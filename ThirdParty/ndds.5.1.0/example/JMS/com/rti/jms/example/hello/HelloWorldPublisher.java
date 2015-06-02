package com.rti.jms.example.hello;

import java.util.Properties;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.jms.Topic;
import javax.naming.Context;

import com.rti.naming.InitialContext;


public class HelloWorldPublisher {
    // -----------------------------------------------------------------------
    // Public Methods
    // -----------------------------------------------------------------------
    
    public static void main(String[] args) throws Exception {
        // --- Get max loop count --- //
        /* Get the number of messages to publish from the command line.
         * Zero (0) means to publish forever (i.e., until this application is
         * killed).
         */
        int messageCount = 0;
        if (args.length >= 1) {
            messageCount = Integer.valueOf(args[0]).intValue();
        }

        // --- Turn on verbose logging --- //
        /*
        com.rti.management.Logger.setVerbosityByCategory(
                com.rti.management.Logger.Category.API,
                com.rti.management.Logger.Verbosity.STATUS_ALL);
        */

        // --- Create InitialContext --- //
        /* Point to the configuration file where the administered objects are
         * stored. The code won't run if that file isn't filled in.
         */
        Properties prop = new Properties();
        prop.setProperty(Context.PROVIDER_URL, "ExampleQosConfig.xml");
        InitialContext ctx = new InitialContext(prop);

        // --- Create messaging objects --- //
        /* Load the ConnectionFactory and Topic from the file, then use them
         * to create the Session and MessageProducer. 
         */
        ConnectionFactory factory = (ConnectionFactory) ctx.lookup(
                "hello/helloConnectionFactory");
        Connection conn = factory.createConnection();
        try {
            Session session = conn.createSession(
                    false, Session.DUPS_OK_ACKNOWLEDGE);
            Topic topic = (Topic) ctx.lookup("hello/helloTopic");
            MessageProducer producer = session.createProducer(topic);
            conn.start();

            // --- Publish messages --- //
            TextMessage instance = session.createTextMessage("Hello, World");
            final long sendPeriodMillis = 4 * 1000; // 4 seconds
            for (int count = 0;
                 (messageCount == 0) || (count < messageCount);
                 ++count) {
                System.out.println("Sending, count " + count);

                producer.send(instance);

                // Pause before sending the next message.
                Thread.sleep(sendPeriodMillis);
            }
        } finally {
            // Close down communication
            if (conn != null) {
                conn.close();
            }
        }
    }
}
