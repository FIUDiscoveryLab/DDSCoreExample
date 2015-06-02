/****************************************************************************/
/*         (c) Copyright, Real-Time Innovations, All rights reserved.       */
/*                                                                          */
/*         Permission to modify and use for internal purposes granted.      */
/* This software is provided "as is", without warranty, express or implied. */
/*                                                                          */
/****************************************************************************/

#include <time.h>

#include "News.h"
#include "NewsPublisher.h"


/* Manage the data publication for the News example. Several news outlets
 * publish articles periodically but at different rates.
 */

/****************************************************************************/
/* News Outlets                                                             */
/****************************************************************************/

typedef struct NewsOutlet {
    /* The name of a news outlet. */
    const char* _name;

    /* The writer that publishes the data. */
    DDS_KeyedStringDataWriter* _writer;

    /* The handle that helps the middleware locate the instance to which
     * a sample will be published.
     */
    DDS_InstanceHandle_t _handle;

    /* The number of articles this outlet has published. */
    DDS_Long _articleCount;
} NewsOutlet;


static void initialize_news_outlet(NewsOutlet* outlet,
                                   const char* theName,
                                   DDS_KeyedStringDataWriter* theWriter) {
    outlet->_name = theName;
    outlet->_writer = theWriter;
    outlet->_handle = DDS_HANDLE_NIL;
    outlet->_articleCount = 0;
}


/* Maximum consecutive write error after stopping the write process. */
#define MAX_CONSECUTIVE_WRITE_ERROR         5


static DDS_Boolean publish_next_article(char* article_out,
                                        size_t article_out_size,
                                        NewsOutlet* outlet) {
    char article_text[256];
    DDS_ReturnCode_t write_result = DDS_RETCODE_ERROR;
    int i = 0;

    /* --- Build article text --- */
    ++(outlet->_articleCount);
    RTI_SNPRINTF(article_text, 256, "lorem ipsum %3d",
                 outlet->_articleCount);

    /* --- Try to publish article --- */
    for (i = 0; i < MAX_CONSECUTIVE_WRITE_ERROR; ++i) {
        write_result = DDS_KeyedStringDataWriter_write_string_w_key(
            outlet->_writer,
            outlet->_name, article_text, &outlet->_handle);
        if (write_result == DDS_RETCODE_OK) {
            format_article(
                article_out, article_out_size, outlet->_name, article_text);
            return DDS_BOOLEAN_TRUE;
        }
        fprintf(stderr, "! Write error: %d\n", write_result);
    }

    /* --- Report publication error --- */
    fprintf(
        stderr,
        "! Reached maximum number of failures: stopping publishing...\n");
    return DDS_BOOLEAN_FALSE;
}


static void register_news_outlet(NewsOutlet* outlet) {
    /* When working with keyed data types, you can "register" an
     * instance before writing it, which will give you back an
     * "instance handle." By providing this handle back to the writer
     * when you write a sample, you help the middleware locate its
     * internal data structures associated with that instance,
     * enabling the writer to work more efficiently.
     * 
     * Pre-registering an instance is optional; you can always pass a
     * "nil" handle to the writer when writing, and it will
     * recalculate the instance on the fly. Consider pre-registering
     * your instance(s) if throughput and/or writer CPU usage are
     * significant concerns.
     */
    outlet->_handle = DDS_KeyedStringDataWriter_register_instance_w_key(
        outlet->_writer, outlet->_name);
}


/****************************************************************************/
/* Start sending the data.                                                  */
/****************************************************************************/

static void report_articles_published(char** articles_published,
                                      int num_articles) {
    time_t now_time = 0;
    struct tm* lt = NULL;
    int i = 0;

    if (num_articles == 0) {
        return;
    }

    now_time = time(NULL);
    lt = localtime(&now_time);
    printf("Articles published in last period as of %02d:%02d:%0d:\n",
           lt->tm_hour, lt->tm_min, lt->tm_sec);
    for (i = 0; i < num_articles; ++i) {
        printf("    %s\n", articles_published[i]);
    }
}


#define MILLIS_PER_SEC          1000
#define PUBLISH_PERIOD_MILLIS   (STATUS_PERIOD_MILLIS / 10)


DDS_Boolean publish(DDS_DomainParticipant* participant,
                    DDS_Topic* topic,
                    DDS_Long verbose,
                    DDS_Long run_seconds) {
    DDS_DataWriter* untyped_writer = NULL;
    DDS_KeyedStringDataWriter* writer = NULL;
    const char* news_outlet_names[] = {
        "Reuters",
        "AP",
        "CNN",
        "Bloomberg",
        "NY Times",
        "Economist"
    };
    int num_outlets = sizeof(news_outlet_names) / sizeof(const char*);
    int i = 0;
    /* The size of the array should really be 'num_outlets', but that won't
     * compile on all architectures, so just pick a value likely to be
     * larger than that, even if the name array grows a little bit.
     */
    NewsOutlet news_outlets[16];
    int elapsedMillis = 0;
    struct DDS_Duration_t sleep_time = DDS_DURATION_ZERO;
    int num_articles = 0;
    int num_articles_allocated = 64; /* arbitrary initial size */
    char** articles_in_last_status_period = (char**) malloc(
        sizeof(char*) * num_articles_allocated);
    DDS_Boolean pub_success = DDS_BOOLEAN_FALSE;

    /* --- Create DataWriter --- */
    /* If you want to customize the writer QoS, use
     * DDSPublisher::get_default_datawriter_qos() to 
     * initialize a local copy of the default QoS, modify them, then
     * use them in the creation call below instead of 
     * DDS_DATAWRITER_QOS_DEFAULT.
     */
    if (verbose) {
        printf("Creating the DataWriter...\n");
    }
    untyped_writer = DDS_DomainParticipant_create_datawriter(
        participant,
        topic,
        &DDS_DATAWRITER_QOS_DEFAULT,
        NULL,           /* listener */
        DDS_STATUS_MASK_NONE);
    if (untyped_writer == NULL) {
        fprintf(stderr, "! Unable to create DataWriter\n");
        goto done;
    }
    /* The following narrow function should never fail, as it performs 
     * only a safe cast of the generic data writer into a specific
     * DDS_KeyedStringDataWriter.
     */
    writer = DDS_KeyedStringDataWriter_narrow(untyped_writer);
    if (writer == NULL) {
        fprintf(
            stderr,
            "! Unable to narrow data writer into KeyedStringDataWriter\n");
        goto done;
    }

    /* --- Initialize news outlets --- */
    for (i = 0; i < num_outlets; ++i) {
        initialize_news_outlet(&news_outlets[i], news_outlet_names[i], writer);
    }

    /* --- Register news outlets --- */
    for (i = 0; i < num_outlets; ++i) {
        register_news_outlet(&news_outlets[i]);
    }

    /* --- Publish --- */
    for (elapsedMillis = 0;
             elapsedMillis < run_seconds * MILLIS_PER_SEC;
             elapsedMillis += PUBLISH_PERIOD_MILLIS) {
        /* --- Publish articles --- */
        for (i = 0; i < num_outlets; ++i) {
            /* Publish the articles at different rates: the first
             * outlet's articles every round, the second outlet's every
             * other, the third's every third, and so on.
             */
            if (elapsedMillis / PUBLISH_PERIOD_MILLIS % (i + 1) == 0) {
                NewsOutlet* news_outlet = &news_outlets[i];
                char temp_article_buffer[128];
                DDS_Boolean published = publish_next_article(
                    temp_article_buffer, 128, news_outlet);
                if (!published) {
                    fprintf(stderr, "! Unable to publish message.\n");
                    goto done;
                }
                if (num_articles == num_articles_allocated) {
                    articles_in_last_status_period = (char**) realloc(
                        articles_in_last_status_period,
                        num_articles_allocated *= 2);
                }
                articles_in_last_status_period[num_articles++] =
                    DDS_String_dup(temp_article_buffer);
            }
        }

        /* --- Print periodic status --- */
        if (elapsedMillis > 0 &&
                elapsedMillis % STATUS_PERIOD_MILLIS == 0) {
            report_articles_published(
                articles_in_last_status_period, num_articles);
            while (num_articles > 0) {
                DDS_String_free(
                    articles_in_last_status_period[num_articles - 1]);
                articles_in_last_status_period[--num_articles] = NULL;
            }
        }

        /* --- Sleep --- */
        /* ...until it's time to publish again. */
        sleep_time.sec = PUBLISH_PERIOD_MILLIS / MILLIS_PER_SEC;
        sleep_time.nanosec = (PUBLISH_PERIOD_MILLIS % MILLIS_PER_SEC) *
                MILLIS_PER_SEC * MILLIS_PER_SEC;
        NDDS_Utility_sleep(&sleep_time);
    }

    /* Print final status: */
    report_articles_published(articles_in_last_status_period, num_articles);

    /* --- Clean up --- */
    pub_success = DDS_BOOLEAN_TRUE;
  done:
    while (num_articles > 0) {
        DDS_String_free(
            articles_in_last_status_period[num_articles - 1]);
        articles_in_last_status_period[--num_articles] = NULL;
    }
    free(articles_in_last_status_period);
    return pub_success;
}
