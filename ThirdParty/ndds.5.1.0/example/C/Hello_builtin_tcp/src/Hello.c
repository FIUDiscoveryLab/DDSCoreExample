/*****************************************************************************/
/*         (c) Copyright, Real-Time Innovations, All rights reserved.        */
/*                                                                           */
/*         Permission to modify and use for internal purposes granted.       */
/* This software is provided "as is", without warranty, express or implied.  */
/*                                                                           */
/*****************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Hello.h"
#include <ndds/ndds_c.h>
#include "HelloPublisher.h"
#include "HelloSubscriber.h"

#include "ndds/transport_tcp/transport_tcp_tcpv4.h"

/*****************************************************************************/
/* Local constants & macros                                                  */
/*****************************************************************************/

/* Command line defaults */
#define DEFAULT_DOMAIN_ID           0
#define APPLICATION_NAME            "Hello"
#define DEFAULT_PAYLOAD             1023
#define MAX_PAYLOAD                 1023
#define MIN_PAYLOAD                 10

/* Application running mode */
#define APP_MODE_UNDEFINED          0
#define APP_MODE_PUBLISHER          1
#define APP_MODE_SUBSCRIBER         2

/* The following constants are exit codes (defined for C++, but not for C) */
#ifndef EXIT_SUCCESS
#define EXIT_SUCCESS              0
#define EXIT_FAILURE              1
#endif

/* This is the name of the topic used for our test */
#define DEFAULT_TOPIC_NAME          "Hello Builtin"

/* The maximum value for Domain ID. The effective value depends on the QoS,
 * in particular to the value of the field:
 *              DDS_RtpsWellKnownPorts_t.domain_id_gain
 * The default value is 250, so we just limit to that statically so we can
 * check the validity before attempting to create the domain participant.
 */
#define DOMAIN_ID_MAX               250


/*****************************************************************************/
/* Structure to hold the parsed command line arguments                       */
/*****************************************************************************/
typedef struct CommandLineArguments_t {
    DDS_Long        domain_id;
    DDS_Long        mode;
    DDS_Long        data_size;
    DDS_Long        verbose;        /* 0=no verbose, 1=app verbose, 2=DDS */
    const char *    topic_name;
    DDS_Long        sample_count;

    /* TCP Specific */
    const char *    addr;           /* Public address */
    DDS_Long        port;           /* Server bind port */
    DDS_Boolean     async_send;     /* Use asynchronous send */
    char *          tls_ca_cert;    /* Certificat of Authority */
    char *          tls_cert_chain; /* Cert. chain for TLS */
} CommandLineArguments;



/*****************************************************************************/
/* CommandLineArguments_initialize                                           */
/*                                                                           */
/* Initialize the command line argument structure with the default values    */
/*****************************************************************************/
static void CommandLineArguments_initialize(
                        CommandLineArguments *arg) {
    arg->mode           = APP_MODE_UNDEFINED;
    arg->domain_id      = DEFAULT_DOMAIN_ID;
    arg->data_size      = DEFAULT_PAYLOAD;
    arg->verbose        = 0;
    arg->topic_name     = DEFAULT_TOPIC_NAME;
    arg->sample_count   = 0;

    /* TCP Options */
    arg->addr           = NULL;
    arg->port           = 0;    /* Unreachable node by default */
    arg->async_send     = DDS_BOOLEAN_FALSE;
    arg->tls_ca_cert    = NULL;
    arg->tls_cert_chain = NULL;
}



/*****************************************************************************/
/* file_exist                                                                */
/*                                                                           */
/* Just a convenience function that checks if a file exist and can be read   */
/*****************************************************************************/
static DDS_Boolean file_exist(const char *fileName) {
    FILE *fp;
#if defined(RTI_WIN32) && (_MSC_VER > 1310) 
    fopen_s(&fp, "USER_QOS_PROFILES.xml", "r");
#else 
    fp = fopen("USER_QOS_PROFILES.xml", "r");
#endif
    if (fp != NULL) {
        fclose(fp);
        return DDS_BOOLEAN_TRUE;
    }
    return DDS_BOOLEAN_FALSE;
}


/*****************************************************************************/
/* start_application                                                         */
/*                                                                           */
/* Creates the DDS Domain Participant, then delegates the execution to the   */
/* correct pub/sub function.                                                 */
/* If entity creation is successful, this function does not return.          */
/*                                                                           */
/* Input:                                                                    */
/*   arg: pointer to the CommandLineArguments structure                      */
/*                                                                           */
/* Returns:                                                                  */
/*   The boolean value DDS_BOOLEAN_TRUE if an error occurred.                */
/*                                                                           */
/*****************************************************************************/
static DDS_Boolean start_application(
                        const CommandLineArguments *arg) {
    DDS_ReturnCode_t                rc;
    DDS_DomainParticipant *         participant = NULL;
    DDS_Topic *                     topic = NULL;
    DDS_Boolean                     return_value = DDS_BOOLEAN_FALSE;
    struct DDS_DomainParticipantQos part_qos = DDS_DomainParticipantQos_INITIALIZER;
    NDDS_Transport_Plugin *tcp_transport = NULL;

    puts("# The output below depends on the QoS profile"); 
    puts("# provided to this application.");
    puts("# -> For more information on the provided example");
    puts("#    profiles, please see the Getting Started Guide.");
    puts("# -> For detailed product performance metrics, visit");
    puts("#    http://www.rti.com/products/data_distribution/index.html");
    puts("#    and click on Benchmarks.\n");

    /* This example creates DDS entities using the default QoS.
     * The default QoS can be modified in two ways:
     * 1. By placing a file called 'USER_QOS_PROFILES.xml' in the directory
     *    where the application is launched.
     * 2. By setting the environment variable 'NDDS_QOS_PROFILES' to point
     *    to a valid file containing NDDS QoS profile definitions.
     *
     * This section check if a QoS profile file is accessible, and prints
     * a warning if that's not true.
     */
     
    /* First look in the current directory to see if the USER_QOS_PROFILES.xml
     * file exist.
     */
    if (!file_exist("USER_QOS_PROFILES.xml")) {
        /* Then look for the env variable 'NDDS_QOS_PROFILES'... 
         */
        char *envVal;
#if defined(RTI_WIN32) && (_MSC_VER > 1310) 
        /* on Windows, getenv is deprecated for newer than VC70 */
        size_t envValSize;
        _dupenv_s(&envVal, &envValSize, "NDDS_QOS_PROFILES"); 
#else 
        envVal = getenv("NDDS_QOS_PROFILES");
#endif
        if (envVal == NULL || !file_exist(envVal)) {
            puts("! Warning:");
            puts("! Default QoS profile definition file not found.");
            puts("! The application will use the DDS default QoS.");
            puts("! If you want to use different QoS, make sure you have the "
                        "QoS definition file");
            puts("! (USER_QOS_PROFILES.xml) in the current working directory");
            puts("! or set the environment variable NDDS_QOS_PROFILES to");
            puts("! point to a file containing the default QoS profile");
        }
#if defined(RTI_WIN32) && (_MSC_VER > 1310) 
        if (envVal) free(envVal); 
#endif
    }

    /* If you need to customize any DDS factory QoS, uncomment the following
     * code:
     *
    {
        struct DDS_DomainParticipantFactoryQos factoryQos =
            DDS_DomainParticipantFactoryQos_INITIALIZER;
        rc = DDS_DomainParticipantFactoryQos_initialize(&factoryQos);
        if (rc != DDS_RETCODE_OK) { 
            fprintf(stderr, "! Unable to initialize participant "
                        "factory QoS: %d\n", rc);
            goto exitFn;
        }
        rc = DDS_DomainParticipantFactory_get_qos(
                        DDS_TheParticipantFactory, 
                        &factoryQos);
        if (rc != DDS_RETCODE_OK) { 
            fprintf(stderr, "! Unable to get participant "
                        "factory QoS: %d\n", rc);
            goto exitFn;
        }
        
        // Modify the factory QoS here
        
        rc = DDS_DomainParticipantFactory_set_qos(
                        DDS_TheParticipantFactory, 
                        &factoryQos);
        if (rc != DDS_RETCODE_OK) { 
            fprintf(stderr, "! Unable to set participant "
                        "factory QoS: %d\n", rc);
            goto exitFn;
        }
        rc = DDS_DomainParticipantFactoryQos_finalize(&factoryQos);            
        if (rc != DDS_RETCODE_OK) { 
            fprintf(stderr, "! Unable to finalize participant "
                        "factory QoS: %d\n", rc);
            goto exitFn;
        }   
    }
    */
    
            
    /* Creates the DDS Domain Participant.
     *
     * Note: for more info on the domain participant API see:
     *     $NDDSHOME/doc/html/api_c/group__DDSDomainParticipantModule.html
     */
    if (arg->verbose) {
        printf("Creating domain participant...\n");
    }

    rc = DDS_DomainParticipantFactory_get_default_participant_qos(
        DDS_TheParticipantFactory, &part_qos);

    if (rc != DDS_RETCODE_OK) {
        fprintf(stderr, "! unable to get default participant qos: %d\n", rc);
        return -1;
    }
    
    /* Disable auto-enabling the domain participant so that we can
     * configure the TCP transport.
     */
    {
        struct DDS_DomainParticipantFactoryQos factory_qos =
            DDS_DomainParticipantFactoryQos_INITIALIZER;
        rc = DDS_DomainParticipantFactory_get_qos(
            DDS_TheParticipantFactory, &factory_qos);
        if (rc != DDS_RETCODE_OK) {
            fprintf(stderr, "! unable to get participant factory qos: %d\n", rc);
            return -1;
        }
        factory_qos.entity_factory.autoenable_created_entities = DDS_BOOLEAN_FALSE;
        rc = DDS_DomainParticipantFactory_set_qos(
            DDS_TheParticipantFactory, &factory_qos);
        if (rc != DDS_RETCODE_OK) {
            fprintf(stderr, "! unable to set participant factory qos: %d\n", rc);
            return -1;
        }
        DDS_DomainParticipantFactoryQos_finalize(&factory_qos);            
    }

    /* Configure the TCP transport */
    {
        struct NDDS_Transport_TCPv4_Property_t tcpProperties =
            NDDS_TRANSPORT_TCPV4_PROPERTY_DEFAULT;

        /* Is TLS specified ? */
        if (arg->tls_ca_cert) {
            tcpProperties.tls.verify.ca_file = arg->tls_ca_cert;
            tcpProperties.tls.identity.certificate_chain_file = arg->tls_cert_chain;
            /* The default class ID now is TLSV4_LAN */
            tcpProperties.parent.classid = NDDS_TRANSPORT_CLASSID_TLSV4_LAN;
        }

        /* Sets the transport mode */
        if (arg->addr != NULL && arg->port != 0) {
            /* transport is reachable, in WAN configuration */
            tcpProperties.parent.classid = arg->tls_ca_cert ? 
                        NDDS_TRANSPORT_CLASSID_TLSV4_WAN : NDDS_TRANSPORT_CLASSID_TCPV4_WAN;
	    if (!NDDS_Transport_TCPv4_Plugin_stringToTransportAddress(
                        &tcpProperties.public_address,
                        arg->addr,
                        RTI_FALSE)) {  /* host names are not accepted */
                fprintf(stderr, "! unable to set TCP property 'public_address'\n");
                return RTI_FALSE;
            }
            tcpProperties.server_bind_port = arg->port;
        } else if (arg->port == 0) {
            tcpProperties.server_bind_port = 0;
            if (arg->addr != NULL) {
                fprintf(stderr, "You specified a public address but the node is unreachable (the server port is not set)\n"
                                "The server public address parameter will be ignored.\n");
            }
            /* Asymmetric mode is only WAN */
            tcpProperties.parent.classid = arg->tls_ca_cert ? 
                        NDDS_TRANSPORT_CLASSID_TLSV4_WAN : NDDS_TRANSPORT_CLASSID_TCPV4_WAN;
        } else {
            /* arg->addr == NULL && arg->port != 0 
             * This is for LAN mode */
            tcpProperties.server_bind_port = arg->port;
        }


        tcpProperties.force_asynchronous_send = (arg->async_send) ? 1 : 0;
        if (arg->verbose > 0) {
            /* Enable debugging logging */
            tcpProperties.logging_verbosity_bitmap = 255;
        }

        /* Create the TCP transport plugin */
        tcp_transport = NDDS_Transport_TCPv4_new(&tcpProperties);
        if (tcp_transport == NULL) {
            fprintf(stderr, "! unable to create TCP transport plugin\n");
            return RTI_FALSE;
        }

        /* Disable all the other transports */
        part_qos.transport_builtin.mask = DDS_TRANSPORTBUILTIN_MASK_NONE;
    }

    participant = DDS_DomainParticipantFactory_create_participant(
                    DDS_TheParticipantFactory,
                    arg->domain_id,
                    &part_qos,
                    NULL,   /* Listener */
                    DDS_STATUS_MASK_NONE);
    if (participant == NULL) {
        fprintf(stderr, "! Unable to create DDS domain participant\n");
        goto exitFn;
    }

    /* Register the TCP transport plugin */
    {
        /* The names by which this transport plugin will be known, use
           the name of the builtin transport...
        */
        const char* ALIASES[] = { "tcp1" };
        struct DDS_StringSeq aliases = DDS_SEQUENCE_INITIALIZER;
        NDDS_Transport_Address_t defaultNetworkAddress = RTI_NETIO_ADDRESS_INVALID;        
        NDDS_Transport_Handle_t handle = NDDS_TRANSPORT_HANDLE_NIL;

        /* Initialize the aliases StringSeq */
        if (!DDS_StringSeq_from_array(&aliases, ALIASES, 1)) {
            fprintf(stderr, "! unable to create transport alias string sequence\n");
            goto exitFn;
        }

        handle = NDDS_Transport_Support_register_transport(
            participant,                  /* Disabled Domain Participant */
            tcp_transport,                /* Transport plugin */
            &aliases,                     /* Transport aliases */
            &defaultNetworkAddress);      /* Transport network address */

        if (NDDS_Transport_Handle_is_nil(&handle)) {
            fprintf(stderr, "! unable to register TCP transport\n");
            goto exitFn;
        }

        DDS_StringSeq_finalize(&aliases);
    }


    /* Enable the DDS Domain Participant */
    rc = DDS_Entity_enable(DDS_DomainParticipant_as_entity(participant));
    if (rc != DDS_RETCODE_OK) {
        fprintf(stderr, "! unable to enable domain participant: %d\n", rc);
        return -1;
    }


    /* Creates the topic.
     * The following command will create the topic without
     * installing any status callback listener.
     * If you want to create a topic with different QoS,
     * use DDS_DomainParticipant_get_default_topic_qos
     * to obtain a copy of the default topic QoS, change them,
     * then use them instead of DDS_TOPIC_QOS_DEFAULT:
     *
        struct DDS_TopicQos myQos = DDS_TopicQos_INITIALIZER;
        DDS_DomainParticipant_get_default_topic_qos(participant, &myQos);
        
        // Modify the topic QoS here

        // Then create the topic using 'myQos'...
        
        // Don't forget to finalize the topic QoS before terminating:
        DDS_TopicQos_finalize(&myQos);      
     *
     * Note: for more info on the topic API see:
     *     $NDDSHOME/doc/html/api_c/group__DDSTopicEntityModule.html
     */
    if (arg->verbose) {
        printf("Creating the topic...\n");
    }
    topic = DDS_DomainParticipant_create_topic(
                        participant, 
                        arg->topic_name,
                        DDS_StringTypeSupport_get_type_name(), 
                        &DDS_TOPIC_QOS_DEFAULT,
                        NULL,           /* listener */
                        DDS_STATUS_MASK_NONE);
    if (topic == NULL) {
        fprintf(stderr, "! Unable to create topic '%s'\n", 
                        arg->topic_name);
        goto exitFn;
    }

    /* Creates the publisher or subscriber */
    if (arg->mode == APP_MODE_PUBLISHER) {
        /* If TCP transport is selected, give an extra couple of seconds before start publishing data
         * to allow the TCP control protocol to establish a data communication with the other
         * peer
         */
        struct DDS_Duration_t delay = { 2, 0 };  /* 2 seconds */
        NDDS_Utility_sleep(&delay);
        if (!start_publisher(
                        participant, 
                        topic,
                        arg->verbose,
                        arg->data_size,
                        arg->sample_count)) {
            goto exitFn;
        }
    } else {
        if (!start_subscriber(
                        participant, 
                        topic,
                        arg->verbose,
                        arg->sample_count)) {
            goto exitFn;
        }
    }
    return_value = DDS_BOOLEAN_TRUE;
    
exitFn:
    if (arg->verbose) {
        printf("Cleaning up...\n");
    }
    if (participant != NULL) {
        /* Perform a clean shutdown of the participant and all the contained
         * entities
         */
        rc = DDS_DomainParticipant_delete_contained_entities(participant);
        if (rc != DDS_RETCODE_OK) {
            fprintf(stderr, "! Unable to delete participant contained "
                        "entities: %d\n", rc);
        }

        rc = DDS_DomainParticipantFactory_delete_participant(
                        DDS_TheParticipantFactory, 
                        participant);
        if (rc != DDS_RETCODE_OK) {
            fprintf(stderr, "! Unable to delete participant: %d\n", rc);
        }

        DDS_DomainParticipantQos_finalize(&part_qos);
    }
    return return_value;
}




/*****************************************************************************/
/* usage                                                                     */
/*                                                                           */
/* Prints help on command line accepted by this application                  */
/*****************************************************************************/
static void usage() {
    printf("Usage:\n");
    printf("    %s pub [arguments]     Run as publisher\n", APPLICATION_NAME);
    printf("    %s sub [arguments]     Run as subscriber\n", APPLICATION_NAME);
    printf("Where arguments are:\n");
    printf("  -h | --help                 "
           "Shows this page\n");
    printf("  -v | --verbose              "
           "Increase output verbosity (can be repeated)\n");
    printf("  -d | --domain <domainID>    "
           "Sets the DDS domain ID [default=%d]\n", DEFAULT_DOMAIN_ID);
    printf("  -t | --topic <name>         "
           "Sets topic name [default=%s]\n", DEFAULT_TOPIC_NAME);
    printf("  -s | --size <num>           "
           "Sets payload size in bytes [default=%d]\n", DEFAULT_PAYLOAD);
    printf("  -c | --sampleCount <num>    "
           "Sets number of samples to send/receive [default=0(UNLIMITED)]\n");
    printf("TCP-transport only:\n");
    printf("  --async                     "
           "Use asynchronous send [default=use synchronous send]\n");
    printf("  -a | --address <ip:port>    "
           "Enable WAN mode and sets the public IP and port for the TCP transport\n");
    printf("  -p | --port <port>          "
           "Sets the server binding port and define this node as reachable (Symmetric mode)\n");
    printf("  --tls-cert <ca_cert>        "
           "Sets certificate of authority used in TLS configuration\n");
    printf("  --tls-chain <cert_chain>    "
           "Sets certificate chain file used in TLS configuration\n");
    printf("\nConfiguration notes:\n");
    printf("- If the public IP and port is not set, the transport will work in LAN\n"
           "  configuration mode, where all the local IP address(es) will be used \n"
           "  for the communication (using server binding port).\n"
           "- If the server bind port (--port argument) is not provided, the node\n"
           "  is considered as unreachable and can only communicate with peers that\n"
           "  are reachable.\n");
    printf("\n");
}


/*****************************************************************************/
/* ENSURE_ONE_MORE_ARGUMENT                                                  */
/*                                                                           */
/* A simple macro used to check if there are enough command line args        */
/*****************************************************************************/
#define ENSURE_ONE_MORE_ARGUMENT(argc, argv, i, arg_name)                     \
    if (i+1 >= argc) {                                                         \
        usage();                                                              \
        fprintf(stderr, "! Error: missing value for %s argument\n",           \
                        arg_name);                                            \
        return EXIT_FAILURE;                                                  \
    }


/*****************************************************************************/
/* main                                                                      */
/*                                                                           */
/* Application main entry point                                              */
/*****************************************************************************/
int main(int argc, char **argv) {
    CommandLineArguments arg;    
    int        i;

    /* Initialize command-line structure with default values */
    CommandLineArguments_initialize(&arg);

    printf("Hello Example Application for TCP transport\n");
    printf("Copyright 2008 Real-Time Innovations, Inc.\n\n");

    /* Ensure there are enough arguments in the command line */
    if (argc < 2) {
        usage();
        fprintf(stderr, "! Invalid number of arguments.\n"
               "! You must specify at least running mode (pub/sub)\n");
        return EXIT_FAILURE;
    }

    /* Parse the running mode: pub/sub */    
    if (RTI_STRCASECMP(argv[1], "pub") == 0) {
        arg.mode = APP_MODE_PUBLISHER;
    } else if (RTI_STRCASECMP(argv[1], "sub") == 0) {
        arg.mode = APP_MODE_SUBSCRIBER;
    } else if (!RTI_STRNCMP(argv[1], "-h", 2) || 
               !RTI_STRNCMP(argv[1], "--help", 6)) {
        usage();
        return EXIT_SUCCESS;
    } else {
        usage();
        fprintf(stderr, "! Invalid mode: '%s'\n"
               "! Valid modes are only 'pub' or 'sub'.\n", argv[1]);
        return EXIT_FAILURE;
    }

    /* Parse the optional arguments */
    for (i = 2; i < argc; ++i) {
        if (!RTI_STRNCMP(argv[i], "-h", 2) || 
            !RTI_STRNCMP(argv[i], "--help", 6)) {
            usage();
            return EXIT_SUCCESS;
        }
        
        if (!RTI_STRNCMP(argv[i], "-v", 2) || 
            !RTI_STRNCMP(argv[i], "--verbose", 9)) {
            ++arg.verbose;
            continue;
        }

        if (!RTI_STRNCMP(argv[i], "-d", 2) || 
            !RTI_STRNCMP(argv[i], "--domain", 8)) {
            char *ptr;
            ENSURE_ONE_MORE_ARGUMENT(argc, argv, i, "--domain")
            arg.domain_id = strtol(argv[++i], &ptr, 10);
            if (*ptr != '\0') {
                usage();
                fprintf(stderr, "! Value of --domain argument is not "
                        "a number: %s\n", argv[i]);
                return EXIT_FAILURE;
            }
            if (arg.domain_id < 0 || arg.domain_id > DOMAIN_ID_MAX) {
                usage();
                fprintf(stderr, "! Invalid DDS Domain ID: %d\n", 
                        arg.domain_id);
                fprintf(stderr, "! The domain ID must be between "
                        "0 and %d (inclusive)\n", DOMAIN_ID_MAX);
                return EXIT_FAILURE;
            }
            continue;
        }

        if (!RTI_STRNCMP(argv[i], "-s", 2) || 
            !RTI_STRNCMP(argv[i], "--size", 6)) {
            char *ptr;
            ENSURE_ONE_MORE_ARGUMENT(argc, argv, i, "--size")
            arg.data_size = strtol(argv[++i], &ptr, 10);
            if (*ptr != '\0') {
                usage();
                fprintf(stderr, "! Invalid value for --size option: %s\n", 
                        argv[i]);
                return EXIT_FAILURE;
            }
            if (arg.data_size <= 0) {
                usage();
                fprintf(stderr, "! Invalid value for --size argument: %d\n",
                        arg.data_size);
                return EXIT_FAILURE;
            }
            if (arg.data_size > MAX_PAYLOAD) {
                usage();
                fprintf(stderr, "! Value too big for --size "
                        "argument: %d\n", arg.data_size);
                fprintf(stderr, "! For built-in types, the default max " 
                        "string size is set to %d\n", MAX_PAYLOAD);
                fprintf(stderr, "! See manual on built-in types for "
                        "more information.\n");
                return EXIT_FAILURE;
            }
            if (arg.data_size < MIN_PAYLOAD) {
                usage();
                fprintf(stderr, "! Value too small for --size "
                        "argument: %d\n", arg.data_size);
                fprintf(stderr, "! For this example, the size of the string " 
                        "cannot be smaller than %d\n", MIN_PAYLOAD);
                return EXIT_FAILURE;
            }
            continue;
        }

        if (!RTI_STRNCMP(argv[i], "-t", 2) || 
            !RTI_STRNCMP(argv[i], "--topic", 7)) {
            ENSURE_ONE_MORE_ARGUMENT(argc, argv, i, "--topic")
            arg.topic_name = argv[++i];
            continue;
        }

        if (!RTI_STRNCMP(argv[i], "--tls-cert", 10)) {
            ENSURE_ONE_MORE_ARGUMENT(argc, argv, i, "--tls-cert")
            arg.tls_ca_cert = argv[++i];
            continue;
        }
        if (!RTI_STRNCMP(argv[i], "--tls_chain", 10)) {
            ENSURE_ONE_MORE_ARGUMENT(argc, argv, i, "--tls_chain")
            arg.tls_cert_chain = argv[++i];
            continue;
        }

        if (!RTI_STRNCMP(argv[i], "-c", 2) || 
            !RTI_STRNCMP(argv[i], "--sampleCount", 13)) {
            char *ptr;
            ENSURE_ONE_MORE_ARGUMENT(argc, argv, i, "--sampleCount")
            arg.sample_count = strtol(argv[++i], &ptr, 10);
            if (*ptr != '\0') {
                usage();
                fprintf(stderr, "! Invalid value for --sampleCount option: %s\n", 
                        argv[i]);
                return EXIT_FAILURE;
            }
            if (arg.sample_count < 0) {
                usage();
                fprintf(stderr, "! Invalid value for --sampleCount argument: %d\n",
                        arg.data_size);
                return EXIT_FAILURE;
            }
            continue;
        }

        if (!RTI_STRNCMP(argv[i], "-a", 2) || 
            !RTI_STRNCMP(argv[i], "--address", 9)) {
            ENSURE_ONE_MORE_ARGUMENT(argc, argv, i, "--address")
            arg.addr = argv[++i];
            continue;
        }

        if (!RTI_STRNCMP(argv[i], "--tls-cert", 10)) {
            ENSURE_ONE_MORE_ARGUMENT(argc, argv, i, "--tls-cert")
            arg.tls_ca_cert = argv[++i];
            continue;
        }

        if (!RTI_STRNCMP(argv[i], "--tls-chain", 11)) {
            ENSURE_ONE_MORE_ARGUMENT(argc, argv, i, "--tls-chain")
            arg.tls_cert_chain = argv[++i];
            continue;
        }

        if (!RTI_STRNCMP(argv[i], "-p", 2) || 
            !RTI_STRNCMP(argv[i], "--port", 6)) {
            char *ptr;
            ENSURE_ONE_MORE_ARGUMENT(argc, argv, i, "--port")
            arg.port = strtol(argv[++i], &ptr, 10);
            if (*ptr != '\0') {
                usage();
                fprintf(stderr, "! Value of --port argument is not "
                        "a number: %s\n", argv[i]);
                return EXIT_FAILURE;
            }
            if (arg.port < 0 || arg.port > 65535) {
                usage();
                fprintf(stderr, "! Invalid server port number: %d\n", 
                        arg.port);
                return EXIT_FAILURE;
            }
            continue;
        }

        if (!RTI_STRNCMP(argv[i], "--async", 7)) {
            arg.async_send = RTI_TRUE;
            continue;
        }

        usage();
        fprintf(stderr, "! Unknown argument %s\n", argv[i]);
        return EXIT_FAILURE;
    } /* foreach argument */

    /* Validate the TLS settings */
    if ((arg.tls_ca_cert && !arg.tls_cert_chain) ||
        (!arg.tls_ca_cert && arg.tls_cert_chain)) {
        fprintf(stderr, "! to enable TLS you must specify both --tls-cert and "
                "--tls-chain arguments\n");
        return EXIT_FAILURE;
    }

    if (arg.verbose) {
        const struct DDS_ProductVersion_t *prodVersion = 
                        NDDS_Config_Version_get_product_version();
        printf("Running with the following arguments:\n");
        printf("    Verbosity level.. : %d\n", (int) arg.verbose);
        printf("    Payload size..... : %d\n", (int) arg.data_size);
        printf("    Sample count..... : %d\n", (int) arg.sample_count);
        printf("    Domain ID........ : %d\n", (int) arg.domain_id);
        printf("    Topic name....... : %s\n", arg.topic_name);
        printf("RTI Product Version.. : %d.%d%c (rev %d)\n",
                        prodVersion->major,
                        prodVersion->minor,
                        prodVersion->release,
                        prodVersion->revision);
        printf("TCP Settings:\n");
        printf("    Public address... : %s\n",
                    (arg.addr == NULL ? "not set (use LAN mode)" : arg.addr));
        if (arg.port) {
            printf("    Server bind port. : %d\n", arg.port);
        } else {
            printf("    Server bind port. : not set (node is unreachable)\n");
        }
        printf("    Use async send... : %s\n", (arg.async_send ? "YES" : "NO"));
        if (arg.tls_ca_cert) {
            printf("    Use TLS ......... : YES\n");
            printf("    TLS CA Cert ..... : %s\n", arg.tls_ca_cert);
            printf("    TLS Cert Chain .. : %s\n", arg.tls_cert_chain);
        } else {
            printf("    Use TLS ......... : NO\n");
        }

        /* Alternatively, you can print all the components of the 
         * NDDS_Config_Version object with a single call to:
         *       NDDS_Config_Version_to_string()
         */
    }

    /* If the verbosity is bigger than 1, also turn on RTI DDS status logging
     * For more info, see: 
     *            $NDDSHOME/doc/html/api_c/group__NDDSConfigModule.html
     */
    if (arg.verbose > 1) {
        NDDS_Config_Logger_set_verbosity_by_category(
                        NDDS_Config_Logger_get_instance(),
                        NDDS_CONFIG_LOG_CATEGORY_API,
                        NDDS_CONFIG_LOG_VERBOSITY_STATUS_ALL);
    }

    /* Finally, starts the application */
    start_application(&arg);

    /* start_application terminates if sample_count is set ... */
    printf("Done.\n");
    return EXIT_SUCCESS;
}
