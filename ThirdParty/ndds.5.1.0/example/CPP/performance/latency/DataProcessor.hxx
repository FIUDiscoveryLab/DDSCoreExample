/*
 (c) Copyright, Real-Time Innovations, $Date: 2009/05/09 14:17:28 $.
 All rights reserved.
 No duplications, whole or partial, manual or electronic, may be made
 without express written permission.  Any such copies, or
 revisions thereof, must display this notice unaltered.
 This code contains trade secrets of Real-Time Innovations, Inc.
*/

/*=======================================================================*/
#ifndef DataProcessor_hxx
#define DataProcessor_hxx

/* MAX_LATENCY_SLOTS
** Number of histogram bins to store count vs latency range. 
** Used to size LatencyDataProcessor::_latencySlot
** and LatencyDataProcessor::_histogram.
*/
#define MAX_LATENCY_SLOTS (20000)

/* PERCENTILE_COUNT
** Defines the values of the percentiles for which we want to compute 
** the latency. 
** The algorithm used requires that values in the PERCENTILE_POINTS
** are sorted in ascending order.
*/
#define PERCENTILE_COUNT   (4)

#define PERCENTILE_INDEX_50 (0)
#define PERCENTILE_INDEX_90 (1)
#define PERCENTILE_INDEX_99 (2)
#define PERCENTILE_INDEX_99_99 (3)

class LatencyDataProcessor {
  private:
    DDS_Long _sequence_number;
    DDS_Boolean _got_valid_echo;
    int _message_count;
    int _message_size;
    int _array_index;

    struct RTIClock *_clock;
    struct RTINtpTime _start_time, _finish_time, _recv_signaled_time;
    double _clock_overhead;

    double _min_roundtrip_time, _max_roundtrip_time;
    double _sigma_roundtrip_time, _sigma_roundtrip_time_squared;
    double _roundtrip_time_mean, _roundtrip_time_std;
    
    double _sigma_roundtrip_time_array[LATENCY_ROUND_MAX];
    double _sigma_roundtrip_time_squared_array[LATENCY_ROUND_MAX];
    int _message_size_array[LATENCY_ROUND_MAX];
    int _count_array[LATENCY_ROUND_MAX];
    int _roundtrip_time_len;

    /* array with _roundtripTimeLen elements */
    double *_roundtrip_time; 

    /* Array that keps sort order of _roundtripTime */
    double *_roundtrip_time_sorted;    

    /* array with _roundtripTimeLen elements */
    double *_roundtrip_time_timestamp; 

    int _latency_slot_count;
    double _latency_slot[MAX_LATENCY_SLOTS];
    int _histogram[MAX_LATENCY_SLOTS];
    double _latency_percentiles[PERCENTILE_COUNT];

  private:
    void compute_statistics();
    
  public:
    virtual ~LatencyDataProcessor();
    LatencyDataProcessor();
    DDS_Boolean calculate_clock_overhead();
    double clock_overhead() {return _clock_overhead;}
    DDS_Boolean initialize(struct RTIClock *clock, 
                           int roundtrip_array_len);
    void reset();
    DDS_Boolean start_one_issue();
    void finish_one_issue_recv_thread();
    void start_one_round(int message_size)
    {
        reset();
        _message_size = message_size;
        _sequence_number = 0;
    }
    void finish_one_round();
    int find_hist_slot(double latency, 
                       int low_slot, 
                       int high_slot, 
                       int slot_guess);
    void compute_latency_percentiles();
    DDS_Long get_sequence_number() {return _sequence_number;}
    DDS_Boolean echo_received();
    DDS_Boolean is_finished() {return _got_valid_echo;}
    /*** INTERNAL API: RTIOsapiSemaphoreXXX, RTINtpTime ***/
    RTIOsapiSemaphoreStatus wait(const struct RTINtpTime*);
};

#endif/*DataProcessor_hxx*/
