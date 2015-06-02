
/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from Latency.idl using "rtiddsgen".
  The rtiddsgen tool is part of the RTI Connext distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the RTI Connext manual.
*/

#ifndef LatencyPlugin_1496238403_h
#define LatencyPlugin_1496238403_h

#include "Latency.h"



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


#define LatencyPlugin_get_sample PRESTypePluginDefaultEndpointData_getSample  
#define LatencyPlugin_get_buffer PRESTypePluginDefaultEndpointData_getBuffer 
#define LatencyPlugin_return_buffer PRESTypePluginDefaultEndpointData_returnBuffer 
 

#define LatencyPlugin_create_sample PRESTypePluginDefaultEndpointData_createSample 
#define LatencyPlugin_destroy_sample PRESTypePluginDefaultEndpointData_deleteSample 

/* --------------------------------------------------------------------------------------
    Support functions:
 * -------------------------------------------------------------------------------------- */

NDDSUSERDllExport extern Latency*
LatencyPluginSupport_create_data_w_params(
    const struct DDS_TypeAllocationParams_t * alloc_params);

NDDSUSERDllExport extern Latency*
LatencyPluginSupport_create_data_ex(RTIBool allocate_pointers);

NDDSUSERDllExport extern Latency*
LatencyPluginSupport_create_data(void);

NDDSUSERDllExport extern RTIBool 
LatencyPluginSupport_copy_data(
    Latency *out,
    const Latency *in);

NDDSUSERDllExport extern void 
LatencyPluginSupport_destroy_data_w_params(
    Latency *sample,
    const struct DDS_TypeDeallocationParams_t * dealloc_params);

NDDSUSERDllExport extern void 
LatencyPluginSupport_destroy_data_ex(
    Latency *sample,RTIBool deallocate_pointers);

NDDSUSERDllExport extern void 
LatencyPluginSupport_destroy_data(
    Latency *sample);

NDDSUSERDllExport extern void 
LatencyPluginSupport_print_data(
    const Latency *sample,
    const char *desc,
    unsigned int indent);


/* ----------------------------------------------------------------------------
    Callback functions:
 * ---------------------------------------------------------------------------- */

NDDSUSERDllExport extern PRESTypePluginParticipantData 
LatencyPlugin_on_participant_attached(
    void *registration_data, 
    const struct PRESTypePluginParticipantInfo *participant_info,
    RTIBool top_level_registration, 
    void *container_plugin_context,
    RTICdrTypeCode *typeCode);

NDDSUSERDllExport extern void 
LatencyPlugin_on_participant_detached(
    PRESTypePluginParticipantData participant_data);
    
NDDSUSERDllExport extern PRESTypePluginEndpointData 
LatencyPlugin_on_endpoint_attached(
    PRESTypePluginParticipantData participant_data,
    const struct PRESTypePluginEndpointInfo *endpoint_info,
    RTIBool top_level_registration, 
    void *container_plugin_context);

NDDSUSERDllExport extern void 
LatencyPlugin_on_endpoint_detached(
    PRESTypePluginEndpointData endpoint_data);
    
NDDSUSERDllExport extern void    
LatencyPlugin_return_sample(
    PRESTypePluginEndpointData endpoint_data,
    Latency *sample,
    void *handle);    
 

NDDSUSERDllExport extern RTIBool 
LatencyPlugin_copy_sample(
    PRESTypePluginEndpointData endpoint_data,
    Latency *out,
    const Latency *in);

/* --------------------------------------------------------------------------------------
    (De)Serialize functions:
 * -------------------------------------------------------------------------------------- */

NDDSUSERDllExport extern RTIBool 
LatencyPlugin_serialize(
    PRESTypePluginEndpointData endpoint_data,
    const Latency *sample,
    struct RTICdrStream *stream, 
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_sample, 
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern RTIBool 
LatencyPlugin_deserialize_sample(
    PRESTypePluginEndpointData endpoint_data,
    Latency *sample, 
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_sample, 
    void *endpoint_plugin_qos);

 
NDDSUSERDllExport extern RTIBool 
LatencyPlugin_deserialize(
    PRESTypePluginEndpointData endpoint_data,
    Latency **sample, 
    RTIBool * drop_sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_sample, 
    void *endpoint_plugin_qos);




NDDSUSERDllExport extern RTIBool
LatencyPlugin_skip(
    PRESTypePluginEndpointData endpoint_data,
    struct RTICdrStream *stream, 
    RTIBool skip_encapsulation,  
    RTIBool skip_sample, 
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern unsigned int 
LatencyPlugin_get_serialized_sample_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern unsigned int 
LatencyPlugin_get_serialized_sample_min_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern unsigned int
LatencyPlugin_get_serialized_sample_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment,
    const Latency * sample);



/* --------------------------------------------------------------------------------------
    Key Management functions:
 * -------------------------------------------------------------------------------------- */

NDDSUSERDllExport extern PRESTypePluginKeyKind 
LatencyPlugin_get_key_kind(void);

NDDSUSERDllExport extern unsigned int 
LatencyPlugin_get_serialized_key_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern RTIBool 
LatencyPlugin_serialize_key(
    PRESTypePluginEndpointData endpoint_data,
    const Latency *sample,
    struct RTICdrStream *stream,
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_key,
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern RTIBool 
LatencyPlugin_deserialize_key_sample(
    PRESTypePluginEndpointData endpoint_data,
    Latency * sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_key,
    void *endpoint_plugin_qos);

 
NDDSUSERDllExport extern RTIBool 
LatencyPlugin_deserialize_key(
    PRESTypePluginEndpointData endpoint_data,
    Latency ** sample,
    RTIBool * drop_sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_key,
    void *endpoint_plugin_qos);


NDDSUSERDllExport extern RTIBool
LatencyPlugin_serialized_sample_to_key(
    PRESTypePluginEndpointData endpoint_data,
    Latency *sample,
    struct RTICdrStream *stream, 
    RTIBool deserialize_encapsulation,  
    RTIBool deserialize_key, 
    void *endpoint_plugin_qos);

     
/* Plugin Functions */
NDDSUSERDllExport extern struct PRESTypePlugin*
LatencyPlugin_new(void);

NDDSUSERDllExport extern void
LatencyPlugin_delete(struct PRESTypePlugin *);

#ifdef __cplusplus
}
#endif

        
#if (defined(RTI_WIN32) || defined (RTI_WINCE)) && defined(NDDS_USER_DLL_EXPORT)
/* If the code is building on Windows, stop exporting symbols.
*/
#undef NDDSUSERDllExport
#define NDDSUSERDllExport
#endif        

#endif /* LatencyPlugin_1496238403_h */
