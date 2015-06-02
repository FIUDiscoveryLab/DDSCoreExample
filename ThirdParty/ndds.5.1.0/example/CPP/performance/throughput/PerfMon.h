/*
 (c) Copyright, Real-Time Innovations, $Date: 2009/05/09 14:17:37 $.
 All rights reserved.
 No duplications, whole or partial, manual or electronic, may be made
 without express written permission.  Any such copies, or
 revisions thereof, must display this notice unaltered.
 This code contains trade secrets of Real-Time Innovations, Inc.
*/

#ifndef PerfMon_h
#define PerfMon_h
#ifdef RTI_WIN32
  #include <sys/timeb.h>
#endif
#include "osapi/osapi_type.h"

Peer class PerfMon {
  private:
    RTI_UINT32 _pid;
#ifdef RTI_LINUX
    int Cpu_tot;
    unsigned long long Hertz, prevtic;
    struct timeval oldtimev;

    struct {
        unsigned long long utime, stime; /* [jiffies] */
        unsigned long vsize; /* [bytes] */
    } mStat_process;

    struct NetDevStat {
        unsigned long byte_recv, packet_recv, err_recv, drop_recv, mcast_recv,
            byte_sent, packet_sent, err_sent, drop_sent, colls_sent;
    } mStatNetDev_current, mStatNetDev_initial;

#endif

  public:
    ~PerfMon();
    PerfMon();

    int isValid();
    float getCpu();
    unsigned long getMemory();

  private:
#ifdef RTI_LINUX
    RTIBool readProcStat();
#elif defined(RTI_WIN32)
    struct _timeb mTimebLast;
    __int64 mIKernelLast, mIUserLast;
#endif
};

#endif/*PerfMon_h*/
