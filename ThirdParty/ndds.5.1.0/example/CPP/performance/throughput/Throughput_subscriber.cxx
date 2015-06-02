/*
 (c) Copyright, Real-Time Innovations, $Date: 2012/04/23 18:37:51 $.
 All rights reserved.
 No duplications, whole or partial, manual or electronic, may be made
 without express written permission.  Any such copies, or
 revisions thereof, must display this notice unaltered.
 This code contains trade secrets of Real-Time Innovations, Inc.
*/

#include <stdio.h>
#include <stdlib.h>
#ifndef ndds_cpp_h
  #include "ndds/ndds_cpp.h"
#endif
#include "Throughput.h"
#include "ThroughputArgs.h"
#include "ThroughputCommon.h"
#include "ThroughputPlugin.h"
#include "ThroughputQos.h"
#include "ThroughputSupport.h"
#include "ThroughputTransport.h"
#include "PerfMon.h"
#include "TimeManager.h"

class ThroughputCommandListener : public DDSDataReaderListener {
  public:
    ThroughputCommand packet;

  public:
    int _matching_writer;
    int _test_verbosity;
    int _samples_lost;
  public:
    void reset() {
        packet.command = THROUGHPUT_COMMAND_IDLE;
    }

    ~ThroughputCommandListener() {};

    ThroughputCommandListener() {
        packet.data_length = 0;
        _test_verbosity = 0;
        _matching_writer = 0;
        _samples_lost = 0;
        reset();
    }

    virtual void on_data_available(DDSDataReader *reader);
    virtual void on_liveliness_changed(
        DDSDataReader *reader, const DDS_LivelinessChangedStatus &status) {}

    virtual void on_requested_deadline_missed(
        DDSDataReader *reader,
        const DDS_RequestedDeadlineMissedStatus &status) {}

    virtual void on_requested_incompatible_qos(
        DDSDataReader *reader,
        const DDS_RequestedIncompatibleQosStatus &status) {}

    virtual void on_sample_lost(
        DDSDataReader *reader, const DDS_SampleLostStatus &status) {
        _samples_lost = status.total_count;
    }

    virtual void on_sample_rejected(
        DDSDataReader *reader, const DDS_SampleRejectedStatus &status) {}

    virtual void on_subscription_matched(DDSDataReader *reader,
        const DDS_SubscriptionMatchedStatus &status) {
        _matching_writer = status.current_count;
    }

    void set_verbosity(int verbosity) { _test_verbosity = verbosity; }
    int get_samples_lost() { return _samples_lost; }
    int get_matching_writers() { return _matching_writer; }
};

void ThroughputCommandListener::on_data_available(DDSDataReader *reader) {
    ThroughputCommandDataReader* command_reader;
    ThroughputCommandSeq data_seq;
    DDS_SampleInfoSeq info_seq;
    DDS_ReturnCode_t return_code;
    int i;

    command_reader = ThroughputCommandDataReader::narrow(reader);

    return_code = command_reader->take(
        data_seq, info_seq, DDS_LENGTH_UNLIMITED, DDS_NOT_READ_SAMPLE_STATE,
        DDS_ANY_VIEW_STATE, DDS_ALIVE_INSTANCE_STATE);
    if (return_code != DDS_RETCODE_OK) {
        AppLog_exception("\nError in Throughput Command Reader\n");
        return;
    }
    for (i = 0; i < data_seq.length(); ++i) {
        if (info_seq[i].valid_data) {
            packet = data_seq[i];
        }
    }
    command_reader->return_loan(data_seq, info_seq);
}

class ThroughputListener : public DDSDataReaderListener {
  private:
    int _packets_received;
    int _packets_lost;
    DDS_UnsignedLong _sequence_number;
    int _matching_writer;
    int _test_verbosity;
    int _samples_lost;
    int _samples_rejected;

  public:
    ~ThroughputListener() {};

    ThroughputListener() {
        reset();
        _test_verbosity = 0;
    }

    virtual void on_requested_deadline_missed(
        DDSDataReader* /*reader*/,
        const DDS_RequestedDeadlineMissedStatus& /*status*/) {}

    virtual void on_requested_incompatible_qos(
        DDSDataReader* /*reader*/,
        const DDS_RequestedIncompatibleQosStatus& /*status*/) {}

    virtual void on_sample_rejected(
        DDSDataReader* reader, const DDS_SampleRejectedStatus& status) {
        _samples_rejected += status.total_count_change;
    }

    virtual void on_liveliness_changed(
        DDSDataReader* /*reader*/,
        const DDS_LivelinessChangedStatus& /*status*/) {}

    virtual void on_sample_lost(
        DDSDataReader* reader, const DDS_SampleLostStatus& status) {
            _samples_lost += status.total_count_change;
    }

    virtual void on_subscription_matched(
        DDSDataReader* reader, const DDS_SubscriptionMatchedStatus& status) {
       _matching_writer = status.current_count;
    }

    virtual void on_data_available(DDSDataReader* reader);

    void set_verbosity(int verbosity) { _test_verbosity = verbosity; }
    int get_packets_received() { return _packets_received; }
    int get_packets_lost() { return _packets_lost; }
    int get_samples_lost() { return _samples_lost; }
    int get_samples_rejected() { return _samples_rejected; }
    int get_matching_writers() { return _matching_writer; }

    void resetCounts() {
       _samples_rejected = 0;
       _samples_lost = 0;
       _sequence_number = 0;
       _packets_received = 0;
       _packets_lost = 0;
    }

    void reset() {
        resetCounts();
        _matching_writer = 0;
    }
};

void ThroughputListener::on_data_available(DDSDataReader* reader) {
    /* Increment number of packets received */
    int i;
    ThroughputDataReader* data_reader;
    ThroughputSeq data_seq;
    DDS_SampleInfoSeq info_seq;
    DDS_ReturnCode_t return_code;

    data_reader = ThroughputDataReader::narrow(reader);

    return_code = data_reader->take(data_seq, info_seq, DDS_LENGTH_UNLIMITED,
                                    DDS_NOT_READ_SAMPLE_STATE,
                                    DDS_ANY_VIEW_STATE,
                                    DDS_ALIVE_INSTANCE_STATE);
    if (return_code != DDS_RETCODE_OK) {
        if (return_code != DDS_RETCODE_NO_DATA) {
            AppLog_exception("Error in reading data\n");
        }
        return;
    }
    for (i = 0; i < data_seq.length(); ++i) {
        if (info_seq[i].valid_data) {
            if (data_seq[i].sequence_number != _sequence_number) {
                if (_sequence_number != 0) {
                    if (_test_verbosity >= TEST_VERBOSITY_MESSAGES) {
                        AppLog_warn("data_seq[%d].sequence_number = %d, "
                                    "Expected sequence_number = %d\n",
                                    i, data_seq[i].sequence_number,
                                    _sequence_number);
                    }
                    _packets_lost += (data_seq[i].sequence_number -
                        _sequence_number);
                }
                /* Reset sequence number */
                _sequence_number = data_seq[i].sequence_number;
            }
            ++_packets_received;
            ++_sequence_number;
        }
    }
    data_reader->return_loan(data_seq, info_seq);
}

/* Delete all entities */
static int subscriber_shutdown(DDSDomainParticipant *participant) {
    DDS_ReturnCode_t return_code;
    int status = 0;

    if (participant != NULL) {
        return_code = participant->delete_contained_entities();
        if (return_code != DDS_RETCODE_OK) {
            AppLog_exception("delete_contained_entities error %d\n", return_code);
            status = -1;
        }
        return_code = DDSTheParticipantFactory->
            delete_participant(participant);
        if (return_code != DDS_RETCODE_OK) {
            AppLog_exception("delete_participant error %d\n", return_code);
            status = -1;
        }
    }

    /* RTI Connext provides finalize_instance() method for
       people who want to release memory used by the participant factory
       singleton. Uncomment the following block of code for clean destruction
       of the participant factory singleton. */
/*
    return_code = DDSDomainParticipantFactory::finalize_instance();
    if (return_code != DDS_RETCODE_OK) {
        AppLog_exception("finalize_instance error %d\n", return_code);
        status = -1;
    }
*/
    return status;
}

int subscriber_test_throughput(ThroughputSubscriberArgs& args) {

    DDSDomainParticipantFactory *factory;
    DDS_DomainParticipantFactoryQos factory_qos;
    DDSDomainParticipant *participant;
    DDS_DomainParticipantQos participant_qos;
    DDSSubscriber *subscriber;
    DDS_SubscriberQos subscriber_qos;
    ThroughputDataReader *throughput_reader;
    DDS_DataReaderQos throughput_reader_qos;
    ThroughputListener *throughput_reader_listener;
    ThroughputCommandDataReader *throughput_command_reader;
    DDS_DataReaderQos throughput_command_reader_qos;
    ThroughputCommandListener *throughput_command_reader_listener;
    DDSTopic *throughput_topic;
    DDS_TopicQos throughput_qos;
    DDSTopic *throughput_command_topic;
    DDS_TopicQos throughput_command_qos;

    /***************************************************
     * Other data
     ***************************************************/
    DDSDataReader *reader = NULL;
    DDS_ReturnCode_t return_code = DDS_RETCODE_OK;
    /* We use a manager to handle all of the timing */
    TimeManager time_manager;
    double bytes_read = 0.0;
    double delta_time = 0.0;
    double subscriber_throughput = 0.0;
    char *locator = NULL;
    float appCpuLoad;
    int packets_received = 0;

    PerfMon subsMonitor;

    set_logger_verbosity(args.ndds_verbosity);    

    factory = DDSDomainParticipantFactory::get_instance();
    if (factory == NULL) {
        AppLog_exception("Error in getting participant factory\n");
        return 0;
    }

    /* Configure the Factory Quality of Service */
    return_code = configure_factory_qos(factory_qos, factory);
    if (return_code != DDS_RETCODE_OK) {
        return 0;
    }

    /* Configure the Participant Quality of Service */
    return_code = configure_subscriber_participant_qos(participant_qos,
                                                       factory, args);
    if (return_code != DDS_RETCODE_OK) {
        return 0;
    }

    /* Now we can create the 'disabled' participant. */
    participant = factory->create_participant(
        args.ndds_domain, participant_qos, NULL, DDS_STATUS_MASK_NONE);
    if (participant == NULL) {
        AppLog_exception("Error in creating Domain Participant\n");
        return subscriber_shutdown(participant);
    }
     
    locator = DDS_String_alloc(8 + MAX_PEER_LOCATOR_STR_LEN);
    if (locator == NULL) {
        AppLog_exception("Error in creating interface string for "
                         "test network\n");
        return_code = DDS_RETCODE_ERROR;
        return return_code;
    }

    /* Configure the participant transport */
    return_code = configure_subscriber_participant_transport(participant, 
                                                             args, &locator);
    if (return_code != DDS_RETCODE_OK) {
        return subscriber_shutdown(participant);
    }

    /* Now we enable the participant */
    return_code = participant->enable();
    if (return_code != DDS_RETCODE_OK) {
        AppLog_exception("Error in enabling the domain participant\n");
        return subscriber_shutdown(participant);
    }    

    /* And create the subscriber with default QoS */
    participant->get_default_subscriber_qos(subscriber_qos);
    subscriber = participant->create_subscriber(
        subscriber_qos, NULL, DDS_STATUS_MASK_NONE);
    if (subscriber == NULL) {
        AppLog_exception("Error in creating Subscriber\n");
        return subscriber_shutdown(participant);
    }

    /*********************************************************
     * Set up Throughput topic and reader.
     **********************************************************/

    /* Now we register the data topic type with the participant. */
    return_code = ThroughputTypeSupport::register_type(participant,
                                                       ThroughputTYPENAME);
    if (return_code != DDS_RETCODE_OK) {
        AppLog_exception("Error in registering %s\n", ThroughputTYPENAME);
        return subscriber_shutdown(participant);
    }

    /* Get the default QoS for the Topic */
    participant->get_default_topic_qos(throughput_qos);
    /* Note: Ownership is Shared by default.
       There is only one publisher of this Topic so... */
    throughput_qos.ownership.kind = DDS_EXCLUSIVE_OWNERSHIP_QOS;
    /* And create a Topic with QoS and default listener. */
    throughput_topic = participant->create_topic(
        "Throughput", ThroughputTYPENAME, throughput_qos, NULL,
        DDS_STATUS_MASK_NONE);
    if (throughput_topic == NULL) {
        AppLog_exception("Error in creating Data Topic\n");
        return subscriber_shutdown(participant);
    }
    throughput_reader_listener = new ThroughputListener();
    if (throughput_reader_listener == NULL) {
        AppLog_exception("Error in creating Data Reader Listener\n");
        return subscriber_shutdown(participant);
    }
    throughput_reader_listener->set_verbosity(args.test_verbosity);

    /* Configure throughput reader Quality of service */
    return_code = configure_throughput_reader_qos(throughput_reader_qos,
                                                  subscriber, args);
    if (return_code != DDS_RETCODE_OK) {
        return subscriber_shutdown(participant);
    }

    /* Now create the throughput reader */
    reader = subscriber->create_datareader(
        throughput_topic, throughput_reader_qos, throughput_reader_listener,
        DDS_STATUS_MASK_ALL);
    if (reader == NULL) {
        AppLog_exception("Error in creating Data Reader\n");
        return subscriber_shutdown(participant);
    }

    throughput_reader =  ThroughputDataReader::narrow(reader);
    if (throughput_reader == NULL) {
        AppLog_exception("Error in narrowing Data Reader\n");
        /* Ensure that we clean up correctly */
        throughput_reader = (ThroughputDataReader *)reader;
        return subscriber_shutdown(participant);
    }

    /*************************************************************************
     * Set up Command topic and reader.
     *************************************************************************/

    /* Now we register the command topic type with the participant */
    return_code = ThroughputCommandTypeSupport::register_type(
        participant, ThroughputCommandTYPENAME);
    if (return_code != DDS_RETCODE_OK) {
        AppLog_exception("Error in registering Test Command Packet\n");
        return subscriber_shutdown(participant);
    }

    /* and create the command topic and reader */
    participant->get_default_topic_qos(throughput_command_qos);
    /* We need exclusive ownership of this Topic
       because there is only one writer so... */
    throughput_command_qos.ownership.kind = DDS_EXCLUSIVE_OWNERSHIP_QOS;
    /* And create a Topic with QoS and default listener.
       Note Ownership is Shared by default. */
    throughput_command_topic = participant->create_topic(
        "ThroughputCommand", ThroughputCommandTYPENAME,
        throughput_command_qos, NULL, DDS_STATUS_MASK_NONE);
    if (throughput_command_topic == NULL) {
        AppLog_exception("Error in creating Command Topic\n");
        return subscriber_shutdown(participant);
    }

    throughput_command_reader_listener = new ThroughputCommandListener();
    if (throughput_command_reader_listener == NULL) {
        AppLog_exception("Error in creating Command Reader Listener\n");
        return subscriber_shutdown(participant);
    }
    throughput_command_reader_listener->set_verbosity(args.test_verbosity);

    return_code = configure_command_reader_qos(
        throughput_command_reader_qos, subscriber);
    if (return_code != DDS_RETCODE_OK) {
        return subscriber_shutdown(participant);
    }

    /* create and enable command reader */
    reader = subscriber->create_datareader(
            throughput_command_topic, throughput_command_reader_qos,
            throughput_command_reader_listener, DDS_STATUS_MASK_ALL);
    if (reader == NULL) {
        AppLog_exception("Error in creating Command Reader\n");
        return subscriber_shutdown(participant);
    }
    throughput_command_reader =
        ThroughputCommandDataReader::narrow(reader);
    if (throughput_command_reader == NULL) {
        AppLog_exception("Error in narrowing Command Reader\n");
        /* Ensure that we clean up correctly */
        throughput_command_reader = (ThroughputCommandDataReader*)reader;
        return subscriber_shutdown(participant);
    }

    /*************************************************************************
     * Start test
     ************************************************************************/

    if (!time_manager.initialize(0)) {
        AppLog_exception("Error in creating clock\n");
        return subscriber_shutdown(participant);
    }

    if (!time_manager.calculate_clock_overhead()) {
        AppLog_exception("Error in calculating clock overhead. Results may not"
                        " be accurate\n");
        return subscriber_shutdown(participant);
    }

    AppLog_report("Starting test...\n");
    if (args.test_verbosity >= TEST_VERBOSITY_MESSAGES) {
        AppLog_report("using the following parameters:\n");
        args.print_arguments();
    }

    AppLog_report(" bytes,demand, samples,sample/s, Mbit/s,lost(A),Nreject,lost(N), CPU %%,memory\n"
                  "------,------,--------,--------,-------,-------,-------,-------,------,------\n");
    fflush(stdout);

    do {
        throughput_command_reader_listener->reset();
        /* Reset Data Reader Listener counts prior to starting test */
        throughput_reader_listener->resetCounts();

        /* Wait for a start command */
        if (args.test_verbosity >= TEST_VERBOSITY_WARNINGS) {
            AppLog_warn("Waiting for test start command\n");
        }        
        /* wait for the start command */
        while (throughput_command_reader_listener->packet.command !=
            THROUGHPUT_COMMAND_START) {
            time_manager.sleep(ten_millisec);
        }
        appCpuLoad = subsMonitor.getCpu();        
        /* Command contains writer packet size */
        /* throughput_command_reader_listener->packet.packet_size =
            throughput_command_reader_listener->getPacketSize(); */
        if (!time_manager.get_start_time()) {
            AppLog_exception("Error in setting StartTime."
                             " Results may not be accurate\n");
            return subscriber_shutdown(participant);
        }

        /* Run until the test complete command is received */        
        while (throughput_command_reader_listener->packet.command !=
            THROUGHPUT_COMMAND_COMPLETE) {
            time_manager.sleep(ten_millisec);
        }

        if (!time_manager.get_stop_time()) {
            AppLog_exception("Error in getting Stop Time."
                             " Results may not be accurate\n");
            return subscriber_shutdown(participant);
        }
        packets_received = throughput_reader_listener->get_packets_received();
        appCpuLoad = subsMonitor.getCpu();        
        delta_time = time_manager.get_delta_time();
        bytes_read = (double)packets_received * (THROUGHPUT_PACKET_OVERHEAD + 
                     throughput_command_reader_listener->packet.data_length);
        if (delta_time > 0) {
            subscriber_throughput = 8.0 * bytes_read / delta_time / 1000000.0;
        }

        AppLog_report("%6d,%6d,%8d,%8.2f,%7.1f,%7d,%7d,%7d,%6.2f,%6.1f\n",
                      (throughput_command_reader_listener->packet.data_length +
                          THROUGHPUT_PACKET_OVERHEAD),
                      throughput_command_reader_listener->
                      packet.current_publisher_effort,
                      packets_received,
                      (float)packets_received/delta_time,
                      subscriber_throughput,
                      throughput_reader_listener->get_packets_lost(),
                      throughput_reader_listener->get_samples_rejected(),
                      throughput_reader_listener->get_samples_lost(),
                      appCpuLoad,
                      (float)subsMonitor.getMemory()/(1024.0 * 1024.0));

	fflush(stdout);

        /* Receive remaining of data */
        time_manager.sleep(three_second);

    } while (throughput_command_reader_listener->
             packet.current_publisher_effort 
             < throughput_command_reader_listener->
             packet.final_publisher_effort);

    AppLog_report("Test Completed.\n");

    subscriber_shutdown(participant);

    delete throughput_command_reader_listener;

    delete throughput_reader_listener;

    DDS_String_free(locator);

    return return_code;
}

#if defined(RTI_WINCE)
int wmain(int argc, wchar_t* argv[])
{
    char arg_array[MAX_COMMAND_LINE_ARGUMENTS][MAX_COMMAND_EXEC_LEN];
    char *argv_c[MAX_COMMAND_LINE_ARGUMENTS];
    int i;

    for (i = 0; i < argc; ++i) {
        wcstombs(arg_array[i], argv[i], wcslen(argv[i]) + 1);
        arg_array[i][wcslen(argv[i])] = '\0';
        argv_c[i] = &arg_array[i][0];
    }
    argv_c[argc] = '\0';

    ThroughputSubscriberArgs *args;

    if(argc <= 1){
	args = new ThroughputSubscriberArgs();
    } else {
    	args = new ThroughputSubscriberArgs(argc, argv_c);
    }

#elif !(defined(RTI_VXWORKS) && !defined(__RTP__)) && !defined(RTI_PSOS)
int main(int argc, char *argv[]) 
{
    ThroughputSubscriberArgs *args;	    

    if(argc <= 1){
	args = new ThroughputSubscriberArgs();
    } else {
    	args = new ThroughputSubscriberArgs(argc, argv);
    }
#elif defined(RTI_VXWORKS)
int subscriber_main(void) 
{
    ThroughputSubscriberArgs *args = new ThroughputSubscriberArgs();
#endif

    if (args->is_help_requested()) {
        args->usage();
 	delete args;
        return -1;
    } else if (!args->is_valid()) {
        args->print_error();
	delete args;
       	return -1;
    }
    int ret_value = subscriber_test_throughput(*args);
    delete args;
    return ret_value;	
}

