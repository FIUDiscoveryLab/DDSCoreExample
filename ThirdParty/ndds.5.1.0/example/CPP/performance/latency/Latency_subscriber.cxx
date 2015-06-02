/*
 (c) Copyright, Real-Time Innovations, $Date: 2013/11/22 19:48:16 $.
 All rights reserved.
 No duplications, whole or partial, manual or electronic, may be made
 without express written permission.  Any such copies, or
 revisions thereof, must display this notice unaltered.
 This code contains trade secrets of Real-Time Innovations, Inc.
*/

/*=======================================================================*/

#include <stdio.h>
#include <stdlib.h>

#include "reda/reda_string.h"
#include "LatencyGlobalSettings.hxx"
#include "Communicator.hxx"


static DDS_Boolean subscriber_main(
    int rti_dds_domain, int rti_dds_part_index,
    char* peer, char* nic,
    int cookie, DDS_Boolean is_reliable,
    DDS_Boolean receive_on_multicast, 
    char* mcast_recv_addr, 
    int multicast_ttl,
    DDS_Boolean use_keys, 
    NDDS_Transport_ClassId_t transport,
    int recv_thread_priority, 
    int event_thread_priority, 
    int db_thread_priority,
    DDS_Boolean echo_disabled)
{
    Communicator *communicator;
    const struct DDS_Duration_t sleep_time = {2,0};
    Latency *send_instance;
    DDS_Octet *data_buffer;

    communicator = new RtiDdsReceiverCommunicator(
        rti_dds_domain, rti_dds_part_index, peer, nic, transport,
        is_reliable, receive_on_multicast, multicast_ttl, use_keys,
        recv_thread_priority, event_thread_priority, db_thread_priority,
        cookie, echo_disabled);
   
    /* set up the data buffer for sending/receiving the message */
    send_instance = new Latency() ;
    data_buffer = 
        (DDS_Octet *)calloc(MAX_DATA_SEQUENCE_LENGTH, sizeof(DDS_Octet));
    if (data_buffer == NULL) {
        AppLog_exception("failed to create data buffer\n");
        return DDS_BOOLEAN_FALSE;
    }
    send_instance->data.loan_contiguous(data_buffer, 
                                        MAX_DATA_SEQUENCE_LENGTH, 
                                        MAX_DATA_SEQUENCE_LENGTH);

    if (!communicator->prepare(send_instance, mcast_recv_addr, NULL)) {
         AppLog_exception("failed to prepare communications\n");
         return DDS_BOOLEAN_FALSE;
    }

    /* Leave commented for Latency Test.
    ** Causes communicator to start a thread
    */ 
    /* communicator->runReceiverThread(); */

    /* passively receive issue and echo back */
    while (!communicator->has_received_sentinel()) {
        NDDSUtility::sleep(sleep_time);
    }

    AppLog_warn("Test successful: %d messages received, %d replies sent.\n",
                communicator->recv_message_count(), 
                communicator->sent_message_count());

    communicator->cleanup_receiver();

    delete communicator;

    send_instance->data.unloan();
    delete send_instance;

    free(data_buffer);

    return DDS_BOOLEAN_TRUE;  
}

#if !(defined(RTI_VXWORKS) && !defined(__RTP__)) && !defined(RTI_PSOS)
int main(int argc, char *argv[])
{
    int rti_dds_domain = 0;
    /* Use default => (cookie != 0)?(cookie %50):1 */
    int rti_dds_part_index  = -1; 
    int cookie = 1; 
    char *peer = NULL, *nic = NULL;
    DDS_Boolean echo_disabled = DDS_BOOLEAN_FALSE;
    DDS_Boolean use_multicast = DDS_BOOLEAN_FALSE;
    char* mcast_recv_addr = NULL;
    int multicast_ttl = 1;
    DDS_Boolean is_reliable = DDS_BOOLEAN_FALSE;
    DDS_Boolean use_keys = DDS_BOOLEAN_FALSE;
    NDDS_Transport_ClassId_t transport = DDS_TRANSPORTBUILTIN_UDPv4;

    /*** INTERNAL API: RTI_OSAPI_XXX ***/
    int recv_thread_priority = RTI_OSAPI_THREAD_PRIORITY_HIGH;
    int event_thread_priority = RTI_OSAPI_THREAD_PRIORITY_BELOW_NORMAL;
    int db_thread_priority = RTI_OSAPI_THREAD_PRIORITY_BELOW_NORMAL;

    const char *usage_str =
        "Usage:\n"
        "       %s  [commonoptions] [rtiddsoptions]\n"

        "\nWhere [commonoptions] are:\n"
        "\t-help                 "
        "- Print this usage message and exit\n"
        "\t-cookie      <cookie> "
        "- Globally-unique number among subscribers: 1..255\n"
        "\t                        "
        "Allows publisher to restrict reply to a single\n"
        "\t                        subscriber. "
        "(cookie==0) ==> do not restrict\n"
        "\t-noecho               "
        "- Do not echo. Overrides the use of the cookie\n"
        "\nWhere [rtiddsoptions] are:\n"
        "\t-domainId              <id>    "
        "- RTI DDS domain (range 0..100)\n"
        "\t-nic                 <IP>    "
        "- Network Interface Card (NIC) to use\n"
        "\t-peer                <peer>  "
        "- Peer Host IP Address\n"
        "\t-index               <index> "
        "- RTI DDS Participant index (range 0..50)\n"
        "\t-reliable                    "
        "- Use reliable service\n"
        "\t-multicast_ttl       <ttl>   "
        "- Multicast packet TTL\n"
        "\t-mcast_recv_addr     <IP>    "
        "- Multicast receive address\n"
        "\t-transport (1: UDPv4, 2: shmem, 8: UDPv6)\n"
        "\t-recvThreadPriority  <prio>  "
        "- Set priority of the RTI DDS receive threads\n"
        "\t-eventThreadPriority <prio>  "
        "- Set priority of the RTI DDS event thread\n"
        "\t-dbThreadPriority    <prio>  "
        "- Set priority of the RTI DDS database thread\n";     

    AppLog_warn("\nRTI DDS Latency Test - Subscriber\n");
    AppLog_warn("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");

    if(argc <= 1){
      	 return subscriber_main_no_args(); 
    } else {

    for (int i = 1; i < argc; i++) {
        if (IS_OPTION(argv[i], "-help")) {
            AppLog_exception(usage_str, argv[0]);
            return 0;
        } else if (IS_OPTION(argv[i], "-domainId")) {
            if ((i == (argc-1)) || *argv[++i] == '-') {
                AppLog_exception("Missing <id> after -domainId\n");
                return 0;
            }
            rti_dds_domain = strtol(argv[i], NULL, 10);
        } else if (IS_OPTION(argv[i], "-index")) {
            if ((i == (argc-1)) || *argv[++i] == '-') {
                AppLog_exception("Missing <index> after -index\n");
                return 0;
            }
            rti_dds_part_index = strtol(argv[i], NULL, 10);
        } else if (IS_OPTION(argv[i], "-cookie")) {
            if ((i == (argc-1)) || *argv[++i] == '-') {
                AppLog_exception("Missing <cookie> after -cookie\n");
                return 0;
            }
            cookie = strtol(argv[i], NULL, 10);
        } else if (IS_OPTION(argv[i], "-noecho")) {
            echo_disabled = DDS_BOOLEAN_TRUE;
        } else if (IS_OPTION(argv[i], "-multicast_ttl")) {
            multicast_ttl = strtol(argv[++i], NULL, 10);
        } else if (IS_OPTION(argv[i], "-mcast_recv_addr")) {
            mcast_recv_addr = argv[++i];
            use_multicast = DDS_BOOLEAN_TRUE;
        } else if (IS_OPTION(argv[i], "-reliable")) {
            is_reliable = DDS_BOOLEAN_TRUE;
        } else if (IS_OPTION(argv[i], "-use_keys")) {
            use_keys = DDS_BOOLEAN_TRUE;
        } else if (IS_OPTION(argv[i], "-transport")) {
            if ((i == (argc-1)) || *argv[++i] == '-') {
                AppLog_exception("Missing value after "
                                 "-transport\n");
                return 0;
            }
            transport = strtol(argv[i], NULL, 10);
        } else if (IS_OPTION(argv[i], "-recvThreadPriority")) {
            if ((i == (argc-1)) || *argv[++i] == '-' ) {
                AppLog_exception("Missing <prio> after "
                                 "-recvThreadPriority\n");
                return 0;
            }
            recv_thread_priority = strtol(argv[i], NULL, 10);
        } else if (IS_OPTION(argv[i], "-eventThreadPriority")) {
            if ((i == (argc-1)) || *argv[++i] == '-') {
                AppLog_exception("Missing <prio> after "
                                 "-eventThreadPriority\n");
                return 0;
            }
            event_thread_priority = strtol(argv[i], NULL, 10);
        } else if (IS_OPTION(argv[i], "-dbThreadPriority")) {
            if ((i == (argc-1)) || *argv[++i] == '-') {
                AppLog_exception("Missing <prio> after "
                                 "-dbThreadPriority\n");
                return 0;
            }
            db_thread_priority = strtol(argv[i], NULL, 10);
        } else if (IS_OPTION(argv[i], "-nic")) {
            if ((i == (argc-1)) || *argv[++i] == '-') {
                AppLog_exception("Missing <address> after -nic\n");
                return 0;
            }
            nic = argv[i];
        } else if (IS_OPTION(argv[i], "-peer")) {
            if ((i == (argc-1)) || *argv[++i] == '-') {
                AppLog_exception("Missing value after -peer\n");
                return 0;
            }
            peer = argv[i];
        } else {
            AppLog_exception("Unrecognized option \"%s\"\n", argv[i]);
            AppLog_exception("           use the '-help' option "
                             "to see the usage\n");
            return 0;
        }
    }

    if (rti_dds_part_index == -1) {
        rti_dds_part_index  = (cookie != 0)?(cookie %50):1;  
    }
    
    if ((rti_dds_part_index < 1) || (rti_dds_part_index > 50)) {
        AppLog_exception("Out of range value specified for option -index.\n"
               "           Specified value was %d, valid range is "
               "between 1 and 50\n", 
               rti_dds_part_index);
        return 0;
    }

    if ((cookie < 0) || (cookie > 255)) {
        AppLog_exception("Out of range value specified for option -cookie.\n"
               "           Specified value was %d, valid range is "
               "between 0 and 255\n", 
               cookie);
        return 0;
    }
    
    return subscriber_main(rti_dds_domain, rti_dds_part_index,
                           peer, nic,
                           cookie,
                           is_reliable,
                           use_multicast, mcast_recv_addr, multicast_ttl,
                           use_keys, transport,
                           recv_thread_priority, 
                           event_thread_priority, 
                           db_thread_priority,
                           echo_disabled);
    } /*if (argc <= 1)*/
}
#endif

/*This function will allow you to run the example by hard-coding the arguments*/
int subscriber_main_no_args(void) {

    AppLog_warn("WARNING: running subscriber_main_no_args function\n"
		"	  make sure the hard-coded arguments will\n"
		"         fit your system and scenario\n");
    AppLog_flush;

    char *peer = (char *)NULL;
    char *nic = (char *)NULL;
    
    int rti_dds_part_index  = -1;
    int cookie = 1;
    int domainId = 0;

    DDS_Boolean echo_disabled = DDS_BOOLEAN_FALSE;
    DDS_Boolean use_multicast = DDS_BOOLEAN_FALSE;
    char* mcast_recv_addr = NULL;
    int multicast_ttl = 1;
    DDS_Boolean is_reliable = DDS_BOOLEAN_FALSE;
    DDS_Boolean use_keys = DDS_BOOLEAN_FALSE;
    NDDS_Transport_ClassId_t transport = DDS_TRANSPORTBUILTIN_UDPv4;

    /*** INTERNAL API: RTI_OSAPI_XXX ***/
    int recv_thread_priority = RTI_OSAPI_THREAD_PRIORITY_HIGH;
    int event_thread_priority = RTI_OSAPI_THREAD_PRIORITY_BELOW_NORMAL;
    int db_thread_priority = RTI_OSAPI_THREAD_PRIORITY_BELOW_NORMAL;

    return subscriber_main(domainId, rti_dds_part_index,
                           peer, nic,
                           cookie,
                           is_reliable,
                           use_multicast, mcast_recv_addr, multicast_ttl,
                           use_keys, transport,
                           recv_thread_priority,
                           event_thread_priority,
                           db_thread_priority,
                           echo_disabled);
}

#if defined(RTI_WINCE)
int wmain(int argc, wchar_t* argv[])
{
    char arg_array[MAX_COMMAND_LINE_ARGUMENTS][MAX_COMMAND_EXEC_LEN];
    char *argv_c[MAX_COMMAND_LINE_ARGUMENTS];
    int i;

    if(argc <= 1){
	return subscriber_main_no_args();
    } else {
    for (i = 0; i < argc; ++i) {
        wcstombs(arg_array[i], argv[i], wcslen(argv[i]) + 1);
        arg_array[i][wcslen(argv[i])] = '\0';
        argv_c[i] = arg_array[i];
    }
    argv_c[argc] = '\0';
    return main(argc, argv_c);
    }
}
#endif
