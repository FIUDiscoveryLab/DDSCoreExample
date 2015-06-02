
/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from HelloWorld.idl using "rtiddsgen".
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



#include "HelloWorld.h"

/* ========================================================================= */
const char *HelloWorldTYPENAME = "HelloWorld";

DDS_TypeCode* HelloWorld_get_typecode()
{
    static RTIBool is_initialized = RTI_FALSE;

    static DDS_TypeCode HelloWorld_g_tc_sender_string = DDS_INITIALIZE_STRING_TYPECODE((MAX_NAME_LEN));
    static DDS_TypeCode HelloWorld_g_tc_message_string = DDS_INITIALIZE_STRING_TYPECODE((MAX_MSG_LEN));

    static DDS_TypeCode_Member HelloWorld_g_tc_members[3]=
    {
        {
            (char *)"sender",/* Member name */
            {
                0,/* Representation ID */
                DDS_BOOLEAN_FALSE,/* Is a pointer? */
                -1, /* Bitfield bits */
                NULL/* Member type code is assigned later */
            },
            0, /* Ignored */
            0, /* Ignored */
            0, /* Ignored */
            NULL, /* Ignored */
            RTI_CDR_KEY_MEMBER, /* Member flags */
            DDS_PRIVATE_MEMBER,/* Ignored */
            1,
            NULL/* Ignored */
        },
        {
            (char *)"message",/* Member name */
            {
                1,/* Representation ID */
                DDS_BOOLEAN_FALSE,/* Is a pointer? */
                -1, /* Bitfield bits */
                NULL/* Member type code is assigned later */
            },
            0, /* Ignored */
            0, /* Ignored */
            0, /* Ignored */
            NULL, /* Ignored */
            RTI_CDR_REQUIRED_MEMBER, /* Member flags */
            DDS_PRIVATE_MEMBER,/* Ignored */
            1,
            NULL/* Ignored */
        },
        {
            (char *)"count",/* Member name */
            {
                2,/* Representation ID */
                DDS_BOOLEAN_FALSE,/* Is a pointer? */
                -1, /* Bitfield bits */
                NULL/* Member type code is assigned later */
            },
            0, /* Ignored */
            0, /* Ignored */
            0, /* Ignored */
            NULL, /* Ignored */
            RTI_CDR_REQUIRED_MEMBER, /* Member flags */
            DDS_PRIVATE_MEMBER,/* Ignored */
            1,
            NULL/* Ignored */
        }
    };

    static DDS_TypeCode HelloWorld_g_tc =
    {{
        DDS_TK_STRUCT,/* Kind */
        DDS_BOOLEAN_FALSE, /* Ignored */
        -1,/* Ignored */
        (char *)"HelloWorld", /* Name */
        NULL, /* Ignored */
        0, /* Ignored */
        0, /* Ignored */
        NULL, /* Ignored */
        3, /* Number of members */
        HelloWorld_g_tc_members, /* Members */
        DDS_VM_NONE /* Ignored */
    }}; /* Type code for HelloWorld*/

    if (is_initialized) {
        return &HelloWorld_g_tc;
    }


    HelloWorld_g_tc_members[0]._representation._typeCode = (RTICdrTypeCode *)&HelloWorld_g_tc_sender_string;
    HelloWorld_g_tc_members[1]._representation._typeCode = (RTICdrTypeCode *)&HelloWorld_g_tc_message_string;
    HelloWorld_g_tc_members[2]._representation._typeCode = (RTICdrTypeCode *)&DDS_g_tc_long;

    is_initialized = RTI_TRUE;

    return &HelloWorld_g_tc;
}


RTIBool HelloWorld_initialize(
    HelloWorld* sample) {
  return HelloWorld_initialize_ex(sample,RTI_TRUE,RTI_TRUE);
}
        
RTIBool HelloWorld_initialize_ex(
    HelloWorld* sample,RTIBool allocatePointers,RTIBool allocateMemory)
{
    struct DDS_TypeAllocationParams_t allocParams =
        DDS_TYPE_ALLOCATION_PARAMS_DEFAULT;
        
    allocParams.allocate_pointers =  (DDS_Boolean)allocatePointers;
    allocParams.allocate_memory = (DDS_Boolean)allocateMemory;
    
    return HelloWorld_initialize_w_params(
        sample,&allocParams);
}

RTIBool HelloWorld_initialize_w_params(
        HelloWorld* sample,
        const struct DDS_TypeAllocationParams_t * allocParams)
{
        
    
    if (allocParams) {} /* To avoid warnings */
        

    if (allocParams->allocate_memory) {
        sample->sender = DDS_String_alloc(((MAX_NAME_LEN)));
        if (sample->sender == NULL) {
            return RTI_FALSE;
        }
    } else {
        if (sample->sender != NULL) { 
            sample->sender[0] = '\0';
        }
    }
            

    if (allocParams->allocate_memory) {
        sample->message = DDS_String_alloc(((MAX_MSG_LEN)));
        if (sample->message == NULL) {
            return RTI_FALSE;
        }
    } else {
        if (sample->message != NULL) { 
            sample->message[0] = '\0';
        }
    }
            

    if (!RTICdrType_initLong(&sample->count)) {
        return RTI_FALSE;
    }                
            


    return RTI_TRUE;
}

void HelloWorld_finalize(
    HelloWorld* sample)
{
    HelloWorld_finalize_ex(sample,RTI_TRUE);
}
        
void HelloWorld_finalize_ex(
    HelloWorld* sample,RTIBool deletePointers)
{        
    struct DDS_TypeDeallocationParams_t deallocParams =
            DDS_TYPE_DEALLOCATION_PARAMS_DEFAULT;

    if (sample) { } /* To avoid warnings */
    
    deallocParams.delete_pointers = (DDS_Boolean)deletePointers;

    HelloWorld_finalize_w_params(
        sample,&deallocParams);
}

void HelloWorld_finalize_w_params(
        HelloWorld* sample,
        const struct DDS_TypeDeallocationParams_t * deallocParams)
{    
    if (sample) { } /* To avoid warnings */
    if (deallocParams) {} /* To avoid warnings */


    if (sample->sender != NULL) {    
        DDS_String_free(sample->sender);
        sample->sender = NULL;
    }
            

    if (sample->message != NULL) {    
        DDS_String_free(sample->message);
        sample->message = NULL;
    }
            


}

void HelloWorld_finalize_optional_members(
    HelloWorld* sample, RTIBool deletePointers)
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

RTIBool HelloWorld_copy(
    HelloWorld* dst,
    const HelloWorld* src)
{

    if (!RTICdrType_copyString(
        dst->sender, src->sender, ((MAX_NAME_LEN)) + 1)) {
        return RTI_FALSE;
    }
            

    if (!RTICdrType_copyString(
        dst->message, src->message, ((MAX_MSG_LEN)) + 1)) {
        return RTI_FALSE;
    }
            

    if (!RTICdrType_copyLong(
        &dst->count, &src->count)) {
        return RTI_FALSE;
    }
            


    return RTI_TRUE;
}


/**
 * <<IMPLEMENTATION>>
 *
 * Defines:  TSeq, T
 *
 * Configure and implement 'HelloWorld' sequence class.
 */
#define T HelloWorld
#define TSeq HelloWorldSeq
#define T_initialize_w_params HelloWorld_initialize_w_params
#define T_finalize_w_params   HelloWorld_finalize_w_params
#define T_copy       HelloWorld_copy

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

