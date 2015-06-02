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


public class StockNewsPublisher {
    // -----------------------------------------------------------------------
    // Public Methods
    // -----------------------------------------------------------------------
    
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
            MessageProducer producer = session.createProducer(topic);
            conn.start();
        
            // --- Write messages --- //
            BytesMessage instance = session.createBytesMessage();
            final long sendPeriodMillis = 4 * 1000; // 4 seconds
            for (int count = 0;
                 (messageCount == 0) || (count < messageCount);
                 ++count) {
                System.out.println("Sending Stock News, count " + count);
        
                instance.writeUTF("RTII");      // stock ticker symbol
                instance.writeUTF("http://www.rti.com");    // stock news URL
                instance.writeUTF("reuters");   // updated by
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
