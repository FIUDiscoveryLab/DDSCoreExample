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
using System.Threading;

namespace Hello
{
    /**
     * Manage the subscription for the data published in the Hello example 
     */
    class HelloSubscriber : DDS.DataReaderListener
    {
        DDS.DomainParticipant participant;
        HelloWorldDataReader helloReader;

        new public void Dispose()
        {
            if (this.participant != null)
            {
                this.participant.delete_contained_entities();
                this.helloReader = null;
                DDS.DomainParticipantFactory.get_instance().delete_participant(
                    ref this.participant);                
            }
            base.Dispose();
            DDS.DomainParticipantFactory.finalize_instance();
        }

        public void subscriberStart(
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
                                        "MyParticipantLibrary::SubscriptionParticipant");
                if (this.participant == null)
                {
                    Console.Error.WriteLine("! Unable to create DDS domain participant");
                    return;
                }
            }    

            if (this.helloReader == null)
            {
                this.helloReader = (HelloWorldDataReader)
                        this.participant.lookup_datareader_by_name(
                                                  "MySubscriber::HelloWorldReader");
                if (this.helloReader == null)
                {
                    Console.Error.WriteLine("! Unable to get DDS HelloWorld reader");
                    return;
                }
            }            

            /* set listener */
            try
            {
                this.helloReader.set_listener(this, DDS.StatusMask.STATUS_MASK_ALL);
            }
            catch (DDS.Retcode_Error e)
            {
                Console.Error.WriteLine("! Write error " +
                            e.GetType().ToString() + ": " + e.Message);
                return;
            }

            /* Main loop */
            int receivePeriod = 3;
            for (int count = 0; (sampleCount == 0) || (count < sampleCount); ++count)
            {
                Console.WriteLine("HelloWorld_subscriber: Sleeping for " + receivePeriod + " sec...");
                System.Threading.Thread.Sleep(receivePeriod * 1000);
            }
        }

        public override void on_data_available(DDS.DataReader reader)
        {
            HelloWorldDataReader helloWorldReader = (HelloWorldDataReader)reader;
            HelloWorldSeq dataSeq = new HelloWorldSeq();
            DDS.SampleInfoSeq infoSeq = new DDS.SampleInfoSeq();
            try
            {
                helloWorldReader.take(
                            dataSeq,
                            infoSeq,
                            DDS.ResourceLimitsQosPolicy.LENGTH_UNLIMITED,
                            DDS.SampleStateKind.ANY_SAMPLE_STATE,
                            DDS.ViewStateKind.ANY_VIEW_STATE,
                            DDS.InstanceStateKind.ANY_INSTANCE_STATE);
                for (int i = 0; i < dataSeq.length; ++i)
                {
                    DDS.SampleInfo info = infoSeq.get_at(i);
                    if (info.valid_data)
                    {
                        HelloWorldTypeSupport.print_data(dataSeq.get_at(i));
                    }
                    else
                    {
                        Console.WriteLine("! No valid data. Instance state: " + info.instance_state);
                    }
                }
             }
             finally
             {
                helloWorldReader.return_loan(dataSeq, infoSeq);
             }
        }

        public override void on_sample_lost(DDS.DataReader reader,
                                   ref DDS.SampleLostStatus status)
        {
            Console.WriteLine("->Callback: sample lost.");
        }

        public override void on_requested_deadline_missed(DDS.DataReader reader,
                                                 ref DDS.RequestedDeadlineMissedStatus status)
        {
            Console.WriteLine("->Callback: requested deadline missed.");
        }

        public override void on_requested_incompatible_qos(DDS.DataReader reader,
                                DDS.RequestedIncompatibleQosStatus status)
        {
            Console.WriteLine("->Callback: requested incompatible Qos.");
        }

        public override void on_sample_rejected(DDS.DataReader reader,
                               ref DDS.SampleRejectedStatus status)
        {
            Console.WriteLine("->Callback: sample rejected.");
        }

        public override void on_liveliness_changed(DDS.DataReader reader,
                                ref DDS.LivelinessChangedStatus status)
        {
            Console.WriteLine("->Callback: liveliness changed.");
        }

        public override void on_subscription_matched(DDS.DataReader reader,
                              ref DDS.SubscriptionMatchedStatus status)
        {
            Console.WriteLine("->Callback: subscription matched.");
        }

        public static void Main(string[] argv)
        {
            int sampleCount = 0; // infinite loop

            if (argv.Length >= 1)
            {
                sampleCount = Int32.Parse(argv[0]);
            }

            HelloSubscriber subscriber = new HelloSubscriber();
            subscriber.subscriberStart(sampleCount);
            subscriber.Dispose();
        }
            
    }
}
