
/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from Throughput.idl using "rtiddsgen".
  The rtiddsgen tool is part of the RTI Connext distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the RTI Connext manual.
*/

#ifndef ThroughputPlugin_1907597258_h
#define ThroughputPlugin_1907597258_h

#include "Throughput.h"



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


/* ------------------------------------------------------------------------
 * (De)Serialization Methods
 * ------------------------------------------------------------------------ */

NDDSUSERDllExport extern RTIBool
ThroughputCommandKindPlugin_serialize(
    PRESTypePluginEndpointData endpoint_data,
    const ThroughputCommandKind *sample, struct RTICdrStream *stream,
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_sample, 
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern RTIBool
ThroughputCommandKindPlugin_deserialize_sample(
    PRESTypePluginEndpointData endpoint_data,
    ThroughputCommandKind *sample, 
    struct RTICdrStream *stream, 
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_sample, 
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern RTIBool
ThroughputCommandKindPlugin_skip(
    PRESTypePluginEndpointData endpoint_data,
    struct RTICdrStream *stream, 
    RTIBool skip_encapsulation,  
    RTIBool skip_sample, 
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern unsigned int
ThroughputCommandKindPlugin_get_serialized_sample_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern unsigned int
ThroughputCommandKindPlugin_get_serialized_sample_min_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern unsigned int
ThroughputCommandKindPlugin_get_serialized_sample_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment,
    const ThroughputCommandKind * sample);


/* ------------------------------------------------------------------------
    Key Management functions:
 * ------------------------------------------------------------------------ */

NDDSUSERDllExport extern RTIBool 
ThroughputCommandKindPlugin_serialize_key(
    PRESTypePluginEndpointData endpoint_data,
    const ThroughputCommandKind *sample,
    struct RTICdrStream *stream,
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_key,
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern RTIBool 
ThroughputCommandKindPlugin_deserialize_key_sample(
    PRESTypePluginEndpointData endpoint_data,
    ThroughputCommandKind *sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_key,
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern unsigned int 
ThroughputCommandKindPlugin_get_serialized_key_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern RTIBool
ThroughputCommandKindPlugin_serialized_sample_to_key(
    PRESTypePluginEndpointData endpoint_data,
    ThroughputCommandKind *sample,
    struct RTICdrStream *stream, 
    RTIBool deserialize_encapsulation,  
    RTIBool deserialize_key, 
    void *endpoint_plugin_qos);

 


/* ----------------------------------------------------------------------------
    Support functions:
 * ---------------------------------------------------------------------------- */

NDDSUSERDllExport extern void
ThroughputCommandKindPluginSupport_print_data(
    const ThroughputCommandKind *sample, const char *desc, int indent_level);



#define ThroughputCommandPlugin_get_sample PRESTypePluginDefaultEndpointData_getSample  
#define ThroughputCommandPlugin_get_buffer PRESTypePluginDefaultEndpointData_getBuffer 
#define ThroughputCommandPlugin_return_buffer PRESTypePluginDefaultEndpointData_returnBuffer 
 

#define ThroughputCommandPlugin_create_sample PRESTypePluginDefaultEndpointData_createSample 
#define ThroughputCommandPlugin_destroy_sample PRESTypePluginDefaultEndpointData_deleteSample 

/* --------------------------------------------------------------------------------------
    Support functions:
 * -------------------------------------------------------------------------------------- */

NDDSUSERDllExport extern ThroughputCommand*
ThroughputCommandPluginSupport_create_data_w_params(
    const struct DDS_TypeAllocationParams_t * alloc_params);

NDDSUSERDllExport extern ThroughputCommand*
ThroughputCommandPluginSupport_create_data_ex(RTIBool allocate_pointers);

NDDSUSERDllExport extern ThroughputCommand*
ThroughputCommandPluginSupport_create_data(void);

NDDSUSERDllExport extern RTIBool 
ThroughputCommandPluginSupport_copy_data(
    ThroughputCommand *out,
    const ThroughputCommand *in);

NDDSUSERDllExport extern void 
ThroughputCommandPluginSupport_destroy_data_w_params(
    ThroughputCommand *sample,
    const struct DDS_TypeDeallocationParams_t * dealloc_params);

NDDSUSERDllExport extern void 
ThroughputCommandPluginSupport_destroy_data_ex(
    ThroughputCommand *sample,RTIBool deallocate_pointers);

NDDSUSERDllExport extern void 
ThroughputCommandPluginSupport_destroy_data(
    ThroughputCommand *sample);

NDDSUSERDllExport extern void 
ThroughputCommandPluginSupport_print_data(
    const ThroughputCommand *sample,
    const char *desc,
    unsigned int indent);


/* ----------------------------------------------------------------------------
    Callback functions:
 * ---------------------------------------------------------------------------- */

NDDSUSERDllExport extern PRESTypePluginParticipantData 
ThroughputCommandPlugin_on_participant_attached(
    void *registration_data, 
    const struct PRESTypePluginParticipantInfo *participant_info,
    RTIBool top_level_registration, 
    void *container_plugin_context,
    RTICdrTypeCode *typeCode);

NDDSUSERDllExport extern void 
ThroughputCommandPlugin_on_participant_detached(
    PRESTypePluginParticipantData participant_data);
    
NDDSUSERDllExport extern PRESTypePluginEndpointData 
ThroughputCommandPlugin_on_endpoint_attached(
    PRESTypePluginParticipantData participant_data,
    const struct PRESTypePluginEndpointInfo *endpoint_info,
    RTIBool top_level_registration, 
    void *container_plugin_context);

NDDSUSERDllExport extern void 
ThroughputCommandPlugin_on_endpoint_detached(
    PRESTypePluginEndpointData endpoint_data);
    
NDDSUSERDllExport extern void    
ThroughputCommandPlugin_return_sample(
    PRESTypePluginEndpointData endpoint_data,
    ThroughputCommand *sample,
    void *handle);    
 

NDDSUSERDllExport extern RTIBool 
ThroughputCommandPlugin_copy_sample(
    PRESTypePluginEndpointData endpoint_data,
    ThroughputCommand *out,
    const ThroughputCommand *in);

/* --------------------------------------------------------------------------------------
    (De)Serialize functions:
 * -------------------------------------------------------------------------------------- */

NDDSUSERDllExport extern RTIBool 
ThroughputCommandPlugin_serialize(
    PRESTypePluginEndpointData endpoint_data,
    const ThroughputCommand *sample,
    struct RTICdrStream *stream, 
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_sample, 
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern RTIBool 
ThroughputCommandPlugin_deserialize_sample(
    PRESTypePluginEndpointData endpoint_data,
    ThroughputCommand *sample, 
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_sample, 
    void *endpoint_plugin_qos);

 
NDDSUSERDllExport extern RTIBool 
ThroughputCommandPlugin_deserialize(
    PRESTypePluginEndpointData endpoint_data,
    ThroughputCommand **sample, 
    RTIBool * drop_sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_sample, 
    void *endpoint_plugin_qos);




NDDSUSERDllExport extern RTIBool
ThroughputCommandPlugin_skip(
    PRESTypePluginEndpointData endpoint_data,
    struct RTICdrStream *stream, 
    RTIBool skip_encapsulation,  
    RTIBool skip_sample, 
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern unsigned int 
ThroughputCommandPlugin_get_serialized_sample_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern unsigned int 
ThroughputCommandPlugin_get_serialized_sample_min_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern unsigned int
ThroughputCommandPlugin_get_serialized_sample_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment,
    const ThroughputCommand * sample);



/* --------------------------------------------------------------------------------------
    Key Management functions:
 * -------------------------------------------------------------------------------------- */

NDDSUSERDllExport extern PRESTypePluginKeyKind 
ThroughputCommandPlugin_get_key_kind(void);

NDDSUSERDllExport extern unsigned int 
ThroughputCommandPlugin_get_serialized_key_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern RTIBool 
ThroughputCommandPlugin_serialize_key(
    PRESTypePluginEndpointData endpoint_data,
    const ThroughputCommand *sample,
    struct RTICdrStream *stream,
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_key,
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern RTIBool 
ThroughputCommandPlugin_deserialize_key_sample(
    PRESTypePluginEndpointData endpoint_data,
    ThroughputCommand * sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_key,
    void *endpoint_plugin_qos);

 
NDDSUSERDllExport extern RTIBool 
ThroughputCommandPlugin_deserialize_key(
    PRESTypePluginEndpointData endpoint_data,
    ThroughputCommand ** sample,
    RTIBool * drop_sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_key,
    void *endpoint_plugin_qos);


NDDSUSERDllExport extern RTIBool
ThroughputCommandPlugin_serialized_sample_to_key(
    PRESTypePluginEndpointData endpoint_data,
    ThroughputCommand *sample,
    struct RTICdrStream *stream, 
    RTIBool deserialize_encapsulation,  
    RTIBool deserialize_key, 
    void *endpoint_plugin_qos);

     
/* Plugin Functions */
NDDSUSERDllExport extern struct PRESTypePlugin*
ThroughputCommandPlugin_new(void);

NDDSUSERDllExport extern void
ThroughputCommandPlugin_delete(struct PRESTypePlugin *);

/* The type used to store keys for instances of type struct
 * Throughput.
 *
 * By default, this type is struct Throughput
 * itself. However, if for some reason this choice is not practical for your
 * system (e.g. if sizeof(struct Throughput)
 * is very large), you may redefine this typedef in terms of another type of
 * your choosing. HOWEVER, if you define the KeyHolder type to be something
 * other than struct Throughput, the
 * following restriction applies: the key of struct
 * Throughput must consist of a
 * single field of your redefined KeyHolder type and that field must be the
 * first field in struct Throughput.
*/
typedef  class Throughput ThroughputKeyHolder;


#define ThroughputPlugin_get_sample PRESTypePluginDefaultEndpointData_getSample  
#define ThroughputPlugin_get_buffer PRESTypePluginDefaultEndpointData_getBuffer 
#define ThroughputPlugin_return_buffer PRESTypePluginDefaultEndpointData_returnBuffer 

#define ThroughputPlugin_get_key PRESTypePluginDefaultEndpointData_getKey 
#define ThroughputPlugin_return_key PRESTypePluginDefaultEndpointData_returnKey
 

#define ThroughputPlugin_create_sample PRESTypePluginDefaultEndpointData_createSample 
#define ThroughputPlugin_destroy_sample PRESTypePluginDefaultEndpointData_deleteSample 

/* --------------------------------------------------------------------------------------
    Support functions:
 * -------------------------------------------------------------------------------------- */

NDDSUSERDllExport extern Throughput*
ThroughputPluginSupport_create_data_w_params(
    const struct DDS_TypeAllocationParams_t * alloc_params);

NDDSUSERDllExport extern Throughput*
ThroughputPluginSupport_create_data_ex(RTIBool allocate_pointers);

NDDSUSERDllExport extern Throughput*
ThroughputPluginSupport_create_data(void);

NDDSUSERDllExport extern RTIBool 
ThroughputPluginSupport_copy_data(
    Throughput *out,
    const Throughput *in);

NDDSUSERDllExport extern void 
ThroughputPluginSupport_destroy_data_w_params(
    Throughput *sample,
    const struct DDS_TypeDeallocationParams_t * dealloc_params);

NDDSUSERDllExport extern void 
ThroughputPluginSupport_destroy_data_ex(
    Throughput *sample,RTIBool deallocate_pointers);

NDDSUSERDllExport extern void 
ThroughputPluginSupport_destroy_data(
    Throughput *sample);

NDDSUSERDllExport extern void 
ThroughputPluginSupport_print_data(
    const Throughput *sample,
    const char *desc,
    unsigned int indent);


NDDSUSERDllExport extern Throughput*
ThroughputPluginSupport_create_key_ex(RTIBool allocate_pointers);

NDDSUSERDllExport extern Throughput*
ThroughputPluginSupport_create_key(void);

NDDSUSERDllExport extern void 
ThroughputPluginSupport_destroy_key_ex(
    ThroughputKeyHolder *key,RTIBool deallocate_pointers);

NDDSUSERDllExport extern void 
ThroughputPluginSupport_destroy_key(
    ThroughputKeyHolder *key);

/* ----------------------------------------------------------------------------
    Callback functions:
 * ---------------------------------------------------------------------------- */

NDDSUSERDllExport extern PRESTypePluginParticipantData 
ThroughputPlugin_on_participant_attached(
    void *registration_data, 
    const struct PRESTypePluginParticipantInfo *participant_info,
    RTIBool top_level_registration, 
    void *container_plugin_context,
    RTICdrTypeCode *typeCode);

NDDSUSERDllExport extern void 
ThroughputPlugin_on_participant_detached(
    PRESTypePluginParticipantData participant_data);
    
NDDSUSERDllExport extern PRESTypePluginEndpointData 
ThroughputPlugin_on_endpoint_attached(
    PRESTypePluginParticipantData participant_data,
    const struct PRESTypePluginEndpointInfo *endpoint_info,
    RTIBool top_level_registration, 
    void *container_plugin_context);

NDDSUSERDllExport extern void 
ThroughputPlugin_on_endpoint_detached(
    PRESTypePluginEndpointData endpoint_data);
    
NDDSUSERDllExport extern void    
ThroughputPlugin_return_sample(
    PRESTypePluginEndpointData endpoint_data,
    Throughput *sample,
    void *handle);    
 

NDDSUSERDllExport extern RTIBool 
ThroughputPlugin_copy_sample(
    PRESTypePluginEndpointData endpoint_data,
    Throughput *out,
    const Throughput *in);

/* --------------------------------------------------------------------------------------
    (De)Serialize functions:
 * -------------------------------------------------------------------------------------- */

NDDSUSERDllExport extern RTIBool 
ThroughputPlugin_serialize(
    PRESTypePluginEndpointData endpoint_data,
    const Throughput *sample,
    struct RTICdrStream *stream, 
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_sample, 
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern RTIBool 
ThroughputPlugin_deserialize_sample(
    PRESTypePluginEndpointData endpoint_data,
    Throughput *sample, 
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_sample, 
    void *endpoint_plugin_qos);

 
NDDSUSERDllExport extern RTIBool 
ThroughputPlugin_deserialize(
    PRESTypePluginEndpointData endpoint_data,
    Throughput **sample, 
    RTIBool * drop_sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_sample, 
    void *endpoint_plugin_qos);




NDDSUSERDllExport extern RTIBool
ThroughputPlugin_skip(
    PRESTypePluginEndpointData endpoint_data,
    struct RTICdrStream *stream, 
    RTIBool skip_encapsulation,  
    RTIBool skip_sample, 
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern unsigned int 
ThroughputPlugin_get_serialized_sample_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern unsigned int 
ThroughputPlugin_get_serialized_sample_min_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern unsigned int
ThroughputPlugin_get_serialized_sample_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment,
    const Throughput * sample);



/* --------------------------------------------------------------------------------------
    Key Management functions:
 * -------------------------------------------------------------------------------------- */

NDDSUSERDllExport extern PRESTypePluginKeyKind 
ThroughputPlugin_get_key_kind(void);

NDDSUSERDllExport extern unsigned int 
ThroughputPlugin_get_serialized_key_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern RTIBool 
ThroughputPlugin_serialize_key(
    PRESTypePluginEndpointData endpoint_data,
    const Throughput *sample,
    struct RTICdrStream *stream,
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_key,
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern RTIBool 
ThroughputPlugin_deserialize_key_sample(
    PRESTypePluginEndpointData endpoint_data,
    Throughput * sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_key,
    void *endpoint_plugin_qos);

 
NDDSUSERDllExport extern RTIBool 
ThroughputPlugin_deserialize_key(
    PRESTypePluginEndpointData endpoint_data,
    Throughput ** sample,
    RTIBool * drop_sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_key,
    void *endpoint_plugin_qos);


NDDSUSERDllExport extern RTIBool
ThroughputPlugin_serialized_sample_to_key(
    PRESTypePluginEndpointData endpoint_data,
    Throughput *sample,
    struct RTICdrStream *stream, 
    RTIBool deserialize_encapsulation,  
    RTIBool deserialize_key, 
    void *endpoint_plugin_qos);

 
NDDSUSERDllExport extern RTIBool 
ThroughputPlugin_instance_to_key(
    PRESTypePluginEndpointData endpoint_data,
    ThroughputKeyHolder *key, 
    const Throughput *instance);

NDDSUSERDllExport extern RTIBool 
ThroughputPlugin_key_to_instance(
    PRESTypePluginEndpointData endpoint_data,
    Throughput *instance, 
    const ThroughputKeyHolder *key);

NDDSUSERDllExport extern RTIBool 
ThroughputPlugin_instance_to_keyhash(
    PRESTypePluginEndpointData endpoint_data,
    DDS_KeyHash_t *keyhash,
    const Throughput *instance);

NDDSUSERDllExport extern RTIBool 
ThroughputPlugin_serialized_sample_to_keyhash(
    PRESTypePluginEndpointData endpoint_data,
    struct RTICdrStream *stream, 
    DDS_KeyHash_t *keyhash,
    RTIBool deserialize_encapsulation,
    void *endpoint_plugin_qos); 
     
/* Plugin Functions */
NDDSUSERDllExport extern struct PRESTypePlugin*
ThroughputPlugin_new(void);

NDDSUSERDllExport extern void
ThroughputPlugin_delete(struct PRESTypePlugin *);

#ifdef __cplusplus
}
#endif

        
#if (defined(RTI_WIN32) || defined (RTI_WINCE)) && defined(NDDS_USER_DLL_EXPORT)
/* If the code is building on Windows, stop exporting symbols.
*/
#undef NDDSUSERDllExport
#define NDDSUSERDllExport
#endif        

#endif /* ThroughputPlugin_1907597258_h */
