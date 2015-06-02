
/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from Latency.idl using "rtiddsgen".
  The rtiddsgen tool is part of the RTI Connext distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the RTI Connext manual.
*/

#ifndef Latency_1496238403_h
#define Latency_1496238403_h

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

             
static const DDS_Short MAX_DATA_SEQUENCE_LENGTH = 8192;
#define Latency_LAST_MEMBER_ID 1
#ifdef __cplusplus
extern "C" {
#endif

        
extern const char *LatencyTYPENAME;
        

#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
    struct LatencySeq;

#ifndef NDDS_STANDALONE_TYPE
    class LatencyTypeSupport;
    class LatencyDataWriter;
    class LatencyDataReader;
#endif

#endif

            
    
class Latency                                        
{
public:            
#ifdef __cplusplus
    typedef struct LatencySeq Seq;

#ifndef NDDS_STANDALONE_TYPE
    typedef LatencyTypeSupport TypeSupport;
    typedef LatencyDataWriter DataWriter;
    typedef LatencyDataReader DataReader;
#endif

#endif
    
    DDS_Long  sequence_number;

     DDS_OctetSeq  data;

            
};                        
    
                            
#if (defined(RTI_WIN32) || defined (RTI_WINCE)) && defined(NDDS_USER_DLL_EXPORT)
  /* If the code is building on Windows, start exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport __declspec(dllexport)
#endif

    

DDS_SEQUENCE(LatencySeq, Latency);
        
NDDSUSERDllExport
RTIBool Latency_initialize(
        Latency* self);
        
NDDSUSERDllExport
RTIBool Latency_initialize_ex(
        Latency* self,
        RTIBool allocatePointers,RTIBool allocateMemory);
        
NDDSUSERDllExport
RTIBool Latency_initialize_w_params(
        Latency* self,
        const struct DDS_TypeAllocationParams_t * allocParams);

NDDSUSERDllExport
void Latency_finalize(
        Latency* self);
                        
NDDSUSERDllExport
void Latency_finalize_ex(
        Latency* self,RTIBool deletePointers);
       
NDDSUSERDllExport
void Latency_finalize_w_params(
        Latency* self,
        const struct DDS_TypeDeallocationParams_t * deallocParams);
        
NDDSUSERDllExport
void Latency_finalize_optional_members(
        Latency* self, RTIBool deletePointers);        
        
NDDSUSERDllExport
RTIBool Latency_copy(
        Latency* dst,
        const Latency* src);

#if (defined(RTI_WIN32) || defined (RTI_WINCE)) && defined(NDDS_USER_DLL_EXPORT)
  /* If the code is building on Windows, stop exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport
#endif



#endif /* Latency_1496238403_h */
