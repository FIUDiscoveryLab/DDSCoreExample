// ****************************************************************************
//         (c) Copyright, Real-Time Innovations, All rights reserved.       
//                                                                          
//         Permission to modify and use for internal purposes granted.      
// This software is provided "as is", without warranty, express or implied. 
//                                                                          
// ****************************************************************************

package com.rti.hello.dynamic;


import com.rti.dds.domain.DomainParticipant;
import com.rti.dds.domain.DomainParticipantFactory;
import com.rti.dds.dynamicdata.DynamicData;
import com.rti.dds.dynamicdata.DynamicDataWriter;
import com.rti.dds.infrastructure.InstanceHandle_t;
import com.rti.dds.infrastructure.RETCODE_ERROR;


public class HelloPublisher {

    DomainParticipant participant;
    DynamicDataWriter dynamicWriter;
    DynamicData instance;

    protected void dispose() {                
        
        if (this.dynamicWriter != null && instance != null) {                      
            this.dynamicWriter.delete_data(this.instance);
        }            
        
        if (this.participant != null) {
            this.participant.delete_contained_entities();
            this.dynamicWriter = null;
            
            DomainParticipantFactory.get_instance().delete_participant(
                    this.participant);                
        }

        DomainParticipantFactory.finalize_instance();
    }

    public void publisherStart(
            int sampleCount) {

        /*
         * To customize QoS, use the configuration file USER_QOS_PROFILES.xml
         */
        if (this.participant == null) {
            this.participant = DomainParticipantFactory.get_instance().
                    create_participant_from_config(
                    "MyParticipantLibrary::PublicationParticipant");
            if (this.participant == null) {
                System.out.println("! Unable to create DDS domain participant");
                return;
            }
        }

        if (this.dynamicWriter == null) {
            this.dynamicWriter = (DynamicDataWriter) this.participant.lookup_datawriter_by_name(
                    "MyPublisher::HelloWorldWriter");
            if (this.dynamicWriter == null) {
                System.out.println("! Unable to get DDS dynamic data writer");
                return;
            }
        }

        if (this.instance == null) {
            this.instance = this.dynamicWriter.create_data(DynamicData.PROPERTY_DEFAULT);
            if (this.instance == null) {
                System.out.println("! Unable to create DDS dynamic data instance");
                return;
            }
        }

        /*
         * Main loop
         */
        for (int count = 0; (sampleCount == 0) || (count < sampleCount); ++count) {
            System.out.println("Writing HelloWorld, count: " + count);
            /*
             * Set the data fields
             */
            this.instance.set_string(
                    "sender",
                    DynamicData.MEMBER_ID_UNSPECIFIED,
                    "John Smith");
            this.instance.set_string("message",
                    DynamicData.MEMBER_ID_UNSPECIFIED,
                    "Hello World!");
            this.instance.set_int("count",
                    DynamicData.MEMBER_ID_UNSPECIFIED,
                    count);

            try {
                this.dynamicWriter.write(
                        this.instance, 
                        InstanceHandle_t.HANDLE_NIL);
                Thread.sleep(3000);
            }
            catch (RETCODE_ERROR e) {
                System.out.println("! Write error:"
                        + e.getMessage());
                return;
            }
            catch (InterruptedException e) {
                e.printStackTrace();
                return;
            }

        }
    }

    public static void main(String[] argv) {
        int sampleCount = 0; // infinite loop

        if (argv.length >= 1) {
            sampleCount = Integer.parseInt(argv[0]);
        }

        HelloPublisher publisher = new HelloPublisher();
        publisher.publisherStart(sampleCount);
        publisher.dispose();
    }
}
