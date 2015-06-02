
/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from Primes.idl using "rtiddsgen".
  The rtiddsgen tool is part of the RTI Connext distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the RTI Connext manual.
*/

#ifndef Primes_831781118_h
#define Primes_831781118_h

#ifndef NDDS_STANDALONE_TYPE
    #ifdef __cplusplus
        #ifndef ndds_cpp_h
            #include "ndds/ndds_cpp.h"
        #endif
    #else
        #ifndef ndds_c_h
            #include "ndds/ndds_c.h"
        #endif
    #endif
#else
    #include "ndds_standalone_type.h"
#endif


#define PrimeNumberRequest_LAST_MEMBER_ID 1
#ifdef __cplusplus
extern "C" {
#endif

        
extern const char *PrimeNumberRequestTYPENAME;
        

#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
    struct PrimeNumberRequestSeq;

#ifndef NDDS_STANDALONE_TYPE
    class PrimeNumberRequestTypeSupport;
    class PrimeNumberRequestDataWriter;
    class PrimeNumberRequestDataReader;
#endif

#endif

            
    typedef struct PrimeNumberRequest
{

    DDS_Long  n;

    DDS_Long  primes_per_reply;

            
} PrimeNumberRequest;                        
    
                            
#if (defined(RTI_WIN32) || defined (RTI_WINCE)) && defined(NDDS_USER_DLL_EXPORT)
  /* If the code is building on Windows, start exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport __declspec(dllexport)
#endif

    
NDDSUSERDllExport DDS_TypeCode* PrimeNumberRequest_get_typecode(void); /* Type code */
    

DDS_SEQUENCE(PrimeNumberRequestSeq, PrimeNumberRequest);
        
NDDSUSERDllExport
RTIBool PrimeNumberRequest_initialize(
        PrimeNumberRequest* self);
        
NDDSUSERDllExport
RTIBool PrimeNumberRequest_initialize_ex(
        PrimeNumberRequest* self,
        RTIBool allocatePointers,RTIBool allocateMemory);
        
NDDSUSERDllExport
RTIBool PrimeNumberRequest_initialize_w_params(
        PrimeNumberRequest* self,
        const struct DDS_TypeAllocationParams_t * allocParams);

NDDSUSERDllExport
void PrimeNumberRequest_finalize(
        PrimeNumberRequest* self);
                        
NDDSUSERDllExport
void PrimeNumberRequest_finalize_ex(
        PrimeNumberRequest* self,RTIBool deletePointers);
       
NDDSUSERDllExport
void PrimeNumberRequest_finalize_w_params(
        PrimeNumberRequest* self,
        const struct DDS_TypeDeallocationParams_t * deallocParams);
        
NDDSUSERDllExport
void PrimeNumberRequest_finalize_optional_members(
        PrimeNumberRequest* self, RTIBool deletePointers);        
        
NDDSUSERDllExport
RTIBool PrimeNumberRequest_copy(
        PrimeNumberRequest* dst,
        const PrimeNumberRequest* src);

#if (defined(RTI_WIN32) || defined (RTI_WINCE)) && defined(NDDS_USER_DLL_EXPORT)
  /* If the code is building on Windows, stop exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport
#endif

                
#define PRIME_SEQUENCE_MAX_LENGTH (1024)                
         
typedef enum PrimeNumberCalculationStatus
{
    REPLY_IN_PROGRESS,
    REPLY_COMPLETED,
    REPLY_ERROR
} PrimeNumberCalculationStatus;
    

#if (defined(RTI_WIN32) || defined (RTI_WINCE)) && defined(NDDS_USER_DLL_EXPORT)
  /* If the code is building on Windows, start exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport __declspec(dllexport)
#endif

    
NDDSUSERDllExport DDS_TypeCode* PrimeNumberCalculationStatus_get_typecode(void); /* Type code */
    

DDS_SEQUENCE(PrimeNumberCalculationStatusSeq, PrimeNumberCalculationStatus);
        
NDDSUSERDllExport
RTIBool PrimeNumberCalculationStatus_initialize(
        PrimeNumberCalculationStatus* self);
        
NDDSUSERDllExport
RTIBool PrimeNumberCalculationStatus_initialize_ex(
        PrimeNumberCalculationStatus* self,
        RTIBool allocatePointers,RTIBool allocateMemory);
        
NDDSUSERDllExport
RTIBool PrimeNumberCalculationStatus_initialize_w_params(
        PrimeNumberCalculationStatus* self,
        const struct DDS_TypeAllocationParams_t * allocParams);

NDDSUSERDllExport
void PrimeNumberCalculationStatus_finalize(
        PrimeNumberCalculationStatus* self);
                        
NDDSUSERDllExport
void PrimeNumberCalculationStatus_finalize_ex(
        PrimeNumberCalculationStatus* self,RTIBool deletePointers);
        
NDDSUSERDllExport
void PrimeNumberCalculationStatus_finalize_w_params(
        PrimeNumberCalculationStatus* self,
        const struct DDS_TypeDeallocationParams_t * deallocParams);

NDDSUSERDllExport
void PrimeNumberCalculationStatus_finalize_optional_members(
        PrimeNumberCalculationStatus* self, RTIBool deletePointers);
                
NDDSUSERDllExport
RTIBool PrimeNumberCalculationStatus_copy(
        PrimeNumberCalculationStatus* dst,
        const PrimeNumberCalculationStatus* src);


NDDSUSERDllExport
RTIBool PrimeNumberCalculationStatus_getValues(struct PrimeNumberCalculationStatusSeq * values);
    

#if (defined(RTI_WIN32) || defined (RTI_WINCE)) && defined(NDDS_USER_DLL_EXPORT)
  /* If the code is building on Windows, stop exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport
#endif


#define PrimeNumberReply_LAST_MEMBER_ID 1
#ifdef __cplusplus
extern "C" {
#endif

        
extern const char *PrimeNumberReplyTYPENAME;
        

#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
    struct PrimeNumberReplySeq;

#ifndef NDDS_STANDALONE_TYPE
    class PrimeNumberReplyTypeSupport;
    class PrimeNumberReplyDataWriter;
    class PrimeNumberReplyDataReader;
#endif

#endif

            
    typedef struct PrimeNumberReply
{

    struct DDS_LongSeq  primes;

    PrimeNumberCalculationStatus  status;

            
} PrimeNumberReply;                        
    
                            
#if (defined(RTI_WIN32) || defined (RTI_WINCE)) && defined(NDDS_USER_DLL_EXPORT)
  /* If the code is building on Windows, start exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport __declspec(dllexport)
#endif

    
NDDSUSERDllExport DDS_TypeCode* PrimeNumberReply_get_typecode(void); /* Type code */
    

DDS_SEQUENCE(PrimeNumberReplySeq, PrimeNumberReply);
        
NDDSUSERDllExport
RTIBool PrimeNumberReply_initialize(
        PrimeNumberReply* self);
        
NDDSUSERDllExport
RTIBool PrimeNumberReply_initialize_ex(
        PrimeNumberReply* self,
        RTIBool allocatePointers,RTIBool allocateMemory);
        
NDDSUSERDllExport
RTIBool PrimeNumberReply_initialize_w_params(
        PrimeNumberReply* self,
        const struct DDS_TypeAllocationParams_t * allocParams);

NDDSUSERDllExport
void PrimeNumberReply_finalize(
        PrimeNumberReply* self);
                        
NDDSUSERDllExport
void PrimeNumberReply_finalize_ex(
        PrimeNumberReply* self,RTIBool deletePointers);
       
NDDSUSERDllExport
void PrimeNumberReply_finalize_w_params(
        PrimeNumberReply* self,
        const struct DDS_TypeDeallocationParams_t * deallocParams);
        
NDDSUSERDllExport
void PrimeNumberReply_finalize_optional_members(
        PrimeNumberReply* self, RTIBool deletePointers);        
        
NDDSUSERDllExport
RTIBool PrimeNumberReply_copy(
        PrimeNumberReply* dst,
        const PrimeNumberReply* src);

#if (defined(RTI_WIN32) || defined (RTI_WINCE)) && defined(NDDS_USER_DLL_EXPORT)
  /* If the code is building on Windows, stop exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport
#endif



#endif /* Primes_831781118_h */
