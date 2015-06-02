/* ***************************************************************************
 *         (c) Copyright, Real-Time Innovations, All rights reserved.       
 *                                                                          
 *         Permission to modify and use for internal purposes granted.      
 * This software is provided "as is", without warranty, express or implied. 
 *                                                                          
 * ***************************************************************************
 */
using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

using DDS;
using NDDS;


namespace News {
    /* A container for the running options (defined through the command-line 
     * arguments). This class is used by the News class.
     */
    internal class CommandLineArguments {
        // -------------------------------------------------------------------
        // Fields
        // -------------------------------------------------------------------
    
        // --- Domain ID: ----------------------------------------------------
    
        private const int DEFAULT_DOMAIN_ID = 0;
    
        /* The maximum value for Domain ID. The effective value depends on the
         * QoS, in particular to the value of the field
         * RtpsWellKnownPorts_t.domain_id_gain.
         * The default value is 250, so we just limit to that statically so we
         * can check the validity before attempting to create the domain
         * participant.
         */
        private const int DOMAIN_ID_MAX = 250;
    
        public int domainId = DEFAULT_DOMAIN_ID;
    
    
        // --- Mode (publisher or subscriber): -------------------------------
    
        public const int APP_MODE_UNDEFINED  = 0;
        public const int APP_MODE_PUBLISHER  = 1;
        public const int APP_MODE_SUBSCRIBER = 2;
    
        public int mode = APP_MODE_UNDEFINED;
    
    
        // --- Other fields: -------------------------------------------------
    
        // The number of seconds for which this application should run.
        public int runSeconds = 20;
    
        // 0 = no verbose, 1 = app verbose, 2 = DDS
        public int verbose = 0;
    
        /* If the subscribing application is using a content-based filter to
         * down-sample the incoming data, the filter expression will be stored
         * here.
         */
        public String contentFilter = null;
    
    
    
        // -------------------------------------------------------------------
        // Public Methods
        // -------------------------------------------------------------------
    
        public static CommandLineArguments parseArguments(String[] argv) {
            CommandLineArguments args = new CommandLineArguments();
            try {
                if (argv.Length == 0) {
                    Console.Error.WriteLine(
                        "! Invalid arguments.\n" +
                        "! You must specify at least running mode (pub/sub)");
                    throw new ArgumentParseException();
                }
    
                // Parse the command: pub or sub
                if (argv[0].Equals("pub")) {
                    args.mode = CommandLineArguments.APP_MODE_PUBLISHER;
                } else if (argv[0].Equals("sub")) {
                    args.mode = CommandLineArguments.APP_MODE_SUBSCRIBER;
                } else if (argv[0].Equals("-h") || argv[0].Equals("--help")) {
                    Usage();
                    return null;
                } else {
                    Console.Error.WriteLine("! Invalid mode: " + argv[0]);
                    Console.Error.WriteLine(
                        "! Valid modes are only 'pub' or 'sub'.");
                    throw new ArgumentParseException();
                }
    
                // Parse the rest of the arguments
                for (int i = 1; i < argv.Length; ++i) {
                    if (argv[i].Equals("-h") || argv[i].Equals("--help")) {
                        Usage();
                        args = null;
                        break;
                    }

                    if (argv[i].Equals("-v") || argv[i].Equals("--verbose")) {
                        ++args.verbose;
                        continue;
                    }

                    if (argv[i].Equals("-d") || argv[i].Equals("--domain")) {
                        EnsureOneMoreArgument(i, argv, "--domain");
                        args.domainId = Int32.Parse(argv[++i]);
                        if (args.domainId < 0 || 
                                args.domainId > CommandLineArguments.DOMAIN_ID_MAX) {
                            Console.Error.WriteLine(
                                "! Invalid DDS Domain ID:" + args.domainId);
                            Console.Error.WriteLine(
                                "! The domain ID must be between 0 and " +
                                CommandLineArguments.DOMAIN_ID_MAX +
                                " (inclusive)");
                            throw new ArgumentParseException();
                        }
                        continue;
                    }

                    if (argv[i].Equals("-r") || argv[i].Equals("--runSeconds")) {
                        EnsureOneMoreArgument(i, argv, "--runSeconds");
                        args.runSeconds = Int32.Parse(argv[++i]);
                        if (args.runSeconds <= 0) {
                            Console.Error.WriteLine(
                                "! Invalid value for --runSeconds argument: " +
                                args.runSeconds);
                        }
                        continue;
                    }

                    if (argv[i].Equals("-f") ||
                            argv[i].Equals("--filterExpression")) {
                        EnsureOneMoreArgument(i, argv, "--filterExpression");
                        args.contentFilter = argv[++i];
                        continue;
                    }
    
                    // Else, is an invalid argument
                    Console.Error.WriteLine("! Unknown argument: " + argv[i]);
                    throw new ArgumentParseException();
                }
            } catch (ArgumentParseException apx) {
                Usage();
                throw apx;
            }
            return args;
        }
    
    
    
        // -------------------------------------------------------------------
        // Private Methods
        // -------------------------------------------------------------------
    
        /* Prints brief instructions on command-line arguments accepted to
         * standard out.
         */
        private static void Usage() {
            Console.WriteLine("Usage:");
            Console.WriteLine(
                "    News pub [arguments]     Run as publisher");
            Console.WriteLine(
                "    News sub [arguments]     Run as subscriber");
            Console.WriteLine("Where arguments are:");
            Console.WriteLine(
                    "  -h | --help                   " +
                    "Shows this page");
            Console.WriteLine(
                    "  -v | --verbose                " +
                    "Increase output verbosity (can be repeated)");
            Console.WriteLine(
                    "  -d | --domain <domainID>      " +
                    "Sets the DDS domain ID [default=" + 
                    CommandLineArguments.DEFAULT_DOMAIN_ID + "]");
            Console.WriteLine(
                    "  -r | --runSeconds <integer>   " +
                    "Sets the number of seconds to run [default=20]");
            Console.WriteLine(
                    "  -f | --filterExpression <SQL> " +
                    "Sets a content filter on the data");
            Console.WriteLine();
        }
    
    
        private CommandLineArguments() {
            // empty
        }
        
        
        /* A simple function used to check if there are enough command line
         * arguments.
         */
        private static void EnsureOneMoreArgument(
                int i, String [] args, String argName) {
            if (i+1 > args.Length) {
                Console.WriteLine("! Error: missing value for " + argName +
                                   " argument");
                throw new ArgumentParseException();
            }
        }
    
    
    
        // -------------------------------------------------------------------
        // Types
        // -------------------------------------------------------------------
    
        public class ArgumentParseException : System.Exception {
            // empty
        }
    }
    

    /* The News example implements a simple application: a variety of news
     * outlets publish articles at different rates, and subscribers consume
     * the data based on different criteria. It demonstrates several
     * important design patterns.
     * 
     * This class, the main class, contains only static methods. It contains
     * the main entry method and delegates the pub/sub to the other classes.
     */
    public class News {
        // -------------------------------------------------------------------
        // Constants
        // -------------------------------------------------------------------
    
        /* Both the publisher(s) and the subscriber(s) will print out their
         * status after this many milliseconds.
         */
        internal const int STATUS_PERIOD_MILLIS = 2 * 1000;
    
    
        private const String TOPIC_NAME = "News Example";
    
    
    
        // -------------------------------------------------------------------
        // Main Method
        // -------------------------------------------------------------------

        /* Application main entry point.
         * 
         * Parameters:
         *     argv  array of strings containing the command-line arguments
         */
        public static void Main(String[] argv) {
            Console.WriteLine("RTI News Example");
            Console.WriteLine("Copyright 2009 Real-Time Innovations, Inc.\n");
            
            try {
                CommandLineArguments args =
                    CommandLineArguments.parseArguments(argv);
                if (args == null) {
                    return;
                }
    
                if (args.verbose > 0) {
                    PrintProductInformation(args);
                }
                /* If the verbosity is greater than 1, also turn on RTI status
                 * logging.
                 */
                if (args.verbose > 1) {
                    ConfigLogger.get_instance().set_verbosity_by_category(
                        LogCategory.NDDS_CONFIG_LOG_CATEGORY_API,
                        LogVerbosity.NDDS_CONFIG_LOG_VERBOSITY_STATUS_ALL);
                }
                
                // Start the application
                StartApplication(args);
                Console.WriteLine("Done.");
            } catch (CommandLineArguments.ArgumentParseException) {
                // do nothing; just return
            }
        }
    
    
    
        // -------------------------------------------------------------------
        // Private Methods
        // -------------------------------------------------------------------
    
        /* Creates the DDS Domain Participant then delegates the execution to
         * the correct pub/sub method.
         */
        private static void StartApplication(CommandLineArguments arg) {
            /* This example creates DDS entities using the default QoS loaded
             * from the file USER_QOS_PROFILES.xml in the current working
             * directory.
             */
            if (!File.Exists("USER_QOS_PROFILES.xml")) {
                Console.Error.WriteLine(
                    "! Unable to locate QoS definition file");
                Console.Error.WriteLine(
                    "! (USER_QOS_PROFILES.xml) in current directory.");
                return;
            }
    
            // --- Get the DomainParticipantFactory --- //
            DomainParticipantFactory factory =
                DomainParticipantFactory.get_instance();
            /* If you need to customize any DDS factory QoS, uncomment the
             * following code:
             *
            DomainParticipantFactoryQos factoryQos =
                new DomainParticipantFactoryQos();
            factory.get_qos(factoryQos);
            // Modify the factory QoS here.
            factory.set_qos(factoryQos);
             */
    
            // --- Create the DomainParticipant --- //
            /* If you want to create a domain participant with different QoS,
             * use DomainParticipantFactory.get_default_participant_qos()
             * to obtain a copy of the default participant QoS, change them,
             * then use them instead of PARTICIPANT_QOS_DEFAULT:
             *
                DomainParticipantQos myQos = new DomainParticipantQos();
                factory.get_default_participant_qos(myQos);
                // Modify the participant QoS here.
                // Then create the domain participant using 'myQos' instead of
                //     DomainParticipantFactory.PARTICIPANT_QOS_DEFAULT
             */
            if (arg.verbose > 1) {
                Console.WriteLine("Creating DomainParticipant...");
            }
            DomainParticipant participant = factory.create_participant(
                    arg.domainId,
                    DomainParticipantFactory.PARTICIPANT_QOS_DEFAULT,
                    null,                           // no listener
                    StatusMask.STATUS_MASK_NONE);   // no listener callbacks
            if (participant == null) {
                Console.Error.WriteLine(
                    "! Unable to create DomainParticipant");
                return;
            }        
    
            try {
                // --- Create the Topic --- //
                /* If you want to create a topic with different QoS,
                 * use DomainParticipant.get_default_topic_qos()
                 * to obtain a copy of the default topic QoS, change them,
                 * then use them instead of TOPIC_QOS_DEFAULT:
                 *
                TopicQos myQos = new TopicQos();
                participant.get_default_topic_qos(myQos);
                // Modify the topic QoS here
                // Then create the topic using 'myQos'...
                 */
                if (arg.verbose > 0) {
                    Console.WriteLine("Creating the Topic...");
                }
                Topic topic = participant.create_topic(
                        TOPIC_NAME,
                        KeyedStringTypeSupport.get_type_name(), 
                        DomainParticipant.TOPIC_QOS_DEFAULT,
                        null,                         // no listener
                        StatusMask.STATUS_MASK_NONE); // no listener callbacks
                if (topic == null) {
                    Console.Error.WriteLine("! Unable to create Topic");
                    return;
                }
    
                // --- Start Publishing or Subscribing Application --- //
                if (arg.mode == CommandLineArguments.APP_MODE_PUBLISHER) {
                    NewsPublisher publisher = new NewsPublisher(
                            participant, 
                            topic,
                            arg.verbose,
                            arg.runSeconds);
                    publisher.Publish();
                } else {
                    NewsSubscriber subscriber = new NewsSubscriber(
                            participant, 
                            topic,
                            arg.verbose,
                            arg.runSeconds,
                            arg.contentFilter);
                    subscriber.ReadArticles();
                }
            } finally {
                // --- Shutdown --- //
                if (participant != null) {
                    participant.delete_contained_entities();
                    factory.delete_participant(ref participant);
                }
                DomainParticipantFactory.finalize_instance();
            }
        }
    
    
        private static void PrintProductInformation(
                CommandLineArguments args) {
            ConfigVersion rtiddsVersion = ConfigVersion.get_instance();
            ProductVersion_t prodVersion =
                rtiddsVersion.get_product_version();
    
            Console.WriteLine("Running with the following arguments:");
            Console.WriteLine("    Verbosity level.. : " + args.verbose);
            Console.WriteLine("    Domain ID........ : " + args.domainId);
            Console.WriteLine("    Seconds to run... : " + args.runSeconds);
            Console.WriteLine("    Content filter... : " + args.contentFilter);
            Console.WriteLine("RTI Product Version.. : " +
                               prodVersion.major + "." +
                               prodVersion.minor +
                               (char) prodVersion.release + " (rev " +
                               prodVersion.revision + ")");
        }
    
    
    
        // -------------------------------------------------------------------
        // Types
        // -------------------------------------------------------------------

        /* A helper class that formats the news outlet name together with the
         * article text for output to the terminal.
         */
        internal class Article {
            // --- Private fields: -------------------------------------------
            private const int MIN_NAME_WIDTH = 10;
            
            private String _stringified;
    
            // --- Public methods: -------------------------------------------
            public Article(String newsOutletName, String articleText) {
                /* For formatting purposes, make sure all of the news outlet
                 * names are padded to the same width.
                 */
                StringBuilder outletNameBuf = new StringBuilder(
                    newsOutletName);
                for (int i = newsOutletName.Length; i < MIN_NAME_WIDTH; ++i) {
                    outletNameBuf.Append(' ');
                }
                newsOutletName = outletNameBuf.ToString();
    
                _stringified =
                    "From " + newsOutletName + ": \"" + articleText + "\"";
            }
    
            public override String ToString() {
                return _stringified;
            }
        }
    
    }
}
