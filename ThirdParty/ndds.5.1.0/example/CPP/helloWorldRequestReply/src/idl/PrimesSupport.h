
/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from Primes.idl using "rtiddsgen".
  The rtiddsgen tool is part of the RTI Connext distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the RTI Connext manual.
*/

#ifndef PrimesSupport_831781118_h
#define PrimesSupport_831781118_h

/* Uses */
#include "Primes.h"



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

DDS_TYPESUPPORT_CPP(PrimeNumberRequestTypeSupport, PrimeNumberRequest);

DDS_DATAWRITER_CPP(PrimeNumberRequestDataWriter, PrimeNumberRequest);
DDS_DATAREADER_CPP(PrimeNumberRequestDataReader, PrimeNumberRequestSeq, PrimeNumberRequest);


#else

DDS_TYPESUPPORT_C(PrimeNumberRequestTypeSupport, PrimeNumberRequest);
DDS_DATAWRITER_C(PrimeNumberRequestDataWriter, PrimeNumberRequest);
DDS_DATAREADER_C(PrimeNumberRequestDataReader, PrimeNumberRequestSeq, PrimeNumberRequest);

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

DDS_TYPESUPPORT_CPP(PrimeNumberReplyTypeSupport, PrimeNumberReply);

DDS_DATAWRITER_CPP(PrimeNumberReplyDataWriter, PrimeNumberReply);
DDS_DATAREADER_CPP(PrimeNumberReplyDataReader, PrimeNumberReplySeq, PrimeNumberReply);


#else

DDS_TYPESUPPORT_C(PrimeNumberReplyTypeSupport, PrimeNumberReply);
DDS_DATAWRITER_C(PrimeNumberReplyDataWriter, PrimeNumberReply);
DDS_DATAREADER_C(PrimeNumberReplyDataReader, PrimeNumberReplySeq, PrimeNumberReply);

#endif

#if (defined(RTI_WIN32) || defined (RTI_WINCE)) && defined(NDDS_USER_DLL_EXPORT)
  /* If the code is building on Windows, stop exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport
#endif



#endif  /* PrimesSupport_831781118_h */
