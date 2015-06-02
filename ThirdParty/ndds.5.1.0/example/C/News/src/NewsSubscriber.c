/*****************************************************************************/
/*         (c) Copyright, Real-Time Innovations, All rights reserved.        */
/*                                                                           */
/*         Permission to modify and use for internal purposes granted.       */
/* This software is provided "as is", without warranty, express or implied.  */
/*                                                                           */
/*****************************************************************************/

#include <stdio.h>
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

void ArticleDeliveryStatusListener_on_requested_deadline_missed(
        void* listener_data,
        DDS_DataReader* reader, 
        const struct DDS_RequestedDeadlineMissedStatus* status) {
    DDS_KeyedStringDataReader* typed_reader =
        DDS_KeyedStringDataReader_narrow(reader);
    DDS_KeyedString key_holder;
    
    DDS_KeyedStringDataReader_get_key_value(
        typed_reader,
        &key_holder,
        &status->last_instance_handle);
    printf("->Callback: requested deadline missed: %s\n",
           key_holder.key);
}

void ArticleDeliveryStatusListener_on_requested_incompatible_qos(
        void* listener_data,
        DDS_DataReader* reader, 
        const struct DDS_RequestedIncompatibleQosStatus* status) {
    printf("->Callback: requested incompatible QoS: %d\n",
           status->last_policy_id);
}

void ArticleDeliveryStatusListener_on_sample_lost(
        void* listener_data,
        DDS_DataReader* reader, 
        const struct DDS_SampleLostStatus* status) {
    DDS_Long verbosity = *((DDS_Long*) listener_data);
    if (verbosity > 0) {
        printf("->Callback: article lost.\n");
    }
}

void ArticleDeliveryStatusListener_on_sample_rejected(
        void* listener_data,
        DDS_DataReader* reader, 
        const struct DDS_SampleRejectedStatus* status) {
    DDS_Long verbosity = *((DDS_Long*) listener_data);
    if (verbosity > 0) {
        printf("->Callback: article rejected.\n");
    }
}

void ArticleDeliveryStatusListener_on_liveliness_changed(
        void* listener_data,
        DDS_DataReader* reader, 
        const struct DDS_LivelinessChangedStatus* status) {
    DDS_Long verbosity = *((DDS_Long*) listener_data);
    if (verbosity > 0) {
        printf("->Callback: liveliness changed.\n");
    }
}

void ArticleDeliveryStatusListener_on_subscription_matched(
        void* listener_data,
        DDS_DataReader* reader, 
        const struct DDS_SubscriptionMatchedStatus* status) {
    DDS_Long verbosity = *((DDS_Long*) listener_data);
    if (verbosity > 0) {
        printf("->Callback: subscription matched.\n");
    }
}

void ArticleDeliveryStatusListener_on_data_available(
        void* listener_data,
        DDS_DataReader* reader) {
    /* Do nothing: we're polling for data. */
}


/****************************************************************************/
/* Read Articles                                                            */
/****************************************************************************/

#define MILLIS_PER_SEC    1000

/* Reads the articles arriving on the network. */
DDS_Boolean read_articles(
        DDS_DomainParticipant* participant,
        DDS_Topic* topic,
        DDS_Long verbosity,
        DDS_Long run_seconds,
        const char* content_filter_expression) {

    DDS_TopicDescription* topic_or_content_filtered_topic = NULL;
    DDS_DataReader* untyped_reader = NULL;
    DDS_KeyedStringDataReader* reader = NULL;
    struct DDS_DataReaderListener listener =
        DDS_DataReaderListener_INITIALIZER;
    struct DDS_KeyedStringSeq articles = DDS_SEQUENCE_INITIALIZER;
    struct DDS_SampleInfoSeq articleInfos = DDS_SEQUENCE_INITIALIZER;
    int elapsedMillis = 0;
    DDS_Boolean read_success = DDS_BOOLEAN_FALSE;

    /* --- Create content-filtered topic --- */
    /* ...if necessary. */
    if (verbosity > 0) {
        printf("Creating the ContentFilteredTopic...\n");
    }
    topic_or_content_filtered_topic = DDS_Topic_as_topicdescription(topic);
    if (content_filter_expression != NULL) {
        DDS_ContentFilteredTopic* cft = NULL;
        const struct DDS_StringSeq noFilterParams;
        char cft_name[256];
        RTI_SNPRINTF(
            cft_name, 256, "%s (filtered)",
            DDS_TopicDescription_get_name(topic_or_content_filtered_topic));
        cft = DDS_DomainParticipant_create_contentfilteredtopic(
                participant,
                cft_name,
                topic,
                content_filter_expression,
                &noFilterParams);
        if (cft == NULL) {
            fprintf(stderr, "! Unable to create ContentFilteredTopic\n");
            goto done;
        }
        topic_or_content_filtered_topic =
            DDS_ContentFilteredTopic_as_topicdescription(cft);
    }

    /* --- Create DataReader --- */
    /* If you want to customize the reader QoS, use
     * DDS_Subscriber_get_default_datareader_qos()
     * to initialize a local copy of the default QoS, modify them, then
     * use them in the creation call below instead of
     * DATAREADER_QOS_DEFAULT.
     */
    if (verbosity > 0) {
        printf("Creating the DataReader...\n");
    }
    listener.as_listener.listener_data = &verbosity;
    listener.on_data_available =
        ArticleDeliveryStatusListener_on_data_available;
    listener.on_liveliness_changed =
        ArticleDeliveryStatusListener_on_liveliness_changed;
    listener.on_requested_deadline_missed =
        ArticleDeliveryStatusListener_on_requested_deadline_missed;
    listener.on_requested_incompatible_qos =
        ArticleDeliveryStatusListener_on_requested_incompatible_qos;
    listener.on_sample_lost =
        ArticleDeliveryStatusListener_on_sample_lost;
    listener.on_sample_rejected =
        ArticleDeliveryStatusListener_on_sample_rejected;
    listener.on_subscription_matched =
        ArticleDeliveryStatusListener_on_subscription_matched;
    untyped_reader = DDS_DomainParticipant_create_datareader(
        participant,
        topic_or_content_filtered_topic,
        &DDS_DATAREADER_QOS_DEFAULT, 
        &listener,             /* listener */
        DDS_STATUS_MASK_ALL);  /* all callbacks */
    if (untyped_reader == NULL) {
        fprintf(stderr, "! Unable to create DataReader\n");
        goto done;
    }
    /* The following narrow function should never fail, as it performs 
     * only a safe cast of the generic data writer into a specific
     * DDS_KeyedStringDataReader.
     */
    reader = DDS_KeyedStringDataReader_narrow(untyped_reader);
    if (reader == NULL) {
        fprintf(
            stderr,
            "! Unable to narrow data reader into KeyedStringDataReader\n");
        goto done;
    }

    /* --- Read articles --- */
    for (elapsedMillis = 0;
             elapsedMillis < run_seconds * MILLIS_PER_SEC;
             elapsedMillis += STATUS_PERIOD_MILLIS) {
        time_t now_time = 0;
        struct tm* lt = NULL;
        int i = 0;
        struct DDS_Duration_t sleep_time;

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
        DDS_ReturnCode_t result = DDS_KeyedStringDataReader_read(
            reader,
            &articles,            /* fill in data here */
            &articleInfos,        /* fill in parallel meta-data here */
            DDS_LENGTH_UNLIMITED, /* any # articles */
            DDS_ANY_SAMPLE_STATE,
            DDS_ANY_VIEW_STATE,
            DDS_ANY_INSTANCE_STATE);
        if (result == DDS_RETCODE_NO_DATA) {
            /* nothing to read; go back to sleep */
            goto sleep;
        }
        if (result != DDS_RETCODE_OK) {
            /* an error occurred: stop reading */
            fprintf(stderr, "! A read error occurred: %d\n", result);
            goto done;
        }

        now_time = time(NULL);
        lt = localtime(&now_time);
        printf("Available articles as of %02d:%02d:%02d:\n",
               lt->tm_hour, lt->tm_min, lt->tm_sec);
        for (i = 0; i < DDS_KeyedStringSeq_get_length(&articles); ++i) {
            struct DDS_SampleInfo* articleInfo =
                DDS_SampleInfoSeq_get_reference(&articleInfos, i);
            struct DDS_KeyedString* articleData =
                DDS_KeyedStringSeq_get_reference(&articles, i);
            char article[256];
            time_t src_time = 0;
            struct tm* local_src_time = NULL;

            /* articles[i] contains a valid data sample; it's not
             * just a notification of a state change.
             */
            if (!articleInfo->valid_data) {
                continue;
            }

            /* Time stamp: */
            src_time = (time_t) articleInfo->source_timestamp.sec;
            local_src_time = localtime(&src_time);
            /* Article contents: */
            format_article(
                article, 256, articleData->key, articleData->value);
            /* Print output: */
            printf("    [%02d:%02d:%02d] %20s",
                   local_src_time->tm_hour,
                   local_src_time->tm_min,
                   local_src_time->tm_sec,
                   article);
            if (articleInfo->sample_state == DDS_READ_SAMPLE_STATE) {
                /* Have we seen this article before? */
                printf(" (cached)");
            }
            printf("\n");
        }

        /* For the sake of efficiency, we're using object pools
         * maintained by the middleware. Return the objects to the
         * pool so that the middleware can recycle them.
         */
        result = DDS_KeyedStringDataReader_return_loan(
            reader, &articles, &articleInfos);
        if (result != DDS_RETCODE_OK) {
            /* an error occurred: stop reading */
            fprintf(stderr, "! A loan return error occurred: %d\n", result);
            goto done;
        }

      sleep:
        /* --- Sleep --- */
        /* ...until it's time to read again. */
        sleep_time.sec = STATUS_PERIOD_MILLIS / MILLIS_PER_SEC;
        sleep_time.nanosec = (STATUS_PERIOD_MILLIS % MILLIS_PER_SEC) *
                MILLIS_PER_SEC * MILLIS_PER_SEC;
        NDDS_Utility_sleep(&sleep_time);
    }

    read_success = DDS_BOOLEAN_TRUE;
  done:
    DDS_DataReader_set_listener(
        untyped_reader, NULL, DDS_STATUS_MASK_NONE);
    return read_success;
}
