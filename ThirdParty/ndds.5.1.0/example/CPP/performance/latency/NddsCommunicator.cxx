/*
 (c) Copyright, Real-Time Innovations, $Date: 2012/10/10 17:42:46 $.
 All rights reserved.
 No duplications, whole or partial, manual or electronic, may be made
 without express written permission.  Any such copies, or
 revisions thereof, must display this notice unaltered.
 This code contains trade secrets of Real-Time Innovations, Inc.
*/

/*=======================================================================*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

/*** INTERNAL API: OSAPI, CDR, REDA, CLOCK Headers ***/
#include "osapi/osapi_semaphore.h"
#include "cdr/cdr_type.h"
#include "cdr/cdr_stream.h"
#include "reda/reda_worker.h"
#include "clock/clock_highResolution.h"

#include "LatencyGlobalSettings.hxx"
#include "LatencyPlugin.h"

#include "DataProcessor.hxx"
#include "Communicator.hxx"

#define REPLY_REGARDLESS_OF_COOKIE (255)

DDS_Boolean latency_plugin_use_key_in_message = DDS_BOOLEAN_FALSE;

void latency_plugin_use_keyed_data(DDS_Boolean useKey)
{
  latency_plugin_use_key_in_message = useKey;
}

/* ---------------------------------------------------------------------*/
class SenderEchoListener : public DDSDataReaderListener {
  private:
    LatencyDataProcessor *_data_processor;
    LatencySeq data_seq;
    DDS_SampleInfoSeq info_seq;

    /*** INTERNAL API: RTIOsapiSemaphore ***/
    struct RTIOsapiSemaphore* _sem;
    
  public:
    SenderEchoListener(LatencyDataProcessor *dp,
                       struct RTIOsapiSemaphore* sem)
        : _data_processor(dp),
          _sem(sem)
    {
    }
    virtual ~SenderEchoListener() { } 

    /* DDSDataReaderListener */
    virtual void on_requested_deadline_missed(
        DDSDataReader* /*reader*/,
        const DDS_RequestedDeadlineMissedStatus& /*status*/) {}

    virtual void on_requested_incompatible_qos(
        DDSDataReader* /*reader*/,
        const DDS_RequestedIncompatibleQosStatus& /*status*/);

    virtual void on_sample_rejected(DDSDataReader* /*reader*/,
                        const DDS_SampleRejectedStatus& /*status*/) {}

    virtual void on_liveliness_changed(DDSDataReader* /*reader*/,
        const DDS_LivelinessChangedStatus& /*status*/) {}

    virtual void on_subscription_matched(DDSDataReader* /*reader*/,
        const DDS_SubscriptionMatchedStatus& /*status*/) {}

    virtual void on_sample_lost(DDSDataReader* /*reader*/,
        const DDS_SampleLostStatus& /*status*/) {}

    virtual void on_data_available(DDSDataReader* /*reader*/);
};

/* ---------------------------------------------------------------------*/
void SenderEchoListener::on_requested_incompatible_qos(
        DDSDataReader* reader,
        const DDS_RequestedIncompatibleQosStatus& status)
{
    AppLog_warn("Detected writer with incompatible QoS policy_id = %d\n",
            status.last_policy_id);
    AppLog_warn("            Please verify that you used "
                "the \"-reliable\" flag "
                "consistently in the subscriber\n");
}

/* ---------------------------------------------------------------------*/
/*i called when received echo */
void SenderEchoListener::on_data_available(DDSDataReader* datareader)
{
    LatencyDataReader* reader = LatencyDataReader::narrow(datareader);
    DDS_ReturnCode_t ret_code;

    /* get all the data that the reader has received since the last 'take' */
    ret_code = reader->take(data_seq, info_seq, DDS_LENGTH_UNLIMITED,
                           DDS_ANY_SAMPLE_STATE,
                           DDS_ANY_VIEW_STATE,
                           DDS_ANY_INSTANCE_STATE);

    if (!_data_processor->echo_received()) {
        AppLog_exception("failed to call echo_received\n");
    }

    if (ret_code != DDS_RETCODE_OK) {
        AppLog_exception("failed to access data from the reader\n");
    } else {
        /* Examine every sample returned, but we actually only expect 1 */
        for (int i = 0; i < data_seq.length(); i++) {
            /* Must check the 'valid_data' because for some
               samples the data_seq[i] will be NULL */
            if (info_seq[i].valid_data
                && (data_seq[i].sequence_number
                    == _data_processor->get_sequence_number())) {
                _data_processor->finish_one_issue_recv_thread();
            }
        }
    }

    /* Let the service know the application no longer needs the data and
    ** info buffers
    */
    reader->return_loan(data_seq, info_seq);
    RTIOsapiSemaphore_give(_sem);
}

/* ---------------------------------------------------------------------*/
/* ---------------------------------------------------------------------*/
class ReceiverDataListener : public DDSDataReaderListener {
    
  private:
    /* Data declarations */
    Latency _instance;
    LatencySeq data_seq;
    DDS_SampleInfoSeq info_seq;
    DDS_InstanceHandle_t _instance_handle;
    LatencyDataWriter* _writer;
    DDS_Long _sequence_number;
    int _cookie;
    int _num_messages;
    int _num_replies;
    
  public:
    ReceiverDataListener( int cookie )
        : _instance_handle(DDS_HANDLE_NIL),
          _writer(NULL),
          _sequence_number(0),
          _cookie(cookie),
          _num_messages(0),
          _num_replies(0)
    {}
    virtual ~ReceiverDataListener() {} 

    /* DDSDataReaderListener */
    virtual void on_requested_deadline_missed(
        DDSDataReader* /*reader*/,
        const DDS_RequestedDeadlineMissedStatus& /*status*/) {}

    virtual void on_requested_incompatible_qos(
        DDSDataReader* /*reader*/,
        const DDS_RequestedIncompatibleQosStatus& /*status*/);

    virtual void on_sample_rejected(DDSDataReader* /*reader*/,
                        const DDS_SampleRejectedStatus& /*status*/) {}

    virtual void on_liveliness_changed(DDSDataReader* /*reader*/,
        const DDS_LivelinessChangedStatus& /*status*/) {}

    virtual void on_sample_lost(DDSDataReader* /*reader*/,
        const DDS_SampleLostStatus& /*status*/) {}

    virtual void on_data_available(DDSDataReader* /*reader*/);

    void set_writer(LatencyDataWriter* writer) { _writer = writer; }

    int num_messages() { return _num_messages; }
    int num_replies() { return _num_replies; }
    
    /* test is finished if the sn received is FINAL */
    DDS_Boolean has_received_sentinel() { 
        return _sequence_number == FINAL_SEQUENCE_NUMBER; 
    }
};


/* ---------------------------------------------------------------------*/
void ReceiverDataListener::on_requested_incompatible_qos(
        DDSDataReader* reader,
        const DDS_RequestedIncompatibleQosStatus& status)
{
    AppLog_warn("Detected writer with incompatible QoS policy_id = %d\n",
            status.last_policy_id);
    AppLog_warn("            Please verify that you used "
                "the \"-reliable\" flag "
                "consistently in the publisher\n");
}

/* ---------------------------------------------------------------------*/
void ReceiverDataListener::on_data_available(DDSDataReader* datareader)
{
    LatencyDataReader* reader = LatencyDataReader::narrow(datareader);
    DDS_ReturnCode_t ret_code;
 
    /* get all the data that the reader has received since the last 'take' */
    ret_code = reader->take(data_seq, info_seq, DDS_LENGTH_UNLIMITED,
                           DDS_ANY_SAMPLE_STATE,
                           DDS_ANY_VIEW_STATE,
                           DDS_ANY_INSTANCE_STATE);

    if (ret_code != DDS_RETCODE_OK) {
        AppLog_exception("failed to access data from the reader\n");
    } else {
        /* Examine every sample returned */
        for (int i = 0; i < data_seq.length(); i++) {

            /* Must check the 'valid_data' because for some
               samples the data_seq[i] will be NULL */
            if (info_seq[i].valid_data) {
                _sequence_number = data_seq[i].sequence_number;
                _instance.sequence_number = _sequence_number;
                _instance.data.loan_contiguous(data_seq[i].data.
                                               get_contiguous_bufferI(),
                                               data_seq[i].data.length(),
                                               data_seq[i].data.maximum());
                if ((_writer) &&
                    ((data_seq[i].data[0] 
                      == LATENCY_RESTRICT_RECV_COOKIE_NONE) ||
                     (data_seq[i].data[0] == _cookie))) {
                    /* echo back to the originator */
                    ret_code = _writer->write(_instance, _instance_handle); 
                    if (ret_code != DDS_RETCODE_OK) {
                        AppLog_exception("failed to send data\n");
                    }
                    ++_num_replies;
                }      
                ++_num_messages;           
                _instance.data.unloan();/* return loan */
            }
        }
    }

    /* Let the service know the application no longer needs the data and
    ** info buffers
    */
    reader->return_loan(data_seq, info_seq);
}


/* ---------------------------------------------------------------------*/
/* ---------------------------------------------------------------------*/
class SenderWriterListener : public DDSDataWriterListener {
  private:
    DDS_InstanceHandle_t _subscription_handle[LATENCY_MAX_SUBSCRIPTIONS];
    int _matched_subs_count;
    
  public:
    SenderWriterListener() : _matched_subs_count(0) {}
    virtual ~SenderWriterListener() {} 

    virtual void on_publication_matched(DDSDataWriter* /*reader*/,
        const DDS_PublicationMatchedStatus& /*status*/);

    DDS_InstanceHandle_t get_discovered_subscription_handle(int index);

   /* DDSDataWriterListener */
    virtual void on_offered_deadline_missed(DDSDataWriter* writer, 
        const DDS_OfferedDeadlineMissedStatus& status) {}
  
    virtual void on_liveliness_lost(DDSDataWriter* writer, 
        const DDS_LivelinessLostStatus& status) {}
    
    virtual void on_offered_incompatible_qos(DDSDataWriter* writer, 
        const DDS_OfferedIncompatibleQosStatus& status) {}

    virtual void on_reliable_writer_cache_changed(DDSDataWriter* writer,
        const DDS_ReliableWriterCacheChangedStatus& status) {}

    virtual void on_reliable_reader_activity_changed(DDSDataWriter* writer,
        const DDS_ReliableReaderActivityChangedStatus& status) {}
};


/* ---------------------------------------------------------------------*/
DDS_InstanceHandle_t 
SenderWriterListener::get_discovered_subscription_handle(int order)
{
    if ((order < 0) || (order >= _matched_subs_count)) {
        return DDS_HANDLE_NIL;
    }
    
    return _subscription_handle[order];
}

/* ---------------------------------------------------------------------*/
void SenderWriterListener::on_publication_matched(DDSDataWriter* writer,
        const DDS_PublicationMatchedStatus& status)
{
    DDS_SubscriptionBuiltinTopicData subscription_data;
    DDS_ReturnCode_t ret_code;

    if (status.total_count_change <= 0) {
        /* unmatched */
        return;
    }
    
    AppLog_warn("[%d]", status.current_count); 

    /* Save the order in which it was discovered as this indicates
    ** the order in which data will be sent
    */
    subscription_data.topic_name = DDS_String_alloc(256);
    subscription_data.type_name  = DDS_String_alloc(256);
    ret_code = writer->get_matched_subscription_data(
                                        subscription_data,
                                        status.last_subscription_handle);
    if (ret_code != DDS_RETCODE_OK ) {
        AppLog_exception("failed in get_matched_subscription_data()\n");
        return;
    }
    
    _subscription_handle[_matched_subs_count++] = 
        status.last_subscription_handle;
}


/* ---------------------------------------------------------------------*/
/* ---------------------------------------------------------------------*/
RtiDdsCommunicator::RtiDdsCommunicator(int domain_id, int index,
                                       char* peer, char* nic,
                                       NDDS_Transport_ClassId_t transport_id,
                                       DDS_Boolean is_reliable,
                                       DDS_Boolean receive_on_multicast, 
                                       int multicast_ttl,
                                       DDS_Boolean use_key_in_topic,
                                       int recv_thread_priority, 
                                       int event_thread_priority, 
                                       int db_thread_priority, 
                                       DDS_Boolean is_ready)
    : Communicator(recv_thread_priority,  
                   receive_on_multicast, multicast_ttl, is_ready),
    _domain_id(domain_id),
    _index(index),
    _peer(peer),
    _nic(nic),
    _is_reliable(is_reliable),
    _receive_on_multicast(receive_on_multicast),
    _use_key_in_topic(use_key_in_topic),
    _event_thread_priority(event_thread_priority),
    _db_thread_priority(db_thread_priority),
    _transport_id(transport_id)
{
}

/* ---------------------------------------------------------------------*/
/* ---------------------------------------------------------------------*/
DDS_Boolean RtiDdsCommunicator::send_data( )
{
    DDS_ReturnCode_t ret_code;

    ret_code = _writer->write(*_send_instance, _instance_handle );
    return (ret_code == DDS_RETCODE_OK);
}

/* ---------------------------------------------------------------------*/
DDS_Boolean RtiDdsCommunicator::needs_receiver_thread()
{
    return DDS_BOOLEAN_FALSE;
}

/* ---------------------------------------------------------------------*/
DDS_Boolean RtiDdsCommunicator::configure_udpv4_transport()
{
    /* Instantiate own transport before multicast reader is created, 
    ** rather than waiting for built-in transport, to enable
    ** multicast, as built-in transport is not created before multicast reader
    */
    struct NDDS_Transport_UDPv4_Property_t udpv4_property
        = NDDS_TRANSPORT_UDPV4_PROPERTY_DEFAULT;
 
    const char* ALIASES[] = {"My.udpv4"};
    const long ALIASES_LENGTH = sizeof(ALIASES)/sizeof(const char*);
    DDS_StringSeq alias_seq;

    /* Initialize the aliases StringSeq */
    if(!alias_seq.from_array(ALIASES, ALIASES_LENGTH)) {
        AppLog_exception("failed to initialize transport aliases\n");
        return DDS_BOOLEAN_FALSE;
    }

    if (NDDSTransportSupport::get_builtin_transport_property(
        _participant, DDS_TRANSPORTBUILTIN_UDPv4,
        (struct NDDS_Transport_Property_t&)udpv4_property) 
        != DDS_RETCODE_OK) {

        AppLog_exception("failed to get default UDPv4 transport property\n");
        return DDS_BOOLEAN_FALSE;
    }

    if(_nic) { /* Use the designated interface */
        udpv4_property.parent.allow_interfaces_list_length = 1; 
        udpv4_property.parent.allow_interfaces_list = &_nic;
    }

    udpv4_property.parent.message_size_max = 
        MAX_DATA_SEQUENCE_LENGTH + 8 + RTI_DDS_OVERHEAD;
    udpv4_property.send_socket_buffer_size
            = udpv4_property.parent.message_size_max;
    udpv4_property.recv_socket_buffer_size
            = 2 * udpv4_property.send_socket_buffer_size;
    udpv4_property.multicast_ttl = _multicast_ttl;

    AppLog_warn("UDP enabled. Socket sendBuffer size = %d, "
                "receiveBuffer size = %d.\n",
                udpv4_property.send_socket_buffer_size,
                udpv4_property.recv_socket_buffer_size);

    /* Check that the UDP transport can handle the message size */
    if ((MAX_DATA_SEQUENCE_LENGTH + RTI_DDS_OVERHEAD + 8) > 64 * 1024) {
        AppLog_warn("***Warning: Maximum payload size %d "
                    "Bytes plus NDDS overhead of"
                    "%d Bytes exceeds\n"
                    "            capabilities of UDP transport. "
                    "Errors will occur if "
                       "payloads\n"
                    "            that approximate or exceed %d "
                    "Bytes are sent\n",
                       MAX_DATA_SEQUENCE_LENGTH, RTI_DDS_OVERHEAD + 8,
                    64*1024 -  RTI_DDS_OVERHEAD - 8);
    }

    if (NDDSTransportSupport::set_builtin_transport_property(
        _participant, DDS_TRANSPORTBUILTIN_UDPv4,
        (struct NDDS_Transport_Property_t&)udpv4_property) 
        != DDS_RETCODE_OK) {

        AppLog_exception("failed to get default udpv4 transport property\n");
        return DDS_BOOLEAN_FALSE;
    }

    AppLog_warn("UDPv4 enabled\n"); 

    return DDS_BOOLEAN_TRUE;
}

#ifdef RTI_SHARED_MEMORY
/* ---------------------------------------------------------------------*/
DDS_Boolean RtiDdsCommunicator::configure_shmem_transport()
{

    struct NDDS_Transport_Shmem_Property_t shmem_property
        = NDDS_TRANSPORT_SHMEM_PROPERTY_DEFAULT;

    if (NDDSTransportSupport::get_builtin_transport_property(
        _participant, DDS_TRANSPORTBUILTIN_SHMEM,
       (struct NDDS_Transport_Property_t&)shmem_property) 
        != DDS_RETCODE_OK) {

        AppLog_exception("failed to get default shmem transport property\n");
        return DDS_BOOLEAN_FALSE;
    }

    shmem_property.parent.message_size_max = 
        MAX_DATA_SEQUENCE_LENGTH + 8 + RTI_DDS_OVERHEAD;
    /* shmem_property.received_message_count_max = 3; */
    shmem_property.receive_buffer_size
            = (shmem_property.received_message_count_max
                * shmem_property.parent.message_size_max);

    if (NDDSTransportSupport::set_builtin_transport_property(
        _participant, DDS_TRANSPORTBUILTIN_SHMEM,
        (struct NDDS_Transport_Property_t&)shmem_property) 
        != DDS_RETCODE_OK) {

        AppLog_exception("failed to get default shmem transport property\n");
        return DDS_BOOLEAN_FALSE;
    }
    AppLog_warn("Shared Memory enabled. ReceiveBuffer size = %d\n",
            shmem_property.receive_buffer_size); 

    return DDS_BOOLEAN_TRUE;
}
#endif/*RTI_SHARED_MEMORY*/

#ifdef RTI_IPV6
/* ---------------------------------------------------------------------*/
DDS_Boolean RtiDdsCommunicator::configure_udpv6_transport()
{
    /* Instantiate own transport before multicast reader is created, 
    ** rather than waiting for built-in transport, to enable
    ** multicast, as built-in transport is not created before multicast reader
    */
    struct NDDS_Transport_UDPv6_Property_t udpv6_property
        = NDDS_TRANSPORT_UDPV6_PROPERTY_DEFAULT;
 
    const char* ALIASES[] = {"My.udpv6"};
    const long ALIASES_LENGTH = sizeof(ALIASES)/sizeof(const char*);
    DDS_StringSeq alias_seq;
    /* addresses are the full 128 bits */
    NDDS_Transport_Address_t network_address = 
        {{0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0}};

    /* Initialize the aliases StringSeq */
    if(!alias_seq.from_array(ALIASES, ALIASES_LENGTH)) {
        AppLog_exception("failed to initialize transport aliases\n");
        return DDS_BOOLEAN_FALSE;
    }

    if (NDDSTransportSupport::get_builtin_transport_property(
        _participant, DDS_TRANSPORTBUILTIN_UDPv6,
        (struct NDDS_Transport_Property_t&)udpv6_property) != DDS_RETCODE_OK) {
        AppLog_exception("failed to get default UDPv6 transport property\n");
        return DDS_BOOLEAN_FALSE;
    }

    if(_nic) { /* Use the designated interface */
        udpv6_property.parent.allow_interfaces_list_length = 1; 
        udpv6_property.parent.allow_interfaces_list = &_nic;
    }

    udpv6_property.parent.message_size_max = 
        MAX_DATA_SEQUENCE_LENGTH + 8 + RTI_DDS_OVERHEAD;
    udpv6_property.send_socket_buffer_size
            = udpv6_property.parent.message_size_max;
    udpv6_property.recv_socket_buffer_size
            = 2 * udpv6_property.send_socket_buffer_size;
    udpv6_property.multicast_ttl = _multicast_ttl;

    AppLog_warn("UDP enabled. Socket sendBuffer size = %d, "
                "receiveBuffer size = %d.\n",
                udpv6_property.send_socket_buffer_size,
                udpv6_property.recv_socket_buffer_size);

    /* Check that the UDP transport can handle the message size */
    if ((MAX_DATA_SEQUENCE_LENGTH + RTI_DDS_OVERHEAD + 8) > 64 * 1024) {
        AppLog_warn("***Warning: Maximum payload size %d "
                    "Bytes plus NDDS overhead of"
                    "%d Bytes exceeds\n"
                    "            capabilities of UDP transport. "
                    "Errors will occur if "
                    "payloads\n"
                    "            that approximate or exceed %d "
                    "Bytes are sent\n",
                    MAX_DATA_SEQUENCE_LENGTH, RTI_DDS_OVERHEAD + 8,
                    64*1024 -  RTI_DDS_OVERHEAD - 8);
    }

    if (NDDSTransportSupport::set_builtin_transport_property(
        _participant, DDS_TRANSPORTBUILTIN_UDPv6,
        (struct NDDS_Transport_Property_t&)udpv6_property) 
        != DDS_RETCODE_OK) {

        AppLog_exception("failed to get default shmem transport property\n");
        return DDS_BOOLEAN_FALSE;
    }
    AppLog_warn("UDPv6 enabled\n"); 

    return DDS_BOOLEAN_TRUE;
}
#endif/*RTI_IPV6*/
/* ---------------------------------------------------------------------*/
DDS_Boolean 
RtiDdsCommunicator::create_dds_entities(const struct Latency *instance,
                                        const char *reader_mcast_address,
                                        const char *send_topic_name,
                                        const char *recv_topic_name)
{
    DDS_DomainParticipantFactoryQos factory_qos;         
    DDS_DomainParticipantQos participant_qos;
    DDS_SubscriberQos subscriber_qos;
    DDS_PublisherQos publisher_qos;
    DDS_DataReaderQos reader_qos;
    DDS_DataWriterQos writer_qos;
    DDS_TopicQos topic_qos;

    /* DomainParticipantFactory declarations */
    DDSDomainParticipantFactory* factory = NULL;
    DDSDataWriter* tmp_writer;

    /* Data declarations */
    _send_instance = instance;

    NDDSConfigLogger* logger = NDDSConfigLogger::get_instance();

    /*-------------------------- create dds entities ---------------------*/

    /* get handle to participant factory */
    factory = DDSDomainParticipantFactory::get_instance();
    if (factory == NULL) {
        AppLog_exception("failed to get domain participant factory\n");
        return DDS_BOOLEAN_FALSE;
    }
    /* Do not auto enable participants upon creation since we want to register
       transport plugins */
    factory->get_qos(factory_qos);
    factory_qos.entity_factory.autoenable_created_entities = DDS_BOOLEAN_FALSE;

    if (factory->set_qos(factory_qos) != DDS_RETCODE_OK) {
        AppLog_exception("failed to set factory QoS\n");
        return DDS_BOOLEAN_FALSE;
    }    
    
    /* initialize participant_qos with default values */
    factory->get_default_participant_qos(participant_qos);

    participant_qos.resource_limits.writer_user_data_max_length = 128;

    participant_qos.receiver_pool.buffer_size = 
        MAX_DATA_SEQUENCE_LENGTH + 8 + RTI_DDS_OVERHEAD;

    /* Set thread priorities as requested */
    if ( _recv_thread_priority != DEFAULT_THREAD_PRIORITY ) {
        AppLog_warn("Modifying RTI DDS receive thread priorities "
                    "from priority = %d to %d\n",
                    participant_qos.receiver_pool.thread.priority,
                    _recv_thread_priority);
        participant_qos.receiver_pool.thread.priority = _recv_thread_priority;
    }
    if ( _db_thread_priority != DEFAULT_THREAD_PRIORITY ) { 
        AppLog_warn("Modifying RTI DDS database thread priorities "
                    "from priority = %d to %d\n",
                    participant_qos.database.thread.priority,
                    _db_thread_priority);
        participant_qos.database.thread.priority = _db_thread_priority;
    }
    if ( _event_thread_priority != DEFAULT_THREAD_PRIORITY ) {
        AppLog_warn("Modifying RTI DDS event thread priorities "
                    "from priority = %d to %d\n",
                    participant_qos.event.thread.priority,
                    _event_thread_priority);
        participant_qos.event.thread.priority = _event_thread_priority;
    }


    /* The builtin transport masks must be set before creating the participant
       We create our own transports, except for shmem
     */
    participant_qos.transport_builtin.mask = _transport_id;

    if((_transport_id == DDS_TRANSPORTBUILTIN_UDPv4 ||
        _transport_id == DDS_TRANSPORTBUILTIN_UDPv6) &&
        /* Check that the UDP transport can handle the message size */
        (MAX_DATA_SEQUENCE_LENGTH + RTI_DDS_OVERHEAD + 8) > 64*1024) {
        AppLog_warn("***Warning: Maximum payload size %d "
                    "Bytes plus NDDS overhead of"
                    "%d Bytes exceeds\n"
                    "            capabilities of UDP transport. "
                    "Errors will occur if "
                    "payloads\n"
                    "            that approximate or exceed %d "
                    "Bytes are sent\n",
                    MAX_DATA_SEQUENCE_LENGTH, RTI_DDS_OVERHEAD + 8,
                    64*1024 -  RTI_DDS_OVERHEAD - 8);
    }

    participant_qos.discovery_config.
        participant_liveliness_assert_period.sec = 61;
    participant_qos.discovery_config.
        participant_liveliness_lease_duration.sec = 128;

    if(_peer &&
       _peer[0] != 0) {/* If NULL, get from env var or file */
        const char* peer_array[LATENCY_MAX_SUBSCRIPTIONS];
        char* ptr = _peer;
        int peer_count = 1;
        peer_array[0] = _peer;
        while((ptr = strchr(ptr, ',')) &&
              (peer_count < LATENCY_MAX_SUBSCRIPTIONS)) {

            *ptr = 0;
            peer_array[peer_count] = ++ptr;
            ++peer_count;
        }
        participant_qos.discovery.
            initial_peers.from_array(peer_array, peer_count);

        participant_qos.discovery.multicast_receive_addresses.ensure_length(0,0);
    }

    /* create participant. 
    ** Defer enable till builtin transports are configured 
    */
    _participant = factory->create_participant(_domain_id,
                                               participant_qos,
                                               NULL /* listener */,
                                               DDS_STATUS_MASK_NONE);
    if (_participant == NULL) {
        AppLog_exception("failed to create domain participant\n");
        return DDS_BOOLEAN_FALSE;
    }
    logger->set_verbosity(NDDS_CONFIG_LOG_VERBOSITY_ERROR);

    switch(_transport_id) {
      case DDS_TRANSPORTBUILTIN_UDPv4:
        configure_udpv4_transport();
        break;
#ifdef RTI_SHARED_MEMORY
      case DDS_TRANSPORTBUILTIN_SHMEM:
        configure_shmem_transport();
        break;
#endif/*RTI_SHARED_MEMORY*/
#ifdef RTI_IPV6
      case DDS_TRANSPORTBUILTIN_UDPv6:
        configure_udpv6_transport();
        break;
#endif/*RTI_IPV6*/
      default:
        AppLog_exception("unexpected transport %#X\n", _transport_id);
        return DDS_BOOLEAN_FALSE;
    }

    /*----------------------------------------------------------------------
      Create a publisher and a subsciber, both with default QoSes.
      ----------------------------------------------------------------------*/

    /* initialize subscriber_qos with default values */
    _participant->get_default_subscriber_qos(subscriber_qos);

    /* optionally modify subscriber qos values */

    /* create and enable subscriber */
    _subscriber = _participant->create_subscriber(subscriber_qos,
                                                  NULL /* listener */,
                                                  DDS_STATUS_MASK_NONE);
    if (_subscriber == NULL) {
        AppLog_exception("failed to create subscriber\n");
        return DDS_BOOLEAN_FALSE;
    }

    /* initialize publisher_qos with default values */
    _participant->get_default_publisher_qos(publisher_qos);

    /* optionally modify publisher qos values here */

    /* create and enable publisher */
    _publisher = _participant->create_publisher(publisher_qos,
                                                NULL /* listener */,
                                                DDS_STATUS_MASK_NONE);
    if (_publisher == NULL) {
        AppLog_exception("failed to create publisher\n");
        return DDS_BOOLEAN_FALSE;
    }

   /*--------------------------------------------------------------------
     Register data types, and create topics: recvTopic and sendTopic
     --------------------------------------------------------------------*/
    latency_plugin_use_keyed_data(_use_key_in_topic);
    LatencyTypeSupport::register_type(_participant, LATENCY_TYPE_NAME);

    /* initialize topic_qos with default values */
    _participant->get_default_topic_qos(topic_qos);
    
    /* Optionally create the topic to send. In the one-to-many
       test all receivers except for one do not reply to the messages */
    _send_topic = NULL;
    if (send_topic_name != NULL) {
        _send_topic = _participant->create_topic(
                                        send_topic_name, LATENCY_TYPE_NAME,
                                        topic_qos, NULL /* listener */, 
                                        DDS_STATUS_MASK_NONE);
        if (_send_topic == NULL) {
            AppLog_exception("failed to create data topic\n");
            return DDS_BOOLEAN_FALSE;
        }
    }

    _recv_topic = _participant->create_topic(recv_topic_name, 
                                             LATENCY_TYPE_NAME,
                                             topic_qos, 
                                             NULL /* listener */, 
                                             DDS_STATUS_MASK_NONE);
    if (_recv_topic == NULL) {
        AppLog_exception("failed to create echo topic\n");
        return DDS_BOOLEAN_FALSE;
    }    

    /*---------------------------------------------------------------------
      Create one data writer: 
    -----------------------------------------------------------------------*/
    _writer = NULL;
    if (_send_topic != NULL) {
        /* initialize writer_qos with default values */
        _publisher->get_default_datawriter_qos(writer_qos);

        writer_qos.history.kind = DDS_KEEP_LAST_HISTORY_QOS;
        writer_qos.history.depth = 1;
        if(!_is_reliable) { /* writer is reliable by default */
            writer_qos.reliability.kind = DDS_BEST_EFFORT_RELIABILITY_QOS;
        } else {
            writer_qos.resource_limits.initial_samples =
                writer_qos.resource_limits.max_samples =
                writer_qos.resource_limits.max_samples_per_instance = 3;
            /* Set immediate reader repair response time */
            writer_qos.protocol.rtps_reliable_writer.
                max_nack_response_delay.nanosec = 0;
            writer_qos.protocol.rtps_reliable_writer.
                max_nack_response_delay.sec = 0;

            /* Use impatient reliability */
            writer_qos.reliability.max_blocking_time.sec = 1;
            writer_qos.reliability.max_blocking_time.nanosec = 0;
            writer_qos.protocol.rtps_reliable_writer.
                fast_heartbeat_period.sec = 0;
            writer_qos.protocol.rtps_reliable_writer.
                fast_heartbeat_period.nanosec =
              1 * 1000000; /* 1 ms */
            writer_qos.protocol.rtps_reliable_writer.heartbeat_period.sec =
                3600 * 24 * 7; /* 1 week */

            /* because the queue is 1, want to piggyback HB w/ every sample.
               This may be duplicate HB's, but since the rate is low, it's OK
            */
            writer_qos.protocol.rtps_reliable_writer.
                heartbeats_per_max_samples =
                    (writer_qos.resource_limits.max_samples > 1)
                    ? writer_qos.resource_limits.max_samples
                    : 100000000; 
        }
        
        /* create and enable writer. use sendTopic. */
        tmp_writer = _publisher->create_datawriter(_send_topic, writer_qos,
                                                  NULL/* listenr */,
                                                  DDS_STATUS_MASK_NONE);
        if (tmp_writer == NULL) {
            AppLog_exception("failed to create writer\n");
            return DDS_BOOLEAN_FALSE;
        }

        _writer = LatencyDataWriter::narrow(tmp_writer);
        if (_writer == NULL) {
            AppLog_exception("failed to narrow to LatencyDataWriter\n");
            return DDS_BOOLEAN_FALSE;
        }

        /* For better performance register the instance to get the handle */
        _instance_handle = DDS_HANDLE_NIL;
    }

    /*----------------------------------------------------------------------
      Always create a data-reader
      ----------------------------------------------------------------------*/ 
    /* initialize reader_qos with default values */
    _subscriber->get_default_datareader_qos(reader_qos);
    
    if (_is_reliable) { /* reader is BE by default */
        reader_qos.reliability.kind = DDS_RELIABLE_RELIABILITY_QOS;
        reader_qos.protocol.rtps_reliable_reader.
            max_heartbeat_response_delay.sec     = 0;
        reader_qos.protocol.rtps_reliable_reader.
            max_heartbeat_response_delay.nanosec = 0;
    }

    if (_receive_on_multicast) {
        reader_qos.multicast.value.ensure_length(1,1);
        /* must use strdup() to avoid crash at end */
        reader_qos.multicast.value[0].receive_address
          = DDS_String_dup(reader_mcast_address);
    }
    reader_qos.history.kind = DDS_KEEP_LAST_HISTORY_QOS;
    reader_qos.history.depth = 1;

    /* create and enable reader. use recvTopic. */
    _reader = _subscriber->create_datareader(_recv_topic, reader_qos,
                                             NULL, DDS_STATUS_MASK_NONE);

    return DDS_BOOLEAN_TRUE;
}

/* ---------------------------------------------------------------------*/
DDS_Boolean RtiDdsCommunicator::cleanup_sender()
{
    /* Delete all DDS entities created in the prepare */
    DDSDomainParticipantFactory* factory =
            DDSDomainParticipantFactory::get_instance();
    DDS_Boolean ok = DDS_BOOLEAN_TRUE;

    /*------------------------ tear down dds entities ----------------------*/
    ok = ((_subscriber->delete_datareader(_reader) == DDS_RETCODE_OK) && 
          ok);

    if (_writer != NULL) {
        ok = ((_publisher->
               delete_datawriter(_writer) == DDS_RETCODE_OK) && ok);
    }
    ok = ((_participant->
           delete_topic(_recv_topic) == DDS_RETCODE_OK) && ok);
    ok = ((_participant->
           delete_topic(_send_topic) == DDS_RETCODE_OK) && ok);
    ok = ((_participant->
           delete_subscriber(_subscriber) == DDS_RETCODE_OK) && ok);
    ok = ((_participant->
           delete_publisher(_publisher) == DDS_RETCODE_OK) && ok);
    ok = ((factory->
           delete_participant(_participant) == DDS_RETCODE_OK) && ok);

    return ok;
}


/* ---------------------------------------------------------------------*/
DDS_Boolean RtiDdsSenderCommunicator::is_ready()
{
    DDS_PublicationMatchedStatus status;
    
    _writer->get_publication_matched_status(status);
    return (status.current_count >= _subscribers);
}

/* ---------------------------------------------------------------------*/
int RtiDdsSenderCommunicator::get_echoer_cookie()
{
    DDS_SubscriptionBuiltinTopicData subscription_data;
    int cookie;
    DDS_ReturnCode_t ret_code;
    DDS_InstanceHandle_t handle;
    
    if (_subscribers > 0) {
        return _subscribers;
    }
    
    handle = _data_writer_listener->get_discovered_subscription_handle(
        _subscribers);
    if (DDS_InstanceHandle_is_nil(&handle)) {
        AppLog_exception("could not find the subscription with cookie %d\n",
                         _subscribers);
        return LATENCY_RESTRICT_RECV_COOKIE_NONE;
    }
        
    subscription_data.topic_name = DDS_String_alloc(256);
    subscription_data.type_name  = DDS_String_alloc(256);
    ret_code = _writer->get_matched_subscription_data(subscription_data, 
                                                      handle);
    if (ret_code != DDS_RETCODE_OK) {
        AppLog_exception("could not get matched subscription data\n");
        return LATENCY_RESTRICT_RECV_COOKIE_NONE;
    }
    cookie = subscription_data.user_data.value[0];
    
    return cookie;
}

/* ---------------------------------------------------------------------*/
DDS_Boolean RtiDdsSenderCommunicator::prepare(
    struct Latency *instance,
    char* mcast_recv_addr,
    class LatencyDataProcessor *data_processor)
{
    DDS_ReturnCode_t ret_code = DDS_RETCODE_ERROR;
    DDS_DataWriterQos writer_qos;

    /* Use participant index = 0 for sender */
    if (!create_dds_entities(instance, 
                             mcast_recv_addr,
                             LATENCY_DATA_TOPIC_NAME,
                             LATENCY_ECHO_TOPIC_NAME)) {
        return DDS_BOOLEAN_FALSE;
    }

    /*** INTERNAL API: RTIOsapiSemaphore_XXX ***/
    sem = RTIOsapiSemaphore_new(RTI_OSAPI_SEMAPHORE_KIND_BINARY, NULL);

    /* Listener declarations */
    _echo_reader_listener = new SenderEchoListener(data_processor, sem);

     /* setup reader to access received data via a listener 
       explicitly specify which operations in the listener are
       activated for callback
    */
    ret_code = _reader->set_listener(_echo_reader_listener, 
                                     DDS_DATA_AVAILABLE_STATUS |
                                     DDS_REQUESTED_INCOMPATIBLE_QOS_STATUS);
    if (ret_code != DDS_RETCODE_OK) {
        AppLog_exception("failed to set echo reader listener\n");
    }


    _data_writer_listener = new SenderWriterListener();

    /* Setup reader to access received data via a listener. 
    ** Explicitly specify which operations in the listener are
    ** activated for callback
    */
    ret_code = 
        _writer->set_listener(_data_writer_listener, DDS_STATUS_MASK_ALL);
    if (ret_code != DDS_RETCODE_OK) {
        AppLog_exception("failed to set data writer listener\n");
    }
    
    _writer->get_qos(writer_qos);
    writer_qos.user_data.value.ensure_length(1, 1);
    writer_qos.user_data.value[0] = _subscribers;
 
    if(writer_qos.protocol.rtps_reliable_writer.
       fast_heartbeat_period.sec == -1)
    {
        writer_qos.protocol.rtps_reliable_writer.fast_heartbeat_period.sec 
            = writer_qos.protocol.rtps_reliable_writer.heartbeat_period.sec;
    }
    
    ret_code = _writer->set_qos(writer_qos);
    if ( ret_code != DDS_RETCODE_OK) {
        AppLog_exception("failed to modify writer qos\n");
        return DDS_BOOLEAN_FALSE;
    }

    /* now bring up the participant */
    ret_code = _participant->enable();
    if (ret_code != DDS_RETCODE_OK) {
        AppLog_exception("failed to enable participant\n");
        return DDS_BOOLEAN_FALSE;
    }

    return DDS_BOOLEAN_TRUE;
}


RtiDdsSenderCommunicator::~RtiDdsSenderCommunicator()
{
    /*** INTERNAL API: RTIOsapiSemaphore_XXX ***/
    RTIOsapiSemaphore_delete(sem);

    if (_data_writer_listener != NULL) {
        delete _data_writer_listener;
    }

    if (_echo_reader_listener != NULL) {
        delete _echo_reader_listener;
    }
}
/* ---------------------------------------------------------------------*/
RtiDdsSenderCommunicator::RtiDdsSenderCommunicator(
    int domain_id, char* peer, char* nic,
    NDDS_Transport_ClassId_t transport_id,
    DDS_Boolean is_reliable, 
    DDS_Boolean receive_on_multicast, 
    int multicast_ttl,
    DDS_Boolean use_key_in_topic,
    int recv_thread_priority, 
    int event_thread_priority, 
    int db_thread_priority,
    DDS_Boolean is_ready, int subscribers)  
    : RtiDdsCommunicator(domain_id, 0, peer, 
                         nic, transport_id,
                         is_reliable, 
                         receive_on_multicast, 
                         multicast_ttl,
                         use_key_in_topic,
                         recv_thread_priority, 
                         event_thread_priority, 
                         db_thread_priority, 
                         is_ready),
    sem(NULL)
{
    _subscribers = subscribers;
}

/* ---------------------------------------------------------------------*/
RtiDdsReceiverCommunicator::RtiDdsReceiverCommunicator(
    int domain_id, int index, char* peer, char* nic,
    NDDS_Transport_ClassId_t transport_id,
    DDS_Boolean is_reliable,
    DDS_Boolean receive_on_multicast, int multicast_ttl,
    DDS_Boolean use_key_in_topic,
    int recv_thread_priority, 
    int event_thread_priority, 
    int db_thread_priority,
    int cookie, DDS_Boolean echoDisabled)
    : RtiDdsCommunicator(domain_id, index, peer, nic, transport_id,
                         is_reliable, receive_on_multicast, multicast_ttl,
                         use_key_in_topic,
                         recv_thread_priority, 
                         event_thread_priority, 
                         db_thread_priority,
                         DDS_BOOLEAN_TRUE /* receiver is always ready */ )
{
    _cookie = cookie;
    _echo_disabled = echoDisabled;
}

/* ---------------------------------------------------------------------*/
DDS_Boolean RtiDdsReceiverCommunicator::has_received_sentinel()
{
    return _data_listener->has_received_sentinel();
}

/* ---------------------------------------------------------------------*/
int RtiDdsReceiverCommunicator::recv_message_count() 
{ 
    return _data_listener->num_messages();    
}

/* ---------------------------------------------------------------------*/
int RtiDdsReceiverCommunicator::sent_message_count() 
{ 
    return _data_listener->num_replies(); 
}
 
/* ---------------------------------------------------------------------*/
DDS_Boolean RtiDdsReceiverCommunicator::prepare(
    struct Latency *instance, char* mcast_recv_addr,
    class LatencyDataProcessor*)
{
    DDS_ReturnCode_t ret_code = DDS_RETCODE_ERROR;
    const char *send_topic_name = NULL;
    DDS_DataReaderQos reader_qos;
   
    if ( _echo_disabled == DDS_BOOLEAN_FALSE ) {
         send_topic_name = LATENCY_ECHO_TOPIC_NAME;
    }
    
    /* Use participant index = _cookie for receiver */
    if (!create_dds_entities(instance, 
                             mcast_recv_addr, 
                             send_topic_name,
                             LATENCY_DATA_TOPIC_NAME)) {
        return DDS_BOOLEAN_FALSE;
    }

    /* Listener declarations */
    _data_listener = new ReceiverDataListener(_cookie);
    _data_listener->set_writer(_writer);

    /* save the cookie as a cookie in the user data so that the
    ** writer can identify the reader it wants to reply 
    */
    _reader->get_qos(reader_qos);
    reader_qos.user_data.value.ensure_length(1, 1);
    reader_qos.user_data.value[0] = _cookie;
    _reader->set_qos(reader_qos);

    /* Setup reader to access received data via a listener. 
    ** Explicitly specify which operations in the listener are
    ** activated for callback
    */
    ret_code = _reader->set_listener(_data_listener, 
                                     DDS_DATA_AVAILABLE_STATUS |
                                     DDS_REQUESTED_INCOMPATIBLE_QOS_STATUS |
                                     DDS_SUBSCRIPTION_MATCHED_STATUS);
    if (ret_code != DDS_RETCODE_OK) {
        AppLog_exception("failed to set listener\n");
        return DDS_BOOLEAN_FALSE;
    }

    /* bring up participant */
    ret_code = _participant->enable();
    if (ret_code != DDS_RETCODE_OK) {
        AppLog_exception("failed to enable participant\n");
        return DDS_BOOLEAN_FALSE;
    }

    return DDS_BOOLEAN_TRUE;
}


/* ---------------------------------------------------------------------*/
DDS_Boolean RtiDdsCommunicator::cleanup_receiver()
{
    /* Delete all DDS entities created in the prepare */
    DDSDomainParticipantFactory* factory =
            DDSDomainParticipantFactory::get_instance();
    DDS_Boolean ok = DDS_BOOLEAN_TRUE;

    /*------------------------ tear down dds entities ----------------------*/
    ok = ((_subscriber->delete_datareader(_reader) == DDS_RETCODE_OK) && 
          ok);

    if (_writer != NULL) {
        ok = ((_publisher->
               delete_datawriter(_writer) == DDS_RETCODE_OK) && ok);
    }
    ok = ((_participant->
           delete_topic(_recv_topic) == DDS_RETCODE_OK) && ok);
    ok = ((_participant->
           delete_topic(_send_topic) == DDS_RETCODE_OK) && ok);
    ok = ((_participant->
           delete_subscriber(_subscriber) == DDS_RETCODE_OK) && ok);
    ok = ((_participant->
           delete_publisher(_publisher) == DDS_RETCODE_OK) && ok);
    ok = ((factory->
           delete_participant(_participant) == DDS_RETCODE_OK) && ok);

    return ok;
}

RtiDdsReceiverCommunicator::~RtiDdsReceiverCommunicator()
{
    if (_data_listener != NULL) {
        delete _data_listener;
    }
}
