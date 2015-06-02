
/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from Throughput.idl using "rtiddsgen".
  The rtiddsgen tool is part of the RTI Connext distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the RTI Connext manual.
*/

#ifndef Throughput_1907597258_h
#define Throughput_1907597258_h

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

             
static const DDS_UnsignedLong THROUGHPUT_TEST_PACKET_DATA_SIZE_MAX = 8192; 
typedef enum ThroughputCommandKind
{
    THROUGHPUT_COMMAND_IDLE,
    THROUGHPUT_COMMAND_START,
    THROUGHPUT_COMMAND_COMPLETE
} ThroughputCommandKind;
    

#if (defined(RTI_WIN32) || defined (RTI_WINCE)) && defined(NDDS_USER_DLL_EXPORT)
  /* If the code is building on Windows, start exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport __declspec(dllexport)
#endif

    

DDS_SEQUENCE(ThroughputCommandKindSeq, ThroughputCommandKind);
        
NDDSUSERDllExport
RTIBool ThroughputCommandKind_initialize(
        ThroughputCommandKind* self);
        
NDDSUSERDllExport
RTIBool ThroughputCommandKind_initialize_ex(
        ThroughputCommandKind* self,
        RTIBool allocatePointers,RTIBool allocateMemory);
        
NDDSUSERDllExport
RTIBool ThroughputCommandKind_initialize_w_params(
        ThroughputCommandKind* self,
        const struct DDS_TypeAllocationParams_t * allocParams);

NDDSUSERDllExport
void ThroughputCommandKind_finalize(
        ThroughputCommandKind* self);
                        
NDDSUSERDllExport
void ThroughputCommandKind_finalize_ex(
        ThroughputCommandKind* self,RTIBool deletePointers);
        
NDDSUSERDllExport
void ThroughputCommandKind_finalize_w_params(
        ThroughputCommandKind* self,
        const struct DDS_TypeDeallocationParams_t * deallocParams);

NDDSUSERDllExport
void ThroughputCommandKind_finalize_optional_members(
        ThroughputCommandKind* self, RTIBool deletePointers);
                
NDDSUSERDllExport
RTIBool ThroughputCommandKind_copy(
        ThroughputCommandKind* dst,
        const ThroughputCommandKind* src);


NDDSUSERDllExport
RTIBool ThroughputCommandKind_getValues(ThroughputCommandKindSeq * values);
    

#if (defined(RTI_WIN32) || defined (RTI_WINCE)) && defined(NDDS_USER_DLL_EXPORT)
  /* If the code is building on Windows, stop exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport
#endif


#define ThroughputCommand_LAST_MEMBER_ID 5
#ifdef __cplusplus
extern "C" {
#endif

        
extern const char *ThroughputCommandTYPENAME;
        

#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
    struct ThroughputCommandSeq;

#ifndef NDDS_STANDALONE_TYPE
    class ThroughputCommandTypeSupport;
    class ThroughputCommandDataWriter;
    class ThroughputCommandDataReader;
#endif

#endif

            
    
class ThroughputCommand                                        
{
public:            
#ifdef __cplusplus
    typedef struct ThroughputCommandSeq Seq;

#ifndef NDDS_STANDALONE_TYPE
    typedef ThroughputCommandTypeSupport TypeSupport;
    typedef ThroughputCommandDataWriter DataWriter;
    typedef ThroughputCommandDataReader DataReader;
#endif

#endif
    
    DDS_Octet  signature[4];

    ThroughputCommandKind  command;

    DDS_UnsignedLong  data_length;

    DDS_UnsignedLong  current_publisher_effort;

    DDS_UnsignedLong  final_publisher_effort;

    DDS_Float  publisher_cpu_usage;

            
};                        
    
                            
#if (defined(RTI_WIN32) || defined (RTI_WINCE)) && defined(NDDS_USER_DLL_EXPORT)
  /* If the code is building on Windows, start exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport __declspec(dllexport)
#endif

    

DDS_SEQUENCE(ThroughputCommandSeq, ThroughputCommand);
        
NDDSUSERDllExport
RTIBool ThroughputCommand_initialize(
        ThroughputCommand* self);
        
NDDSUSERDllExport
RTIBool ThroughputCommand_initialize_ex(
        ThroughputCommand* self,
        RTIBool allocatePointers,RTIBool allocateMemory);
        
NDDSUSERDllExport
RTIBool ThroughputCommand_initialize_w_params(
        ThroughputCommand* self,
        const struct DDS_TypeAllocationParams_t * allocParams);

NDDSUSERDllExport
void ThroughputCommand_finalize(
        ThroughputCommand* self);
                        
NDDSUSERDllExport
void ThroughputCommand_finalize_ex(
        ThroughputCommand* self,RTIBool deletePointers);
       
NDDSUSERDllExport
void ThroughputCommand_finalize_w_params(
        ThroughputCommand* self,
        const struct DDS_TypeDeallocationParams_t * deallocParams);
        
NDDSUSERDllExport
void ThroughputCommand_finalize_optional_members(
        ThroughputCommand* self, RTIBool deletePointers);        
        
NDDSUSERDllExport
RTIBool ThroughputCommand_copy(
        ThroughputCommand* dst,
        const ThroughputCommand* src);

#if (defined(RTI_WIN32) || defined (RTI_WINCE)) && defined(NDDS_USER_DLL_EXPORT)
  /* If the code is building on Windows, stop exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport
#endif


#define Throughput_LAST_MEMBER_ID 2
#ifdef __cplusplus
extern "C" {
#endif

        
extern const char *ThroughputTYPENAME;
        

#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
    struct ThroughputSeq;

#ifndef NDDS_STANDALONE_TYPE
    class ThroughputTypeSupport;
    class ThroughputDataWriter;
    class ThroughputDataReader;
#endif

#endif

            
    
class Throughput                                        
{
public:            
#ifdef __cplusplus
    typedef struct ThroughputSeq Seq;

#ifndef NDDS_STANDALONE_TYPE
    typedef ThroughputTypeSupport TypeSupport;
    typedef ThroughputDataWriter DataWriter;
    typedef ThroughputDataReader DataReader;
#endif

#endif
    
    DDS_Long  key;

    DDS_UnsignedLong  sequence_number;

     DDS_OctetSeq  data;

            
};                        
    
                            
#if (defined(RTI_WIN32) || defined (RTI_WINCE)) && defined(NDDS_USER_DLL_EXPORT)
  /* If the code is building on Windows, start exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport __declspec(dllexport)
#endif

    

DDS_SEQUENCE(ThroughputSeq, Throughput);
        
NDDSUSERDllExport
RTIBool Throughput_initialize(
        Throughput* self);
        
NDDSUSERDllExport
RTIBool Throughput_initialize_ex(
        Throughput* self,
        RTIBool allocatePointers,RTIBool allocateMemory);
        
NDDSUSERDllExport
RTIBool Throughput_initialize_w_params(
        Throughput* self,
        const struct DDS_TypeAllocationParams_t * allocParams);

NDDSUSERDllExport
void Throughput_finalize(
        Throughput* self);
                        
NDDSUSERDllExport
void Throughput_finalize_ex(
        Throughput* self,RTIBool deletePointers);
       
NDDSUSERDllExport
void Throughput_finalize_w_params(
        Throughput* self,
        const struct DDS_TypeDeallocationParams_t * deallocParams);
        
NDDSUSERDllExport
void Throughput_finalize_optional_members(
        Throughput* self, RTIBool deletePointers);        
        
NDDSUSERDllExport
RTIBool Throughput_copy(
        Throughput* dst,
        const Throughput* src);

#if (defined(RTI_WIN32) || defined (RTI_WINCE)) && defined(NDDS_USER_DLL_EXPORT)
  /* If the code is building on Windows, stop exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport
#endif



#endif /* Throughput_1907597258_h */
