/*
 (c) Copyright, Real-Time Innovations, $Date: 2012/10/10 17:42:46 $.
 All rights reserved.
 No duplications, whole or partial, manual or electronic, may be made
 without express written permission.  Any such copies, or
 revisions thereof, must display this notice unaltered.
 This code contains trade secrets of Real-Time Innovations, Inc.
*/

/*

=========================================================================*/

#include <stdlib.h>
#include <stdio.h>

#include "ndds/ndds_cpp.h"

/* INTERNAL API: Clock */
#include "clock/clock_highResolution.h"

#include "LatencyGlobalSettings.hxx"
#include "LatencyPlugin.h"

#include "Communicator.hxx"
#include "DataProcessor.hxx"


/* ---------------------------------------------------------------------*/
class LatencyEngine {
  protected:
    Communicator *_communicator;
    int _min_message_size, _max_message_size;
    DDS_Boolean _is_reliable, _receive_on_multicast;
    int _num_iter;
    int _subscribers;
    NDDS_Transport_ClassId_t _transport;

    struct RTIClock *_clock;
    LatencyDataProcessor _data_processor;
    Latency _send_instance;
    
  public:
    LatencyEngine();
    virtual ~LatencyEngine() {}
 
    DDS_Boolean initialize(const char *command_line_string,
                           int min_message_size, int max_message_size,
                           DDS_Boolean is_reliable,
                           DDS_Boolean receive_on_multicast,
                           int num_iter, 
                           int subscribers,
                           NDDS_Transport_ClassId_t transport);

    DDS_Boolean prepare_communicator(Communicator *communicator,
                                     char* mcast_recv_addr);

    DDS_Boolean execute_sending_loop();
    DDS_Boolean finalize();

  protected:
    DDS_Boolean signal_data_received();

  private:
    /* Leave commented for Latency Test.
    ** Runs separate received thread as necessary, 
    ** when needsReceiverThread()== DDS_BOOLEAN_TRUE
    */
    /* static int execute_receiver(); */
};


LatencyEngine::LatencyEngine()
{
}

/* ---------------------------------------------------------------------*/
DDS_Boolean LatencyEngine::prepare_communicator(Communicator *communicator,
                                                char* mcast_recv_addr)
{
    _communicator = communicator;
    return _communicator->prepare(&_send_instance, mcast_recv_addr,
                                  &_data_processor);
}

/* ---------------------------------------------------------------------*/
DDS_Boolean LatencyEngine::initialize( 
                        const char *command_line_string,
                        int min_message_size, int max_message_size,
                        DDS_Boolean is_reliable,
                        DDS_Boolean receive_on_multicast,
                        int num_iter, 
                        int subscribers,
                        NDDS_Transport_ClassId_t transport)
{
    /* check if user option greater than maximum message size
    ** of data + sequencenumber
    */
    if (max_message_size > 
        (int)(MAX_DATA_SEQUENCE_LENGTH + sizeof(DDS_Long))) {
        AppLog_exception("invalid parameter; "
                         "max_message_size > max sequence length\n");
        return DDS_BOOLEAN_FALSE;
    }

    _min_message_size = min_message_size;
    _max_message_size = max_message_size;
    _is_reliable = is_reliable;
    _receive_on_multicast = receive_on_multicast;
    _num_iter = num_iter;
    _subscribers = subscribers;
    _transport = transport;

    /*** INTERNAL API: RTIHighResolutionClock_XXX ***/
    _clock = RTIHighResolutionClock_new();
    
    if (!_data_processor.initialize(_clock, _num_iter)) {
        AppLog_exception("failed to initiate data processor or clock\n");
        return DDS_BOOLEAN_FALSE;
    }

    /* calculate the overhead for clock->getTime() call */
    if (!_data_processor.calculate_clock_overhead()) {
        AppLog_exception("failed to calculate clock overhead\n");
        return DDS_BOOLEAN_FALSE;
    }

    /* Size sequence to hold largest message */
    _send_instance.data.maximum((DDS_Long) _max_message_size);

    return DDS_BOOLEAN_TRUE;
}

/* ---------------------------------------------------------------------*/
DDS_Boolean LatencyEngine::finalize()
{
    _communicator->cleanup_sender();
    /*** INTERNAL API: RTIHighResolutionClock_XXX ***/
    RTIHighResolutionClock_delete(_clock);

    /* Close all files */
    return DDS_BOOLEAN_TRUE;
}

/* ---------------------------------------------------------------------*/
DDS_Boolean LatencyEngine::execute_sending_loop()
{
    DDS_Boolean ok = DDS_BOOLEAN_FALSE;

    const struct DDS_Duration_t sleep_time = {2,0};
    /*** INTERNAL API: RTINtpTime ***/
    const struct RTINtpTime ntp_sleep_time = {2,0};

    int i = 0;
    int echoer_cookie;
    int m_size;
    int round_number;
    
    /* Wait for communicator to be ready */
    AppLog_warn("Waiting for %d receivers.", _subscribers);
    while (_communicator->is_ready() == DDS_BOOLEAN_FALSE) {
        AppLog_warn("."); 
        /*** INTERNAL API: RTIOsapiSemaphore_XXX ***/
        RTIOsapiSemaphore_take(((RtiDdsSenderCommunicator*)_communicator)->sem,
			       &ntp_sleep_time);
    }
    AppLog_warn("\n");
    echoer_cookie = _communicator->get_echoer_cookie();
    if (echoer_cookie != LATENCY_RESTRICT_RECV_COOKIE_NONE) {
        AppLog_warn("Echoer restricted to the one in place #%d, identified to "
               "have cookie %d.\n", _subscribers, echoer_cookie);
    }

    /* Echo to stdout the banner for the report */
    AppLog_report("Collecting statistics on %d samples per message size.\n"
	   	  "This is the roundtrip time, *not* the one-way-latency\n", 
	   	  _num_iter);
    AppLog_report("bytes ,stdev us,ave us, min us, 50%% us, 90%% us, 99%% us, 99.99%%, max us\n");
    AppLog_report("------,-------,-------,-------,-------,-------,-------,-------,-------\n");
    AppLog_flush;

    for (m_size = _min_message_size, round_number = 0;
         m_size <= _max_message_size;
         m_size *= 2, ++round_number) { /* each round doubles payload */

        NDDSUtility::sleep(sleep_time);
        _send_instance.data.length(m_size - sizeof(DDS_Long));
        _data_processor.start_one_round(m_size);

        for (i = 0; i <= _num_iter;) {

/* ALLOW_SLOW_SWITCH_SLEEP 
** Define to activate sleep per send-cycle to
** prevent overwhelming slower switches
*/
#ifdef ALLOW_SLOW_SWITCH_SLEEP
            if(_receive_on_multicast) {
                const struct DDS_Duration_t waitTime = {0, m_size * 10000};
                NDDSUtility::sleep(waitTime);
            }
#endif
            _send_instance.sequence_number = 
                _data_processor.get_sequence_number();
            _send_instance.data[0] = echoer_cookie;
            _data_processor.start_one_issue();

            /* send the raw data to all interested parties */
            ok = _communicator->send_data();
                         
            if (!ok) {
                AppLog_exception("failed to send data\n");
                return DDS_BOOLEAN_FALSE;
            }

            /* wait until the echo message is received 
            ** from the LatencyReader 
            */
            /*** INTERNAL API: RTIOsapiSemaphore_XXX ***/
            RTIOsapiSemaphore_take(((RtiDdsSenderCommunicator*)_communicator)->
				   sem, &ntp_sleep_time);
            if(_data_processor.is_finished()) {//this packet exchange succeeded
		++i;
	    } else { // warn, sleep, and retry rather than stopping
                AppLog_exception("STOPPING SEND: did not receive echo "
                                 "in reasonable time "
                                 "(messageSize = %d, loop = %d)\n", 
                                 m_size, i);
		NDDSUtility::sleep(sleep_time);//break;
            }
        } /* end of for (i) */

        /* one round (m_size) finished. print out the result */
        _data_processor.finish_one_round();
    } /* end of for (m_size) */

    /* Set to final sequence number */
    _send_instance.sequence_number = FINAL_SEQUENCE_NUMBER;
    _send_instance.data.length(16);
    
    /* send to reader to terminate the reader */
    ok = _communicator->send_data();
    
    if (!ok) {
        AppLog_exception("failed to send data\n");
    }

    return ok;
}

/* ---------------------------------------------------------------------*/
static DDS_Boolean
publisher_main(int rti_dds_domain, char* peer, char* nic,
               int min_message_size, int max_message_size,
               DDS_Boolean is_reliable,
               DDS_Boolean receive_on_multicast, 
               char* mcast_recv_addr, 
               int multicast_ttl,
               DDS_Boolean use_key_in_topic,
               int num_iter,
               NDDS_Transport_ClassId_t transport,
               int recv_thread_priority, 
               int event_thread_priority, 
               int db_thread_priority,
               int subscribers, 
               const char *command_line_string)
{
    const struct DDS_Duration_t sleep_time = {2,0};
    DDS_Boolean ok = DDS_BOOLEAN_FALSE;
    LatencyEngine *latency_engine;
    Communicator *communicator;
         
    latency_engine = new LatencyEngine();
    ok = latency_engine->initialize(command_line_string,
                                    min_message_size, max_message_size,
                                    is_reliable, receive_on_multicast,
                                    num_iter, 
                                    subscribers,
                                    transport);
    if (!ok) {
        AppLog_exception("failed to initialize the engine\n");
        return DDS_BOOLEAN_FALSE;
    }
 
    communicator = new RtiDdsSenderCommunicator(
        rti_dds_domain, peer, nic, transport,
        is_reliable, receive_on_multicast, multicast_ttl, use_key_in_topic,
        recv_thread_priority, event_thread_priority, db_thread_priority,
        DDS_BOOLEAN_FALSE, /* start in not-ready state */
        subscribers);
    
    if (!latency_engine->prepare_communicator(communicator, 
                                              mcast_recv_addr)) {
        return DDS_BOOLEAN_FALSE;
    }

    /* Leave commented for Latency Test.
    ** Causes communicator to start receiver thread
    */ 
    /* communicator->runReceiverThread(); */

    /* ---------------------------------------------------------------------*/
    ok = latency_engine->execute_sending_loop();
    if (!ok) {
        AppLog_exception("failed to execute sending of data\n");
        return DDS_BOOLEAN_FALSE;
    }
 
    /* Give any started threads a chance to exit before cleaning up things */
    NDDSUtility::sleep(sleep_time);

    /* Cleanup the engine */
    ok = latency_engine->finalize();
    if (!ok) {
        AppLog_exception("failed to finalize data structures\n");
        return DDS_BOOLEAN_FALSE;
    }

    if (ok) {
        AppLog_warn("Test successful!\n");
    } else {
        AppLog_exception("Test NOT successful!\n");
    }
    AppLog_flush;
    
    /* clean-up engine */
    delete latency_engine;

    delete communicator;

    return DDS_BOOLEAN_TRUE;
}


/* ---------------------------------------------------------------------*/
#if !(defined(RTI_VXWORKS) && !defined(__RTP__)) && !defined(RTI_PSOS)
int main(int argc, char **argv)
{
    int min_message_size = 16;
    int max_message_size = 8192;
    int rti_dds_domain = 0;
    char *peer = NULL, *nic = NULL;
    DDS_Boolean use_multicast = DDS_BOOLEAN_FALSE;
    char* mcast_recv_addr = NULL;
    int multicast_ttl = 1;
    DDS_Boolean is_reliable = DDS_BOOLEAN_FALSE;
    DDS_Boolean use_keys = DDS_BOOLEAN_FALSE;
    int num_iter = 10000;
    NDDS_Transport_ClassId_t transport = DDS_TRANSPORTBUILTIN_UDPv4;

    /*** INTERNAL API: RTI_OSAPI_XXX ***/
    int recv_thread_priority = RTI_OSAPI_THREAD_PRIORITY_HIGH;
    int event_thread_priority = RTI_OSAPI_THREAD_PRIORITY_BELOW_NORMAL;
    int db_thread_priority = RTI_OSAPI_THREAD_PRIORITY_BELOW_NORMAL;
    char command_line[1024];
    int i;
    
    /* Assign default number of receivers to wait for */
    int subscribers = LATENCY_WAIT_RECV_COUNT_DEFAULT;

    const char *usage_str =
        "Usage:\n"
        "       %s  [commonoptions] [rtiddsoptions]\n"

        "\nWhere [commonoptions] are:\n"
        "\t-help                           "
        "- Print this usage message and exit\n"
        "\t-minSize       <size>           "
        "- Set minimum payload size (def. 16B)\n"
        "\t-maxSize       <size>           "
        "- Set maximum payload size (def. 8KB)\n"
        "\t-numIter       <count>          "
        "- Number of iterations per size.\n"
        "\t-subscribers   <recvCount>      "
        "- Wait for the presence of receivers\n"

        "\nWhere [rtiddsoptions] are:\n"
        "\t-domainId      <domainId>      "
        "- RTI DDS domain\n"
        "\t-nic         <IP>            "
        "- Network Interface Card (NIC) to use\n"
        "\t-peer        <peer>          "
        "- Peer Host IP Address\n"
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

    AppLog_warn("\nRTI DDS Latency Test - Publisher\n"
		"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");

#if defined(__RTP__)
        AppLog_exception("You cannot run the Latency Publisher in RTP mode on VxWorks\n"
                         "Please read the Instructions for further details\n");
        exit(1);
#endif

    if(argc <= 1){
      	 return publisher_main_no_args(); 
    } else {

    strcpy(command_line, argv[0]);
    for (i = 1; i < argc; i++) {
        strcat(command_line, " ");
        strcat(command_line, argv[i]);
    }

    for (i = 1; i < argc; i++) {
        if (IS_OPTION(argv[i], "-help")) {
            AppLog_exception(usage_str, argv[0]);
            return 0;
        } else if (IS_OPTION(argv[i], "-domainId")) {
            if ((i == (argc-1)) || *argv[++i] == '-') {
                AppLog_exception("Missing <id> after -domainId\n");
                return 0;
            }
            rti_dds_domain = strtol(argv[i], NULL, 10);
        } else if (IS_OPTION(argv[i], "-minSize")) {
            if ((i == (argc-1)) || *argv[++i] == '-') {
                AppLog_exception("Missing <size> after -minSize\n");
                return 0;
            }
            min_message_size = strtol(argv[i], NULL, 10);
        } else if (IS_OPTION(argv[i], "-maxSize")) {
            if ((i == (argc-1)) || *argv[++i] == '-') {
                AppLog_exception("Missing <size> after -maxSize\n");
                return 0;
            }
            max_message_size = strtol(argv[i], NULL, 10);
        } else if (IS_OPTION(argv[i], "-multicast_ttl") ){
            multicast_ttl = strtol(argv[++i], NULL, 10);
        } else if (IS_OPTION(argv[i], "-mcast_recv_addr") ){
            mcast_recv_addr = argv[++i];
            use_multicast = DDS_BOOLEAN_TRUE;
        } else if (IS_OPTION(argv[i], "-reliable")) {
            is_reliable = DDS_BOOLEAN_TRUE;
        } else if (IS_OPTION(argv[i], "-use_keys")) {
            use_keys = DDS_BOOLEAN_TRUE;
        } else if (IS_OPTION(argv[i], "-transport")) {
            if ((i == (argc-1)) || *argv[++i] == '-') {
                AppLog_exception("Missing value after -transport\n");
                return 0;
            }
            transport = strtol(argv[i], NULL, 10);
        } else if (IS_OPTION(argv[i], "-numIter")) {
            if ((i == (argc-1)) || *argv[++i] == '-') {
                AppLog_exception("Missing <iter> after -numIter\n");
                return 0;
            }
            num_iter = strtol(argv[i], NULL, 10);
        } else if (IS_OPTION(argv[i], "-recvThreadPriority") ) {
            if ((i == (argc-1)) || *argv[++i] == '-') {
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
                AppLog_exception("Missing <prio> after -dbThreadPriority\n");
                return 0;
            }
            db_thread_priority = strtol(argv[i], NULL, 10);
        } else if (IS_OPTION(argv[i], "-subscribers")) {
            if ((i == (argc-1)) || *argv[++i] == '-') {
                AppLog_exception("Missing <count> after -subscribers\n");
                return 0;
            }
            subscribers = strtol(argv[i], NULL, 10);
            if (subscribers > LATENCY_MAX_SUBSCRIPTIONS) {
                AppLog_exception("you can only wait for %d subscribers at most\n",
                                 LATENCY_MAX_SUBSCRIPTIONS);
                return 0;
            }
        } else if (IS_OPTION(argv[i], "-peer")) {
            if ((i == (argc-1)) || *argv[++i] == '-') {
                AppLog_exception("Missing value after -peer\n");
                return 0;
            }
            peer = argv[i];
        } else if (IS_OPTION(argv[i], "-nic")) {
            if ((i == (argc-1)) || *argv[++i] == '-') {
                AppLog_exception("Missing <address> after -nic\n");
                return 0;
            }
            nic = argv[i];
        } else {
            AppLog_exception("Unrecognized option \"%s\"\n", argv[i]);
            AppLog_exception("           use the '-help' option "
                             "to see the usage\n");
            return 0;
        }
    }

    return publisher_main(rti_dds_domain, peer, nic,
                          min_message_size, max_message_size,
                          is_reliable, use_multicast, 
                          mcast_recv_addr, multicast_ttl,
                          use_keys, num_iter, transport,
                          recv_thread_priority, 
                          event_thread_priority, 
                          db_thread_priority,
                          subscribers,
                          command_line);
    
   } /*if (argc <= 1)*/
}
#endif

/*This function will allow you to run the example by hard-coding the arguments*/
int publisher_main_no_args(void) {

    AppLog_warn("WARNING: running publisher_main_no_args function\n"
		"	  make sure the hard-coded arguments will\n"
		"         fit your system and scenario\n");
    AppLog_flush;

    char *peer = (char *)NULL;
    char *nic = (char *)NULL;

    int domainId = 0;

    int min_message_size = 16;
    int max_message_size = 8192;
    int num_iter = 10000;

    DDS_Boolean use_multicast = DDS_BOOLEAN_FALSE;
    char* mcast_recv_addr = NULL;
    int multicast_ttl = 1;
    DDS_Boolean is_reliable = DDS_BOOLEAN_FALSE;
    DDS_Boolean use_keys = DDS_BOOLEAN_FALSE;
    NDDS_Transport_ClassId_t transport = DDS_TRANSPORTBUILTIN_UDPv4;
    int subscribers = LATENCY_WAIT_RECV_COUNT_DEFAULT;

    /*** INTERNAL API: RTI_OSAPI_XXX ***/
    int recv_thread_priority = RTI_OSAPI_THREAD_PRIORITY_HIGH;
    int event_thread_priority = RTI_OSAPI_THREAD_PRIORITY_BELOW_NORMAL;
    int db_thread_priority = RTI_OSAPI_THREAD_PRIORITY_BELOW_NORMAL;

    return publisher_main(domainId, peer, nic,
                          min_message_size, max_message_size,
                          is_reliable, use_multicast,
                          mcast_recv_addr, multicast_ttl,
                          use_keys, num_iter, transport,
                          recv_thread_priority,
                          event_thread_priority,
                          db_thread_priority,
                          subscribers,
                          NULL);

}

#if defined(RTI_WINCE)
int wmain(int argc, wchar_t* argv[])
{
    char arg_array[MAX_COMMAND_LINE_ARGUMENTS][MAX_COMMAND_EXEC_LEN];
    char *argv_c[MAX_COMMAND_LINE_ARGUMENTS];
    int i;

    if(argc <= 1){
	return publisher_main_no_args();
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
