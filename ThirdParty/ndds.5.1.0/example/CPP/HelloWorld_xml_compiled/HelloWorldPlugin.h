
/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from HelloWorld.idl using "rtiddsgen".
  The rtiddsgen tool is part of the RTI Connext distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the RTI Connext manual.
*/

#ifndef HelloWorldPlugin_1436886431_h
#define HelloWorldPlugin_1436886431_h

#include "HelloWorld.h"



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

/* The type used to store keys for instances of type struct
 * HelloWorld.
 *
 * By default, this type is struct HelloWorld
 * itself. However, if for some reason this choice is not practical for your
 * system (e.g. if sizeof(struct HelloWorld)
 * is very large), you may redefine this typedef in terms of another type of
 * your choosing. HOWEVER, if you define the KeyHolder type to be something
 * other than struct HelloWorld, the
 * following restriction applies: the key of struct
 * HelloWorld must consist of a
 * single field of your redefined KeyHolder type and that field must be the
 * first field in struct HelloWorld.
*/
typedef  class HelloWorld HelloWorldKeyHolder;


#define HelloWorldPlugin_get_sample PRESTypePluginDefaultEndpointData_getSample  
#define HelloWorldPlugin_get_buffer PRESTypePluginDefaultEndpointData_getBuffer 
#define HelloWorldPlugin_return_buffer PRESTypePluginDefaultEndpointData_returnBuffer 

#define HelloWorldPlugin_get_key PRESTypePluginDefaultEndpointData_getKey 
#define HelloWorldPlugin_return_key PRESTypePluginDefaultEndpointData_returnKey
 

#define HelloWorldPlugin_create_sample PRESTypePluginDefaultEndpointData_createSample 
#define HelloWorldPlugin_destroy_sample PRESTypePluginDefaultEndpointData_deleteSample 

/* --------------------------------------------------------------------------------------
    Support functions:
 * -------------------------------------------------------------------------------------- */

NDDSUSERDllExport extern HelloWorld*
HelloWorldPluginSupport_create_data_w_params(
    const struct DDS_TypeAllocationParams_t * alloc_params);

NDDSUSERDllExport extern HelloWorld*
HelloWorldPluginSupport_create_data_ex(RTIBool allocate_pointers);

NDDSUSERDllExport extern HelloWorld*
HelloWorldPluginSupport_create_data(void);

NDDSUSERDllExport extern RTIBool 
HelloWorldPluginSupport_copy_data(
    HelloWorld *out,
    const HelloWorld *in);

NDDSUSERDllExport extern void 
HelloWorldPluginSupport_destroy_data_w_params(
    HelloWorld *sample,
    const struct DDS_TypeDeallocationParams_t * dealloc_params);

NDDSUSERDllExport extern void 
HelloWorldPluginSupport_destroy_data_ex(
    HelloWorld *sample,RTIBool deallocate_pointers);

NDDSUSERDllExport extern void 
HelloWorldPluginSupport_destroy_data(
    HelloWorld *sample);

NDDSUSERDllExport extern void 
HelloWorldPluginSupport_print_data(
    const HelloWorld *sample,
    const char *desc,
    unsigned int indent);


NDDSUSERDllExport extern HelloWorld*
HelloWorldPluginSupport_create_key_ex(RTIBool allocate_pointers);

NDDSUSERDllExport extern HelloWorld*
HelloWorldPluginSupport_create_key(void);

NDDSUSERDllExport extern void 
HelloWorldPluginSupport_destroy_key_ex(
    HelloWorldKeyHolder *key,RTIBool deallocate_pointers);

NDDSUSERDllExport extern void 
HelloWorldPluginSupport_destroy_key(
    HelloWorldKeyHolder *key);

/* ----------------------------------------------------------------------------
    Callback functions:
 * ---------------------------------------------------------------------------- */

NDDSUSERDllExport extern PRESTypePluginParticipantData 
HelloWorldPlugin_on_participant_attached(
    void *registration_data, 
    const struct PRESTypePluginParticipantInfo *participant_info,
    RTIBool top_level_registration, 
    void *container_plugin_context,
    RTICdrTypeCode *typeCode);

NDDSUSERDllExport extern void 
HelloWorldPlugin_on_participant_detached(
    PRESTypePluginParticipantData participant_data);
    
NDDSUSERDllExport extern PRESTypePluginEndpointData 
HelloWorldPlugin_on_endpoint_attached(
    PRESTypePluginParticipantData participant_data,
    const struct PRESTypePluginEndpointInfo *endpoint_info,
    RTIBool top_level_registration, 
    void *container_plugin_context);

NDDSUSERDllExport extern void 
HelloWorldPlugin_on_endpoint_detached(
    PRESTypePluginEndpointData endpoint_data);
    
NDDSUSERDllExport extern void    
HelloWorldPlugin_return_sample(
    PRESTypePluginEndpointData endpoint_data,
    HelloWorld *sample,
    void *handle);    
 

NDDSUSERDllExport extern RTIBool 
HelloWorldPlugin_copy_sample(
    PRESTypePluginEndpointData endpoint_data,
    HelloWorld *out,
    const HelloWorld *in);

/* --------------------------------------------------------------------------------------
    (De)Serialize functions:
 * -------------------------------------------------------------------------------------- */

NDDSUSERDllExport extern RTIBool 
HelloWorldPlugin_serialize(
    PRESTypePluginEndpointData endpoint_data,
    const HelloWorld *sample,
    struct RTICdrStream *stream, 
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_sample, 
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern RTIBool 
HelloWorldPlugin_deserialize_sample(
    PRESTypePluginEndpointData endpoint_data,
    HelloWorld *sample, 
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_sample, 
    void *endpoint_plugin_qos);

 
NDDSUSERDllExport extern RTIBool 
HelloWorldPlugin_deserialize(
    PRESTypePluginEndpointData endpoint_data,
    HelloWorld **sample, 
    RTIBool * drop_sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_sample, 
    void *endpoint_plugin_qos);




NDDSUSERDllExport extern RTIBool
HelloWorldPlugin_skip(
    PRESTypePluginEndpointData endpoint_data,
    struct RTICdrStream *stream, 
    RTIBool skip_encapsulation,  
    RTIBool skip_sample, 
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern unsigned int 
HelloWorldPlugin_get_serialized_sample_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern unsigned int 
HelloWorldPlugin_get_serialized_sample_min_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern unsigned int
HelloWorldPlugin_get_serialized_sample_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment,
    const HelloWorld * sample);



/* --------------------------------------------------------------------------------------
    Key Management functions:
 * -------------------------------------------------------------------------------------- */

NDDSUSERDllExport extern PRESTypePluginKeyKind 
HelloWorldPlugin_get_key_kind(void);

NDDSUSERDllExport extern unsigned int 
HelloWorldPlugin_get_serialized_key_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern RTIBool 
HelloWorldPlugin_serialize_key(
    PRESTypePluginEndpointData endpoint_data,
    const HelloWorld *sample,
    struct RTICdrStream *stream,
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_key,
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern RTIBool 
HelloWorldPlugin_deserialize_key_sample(
    PRESTypePluginEndpointData endpoint_data,
    HelloWorld * sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_key,
    void *endpoint_plugin_qos);

 
NDDSUSERDllExport extern RTIBool 
HelloWorldPlugin_deserialize_key(
    PRESTypePluginEndpointData endpoint_data,
    HelloWorld ** sample,
    RTIBool * drop_sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_key,
    void *endpoint_plugin_qos);


NDDSUSERDllExport extern RTIBool
HelloWorldPlugin_serialized_sample_to_key(
    PRESTypePluginEndpointData endpoint_data,
    HelloWorld *sample,
    struct RTICdrStream *stream, 
    RTIBool deserialize_encapsulation,  
    RTIBool deserialize_key, 
    void *endpoint_plugin_qos);

 
NDDSUSERDllExport extern RTIBool 
HelloWorldPlugin_instance_to_key(
    PRESTypePluginEndpointData endpoint_data,
    HelloWorldKeyHolder *key, 
    const HelloWorld *instance);

NDDSUSERDllExport extern RTIBool 
HelloWorldPlugin_key_to_instance(
    PRESTypePluginEndpointData endpoint_data,
    HelloWorld *instance, 
    const HelloWorldKeyHolder *key);

NDDSUSERDllExport extern RTIBool 
HelloWorldPlugin_instance_to_keyhash(
    PRESTypePluginEndpointData endpoint_data,
    DDS_KeyHash_t *keyhash,
    const HelloWorld *instance);

NDDSUSERDllExport extern RTIBool 
HelloWorldPlugin_serialized_sample_to_keyhash(
    PRESTypePluginEndpointData endpoint_data,
    struct RTICdrStream *stream, 
    DDS_KeyHash_t *keyhash,
    RTIBool deserialize_encapsulation,
    void *endpoint_plugin_qos); 
     
/* Plugin Functions */
NDDSUSERDllExport extern struct PRESTypePlugin*
HelloWorldPlugin_new(void);

NDDSUSERDllExport extern void
HelloWorldPlugin_delete(struct PRESTypePlugin *);

#ifdef __cplusplus
}
#endif

        
#if (defined(RTI_WIN32) || defined (RTI_WINCE)) && defined(NDDS_USER_DLL_EXPORT)
/* If the code is building on Windows, stop exporting symbols.
*/
#undef NDDSUSERDllExport
#define NDDSUSERDllExport
#endif        

#endif /* HelloWorldPlugin_1436886431_h */
