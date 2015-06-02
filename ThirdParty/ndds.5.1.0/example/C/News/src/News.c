/****************************************************************************/
/*         (c) Copyright, Real-Time Innovations, All rights reserved.       */
/*                                                                          */
/*         Permission to modify and use for internal purposes granted.      */
/* This software is provided "as is", without warranty, express or implied. */
/*                                                                          */
/****************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <ndds/ndds_c.h>

#include "News.h"
#include "NewsPublisher.h"
#include "NewsSubscriber.h"


/* The News example implements a simple application: a variety of news
 * outlets publish articles at different rates, and subscribers consume the
 * data based on different criteria. It demonstrates several important design
 * patterns.
 */

/****************************************************************************/
/* Local constants & macros                                                 */
/****************************************************************************/

/* Command line defaults */
#define DEFAULT_DOMAIN_ID           0

/* Application running mode */
#define APP_MODE_UNDEFINED          0
#define APP_MODE_PUBLISHER          1
#define APP_MODE_SUBSCRIBER         2

/* This is the name of the topic used for our test */
#define TOPIC_NAME                  "News Example"

/* The maximum value for Domain ID. The effective value depends on the QoS,
 * in particular to the value of the field:
 *              DDS_RtpsWellKnownPorts_t.domainId_gain
 * The default value is 250, so we just limit to that statically so we can
 * check the validity before attempting to create the domain participant.
 */
#define DOMAIN_ID_MAX               250

#define RUN_SECONDS_DEFAULT         20


/****************************************************************************/
/* Structure to hold the parsed command line arguments                      */
/****************************************************************************/

struct CommandLineArguments {
    DDS_Long    domain_id;
    DDS_Long    mode;

    /* The number of seconds for which this application should run. */
    DDS_Long    run_seconds;
    DDS_Long    verbose;        /* 0=no verbose, 1=app verbose, 2=DDS */
    /* If the subscribing application is using a content-based filter to
     * down-sample the incoming data, the filter expression will be stored
     * here.
     */
    const char* content_filter;
};


void initial_arguments(struct CommandLineArguments* args) {
    args->domain_id = DEFAULT_DOMAIN_ID;
    args->mode = APP_MODE_UNDEFINED;
    args->run_seconds = RUN_SECONDS_DEFAULT;
    args->verbose = 0;
    args->content_filter = NULL;
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


/****************************************************************************/
/* start_application                                                        */
/*                                                                          */
/* Creates the DDS Domain Participant, then delegates the execution to the  */
/* correct pub/sub function.                                                */
/*                                                                          */
/* Input:                                                                   */
/*   arg: pointer to the CommandLineArguments structure                     */
/*                                                                          */
/* Returns:                                                                 */
/*   false if an error occurred.                                            */
/*                                                                          */
/****************************************************************************/

static void start_application(const struct CommandLineArguments* arg) {
    DDS_ReturnCode_t rc = DDS_RETCODE_ERROR;
    DDS_Topic *      topic = NULL;
    DDS_Boolean      return_value = DDS_BOOLEAN_FALSE;
    DDS_DomainParticipantFactory* factory = NULL;
    DDS_DomainParticipant*        participant = NULL;

    /* This example creates DDS entities using the default QoS loaded
     * from the file USER_QOS_PROFILES.xml in the current working
     * directory.
     */
    if (!file_exist("USER_QOS_PROFILES.xml")) {
        printf("! Unable to locate QoS definition file\n");
        printf("! (USER_QOS_PROFILES.xml) in current directory.\n");
        return;
    }

    factory = DDS_DomainParticipantFactory_get_instance();
    /* If you need to customize any DDS factory QoS, uncomment the following
     * code: 
     *
    {
        struct DDS_DomainParticipantFactoryQos factory_qos =
            DDS_DomainParticipantFactoryQos_INITIALIZER;
        rc = DDS_DomainParticipantFactory_get_qos(factory, &factory_qos);
        if (rc != DDS_RETCODE_OK) { 
            fprintf(stderr, "! Unable to get participant factory QoS: %d\n",
                    rc);
            goto exitFn;
        }
        
        // Modify the factory QoS here
        
        rc = DDS_DomainParticipantFactory_set_qos(factory, &factory_qos);
        if (rc != DDS_RETCODE_OK) { 
            fprintf(stderr, "! Unable to set participant factory QoS: %d\n",
                    rc);
            goto exitFn;
        }
    }
    */
    
            
    /* Creates the DDS Domain Participant.
     * If you want to create a domain participant with different QoS,
     * use DDS_DomainParticipantFactory_get_default_participant_qos
     * to obtain a copy of the default participant QoS, change them,
     * then use them instead of DDS_PARTICIPANT_QOS_DEFAULT:
     *
    {
        struct DDS_DomainParticipantQos participant_qos =
            DDS_DomainParticipantQos_INITIALIZER;
        rc = DDS_DomainParticipantFactory_get_default_participant_qos(
             factory, &participant_qos);
        if (rc != DDS_RETCODE_OK) { 
            fprintf(stderr, "! Unable to get default participant QoS: %d\n",
                    rc);
            goto exitFn;
        }
        // Modify the participant QoS here
        // Then create the domain participant using 'participant_qos'...
    }
     */
    if (arg->verbose) {
        printf("Creating DomainParticipant...\n");
    }
    participant = DDS_DomainParticipantFactory_create_participant(
         factory,
         arg->domain_id,
         &DDS_PARTICIPANT_QOS_DEFAULT,
         NULL,                    /* no listener */
         DDS_STATUS_MASK_NONE);   /* no listener callbacks */
    if (participant == NULL) {
        fprintf(stderr, "! Unable to create DomainParticipant\n");
        goto exitFn;
    }

    /* Creates the topic.
     * If you want to create a topic with different QoS,
     * use DDS_DomainParticipant_get_default_topic_qos
     * to obtain a copy of the default topic QoS, change them,
     * then use them instead of DDS_TOPIC_QOS_DEFAULT:
     *
    {
        struct DDS_TopicQos topic_qos = DDS_TopicQos_INITIALIZER;
        rc = DDS_DomainParticipant_get_default_topic_qos(
            participant, &topic_qos);
        if (rc != DDS_RETCODE_OK) { 
            fprintf(stderr, "! Unable to get default participant QoS: %d\n",
                    rc);
            goto exitFn;
        }
        
        // Modify the topic QoS here
        // Then create the topic using 'topic_qos'...        
    }
     */
    if (arg->verbose) {
        printf("Creating the topic...\n");
    }
    topic = DDS_DomainParticipant_create_topic(
        participant,
        TOPIC_NAME,
        DDS_KeyedStringTypeSupport_get_type_name(), 
        &DDS_TOPIC_QOS_DEFAULT,
        NULL,                    /* no listener */
        DDS_STATUS_MASK_NONE);   /* no listener callbacks */
    if (topic == NULL) {
        fprintf(stderr, "! Unable to create topic.\n");
        goto exitFn;
    }

    /* Creates the publisher or subscriber */
    if (arg->mode == APP_MODE_PUBLISHER) {
        return_value = publish(
            participant, topic, arg->verbose, arg->run_seconds);
    } else {
        return_value = read_articles(
            participant,
            topic,
            arg->verbose,
            arg->run_seconds,
            arg->content_filter);
    }
    if (!return_value) {
        fprintf(stderr, "! An error occurred.\n");
    }
    
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
            fprintf(
                stderr,
                "! Unable to delete participant contained entities: %d\n",
                rc);
        }

        rc = DDS_DomainParticipantFactory_delete_participant(
            factory, participant);
        if (rc != DDS_RETCODE_OK) {
            fprintf(stderr, "! Unable to delete participant: %d\n", rc);
        }
    }
    DDS_DomainParticipantFactory_finalize_instance();
}




/****************************************************************************/
/* usage                                                                    */
/*                                                                          */
/* Prints help on command line accepted by this application                 */
/****************************************************************************/

static void usage() {
    printf("Usage:\n");
    printf("    News pub [arguments]     Run as publisher\n");
    printf("    News sub [arguments]     Run as subscriber\n");
    printf("Where arguments are:\n");
    printf("  -h | --help                   "
           "Shows this page\n");
    printf("  -v | --verbose                "
           "Increase output verbosity (can be repeated)\n");
    printf("  -d | --domain <domainID>      "
           "Sets the DDS domain ID [default=%d]\n", DEFAULT_DOMAIN_ID);
    printf("  -r | --runSeconds <integer>   "
           "Sets the number of seconds to run [default=20]\n");
    printf("  -f | --filterExpression <SQL> "
           "Sets a content filter on the data\n");
    printf("\n");
}


/****************************************************************************/
/* ENSURE_ONE_MORE_ARGUMENT                                                 */
/*                                                                          */
/* A simple macro used to check if there are enough command line args       */
/****************************************************************************/
#define ENSURE_ONE_MORE_ARGUMENT(argc, argv, i, argName)                     \
    if (i+1 >= argc) {                                                        \
        usage();                                                             \
        fprintf(stderr, "! Error: missing value for %s argument\n",          \
                argName);                                                    \
        return EXIT_FAILURE;                                                 \
    }


/****************************************************************************/
/* main                                                                     */
/*                                                                          */
/* Application main entry point                                             */
/****************************************************************************/
int main(int argc, const char **argv) {
    struct CommandLineArguments arg;
    int i = 0;

    printf("RTI News Example\n");
    printf("Copyright 2009 Real-Time Innovations, Inc.\n\n");

    /* Ensure there are enough arguments in the command line */
    initial_arguments(&arg);
    if (argc < 2) {
        usage();
        fprintf(stderr, "! Invalid number of arguments.\n");
        fprintf(
            stderr, "! You must specify at least running mode (pub/sub)\n");
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
        fprintf(stderr, "! Invalid mode: '%s'\n", argv[1]);
        fprintf(stderr, "! Valid modes are only 'pub' or 'sub'\n");
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
            char *ptr = NULL;
            ENSURE_ONE_MORE_ARGUMENT(argc, argv, i, "--domain")
            arg.domain_id = strtol(argv[++i], &ptr, 10);
            if (*ptr != '\0') {
                usage();
                fprintf(
                    stderr,
                    "! Value of --domain argument is not a number: %s\n", 
                    argv[i]);
                return EXIT_FAILURE;
            }
            if (arg.domain_id < 0 || arg.domain_id > DOMAIN_ID_MAX) {
                usage();
                fprintf(
                    stderr, "! Invalid DDS Domain ID: %d\n", arg.domain_id);
                fprintf(
                    stderr,
                    "! The domain ID must be between 0 and %d (inclusive)\n",
                    DOMAIN_ID_MAX);
                return EXIT_FAILURE;
            }
            continue;
        }

        if (!RTI_STRNCMP(argv[i], "-r", 2) ||
            !RTI_STRNCMP(argv[i], "--runSeconds", 12)) {
            char *ptr;
            ENSURE_ONE_MORE_ARGUMENT(argc, argv, i, "--runSeconds")
            arg.run_seconds = strtol(argv[++i], &ptr, 10);
            if (*ptr != '\0') {
                usage();
                fprintf(
                    stderr,
                    "! Invalid value for --runSeconds option: %s\n",
                    argv[i]);
                return EXIT_FAILURE;
            }
            if (arg.run_seconds <= 0) {
                usage();
                fprintf(
                    stderr,
                    "! Invalid value for --runSeconds argument: %d\n",
                    arg.run_seconds);
                return EXIT_FAILURE;
            }
            continue;
        }

        if (!RTI_STRNCMP(argv[i], "-f", 2) || 
            !RTI_STRNCMP(argv[i], "--filterExpression", 18)) {
            ENSURE_ONE_MORE_ARGUMENT(argc, argv, i, "--filterExpression")
            arg.content_filter = argv[++i];
            continue;
        }
        
        usage();
        fprintf(stderr, "! Unknown argument %s\n", argv[i]);
        return EXIT_FAILURE;
    } /* foreach argument */

    if (arg.verbose) {
        const struct DDS_ProductVersion_t* prod_version = 
            NDDS_Config_Version_get_product_version();
        printf("Running with the following arguments:\n");
        printf("    Verbosity level.. : %d\n", arg.verbose);
        printf("    Domain ID........ : %d\n", arg.domain_id);
        printf("    Seconds to run... : %d\n", arg.run_seconds);
        printf("    Content filter... : %s\n", arg.content_filter);
        printf("RTI Product Version.. : %d.%d%c (rev %d)\n",
                        prod_version->major,
                        prod_version->minor,
                        prod_version->release,
                        prod_version->revision);
    }

    /* If the verbosity is greater than 1, also turn on RTI status logging. */
    if (arg.verbose > 1) {
        NDDS_Config_Logger_set_verbosity_by_category(
            NDDS_Config_Logger_get_instance(),
            NDDS_CONFIG_LOG_CATEGORY_API,
            NDDS_CONFIG_LOG_VERBOSITY_STATUS_ALL);
    }

    /* Finally, starts the application */
    start_application(&arg);

    /* start_application terminates if sampleCount is set */
    printf("Done.\n");
    return EXIT_SUCCESS;
}


/****************************************************************************/
/* Article Class                                                            */
/****************************************************************************/

void format_article(char* output,
                    size_t output_size,
                    const char* news_outlet_name,
                    const char* article_text) {
    /* For formatting purposes, make sure all of the news outlet
     * names are padded to the same width.
     */
    RTI_SNPRINTF(output, output_size, "From %-10s: \"%s\"",
                 news_outlet_name, article_text);
}
