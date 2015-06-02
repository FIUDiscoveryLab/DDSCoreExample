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

namespace Hello {
    /**
     * Manage the subscription for the data published in the Hello example 
     */
    class HelloSubscriber : DDS.DataReaderListener {
        private const int POLL_PERIOD_MILLISEC = 1000; /* In seconds */
        private const int ONE_MEGABYTE = 1024 * 1024;

        private int _theVerbose;
        private int _theSampleId = 0;       // Last received sample ID
        private int _thePayloadSize = 0;    // Set only when received the 1st sample
        private int _theSampleLost = 0;     // Counter for sample lost
        private int _theSampleRcvdCount = 0; /* Counter of samples received */
        private int _theSampleRcvdMax = 0;   /* Maximum number of samples to receive */

        private DDS.DynamicDataSeq _dataSeq = new DDS.DynamicDataSeq();
        private DDS.SampleInfoSeq _infoSeq = new DDS.SampleInfoSeq();
        private DDS.DynamicDataReader _reader = null; 

        public HelloSubscriber(DDS.DomainParticipant participant,
                            DDS.Topic topic,
                            int verbose,
                            int sampleCount) {
            _theVerbose = verbose;
            _theSampleRcvdMax = sampleCount;

            /* Creates the DDS Data reader. 
             * Just like before, if you want to customize the reader QoS,
             * use DDS.Subscriber.get_default_datareader_qos() to 
             * initialize a local copy of the default QoS, modify them, then
             * use them in the creation call below instead of 
             * DDS_DATAREADER_QOS_DEFAULT.
             * For more data reader API info, see:
             *     $NDDSHOME/doc/html/api_dotnet/group__DDSReaderModule.html
             */
            if (verbose > 0) {
                Console.WriteLine("Creating the data reader...");
            }
            _reader = (DDS.DynamicDataReader)
                        participant.create_datareader(
                        topic,
                        DDS.Subscriber.DATAREADER_QOS_DEFAULT,
                        this,
                        DDS.StatusMask.STATUS_MASK_ALL);
            if (_reader == null) {
                Console.Error.WriteLine("! Unable to create DDS Data Reader");
                return;
            }
        }

        /**************************************************************************
         * Waits for the application to terminate. Data samples are received from
         * the DDS thread. This thread simply periodically prints on screen the
         * statistics of the data received.
         */
        public void waitForTermination() {
            /* Statistics variables */
            int stat_first_sequence_id = 0;         /* ID of first sample */
            DateTime time_now;                      /* Time for every iteration */
            DateTime start_time;                    /* Time of first iteration w/samples */
            int stat_delta_time_sec;                /* Num. secs since first sample */
            int last_sample_id = 0;                 /* Copy of the last sample_id */
            int last_sample_lost = 0;               /* Copy of the last sample_lost */
            int prev_sample_id = 0;                 /* ID of sample lost on prev. iteration */
            int prev_sample_lost = 0;               /* Sample lost of prev. iteration */
            int stat_total_samples = 0;             /* Total # of msgs received */
            int stat_samples_lost;                  /* Samples lost for the last period */
            float stat_total_sample_per_sec = 0;
            float stat_current_sample_per_sec = 0;
            float stat_throughput = 0;

            /* Initialize start_time */
            start_time = DateTime.Now;

            Console.WriteLine("");
            /*      12345678|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890 */
            Console.WriteLine("Sec.from   |Total     |Total Lost|Curr Lost|Average      |Current   |Current");
            Console.WriteLine("start      |samples   |samples   |samples  |smpls/sec    |smpls/sec |Mb/sec");
            Console.WriteLine("-----------+----------+----------+---------+-------------+----------+----------");

            for (; ; ) {
                try {
                    Thread.Sleep(POLL_PERIOD_MILLISEC);

                    if (_theSampleRcvdMax != 0 && (_theSampleRcvdCount >= _theSampleRcvdMax)) {
                        Console.WriteLine("Received " + _theSampleRcvdCount + " samples.");
                        _reader.set_listener(null, DDS.StatusMask.STATUS_MASK_NONE); 
                        break;
                    }

                    /* If the last sample_id received is < than the older one received,
                     * it is because the publisher has restarted or there are two publishers
                     * in the system.
                     * In this case the stats won't be correct, so terminate the application
                     */
                    if (_theSampleId < last_sample_id) {
                        Console.WriteLine("Detected multiple publishers, or the publisher was restarted.");
                        Console.WriteLine("If you have multiple publishers on the network or you restart");
                        Console.WriteLine("the publisher, the statistics produced won't be accurate.");
                        break;
                    }

                    /* Make a copy of the last sample received */
                    last_sample_id = _theSampleId;
                    last_sample_lost = _theSampleLost;
                    time_now = DateTime.Now;
                    if (last_sample_id == 0) {
                        if (_theVerbose > 0) {
                            Console.WriteLine("No data...");
                        }
                        /* No data */
                        continue;
                    }

                    /* If this is the first sample received, mark the sample ID and 
                       get the time */
                    if (stat_first_sequence_id == 0) {
                        stat_first_sequence_id = last_sample_id;
                        start_time = DateTime.Now;
                        /* Don't consider this iteration in the statistics, as it is
                         * not meaningful.
                         */
                        prev_sample_id = last_sample_id;
                        prev_sample_lost = last_sample_lost;
                        continue;
                    }

                    /* Then calculate the statistics */
                    stat_delta_time_sec = (int)((TimeSpan)(time_now - start_time)).TotalSeconds;
                    stat_total_samples = last_sample_id - stat_first_sequence_id - last_sample_lost;
                    stat_total_sample_per_sec = (float)stat_total_samples / (float)stat_delta_time_sec;
                    stat_current_sample_per_sec = (float)(last_sample_id - prev_sample_id)
                                        / (POLL_PERIOD_MILLISEC / 1000);
                    stat_samples_lost = last_sample_lost - prev_sample_lost;
                    stat_throughput =
                        _thePayloadSize *
                        stat_current_sample_per_sec *
                        8.0f /
                        ONE_MEGABYTE;

                    Console.WriteLine("{0,11} {1,10} {2,10} {3,9} {4,13:F} {5,10:F} {6,10:F}",
                            stat_delta_time_sec,
                            stat_total_samples,
                            last_sample_lost,
                            stat_samples_lost,
                            stat_total_sample_per_sec,
                            stat_current_sample_per_sec,
                            stat_throughput);
                    prev_sample_id = last_sample_id;
                    prev_sample_lost = last_sample_lost;

                }
                catch (ThreadInterruptedException) { }
            }
        }

        /**************************************************************************
         * Called for every valid sample received from DDS. 
         * This simply copy the
         * received data in the class properties to be processed by the main
         * thread (running waitForTermination).
         * @param instance an instance of the data just received. 
         */
        private void _processData(DDS.DynamicData instance) {
            _theSampleId = instance.get_int("sampleId",
                            DDS.DynamicData.MEMBER_ID_UNSPECIFIED);
            ++_theSampleRcvdCount;
            if (_thePayloadSize == 0) {
                DDS.ByteSeq payload = new DDS.ByteSeq(CommandLineArguments.MAX_PAYLOAD);
                payload.ensure_length(CommandLineArguments.MAX_PAYLOAD, CommandLineArguments.MAX_PAYLOAD);
                instance.get_byte_seq(payload, "payload", DDS.DynamicData.MEMBER_ID_UNSPECIFIED);
                _thePayloadSize = payload.length;
            }
        }

        /* ************************************************************************
         * Implementation of the methods described in DataReaderListener interface
         * ************************************************************************
         */
        public override void on_data_available(DDS.DataReader reader) {
            DDS.DynamicDataReader HelloWorldReader = (DDS.DynamicDataReader)reader;
            if (_theSampleRcvdMax != 0 && 
                (_theSampleRcvdCount >= _theSampleRcvdMax)) {
                return;
            }
            try {
                HelloWorldReader.take(
                            _dataSeq,
                            _infoSeq,
                            DDS.ResourceLimitsQosPolicy.LENGTH_UNLIMITED,
                            DDS.SampleStateKind.ANY_SAMPLE_STATE,
                            DDS.ViewStateKind.ANY_VIEW_STATE,
                            DDS.InstanceStateKind.ANY_INSTANCE_STATE);
                for (int i = 0; i < _dataSeq.length; ++i) {
                    DDS.SampleInfo info = (DDS.SampleInfo)_infoSeq.get_at(i);
                    if (info.valid_data) {
                        _processData((DDS.DynamicData)_dataSeq.get_at(i));
                    }
                }
            } catch (DDS.Retcode_NoData) {
                /* No data to process */
                if (_theVerbose > 0) {
                    Console.WriteLine("No data to process.");
                }
            } finally {
                HelloWorldReader.return_loan(_dataSeq, _infoSeq);
            }
        }

        public void on_sample_lost(DDS.DataReader reader,
                                DDS.SampleLostStatus status) {
            ++_theSampleLost;
            if (_theVerbose > 0) {
                Console.WriteLine("->Callback: sample lost.");
            }
        }

        public void on_requested_deadline_missed(DDS.DataReader reader,
                            DDS.RequestedDeadlineMissedStatus status) {
            if (_theVerbose > 0) {
                Console.WriteLine("->Callback: requested deadline missed.");
            }
        }

        public override void on_requested_incompatible_qos(DDS.DataReader reader,
                            DDS.RequestedIncompatibleQosStatus status) {
            if (_theVerbose > 0) {
                Console.WriteLine("->Callback: requested incompatible Qos.");
            }
        }

        public void on_sample_rejected(DDS.DataReader reader,
                           DDS.SampleRejectedStatus status) {
            if (_theVerbose > 0) {
                Console.WriteLine("->Callback: sample rejected.");
            }
        }

        public void on_liveliness_changed(DDS.DataReader reader,
                            DDS.LivelinessChangedStatus status) {
            if (_theVerbose > 0) {
                Console.WriteLine("->Callback: liveliness changed.");
            }
        }

        public void on_subscription_matched(DDS.DataReader reader,
                           DDS.SubscriptionMatchedStatus status) {
            if (_theVerbose > 0) {
                Console.WriteLine("->Callback: subscription matched.");
            }
        }

    }
}
