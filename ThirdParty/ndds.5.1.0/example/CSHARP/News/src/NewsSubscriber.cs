/* ***************************************************************************
 *         (c) Copyright, Real-Time Innovations, All rights reserved.       
 *                                                                          
 *         Permission to modify and use for internal purposes granted.      
 * This software is provided "as is", without warranty, express or implied. 
 *                                                                          
 * ***************************************************************************
 */
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;

using DDS;


namespace News {
    /* Subscribe to news articles, which are published at different rates, and
     * print them out periodically.
     */
    public class NewsSubscriber {
        // -------------------------------------------------------------------
        // Fields
        // -------------------------------------------------------------------
    
        private int _verbosity;
        private int _runSeconds;
    
        private KeyedStringDataReader _reader = null;
    
    
    
        // -------------------------------------------------------------------
        // Public Methods
        // -------------------------------------------------------------------
    
        public NewsSubscriber(
                DomainParticipant participant,
                Topic topic,
                int verbosity,
                int runSeconds,
                String contentFilterExpression) {
            _verbosity = verbosity;
            _runSeconds = runSeconds;
    
            // --- Create content-filtered topic --- //
            // ...if necessary.
            if (verbosity > 0) {
                Console.WriteLine("Creating the ContentFilteredTopic...");
            }
            ITopicDescription topicOrContentFilteredTopic = topic;
            if (contentFilterExpression != null) {
                StringSeq noFilterParams = new StringSeq();
                topicOrContentFilteredTopic =
                    participant.create_contentfilteredtopic(
                            topic.get_name() + " (filtered)",
                            topic,
                            contentFilterExpression,
                            noFilterParams);
                if (topicOrContentFilteredTopic == null) {
                    throw new ApplicationException(
                            "Unable to create ContentFilteredTopic");
                }
            }
    
            // --- Create DataReader --- // 
            /* If you want to customize the reader QoS, use
             * Subscriber.get_default_datareader_qos()
             * to initialize a local copy of the default QoS, modify them,
             * then use them in the creation call below instead of
             * DATAREADER_QOS_DEFAULT.
             */
            if (verbosity > 0) {
                Console.WriteLine("Creating the DataReader...");
            }
            _reader = (KeyedStringDataReader) participant.create_datareader(
                    topicOrContentFilteredTopic,
                    Subscriber.DATAREADER_QOS_DEFAULT, 
                    new ArticleDeliveryStatusListener(_verbosity),// listener
                    StatusMask.STATUS_MASK_ALL);             // all callbacks
            if (_reader == null) {
                throw new ApplicationException("Unable to create DataReader");
            }
        }
    
    
        // Reads the articles arriving on the network.
        public void ReadArticles() {
            KeyedStringSeq articles = new KeyedStringSeq();
            SampleInfoSeq articleInfos = new SampleInfoSeq();
    
            const long MILLIS_PER_SEC = 1000;
            for (int elapsedMillis = 0;
                     elapsedMillis < _runSeconds * MILLIS_PER_SEC;
                     elapsedMillis += News.STATUS_PERIOD_MILLIS) {
                try {
                    /* There are three ways to be notified of new data:
                     *    - Non-blocking poll (see example below)
                     *    - Blocking an application thread until new data is
                     *      available using a WaitSet (see other code
                     *      examples)
                     *    - Asynchronous notification in a middleware thread
                     *      using a listener (the code below installs a
                     *      listener but does not use it to read data)
                     * 
                     * When you expect your data to arrive periodically, it
                     * may be appropriate -- depending on your latency
                     * requirements -- to simply poll for data at that period.
                     * 
                     * Once you know you want to get data, there are 2 ways to
                     * get it:
                     *    - "reading" it: View the data in the middleware's
                     *      internal cache, but leave it in that cache so that
                     *      you can get it back later if you want it. This is
                     *      what the code below does.
                     *    - "taking" it: View the data in the middleware's
                     *      cache, and simultaneously remove it from that
                     *      cache such that future reads/takes will not see
                     *      it.
                     */
                    _reader.read(
                        articles,       // fill in data here
                        articleInfos,   // fill in parallel meta-data here
                        ResourceLimitsQosPolicy.LENGTH_UNLIMITED,// any # articles
                        SampleStateKind.ANY_SAMPLE_STATE,
                        ViewStateKind.ANY_VIEW_STATE,
                        InstanceStateKind.ANY_INSTANCE_STATE);
                    
                    Console.WriteLine(
                        "Available articles as of " +
                        DateTime.Now.ToLongTimeString() + ":");
                    for (int i = 0; i < articles.length; ++i) {
                        SampleInfo articleInfo = articleInfos.get_at(i);
                        /* articles[i] contains a valid data sample; it's not
                         * just a notification of a state change.
                         */
                        if (!articleInfo.valid_data) {
                            continue;
                        }

                        /* Time stamp:
                         * (The timestamp in DDS is relative to the UNIX
                         * system time epoch: midnight January 1, 1970.
                         * The .Net time epoch starts at 0, so start with
                         * the UNIX epoch and add the elapsed seconds to
                         * that to get the current time.)
                         */
                        DateTime epoch = new DateTime(1970, 1, 1);
                        DateTime now = epoch.AddSeconds(
                            articleInfo.source_timestamp.sec);
                        now = now.ToLocalTime();
                        // Article contents:
                        KeyedString articleData = articles.get_at(i);
                        News.Article article = new News.Article(
                                articleData.key, articleData.value);
                        // Have we seen this article before?
                        String isCached =
                            (articleInfo.sample_state ==
                                SampleStateKind.READ_SAMPLE_STATE)
                            ? " (cached)"
                            : "";
                        // Print output:
                        Console.WriteLine(
                            "    [" + now.ToLongTimeString() + "] " +
                            article +
                            isCached);
                    }
                } catch (Retcode_NoData) {
                    // nothing to read; go back to sleep
                } catch (DDS.Exception ex) {
                    // an error occurred: stop reading
                    throw ex;
                } finally {
                    /* For the sake of efficiency, we're using object pools
                     * maintained by the middleware. Return the objects to the
                     * pool so that the middleware can recycle them.
                     */
                    _reader.return_loan(articles, articleInfos);
                }
    
                // --- Sleep --- //
                // ...until it's time to read again.
                try {
                    Thread.Sleep(News.STATUS_PERIOD_MILLIS);
                } catch (System.Exception ex) {
                    Console.Error.WriteLine(ex.StackTrace);
                    break;
                }
            }
        }
    }


    // -----------------------------------------------------------------------
    // Implementation of the methods described in DataReaderListener interface
    // -----------------------------------------------------------------------

    // =======================================================================

    internal class ArticleDeliveryStatusListener : DataReaderListener {
        private int _verbosity;

        public ArticleDeliveryStatusListener(int verbosity) {
            _verbosity = verbosity;
        }

        public override void on_requested_deadline_missed(
                DataReader reader, 
                ref RequestedDeadlineMissedStatus status) {
            KeyedString keyHolder = new KeyedString();
            reader.get_key_value_untyped(
                keyHolder, ref status.last_instance_handle);
            Console.WriteLine("->Callback: requested deadline missed: " +
                               keyHolder.key);
        }

        public override void on_requested_incompatible_qos(
                DataReader reader, 
                RequestedIncompatibleQosStatus status) {
            Console.WriteLine("->Callback: requested incompatible QoS: " +
                               status.last_policy_id);
        }

        public override void on_sample_lost(
                DataReader reader, 
                ref SampleLostStatus status) {
            if (_verbosity > 0) {
                Console.WriteLine("->Callback: article lost.");
            }
        }

        public override void on_sample_rejected(
                DataReader reader, 
                ref SampleRejectedStatus status) {
            if (_verbosity > 0) {
                Console.WriteLine("->Callback: article rejected.");
            }
        }

        public override void on_liveliness_changed(
                DataReader reader, 
                ref LivelinessChangedStatus status) {
            if (_verbosity > 0) {
                Console.WriteLine("->Callback: liveliness changed.");
            }
        }

        public override void on_subscription_matched(
                DataReader reader, 
                ref SubscriptionMatchedStatus status) {
            if (_verbosity > 0) {
                Console.WriteLine("->Callback: subscription matched.");
            }
        }

        public override void on_data_available(DataReader reader) {
            // Do nothing: we're polling for data.
        }
    }

}
