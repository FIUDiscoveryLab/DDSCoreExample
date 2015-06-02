/*
 (c) Copyright, Real-Time Innovations, $Date: 2009/05/17 03:52:03 $.
 All rights reserved.
 No duplications, whole or partial, manual or electronic, may be made
 without express written permission.  Any such copies, or
 revisions thereof, must display this notice unaltered.
 This code contains trade secrets of Real-Time Innovations, Inc.
*/

import java.text.DecimalFormat;
import java.util.StringTokenizer;

import com.rti.dds.domain.*;
import com.rti.dds.infrastructure.*;
import com.rti.dds.publication.*;
import com.rti.dds.topic.*;
import com.rti.ndds.config.*;
import com.rti.ndds.transport.*;

// ===========================================================================

public class ThroughputPublisher {
    // -----------------------------------------------------------------------
    // Public Methods
    // -----------------------------------------------------------------------

    public static void main(String[] args) {
        Argument arguments = new Argument(args.length, args);

        if (!arguments.isValid()) {
            System.out.println("Invalid arg; please consult README");
            return;
        }
        publisherMain(arguments);
    }

    // -----------------------------------------------------------------------
    // Private Methods
    // -----------------------------------------------------------------------
    private static void publisherMain(Argument args) {
        DomainParticipantFactoryQos factory_qos = null;
        DomainParticipantFactory factory = null;

        DomainParticipantQos participant_qos = null;
        DomainParticipant participant = null;

        PublisherQos publisher_qos = null;
        Publisher publisher = null;

        // And a data writer to do the work
        DataWriterQos data_writer_qos = null;
        ThroughputDataWriter data_writer = null;
        PublicationMatchedStatus data_writer_status = null;

        InstanceHandle_t data_instanceHandle = null;

        // And a writer to communicate commands
        DataWriterQos command_writer_qos = null;
        ThroughputCommandDataWriter command_writer = null;
        PublicationMatchedStatus command_writer_status = null;

        InstanceHandle_t command_instanceHandle = null;

	boolean large_data = args.packetSize >= Argument.MESSAGE_SIZE_MAX;
	FlowController flow_controller = null;
	FlowControllerProperty_t flow_controller_property =
	    new FlowControllerProperty_t();

        TopicQos data_topic_qos = null;
        Topic data_topic = null;
        TopicQos command_topic_qos = null;
        Topic command_topic = null;

        Throughput data_instance = null;
        ThroughputCommand command_instance = null;

        try {
            factory_qos = new DomainParticipantFactoryQos();

            participant_qos = new DomainParticipantQos();
            publisher_qos = new PublisherQos();

            // And a data writer to do the work
            data_writer_qos = new DataWriterQos();
            data_writer_status = new PublicationMatchedStatus();
            data_instanceHandle = InstanceHandle_t.HANDLE_NIL;
            data_topic_qos = new TopicQos();

            // And a writer to communicate commands
            command_writer_qos = new DataWriterQos();
            command_writer_status = new PublicationMatchedStatus();
            command_instanceHandle = InstanceHandle_t.HANDLE_NIL;
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
            long twentyMilliSec = 20;
            long oneSecond = 1000;
	    Duration_t threeSecond = new Duration_t(3,0);
	    long recoveryTime = 10;

            long packetsWritten = 0L;
            double bytesWritten = 0.0;
            long startTimeInMilli = 0;
            long stopTimeInMilli = 0;
            long deltaTimeInMilli = 0;
            long currentTimeInMilli = 0;
            long expectedStopTimeInMilli = 0;
            double publisherThroughput = 0.0;

            int i, effort;
            boolean testComplete;
            String locator = null;
            boolean useMulticast = false;
	    int samples_per_trigger = 25, max_gather_send_buffers = 16;
            Duration_t ack_wait_time = new Duration_t(60, 0); /* 1 minute */

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

            participant.enable();

            // Create the rest of the entities
	    if (large_data || args.asynchronous) {
		/* Configure flow controller Quality of Service */
		configure_flow_controller_property(flow_controller_property,
						   participant, args,
						   large_data);
		/* Create flowcontroller */
		flow_controller = participant.create_flowcontroller(
		    "throughput test flow_controller", flow_controller_property);
	    }

            // Create the rest of the entities
            participant.get_default_publisher_qos(publisher_qos);
            // And create the publisher with default QoS and a default listener
	    publisher_qos.asynchronous_publisher.thread.priority =
		Thread.MAX_PRIORITY - 1;
            publisher = participant.create_publisher(publisher_qos, null,
                    StatusKind.STATUS_MASK_NONE);

            /******************************************************************
             * Set up Throughput topic and writer.
             *****************************************************************/
            // Now we register the data topic type with the participant.
            ThroughputTypeSupport.register_type(participant,
                    ThroughputTypeSupport.get_type_name());

            // Get the default QoS for the Topic
            participant.get_default_topic_qos(data_topic_qos);
            // We need exclusive ownership of this Topic so...
            data_topic_qos.ownership.kind =
                OwnershipQosPolicyKind.EXCLUSIVE_OWNERSHIP_QOS;

            // And create a Topic with Default QoS and default listener.
            // Note: Ownership is Shared by default.
            data_topic = participant.create_topic("Throughput",
                    ThroughputTypeSupport.get_type_name(), data_topic_qos,
                    null, StatusKind.STATUS_MASK_NONE);

            /* set up user data */
            data_instance = new Throughput();

            samples_per_trigger = configure_data_writer_qos(
 		data_writer_qos, large_data, max_gather_send_buffers, publisher,
	 	args, useMulticast);

            data_writer = (ThroughputDataWriter) publisher.create_datawriter(
                    data_topic, data_writer_qos, null,
                    StatusKind.STATUS_MASK_NONE);

            /*
             * Register Topic instance with data writer. Note: because we are
             * not using keys this will return DDS_HANDLE_NIL
             */
            data_instanceHandle = data_writer.register_instance(data_instance);

            /******************************************************************
             * Set up Command topic and writer.
             *****************************************************************/

            // Now we register the command topic type with the participant
            ThroughputCommandTypeSupport.register_type(participant,
                    ThroughputCommandTypeSupport.get_type_name());

            // and create the command topic and writer
            participant.get_default_topic_qos(command_topic_qos);
            // We need exclusive ownership of this Topic so...
            command_topic_qos.ownership.kind =
                OwnershipQosPolicyKind.EXCLUSIVE_OWNERSHIP_QOS;
            /*
             * And create a Topic with Default QoS and default listener. Note
             * Ownership is Shared by default.
             */
            command_topic = participant.create_topic("ThroughputCommand",
                    ThroughputCommandTypeSupport.get_type_name(),
                    command_topic_qos, null, StatusKind.STATUS_MASK_NONE);

            configure_command_writer_qos(command_writer_qos, publisher, args);

            command_writer = (ThroughputCommandDataWriter) publisher
                    .create_datawriter(command_topic, command_writer_qos, null,
                            StatusKind.STATUS_MASK_NONE);

            // and create an initialized instance of command topic
            command_instance = new ThroughputCommand();

            command_instanceHandle = command_writer
                    .register_instance(command_instance);

            // ////////////////////////////////////////////////////////////////
            // Start test
            // ////////////////////////////////////////////////////////////////

            // Ensure we are sending the correct packet size
            data_instance.data.clear();
            data_instance.data.setMaximum(args.packetSize);
            data_instance.data.addAllByte(new byte[args.packetSize]);

            System.out.print("\n\nStarting test...\n");

            /*
             * Wait until we have all subscribers matching command topics
             * and data topics
             */
            do {
                try {
                    Thread.sleep(oneSecond);
                } catch (InterruptedException ie) {
                    System.err.println("Thread interrupted during sleep");
                }
                data_writer
                    .get_publication_matched_status(data_writer_status);
                command_writer
                    .get_publication_matched_status(command_writer_status);
            } while ((data_writer_status.current_count < args.subscribers)
                     || (command_writer_status.current_count <
                         args.subscribers));
            
            System.out.print("\n bytes,samples,  Mbit/s,duration,effort\n"
                    + "------,-------,--------,--------,------ \n");

	    recoveryTime = args.getRecoveryTime();

            // Allow time for subscribers to initialise
            try {
                Thread.sleep(oneSecond);
            } catch (InterruptedException ie) {
                System.err.println("Thread interrupted during sleep");
            }

            for (effort = args.demandInitial; effort <= args.demandMax;
                    effort += args.demandIncrement) {
                testComplete = false;

                // Set up initial Data
                data_instance.sequence_number = 0;

                // Setup command

                try {
                    command_instance.signature[0] = Byte.parseByte("43", 16);
                    command_instance.signature[1] = Byte.parseByte("21", 16);
                    command_instance.signature[2] = Byte.parseByte("43", 16);
                    command_instance.signature[3] = Byte.parseByte("21", 16);
                } catch (NumberFormatException ne) {
                    System.err.println("Number Format Exception while "
                            + "setting command signature");
                }

                command_instance.command =
                    ThroughputCommandKind.THROUGHPUT_COMMAND_START;
                command_instance.data_length = args.packetSize;
                command_instance.current_publisher_effort = effort;
                command_instance.final_publisher_effort = args.demandMax;

                command_writer.write(command_instance, command_instanceHandle);
                command_writer.wait_for_acknowledgments(ack_wait_time);

                startTimeInMilli = System.currentTimeMillis();
                expectedStopTimeInMilli = startTimeInMilli
                        + (args.testDurationSec * Argument.MILLISEC_PER_SEC);

                while (!testComplete) {
                    for (int current_effort = 0; current_effort < effort
                         && !testComplete;
                         ++current_effort, data_instance.sequence_number++) {

                        try {
                            data_writer.write(data_instance,
                                    data_instanceHandle);
                        } catch (RETCODE_TIMEOUT timeout) {
                            data_instance.sequence_number--;
                        }

			if (args.asynchronous && !large_data) {
			    /* Once all gather send buffers are used up, we
			       cannot coalesce any further samples, so send the
			       message now. */
			    if (data_instance.sequence_number %
				samples_per_trigger == 0) {
				flow_controller.trigger_flow();
			    }
			}
                    }

                    currentTimeInMilli = System.currentTimeMillis();
                    if (currentTimeInMilli >= expectedStopTimeInMilli) {
                        testComplete = true;
                    } else {
                        testComplete = false;
                    }

                    if (!testComplete) {
                        try {
                            Thread.sleep(recoveryTime);
                        } catch (InterruptedException ie) {
                            System.err.print(
                                "Thread interrupted during sleep");
                        }
                    }
                }

		/* make sure all asynchronous data was sent
		   before sending complete command */
		if (args.asynchronous || large_data) {
		    flow_controller.trigger_flow();
		    data_writer.wait_for_asynchronous_publishing(threeSecond);
		}

                command_instance.command =
                    ThroughputCommandKind.THROUGHPUT_COMMAND_COMPLETE;

                command_writer.write(command_instance, command_instanceHandle);
                command_writer.wait_for_acknowledgments(ack_wait_time);

                stopTimeInMilli = System.currentTimeMillis();
                deltaTimeInMilli = stopTimeInMilli - startTimeInMilli;

                packetsWritten = data_instance.sequence_number;
                bytesWritten = ((double) packetsWritten *
                        (Argument.TEST_PACKET_OVERHEAD + args.packetSize));
                if (deltaTimeInMilli > 0)
                    publisherThroughput = ((8.0 * (double) bytesWritten /
                            (((double) deltaTimeInMilli) /
                                    Argument.MILLISEC_PER_SEC)) / 1000000.0);

		System.out.format("%6d,%7d,%8.1f,%8.1f,%7d\n",
			(args.packetSize + Argument.TEST_PACKET_OVERHEAD),
			packetsWritten,
			publisherThroughput,
			(1.0f*deltaTimeInMilli) / Argument.MILLISEC_PER_SEC,
			effort);

                try {
                    /* Let subscriber poll for COMPLETE command */
                    Thread.sleep(oneSecond);

		    /* Let subscriber receive remaining of data */
		    Thread.sleep(oneSecond);
		    Thread.sleep(oneSecond);
 		    Thread.sleep(oneSecond);

                } catch (InterruptedException ie) {
                    System.err.print("Thread interrupted during sleep");
                }

            } /* for(effort < maxEffort) */

        } finally {
            if (participant != null) {
                participant.delete_contained_entities();

                DomainParticipantFactory.TheParticipantFactory
                        .delete_participant(participant);
            }
        }
    }

    // --- Constructors: -----------------------------------------------------

    // -----------------------------------------------------------------------

    private static class Argument {
        final static int NDDS_OVERHEAD = 256; /*
         * Conservate estimate to
         * account for issue overhead +
         * potential INFO_TS + potential
         * HB + ...
         */

        final static int TEST_VERBOSITY_ERRORS = 1;

        final static int TEST_VERBOSITY_WARNINGS = 2;

        final static int TEST_VERBOSITY_MESSAGES = 3;

        final static int THROUGHPUT_TEST_MAX_NODES = 16;

        final static int THROUGHPUT_TEST_DOMAIN_DEFAULT = 0;

        final static int MAX_TEST_SUBSCRIBERS = 16;

        final static int MIN_TEST_DURATION_SEC = 1;

        final static int MAX_COMMAND_LINE_ARGUMENTS = 80;

        // final static int MAX_PEER_LOCATOR_STR_LEN = 128;
        final static int MAX_PEER_PART_IDX = 4;

        // Allow a maximum of 5 participants (0..4) per node.

        final static int MAX_SAMPLES_PER_INSTANCE = 512;

        // An arbitrary total number of samples

        final static int MAX_INITIAL_SAMPLES = 512;

        // The initial allocation

        final static int DEFAULT_TEST_DURATION = 10;

        // 10 seconds

        final static int DEFAULT_TEST_STRENGTH = 5;

        final static int DEFAULT_NUMBER_OF_SUBSCRIBERS = 1;

        final static int DEFAULT_TEST_VERBOSITY = TEST_VERBOSITY_ERRORS;

        final static int DEFAULT_NDDS_VERBOSITY = 1;

        final static int DEFAULT_DEMAND = 10; // Message per write loop

        final static int DEFAULT_PUBLISHER_PARTICIPANT_INDEX = 0;

        final static int DEFAULT_SUBSCRIBER_PARTICIPANT_INDEX = 1;

        final static int DEFAULT_MAX_BLOCKING_TIME_NS = 999000000;

        final static int DEFAULT_FAST_HEARTBEAT_TIME_NS = 1000000;

        final static int TEST_PACKET_OVERHEAD = 8;

        // 4 Bytes for length of sequence and 4 bytes for sequence number.

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

        protected String _nic;

        // Used to restrict the (NIC) interface that the test uses

        protected String _argumentsBuff; // Buffer to hold arguments from

        // file.

        protected String _argVariables[]; // Arguments parsed from file buffer

        protected boolean _argsValid;

        protected boolean _reliable;

        protected int _transportToUse;

        protected boolean _dontTestNdds;

        public int nddsDomain; // Test domain

        public int maxPeerIndex; // Number of peers

        public int participantId;

        // the participant Id which must be supplied

        public int nddsVerbosity; // NDDS verbosity

        public int testVerbosity; // Test verbosity

        public String exeName;

        // Class specific member variables
        public int multicast_ttl;

        // For single host test, keep at 0 to avoid lots of mcast packets

        public int packetSize; // Size of the message sequence

        public int testDurationSec; // Duration of test

        public int subscribers; // Number of subscribers IP addresses supplied

        public int strength; // For the reliable writers

        public int demandInitial; // Demand messages / write loop

        public int demandIncrement;

        public int demandMax;

        public boolean no_push_on_write; // Whether the writer should push

	public boolean asynchronous = false;
	public int bw_limit = ResourceLimitsQosPolicy.LENGTH_UNLIMITED;

        public Argument(int argc, String[] argv) {
            _peerHosts = new String[THROUGHPUT_TEST_MAX_NODES];
            _errorString = new String();
            _nic = new String();
            _argumentsBuff = new String();
            _argVariables = new String[MAX_COMMAND_LINE_ARGUMENTS];
            initialise(); // Set the defaults

            _argsValid = true; // Assume that arguments are OK
            exeName = "Throughput_publisher";
            _argsValid = parseArguments(argc, argv);
        }

        public String getPeerHost(int index) {
            if (index > THROUGHPUT_TEST_MAX_NODES) {
                return null;
            } else {
                return _peerHosts[index];
            }
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

        public Duration_t getMaxBlockingTime() {
            return _maxBlockingTime;
        }

        public long getRecoveryTime() {
            return _recoveryTime;
        }

        private long _recoveryTime = 10;

        public void setMaxBlockingTime(long msec) {
            while (msec >= 1000) {
                _maxBlockingTime.sec++;
                msec -= 1000;
            }
            _maxBlockingTime.nanosec = (int) (msec * 1000000);
        }

        private Duration_t _maxBlockingTime = new Duration_t();

        // Maximum blocking time for a reliable writer

        private long _blockingTime;

        // Hold user input in ms before conversion to DDS_Duration_t

        // Private functions which override base class functions

        // With defaults for the Publisher
        protected void initialise() {
            int i;

            nddsDomain = THROUGHPUT_TEST_DOMAIN_DEFAULT;
            maxPeerIndex = 0;
            for (i = 0; i < THROUGHPUT_TEST_MAX_NODES; i++) {
                _peerHosts[i] = "";
            }
            _nic = "";
            _argumentsBuff = null;

            for (i = 0; i < MAX_COMMAND_LINE_ARGUMENTS; i++) {
                _argVariables[i] = null;
            }

            nddsVerbosity = DEFAULT_NDDS_VERBOSITY;
            testVerbosity = DEFAULT_TEST_VERBOSITY;

            _reliable = false;
            _dontTestNdds = false;
            _transportToUse = 1;// UDP

            // And that we don't know what the error is in the argument list.
            _errorString = "None\n";

            participantId = DEFAULT_PUBLISHER_PARTICIPANT_INDEX;

            // Size of the message, can be up 63K user bytes +
            // 4 bytes for the sequence number;
            packetSize = DEFAULT_PACKET_SIZE;

            // Number of seconds to run the test
            testDurationSec = DEFAULT_TEST_DURATION;

            // Set the default message demand per 10ms iteration
            demandInitial = DEFAULT_DEMAND;
            demandIncrement = DEFAULT_DEMAND;
            demandMax = DEFAULT_DEMAND;

            // Assume only one subscriber
            subscribers = DEFAULT_NUMBER_OF_SUBSCRIBERS;

            strength = DEFAULT_TEST_STRENGTH;
            multicast_ttl = 1;
            _maxBlockingTime.sec = 0;
            _maxBlockingTime.nanosec = DEFAULT_MAX_BLOCKING_TIME_NS;
            no_push_on_write = false;
        }

        // Check that parameters provided are valid for the publisher
        protected boolean validateArgs() {
            // Is the packet size wrong ?
            if (packetSize > THROUGHPUT_TEST_PACKET_DATA_SIZE_MAX.VALUE
                    || packetSize < 8) {
                _errorString = "Packet Size (" + packetSize + ") > ("
                        + THROUGHPUT_TEST_PACKET_DATA_SIZE_MAX.VALUE
                        + ") or < (8)?\n";
                return false;
            }

            // Is the duration nonsense ?
            if (testDurationSec < MIN_TEST_DURATION_SEC) {
                _errorString = "Duration (" + testDurationSec
                        + ") < Minimum permitted (" + MIN_TEST_DURATION_SEC
                        + ") ?\n";
                return false;
            }
            // Have too many subscribers been specified ?
            if (subscribers > MAX_TEST_SUBSCRIBERS) {
                _errorString = "Subscribers (" + subscribers
                               + ") > Max permitted (" 
                               + MAX_TEST_SUBSCRIBERS + ")?\n";
                return false;
            }

            if (demandInitial <= 0 || demandIncrement <= 0
                    || demandMax < demandInitial) {
                _errorString = "Demand (" + demandInitial
                        + ") must be > 1 message per write loop\n";
                return false;
            }

            if (_reliable) {
                if (((_maxBlockingTime.sec == 0) && (_maxBlockingTime.nanosec <
                   DEFAULT_MAX_BLOCKING_TIME_NS)) ||
                   ((_maxBlockingTime.nanosec % DEFAULT_FAST_HEARTBEAT_TIME_NS)
                            != 0)) {
                    _errorString = "Max blocking time must be > 2 * Fast " +
                        "Heartbeat period(10ms), and a multiple of 10 ms\n";
                    return false;
                }
            }

            if (bw_limit <= 0 && 
                bw_limit != ResourceLimitsQosPolicy.LENGTH_UNLIMITED) {
                _errorString = "B/W Limit " + bw_limit + " must be > 0\n";
                return false;
            }

            return true;
        }

        // Parse the command line or constructed command line arguments
        private boolean parseArguments(int argc, String[] argv) {
            // This function is called recursively if there is a configuration
            // file specified on the command line.

            String configFileName;
            String tmp1;

            _argsValid = true; // Assume all is OK
            configFileName = ""; // Ensure that file name is not hanging
            // around

            // Parse the arguments
            for (int i = 0; i < argc; ++i) {
                if (argv[i].equals("-no_push_on_write")) {//don't push reliable data
                    no_push_on_write = true;
		} else if (argv[i].equals("-asynchronous")) {//asynch publisher
                    asynchronous = true;
                } else if (argv[i].equals("-bw_limit")) {// large-data bandwidth limit
                    if (argv[++i] != null) {
                        bw_limit = Integer.parseInt(argv[i]);
                    } else {
                        _argsValid = false;
                    }
                } else if (argv[i].equals("-subscribers")) {
                    // number of subscribers
                    if (argv[++i] != null) {
                        subscribers = Integer.parseInt(argv[i]);
                    } else {
                        _argsValid = false;
                    }
                } else if (argv[i].equals("-size")) {// Packet size
                    if (argv[++i] != null) {
                        packetSize = Integer.parseInt(argv[i]);
                        packetSize -= TEST_PACKET_OVERHEAD;
                    } else {
                        _argsValid = false;
                    }
                } else if (argv[i].equals("-multicast_ttl")) {// multicast_ttl
                    if (argv[++i] != null) {
                        multicast_ttl = Integer.parseInt(argv[i]);
                    } else {
                        _argsValid = false;
                    }
                } else if (argv[i].equals("-duration")) {// Test duration
                    if (argv[++i] != null) {
                        testDurationSec = Integer.parseInt(argv[i]);
                    } else {
                        _argsValid = false;
                    }
                } else if (argv[i].equals("-demand")) { // Test demand
                    if (argv[++i] == null) {
                        _argsValid = false;
                    }

                    StringTokenizer st = new StringTokenizer(argv[i]);
                    tmp1 = st.nextToken(":");
                    demandInitial = Integer.parseInt(tmp1);
                    if (!st.hasMoreTokens()) {
                        _argsValid = false;
                    } else {
                        tmp1 = st.nextToken(":");
                        demandIncrement = Integer.parseInt(tmp1);
                    }
                    if (!st.hasMoreTokens()) {
                        _argsValid = false;
                    } else {
                        tmp1 = st.nextToken();
                        demandMax = Integer.parseInt(tmp1);
                    }
                } else if (argv[i].equals("-recoveryTime")) {
                    if (argv[++i] != null) {
                        _recoveryTime = Long.parseLong(argv[i]);
                    } else {
                        _argsValid = false;
                    }
                } else if (argv[i].equals("-strength")) {// Ownership
                    // strength
                    if (argv[++i] != null)
                        strength = Integer.parseInt(argv[i]);
                    else
                        _argsValid = false;
                } else if (argv[i].equals("-maxBlockingTime")) {
                    if (argv[++i] != null) {
                        _blockingTime = Long.parseLong(argv[i]);
                        setMaxBlockingTime(_blockingTime);
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
                } else if (argv[i].equals("-nic")) {
                    // Test Network
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
                } else if (argv[i].equals("-transport")) {
                    // Which transport to use?
                    if (argv[++i] != null) {
                        _transportToUse = Integer.parseInt(argv[i]);
                    } else {
                        _argsValid = false;
                    }
                } else if (argv[i].equals("-nddsVerbosity")) {
                    // NDDS verbosity
                    if (argv[++i] != null) {
                        nddsVerbosity = Integer.parseInt(argv[i]);
                    } else {
                        _argsValid = false;
                    }
                } else if (argv[i].equals("-testVerbosity")) {
                    // Test verbosity
                    if (argv[++i] != null) {
                        testVerbosity = Integer.parseInt(argv[i]);
                    } else {
                        _argsValid = false;
                    }
                } else {
                    return false;
                }
            }
            return _argsValid;
        }
    }

    private static void DataWriterQos_setMulticast(DataWriterQos qos,
            int readerQueueSize) {
        DataWriterQos_setMulticast(qos, readerQueueSize, 0, 1);
    }

    private static void DataWriterQos_setMulticast(DataWriterQos qos,
            int readerQueueSize, int nackCoalesceTimeMinInMs,
            int nackCoalesceTimeMaxInMs) {
        // qos.protocol.rtps_reliable_writer.max_bytes_per_nack_response =
        // -readerQueueSize;
        qos.protocol.rtps_reliable_writer.max_bytes_per_nack_response =
            32 * 1024;
        qos.protocol.rtps_reliable_writer.min_nack_response_delay.sec = 0;
        qos.protocol.rtps_reliable_writer.min_nack_response_delay.nanosec =
            nackCoalesceTimeMinInMs
                * Argument.NANOSEC_PER_MILLISEC;
        qos.protocol.rtps_reliable_writer.max_nack_response_delay.sec = 0;
        qos.protocol.rtps_reliable_writer.max_nack_response_delay.nanosec =
            nackCoalesceTimeMaxInMs
                * Argument.NANOSEC_PER_MILLISEC;
    }

    private static void DataWriterQos_setImpatientReliable(DataWriterQos qos,
            Duration_t timeToGoFromFullToLowWaterMarkMs) {
        DataWriterQos_setImpatientReliable(qos,
                timeToGoFromFullToLowWaterMarkMs, 10);
    }

    private static void DataWriterQos_setImpatientReliable(DataWriterQos qos,
            Duration_t timeToGoFromFullToLowWaterMarkMs,
            int alertReaderWithinThisMs) {
        qos.reliability.kind = 
            ReliabilityQosPolicyKind.RELIABLE_RELIABILITY_QOS;

        qos.reliability.max_blocking_time.sec =
            timeToGoFromFullToLowWaterMarkMs.sec;
        qos.reliability.max_blocking_time.nanosec =
            timeToGoFromFullToLowWaterMarkMs.nanosec;
        // qos.protocol.push_on_write = true;

        qos.history.kind = HistoryQosPolicyKind.KEEP_ALL_HISTORY_QOS;

        // limit the queue, because we don't need to use the queue
        qos.resource_limits.max_samples = 2;
        qos.resource_limits.initial_samples = 
            qos.resource_limits.max_samples;

        // use these hard coded value until you use key
        qos.resource_limits.max_samples_per_instance =
            qos.resource_limits.max_samples;
        qos.resource_limits.max_instances = 1;
        qos.resource_limits.initial_instances = 
            qos.resource_limits.max_instances;

        // should be faster than the send rate!
        qos.protocol.rtps_reliable_writer.fast_heartbeat_period.sec = 0;
        qos.protocol.rtps_reliable_writer.fast_heartbeat_period.nanosec =
            alertReaderWithinThisMs * Argument.NANOSEC_PER_MILLISEC;

        /*
         * because the queue is 1, want to piggyback HB w/ every sample. This
         * may be a duplicate HB, but since the send is low, it's OK
         */
        qos.protocol.rtps_reliable_writer.heartbeats_per_max_samples =
            qos.resource_limits.max_samples;

        // essentially turn off slow HB period, relying on periodic nature of
        // the data
        qos.protocol.rtps_reliable_writer.heartbeat_period.sec = 3600 * 24 * 7;

        qos.protocol.rtps_reliable_writer.min_nack_response_delay.sec = 0;
        qos.protocol.rtps_reliable_writer.min_nack_response_delay.nanosec = 0;
        qos.protocol.rtps_reliable_writer.max_nack_response_delay.sec = 0;
        qos.protocol.rtps_reliable_writer.max_nack_response_delay.nanosec = 0;
    }

    private static void DataWriterQos_setReliableBursty(DataWriterQos qos,
            int worstBurstInSamples, Duration_t maxBlockingTime) {
        DataWriterQos_setReliableBursty(qos, worstBurstInSamples,
                maxBlockingTime, 10);
    }

    private static void DataWriterQos_setReliableBursty(DataWriterQos qos,
            int worstBurstInSamples, Duration_t maxBlockingTime,
            int alertReaderWithinThisMs) {
        qos.reliability.kind =
            ReliabilityQosPolicyKind.RELIABLE_RELIABILITY_QOS;

        qos.reliability.max_blocking_time.sec = maxBlockingTime.sec;
        qos.reliability.max_blocking_time.nanosec = maxBlockingTime.nanosec;

        qos.history.kind = HistoryQosPolicyKind.KEEP_ALL_HISTORY_QOS;
        // qos.liveliness.kind = DDS_MANUAL_BY_TOPIC_LIVELINESS_QOS;
        // qos.liveliness.lease_duration.sec = 1;
        // qos.liveliness.lease_duration.nanosec = 400 * NANOSEC_PER_MILLISEC;

        // avoid malloc and pay memory; might have to change policy for large
        // type
        qos.resource_limits.max_samples = worstBurstInSamples;
        qos.resource_limits.initial_samples = worstBurstInSamples;
        // if worst burst == expected burst
        qos.resource_limits.max_samples_per_instance =
            qos.resource_limits.max_samples;

        // trip high water mark as soon as data starts coming in
        qos.protocol.rtps_reliable_writer.high_watermark = 1;
        /*
         * And stay in fast mode (work harder to resolve stored samples) until
         * all have been delivered.
         */
        qos.protocol.rtps_reliable_writer.low_watermark = 0;

        qos.protocol.rtps_reliable_writer.fast_heartbeat_period.sec = 0;
        qos.protocol.rtps_reliable_writer.fast_heartbeat_period.nanosec =
            alertReaderWithinThisMs * Argument.NANOSEC_PER_MILLISEC;

        // NOTE: piggyback HB irrelevant when push_on_write is turned off
        qos.protocol.rtps_reliable_writer.heartbeats_per_max_samples =
            worstBurstInSamples / 64;

        // turn off slow HB
        qos.protocol.rtps_reliable_writer.heartbeat_period.sec = 3600 * 24 * 7;

        // don't want to forget the reader even if itsn't responsive for 1 sec
        qos.protocol.rtps_reliable_writer.max_heartbeat_retries = 100;

        qos.protocol.rtps_reliable_writer.min_nack_response_delay.sec = 0;
        qos.protocol.rtps_reliable_writer.min_nack_response_delay.nanosec = 0;
        qos.protocol.rtps_reliable_writer.max_nack_response_delay.sec = 0;
        qos.protocol.rtps_reliable_writer.max_nack_response_delay.nanosec = 0;
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
        // We need to disable participants so that we can
        // plug in a new/modified transport
        factory.get_qos(factory_qos);
        factory_qos.entity_factory.autoenable_created_entities = false;
        factory.set_qos(factory_qos);
    }

    public static void configure_participant_qos(
            DomainParticipantQos participant_qos,
            DomainParticipantFactory factory, Argument args) {
        // Configure participant QoS
        factory.get_default_participant_qos(participant_qos);

        participant_qos.event.thread.priority = Thread.MAX_PRIORITY; // 10;
        participant_qos.receiver_pool.thread.priority = 
            Thread.MAX_PRIORITY - 1;

        // Someone may decide to start another publisher so take
        // participant Id from arguments
        participant_qos.wire_protocol.participant_id = args.participantId;

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

        // So we can receive large packets.
        participant_qos.receiver_pool.buffer_size = Argument.MESSAGE_SIZE_MAX
                * Argument.MAX_SAMPLES;
        participant_qos.event.max_count = Argument.MAX_EVENT_COUNT;

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
                System.out.println("Peers " + i + " = "
                        + participant_qos.discovery.initial_peers.get(i));
        }
    }

    public static int configure_participant_transport(String locator,
            UDPv4Transport.Property_t udpv4TransportProperty,
            ShmemTransport.Property_t smemTransportProperty,
            UDPv6Transport.Property_t udpv6TransportProperty,
            DomainParticipant participant, Argument args) {
	int gather_send_buffer_count_max = 16;
        if (args.transportToUse() == TransportBuiltinKind.UDPv4) {
            // Configure built in IPv4 transport to handle large messages
            TransportSupport.get_builtin_transport_property(participant,
                    udpv4TransportProperty);

            udpv4TransportProperty.message_size_max = Argument.UDP_SIZE_MAX;
            udpv4TransportProperty.send_socket_buffer_size =
		udpv4TransportProperty.message_size_max;
            udpv4TransportProperty.recv_socket_buffer_size =
                udpv4TransportProperty.message_size_max * 2;
            udpv4TransportProperty.multicast_ttl = args.multicast_ttl;
            // ONLY one interface permitted for test

            locator = args.getIpInterface();
            if(locator != null && !locator.equals("")) {
                udpv4TransportProperty.allow_interfaces_list.clear();
                udpv4TransportProperty.allow_interfaces_list.add(locator);
            }
            
            TransportSupport.set_builtin_transport_property(participant,
                    udpv4TransportProperty);
	    gather_send_buffer_count_max =
			udpv4TransportProperty.gather_send_buffer_count_max;

        } else if (args.transportToUse() == TransportBuiltinKind.SHMEM) {

            // Configure built in Shared Memory transport to
            // handle large messages
            TransportSupport.get_builtin_transport_property(participant,
                    smemTransportProperty);

            // Just ensure we can send 64K Messages via shared memory
            smemTransportProperty.message_size_max = Argument.SHMEM_SIZE_MAX;
            smemTransportProperty.received_message_count_max =
                Argument.MAX_SAMPLES;
            smemTransportProperty.receive_buffer_size =
                smemTransportProperty.message_size_max * 4;

            TransportSupport.set_builtin_transport_property(participant,
                    smemTransportProperty);
	    gather_send_buffer_count_max =
			smemTransportProperty.gather_send_buffer_count_max;

        } else if (args.transportToUse() == TransportBuiltinKind.UDPv6) {
            // Configure built in IPv6 transport to handle large messages
            TransportSupport.get_builtin_transport_property(participant,
                    udpv6TransportProperty);

            udpv6TransportProperty.message_size_max = Argument.UDP_SIZE_MAX;
            udpv6TransportProperty.send_socket_buffer_size = 
		udpv6TransportProperty.message_size_max;
            udpv6TransportProperty.recv_socket_buffer_size =
                udpv6TransportProperty.message_size_max * 2;
            udpv6TransportProperty.multicast_ttl = args.multicast_ttl;
            // ONLY one interface permitted for test

            locator = args.getIpInterface();
            if(locator != null && !locator.equals("")) {
                udpv6TransportProperty.allow_interfaces_list.clear();
                udpv6TransportProperty.allow_interfaces_list.add(locator);
            }

            TransportSupport.set_builtin_transport_property(participant,
                    udpv6TransportProperty);
	    gather_send_buffer_count_max =
			udpv6TransportProperty.gather_send_buffer_count_max;
        }
	return gather_send_buffer_count_max;
    }

    public static void configure_flow_controller_property(
	FlowControllerProperty_t flow_controller_property, 
	DomainParticipant participant, Argument args, boolean large_data) {

	participant.get_default_flowcontroller_property(flow_controller_property);

	/* Approach: send small bursts as fast as possible (as opposed to
	   sending larger bursts, but slower) */
	if (large_data && args.bw_limit > 0) {
	    flow_controller_property.token_bucket.tokens_added_per_period =
		(int)((float)args.bw_limit*1000000.0/8.0/100.0/1024.0);
	} else {
	    flow_controller_property.token_bucket.tokens_added_per_period =
		ResourceLimitsQosPolicy.LENGTH_UNLIMITED;
	}
	flow_controller_property.token_bucket.max_tokens =
	    ResourceLimitsQosPolicy.LENGTH_UNLIMITED;
	flow_controller_property.token_bucket.tokens_leaked_per_period =
	    ResourceLimitsQosPolicy.LENGTH_UNLIMITED;
	// tenMilliSec
	flow_controller_property.token_bucket.period.sec = 0;
	flow_controller_property.token_bucket.period.nanosec = 10*1000000;
	flow_controller_property.token_bucket.bytes_per_token = 1024; 
	/* minimum value */
    } 


    public static void configure_command_writer_qos(
            DataWriterQos command_writer_qos, Publisher publisher,
            Argument args) {
        Duration_t OneSecond = new Duration_t(1, 0);
        // Get the default writer QoS and configure to our
        // requirements for command packets
        publisher.get_default_datawriter_qos(command_writer_qos);
        // We will own the topic so set the strength as
        // determined by the user.
        command_writer_qos.ownership_strength.value = args.strength;
        // We will use guaranteed reliable communications to
        // communicate commands...
        DataWriterQos_setImpatientReliable(command_writer_qos, OneSecond);
    }

    public static int configure_data_writer_qos(
	DataWriterQos data_writer_qos,
	boolean large_data, int max_gather_send_buffers,
	Publisher publisher, Argument args, boolean useMulticast) {

        publisher.get_default_datawriter_qos(data_writer_qos);
        // We will own the topic so set the strength as
        // determined by the user.
        data_writer_qos.ownership_strength.value = args.strength;
        data_writer_qos.resource_limits.initial_samples = 1;

        // use these hard coded value until you use key
        data_writer_qos.resource_limits.max_instances = 1;
        data_writer_qos.resource_limits.initial_instances =
            data_writer_qos.resource_limits.max_instances;

	if (large_data || args.asynchronous) {
	    data_writer_qos.publish_mode.kind =
            PublishModeQosPolicyKind.ASYNCHRONOUS_PUBLISH_MODE_QOS;
	    data_writer_qos.publish_mode.flow_controller_name =
		"throughput test flow_controller";
	}

        // Unless specified, we will use best effort for this test so...
        if (!args.isReliable()) {
            data_writer_qos.reliability.kind =
                ReliabilityQosPolicyKind.BEST_EFFORT_RELIABILITY_QOS;
	    if (large_data || args.asynchronous) {
		/* We must queue samples so the asynchronous publishing thread
		   can access them later when tokens become available for
		   sending */
		data_writer_qos.history.kind = 
		    HistoryQosPolicyKind.KEEP_ALL_HISTORY_QOS;
		data_writer_qos.resource_limits.max_samples =
		    Argument.MAX_SAMPLES;
		data_writer_qos.resource_limits.initial_samples =
		    Argument.MAX_SAMPLES;
		data_writer_qos.resource_limits.max_samples_per_instance =
		    Argument.MAX_SAMPLES;

		/* max_blocking_time is only relevant when sending
		   asynchronously */
		data_writer_qos.reliability.max_blocking_time.sec = 3;
	    }
        } else {
            DataWriterQos_setReliableBursty(data_writer_qos,
                    Argument.MAX_SAMPLES, args.getMaxBlockingTime());
            data_writer_qos.protocol.push_on_write = !args.no_push_on_write;

	    if (large_data || args.asynchronous) {
		/* An asynchronous writer coalesces all piggyback HBs into a
		single HB that gets appended when sending the last asynchronous
		sample in the queue, so it is ok to request one piggyback
		HB with every sample. */
		data_writer_qos.protocol.rtps_reliable_writer.
		    heartbeats_per_max_samples = Argument.MAX_SAMPLES;

		data_writer_qos.reliability.max_blocking_time.sec = 3;
	    }

            if (useMulticast) {
                DataWriterQos_setMulticast(data_writer_qos, 32);
            }
        }

	/* When asynchronously writing small samples, we need to trigger the
	   flow controller faster than every 10ms, as the number of samples that
	   can be put on the wire every 10ms greatly exceeds
	   the writer's send queue size.
	   Approach: send message once all gather buffers are used up.
	   Need 1 buffer for RTPS header and >= 2 per issue submessage. */
	int samples_per_trigger = (max_gather_send_buffers-1)/2;
	/* Trigger at least 4 times per send queue. */
	if (samples_per_trigger > data_writer_qos.resource_limits.max_samples/4)
	{
	    samples_per_trigger = data_writer_qos.resource_limits.max_samples/4;
	}
	return samples_per_trigger;
    }
}

