// ****************************************************************************
//         (c) Copyright, Real-Time Innovations, All rights reserved.       
//                                                                          
//         Permission to modify and use for internal purposes granted.      
// This software is provided "as is", without warranty, express or implied. 
//                                                                          
// ****************************************************************************

package com.rti.hello;

import java.io.File;
import java.io.IOException;
import java.util.logging.LogManager;

import com.rti.dds.domain.DomainParticipant;
import com.rti.dds.domain.DomainParticipantFactory;
import com.rti.dds.infrastructure.ProductVersion_t;
import com.rti.dds.infrastructure.StatusKind;
import com.rti.dds.topic.Topic;
import com.rti.dl.DistLogger;
import com.rti.ndds.config.LogCategory;
import com.rti.ndds.config.LogVerbosity;
import com.rti.ndds.config.Logger;
import com.rti.ndds.config.Version;

// This import allow this file to see all the generated code
import com.rti.hello.idl.HELLODDS_MAX_PAYLOAD_SIZE;
import com.rti.hello.idl.HelloWorldTypeSupport;


// ****************************************************************************
/**
 * A container for the running options (defined through the command-line 
 * arguments)
 */
class CommandLineArguments {
            
    // A set of constants used in this class
    static final String APPLICATION_NAME = "Hello";
    static final int    DEFAULT_PAYLOAD = 1024;
    static final int    DEFAULT_DOMAIN_ID = 0; //Change here the domain ID
    static final String DEFAULT_TOPIC_NAME = "Hello IDL";

    // Running mode: publisher or subscriber
    static final int    APP_MODE_UNDEFINED  = 0;
    static final int    APP_MODE_PUBLISHER  = 1;
    static final int    APP_MODE_SUBSCRIBER = 2;
    
    // The maximum value for Domain ID. The effective value depends on the QoS,
    // in particular to the value of the field:
    //             RtpsWellKnownPorts_t.domain_id_gain
    // The default value is 250, so we just limit to that statically so we can
    // check the validity before attempting to create the domain participant.
    static final int    DOMAIN_ID_MAX = 250;

    public int domainId;
    public int mode;
    public int dataSize;
    public int sampleCount;
    public int verbose;        // 0=no verbose, 1=app verbose, 2=DDS
    public String topicName;
    
    CommandLineArguments() {
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
    // get a logger from the java.util.logging package
    private static final java.util.logging.Logger logger = 
            java.util.logging.Logger.getLogger(Hello.class.toString());
    

    /**************************************************************************
     * Creates the DDS Domain Participant, then delegates the execution to the
     * correct pub/sub function.
     * If entity creation is successful, this function does not return. 
     */
    private static void startApplication(final CommandLineArguments arg) {
        StringBuilder buffer = new StringBuilder();
        buffer.append("\n# The output below depends on the QoS profile\n"); 
        buffer.append("# provided to this application.\n");
        buffer.append("# -> For more information on the provided example\n");
        buffer.append("#    profiles, please see the Getting Started Guide.\n");
        buffer.append("# -> For detailed product performance metrics, visit\n");
        buffer.append("#    http://www.rti.com/products/data_distribution/index.html\n");
        buffer.append("#    and click on Benchmarks.\n\n");
        logger.info(buffer.toString());

        // This example creates DDS entities using the default QoS.
        // The default QoS can be modified in two ways:
        // 1. By placing a file called 'USER_QOS_PROFILES.xml' in the directory
        //    where the application is launched.
        // 2. By setting the environment variable 'NDDS_QOS_PROFILES' to point
        //    to a valid file containing QoS policy definitions.
        //
        // This section check if a QoS profile file is accessible, and prints
        // a warning if that's not true.
        //
        
        // First look in the current directory to see if the USER_QOS_PROFILES.xml
        // file exist.
        //
        if (!new File("USER_QOS_PROFILES.xml").exists()) {
            /* Then look for the environment variable 'NDDS_QOS_PROFILES'... 
             */
            String version = System.getProperty("java.version");
            if (version.startsWith("1.4")) { /* deprecated System.getenv() */
                logger.warning("! Warning:");
                logger.warning("! Java "+version+" cannot determine if the"); 
                logger.warning("! environment variable NDDS_QOS_PROFILES is set.");
                logger.warning("! If not set, the application will use the ");
                logger.warning("! DDS default QoS.");
                logger.warning("! If you want to use different QoS, make sure you have the " +
                                   "QoS definition file");
                logger.warning("! (USER_QOS_PROFILES.xml) in the current working directory");
                logger.warning("! or set the environment variable NDDS_QOS_PROFILES to");
                logger.warning("! point to a file containing the default QoS profile");
            } else {
                String envVal = System.getenv("NDDS_QOS_PROFILES");
                if (envVal == null || new File(envVal).exists()) {
                    logger.warning("! Warning:");
                    logger.warning("! Default QoS profile definition file not found.");
                    logger.warning("! The application will use the DDS default QoS.");
                    logger.warning("! If you want to use different QoS, make sure you have the " +
                                "QoS definition file");
                    logger.warning("! (USER_QOS_PROFILES.xml) in the current working directory");
                    logger.warning("! or set the environment variable NDDS_QOS_PROFILES to");
                    logger.warning("! point to a file containing the default QoS profile");
                }
            }
        }
        
        /* If you need to customize any DDS factory QoS, uncomment the following
         * code:
         *
        try {
            DomainParticipantFactoryQos factoryQos = new DomainParticipantFactoryQos();
            DomainParticipantFactory.get_instance().get_qos(factoryQos);
            // Modify the factory QoS here

            DomainParticipantFactory.get_instance().set_qos(factoryQos);
        }
        catch(RETCODE_ERROR e) {
            logger.severe("An error occurred while changing factory QoS: " 
                        + e);
        }
        */

        /* Creates the DDS Domain Participant.
         * The following command will create a DDS Domain participant without
         * installing any status callback listener.
         * If you want to create a domain participant with different QoS,
         * use DomainParticipantFactory.get_default_participant_qos
         * to obtain a copy of the default participant QoS, change them,
         * then use them instead of PARTICIPANT_QOS_DEFAULT:
         *
            DomainParticipantQos myQos = new DomainParticipantQos();
            DomainParticipantFactory.get_instance().get_default_participant_qos(myQos);

            // Modify the participant QoS here

            // Then create the domain participant using 'myQos' instead of
            //     DomainParticipantFactory.PARTICIPANT_QOS_DEFAULT
            
         *
         * Note: for more info on the domain participant API see:
         *     $NDDSHOME/doc/html/api_java/group__DDSDomainParticipantModule.html
         */
        if (arg.verbose > 1) {
            logger.info("Creating domain participant...");
        }
        DomainParticipant participant = 
                        DomainParticipantFactory.get_instance().create_participant(
                            arg.domainId,
                            DomainParticipantFactory.PARTICIPANT_QOS_DEFAULT,
                            null,       // listener
                            StatusKind.STATUS_MASK_NONE);
        if (participant == null) {
            logger.severe("! Unable to create DDS domain participant");
            System.exit(-1);
        }
                

        /* Registers the type used in this example with the domain participant.
         * For more information on user-defined data types:
         *     $NDDSHOME/doc/html/api_java/group__DDSUserDataModule.html
         */
        if (arg.verbose > 0) {
            logger.info("Registering the type...");
        }
        HelloWorldTypeSupport.register_type(participant, 
                        HelloWorldTypeSupport.get_type_name());

        
        /* Creates the topic.
         * The following command will create the topic without
         * installing any status callback listener.
         * If you want to create a topic with different QoS,
         * use DomainParticipant.get_default_topic_qos
         * to obtain a copy of the default topic QoS, change them,
         * then use them instead of TOPIC_QOS_DEFAULT:
         *
            TopicQos myQos = new TopicQos();
            participant.get_default_topic_qos(myQos);
            
            // Modify the topic QoS here

            // Then create the topic using 'myQos'...
         *
         * Note: for more info on the topic API see:
         *     $NDDSHOME/doc/html/api_c/group__DDSTopicEntityModule.html
         */
        if (arg.verbose > 0) {
            logger.info("Creating the topic...");
        }
        Topic topic = participant.create_topic(
                        arg.topicName,
                        HelloWorldTypeSupport.get_type_name(), 
                        DomainParticipant.TOPIC_QOS_DEFAULT,
                        null,   // listener
                        StatusKind.STATUS_MASK_NONE);
        if (topic == null) {
            logger.severe("! Unable to create topic " + arg.topicName);
            System.exit(-1);
        }           
        

        /* Creates the publisher or subscriber */
        if (arg.mode == CommandLineArguments.APP_MODE_PUBLISHER) {
            HelloPublisher publisher = new HelloPublisher(
                            participant, 
                            topic,
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

        /* Shutdown, when sampleCount is finite */
        if(participant != null) {
            participant.delete_contained_entities();

            DomainParticipantFactory.TheParticipantFactory.
                delete_participant(participant);
        }
        
        // this is a normal shutdown and since we finalize the factory instance
        // below, we need to delete the Distributed Logger first.
        DistLogger.delete();
        
        DomainParticipantFactory.finalize_instance();
    }
    
    /**************************************************************************
     * Prints on stdout brief instructions on command-line arguments accepted.
     * 
     */
    public static void usage() {
        StringBuilder buffer = new StringBuilder();
        buffer.append("Usage:\n");
        buffer.append("    Hello pub [arguments]     Run as publisher\n");
        buffer.append("    Hello sub [arguments]     Run as subscriber\n");
        buffer.append("Where arguments are:");
        buffer.append("  -h | --help                 " +
                        "Shows this page\n");
        buffer.append("  -v | --verbose              " +
                        "Increase output verbosity (can be repeated)\n");
        buffer.append("  -d | --domain <domainID>    " +
                        "Sets the DDS domain ID [default=" + 
                        Integer.toString(CommandLineArguments.DEFAULT_DOMAIN_ID) + "]\n");
        buffer.append("  -t | --topic <name>         " +
                        "Sets topic name [default=" + 
                        CommandLineArguments.DEFAULT_TOPIC_NAME + "]\n");
        buffer.append("  -s | --size <num>           " +
                        "Sets payload size in bytes [default=" +
                        Integer.toString(CommandLineArguments.DEFAULT_PAYLOAD) + "]\n");
        buffer.append("  -c | --sampleCount <num>    " +
                        "Sets number of samples to send/receive [default=0(UNLIMITED)]\n");
        buffer.append("\n");
        logger.info(buffer.toString());
    }
    
    
    /**************************************************************************
     * A simple function used to check if there are enough command line args
     */
    static boolean ensureOneMoreArgument(int i, String [] args, String argName) {
        if (i+1 > args.length) {
            usage();
            logger.severe("! Error: missing value for " + argName +
                        " argument");
            return false;
        }
        return true;
    }

    /**************************************************************************
     * Application main entry point
     * @param argv      array of strings containing the command-line arguments
     */
    public static void main(String[] argv) {
        CommandLineArguments args = new CommandLineArguments();
        
        logger.info("Hello Example Application");
        logger.info("Copyright 2008 Real-Time Innovations, Inc.\n");
        if (argv.length == 0) {
            usage();
            logger.severe("! Invalid number of arguments.\n" +
                        "! You must specify at least running mode (pub/sub)");
            System.exit(-1);
        }
        
        // Parse the command: pub or sub
        if (argv[0].equalsIgnoreCase("pub")) {
            args.mode = CommandLineArguments.APP_MODE_PUBLISHER;
        } else if (argv[0].equalsIgnoreCase("sub")) {
            args.mode = CommandLineArguments.APP_MODE_SUBSCRIBER;
        } else if (argv[0].equals("-h") || argv[0].equals("--help")) {
            usage();
            System.exit(-1);
        } else {
            usage();
            logger.severe("! Invalid mode: " + argv[0]);
            logger.severe("! Valid modes are only 'pub' or 'sub'.");
            System.exit(-1);
        }
        
        // Parse the rest of the arguments
        for (int i = 1; i < argv.length; ++i) { 
            if (argv[i].equals("-h") || argv[i].equals("--help")) {
                usage();
                System.exit(-1);
            }
            
            if (argv[i].equals("-v") || argv[i].equals("--verbose")) {
                ++args.verbose;
                continue;
            }
            
            if (argv[i].equals("-d") || argv[i].equals("--domain")) {
                if (!ensureOneMoreArgument(i, argv, "--domain")) {
                    System.exit(-1);
                }
                args.domainId = Integer.parseInt(argv[++i]);
                if (args.domainId < 0 || 
                    args.domainId > CommandLineArguments.DOMAIN_ID_MAX) {
                    usage();
                    logger.severe("! Invalid DDS Domain ID:" +
                        Integer.toString(args.domainId));
                    logger.severe("! The domain ID must be between 0 and " +
                        Integer.toString(CommandLineArguments.DOMAIN_ID_MAX) +
                        " (inclusive)");
                    System.exit(-1);
                }
                continue;
            }
            
            if (argv[i].equals("-s") || argv[i].equals("--size")) {
                if (!ensureOneMoreArgument(i, argv, "--size")) {
                    System.exit(-1);
                }
                args.dataSize = Integer.parseInt(argv[++i]);
                if (args.dataSize <= 0) {
                    usage();
                    logger.severe("! Invalid value for --size argument: " +
                        Integer.toString(args.dataSize));
                    System.exit(-1);
                }
                if (args.dataSize > HELLODDS_MAX_PAYLOAD_SIZE.VALUE) {
                    usage();
                    logger.severe("! Invalid value for --size argument: " +
                        Integer.toString(args.dataSize) + 
                        " data too big (max value is " +
                        Integer.toString(HELLODDS_MAX_PAYLOAD_SIZE.VALUE) +
                        ")");
                }
                continue;
            }
            
            if (argv[i].equals("-t") || argv[i].equals("--topic")) {
                if (!ensureOneMoreArgument(i, argv, "--topic")) {
                    System.exit(-1);
                }
                args.topicName = argv[++i];
                continue;
            }

            if (argv[i].equals("-c") || argv[i].equals("--sampleCount")) {
                if (!ensureOneMoreArgument(i, argv, "--sampleCount")) {
                    System.exit(-1);
                }
                args.sampleCount = Integer.parseInt(argv[++i]);
                if (args.sampleCount < 0) {
                    usage();
                    logger.severe("! Invalid value for --sampleCount argument: " +
                        Integer.toString(args.dataSize));
                    System.exit(-1);
                }
                continue;
            }
            
            // Else, is an invalid argument
            usage();
            logger.severe("! Unknown argument: " + argv[i]);
            System.exit(-1);
        }
        
        if (args.verbose > 0) {
            Version rtiddsVersion = Version.get_instance();
            ProductVersion_t prodVersion = rtiddsVersion.get_product_version();

            logger.info("Running with the following arguments:");
            logger.info("    Verbosity level.. : " + 
                        Integer.toString(args.verbose));
            logger.info("    Payload size..... : " + 
                        Integer.toString(args.dataSize));
            logger.info("    Sample count..... : " + 
                        Integer.toString(args.sampleCount));
            logger.info("    Domain ID........ : " +
                        Integer.toString(args.domainId));
            logger.info("    Topic name....... : " + args.topicName);
            logger.info("RTI Product Version.. : " +
                        Integer.toString(prodVersion.major) + "." +
                        Integer.toString(prodVersion.minor) +
                        Character.toString(prodVersion.release) + "(rev " +
                        Integer.toString(prodVersion.revision) + ")");
        }
        /* If the verbosity is bigger than 1, also turn on RTI DDS status logging
         * For more info, see: 
         *      $NDDSHOME/doc/html/api_java/group__NDDSConfigModule.html
         */
        if (args.verbose > 1) {
            Logger logger = Logger.get_instance();
            
            logger.set_verbosity_by_category(
                        LogCategory.NDDS_CONFIG_LOG_CATEGORY_API,
                        LogVerbosity.NDDS_CONFIG_LOG_VERBOSITY_STATUS_ALL);
        }
        
        // Finally start the application
        startApplication(args);
        logger.info("Done.");
    }

}
