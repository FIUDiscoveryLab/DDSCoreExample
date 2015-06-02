/*
 (c) Copyright, Real-Time Innovations, $Date: 2009/05/09 14:17:40 $.
 All rights reserved.
 No duplications, whole or partial, manual or electronic, may be made
 without express written permission.  Any such copies, or
 revisions thereof, must display this notice unaltered.
 This code contains trade secrets of Real-Time Innovations, Inc.
*/

#ifndef ThroughputCommon_h
#define ThroughputCommon_h

#ifndef ndds_cpp_h
  #include "ndds/ndds_cpp.h"
#endif

#define WIRE_PROTOCOL_OVERHEAD 512
/* conservative estimate to account for overhead */

#define TEST_VERBOSITY_ERRORS    1
#define TEST_VERBOSITY_WARNINGS  2
#define TEST_VERBOSITY_MESSAGES  3

#define MAX_TEST_SUBSCRIBERS 16
#define MIN_TEST_DURATION_SEC 1

#define DEFAULT_TEST_DURATION 10 /* 10 seconds */
#define DEFAULT_TEST_STRENGTH 5
#define DEFAULT_NUMBER_OF_SUBSCRIBERS 1

#define DEFAULT_DEMAND 10 /* Message per write loop */
#define DEFAULT_RECOVERY_TIME_MS 10 /* sleep per write loop*/
#define DEFAULT_PUBLISHER_PARTICIPANT_ID 0
#define DEFAULT_SUBSCRIBER_PARTICIPANT_ID 1

#define DEFAULT_MAX_BLOCKING_TIME_NS   999000000
#define DEFAULT_FAST_HEARTBEAT_TIME_NS  1000000

#define THROUGHPUT_PACKET_OVERHEAD 12 /* 4 bytes for key, 4 bytes for length of
    sequence and 4 bytes for sequence number. */
#define DEFAULT_PACKET_SIZE (1024 - THROUGHPUT_PACKET_OVERHEAD)

#define NANOSEC_PER_MILLISEC 1000000

#define SHMEM_SIZE_MAX  262144

#ifdef RTI_WINCE
  #define UDP_SIZE_MAX    9126
  
  #define UDP_SOCKET_SEND_BUFFER_SIZE     UDP_SIZE_MAX
  #define UDP_SOCKET_RECV_BUFFER_SIZE     UDP_SOCKET_SEND_BUFFER_SIZE
#else
  #define UDP_SIZE_MAX    65536

  /*If you plan to increase the socket buffer sizes, make sure your OS supports it*/
  #define UDP_SOCKET_SEND_BUFFER_SIZE     UDP_SIZE_MAX
  #define UDP_SOCKET_RECV_BUFFER_SIZE     2*UDP_SOCKET_SEND_BUFFER_SIZE
#endif

#define MESSAGE_SIZE_MAX (UDP_SIZE_MAX - WIRE_PROTOCOL_OVERHEAD)
#define QUEUE_SIZE 100

#define MAX_EVENT_COUNT (1024 * 16)

#define MAX_ACCEPTABLE_PACKET_LOSS 4

#define AppLog_report printf
#define AppLog_exception printf
#define AppLog_warn printf
#define AppLog_flush fflush(stdout)

extern const DDS_Duration_t ten_millisec;
extern const DDS_Duration_t twenty_millisec;
extern const DDS_Duration_t hundred_millisec;
extern const DDS_Duration_t one_second;
extern const DDS_Duration_t three_second;

void set_logger_verbosity(int ndds_verbosity);

#endif /* ThroughputCommon_h */
