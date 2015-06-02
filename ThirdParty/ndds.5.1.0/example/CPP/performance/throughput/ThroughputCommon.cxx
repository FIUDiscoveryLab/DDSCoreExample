/*
 (c) Copyright, Real-Time Innovations, $Date: 2009/05/09 14:17:39 $.
 All rights reserved.
 No duplications, whole or partial, manual or electronic, may be made
 without express written permission.  Any such copies, or
 revisions thereof, must display this notice unaltered.
 This code contains trade secrets of Real-Time Innovations, Inc.
*/

#include "ThroughputCommon.h"

const DDS_Duration_t ten_millisec = {0,NANOSEC_PER_MILLISEC * 10};
const DDS_Duration_t twenty_millisec = {0,NANOSEC_PER_MILLISEC * 20};
const DDS_Duration_t hundred_millisec = {0,NANOSEC_PER_MILLISEC * 100};
const DDS_Duration_t one_second = {1,0};
const DDS_Duration_t three_second = {3,0};

void set_logger_verbosity(int ndds_verbosity) {
    NDDSConfigLogger* logger = NDDSConfigLogger::get_instance();
    NDDS_Config_LogVerbosity verbosity;

    switch(ndds_verbosity) {
        case 0: verbosity = NDDS_CONFIG_LOG_VERBOSITY_SILENT;
            break;
        case 1: verbosity = NDDS_CONFIG_LOG_VERBOSITY_ERROR;
            break;
        case 2: verbosity = NDDS_CONFIG_LOG_VERBOSITY_WARNING;
            break;
        case 3: verbosity = NDDS_CONFIG_LOG_VERBOSITY_STATUS_LOCAL;
            break;
        case 4: verbosity = NDDS_CONFIG_LOG_VERBOSITY_STATUS_REMOTE;
            break;
        case 5: verbosity = NDDS_CONFIG_LOG_VERBOSITY_STATUS_ALL;
            break;
        default: verbosity = NDDS_CONFIG_LOG_VERBOSITY_ERROR;
    }
    logger->set_verbosity(verbosity);
}
