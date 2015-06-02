
/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from Primes.idl using "rtiddsgen".
  The rtiddsgen tool is part of the RTI Connext distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the RTI Connext manual.
*/

#ifndef PrimesPlugin_831781118_h
#define PrimesPlugin_831781118_h

#include "Primes.h"



struct RTICdrStream;

#ifndef pres_typePlugin_h
#include "pres/pres_typePlugin.h"
#endif


#if (defined(RTI_WIN32) || defined (RTI_WINCE)) && defined(NDDS_USER_DLL_EXPORT)
/* If the code is building on Windows, start exporting symbols.
*/
#undef NDDSUSERDllExport
#define NDDSUSERDllExport __declspec(dllexport)
#endif


#ifdef __cplusplus
extern "C" {
#endif


#define PrimeNumberRequestPlugin_get_sample PRESTypePluginDefaultEndpointData_getSample  
#define PrimeNumberRequestPlugin_get_buffer PRESTypePluginDefaultEndpointData_getBuffer 
#define PrimeNumberRequestPlugin_return_buffer PRESTypePluginDefaultEndpointData_returnBuffer 
 

#define PrimeNumberRequestPlugin_create_sample PRESTypePluginDefaultEndpointData_createSample 
#define PrimeNumberRequestPlugin_destroy_sample PRESTypePluginDefaultEndpointData_deleteSample 

/* --------------------------------------------------------------------------------------
    Support functions:
 * -------------------------------------------------------------------------------------- */

NDDSUSERDllExport extern PrimeNumberRequest*
PrimeNumberRequestPluginSupport_create_data_w_params(
    const struct DDS_TypeAllocationParams_t * alloc_params);

NDDSUSERDllExport extern PrimeNumberRequest*
PrimeNumberRequestPluginSupport_create_data_ex(RTIBool allocate_pointers);

NDDSUSERDllExport extern PrimeNumberRequest*
PrimeNumberRequestPluginSupport_create_data(void);

NDDSUSERDllExport extern RTIBool 
PrimeNumberRequestPluginSupport_copy_data(
    PrimeNumberRequest *out,
    const PrimeNumberRequest *in);

NDDSUSERDllExport extern void 
PrimeNumberRequestPluginSupport_destroy_data_w_params(
    PrimeNumberRequest *sample,
    const struct DDS_TypeDeallocationParams_t * dealloc_params);

NDDSUSERDllExport extern void 
PrimeNumberRequestPluginSupport_destroy_data_ex(
    PrimeNumberRequest *sample,RTIBool deallocate_pointers);

NDDSUSERDllExport extern void 
PrimeNumberRequestPluginSupport_destroy_data(
    PrimeNumberRequest *sample);

NDDSUSERDllExport extern void 
PrimeNumberRequestPluginSupport_print_data(
    const PrimeNumberRequest *sample,
    const char *desc,
    unsigned int indent);


/* ----------------------------------------------------------------------------
    Callback functions:
 * ---------------------------------------------------------------------------- */

NDDSUSERDllExport extern PRESTypePluginParticipantData 
PrimeNumberRequestPlugin_on_participant_attached(
    void *registration_data, 
    const struct PRESTypePluginParticipantInfo *participant_info,
    RTIBool top_level_registration, 
    void *container_plugin_context,
    RTICdrTypeCode *typeCode);

NDDSUSERDllExport extern void 
PrimeNumberRequestPlugin_on_participant_detached(
    PRESTypePluginParticipantData participant_data);
    
NDDSUSERDllExport extern PRESTypePluginEndpointData 
PrimeNumberRequestPlugin_on_endpoint_attached(
    PRESTypePluginParticipantData participant_data,
    const struct PRESTypePluginEndpointInfo *endpoint_info,
    RTIBool top_level_registration, 
    void *container_plugin_context);

NDDSUSERDllExport extern void 
PrimeNumberRequestPlugin_on_endpoint_detached(
    PRESTypePluginEndpointData endpoint_data);
    
NDDSUSERDllExport extern void    
PrimeNumberRequestPlugin_return_sample(
    PRESTypePluginEndpointData endpoint_data,
    PrimeNumberRequest *sample,
    void *handle);    
 

NDDSUSERDllExport extern RTIBool 
PrimeNumberRequestPlugin_copy_sample(
    PRESTypePluginEndpointData endpoint_data,
    PrimeNumberRequest *out,
    const PrimeNumberRequest *in);

/* --------------------------------------------------------------------------------------
    (De)Serialize functions:
 * -------------------------------------------------------------------------------------- */

NDDSUSERDllExport extern RTIBool 
PrimeNumberRequestPlugin_serialize(
    PRESTypePluginEndpointData endpoint_data,
    const PrimeNumberRequest *sample,
    struct RTICdrStream *stream, 
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_sample, 
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern RTIBool 
PrimeNumberRequestPlugin_deserialize_sample(
    PRESTypePluginEndpointData endpoint_data,
    PrimeNumberRequest *sample, 
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_sample, 
    void *endpoint_plugin_qos);

 
NDDSUSERDllExport extern RTIBool 
PrimeNumberRequestPlugin_deserialize(
    PRESTypePluginEndpointData endpoint_data,
    PrimeNumberRequest **sample, 
    RTIBool * drop_sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_sample, 
    void *endpoint_plugin_qos);




NDDSUSERDllExport extern RTIBool
PrimeNumberRequestPlugin_skip(
    PRESTypePluginEndpointData endpoint_data,
    struct RTICdrStream *stream, 
    RTIBool skip_encapsulation,  
    RTIBool skip_sample, 
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern unsigned int 
PrimeNumberRequestPlugin_get_serialized_sample_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern unsigned int 
PrimeNumberRequestPlugin_get_serialized_sample_min_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern unsigned int
PrimeNumberRequestPlugin_get_serialized_sample_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment,
    const PrimeNumberRequest * sample);



/* --------------------------------------------------------------------------------------
    Key Management functions:
 * -------------------------------------------------------------------------------------- */

NDDSUSERDllExport extern PRESTypePluginKeyKind 
PrimeNumberRequestPlugin_get_key_kind(void);

NDDSUSERDllExport extern unsigned int 
PrimeNumberRequestPlugin_get_serialized_key_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern RTIBool 
PrimeNumberRequestPlugin_serialize_key(
    PRESTypePluginEndpointData endpoint_data,
    const PrimeNumberRequest *sample,
    struct RTICdrStream *stream,
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_key,
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern RTIBool 
PrimeNumberRequestPlugin_deserialize_key_sample(
    PRESTypePluginEndpointData endpoint_data,
    PrimeNumberRequest * sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_key,
    void *endpoint_plugin_qos);

 
NDDSUSERDllExport extern RTIBool 
PrimeNumberRequestPlugin_deserialize_key(
    PRESTypePluginEndpointData endpoint_data,
    PrimeNumberRequest ** sample,
    RTIBool * drop_sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_key,
    void *endpoint_plugin_qos);


NDDSUSERDllExport extern RTIBool
PrimeNumberRequestPlugin_serialized_sample_to_key(
    PRESTypePluginEndpointData endpoint_data,
    PrimeNumberRequest *sample,
    struct RTICdrStream *stream, 
    RTIBool deserialize_encapsulation,  
    RTIBool deserialize_key, 
    void *endpoint_plugin_qos);

     
/* Plugin Functions */
NDDSUSERDllExport extern struct PRESTypePlugin*
PrimeNumberRequestPlugin_new(void);

NDDSUSERDllExport extern void
PrimeNumberRequestPlugin_delete(struct PRESTypePlugin *);


/* ------------------------------------------------------------------------
 * (De)Serialization Methods
 * ------------------------------------------------------------------------ */

NDDSUSERDllExport extern RTIBool
PrimeNumberCalculationStatusPlugin_serialize(
    PRESTypePluginEndpointData endpoint_data,
    const PrimeNumberCalculationStatus *sample, struct RTICdrStream *stream,
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_sample, 
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern RTIBool
PrimeNumberCalculationStatusPlugin_deserialize_sample(
    PRESTypePluginEndpointData endpoint_data,
    PrimeNumberCalculationStatus *sample, 
    struct RTICdrStream *stream, 
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_sample, 
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern RTIBool
PrimeNumberCalculationStatusPlugin_skip(
    PRESTypePluginEndpointData endpoint_data,
    struct RTICdrStream *stream, 
    RTIBool skip_encapsulation,  
    RTIBool skip_sample, 
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern unsigned int
PrimeNumberCalculationStatusPlugin_get_serialized_sample_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern unsigned int
PrimeNumberCalculationStatusPlugin_get_serialized_sample_min_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern unsigned int
PrimeNumberCalculationStatusPlugin_get_serialized_sample_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment,
    const PrimeNumberCalculationStatus * sample);


/* ------------------------------------------------------------------------
    Key Management functions:
 * ------------------------------------------------------------------------ */

NDDSUSERDllExport extern RTIBool 
PrimeNumberCalculationStatusPlugin_serialize_key(
    PRESTypePluginEndpointData endpoint_data,
    const PrimeNumberCalculationStatus *sample,
    struct RTICdrStream *stream,
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_key,
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern RTIBool 
PrimeNumberCalculationStatusPlugin_deserialize_key_sample(
    PRESTypePluginEndpointData endpoint_data,
    PrimeNumberCalculationStatus *sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_key,
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern unsigned int 
PrimeNumberCalculationStatusPlugin_get_serialized_key_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern RTIBool
PrimeNumberCalculationStatusPlugin_serialized_sample_to_key(
    PRESTypePluginEndpointData endpoint_data,
    PrimeNumberCalculationStatus *sample,
    struct RTICdrStream *stream, 
    RTIBool deserialize_encapsulation,  
    RTIBool deserialize_key, 
    void *endpoint_plugin_qos);

 


/* ----------------------------------------------------------------------------
    Support functions:
 * ---------------------------------------------------------------------------- */

NDDSUSERDllExport extern void
PrimeNumberCalculationStatusPluginSupport_print_data(
    const PrimeNumberCalculationStatus *sample, const char *desc, int indent_level);



#define PrimeNumberReplyPlugin_get_sample PRESTypePluginDefaultEndpointData_getSample  
#define PrimeNumberReplyPlugin_get_buffer PRESTypePluginDefaultEndpointData_getBuffer 
#define PrimeNumberReplyPlugin_return_buffer PRESTypePluginDefaultEndpointData_returnBuffer 
 

#define PrimeNumberReplyPlugin_create_sample PRESTypePluginDefaultEndpointData_createSample 
#define PrimeNumberReplyPlugin_destroy_sample PRESTypePluginDefaultEndpointData_deleteSample 

/* --------------------------------------------------------------------------------------
    Support functions:
 * -------------------------------------------------------------------------------------- */

NDDSUSERDllExport extern PrimeNumberReply*
PrimeNumberReplyPluginSupport_create_data_w_params(
    const struct DDS_TypeAllocationParams_t * alloc_params);

NDDSUSERDllExport extern PrimeNumberReply*
PrimeNumberReplyPluginSupport_create_data_ex(RTIBool allocate_pointers);

NDDSUSERDllExport extern PrimeNumberReply*
PrimeNumberReplyPluginSupport_create_data(void);

NDDSUSERDllExport extern RTIBool 
PrimeNumberReplyPluginSupport_copy_data(
    PrimeNumberReply *out,
    const PrimeNumberReply *in);

NDDSUSERDllExport extern void 
PrimeNumberReplyPluginSupport_destroy_data_w_params(
    PrimeNumberReply *sample,
    const struct DDS_TypeDeallocationParams_t * dealloc_params);

NDDSUSERDllExport extern void 
PrimeNumberReplyPluginSupport_destroy_data_ex(
    PrimeNumberReply *sample,RTIBool deallocate_pointers);

NDDSUSERDllExport extern void 
PrimeNumberReplyPluginSupport_destroy_data(
    PrimeNumberReply *sample);

NDDSUSERDllExport extern void 
PrimeNumberReplyPluginSupport_print_data(
    const PrimeNumberReply *sample,
    const char *desc,
    unsigned int indent);


/* ----------------------------------------------------------------------------
    Callback functions:
 * ---------------------------------------------------------------------------- */

NDDSUSERDllExport extern PRESTypePluginParticipantData 
PrimeNumberReplyPlugin_on_participant_attached(
    void *registration_data, 
    const struct PRESTypePluginParticipantInfo *participant_info,
    RTIBool top_level_registration, 
    void *container_plugin_context,
    RTICdrTypeCode *typeCode);

NDDSUSERDllExport extern void 
PrimeNumberReplyPlugin_on_participant_detached(
    PRESTypePluginParticipantData participant_data);
    
NDDSUSERDllExport extern PRESTypePluginEndpointData 
PrimeNumberReplyPlugin_on_endpoint_attached(
    PRESTypePluginParticipantData participant_data,
    const struct PRESTypePluginEndpointInfo *endpoint_info,
    RTIBool top_level_registration, 
    void *container_plugin_context);

NDDSUSERDllExport extern void 
PrimeNumberReplyPlugin_on_endpoint_detached(
    PRESTypePluginEndpointData endpoint_data);
    
NDDSUSERDllExport extern void    
PrimeNumberReplyPlugin_return_sample(
    PRESTypePluginEndpointData endpoint_data,
    PrimeNumberReply *sample,
    void *handle);    
 

NDDSUSERDllExport extern RTIBool 
PrimeNumberReplyPlugin_copy_sample(
    PRESTypePluginEndpointData endpoint_data,
    PrimeNumberReply *out,
    const PrimeNumberReply *in);

/* --------------------------------------------------------------------------------------
    (De)Serialize functions:
 * -------------------------------------------------------------------------------------- */

NDDSUSERDllExport extern RTIBool 
PrimeNumberReplyPlugin_serialize(
    PRESTypePluginEndpointData endpoint_data,
    const PrimeNumberReply *sample,
    struct RTICdrStream *stream, 
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_sample, 
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern RTIBool 
PrimeNumberReplyPlugin_deserialize_sample(
    PRESTypePluginEndpointData endpoint_data,
    PrimeNumberReply *sample, 
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_sample, 
    void *endpoint_plugin_qos);

 
NDDSUSERDllExport extern RTIBool 
PrimeNumberReplyPlugin_deserialize(
    PRESTypePluginEndpointData endpoint_data,
    PrimeNumberReply **sample, 
    RTIBool * drop_sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_sample, 
    void *endpoint_plugin_qos);




NDDSUSERDllExport extern RTIBool
PrimeNumberReplyPlugin_skip(
    PRESTypePluginEndpointData endpoint_data,
    struct RTICdrStream *stream, 
    RTIBool skip_encapsulation,  
    RTIBool skip_sample, 
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern unsigned int 
PrimeNumberReplyPlugin_get_serialized_sample_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern unsigned int 
PrimeNumberReplyPlugin_get_serialized_sample_min_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern unsigned int
PrimeNumberReplyPlugin_get_serialized_sample_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment,
    const PrimeNumberReply * sample);



/* --------------------------------------------------------------------------------------
    Key Management functions:
 * -------------------------------------------------------------------------------------- */

NDDSUSERDllExport extern PRESTypePluginKeyKind 
PrimeNumberReplyPlugin_get_key_kind(void);

NDDSUSERDllExport extern unsigned int 
PrimeNumberReplyPlugin_get_serialized_key_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern RTIBool 
PrimeNumberReplyPlugin_serialize_key(
    PRESTypePluginEndpointData endpoint_data,
    const PrimeNumberReply *sample,
    struct RTICdrStream *stream,
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_key,
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern RTIBool 
PrimeNumberReplyPlugin_deserialize_key_sample(
    PRESTypePluginEndpointData endpoint_data,
    PrimeNumberReply * sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_key,
    void *endpoint_plugin_qos);

 
NDDSUSERDllExport extern RTIBool 
PrimeNumberReplyPlugin_deserialize_key(
    PRESTypePluginEndpointData endpoint_data,
    PrimeNumberReply ** sample,
    RTIBool * drop_sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_key,
    void *endpoint_plugin_qos);


NDDSUSERDllExport extern RTIBool
PrimeNumberReplyPlugin_serialized_sample_to_key(
    PRESTypePluginEndpointData endpoint_data,
    PrimeNumberReply *sample,
    struct RTICdrStream *stream, 
    RTIBool deserialize_encapsulation,  
    RTIBool deserialize_key, 
    void *endpoint_plugin_qos);

     
/* Plugin Functions */
NDDSUSERDllExport extern struct PRESTypePlugin*
PrimeNumberReplyPlugin_new(void);

NDDSUSERDllExport extern void
PrimeNumberReplyPlugin_delete(struct PRESTypePlugin *);

#ifdef __cplusplus
}
#endif

        
#if (defined(RTI_WIN32) || defined (RTI_WINCE)) && defined(NDDS_USER_DLL_EXPORT)
/* If the code is building on Windows, stop exporting symbols.
*/
#undef NDDSUSERDllExport
#define NDDSUSERDllExport
#endif        

#endif /* PrimesPlugin_831781118_h */
