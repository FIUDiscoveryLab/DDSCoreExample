// ****************************************************************************
//         (c) Copyright, Real-Time Innovations, All rights reserved.       
//                                                                          
//         Permission to modify and use for internal purposes granted.      
// This software is provided "as is", without warranty, express or implied. 
//                                                                          
// ****************************************************************************

package com.rti.hello.dynamic;


import com.rti.dds.domain.DomainParticipant;
import com.rti.dds.dynamicdata.DynamicData;
import com.rti.dds.dynamicdata.DynamicDataWriter;
import com.rti.dds.infrastructure.ByteSeq;
import com.rti.dds.infrastructure.InstanceHandle_t;
import com.rti.dds.infrastructure.RETCODE_ERROR;
import com.rti.dds.infrastructure.StatusKind;
import com.rti.dds.publication.Publisher;
import com.rti.dds.topic.Topic;
import com.rti.dds.typecode.TypeCode;


//****************************************************************************
/**
 * Manage the data publication for the Hello example 
 */
public class HelloPublisher {
    // Maximum consecutive write error after stopping the write process
    private static final int MAX_CONSECUTIVE_WRITE_ERROR = 5;
    
    private DynamicDataWriter   _theDataWriter;
    private int                 _theVerbose;
    private int                 _theSampleCount;
    private DynamicData         _theInstance;

    // ************************************************************************
    /**
     * Builds a new HelloPublisher object and initialize the inner DDS 
     * entities.
     * This method only creates the entities, but it does not actually write
     * the data.
     * To write the data, use the method run().
     *  
     * @param participant the DDS Domain participant
     * @param topic       the DDS topic 
     * @param verbose     an integer to control the output verbosity
     * @param dataSize    the size of the payload data
     */
    public HelloPublisher(DomainParticipant participant,
            Topic topic,
            TypeCode typeCode,
            int verbose,
            int dataSize,
            int sampleCount) {
        _theVerbose = verbose;
        _theSampleCount = sampleCount;
        
        // Creates the DDS Data writer. 
        // Just like before, if you want to customize the writer QoS,
        // use Publisher.get_default_datawriter_qos() to 
        // initialize a local copy of the default QoS, modify them, then
        // use them in the creation call below instead of 
        // DATAWRITER_QOS_DEFAULT.
        // For more data writer API info, see:
        //     $NDDSHOME/doc/html/api_c/group__DDSWriterModule.html
        //
        if (verbose > 0) {
            System.out.println("Creating the data writer...");
        }
        _theDataWriter = (DynamicDataWriter)
            participant.create_datawriter(topic,
                        Publisher.DATAWRITER_QOS_DEFAULT,
                        null,           // listener
                        StatusKind.STATUS_MASK_NONE);
        if (_theDataWriter == null) {
            System.err.println("! Unable to create DDS data writer\n");
            return;
        }
        
        /* Creates an instance of the sparse data we are about to send
         */
        _theInstance = new DynamicData(typeCode, DynamicData.PROPERTY_DEFAULT);
        
        /* The DynamicDataType has been defined (in HelloWorldType.cxx) to hold
         * a structure like the following one:
         * struct HelloWorld {
         *     string<64>            prefix;
         *     long                  sampleId;
         *     sequence<octet, 8192> payload;
         * };
         */
        _theInstance.set_string("prefix", 
                            DynamicData.MEMBER_ID_UNSPECIFIED, 
                            "Hello World!");
        _theInstance.set_int("sampleId", 
                            DynamicData.MEMBER_ID_UNSPECIFIED, 
                            0);
        byte [] payload = new byte[dataSize];
        for (int i = 0; i < dataSize; ++i) {
            payload[i] = (byte)(i % 0xff);
        }
        ByteSeq byteSeq = new ByteSeq(payload);
        _theInstance.set_byte_seq("payload",
                            DynamicData.MEMBER_ID_UNSPECIFIED, 
                            byteSeq);
    }
    
    // ************************************************************************
    /**
     * Writes samples to DDS. This method never returns.
     */
    void writeSamples() {
        InstanceHandle_t instance_handle = InstanceHandle_t.HANDLE_NIL;
        // For a data type that has a key, if the same instance is going to be
        // written multiple times, initialize the key here
        // and register the keyed instance prior to writing */
        //      instance_handle = writer.register_instance(instance);

        System.out.println("Sending data...\n");
        int consecutiveErrors = 0;
        for (int count = 0;; ++count) {
            _theInstance.set_int("sampleId",
                    DynamicData.MEMBER_ID_UNSPECIFIED,
                    count);
            try {
                _theDataWriter.write(_theInstance, instance_handle);
            } catch(RETCODE_ERROR e) {
                System.err.println("! Write error " + 
                        e.getClass().toString() + ": " + e.getMessage());
                if (++consecutiveErrors > MAX_CONSECUTIVE_WRITE_ERROR) {
                    System.out.println("! Reached maximum number of failure, " +
                        "stopping writer...");
                    return;
                }
            }
            // Always clear the error count in case of successful write
            consecutiveErrors = 0;
            if (_theVerbose > 0 && (count % 10000) == 0) {
                System.out.println("Sent " + 
                        Integer.toString(count) + 
                        " samples...");
            }
            if (_theSampleCount != 0 && (count >= _theSampleCount)) {
                System.out.println("\nSent " + 
                        Integer.toString(count) + 
                        " samples.");
                return;
            }
        }
    }
}
