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
        DDS.DynamicDataWriter dynamicWriter;
        DDS.DynamicData instance;

        public void Dispose()
        {
            if (this.dynamicWriter != null && instance != null)
            {
                this.dynamicWriter.delete_data(ref this.instance);
            }
            if (this.participant != null)
            {
                this.participant.delete_contained_entities();
                this.dynamicWriter = null;
                DDS.DomainParticipantFactory.get_instance().delete_participant(
                    ref this.participant);                
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
                this.participant = DDS.DomainParticipantFactory.get_instance().
                        create_participant_from_config(
                                        "MyParticipantLibrary::PublicationParticipant");
                if (this.participant == null)
                {
                    Console.Error.WriteLine("! Unable to create DDS domain participant");
                    return;
                }
            }                       

            if (this.dynamicWriter == null)
            {
                this.dynamicWriter = (DDS.DynamicDataWriter)
                        this.participant.lookup_datawriter_by_name(
                                                  "MyPublisher::HelloWorldWriter");
                if (this.dynamicWriter == null)
                {
                    Console.Error.WriteLine("! Unable to get DDS dynamic data writer");
                    return;
                }
            }

            if (this.instance == null)
            {
                this.instance = this.dynamicWriter.create_data(DDS.DynamicData.DYNAMIC_DATA_PROPERTY_DEFAULT);
                if (this.instance == null)
                {
                    Console.Error.WriteLine("! Unable to create DDS dynamic data instance");
                    return;
                } 
            }              
       
            /* Main loop */
            for (int count=0; (sampleCount == 0) || (count < sampleCount); ++count) 
            {
                Console.WriteLine("Writing HelloWorld, count: " + count);
                /* Set the data fields */
                this.instance.set_string(
                    "sender", 
                    DDS.DynamicData.MEMBER_ID_UNSPECIFIED,
                    "John Smith");
                this.instance.set_string("message", 
                                       DDS.DynamicData.MEMBER_ID_UNSPECIFIED, 
                                       "Hello World!");
                this.instance.set_int("count", 
                                       DDS.DynamicData.MEMBER_ID_UNSPECIFIED, 
                                       count);              
       
                try
                {
                    this.dynamicWriter.write(this.instance, ref DDS.InstanceHandle_t.HANDLE_NIL);
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
