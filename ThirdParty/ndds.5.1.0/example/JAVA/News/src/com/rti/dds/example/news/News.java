// ***************************************************************************
//         (c) Copyright, Real-Time Innovations, All rights reserved.
//
//         Permission to modify and use for internal purposes granted.
// This software is provided "as is", without warranty, express or implied.
//
// ***************************************************************************

package com.rti.dds.example.news;

import java.io.File;
import java.text.MessageFormat;

import com.rti.dds.domain.DomainParticipant;
import com.rti.dds.domain.DomainParticipantFactory;
import com.rti.dds.infrastructure.ProductVersion_t;
import com.rti.dds.infrastructure.StatusKind;
import com.rti.dds.topic.Topic;
import com.rti.dds.type.builtin.KeyedStringTypeSupport;
import com.rti.ndds.config.LogCategory;
import com.rti.ndds.config.LogVerbosity;
import com.rti.ndds.config.Logger;
import com.rti.ndds.config.Version;


// ***************************************************************************

/**
 * The News example implements a simple application: a variety of news
 * outlets publish articles at different rates, and subscribers consume the
 * data based on different criteria. It demonstrates several important design
 * patterns.
 * 
 * This class, the main class, contains only static methods. It contains the
 * main entry method and delegates the pub/sub to the other classes.
 */
public class News {
    // -----------------------------------------------------------------------
    // Constants
    // -----------------------------------------------------------------------

    /**
     * Both the publisher(s) and the subscriber(s) will print out their
     * status after this many milliseconds.
     */
    /*package*/ static final int STATUS_PERIOD_MILLIS = 2 * 1000;


    private static final String TOPIC_NAME = "News Example";



    // -----------------------------------------------------------------------
    // Main Method
    // -----------------------------------------------------------------------

    /**
     * Application main entry point.
     * 
     * @param argv      array of strings containing the command-line arguments
     */
    public static void main(String[] argv) {
        System.out.println("RTI News Example");
        System.out.println("Copyright 2009 Real-Time Innovations, Inc.\n");
        
        try {
            CommandLineArguments args = CommandLineArguments.parseArguments(
                    argv);
            if (args == null) {
                return;
            }

            if (args.verbose > 0) {
                printProductInformation(args);
            }
            /* If the verbosity is greater than 1, also turn on RTI status
             * logging.
             */
            if (args.verbose > 1) {
                Logger.get_instance().set_verbosity_by_category(
                        LogCategory.NDDS_CONFIG_LOG_CATEGORY_API,
                        LogVerbosity.NDDS_CONFIG_LOG_VERBOSITY_STATUS_ALL);
            }
            
            // Start the application
            startApplication(args);
            System.out.println("Done.");
        } catch (CommandLineArguments.ArgumentParseException apx) {
            // do nothing; just return
        }
    }



    // -----------------------------------------------------------------------
    // Private Methods
    // -----------------------------------------------------------------------

    /**
     * Creates the DDS Domain Participant then delegates the execution to the
     * correct pub/sub method.
     */
    private static void startApplication(CommandLineArguments arg) {
        /* This example creates DDS entities using the default QoS loaded
         * from the file USER_QOS_PROFILES.xml in the current working
         * directory.
         */
        if (!new File("USER_QOS_PROFILES.xml").exists()) {
            System.err.println("! Unable to locate QoS definition file");
            System.err.println("! (USER_QOS_PROFILES.xml) in current directory.");
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
            System.out.println("Creating DomainParticipant...");
        }
        DomainParticipant participant = factory.create_participant(
                arg.domainId,
                DomainParticipantFactory.PARTICIPANT_QOS_DEFAULT,
                null,                           // no listener
                StatusKind.STATUS_MASK_NONE);   // no listener callbacks
        if (participant == null) {
            System.err.println("! Unable to create DomainParticipant");
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
                System.out.println("Creating the Topic...");
            }
            Topic topic = participant.create_topic(
                    TOPIC_NAME,
                    KeyedStringTypeSupport.get_type_name(), 
                    DomainParticipant.TOPIC_QOS_DEFAULT,
                    null,                           // no listener
                    StatusKind.STATUS_MASK_NONE);   // no listener callbacks
            if (topic == null) {
                System.err.println("! Unable to create Topic");
                return;
            }

            // --- Start Publishing or Subscribing Application --- //
            if (arg.mode == CommandLineArguments.APP_MODE_PUBLISHER) {
                NewsPublisher publisher = new NewsPublisher(
                        participant, 
                        topic,
                        arg.verbose,
                        arg.runSeconds);
                publisher.publish();
            } else {
                NewsSubscriber subscriber = new NewsSubscriber(
                        participant, 
                        topic,
                        arg.verbose,
                        arg.runSeconds,
                        arg.contentFilter);
                subscriber.readArticles();
            }
        } finally {
            // --- Shutdown --- //
            if (participant != null) {
                participant.delete_contained_entities();
                factory.delete_participant(participant);
            }
            DomainParticipantFactory.finalize_instance();
        }
    }


    private static void printProductInformation(CommandLineArguments args) {
        Version rtiddsVersion = Version.get_instance();
        ProductVersion_t prodVersion = rtiddsVersion.get_product_version();

        System.out.println("Running with the following arguments:");
        System.out.println("    Verbosity level.. : " + args.verbose);
        System.out.println("    Domain ID........ : " + args.domainId);
        System.out.println("    Seconds to run... : " + args.runSeconds);
        System.out.println("    Content filter... : " + args.contentFilter);
        System.out.println("RTI Product Version.. : " +
                           (int) prodVersion.major + "." +
                           (int) prodVersion.minor +
                           prodVersion.release + " (rev " +
                           (int) prodVersion.revision + ")");
    }



    // -----------------------------------------------------------------------
    // Types
    // -----------------------------------------------------------------------

    // =======================================================================

    /**
     * A helper class that formats the news outlet name together with the
     * article text for output to the terminal.
     */
    /*package*/ static class Article {
        // --- Private fields: -----------------------------------------------
        private static final int MIN_NAME_WIDTH = 10;
        
        private final String _stringified;

        // --- Public methods: -----------------------------------------------
        public Article(String newsOutletName, String articleText) {
            /* For formatting purposes, make sure all of the news outlet
             * names are padded to the same width.
             */
            StringBuffer outletNameBuf = new StringBuffer(newsOutletName);
            for (int i = newsOutletName.length(); i < MIN_NAME_WIDTH; ++i) {
                outletNameBuf.append(' ');
            }
            newsOutletName = outletNameBuf.toString();

            _stringified = MessageFormat.format(
                    "From {0}: \"{1}\"",
                    new Object[] { newsOutletName, articleText });
        }

        public String toString() {
            return _stringified;
        }
    }

}
