/*
 (c) Copyright, Real-Time Innovations, $Date: 2009/05/09 14:17:40 $.
 All rights reserved.
 No duplications, whole or partial, manual or electronic, may be made
 without express written permission.  Any such copies, or
 revisions thereof, must display this notice unaltered.
 This code contains trade secrets of Real-Time Innovations, Inc.
*/

#ifndef ThroughputQos_h
#define ThroughputQos_h

#include "ThroughputTransport.h"
#include "Throughput.h"

DDS_ReturnCode_t configure_factory_qos(
    DDS_DomainParticipantFactoryQos &factory_qos,
    DDSDomainParticipantFactory *factory);

DDS_ReturnCode_t configure_publisher_participant_qos(
    DDS_DomainParticipantQos &participant_qos,
    DDSDomainParticipantFactory *factory, ThroughputPublisherArgs &args);

DDS_ReturnCode_t configure_subscriber_participant_qos(
    DDS_DomainParticipantQos &participant_qos,
    DDSDomainParticipantFactory *factory, ThroughputSubscriberArgs &args);

DDS_ReturnCode_t configure_throughput_writer_qos(
    DDS_DataWriterQos &throughput_writer_qos,
    DDS_Long *samples_per_trigger, DDS_Boolean large_data,
    DDS_Boolean use_multicast, DDS_Long max_gather_send_buffers,
    DDSPublisher *publisher, ThroughputPublisherArgs &args);

DDS_ReturnCode_t configure_throughput_reader_qos(
    DDS_DataReaderQos &throughput_reader_qos, DDSSubscriber *subscriber,
    ThroughputSubscriberArgs &args);


DDS_ReturnCode_t configure_command_reader_qos(
    DDS_DataReaderQos &throughput_command_reader_qos, 
    DDSSubscriber *subscriber);

DDS_ReturnCode_t configure_command_writer_qos(
    DDS_DataWriterQos &throughput_command_writer_qos, 
    DDSPublisher *publisher, ThroughputPublisherArgs &args);

#endif /* ThroughputQos_h */
