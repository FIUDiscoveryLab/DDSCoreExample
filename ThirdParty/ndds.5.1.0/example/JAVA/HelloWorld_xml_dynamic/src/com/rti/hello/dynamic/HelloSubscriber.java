// ****************************************************************************
//         (c) Copyright, Real-Time Innovations, All rights reserved.       
//                                                                          
//         Permission to modify and use for internal purposes granted.      
// This software is provided "as is", without warranty, express or implied. 
//                                                                          
// ****************************************************************************

package com.rti.hello.dynamic;

import com.rti.dds.domain.DomainParticipantFactory;
import com.rti.dds.domain.DomainParticipant;
import com.rti.dds.dynamicdata.DynamicDataReader;
import com.rti.dds.dynamicdata.DynamicDataSeq;
import com.rti.dds.dynamicdata.DynamicData;
import com.rti.dds.infrastructure.ResourceLimitsQosPolicy;
import com.rti.dds.infrastructure.StatusKind;
import com.rti.dds.infrastructure.RETCODE_ERROR;
import com.rti.dds.subscription.DataReader;
import com.rti.dds.subscription.DataReaderAdapter;
import com.rti.dds.subscription.SampleInfo;
import com.rti.dds.subscription.SampleInfoSeq;
import com.rti.dds.subscription.SampleStateKind;
import com.rti.dds.subscription.ViewStateKind;
import com.rti.dds.subscription.InstanceStateKind;


/**
 * Manage the subscription for the data published in the Hello example
 */
class HelloSubscriber extends DataReaderAdapter {

    DomainParticipant participant;
    DynamicDataReader dynamicReader;

    protected void dispose() {
        if (this.participant != null) {
            this.participant.delete_contained_entities();
            this.dynamicReader = null;
            DomainParticipantFactory.get_instance().delete_participant(
                    this.participant);
        }

        DomainParticipantFactory.finalize_instance();
    }

    public void subscriberStart(
            int sampleCount) {

        /*
         * To customize QoS, use the configuration file USER_QOS_PROFILES.xml
         */
        if (this.participant == null) {
            this.participant = DomainParticipantFactory.get_instance().
                    create_participant_from_config(
                    "MyParticipantLibrary::SubscriptionParticipant");
            if (this.participant == null) {
                System.out.println("! Unable to create DDS domain participant");
                return;
            }
        }

        if (this.dynamicReader == null) {
            this.dynamicReader = (DynamicDataReader) this.participant.lookup_datareader_by_name(
                    "MySubscriber::HelloWorldReader");
            if (this.dynamicReader == null) {
                System.out.println("! Unable to get DDS dynamic data reader");
                return;
            }
        }

        /*
         * set listener
         */
        try {
            this.dynamicReader.set_listener(this, StatusKind.STATUS_MASK_ALL);
        } catch (RETCODE_ERROR e) {
            System.out.println("! Write error: "+  e.getMessage());
            return;
        }

        /*
         * Main loop
         */
        int receivePeriod = 3;
        for (int count = 0; (sampleCount == 0) || (count < sampleCount); ++count) {
            System.out.println("HelloWorld_subscriber: Sleeping for " + receivePeriod + " sec...");
            try {
                Thread.sleep(receivePeriod * 1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
                return;
            }
        }
    }

   
    public void on_data_available(DataReader reader) {
        DynamicDataReader helloWorldReader = (DynamicDataReader) reader;
        DynamicDataSeq dataSeq = new DynamicDataSeq();
        SampleInfoSeq infoSeq = new SampleInfoSeq();
        try {
            helloWorldReader.take(
                    dataSeq,
                    infoSeq,
                    ResourceLimitsQosPolicy.LENGTH_UNLIMITED,
                    SampleStateKind.ANY_SAMPLE_STATE,
                    ViewStateKind.ANY_VIEW_STATE,
                    InstanceStateKind.ANY_INSTANCE_STATE);
            for (int i = 0; i < dataSeq.size(); ++i) {
                SampleInfo info = (SampleInfo) infoSeq.get(i);
                if (info.valid_data) {
                    DynamicData sample = (DynamicData) dataSeq.get(i);
                    sample.print(null, 0);
                } else {
                    System.out.println("! No valid data. Instance state: " + info.instance_state);
                }
            }
        } finally {
            helloWorldReader.return_loan(dataSeq, infoSeq);
        }
    }

    public static void main(String[] argv) {
        int sampleCount = 0; // infinite loop

        if (argv.length >= 1) {
            sampleCount = Integer.parseInt(argv[0]);
        }

        HelloSubscriber subscriber = new HelloSubscriber();
        subscriber.subscriberStart(sampleCount);
        subscriber.dispose();
    }
}

