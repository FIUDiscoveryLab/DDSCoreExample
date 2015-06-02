/****************************************************************************/
/*         (c) Copyright, Real-Time Innovations, All rights reserved.       */
/*                                                                          */
/*         Permission to modify and use for internal purposes granted.      */
/* This software is provided "as is", without warranty, express or implied. */
/*                                                                          */
/****************************************************************************/

#include <iostream>
#include <iomanip>
#include <sstream>
#include <string>
#include <stdexcept>
#include <cstdlib>
#include <time.h>

#include "News.h"
#include "NewsPublisher.h"


/* Manage the data publication for the News example. Several news outlets
 * publish articles periodically but at different rates.
 */

/****************************************************************************/
/* Lifecycle                                                                */
/****************************************************************************/

NewsPublisher::NewsPublisher(
            DDSDomainParticipant* participant,
            DDSTopic* topic,
            DDS_Long verbose,
            DDS_Long runSeconds) : _runSeconds(runSeconds) {
    // --- Create DataWriter --- // 
    /* If you want to customize the writer QoS, use
     * DDSPublisher::get_default_datawriter_qos() to 
     * initialize a local copy of the default QoS, modify them, then
     * use them in the creation call below instead of 
     * DDS_DATAWRITER_QOS_DEFAULT.
     */
    if (verbose) {
        std::cout << "Creating the DataWriter..." << std::endl;
    }
    DDSDataWriter* dataWriter = participant->create_datawriter(
                        topic,
                        DDS_DATAWRITER_QOS_DEFAULT,
                        NULL,           /* listener */
                        DDS_STATUS_MASK_NONE);
    if (dataWriter == NULL) {
        throw std::runtime_error("Unable to create DataWriter");
    }
    /* The following narrow function should never fail, as it performs 
     * only a safe cast of the generic data writer into a specific
     * DDSKeyedStringDataWriter.
     */
    _writer = DDSKeyedStringDataWriter::narrow(dataWriter);
    if (_writer == NULL) {
        throw std::runtime_error(
            "Unable to narrow DataWriter into KeyedStringDataWriter");
    }

    // --- Initialize news outlets --- //
    std::string names[] = {
        "Reuters",
        "AP",
        "CNN",
        "Bloomberg",
        "NY Times",
        "Economist"
    };
    int nNames = sizeof(names) / sizeof(std::string);
    for (int i = 0; i < nNames; ++i) {
        _newsOutlets.push_back(new NewsOutlet(names[i], _writer));
    }

    // --- Register news outlets --- //
    for (unsigned int j = 0; j < _newsOutlets.size(); ++j) {
        _newsOutlets[j]->registerNewsOutlet();
    }
}

NewsPublisher::~NewsPublisher() {
    for (unsigned int i = 0; i < _newsOutlets.size(); ++i) {
        delete _newsOutlets[i];
        _newsOutlets[i] = NULL;
    }
}


/****************************************************************************/
/* Start sending the data.                                                  */
/****************************************************************************/

void reportArticlesPublished(const std::vector<Article>& articlesPublished) {
    if (articlesPublished.empty()) {
        return;
    }

    time_t nowTime = time(NULL);
    tm* lt = localtime(&nowTime);
    std::cout
        << "Articles published in last period as of "
        << lt->tm_hour
        << ":" << std::setw(2) << std::setfill('0') << lt->tm_min
        << ":" << std::setw(2) << std::setfill('0') << lt->tm_sec
        << ':' << std::endl;
    for (std::vector<Article>::const_iterator it = articlesPublished.begin();
            it < articlesPublished.end();
            ++it) {
        Article article = *it;
        std::cout << "    " << article << std::endl;
    }
}

void NewsPublisher::publish() {
    const int MILLIS_PER_SEC = 1000;
    const int PUBLISH_PERIOD_MILLIS = STATUS_PERIOD_MILLIS / 10;

    std::vector<Article> articlesInLastStatusPeriod;
    for (int elapsedMillis = 0;
             elapsedMillis < _runSeconds * MILLIS_PER_SEC;
             elapsedMillis += PUBLISH_PERIOD_MILLIS) {
        // --- Publish articles --- //
        for (unsigned int i = 0; i < _newsOutlets.size(); ++i) {
            /* Publish the articles at different rates: the first
             * outlet's articles every round, the second outlet's every
             * other, the third's every third, and so on.
             */
            if (elapsedMillis / PUBLISH_PERIOD_MILLIS % (i + 1) == 0) {
                NewsOutlet* newsOutlet = _newsOutlets[i];
                Article article = newsOutlet->publishNextArticle();
                articlesInLastStatusPeriod.push_back(article);
            }
        }

        // --- Print periodic status --- //
        if (elapsedMillis > 0 &&
                elapsedMillis % STATUS_PERIOD_MILLIS == 0) {
            reportArticlesPublished(articlesInLastStatusPeriod);
            articlesInLastStatusPeriod.clear();
        }

        // --- Sleep --- //
        // ...until it's time to publish again.
        DDS_Duration_t sleepTime;
        sleepTime.sec = PUBLISH_PERIOD_MILLIS / MILLIS_PER_SEC;
        sleepTime.nanosec = (PUBLISH_PERIOD_MILLIS % MILLIS_PER_SEC) *
                MILLIS_PER_SEC * MILLIS_PER_SEC;
        NDDS_Utility_sleep(&sleepTime);
    }

    // Print final status:
    reportArticlesPublished(articlesInLastStatusPeriod);
}


/****************************************************************************/
/* News Outlets                                                             */
/****************************************************************************/

/* Maximum consecutive write error after stopping the write process. */
#define MAX_CONSECUTIVE_WRITE_ERROR         5


NewsOutlet::NewsOutlet(
            const std::string& theName,
            DDSKeyedStringDataWriter* theWriter)
        : _name(theName),
          _writer(theWriter),
          _handle(DDS_HANDLE_NIL),
          _articleCount(0) {
    // empty
}


Article NewsOutlet::publishNextArticle() {
    // --- Build article text --- //
    std::stringstream articleTextBuffer;
    articleTextBuffer << "lorem ipsum " << ++_articleCount;
    std::string articleText = articleTextBuffer.str();

    // --- Try to publish article --- //
    DDS_ReturnCode_t lastWriteResult;
    for (int i = 0; i < MAX_CONSECUTIVE_WRITE_ERROR; ++i) {
        lastWriteResult = _writer->write(
            _name.c_str(), articleText.c_str(), _handle);
        if (lastWriteResult == DDS_RETCODE_OK) {
            return Article(_name, articleText);
        }
        std::cerr << "! Write error: " << lastWriteResult << std::endl;
    }

    // --- Report publication error --- //
    throw std::runtime_error(
        "Reached maximum number of failures: stopping publishing...");
}

void NewsOutlet::registerNewsOutlet() {
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
    _handle = _writer->register_instance(_name.c_str());
}
