// (c) Copyright, Real-Time Innovations, 2006.  All rights reserved.
// No duplications, whole or partial, manual or electronic, may be made
// without express written permission.  Any such copies, or
// revisions thereof, must display this notice unaltered.
// This code contains trade secrets of Real-Time Innovations, Inc.

import java.util.*;
import java.net.*;

import com.rti.dds.domain.*;
import com.rti.dds.infrastructure.*;
import com.rti.dds.subscription.*;
import com.rti.dds.publication.*;
import com.rti.dds.topic.*;
import com.rti.ndds.transport.*;
import com.rti.dds.cdr.*;

// ===========================================================================

public class LatencySubscriber {
    // -----------------------------------------------------------------------
    // Public Methods
    // -----------------------------------------------------------------------
    
    public static void main(String[] args) throws Exception {
        Argument argument = new Argument();
        
        for (int i = 0; i < args.length; ) {
            i = argument.parse(args, i);
        }

        // Uncomment this to turn on additional logging
        //   Logger.get_instance().set_verbosity_by_category(
        //   LogCategory.NDDS_CONFIG_LOG_CATEGORY_API, 
        //  LogVerbosity.NDDS_CONFIG_LOG_VERBOSITY_STATUS_ALL);
                
        // --- Run --- //
        subscriber_main(argument);
    }
    
    // -----------------------------------------------------------------------
    // Private Methods
    // -----------------------------------------------------------------------
    
    private static void subscriber_main(Argument argument)
        throws Exception {
        DomainParticipantFactoryQos factory_qos = 
            new DomainParticipantFactoryQos();
        DomainParticipantFactory factory = null;
        DomainParticipantQos participant_qos = 
            new DomainParticipantQos(); 
        DomainParticipant participant = null;
        Subscriber subscriber = null;
        Publisher publisher = null;
        Topic data_topic = null, echo_topic = null;
        LatencyListener listener = null;
        DataReaderQos reader_qos = new DataReaderQos();
        LatencyDataReader reader = null;
        DataWriterQos writer_qos = new DataWriterQos();
        LatencyDataWriter writer = null;
        InstanceHandle_t instance_handle = InstanceHandle_t.HANDLE_NIL;

        try {
            // print subscriber test banner
            System.out.println("\nRTI DDS Latency Test - Subscriber");
            System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

            // Need to change default plugin property
            factory = DomainParticipantFactory.get_instance();
            factory.get_qos(factory_qos);
            factory_qos.entity_factory.autoenable_created_entities = false;
            factory.set_qos(factory_qos);

            // --- Create participant --- //
            factory.get_default_participant_qos(participant_qos);

            participant_qos.wire_protocol.participant_id = argument.cookie;
            participant_qos.resource_limits.writer_user_data_max_length = 128;
            participant_qos.receiver_pool.buffer_size =
                MAX_DATA_SEQUENCE_LENGTH.VALUE + 8 + Argument.RTI_DDS_OVERHEAD;
            participant_qos.transport_builtin.mask = argument.transport;
            participant_qos.discovery_config.
                participant_liveliness_assert_period.sec = 61;
            participant_qos.discovery_config.
                participant_liveliness_lease_duration.sec = 128;

            //clear default initial_peers
	    if (argument.peers.size() != 0) {
		participant_qos.discovery.initial_peers.clear();
		participant_qos.discovery.initial_peers.addAll(argument.peers);
		// clear built-in multicast receive address
		participant_qos.discovery.multicast_receive_addresses.clear();
	    }
            
            participant = factory.create_participant(
                argument.domain_id, participant_qos,
                null, // listener  
                StatusKind.STATUS_MASK_NONE);

            if (argument.transport == TransportBuiltinKind.SHMEM) {
                ShmemTransport.Property_t property = 
                    new ShmemTransport.Property_t();
                TransportSupport.get_builtin_transport_property(participant, 
                                                                property);

                property.message_size_max = 
                    participant_qos.receiver_pool.buffer_size;
                property.receive_buffer_size = 
                    property.received_message_count_max *
                    property.message_size_max;

                TransportSupport.set_builtin_transport_property(participant, 
                                                                property);
            } else if (argument.transport == TransportBuiltinKind.UDPv4) {
                UDPv4Transport.Property_t property = 
                    new UDPv4Transport.Property_t();                    
                TransportSupport.get_builtin_transport_property(participant, 
                                                                property);
                
                // bind to a particular interface
                if (argument.nic != null) {
                    property.allow_interfaces_list.add(argument.nic);
                }
                property.message_size_max = 
                    participant_qos.receiver_pool.buffer_size;
                property.send_socket_buffer_size = property.message_size_max;
                property.recv_socket_buffer_size = 
                    2 * property.send_socket_buffer_size;
                property.multicast_ttl = argument.multicast_ttl;

                TransportSupport.set_builtin_transport_property(participant, 
                                                                property);
            } else if (argument.transport == TransportBuiltinKind.UDPv6) {
                UDPv6Transport.Property_t property = 
                    new UDPv6Transport.Property_t();                    
                TransportSupport.get_builtin_transport_property(participant, 
                                                                property);
                
                // bind to a particular interface
                if (argument.nic != null) {
                    property.allow_interfaces_list.add(argument.nic);
                }
                property.message_size_max = 
                    participant_qos.receiver_pool.buffer_size;
                property.send_socket_buffer_size = property.message_size_max;
                property.recv_socket_buffer_size = 
                    2 * property.send_socket_buffer_size;
                property.multicast_ttl = argument.multicast_ttl;

                TransportSupport.set_builtin_transport_property(participant, 
                                                                property);
            } else {
                throw new Exception("Unsupported transport");
            }
            // --- Enable to start Discovery ---
            participant.enable(); 
            
            subscriber = participant.create_subscriber(
                DomainParticipant.SUBSCRIBER_QOS_DEFAULT, null, // listener
                StatusKind.STATUS_MASK_NONE);

            publisher = participant.create_publisher(
                DomainParticipant.PUBLISHER_QOS_DEFAULT, null, // listener
                StatusKind.STATUS_MASK_NONE);
            

            // --- Create topic --- //
        
            // Register type before creating topic 
            String type_name = LatencyTypeSupport.get_type_name(); 
            LatencyTypeSupport.register_type(participant, type_name);

            // To customize topic QoS, use
            //  participant.get_default_topic_qos() instead of default
            data_topic = participant.create_topic(
                "DataTopic", type_name, DomainParticipant.TOPIC_QOS_DEFAULT,
                null, // listener 
                StatusKind.STATUS_MASK_NONE);
            echo_topic = participant.create_topic(
                "EchoTopic", type_name, DomainParticipant.TOPIC_QOS_DEFAULT,
                null, // listener
                StatusKind.STATUS_MASK_NONE);

            // echo writer
            publisher.get_default_datawriter_qos(writer_qos);
            if (!argument.is_reliable) {
                writer_qos.reliability.kind = 
                    ReliabilityQosPolicyKind.BEST_EFFORT_RELIABILITY_QOS;
            } else {//configure for a one-at-a time, impatient reliability
                writer_qos.reliability.kind = 
                    ReliabilityQosPolicyKind.RELIABLE_RELIABILITY_QOS;
                writer_qos.reliability.max_blocking_time.sec = 1;
                writer_qos.reliability.max_blocking_time.nanosec = 0;
                writer_qos.resource_limits.initial_samples =
                    writer_qos.resource_limits.max_samples = 3;
                writer_qos.resource_limits.max_samples_per_instance =
                    writer_qos.resource_limits.max_samples;
                writer_qos.protocol.rtps_reliable_writer.
                    fast_heartbeat_period.nanosec = 1 * 1000000; //1 ms
                writer_qos.protocol.rtps_reliable_writer.
                    heartbeat_period.sec = 3600 * 24 * 7; //1 week

                // because the queue is 1, 
                // want to piggyback HB w/ every sample.
                // This may be a duplicate HB, 
                // but since the send is low, it's OK
                writer_qos.protocol.rtps_reliable_writer.
                    heartbeats_per_max_samples = 
                    writer_qos.resource_limits.max_samples;
                writer_qos.history.kind = 
                    HistoryQosPolicyKind.KEEP_ALL_HISTORY_QOS;
            }
            writer = (LatencyDataWriter)
                publisher.create_datawriter(echo_topic, 
                                            writer_qos,
                                            null, // listener
                                            StatusKind.STATUS_MASK_NONE);
            // --- Create reader --- //
            listener = new LatencyListener(writer, 
                                           instance_handle, 
                                           argument.cookie);

            subscriber.get_default_datareader_qos(reader_qos);
            if (!argument.is_reliable) {
                reader_qos.reliability.kind = 
                    ReliabilityQosPolicyKind.BEST_EFFORT_RELIABILITY_QOS;
            } else {
                reader_qos.reliability.kind = 
                    ReliabilityQosPolicyKind.RELIABLE_RELIABILITY_QOS;
                reader_qos.history.kind = 
                    HistoryQosPolicyKind.KEEP_ALL_HISTORY_QOS;
                reader_qos.protocol.rtps_reliable_reader.
                    max_heartbeat_response_delay.sec = 0;
                reader_qos.protocol.rtps_reliable_reader.
                    max_heartbeat_response_delay.nanosec = 0;
            }
            if (argument.mcast_recv_addr != null) {
                TransportMulticastSettings_t ms = 
                    new TransportMulticastSettings_t();
                ms.receive_address = 
                    InetAddress.getByName(argument.mcast_recv_addr);
                reader_qos.multicast.value.add(ms);
            }
            reader = (LatencyDataReader)subscriber.create_datareader(
                data_topic, reader_qos, listener,
                (StatusKind.DATA_AVAILABLE_STATUS
                 | StatusKind.REQUESTED_INCOMPATIBLE_QOS_STATUS));

            while (!listener.has_received_sentinel()) {
                Thread.sleep(1000); //sleep for 1 sec
            }
        } finally { // --- Shutdown --- //
            if (participant != null) {
                participant.delete_contained_entities();

                DomainParticipantFactory.TheParticipantFactory.
                    delete_participant(participant);
            }
            // RTI DDS provides finalize_instance() method for people 
            // who want to release memory used by the participant 
            // factory singleton.
            // Uncomment the following block of code for clean destruction of
            // the participant factory singleton.
            DomainParticipantFactory.finalize_instance();
        }
    }
    
    // -----------------------------------------------------------------------
    // Private Types
    // -----------------------------------------------------------------------
    private static class Argument {
        public static final int RTI_DDS_OVERHEAD = 512;
        public static final int FINAL_SN = -1;
        public int cookie = 1;
        public boolean no_echo = false;
        public int domain_id = 0,
            transport = 1,
            multicast_ttl = 1;
        public String mcast_recv_addr = null;
        public LinkedList<String> peers = new LinkedList<String>();;
        public String nic = null;
        public boolean is_reliable = false;

        public Argument() {}
        
        public int parse(String[] args, int current_position) 
        throws Exception {
            if (args[current_position].equals("-cookie")) {
                cookie = 
                    Integer.valueOf(args[++current_position]).intValue();
                return ++current_position;
            } else if (args[current_position].equals("-noecho")) {
                no_echo = true;
                return ++current_position;
            } else if (args[current_position].equals("-domainId")) {
                domain_id = 
                    Integer.valueOf(args[++current_position]).intValue();
                return ++current_position;
            } else if (args[current_position].equals("-transport")) {
                transport = 
                    Integer.valueOf(args[++current_position]).intValue();
                return ++current_position;
            } else if (args[current_position].equals("-nic")) {
                nic = args[++current_position];
                return ++current_position;
            } else if (args[current_position].equals("-reliable")) {
                is_reliable = true;
                return ++current_position;
            } else if (args[current_position].equals("-peer")) {
                peers.add(args[++current_position]);
                return ++current_position;
            } else if (args[current_position].equals("-mcast_recv_addr")) {
                mcast_recv_addr = args[++current_position];
                return ++current_position;
            } else if (args[current_position].equals("-multicast_ttl")) {
                multicast_ttl = 
                    Integer.valueOf(args[++current_position]).intValue();
                return ++current_position;
            } else {
                throw new Exception("invalid argument: " + 
                                    args[current_position]);
            }
        }
    }

    
    // =======================================================================
    
    private static class LatencyListener extends DataReaderAdapter {
        private LatencyDataWriter _writer;
        private InstanceHandle_t _instance_handle;
        private int _sequence_number = 0,
            _cookie,
            _num_messages = 0,
            _num_replies = 0;

        LatencySeq data_seq = new LatencySeq();
        SampleInfoSeq info_seq = new SampleInfoSeq();

        public LatencyListener(LatencyDataWriter writer,
                               InstanceHandle_t instance_handle,
                               int cookie) {
            _writer = writer;
            _instance_handle = instance_handle;
            _cookie = cookie;
        }
        
        public boolean has_received_sentinel() {
            return(_sequence_number == Argument.FINAL_SN);
        }
        
        public void on_requested_incompatible_qos(DataReader reader,
                                     RequestedIncompatibleQosStatus status) {
            System.out.println("Incompatible QoS " + status.last_policy_id);
        }
        
        public void on_data_available(DataReader reader) {
            LatencyDataReader LatencyReader = (LatencyDataReader)reader;
            try {
                LatencyReader.take(
                    data_seq, info_seq,
                    ResourceLimitsQosPolicy.LENGTH_UNLIMITED,
                    SampleStateKind.ANY_SAMPLE_STATE,
                    ViewStateKind.ANY_VIEW_STATE,
                    InstanceStateKind.ANY_INSTANCE_STATE);

                for (int i = 0; i < data_seq.size(); ++i) {
                    SampleInfo info = (SampleInfo)info_seq.get(i);
                    if (info.valid_data) {
                        Latency msg = (Latency)data_seq.get(i);
                        byte cookie = msg.data.getByte(0);
                        _sequence_number = msg.sequence_number;
                        if (cookie == _cookie) {
                            _writer.write(msg, _instance_handle);
                            ++_num_replies;
                        }
                        if (msg.sequence_number == Argument.FINAL_SN) {
                            System.out.println("Test end signaled after " + 
                                               _num_messages +
                                               " messages and " + 
                                               _num_replies + " replies");
                        }
                    }
                    ++_num_messages;
                }
            } catch (RETCODE_NO_DATA no_data) { // No data to process
            } finally {
                LatencyReader.return_loan(data_seq, info_seq);
            }
        }
    }
}

