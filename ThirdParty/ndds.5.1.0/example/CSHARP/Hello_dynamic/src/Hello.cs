/* ****************************************************************************
 *         (c) Copyright, Real-Time Innovations, All rights reserved.       
 *                                                                          
 *         Permission to modify and use for internal purposes granted.      
 * This software is provided "as is", without warranty, express or implied. 
 *                                                                          
 * ****************************************************************************
 */
using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace Hello {
    /**
     * A container for the running options (defined through the command-line 
     * arguments)
     */
    public class CommandLineArguments {
        /* Command line defaults */
        public const int DEFAULT_DOMAIN_ID = 0;
        public const int DEFAULT_PAYLOAD = 1023;
        public const int MAX_PAYLOAD = 1023;
        public const String APPLICATION_NAME = "Hello";

        /* This is the name of the topic used for our test */
        public const String DEFAULT_TOPIC_NAME = "Hello Dynamic";

        /* Application running mode */
        public const int APP_MODE_UNDEFINED = 0;
        public const int APP_MODE_PUBLISHER = 1;
        public const int APP_MODE_SUBSCRIBER = 2;

        /* The maximum value for Domain ID. The effective value depends on the QoS,
         * in particular to the value of the field:
         *              DDS_RtpsWellKnownPorts_t.domainId_gain
         * The default value is 250, so we just limit to that statically so we can
         * check the validity before attempting to create the domain participant.
         */
        public const int DOMAIN_ID_MAX = 250;

        public int domainId;
        public int mode;
        public int dataSize;
        public int sampleCount;
        public int verbose;    /* 0=no verbose, 1=app verbose, 2=DDS */
        public String topicName;

        public CommandLineArguments() {
            domainId = DEFAULT_DOMAIN_ID;
            mode = APP_MODE_UNDEFINED;
            dataSize = DEFAULT_PAYLOAD;
            sampleCount = 0;
            verbose = 0;
            topicName = DEFAULT_TOPIC_NAME;
        }
    }
    
    // ****************************************************************************
    /**
     * The main class contains only static methods. It contains the main entry
     * method and delegates the pub/sub to the other classes.
     */
    public class Hello {
        /*****************************************************************************/
        /* startApplication                                                          */
        /*                                                                           */
        /* Creates the DDS Domain Participant, then delegates the execution to the   */
        /* correct pub/sub function.                                                 */
        /* If entity creation is successful, this function does not return.          */
        /*                                                                           */
        /* Input:                                                                    */
        /*   arg: pointer to the CommandLineArguments structure                      */
        /*                                                                           */
        /*****************************************************************************/
        private static void startApplication(CommandLineArguments arg) {
            Console.WriteLine("# The output below depends on the QoS profile"); 
            Console.WriteLine("# provided to this application.");
            Console.WriteLine("# -> For more information on the provided example");
            Console.WriteLine("#    profiles, please see the Getting Started Guide.");
            Console.WriteLine("# -> For detailed product performance metrics, visit");
            Console.WriteLine("#    http://www.rti.com/products/data_distribution/index.html");
            Console.WriteLine("#    and click on Benchmarks.\n");

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
            try {
                if (!File.Exists("USER_QOS_PROFILES.xml")) {
                    /* Then look for the environment variable 'NDDS_QOS_PROFILES'... 
                     */
                    String enVal = System.Environment.GetEnvironmentVariable("NDDS_QOS_PROFILES");
                    if ((enVal == null) || !File.Exists(enVal)) {
                        Console.WriteLine("! Warning:");
                        Console.WriteLine("! Default QoS profile definition file not found");
                        Console.WriteLine("! The application will use the DDS default QoS.");
                        Console.WriteLine("! If you want to use different QoS, make sure you have the QoS definition file");
                        Console.WriteLine("! (USER_QOS_PROFILES.xml) in the current working directory");
                        Console.WriteLine("! or set the environment variable NDDS_QOS_PROFILES to point");
                        Console.WriteLine("! to a file containing the default QoS profile");
                    }
                }
            }
            catch (FileNotFoundException) { }
            /* If you need to customize any DDS factory QoS, uncomment the following
            * code:
            *
            try {
                DDS.DomainParticipantFactoryQos factoryQos = new DDS.DomainParticipantFactoryQos();
                DDS.DomainParticipantFactory.get_instance().get_qos(factoryQos);
                // Modify the factory QoS here

                DDS.DomainParticipantFactory.get_instance().set_qos(factoryQos);
            }
            catch (DDS.Exception e) {
                Console.Error.WriteLine("An error occurred while changing factory QoS: " + e);
            }
            */

            /* Creates the DDS Domain Participant.
             * The following command will create a DDS Domain participant
             * without installing any status callback listener.
             * If you want to create a domain participant with different QoS,
             * use DDS_DomainParticipantFactory_get_default_participant_qos
             * to obtain a copy of the default participant QoS, change them,
             * then use them instead of DDS_PARTICIPANT_QOS_DEFAULT:
             *
               DDS.DomainParticipantQos myQos = new DDS.DomainParticipantQos();
               DDS.DomainParticipantFactory.get_instance().get_default_participant_qos(myQos);

               // Modify here the participant Qos

               // Then create the domain participant using 'myQos' instead of
               //     DDS.DomainParticipantFactory.PARTICIPANT_QOS_DEFAULT
                
             *
             * Note: for more info on the domain participant API see:
             *     $NDDSHOME/doc/html/api_dotnet/group__DDSDomainParticipantModule.html
             */

            if (arg.verbose > 1) {
                Console.WriteLine("Creating domain participant...");
            }
            DDS.DomainParticipant participant = DDS.DomainParticipantFactory.get_instance().create_participant(
                                arg.domainId,
                                DDS.DomainParticipantFactory.PARTICIPANT_QOS_DEFAULT,
                                null, /* Listener */
                                DDS.StatusMask.STATUS_MASK_NONE);
            if (participant == null) {
                Console.Error.WriteLine("! Unable to create DDS domain participant");
                return;
            }
            /* Create TypeCode, DynamicDataTypeSupport for dynamic data type */
            DDS.TypeCode type = HelloWorldType.create();
            if (type == null) {
                Console.Error.WriteLine("! Unable to create dynamic type code");
                return;
            }

            /* Create the Dynamic data type support object */
            DDS.DynamicDataTypeSupport typeSupport = new DDS.DynamicDataTypeSupport(                                    
                                    type,
                                    DDS.DynamicDataTypeProperty_t.DYNAMIC_DATA_TYPE_PROPERTY_DEFAULT);

            /* Register type before creating topic */
            typeSupport.register_type(participant, HelloWorldType.getTypeName());

            /* Creates the topic.
             * The following command will create the topic without
             * installing any status callback listener.
             * If you want to create a topic with different QoS,
             * use DDS.DomainParticipant.get_default_topic_qos
             * to obtain a copy of the default topic QoS, change them,
             * then use them instead of DDS_TOPIC_QOS_DEFAULT:
             *
                DDS.TopicQos myQos = new DDS.TopicQos();
                participant.get_default_topic_qos(myQos);
                
                // Modify here the topic Qos

                // Then create the topic using 'myQos'...
             *
             * Note: for more info on the topic API see:
             *     $NDDSHOME/doc/html/api_dotnet/group__DDSTopicEntityModule.html
             */

            if (arg.verbose > 0) {
                Console.WriteLine("Creating the topic....");
            }

            DDS.Topic topic = participant.create_topic(
                            arg.topicName,
                            HelloWorldType.getTypeName(),
                            DDS.DomainParticipant.TOPIC_QOS_DEFAULT,
                            null, /* Listener */
                            DDS.StatusMask.STATUS_MASK_NONE);

            if (topic == null) {
                Console.Error.WriteLine("! Unable to create topic " + arg.topicName);
                return;
            }

            /* Creates the publisher or subscriber */
            if (arg.mode == CommandLineArguments.APP_MODE_PUBLISHER) {
                HelloPublisher publisher = new HelloPublisher(
                                participant,
                                topic,
                                type,
                                arg.verbose,
                                arg.dataSize,
                                arg.sampleCount);
                publisher.writeSamples();
            } else {
                HelloSubscriber subscriber = new HelloSubscriber(
                                participant,
                                topic,
                                arg.verbose,
                                arg.sampleCount);
                subscriber.waitForTermination();
            }

            /* Shutdown when sample count is set */
            if (participant != null) {
                participant.delete_contained_entities();
                typeSupport.unregister_type(participant, HelloWorldType.getTypeName());
                DDS.DomainParticipantFactory.get_instance().delete_participant(
                    ref participant);
            }
            typeSupport.Dispose();
            HelloWorldType.delete(type);
        }

        /*****************************************************************************/
        /* usage                                                                     */
        /*                                                                           */
        /* Prints help on command line arguments accepted by this application        */
        /*****************************************************************************/
        public static void usage() {
            Console.WriteLine("Usage:");
            Console.WriteLine("\tHello pub [arguments]\tRun as publisher");
            Console.WriteLine("\tHello sub [arguments]\tRun as subscriber");
            Console.WriteLine("Where arguments are:");
            Console.WriteLine("\t -h | --help\t\t Shows this page");
            Console.WriteLine("\t -v | --verbose\t\t Increase output verbosity (can be repeated)");
            Console.WriteLine("\t -d | --domain <domainID>\t\t Sets the DDS domain ID [default=" + CommandLineArguments.DEFAULT_DOMAIN_ID + "]");
            Console.WriteLine("\t -t | --topic <name>\t\t Sets topic name [default=[" + CommandLineArguments.DEFAULT_TOPIC_NAME + "]");
            Console.WriteLine("\t -s | --size <num>\t\t Sets payload size in bytes [default=" + CommandLineArguments.DEFAULT_PAYLOAD + "]");
            Console.WriteLine("\t -c | --sampleCount <num>\t\t Sets the number of samples to send/receive [default=0(UNLIMITED)]");
            Console.WriteLine("");
        }

        /**************************************************************************
         * A simple method used to check if there are enough command line args
         */
        public static Boolean ensure_one_more_arguement(int i, String[] args, string argName) {
            if (i + 1 > args.Length) {
                usage();
                Console.WriteLine("! Error: missing value for " + argName + " argument");
                return false;
            }
            return true;
        }

        /*****************************************************************************/
        /* main                                                                      */
        /*                                                                           */
        /* Application main entry point                                              */
        /*****************************************************************************/
        public static void Main(string[] argv) {
            CommandLineArguments args = new CommandLineArguments();

            Console.WriteLine("Hello Example Application");
            Console.WriteLine("Copyright 2008 Real-Time Innovations, Inc.");

            /* Ensure there are enough arguments in the command line */
            if (argv.Length == 0) {
                usage();
                Console.Error.WriteLine("! Invalid number of arguments.");
                Console.Error.WriteLine("! You must specify must specify at least running mode (pub/sub)");
                return;
            }

            /* Parse the running mode: pub/sub */
            if (argv[0].Equals("pub")) {
                args.mode = CommandLineArguments.APP_MODE_PUBLISHER;
            } else if (argv[0].Equals("sub")) {
                args.mode = CommandLineArguments.APP_MODE_SUBSCRIBER;
            } else if (argv[0].Equals("-h") || argv[0].Equals("--help")) {
                usage();
                return;
            } else {
                usage();
                Console.Error.WriteLine("! Invalid number of arguments.");
                Console.Error.WriteLine("! You must specify must specify at least running mode (pub/sub)");
                return;
            }

            /* Parse the optional arguments */
            for (int i = 1; i < argv.Length; ++i) {
                if (argv[i].Equals("-h") || argv[i].Equals("--help")) {
                    usage();
                    return;
                }

                if (argv[i].Equals("-v") || argv[i].Equals("--verbose")) {
                    ++args.verbose;
                    continue;
                }

                if (argv[i].Equals("-d") || argv[i].Equals("--domain")) {
                    if (!(ensure_one_more_arguement(i, argv, "--domain"))) {
                        return;
                    }
                    args.domainId = Int32.Parse(argv[++i]);
                    if (args.domainId < 0 || args.domainId > CommandLineArguments.DOMAIN_ID_MAX) {
                        usage();
                        Console.Error.WriteLine("! Invalid DDS Domain ID: " + args.domainId);
                        Console.Error.WriteLine("! The domain ID must be between 0 and " + CommandLineArguments.DOMAIN_ID_MAX + " (inclusive)");
                        return;
                    }
                    continue;
                }

                if (argv[i].Equals("-s") || argv[i].Equals("--size")) {
                    if (!ensure_one_more_arguement(i, argv, "--size")) {
                        return;
                    }
                    args.dataSize = Int32.Parse(argv[++i]);
                    if (args.dataSize <= 0) {
                        usage();
                        Console.Error.WriteLine("! Invalid value for --size argument: " +
                        args.dataSize);
                        return;
                    }
                    if (args.dataSize > CommandLineArguments.MAX_PAYLOAD) {
                        usage();
                        Console.Error.WriteLine("! Value too big for --size argument: "
                            + args.dataSize);
                        Console.Error.WriteLine("! For built-in types, the default max string size is set to "
                            + CommandLineArguments.MAX_PAYLOAD);
                        Console.Error.WriteLine("! See manual on built-in types for more information.");
                        return;
                    }
                    continue;
                }
                if (argv[i].Equals("-t") || argv[i].Equals("--topic")) {
                    if (!ensure_one_more_arguement(i, argv, "--topic")) {
                        return;
                    }
                    args.topicName = argv[++i];
                    continue;
                }
                if (argv[i].Equals("-c") || argv[i].Equals("--sampleCount")) {
                    if (!ensure_one_more_arguement(i, argv, "--sampleCount")) {
                        return;
                    }
                    args.sampleCount = Int32.Parse(argv[++i]);
                    if (args.sampleCount < 0) {
                        usage();
                        Console.Error.WriteLine("! Invalid value for --sampleCount argument: " +
                        args.sampleCount);
                        return;
                    }
                    continue;
                }
                /* Else, it is an invalid argument */
                usage();
                Console.Error.WriteLine("! Unknown argument " + argv[i]);
                return;
            } /* foreach argument */
            
            if (args.verbose > 0) {
                DDS.ProductVersion_t prodVersion =
                    NDDS.ConfigVersion.get_instance().get_product_version();
                Console.WriteLine("Running with the following arguments:");
                Console.WriteLine("    Verbosity level.. : " + args.verbose);
                Console.WriteLine("    Payload size..... : " + args.dataSize);
                Console.WriteLine("    Sample count..... : " + args.sampleCount);
                Console.WriteLine("    Domain ID........ : " + args.domainId);
                Console.WriteLine("    Topic name....... : " + args.topicName);
                Console.WriteLine("RTI Product Version.. : " + prodVersion.major + "." +
                                    prodVersion.minor + prodVersion.release +
                                    "(rev " + prodVersion.release + ")");

               /* Alternatively, you can print all the components of the 
                * NDDS.ConfigVersion object with a single call to:
                *       NDDS.ConfigVersion.get_instance().to_string()
                */
            }
            
            /* If the verbosity is bigger than 1, also turn on RTI DDS status logging
             * For more info, see: 
             *       $NDDSHOME/doc/html/api_dotnet/group__NDDSConfigModule.html
             */
            if (args.verbose > 1) {
                NDDS.ConfigLogger.get_instance().set_verbosity_by_category(
                    NDDS.LogCategory.NDDS_CONFIG_LOG_CATEGORY_API,
                    NDDS.LogVerbosity.NDDS_CONFIG_LOG_VERBOSITY_STATUS_ALL);
            }
            
            /* Finally, starts the application */
            startApplication(args);

            /* startApplication terminates if sample count is set */
            Console.WriteLine("Done.");
            return;
        }

    }
}
