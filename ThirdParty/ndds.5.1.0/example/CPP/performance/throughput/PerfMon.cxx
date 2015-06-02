/*
 (c) Copyright, Real-Time Innovations, $Date: 2011/12/06 05:38:53 $.
 All rights reserved.
 No duplications, whole or partial, manual or electronic, may be made
 without express written permission.  Any such copies, or
 revisions thereof, must display this notice unaltered.
 This code contains trade secrets of Real-Time Innovations, Inc.
*/

/*
To create and use an effective performance monitoring application:

   1. Decide which counters (i.e. processes, etc.) you wish to monitor.
   2. Decide which instances you wish to apply these counters to, if applicable.
   3. Decide upon application design issues, such as the duration of the
      monitoring and monitoring intervals.
   4. Write the code to do the monitoring, incorporating the following basic
      steps:
          * create a query
          * associate counters with the query
          * collect and process the data
          * close the query. 
   5. Run the application.
   6. Analyze the data. 
*/
#include <stdio.h>
#include "log/log_makeheader.h"
#include "log/log_common.h"
#include "osapi/osapi_process.h"
#include "osapi/osapi_utility.h"

#include "ThroughputArgs.h"
#include "PerfMon.h"
#include "ThroughputCommon.h"

#ifdef RTI_LINUX
  #include <stdio.h>
  #include <string.h>
  #include <errno.h>
  #include <sys/time.h>
  #include <unistd.h>
  #include <sys/types.h>
  #include <sys/stat.h>
  #include <fcntl.h>
  #include <asm/param.h> /* <elf.h> */

PerfMon::~PerfMon() {}

PerfMon::PerfMon()
    : Hertz(0)
{
    prevtic = 0;
    oldtimev.tv_sec = 0;
    oldtimev.tv_usec = 0;
#ifdef DIVIDE_BY_NUMBER_OF_PROCESSORS
    long smp_num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
    /* SPARC glibc is buggy */
    Cpu_tot = RTIOsapiUtility_max(smp_num_cpus, 1);
#endif

    _pid = RTIOsapiProcess_getId();
  #ifndef HZ
    #error "This code will not work"
  #endif
    Hertz = HZ;
    if (Hertz == 0) {
        AppLog_exception("sysconf(_SC_NPROCESSORS_ONLN) failed");
    }
    getCpu(); /*the first run; result will be garbage so just ignore */
}

int PerfMon::isValid() {
    return(Hertz);
};


RTIBool PerfMon::readProcStat()
{
    RTIBool ok = 0;
    int file = -1, bytesRead;
    char state;
    unsigned long garbage_ulong;
    int garbage_int;
    long garbage_long;
    unsigned long long cutime, cstime, garbage_longlong;
    int numScanned;
    char *S, *tmp, buf[1024], fname[40];
    const char* METHOD_NAME = "PerfMon::readProcStat";

    sprintf(fname, "/proc/%d/stat", _pid);
    file = open(fname, O_RDONLY, 0);
    if (file == -1) {
        AppLog_exception("failed to open %s", fname);
        goto fin;
    }
    
    bytesRead = read(file, buf, sizeof(buf) - 1);
    if (bytesRead <= 0) {
        AppLog_exception("%s read failed %d", METHOD_NAME, errno);
        goto fin;
    }

    buf[bytesRead] = 0; /* terminating NULL */

    /* look for the command name inside parenthesis */
    S = strchr(buf, '(') + 1;
    tmp = strrchr(S, ')');
    if (!S || !tmp) {
        AppLog_exception("%s strchr failed %d", METHOD_NAME, errno);
        goto fin;
    }

#ifdef UNNECESSARY
    num = tmp - S;
    if (unlikely(num >= sizeof P->cmd)) {
        num = sizeof P->cmd - 1;
    }
    memcpy(P->cmd, S, num);
    P->cmd[num] = '\0';
#endif
    S = tmp + 2; /* skip ") " */

    /* and the rest are just bunch of numbers, so just read them in */
    numScanned = sscanf(S,
               "%c "                                               /* 1 */
               "%d %d %d %d %d "                                   /* + 5 */
               "%lu %lu %lu %lu %lu "                              /* + 5 */
               "%Lu %Lu %Lu %Lu "  /* utime stime cutime cstime */ /* + 4 */
               "%ld %ld "                                          /* + 2 */
               "%d "                                               /* + 1 */
               "%ld "                                              /* + 1 */
               "%Lu " /* start_time */                             /* + 1 */
               "%lu " /* vsize */                                  /* + 1 */
               ,                                                   /* = 21 */
               &state,
               &garbage_int, &garbage_int, &garbage_int, &garbage_int,
               &garbage_int,
               &garbage_ulong, &garbage_ulong, &garbage_ulong, &garbage_ulong,
               &garbage_ulong,
               &mStat_process.utime, &mStat_process.stime, &cutime, &cstime,
               &garbage_long, &garbage_long,
               &garbage_int,
               &garbage_long,
               &garbage_longlong,/* start_time */
               &mStat_process.vsize); /* vsize [bytes] */
    if (numScanned != 21) {
        AppLog_exception("%s sscanf failed %d", METHOD_NAME, numScanned);
        goto fin;
    }

    ok = RTI_TRUE;
 fin:
    if (file != -1) {
        close(file);
    }
    return ok;
}

float PerfMon::getCpu() {
    float cpuUsed = -1.0f, et, Frame_tscale;
    struct timeval timev;
    unsigned long long tics = prevtic;
    unsigned long pcpu = 0;

    if (!readProcStat()) {
        AppLog_exception("failed to read /proc/[pid]/stat");
        goto fin;
    }

    tics = mStat_process.utime + mStat_process.stime;
    pcpu = tics - prevtic;

    /* TODO: use RDTSC to get a finer time resolution */
    prevtic = tics; /* save into history, so we can get the delta next time */

    gettimeofday(&timev, NULL); /* don't care about the timezone */
    et = /* means elapsed time, in [sec] */
        (timev.tv_sec - oldtimev.tv_sec)
        + (float)(timev.tv_usec - oldtimev.tv_usec) / 1000000.0;

    Frame_tscale = (et > 0.0f) ? 100.0f / ((float)Hertz * et /* * Cpu_tot */) : 1.0f;

    oldtimev = timev;

    cpuUsed = (float)pcpu * Frame_tscale;
    /*if (cpuUsed > 100.0f) cpuUsed = 100.0f;*/
 fin:
    return cpuUsed;
}

unsigned long PerfMon::getMemory() {

    if (!readProcStat()) {
        AppLog_exception("failed to read /proc/[pid]/stat");
        return 0;
    }
    return mStat_process.vsize;
}

#elif defined(RTI_WIN32)

#include <windows.h>

PerfMon::~PerfMon() {
}

PerfMon::PerfMon() {
    getCpu();
}

int PerfMon::isValid() {
    return 1;
}

float PerfMon::getCpu() {
    HANDLE pid = GetCurrentProcess();
    struct _timeb timebNow, timebElapsed;

    FILETIME createTime, exitTime;//don't actually care about these two quant
    FILETIME kernelTimeProcess, userTimeProcess;
    __int64 iKernelElapsed, iKernel, iUserElapsed, iUser;

    GetProcessTimes(pid, &createTime, &exitTime,
	&kernelTimeProcess, &userTimeProcess );
    _ftime(&timebNow);

    iKernel = ((__int64)kernelTimeProcess.dwHighDateTime << 32)
	    + kernelTimeProcess.dwLowDateTime;
    iUser = ((__int64)userTimeProcess.dwHighDateTime << 32)
	  + userTimeProcess.dwLowDateTime;

    iKernelElapsed = iKernel - mIKernelLast;
    iUserElapsed = iUser - mIUserLast;
    float fCpuTimeTaken = (float)(iKernelElapsed + iUserElapsed)
	/10000000.0f;//this tick in 100 nanosecond intervals in 1 second

    timebElapsed.time = timebNow.time - mTimebLast.time;
    int iMs = (int)timebNow.millitm - (int)mTimebLast.millitm;
    if(iMs >= 0) {
	timebElapsed.millitm = iMs;
    } else {
	timebElapsed.time--;
	timebElapsed.millitm = 1000 + iMs;
    }
    float fTimeElapsed = timebElapsed.time
	+ (float)timebElapsed.millitm/1000.0f;

    mTimebLast = timebNow;
    mIKernelLast = iKernel; mIUserLast = iUser;

    return 100.0f * fCpuTimeTaken / fTimeElapsed;
}

unsigned long PerfMon::getMemory() { return 0; }

#else

PerfMon::~PerfMon() {}
PerfMon::PerfMon() {}
int PerfMon::isValid() { return 1; }
float PerfMon::getCpu() { return 0.0f; }
unsigned long PerfMon::getMemory() { return 0; }

#endif

