/*
 (c) Copyright, Real-Time Innovations, $Date: 2009/05/17 03:52:03 $.
 All rights reserved.
 No duplications, whole or partial, manual or electronic, may be made
 without express written permission.  Any such copies, or
 revisions thereof, must display this notice unaltered.
 This code contains trade secrets of Real-Time Innovations, Inc.
*/

import java.net.InetAddress;
import java.text.DecimalFormat;

import com.rti.dds.domain.*;
import com.rti.dds.infrastructure.*;
import com.rti.dds.subscription.*;
import com.rti.dds.topic.*;
import com.rti.ndds.config.*;
import com.rti.ndds.transport.*;

// ===========================================================================

public class ThroughputSubscriber {
    // -----------------------------------------------------------------------
    // Public Methods
    // -----------------------------------------------------------------------

    public static void main(String[] args) {
        Argument arguments = new Argument(args.length, args);

        if (!arguments.isValid()) {
            System.out.println("Invalid arg; please consult README");
            return;
        }
        subscriberMain(arguments);
    }

    private static void subscriberMain(Argument args) {
        DomainParticipantFactoryQos factory_qos = null;
        DomainParticipantFactory factory = null;

        DomainParticipantQos participant_qos = null;
        DomainParticipant participant = null;

        SubscriberQos subscriber_qos = null;
        Subscriber subscriber = null;

        // And a data writer to do the work
        DataReaderQos data_reader_qos = null;
        ThroughputDataReader data_reader = null;

        ThroughputListener data_listener = null;

        // And a writer to communicate commands
        DataReaderQos command_reader_qos = null;
        ThroughputCommandDataReader command_reader = null;

        ThroughputCommandListener command_listener;

        TopicQos data_topic_qos = null;
        Topic data_topic = null;
        TopicQos command_topic_qos = null;
        Topic command_topic = null;

        try {
            int i;
            factory_qos = new DomainParticipantFactoryQos();

            participant_qos = new DomainParticipantQos();
            subscriber_qos = new SubscriberQos();

            // And a data writer to do the work
            data_reader_qos = new DataReaderQos();
            data_topic_qos = new TopicQos();

            // And a writer to communicate commands
            command_reader_qos = new DataReaderQos();
            command_topic_qos = new TopicQos();

            /******************************************************************
             * Plug-in transport variables
             *****************************************************************/
            UDPv4Transport.Property_t udpv4TransportProperty =
                new UDPv4Transport.Property_t();
            ShmemTransport.Property_t smemTransportProperty =
                new ShmemTransport.Property_t();
            UDPv6Transport.Property_t udpv6TransportProperty =
                new UDPv6Transport.Property_t();

            /******************************************************************
             * Other data
             *****************************************************************/

            // Time in milliseconds
            long tenMilliSec = 10;
            long oneSecond = 1000;
            long threeSecond = 3000;

            long startTimeInMilli = 0, stopTimeInMilli = 0;
            long deltaTimeInMilli = 0;
            double bytesRead = 0.0;
            int packetsReceived = 0;

            double subscriberThroughput = 0.0;
            String locator = null;

            set_logger_verbosity(args.nddsVerbosity);

            factory = DomainParticipantFactory.get_instance();

            configure_factory_qos(factory_qos, factory);

            configure_participant_qos(participant_qos, factory, args);

            // Now we can create the 'disabled' participant.
            participant = factory.create_participant(args.nddsDomain,
                    participant_qos, null, StatusKind.STATUS_MASK_NONE);

            configure_participant_transport(locator, udpv4TransportProperty,
                    smemTransportProperty, udpv6TransportProperty, participant,
                    args);

            // Now enable the participant
            participant.enable();

            participant.get_default_subscriber_qos(subscriber_qos);
            // And create the subscriber with default QoS and a default listener
            subscriber = participant.create_subscriber(subscriber_qos, null,
                    StatusKind.STATUS_MASK_NONE);

            /******************************************************************
             * Set up Throughput topic and reader.
             *****************************************************************/
            // Now we register the data topic type with the participant.
            ThroughputTypeSupport.register_type(participant,
                    ThroughputTypeSupport.get_type_name());

            // Get the default QoS for the Topic
            participant.get_default_topic_qos(data_topic_qos);
            // There is only one publisher of this Topic so...
            data_topic_qos.ownership.kind =
                OwnershipQosPolicyKind.EXCLUSIVE_OWNERSHIP_QOS;
            // And create a Topic with QoS and default listener.
            // Note: Ownership is Shared by default.
            data_topic = participant.create_topic("Throughput",
                    ThroughputTypeSupport.get_type_name(), data_topic_qos,
                    null, StatusKind.STATUS_MASK_NONE);

            data_listener = new ThroughputListener();
            data_listener.setVerbosity(args.testVerbosity);

            // Get the default reader QoS and configure to our requirements
            configure_data_reader_qos(data_reader_qos, subscriber, args);

            data_reader = (ThroughputDataReader) subscriber.create_datareader(
                    data_topic, data_reader_qos, data_listener,
                    StatusKind.STATUS_MASK_ALL);

            /******************************************************************
             * Set up Command topic and reader.
             *****************************************************************/

            // Now we register the command topic type with the participant
            ThroughputCommandTypeSupport.register_type(participant,
                    ThroughputCommandTypeSupport.get_type_name());

            // and create the command topic and reader
            participant.get_default_topic_qos(command_topic_qos);
            // We need exclusive ownership of this Topic because there is only
            // one writer so...
            command_topic_qos.ownership.kind =
                OwnershipQosPolicyKind.EXCLUSIVE_OWNERSHIP_QOS;
            // And create a Topic with QoS and default listener. Note Ownership
            // is Shared by default.
            command_topic = participant.create_topic("ThroughputCommand",
                    ThroughputCommandTypeSupport.get_type_name(),
                    command_topic_qos, null, StatusKind.STATUS_MASK_NONE);

            command_listener = new ThroughputCommandListener();
            command_listener.setVerbosity(args.testVerbosity);

            // Get the default reader QoS and configure to our requirements for
            // command packets
            configure_command_reader_qos(command_reader_qos, subscriber);

            // create and enable reader
            command_reader =
                (ThroughputCommandDataReader) subscriber.create_datareader(
                    command_topic, command_reader_qos,
                    command_listener, StatusKind.STATUS_MASK_ALL);

            // ////////////////////////////////////////////////////////////////
            // Start test
            // ////////////////////////////////////////////////////////////////

            System.out.print("\n\nStarting test...\n");
            System.out
                .print("\n bytes, effort,samples,lost(A),Nreject,lost(N)," +
                        " Mbit/s,duration\n" +
                        "------,-------,-------,-------,-------,-------," +
                        "-------,--------\n");

            do {
                command_listener.reset();

                // Reset Data Reader Listener counts prior to starting test
                data_listener.resetCounts();

                // Wait for a start command
                if (args.testVerbosity >= Argument.TEST_VERBOSITY_WARNINGS) {
                    System.out.print("Waiting for test start command\n");
                }

                // wait for the start command
                while (command_listener.packet.command !=
                    ThroughputCommandKind.THROUGHPUT_COMMAND_START) {
                    try {
                        Thread.sleep(tenMilliSec);
                    } catch (InterruptedException ie) {
                        System.err.println("Thread interrupted during sleep");
                    }
                }
                startTimeInMilli = System.currentTimeMillis();

                // Run until the test complete command is received
                while (command_listener.packet.command !=
                    ThroughputCommandKind.THROUGHPUT_COMMAND_COMPLETE) {
                    try {
                        Thread.sleep(tenMilliSec);
                    } catch (InterruptedException ie) {
                        System.err.println("Thread interrupted during sleep");
                    }
                }
                stopTimeInMilli = System.currentTimeMillis();

                packetsReceived = data_listener.getPacketsReceived();

                deltaTimeInMilli = stopTimeInMilli - startTimeInMilli;

                bytesRead = (double) packetsReceived 
                        * (Argument.TEST_PACKET_OVERHEAD +
                                command_listener.packet.data_length);
                if (deltaTimeInMilli > 0) {
                    subscriberThroughput = ((8.0 * (double) bytesRead /
                            (((double) deltaTimeInMilli) /
                                    Argument.MILLISEC_PER_SEC)) / 1000000.0);
                }

		System.out.format("%6d,%7d,%7d,%7d,%7d,%7d,%7.1f,%8.1f\n",
			(command_listener.packet.data_length + Argument.TEST_PACKET_OVERHEAD),
			command_listener.packet.current_publisher_effort,
			packetsReceived,
			data_listener.getPacketsLost(),
			data_listener.getSamplesRejected(),
			data_listener.getSamplesLost(),
			subscriberThroughput,
			(1.0f*deltaTimeInMilli) / Argument.MILLISEC_PER_SEC);


                /* Receive remaining of data */
                try {
                    Thread.sleep(threeSecond);
                } catch (InterruptedException ie) {
                    System.err.println("Thread interrupted during sleep");
                }
                
            } while (command_listener.packet.current_publisher_effort <
                    command_listener.packet.final_publisher_effort);
        } finally {
            if (participant != null) {
                participant.delete_contained_entities();

                DomainParticipantFactory.TheParticipantFactory
                        .delete_participant(participant);
            }
        }
    }

    private static class ThroughputListener extends DataReaderAdapter {
        ThroughputSeq dataSeq = new ThroughputSeq();

        SampleInfoSeq infoSeq = new SampleInfoSeq();

        private int _packetsReceived;

        private int _packetsLost;

        private long _sequenceNumber;

        private int _matchingWriter;

        private int _testVerbosity;

        private int _samplesLost;

        private int _samplesRejected;

        public ThroughputListener() {
            reset();
            _testVerbosity = 0;
        }

        public void on_data_available(DataReader reader) {
            ThroughputDataReader dataReader = (ThroughputDataReader) reader;

            try {
                dataReader.take(dataSeq, infoSeq,
                        ResourceLimitsQosPolicy.LENGTH_UNLIMITED,
                        SampleStateKind.NOT_READ_SAMPLE_STATE,
                        ViewStateKind.ANY_VIEW_STATE,
                        InstanceStateKind.ALIVE_INSTANCE_STATE);

                for (int i = 0; i < dataSeq.size(); ++i) {
                    if (((SampleInfo) infoSeq.get(i)).valid_data) {
                        if (((Throughput) dataSeq.get(i)).sequence_number !=
                            _sequenceNumber) {
                            if (_sequenceNumber != 0) {
                                if (_testVerbosity >=
                                    Argument.TEST_VERBOSITY_MESSAGES) {
                                    System.out
                                            .println("dataSeq["
                                                    + i
                                                    + "].seq = "
                                                    + ((Throughput) dataSeq
                                                       .get(i)).sequence_number
                                                    + ", Expected seq = "
                                                    + _sequenceNumber);
                                }
                                _packetsLost += (((Throughput) dataSeq.get(i)).
                                        sequence_number - _sequenceNumber);
                            }
                            _sequenceNumber = ((Throughput) dataSeq.get(i)).
                                sequence_number;
                            // Reset sequence number
                        }
                        _packetsReceived++;
                        _sequenceNumber++; // Increment expected sequence
                        // number
                    }
                }
                dataReader.return_loan(dataSeq, infoSeq);
            } catch (RETCODE_NO_DATA noData) {
                // No data to process
            }
        }

        public void on_liveliness_changed(DataReader reader,
                LivelinessChangedStatus status) {
        }

        public void on_requested_deadline_missed(DataReader reader,
                RequestedDeadlineMissedStatus status) {
        }

        public void on_requested_incompatible_qos(DataReader reader,
                RequestedIncompatibleQosStatus status) {
        }

        public void on_sample_lost(
            DataReader reader, SampleLostStatus status) {
            // Only for Reliable Communications.
            _samplesLost += status.total_count_change;
        }

        public void on_sample_rejected(DataReader reader,
                SampleRejectedStatus status) {
            _samplesRejected += status.total_count_change;
        }

        public void on_subscription_matched(DataReader reader,
                SubscriptionMatchedStatus status) {
            _matchingWriter = status.current_count;
        }

        void setVerbosity(int verbosity) {
            _testVerbosity = verbosity;
        }

        int getPacketsReceived() {
            return _packetsReceived;
        }

        int getPacketsLost() {
            return _packetsLost;
        }

        int getSamplesLost() {
            return _samplesLost;
        }

        int getSamplesRejected() {
            return _samplesRejected;
        }

        int getMatchingWriters() {
            return _matchingWriter;
        }

        void resetCounts() {
            _samplesRejected = 0;
            _samplesLost = 0;
            _sequenceNumber = 0;
            _packetsReceived = 0;
            _packetsLost = 0;
        }

        void reset() {
            resetCounts();
            _matchingWriter = 0;
        }
    }

    private static class ThroughputCommandListener extends DataReaderAdapter {

        public ThroughputCommand packet = new ThroughputCommand();

        private int _matchingWriter;

        private int _testVerbosity;

        private int _sampleLost;

        public void reset() {
            packet.command = ThroughputCommandKind.THROUGHPUT_COMMAND_IDLE;
        }

        public ThroughputCommandListener() {
            packet.data_length = 0;
            _testVerbosity = 0;
            _matchingWriter = 0;
            _sampleLost = 0;
            reset();
        }

        public void on_data_available(DataReader reader) {
            ThroughputCommandDataReader commandReader =
                (ThroughputCommandDataReader) reader;
            ThroughputCommandSeq dataSeq = new ThroughputCommandSeq();
            // sequence of user data type
            SampleInfoSeq infoSeq = new SampleInfoSeq(); // sequence of
            // DDS_SampleInfo

            try {
                commandReader.take(dataSeq, infoSeq,
                        ResourceLimitsQosPolicy.LENGTH_UNLIMITED,
                        SampleStateKind.NOT_READ_SAMPLE_STATE,
                        ViewStateKind.ANY_VIEW_STATE,
                        InstanceStateKind.ALIVE_INSTANCE_STATE);

                for (int i = 0; i < dataSeq.size(); ++i) {
                    if (((SampleInfo) infoSeq.get(i)).valid_data) {
                        packet = (ThroughputCommand) dataSeq.get(i);
                    }
                }

                commandReader.return_loan(dataSeq, infoSeq);
            } catch (RETCODE_NO_DATA noData) {
                // No data to process
            }
        }

        public void on_liveliness_changed(DataReader reader,
                LivelinessChangedStatus status) {
        }

        public void on_requested_deadline_missed(DataReader reader,
                RequestedDeadlineMissedStatus status) {
        }

        public void on_requested_incompatible_qos(DataReader reader,
                RequestedIncompatibleQosStatus status) {
        }

        public void on_sample_lost(
            DataReader reader, SampleLostStatus status) {
            _sampleLost = status.total_count;
        }

        public void on_sample_rejected(DataReader reader,
                SampleRejectedStatus status) {
        }

        public void on_subscription_matched(DataReader reader,
                SubscriptionMatchedStatus status) {
            _matchingWriter = status.current_count;
        }

        public void setVerbosity(int verbosity) {
            _testVerbosity = verbosity;
        }

        public int getSampleLost() {
            return _sampleLost;
        }

        public int getMatchingWriters() {
            return _matchingWriter;
        }
    }

    private static void DataReaderQos_setMulticast(DataReaderQos qos,
            String mcastUserDataAddress) {
        DataReaderQos_setMulticast(qos, mcastUserDataAddress, 1);
    }

    private static void DataReaderQos_setMulticast(DataReaderQos qos,
            String mcastUserDataAddress, int multicastReaderCount) {
        TransportMulticastSettings_t multicastLocator =
            new TransportMulticastSettings_t();
        try {
            multicastLocator.receive_address = InetAddress.getByName(
                mcastUserDataAddress);
        } catch (Exception UnknownHostException) {
            System.err
                .println("Unknown Host Exception using multicast address");
        }

        qos.multicast.value.clear();
        qos.multicast.value.add(multicastLocator);

        qos.resource_limits.initial_samples *= multicastReaderCount;
        if (qos.resource_limits.initial_samples >
            qos.resource_limits.max_samples) {
            qos.resource_limits.max_samples =
                qos.resource_limits.initial_samples;
        }
        qos.reader_resource_limits.max_samples_per_remote_writer =
            qos.resource_limits.initial_samples;
    }

    private static void DataReaderQos_setImpatientReliable(DataReaderQos qos,
            int remoteWriterCountMax) {
        qos.reliability.kind = 
            ReliabilityQosPolicyKind.RELIABLE_RELIABILITY_QOS;
        qos.history.kind = HistoryQosPolicyKind.KEEP_ALL_HISTORY_QOS;
        // limit the queue, because we don't need to use the queue
        int unresolvedSamplePerRemoteWriterMax = 2;

        qos.reader_resource_limits.max_samples_per_remote_writer =
            unresolvedSamplePerRemoteWriterMax;
        qos.resource_limits.initial_samples = remoteWriterCountMax
                * unresolvedSamplePerRemoteWriterMax;
        // don't limit max yet
        // qos->resource_limits.max_samples =
        // qos->resource_limits.initial_samples;

        // use these hard coded value until you use key
        // don't limit the max yet
        // qos->resource_limits.max_samples_per_instance =
        // qos->reader_resource_limits.initial_remote_writers_per_instance;
        qos.resource_limits.initial_instances = 1;
        // qos->resource_limits.max_instances =
        // qos->resource_limits.initial_instances;

        qos.protocol.rtps_reliable_reader.max_heartbeat_response_delay.sec = 0;
        qos.protocol.rtps_reliable_reader.max_heartbeat_response_delay.nanosec 
            = 0;
        qos.protocol.rtps_reliable_reader.min_heartbeat_response_delay.sec = 0;
        qos.protocol.rtps_reliable_reader.min_heartbeat_response_delay.nanosec 
            = 0;
    }

    private static void DataReaderQos_setReliableBursty(DataReaderQos qos) {
        DataReaderQos_setReliableBursty(qos, 1);
    }

    private static void DataReaderQos_setReliableBursty(DataReaderQos qos,
            int remoteWriterCountMax) {
        qos.reliability.kind =
            ReliabilityQosPolicyKind.RELIABLE_RELIABILITY_QOS;
        qos.history.kind = HistoryQosPolicyKind.KEEP_ALL_HISTORY_QOS;

        // reader queue can be constant regardless of rate
        int unresolvedSamplePerRemoteWriterMax = 100;

        qos.resource_limits.max_samples =
            remoteWriterCountMax * unresolvedSamplePerRemoteWriterMax;
        qos.resource_limits.initial_samples = qos.resource_limits.max_samples;

        qos.reader_resource_limits.max_samples_per_remote_writer =
            qos.resource_limits.initial_samples;
        qos.resource_limits.max_samples_per_instance =
            qos.resource_limits.initial_samples;

        // the writer probably has more for the reader; ask right away
        qos.protocol.rtps_reliable_reader.min_heartbeat_response_delay.sec = 0;
        qos.protocol.rtps_reliable_reader.min_heartbeat_response_delay.nanosec 
            = 0;
        qos.protocol.rtps_reliable_reader.max_heartbeat_response_delay.sec = 0;
        qos.protocol.rtps_reliable_reader.max_heartbeat_response_delay.nanosec 
            = 0;
    }

    /* Subscriber arguments */
    // Derived classes for Publisher arguments or Subscriber arguments
    private static class Argument {
        // Class specific public members
        public String mcast_recv_addr;

        final static int NDDS_OVERHEAD = 256; /*
                                                 * Conservate estimate to
                                                 * account for overhead */

        final static int TEST_VERBOSITY_ERRORS = 1;

        final static int TEST_VERBOSITY_WARNINGS = 2;

        final static int TEST_VERBOSITY_MESSAGES = 3;

        final static int THROUGHPUT_TEST_MAX_NODES = 16;

        final static int THROUGHPUT_TEST_DOMAIN_DEFAULT = 0;

        final static int MAX_TEST_SUBSCRIBERS = 16;

        final static int MIN_TEST_DURATION_SEC = 1;

        final static int MAX_COMMAND_LINE_ARGUMENTS = 80;

        // final static int MAX_PEER_LOCATOR_STR_LEN = 128;
        final static int MAX_PEER_PART_IDX = 4; // Allow a maximum of 5

        // participants (0..4) per node.

        final static int MAX_SAMPLES_PER_INSTANCE = 512; // An arbitrary

        // total number of
        // samples

        final static int MAX_INITIAL_SAMPLES = 512; // The initial allocation

        final static int DEFAULT_TEST_DURATION = 10; // 10 seconds

        final static int DEFAULT_TEST_STRENGTH = 5;

        final static int DEFAULT_NUMBER_OF_SUBSCRIBERS = 1;

        final static int DEFAULT_TEST_VERBOSITY = TEST_VERBOSITY_ERRORS;

        final static int DEFAULT_NDDS_VERBOSITY = 1;

        final static int DEFAULT_DEMAND = 10; // Message per write loop

        final static int DEFAULT_PUBLISHER_PARTICIPANT_INDEX = 0;

        final static int DEFAULT_SUBSCRIBER_PARTICIPANT_INDEX = 1;

        final static int DEFAULT_MAX_BLOCKING_TIME_NS = 999000000;

        final static int DEFAULT_FAST_HEARTBEAT_TIME_NS = 1000000;

        final static int TEST_PACKET_OVERHEAD = 8; // 4 Bytes for length of

        // sequence and 4 bytes for
        // sequence number.

        final static int DEFAULT_PACKET_SIZE = (1024 - TEST_PACKET_OVERHEAD);

        final static int NANOSEC_PER_MILLISEC = 1000000;

        final static long NANOSEC_PER_SEC = 1000000000;

        final static int MILLISEC_PER_SEC = 1000;

        final static int MESSAGE_SIZE_MAX = 8192; // 65535

	final static int UDP_SIZE_MAX = 65536;

	final static int SHMEM_SIZE_MAX = 9216;

        final static int MAX_SAMPLES = 100;

        // final static int LOW_WATERMARK = (MAX_SAMPLES - 80); // 20%
        // final static int HIGH_WATERMARK = (MAX_SAMPLES - 30); // 70%
        final static int MAX_EVENT_COUNT = (1024 * 16);

        // final static int _MAX_PATH = 260;
        final static int MAX_ACCEPTABLE_PACKET_LOSS = 4;

        // Class variables available to derived classes only
        protected String[] _peerHosts;

        protected String _errorString;

        protected String _nic; // Used to restrict the (NIC) interface that the

        // test uses

        protected String _argumentsBuff; // Buffer to hold arguments from

        // file.

        protected String _argVariables[]; // Arguments parsed from file buffer

        protected boolean _argsValid;

        protected boolean _reliable;

        protected int _transportToUse;

        protected boolean _dontTestNdds;

        public int nddsDomain; // Test domain

        public int maxPeerIndex; // Number of peers

        public int participantId; // the participant Id which must be

        // supplied

        public int nddsVerbosity; // NDDS verbosity

        public int testVerbosity; // Test verbosity

        public String exeName;

        // Constructors
        public Argument(int argc, String[] argv) {
            _peerHosts = new String[THROUGHPUT_TEST_MAX_NODES];
            _errorString = new String();
            _nic = new String();
            _argumentsBuff = new String();
            _argVariables = new String[MAX_COMMAND_LINE_ARGUMENTS];
            initialise(); // Set the defaults

            _argsValid = true; // Assume that arguments are OK
            exeName = "Throughput_subscriber";
            mcast_recv_addr = null;
            _argsValid = parseArguments(argc, argv);
        }

        public String getPeerHost(int index) {
            if (index > THROUGHPUT_TEST_MAX_NODES) {
                return null;
            } else {
                return _peerHosts[index];
            }
        }

        // With defaults for the Subscriber
        public void initialise() {
            int i;
            nddsDomain = THROUGHPUT_TEST_DOMAIN_DEFAULT;
            maxPeerIndex = 0;
            for (i = 0; i < THROUGHPUT_TEST_MAX_NODES; i++)
                _peerHosts[i] = "";
            _nic = "";
            _argumentsBuff = null;

            for (i = 0; i < MAX_COMMAND_LINE_ARGUMENTS; i++)
                _argVariables[i] = null;

            nddsVerbosity = DEFAULT_NDDS_VERBOSITY;
            testVerbosity = DEFAULT_TEST_VERBOSITY;

            _reliable = false;
            _dontTestNdds = false;
            _transportToUse = 1;// UDP

            // And that we don't know what the error is in the argument list.
            participantId = DEFAULT_SUBSCRIBER_PARTICIPANT_INDEX;
        }

        public boolean isValid() {
            return _argsValid;
        }

        public boolean isReliable() {
            return _reliable;
        }

        public boolean dontTestNdds() {
            return _dontTestNdds;
        }

        public int transportToUse() {
            return _transportToUse;
        }

        public String getIpInterface() {
            return _nic;
        }

        // Parse the command line or constructed command line
        private boolean parseArguments(int argc, String[] argv) {
            _argsValid = true; // Assume all is OK
            for (int i = 0; i < argc; ++i) {
                if (argv[i].equals("-mcast_recv_addr")) {// mcast_recv_addr
                    if (argv[++i] != null) {
                        mcast_recv_addr = argv[i];
                    } else {
                        _argsValid = false;
                    }
                } else if (argv[i].equals("-participantId")) {
                    if (argv[++i] != null) {
                        participantId = Integer.parseInt(argv[i]);
                        if (participantId > MAX_PEER_PART_IDX) {
                            _errorString = "Only 5 participants permitted per" 
                                + " node (participant 0..4)\n";
                            _argsValid = false;
                        }
                    } else {
                        _argsValid = false;
                    }
                } else if (argv[i].equals("-domainId")) {// Test Domain
                    if (argv[++i] != null) {
                        nddsDomain = Integer.parseInt(argv[i]);
                    } else {
                        _argsValid = false;
                    }
                } else if (argv[i].equals("-peer")) { // Peer host list
                    if ((argv[++i] != null)
                            && (maxPeerIndex < THROUGHPUT_TEST_MAX_NODES)) {
                        _peerHosts[maxPeerIndex++] = argv[i];
                    } else {
                        _argsValid = false;
                    }
                    if (maxPeerIndex >= THROUGHPUT_TEST_MAX_NODES) {
                        _errorString = "Peer nodes (" + maxPeerIndex + ") > "
                                + "Maximum number of peer nodes permitted ("
                                + THROUGHPUT_TEST_MAX_NODES + ")\n";
                    }
                } else if (argv[i].equals("-name")) { // Executable name
                    if (argv[++i] != null) {
                        exeName = argv[i];
                    } else {
                        _argsValid = false;
                    }
                } else if (argv[i].equals("-nic")) { // Test Network
                    if (argv[++i] != null) {
                        _nic = argv[i];
                    } else {
                        _argsValid = false;
                    }
                } else if (argv[i].equals("-reliable")) {
                    // Use Reliable Communications
                    _reliable = true;
                } else if (argv[i].equals("-dontTestNdds")) {// Test raw TCP
                    _dontTestNdds = true;
                } else if (argv[i].equals("-transport")) {// Which transport
                    // to use?
                    if (argv[++i] != null) {
                        _transportToUse = Integer.parseInt(argv[i]);
                    } else {
                        _argsValid = false;
                    }
                } else if (argv[i].equals("-nddsVerbosity")) {// NDDS
                    // verbosity
                    if (argv[++i] != null) {
                        nddsVerbosity = Integer.parseInt(argv[i]);
                    } else {
                        _argsValid = false;
                    }
                } else if (argv[i].equals("-testVerbosity")) {// Test
                                                                // verbosity
                    if (argv[++i] != null) {
                        testVerbosity = Integer.parseInt(argv[i]);
                    } else {
                        _argsValid = false;
                    }
                } else { // Check to see if it is one of the common arguments
                    return false;
                }
            }
            return _argsValid;
        }
    }

    public static void set_logger_verbosity(int ndds_verbosity) {
        Logger logger = Logger.get_instance();
        LogVerbosity verbosity;

        switch (ndds_verbosity) {
        case 0:
            verbosity = LogVerbosity.NDDS_CONFIG_LOG_VERBOSITY_SILENT;
            break;
        case 1:
            verbosity = LogVerbosity.NDDS_CONFIG_LOG_VERBOSITY_ERROR;
            break;
        case 2:
            verbosity = LogVerbosity.NDDS_CONFIG_LOG_VERBOSITY_WARNING;
            break;
        case 3:
            verbosity = LogVerbosity.NDDS_CONFIG_LOG_VERBOSITY_STATUS_LOCAL;
            break;
        case 4:
            verbosity = LogVerbosity.NDDS_CONFIG_LOG_VERBOSITY_STATUS_REMOTE;
            break;
        case 5:
            verbosity = LogVerbosity.NDDS_CONFIG_LOG_VERBOSITY_STATUS_ALL;
            break;
        default:
            verbosity = LogVerbosity.NDDS_CONFIG_LOG_VERBOSITY_ERROR;
        }
        logger.set_verbosity(verbosity);
    }

    public static void configure_factory_qos(
            DomainParticipantFactoryQos factory_qos,
            DomainParticipantFactory factory) {
        // We need to disable participants so that we can plug in a
        // new/modified transport
        factory.get_qos(factory_qos);
        factory_qos.entity_factory.autoenable_created_entities = false;
        factory.set_qos(factory_qos);
    }

    public static void configure_participant_qos(
            DomainParticipantQos participant_qos,
            DomainParticipantFactory factory, Argument args) {
        // Configure the Participant Quality of Service
        factory.get_default_participant_qos(participant_qos);

        // Someone may decide to start another publisher so take participant
        // Id from arguments
        participant_qos.wire_protocol.participant_id = args.participantId;

        // Ensure that when we receive data it is processed quickly
        participant_qos.event.thread.priority = Thread.MAX_PRIORITY;
        participant_qos.receiver_pool.thread.priority = 
            Thread.MAX_PRIORITY - 1;

        // Turn off Shared Memory only use loop back
        // Comment out to use Shared Memory on local host beware -auto does
        // not run over shared memory

        // So we can receive large packets.
        participant_qos.receiver_pool.buffer_size = Argument.MESSAGE_SIZE_MAX
                * (Argument.MAX_SAMPLES * 2);

        participant_qos.transport_builtin.mask = 0;// clear all xport first

        if (args.transportToUse() == TransportBuiltinKind.UDPv4) {
            participant_qos.transport_builtin.mask |=
                TransportBuiltinKind.UDPv4;
        }
        if (args.transportToUse() == TransportBuiltinKind.SHMEM) {
            participant_qos.transport_builtin.mask |=
                TransportBuiltinKind.SHMEM;
        }
        if (args.transportToUse() == TransportBuiltinKind.UDPv6) {
            participant_qos.transport_builtin.mask |=
                TransportBuiltinKind.UDPv6;
        }

        if (args.maxPeerIndex > 0) {
            String[] initial_peer_array =
                new String[Argument.THROUGHPUT_TEST_MAX_NODES];
            participant_qos.discovery.initial_peers.clear();
            for (int i = 0; i < args.maxPeerIndex; ++i) {
                initial_peer_array[i] = args.getPeerHost(i);
                participant_qos.discovery.initial_peers.add(i,
                        initial_peer_array[i]);
            }
            participant_qos.discovery.multicast_receive_addresses.clear();
        }
        if (args.testVerbosity >= Argument.TEST_VERBOSITY_MESSAGES) {
            for (int i = 0; i <
                participant_qos.discovery.initial_peers.size(); i++)
                System.out.println("Peers " + i + " =   "
                        + participant_qos.discovery.initial_peers.get(i));
        }
    }

    public static void configure_participant_transport(String locator,
            UDPv4Transport.Property_t udpv4TransportProperty,
            ShmemTransport.Property_t smemTransportProperty,
            UDPv6Transport.Property_t udpv6TransportProperty,
            DomainParticipant participant, Argument args) {
        if (args.transportToUse() == TransportBuiltinKind.UDPv4) {
            // Configure built in IPv4 transport to handle large messages
            TransportSupport.get_builtin_transport_property(participant,
                    udpv4TransportProperty);
            udpv4TransportProperty.message_size_max = Argument.UDP_SIZE_MAX;
            udpv4TransportProperty.send_socket_buffer_size =
		udpv4TransportProperty.message_size_max;
            udpv4TransportProperty.recv_socket_buffer_size =
                udpv4TransportProperty.message_size_max * 2;

            // ONLY one interface permitted for test
            locator = args.getIpInterface();
            if(locator != null && !locator.equals("")) {
                udpv4TransportProperty.allow_interfaces_list.clear();
                udpv4TransportProperty.allow_interfaces_list.add(locator);
            }

            TransportSupport.set_builtin_transport_property(participant,
                    udpv4TransportProperty);

        } else if (args.transportToUse() == TransportBuiltinKind.SHMEM) {
            // Configure built in Shared Memory transport to handle large
            // messages
            TransportSupport.get_builtin_transport_property(participant,
                    smemTransportProperty);
            // Just ensure we can receive 64K Messages via shared memory
            smemTransportProperty.message_size_max = Argument.SHMEM_SIZE_MAX;
            smemTransportProperty.receive_buffer_size =
                smemTransportProperty.message_size_max * 4;
            smemTransportProperty.received_message_count_max =
		Argument.MAX_SAMPLES;
            
	    TransportSupport.set_builtin_transport_property(participant,
                    smemTransportProperty);
        } else if (args.transportToUse() == TransportBuiltinKind.UDPv6) {
            // Configure built in IPv6 transport to handle large messages
            TransportSupport.get_builtin_transport_property(participant,
                    udpv6TransportProperty);
            udpv6TransportProperty.message_size_max = Argument.UDP_SIZE_MAX;
            udpv6TransportProperty.send_socket_buffer_size =
		udpv6TransportProperty.message_size_max;
            udpv6TransportProperty.recv_socket_buffer_size =
               udpv6TransportProperty.message_size_max * 2;

            // ONLY one interface permitted for test
            locator = args.getIpInterface();
            if(locator != null && !locator.equals("")) {
                udpv6TransportProperty.allow_interfaces_list.clear();
                udpv6TransportProperty.allow_interfaces_list.add(locator);
            }

            TransportSupport.set_builtin_transport_property(participant,
                    udpv6TransportProperty);
        }
    }

    public static void configure_command_reader_qos(
            DataReaderQos command_reader_qos, Subscriber subscriber) {
        subscriber.get_default_datareader_qos(command_reader_qos);

        // We will use reliable communications to communicate commands...
        DataReaderQos_setImpatientReliable(command_reader_qos, 1);
    }

    public static void configure_data_reader_qos(DataReaderQos data_reader_qos,
            Subscriber subscriber, Argument args) {
        subscriber.get_default_datareader_qos(data_reader_qos);

        // use these hard coded value until you use key
        data_reader_qos.resource_limits.max_instances = 1;
        data_reader_qos.resource_limits.initial_instances =
            data_reader_qos.resource_limits.max_instances;
        
        data_reader_qos.resource_limits.max_samples_per_instance = 1;
        data_reader_qos.reader_resource_limits.max_samples_per_remote_writer
            = data_reader_qos.resource_limits.max_samples_per_instance;
        data_reader_qos.resource_limits.max_samples =
            data_reader_qos.resource_limits.max_samples_per_instance;
        data_reader_qos.resource_limits.initial_samples =
            data_reader_qos.resource_limits.max_samples_per_instance;

        // Unless specified, we will use best effort for this test so...
        if (args.isReliable()) {
            DataReaderQos_setReliableBursty(data_reader_qos);
        }

        if (args.mcast_recv_addr != null) {
            DataReaderQos_setMulticast(data_reader_qos, args.mcast_recv_addr);
        }
    }
}

