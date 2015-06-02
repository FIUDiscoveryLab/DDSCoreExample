/* ****************************************************************************
 *         (c) Copyright, Real-Time Innovations, All rights reserved.       
 *                                                                          
 *         Permission to modify and use for internal purposes granted.      
 * This software is provided "as is", without warranty, express or implied. 
 *                                                                          
 * ****************************************************************************
 */

using System;
using System.Collections.Generic;
using System.Text;

namespace Hello
{
    /**
     * Manage the data publication for the Hello example 
     */
    class HelloPublisher
    {        
        DDS.DomainParticipant participant;
        HelloWorldDataWriter helloWriter;
        HelloWorld instance;

        public void Dispose()
        {
            
            if (this.participant != null)
            {
                this.participant.delete_contained_entities();
                this.helloWriter = null;
                DDS.DomainParticipantFactory.get_instance().delete_participant(
                    ref this.participant);                
            }

            if (instance != null) {
                HelloWorldTypeSupport.delete_data(instance);
                instance = null;
            }

            DDS.DomainParticipantFactory.finalize_instance();
        }

        public void publisherStart(
            int sampleCount) 
        { 
                       
            /* To customize QoS, use 
            the configuration file USER_QOS_PROFILES.xml */
            if (this.participant == null)
            {
                DDS.DomainParticipantFactory.get_instance().register_type_support(
                    HelloWorldTypeSupport.get_instance(),
                    "HelloWorldType");
                this.participant = DDS.DomainParticipantFactory.get_instance().
                        create_participant_from_config(
                                        "MyParticipantLibrary::PublicationParticipant");
                if (this.participant == null)
                {
                    Console.Error.WriteLine("! Unable to create DDS domain participant");
                    return;
                }
            }

            if (this.helloWriter == null)
            {
                this.helloWriter = (HelloWorldDataWriter)
                        this.participant.lookup_datawriter_by_name(
                                                  "MyPublisher::HelloWorldWriter");
                if (this.helloWriter == null)
                {
                    Console.Error.WriteLine("! Unable to get DDS HelloWorld writer");
                    return;
                }
            }

            if (this.instance == null)
            {
                this.instance = HelloWorldTypeSupport.create_data();
                if (this.instance == null)
                {
                    Console.Error.WriteLine("! Unable to create DDS HelloWorld instance");
                    return;
                } 
            }              
       
            /* Main loop */
            for (int count=0; (sampleCount == 0) || (count < sampleCount); ++count) 
            {
                Console.WriteLine("Writing HelloWorld, count: " + count);
                this.instance.sender = "John Smith";
                this.instance.message = "Hello World!";
                this.instance.count = count;
               
                try
                {
                    this.helloWriter.write(this.instance, ref DDS.InstanceHandle_t.HANDLE_NIL);
                }
                catch (DDS.Retcode_Error e)
                {
                    Console.Error.WriteLine("! Write error " +
                                e.GetType().ToString() + ": " + e.Message);
                    return;
                }

                System.Threading.Thread.Sleep(3000);
            }
        }

        public static void Main(string[] argv) 
        {

            int sampleCount = 0; // infinite loop

            if (argv.Length >= 1)
            {
                sampleCount = Int32.Parse(argv[0]);
            }

            HelloPublisher publisher = new HelloPublisher();            
            publisher.publisherStart(sampleCount);
            publisher.Dispose();
        }        
        
    }
}
