/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from Primes.idl using "rtiddsgen".
  The rtiddsgen tool is part of the RTI Connext distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the RTI Connext manual.
*/

#pragma once

#include "Primes.h"


    
/* ------------------------------------------------------------------------
 * Type: Foo
 * ------------------------------------------------------------------------ */

public ref class FooPlugin :
    DefaultTypePlugin<Foo^> {
// --- Support methods: ------------------------------------------------------
public:
    void print_data(
        Foo^ sample,
        System::String^ desc,
        System::UInt32 indent);


// --- (De)Serialize methods: ------------------------------------------------
public:
    virtual System::Boolean serialize(
        TypePluginDefaultEndpointData^ endpoint_data,
        Foo^ sample,
        CdrStream% stream,
        System::Boolean serialize_encapsulation,
        System::UInt16  encapsulation_id,
        System::Boolean serialize_sample,
        System::Object^ endpoint_plugin_qos) override;

    virtual System::Boolean deserialize_sample(
        TypePluginDefaultEndpointData^ endpoint_data,
        Foo^ sample,
        CdrStream% stream,
        System::Boolean deserialize_encapsulation,
        System::Boolean deserialize_sample, 
        System::Object^ endpoint_plugin_qos) override;

    System::Boolean skip(
        TypePluginDefaultEndpointData^ endpoint_data,
        CdrStream% stream,
        System::Boolean skip_encapsulation,  
        System::Boolean skip_sample, 
        System::Object^ endpoint_plugin_qos);

    virtual System::UInt32 get_serialized_sample_max_size(
        TypePluginDefaultEndpointData^ endpoint_data,
        System::Boolean include_encapsulation,
        System::UInt16  encapsulation_id,
        System::UInt32 size) override;

    virtual System::UInt32 get_serialized_sample_min_size(
        TypePluginDefaultEndpointData^ endpoint_data,
        System::Boolean include_encapsulation,
        System::UInt16  encapsulation_id,
        System::UInt32 size) override;

    virtual System::UInt32 get_serialized_sample_size(
        TypePluginDefaultEndpointData^ endpoint_data,
        Boolean include_encapsulation,
        UInt16 encapsulation_id,
        UInt32 current_alignment,
        Foo^ sample) override;

// ---  Key Management functions: --------------------------------------------
public:
    virtual System::UInt32 get_serialized_key_max_size(
        TypePluginDefaultEndpointData^ endpoint_data,
        System::Boolean include_encapsulation,
        System::UInt16  encapsulation_id,
        System::UInt32 current_alignment) override;

    virtual System::Boolean serialize_key(
        TypePluginDefaultEndpointData^ endpoint_data,
        Foo^ key,
        CdrStream% stream,
        System::Boolean serialize_encapsulation,
        System::UInt16  encapsulation_id,
        System::Boolean serialize_sample,
        System::Object^ endpoint_plugin_qos) override;

    virtual System::Boolean deserialize_key_sample(
        TypePluginDefaultEndpointData^ endpoint_data,
        Foo^ key,
        CdrStream% stream,
        System::Boolean deserialize_encapsulation,
        System::Boolean deserialize_sample,
        System::Object^ endpoint_plugin_qos) override;

    System::Boolean serialized_sample_to_key(
        TypePluginDefaultEndpointData^ endpoint_data,
        Foo^ sample,
        CdrStream% stream,
        System::Boolean deserialize_encapsulation,
        System::Boolean deserialize_key,
        System::Object^ endpoint_plugin_qos);

 


// ---  Plug-in lifecycle management methods: --------------------------------
public:
    static FooPlugin^ get_instance();

    static void dispose();

private:
    FooPlugin()
            : DefaultTypePlugin(
                "Foo",

                false, // not keyed
    
                false, // use RTPS-compliant alignment
                   Foo::get_typecode()) {
        // empty
    }

    static FooPlugin^ _singleton;
};

/* ------------------------------------------------------------------------
 * Type: Bar
 * ------------------------------------------------------------------------ */

public ref class BarPlugin :
    DefaultTypePlugin<Bar^> {
// --- Support methods: ------------------------------------------------------
public:
    void print_data(
        Bar^ sample,
        System::String^ desc,
        System::UInt32 indent);


// --- (De)Serialize methods: ------------------------------------------------
public:
    virtual System::Boolean serialize(
        TypePluginDefaultEndpointData^ endpoint_data,
        Bar^ sample,
        CdrStream% stream,
        System::Boolean serialize_encapsulation,
        System::UInt16  encapsulation_id,
        System::Boolean serialize_sample,
        System::Object^ endpoint_plugin_qos) override;

    virtual System::Boolean deserialize_sample(
        TypePluginDefaultEndpointData^ endpoint_data,
        Bar^ sample,
        CdrStream% stream,
        System::Boolean deserialize_encapsulation,
        System::Boolean deserialize_sample, 
        System::Object^ endpoint_plugin_qos) override;

    System::Boolean skip(
        TypePluginDefaultEndpointData^ endpoint_data,
        CdrStream% stream,
        System::Boolean skip_encapsulation,  
        System::Boolean skip_sample, 
        System::Object^ endpoint_plugin_qos);

    virtual System::UInt32 get_serialized_sample_max_size(
        TypePluginDefaultEndpointData^ endpoint_data,
        System::Boolean include_encapsulation,
        System::UInt16  encapsulation_id,
        System::UInt32 size) override;

    virtual System::UInt32 get_serialized_sample_min_size(
        TypePluginDefaultEndpointData^ endpoint_data,
        System::Boolean include_encapsulation,
        System::UInt16  encapsulation_id,
        System::UInt32 size) override;

    virtual System::UInt32 get_serialized_sample_size(
        TypePluginDefaultEndpointData^ endpoint_data,
        Boolean include_encapsulation,
        UInt16 encapsulation_id,
        UInt32 current_alignment,
        Bar^ sample) override;

// ---  Key Management functions: --------------------------------------------
public:
    virtual System::UInt32 get_serialized_key_max_size(
        TypePluginDefaultEndpointData^ endpoint_data,
        System::Boolean include_encapsulation,
        System::UInt16  encapsulation_id,
        System::UInt32 current_alignment) override;

    virtual System::Boolean serialize_key(
        TypePluginDefaultEndpointData^ endpoint_data,
        Bar^ key,
        CdrStream% stream,
        System::Boolean serialize_encapsulation,
        System::UInt16  encapsulation_id,
        System::Boolean serialize_sample,
        System::Object^ endpoint_plugin_qos) override;

    virtual System::Boolean deserialize_key_sample(
        TypePluginDefaultEndpointData^ endpoint_data,
        Bar^ key,
        CdrStream% stream,
        System::Boolean deserialize_encapsulation,
        System::Boolean deserialize_sample,
        System::Object^ endpoint_plugin_qos) override;

    System::Boolean serialized_sample_to_key(
        TypePluginDefaultEndpointData^ endpoint_data,
        Bar^ sample,
        CdrStream% stream,
        System::Boolean deserialize_encapsulation,
        System::Boolean deserialize_key,
        System::Object^ endpoint_plugin_qos);

 


// ---  Plug-in lifecycle management methods: --------------------------------
public:
    static BarPlugin^ get_instance();

    static void dispose();

private:
    BarPlugin()
            : DefaultTypePlugin(
                "Bar",

                false, // not keyed
    
                false, // use RTPS-compliant alignment
                   Bar::get_typecode()) {
        // empty
    }

    static BarPlugin^ _singleton;
};

/* ------------------------------------------------------------------------
 * Type: PrimeNumberRequest
 * ------------------------------------------------------------------------ */

public ref class PrimeNumberRequestPlugin :
    DefaultTypePlugin<PrimeNumberRequest^> {
// --- Support methods: ------------------------------------------------------
public:
    void print_data(
        PrimeNumberRequest^ sample,
        System::String^ desc,
        System::UInt32 indent);


// --- (De)Serialize methods: ------------------------------------------------
public:
    virtual System::Boolean serialize(
        TypePluginDefaultEndpointData^ endpoint_data,
        PrimeNumberRequest^ sample,
        CdrStream% stream,
        System::Boolean serialize_encapsulation,
        System::UInt16  encapsulation_id,
        System::Boolean serialize_sample,
        System::Object^ endpoint_plugin_qos) override;

    virtual System::Boolean deserialize_sample(
        TypePluginDefaultEndpointData^ endpoint_data,
        PrimeNumberRequest^ sample,
        CdrStream% stream,
        System::Boolean deserialize_encapsulation,
        System::Boolean deserialize_sample, 
        System::Object^ endpoint_plugin_qos) override;

    System::Boolean skip(
        TypePluginDefaultEndpointData^ endpoint_data,
        CdrStream% stream,
        System::Boolean skip_encapsulation,  
        System::Boolean skip_sample, 
        System::Object^ endpoint_plugin_qos);

    virtual System::UInt32 get_serialized_sample_max_size(
        TypePluginDefaultEndpointData^ endpoint_data,
        System::Boolean include_encapsulation,
        System::UInt16  encapsulation_id,
        System::UInt32 size) override;

    virtual System::UInt32 get_serialized_sample_min_size(
        TypePluginDefaultEndpointData^ endpoint_data,
        System::Boolean include_encapsulation,
        System::UInt16  encapsulation_id,
        System::UInt32 size) override;

    virtual System::UInt32 get_serialized_sample_size(
        TypePluginDefaultEndpointData^ endpoint_data,
        Boolean include_encapsulation,
        UInt16 encapsulation_id,
        UInt32 current_alignment,
        PrimeNumberRequest^ sample) override;

// ---  Key Management functions: --------------------------------------------
public:
    virtual System::UInt32 get_serialized_key_max_size(
        TypePluginDefaultEndpointData^ endpoint_data,
        System::Boolean include_encapsulation,
        System::UInt16  encapsulation_id,
        System::UInt32 current_alignment) override;

    virtual System::Boolean serialize_key(
        TypePluginDefaultEndpointData^ endpoint_data,
        PrimeNumberRequest^ key,
        CdrStream% stream,
        System::Boolean serialize_encapsulation,
        System::UInt16  encapsulation_id,
        System::Boolean serialize_sample,
        System::Object^ endpoint_plugin_qos) override;

    virtual System::Boolean deserialize_key_sample(
        TypePluginDefaultEndpointData^ endpoint_data,
        PrimeNumberRequest^ key,
        CdrStream% stream,
        System::Boolean deserialize_encapsulation,
        System::Boolean deserialize_sample,
        System::Object^ endpoint_plugin_qos) override;

    System::Boolean serialized_sample_to_key(
        TypePluginDefaultEndpointData^ endpoint_data,
        PrimeNumberRequest^ sample,
        CdrStream% stream,
        System::Boolean deserialize_encapsulation,
        System::Boolean deserialize_key,
        System::Object^ endpoint_plugin_qos);

 


// ---  Plug-in lifecycle management methods: --------------------------------
public:
    static PrimeNumberRequestPlugin^ get_instance();

    static void dispose();

private:
    PrimeNumberRequestPlugin()
            : DefaultTypePlugin(
                "PrimeNumberRequest",

                false, // not keyed
    
                false, // use RTPS-compliant alignment
                   PrimeNumberRequest::get_typecode()) {
        // empty
    }

    static PrimeNumberRequestPlugin^ _singleton;
};

/* ------------------------------------------------------------------------
 * Enum Type: PrimeNumberCalculationStatus
 * ------------------------------------------------------------------------ */

public ref class PrimeNumberCalculationStatusPlugin {
// --- (De)Serialization Methods: --------------------------------------------
public:
    System::Boolean serialize(
        TypePluginEndpointData^ endpoint_data,
        PrimeNumberCalculationStatus sample,
        CdrStream% stream,
        System::Boolean serialize_encapsulation,
        System::UInt16  encapsulation_id,
        System::Boolean serialize_sample,
        System::Object^ endpoint_plugin_qos);

    System::Boolean deserialize_sample(
        TypePluginEndpointData^ endpoint_data,
        PrimeNumberCalculationStatus% sample,
        CdrStream% stream,
        System::Boolean deserialize_encapsulation,
        System::Boolean deserialize_sample, 
        System::Object^ endpoint_plugin_qos);

    System::Boolean skip(
        TypePluginEndpointData^ endpoint_data,
        CdrStream% stream,
        System::Boolean skip_encapsulation,
        System::Boolean skip_sample, 
        System::Object^ endpoint_plugin_qos);

    System::UInt32 get_serialized_sample_max_size(
        TypePluginEndpointData^ endpoint_data,
        System::Boolean include_encapsulation,
        System::UInt16  encapsulation_id,
        System::UInt32 size);

    System::UInt32 get_serialized_sample_min_size(
        TypePluginEndpointData^ endpoint_data,
        System::Boolean include_encapsulation,
        System::UInt16  encapsulation_id,
        System::UInt32 size);

    System::UInt32 get_serialized_sample_size(
        TypePluginEndpointData^ endpoint_data,
        Boolean include_encapsulation,
        UInt16 encapsulation_id,
        UInt32 current_alignment,
        PrimeNumberCalculationStatus sample);

// --- Key Management functions: ---------------------------------------------
public:
    System::Boolean serialize_key(
        TypePluginEndpointData^ endpoint_data,
        PrimeNumberCalculationStatus key,
        CdrStream% stream,
        System::Boolean serialize_encapsulation,
        System::UInt16  encapsulation_id,
        System::Boolean serialize_sample,
        System::Object^ endpoint_plugin_qos);

    System::Boolean deserialize_key_sample(
        TypePluginEndpointData^ endpoint_data,
        PrimeNumberCalculationStatus% key,
        CdrStream% stream,
        System::Boolean deserialize_encapsulation,
        System::Boolean deserialize_sample,
        System::Object^ endpoint_plugin_qos);

    System::UInt32 get_serialized_key_max_size(
        TypePluginEndpointData^ endpoint_data,
        System::Boolean include_encapsulation,
        System::UInt16  encapsulation_id,
        System::UInt32 current_alignment);

    System::Boolean serialized_sample_to_key(
        TypePluginEndpointData^ endpoint_data,
        PrimeNumberCalculationStatus% sample,
        CdrStream% stream, 
        Boolean deserialize_encapsulation,  
        Boolean deserialize_key, 
        Object^ endpoint_plugin_qos);


// --- Support functions: ----------------------------------------------------
public:
    void print_data(
        PrimeNumberCalculationStatus sample,
        System::String^ desc,
        System::UInt32 indent_level);

    



// ---  Plug-in lifecycle management methods: --------------------------------
public:
    static PrimeNumberCalculationStatusPlugin^ get_instance();

    static void dispose();

private:
    PrimeNumberCalculationStatusPlugin() { /*empty*/ }

    static PrimeNumberCalculationStatusPlugin^ _singleton;
};  

/* ------------------------------------------------------------------------
 * Type: PrimeNumberReply
 * ------------------------------------------------------------------------ */

public ref class PrimeNumberReplyPlugin :
    DefaultTypePlugin<PrimeNumberReply^> {
// --- Support methods: ------------------------------------------------------
public:
    void print_data(
        PrimeNumberReply^ sample,
        System::String^ desc,
        System::UInt32 indent);


// --- (De)Serialize methods: ------------------------------------------------
public:
    virtual System::Boolean serialize(
        TypePluginDefaultEndpointData^ endpoint_data,
        PrimeNumberReply^ sample,
        CdrStream% stream,
        System::Boolean serialize_encapsulation,
        System::UInt16  encapsulation_id,
        System::Boolean serialize_sample,
        System::Object^ endpoint_plugin_qos) override;

    virtual System::Boolean deserialize_sample(
        TypePluginDefaultEndpointData^ endpoint_data,
        PrimeNumberReply^ sample,
        CdrStream% stream,
        System::Boolean deserialize_encapsulation,
        System::Boolean deserialize_sample, 
        System::Object^ endpoint_plugin_qos) override;

    System::Boolean skip(
        TypePluginDefaultEndpointData^ endpoint_data,
        CdrStream% stream,
        System::Boolean skip_encapsulation,  
        System::Boolean skip_sample, 
        System::Object^ endpoint_plugin_qos);

    virtual System::UInt32 get_serialized_sample_max_size(
        TypePluginDefaultEndpointData^ endpoint_data,
        System::Boolean include_encapsulation,
        System::UInt16  encapsulation_id,
        System::UInt32 size) override;

    virtual System::UInt32 get_serialized_sample_min_size(
        TypePluginDefaultEndpointData^ endpoint_data,
        System::Boolean include_encapsulation,
        System::UInt16  encapsulation_id,
        System::UInt32 size) override;

    virtual System::UInt32 get_serialized_sample_size(
        TypePluginDefaultEndpointData^ endpoint_data,
        Boolean include_encapsulation,
        UInt16 encapsulation_id,
        UInt32 current_alignment,
        PrimeNumberReply^ sample) override;

// ---  Key Management functions: --------------------------------------------
public:
    virtual System::UInt32 get_serialized_key_max_size(
        TypePluginDefaultEndpointData^ endpoint_data,
        System::Boolean include_encapsulation,
        System::UInt16  encapsulation_id,
        System::UInt32 current_alignment) override;

    virtual System::Boolean serialize_key(
        TypePluginDefaultEndpointData^ endpoint_data,
        PrimeNumberReply^ key,
        CdrStream% stream,
        System::Boolean serialize_encapsulation,
        System::UInt16  encapsulation_id,
        System::Boolean serialize_sample,
        System::Object^ endpoint_plugin_qos) override;

    virtual System::Boolean deserialize_key_sample(
        TypePluginDefaultEndpointData^ endpoint_data,
        PrimeNumberReply^ key,
        CdrStream% stream,
        System::Boolean deserialize_encapsulation,
        System::Boolean deserialize_sample,
        System::Object^ endpoint_plugin_qos) override;

    System::Boolean serialized_sample_to_key(
        TypePluginDefaultEndpointData^ endpoint_data,
        PrimeNumberReply^ sample,
        CdrStream% stream,
        System::Boolean deserialize_encapsulation,
        System::Boolean deserialize_key,
        System::Object^ endpoint_plugin_qos);

 


// ---  Plug-in lifecycle management methods: --------------------------------
public:
    static PrimeNumberReplyPlugin^ get_instance();

    static void dispose();

private:
    PrimeNumberReplyPlugin()
            : DefaultTypePlugin(
                "PrimeNumberReply",

                false, // not keyed
    
                false, // use RTPS-compliant alignment
                   PrimeNumberReply::get_typecode()) {
        // empty
    }

    static PrimeNumberReplyPlugin^ _singleton;
};
