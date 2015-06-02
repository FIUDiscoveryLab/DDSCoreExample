/*****************************************************************************/
/*         (c) Copyright, Real-Time Innovations, All rights reserved.        */
/*                                                                           */
/*         Permission to modify and use for internal purposes granted.       */
/* This software is provided "as is", without warranty, express or implied.  */
/*                                                                           */
/*****************************************************************************/

#include <iostream>
#include <string>
#include <stdexcept>
#include <iomanip>
#include <stdlib.h>
#include <time.h>
#include <errno.h>

#include "News.h"
#include "NewsSubscriber.h"


/**
 * Subscribe to news articles, which are published at different rates, and
 * print them out periodically.
 */

/****************************************************************************/
/* Listener                                                                 */
/****************************************************************************/

ArticleDeliveryStatusListener::ArticleDeliveryStatusListener(int verbosity):
        _verbosity(verbosity) {
    // empty
}

void ArticleDeliveryStatusListener::on_requested_deadline_missed(
        DDSDataReader* reader, 
        const DDS_RequestedDeadlineMissedStatus& status) {
    DDS_KeyedString keyHolder;
    DDSKeyedStringDataReader* typedReader =
        DDSKeyedStringDataReader::narrow(reader);
    typedReader->get_key_value(
            keyHolder, status.last_instance_handle);
    std::cout << "->Callback: requested deadline missed: "
              << keyHolder.key
              << std::endl;
}

void ArticleDeliveryStatusListener::on_requested_incompatible_qos(
        DDSDataReader* reader, 
        const DDS_RequestedIncompatibleQosStatus& status) {
    std::cout << "->Callback: requested incompatible QoS: "
              << status.last_policy_id
              << std::endl;
}

void ArticleDeliveryStatusListener::on_sample_lost(
        DDSDataReader* reader, 
        const DDS_SampleLostStatus& status) {
    if (_verbosity > 0) {
        std::cout << "->Callback: article lost." << std::endl;
    }
}

void ArticleDeliveryStatusListener::on_sample_rejected(
        DDSDataReader* reader, 
        const DDS_SampleRejectedStatus& status) {
    if (_verbosity > 0) {
        std::cout << "->Callback: article rejected." << std::endl;
    }
}

void ArticleDeliveryStatusListener::on_liveliness_changed(
        DDSDataReader* reader, 
        const DDS_LivelinessChangedStatus& status) {
    if (_verbosity > 0) {
        std::cout << "->Callback: liveliness changed." << std::endl;
    }
}

void ArticleDeliveryStatusListener::on_subscription_matched(
        DDSDataReader* reader, 
        const DDS_SubscriptionMatchedStatus& status) {
    if (_verbosity > 0) {
        std::cout << "->Callback: subscription matched." << std::endl;
    }
}

void ArticleDeliveryStatusListener::on_data_available(DDSDataReader* reader) {
    // Do nothing: we're polling for data.
}


/****************************************************************************/
/* Lifecycle                                                                */
/****************************************************************************/

NewsSubscriber::NewsSubscriber(
        DDSDomainParticipant* participant,
        DDSTopic* topic,
        DDS_Long verbosity,
        DDS_Long runSeconds,
        const std::string& contentFilterExpression)
        : _listener(verbosity),
          _verbosity(verbosity),
          _runSeconds(runSeconds),
          _reader(NULL) {

    // --- Create content-filtered topic --- //
    // ...if necessary.
    if (verbosity > 0) {
        std::cout << "Creating the ContentFilteredTopic..." << std::endl;
    }
    DDSTopicDescription* topicOrContentFilteredTopic = topic;
    if (contentFilterExpression.length() > 0) {
        std::string cftName =
            std::string(topic->get_name()) + std::string(" (filtered)");
        const DDS_StringSeq noFilterParams;
        topicOrContentFilteredTopic =
            participant->create_contentfilteredtopic(
                cftName.c_str(),
                topic,
                contentFilterExpression.c_str(),
                noFilterParams);
        if (topicOrContentFilteredTopic == NULL) {
            throw std::runtime_error(
                    "Unable to create ContentFilteredTopic");
        }
    }

    // --- Create DataReader --- // 
    /* If you want to customize the reader QoS, use
     * DDSSubscriber::get_default_datareader_qos()
     * to initialize a local copy of the default QoS, modify them, then
     * use them in the creation call below instead of
     * DATAREADER_QOS_DEFAULT.
     */
    if (verbosity > 0) {
        std::cout << "Creating the DataReader..." << std::endl;
    }
    DDSDataReader* untypedReader = participant->create_datareader(
            topicOrContentFilteredTopic,
            DDS_DATAREADER_QOS_DEFAULT, 
            &_listener,             // listener
            DDS_STATUS_MASK_ALL);   // all callbacks
    if (untypedReader == NULL) {
        throw std::runtime_error("Unable to create DataReader");
    }
    /* The following narrow function should never fail, as it performs 
     * only a safe cast of the generic data writer into a specific
     * DDSKeyedStringDataReader.
     */
    _reader = DDSKeyedStringDataReader::narrow(untypedReader);
    if (_reader == NULL) {
        throw std::runtime_error(
            "Unable to narrow data reader into DDSKeyedStringDataReader");
    }
}


/****************************************************************************/
/* Read Articles                                                            */
/****************************************************************************/

/* Reads the articles arriving on the network. */
void NewsSubscriber::readArticles() {
    DDS_KeyedStringSeq articles;
    DDS_SampleInfoSeq articleInfos;
    time_t nowTime = 0;
    tm* lt = NULL;
    int i;

    const DDS_Long MILLIS_PER_SEC = 1000;
    for (int elapsedMillis = 0;
             elapsedMillis < _runSeconds * MILLIS_PER_SEC;
             elapsedMillis += STATUS_PERIOD_MILLIS) {
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
        DDS_ReturnCode_t result = _reader->read(
                articles,             // fill in data here
                articleInfos,         // fill in parallel meta-data here
                DDS_LENGTH_UNLIMITED, // any # articles
                DDS_ANY_SAMPLE_STATE,
                DDS_ANY_VIEW_STATE,
                DDS_ANY_INSTANCE_STATE);
        if (result == DDS_RETCODE_NO_DATA) {
            // nothing to read; go back to sleep
            goto sleep;
        }
        if (result != DDS_RETCODE_OK) {
            // an error occurred: stop reading
            throw std::runtime_error("A read error occurred: " + result);
        }

        nowTime = time(NULL);
        lt = localtime(&nowTime);
        std::cout << "Available articles as of "
                  << lt->tm_hour
                  << ":" << std::setw(2) << lt->tm_min
                  << ":" << std::setw(2) << lt->tm_sec
                  << ":"
                  << std::endl;
        for (i = 0; i < articles.length(); ++i) {
            DDS_SampleInfo& articleInfo = articleInfos[i];
            /* articles[i] contains a valid data sample; it's not
             * just a notification of a state change.
             */
            if (!articleInfo.valid_data) {
                continue;
            }

            // Article contents:
            DDS_KeyedString& articleData = articles[i];
            Article article(articleData.key, articleData.value);
            // Time stamp:
            time_t src_time = (time_t) articleInfo.source_timestamp.sec;
            tm* local_src_time = localtime(&src_time);
            // Print output:
            std::cout
                << "    [" << local_src_time->tm_hour
                << ":"     << std::setw(2) << std::setfill('0')
                           << local_src_time->tm_min
                << ":"     << std::setw(2) << std::setfill('0')
                           << local_src_time->tm_sec << "] "
                << std::setw(20) << article;
            if (articleInfo.sample_state == DDS_READ_SAMPLE_STATE) {
                // Have we seen this article before?
                std::cout << " (cached)";
            }
            std::cout << std::endl;
        }

        /* For the sake of efficiency, we're using object pools
         * maintained by the middleware. Return the objects to the
         * pool so that the middleware can recycle them.
         */
        result = _reader->return_loan(articles, articleInfos);
        if (result != DDS_RETCODE_OK) {
            // an error occurred: stop reading
            throw std::runtime_error(
                    "A loan return error occurred: " + result);
        }

    sleep:
        // --- Sleep --- //
        // ...until it's time to read again.
        DDS_Duration_t sleepTime;
        sleepTime.sec = STATUS_PERIOD_MILLIS / MILLIS_PER_SEC;
        sleepTime.nanosec = (STATUS_PERIOD_MILLIS % MILLIS_PER_SEC) *
                MILLIS_PER_SEC * MILLIS_PER_SEC;
        NDDS_Utility_sleep(&sleepTime);
    }
}
