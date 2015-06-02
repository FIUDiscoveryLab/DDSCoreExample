package com.rti.jms.example.stock;

import java.util.Properties;

import javax.jms.BytesMessage;
import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.Topic;
import javax.naming.Context;

import com.rti.naming.InitialContext;
import com.rti.naming.RTIContext;


public class StockPricePublisher {
    public static void main(String[] args) throws Exception {
        // --- Get max loop count; 0 means infinite loop --- //
        int messageCount = 0;
        if (args.length >= 1) {
            messageCount = Integer.valueOf(args[0]).intValue();
        }

        // --- Provider --- //
        String price_provider = "Message Board"; // Default provider
        if (args.length >= 2) {
            price_provider = args[1];
        }

        // --- Ownership strength --- //
        int ownership_strength = 0;
        if (args.length >= 3) {
            ownership_strength = Integer.valueOf(args[2]).intValue();
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
        prop.setProperty(
            RTIContext.QOS_FIELD_PREFIX +
                ":stock/Example Stock Price/producer_defaults/ownership_strength/value",
            String.valueOf(ownership_strength));
        InitialContext ctx = new InitialContext(prop);
        
        // --- Create entities --- //
        ConnectionFactory factory = (ConnectionFactory) ctx.lookup(
                "stock/connectionFactory");
        Connection conn = factory.createConnection();
        try {
            Session session = conn.createSession(
                    false, Session.DUPS_OK_ACKNOWLEDGE);
            Topic topic = (Topic) ctx.lookup("stock/Example Stock Price");
            MessageProducer producer = session.createProducer(topic); 
            conn.start();
        
            // --- Write messages --- //
            BytesMessage instance = session.createBytesMessage();
            final long sendPeriodMillis = 4 * 1000; // 4 seconds
            for (int count = 0;
                 (messageCount == 0) || (count < messageCount);
                 ++count) {
                System.out.println("Sending Stock Price, count " + count);

                instance.writeUTF("RTII");      // stock ticker symbol
                instance.writeDouble(32.0 + (0.1 * count)); // stock price
                instance.writeUTF(price_provider);          // updated by
                instance.writeLong(System.currentTimeMillis()); // date/time
                producer.send(instance);
                instance.clearBody();

                Thread.sleep(sendPeriodMillis);
            }
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
    }
}
