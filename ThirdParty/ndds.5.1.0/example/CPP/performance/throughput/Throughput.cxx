
/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from Throughput.idl using "rtiddsgen".
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



#include "Throughput.h"

/* ========================================================================= */
const char *ThroughputCommandKindTYPENAME = "ThroughputCommandKind";
 

RTIBool ThroughputCommandKind_initialize(
    ThroughputCommandKind* sample)
{
    *sample = THROUGHPUT_COMMAND_IDLE;
    return RTI_TRUE;
}
        
RTIBool ThroughputCommandKind_initialize_ex(
    ThroughputCommandKind* sample,RTIBool allocatePointers,RTIBool allocateMemory)
{
    if (allocatePointers) {} /* To avoid warnings */
    if (allocateMemory) {} /* To avoid warnings */
    *sample = THROUGHPUT_COMMAND_IDLE;
    return RTI_TRUE;
}

RTIBool ThroughputCommandKind_initialize_w_params(
        ThroughputCommandKind* sample,
        const struct DDS_TypeAllocationParams_t * allocParams)
{
    if (allocParams) {} /* To avoid warnings */
    *sample = THROUGHPUT_COMMAND_IDLE;
    return RTI_TRUE;
}

void ThroughputCommandKind_finalize(
    ThroughputCommandKind* sample)
{
    if (sample) {} /* To avoid warnings */
    /* empty */
}
        
void ThroughputCommandKind_finalize_ex(
    ThroughputCommandKind* sample,RTIBool deletePointers)
{
    if (sample) {} /* To avoid warnings */
    if (deletePointers) {} /* To avoid warnings */
    /* empty */
}

void ThroughputCommandKind_finalize_w_params(
        ThroughputCommandKind* sample,
        const struct DDS_TypeDeallocationParams_t * deallocParams)
{
    if (sample) {} /* To avoid warnings */
    if (deallocParams) {} /* To avoid warnings */
    /* empty */
}

RTIBool ThroughputCommandKind_copy(
    ThroughputCommandKind* dst,
    const ThroughputCommandKind* src)
{
    return RTICdrType_copyEnum((RTICdrEnum *)dst, (RTICdrEnum *)src);
}


RTIBool ThroughputCommandKind_getValues(ThroughputCommandKindSeq * values) 
    
{
    int i = 0;
    ThroughputCommandKind * buffer;


    if (!values->maximum(3)) {
        return RTI_FALSE;
    }

    if (!values->length(3)) {
        return RTI_FALSE;
    }

    buffer = values->get_contiguous_buffer();
    
    buffer[i] = THROUGHPUT_COMMAND_IDLE;
    i++;
    
    buffer[i] = THROUGHPUT_COMMAND_START;
    i++;
    
    buffer[i] = THROUGHPUT_COMMAND_COMPLETE;
    i++;
    

    return RTI_TRUE;
}

/**
 * <<IMPLEMENTATION>>
 *
 * Defines:  TSeq, T
 *
 * Configure and implement 'ThroughputCommandKind' sequence class.
 */
#define T ThroughputCommandKind
#define TSeq ThroughputCommandKindSeq
#define T_initialize_w_params ThroughputCommandKind_initialize_w_params
#define T_finalize_w_params   ThroughputCommandKind_finalize_w_params
#define T_copy       ThroughputCommandKind_copy

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
/* ========================================================================= */
const char *ThroughputCommandTYPENAME = "ThroughputCommand";


RTIBool ThroughputCommand_initialize(
    ThroughputCommand* sample) {
  return ThroughputCommand_initialize_ex(sample,RTI_TRUE,RTI_TRUE);
}
        
RTIBool ThroughputCommand_initialize_ex(
    ThroughputCommand* sample,RTIBool allocatePointers,RTIBool allocateMemory)
{
    struct DDS_TypeAllocationParams_t allocParams =
        DDS_TYPE_ALLOCATION_PARAMS_DEFAULT;
        
    allocParams.allocate_pointers =  (DDS_Boolean)allocatePointers;
    allocParams.allocate_memory = (DDS_Boolean)allocateMemory;
    
    return ThroughputCommand_initialize_w_params(
        sample,&allocParams);
}

RTIBool ThroughputCommand_initialize_w_params(
        ThroughputCommand* sample,
        const struct DDS_TypeAllocationParams_t * allocParams)
{
        
    
    if (allocParams) {} /* To avoid warnings */
        
    
    if (!RTICdrType_initArray(
        sample->signature, (4), RTI_CDR_OCTET_SIZE)) {
        return RTI_FALSE;
    }
            

    if (!ThroughputCommandKind_initialize_w_params(&sample->command,allocParams)) {
        return RTI_FALSE;
    }
            

    if (!RTICdrType_initUnsignedLong(&sample->data_length)) {
        return RTI_FALSE;
    }                
            

    if (!RTICdrType_initUnsignedLong(&sample->current_publisher_effort)) {
        return RTI_FALSE;
    }                
            

    if (!RTICdrType_initUnsignedLong(&sample->final_publisher_effort)) {
        return RTI_FALSE;
    }                
            

    if (!RTICdrType_initFloat(&sample->publisher_cpu_usage)) {
        return RTI_FALSE;
    }                
            


    return RTI_TRUE;
}

void ThroughputCommand_finalize(
    ThroughputCommand* sample)
{
    ThroughputCommand_finalize_ex(sample,RTI_TRUE);
}
        
void ThroughputCommand_finalize_ex(
    ThroughputCommand* sample,RTIBool deletePointers)
{        
    struct DDS_TypeDeallocationParams_t deallocParams =
            DDS_TYPE_DEALLOCATION_PARAMS_DEFAULT;

    if (sample) { } /* To avoid warnings */
    
    deallocParams.delete_pointers = (DDS_Boolean)deletePointers;

    ThroughputCommand_finalize_w_params(
        sample,&deallocParams);
}

void ThroughputCommand_finalize_w_params(
        ThroughputCommand* sample,
        const struct DDS_TypeDeallocationParams_t * deallocParams)
{    
    if (sample) { } /* To avoid warnings */
    if (deallocParams) {} /* To avoid warnings */



    ThroughputCommandKind_finalize_w_params(&sample->command, deallocParams);
            





}

void ThroughputCommand_finalize_optional_members(
    ThroughputCommand* sample, RTIBool deletePointers)
{
    struct DDS_TypeDeallocationParams_t deallocParamsTmp =
        DDS_TYPE_DEALLOCATION_PARAMS_DEFAULT;
    struct DDS_TypeDeallocationParams_t * deallocParams =
        &deallocParamsTmp;
    if (sample) { } /* To avoid warnings */
    if (deallocParams) {} /* To avoid warnings */

        

    deallocParamsTmp.delete_pointers = (DDS_Boolean)deletePointers;
    deallocParamsTmp.delete_optional_members = DDS_BOOLEAN_TRUE;    
             


    ThroughputCommandKind_finalize_w_params(&sample->command, deallocParams);
            





}

RTIBool ThroughputCommand_copy(
    ThroughputCommand* dst,
    const ThroughputCommand* src)
{

    if (!RTICdrType_copyArray(
        dst->signature, src->signature, (4), RTI_CDR_OCTET_SIZE)) {
        return RTI_FALSE;
    }
            

    if (!ThroughputCommandKind_copy(
        &dst->command, &src->command)) {
        return RTI_FALSE;
    }
            

    if (!RTICdrType_copyUnsignedLong(
        &dst->data_length, &src->data_length)) {
        return RTI_FALSE;
    }
            

    if (!RTICdrType_copyUnsignedLong(
        &dst->current_publisher_effort, &src->current_publisher_effort)) {
        return RTI_FALSE;
    }
            

    if (!RTICdrType_copyUnsignedLong(
        &dst->final_publisher_effort, &src->final_publisher_effort)) {
        return RTI_FALSE;
    }
            

    if (!RTICdrType_copyFloat(
        &dst->publisher_cpu_usage, &src->publisher_cpu_usage)) {
        return RTI_FALSE;
    }
            


    return RTI_TRUE;
}


/**
 * <<IMPLEMENTATION>>
 *
 * Defines:  TSeq, T
 *
 * Configure and implement 'ThroughputCommand' sequence class.
 */
#define T ThroughputCommand
#define TSeq ThroughputCommandSeq
#define T_initialize_w_params ThroughputCommand_initialize_w_params
#define T_finalize_w_params   ThroughputCommand_finalize_w_params
#define T_copy       ThroughputCommand_copy

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

/* ========================================================================= */
const char *ThroughputTYPENAME = "Throughput";


RTIBool Throughput_initialize(
    Throughput* sample) {
  return Throughput_initialize_ex(sample,RTI_TRUE,RTI_TRUE);
}
        
RTIBool Throughput_initialize_ex(
    Throughput* sample,RTIBool allocatePointers,RTIBool allocateMemory)
{
    struct DDS_TypeAllocationParams_t allocParams =
        DDS_TYPE_ALLOCATION_PARAMS_DEFAULT;
        
    allocParams.allocate_pointers =  (DDS_Boolean)allocatePointers;
    allocParams.allocate_memory = (DDS_Boolean)allocateMemory;
    
    return Throughput_initialize_w_params(
        sample,&allocParams);
}

RTIBool Throughput_initialize_w_params(
        Throughput* sample,
        const struct DDS_TypeAllocationParams_t * allocParams)
{

    void* buffer = NULL;
    if (buffer) {} /* To avoid warnings */
        
    
    if (allocParams) {} /* To avoid warnings */
        

    if (!RTICdrType_initLong(&sample->key)) {
        return RTI_FALSE;
    }                
            

    if (!RTICdrType_initUnsignedLong(&sample->sequence_number)) {
        return RTI_FALSE;
    }                
            

    if (allocParams->allocate_memory) {
        DDS_OctetSeq_initialize(&sample->data);
        if (!DDS_OctetSeq_set_maximum(&sample->data,
                ((THROUGHPUT_TEST_PACKET_DATA_SIZE_MAX)))) {
            return RTI_FALSE;
        }
    } else {
        DDS_OctetSeq_set_length(&sample->data, 0); 
    }
            


    return RTI_TRUE;
}

void Throughput_finalize(
    Throughput* sample)
{
    Throughput_finalize_ex(sample,RTI_TRUE);
}
        
void Throughput_finalize_ex(
    Throughput* sample,RTIBool deletePointers)
{        
    struct DDS_TypeDeallocationParams_t deallocParams =
            DDS_TYPE_DEALLOCATION_PARAMS_DEFAULT;

    if (sample) { } /* To avoid warnings */
    
    deallocParams.delete_pointers = (DDS_Boolean)deletePointers;

    Throughput_finalize_w_params(
        sample,&deallocParams);
}

void Throughput_finalize_w_params(
        Throughput* sample,
        const struct DDS_TypeDeallocationParams_t * deallocParams)
{    
    if (sample) { } /* To avoid warnings */
    if (deallocParams) {} /* To avoid warnings */




    DDS_OctetSeq_finalize(&sample->data);
            

}

void Throughput_finalize_optional_members(
    Throughput* sample, RTIBool deletePointers)
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

RTIBool Throughput_copy(
    Throughput* dst,
    const Throughput* src)
{

    if (!RTICdrType_copyLong(
        &dst->key, &src->key)) {
        return RTI_FALSE;
    }
            

    if (!RTICdrType_copyUnsignedLong(
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
 * Configure and implement 'Throughput' sequence class.
 */
#define T Throughput
#define TSeq ThroughputSeq
#define T_initialize_w_params Throughput_initialize_w_params
#define T_finalize_w_params   Throughput_finalize_w_params
#define T_copy       Throughput_copy

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

