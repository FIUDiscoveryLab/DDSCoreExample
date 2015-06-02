/*
 (c) Copyright, Real-Time Innovations, $Date: 2009/05/09 14:17:41 $.
 All rights reserved.
 No duplications, whole or partial, manual or electronic, may be made
 without express written permission.  Any such copies, or
 revisions thereof, must display this notice unaltered.
 This code contains trade secrets of Real-Time Innovations, Inc.
*/

#ifndef ThroughputTransport_h
#define ThroughputTransport_h

#include "ThroughputArgs.h"
#include "ThroughputCommon.h"


DDS_ReturnCode_t configure_publisher_participant_transport(
    DDS_Long &max_gather_send_buffers, DDSDomainParticipant *participant,
    ThroughputPublisherArgs &args, char **locator);

DDS_ReturnCode_t configure_subscriber_participant_transport(
    DDSDomainParticipant *participant, ThroughputSubscriberArgs &args,
    char **locator);

DDS_ReturnCode_t configure_flow_controller_property(
    DDS_FlowControllerProperty_t &flow_controller_property, 
    DDSDomainParticipant *participant, ThroughputPublisherArgs &args,
    DDS_Boolean large_data);

#endif /* ThroughputTransport_h */
