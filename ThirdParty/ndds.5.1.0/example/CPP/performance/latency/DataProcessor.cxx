/*
 (c) Copyright, Real-Time Innovations, $Date: 2011/12/06 05:38:53 $.
 All rights reserved.
 No duplications, whole or partial, manual or electronic, may be made
 without express written permission.  Any such copies, or
 revisions thereof, must display this notice unaltered.
 This code contains trade secrets of Real-Time Innovations, Inc.
*/

/*=======================================================================*/

#include <math.h> 

/*** INTERNAL API: OSAPI, CDR, CLOCK Headers ***/
#include "osapi/osapi_ntptime.h"
#include "cdr/cdr_type.h"
#include "clock/clock_highResolution.h"

#include "LatencyGlobalSettings.hxx"
#include "DataProcessor.hxx"

const double PERCENTILE_POINTS[PERCENTILE_COUNT] = 
    {0.5f, 0.90f, 0.99f, 0.9999f};

/* ---------------------------------------------------------------------*/
LatencyDataProcessor::~LatencyDataProcessor() {

    if (_roundtrip_time != NULL) {
        free(_roundtrip_time);
    }

    if (_roundtrip_time_timestamp != NULL) {
        free(_roundtrip_time_timestamp);
    }

    if (_roundtrip_time_sorted != NULL) {
        free(_roundtrip_time_sorted);
    }
}

/* ---------------------------------------------------------------------*/
LatencyDataProcessor::LatencyDataProcessor()
    : _array_index(0),
      _clock(NULL)
{
    int latency, count;

    count = 0;
    for (latency = 0; latency < 200; ++latency) {
        _latency_slot[count++] = (double)latency;
    }
    for (latency = 200; latency < 1000; latency += (latency/100)) {
        latency -= (latency%2);
        _latency_slot[count++] = (double)((int)latency);
    }
    for (latency = 1000; latency < 10000; latency += (latency/100)) {
        latency -= (latency%10);
        _latency_slot[count++] = (double)((int)latency);
    }
    for (latency = 10000; latency < 100000; latency += (latency/100)) {
        latency -= (latency%100);
        _latency_slot[count++] = (double)((int)latency);
    }
    for (latency = 100000; latency < 1000000; latency += (latency/100)) {
        latency -= (latency%1000);
        _latency_slot[count++] = (double)((int)latency);
    }
    _latency_slot[count] = 1e9;
    
    if (count >= MAX_LATENCY_SLOTS) {
        AppLog_exception("configuration error. "
            "Please increase MAX_LATENCY_SLOTS to at least %d\n", count + 1);
    }

    _latency_slot_count = count;
}

/* ---------------------------------------------------------------------*/
int LatencyDataProcessor::find_hist_slot(double latency, 
                                         int low_slot, 
                                         int high_slot, 
                                         int slot_guess)
{
    if (_latency_slot[slot_guess] <= latency) {
        if (_latency_slot[slot_guess + 1] > latency) {
            return slot_guess;
        } else {
            return find_hist_slot(latency, 
                                  slot_guess + 1, 
                                  high_slot,
                                  (slot_guess + high_slot) / 2);
        }
    } else {
        if (_latency_slot[slot_guess - 1] <= latency) {
            return (slot_guess - 1);
        } else {
            return find_hist_slot(latency, 
                                  low_slot, 
                                  slot_guess, 
                                  (low_slot + slot_guess) / 2);
        }   
    }
    AppLog_exception("*** Error in find_hist_slot\n");
    return -1;
}

#if USE_QSORT
static int compare_two_doubles(const void *double1, const void *double2)
{
    return ((*(double *)double1) >= (*(double *)double2));
}
#endif

/* ---------------------------------------------------------------------*/
void LatencyDataProcessor::compute_latency_percentiles()
{
    int slot;
    int cumulative_count = 0;
    int percentile_index;

 /* Define to use quicksort for sorting statistics.
 ** Note that not using quicksort is likely to be more stable.
 */
#if USE_QSORT 
    AppLog_warn("starting qsort()\n");
    qsort(_roundtrip_time_sorted, _roundtrip_time_len, 
          sizeof(*_roundtrip_time_sorted), CompareTwoDoubles);
    AppLog_warn("ending qsort()\n");

    percentile_index = (int)(double)(0.5*_roundtrip_time_len);
    _latency_percentiles[PERCENTILE_INDEX_50] = 
        _roundtrip_time_sorted[percentile_index];
    percentile_index = (int)(double)(0.9*_roundtrip_time_len);
    _latency_percentiles[PERCENTILE_INDEX_90] =
        _roundtrip_time_sorted[percentile_index];
    percentile_index = (int)(double)(0.99*_roundtrip_time_len);
    _latency_percentiles[PERCENTILE_INDEX_99] =
        _roundtrip_time_sorted[percentile_index];
    percentile_index = (int)(double)(0.9999*_roundtrip_time_len);
    _latency_percentiles[PERCENTILE_INDEX_99_99] = 
        _roundtrip_time_sorted[percentile_index];
#else

    for (slot = 0, percentile_index = 0; slot < _latency_slot_count; ++slot) {
        cumulative_count += _histogram[slot];
        while ((percentile_index < PERCENTILE_COUNT) && 
               (cumulative_count >= 
                    _message_count * PERCENTILE_POINTS[percentile_index])) {
            _latency_percentiles[percentile_index] = _latency_slot[slot];
            ++percentile_index;   
        }
    }
#endif
}

/* ---------------------------------------------------------------------*/
DDS_Boolean LatencyDataProcessor::calculate_clock_overhead() 
{
    int i = 0;

    /*** INTERNAL API: RTINtpTime ***/
    struct RTINtpTime begin_time = RTI_NTP_TIME_ZERO,
        clock_roundtrip_time = RTI_NTP_TIME_ZERO;

    if (!_clock->reset(_clock)) {
        return DDS_BOOLEAN_FALSE;
    }
    if (!_clock->getTime(_clock, &begin_time)) {
        return DDS_BOOLEAN_FALSE;
    }
    for (i = 0; i < NUM_OF_LOOPS_CLOCK; ++i) {
        if (!_clock->getTime(_clock, &clock_roundtrip_time)) {
            return DDS_BOOLEAN_FALSE;
        }
    }
    RTINtpTime_decrement(clock_roundtrip_time, begin_time);
    _clock_overhead = 1E6 * RTINtpTime_toDouble(&clock_roundtrip_time) /
        (double)NUM_OF_LOOPS_CLOCK;

    return DDS_BOOLEAN_TRUE;
}

/* ---------------------------------------------------------------------*/
DDS_Boolean LatencyDataProcessor::initialize(struct RTIClock *clock, 
                                             int roundtrip_array_len) 
{
    _clock = clock;
    reset();
    _roundtrip_time_len = roundtrip_array_len;
    _roundtrip_time = (double *)calloc(roundtrip_array_len, 
                                       sizeof(double));
    _roundtrip_time_timestamp = (double *)calloc(roundtrip_array_len, 
                                                 sizeof(double));
    _roundtrip_time_sorted = (double *)calloc(roundtrip_array_len, 
                                              sizeof(double));
    return DDS_BOOLEAN_TRUE;
}

/* ---------------------------------------------------------------------*/
DDS_Boolean LatencyDataProcessor::echo_received() 
{ /* stop timer */
    _clock->getTime(_clock, &_finish_time); 
    return DDS_BOOLEAN_TRUE;
}


/* ---------------------------------------------------------------------*/
DDS_Boolean LatencyDataProcessor::start_one_issue() 
{ /* start timer */
    _got_valid_echo = DDS_BOOLEAN_FALSE;

    return _clock->reset(_clock) && _clock->getTime(_clock, &_start_time);
}

/* ---------------------------------------------------------------------*/
void LatencyDataProcessor::reset() 
{ /* start one new round (messageSize) */
    int slot;

    /*** INTERNAL API: RTINtpTime_XXX ***/
    RTINtpTime_setZero(&_start_time);
    RTINtpTime_setZero(&_finish_time);
    RTINtpTime_setZero(&_recv_signaled_time);
    _got_valid_echo = DDS_BOOLEAN_FALSE;
    _message_count = -1;
    _message_size = 4;
    _sigma_roundtrip_time = 0.0;
    _sigma_roundtrip_time_squared = 0.0;
    _min_roundtrip_time = 1e6;
    _max_roundtrip_time = 0;
    for (slot = 0; slot < _latency_slot_count; ++slot) {
        _histogram[slot] = 0;
    }
}

/* ---------------------------------------------------------------------*/
void LatencyDataProcessor::finish_one_issue_recv_thread() {

    /*** INTERNAL API: RTINtpTime ***/
    RTINtpTime roundtrip = {0, 0};
    double roundtrip_in_double = 0.0;

    ++_sequence_number; /* always increase the next sequence number */

    /* drop the first result since we do lazy alloc */
    if (_message_count >= 0) { 
    
        /* The total roundtrip time */
        RTINtpTime_subtract(roundtrip, _finish_time, _start_time);
        roundtrip_in_double = 
            1E6 * RTINtpTime_toDouble(&roundtrip) - _clock_overhead;
        if (roundtrip_in_double <= 0) {
        AppLog_exception("roundtrip time <= 0\n");
        }
     
        if (  roundtrip_in_double < _min_roundtrip_time ) {
        _min_roundtrip_time = roundtrip_in_double;
        }
        if (  roundtrip_in_double > _max_roundtrip_time ) {
        _max_roundtrip_time = roundtrip_in_double;
        }
    
        _roundtrip_time[_message_count] = roundtrip_in_double;
        _roundtrip_time_sorted[_message_count] = roundtrip_in_double;
        _roundtrip_time_timestamp[_message_count] = 
            RTINtpTime_toDouble(&_start_time);
        _sigma_roundtrip_time += roundtrip_in_double;
        _sigma_roundtrip_time_squared += 
            (roundtrip_in_double * roundtrip_in_double);
    }
 
    ++_message_count;
    _got_valid_echo = DDS_BOOLEAN_TRUE;
}

/* ---------------------------------------------------------------------*/
void LatencyDataProcessor::compute_statistics()
{ 
    int i, slot;

    double time_ave = _sigma_roundtrip_time / (double)_message_count;
    
    _roundtrip_time_mean = time_ave;
    _roundtrip_time_std  = sqrt(
        (_sigma_roundtrip_time_squared / (double)_message_count) -
        (time_ave * time_ave));

    /* Compute latency_50_percentile, latency_99_percentile and 
     * latency_99.99_percentile.
     * In general of a value P of the percentile latency_P_percentile is the
     * value of the latency such that P% of the samples verify:
     *    latency <= latency_P_percentile.
     * For example latency_50_percentile is the median i.e. 50% of the 
     * samples have latency <= latency_50_percentile 
     */
    /* There are two ways to compute the percentiles. The most direct one
     * would be to sort all the samples, but this is an O(Nlog(N)) operation
     * A more efficient approach is to use the histogram bins which
     * we need for the output and is an O(N) operation and although not exact
     * gives the resolution of one bin.
     */
    for (i = 0; i < _message_count; ++i) {
        slot = find_hist_slot(_roundtrip_time[i],
                              0, _latency_slot_count, _latency_slot_count / 2);
        _histogram[slot]++;
    }
    
    compute_latency_percentiles();   
}

/* ---------------------------------------------------------------------*/
void LatencyDataProcessor::finish_one_round()
{ 
    /* Must compute before printing/writing any results */    
    compute_statistics();
        
    /* print out result */
    AppLog_report("%6d,%7.1f,%7.1f,%7.1f,%7.1f,%7.1f,%7.1f,%7.1f,%7.1f\n",
                  _message_size, 
                  _roundtrip_time_std, _roundtrip_time_mean,
                  _min_roundtrip_time,
                  _latency_percentiles[PERCENTILE_INDEX_50],
                  _latency_percentiles[PERCENTILE_INDEX_90],
                  _latency_percentiles[PERCENTILE_INDEX_99],
                  _latency_percentiles[PERCENTILE_INDEX_99_99],
                  _max_roundtrip_time);
    AppLog_flush;
}
