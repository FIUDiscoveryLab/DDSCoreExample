
/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from Throughput.idl using "rtiddsgen".
  The rtiddsgen tool is part of the RTI Connext distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the RTI Connext manual.
*/


#include <string.h>

#ifdef __cplusplus
#ifndef ndds_cpp_h
  #include "ndds/ndds_cpp.h"
#endif
#else
#ifndef ndds_c_h
  #include "ndds/ndds_c.h"
#endif
#endif

#ifndef osapi_type_h
  #include "osapi/osapi_type.h"
#endif
#ifndef osapi_heap_h
  #include "osapi/osapi_heap.h"
#endif

#ifndef osapi_utility_h
  #include "osapi/osapi_utility.h"
#endif

#ifndef cdr_type_h
  #include "cdr/cdr_type.h"
#endif

#ifndef cdr_type_object_h
  #include "cdr/cdr_typeObject.h"
#endif

#ifndef cdr_encapsulation_h
  #include "cdr/cdr_encapsulation.h"
#endif

#ifndef cdr_stream_h
  #include "cdr/cdr_stream.h"
#endif

#ifndef pres_typePlugin_h
  #include "pres/pres_typePlugin.h"
#endif



#include "ThroughputPlugin.h"



/* ------------------------------------------------------------------------
   Enum Type: ThroughputCommandKind
 * ------------------------------------------------------------------------- */
 
/* ------------------------------------------------------------------------
 * (De)Serialization Methods
 * ------------------------------------------------------------------------ */


RTIBool ThroughputCommandKindPlugin_serialize(
    PRESTypePluginEndpointData endpoint_data,
    const ThroughputCommandKind *sample,
    struct RTICdrStream *stream, 
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_sample,
    void *endpoint_plugin_qos)
{
    char * position = NULL;


    if (endpoint_data) {} /* To avoid warnings */
    if (endpoint_plugin_qos) {} /* To avoid warnings */



    if(serialize_encapsulation) {
        if (!RTICdrStream_serializeAndSetCdrEncapsulation(stream, encapsulation_id)) {
            return RTI_FALSE;
        }


        position = RTICdrStream_resetAlignment(stream);

    }

    if(serialize_sample) {

        if (!RTICdrStream_serializeEnum(stream, sample))
        {
            return RTI_FALSE;
        }

    }


    if(serialize_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }


    return RTI_TRUE;
}


RTIBool 
ThroughputCommandKindPlugin_deserialize_sample(
    PRESTypePluginEndpointData endpoint_data,
    ThroughputCommandKind *sample,
    struct RTICdrStream *stream, 
    RTIBool deserialize_encapsulation,  
    RTIBool deserialize_sample, 
    void *endpoint_plugin_qos)
{
    char * position = NULL;
 
    DDS_Enum enum_tmp; 

    if (endpoint_data) {} /* To avoid warnings */
    if (endpoint_plugin_qos) {} /* To avoid warnings */

    if(deserialize_encapsulation) {
        if (!RTICdrStream_deserializeAndSetCdrEncapsulation(stream)) {
            return RTI_FALSE;
        }


        position = RTICdrStream_resetAlignment(stream);

    }

    if(deserialize_sample) {
 
        if (!RTICdrStream_deserializeEnum(stream, &enum_tmp))
        {
            return RTI_FALSE;
        }
        switch (enum_tmp) {

            case THROUGHPUT_COMMAND_IDLE:
                *sample=THROUGHPUT_COMMAND_IDLE;
                break;
            case THROUGHPUT_COMMAND_START:
                *sample=THROUGHPUT_COMMAND_START;
                break;
            case THROUGHPUT_COMMAND_COMPLETE:
                *sample=THROUGHPUT_COMMAND_COMPLETE;
                break;
            default:
            {
                stream->_xTypesState.unassignable = RTI_TRUE;
                return RTI_FALSE;
            }
        }

    }


    if(deserialize_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }


    return RTI_TRUE;
}


RTIBool ThroughputCommandKindPlugin_skip(
    PRESTypePluginEndpointData endpoint_data,
    struct RTICdrStream *stream, 
    RTIBool skip_encapsulation,  
    RTIBool skip_sample, 
    void *endpoint_plugin_qos)
{
    char * position = NULL;


    if (endpoint_data) {} /* To avoid warnings */
    if (endpoint_plugin_qos) {} /* To avoid warnings */

    if(skip_encapsulation) {
        if (!RTICdrStream_skipEncapsulation(stream)) {
            return RTI_FALSE;
        }


        position = RTICdrStream_resetAlignment(stream);

    }

    if(skip_sample) {

        if (!RTICdrStream_skipEnum(stream)) {
            return RTI_FALSE;
        }


    }


    if(skip_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }


    return RTI_TRUE;
}


unsigned int ThroughputCommandKindPlugin_get_serialized_sample_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment)
{
    unsigned int initial_alignment = current_alignment;

    unsigned int encapsulation_size = current_alignment;


    if (endpoint_data) {} /* To avoid warnings */

    if (include_encapsulation) {
        if (!RTICdrEncapsulation_validEncapsulationId(encapsulation_id)) {
            return 1;
        }


        RTICdrStream_getEncapsulationSize(encapsulation_size);
        encapsulation_size -= current_alignment;
        current_alignment = 0;
        initial_alignment = 0;

    }

    current_alignment += RTICdrType_getEnumMaxSizeSerialized(current_alignment);


    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }


    return current_alignment - initial_alignment;
}


unsigned int ThroughputCommandKindPlugin_get_serialized_sample_min_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment)
{
    unsigned int initial_alignment = current_alignment;

    current_alignment += ThroughputCommandKindPlugin_get_serialized_sample_max_size(
        endpoint_data,include_encapsulation,
        encapsulation_id, current_alignment);

    return current_alignment - initial_alignment;
}


unsigned int
ThroughputCommandKindPlugin_get_serialized_sample_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment,
    const ThroughputCommandKind * sample) 
{
    unsigned int initial_alignment = current_alignment;

    if (sample) {} /* To avoid warnings */ 

    current_alignment += ThroughputCommandKindPlugin_get_serialized_sample_max_size(
        endpoint_data,include_encapsulation,
        encapsulation_id, current_alignment);

    return current_alignment - initial_alignment;
}






/* ------------------------------------------------------------------------
    Key Management functions:
 * ------------------------------------------------------------------------ */


RTIBool ThroughputCommandKindPlugin_serialize_key(
    PRESTypePluginEndpointData endpoint_data,
    const ThroughputCommandKind *sample, 
    struct RTICdrStream *stream, 
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_key,
    void *endpoint_plugin_qos)
{   
    return ThroughputCommandKindPlugin_serialize(
            endpoint_data, sample, stream, 
            serialize_encapsulation, encapsulation_id, 
            serialize_key, endpoint_plugin_qos);
}


RTIBool ThroughputCommandKindPlugin_deserialize_key_sample(
    PRESTypePluginEndpointData endpoint_data,
    ThroughputCommandKind *sample,
    struct RTICdrStream *stream, 
    RTIBool deserialize_encapsulation,  
    RTIBool deserialize_key, 
    void *endpoint_plugin_qos)
{   
    return ThroughputCommandKindPlugin_deserialize_sample(
            endpoint_data, sample, stream, deserialize_encapsulation, 
            deserialize_key, endpoint_plugin_qos);
}


unsigned int ThroughputCommandKindPlugin_get_serialized_key_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment)
{
    unsigned int initial_alignment = current_alignment;

    current_alignment += ThroughputCommandKindPlugin_get_serialized_sample_max_size(
        endpoint_data,include_encapsulation,
        encapsulation_id, current_alignment);

    return current_alignment - initial_alignment;
}


RTIBool 
ThroughputCommandKindPlugin_serialized_sample_to_key(
    PRESTypePluginEndpointData endpoint_data,
    ThroughputCommandKind *sample,
    struct RTICdrStream *stream, 
    RTIBool deserialize_encapsulation,  
    RTIBool deserialize_key, 
    void *endpoint_plugin_qos)
{    
    return ThroughputCommandKindPlugin_deserialize_sample(
            endpoint_data, sample, stream, deserialize_encapsulation, 
            deserialize_key, endpoint_plugin_qos);
}

 
/* ----------------------------------------------------------------------------
    Support functions:
 * ---------------------------------------------------------------------------- */


void ThroughputCommandKindPluginSupport_print_data(
    const ThroughputCommandKind *sample,
    const char *description, int indent_level)
{
    if (description != NULL) {
        RTICdrType_printIndent(indent_level);
        RTILog_debug("%s:\n", description);
    }

    if (sample == NULL) {
        RTICdrType_printIndent(indent_level+1);
        RTILog_debug("NULL\n");
        return;
    }

    RTICdrType_printEnum((RTICdrEnum *)sample, "ThroughputCommandKind", indent_level + 1);
}


/* --------------------------------------------------------------------------------------
 *  Type ThroughputCommand
 * -------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------
    Support functions:
 * -------------------------------------------------------------------------------------- */

ThroughputCommand*
ThroughputCommandPluginSupport_create_data_w_params(
    const struct DDS_TypeAllocationParams_t * alloc_params){
    ThroughputCommand *sample = NULL;

    RTIOsapiHeap_allocateStructure(
        &sample, ThroughputCommand);

    if(sample != NULL) {
        if (!ThroughputCommand_initialize_w_params(sample,alloc_params)) {
            RTIOsapiHeap_freeStructure(sample);
            return NULL;
        }
    }        
    return sample; 
}


ThroughputCommand *
ThroughputCommandPluginSupport_create_data_ex(RTIBool allocate_pointers){
    ThroughputCommand *sample = NULL;

    RTIOsapiHeap_allocateStructure(
        &sample, ThroughputCommand);

    if(sample != NULL) {
        if (!ThroughputCommand_initialize_ex(sample,allocate_pointers, RTI_TRUE)) {
            RTIOsapiHeap_freeStructure(sample);
            return NULL;
        }
    }        
    return sample; 
}


ThroughputCommand *
ThroughputCommandPluginSupport_create_data(void)
{
    return ThroughputCommandPluginSupport_create_data_ex(RTI_TRUE);
}


void 
ThroughputCommandPluginSupport_destroy_data_w_params(
    ThroughputCommand *sample,
    const struct DDS_TypeDeallocationParams_t * dealloc_params) {

    ThroughputCommand_finalize_w_params(sample,dealloc_params);

    RTIOsapiHeap_freeStructure(sample);
}


void 
ThroughputCommandPluginSupport_destroy_data_ex(
    ThroughputCommand *sample,RTIBool deallocate_pointers) {

    ThroughputCommand_finalize_ex(sample,deallocate_pointers);

    RTIOsapiHeap_freeStructure(sample);
}


void 
ThroughputCommandPluginSupport_destroy_data(
    ThroughputCommand *sample) {

    ThroughputCommandPluginSupport_destroy_data_ex(sample,RTI_TRUE);

}


RTIBool 
ThroughputCommandPluginSupport_copy_data(
    ThroughputCommand *dst,
    const ThroughputCommand *src)
{
    return ThroughputCommand_copy(dst,src);
}


void 
ThroughputCommandPluginSupport_print_data(
    const ThroughputCommand *sample,
    const char *desc,
    unsigned int indent_level)
{


    RTICdrType_printIndent(indent_level);

    if (desc != NULL) {
      RTILog_debug("%s:\n", desc);
    } else {
      RTILog_debug("\n");
    }

    if (sample == NULL) {
      RTILog_debug("NULL\n");
      return;
    }


    RTICdrType_printArray(
        sample->signature, (4), RTI_CDR_OCTET_SIZE,
        (RTICdrTypePrintFunction)RTICdrType_printOctet,
        "signature", indent_level + 1);
            

    ThroughputCommandKindPluginSupport_print_data(
        &sample->command, "command", indent_level + 1);
            

    RTICdrType_printUnsignedLong(
        &sample->data_length, "data_length", indent_level + 1);
            

    RTICdrType_printUnsignedLong(
        &sample->current_publisher_effort, "current_publisher_effort", indent_level + 1);
            

    RTICdrType_printUnsignedLong(
        &sample->final_publisher_effort, "final_publisher_effort", indent_level + 1);
            

    RTICdrType_printFloat(
        &sample->publisher_cpu_usage, "publisher_cpu_usage", indent_level + 1);
            


}


/* ----------------------------------------------------------------------------
    Callback functions:
 * ---------------------------------------------------------------------------- */



PRESTypePluginParticipantData 
ThroughputCommandPlugin_on_participant_attached(
    void *registration_data,
    const struct PRESTypePluginParticipantInfo *participant_info,
    RTIBool top_level_registration,
    void *container_plugin_context,
    RTICdrTypeCode *type_code)
{

    if (registration_data) {} /* To avoid warnings */
    if (participant_info) {} /* To avoid warnings */
    if (top_level_registration) {} /* To avoid warnings */
    if (container_plugin_context) {} /* To avoid warnings */
    if (type_code) {} /* To avoid warnings */
    return PRESTypePluginDefaultParticipantData_new(participant_info);

}


void 
ThroughputCommandPlugin_on_participant_detached(
    PRESTypePluginParticipantData participant_data)
{

  PRESTypePluginDefaultParticipantData_delete(participant_data);
}


PRESTypePluginEndpointData
ThroughputCommandPlugin_on_endpoint_attached(
    PRESTypePluginParticipantData participant_data,
    const struct PRESTypePluginEndpointInfo *endpoint_info,
    RTIBool top_level_registration, 
    void *containerPluginContext)
{
    PRESTypePluginEndpointData epd = NULL;

    unsigned int serializedSampleMaxSize;

   if (top_level_registration) {} /* To avoid warnings */
   if (containerPluginContext) {} /* To avoid warnings */

    epd = PRESTypePluginDefaultEndpointData_new(
            participant_data,
            endpoint_info,
            (PRESTypePluginDefaultEndpointDataCreateSampleFunction)
            ThroughputCommandPluginSupport_create_data,
            (PRESTypePluginDefaultEndpointDataDestroySampleFunction)
            ThroughputCommandPluginSupport_destroy_data,
            NULL, NULL);

    if (epd == NULL) {
        return NULL;
    }

    

    if (endpoint_info->endpointKind == PRES_TYPEPLUGIN_ENDPOINT_WRITER) {
        serializedSampleMaxSize = ThroughputCommandPlugin_get_serialized_sample_max_size(
            epd,RTI_FALSE,RTI_CDR_ENCAPSULATION_ID_CDR_BE,0);
            
        PRESTypePluginDefaultEndpointData_setMaxSizeSerializedSample(epd, serializedSampleMaxSize);

        if (PRESTypePluginDefaultEndpointData_createWriterPool(
                epd,
                endpoint_info,
            (PRESTypePluginGetSerializedSampleMaxSizeFunction)
                ThroughputCommandPlugin_get_serialized_sample_max_size, epd,
            (PRESTypePluginGetSerializedSampleSizeFunction)
            ThroughputCommandPlugin_get_serialized_sample_size,
            epd) == RTI_FALSE) {
            PRESTypePluginDefaultEndpointData_delete(epd);
            return NULL;
        }
    }
    


    return epd;    
}


void 
ThroughputCommandPlugin_on_endpoint_detached(
    PRESTypePluginEndpointData endpoint_data)
{  

    PRESTypePluginDefaultEndpointData_delete(endpoint_data);
}


void    
ThroughputCommandPlugin_return_sample(
    PRESTypePluginEndpointData endpoint_data,
    ThroughputCommand *sample,
    void *handle)
{
    
    ThroughputCommand_finalize_optional_members(sample, RTI_TRUE);
           
    PRESTypePluginDefaultEndpointData_returnSample(
        endpoint_data, sample, handle);
}
 


RTIBool 
ThroughputCommandPlugin_copy_sample(
    PRESTypePluginEndpointData endpoint_data,
    ThroughputCommand *dst,
    const ThroughputCommand *src)
{
    if (endpoint_data) {} /* To avoid warnings */
    return ThroughputCommandPluginSupport_copy_data(dst,src);
}

/* --------------------------------------------------------------------------------------
    (De)Serialize functions:
 * -------------------------------------------------------------------------------------- */

unsigned int 
ThroughputCommandPlugin_get_serialized_sample_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);


RTIBool 
ThroughputCommandPlugin_serialize(
    PRESTypePluginEndpointData endpoint_data,
    const ThroughputCommand *sample, 
    struct RTICdrStream *stream,    
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_sample, 
    void *endpoint_plugin_qos)
{
    char * position = NULL;
    RTIBool retval = RTI_TRUE;

    if (endpoint_data) {} /* To avoid warnings */
    if (endpoint_plugin_qos) {} /* To avoid warnings */


    if(serialize_encapsulation) {
  
        if (!RTICdrStream_serializeAndSetCdrEncapsulation(stream, encapsulation_id)) {
            return RTI_FALSE;
        }

        position = RTICdrStream_resetAlignment(stream);

    }


    if(serialize_sample) {
    
    if (!RTICdrStream_serializePrimitiveArray(
        stream, (void*)sample->signature, (4), RTI_CDR_OCTET_TYPE)) {
        return RTI_FALSE;
    }
            

    if (!ThroughputCommandKindPlugin_serialize(
            endpoint_data,
            &sample->command, 
            stream, 
            RTI_FALSE, encapsulation_id, 
            RTI_TRUE, 
            endpoint_plugin_qos)) {
        return RTI_FALSE;
    }
            

    if (!RTICdrStream_serializeUnsignedLong(
        stream, &sample->data_length)) {
        return RTI_FALSE;
    }
            

    if (!RTICdrStream_serializeUnsignedLong(
        stream, &sample->current_publisher_effort)) {
        return RTI_FALSE;
    }
            

    if (!RTICdrStream_serializeUnsignedLong(
        stream, &sample->final_publisher_effort)) {
        return RTI_FALSE;
    }
            

    if (!RTICdrStream_serializeFloat(
        stream, &sample->publisher_cpu_usage)) {
        return RTI_FALSE;
    }
            

    }


    if(serialize_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }


  return retval;
}


RTIBool 
ThroughputCommandPlugin_deserialize_sample(
    PRESTypePluginEndpointData endpoint_data,
    ThroughputCommand *sample,
    struct RTICdrStream *stream,   
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_sample, 
    void *endpoint_plugin_qos)
{
    char * position = NULL;

    RTIBool done = RTI_FALSE;

    if (endpoint_data) {} /* To avoid warnings */
    if (endpoint_plugin_qos) {} /* To avoid warnings */


    if(deserialize_encapsulation) {
        /* Deserialize encapsulation */
        if (!RTICdrStream_deserializeAndSetCdrEncapsulation(stream)) {
            return RTI_FALSE;
        }

        position = RTICdrStream_resetAlignment(stream);

    }
    
    
    if(deserialize_sample) {
        ThroughputCommand_initialize_ex(sample, RTI_FALSE, RTI_FALSE);
    
    if (!RTICdrStream_deserializePrimitiveArray(
        stream, (void*)sample->signature, (4), RTI_CDR_OCTET_TYPE)) {
        goto fin;
    }
            

    if (!ThroughputCommandKindPlugin_deserialize_sample(
            endpoint_data,
            &sample->command,
            stream, 
            RTI_FALSE, RTI_TRUE, 
            endpoint_plugin_qos)) {
        goto fin;
    }
            

    if (!RTICdrStream_deserializeUnsignedLong(
        stream, &sample->data_length)) {
        goto fin;
    }

    if (!RTICdrStream_deserializeUnsignedLong(
        stream, &sample->current_publisher_effort)) {
        goto fin;
    }

    if (!RTICdrStream_deserializeUnsignedLong(
        stream, &sample->final_publisher_effort)) {
        goto fin;
    }

    if (!RTICdrStream_deserializeFloat(
        stream, &sample->publisher_cpu_usage)) {
        goto fin;
    }

    }

    done = RTI_TRUE;
fin:
    if (done != RTI_TRUE && 
        RTICdrStream_getRemainder(stream) >=
            RTI_CDR_PARAMETER_HEADER_ALIGNMENT) {
        return RTI_FALSE;   
    }

    if(deserialize_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }


    return RTI_TRUE;
}

 
 

RTIBool 
ThroughputCommandPlugin_deserialize(
    PRESTypePluginEndpointData endpoint_data,
    ThroughputCommand **sample,
    RTIBool * drop_sample,
    struct RTICdrStream *stream,   
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_sample, 
    void *endpoint_plugin_qos)
{

    RTIBool result;
    if (drop_sample) {} /* To avoid warnings */
    
    stream->_xTypesState.unassignable = RTI_FALSE;

    result = ThroughputCommandPlugin_deserialize_sample( 
        endpoint_data, (sample != NULL)?*sample:NULL,
        stream, deserialize_encapsulation, deserialize_sample, 
        endpoint_plugin_qos);
        
    if (result) {
        if (stream->_xTypesState.unassignable) {
            result = RTI_FALSE;
        }
    }
    
    return result;
 
}




RTIBool ThroughputCommandPlugin_skip(
    PRESTypePluginEndpointData endpoint_data,
    struct RTICdrStream *stream,   
    RTIBool skip_encapsulation,
    RTIBool skip_sample, 
    void *endpoint_plugin_qos)
{
    char * position = NULL;

    RTIBool done = RTI_FALSE;

    if (endpoint_data) {} /* To avoid warnings */
    if (endpoint_plugin_qos) {} /* To avoid warnings */


    if(skip_encapsulation) {
        if (!RTICdrStream_skipEncapsulation(stream)) {
            return RTI_FALSE;
        }


        position = RTICdrStream_resetAlignment(stream);

    }

    if (skip_sample) {

    if (!RTICdrStream_skipPrimitiveArray(
        stream, (4), RTI_CDR_OCTET_TYPE)) {
        goto fin;
    }
            

    if (!ThroughputCommandKindPlugin_skip(
            endpoint_data,
            stream, 
            RTI_FALSE, RTI_TRUE, 
            endpoint_plugin_qos)) {
        goto fin;
    }
            

    if (!RTICdrStream_skipUnsignedLong(stream)) {
        goto fin;
    }
            

    if (!RTICdrStream_skipUnsignedLong(stream)) {
        goto fin;
    }
            

    if (!RTICdrStream_skipUnsignedLong(stream)) {
        goto fin;
    }
            

    if (!RTICdrStream_skipFloat(stream)) {
        goto fin;
    }
            


    }
    

    done = RTI_TRUE;
fin:
    if (done != RTI_TRUE && 
        RTICdrStream_getRemainder(stream) >=
            RTI_CDR_PARAMETER_HEADER_ALIGNMENT) {
        return RTI_FALSE;   
    }

    if(skip_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }


    return RTI_TRUE;
}


unsigned int 
ThroughputCommandPlugin_get_serialized_sample_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment)
{

    unsigned int initial_alignment = current_alignment;

    unsigned int encapsulation_size = current_alignment;

    if (endpoint_data) {} /* To avoid warnings */


    if (include_encapsulation) {

        if (!RTICdrEncapsulation_validEncapsulationId(encapsulation_id)) {
            return 1;
        }

        RTICdrStream_getEncapsulationSize(encapsulation_size);
        encapsulation_size -= current_alignment;
        current_alignment = 0;
        initial_alignment = 0;

    }


    current_alignment +=  RTICdrType_getPrimitiveArrayMaxSizeSerialized(
        current_alignment, (4), RTI_CDR_OCTET_TYPE);
            

    current_alignment +=  ThroughputCommandKindPlugin_get_serialized_sample_max_size(
        endpoint_data,RTI_FALSE,encapsulation_id,current_alignment);
            

    current_alignment +=  RTICdrType_getUnsignedLongMaxSizeSerialized(
        current_alignment);
            

    current_alignment +=  RTICdrType_getUnsignedLongMaxSizeSerialized(
        current_alignment);
            

    current_alignment +=  RTICdrType_getUnsignedLongMaxSizeSerialized(
        current_alignment);
            

    current_alignment +=  RTICdrType_getFloatMaxSizeSerialized(
        current_alignment);
            

    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }

    return current_alignment - initial_alignment;
}


unsigned int 
ThroughputCommandPlugin_get_serialized_sample_min_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment)
{

    unsigned int initial_alignment = current_alignment;

    unsigned int encapsulation_size = current_alignment;

    if (endpoint_data) {} /* To avoid warnings */


    if (include_encapsulation) {

        if (!RTICdrEncapsulation_validEncapsulationId(encapsulation_id)) {
            return 1;
        }

        RTICdrStream_getEncapsulationSize(encapsulation_size);
        encapsulation_size -= current_alignment;
        current_alignment = 0;
        initial_alignment = 0;

    }


    current_alignment +=  RTICdrType_getPrimitiveArrayMaxSizeSerialized(
        current_alignment, (4), RTI_CDR_OCTET_TYPE);
            

    current_alignment +=  ThroughputCommandKindPlugin_get_serialized_sample_min_size(
        endpoint_data,RTI_FALSE,encapsulation_id,current_alignment);
            

    current_alignment +=  RTICdrType_getUnsignedLongMaxSizeSerialized(
        current_alignment);
            

    current_alignment +=  RTICdrType_getUnsignedLongMaxSizeSerialized(
        current_alignment);
            

    current_alignment +=  RTICdrType_getUnsignedLongMaxSizeSerialized(
        current_alignment);
            

    current_alignment +=  RTICdrType_getFloatMaxSizeSerialized(
        current_alignment);
            

    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }

    return current_alignment - initial_alignment;
}


/* Returns the size of the sample in its serialized form (in bytes).
 * It can also be an estimation in excess of the real buffer needed 
 * during a call to the serialize() function.
 * The value reported does not have to include the space for the
 * encapsulation flags.
 */
unsigned int
ThroughputCommandPlugin_get_serialized_sample_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment,
    const ThroughputCommand * sample) 
{

    unsigned int initial_alignment = current_alignment;

    unsigned int encapsulation_size = current_alignment;

    if (endpoint_data) {} /* To avoid warnings */
    if (sample) {} /* To avoid warnings */


    if (include_encapsulation) {

        if (!RTICdrEncapsulation_validEncapsulationId(encapsulation_id)) {
            return 1;
        }

        RTICdrStream_getEncapsulationSize(encapsulation_size);
        encapsulation_size -= current_alignment;
        current_alignment = 0;
        initial_alignment = 0;

    }


    current_alignment += RTICdrType_getPrimitiveArrayMaxSizeSerialized(
        current_alignment, (4), RTI_CDR_OCTET_TYPE);
            

    current_alignment += ThroughputCommandKindPlugin_get_serialized_sample_size(
        endpoint_data,RTI_FALSE, encapsulation_id, 
        current_alignment, &sample->command);
            

    current_alignment += RTICdrType_getUnsignedLongMaxSizeSerialized(
        current_alignment);
            

    current_alignment += RTICdrType_getUnsignedLongMaxSizeSerialized(
        current_alignment);
            

    current_alignment += RTICdrType_getUnsignedLongMaxSizeSerialized(
        current_alignment);
            

    current_alignment += RTICdrType_getFloatMaxSizeSerialized(
        current_alignment);
            

    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }

    return current_alignment - initial_alignment;
}







/* --------------------------------------------------------------------------------------
    Key Management functions:
 * -------------------------------------------------------------------------------------- */


PRESTypePluginKeyKind 
ThroughputCommandPlugin_get_key_kind(void)
{

    return PRES_TYPEPLUGIN_NO_KEY;
     
}


RTIBool 
ThroughputCommandPlugin_serialize_key(
    PRESTypePluginEndpointData endpoint_data,
    const ThroughputCommand *sample, 
    struct RTICdrStream *stream,    
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_key,
    void *endpoint_plugin_qos)
{
    char * position = NULL;

    if (endpoint_data) {} /* To avoid warnings */
    if (endpoint_plugin_qos) {} /* To avoid warnings */


    if(serialize_encapsulation) {
    
        if (!RTICdrStream_serializeAndSetCdrEncapsulation(stream, encapsulation_id)) {
            return RTI_FALSE;
        }


        position = RTICdrStream_resetAlignment(stream);

    }

    if(serialize_key) {

        if (!ThroughputCommandPlugin_serialize(
                endpoint_data,
                sample,
                stream,
                RTI_FALSE, encapsulation_id,
                RTI_TRUE,
                endpoint_plugin_qos)) {
            return RTI_FALSE;
        }
    
    }


    if(serialize_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }


    return RTI_TRUE;
}


RTIBool ThroughputCommandPlugin_deserialize_key_sample(
    PRESTypePluginEndpointData endpoint_data,
    ThroughputCommand *sample, 
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_key,
    void *endpoint_plugin_qos)
{
    char * position = NULL;

    if (endpoint_data) {} /* To avoid warnings */
    if (endpoint_plugin_qos) {} /* To avoid warnings */


    if(deserialize_encapsulation) {
        /* Deserialize encapsulation */
        if (!RTICdrStream_deserializeAndSetCdrEncapsulation(stream)) {
            return RTI_FALSE;  
        }


        position = RTICdrStream_resetAlignment(stream);

    }

    if (deserialize_key) {

        if (!ThroughputCommandPlugin_deserialize_sample(
                endpoint_data, sample, stream,
                RTI_FALSE, RTI_TRUE, 
                endpoint_plugin_qos)) {
            return RTI_FALSE;
        }
    
    }


    if(deserialize_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }


    return RTI_TRUE;
}


 
RTIBool ThroughputCommandPlugin_deserialize_key(
    PRESTypePluginEndpointData endpoint_data,
    ThroughputCommand **sample, 
    RTIBool * drop_sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_key,
    void *endpoint_plugin_qos)
{
    RTIBool result;
    if (drop_sample) {} /* To avoid warnings */
    
    stream->_xTypesState.unassignable = RTI_FALSE;
    
    result = ThroughputCommandPlugin_deserialize_key_sample(
        endpoint_data, (sample != NULL)?*sample:NULL, stream,
        deserialize_encapsulation, deserialize_key, endpoint_plugin_qos);
        
    if (result) {
        if (stream->_xTypesState.unassignable) {
            result = RTI_FALSE;
        }
    }
    
    return result;
}



unsigned int
ThroughputCommandPlugin_get_serialized_key_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment)
{

    unsigned int encapsulation_size = current_alignment;


    unsigned int initial_alignment = current_alignment;


    if (endpoint_data) {} /* To avoid warnings */


    if (include_encapsulation) {
        if (!RTICdrEncapsulation_validEncapsulationId(encapsulation_id)) {
            return 1;
        }


        RTICdrStream_getEncapsulationSize(encapsulation_size);
        encapsulation_size -= current_alignment;
        current_alignment = 0;
        initial_alignment = 0;

    }
        

    current_alignment += ThroughputCommandPlugin_get_serialized_sample_max_size(
        endpoint_data,RTI_FALSE, encapsulation_id, current_alignment);
    
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }

    return current_alignment - initial_alignment;
}


RTIBool 
ThroughputCommandPlugin_serialized_sample_to_key(
    PRESTypePluginEndpointData endpoint_data,
    ThroughputCommand *sample,
    struct RTICdrStream *stream, 
    RTIBool deserialize_encapsulation,  
    RTIBool deserialize_key, 
    void *endpoint_plugin_qos)
{
    char * position = NULL;

    RTIBool done = RTI_FALSE;

    if (stream == NULL) goto fin; /* To avoid warnings */


    if(deserialize_encapsulation) {
        if (!RTICdrStream_deserializeAndSetCdrEncapsulation(stream)) {
            return RTI_FALSE;
        }

        position = RTICdrStream_resetAlignment(stream);

    }

    if (deserialize_key) {

        if (!ThroughputCommandPlugin_deserialize_sample(
            endpoint_data, sample, stream, RTI_FALSE, 
            RTI_TRUE, endpoint_plugin_qos)) {
            return RTI_FALSE;
        }

    }


    done = RTI_TRUE;
fin:
    if (done != RTI_TRUE && 
        RTICdrStream_getRemainder(stream) >=
            RTI_CDR_PARAMETER_HEADER_ALIGNMENT) {
        return RTI_FALSE;   
    }

    if(deserialize_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }


    return RTI_TRUE;
}




/* ------------------------------------------------------------------------
 * Plug-in Installation Methods
 * ------------------------------------------------------------------------ */
 
struct PRESTypePlugin *ThroughputCommandPlugin_new(void) 
{ 
    struct PRESTypePlugin *plugin = NULL;
    const struct PRESTypePluginVersion PLUGIN_VERSION = 
        PRES_TYPE_PLUGIN_VERSION_2_0;

    RTIOsapiHeap_allocateStructure(
        &plugin, struct PRESTypePlugin);
    if (plugin == NULL) {
       return NULL;
    }

    plugin->version = PLUGIN_VERSION;

    /* set up parent's function pointers */
    plugin->onParticipantAttached =
        (PRESTypePluginOnParticipantAttachedCallback)
        ThroughputCommandPlugin_on_participant_attached;
    plugin->onParticipantDetached =
        (PRESTypePluginOnParticipantDetachedCallback)
        ThroughputCommandPlugin_on_participant_detached;
    plugin->onEndpointAttached =
        (PRESTypePluginOnEndpointAttachedCallback)
        ThroughputCommandPlugin_on_endpoint_attached;
    plugin->onEndpointDetached =
        (PRESTypePluginOnEndpointDetachedCallback)
        ThroughputCommandPlugin_on_endpoint_detached;

    plugin->copySampleFnc =
        (PRESTypePluginCopySampleFunction)
        ThroughputCommandPlugin_copy_sample;
    plugin->createSampleFnc =
        (PRESTypePluginCreateSampleFunction)
        ThroughputCommandPlugin_create_sample;
    plugin->destroySampleFnc =
        (PRESTypePluginDestroySampleFunction)
        ThroughputCommandPlugin_destroy_sample;

    plugin->serializeFnc =
        (PRESTypePluginSerializeFunction)
        ThroughputCommandPlugin_serialize;
    plugin->deserializeFnc =
        (PRESTypePluginDeserializeFunction)
        ThroughputCommandPlugin_deserialize;
    plugin->getSerializedSampleMaxSizeFnc =
        (PRESTypePluginGetSerializedSampleMaxSizeFunction)
        ThroughputCommandPlugin_get_serialized_sample_max_size;
    plugin->getSerializedSampleMinSizeFnc =
        (PRESTypePluginGetSerializedSampleMinSizeFunction)
        ThroughputCommandPlugin_get_serialized_sample_min_size;


    plugin->getSampleFnc =
        (PRESTypePluginGetSampleFunction)
        ThroughputCommandPlugin_get_sample;
    plugin->returnSampleFnc =
        (PRESTypePluginReturnSampleFunction)
        ThroughputCommandPlugin_return_sample;

    plugin->getKeyKindFnc =
        (PRESTypePluginGetKeyKindFunction)
        ThroughputCommandPlugin_get_key_kind;

 
    /* These functions are only used for keyed types. As this is not a keyed
    type they are all set to NULL
    */
    plugin->serializeKeyFnc = NULL;
    plugin->deserializeKeyFnc = NULL;
    plugin->getKeyFnc = NULL;
    plugin->returnKeyFnc = NULL;
    plugin->instanceToKeyFnc = NULL;
    plugin->keyToInstanceFnc = NULL;
    plugin->getSerializedKeyMaxSizeFnc = NULL;
    plugin->instanceToKeyHashFnc = NULL;
    plugin->serializedSampleToKeyHashFnc = NULL;
    plugin->serializedKeyToKeyHashFnc = NULL;
    
    plugin->typeCode = NULL; 
    
    plugin->languageKind = PRES_TYPEPLUGIN_DDS_TYPE; 

    /* Serialized buffer */
    plugin->getBuffer = 
        (PRESTypePluginGetBufferFunction)
        ThroughputCommandPlugin_get_buffer;
    plugin->returnBuffer = 
        (PRESTypePluginReturnBufferFunction)
        ThroughputCommandPlugin_return_buffer;
    plugin->getSerializedSampleSizeFnc =
        (PRESTypePluginGetSerializedSampleSizeFunction)
        ThroughputCommandPlugin_get_serialized_sample_size;

    plugin->endpointTypeName = ThroughputCommandTYPENAME;

    return plugin;
}

void
ThroughputCommandPlugin_delete(struct PRESTypePlugin *plugin)
{
    RTIOsapiHeap_freeStructure(plugin);
} 

/* --------------------------------------------------------------------------------------
 *  Type Throughput
 * -------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------
    Support functions:
 * -------------------------------------------------------------------------------------- */

Throughput*
ThroughputPluginSupport_create_data_w_params(
    const struct DDS_TypeAllocationParams_t * alloc_params){
    Throughput *sample = NULL;

    RTIOsapiHeap_allocateStructure(
        &sample, Throughput);

    if(sample != NULL) {
        if (!Throughput_initialize_w_params(sample,alloc_params)) {
            RTIOsapiHeap_freeStructure(sample);
            return NULL;
        }
    }        
    return sample; 
}


Throughput *
ThroughputPluginSupport_create_data_ex(RTIBool allocate_pointers){
    Throughput *sample = NULL;

    RTIOsapiHeap_allocateStructure(
        &sample, Throughput);

    if(sample != NULL) {
        if (!Throughput_initialize_ex(sample,allocate_pointers, RTI_TRUE)) {
            RTIOsapiHeap_freeStructure(sample);
            return NULL;
        }
    }        
    return sample; 
}


Throughput *
ThroughputPluginSupport_create_data(void)
{
    return ThroughputPluginSupport_create_data_ex(RTI_TRUE);
}


void 
ThroughputPluginSupport_destroy_data_w_params(
    Throughput *sample,
    const struct DDS_TypeDeallocationParams_t * dealloc_params) {

    Throughput_finalize_w_params(sample,dealloc_params);

    RTIOsapiHeap_freeStructure(sample);
}


void 
ThroughputPluginSupport_destroy_data_ex(
    Throughput *sample,RTIBool deallocate_pointers) {

    Throughput_finalize_ex(sample,deallocate_pointers);

    RTIOsapiHeap_freeStructure(sample);
}


void 
ThroughputPluginSupport_destroy_data(
    Throughput *sample) {

    ThroughputPluginSupport_destroy_data_ex(sample,RTI_TRUE);

}


RTIBool 
ThroughputPluginSupport_copy_data(
    Throughput *dst,
    const Throughput *src)
{
    return Throughput_copy(dst,src);
}


void 
ThroughputPluginSupport_print_data(
    const Throughput *sample,
    const char *desc,
    unsigned int indent_level)
{


    RTICdrType_printIndent(indent_level);

    if (desc != NULL) {
      RTILog_debug("%s:\n", desc);
    } else {
      RTILog_debug("\n");
    }

    if (sample == NULL) {
      RTILog_debug("NULL\n");
      return;
    }


    RTICdrType_printLong(
        &sample->key, "key", indent_level + 1);
            

    RTICdrType_printUnsignedLong(
        &sample->sequence_number, "sequence_number", indent_level + 1);
            

    if (&sample->data == NULL) {
        RTICdrType_printIndent(indent_level+1);
        RTILog_debug("data: NULL\n");    
    } else {
    
        if (DDS_OctetSeq_get_contiguous_bufferI(&sample->data) != NULL) {
            RTICdrType_printArray(
                DDS_OctetSeq_get_contiguous_bufferI(&sample->data),
                DDS_OctetSeq_get_length(&sample->data),
                RTI_CDR_OCTET_SIZE,
                (RTICdrTypePrintFunction)RTICdrType_printOctet,
                "data", indent_level + 1);
        } else {
            RTICdrType_printPointerArray(
                DDS_OctetSeq_get_discontiguous_bufferI(&sample->data),
                DDS_OctetSeq_get_length(&sample->data),
               (RTICdrTypePrintFunction)RTICdrType_printOctet,
               "data", indent_level + 1);
        }
    
    }
            


}

Throughput *
ThroughputPluginSupport_create_key_ex(RTIBool allocate_pointers){
    Throughput *key = NULL;

    RTIOsapiHeap_allocateStructure(
        &key, ThroughputKeyHolder);

    Throughput_initialize_ex(key,allocate_pointers,RTI_TRUE);
    return key;
}


Throughput *
ThroughputPluginSupport_create_key(void)
{
    return  ThroughputPluginSupport_create_key_ex(RTI_TRUE);
}


void 
ThroughputPluginSupport_destroy_key_ex(
    ThroughputKeyHolder *key,RTIBool deallocate_pointers)
{
    Throughput_finalize_ex(key,deallocate_pointers);

    RTIOsapiHeap_freeStructure(key);
}


void 
ThroughputPluginSupport_destroy_key(
    ThroughputKeyHolder *key) {

  ThroughputPluginSupport_destroy_key_ex(key,RTI_TRUE);

}


/* ----------------------------------------------------------------------------
    Callback functions:
 * ---------------------------------------------------------------------------- */



PRESTypePluginParticipantData 
ThroughputPlugin_on_participant_attached(
    void *registration_data,
    const struct PRESTypePluginParticipantInfo *participant_info,
    RTIBool top_level_registration,
    void *container_plugin_context,
    RTICdrTypeCode *type_code)
{

    if (registration_data) {} /* To avoid warnings */
    if (participant_info) {} /* To avoid warnings */
    if (top_level_registration) {} /* To avoid warnings */
    if (container_plugin_context) {} /* To avoid warnings */
    if (type_code) {} /* To avoid warnings */
    return PRESTypePluginDefaultParticipantData_new(participant_info);

}


void 
ThroughputPlugin_on_participant_detached(
    PRESTypePluginParticipantData participant_data)
{

  PRESTypePluginDefaultParticipantData_delete(participant_data);
}


PRESTypePluginEndpointData
ThroughputPlugin_on_endpoint_attached(
    PRESTypePluginParticipantData participant_data,
    const struct PRESTypePluginEndpointInfo *endpoint_info,
    RTIBool top_level_registration, 
    void *containerPluginContext)
{
    PRESTypePluginEndpointData epd = NULL;

    unsigned int serializedSampleMaxSize;

    unsigned int serializedKeyMaxSize;

    if (top_level_registration) {} /* To avoid warnings */
    if (containerPluginContext) {} /* To avoid warnings */


    epd = PRESTypePluginDefaultEndpointData_new(
            participant_data,
            endpoint_info,
            (PRESTypePluginDefaultEndpointDataCreateSampleFunction)
            ThroughputPluginSupport_create_data,
            (PRESTypePluginDefaultEndpointDataDestroySampleFunction)
            ThroughputPluginSupport_destroy_data,
            (PRESTypePluginDefaultEndpointDataCreateKeyFunction)
            ThroughputPluginSupport_create_key,
            (PRESTypePluginDefaultEndpointDataDestroyKeyFunction)
            ThroughputPluginSupport_destroy_key);

    if (epd == NULL) {
        return NULL;
    }
   
    serializedKeyMaxSize = ThroughputPlugin_get_serialized_key_max_size(
        epd,RTI_FALSE,RTI_CDR_ENCAPSULATION_ID_CDR_BE,0);
    
    if (!PRESTypePluginDefaultEndpointData_createMD5Stream(
            epd,serializedKeyMaxSize)) 
    {
        PRESTypePluginDefaultEndpointData_delete(epd);
        return NULL;
    }
    
    

    if (endpoint_info->endpointKind == PRES_TYPEPLUGIN_ENDPOINT_WRITER) {
        serializedSampleMaxSize = ThroughputPlugin_get_serialized_sample_max_size(
            epd,RTI_FALSE,RTI_CDR_ENCAPSULATION_ID_CDR_BE,0);
            
        PRESTypePluginDefaultEndpointData_setMaxSizeSerializedSample(epd, serializedSampleMaxSize);

        if (PRESTypePluginDefaultEndpointData_createWriterPool(
                epd,
                endpoint_info,
            (PRESTypePluginGetSerializedSampleMaxSizeFunction)
                ThroughputPlugin_get_serialized_sample_max_size, epd,
            (PRESTypePluginGetSerializedSampleSizeFunction)
            ThroughputPlugin_get_serialized_sample_size,
            epd) == RTI_FALSE) {
            PRESTypePluginDefaultEndpointData_delete(epd);
            return NULL;
        }
    }
    


    return epd;    
}


void 
ThroughputPlugin_on_endpoint_detached(
    PRESTypePluginEndpointData endpoint_data)
{  

    PRESTypePluginDefaultEndpointData_delete(endpoint_data);
}


void    
ThroughputPlugin_return_sample(
    PRESTypePluginEndpointData endpoint_data,
    Throughput *sample,
    void *handle)
{
    
    Throughput_finalize_optional_members(sample, RTI_TRUE);
           
    PRESTypePluginDefaultEndpointData_returnSample(
        endpoint_data, sample, handle);
}
 


RTIBool 
ThroughputPlugin_copy_sample(
    PRESTypePluginEndpointData endpoint_data,
    Throughput *dst,
    const Throughput *src)
{
    if (endpoint_data) {} /* To avoid warnings */
    return ThroughputPluginSupport_copy_data(dst,src);
}

/* --------------------------------------------------------------------------------------
    (De)Serialize functions:
 * -------------------------------------------------------------------------------------- */

unsigned int 
ThroughputPlugin_get_serialized_sample_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);


RTIBool 
ThroughputPlugin_serialize(
    PRESTypePluginEndpointData endpoint_data,
    const Throughput *sample, 
    struct RTICdrStream *stream,    
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_sample, 
    void *endpoint_plugin_qos)
{
    char * position = NULL;
    RTIBool retval = RTI_TRUE;

    if (endpoint_data) {} /* To avoid warnings */
    if (endpoint_plugin_qos) {} /* To avoid warnings */


    if(serialize_encapsulation) {
  
        if (!RTICdrStream_serializeAndSetCdrEncapsulation(stream, encapsulation_id)) {
            return RTI_FALSE;
        }

        position = RTICdrStream_resetAlignment(stream);

    }


    if(serialize_sample) {
    
    if (!RTICdrStream_serializeLong(
        stream, &sample->key)) {
        return RTI_FALSE;
    }
            

    if (!RTICdrStream_serializeUnsignedLong(
        stream, &sample->sequence_number)) {
        return RTI_FALSE;
    }
            

    if (DDS_OctetSeq_get_contiguous_bufferI(&sample->data) != NULL) {
        if (!RTICdrStream_serializePrimitiveSequence(
            stream,
            DDS_OctetSeq_get_contiguous_bufferI(&sample->data),
            DDS_OctetSeq_get_length(&sample->data),
            ((THROUGHPUT_TEST_PACKET_DATA_SIZE_MAX)),
            RTI_CDR_OCTET_TYPE)) {
            return RTI_FALSE;
        }
    } else {
        if (!RTICdrStream_serializePrimitivePointerSequence(
            stream,
            (const void **)DDS_OctetSeq_get_discontiguous_bufferI(&sample->data),
            DDS_OctetSeq_get_length(&sample->data),
            ((THROUGHPUT_TEST_PACKET_DATA_SIZE_MAX)),
            RTI_CDR_OCTET_TYPE)) {
            return RTI_FALSE;
        }
    }
            

    }


    if(serialize_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }


  return retval;
}


RTIBool 
ThroughputPlugin_deserialize_sample(
    PRESTypePluginEndpointData endpoint_data,
    Throughput *sample,
    struct RTICdrStream *stream,   
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_sample, 
    void *endpoint_plugin_qos)
{
    char * position = NULL;

    RTIBool done = RTI_FALSE;

    if (endpoint_data) {} /* To avoid warnings */
    if (endpoint_plugin_qos) {} /* To avoid warnings */


    if(deserialize_encapsulation) {
        /* Deserialize encapsulation */
        if (!RTICdrStream_deserializeAndSetCdrEncapsulation(stream)) {
            return RTI_FALSE;
        }

        position = RTICdrStream_resetAlignment(stream);

    }
    
    
    if(deserialize_sample) {
        Throughput_initialize_ex(sample, RTI_FALSE, RTI_FALSE);
    
    if (!RTICdrStream_deserializeLong(
        stream, &sample->key)) {
        goto fin;
    }

    if (!RTICdrStream_deserializeUnsignedLong(
        stream, &sample->sequence_number)) {
        goto fin;
    }

    {
        RTICdrUnsignedLong sequence_length;

        if (DDS_OctetSeq_get_contiguous_bufferI(&sample->data) != NULL) {
            if (!RTICdrStream_deserializePrimitiveSequence(
                stream,
                DDS_OctetSeq_get_contiguous_bufferI(&sample->data),
                &sequence_length,
                DDS_OctetSeq_get_maximum(&sample->data),
                RTI_CDR_OCTET_TYPE)) {
                goto fin;
            }
        } else {
            if (!RTICdrStream_deserializePrimitivePointerSequence(
                stream,
                (void **)DDS_OctetSeq_get_discontiguous_bufferI(&sample->data),
                &sequence_length,
                DDS_OctetSeq_get_maximum(&sample->data),
                RTI_CDR_OCTET_TYPE)) {
                goto fin;
            }
        }
        if (!DDS_OctetSeq_set_length(&sample->data, sequence_length)) {
            return RTI_FALSE;
        }
    }
            

    }

    done = RTI_TRUE;
fin:
    if (done != RTI_TRUE && 
        RTICdrStream_getRemainder(stream) >=
            RTI_CDR_PARAMETER_HEADER_ALIGNMENT) {
        return RTI_FALSE;   
    }

    if(deserialize_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }


    return RTI_TRUE;
}

 
 

RTIBool 
ThroughputPlugin_deserialize(
    PRESTypePluginEndpointData endpoint_data,
    Throughput **sample,
    RTIBool * drop_sample,
    struct RTICdrStream *stream,   
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_sample, 
    void *endpoint_plugin_qos)
{

    RTIBool result;
    if (drop_sample) {} /* To avoid warnings */
    
    stream->_xTypesState.unassignable = RTI_FALSE;

    result = ThroughputPlugin_deserialize_sample( 
        endpoint_data, (sample != NULL)?*sample:NULL,
        stream, deserialize_encapsulation, deserialize_sample, 
        endpoint_plugin_qos);
        
    if (result) {
        if (stream->_xTypesState.unassignable) {
            result = RTI_FALSE;
        }
    }
    
    return result;
 
}




RTIBool ThroughputPlugin_skip(
    PRESTypePluginEndpointData endpoint_data,
    struct RTICdrStream *stream,   
    RTIBool skip_encapsulation,
    RTIBool skip_sample, 
    void *endpoint_plugin_qos)
{
    char * position = NULL;

    RTIBool done = RTI_FALSE;

    if (endpoint_data) {} /* To avoid warnings */
    if (endpoint_plugin_qos) {} /* To avoid warnings */


    if(skip_encapsulation) {
        if (!RTICdrStream_skipEncapsulation(stream)) {
            return RTI_FALSE;
        }


        position = RTICdrStream_resetAlignment(stream);

    }

    if (skip_sample) {

    if (!RTICdrStream_skipLong(stream)) {
        goto fin;
    }
            

    if (!RTICdrStream_skipUnsignedLong(stream)) {
        goto fin;
    }
            

    {
        RTICdrUnsignedLong sequence_length;

        if (!RTICdrStream_skipPrimitiveSequence(
            stream,
            &sequence_length,
            RTI_CDR_OCTET_TYPE)) {
            goto fin;
        }
    }
            


    }
    

    done = RTI_TRUE;
fin:
    if (done != RTI_TRUE && 
        RTICdrStream_getRemainder(stream) >=
            RTI_CDR_PARAMETER_HEADER_ALIGNMENT) {
        return RTI_FALSE;   
    }

    if(skip_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }


    return RTI_TRUE;
}


unsigned int 
ThroughputPlugin_get_serialized_sample_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment)
{

    unsigned int initial_alignment = current_alignment;

    unsigned int encapsulation_size = current_alignment;

    if (endpoint_data) {} /* To avoid warnings */


    if (include_encapsulation) {

        if (!RTICdrEncapsulation_validEncapsulationId(encapsulation_id)) {
            return 1;
        }

        RTICdrStream_getEncapsulationSize(encapsulation_size);
        encapsulation_size -= current_alignment;
        current_alignment = 0;
        initial_alignment = 0;

    }


    current_alignment +=  RTICdrType_getLongMaxSizeSerialized(
        current_alignment);
            

    current_alignment +=  RTICdrType_getUnsignedLongMaxSizeSerialized(
        current_alignment);
            

    current_alignment +=  RTICdrType_getPrimitiveSequenceMaxSizeSerialized(
        current_alignment, ((THROUGHPUT_TEST_PACKET_DATA_SIZE_MAX)), RTI_CDR_OCTET_TYPE);
            

    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }

    return current_alignment - initial_alignment;
}


unsigned int 
ThroughputPlugin_get_serialized_sample_min_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment)
{

    unsigned int initial_alignment = current_alignment;

    unsigned int encapsulation_size = current_alignment;

    if (endpoint_data) {} /* To avoid warnings */


    if (include_encapsulation) {

        if (!RTICdrEncapsulation_validEncapsulationId(encapsulation_id)) {
            return 1;
        }

        RTICdrStream_getEncapsulationSize(encapsulation_size);
        encapsulation_size -= current_alignment;
        current_alignment = 0;
        initial_alignment = 0;

    }


    current_alignment +=  RTICdrType_getLongMaxSizeSerialized(
        current_alignment);
            

    current_alignment +=  RTICdrType_getUnsignedLongMaxSizeSerialized(
        current_alignment);
            

    current_alignment +=  RTICdrType_getPrimitiveSequenceMaxSizeSerialized(
        current_alignment, 0, RTI_CDR_OCTET_TYPE);
            

    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }

    return current_alignment - initial_alignment;
}


/* Returns the size of the sample in its serialized form (in bytes).
 * It can also be an estimation in excess of the real buffer needed 
 * during a call to the serialize() function.
 * The value reported does not have to include the space for the
 * encapsulation flags.
 */
unsigned int
ThroughputPlugin_get_serialized_sample_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment,
    const Throughput * sample) 
{

    unsigned int initial_alignment = current_alignment;

    unsigned int encapsulation_size = current_alignment;

    if (endpoint_data) {} /* To avoid warnings */
    if (sample) {} /* To avoid warnings */


    if (include_encapsulation) {

        if (!RTICdrEncapsulation_validEncapsulationId(encapsulation_id)) {
            return 1;
        }

        RTICdrStream_getEncapsulationSize(encapsulation_size);
        encapsulation_size -= current_alignment;
        current_alignment = 0;
        initial_alignment = 0;

    }


    current_alignment += RTICdrType_getLongMaxSizeSerialized(
        current_alignment);
            

    current_alignment += RTICdrType_getUnsignedLongMaxSizeSerialized(
        current_alignment);
            

    current_alignment += RTICdrType_getPrimitiveSequenceSerializedSize(
        current_alignment, 
        DDS_OctetSeq_get_length(&sample->data),
        RTI_CDR_OCTET_TYPE);
            

    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }

    return current_alignment - initial_alignment;
}







/* --------------------------------------------------------------------------------------
    Key Management functions:
 * -------------------------------------------------------------------------------------- */


PRESTypePluginKeyKind 
ThroughputPlugin_get_key_kind(void)
{

    return PRES_TYPEPLUGIN_USER_KEY;
     
}


RTIBool 
ThroughputPlugin_serialize_key(
    PRESTypePluginEndpointData endpoint_data,
    const Throughput *sample, 
    struct RTICdrStream *stream,    
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_key,
    void *endpoint_plugin_qos)
{
    char * position = NULL;

    if (endpoint_data) {} /* To avoid warnings */
    if (endpoint_plugin_qos) {} /* To avoid warnings */


    if(serialize_encapsulation) {
    
        if (!RTICdrStream_serializeAndSetCdrEncapsulation(stream, encapsulation_id)) {
            return RTI_FALSE;
        }


        position = RTICdrStream_resetAlignment(stream);

    }

    if(serialize_key) {

    if (!RTICdrStream_serializeLong(
        stream, &sample->key)) {
        return RTI_FALSE;
    }
            

    }


    if(serialize_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }


    return RTI_TRUE;
}


RTIBool ThroughputPlugin_deserialize_key_sample(
    PRESTypePluginEndpointData endpoint_data,
    Throughput *sample, 
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_key,
    void *endpoint_plugin_qos)
{
    char * position = NULL;

    if (endpoint_data) {} /* To avoid warnings */
    if (endpoint_plugin_qos) {} /* To avoid warnings */


    if(deserialize_encapsulation) {
        /* Deserialize encapsulation */
        if (!RTICdrStream_deserializeAndSetCdrEncapsulation(stream)) {
            return RTI_FALSE;  
        }


        position = RTICdrStream_resetAlignment(stream);

    }

    if (deserialize_key) {

    if (!RTICdrStream_deserializeLong(
        stream, &sample->key)) {
        return RTI_FALSE;
    }

    }


    if(deserialize_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }


    return RTI_TRUE;
}


 
RTIBool ThroughputPlugin_deserialize_key(
    PRESTypePluginEndpointData endpoint_data,
    Throughput **sample, 
    RTIBool * drop_sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_key,
    void *endpoint_plugin_qos)
{
    RTIBool result;
    if (drop_sample) {} /* To avoid warnings */
    
    stream->_xTypesState.unassignable = RTI_FALSE;
    
    result = ThroughputPlugin_deserialize_key_sample(
        endpoint_data, (sample != NULL)?*sample:NULL, stream,
        deserialize_encapsulation, deserialize_key, endpoint_plugin_qos);
        
    if (result) {
        if (stream->_xTypesState.unassignable) {
            result = RTI_FALSE;
        }
    }
    
    return result;
}



unsigned int
ThroughputPlugin_get_serialized_key_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment)
{

    unsigned int encapsulation_size = current_alignment;


    unsigned int initial_alignment = current_alignment;


    if (endpoint_data) {} /* To avoid warnings */


    if (include_encapsulation) {
        if (!RTICdrEncapsulation_validEncapsulationId(encapsulation_id)) {
            return 1;
        }


        RTICdrStream_getEncapsulationSize(encapsulation_size);
        encapsulation_size -= current_alignment;
        current_alignment = 0;
        initial_alignment = 0;

    }
        

    current_alignment +=  RTICdrType_getLongMaxSizeSerialized(
        current_alignment);
            

    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }

    return current_alignment - initial_alignment;
}


RTIBool 
ThroughputPlugin_serialized_sample_to_key(
    PRESTypePluginEndpointData endpoint_data,
    Throughput *sample,
    struct RTICdrStream *stream, 
    RTIBool deserialize_encapsulation,  
    RTIBool deserialize_key, 
    void *endpoint_plugin_qos)
{
    char * position = NULL;

    RTIBool done = RTI_FALSE;

    if (endpoint_data) {} /* To avoid warnings */
    if (endpoint_plugin_qos) {} /* To avoid warnings */

    if (stream == NULL) goto fin; /* To avoid warnings */


    if(deserialize_encapsulation) {
        if (!RTICdrStream_deserializeAndSetCdrEncapsulation(stream)) {
            return RTI_FALSE;
        }

        position = RTICdrStream_resetAlignment(stream);

    }

    if (deserialize_key) {

    if (!RTICdrStream_deserializeLong(
        stream, &sample->key)) {
        return RTI_FALSE;
    }

    if (!RTICdrStream_skipUnsignedLong(stream)) {
        goto fin;
    }
            

    {
        RTICdrUnsignedLong sequence_length;

        if (!RTICdrStream_skipPrimitiveSequence(
            stream,
            &sequence_length,
            RTI_CDR_OCTET_TYPE)) {
            goto fin;
        }
    }
            

    }


    done = RTI_TRUE;
fin:
    if (done != RTI_TRUE && 
        RTICdrStream_getRemainder(stream) >=
            RTI_CDR_PARAMETER_HEADER_ALIGNMENT) {
        return RTI_FALSE;   
    }

    if(deserialize_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }


    return RTI_TRUE;
}





RTIBool 
ThroughputPlugin_instance_to_key(
    PRESTypePluginEndpointData endpoint_data,
    ThroughputKeyHolder *dst, 
    const Throughput *src)
{  

    if (endpoint_data) {} /* To avoid warnings */

    if (!RTICdrType_copyLong(
        &dst->key, &src->key)) {
        return RTI_FALSE;
    }
            

    return RTI_TRUE;
}


RTIBool 
ThroughputPlugin_key_to_instance(
    PRESTypePluginEndpointData endpoint_data,
    Throughput *dst, const
    ThroughputKeyHolder *src)
{

    if (endpoint_data) {} /* To avoid warnings */

    if (!RTICdrType_copyLong(
        &dst->key, &src->key)) {
        return RTI_FALSE;
    }
            

    return RTI_TRUE;
}


RTIBool 
ThroughputPlugin_instance_to_keyhash(
    PRESTypePluginEndpointData endpoint_data,
    DDS_KeyHash_t *keyhash,
    const Throughput *instance)
{
    struct RTICdrStream * md5Stream = NULL;

    md5Stream = PRESTypePluginDefaultEndpointData_getMD5Stream(endpoint_data);

    if (md5Stream == NULL) {
        return RTI_FALSE;
    }

    RTIOsapiMemory_zero(
        RTICdrStream_getBuffer(md5Stream),
        RTICdrStream_getBufferLength(md5Stream));
    RTICdrStream_resetPosition(md5Stream);
    RTICdrStream_setDirtyBit(md5Stream, RTI_TRUE);

    if (!ThroughputPlugin_serialize_key(
            endpoint_data,instance,md5Stream, RTI_FALSE, RTI_CDR_ENCAPSULATION_ID_CDR_BE, RTI_TRUE,NULL)) {
        return RTI_FALSE;
    }
    
    if (PRESTypePluginDefaultEndpointData_getMaxSizeSerializedKey(endpoint_data) > (unsigned int)(MIG_RTPS_KEY_HASH_MAX_LENGTH)) {
        RTICdrStream_computeMD5(md5Stream, keyhash->value);
    } else {
        RTIOsapiMemory_zero(keyhash->value,MIG_RTPS_KEY_HASH_MAX_LENGTH);
        RTIOsapiMemory_copy(
            keyhash->value, 
            RTICdrStream_getBuffer(md5Stream), 
            RTICdrStream_getCurrentPositionOffset(md5Stream));
    }

    keyhash->length = MIG_RTPS_KEY_HASH_MAX_LENGTH;
    return RTI_TRUE;
}


RTIBool 
ThroughputPlugin_serialized_sample_to_keyhash(
    PRESTypePluginEndpointData endpoint_data,
    struct RTICdrStream *stream, 
    DDS_KeyHash_t *keyhash,
    RTIBool deserialize_encapsulation,
    void *endpoint_plugin_qos) 
{   
    char * position = NULL;

    RTIBool done = RTI_FALSE;
    Throughput * sample = NULL;

    if (endpoint_plugin_qos) {} /* To avoid warnings */


    if (stream == NULL) goto fin; /* To avoid warnings */


    if(deserialize_encapsulation) {
        if (!RTICdrStream_deserializeAndSetCdrEncapsulation(stream)) {
            return RTI_FALSE;
        }

        position = RTICdrStream_resetAlignment(stream);
    }


    sample = (Throughput *)
                PRESTypePluginDefaultEndpointData_getTempSample(endpoint_data);

    if (sample == NULL) {
        return RTI_FALSE;
    }


    if (!RTICdrStream_deserializeLong(
        stream, &sample->key)) {
        return RTI_FALSE;
    }

    done = RTI_TRUE;
fin:
    if (done != RTI_TRUE && 
        RTICdrStream_getRemainder(stream) >=
            RTI_CDR_PARAMETER_HEADER_ALIGNMENT) {
        return RTI_FALSE;   
    }

    if(deserialize_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }


    if (!ThroughputPlugin_instance_to_keyhash(
            endpoint_data, keyhash, sample)) {
        return RTI_FALSE;
    }

    return RTI_TRUE;
}


/* ------------------------------------------------------------------------
 * Plug-in Installation Methods
 * ------------------------------------------------------------------------ */
 
struct PRESTypePlugin *ThroughputPlugin_new(void) 
{ 
    struct PRESTypePlugin *plugin = NULL;
    const struct PRESTypePluginVersion PLUGIN_VERSION = 
        PRES_TYPE_PLUGIN_VERSION_2_0;

    RTIOsapiHeap_allocateStructure(
        &plugin, struct PRESTypePlugin);
    if (plugin == NULL) {
       return NULL;
    }

    plugin->version = PLUGIN_VERSION;

    /* set up parent's function pointers */
    plugin->onParticipantAttached =
        (PRESTypePluginOnParticipantAttachedCallback)
        ThroughputPlugin_on_participant_attached;
    plugin->onParticipantDetached =
        (PRESTypePluginOnParticipantDetachedCallback)
        ThroughputPlugin_on_participant_detached;
    plugin->onEndpointAttached =
        (PRESTypePluginOnEndpointAttachedCallback)
        ThroughputPlugin_on_endpoint_attached;
    plugin->onEndpointDetached =
        (PRESTypePluginOnEndpointDetachedCallback)
        ThroughputPlugin_on_endpoint_detached;

    plugin->copySampleFnc =
        (PRESTypePluginCopySampleFunction)
        ThroughputPlugin_copy_sample;
    plugin->createSampleFnc =
        (PRESTypePluginCreateSampleFunction)
        ThroughputPlugin_create_sample;
    plugin->destroySampleFnc =
        (PRESTypePluginDestroySampleFunction)
        ThroughputPlugin_destroy_sample;

    plugin->serializeFnc =
        (PRESTypePluginSerializeFunction)
        ThroughputPlugin_serialize;
    plugin->deserializeFnc =
        (PRESTypePluginDeserializeFunction)
        ThroughputPlugin_deserialize;
    plugin->getSerializedSampleMaxSizeFnc =
        (PRESTypePluginGetSerializedSampleMaxSizeFunction)
        ThroughputPlugin_get_serialized_sample_max_size;
    plugin->getSerializedSampleMinSizeFnc =
        (PRESTypePluginGetSerializedSampleMinSizeFunction)
        ThroughputPlugin_get_serialized_sample_min_size;


    plugin->getSampleFnc =
        (PRESTypePluginGetSampleFunction)
        ThroughputPlugin_get_sample;
    plugin->returnSampleFnc =
        (PRESTypePluginReturnSampleFunction)
        ThroughputPlugin_return_sample;

    plugin->getKeyKindFnc =
        (PRESTypePluginGetKeyKindFunction)
        ThroughputPlugin_get_key_kind;


    plugin->getSerializedKeyMaxSizeFnc =   
        (PRESTypePluginGetSerializedKeyMaxSizeFunction)
        ThroughputPlugin_get_serialized_key_max_size;
    plugin->serializeKeyFnc =
        (PRESTypePluginSerializeKeyFunction)
        ThroughputPlugin_serialize_key;
    plugin->deserializeKeyFnc =
        (PRESTypePluginDeserializeKeyFunction)
        ThroughputPlugin_deserialize_key;
    plugin->deserializeKeySampleFnc =
        (PRESTypePluginDeserializeKeySampleFunction)
        ThroughputPlugin_deserialize_key_sample;

    plugin->instanceToKeyHashFnc = 
        (PRESTypePluginInstanceToKeyHashFunction)
        ThroughputPlugin_instance_to_keyhash;
    plugin->serializedSampleToKeyHashFnc = 
        (PRESTypePluginSerializedSampleToKeyHashFunction)
        ThroughputPlugin_serialized_sample_to_keyhash;

    plugin->getKeyFnc =
        (PRESTypePluginGetKeyFunction)
        ThroughputPlugin_get_key;
    plugin->returnKeyFnc =
        (PRESTypePluginReturnKeyFunction)
        ThroughputPlugin_return_key;

    plugin->instanceToKeyFnc =
        (PRESTypePluginInstanceToKeyFunction)
        ThroughputPlugin_instance_to_key;
    plugin->keyToInstanceFnc =
        (PRESTypePluginKeyToInstanceFunction)
        ThroughputPlugin_key_to_instance;
    plugin->serializedKeyToKeyHashFnc = NULL; /* Not supported yet */
    
    plugin->typeCode = NULL; 
    
    plugin->languageKind = PRES_TYPEPLUGIN_DDS_TYPE; 

    /* Serialized buffer */
    plugin->getBuffer = 
        (PRESTypePluginGetBufferFunction)
        ThroughputPlugin_get_buffer;
    plugin->returnBuffer = 
        (PRESTypePluginReturnBufferFunction)
        ThroughputPlugin_return_buffer;
    plugin->getSerializedSampleSizeFnc =
        (PRESTypePluginGetSerializedSampleSizeFunction)
        ThroughputPlugin_get_serialized_sample_size;

    plugin->endpointTypeName = ThroughputTYPENAME;

    return plugin;
}

void
ThroughputPlugin_delete(struct PRESTypePlugin *plugin)
{
    RTIOsapiHeap_freeStructure(plugin);
} 
