/*
 (c) Copyright, Real-Time Innovations, $Date: 2009/05/09 14:17:29 $.
 All rights reserved.
 No duplications, whole or partial, manual or electronic, may be made
 without express written permission.  Any such copies, or
 revisions thereof, must display this notice unaltered.
 This code contains trade secrets of Real-Time Innovations, Inc.
*/

/*=======================================================================*/

/*
**  Description
**  -----------
**
**  We use two pairs of best effort writers and best effort readers 
**  to measure the latency. The basic algorithm is as follows:
**
**    LatencyWriter                          LatencyReader
**    Create a writer (topic dataTopic)      Create a reader (topic dataTopic)
**    Create a reader (topic echoTopic)      Create a writer (topic echoTopic)
**    Start timer                            Wait
**    Send one issue --(topic dataTopic)-->  ...
**    Wait                                   Receive the issue
**    ....           <--(topic echoTopic)--  Send one issue of the same size
**    Receive the issue
**    Stop timer
**    Calculate delay, minus clock overhead, and divide by 2
*/

#ifndef latency_global_settings_h
#define latency_global_settings_h

/* RTI DDS header file */
#include "ndds/ndds_cpp.h"

/* Type header files */
#include "LatencySupport.h"
#include "Latency.h"

/* Type name */
#define LATENCY_TYPE_NAME LatencyTYPENAME

/* Topic names define what information is exchanged between pub/sub apps */

/* The max length of topic named used */
#define TOPIC_NAME_LENGTH_MAX (10)
/* DataTopic: from LatencyWriter to LatencyReader */
#define LATENCY_DATA_TOPIC_NAME    "DataTopic"
/* EchoTopic: from LatencyReader to LatencyWriter */
#define LATENCY_ECHO_TOPIC_NAME    "EchoTopic"


/* Max number of different issue sizes tested */
#define LATENCY_ROUND_MAX (16)
/* Number of loops to calculate clock overhead */
#define NUM_OF_LOOPS_CLOCK (320)
/* Number of loops to ave latency for each issue size */
#define NUM_OF_LOOPS (256)
/* The final sequence number to indicate to terminate the application */
#define FINAL_SEQUENCE_NUMBER (-1)

/* RTI DDS OVERHEAD:
** Conservative estimate to account for 
** issue overhead + potential INFO_TS + potential HB + ...
*/
#define RTI_DDS_OVERHEAD (512) 

#define UNFRAGMENTED_UDP_PACKET_SIZE_MAX (1500 - 14 - 20 - 8)

#define DEFAULT_TRANSPORT_SEND_DATA_PORT    (11000)
#define DEFAULT_TRANSPORT_RECEIVE_ECHO_PORT (11001)

/* default multicast addresses */
/* #define DEFAULT_DATA_MULTICAST_ADDRESS "225.3.2.1" */
/* #define DEFAULT_ECHO_MULTICAST_ADDRESS "225.1.2.3" */

/* Default is to leave unchanged */
#define DEFAULT_THREAD_PRIORITY (-1)

/* ---------------------------------------------------------------- */
/* Max number of remote subscriptions when using a transport plugin */
#define LATENCY_MAX_SUBSCRIPTIONS (32)

/* Sentinel value indicating the absence of a cookie. The presence
** of a response cookie limits the response of reader. Only
** the reader with the cookie that matches will echo back to
** the writer. No cookie means all readers respond
*/
#define LATENCY_RESTRICT_RECV_COOKIE_NONE (0)
#define LATENCY_WAIT_RECV_COUNT_DEFAULT   (1)

#define IS_OPTION(str, option) (strncmp(str, option, strlen(str)) == 0)

#define AppLog_exception	printf
#define AppLog_warn      	printf
#define AppLog_report     	printf
#define AppLog_flush          	fflush(stdout)

#define MAX_COMMAND_LINE_ARGUMENTS 80
#define MAX_COMMAND_EXEC_LEN 256

/*functions to run the example with hard-coded arguments*/
int publisher_main_no_args(void);
int subscriber_main_no_args(void);

#endif /* #ifndef latency_global_settings_h */
