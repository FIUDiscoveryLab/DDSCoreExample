
/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from Throughput.idl using "rtiddsgen".
  The rtiddsgen tool is part of the RTI Connext distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the RTI Connext manual.
*/

#ifndef ThroughputSupport_1907597258_h
#define ThroughputSupport_1907597258_h

/* Uses */
#include "Throughput.h"



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

DDS_TYPESUPPORT_CPP(ThroughputCommandTypeSupport, ThroughputCommand);

DDS_DATAWRITER_CPP(ThroughputCommandDataWriter, ThroughputCommand);
DDS_DATAREADER_CPP(ThroughputCommandDataReader, ThroughputCommandSeq, ThroughputCommand);


#else

DDS_TYPESUPPORT_C(ThroughputCommandTypeSupport, ThroughputCommand);
DDS_DATAWRITER_C(ThroughputCommandDataWriter, ThroughputCommand);
DDS_DATAREADER_C(ThroughputCommandDataReader, ThroughputCommandSeq, ThroughputCommand);

#endif

#if (defined(RTI_WIN32) || defined (RTI_WINCE)) && defined(NDDS_USER_DLL_EXPORT)
  /* If the code is building on Windows, stop exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport
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

DDS_TYPESUPPORT_CPP(ThroughputTypeSupport, Throughput);

DDS_DATAWRITER_CPP(ThroughputDataWriter, Throughput);
DDS_DATAREADER_CPP(ThroughputDataReader, ThroughputSeq, Throughput);


#else

DDS_TYPESUPPORT_C(ThroughputTypeSupport, Throughput);
DDS_DATAWRITER_C(ThroughputDataWriter, Throughput);
DDS_DATAREADER_C(ThroughputDataReader, ThroughputSeq, Throughput);

#endif

#if (defined(RTI_WIN32) || defined (RTI_WINCE)) && defined(NDDS_USER_DLL_EXPORT)
  /* If the code is building on Windows, stop exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport
#endif



#endif  /* ThroughputSupport_1907597258_h */
