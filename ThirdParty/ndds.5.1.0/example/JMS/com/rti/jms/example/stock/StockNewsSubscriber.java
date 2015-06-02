package com.rti.jms.example.stock;

import java.util.Date;
import java.util.Properties;

import javax.jms.BytesMessage;
import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.MessageListener;
import javax.jms.Session;
import javax.jms.Topic;
import javax.naming.Context;

import com.rti.naming.InitialContext;


public class StockNewsSubscriber {
    public static void main(String[] args) throws Exception {
        // --- Get max loop count; 0 means infinite loop --- //
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
        Properties prop = new Properties();
        prop.setProperty(Context.PROVIDER_URL, "ExampleQosConfig.xml");
        InitialContext ctx = new InitialContext(prop);
        
        // --- Create entities --- //
        ConnectionFactory factory = (ConnectionFactory) ctx.lookup(
                "stock/connectionFactory");
        Connection conn = factory.createConnection();
        try {
            Session session = conn.createSession(
                    false, Session.DUPS_OK_ACKNOWLEDGE);
            Topic topic = (Topic) ctx.lookup("stock/Example Stock News");
            MessageConsumer consumer = session.createConsumer(topic);

            consumer.setMessageListener(new MessageListener() {
                public void onMessage(Message message) {
                    System.out.println("Received: ");
                    if (message instanceof BytesMessage) {
                        try {
                            BytesMessage bytes = (BytesMessage) message;
                            System.out.println(
                                "    Symbol: " + bytes.readUTF());
                            System.out.println("    URL: " + bytes.readUTF());
                            System.out.println("    Updated By: " + bytes.readUTF());
                            System.out.println(
                                "    Time: " + new Date(bytes.readLong()));
                        } catch (JMSException jx) {
                            System.err.println("Error reading message:");
                            jx.printStackTrace();
                        }
                    } else {
                        System.out.println("    " + message);
                    }
                }
            });

            conn.start();

            // --- Wait for data --- //
            final long receivePeriodSec = 4;
            for (int count = 0;
                 (messageCount == 0) || (count < messageCount);
                 ++count) {
                System.out.println("Stock News subscriber sleeping for " +
                                   receivePeriodSec +
                                   " sec...");
                Thread.sleep(receivePeriodSec * 1000);  // in millisec
            }
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
    }
}
