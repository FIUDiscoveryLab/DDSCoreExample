
/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from Latency.idl using "rtiddsgen".
  The rtiddsgen tool is part of the RTI Connext distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the RTI Connext manual.
*/

#ifndef LatencySupport_1496238403_h
#define LatencySupport_1496238403_h

/* Uses */
#include "Latency.h"



#ifdef __cplusplus
#ifndef ndds_cpp_h
  #include "ndds/ndds_cpp.h"
#endif
#else
#ifndef ndds_c_h
  #include "ndds/ndds_c.h"
#endif
#endif

        

/* ========================================================================= */
/**
   Uses:     T

   Defines:  TTypeSupport, TDataWriter, TDataReader

   Organized using the well-documented "Generics Pattern" for
   implementing generics in C and C++.
*/

#if (defined(RTI_WIN32) || defined (RTI_WINCE)) && defined(NDDS_USER_DLL_EXPORT)
  /* If the code is building on Windows, start exporting symbols.
  */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport __declspec(dllexport)
#endif

#ifdef __cplusplus

DDS_TYPESUPPORT_CPP(LatencyTypeSupport, Latency);

DDS_DATAWRITER_CPP(LatencyDataWriter, Latency);
DDS_DATAREADER_CPP(LatencyDataReader, LatencySeq, Latency);


#else

DDS_TYPESUPPORT_C(LatencyTypeSupport, Latency);
DDS_DATAWRITER_C(LatencyDataWriter, Latency);
DDS_DATAREADER_C(LatencyDataReader, LatencySeq, Latency);

#endif

#if (defined(RTI_WIN32) || defined (RTI_WINCE)) && defined(NDDS_USER_DLL_EXPORT)
  /* If the code is building on Windows, stop exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport
#endif



#endif  /* LatencySupport_1496238403_h */
