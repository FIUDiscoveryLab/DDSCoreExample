/*:
 (c) Copyright, Real-Time Innovations, $Date: 2011/12/06 05:38:53 $.
 All rights reserved.
 No duplications, whole or partial, manual or electronic, may be made
 without express written permission.  Any such copies, or
 revisions thereof, must display this notice unaltered.
 This code contains trade secrets of Real-Time Innovations, Inc.
*/

/* This class is used to collect and validate the command line arguments for
   the NDDS Throughput tool */

#include <stdio.h>
#include <stdlib.h>
#ifndef ndds_cpp_h
  #include "ndds/ndds_cpp.h"
#endif
#include "ThroughputArgs.h"
#include "ThroughputCommon.h"

#define IS_OPTION(str, option) (strcmp(str, option) == 0)

ThroughputArgs::ThroughputArgs() {
    memset(_peer_hosts, 0, sizeof(_peer_hosts));
    memset(_error_string, 0 , sizeof(_error_string));
    memset(_nic, 0, sizeof(_nic));
    memset(_config_file_name, 0, sizeof(_config_file_name));
    memset(_arg_variables, 0, sizeof(_arg_variables));
}

void ThroughputArgs::usage() {
    const char * common_usage_str =
        "\t-help                         - Print this message and exit\n"
        "\t-nic         <NIC IP address> - Network Interface Card (NIC) to use\n"
        "\t                                This option limits the traffic to the\n"
        "\t                                specified NIC. By default all available\n"
        "\t                                NICs are used\n"
        /* Restrict the packet transmission to one network interface */
        "\t-domainId      <domainId>     - RTI DDS domain\n"
        /* We need to know the domain that the test is to operate on. */
        "\t-peer        <IP Address>     - Peer Host IP Address\n"
        "\t                                The parameter can be repeated ut to 16\n"
        "\t                                times to indicate multiple peers.\n"
        "\t                                Both unicast and multicast IP addresses\n"
        "\t                                can be used.\n"
        /* We need a list of peers */
        "\t-participantId        <id>    - Participant Id (range 0..3)\n"
        /* Participant Id */
        "\t-reliable                     - Use reliable service\n"
        "\t-file         <config file>   - Read arguments from the specified\n"
        "\t                                configuration file\n"
        /* We need to know if there are further options provided via a file */
        "\t-nddsVerbosity <int value>    - Set RTI DDS verbosity level (range 0..5)\n"
        "\t                                Meaning of value: 0 (Silent) to 5 (Max)\n"
        /* We need to know if the user needs feedback. */
        "\t-testVerbosity <int value>    - Set test verbosity level (range 0..5)\n"
        "\t                                Meaning of value: 0 (Silent) to 5 (Max)\n"
        /* We need to know if the user needs feedback. */
        "\t-transport    <transportId>   - Select the transport to use.\n" 
        "\t                                Possible values for transportId are:\n"
        "\t                                   (1: UDP, 2: shared memory)\n"
        "\t-name         <program name>  - Change the name used in the output\n"
        "\t                                messages to identify this program\n"
        "\t                                execution\n";

    AppLog_exception("Usage: \n\t%s [baseoptions] [extraoptions]\n\n",
                     _command);
    AppLog_exception("Where [baseoptions] are:\n%s\n", common_usage_str);
}

int ThroughputArgs::parse_common_args(int &arg, char ** argv) {
    /* Assume it is a common argument */
    _args_valid = DDS_BOOLEAN_TRUE;

    if ( IS_OPTION(argv[arg],"-participantId") ) {
        /* Peer host list */
        if (argv[++arg] != NULL) {
            participant_id = strtol(argv[arg],NULL,10);
            if (participant_id > MAX_PEER_PART_IDX) {
                sprintf(_error_string, "Only 5 participants permitted per node"
                        " (participant 0..4)\n");
                _args_valid = DDS_BOOLEAN_FALSE;
            }
        } else {
            _args_valid = DDS_BOOLEAN_FALSE;
        }
    } else if ( IS_OPTION(argv[arg], "-domainId") ) { /* Test Domain */
        if ( argv[++arg] != NULL) {
            ndds_domain = strtol(argv[arg], NULL, 10);
        } else {
            _args_valid = DDS_BOOLEAN_FALSE;
        }
    } else if ( IS_OPTION(argv[arg],"-peer") ) { /* Peer host list */
        if ((argv[++arg] != NULL) &&
            (max_peer_index < THROUGHPUT_TEST_MAX_NODES)) {
                strncpy(_peer_hosts[max_peer_index++], argv[arg],
                        MAX_PEER_LOCATOR_STR_LEN);
        } else {
            _args_valid = DDS_BOOLEAN_FALSE;
            if (max_peer_index >= THROUGHPUT_TEST_MAX_NODES) {
                sprintf(_error_string,"Peer nodes (%d) > Maximum number of "
                        "peer nodes permitted (%d)\n",
                        max_peer_index, THROUGHPUT_TEST_MAX_NODES);
            }
        }
    } else if ( IS_OPTION(argv[arg],"-name") ) { /* Executable name */
        if ( argv[++arg] != NULL) {
            exe_name = argv[arg];
        } else {
            _args_valid = DDS_BOOLEAN_FALSE;
        }
    } else if ( IS_OPTION(argv[arg],"-nic") ) {
        /* Test Network */
        if (argv[++arg] != NULL) {
            strncpy(_nic,argv[arg],MAX_PEER_LOCATOR_STR_LEN);
        } else {
            _args_valid = DDS_BOOLEAN_FALSE;
        }
    } else if ( IS_OPTION(argv[arg],"-reliable") ) {
        /* Use Reliable Communications */
        _reliable = DDS_BOOLEAN_TRUE;
    } else if ( IS_OPTION(argv[arg],"-transport") ) {
        /* Which transport to use? */
        if ( argv[++arg] != NULL) {
            _transport_to_use = strtol(argv[arg], NULL, 10);
        } else {
            _args_valid = DDS_BOOLEAN_FALSE;
        }
    } else if ( IS_OPTION(argv[arg], "-instance") ) {
        if (argv[++arg] != NULL) {
            mi_instance_count = strtol(argv[arg], NULL, 10);
        }else {
            _args_valid = DDS_BOOLEAN_FALSE;
        }
    } else if ( IS_OPTION(argv[arg], "-nddsVerbosity") ) {
        /* NDDS verbosity */
        if ( argv[++arg] != NULL) {
            ndds_verbosity = strtol(argv[arg], NULL, 10);
        } else {
            _args_valid = DDS_BOOLEAN_FALSE;
        }
    } else if ( IS_OPTION(argv[arg], "-testVerbosity") ) {
        /* Test verbosity */
        if ( argv[++arg] != NULL) {
            test_verbosity = strtol(argv[arg], NULL, 10);
        } else {
            _args_valid = DDS_BOOLEAN_FALSE;
        }
    } else if ( IS_OPTION(argv[arg],"-help") ) {
        /* Use Reliable Communications */
        _help_requested = DDS_BOOLEAN_TRUE;
    } else { /* return error */
        _args_valid = DDS_BOOLEAN_FALSE;
    }
    return _args_valid;
}

DDS_Boolean ThroughputArgs::validate_args() {
    return DDS_BOOLEAN_TRUE;
}

void ThroughputArgs::initialize(const char *command) {

    strncpy(_command, command, MAX_COMMAND_EXEC_LEN-1);
    _command[MAX_COMMAND_EXEC_LEN-1] = '\0';

    mi_instance_count = 0;

    ndds_domain = THROUGHPUT_TEST_DOMAIN_DEFAULT;
    max_peer_index = 0;

    _arguments_buff = NULL;

    ndds_verbosity = DEFAULT_NDDS_VERBOSITY;
    test_verbosity = DEFAULT_TEST_VERBOSITY;

    _reliable = DDS_BOOLEAN_FALSE;
    _help_requested = DDS_BOOLEAN_FALSE;
    _transport_to_use = 1; /* UDP */

    sprintf(_config_file_name,"Not Specified");
    sprintf(_error_string, "None\n");

}

void ThroughputArgs::print_arguments() {
    int i;
    AppLog_report("\t-nic = %s\n"
                  "\t-domainId = %d\n"
                  "\t-participantId = %d\n",
                  _nic, ndds_domain, participant_id);
    i = 0;
    while(++i < max_peer_index) {
        AppLog_report("\t-peer[%d] = '%s' \n",i,_peer_hosts[i]);
    }

    AppLog_report("\t-reliable         = %s\n"
                  "\t-nddsVerbosity     = %d\n"
                  "\t-testVerbosity    = %d\n"
                  "\t-file             = %s\n"
                  "\t-transport        = %d\n",
                  ((_reliable == DDS_BOOLEAN_TRUE)? "ON":"OFF"),
                  ndds_verbosity,
                  test_verbosity,
                  _config_file_name,
                  _transport_to_use);
}

int ThroughputArgs::construct_args_from_file(char *config_file_name,
                                             int &arg_count) {
    FILE *p_config_file;
    long end_of_buffer, file_length;
    int args_valid;

    args_valid = DDS_BOOLEAN_TRUE; /* Assume OK */

    p_config_file  = fopen(config_file_name, "r");
    if (p_config_file == NULL) {
        sprintf(_error_string, "Unable to open %s\n",config_file_name);
        args_valid = DDS_BOOLEAN_FALSE;
        return args_valid;
    }
    /* File name is OK so save the name in a
       class variable for printing arguments. */
    strncpy(_config_file_name,config_file_name,sizeof(config_file_name));

    /* Find the length of the file */
    fseek(p_config_file, 0, SEEK_END);
    file_length = ftell(p_config_file);
    fseek(p_config_file,0, SEEK_SET);

    /* Free if it has been allocated prior to this */
    if (_arguments_buff != NULL) {
        free(_arguments_buff);
    }

    /* Allocate a buffer for the whole file + 1 in case the file is empty! */
    _arguments_buff = (char *)calloc(file_length + 1, sizeof(char));

    /* and read the file in.... */
    end_of_buffer = fread(_arguments_buff,sizeof(char),file_length,
                          p_config_file);
    _arguments_buff[end_of_buffer-1] = '\0';

    /* Don't need the file an more ! */
    fclose(p_config_file);

    arg_count = 0;
    _arg_variables[++arg_count] = strtok(_arguments_buff," ");
    while(_arg_variables[arg_count] != NULL) {
        _arg_variables[++arg_count] = strtok(NULL," ");
    }
    return args_valid;
}

ThroughputPublisherArgs::~ThroughputPublisherArgs(void) {
}


ThroughputPublisherArgs::ThroughputPublisherArgs(void):
    ThroughputArgs() {
	AppLog_warn("WARNING: running ThroughputPublisherArgs() constructor\n"
		    "	      make sure the hard-coded arguments will\n"
		    "         fit your system and scenario\n");
    	AppLog_flush;

	_args_valid = DDS_BOOLEAN_TRUE;
	_arguments_buff = NULL;

        mi_instance_count = 0;

    	ndds_domain = THROUGHPUT_TEST_DOMAIN_DEFAULT;
    	
	max_peer_index = 0;

    	ndds_verbosity = DEFAULT_NDDS_VERBOSITY;
    	test_verbosity = DEFAULT_TEST_VERBOSITY;

    	_reliable = DDS_BOOLEAN_FALSE;
    	_help_requested = DDS_BOOLEAN_FALSE;
    	_transport_to_use = 1; /* UDP */

    	sprintf(_config_file_name,"Not Specified");
    	sprintf(_error_string, "None\n");

	participant_id = DEFAULT_PUBLISHER_PARTICIPANT_ID;
	
	/* Size of the message */
	packet_size = DEFAULT_PACKET_SIZE;
	
	/* Number of seconds to run the test */
    	test_duration_sec = DEFAULT_TEST_DURATION;

    	/* Set the default message demand per 10ms iteration */
    	recovery_time_msec = DEFAULT_RECOVERY_TIME_MS; /* 10ms */
    	demand_initial = DEFAULT_DEMAND;
    	demand_increment = DEFAULT_DEMAND;
    	demand_max = DEFAULT_DEMAND;

    	no_push_on_write = DDS_BOOLEAN_FALSE;

    	/* Assume only one subscriber */
    	subscribers = DEFAULT_NUMBER_OF_SUBSCRIBERS;

    	strength = DEFAULT_TEST_STRENGTH;
    	multicast_ttl = 1;
    	_max_blocking_time.sec = 0;
    	_max_blocking_time.nanosec = DEFAULT_MAX_BLOCKING_TIME_NS;
    	no_push_on_write = DDS_BOOLEAN_FALSE;
    	bw_limit = DDS_LENGTH_UNLIMITED;
    	asynchronous = DDS_BOOLEAN_FALSE;	

}


ThroughputPublisherArgs::ThroughputPublisherArgs(char* config_file_name):
    ThroughputArgs() {
    int arg_count;

    _args_valid = DDS_BOOLEAN_TRUE; /* Assume that arguments are OK */
    arg_count = 0;

    initialize(""); /* Set the defaults */

    _args_valid = construct_args_from_file(config_file_name,arg_count);
    if (_args_valid) {
        _args_valid = parse_arguments(arg_count, _arg_variables);
        /* If there are no parse errors check for logical errors. */
        if (_args_valid)  {
            _args_valid = validate_args();
        }
    }
}

ThroughputPublisherArgs::ThroughputPublisherArgs(int argc, char **argv)
    : ThroughputArgs() {

    initialize(argv[0]); /* Set the defaults */

    _args_valid = DDS_BOOLEAN_FALSE;

    exe_name = "Throughput_publisher";
    _args_valid = parse_arguments(argc, argv);
    /* If there are no parse errors check for logical errors. */
    if (_args_valid) {
        /* Provide loop back as default if no Peers specified. */
        _args_valid = validate_args();
    }
}

void ThroughputPublisherArgs::usage() {
    const char *publisherUsageStr =
    "Where [extraoptions] are:\n"
    "\t-multicast_ttl         <ttl>  - Multicast packet TTL (range 0..255)\n"
    "\t                                Use: 0 for inter-process test\n"
    "\t                                     1 for same subnet   test\n"
    "\t                                     N to limit to \"N\"hops\n"
    "\t-subscribers <num>            - Number of subscribers (range: 1..16)\n"
    /* We need to know how many  of the peers are subscribers. */
    "\t-size        <numBytes>       - Packet size (range 8..240000)\n"
    /* We need to know how  big the packet should be */
    "\t-duration    <numSeconds>     - Test duration in seconds\n"
    /* We need to know how long the test should last. */
    "\t-demand     <first:incr:last> - Controls messages sent per write loop\n"
    "\t                                increasing demand increases throughput\n"
    "\t                                and also the processor load\n"
    "\t                                Must be specified as a range using\n"
    "\t                                three numbers (first, incr, last)\n"
    "\t                                separated by a ':'\n"
    "\t                                The values must verify 1<= first <= last\n"
    "\t-recoveryTime  <ms>           - sleep time between 2 write loops\n"
    "\t-strength    <value>          - Sets DDS Writer Ownership Strength\n"
    /* We need to know what the strength of this publisher. */
    "\t-maxBlockingTime  <ms>        - Sets the DDS Reliable writer\n"
    "\t                                max blocking time (range: 20..MAX_INT)\n"
    "\t-no_push_on_write             - Force writer to not push information\n"
    "\t                                and send only in response to NACKs\n"
    "\t-asynchronous                 - Send data using a separate thread and\n"
    "\t                                enable flow control.\n"
    "\t                                This option is implied if the data-size\n"
    "\t                                exceeds the transport MTU\n";
    ThroughputArgs::usage();

    AppLog_exception(publisherUsageStr);
}

void ThroughputPublisherArgs::print_error() {
    AppLog_exception("\nLast error detected: %s", _error_string);
    AppLog_flush;
    /* Explain where the error occurred if possible. */
}

void ThroughputPublisherArgs::initialize(const char *command) {
    ThroughputArgs::initialize(command);

    participant_id = DEFAULT_PUBLISHER_PARTICIPANT_ID;

    /* Size of the message, can be up 63K user bytes +
       4 bytes for the sequence number; */
    packet_size = DEFAULT_PACKET_SIZE;

    /* Number of seconds to run the test */
    test_duration_sec = DEFAULT_TEST_DURATION;

    /* Set the default message demand per 10ms iteration */
    recovery_time_msec = DEFAULT_RECOVERY_TIME_MS; /* 10ms */
    demand_initial = DEFAULT_DEMAND;
    demand_increment = DEFAULT_DEMAND;
    demand_max = DEFAULT_DEMAND;

    no_push_on_write = DDS_BOOLEAN_FALSE;

    /* Assume only one subscriber */
    subscribers = DEFAULT_NUMBER_OF_SUBSCRIBERS;

    strength = DEFAULT_TEST_STRENGTH;
    multicast_ttl = 1;
    _max_blocking_time.sec = 0;
    _max_blocking_time.nanosec = DEFAULT_MAX_BLOCKING_TIME_NS;
    no_push_on_write = DDS_BOOLEAN_FALSE;
    bw_limit = DDS_LENGTH_UNLIMITED;
    asynchronous = DDS_BOOLEAN_FALSE;
}

DDS_Duration_t ThroughputPublisherArgs::get_max_blocking_time() {
    return _max_blocking_time;
}

DDS_Boolean ThroughputPublisherArgs::validate_args() {
    if (!ThroughputArgs::validate_args()) {
        return DDS_BOOLEAN_FALSE;
    }

    /* Is the packet size wrong ? */
    if (packet_size < 0) {
        sprintf(_error_string,"Packet Size = %d < 0\n",packet_size);
        return DDS_BOOLEAN_FALSE;
    }
    
    if (packet_size > (int)THROUGHPUT_TEST_PACKET_DATA_SIZE_MAX) {
	sprintf(_error_string,"Packet Size (%d) > "
			      "THROUGHPUT_TEST_PACKET_DATA_SIZE_MAX (%u) \n",
			      packet_size,THROUGHPUT_TEST_PACKET_DATA_SIZE_MAX);
	return DDS_BOOLEAN_FALSE;
	}


    /* Is the duration too small ? */
    if (test_duration_sec < MIN_TEST_DURATION_SEC) {
        sprintf(_error_string,"Duration (%d) < Minimum permitted (%d) ?\n",
        test_duration_sec, MIN_TEST_DURATION_SEC);
        return DDS_BOOLEAN_FALSE;
    }
    /* Have too many subscribers been specified ? */
    if (subscribers > MAX_TEST_SUBSCRIBERS) {
        sprintf(_error_string,"Subscribers (%d) > Max permitted (%d)?\n",
        subscribers, MAX_TEST_SUBSCRIBERS);
        return DDS_BOOLEAN_FALSE;
    }

    if (demand_initial <= 0 ||
        demand_increment <= 0 ||
        demand_max < demand_initial) {
        sprintf(_error_string,
            "Demand (%d) must be > 1 message per write loop\n",
        demand_initial);
        return DDS_BOOLEAN_FALSE;
    }

    if (_reliable) {
        if (((_max_blocking_time.sec == 0) &&
            (_max_blocking_time.nanosec < DEFAULT_MAX_BLOCKING_TIME_NS)) ||
            ((_max_blocking_time.nanosec % DEFAULT_FAST_HEARTBEAT_TIME_NS) !=
            0)) {
            sprintf(_error_string, "Max blocking time must be > 2 * "
                    "Fast Heartbeat period(10ms), and a multiple of 10 ms\n" );
            return DDS_BOOLEAN_FALSE;
        }
    }
    if (bw_limit <= 0 && bw_limit != DDS_LENGTH_UNLIMITED) {
        sprintf(_error_string,"B/W Limit (%d) must be > 0\n", bw_limit);
        return DDS_BOOLEAN_FALSE;
    }
    return DDS_BOOLEAN_TRUE;
}

DDS_Boolean ThroughputPublisherArgs::parse_arguments(int argc, char **argv) {
    /* This function is called recursively if there is a configuration file
       specified on the command line. */

    char config_file_name[_MAX_FILENAME_LENGTH];
    char *tmp1, *tmp2;

    _args_valid = DDS_BOOLEAN_TRUE; /* Assume all is OK */
    *config_file_name = 0; /* Ensure that file name is not hanging around */

    /* Parse the arguments */
    for (int i = 1; i < argc; ++i) {
        if ( IS_OPTION(argv[i],"-no_push_on_write") ) { 
            /* push reliable data */
            no_push_on_write = DDS_BOOLEAN_TRUE;
        } else if ( IS_OPTION(argv[i],"-subscribers") ) {
            /* number of subscribers */
            if ( argv[++i] != NULL) {
                subscribers = strtol(argv[i],NULL,10);
            } else {
                _args_valid = DDS_BOOLEAN_FALSE;
                return DDS_BOOLEAN_FALSE;
            }
        } else if ( IS_OPTION(argv[i], "-size") ) {
            /* Packet size */
            if ( argv[++i] != NULL) {
                packet_size = strtol(argv[i], NULL, 10);
                packet_size -= THROUGHPUT_PACKET_OVERHEAD;
            } else {
                _args_valid = DDS_BOOLEAN_FALSE;
                return DDS_BOOLEAN_FALSE;
            }
        } else if ( IS_OPTION(argv[i], "-multicast_ttl") ) { /* multicast_ttl */
            if (argv[++i] != NULL) {
                multicast_ttl = strtol(argv[i], NULL, 10);
            } else {
                _args_valid = DDS_BOOLEAN_FALSE;
                return DDS_BOOLEAN_FALSE;
            }
        } else if ( IS_OPTION(argv[i], "-duration") ) { /* Test duration */
            if ( argv[++i] != NULL) {
                test_duration_sec = strtol(argv[i], NULL, 10);
            } else {
                _args_valid = DDS_BOOLEAN_FALSE;
                return DDS_BOOLEAN_FALSE;
            }
        } else if ( IS_OPTION(argv[i], "-demand") ) {
            if (argv[++i] == NULL) {
                _args_valid = DDS_BOOLEAN_FALSE;
                return DDS_BOOLEAN_FALSE;
            }
	    tmp1 = strchr(argv[i], ':');
            if (!tmp1) {
                _args_valid = DDS_BOOLEAN_FALSE;
                return DDS_BOOLEAN_FALSE;
            }
            *tmp1 = 0; ++tmp1;
            demand_initial = strtol(argv[i], NULL, 10);
            tmp2 = strchr(tmp1, ':');
            if (!tmp2) {
                _args_valid = DDS_BOOLEAN_FALSE;
                return DDS_BOOLEAN_FALSE;
            }
            *tmp2 = 0; ++tmp2;
            demand_increment = strtol(tmp1, NULL, 10);
            demand_max = strtol(tmp2, NULL, 10);
	} else if ( IS_OPTION(argv[i], "-recoveryTime") ) {
	    /* sleep time in the send loop */
	    if ( argv[++i] != NULL) {
		recovery_time_msec = strtol(argv[i],NULL, 10);
	    } else {
		_args_valid = DDS_BOOLEAN_FALSE;
		return DDS_BOOLEAN_FALSE;		
	    }
	} else if ( IS_OPTION(argv[i], "-strength") ) {
            /* Ownership strength */
            if ( argv[++i] != NULL) {
                strength = strtol(argv[i], NULL, 10);
            } else {
                _args_valid = DDS_BOOLEAN_FALSE;
                return DDS_BOOLEAN_FALSE;
            }
        } else if ( IS_OPTION(argv[i], "-maxBlockingTime") ) {
            /* Maximum Blocking Time */
            if ( argv[++i] != NULL) {
                _blocking_time = strtol(argv[i],NULL, 10);
                set_max_blocking_time(_blocking_time);
            } else {
                _args_valid = DDS_BOOLEAN_FALSE;
                return DDS_BOOLEAN_FALSE;
            }
        } else if ( IS_OPTION(argv[i], "-bw_limit") ) {
            /* B/W Limit (applies to large data only) */
            if ( argv[++i] != NULL) {
                bw_limit = strtol(argv[i],NULL, 10);
            } else {
                _args_valid = DDS_BOOLEAN_FALSE;
                return DDS_BOOLEAN_FALSE;
            }
        } else if ( IS_OPTION(argv[i],"-asynchronous") ) {
            /* Whether to send data asynchronously (N/A if large data) */
            asynchronous = DDS_BOOLEAN_TRUE;
        } else if ( IS_OPTION(argv[i], "-file") ) {
            /* Configuration file name  do here because of recursion */
            if ( argv[++i] != NULL) {
                strncpy(config_file_name, argv[i], sizeof(config_file_name));
                /* Get local copy to use (recursion) */
            } else {
                _args_valid = DDS_BOOLEAN_FALSE;
                return DDS_BOOLEAN_FALSE;
            }
        } else {
            /* Check to see if it is one of the common arguments */
            if (ThroughputArgs::parse_common_args(i,argv) ==
                DDS_BOOLEAN_FALSE) {
                return DDS_BOOLEAN_FALSE;
            }
        }
    }

    if (strlen(config_file_name) > 0)     {
        int arg_count;
        _args_valid = construct_args_from_file(config_file_name,arg_count);
        if (_args_valid) {
            /* Recurse using file arguments which take precedent */
            _args_valid = parse_arguments(arg_count, _arg_variables);
        }
    }
    return _args_valid;
}

void ThroughputPublisherArgs::print_arguments() {
    ThroughputArgs::print_arguments();

    AppLog_report(
           "\t-subscribers     = %d\n"
           "\t-size            = %d bytes\n"
           "\t-duration        = %d seconds\n"
           "\t-demand          = %d:%d:%d message(s) per write loop\n"
           "\t-recoveryTime    = %d sleep time between 2 write loops\n"
           "\t-strength        = %d\n"
           "\t-maxBlockingTime = %lu ms\n"
           "\t-no_push_on_write= %d \n"
           "\t-bw_limit        = %d Mbit/s \n"
           "\t-asynchronous    = %d \n",
           subscribers,
           packet_size,
           test_duration_sec,
           demand_initial, demand_increment, demand_max,
           recovery_time_msec,
           strength,
           _blocking_time,
           no_push_on_write,
           bw_limit,
           asynchronous);
}

void ThroughputPublisherArgs::set_max_blocking_time(unsigned long msec) {
    while(msec >= 1000) {
        _max_blocking_time.sec++;
        msec -= 1000;
    }
    _max_blocking_time.nanosec = msec * 1000000;
}


ThroughputSubscriberArgs::ThroughputSubscriberArgs(void):
    ThroughputArgs() {
	AppLog_warn("WARNING: running ThroughputSubscriberArgs() constructor\n"
		    "	      make sure the hard-coded arguments will\n"
		    "         fit your system and scenario\n");
    	AppLog_flush;

	_args_valid = DDS_BOOLEAN_TRUE;
	_arguments_buff = NULL;
	
	mi_instance_count = 0;

    	ndds_domain = THROUGHPUT_TEST_DOMAIN_DEFAULT;
    	
	max_peer_index = 0;

    	ndds_verbosity = DEFAULT_NDDS_VERBOSITY;
    	test_verbosity = DEFAULT_TEST_VERBOSITY;

    	_reliable = DDS_BOOLEAN_FALSE;
    	_help_requested = DDS_BOOLEAN_FALSE;
    	_transport_to_use = 1; /* UDP */

    	sprintf(_config_file_name,"Not Specified");
    	sprintf(_error_string, "None\n");

        participant_id = DEFAULT_SUBSCRIBER_PARTICIPANT_ID;
	mcast_recv_addr = NULL;

}

ThroughputSubscriberArgs::~ThroughputSubscriberArgs(void) {
}

ThroughputSubscriberArgs::ThroughputSubscriberArgs(char * config_file_name):
    ThroughputArgs() {
    int arg_count;

    _args_valid = DDS_BOOLEAN_TRUE; /* Assume that arguments are OK */
    exe_name = "Throughput_subscriber";
    mcast_recv_addr = NULL;
    arg_count = 0;

    initialize(""); /* Set the defaults */

    _args_valid = construct_args_from_file(config_file_name,arg_count);
    if (_args_valid) {
        _args_valid = parse_arguments(arg_count, _arg_variables);
        /* If there are no parse errors check for logical errors. */
        if (_args_valid) {
            _args_valid = validate_args();
         }
    }
}

ThroughputSubscriberArgs::ThroughputSubscriberArgs(int argc, char **argv):
    ThroughputArgs() {

    initialize(argv[0]); /* Set the defaults */

    _args_valid = DDS_BOOLEAN_TRUE;  /* Assume that arguments are OK */
    exe_name = "Throughput_subscriber";
    mcast_recv_addr = NULL;
    _args_valid = parse_arguments(argc, argv);

    /* If there are no parse errors check for logical errors. */
    if (_args_valid) {
        _args_valid = validate_args();
     }
}

void ThroughputSubscriberArgs::usage() {
    const char *subscriber_usage_str =
        "Where [extraoptions] are:\n"
        "\t-mcast_recv_addr <IP Address> - Multicast receive address\n";

    ThroughputArgs::usage();
    AppLog_exception(subscriber_usage_str);
}

void ThroughputSubscriberArgs::print_error() {
    AppLog_exception("\nLast error detected: %s", _error_string);
    /* Explain where the error occurred if possible. */
}

void ThroughputSubscriberArgs::initialize(const char *command) {
    ThroughputArgs::initialize(command);
    participant_id = DEFAULT_SUBSCRIBER_PARTICIPANT_ID;
}

DDS_Boolean ThroughputSubscriberArgs::validate_args() {
    return ThroughputArgs::validate_args();
}

DDS_Boolean ThroughputSubscriberArgs::parse_arguments(int argc, char **argv) {
    /* This function is called recursively if there is a configuration file
       specified on the command line. */

    char config_file_name[_MAX_FILENAME_LENGTH];

    _args_valid = DDS_BOOLEAN_TRUE; /* Assume all is OK */
    *config_file_name = 0; /* Ensure that file name is not hanging around */

    /* Parse the arguments */
    for (int i = 1; i < argc; ++i) {
        if ( IS_OPTION(argv[i], "-mcast_recv_addr") ) {
            if (argv[++i] != NULL) {
                mcast_recv_addr = argv[i];
            } else {
                _args_valid = DDS_BOOLEAN_FALSE;
                return DDS_BOOLEAN_FALSE;
            }
        } else if ( IS_OPTION(argv[i], "-file") ) {
            /* Configuration file name */
            if (argv[++i] != NULL) {
                strncpy(config_file_name, argv[i], sizeof(config_file_name));
                /* Get local copy to use (recursion) */
            } else {
                _args_valid = DDS_BOOLEAN_FALSE;
                return DDS_BOOLEAN_FALSE;
            }
        } else  { /* Check to see if it is one of the common arguments */
            if (!ThroughputArgs::parse_common_args(i,argv)) {
                return DDS_BOOLEAN_FALSE;
            }
        }
    }

    if (strlen(config_file_name) > 0) {
        int arg_count;

        _args_valid =  construct_args_from_file(config_file_name, arg_count);
        if (_args_valid) {
            /* Recurse using file arguments which take precedent */
            _args_valid = parse_arguments(arg_count, _arg_variables);
        }
    }
    return _args_valid;
}

void ThroughputSubscriberArgs::print_arguments() {
    ThroughputArgs::print_arguments();
    AppLog_report("\t-mcast_recv_addr %s\n",
          mcast_recv_addr ? mcast_recv_addr: "none");
}
