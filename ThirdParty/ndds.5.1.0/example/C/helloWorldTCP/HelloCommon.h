/* Common code between pub & sub */

#include "ndds/osapi/osapi_utility.h"

#ifdef RTI_WIN32
#define RTI_SNPRINTF        _snprintf
#define RTI_STRCASECMP      _stricmp
#define RTI_STRNCASECMP     _strnicmp
#define RTI_STRTOULL        _strtoui64
#define RTI_STRTOUL         strtoul
#define RTI_STRNCMP         strncmp
#else
#define RTI_SNPRINTF        snprintf
#define RTI_STRCASECMP      strcasecmp
#define RTI_STRNCASECMP     strncasecmp
#define RTI_STRTOULL        strtoull
#define RTI_STRTOUL         strtoul
#define RTI_STRNCMP         strncmp
#endif



#define TRANSPORT_LIB_NAME        "nddstransporttcp"
#define TRANSPORT_LIB_NAME_DBG    "nddstransporttcpd"

#define DEFAULT_SERVER_PORT         7400

struct CmdLineArgs {
    int domain_id;
    int sample_count;
    const char * addr;
    int port;
    int verbose;
    RTIBool asyncSend;
    RTIBool debug;
    RTIBool tls;
    const char *tlsCert;
    const char *tlsChain;
};

static void usage(const char *appName) {
    printf("Usage: appName [arguments]\n");
    printf("Where arguments are:\n");
    printf("  -h | --help                "
           "Shows this page\n");
    printf("  -v | --verbose             "
           "Increase output verbosity\n");
    printf("  -s | --sampleCount <num>   "
           "Sets number of loops to perform [default=unlimited]\n");
    printf("  -d | --domain <domainID>   "
           "Sets the DDS domain ID [default=0]\n");
    printf("  --debug                    "
           "Use the debug version of the plugin\n");
    printf("  --async                    "
           "Use asynchronous send [default=use synchronous send]\n");
    printf("  -a | --address <ip:port>   "
           "Sets the public IP and port for the TCP transport\n");
    printf("  -p | --port <port>         "
           "Enable server socket bound at specific port (default=disabled)\n");
    printf("  --tls-cert <ca_cert>       "
           "Sets certificate of authority used in TLS configuration\n");
    printf("  --tls-chain <cert_chain>   "
           "Sets certificate chain file used in TLS configuration\n");
    printf("\n");
    printf("Notes:\n"
           "- If the public IP and port is not set, the transport will work in LAN mode,\n"
           "  where all the local IP address(es) will be used for the communication.\n"
           "- If the --port argument is not provided, the node will be unreachable and\n"
           "  will be able to communicate ONLY with reachable (server) peers\n"
           "- To use TLS configuration, you need to specify at least BOTH\n"
           "  --tls-cert and --tls-chain arguments\n");

}

#define ENSURE_ONE_MORE_ARGUMENT(argc, argv, i, arg_name)                     \
    if (i+1 >= argc) {                                                        \
        usage(appName);                                                       \
        fprintf(stderr, "! Error: missing value for %s argument\n",           \
                        arg_name);                                            \
        return EXIT_FAILURE;                                                  \
    }


/* Returns RTI_FALSE if failure, RTI_TRUE if success */
static RTIBool parseCmdline(struct CmdLineArgs *argOut, int argc, const char **argv) {
    int i;
    const char * const appName = argv[0];

    argOut->domain_id = 0;
    argOut->sample_count = 0;
    argOut->port = 0;
    argOut->addr = NULL;
    argOut->verbose = 0;
    argOut->asyncSend = RTI_FALSE;
    argOut->debug = RTI_FALSE;
    argOut->tls = RTI_FALSE;
    argOut->tlsCert = NULL;
    argOut->tlsChain = NULL;

    for (i = 1; i < argc; ++i) {
        if (!RTI_STRNCMP(argv[i], "-h", 2) || 
            !RTI_STRNCMP(argv[i], "--help", 6)) {
            usage(appName);
            return RTI_FALSE;
        }
        
        if (!RTI_STRNCMP(argv[i], "-v", 2) || 
            !RTI_STRNCMP(argv[i], "--verbose", 9)) {
            ++argOut->verbose;
            continue;
        }

        if (!RTI_STRNCMP(argv[i], "--async", 7)) {
            argOut->asyncSend = RTI_TRUE;
            continue;
        }

        if (!RTI_STRNCMP(argv[i], "--debug", 7)) {
            argOut->debug = RTI_TRUE;
            continue;
        }

        if (!RTI_STRNCMP(argv[i], "-d", 2) || 
            !RTI_STRNCMP(argv[i], "--domain", 8)) {
            char *ptr;
            ENSURE_ONE_MORE_ARGUMENT(argc, argv, i, "--domain")
            argOut->domain_id = strtol(argv[++i], &ptr, 10);
            if (*ptr != '\0') {
                usage(appName);
                printf("! Value of --domain argument is not "
                        "a number: %s\n", argv[i]);
                return RTI_FALSE;
            }
            continue;
        }

        if (!RTI_STRNCMP(argv[i], "-s", 2) || 
            !RTI_STRNCMP(argv[i], "--sampleCount", 13)) {
            char *ptr;
            ENSURE_ONE_MORE_ARGUMENT(argc, argv, i, "--sampleCount")
            argOut->sample_count = strtol(argv[++i], &ptr, 10);
            if (*ptr != '\0') {
                usage(appName);
                printf("! Value of --sampleCount argument is not "
                        "a number: %s\n", argv[i]);
                return RTI_FALSE;
            }
            continue;
        }

        if (!RTI_STRNCMP(argv[i], "-a", 2) || 
            !RTI_STRNCMP(argv[i], "--address", 9)) {
            ENSURE_ONE_MORE_ARGUMENT(argc, argv, i, "--address")
            argOut->addr = argv[++i];
            continue;
        }

        if (!RTI_STRNCMP(argv[i], "-p", 2) || 
            !RTI_STRNCMP(argv[i], "--port", 6)) {
            char *ptr;
            ENSURE_ONE_MORE_ARGUMENT(argc, argv, i, "--port")
            argOut->port = strtol(argv[++i], &ptr, 10);
            if (*ptr != '\0') {
                usage(appName);
                printf("! Value of --port argument is not "
                        "a number: %s\n", argv[i]);
                return RTI_FALSE;
            }
            if (argOut->port < 0 || argOut->port > 65535) {
                usage(appName);
                printf("! Invalid server port number: %d\n", 
                        argOut->port);
                return RTI_FALSE;
            }
            continue;
        }

        if (!RTI_STRNCMP(argv[i], "--tls-cert", 10)) {
            ENSURE_ONE_MORE_ARGUMENT(argc, argv, i, "--tls-cert")
            argOut->tls = RTI_TRUE;
            argOut->tlsCert = argv[++i];
            continue;
        }

        if (!RTI_STRNCMP(argv[i], "--tls-chain", 11)) {
            ENSURE_ONE_MORE_ARGUMENT(argc, argv, i, "--tls-chain")
            argOut->tls = RTI_TRUE;
            argOut->tlsChain = argv[++i];
            continue;
        }

        usage(appName);
        printf("! Unknown argument %s\n", argv[i]);
        return RTI_FALSE;
    } /* foreach argument */

    printf("Running with the following arguments:\n");
    printf("    Domain ID........ : %d\n", argOut->domain_id);
    printf("    Sample count..... : %d\n", argOut->sample_count);
    printf("    Public address... : %s\n",
                (argOut->addr ? argOut->addr : "<not set>"));
    printf("    Server port...... : %d\n", argOut->port);
    printf("    Verbosity........ : %d\n", argOut->verbose);
    printf("    AsyncSend........ : %s\n", (argOut->asyncSend ? "ENABLED" : "disabled"));
    printf("    Use TLS.......... : %s\n", (argOut->tls ? "YES" : "NO"));
    printf("    TLS CA Authority. : %s\n", (argOut->tlsCert ? argOut->tlsCert : "<not set>"));
    printf("    TLS Cert chain... : %s\n", (argOut->tlsChain ? argOut->tlsChain : "<not set>"));

    return RTI_TRUE;
}


DDS_ReturnCode_t configureTcpTransport(const struct CmdLineArgs * const args, 
            struct DDS_DomainParticipantQos * const part_qos) {
    DDS_ReturnCode_t rc;

    if ( (rc = DDS_PropertyQosPolicyHelper_assert_property(
                &part_qos->property,
                "dds.transport.load_plugins",
                "dds.transport.tcp.tcp1",
                DDS_BOOLEAN_FALSE)) != DDS_RETCODE_OK) {
        printf("! unable to set property 'dds.transport.load_plugins': %d\n", 
                rc);
        return DDS_RETCODE_ERROR;
    }

    if ( (rc = DDS_PropertyQosPolicyHelper_assert_property(
                &part_qos->property,
                "dds.transport.tcp.tcp1.library",
                (args->debug ? TRANSPORT_LIB_NAME_DBG : TRANSPORT_LIB_NAME),
                DDS_BOOLEAN_FALSE)) != DDS_RETCODE_OK) {
        printf("! unable to set property 'dds.transport.tcp.tcp1.library': %d\n", 
                rc);
        return DDS_RETCODE_ERROR;
    }

    if ( (rc = DDS_PropertyQosPolicyHelper_assert_property(
                &part_qos->property,
                "dds.transport.tcp.tcp1.create_function",
                "NDDS_Transport_TCPv4_create",
                DDS_BOOLEAN_FALSE)) != DDS_RETCODE_OK) {
        printf("! unable to set property 'dds.transport.tcp.tcp1.create_function': %d\n", 
                rc);
        return DDS_RETCODE_ERROR;
    }

    if (args->tls) {
        if (args->tlsCert == NULL) {
            printf("! missing --tls-cert argument\n");
            return DDS_RETCODE_ERROR;
        }
        if (args->tlsChain == NULL) {
            printf("! missing --tls-chain argument\n");
            return DDS_RETCODE_ERROR;
        }
        if ( (rc = DDS_PropertyQosPolicyHelper_assert_property(
                    &part_qos->property,
                    "dds.transport.tcp.tcp1.tls.verify.ca_file",
                    args->tlsCert,
                    DDS_BOOLEAN_FALSE)) != DDS_RETCODE_OK) {
            printf("! unable to set property 'dds.transport.tcp.tcp1.tls.verify.ca_file': %d\n", 
                    rc);
            return DDS_RETCODE_ERROR;
        }
        if ( (rc = DDS_PropertyQosPolicyHelper_assert_property(
                    &part_qos->property,
                    "dds.transport.tcp.tcp1.tls.identity.certificate_chain_file",
                    args->tlsChain,
                    DDS_BOOLEAN_FALSE)) != DDS_RETCODE_OK) {
            printf("! unable to set property 'dds.transport.tcp.tcp1.tls.verify.certificate_chain_file': %d\n", 
                    rc);
            return DDS_RETCODE_ERROR;
        }
    }

    if (args->port) {
        /* Node is REACHABLE. Internal server is LISTENING */
        char portstr[20];
        RTIOsapiUtility_snprintf(portstr, 20, "%d", args->port);
        if ( (rc = DDS_PropertyQosPolicyHelper_assert_property(
                &part_qos->property,
                "dds.transport.tcp.tcp1.server_bind_port",
                portstr,
                DDS_BOOLEAN_FALSE)) != DDS_RETCODE_OK) {
            printf("! unable to set property 'dds.transport.tcp.tcp1.server_bind_port': %d\n", 
                rc);
            return DDS_RETCODE_ERROR;
        }
        /* Deprecated
        if ( (rc = DDS_PropertyQosPolicyHelper_assert_property(
                    &part_qos->property,
                    "dds.transport.tcp.tcp1.is_reachable",
                    "1",
                    DDS_BOOLEAN_FALSE)) != DDS_RETCODE_OK) {
            printf("! unable to set property 'dds.transport.tcp.tcp1.is_reachable': %d\n", 
                    rc);
            return DDS_RETCODE_ERROR;
        }
        */
        if (args->addr != NULL) {
            /* transport is in wan configuration */
            if (args->tls) {
                if ( (rc = DDS_PropertyQosPolicyHelper_assert_property(
                        &part_qos->property,
                        "dds.transport.tcp.tcp1.parent.classid",
                        "NDDS_TRANSPORT_CLASSID_TLSV4_WAN",
                        DDS_BOOLEAN_FALSE)) != DDS_RETCODE_OK) {
                    printf("! unable to set property 'dds.transport.tcp.tcp1.parent.classid': %d\n", 
                        rc);
                    return DDS_RETCODE_ERROR;
                }
            } else {
                if ( (rc = DDS_PropertyQosPolicyHelper_assert_property(
                        &part_qos->property,
                        "dds.transport.tcp.tcp1.parent.classid",
                        "NDDS_TRANSPORT_CLASSID_TCPV4_WAN",
                        DDS_BOOLEAN_FALSE)) != DDS_RETCODE_OK) {
                    printf("! unable to set property 'dds.transport.tcp.tcp1.parent.classid': %d\n", 
                        rc);
                    return DDS_RETCODE_ERROR;
                }
            }
            if ( (rc = DDS_PropertyQosPolicyHelper_assert_property(
                    &part_qos->property,
                    "dds.transport.tcp.tcp1.public_address",
                    args->addr,
                    DDS_BOOLEAN_FALSE)) != DDS_RETCODE_OK) {
                printf("! unable to set property 'dds.transport.tcp.tcp1.public_address': %d\n", 
                    rc);
                return DDS_RETCODE_ERROR;
            }
            /*
            retcode = DDS_PropertyQosPolicyHelper_assert_property(
                &domainparticipant_qos.property,
                "dds.transport.TCP.tcp1.public_address.network_ordered_value",
                "0,0,0,0,0,0,0,0,255,255,28,232,192,168,93,100",
                DDS_BOOLEAN_FALSE);
            */
        } else {
            /* transport is in LAN configuration */
            if (args->tls) {
                if ( (rc = DDS_PropertyQosPolicyHelper_assert_property(
                        &part_qos->property,
                        "dds.transport.tcp.tcp1.parent.classid",
                        "NDDS_TRANSPORT_CLASSID_TLSV4_LAN",
                        DDS_BOOLEAN_FALSE)) != DDS_RETCODE_OK) {
                    printf("! unable to set property 'dds.transport.tcp.tcp1.parent.classid': %d\n", 
                        rc);
                    return DDS_RETCODE_ERROR;
                }
            } else {
                if ( (rc = DDS_PropertyQosPolicyHelper_assert_property(
                        &part_qos->property,
                        "dds.transport.tcp.tcp1.parent.classid",
                        "NDDS_TRANSPORT_CLASSID_TCPV4_LAN",
                        DDS_BOOLEAN_FALSE)) != DDS_RETCODE_OK) {
                    printf("! unable to set property 'dds.transport.tcp.tcp1.parent.classid': %d\n", 
                        rc);
                    return DDS_RETCODE_ERROR;
                }
            }
        }
       
    } else {
        /* node is NOT REACHABLE */
        if (args->addr != NULL) {
            printf("WARNING: You specified public address (--address), but you configured this node\n"
                   "         to be NOT REACHABLE (you didn't specify the --port argument.\n"
                   "         The public address will be ignored.\n");
        }
        /* Always use WAN configuration in asymmetric scenario */
        if (args->tls) {
            if ( (rc = DDS_PropertyQosPolicyHelper_assert_property(
                        &part_qos->property,
                        "dds.transport.tcp.tcp1.parent.classid",
                        "NDDS_TRANSPORT_CLASSID_TLSV4_WAN",
                        DDS_BOOLEAN_FALSE)) != DDS_RETCODE_OK) {
                printf("! unable to set property 'dds.transport.tcp.tcp1.parent.classid': %d\n", 
                        rc);
                return DDS_RETCODE_ERROR;
            }
        } else {
            if ( (rc = DDS_PropertyQosPolicyHelper_assert_property(
                        &part_qos->property,
                        "dds.transport.tcp.tcp1.parent.classid",
                        "NDDS_TRANSPORT_CLASSID_TCPV4_WAN",
                        DDS_BOOLEAN_FALSE)) != DDS_RETCODE_OK) {
                printf("! unable to set property 'dds.transport.tcp.tcp1.parent.classid': %d\n", 
                        rc);
                return DDS_RETCODE_ERROR;
            }
        }
        if ( (rc = DDS_PropertyQosPolicyHelper_assert_property(
                &part_qos->property,
                "dds.transport.tcp.tcp1.server_bind_port",
                "0",
                DDS_BOOLEAN_FALSE)) != DDS_RETCODE_OK) {
            printf("! unable to set property 'dds.transport.tcp.tcp1.server_bind_port': %d\n", 
                rc);
            return DDS_RETCODE_ERROR;
        }
    }

    /* Enable debugging logging */
    if (args->verbose > 0) {
        /* Set transport verbosity */
        if ( (rc = DDS_PropertyQosPolicyHelper_assert_property(
                &part_qos->property,
                "dds.transport.tcp.tcp1.logging_verbosity_bitmap",
                "255",
                DDS_BOOLEAN_FALSE)) != DDS_RETCODE_OK) {
            printf("! unable to set property 'dds.transport.tcp.tcp1.logging_verbosity_bitmap': %d\n", 
                rc);
            return DDS_RETCODE_ERROR;
        }
    }

    /* Use async send */
    if ( (rc = DDS_PropertyQosPolicyHelper_assert_property(
                &part_qos->property,
                "dds.transport.tcp.tcp1.force_asynchronous_send",
                (args->asyncSend ? "1" : "0"),
                DDS_BOOLEAN_FALSE)) != DDS_RETCODE_OK) {
        printf("! unable to set property 'dds.transport.tcp.tcp1.force_asynchronous_send': %d\n", 
                rc);
        return DDS_RETCODE_ERROR;
    }

    return DDS_RETCODE_OK;

}


