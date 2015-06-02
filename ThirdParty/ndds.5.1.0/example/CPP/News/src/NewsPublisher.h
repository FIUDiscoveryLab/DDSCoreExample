/*****************************************************************************/
/*         (c) Copyright, Real-Time Innovations, All rights reserved.        */
/*                                                                           */
/*         Permission to modify and use for internal purposes granted.       */
/* This software is provided "as is", without warranty, express or implied.  */
/*                                                                           */
/*****************************************************************************/

#ifndef __HELLO_PUBLISHER_H_INCLUDED__
#define __HELLO_PUBLISHER_H_INCLUDED__


#include <vector>
#include <ndds/ndds_cpp.h>

#include "News.h"


class NewsOutlet {
private:
    /* The name of a news outlet. */
    std::string _name;

    /* The writer that publishes the data. */
    DDSKeyedStringDataWriter* _writer;

    /* The handle that helps the middleware locate the instance to which
     * a sample will be published.
     */
    DDS_InstanceHandle_t _handle;

    /* The number of articles this outlet has published. */
    DDS_Long _articleCount;

public:
    NewsOutlet(
        const std::string& theName,
        DDSKeyedStringDataWriter* theWriter);

    Article publishNextArticle();

    void registerNewsOutlet();
};


class NewsPublisher {
public:
    /* Builds a new NewsPublisher object and initialize the inner DDS 
     * entities.
     * 
     * This method only creates the entities; it does not actually publish
     * the data. To publish the data, use the method publish().
     *
     * Parameters:
     *     participant  the DomainParticipant
     *     topic        the Topic 
     *     verbose      the output verbosity
     *     runSeconds   the number of seconds to publish
     */
    NewsPublisher(
            DDSDomainParticipant* participant,
            DDSTopic* topic,
            DDS_Long verbose,
            DDS_Long runSeconds);
    ~NewsPublisher();

public:
    /* Publish articles. */
    void publish();

private:
    /* Articles from these news outlets will be published periodically at
     * different rates.
     */
    std::vector<NewsOutlet*> _newsOutlets;

    DDSKeyedStringDataWriter* _writer;
    DDS_Long _runSeconds;
};


#endif            /* !defined(__HELLO_PUBLISHER_H_INCLUDED__) */
