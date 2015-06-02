package com.rti.jms.example.hello;

import java.util.Properties;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.jms.Topic;
import javax.naming.Context;

import com.rti.naming.InitialContext;


public class HelloWorldSubscriber {
    public static void main(String[] args) throws Exception {
        // --- Get max loop count --- //
        /* Get the number of messages to receive from the command line.
         * Zero (0) means to receive forever (i.e., until this application is
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
         * to create the Session and MessageConsumer. 
         */
        ConnectionFactory factory = (ConnectionFactory) ctx.lookup(
                "hello/helloConnectionFactory");
        Connection conn = factory.createConnection();
        try {
            Session session = conn.createSession(
                    false, Session.DUPS_OK_ACKNOWLEDGE);
            Topic topic = (Topic) ctx.lookup("hello/helloTopic");
            MessageConsumer consumer = session.createConsumer(topic);
            conn.start();

            // --- Receive messages --- //
            for (int count = 0;
                 (messageCount == 0) || (count < messageCount);
                 ++count) {
                Message message = consumer.receive();

                System.out.println("Received: ");
                if (message instanceof TextMessage) {
                    // Expected:
                    TextMessage txt = (TextMessage) message;
                    System.out.println("    Text: " + txt.getText());
                } else {
                    // Unexpected:
                    System.out.println("    " + message);
                }
            }
        } finally {
            // Close down communication
            if (conn != null) {
                conn.close();
            }
        }
    }
}
