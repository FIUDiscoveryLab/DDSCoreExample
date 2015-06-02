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
import com.rti.ndds.config.*;
import com.rti.ndds.transport.*;


// ===========================================================================

public class LatencyPublisher {
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
        //   LogVerbosity.NDDS_CONFIG_LOG_VERBOSITY_STATUS_ALL);
        
        
        // --- Run --- //
        publisher_main(argument);
    }

    // -----------------------------------------------------------------------
    // Private Methods
    // -----------------------------------------------------------------------
    private static void udp_main(Argument argument) throws Exception {
    }

    private static void publisher_main(Argument argument) throws Exception {
        // Create data sample for writing 
        Latency instance = new Latency();

        DomainParticipantFactoryQos factory_qos = 
            new DomainParticipantFactoryQos();
        DomainParticipantFactory factory = null;
        DomainParticipantQos participant_qos = new DomainParticipantQos(); 
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
            // print publisher test banner
            System.out.println("\nRTI DDS Latency Test - Publisher");
            System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

            // Need to change default plugin property
            factory = DomainParticipantFactory.get_instance();
            factory.get_qos(factory_qos);
            factory_qos.entity_factory.autoenable_created_entities = false;
            factory.set_qos(factory_qos);

            // --- Create participant --- //
            factory.get_default_participant_qos(participant_qos);
                
            participant_qos.wire_protocol.participant_id = 0;
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
                property.send_socket_buffer_size = 
                    property.message_size_max;
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
                property.send_socket_buffer_size = 
                    property.message_size_max;
                property.recv_socket_buffer_size = 
                    2 * property.send_socket_buffer_size;
                property.multicast_ttl = argument.multicast_ttl;

                TransportSupport.set_builtin_transport_property(participant, 
                                                                property);
            } else {
                throw new Exception("Unsupported transport");
            }
            // Enable to start Discovery
            participant.enable(); 
            
            subscriber = participant.create_subscriber(
                DomainParticipant.SUBSCRIBER_QOS_DEFAULT, null, // listener 
                StatusKind.STATUS_MASK_NONE);

            publisher = participant.create_publisher(
                DomainParticipant.PUBLISHER_QOS_DEFAULT, null, // listener
                StatusKind.STATUS_MASK_NONE);

            // --- Create topics --- //        
            // Register type before creating topic
            String typeName = LatencyTypeSupport.get_type_name();
            LatencyTypeSupport.register_type(participant, typeName);
            // To customize topic QoS, use
            //   participant.get_default_topic_qos() instead
            data_topic = participant.create_topic(
                "DataTopic", typeName, DomainParticipant.TOPIC_QOS_DEFAULT,
                null, // listener 
                StatusKind.STATUS_MASK_NONE);
            echo_topic = participant.create_topic(
                "EchoTopic", typeName, DomainParticipant.TOPIC_QOS_DEFAULT,
                null, // listener 
                StatusKind.STATUS_MASK_NONE);

            // data writer
            publisher.get_default_datawriter_qos(writer_qos);

            writer_qos.history.kind = 
                HistoryQosPolicyKind.KEEP_LAST_HISTORY_QOS;
            writer_qos.history.depth = 1;

            if (!argument.is_reliable) {
                writer_qos.reliability.kind = 
                    ReliabilityQosPolicyKind.BEST_EFFORT_RELIABILITY_QOS;
            } else { //configure for a one-at-a time, impatient reliability
                writer_qos.reliability.kind = 
                    ReliabilityQosPolicyKind.RELIABLE_RELIABILITY_QOS;
                writer_qos.reliability.max_blocking_time.sec = 2;
                writer_qos.reliability.max_blocking_time.nanosec = 0;
                writer_qos.resource_limits.initial_samples =
                    writer_qos.resource_limits.max_samples =
                    writer_qos.resource_limits.max_samples_per_instance = 3;

                writer_qos.protocol.
                    rtps_reliable_writer.fast_heartbeat_period.sec = 0;
                writer_qos.protocol.
                    rtps_reliable_writer.fast_heartbeat_period.nanosec =
                    1 * 1000000; // 1 ms
                writer_qos.protocol.rtps_reliable_writer.heartbeat_period.sec =
                    3600 * 24 * 7; // 1 week

                // Because the queue is 1, want to piggyback HB 
                // w/ every sample.
                // This may be a duplicate HB, 
                // but since the send is low, it's OK
                writer_qos.protocol.
                    rtps_reliable_writer.heartbeats_per_max_samples =
                        (writer_qos.resource_limits.max_samples > 1)
                        ? writer_qos.resource_limits.max_samples
                        : 100000000;
            }

            writer = (LatencyDataWriter)
                publisher.create_datawriter(data_topic, 
                                            writer_qos,
                                            null, // listener 
                                            StatusKind.STATUS_MASK_NONE);

            // --- Create reader --- //
            listener = new LatencyListener(argument.num_iterations);
            
            subscriber.get_default_datareader_qos(reader_qos);
            if (!argument.is_reliable) {
                reader_qos.reliability.kind = 
                    ReliabilityQosPolicyKind.BEST_EFFORT_RELIABILITY_QOS;
            } else {
                reader_qos.reliability.kind = 
                    ReliabilityQosPolicyKind.RELIABLE_RELIABILITY_QOS;
                reader_qos.history.kind = 
                    HistoryQosPolicyKind.KEEP_ALL_HISTORY_QOS;
                reader_qos.protocol.
                    rtps_reliable_reader.max_heartbeat_response_delay.sec = 0;
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
                echo_topic, reader_qos, listener,
                (StatusKind.DATA_AVAILABLE_STATUS
                 | StatusKind.REQUESTED_INCOMPATIBLE_QOS_STATUS));

            // For data type that has key, if the same instance is going to be
            //   written multiple times, initialize the key here
            //   and register the keyed instance prior to writing 
            //instance_handle_reg = writer.register_instance(instance);
            InstanceHandle_t instance_handle_reg = InstanceHandle_t.HANDLE_NIL;

            // wait for the requisite number of readers to appear
            PublicationMatchedStatus matched_status = 
                new PublicationMatchedStatus();
            for (;;) {
                writer.get_publication_matched_status(matched_status);
                if (matched_status.current_count >= argument.num_subscribers) {
                    break; //found everybody, can move on
                }
                System.out.print('.'); Thread.sleep(1000);
            }
            System.out.println("\nCollecting statistics on " + 
                               argument.num_iterations +
                               " samples per message size.\nThis is the roundtrip time, *not* the one-way-latency");
            System.out.println(
		"bytes ,stdev us,ave us, min us, 50%% us, 90%% us, 99%% us, 99.99%%, max us\n" +
		"------,-------,-------,-------,-------,-------,-------,-------,-------");

            for (int m_size = argument.min_size; 
                 m_size <= argument.maxSize;
                 m_size *= 2) {

                Thread.sleep(2000);
                
                instance.data.clear();
                instance.data.setMaximum(m_size - 4);
                instance.data.addAllByte(new byte[m_size - 4]);
                // set the subscribers know who should echo (the last one)
                instance.data.setByte(0, argument.num_subscribers);
                
                listener.start_one_round(m_size);
                
                for (instance.sequence_number = 1;
                    instance.sequence_number <= argument.num_iterations; ) {
                    listener.start_one_message(instance.sequence_number);
                    writer.write(instance, instance_handle); // -- Write -- 

		    // block up to 1 s for reply
                    if(listener.wait_for_reply(1000)) {
			++instance.sequence_number;
		    } else { // warn, sleep, and retry
			System.out.println("Did not get reply at sn " +
					   instance.sequence_number);
			Thread.sleep(10);
		    }
                }

                // sort raw samples
                Collections.sort(listener.roundtrip_time_array);
                long sum;
                int i;
                for (sum = 0, i = 0; 
                     i < listener.roundtrip_time_array.size(); 
                     ++i)
                {
                    sum += listener.roundtrip_time_array.get(i);
                }

                int sample_size = listener.roundtrip_time_array.size();
                double average = (double)sum/sample_size;
                double deviation_sum;
                for (deviation_sum = 0, i = 0; i < sample_size; ++i) {
                    double sample = listener.roundtrip_time_array.get(i);
                    deviation_sum += (sample - average) * (sample - average); 
                }
                double deviation = deviation_sum / (sum / sample_size - 1);
                deviation = Math.sqrt(deviation);
                int percentile_50_sample_index = (50 * sample_size) / 100;
                int percentile_90_sample_index = (90 * sample_size) / 100;
                int percentile_99_sample_index = (99 * sample_size) / 100;
                int percentile_9999_sample_index = 
                    (9999 * sample_size) / 10000;
                
                average /= 1000.0; //convert to usec
                deviation /= 1000.0; //convert to usec
                double min_sample = (double)
                    listener.roundtrip_time_array.
                    get(0)/1000.0;
                double max_sample = (double)
                    listener.roundtrip_time_array.
                    get(sample_size-1)/1000.0;
                double percentile_50_sample = (double)
                    listener.roundtrip_time_array.
                    get(percentile_50_sample_index)/1000.0;
                double percentile_90_sample = (double)
                    listener.roundtrip_time_array.
                    get(percentile_90_sample_index)/1000.0;
                double percentile_99_sample = (double)
                    listener.roundtrip_time_array.
                    get(percentile_99_sample_index)/1000.0;
                double percentile_9999_sample = (double)
                    listener.roundtrip_time_array.
                    get(percentile_9999_sample_index)/1000.0;
	
		
		System.out.format("%6d,%7.1f,%7.1f,%7.1f,%7.1f,%7.1f,%7.1f,%7.1f,%7.1f\n",
				m_size,
                                deviation,
                                average,
                                min_sample,
                                percentile_50_sample,
                                percentile_90_sample,
                                percentile_99_sample,
                                percentile_9999_sample,
                                max_sample);
                       
	     }

            //writer.unregister_instance(instance, instance_handle_reg);
            //tell reader to shut down
            instance.sequence_number = Argument.FINAL_SN;
            instance.data.setMaximum(20);
            listener.start_one_message(instance.sequence_number);
            writer.write(instance, instance_handle);

        } finally {// --- Shutdown --- //
            if (participant != null) {
                participant.delete_contained_entities();

                DomainParticipantFactory.TheParticipantFactory.
                    delete_participant(participant);
            }
            // NDDS provides finalize_instance() method for people who want to
            //   release memory used by the participant factory singleton.
            //   Uncomment the following block of code for clean destruction of
            //   the participant factory singleton.
            DomainParticipantFactory.finalize_instance();
        }
    }
    
    // -----------------------------------------------------------------------
    // Private Types
    // -----------------------------------------------------------------------
    private static class Argument {
        public static final int RTI_DDS_OVERHEAD = 512;
        public static final int FINAL_SN = -1;
        public int num_iterations = 10000, min_size = 16, maxSize = 8192;
        public byte num_subscribers = 1;
        public int domain_id = 0,
            transport = 1,
            multicast_ttl = 1;
        public String mcast_recv_addr = null;
        public LinkedList<String> peers = new LinkedList<String>();
        public String nic = null;
        public boolean is_reliable = false;

        public Argument() {}
        
        public int 
            parse(String[] args, int currentPosition) throws Exception {
            if (args[currentPosition].equals("-numIter")) {
                num_iterations = 
                    Integer.valueOf(args[++currentPosition]).intValue();
                return ++currentPosition;
            } else if (args[currentPosition].equals("-minSize")) {
                min_size = 
                    Integer.valueOf(args[++currentPosition]).intValue();
                return ++currentPosition;
            } else if (args[currentPosition].equals("-maxSize")) {
                maxSize = 
                    Integer.valueOf(args[++currentPosition]).intValue();
                return ++currentPosition;
            } else if (args[currentPosition].equals("-subscribers")) {
                num_subscribers = 
                    Byte.valueOf(args[++currentPosition]).byteValue();
                return ++currentPosition;
            } else if (args[currentPosition].equals("-domainId")) {
                domain_id = 
                    Integer.valueOf(args[++currentPosition]).intValue();
                return ++currentPosition;
            } else if (args[currentPosition].equals("-transport")) {
                transport = 
                    Integer.valueOf(args[++currentPosition]).intValue();
                return ++currentPosition;
            } else if (args[currentPosition].equals("-nic")) {
                nic = args[++currentPosition];
                return ++currentPosition;
            } else if (args[currentPosition].equals("-reliable")) {
                is_reliable = true;
                return ++currentPosition;
            } else if (args[currentPosition].equals("-peer")) {
                peers.add(args[++currentPosition]);
                return ++currentPosition;
            } else if (args[currentPosition].equals("-mcast_recv_addr")) {
                mcast_recv_addr = args[++currentPosition];
                return ++currentPosition;
            } else if (args[currentPosition].equals("-multicast_ttl")) {
                multicast_ttl = 
                    Integer.valueOf(args[++currentPosition]).intValue();
                return ++currentPosition;
            } else {
                throw new Exception("invalid argument: " + 
                                    args[currentPosition]);
            }
        }
    }
    
    // =======================================================================
    
    private static class LatencyListener extends DataReaderAdapter {
        private int _num_iterations, _expected_sn, _received_sn, _message_size;
        private long _time_sent, _clock_overhead;
        public Logger logger;
        public ArrayList<Long> roundtrip_time_array;

        LatencySeq data_seq = new LatencySeq();
        SampleInfoSeq info_seq = new SampleInfoSeq();

        public LatencyListener(int num_iterations) {
            _num_iterations = num_iterations;
            roundtrip_time_array = new ArrayList<Long>();
            roundtrip_time_array.ensureCapacity(num_iterations);

            long start_time, finish_time = 0;
            start_time = System.nanoTime();
            for (int i = 0; i < 16; ++i) {
                finish_time = System.nanoTime();
            }
            _clock_overhead = (finish_time - start_time)/16;

            logger = Logger.get_instance();
        }
        
        void start_one_round(int message_size) {
            _message_size = message_size;
            roundtrip_time_array.clear();
        }
        void start_one_message(int expected_sn) {
            _expected_sn = expected_sn;
            _received_sn = 0;
            _time_sent = System.nanoTime();
        }
        
        // @brief for debugging
        public void 
            on_requested_incompatible_qos(DataReader reader,
                                  RequestedIncompatibleQosStatus status) {
            System.out.println("Incompatible QoS " + status.last_policy_id);
        }
        public synchronized boolean wait_for_reply(long wait_time_ms)
	    throws Exception {
            if(_received_sn == _expected_sn) { // no need to wait
		return true;
	    }
	    long start_time = System.currentTimeMillis();
	    wait(wait_time_ms);
	    long elapsed_time = System.currentTimeMillis() - start_time;
	    return(elapsed_time < (wait_time_ms - 50 /* safety margin */));
        }
        public synchronized void on_data_available(DataReader reader) {
            LatencyDataReader latency_reader = (LatencyDataReader)reader;
            try {
                latency_reader.take(
                    data_seq, info_seq,
                    ResourceLimitsQosPolicy.LENGTH_UNLIMITED,
                    SampleStateKind.ANY_SAMPLE_STATE,
                    ViewStateKind.ANY_VIEW_STATE,
                    InstanceStateKind.ANY_INSTANCE_STATE);

                long time_received = System.nanoTime();
                for (int i = 0; i < data_seq.size(); ++i) {
                    SampleInfo info = (SampleInfo)info_seq.get(i);
                    if (info.valid_data) {
                        Latency msg = (Latency)data_seq.get(i);
                        _received_sn = msg.sequence_number;  
                        if (_received_sn == _expected_sn) {
                            long roundtrip_time = 
                                time_received - _time_sent - _clock_overhead;
                            // record, so we can process later
                            roundtrip_time_array.add(roundtrip_time);
                            notify(); //let the main thread send another packet
                        } else {
                            System.out.println(
                                "**********ERROR: " +
                                "Received SN " + msg.sequence_number
                                + "!= expected " + _expected_sn);
                        }
                        if (msg.sequence_number > _num_iterations) {
                            System.out.println(
                                "**********ERROR: " +
                                "Received SN > expected " + _num_iterations);
                        }
                    }
                }
            } catch (RETCODE_NO_DATA no_data) { // No data to process
            } finally {
                latency_reader.return_loan(data_seq, info_seq);
            }
        }

    }

}

