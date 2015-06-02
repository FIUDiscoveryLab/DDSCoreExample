// ****************************************************************************
//         (c) Copyright, Real-Time Innovations, All rights reserved.       
//                                                                          
//         Permission to modify and use for internal purposes granted.      
// This software is provided "as is", without warranty, express or implied. 
//                                                                          
// ****************************************************************************

package com.rti.hello.builtin;

import java.io.File;

import com.rti.dds.domain.DomainParticipant;
import com.rti.dds.domain.DomainParticipantFactory;
import com.rti.dds.infrastructure.ProductVersion_t;
import com.rti.dds.infrastructure.StatusKind;
import com.rti.dds.topic.Topic;
import com.rti.dds.type.builtin.StringTypeSupport;
import com.rti.ndds.config.LogCategory;
import com.rti.ndds.config.LogVerbosity;
import com.rti.ndds.config.Logger;
import com.rti.ndds.config.Version;


// ****************************************************************************
/**
 * A container for the running options (defined through the command-line 
 * arguments)
 */
class CommandLineArguments {
    // A set of constants used in this class
    static final String APPLICATION_NAME = "Hello";
    static final int    DEFAULT_PAYLOAD = 1023;
    static final int    MAX_PAYLOAD = 1023;
    static final int    MIN_PAYLOAD = 10;
    static final int    DEFAULT_DOMAIN_ID = 0;
    static final String DEFAULT_TOPIC_NAME = "Hello Builtin";

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
        verbose = 0;
        sampleCount = 0;
        topicName = DEFAULT_TOPIC_NAME;
    }
}





// ****************************************************************************
/**
 * The main class contains only static methods. It contains the main entry
 * method and delegates the pub/sub to the other classes.
 */
public class Hello {
    

    /**************************************************************************
     * Creates the DDS Domain Participant, then delegates the execution to the
     * correct pub/sub function.
     * If entity creation is successful, this function does not return. 
     */
    private static void startApplication(final CommandLineArguments arg) {
        System.out.println("# The output below depends on the QoS profile"); 
        System.out.println("# provided to this application.");
        System.out.println("# -> For more information on the provided example");
        System.out.println("#    profiles, please see the Getting Started Guide.");
        System.out.println("# -> For detailed product performance metrics, visit");
        System.out.println("#    http://www.rti.com/products/data_distribution/index.html");
        System.out.println("#    and click on Benchmarks.\n");
        
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
                System.out.println("! Warning:");
                System.out.println("! Java "+version+" cannot determine if the"); 
                System.out.println("! environment variable NDDS_QOS_PROFILES is set.");
                System.out.println("! If not set, the application will use the ");
                System.out.println("! DDS default QoS.");
                System.out.println("! If you want to use different QoS, make sure you have the " +
                                   "QoS definition file");
                System.out.println("! (USER_QOS_PROFILES.xml) in the current working directory");
                System.out.println("! or set the environment variable NDDS_QOS_PROFILES to");
                System.out.println("! point to a file containing the default QoS profile");
            } else {
                String envVal = System.getenv("NDDS_QOS_PROFILES");
                if (envVal == null || !new File(envVal).exists()) {
                    System.out.println("! Warning:");
                    System.out.println("! Default QoS profile definition file not found.");
                    System.out.println("! The application will use the DDS default QoS.");
                    System.out.println("! If you want to use different QoS, make sure you have the " +
                                "QoS definition file");
                    System.out.println("! (USER_QOS_PROFILES.xml) in the current working directory");
                    System.out.println("! or set the environment variable NDDS_QOS_PROFILES to");
                    System.out.println("! point to a file containing the default QoS profile");
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
            System.err.println("An error occurred while changing factory QoS: " 
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
            System.out.println("Creating domain participant...");
        }
        DomainParticipant participant = 
                        DomainParticipantFactory.get_instance().create_participant(
                            arg.domainId,
                            DomainParticipantFactory.PARTICIPANT_QOS_DEFAULT,
                            null,       // listener
                            StatusKind.STATUS_MASK_NONE);
        if (participant == null) {
            System.err.println("! Unable to create DDS domain participant");
            return;
        }        
        
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
            System.out.println("Creating the topic...");
        }
        Topic topic = participant.create_topic(
                        arg.topicName,
                        StringTypeSupport.get_type_name(), 
                        DomainParticipant.TOPIC_QOS_DEFAULT,
                        null,   // listener
                        StatusKind.STATUS_MASK_NONE);
        if (topic == null) {
            System.err.println("! Unable to create topic " + arg.topicName);
            return;
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
        DomainParticipantFactory.finalize_instance();
    }
    
    /**************************************************************************
     * Prints on stdout brief instructions on command-line arguments accepted.
     * 
     */
    public static void usage() {
        System.out.println("Usage:");
        System.out.println("    Hello pub [arguments]     Run as publisher");
        System.out.println("    Hello sub [arguments]     Run as subscriber");
        System.out.println("Where arguments are:");
        System.out.println("  -h | --help                 " +
                        "Shows this page");
        System.out.println("  -v | --verbose              " +
                        "Increase output verbosity (can be repeated)");
        System.out.println("  -d | --domain <domainID>    " +
                        "Sets the DDS domain ID [default=" + 
                        Integer.toString(CommandLineArguments.DEFAULT_DOMAIN_ID) + "]");
        System.out.println("  -t | --topic <name>         " +
                        "Sets topic name [default=" + 
                        CommandLineArguments.DEFAULT_TOPIC_NAME + "]");
        System.out.println("  -s | --size <num>           " +
                        "Sets payload size in bytes [default=" +
                        Integer.toString(CommandLineArguments.DEFAULT_PAYLOAD) + "]");
        System.out.println("  -c | --sampleCount <num>    " +
                        "Sets number of samples to send/receive [default=0(UNLIMITED)]");
        System.out.println("");
    }
    
    
    /**************************************************************************
     * A simple function used to check if there are enough command line args
     */
    static boolean ensureOneMoreArgument(int i, String [] args, String argName) {
        if (i+1 > args.length) {
            usage();
            System.out.println("! Error: missing value for " + argName +
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
        
        System.out.println("Hello Example Application");
        System.out.println("Copyright 2008 Real-Time Innovations, Inc.\n");
        if (argv.length == 0) {
            usage();
            System.err.println("! Invalid number of arguments.\n" +
                        "! You must specify at least running mode (pub/sub)");
            return;
        }
        
        // Parse the command: pub or sub
        if (argv[0].equalsIgnoreCase("pub")) {
            args.mode = CommandLineArguments.APP_MODE_PUBLISHER;
        } else if (argv[0].equalsIgnoreCase("sub")) {
            args.mode = CommandLineArguments.APP_MODE_SUBSCRIBER;
        } else if (argv[0].equals("-h") || argv[0].equals("--help")) {
            usage();
            return;
        } else {
            usage();
            System.err.println("! Invalid mode: " + argv[0]);
            System.err.println("! Valid modes are only 'pub' or 'sub'.");
            return;
        }
        
        // Parse the rest of the arguments
        for (int i = 1; i < argv.length; ++i) { 
            if (argv[i].equals("-h") || argv[i].equals("--help")) {
                usage();
                return;
            }
            
            if (argv[i].equals("-v") || argv[i].equals("--verbose")) {
                ++args.verbose;
                continue;
            }
            
            if (argv[i].equals("-d") || argv[i].equals("--domain")) {
                if (!ensureOneMoreArgument(i, argv, "--domain")) {
                    return;
                }
                args.domainId = Integer.parseInt(argv[++i]);
                if (args.domainId < 0 || 
                    args.domainId > CommandLineArguments.DOMAIN_ID_MAX) {
                    usage();
                    System.err.println("! Invalid DDS Domain ID:" +
                        Integer.toString(args.domainId));
                    System.err.println("! The domain ID must be between 0 and " +
                        Integer.toString(CommandLineArguments.DOMAIN_ID_MAX) +
                        " (inclusive)");
                    return;
                }
                continue;
            }
            
            if (argv[i].equals("-s") || argv[i].equals("--size")) {
                if (!ensureOneMoreArgument(i, argv, "--size")) {
                    return;
                }
                args.dataSize = Integer.parseInt(argv[++i]);
                if (args.dataSize <= 0) {
                    usage();
                    System.err.println("! Invalid value for --size argument: " +
                        Integer.toString(args.dataSize));
                    return;
                }
                if (args.dataSize > CommandLineArguments.MAX_PAYLOAD) {
                    usage();
                    System.err.println("! Value too big for --size argument: " +
                        Integer.toString(args.dataSize));
                    System.err.println("! For built-in types, the default max "+ 
                        "string size is set to " +
                        Integer.toString(CommandLineArguments.MAX_PAYLOAD));
                    System.err.println("! See manual on built-in types for "+ 
                        "more information.");
                    return;
                }
                if (args.dataSize < CommandLineArguments.MIN_PAYLOAD) {
                    usage();
                    System.err.println("! Value too small for --size argument: " +
                        Integer.toString(args.dataSize));
                    System.err.println("! For this example, the size of the " +
                        "string cannot be smaller than " +
                        Integer.toString(CommandLineArguments.MIN_PAYLOAD));
                    return;
                }
                continue;
            }
            
            if (argv[i].equals("-t") || argv[i].equals("--topic")) {
                if (!ensureOneMoreArgument(i, argv, "--topic")) {
                    return;
                }
                args.topicName = argv[++i];
                continue;
            }

            if (argv[i].equals("-c") || argv[i].equals("--sampleCount")) {
                if (!ensureOneMoreArgument(i, argv, "--sampleCount")) {
                    return;
                }
                args.sampleCount = Integer.parseInt(argv[++i]);
                if (args.sampleCount < 0) {
                    usage();
                    System.err.println("! Invalid value for --sampleCount argument: " +
                        Integer.toString(args.dataSize));
                    return;
                }
                continue;
            }
            
            // Else, is an invalid argument
            usage();
            System.err.println("! Unknown argument: " + argv[i]);
            return;
        }
        
        if (args.verbose > 0) {
            Version rtiddsVersion = Version.get_instance();
            ProductVersion_t prodVersion = rtiddsVersion.get_product_version();

            System.out.println("Running with the following arguments:");
            System.out.println("    Verbosity level.. : " + 
                        Integer.toString(args.verbose));
            System.out.println("    Payload size..... : " + 
                        Integer.toString(args.dataSize));
            System.out.println("    Sample count..... : " + 
                        Integer.toString(args.sampleCount));
            System.out.println("    Domain ID........ : " +
                        Integer.toString(args.domainId));
            System.out.println("    Topic name....... : " + args.topicName);
            System.out.println("RTI Product Version.. : " +
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
        System.out.println("Done.");
    }

}
