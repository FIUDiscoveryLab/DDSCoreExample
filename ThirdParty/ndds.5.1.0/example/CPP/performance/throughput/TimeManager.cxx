/*
 (c) Copyright, Real-Time Innovations, $Date: 2009/05/09 14:17:42 $.
 All rights reserved.
 No duplications, whole or partial, manual or electronic, may be made
 without express written permission.  Any such copies, or
 revisions thereof, must display this notice unaltered.
 This code contains trade secrets of Real-Time Innovations, Inc.
*/

#include "ThroughputCommon.h"
#include "TimeManager.h"


DDS_Boolean TimeManager::initialize(int test_duration_sec)
{
    _test_duration.sec  = test_duration_sec;
    _test_duration.frac = 0;

    _clock = RTIHighResolutionClock_new();
   
    if (_clock != NULL) {
	return DDS_BOOLEAN_TRUE;
    } else {
	return DDS_BOOLEAN_FALSE;
    }
}


DDS_Boolean TimeManager::get_start_time()
{
    RTIBool return_value;
    _clock->reset(_clock);
    RTINtpTime_setZero(&_start_time);
    RTINtpTime_setZero(&_finish_time);
    return_value = _clock->getTime(_clock, &_start_time);
    if (return_value == RTI_TRUE) {
	return DDS_BOOLEAN_TRUE;
    } else {
	return DDS_BOOLEAN_FALSE;
    }
}

DDS_Boolean TimeManager::get_stop_time()
{
    RTIBool return_value;

    return_value = _clock->getTime(_clock, &_finish_time);
    if (return_value == RTI_TRUE) {
	return DDS_BOOLEAN_TRUE;
    } else {
	return DDS_BOOLEAN_FALSE;
    }
}

DDS_Boolean TimeManager::calculate_clock_overhead() 
{
    int i = 0;
    RTIBool ok = RTI_FALSE;

    struct RTINtpTime begin_time = RTI_NTP_TIME_ZERO, 
                      clock_traversal_time = RTI_NTP_TIME_ZERO;

    _clock->reset(_clock); 
    
    if (!_clock->getTime(_clock, &begin_time)) {
        AppLog_exception("***Error: failed to get time\n");
        goto finally;
    }
    
#define TIME_MANAGER_CALCULATION_LOOP_COUNT_MAX 100
    for (i = 0; i < TIME_MANAGER_CALCULATION_LOOP_COUNT_MAX; ++i) {
        if (!_clock->getTime(_clock, &clock_traversal_time)) {
            AppLog_exception("***Error: failed to get time\n");
            goto finally;
        }
    }
    
    RTINtpTime_decrement(clock_traversal_time, begin_time);
    
    _clock_overhead = RTINtpTime_toDouble(&clock_traversal_time)/
	(double)TIME_MANAGER_CALCULATION_LOOP_COUNT_MAX;
    ok = RTI_TRUE;

finally:

    if (ok == RTI_TRUE) {
	return DDS_BOOLEAN_TRUE;
    } else {
	return DDS_BOOLEAN_FALSE;
    }
}


double TimeManager::get_delta_time()
{
    struct RTINtpTime delta_time;
    double return_value;
    
    RTINtpTime_subtract(delta_time, _finish_time, _start_time);
    return_value = RTINtpTime_toDouble(&delta_time);
    return_value -= _clock_overhead;
    return return_value;
}

DDS_Boolean TimeManager::is_test_complete()
{
    struct RTINtpTime delta_time,time_now;
    double delta_time_double,duration_double;

    _clock->getTime(_clock, &time_now); 
    RTINtpTime_subtract(delta_time, time_now, _start_time);

    delta_time_double = RTINtpTime_toDouble(&delta_time);
    delta_time_double -= _clock_overhead;

    duration_double = RTINtpTime_toDouble(&_test_duration);
    if (delta_time_double >= duration_double) {
		return DDS_BOOLEAN_TRUE;
    } else {
	return DDS_BOOLEAN_FALSE;
    }
}

void TimeManager::sleep(DDS_Duration_t time_to_sleep)
{
    NDDSUtility::sleep(time_to_sleep);
}
