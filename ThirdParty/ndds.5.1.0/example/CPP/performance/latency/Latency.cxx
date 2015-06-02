
/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from Latency.idl using "rtiddsgen".
  The rtiddsgen tool is part of the RTI Connext distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the RTI Connext manual.
*/


#ifndef NDDS_STANDALONE_TYPE
    #ifdef __cplusplus
        #ifndef ndds_cpp_h
            #include "ndds/ndds_cpp.h"
        #endif
        #ifndef dds_c_log_impl_h              
            #include "dds_c/dds_c_log_impl.h"                                
        #endif        
    #else
        #ifndef ndds_c_h
            #include "ndds/ndds_c.h"
        #endif
    #endif
    
    #ifndef cdr_type_h
        #include "cdr/cdr_type.h"
    #endif    

    #ifndef osapi_heap_h
        #include "osapi/osapi_heap.h" 
    #endif
#else
    #include "ndds_standalone_type.h"
#endif



#include "Latency.h"

/* ========================================================================= */
const char *LatencyTYPENAME = "Latency";


RTIBool Latency_initialize(
    Latency* sample) {
  return Latency_initialize_ex(sample,RTI_TRUE,RTI_TRUE);
}
        
RTIBool Latency_initialize_ex(
    Latency* sample,RTIBool allocatePointers,RTIBool allocateMemory)
{
    struct DDS_TypeAllocationParams_t allocParams =
        DDS_TYPE_ALLOCATION_PARAMS_DEFAULT;
        
    allocParams.allocate_pointers =  (DDS_Boolean)allocatePointers;
    allocParams.allocate_memory = (DDS_Boolean)allocateMemory;
    
    return Latency_initialize_w_params(
        sample,&allocParams);
}

RTIBool Latency_initialize_w_params(
        Latency* sample,
        const struct DDS_TypeAllocationParams_t * allocParams)
{

    void* buffer = NULL;
    if (buffer) {} /* To avoid warnings */
        
    
    if (allocParams) {} /* To avoid warnings */
        

    if (!RTICdrType_initLong(&sample->sequence_number)) {
        return RTI_FALSE;
    }                
            

    if (allocParams->allocate_memory) {
        DDS_OctetSeq_initialize(&sample->data);
        if (!DDS_OctetSeq_set_maximum(&sample->data,
                ((MAX_DATA_SEQUENCE_LENGTH)))) {
            return RTI_FALSE;
        }
    } else {
        DDS_OctetSeq_set_length(&sample->data, 0); 
    }
            


    return RTI_TRUE;
}

void Latency_finalize(
    Latency* sample)
{
    Latency_finalize_ex(sample,RTI_TRUE);
}
        
void Latency_finalize_ex(
    Latency* sample,RTIBool deletePointers)
{        
    struct DDS_TypeDeallocationParams_t deallocParams =
            DDS_TYPE_DEALLOCATION_PARAMS_DEFAULT;

    if (sample) { } /* To avoid warnings */
    
    deallocParams.delete_pointers = (DDS_Boolean)deletePointers;

    Latency_finalize_w_params(
        sample,&deallocParams);
}

void Latency_finalize_w_params(
        Latency* sample,
        const struct DDS_TypeDeallocationParams_t * deallocParams)
{    
    if (sample) { } /* To avoid warnings */
    if (deallocParams) {} /* To avoid warnings */



    DDS_OctetSeq_finalize(&sample->data);
            

}

void Latency_finalize_optional_members(
    Latency* sample, RTIBool deletePointers)
{
    struct DDS_TypeDeallocationParams_t deallocParamsTmp =
        DDS_TYPE_DEALLOCATION_PARAMS_DEFAULT;
    struct DDS_TypeDeallocationParams_t * deallocParams =
        &deallocParamsTmp;
    if (sample) { } /* To avoid warnings */
    if (deallocParams) {} /* To avoid warnings */

        

    deallocParamsTmp.delete_pointers = (DDS_Boolean)deletePointers;
    deallocParamsTmp.delete_optional_members = DDS_BOOLEAN_TRUE;    
             



}

RTIBool Latency_copy(
    Latency* dst,
    const Latency* src)
{

    if (!RTICdrType_copyLong(
        &dst->sequence_number, &src->sequence_number)) {
        return RTI_FALSE;
    }
            

    if (!DDS_OctetSeq_copy(&dst->data,
                                          &src->data)) {
        return RTI_FALSE;
    }
            


    return RTI_TRUE;
}


/**
 * <<IMPLEMENTATION>>
 *
 * Defines:  TSeq, T
 *
 * Configure and implement 'Latency' sequence class.
 */
#define T Latency
#define TSeq LatencySeq
#define T_initialize_w_params Latency_initialize_w_params
#define T_finalize_w_params   Latency_finalize_w_params
#define T_copy       Latency_copy

#ifndef NDDS_STANDALONE_TYPE
#include "dds_c/generic/dds_c_sequence_TSeq.gen"
#ifdef __cplusplus
#include "dds_cpp/generic/dds_cpp_sequence_TSeq.gen"
#endif
#else
#include "dds_c_sequence_TSeq.gen"
#ifdef __cplusplus
#include "dds_cpp_sequence_TSeq.gen"
#endif
#endif

#undef T_copy
#undef T_finalize_w_params
#undef T_initialize_w_params
#undef TSeq
#undef T

