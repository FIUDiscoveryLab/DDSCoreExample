/*
 (c) Copyright, Real-Time Innovations, $Date: 2009/05/17 03:53:51 $.
 All rights reserved.
 No duplications, whole or partial, manual or electronic, may be made
 without express written permission.  Any such copies, or
 revisions thereof, must display this notice unaltered.
 This code contains trade secrets of Real-Time Innovations, Inc.
*/

#include "ThroughputQos.h"

void DataWriterQos_setMulticast(
    DDS_DataWriterQos &qos, int reader_queue_size,
    int nack_coalesce_time_min_in_ms,
    int nack_coalesce_time_max_in_ms) {
    /* qos.protocol.rtps_reliable_writer.max_bytes_per_nack_response
       = -reader_queue_size; */
    qos.protocol.rtps_reliable_writer.max_bytes_per_nack_response = 32*1024;
    qos.protocol.rtps_reliable_writer.min_nack_response_delay.sec = 0;
    qos.protocol.rtps_reliable_writer.min_nack_response_delay.nanosec =
        nack_coalesce_time_min_in_ms * NANOSEC_PER_MILLISEC;
    qos.protocol.rtps_reliable_writer.max_nack_response_delay.sec = 0;
    qos.protocol.rtps_reliable_writer.max_nack_response_delay.nanosec =
        nack_coalesce_time_max_in_ms * NANOSEC_PER_MILLISEC;
}

void DataWriterQos_setImpatientReliable(
    DDS_DataWriterQos &qos, 
    DDS_Duration_t time_to_go_from_full_to_low_water_mark_ms,
    int alert_reader_within_this_ms) {
    /* assert(block_for_this_ms > alert_reader_within_this_ms); */
    /* assert(send_period_ms > 2 * block_for_this_ms); */
    /* only use for assertion */

    qos.reliability.kind = DDS_RELIABLE_RELIABILITY_QOS;

    qos.reliability.max_blocking_time =
        time_to_go_from_full_to_low_water_mark_ms;

    /* qos.protocol.push_on_write = DDS_BOOLEAN_TRUE; */

    qos.history.kind = DDS_KEEP_ALL_HISTORY_QOS;

    /* limit the queue, because we don't need to use the queue */
    qos.resource_limits.max_samples = 2;
    qos.resource_limits.initial_samples = qos.resource_limits.max_samples;

    /* use these hard coded value until you use key */
    qos.resource_limits.max_samples_per_instance =
        qos.resource_limits.max_samples;
    qos.resource_limits.max_instances = 1;
    qos.resource_limits.initial_instances =
        qos.resource_limits.max_instances;

    /* should be faster than the send rate! */
    qos.protocol.rtps_reliable_writer.fast_heartbeat_period.sec = 0;
    qos.protocol.rtps_reliable_writer.fast_heartbeat_period.nanosec =
        alert_reader_within_this_ms * NANOSEC_PER_MILLISEC;

    /* because the queue is 1, want to piggyback HB w/ every sample.
       This may be a duplicate HB, but since the send is low, it's OK
    */
    qos.protocol.rtps_reliable_writer.heartbeats_per_max_samples =
        qos.resource_limits.max_samples;

    /* essentially turn off slow HB period, relying on periodic nature of the
       data */
    qos.protocol.rtps_reliable_writer.heartbeat_period.sec = 3600 * 24 * 7;
    /* 1 year */

    qos.protocol.rtps_reliable_writer.min_nack_response_delay.sec = 0;
    qos.protocol.rtps_reliable_writer.min_nack_response_delay.nanosec = 0;
    qos.protocol.rtps_reliable_writer.max_nack_response_delay.sec = 0;
    qos.protocol.rtps_reliable_writer.max_nack_response_delay.nanosec = 0;
}

void DataWriterQos_setReliableBursty(
    DDS_DataWriterQos &qos, int worst_burst_in_samples,
    DDS_Duration_t time_to_go_from_full_to_low_water_mark_ms,
    int alert_reader_within_this_ms) {

    qos.reliability.kind = DDS_RELIABLE_RELIABILITY_QOS;

    /* the writing will block until queue goes down to low water mark */
    qos.reliability.max_blocking_time =
        time_to_go_from_full_to_low_water_mark_ms;

    qos.history.kind = DDS_KEEP_ALL_HISTORY_QOS;
    /* qos.liveliness.kind = DDS_MANUAL_BY_TOPIC_LIVELINESS_QOS;
       qos.liveliness.lease_duration.sec = 1;
       qos.liveliness.lease_duration.nanosec = 400 * NANOSEC_PER_MILLISEC; */

    /* avoid malloc and pay memory;
       might have to change policy for large type */
    qos.resource_limits.max_samples = worst_burst_in_samples;
    qos.resource_limits.initial_samples = worst_burst_in_samples;
    /* if worst burst == expected burst */
    qos.resource_limits.max_samples_per_instance =
        qos.resource_limits.max_samples;

    /* trip high water mark as soon as data starts coming in */
    qos.protocol.rtps_reliable_writer.high_watermark = 1;
    /* And stay in fast mode (work harder to resolve stored samples)
       until all have been delivered.
    */
    qos.protocol.rtps_reliable_writer.low_watermark = 0;

    qos.protocol.rtps_reliable_writer.fast_heartbeat_period.sec = 0;
    qos.protocol.rtps_reliable_writer.fast_heartbeat_period.nanosec =
        alert_reader_within_this_ms * NANOSEC_PER_MILLISEC;

    /* NOTE: piggyback HB irrelevant when push_on_write is turned off */
    qos.protocol.rtps_reliable_writer.heartbeats_per_max_samples =
        worst_burst_in_samples / 64;

    /* turn off slow HB? */
    qos.protocol.rtps_reliable_writer.heartbeat_period.sec = 3600 * 24 * 7;
    /* 1 year */

    /* don't want to forget the reader even if it's not responsive for 1 sec */
    qos.protocol.rtps_reliable_writer.max_heartbeat_retries = 100;

    qos.protocol.rtps_reliable_writer.min_nack_response_delay.sec = 0;
    qos.protocol.rtps_reliable_writer.min_nack_response_delay.nanosec = 0;
    qos.protocol.rtps_reliable_writer.max_nack_response_delay.sec = 0;
    qos.protocol.rtps_reliable_writer.max_nack_response_delay.nanosec = 0;
}

void DataReaderQos_setMulticast(
    DDS_DataReaderQos &qos, const char* mcast_user_data_address,
    int multicast_reader_count) {

    struct DDS_TransportMulticastSettings_t* multicast_locator = NULL;
    /* DDS_TransportMulticastSettingsSeq_ensure_length(&, 1, 1); */
    qos.multicast.value.ensure_length(1,1);
    /* DDS_TransportMulticastSettingsSeq_get_reference(&qos.multicast.value,
                               0); */
    multicast_locator = &qos.multicast.value[0];

    DDS_String_replace(&multicast_locator->receive_address,
                       mcast_user_data_address);

    qos.resource_limits.initial_samples *= multicast_reader_count;
    if (qos.resource_limits.initial_samples >
        qos.resource_limits.max_samples) {
        qos.resource_limits.max_samples =
            qos.resource_limits.initial_samples;
    }
    qos.reader_resource_limits.max_samples_per_remote_writer =
        qos.resource_limits.initial_samples;
}

void DataReaderQos_setImpatientReliable(
    DDS_DataReaderQos &qos, int remote_writer_count_max) {
    /* limit the queue, because we don't need to use the queue */
    const int UNRESOLVED_SAMPLE_PER_REMOTE_WRITER_MAX = 2;
    qos.reliability.kind = DDS_RELIABLE_RELIABILITY_QOS;
    qos.history.kind = DDS_KEEP_ALL_HISTORY_QOS;

    qos.reader_resource_limits.max_samples_per_remote_writer =
        UNRESOLVED_SAMPLE_PER_REMOTE_WRITER_MAX;
    qos.resource_limits.initial_samples =
       remote_writer_count_max * UNRESOLVED_SAMPLE_PER_REMOTE_WRITER_MAX;
    /* don't limit max yet */
    /* qos.resource_limits.max_samples =
           qos.resource_limits.initial_samples; */

    /* use these hard coded value until you use key
       don't limit the max yet */
    /* qos.resource_limits.max_samples_per_instance =
           qos.reader_resource_limits.initial_remote_writers_per_instance; */
    qos.resource_limits.initial_instances = 1;
    /* qos.resource_limits.max_instances =
           qos.resource_limits.initial_instances; */

    qos.protocol.rtps_reliable_reader.max_heartbeat_response_delay.sec = 0;
    qos.protocol.rtps_reliable_reader.max_heartbeat_response_delay.nanosec = 0;
    qos.protocol.rtps_reliable_reader.min_heartbeat_response_delay.sec = 0;
    qos.protocol.rtps_reliable_reader.min_heartbeat_response_delay.nanosec = 0;
}

void DataReaderQos_setReliableBursty(
    DDS_DataReaderQos &qos, int remote_writer_count_max) {
    /* reader queue can be constant regardless of rate */
    const int UNRESOLVED_SAMPLE_PER_REMOTE_WRITER_MAX = 100;

    qos.reliability.kind = DDS_RELIABLE_RELIABILITY_QOS;
    qos.history.kind = DDS_KEEP_ALL_HISTORY_QOS;

    qos.resource_limits.max_samples =
       remote_writer_count_max * UNRESOLVED_SAMPLE_PER_REMOTE_WRITER_MAX;
    qos.resource_limits.initial_samples = qos.resource_limits.max_samples;

    qos.reader_resource_limits.max_samples_per_remote_writer =
        qos.resource_limits.initial_samples;
    qos.resource_limits.max_samples_per_instance =
        qos.resource_limits.initial_samples;

    /* the writer probably has more for the reader; ask right away */
    qos.protocol.rtps_reliable_reader.min_heartbeat_response_delay.sec = 0;
    qos.protocol.rtps_reliable_reader.min_heartbeat_response_delay.nanosec = 0;
    qos.protocol.rtps_reliable_reader.max_heartbeat_response_delay.sec = 0;
    qos.protocol.rtps_reliable_reader.max_heartbeat_response_delay.nanosec = 0;
}

DDS_ReturnCode_t configure_factory_qos(
    DDS_DomainParticipantFactoryQos &factory_qos,
    DDSDomainParticipantFactory *factory) {
    DDS_ReturnCode_t return_code = DDS_RETCODE_OK;
    /* We need to disable participants so that we can plug in a new/modified
       transport */
    return_code = factory->get_qos(factory_qos);
    if (return_code != DDS_RETCODE_OK) {
        AppLog_exception("Error get factory QoS\n");
    }

    factory_qos.entity_factory.autoenable_created_entities =
        DDS_BOOLEAN_FALSE;
    return_code = factory->set_qos(factory_qos);
    if (return_code != DDS_RETCODE_OK) {
        AppLog_exception("Error set factory QoS\n");
    }
    return return_code;
}

DDS_ReturnCode_t configure_publisher_participant_qos(
    DDS_DomainParticipantQos &participant_qos,
    DDSDomainParticipantFactory *factory, ThroughputPublisherArgs &args) {
    DDS_ReturnCode_t return_code = DDS_RETCODE_OK;
    int i;

    factory->get_default_participant_qos(participant_qos);
    participant_qos.event.thread.priority = RTI_OSAPI_THREAD_PRIORITY_HIGH;

    /* Someone may decide to start another publisher
       so take participant index from arguments */
    participant_qos.wire_protocol.participant_id = args.participant_id;

    participant_qos.transport_builtin.mask = 0; /* clear all xport first */
    if (args.transport_to_use() & DDS_TRANSPORTBUILTIN_UDPv4) {
        participant_qos.transport_builtin.mask |= DDS_TRANSPORTBUILTIN_UDPv4;
    }
#ifdef RTI_SHARED_MEMORY
    if (args.transport_to_use() & DDS_TRANSPORTBUILTIN_SHMEM) {
        participant_qos.transport_builtin.mask |= DDS_TRANSPORTBUILTIN_SHMEM;
    }
#endif /* RTI_SHARED_MEMORY */
#ifdef RTI_IPV6
    if (args.transport_to_use() & DDS_TRANSPORTBUILTIN_UDPv6) {
        participant_qos.transport_builtin.mask |= DDS_TRANSPORTBUILTIN_UDPv6;
    }
#endif
    participant_qos.receiver_pool.buffer_size = UDP_SIZE_MAX;
    participant_qos.event.max_count = MAX_EVENT_COUNT;

    if (args.max_peer_index > 0) {
        const char* initial_peer_array[THROUGHPUT_TEST_MAX_NODES];
        for (int i = 0; i < args.max_peer_index; ++i) {
            initial_peer_array[i] = args.get_peer_host(i);
        }
        participant_qos.discovery.initial_peers.from_array(
            initial_peer_array, args.max_peer_index);
        participant_qos.discovery.multicast_receive_addresses.ensure_length(0,0);
    }
    if (args.test_verbosity >= TEST_VERBOSITY_MESSAGES) {
        for (i = 0; i < participant_qos.discovery.initial_peers.length();
            ++i) {
            AppLog_warn("Peers %d = %s\n", i,
                        participant_qos.discovery.initial_peers[i]);
        }
    }
    return return_code;
}

DDS_ReturnCode_t configure_subscriber_participant_qos(
    DDS_DomainParticipantQos &participant_qos,
    DDSDomainParticipantFactory *factory, ThroughputSubscriberArgs &args) {
    DDS_ReturnCode_t return_code = DDS_RETCODE_OK;
    int i;

    factory->get_default_participant_qos(participant_qos);

    /* Someone may decide to start another publisher so take
       participant index from arguments */
    participant_qos.wire_protocol.participant_id = args.participant_id;
#ifdef UNNECESSARY
    /* Ensure that when we receive data it is processed quickly */
    participant_qos.receiver_pool.thread.priority =
        RTI_OSAPI_THREAD_PRIORITY_HIGH;
#endif
    participant_qos.event.thread.priority = RTI_OSAPI_THREAD_PRIORITY_HIGH;

    participant_qos.transport_builtin.mask = 0; /* clear all xport first */

    if (args.transport_to_use() & DDS_TRANSPORTBUILTIN_UDPv4) {
        participant_qos.transport_builtin.mask |= DDS_TRANSPORTBUILTIN_UDPv4;
    }
#ifdef RTI_SHARED_MEMORY
    if (args.transport_to_use() & DDS_TRANSPORTBUILTIN_SHMEM) {
        participant_qos.transport_builtin.mask |= DDS_TRANSPORTBUILTIN_SHMEM;
    }
#endif /* RTI_SHARED_MEMORY */
#ifdef RTI_IPV6
    if (args.transport_to_use() & DDS_TRANSPORTBUILTIN_UDPv6) {
        participant_qos.transport_builtin.mask |= DDS_TRANSPORTBUILTIN_UDPv6;
    }
#endif
    
    participant_qos.receiver_pool.buffer_size = UDP_SIZE_MAX;
    
    if (args.max_peer_index > 0) {
        const char* initial_peer_array[THROUGHPUT_TEST_MAX_NODES];
        for (int i = 0; i < args.max_peer_index; ++i) {
            initial_peer_array[i] = args.get_peer_host(i);
        }
        participant_qos.discovery.initial_peers.from_array(
            initial_peer_array, args.max_peer_index);
        participant_qos.discovery.multicast_receive_addresses.ensure_length(0,0);
    }
    if (args.test_verbosity >= TEST_VERBOSITY_MESSAGES) {
        for (i = 0; i < participant_qos.discovery.initial_peers.length();
             ++i) {
            AppLog_warn("Peers %d = %s\n",i,
                        participant_qos.discovery.initial_peers[i]);
        }
    }
    return return_code;
}

DDS_ReturnCode_t configure_throughput_writer_qos(
    DDS_DataWriterQos &throughput_writer_qos,
    DDS_Long *samples_per_trigger, DDS_Boolean large_data,
    DDS_Boolean use_multicast, DDS_Long max_gather_send_buffers,
    DDSPublisher *publisher, ThroughputPublisherArgs &args) {
    const DDS_Duration_t three_second = {3,0};
    DDS_ReturnCode_t return_code = DDS_RETCODE_OK;
    /* Set datawriter QoS */
    publisher->get_default_datawriter_qos(throughput_writer_qos);
    /* We will own the topic so set the strength as determined by the user. */
    throughput_writer_qos.ownership_strength.value = args.strength;
    throughput_writer_qos.resource_limits.initial_samples = 1;

    /* Large data is sent asynchronously and subject to flow control */
    if (large_data || args.asynchronous) {
        throughput_writer_qos.publish_mode.kind =
            DDS_ASYNCHRONOUS_PUBLISH_MODE_QOS;
        throughput_writer_qos.publish_mode.flow_controller_name =
            DDS_String_dup("throughput test flow_controller");
    }

    /* Create as many instances as we need */
    throughput_writer_qos.resource_limits.max_instances =
        (args.mi_instance_count > 0) ? args.mi_instance_count : 1;
    throughput_writer_qos.resource_limits.initial_instances =
        throughput_writer_qos.resource_limits.max_instances;
    /* and override as necessary */
    if (!args.is_reliable()) {
        throughput_writer_qos.reliability.kind =
            DDS_BEST_EFFORT_RELIABILITY_QOS;

        if (large_data || args.asynchronous) {
            /* We must queue samples so the asynchronous publishing thread
               can access them later when tokens become available for sending */
            throughput_writer_qos.history.kind = DDS_KEEP_ALL_HISTORY_QOS;
            throughput_writer_qos.resource_limits.max_samples = QUEUE_SIZE;
            throughput_writer_qos.resource_limits.initial_samples = QUEUE_SIZE;
            throughput_writer_qos.resource_limits.max_samples_per_instance = QUEUE_SIZE;

            /* max_blocking_time is only relevant when sending asynchronously */
            throughput_writer_qos.reliability.max_blocking_time = three_second;
        }
    } else {
        DataWriterQos_setReliableBursty(
            throughput_writer_qos, QUEUE_SIZE,
            args.get_max_blocking_time(), 10);
        throughput_writer_qos.protocol.push_on_write = !args.no_push_on_write;

        if (large_data || args.asynchronous) {
            /* An asynchronous writer coalesces all piggyback HBs into a
               single HB that gets appended when sending the last asynchronous
               sample in the queue, so it is ok to request one piggyback
               HB with every sample. */
            throughput_writer_qos.protocol.rtps_reliable_writer.
                heartbeats_per_max_samples = QUEUE_SIZE;

            throughput_writer_qos.reliability.max_blocking_time = three_second;
        }

        if (use_multicast) {
            DataWriterQos_setMulticast(throughput_writer_qos, 32, 0, 1);
        }
    }

    /* When asynchronously writing small samples, we need to trigger the flow
       controller faster than every 10ms, as the number of samples that
       can be put on the wire every 10ms greatly exceeds
       the writer's send queue size.
       Approach: send message once all gather buffers are used up.
       Need 1 buffer for RTPS header and >= 2 per issue submessage. */
    *samples_per_trigger = (max_gather_send_buffers-1)/2;
    /* Trigger at least 4 times per send queue. */
    if (*samples_per_trigger >
        throughput_writer_qos.resource_limits.max_samples/4) {
        *samples_per_trigger =
            throughput_writer_qos.resource_limits.max_samples/4;
    }
    return return_code;
}

DDS_ReturnCode_t configure_throughput_reader_qos(
    DDS_DataReaderQos &throughput_reader_qos,
    DDSSubscriber *subscriber, ThroughputSubscriberArgs &args) {
    DDS_ReturnCode_t return_code = DDS_RETCODE_OK;
    /* Get the default reader QoS and configure to our requirements */
    subscriber->get_default_datareader_qos(throughput_reader_qos);

    throughput_reader_qos.resource_limits.max_instances =
        (args.mi_instance_count > 0) ? args.mi_instance_count : 1;
    throughput_reader_qos.resource_limits.initial_instances =
        throughput_reader_qos.resource_limits.max_instances;

    throughput_reader_qos.resource_limits.max_samples_per_instance = 1;
    throughput_reader_qos.reader_resource_limits.max_samples_per_remote_writer
        = throughput_reader_qos.resource_limits.max_samples_per_instance;
    throughput_reader_qos.resource_limits.max_samples =
        throughput_reader_qos.resource_limits.max_samples_per_instance;
    throughput_reader_qos.resource_limits.initial_samples =
        throughput_reader_qos.resource_limits.max_samples_per_instance;

    if (args.is_reliable()) {
        DataReaderQos_setReliableBursty(throughput_reader_qos, 1);
    }

    if (args.mcast_recv_addr != NULL) {
        DataReaderQos_setMulticast(throughput_reader_qos,
                                   args.mcast_recv_addr, 1);
    }
    return return_code;
}

DDS_ReturnCode_t configure_command_reader_qos(
    DDS_DataReaderQos &throughput_command_reader_qos, 
    DDSSubscriber *subscriber) {
    DDS_ReturnCode_t return_code = DDS_RETCODE_OK;
    /* Get the default reader QoS and configure to
       our requirements for command packets */
    subscriber->get_default_datareader_qos(throughput_command_reader_qos);

    /* We will use reliable communications to communicate commands... */
    DataReaderQos_setImpatientReliable(throughput_command_reader_qos, 1);
    return return_code;
}

DDS_ReturnCode_t configure_command_writer_qos(
    DDS_DataWriterQos &throughput_command_writer_qos, 
    DDSPublisher *publisher, ThroughputPublisherArgs &args) {
    DDS_ReturnCode_t return_code = DDS_RETCODE_OK;
    /* Get the default writer QoS and configure to our
       requirements for command packets */
    publisher->get_default_datawriter_qos(throughput_command_writer_qos);
    /* We will own the topic so set the strength as determined by the user. */
    throughput_command_writer_qos.ownership_strength.value = args.strength;
    /* We will use guaranteed reliable communications
       to communicate commands... */
    DataWriterQos_setImpatientReliable(throughput_command_writer_qos,
        one_second, 10);
    return return_code;
}
