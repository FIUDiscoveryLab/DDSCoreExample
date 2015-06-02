/*
 (c) Copyright, Real-Time Innovations, $Date: 2009/05/09 14:17:42 $.
 All rights reserved.
 No duplications, whole or partial, manual or electronic, may be made
 without express written permission.  Any such copies, or
 revisions thereof, must display this notice unaltered.
 This code contains trade secrets of Real-Time Innovations, Inc.
*/

#ifndef TimeManager_h
#define TimeManager_h

#include "ndds/ndds_cpp.h"
#include "clock/clock_highResolution.h"

#define THROUGHPUT_TEST_MAX_SLEEP_SEC 1 /* 1 Seconds */

#ifdef WIN32
  #define THROUGHPUT_TEST_DELAY_DECREMENT_NS 10000000 /* 10 Milliseconds */
#else /* For all other OS make resolution 1 ms */
  #define THROUGHPUT_TEST_DELAY_DECREMENT_NS 100000000 /* 1 Millisecond */
#endif

class TimeManager
{
private:
    struct RTIClock *_clock; /* A pointer to a high resolution clock */
    double _clock_overhead;
    
    struct RTINtpTime _start_time;
    struct RTINtpTime _finish_time;
    struct RTINtpTime _test_duration;
      
public:
    ~TimeManager() { if (_clock != NULL) RTIHighResolutionClock_delete(_clock); }
    TimeManager()  {_clock = NULL; }  
    DDS_Boolean initialize(int test_duration_sec);
    DDS_Boolean get_start_time();
    DDS_Boolean get_stop_time(); 
    
    DDS_Boolean calculate_clock_overhead();
    
    double get_delta_time();
    
    DDS_Boolean is_test_complete();
    
    void sleep(DDS_Duration_t time_to_sleep);
};

#endif

