// ****************************************************************************
//         (c) Copyright, Real-Time Innovations, All rights reserved.       
//                                                                          
//         Permission to modify and use for internal purposes granted.      
// This software is provided "as is", without warranty, express or implied. 
//                                                                          
// ****************************************************************************

package com.rti.hello.idl;


import com.rti.dds.domain.DomainParticipant;
import com.rti.dds.domain.DomainParticipantFactory;
import com.rti.dds.infrastructure.InstanceHandle_t;
import com.rti.dds.infrastructure.RETCODE_ERROR;

public class HelloWorldPublisher {

    DomainParticipant participant;
    HelloWorldDataWriter helloWriter;
    HelloWorld instance;

    protected void dispose(){                 
        
        if (this.participant != null) {
            this.participant.delete_contained_entities();
            this.helloWriter = null;
            
            DomainParticipantFactory.get_instance().delete_participant(
                    this.participant);                
            }

            DomainParticipantFactory.finalize_instance();
    }

    public void publisherStart(
            int sampleCount) {

        DomainParticipantFactory.get_instance().register_type_support(               
                HelloWorldTypeSupport.get_instance(),
                "HelloWorldType");        /*
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

        if (this.helloWriter == null) {
            this.helloWriter = (HelloWorldDataWriter) this.participant.lookup_datawriter_by_name(
                    "MyPublisher::HelloWorldWriter");
            if (this.helloWriter == null) {
                System.out.println("! Unable to get DDS HelloWorldDataWriter data writer");
                return;
            }
        }

        if (this.instance == null) {
            this.instance = new HelloWorld();
        }

        /*
         * Main loop
         */
        for (int count = 0; (sampleCount == 0) || (count < sampleCount); ++count) {
            System.out.println("Writing HelloWorld, count: " + count);
            /*
             * Set the data fields
             */
            this.instance.sender = "John Smith";
            this.instance.message = "Hello World!";
            this.instance.count = count;

            try {
                this.helloWriter.write(
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

        HelloWorldPublisher publisher = new HelloWorldPublisher();
        publisher.publisherStart(sampleCount);
        publisher.dispose();
    }
}