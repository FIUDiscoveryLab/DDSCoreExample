/*
 (c) Copyright, Real-Time Innovations, $Date: 2011/12/06 05:38:53 $.
 All rights reserved.
 No duplications, whole or partial, manual or electronic, may be made
 without express written permission.  Any such copies, or
 revisions thereof, must display this notice unaltered.
 This code contains trade secrets of Real-Time Innovations, Inc.
*/

#include "ThroughputTransport.h"
#include "Throughput.h"

DDS_ReturnCode_t configure_publisher_participant_transport(
    DDS_Long &max_gather_send_buffers,
    DDSDomainParticipant *participant,
    ThroughputPublisherArgs &args, char **locator) {    
    DDS_ReturnCode_t return_code = DDS_RETCODE_OK;
    /*****************************************************
     * Plug-in transport variables
     ****************************************************/
    struct NDDS_Transport_UDPv4_Property_t udpv4TransportProperty =
        NDDS_TRANSPORT_UDPV4_PROPERTY_DEFAULT;
#ifdef RTI_SHARED_MEMORY
    struct NDDS_Transport_Shmem_Property_t smemTransportProperty =
        NDDS_TRANSPORT_SHMEM_PROPERTY_DEFAULT;
#endif /* RTI_SHARED_MEMORY */
#ifdef RTI_IPV6
    struct NDDS_Transport_UDPv6_Property_t udpv6TransportProperty =
        NDDS_TRANSPORT_UDPV6_PROPERTY_DEFAULT;
#endif

    if (args.transport_to_use() & DDS_TRANSPORTBUILTIN_UDPv4) {
        /* Configure built in IPv4 transport to handle large messages */
        return_code = NDDSTransportSupport::get_builtin_transport_property(
              participant, DDS_TRANSPORTBUILTIN_UDPv4,
              (struct NDDS_Transport_Property_t&)udpv4TransportProperty);
        if (return_code != DDS_RETCODE_OK) {
            AppLog_exception("Error in getting built-in transport UDPv4 "
                             "property\n");
            return return_code;
        }

        udpv4TransportProperty.parent.message_size_max = UDP_SIZE_MAX;
        udpv4TransportProperty.send_socket_buffer_size = UDP_SOCKET_SEND_BUFFER_SIZE;
        udpv4TransportProperty.recv_socket_buffer_size = UDP_SOCKET_RECV_BUFFER_SIZE;

        udpv4TransportProperty.multicast_ttl = args.multicast_ttl;
        /* ONLY one interface permitted for test */

        if (args.get_ip_interface() != NULL) {
            sprintf(*locator, "%s", args.get_ip_interface());
            udpv4TransportProperty.parent.allow_interfaces_list_length = 1;
            udpv4TransportProperty.parent.allow_interfaces_list = locator;
        }

        return_code = NDDSTransportSupport::set_builtin_transport_property(
            participant,DDS_TRANSPORTBUILTIN_UDPv4,
            (struct NDDS_Transport_Property_t&)udpv4TransportProperty);
        if (return_code != DDS_RETCODE_OK) {
            AppLog_exception("Error in setting built-in transport UDPv4 "
                             "property\n");
            return return_code;
        }

        max_gather_send_buffers =
            udpv4TransportProperty.parent.gather_send_buffer_count_max;

#ifdef RTI_IPV6
    } else if (args.transport_to_use() & DDS_TRANSPORTBUILTIN_UDPv6) {
        /* Configure built in IPv6 transport to handle large messages */
        return_code = NDDSTransportSupport::get_builtin_transport_property(
            participant, DDS_TRANSPORTBUILTIN_UDPv6,
            (struct NDDS_Transport_Property_t&)udpv6TransportProperty);
        if (return_code != DDS_RETCODE_OK) {
            AppLog_exception("Error in getting built-in transport UDPv6 "
                             "property\n");
            return return_code;
        }

        udpv6TransportProperty.parent.message_size_max = UDP_SIZE_MAX; 
        udpv6TransportProperty.send_socket_buffer_size = UDP_SOCKET_SEND_BUFFER_SIZE;
        udpv6TransportProperty.recv_socket_buffer_size = UDP_SOCKET_RECV_BUFFER_SIZE;
        
	udpv6TransportProperty.multicast_ttl = args.multicast_ttl;

        if (args.get_ip_interface() != NULL) {
            sprintf(*locator, "%s", args.get_ip_interface());
            udpv6TransportProperty.parent.allow_interfaces_list_length = 1;
            udpv6TransportProperty.parent.allow_interfaces_list = locator;
        }

        return_code = NDDSTransportSupport::set_builtin_transport_property(
            participant,DDS_TRANSPORTBUILTIN_UDPv6,
            (struct NDDS_Transport_Property_t&)udpv6TransportProperty);
        if (return_code != DDS_RETCODE_OK) {
            AppLog_exception("Error in setting built-in transport UDPv6 "
                             "property\n");
            return return_code;
        }

        max_gather_send_buffers =
        udpv6TransportProperty.parent.gather_send_buffer_count_max;
#endif /* RTI_IPV6 */

#ifdef RTI_SHARED_MEMORY
    } else if (args.transport_to_use() & DDS_TRANSPORTBUILTIN_SHMEM) {
        /* Configure built in Shared Memory transport to
           handle large messages */
        return_code = NDDSTransportSupport::get_builtin_transport_property(
            participant, DDS_TRANSPORTBUILTIN_SHMEM,
            (struct NDDS_Transport_Property_t&)smemTransportProperty);
        if (return_code != DDS_RETCODE_OK) {
            AppLog_exception("Error in getting built-in transport "
                             "Shared Memory property\n");
            return return_code;
        }

        smemTransportProperty.parent.message_size_max = SHMEM_SIZE_MAX; 
        smemTransportProperty.receive_buffer_size =
		smemTransportProperty.parent.message_size_max * 4;

        return_code = NDDSTransportSupport::set_builtin_transport_property(
            participant,DDS_TRANSPORTBUILTIN_SHMEM,
            (struct NDDS_Transport_Property_t&)smemTransportProperty);
        if (return_code != DDS_RETCODE_OK) {
            AppLog_exception("Error in setting built-in transport "
                             "Shared Memory property\n");
            return return_code;
        }

        max_gather_send_buffers =
        smemTransportProperty.parent.gather_send_buffer_count_max;
#endif /* RTI_SHARED_MEMORY */
    }
    return return_code;
}


DDS_ReturnCode_t configure_subscriber_participant_transport(
    DDSDomainParticipant *participant,
    ThroughputSubscriberArgs &args, char **locator) {    
    DDS_ReturnCode_t return_code = DDS_RETCODE_OK;

    /*****************************************************
    * Plug-in transport variables
    ****************************************************/
    struct NDDS_Transport_UDPv4_Property_t udpv4TransportProperty =
        NDDS_TRANSPORT_UDPV4_PROPERTY_DEFAULT;
#ifdef RTI_SHARED_MEMORY
    struct NDDS_Transport_Shmem_Property_t smemTransportProperty =
        NDDS_TRANSPORT_SHMEM_PROPERTY_DEFAULT;
#endif/*RTI_SHARED_MEMORY*/
#ifdef RTI_IPV6
    struct NDDS_Transport_UDPv6_Property_t udpv6TransportProperty =
        NDDS_TRANSPORT_UDPV6_PROPERTY_DEFAULT;
#endif

    /* for raw xport performance measurement */
    Throughput recvInstance;

    if (args.transport_to_use() & DDS_TRANSPORTBUILTIN_UDPv4) {
        /* Configure built in IPv4 transport to handle large messages */
        return_code = NDDSTransportSupport::get_builtin_transport_property(
            participant, DDS_TRANSPORTBUILTIN_UDPv4,
            (struct NDDS_Transport_Property_t&)udpv4TransportProperty);
        if (return_code != DDS_RETCODE_OK) {
            AppLog_exception("Error in getting built-in transport "
                             "UDPv4 property\n");
            return return_code;
        }
        udpv4TransportProperty.parent.message_size_max = UDP_SIZE_MAX; 
        udpv4TransportProperty.send_socket_buffer_size = UDP_SOCKET_SEND_BUFFER_SIZE;
        udpv4TransportProperty.recv_socket_buffer_size = UDP_SOCKET_RECV_BUFFER_SIZE;

        if (args.get_ip_interface() != NULL) {
            sprintf(*locator,"%s",args.get_ip_interface());        
            udpv4TransportProperty.parent.allow_interfaces_list_length = 1;
            udpv4TransportProperty.parent.allow_interfaces_list = locator;
        }

        return_code = NDDSTransportSupport::set_builtin_transport_property(
           participant,DDS_TRANSPORTBUILTIN_UDPv4,
           (struct NDDS_Transport_Property_t &)udpv4TransportProperty);
        if (return_code != DDS_RETCODE_OK) {
            AppLog_exception("Error in setting built-in transport UDPv4 "
                             "property\n");
            return return_code;
        }
#ifdef RTI_IPV6
    } else if (args.transport_to_use() & DDS_TRANSPORTBUILTIN_UDPv6) {
        /* Configure built in IPv6 transport to handle large messages */
        return_code = NDDSTransportSupport::get_builtin_transport_property(
            participant, DDS_TRANSPORTBUILTIN_UDPv6,
            (struct NDDS_Transport_Property_t &)udpv6TransportProperty);
        if (return_code != DDS_RETCODE_OK) {
            AppLog_exception("Error in getting built-in transport "
                             "UDPv6 property\n");
            return return_code;
        }
        udpv6TransportProperty.parent.message_size_max = UDP_SIZE_MAX;
        udpv6TransportProperty.send_socket_buffer_size = UDP_SOCKET_SEND_BUFFER_SIZE;
        udpv6TransportProperty.recv_socket_buffer_size = UDP_SOCKET_RECV_BUFFER_SIZE;

        if (args.get_ip_interface() != NULL) {
            sprintf(*locator,"%s",args.get_ip_interface());
            udpv6TransportProperty.parent.allow_interfaces_list_length = 1;
            udpv6TransportProperty.parent.allow_interfaces_list = locator;
        }

        return_code = NDDSTransportSupport::set_builtin_transport_property(
           participant,DDS_TRANSPORTBUILTIN_UDPv6,
           (struct NDDS_Transport_Property_t&)udpv6TransportProperty);
        if (return_code != DDS_RETCODE_OK) {
            AppLog_exception("Error in setting built-in transport UDPv6 "
                             "property\n");
            return return_code;
        }
#endif
#ifdef RTI_SHARED_MEMORY
    } else if (args.transport_to_use() & DDS_TRANSPORTBUILTIN_SHMEM) {
        /* participant_qos->transport_builtin.mask |=
            DDS_TRANSPORTBUILTIN_SHMEM; */
        /* Configure built in Shared Memory transport to
           handle large messages */
        return_code = NDDSTransportSupport::get_builtin_transport_property(
            participant, DDS_TRANSPORTBUILTIN_SHMEM,
            (struct NDDS_Transport_Property_t&)smemTransportProperty);
        if (return_code != DDS_RETCODE_OK) {
            AppLog_exception("Error in getting built-in transport "
                             "Shared Memory property\n");
            return return_code;
        }

        smemTransportProperty.parent.message_size_max = SHMEM_SIZE_MAX; 
        smemTransportProperty.receive_buffer_size = 
		smemTransportProperty.parent.message_size_max * 4;
        
	smemTransportProperty.received_message_count_max = QUEUE_SIZE;

        return_code = NDDSTransportSupport::set_builtin_transport_property(
                    participant,DDS_TRANSPORTBUILTIN_SHMEM,
                    (struct NDDS_Transport_Property_t&)smemTransportProperty);
        if (return_code != DDS_RETCODE_OK) {
            AppLog_exception("Error in setting built-in transport "
                             "Shared Memory property\n");
            return return_code;
        }
#endif /* RTI_SHARED_MEMORY */
    }
    return return_code;
}

DDS_ReturnCode_t configure_flow_controller_property(
    DDS_FlowControllerProperty_t &flow_controller_property, 
    DDSDomainParticipant *participant, ThroughputPublisherArgs &args,
    DDS_Boolean large_data) {
    DDS_ReturnCode_t return_code = DDS_RETCODE_OK;

    return_code = participant->get_default_flowcontroller_property(
        flow_controller_property);
    if (return_code != DDS_RETCODE_OK) {
        AppLog_exception("Error in getting flow controller properties\n");
        return return_code;
    }

    /* Approach: send small bursts as fast as possible (as opposed to
       sending larger bursts, but slower) */
    if (large_data && args.bw_limit > 0) {
        flow_controller_property.token_bucket.tokens_added_per_period =
            (long)((float)args.bw_limit*1000000.0/8.0/100.0/1024.0);
    } else {
        flow_controller_property.token_bucket.tokens_added_per_period =
            DDS_LENGTH_UNLIMITED;
    }
    flow_controller_property.token_bucket.max_tokens = DDS_LENGTH_UNLIMITED;
    flow_controller_property.token_bucket.tokens_leaked_per_period =
        DDS_LENGTH_UNLIMITED;
    flow_controller_property.token_bucket.period = ten_millisec;
    flow_controller_property.token_bucket.bytes_per_token = 1024; 
    /* minimum value */

    return return_code;
}
