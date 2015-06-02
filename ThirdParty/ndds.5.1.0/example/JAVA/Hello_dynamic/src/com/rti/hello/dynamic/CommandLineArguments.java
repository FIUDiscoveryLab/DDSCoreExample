// ****************************************************************************
//         (c) Copyright, Real-Time Innovations, All rights reserved.       
//                                                                          
//         Permission to modify and use for internal purposes granted.      
// This software is provided "as is", without warranty, express or implied. 
//                                                                          
// ****************************************************************************

package com.rti.hello.dynamic;

/**
 * A container for the running options (defined through the command-line 
 * arguments)
 */
class CommandLineArguments {
    // A set of constants used in this class
    static final String APPLICATION_NAME = "Hello";
    static final int    DEFAULT_PAYLOAD = 1023;
    static final int    MAX_PAYLOAD = 1023;
    static final int    DEFAULT_DOMAIN_ID = 0;
    static final String DEFAULT_TOPIC_NAME = "Hello Dynamic";

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

