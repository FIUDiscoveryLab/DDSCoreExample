/*
 (c) Copyright, Real-Time Innovations, $Date: 2009/05/17 02:59:54 $.
 All rights reserved.
 No duplications, whole or partial, manual or electronic, may be made
 without express written permission.  Any such copies, or
 revisions thereof, must display this notice unaltered.
 This code contains trade secrets of Real-Time Innovations, Inc.
*/

/*=======================================================================*/
#ifndef Communicator_hxx
#define Communicator_hxx

/* ---------------------------------------------------------------------*/
class Communicator {
  protected:
    int  _recv_thread_priority;
    int  _multicast_ttl;
    DDS_Boolean _use_multicast;
    DDS_Boolean _is_ready;
    
  public:
    virtual ~Communicator() {};
    Communicator(int priority,
                 DDS_Boolean use_multicast, 
                 int multicast_ttl,
                 DDS_Boolean is_ready)
        : _recv_thread_priority(priority),
          _multicast_ttl(multicast_ttl),
          _use_multicast(use_multicast),
          _is_ready(is_ready)
    {
    }
    virtual DDS_Boolean prepare(struct Latency *, 
				char* mcast_recv_addr,
				class LatencyDataProcessor *data_processor) = 0;
    virtual DDS_Boolean cleanup_sender() {return DDS_BOOLEAN_TRUE;}
    virtual DDS_Boolean cleanup_receiver() {return DDS_BOOLEAN_TRUE;}
    virtual DDS_Boolean send_data() {return DDS_BOOLEAN_TRUE;}
    virtual DDS_Boolean needs_receiver_thread() {return DDS_BOOLEAN_FALSE;}
    virtual DDS_Boolean receive_data() {return DDS_BOOLEAN_TRUE;}
    virtual DDS_Boolean has_received_sentinel() {return DDS_BOOLEAN_FALSE;}
    virtual DDS_Boolean is_ready() {return DDS_BOOLEAN_TRUE;}
    virtual int get_echoer_cookie() {return -1;}
    virtual int recv_message_count() {return 0;}
    virtual int sent_message_count() {return 0;}


    /* Leave commented for Latency Test.
    ** Causes communicator to start a thread
    */ 
    /* void run_receiver_thread(); */

  private:
     /* Leave commented for Latency Test.
      ** Causes communicator to start a thread
      */ 
     /* static void *receive_thread_rtn(void *communicator); */
};

/* ---------------------------------------------------------------------*/
class RtiDdsCommunicator : public Communicator {
  private:
    DDS_DomainId_t _domain_id;
    int _index;
    char* _peer;
    char* _nic;
    DDS_Boolean _is_reliable;
    DDS_Boolean _receive_on_multicast;
    DDS_Boolean _use_key_in_topic;
    int  _event_thread_priority;
    int  _db_thread_priority;

  protected:
    NDDS_Transport_ClassId_t _transport_id;
    DDSDomainParticipant* _participant;
    DDSSubscriber* _subscriber;
    DDSPublisher* _publisher;
    DDSTopic* _send_topic;
    DDSTopic* _recv_topic;

    DDSDataReader* _reader;
    LatencyDataWriter* _writer;
 
    DDS_InstanceHandle_t _instance_handle;
    const struct Latency *_send_instance;
 
 public:
    virtual DDS_Boolean cleanup_sender();
    virtual DDS_Boolean cleanup_receiver();
    virtual DDS_Boolean send_data();
    virtual DDS_Boolean needs_receiver_thread();
    DDS_Boolean configure_udpv4_transport();

/* Define RTI_SHARED_MEMORY to support shared memory */ 
#ifdef RTI_SHARED_MEMORY
    DDS_Boolean configure_shmem_transport();
#endif

/* Define RTI_IPV6 to support IPV6 transport */
#ifdef RTI_IPV6
    DDS_Boolean configure_udpv6_transport();
#endif

    RtiDdsCommunicator(int domain_id, int index, 
                       char* peer, char* nic,
                       NDDS_Transport_ClassId_t transport_id,
                       DDS_Boolean is_reliable,
                       DDS_Boolean receive_on_multicast, 
                       int multicast_ttl,
                       DDS_Boolean use_key_in_topic,
                       int recv_thread_priority, 
                       int event_thread_priority, 
                       int db_thread_priority,
                       DDS_Boolean is_ready);

  protected:
    DDS_Boolean create_dds_entities(const struct Latency *instance,
                                    const char *reader_multicast_address,
                                    const char *send_topic_name,
                                    const char *recv_topic_name);
};

/* ---------------------------------------------------------------------*/
class RtiDdsSenderCommunicator : public RtiDdsCommunicator {
  private:
    class SenderEchoListener *_echo_reader_listener;
    class SenderWriterListener *_data_writer_listener;
    int _subscribers;
  public:
    /* INTERNAL API: RTIOsapiSemaphore ***/
    virtual ~RtiDdsSenderCommunicator();
    RtiDdsSenderCommunicator(int domain_id,
                       char* peer, 
                       char* nic,
                       NDDS_Transport_ClassId_t transport_id,
                       DDS_Boolean is_reliable,
                       DDS_Boolean receive_on_multicast, 
                       int multicast_ttl,
                       DDS_Boolean use_key_in_topic,
                       int recv_thread_priority, 
                       int event_thread_priority, 
                       int db_thread_priority,
                       DDS_Boolean is_ready, 
                       int subscribers);

    virtual DDS_Boolean prepare(struct Latency *instance,
                                char* mcast_recv_addr,
                                class LatencyDataProcessor *data_processor);
    virtual DDS_Boolean is_ready();
    virtual int get_echoer_cookie();

    struct RTIOsapiSemaphore* sem;
};

/* ---------------------------------------------------------------------*/
class RtiDdsReceiverCommunicator : public RtiDdsCommunicator {
  private:
    class ReceiverDataListener *_data_listener;
    int _cookie;
    DDS_Boolean _echo_disabled;

  public:
    RtiDdsReceiverCommunicator(int domain_id, 
                               int index,
                               char* peer, 
                               char* nic,
                               NDDS_Transport_ClassId_t transport_id,
                               DDS_Boolean is_reliable,
                               DDS_Boolean receive_on_multicast, 
                               int multicast_ttl,
                               DDS_Boolean use_key_in_topic,
                               int recv_thread_priority,
                               int event_thread_priority,
                               int db_thread_priority,
                               int cookie, DDS_Boolean echo_disabled);
    virtual ~RtiDdsReceiverCommunicator();
    
    virtual DDS_Boolean prepare(struct Latency *instance, 
                                char* mcast_recv_addr,
                                class LatencyDataProcessor *data_processor);
    virtual DDS_Boolean has_received_sentinel();
    virtual int recv_message_count();
    virtual int sent_message_count();
};

#endif/* Communicator_hxx*/
