/*****************************************************************************/
/*         (c) Copyright, Real-Time Innovations, All rights reserved.        */
/*                                                                           */
/*         Permission to modify and use for internal purposes granted.       */
/* This software is provided "as is", without warranty, express or implied.  */
/*                                                                           */
/*****************************************************************************/

#ifndef __HELLO_SUBSCRIBER_H_INCLUDED__
#define __HELLO_SUBSCRIBER_H_INCLUDED__


#include <ndds/ndds_cpp.h>


/* The class containing DDS event callbacks */
class ArticleDeliveryStatusListener: public DDSDataReaderListener {
private:
    const int _verbosity;

public:
    ArticleDeliveryStatusListener(int verbosity);

// ---------------------------------------------------------------------------
// DDSDataReaderListener interface callbacks
public:
    virtual void on_requested_deadline_missed(
            DDSDataReader* reader, 
            const DDS_RequestedDeadlineMissedStatus& status);
    virtual void on_requested_incompatible_qos(
            DDSDataReader* reader, 
            const DDS_RequestedIncompatibleQosStatus& status);
    virtual void on_sample_lost(
            DDSDataReader* reader, 
            const DDS_SampleLostStatus& status);
    virtual void on_sample_rejected(
            DDSDataReader* reader, 
            const DDS_SampleRejectedStatus& status);
    virtual void on_liveliness_changed(
            DDSDataReader* reader, 
            const DDS_LivelinessChangedStatus& status);
    virtual void on_subscription_matched(
            DDSDataReader* reader, 
            const DDS_SubscriptionMatchedStatus& status);
    virtual void on_data_available(DDSDataReader* reader);
};


class NewsSubscriber {
public:
    NewsSubscriber(
            DDSDomainParticipant* participant,
            DDSTopic* topic,
            DDS_Long verbose,
            DDS_Long runSeconds,
            const std::string& contentFilter);

public:
    void readArticles();

private:
    ArticleDeliveryStatusListener _listener;
    DDS_Long _verbosity;
    DDS_Long _runSeconds;
    DDSKeyedStringDataReader* _reader;
};


#endif            /* !defined(__HELLO_SUBSCRIBER_H_INCLUDED__) */
