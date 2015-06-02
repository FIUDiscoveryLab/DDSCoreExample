/*
 (c) Copyright, Real-Time Innovations, $Date: 2012/04/23 18:37:51 $.
 All rights reserved.
 No duplications, whole or partial, manual or electronic, may be made
 without express written permission.  Any such copies, or
 revisions thereof, must display this notice unaltered.
 This code contains trade secrets of Real-Time Innovations, Inc.
*/

#include <stdio.h>
#include <stdlib.h>
#ifndef ndds_cpp_h
  #include "ndds/ndds_cpp.h"
#endif
#include "Throughput.h"
#include "ThroughputArgs.h"
#include "ThroughputCommon.h"
#include "ThroughputPlugin.h"
#include "ThroughputQos.h"
#include "ThroughputSupport.h"
#include "ThroughputTransport.h"
#include "PerfMon.h"
#include "TimeManager.h"

/* Delete all entities */
static int publisher_shutdown(DDSDomainParticipant *participant) {
    DDS_ReturnCode_t return_code;
    int status = 0;

    if (participant != NULL) {
        return_code = participant->delete_contained_entities();
        if (return_code != DDS_RETCODE_OK) {
            AppLog_exception("delete_contained_entities error %d\n", return_code);
            status = -1;
        }

        return_code = DDSTheParticipantFactory->
            delete_participant(participant);
        if (return_code != DDS_RETCODE_OK) {
            AppLog_exception("delete_participant error %d\n", return_code);
            status = -1;
        }
    }

    /* RTI Connext provides finalize_instance() method for
       people who want to release memory used by the participant factory
       singleton. Uncomment the following block of code for clean destruction
       of the participant factory singleton. */
/*
    return_code = DDSDomainParticipantFactory::finalize_instance();
    if (return_code != DDS_RETCODE_OK) {
        AppLog_exception("finalize_instance error %d\n", return_code);
        status = -1;
    }
*/
    return status;
}

int publisher_test_throughput(ThroughputPublisherArgs args) {

    DDS_InstanceHandle_t *instance_handle_array = NULL;
    DDS_InstanceHandle_t nil_instance_handle = DDS_HANDLE_NIL;
    DDS_InstanceHandle_t *instance_handle = &nil_instance_handle;
    int instance_index = 0;
    DDSDomainParticipantFactory *factory;
    DDS_DomainParticipantFactoryQos factory_qos;
    DDSDomainParticipant *participant;
    DDS_DomainParticipantQos participant_qos;
    DDSPublisher *publisher;
    DDS_PublisherQos publisher_qos;
    /* And a data writer to do the work */
    ThroughputDataWriter *throughput_writer;
    DDS_DataWriterQos throughput_writer_qos;
    DDS_PublicationMatchedStatus throughput_writer_status;
    /* And a writer to communicate commands */
    ThroughputCommandDataWriter *throughput_command_writer;
    DDS_DataWriterQos throughput_command_writer_qos;
    DDS_PublicationMatchedStatus throughput_command_writer_status;
    DDSTopic *throughput_topic;
    Throughput *throughput_instance;
    DDS_TopicQos throughput_qos;
    DDSTopic *throughput_command_topic;
    ThroughputCommand *throughput_command_instance;
    DDS_TopicQos throughput_command_qos;

    /***************************************************
     * Other data
     ***************************************************/

    DDS_ReturnCode_t return_code = DDS_RETCODE_OK;
    unsigned long packets_written = 0L;
    double bytes_written = 0.0;
    double delta_time = 0.0;
    double publisher_throughput = 0.0;
   
    /*for CPU usage*/ 
    PerfMon app_monitor;
    
    /* We use a manager to handle all of the timing */
    TimeManager time_manager;
    int i, load;
    DDS_Boolean test_complete = DDS_BOOLEAN_FALSE;
    DDS_Boolean large_data = DDS_BOOLEAN_FALSE;
    DDSDataWriter * writer;
    DDS_Boolean use_multicast = DDS_BOOLEAN_FALSE;
    DDSFlowController *flow_controller = NULL;
    DDS_FlowControllerProperty_t flow_controller_property;
    DDS_Long max_gather_send_buffers = 0;
    DDS_Long samples_per_trigger = 0;
    char *locator = NULL;
    int current_load;
    float appCpuLoad;
    DDS_Duration_t ack_wait_time = {60, 0}; /* 1 minute */
    DDS_Duration_t recovery_time = 
	{0, NANOSEC_PER_MILLISEC * args.recovery_time_msec};

    set_logger_verbosity(args.ndds_verbosity);

    /* Check if requested data size exceeds transport's maximum message size */
    if (args.packet_size >= MESSAGE_SIZE_MAX) {
	AppLog_warn("requested data size exceeds maximum message size of the "
		    "transport, using fragmentation...\n");
        large_data = DDS_BOOLEAN_TRUE;
    }

    factory = DDSDomainParticipantFactory::get_instance();
    if (factory == NULL) {
        AppLog_exception("Error in getting a participant factory\n");
        return 0;
    }

    /* Configure the Factory Quality of Service */
    return_code = configure_factory_qos(factory_qos, factory);
    if (return_code != DDS_RETCODE_OK) {
        return 0;
    }

    /* Configure participant Quality of Service */
    return_code = configure_publisher_participant_qos(participant_qos,
                                                      factory, args);
    if (return_code != DDS_RETCODE_OK) {
        return 0;
    }

    /* Now we can create the 'disabled' participant. */
    participant = factory->create_participant(
        args.ndds_domain, participant_qos, NULL, DDS_STATUS_MASK_NONE);
    if (participant == NULL) {
        AppLog_exception("Error in creating Domain Participant\n");
        return publisher_shutdown(participant);
    }

    locator = DDS_String_alloc(MAX_PEER_LOCATOR_STR_LEN);
    if (locator == NULL) {
        AppLog_exception("Error in creating interface string for "
                         "test network\n");
        return_code = DDS_RETCODE_ERROR;
        return return_code;
    }

    /* Configure the participant transport */
    return_code = configure_publisher_participant_transport(
        max_gather_send_buffers, participant, args, &locator);
    if (return_code != DDS_RETCODE_OK) {
        return publisher_shutdown(participant);
    }

    /* Now we are free to enable the participant */
    return_code = participant->enable();
    if (return_code != DDS_RETCODE_OK) {
        AppLog_exception("Error in enabling the domain participant\n");
        return publisher_shutdown(participant);
    }

    /* Create the rest of the entities */
    if (large_data || args.asynchronous) {
        /* Configure flow controller Quality of Service */
        return_code = configure_flow_controller_property(
            flow_controller_property, participant, args, large_data);
        if (return_code != DDS_RETCODE_OK) {
            AppLog_exception("Error in configuring flow controller "
                             "properties\n");
            return publisher_shutdown(participant);
        }
        /* Create flowcontroller */
        flow_controller = participant->create_flowcontroller(
            "throughput test flow_controller", flow_controller_property);
        if (flow_controller == NULL) {
            AppLog_exception("Error in creating flow controller\n");
            return publisher_shutdown(participant);
        }
    }

    participant->get_default_publisher_qos(publisher_qos);
    publisher_qos.asynchronous_publisher.thread.priority =
        RTI_OSAPI_THREAD_PRIORITY_HIGH;

    /* And create the publisher with new QoS */
    publisher = participant->create_publisher(publisher_qos, NULL,
                                              DDS_STATUS_MASK_NONE);
    if (publisher == NULL) {
        AppLog_exception("Error in creating Publisher\n");
        return publisher_shutdown(participant);
    }

    /***********************************************************************
     * Set up Throughput topic and writer.
     ***********************************************************************/

    /* Now we register the data topic type with the participant. */
    return_code = ThroughputTypeSupport::register_type(
    participant, ThroughputTYPENAME);
    if (return_code != DDS_RETCODE_OK) {
        AppLog_exception("Error in registering %s\n", ThroughputTYPENAME);
        return publisher_shutdown(participant);
    }

    /* Get the default QoS for the Topic */
    participant->get_default_topic_qos(throughput_qos);
    /* We need exclusive ownership of this Topic so... */
    throughput_qos.ownership.kind = DDS_EXCLUSIVE_OWNERSHIP_QOS;

    /* And create a Topic with Default QoS and default listener.
       Note: Ownership is Shared by default. */
    throughput_topic = participant->create_topic(
        "Throughput", ThroughputTYPENAME, throughput_qos, NULL, 
        DDS_STATUS_MASK_NONE);
    if (throughput_topic == NULL) {
        AppLog_exception("Error in creating data Topic\n");
        return publisher_shutdown(participant);
    }

    /* set up user data */
    throughput_instance = ThroughputTypeSupport::create_data();
    if (throughput_instance == NULL) {
        AppLog_exception("Error in creating Data Instance\n");
        return publisher_shutdown(participant);
    }

    /* Configure throughput writer Quality of service */
    return_code = configure_throughput_writer_qos(
        throughput_writer_qos, &samples_per_trigger, large_data, use_multicast,
        max_gather_send_buffers, publisher, args);
    if (return_code != DDS_RETCODE_OK) {
        return publisher_shutdown(participant);
    }

    writer = publisher->create_datawriter(
        throughput_topic, throughput_writer_qos, NULL, DDS_STATUS_MASK_NONE);
    if (writer == NULL) {
        AppLog_exception("Error in creating Data Writer\n");
        return publisher_shutdown(participant);
    }
    throughput_writer = ThroughputDataWriter::narrow(writer);
    if (throughput_writer == NULL) {
        AppLog_exception("Error in narrowing Data Writer\n");
        /* Ensure we clean up properly */
        throughput_writer = (ThroughputDataWriter *)writer;
        return publisher_shutdown(participant);
    }
    /* Register Topic instance with data writer.
       Note: because we are not using keys this will return DDS_HANDLE_NIL
    */
    if (args.mi_instance_count > 0) {
        instance_handle_array = (DDS_InstanceHandle_t*)calloc(
            args.mi_instance_count, sizeof(DDS_InstanceHandle_t));
        for (i = 0; i < args.mi_instance_count; ++i) {
            throughput_instance->key = i;
            instance_handle_array[i] = throughput_writer->register_instance(
                *throughput_instance);
        }
    }

    /************************************************************************
     * Set up Command topic and writer.
     *************************************************************************/

    /* Now we register the command topic type with the participant */
    return_code = ThroughputCommandTypeSupport::register_type(
        participant, ThroughputCommandTYPENAME);
    if (return_code != DDS_RETCODE_OK) {
        AppLog_exception("Error in registering Throughput Command Packet\n");
        return publisher_shutdown(participant);
    }
    /* and create the command topic and writer */
    participant->get_default_topic_qos(throughput_command_qos);
    /* We need exclusive ownership of this Topic so... */
    throughput_command_qos.ownership.kind = DDS_EXCLUSIVE_OWNERSHIP_QOS;
    /* And create a Topic with Default QoS and default listener.
       Note Ownership is Shared by default. */
    throughput_command_topic = participant->create_topic(
        "ThroughputCommand", ThroughputCommandTYPENAME,
        throughput_command_qos, NULL, DDS_STATUS_MASK_NONE);
    if (throughput_command_topic == NULL) {
        AppLog_exception("Error in creating Command Topic\n");
        return publisher_shutdown(participant);
    }

    /* Configure command writer Quality of Service */
    return_code = configure_command_writer_qos(
        throughput_command_writer_qos, publisher, args);
    if (return_code != DDS_RETCODE_OK) {
        AppLog_exception("Error in configuring command writer qos\n");
        return publisher_shutdown(participant);
    }

    /*Create command writer */
    writer = publisher->create_datawriter(
        throughput_command_topic, throughput_command_writer_qos, NULL, 
        DDS_STATUS_MASK_NONE);
    if (writer == NULL) {
        AppLog_exception("Error in creating Command Writer\n");
        return publisher_shutdown(participant);
    }
    throughput_command_writer = ThroughputCommandDataWriter::narrow(writer);
    /* create and enable writer */
    if (throughput_command_writer == NULL) {
        AppLog_exception("Error in narrowing Command Writer\n");
        /* Ensure we clean up properly */
        throughput_command_writer = (ThroughputCommandDataWriter*)writer;
        return publisher_shutdown(participant);
    }

    /* and create an initialized instance of command topic */
    throughput_command_instance = ThroughputCommandTypeSupport::create_data();
    if (throughput_command_instance == NULL) {
        AppLog_exception("Error in creating Command Instance\n");
        return publisher_shutdown(participant);
    }

    /*************************************************************************
     * Start test
     ************************************************************************/

    /* Initialize the timer for the test */
    if (!time_manager.initialize(args.test_duration_sec)) {    
        AppLog_exception("Error in initializing time manager\n");
        return publisher_shutdown(participant);
    }

    if (!time_manager.calculate_clock_overhead()) {    
        AppLog_exception("Error in calculating clock overhead\n");
        return publisher_shutdown(participant);
    }

    /* Ensure we are sending the correct packet size */
    if (!throughput_instance->data.length(args.packet_size)) {
        AppLog_exception("Error in setting correct data packet length\n");
    }

    AppLog_report("Starting test...\n");
    if (args.test_verbosity>= TEST_VERBOSITY_MESSAGES) {
        AppLog_report("with the following parameters...\n");
        args.print_arguments();
    }

    /* Wait until we have all subscribers matching command topics
       and data topics */
    do {
        return_code = 
            throughput_writer->get_publication_matched_status(
                throughput_writer_status);
        if (return_code != DDS_RETCODE_OK) {
            AppLog_exception("Error in get_publication_matched_status\n");
            return publisher_shutdown(participant);
        }
        return_code =
            throughput_command_writer->get_publication_matched_status(
                throughput_command_writer_status);
        if (return_code != DDS_RETCODE_OK) {
            AppLog_exception("Error in get_publication_matched_status\n");
            return publisher_shutdown(participant);
        }
        time_manager.sleep(twenty_millisec);
    } while ((throughput_writer_status.current_count <
              args.subscribers ) ||
             (throughput_command_writer_status.current_count <
              args.subscribers));

    AppLog_report(" bytes, demand,  samples, sample/s,  Mbit/s, duration, CPU %%, memory\n"
                  "------, ------, --------, --------, -------, --------, -----, ------\n");
    fflush(stdout);

    /* Allow time for subscribers to initialise */
    time_manager.sleep(one_second);

    for (load = args.demand_initial;
         load <= args.demand_max;
         load += args.demand_increment) {

        test_complete = DDS_BOOLEAN_FALSE;

        /* Set up initial Data */
        throughput_instance->sequence_number = 0;

        /* Setup command */
        throughput_command_instance->signature[0] = 0x43; /* signature */
        throughput_command_instance->signature[1] = 0x21;
        throughput_command_instance->signature[2] = 0x43;
        throughput_command_instance->signature[3] = 0x21;

        throughput_command_instance->command = THROUGHPUT_COMMAND_START;
        throughput_command_instance->data_length = args.packet_size;
        throughput_command_instance->current_publisher_effort = load;
        throughput_command_instance->final_publisher_effort = args.demand_max;

        return_code = 
            throughput_command_writer->write(*throughput_command_instance, 
                                             nil_instance_handle);
        if (return_code != DDS_RETCODE_OK) {
            AppLog_exception("\nCommand writer error, "
                             "TEST_START_COMMAND not issued!\n");
        }

        return_code = 
            throughput_command_writer->wait_for_acknowledgments(ack_wait_time);
        if (return_code != DDS_RETCODE_OK) {
            AppLog_exception("\nCommand writer error, "
                             "TEST_START_COMMAND not acknowledged!\n");
        }

        appCpuLoad = app_monitor.getCpu();

        if (!time_manager.get_start_time()) {
            AppLog_exception("Error in getting Start Time. "
                             "Results may not be accurate\n");
            return publisher_shutdown(participant);
        }
         while (!test_complete) {
            for (current_load = 0;
                current_load < load && !test_complete;
                ++current_load, ++throughput_instance->sequence_number) {
                if (args.mi_instance_count > 0) {
                    instance_handle = &instance_handle_array[instance_index];
                    instance_index = /* for the next round */
                        (instance_index + 1) % args.mi_instance_count;
                }

                return_code = throughput_writer->
                    write(*throughput_instance, *instance_handle);
                if (return_code != DDS_RETCODE_OK) {
                    if (return_code  == DDS_RETCODE_TIMEOUT) {
                        AppLog_exception("\nWrite Timeout please increase "
                                         "-maxBlockingTime parameter for "
                                         "test\n");
                        time_manager.sleep(ten_millisec);
                        --throughput_instance->sequence_number;
                        /* expected case so write the same packet again */
                    } else {
                        AppLog_exception("\nError while writing\n");
                        test_complete = DDS_BOOLEAN_TRUE;
                        break;
                    }
                }
                if (args.asynchronous && !large_data) {
                    /* Once all gather send buffers are used up, we cannot
                       coalesce any further samples,so send the message now. */
                    if (throughput_instance->sequence_number %
                        samples_per_trigger == 0) {
                        flow_controller->trigger_flow();
                    }
                }
            }
            test_complete = time_manager.is_test_complete();

            if (!test_complete) {
                time_manager.sleep (recovery_time);
            }
        }
        /* make sure all asynchronous data was sent
           before sending stop command */
        if (args.asynchronous || large_data) {
            flow_controller->trigger_flow();
            throughput_writer->wait_for_asynchronous_publishing(three_second);
        }

        appCpuLoad = app_monitor.getCpu();
        throughput_command_instance->publisher_cpu_usage = 
            (DDS_Float)appCpuLoad;

        throughput_command_instance->command = THROUGHPUT_COMMAND_COMPLETE;
        return_code = throughput_command_writer->
            write(*throughput_command_instance, nil_instance_handle);
        if (return_code != DDS_RETCODE_OK) {
            AppLog_exception("\nCommand writer error, "
                             "TEST_COMPLETE_COMMAND not issued!\n");
        }

        return_code = 
            throughput_command_writer->wait_for_acknowledgments(ack_wait_time);
        if (return_code != DDS_RETCODE_OK) {
            AppLog_exception("\nCommand writer error, "
                             "TEST_COMPLETE_COMMAND not acknowledged!\n");
        }

        if (!time_manager.get_stop_time()) {
            AppLog_exception("Error in getting Stop Time. "
                             "Results may not be accurate\n");
            return publisher_shutdown(participant);
        }
        delta_time = time_manager.get_delta_time();

        packets_written = throughput_instance->sequence_number;
        bytes_written = ((double)packets_written * 
            (THROUGHPUT_PACKET_OVERHEAD + args.packet_size));
        if (delta_time > 0) {
            publisher_throughput = ((8.0 * (double)bytes_written/delta_time) /
                       1000000.0);
        }

        AppLog_report("%6d, %6d, %8lu, %8.1f, %7.1f, %8.2f, %5.2f, %6.1f\n",
                      (args.packet_size + THROUGHPUT_PACKET_OVERHEAD),
                      load,
                      packets_written,
                      (float)packets_written/delta_time,
                      publisher_throughput,
                      delta_time,
                      throughput_command_instance->publisher_cpu_usage,
                      (float)app_monitor.getMemory()/(1024.0 * 1024.0));
	fflush(stdout);

        /* Let subscriber poll for COMPLETE command */
        time_manager.sleep(one_second);

        /* Let subscriber receive remaining of data */
        time_manager.sleep(three_second);

    } /* for (load < maxLoad) */

    AppLog_report("Test Completed.\n");

    publisher_shutdown(participant);

    ThroughputCommandTypeSupport::delete_data(throughput_command_instance);
    ThroughputTypeSupport::delete_data(throughput_instance);

    DDS_String_free(locator);

    return return_code;
}

#if defined(RTI_WINCE)
int wmain(int argc, wchar_t **argv)
{
    char arg_array[MAX_COMMAND_LINE_ARGUMENTS][MAX_COMMAND_EXEC_LEN];
    char *argv_c[MAX_COMMAND_LINE_ARGUMENTS];
    int i;

    for (i = 0; i < argc; ++i) {
        wcstombs(arg_array[i], argv[i], wcslen(argv[i]) + 1);
        arg_array[i][wcslen(argv[i])] = '\0';
        argv_c[i] = &arg_array[i][0];
    }
    argv_c[argc] = '\0';

    ThroughputPublisherArgs *args;
    if(argc <= 1){
	args = new ThroughputPublisherArgs();
    } else {
        args = new ThroughputPublisherArgs(argc, argv_c);
    }

#elif !(defined(RTI_VXWORKS) && !defined(__RTP__)) && !defined(RTI_PSOS)
int main(int argc, char *argv[])
{
    ThroughputPublisherArgs *args;

    if(argc <= 1){
	args = new ThroughputPublisherArgs();
    } else { 
        args = new ThroughputPublisherArgs(argc, argv);
    }	
#elif defined(RTI_VXWORKS)
int publisher_main(void)
{
    ThroughputPublisherArgs *args = new ThroughputPublisherArgs();
#endif

    if (args->is_help_requested()) {
        args->usage();
	delete args;
        return -1;
    } else if (!args->is_valid()) {
        args->print_error();
	delete args;
        return -1;
    }
    
    int ret_value = publisher_test_throughput(*args); 
    delete args;
    return ret_value;
}

