// ****************************************************************************
//         (c) Copyright, Real-Time Innovations, All rights reserved.       
//                                                                          
//         Permission to modify and use for internal purposes granted.      
// This software is provided "as is", without warranty, express or implied. 
//                                                                          
// ****************************************************************************

package com.rti.hello.dynamic;

import java.text.DecimalFormat;
import java.util.Date;

import com.rti.dds.domain.DomainParticipant;
import com.rti.dds.dynamicdata.DynamicData;
import com.rti.dds.dynamicdata.DynamicDataReader;
import com.rti.dds.dynamicdata.DynamicDataSeq;
import com.rti.dds.infrastructure.ByteSeq;
import com.rti.dds.infrastructure.RETCODE_NO_DATA;
import com.rti.dds.infrastructure.ResourceLimitsQosPolicy;
import com.rti.dds.infrastructure.StatusKind;
import com.rti.dds.subscription.DataReader;
import com.rti.dds.subscription.DataReaderListener;
import com.rti.dds.subscription.InstanceStateKind;
import com.rti.dds.subscription.LivelinessChangedStatus;
import com.rti.dds.subscription.RequestedDeadlineMissedStatus;
import com.rti.dds.subscription.RequestedIncompatibleQosStatus;
import com.rti.dds.subscription.SampleInfo;
import com.rti.dds.subscription.SampleInfoSeq;
import com.rti.dds.subscription.SampleLostStatus;
import com.rti.dds.subscription.SampleRejectedStatus;
import com.rti.dds.subscription.SampleStateKind;
import com.rti.dds.subscription.Subscriber;
import com.rti.dds.subscription.SubscriptionMatchedStatus;
import com.rti.dds.subscription.ViewStateKind;
import com.rti.dds.topic.Topic;


//****************************************************************************
/**
 * Manage the subscription for the data published in the Hello example 
 */
public class HelloSubscriber implements DataReaderListener {
    private static final int POLL_PERIOD_MILLISEC = 1000; // In seconds  
    private static final int ONE_MEGABYTE = 1024*1024;

    private static final DecimalFormat I8FMT = new DecimalFormat("00000000");
    private static final DecimalFormat I10FMT =
        new DecimalFormat("0000000000");
    private static final DecimalFormat DFMT = new DecimalFormat("0000000.00");

    private int _theVerbose;
    private int _theSampleId = 0;       // Last received sample ID
    private int _thePayloadSize = 0;    // Set only when received the 1st sample
    private int _theSampleLost = 0;     // Counter for sample lost
    private int _theSampleRcvdCount = 0; // Counter for sample received
    private int _theSampleRcvdMax = 0;   // Maximum number of samples to receive

    private DynamicDataSeq _dataSeq = new DynamicDataSeq();
    private SampleInfoSeq _infoSeq = new SampleInfoSeq();
    private DynamicDataReader _reader = null;

    public HelloSubscriber(DomainParticipant participant,
                        Topic topic,
                        int verbose,
                        int sampleCount) {
        _theVerbose = verbose;
        _theSampleRcvdMax = sampleCount;
        
        // Creates the DDS Data reader. 
        // Just like before, if you want to customize the reader QoS,
        // use Subscriber.get_default_datareader_qos() to 
        // initialize a local copy of the default QoS, modify them, then
        // use them in the creation call below instead of 
        // DATAREADER_QOS_DEFAULT.
        // For more data reader API info, see:
        //     $NDDSHOME/doc/html/api_c/group__DDSReaderModule.html
        //
        if (verbose > 0) {
            System.out.println("Creating the data reader...");
        }
        _reader = (DynamicDataReader)
                    participant.create_datareader(
                    topic,
                    Subscriber.DATAREADER_QOS_DEFAULT, 
                    this,
                    StatusKind.STATUS_MASK_ALL);
        if (_reader == null) {
            System.err.println("! Unable to create DDS Data Reader");
            throw new RuntimeException("HelloSubscriber creation failed");
        }
    }

    // A simple utility function used for formatting the output. Removes leading
    // zeros from a string (except for the last one).
    private String removeZeros(String s) {
        char [] arr = s.toCharArray();
        int i = 0;
        while (i < s.length()-1 && arr[i] == '0') arr[i++] = ' ';
        return new String(arr);
    }
    
    
    /**************************************************************************
     * Waits for the application to terminate. Data samples are received from
     * the DDS thread. This thread simply periodically prints on screen the
     * statistics of the data received.
     */
    public void waitForTermination() {
        /* Statistics variables */
        int  stat_first_sequence_id = 0;// ID of first sample
        Date time_now;                // Time for every iteration
        Date start_time = new Date(); // Time of first iteration w/samples
        int  stat_delta_time_sec;     // Num. secs since first sample
        int  last_sample_id = 0;      // Copy of the last sample_id
        int  last_sample_lost = 0;    // Copy of the last sample_lost
        int  prev_sample_id = 0;      // ID of sample lost on prev. iteration
        int  prev_sample_lost = 0;    // Sample lost of prev. iteration
        int  stat_total_samples = 0;  // Total # of msgs received
        int  stat_samples_lost;       // Samples lost for the last period
        float stat_total_sample_per_sec = 0;
        float stat_current_sample_per_sec = 0;
        float stat_throughput = 0;

        System.out.println("");
        /*      12345678|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890 */
        System.out.println("Sec.from|Total     |Total Lost|Curr Lost |Average   |Current   |Current");
        System.out.println("start   |samples   |samples   |samples   |smpls/sec |smpls/sec |Mb/sec");
        System.out.println("--------+----------+----------+----------+----------+----------+----------");

        for (;;) {
            try {
                Thread.sleep(POLL_PERIOD_MILLISEC);

                if (_theSampleRcvdMax != 0 && (_theSampleRcvdCount >= _theSampleRcvdMax)) {
                    System.out.println("\nReceived " + 
                        Integer.toString(_theSampleRcvdCount) + 
                        " samples.");
                    _reader.set_listener(null, StatusKind.STATUS_MASK_NONE); 
                    break;
                }

                /* If the last sample_id received is < than the older one received,
                 * it is because the publisher has restarted or there are two publishers
                 * in the system.
                 * In this case the stats won't be correct, so terminate the application
                 */
                if (_theSampleId < last_sample_id) {
                    System.out.println("Detected multiple publishers, or the publisher was restarted.");
                    System.out.println("If you have multiple publishers on the network or you restart");
                    System.out.println("the publisher, the statistics produced won't be accurate.");
                    break;
                 }

                /* Make a copy of the last sample received */
                last_sample_id   = _theSampleId;
                last_sample_lost = _theSampleLost;
                time_now = new Date();
                if (last_sample_id == 0) {
                    if (_theVerbose > 0) {
                        System.out.println("No data...");
                    }
                    /* No data */
                    continue;
                }
                
                // If this is the first sample received, mark the sample ID and 
                // get the time 
                if (stat_first_sequence_id == 0) {
                    stat_first_sequence_id = last_sample_id;
                    start_time = new Date();
                    /* Don't consider this iteration in the statistics, as it is
                     * not meaningful.
                     */
                    prev_sample_id = last_sample_id;
                    prev_sample_lost = last_sample_lost;
                    continue;
                }

                /* Then calculate the statistics */
                stat_delta_time_sec = (int)((time_now.getTime() - start_time.getTime()) / 1000);
                stat_total_samples = last_sample_id - stat_first_sequence_id 
                                - last_sample_lost;
                stat_total_sample_per_sec = (float)stat_total_samples / (float)stat_delta_time_sec;
                stat_current_sample_per_sec = (float)(last_sample_id - prev_sample_id) 
                                / (POLL_PERIOD_MILLISEC / 1000);
                stat_samples_lost = last_sample_lost - prev_sample_lost;
                stat_throughput =
                    _thePayloadSize * 
                    stat_current_sample_per_sec *
                    8.0f /
                    ONE_MEGABYTE;
                
                System.out.println(
                        removeZeros(I8FMT.format(stat_delta_time_sec)) + " " +
                        removeZeros(I10FMT.format(stat_total_samples)) + " " +
                        removeZeros(I10FMT.format(last_sample_lost)) + " " +
                        removeZeros(I10FMT.format(stat_samples_lost)) + " " +
                        removeZeros(DFMT.format(stat_total_sample_per_sec)) + " " +
                        removeZeros(DFMT.format(stat_current_sample_per_sec)) + " " +
                        removeZeros(DFMT.format(stat_throughput)));
                /* Use the following for Java 1.5
                System.out.printf("%8d %10d %10d %10d %10.2f %10.2f %10.2f\n",
                        stat_delta_time_sec,
                        stat_total_samples,
                        last_sample_lost,
                        stat_samples_lost,
                        stat_total_sample_per_sec,
                        stat_current_sample_per_sec,
                        stat_throughput);
                */
                prev_sample_id = last_sample_id;
                prev_sample_lost = last_sample_lost;

            } catch (InterruptedException e) { /*ignore*/ }
        }
    }
    
    /**************************************************************************
     * Called for every valid sample received from DDS. 
     * This simply copy the
     * received data in the class properties to be processed by the main
     * thread (running waitForTermination).
     * @param instance an instance of the data just received. 
     */
    private void _processData(DynamicData instance) {
        _theSampleId = instance.get_int("sampleId",
                        DynamicData.MEMBER_ID_UNSPECIFIED);
        ++_theSampleRcvdCount;
        if (_thePayloadSize == 0) {
            ByteSeq payload = new ByteSeq(CommandLineArguments.MAX_PAYLOAD);
            payload.setSize(CommandLineArguments.MAX_PAYLOAD);
            instance.get_byte_seq(
                    payload, "payload", DynamicData.MEMBER_ID_UNSPECIFIED);
            _thePayloadSize = payload.size();
        }
    }
    
    // ************************************************************************
    // Implementation of the methods described in DataReaderListener interface
    // ************************************************************************
    public void on_data_available(DataReader reader) {
        DynamicDataReader HelloWorldReader = (DynamicDataReader)reader;
        if (_theSampleRcvdMax != 0 &&
            (_theSampleRcvdCount >= _theSampleRcvdMax)) {
            return;
        }
        try {
            HelloWorldReader.take(
                        _dataSeq, 
                        _infoSeq,
                        ResourceLimitsQosPolicy.LENGTH_UNLIMITED,
                        SampleStateKind.ANY_SAMPLE_STATE,
                        ViewStateKind.ANY_VIEW_STATE,
                        InstanceStateKind.ANY_INSTANCE_STATE);

            for (int i = 0; i < _dataSeq.size(); ++i) {
                SampleInfo info = (SampleInfo)_infoSeq.get(i);

                if (info.valid_data) {
                    _processData((DynamicData)_dataSeq.get(i));
                }
            }
        } catch (RETCODE_NO_DATA noData) {
            // No data to process
        } finally {
            HelloWorldReader.return_loan(_dataSeq, _infoSeq);
        }
    }
    
    public void on_sample_lost(DataReader reader, 
                        SampleLostStatus status) {
        ++_theSampleLost;
        if (_theVerbose > 0) {
            System.out.println("->Callback: sample lost.");            
        }
    }
    
    public void on_requested_deadline_missed (DataReader reader, 
                        RequestedDeadlineMissedStatus status) {
        if (_theVerbose > 0) {
            System.out.println("->Callback: requested deadline missed.");            
        }
    }
    
    public void on_requested_incompatible_qos (DataReader reader, 
                        RequestedIncompatibleQosStatus status) {
        if (_theVerbose > 0) {
            System.out.println("->Callback: requested incompatible QoS.");            
        }
    }

    public void on_sample_rejected (DataReader reader, 
                        SampleRejectedStatus status) {
        if (_theVerbose > 0) {
            System.out.println("->Callback: sample rejected.");            
        }
    }
    
    public void on_liveliness_changed (DataReader reader, 
                        LivelinessChangedStatus status) {
        if (_theVerbose > 0) {
            System.out.println("->Callback: liveliness changed.");            
        }
    }

    public void on_subscription_matched (DataReader reader, 
            SubscriptionMatchedStatus status) {
        if (_theVerbose > 0) {
            System.out.println("->Callback: subscription matched.");            
        }
    }

}

