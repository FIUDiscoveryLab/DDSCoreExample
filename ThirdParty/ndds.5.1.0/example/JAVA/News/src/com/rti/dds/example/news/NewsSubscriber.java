// ***************************************************************************
//         (c) Copyright, Real-Time Innovations, All rights reserved.
//
//         Permission to modify and use for internal purposes granted.
// This software is provided "as is", without warranty, express or implied.
//
// ***************************************************************************

package com.rti.dds.example.news;

import java.text.MessageFormat;
import java.util.Date;

import com.rti.dds.domain.DomainParticipant;
import com.rti.dds.infrastructure.RETCODE_ERROR;
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
import com.rti.dds.topic.TopicDescription;
import com.rti.dds.type.builtin.KeyedString;
import com.rti.dds.type.builtin.KeyedStringDataReader;
import com.rti.dds.type.builtin.KeyedStringSeq;


//****************************************************************************
/**
 * Subscribe to news articles, which are published at different rates, and
 * print them out periodically.
 */
public class NewsSubscriber {
    // -----------------------------------------------------------------------
    // Fields
    // -----------------------------------------------------------------------

    private int _verbosity;
    private int _runSeconds;

    private KeyedStringDataReader _reader = null;



    // -----------------------------------------------------------------------
    // Public Methods
    // -----------------------------------------------------------------------

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
            System.out.println("Creating the ContentFilteredTopic...");
        }
        TopicDescription topicOrContentFilteredTopic = topic;
        if (contentFilterExpression != null) {
            topicOrContentFilteredTopic =
                participant.create_contentfilteredtopic(
                        topic.get_name() + " (filtered)",
                        topic,
                        contentFilterExpression,
                        null);
            if (topicOrContentFilteredTopic == null) {
                throw new IllegalStateException(
                        "Unable to create ContentFilteredTopic");
            }
        }

        // --- Create DataReader --- // 
        /* If you want to customize the reader QoS, use
         * Subscriber.get_default_datareader_qos()
         * to initialize a local copy of the default QoS, modify them, then
         * use them in the creation call below instead of
         * DATAREADER_QOS_DEFAULT.
         */
        if (verbosity > 0) {
            System.out.println("Creating the DataReader...");
        }
        _reader = (KeyedStringDataReader) participant.create_datareader(
                topicOrContentFilteredTopic,
                Subscriber.DATAREADER_QOS_DEFAULT, 
                new ArticleDeliveryStatusListener(),    // listener
                StatusKind.STATUS_MASK_ALL);            // all callbacks
        if (_reader == null) {
            throw new IllegalStateException("Unable to create DataReader");
        }
    }


    /**
     * Reads the articles arriving on the network.
     */
    public void readArticles() {
        KeyedStringSeq articles = new KeyedStringSeq();
        SampleInfoSeq articleInfos = new SampleInfoSeq();

        final long MILLIS_PER_SEC = 1000;
        for (int elapsedMillis = 0;
                 elapsedMillis < _runSeconds * MILLIS_PER_SEC;
                 elapsedMillis += News.STATUS_PERIOD_MILLIS) {
            try {
                /* There are three ways to be notified of new data:
                 *    - Non-blocking poll (see example below)
                 *    - Blocking an application thread until new data is
                 *      available using a WaitSet (see other code examples)
                 *    - Asynchronous notification in a middleware thread
                 *      using a listener (the code below installs a listener
                 *      but does not use it to read data)
                 * 
                 * When you expect your data to arrive periodically, it may
                 * be appropriate -- depending on your latency requirements --
                 * to simply poll for data at that period.
                 * 
                 * Once you know you want to get data, there are 2 ways to
                 * get it:
                 *    - "reading" it: View the data in the middleware's
                 *      internal cache, but leave it in that cache so that
                 *      you can get it back later if you want it. This is
                 *      what the code below does.
                 *    - "taking" it: View the data in the middleware's cache,
                 *      and simultaneously remove it from that cache such
                 *      that future reads/takes will not see it.
                 */
                _reader.read(
                        articles,       // fill in data here
                        articleInfos,   // fill in parallel meta-data here
                        ResourceLimitsQosPolicy.LENGTH_UNLIMITED,// any # articles
                        SampleStateKind.ANY_SAMPLE_STATE,
                        ViewStateKind.ANY_VIEW_STATE,
                        InstanceStateKind.ANY_INSTANCE_STATE);
                
                System.out.println(MessageFormat.format(
                        "Available articles as of {0,time}:",
                        new Object[] { new Date() }));
                for (int i = 0; i < articles.size(); ++i) {
                    SampleInfo articleInfo = (SampleInfo) articleInfos.get(i);
                    /* articles[i] contains a valid data sample; it's not
                     * just a notification of a state change.
                     */
                    if (!articleInfo.valid_data) {
                        continue;
                    }

                    // Get ready to print article.
                    final String outputFormatString =
                        "    [{0,time}] {1} {2}";
                    // Time stamp (#0):
                    long nMillis =
                        articleInfo.source_timestamp.sec * MILLIS_PER_SEC;
                    nMillis += (articleInfo.source_timestamp.nanosec
                                / MILLIS_PER_SEC / MILLIS_PER_SEC);
                    // Article contents (#1):
                    KeyedString articleData = (KeyedString) articles.get(i);
                    News.Article article = new News.Article(
                            articleData.key, articleData.value);
                    // Have we seen this article before? (#2):
                    String isCached =
                        (articleInfo.sample_state ==
                            SampleStateKind.READ_SAMPLE_STATE)
                        ? "(cached)"
                        : "";
                    // Print output:
                    System.out.println(MessageFormat.format(
                            outputFormatString,
                            new Object[] {
                                    new Date(nMillis),
                                    article,
                                    isCached
                            }));
                }
            } catch (RETCODE_NO_DATA noData) {
                // nothing to read; go back to sleep
            } catch (RETCODE_ERROR ex) {
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
                Thread.sleep(News.STATUS_PERIOD_MILLIS);
            } catch (InterruptedException ix) {
                break;
            }
        }
    }



    // -----------------------------------------------------------------------
    // Implementation of the methods described in DataReaderListener interface
    // -----------------------------------------------------------------------

    // =======================================================================

    private class ArticleDeliveryStatusListener
    implements DataReaderListener {
        public void on_requested_deadline_missed(
                DataReader reader, 
                RequestedDeadlineMissedStatus status) {
            KeyedString keyHolder = new KeyedString();
            reader.get_key_value_untyped(
                keyHolder, status.last_instance_handle);
            System.out.println("->Callback: requested deadline missed: " +
                               keyHolder.key);
        }

        public void on_requested_incompatible_qos(
                DataReader reader, 
                RequestedIncompatibleQosStatus status) {
            System.out.println("->Callback: requested incompatible QoS: " +
                               status.last_policy_id);
        }

        public void on_sample_lost(
                DataReader reader, 
                SampleLostStatus status) {
            if (_verbosity > 0) {
                System.out.println("->Callback: article lost.");
            }
        }

        public void on_sample_rejected(
                DataReader reader, 
                SampleRejectedStatus status) {
            if (_verbosity > 0) {
                System.out.println("->Callback: article rejected.");
            }
        }

        public void on_liveliness_changed(
                DataReader reader, 
                LivelinessChangedStatus status) {
            if (_verbosity > 0) {
                System.out.println("->Callback: liveliness changed.");
            }
        }

        public void on_subscription_matched(
                DataReader reader, 
                SubscriptionMatchedStatus status) {
            if (_verbosity > 0) {
                System.out.println("->Callback: subscription matched.");
            }
        }

        public void on_data_available(DataReader reader) {
            // Do nothing: we're polling for data.
        }
    }

}

