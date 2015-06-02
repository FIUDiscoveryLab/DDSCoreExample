package com.rti.dl.example;
/* $Id: DirectUsageExample.java,v 1.5 2013/11/19 12:21:18 sara Exp $

   (c) Copyright, Real-Time Innovations, $Date: 2013/11/19 12:21:18 $.
   All rights reserved.

   No duplications, whole or partial, manual or electronic, may be made
   without express written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
   
modification history:
--------------------- 
10a,05oct2011,krb  Added standard header.
=========================================================================== */



import com.rti.dl.DistLogger;
import com.rti.dl.Options;

/**
 * This class is an example of how to use the Application Logger directly.
 * @author RTI
 */
public class DirectUsageExample extends BaseExample {
        
    public DirectUsageExample() {
        // instantiate a logger using a domain id of 0
        Options options = new Options();
        options.setDomainId(0); //Change here the domain ID
        options.setApplicationKind("Direct Usage Example");
        
        // set the options before the logger gets instantiated
        DistLogger.setOptions(options);
    }
    
    public void run() {
        System.out.println("use Control-C to stop the application");
        // write out test messages forever
        int counter = 1;
        while(shouldRun) {
            // here we call the logger to log our messages...these messages will
            // be sent along on DDS
            String message = "test info message : " + counter;
            DistLogger.getInstance().info(message);
            DistLogger.getInstance().trace("test trace message : " + counter);
            DistLogger.getInstance().debug("test debug message : " + counter);
            DistLogger.getInstance().info("test info message : " + counter);
            DistLogger.getInstance().notice("test notice message : " + counter);
            DistLogger.getInstance().warning("test warning message : " + counter);
            DistLogger.getInstance().error("test error message : " + counter);
            DistLogger.getInstance().severe("test severe message : " + counter);
            DistLogger.getInstance().fatal("test fatal message : " + counter);
            
            // write out to the console so that someone running the application
            // has an idea that it is doing something :)
            System.out.println("wrote log message group : " + counter);
            
            counter++;
            try {
                sleep(3000);
            } catch(InterruptedException ie) {
                // not a problem
            }
        }
    }
    
    public static void main(String[] args) {
        new DirectUsageExample().start();
    }
}
