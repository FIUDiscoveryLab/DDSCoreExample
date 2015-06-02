/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from Primes.idl using "rtiddsgen".
  The rtiddsgen tool is part of the RTI Connext distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the RTI Connext manual.
*/

#include "PrimesPlugin.h"


#pragma unmanaged
#include "ndds/ndds_cpp.h"
#include "osapi/osapi_utility.h"
#pragma managed

using namespace System::Runtime::InteropServices;
    
/* ------------------------------------------------------------------------
 *  Type Foo
 * ------------------------------------------------------------------------ */

/* ------------------------------------------------------------------------
    Support functions:
 * ------------------------------------------------------------------------ */

void 
FooPlugin::print_data(
        Foo^ sample,
        String^ desc,
        UInt32 indent_level) {

    for (UInt32 i = 0; i < indent_level; ++i) { Console::Write("   "); }

    if (desc != nullptr) {
        Console::WriteLine("{0}:", desc);
    } else {
        Console::WriteLine();
    }

    if (sample == nullptr) {
        Console::WriteLine("null");
        return;
    }


    DataPrintUtility::print_object(
        sample->message, "message", indent_level);
            
}


/* ------------------------------------------------------------------------
    (De)Serialize functions:
 * ------------------------------------------------------------------------ */

Boolean 
FooPlugin::serialize(
    TypePluginDefaultEndpointData^ endpoint_data,
    Foo^ sample,
    CdrStream% stream,    
    Boolean serialize_encapsulation,
    UInt16 encapsulation_id,
    Boolean serialize_sample, 
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    

    if (serialize_encapsulation) {
        /* Encapsulate sample */
        
        if (!stream.serialize_and_set_cdr_encapsulation(encapsulation_id)) {
            return false;
        }


        position = stream.reset_alignment();

    }

    if (serialize_sample) {

    if (!stream.serialize_string(sample->message, (255))) {
        return false;
    }
            
    }


    if(serialize_encapsulation) {
        stream.restore_alignment(position);
    }


    return true;
}


Boolean 
FooPlugin::deserialize_sample(
    TypePluginDefaultEndpointData^ endpoint_data,
    Foo^ sample,
    CdrStream% stream,   
    Boolean deserialize_encapsulation,
    Boolean deserialize_data, 
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    if(deserialize_encapsulation) {
        /* Deserialize encapsulation */
        if (!stream.deserialize_and_set_cdr_encapsulation()) {
            return false;
        }


        position = stream.reset_alignment();

    }

    if (deserialize_data) {
        sample->clear();

    try {
  
    sample->message = stream.deserialize_string((255)); 
    if (sample->message == nullptr) {
        return false;
    }
            
    } catch (System::ApplicationException^  e) {
        if (stream.get_remainder() >= RTI_CDR_PARAMETER_HEADER_ALIGNMENT) {
            throw gcnew System::ApplicationException("Error deserializing sample! Remainder: " + stream.get_remainder() + "\n" +
                                                              "Exception caused by: " + e->Message);
        }
    }

    }


    if(deserialize_encapsulation) {
        stream.restore_alignment(position);
    }


    return true;
}


Boolean
FooPlugin::skip(
    TypePluginDefaultEndpointData^ endpoint_data,
    CdrStream% stream,   
    Boolean skip_encapsulation,
    Boolean skip_sample, 
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;


    if (skip_encapsulation) {
        if (!stream.skip_encapsulation()) {
            return false;
        }

        position = stream.reset_alignment();

    }

    if (skip_sample) {

    if (!stream.skip_string((255) + 1)) {
        return false;
    }
            
    }


    if(skip_encapsulation) {
        stream.restore_alignment(position);
    }


    return true;
}

/*
  size is the offset from the point where we have do a logical reset
  Return difference in size, not the final offset.
*/
UInt32 
FooPlugin::get_serialized_sample_max_size(
    TypePluginDefaultEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment)
{

    UInt32 initial_alignment = current_alignment;

    UInt32 encapsulation_size = current_alignment;


    if (include_encapsulation) {
        if (!CdrStream::valid_encapsulation_id(encapsulation_id)) {
            return 1;
        }


        encapsulation_size = CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
        encapsulation_size -= current_alignment;
        current_alignment = 0;
        initial_alignment = 0;

    }


    current_alignment +=  CdrSizes::STRING->serialized_size(
        current_alignment, (255) + 1);
            
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }

    return current_alignment - initial_alignment;
}


UInt32
FooPlugin::get_serialized_sample_min_size(
    TypePluginDefaultEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment)
{

    UInt32 initial_alignment = current_alignment;

    UInt32 encapsulation_size = current_alignment;


    if (include_encapsulation) {
        if (!CdrStream::valid_encapsulation_id(encapsulation_id)) {
            return 1;
        }


        encapsulation_size = CdrSizes::ENCAPSULATION->serialized_size(
            encapsulation_size);
        current_alignment = 0;
        initial_alignment = 0;

    }


    current_alignment +=  CdrSizes::STRING->serialized_size(
        current_alignment, 1);
            
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }

    return current_alignment - initial_alignment;
}


UInt32 
FooPlugin::get_serialized_sample_size(
    TypePluginDefaultEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment,
    Foo^ sample)
{

    UInt32 initial_alignment = current_alignment;

    UInt32 encapsulation_size = current_alignment;


    if (include_encapsulation) {
        if (!CdrStream::valid_encapsulation_id(encapsulation_id)) {
            return 1;
        }


        encapsulation_size = CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
        encapsulation_size -= current_alignment;
        current_alignment = 0;
        initial_alignment = 0;

    }


    current_alignment += CdrSizes::STRING->serialized_size(current_alignment, sample->message);
            
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }

    return current_alignment - initial_alignment;
}


UInt32
FooPlugin::get_serialized_key_max_size(
    TypePluginDefaultEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment)
{

    UInt32 encapsulation_size = current_alignment;


    UInt32 initial_alignment = current_alignment;

    if (include_encapsulation) {
        if (!CdrStream::valid_encapsulation_id(encapsulation_id)) {
            return 1;
        }


        encapsulation_size = CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
        current_alignment = 0;
        initial_alignment = 0;

    }
        

    current_alignment += get_serialized_sample_max_size(
        endpoint_data,false,encapsulation_id,current_alignment);
    
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }

    return current_alignment - initial_alignment;
}

/* ------------------------------------------------------------------------
    Key Management functions:
 * ------------------------------------------------------------------------ */

Boolean 
FooPlugin::serialize_key(
    TypePluginDefaultEndpointData^ endpoint_data,
    Foo^ sample,
    CdrStream% stream,    
    Boolean serialize_encapsulation,
    UInt16 encapsulation_id,
    Boolean serialize_key,
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    if (serialize_encapsulation) {
        /* Encapsulate sample */

        if (!stream.serialize_and_set_cdr_encapsulation(encapsulation_id)) {
            return false;
        }


        position = stream.reset_alignment();

    }

    if (serialize_key) {

        if (!serialize(
                endpoint_data,
                sample,
                stream,
                serialize_encapsulation,
                encapsulation_id, 
                serialize_key,
                endpoint_plugin_qos)) {
            return false;
        }
    
    }


    if(serialize_encapsulation) {
        stream.restore_alignment(position);
    }


    return true;
}


Boolean FooPlugin::deserialize_key_sample(
    TypePluginDefaultEndpointData^ endpoint_data,
    Foo^ sample,
    CdrStream% stream, 
    Boolean deserialize_encapsulation,
    Boolean deserialize_key,
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    if (deserialize_encapsulation) {
        /* Deserialize encapsulation */
        if (!stream.deserialize_and_set_cdr_encapsulation()) {
            return false;  
        }


        position = stream.reset_alignment();

    }

    if (deserialize_key) {

        if (!deserialize_sample(
                endpoint_data, sample, stream,
                deserialize_encapsulation,
                deserialize_key,
                endpoint_plugin_qos)) {
            return false;
        }
    
    }


    if(deserialize_encapsulation) {
        stream.restore_alignment(position);
    }


    return true;
}


Boolean
FooPlugin::serialized_sample_to_key(
    TypePluginDefaultEndpointData^ endpoint_data,
    Foo^ sample,
    CdrStream% stream, 
    Boolean deserialize_encapsulation,  
    Boolean deserialize_key, 
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    if(deserialize_encapsulation) {
        if (!stream.deserialize_and_set_cdr_encapsulation()) {
            return false;
        }

        position = stream.reset_alignment();

    }

    if (deserialize_key) {

        if (!deserialize_sample(
                endpoint_data,
                sample,
                stream,
                deserialize_encapsulation,
                deserialize_key,
                endpoint_plugin_qos)) {
            return false;
        }

    }


    if(deserialize_encapsulation) {
        stream.restore_alignment(position);
    }


    return true;
}




/* ------------------------------------------------------------------------
 * Plug-in Lifecycle Methods
 * ------------------------------------------------------------------------ */

FooPlugin^
FooPlugin::get_instance() {
    if (_singleton == nullptr) {
        _singleton = gcnew FooPlugin();
    }
    return _singleton;
}


void
FooPlugin::dispose() {
    delete _singleton;
    _singleton = nullptr;
}

/* ------------------------------------------------------------------------
 *  Type Bar
 * ------------------------------------------------------------------------ */

/* ------------------------------------------------------------------------
    Support functions:
 * ------------------------------------------------------------------------ */

void 
BarPlugin::print_data(
        Bar^ sample,
        String^ desc,
        UInt32 indent_level) {

    for (UInt32 i = 0; i < indent_level; ++i) { Console::Write("   "); }

    if (desc != nullptr) {
        Console::WriteLine("{0}:", desc);
    } else {
        Console::WriteLine();
    }

    if (sample == nullptr) {
        Console::WriteLine("null");
        return;
    }


    DataPrintUtility::print_object(
        sample->message, "message", indent_level);
            
}


/* ------------------------------------------------------------------------
    (De)Serialize functions:
 * ------------------------------------------------------------------------ */

Boolean 
BarPlugin::serialize(
    TypePluginDefaultEndpointData^ endpoint_data,
    Bar^ sample,
    CdrStream% stream,    
    Boolean serialize_encapsulation,
    UInt16 encapsulation_id,
    Boolean serialize_sample, 
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    

    if (serialize_encapsulation) {
        /* Encapsulate sample */
        
        if (!stream.serialize_and_set_cdr_encapsulation(encapsulation_id)) {
            return false;
        }


        position = stream.reset_alignment();

    }

    if (serialize_sample) {

    if (!stream.serialize_string(sample->message, (255))) {
        return false;
    }
            
    }


    if(serialize_encapsulation) {
        stream.restore_alignment(position);
    }


    return true;
}


Boolean 
BarPlugin::deserialize_sample(
    TypePluginDefaultEndpointData^ endpoint_data,
    Bar^ sample,
    CdrStream% stream,   
    Boolean deserialize_encapsulation,
    Boolean deserialize_data, 
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    if(deserialize_encapsulation) {
        /* Deserialize encapsulation */
        if (!stream.deserialize_and_set_cdr_encapsulation()) {
            return false;
        }


        position = stream.reset_alignment();

    }

    if (deserialize_data) {
        sample->clear();

    try {
  
    sample->message = stream.deserialize_string((255)); 
    if (sample->message == nullptr) {
        return false;
    }
            
    } catch (System::ApplicationException^  e) {
        if (stream.get_remainder() >= RTI_CDR_PARAMETER_HEADER_ALIGNMENT) {
            throw gcnew System::ApplicationException("Error deserializing sample! Remainder: " + stream.get_remainder() + "\n" +
                                                              "Exception caused by: " + e->Message);
        }
    }

    }


    if(deserialize_encapsulation) {
        stream.restore_alignment(position);
    }


    return true;
}


Boolean
BarPlugin::skip(
    TypePluginDefaultEndpointData^ endpoint_data,
    CdrStream% stream,   
    Boolean skip_encapsulation,
    Boolean skip_sample, 
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;


    if (skip_encapsulation) {
        if (!stream.skip_encapsulation()) {
            return false;
        }

        position = stream.reset_alignment();

    }

    if (skip_sample) {

    if (!stream.skip_string((255) + 1)) {
        return false;
    }
            
    }


    if(skip_encapsulation) {
        stream.restore_alignment(position);
    }


    return true;
}

/*
  size is the offset from the point where we have do a logical reset
  Return difference in size, not the final offset.
*/
UInt32 
BarPlugin::get_serialized_sample_max_size(
    TypePluginDefaultEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment)
{

    UInt32 initial_alignment = current_alignment;

    UInt32 encapsulation_size = current_alignment;


    if (include_encapsulation) {
        if (!CdrStream::valid_encapsulation_id(encapsulation_id)) {
            return 1;
        }


        encapsulation_size = CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
        encapsulation_size -= current_alignment;
        current_alignment = 0;
        initial_alignment = 0;

    }


    current_alignment +=  CdrSizes::STRING->serialized_size(
        current_alignment, (255) + 1);
            
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }

    return current_alignment - initial_alignment;
}


UInt32
BarPlugin::get_serialized_sample_min_size(
    TypePluginDefaultEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment)
{

    UInt32 initial_alignment = current_alignment;

    UInt32 encapsulation_size = current_alignment;


    if (include_encapsulation) {
        if (!CdrStream::valid_encapsulation_id(encapsulation_id)) {
            return 1;
        }


        encapsulation_size = CdrSizes::ENCAPSULATION->serialized_size(
            encapsulation_size);
        current_alignment = 0;
        initial_alignment = 0;

    }


    current_alignment +=  CdrSizes::STRING->serialized_size(
        current_alignment, 1);
            
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }

    return current_alignment - initial_alignment;
}


UInt32 
BarPlugin::get_serialized_sample_size(
    TypePluginDefaultEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment,
    Bar^ sample)
{

    UInt32 initial_alignment = current_alignment;

    UInt32 encapsulation_size = current_alignment;


    if (include_encapsulation) {
        if (!CdrStream::valid_encapsulation_id(encapsulation_id)) {
            return 1;
        }


        encapsulation_size = CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
        encapsulation_size -= current_alignment;
        current_alignment = 0;
        initial_alignment = 0;

    }


    current_alignment += CdrSizes::STRING->serialized_size(current_alignment, sample->message);
            
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }

    return current_alignment - initial_alignment;
}


UInt32
BarPlugin::get_serialized_key_max_size(
    TypePluginDefaultEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment)
{

    UInt32 encapsulation_size = current_alignment;


    UInt32 initial_alignment = current_alignment;

    if (include_encapsulation) {
        if (!CdrStream::valid_encapsulation_id(encapsulation_id)) {
            return 1;
        }


        encapsulation_size = CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
        current_alignment = 0;
        initial_alignment = 0;

    }
        

    current_alignment += get_serialized_sample_max_size(
        endpoint_data,false,encapsulation_id,current_alignment);
    
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }

    return current_alignment - initial_alignment;
}

/* ------------------------------------------------------------------------
    Key Management functions:
 * ------------------------------------------------------------------------ */

Boolean 
BarPlugin::serialize_key(
    TypePluginDefaultEndpointData^ endpoint_data,
    Bar^ sample,
    CdrStream% stream,    
    Boolean serialize_encapsulation,
    UInt16 encapsulation_id,
    Boolean serialize_key,
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    if (serialize_encapsulation) {
        /* Encapsulate sample */

        if (!stream.serialize_and_set_cdr_encapsulation(encapsulation_id)) {
            return false;
        }


        position = stream.reset_alignment();

    }

    if (serialize_key) {

        if (!serialize(
                endpoint_data,
                sample,
                stream,
                serialize_encapsulation,
                encapsulation_id, 
                serialize_key,
                endpoint_plugin_qos)) {
            return false;
        }
    
    }


    if(serialize_encapsulation) {
        stream.restore_alignment(position);
    }


    return true;
}


Boolean BarPlugin::deserialize_key_sample(
    TypePluginDefaultEndpointData^ endpoint_data,
    Bar^ sample,
    CdrStream% stream, 
    Boolean deserialize_encapsulation,
    Boolean deserialize_key,
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    if (deserialize_encapsulation) {
        /* Deserialize encapsulation */
        if (!stream.deserialize_and_set_cdr_encapsulation()) {
            return false;  
        }


        position = stream.reset_alignment();

    }

    if (deserialize_key) {

        if (!deserialize_sample(
                endpoint_data, sample, stream,
                deserialize_encapsulation,
                deserialize_key,
                endpoint_plugin_qos)) {
            return false;
        }
    
    }


    if(deserialize_encapsulation) {
        stream.restore_alignment(position);
    }


    return true;
}


Boolean
BarPlugin::serialized_sample_to_key(
    TypePluginDefaultEndpointData^ endpoint_data,
    Bar^ sample,
    CdrStream% stream, 
    Boolean deserialize_encapsulation,  
    Boolean deserialize_key, 
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    if(deserialize_encapsulation) {
        if (!stream.deserialize_and_set_cdr_encapsulation()) {
            return false;
        }

        position = stream.reset_alignment();

    }

    if (deserialize_key) {

        if (!deserialize_sample(
                endpoint_data,
                sample,
                stream,
                deserialize_encapsulation,
                deserialize_key,
                endpoint_plugin_qos)) {
            return false;
        }

    }


    if(deserialize_encapsulation) {
        stream.restore_alignment(position);
    }


    return true;
}




/* ------------------------------------------------------------------------
 * Plug-in Lifecycle Methods
 * ------------------------------------------------------------------------ */

BarPlugin^
BarPlugin::get_instance() {
    if (_singleton == nullptr) {
        _singleton = gcnew BarPlugin();
    }
    return _singleton;
}


void
BarPlugin::dispose() {
    delete _singleton;
    _singleton = nullptr;
}

/* ------------------------------------------------------------------------
 *  Type PrimeNumberRequest
 * ------------------------------------------------------------------------ */

/* ------------------------------------------------------------------------
    Support functions:
 * ------------------------------------------------------------------------ */

void 
PrimeNumberRequestPlugin::print_data(
        PrimeNumberRequest^ sample,
        String^ desc,
        UInt32 indent_level) {

    for (UInt32 i = 0; i < indent_level; ++i) { Console::Write("   "); }

    if (desc != nullptr) {
        Console::WriteLine("{0}:", desc);
    } else {
        Console::WriteLine();
    }

    if (sample == nullptr) {
        Console::WriteLine("null");
        return;
    }


    DataPrintUtility::print_object(
        sample->n, "n", indent_level);
            
    DataPrintUtility::print_object(
        sample->primes_per_reply, "primes_per_reply", indent_level);
            
}


/* ------------------------------------------------------------------------
    (De)Serialize functions:
 * ------------------------------------------------------------------------ */

Boolean 
PrimeNumberRequestPlugin::serialize(
    TypePluginDefaultEndpointData^ endpoint_data,
    PrimeNumberRequest^ sample,
    CdrStream% stream,    
    Boolean serialize_encapsulation,
    UInt16 encapsulation_id,
    Boolean serialize_sample, 
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    

    if (serialize_encapsulation) {
        /* Encapsulate sample */
        
        if (!stream.serialize_and_set_cdr_encapsulation(encapsulation_id)) {
            return false;
        }


        position = stream.reset_alignment();

    }

    if (serialize_sample) {

    if (!stream.serialize_long(sample->n)) {
        return false;
    }
            
    if (!stream.serialize_long(sample->primes_per_reply)) {
        return false;
    }
            
    }


    if(serialize_encapsulation) {
        stream.restore_alignment(position);
    }


    return true;
}


Boolean 
PrimeNumberRequestPlugin::deserialize_sample(
    TypePluginDefaultEndpointData^ endpoint_data,
    PrimeNumberRequest^ sample,
    CdrStream% stream,   
    Boolean deserialize_encapsulation,
    Boolean deserialize_data, 
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    if(deserialize_encapsulation) {
        /* Deserialize encapsulation */
        if (!stream.deserialize_and_set_cdr_encapsulation()) {
            return false;
        }


        position = stream.reset_alignment();

    }

    if (deserialize_data) {
        sample->clear();

    try {
  
    sample->n = stream.deserialize_long();
            
    sample->primes_per_reply = stream.deserialize_long();
            
    } catch (System::ApplicationException^  e) {
        if (stream.get_remainder() >= RTI_CDR_PARAMETER_HEADER_ALIGNMENT) {
            throw gcnew System::ApplicationException("Error deserializing sample! Remainder: " + stream.get_remainder() + "\n" +
                                                              "Exception caused by: " + e->Message);
        }
    }

    }


    if(deserialize_encapsulation) {
        stream.restore_alignment(position);
    }


    return true;
}


Boolean
PrimeNumberRequestPlugin::skip(
    TypePluginDefaultEndpointData^ endpoint_data,
    CdrStream% stream,   
    Boolean skip_encapsulation,
    Boolean skip_sample, 
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;


    if (skip_encapsulation) {
        if (!stream.skip_encapsulation()) {
            return false;
        }

        position = stream.reset_alignment();

    }

    if (skip_sample) {

    if (!stream.skip_long()) {
        return false;
    }
            
    if (!stream.skip_long()) {
        return false;
    }
            
    }


    if(skip_encapsulation) {
        stream.restore_alignment(position);
    }


    return true;
}

/*
  size is the offset from the point where we have do a logical reset
  Return difference in size, not the final offset.
*/
UInt32 
PrimeNumberRequestPlugin::get_serialized_sample_max_size(
    TypePluginDefaultEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment)
{

    UInt32 initial_alignment = current_alignment;

    UInt32 encapsulation_size = current_alignment;


    if (include_encapsulation) {
        if (!CdrStream::valid_encapsulation_id(encapsulation_id)) {
            return 1;
        }


        encapsulation_size = CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
        encapsulation_size -= current_alignment;
        current_alignment = 0;
        initial_alignment = 0;

    }


    current_alignment +=  CdrSizes::LONG->serialized_size(
        current_alignment);
            
    current_alignment +=  CdrSizes::LONG->serialized_size(
        current_alignment);
            
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }

    return current_alignment - initial_alignment;
}


UInt32
PrimeNumberRequestPlugin::get_serialized_sample_min_size(
    TypePluginDefaultEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment)
{

    UInt32 initial_alignment = current_alignment;

    UInt32 encapsulation_size = current_alignment;


    if (include_encapsulation) {
        if (!CdrStream::valid_encapsulation_id(encapsulation_id)) {
            return 1;
        }


        encapsulation_size = CdrSizes::ENCAPSULATION->serialized_size(
            encapsulation_size);
        current_alignment = 0;
        initial_alignment = 0;

    }


    current_alignment +=  CdrSizes::LONG->serialized_size(
        current_alignment);
            
    current_alignment +=  CdrSizes::LONG->serialized_size(
        current_alignment);
            
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }

    return current_alignment - initial_alignment;
}


UInt32 
PrimeNumberRequestPlugin::get_serialized_sample_size(
    TypePluginDefaultEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment,
    PrimeNumberRequest^ sample)
{

    UInt32 initial_alignment = current_alignment;

    UInt32 encapsulation_size = current_alignment;


    if (include_encapsulation) {
        if (!CdrStream::valid_encapsulation_id(encapsulation_id)) {
            return 1;
        }


        encapsulation_size = CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
        encapsulation_size -= current_alignment;
        current_alignment = 0;
        initial_alignment = 0;

    }


    current_alignment += CdrSizes::LONG->serialized_size(
        current_alignment);
            
    current_alignment += CdrSizes::LONG->serialized_size(
        current_alignment);
            
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }

    return current_alignment - initial_alignment;
}


UInt32
PrimeNumberRequestPlugin::get_serialized_key_max_size(
    TypePluginDefaultEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment)
{

    UInt32 encapsulation_size = current_alignment;


    UInt32 initial_alignment = current_alignment;

    if (include_encapsulation) {
        if (!CdrStream::valid_encapsulation_id(encapsulation_id)) {
            return 1;
        }


        encapsulation_size = CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
        current_alignment = 0;
        initial_alignment = 0;

    }
        

    current_alignment += get_serialized_sample_max_size(
        endpoint_data,false,encapsulation_id,current_alignment);
    
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }

    return current_alignment - initial_alignment;
}

/* ------------------------------------------------------------------------
    Key Management functions:
 * ------------------------------------------------------------------------ */

Boolean 
PrimeNumberRequestPlugin::serialize_key(
    TypePluginDefaultEndpointData^ endpoint_data,
    PrimeNumberRequest^ sample,
    CdrStream% stream,    
    Boolean serialize_encapsulation,
    UInt16 encapsulation_id,
    Boolean serialize_key,
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    if (serialize_encapsulation) {
        /* Encapsulate sample */

        if (!stream.serialize_and_set_cdr_encapsulation(encapsulation_id)) {
            return false;
        }


        position = stream.reset_alignment();

    }

    if (serialize_key) {

        if (!serialize(
                endpoint_data,
                sample,
                stream,
                serialize_encapsulation,
                encapsulation_id, 
                serialize_key,
                endpoint_plugin_qos)) {
            return false;
        }
    
    }


    if(serialize_encapsulation) {
        stream.restore_alignment(position);
    }


    return true;
}


Boolean PrimeNumberRequestPlugin::deserialize_key_sample(
    TypePluginDefaultEndpointData^ endpoint_data,
    PrimeNumberRequest^ sample,
    CdrStream% stream, 
    Boolean deserialize_encapsulation,
    Boolean deserialize_key,
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    if (deserialize_encapsulation) {
        /* Deserialize encapsulation */
        if (!stream.deserialize_and_set_cdr_encapsulation()) {
            return false;  
        }


        position = stream.reset_alignment();

    }

    if (deserialize_key) {

        if (!deserialize_sample(
                endpoint_data, sample, stream,
                deserialize_encapsulation,
                deserialize_key,
                endpoint_plugin_qos)) {
            return false;
        }
    
    }


    if(deserialize_encapsulation) {
        stream.restore_alignment(position);
    }


    return true;
}


Boolean
PrimeNumberRequestPlugin::serialized_sample_to_key(
    TypePluginDefaultEndpointData^ endpoint_data,
    PrimeNumberRequest^ sample,
    CdrStream% stream, 
    Boolean deserialize_encapsulation,  
    Boolean deserialize_key, 
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    if(deserialize_encapsulation) {
        if (!stream.deserialize_and_set_cdr_encapsulation()) {
            return false;
        }

        position = stream.reset_alignment();

    }

    if (deserialize_key) {

        if (!deserialize_sample(
                endpoint_data,
                sample,
                stream,
                deserialize_encapsulation,
                deserialize_key,
                endpoint_plugin_qos)) {
            return false;
        }

    }


    if(deserialize_encapsulation) {
        stream.restore_alignment(position);
    }


    return true;
}




/* ------------------------------------------------------------------------
 * Plug-in Lifecycle Methods
 * ------------------------------------------------------------------------ */

PrimeNumberRequestPlugin^
PrimeNumberRequestPlugin::get_instance() {
    if (_singleton == nullptr) {
        _singleton = gcnew PrimeNumberRequestPlugin();
    }
    return _singleton;
}


void
PrimeNumberRequestPlugin::dispose() {
    delete _singleton;
    _singleton = nullptr;
}


/* ------------------------------------------------------------------------
  Enum Type: PrimeNumberCalculationStatus
 * ------------------------------------------------------------------------ */

/* ------------------------------------------------------------------------
 * (De)Serialization Methods
 * ------------------------------------------------------------------------ */


Boolean
PrimeNumberCalculationStatusPlugin::serialize(
    TypePluginEndpointData^ endpoint_data,
    PrimeNumberCalculationStatus sample,
    CdrStream% stream, 
    Boolean serialize_encapsulation,
    UInt16 encapsulation_id,
    Boolean serialize_sample,
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    if (serialize_encapsulation) {
        if (!stream.serialize_and_set_cdr_encapsulation(encapsulation_id)) {
            return false;
        }

        position = stream.reset_alignment();

    }

    if (serialize_sample) {

        if (!stream.serialize_enum(sample)) {
            return false;
        }

    }


    if (serialize_encapsulation) {
        stream.restore_alignment(position);

    }

    return true;
}


Boolean 
PrimeNumberCalculationStatusPlugin::deserialize_sample(
    TypePluginEndpointData^ endpoint_data,
    PrimeNumberCalculationStatus% sample,
    CdrStream% stream, 
    Boolean deserialize_encapsulation,  
    Boolean deserialize_data, 
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    if (deserialize_encapsulation) {
        if (!stream.deserialize_and_set_cdr_encapsulation()) {
            return false;
        }


        position = stream.reset_alignment();

    }

    if (deserialize_data) {


        sample = stream.deserialize_enum<PrimeNumberCalculationStatus>();

        switch (sample) {

            case PrimeNumberCalculationStatus::REPLY_IN_PROGRESS:

            case PrimeNumberCalculationStatus::REPLY_COMPLETED:

            case PrimeNumberCalculationStatus::REPLY_ERROR:

            {
            } break;
            default:
            {
                throw gcnew Unassignable("invalid enumerator " + sample.ToString());
            } break;
        }

    }

    if(deserialize_encapsulation) {
        stream.restore_alignment(position);
    }


    return true;
}


Boolean
PrimeNumberCalculationStatusPlugin::skip(
    TypePluginEndpointData^ endpoint_data,
    CdrStream% stream, 
    Boolean skip_encapsulation,  
    Boolean skip_sample, 
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    if (skip_encapsulation) {
        if (!stream.skip_encapsulation()) {
            return false;
        }

        position = stream.reset_alignment();

    }
    if (skip_sample) {

        if (!stream.skip_enum()) {
            return false;
        }


    }


    if(skip_encapsulation) {
        stream.restore_alignment(position);
    }


    return true;
}


UInt32
PrimeNumberCalculationStatusPlugin::get_serialized_sample_max_size(
    TypePluginEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment)
{
    UInt32 initial_alignment = current_alignment;

    UInt32 encapsulation_size = current_alignment;


    if (include_encapsulation) {
        if (!CdrStream::valid_encapsulation_id(encapsulation_id)) {
            return 1;
        }


        encapsulation_size = CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
        current_alignment = 0;
        initial_alignment = 0;

    }

    current_alignment += RTICdrType_getEnumMaxSizeSerialized(current_alignment);


    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }


    return current_alignment - initial_alignment;
}


UInt32
PrimeNumberCalculationStatusPlugin::get_serialized_sample_min_size(
    TypePluginEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment)
{
    UInt32 initial_alignment = current_alignment;

    UInt32 encapsulation_size = current_alignment;


    if (include_encapsulation) {
        if (!CdrStream::valid_encapsulation_id(encapsulation_id)) {
            return 1;
        }


        encapsulation_size = CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
        current_alignment = 0;
        initial_alignment = 0;

    }

    current_alignment += RTICdrType_getEnumMaxSizeSerialized(current_alignment);


    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }


    return current_alignment - initial_alignment;
}


UInt32
PrimeNumberCalculationStatusPlugin::get_serialized_sample_size(
    TypePluginEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment,
    PrimeNumberCalculationStatus sample) 
{
    UInt32 initial_alignment = current_alignment;

    UInt32 encapsulation_size = current_alignment;


    if (include_encapsulation) {
        if (!CdrStream::valid_encapsulation_id(encapsulation_id)) {
            return 1;
        }


        encapsulation_size = CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
        current_alignment = 0;
        initial_alignment = 0;

    }

    current_alignment += RTICdrType_getEnumMaxSizeSerialized(current_alignment);


    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }


    return current_alignment - initial_alignment;
}

/* ------------------------------------------------------------------------
    Key Management functions:
 * ------------------------------------------------------------------------ */


Boolean
PrimeNumberCalculationStatusPlugin::serialize_key(
    TypePluginEndpointData^ endpoint_data,
    PrimeNumberCalculationStatus sample,
    CdrStream% stream,
    Boolean serialize_encapsulation,
    UInt16 encapsulation_id,
    Boolean serialize_key,
    Object^ endpoint_plugin_qos)
{
    return serialize(
            endpoint_data, sample, stream, serialize_encapsulation, 
            encapsulation_id, 
            serialize_key, endpoint_plugin_qos);
}


Boolean
PrimeNumberCalculationStatusPlugin::deserialize_key_sample(
    TypePluginEndpointData^ endpoint_data,
    PrimeNumberCalculationStatus% sample,
    CdrStream% stream,
    Boolean deserialize_encapsulation,
    Boolean deserialize_key,
    Object^ endpoint_plugin_qos)
{
    return deserialize_sample(
            endpoint_data, sample, stream, deserialize_encapsulation, 
            deserialize_key, endpoint_plugin_qos);
}


UInt32
PrimeNumberCalculationStatusPlugin::get_serialized_key_max_size(
    TypePluginEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment)
{
    UInt32 initial_alignment = current_alignment;

    current_alignment += get_serialized_sample_max_size(
        endpoint_data,include_encapsulation,
        encapsulation_id,current_alignment);

    return current_alignment - initial_alignment;
}


Boolean
PrimeNumberCalculationStatusPlugin::serialized_sample_to_key(
    TypePluginEndpointData^ endpoint_data,
    PrimeNumberCalculationStatus% sample,
    CdrStream% stream, 
    Boolean deserialize_encapsulation,  
    Boolean deserialize_key, 
    Object^ endpoint_plugin_qos)
{    
    return deserialize_sample(
            endpoint_data,
            sample,
            stream,
            deserialize_encapsulation, 
            deserialize_key,
            endpoint_plugin_qos);
}


/* ------------------------------------------------------------------------
   Support functions:
 * ------------------------------------------------------------------------ */


void
PrimeNumberCalculationStatusPlugin::print_data(
    PrimeNumberCalculationStatus sample,
    String^ description,
    UInt32 indent_level)
{
    if (description != nullptr) {
        for (UInt32 i = 0; i < indent_level; ++i) { Console::Write("   "); }
        Console::WriteLine("{0}:", description);
    }

    RTICdrType_printEnum((RTICdrEnum*) &sample,
                         "PrimeNumberCalculationStatus", indent_level + 1);
}


/* ------------------------------------------------------------------------
 * Plug-in Lifecycle Methods
 * ------------------------------------------------------------------------ */

PrimeNumberCalculationStatusPlugin^
PrimeNumberCalculationStatusPlugin::get_instance() {
    if (_singleton == nullptr) {
        _singleton = gcnew PrimeNumberCalculationStatusPlugin();
    }
    return _singleton;
}


void
PrimeNumberCalculationStatusPlugin::dispose() {
    delete _singleton;
    _singleton = nullptr;
}


/* ------------------------------------------------------------------------
 *  Type PrimeNumberReply
 * ------------------------------------------------------------------------ */

/* ------------------------------------------------------------------------
    Support functions:
 * ------------------------------------------------------------------------ */

void 
PrimeNumberReplyPlugin::print_data(
        PrimeNumberReply^ sample,
        String^ desc,
        UInt32 indent_level) {

    for (UInt32 i = 0; i < indent_level; ++i) { Console::Write("   "); }

    if (desc != nullptr) {
        Console::WriteLine("{0}:", desc);
    } else {
        Console::WriteLine();
    }

    if (sample == nullptr) {
        Console::WriteLine("null");
        return;
    }


    DataPrintUtility::print_objects(
        sample->primes, "primes", indent_level);
            
    DataPrintUtility::print_object(
        sample->status, "status", indent_level);
            
}


/* ------------------------------------------------------------------------
    (De)Serialize functions:
 * ------------------------------------------------------------------------ */

Boolean 
PrimeNumberReplyPlugin::serialize(
    TypePluginDefaultEndpointData^ endpoint_data,
    PrimeNumberReply^ sample,
    CdrStream% stream,    
    Boolean serialize_encapsulation,
    UInt16 encapsulation_id,
    Boolean serialize_sample, 
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    

    if (serialize_encapsulation) {
        /* Encapsulate sample */
        
        if (!stream.serialize_and_set_cdr_encapsulation(encapsulation_id)) {
            return false;
        }


        position = stream.reset_alignment();

    }

    if (serialize_sample) {

    if (!stream.serialize_primitive_sequence(sample->primes)) {
        return false;
    }
            
    if (!PrimeNumberCalculationStatusPlugin::get_instance()->serialize(
            endpoint_data,
            sample->status,
            stream,
            false, // serialize encapsulation
            encapsulation_id,
            true,  // serialize data 
            endpoint_plugin_qos)) {
        return false;
    }
            
    }


    if(serialize_encapsulation) {
        stream.restore_alignment(position);
    }


    return true;
}


Boolean 
PrimeNumberReplyPlugin::deserialize_sample(
    TypePluginDefaultEndpointData^ endpoint_data,
    PrimeNumberReply^ sample,
    CdrStream% stream,   
    Boolean deserialize_encapsulation,
    Boolean deserialize_data, 
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    if(deserialize_encapsulation) {
        /* Deserialize encapsulation */
        if (!stream.deserialize_and_set_cdr_encapsulation()) {
            return false;
        }


        position = stream.reset_alignment();

    }

    if (deserialize_data) {
        sample->clear();

    try {
  
    if (!stream.deserialize_primitive_sequence(
             sample->primes,
             ((PRIME_SEQUENCE_MAX_LENGTH::VALUE)))) {
        return false;
    }
            
    if (!PrimeNumberCalculationStatusPlugin::get_instance()->deserialize_sample(
            endpoint_data,
            sample->status,
            stream,
            false, // deserialize encapsulation
            true,  // deserialize data
            endpoint_plugin_qos)) {
        return false;
    }
            
    } catch (System::ApplicationException^  e) {
        if (stream.get_remainder() >= RTI_CDR_PARAMETER_HEADER_ALIGNMENT) {
            throw gcnew System::ApplicationException("Error deserializing sample! Remainder: " + stream.get_remainder() + "\n" +
                                                              "Exception caused by: " + e->Message);
        }
    }

    }


    if(deserialize_encapsulation) {
        stream.restore_alignment(position);
    }


    return true;
}


Boolean
PrimeNumberReplyPlugin::skip(
    TypePluginDefaultEndpointData^ endpoint_data,
    CdrStream% stream,   
    Boolean skip_encapsulation,
    Boolean skip_sample, 
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    UInt32 sequence_length = 0;


    if (skip_encapsulation) {
        if (!stream.skip_encapsulation()) {
            return false;
        }

        position = stream.reset_alignment();

    }

    if (skip_sample) {

    if (!stream.skip_primitive_sequence(RTI_CDR_LONG_TYPE)) {
        return false;
    }
            
    if (!PrimeNumberCalculationStatusPlugin::get_instance()->skip(
            endpoint_data,
            stream, 
            false, true, 
            endpoint_plugin_qos)) {
        return false;
    }
            
    }


    if(skip_encapsulation) {
        stream.restore_alignment(position);
    }


    return true;
}

/*
  size is the offset from the point where we have do a logical reset
  Return difference in size, not the final offset.
*/
UInt32 
PrimeNumberReplyPlugin::get_serialized_sample_max_size(
    TypePluginDefaultEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment)
{

    UInt32 initial_alignment = current_alignment;

    UInt32 encapsulation_size = current_alignment;


    if (include_encapsulation) {
        if (!CdrStream::valid_encapsulation_id(encapsulation_id)) {
            return 1;
        }


        encapsulation_size = CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
        encapsulation_size -= current_alignment;
        current_alignment = 0;
        initial_alignment = 0;

    }


    current_alignment +=  CdrSizes::LONG->serialized_sequence_size(
        current_alignment, ((PRIME_SEQUENCE_MAX_LENGTH::VALUE)));
            
    current_alignment +=  PrimeNumberCalculationStatusPlugin::get_instance()->get_serialized_sample_max_size(
        endpoint_data, false, encapsulation_id, current_alignment);
            
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }

    return current_alignment - initial_alignment;
}


UInt32
PrimeNumberReplyPlugin::get_serialized_sample_min_size(
    TypePluginDefaultEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment)
{

    UInt32 initial_alignment = current_alignment;

    UInt32 encapsulation_size = current_alignment;


    if (include_encapsulation) {
        if (!CdrStream::valid_encapsulation_id(encapsulation_id)) {
            return 1;
        }


        encapsulation_size = CdrSizes::ENCAPSULATION->serialized_size(
            encapsulation_size);
        current_alignment = 0;
        initial_alignment = 0;

    }


    current_alignment +=  CdrSizes::LONG->serialized_sequence_size(
        current_alignment, 0);
            
    current_alignment +=  PrimeNumberCalculationStatusPlugin::get_instance()->get_serialized_sample_min_size(
        endpoint_data, false, encapsulation_id, current_alignment);
            
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }

    return current_alignment - initial_alignment;
}


UInt32 
PrimeNumberReplyPlugin::get_serialized_sample_size(
    TypePluginDefaultEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment,
    PrimeNumberReply^ sample)
{

    UInt32 initial_alignment = current_alignment;

    UInt32 encapsulation_size = current_alignment;


    if (include_encapsulation) {
        if (!CdrStream::valid_encapsulation_id(encapsulation_id)) {
            return 1;
        }


        encapsulation_size = CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
        encapsulation_size -= current_alignment;
        current_alignment = 0;
        initial_alignment = 0;

    }


    current_alignment += CdrSizes::LONG->serialized_sequence_size(
        current_alignment, sample->primes->length);
            
    current_alignment += PrimeNumberCalculationStatusPlugin::get_instance()->get_serialized_sample_size(
        endpoint_data, false, encapsulation_id, current_alignment, sample->status);
            
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }

    return current_alignment - initial_alignment;
}


UInt32
PrimeNumberReplyPlugin::get_serialized_key_max_size(
    TypePluginDefaultEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment)
{

    UInt32 encapsulation_size = current_alignment;


    UInt32 initial_alignment = current_alignment;

    if (include_encapsulation) {
        if (!CdrStream::valid_encapsulation_id(encapsulation_id)) {
            return 1;
        }


        encapsulation_size = CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
        current_alignment = 0;
        initial_alignment = 0;

    }
        

    current_alignment += get_serialized_sample_max_size(
        endpoint_data,false,encapsulation_id,current_alignment);
    
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }

    return current_alignment - initial_alignment;
}

/* ------------------------------------------------------------------------
    Key Management functions:
 * ------------------------------------------------------------------------ */

Boolean 
PrimeNumberReplyPlugin::serialize_key(
    TypePluginDefaultEndpointData^ endpoint_data,
    PrimeNumberReply^ sample,
    CdrStream% stream,    
    Boolean serialize_encapsulation,
    UInt16 encapsulation_id,
    Boolean serialize_key,
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    if (serialize_encapsulation) {
        /* Encapsulate sample */

        if (!stream.serialize_and_set_cdr_encapsulation(encapsulation_id)) {
            return false;
        }


        position = stream.reset_alignment();

    }

    if (serialize_key) {

        if (!serialize(
                endpoint_data,
                sample,
                stream,
                serialize_encapsulation,
                encapsulation_id, 
                serialize_key,
                endpoint_plugin_qos)) {
            return false;
        }
    
    }


    if(serialize_encapsulation) {
        stream.restore_alignment(position);
    }


    return true;
}


Boolean PrimeNumberReplyPlugin::deserialize_key_sample(
    TypePluginDefaultEndpointData^ endpoint_data,
    PrimeNumberReply^ sample,
    CdrStream% stream, 
    Boolean deserialize_encapsulation,
    Boolean deserialize_key,
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    if (deserialize_encapsulation) {
        /* Deserialize encapsulation */
        if (!stream.deserialize_and_set_cdr_encapsulation()) {
            return false;  
        }


        position = stream.reset_alignment();

    }

    if (deserialize_key) {

        if (!deserialize_sample(
                endpoint_data, sample, stream,
                deserialize_encapsulation,
                deserialize_key,
                endpoint_plugin_qos)) {
            return false;
        }
    
    }


    if(deserialize_encapsulation) {
        stream.restore_alignment(position);
    }


    return true;
}


Boolean
PrimeNumberReplyPlugin::serialized_sample_to_key(
    TypePluginDefaultEndpointData^ endpoint_data,
    PrimeNumberReply^ sample,
    CdrStream% stream, 
    Boolean deserialize_encapsulation,  
    Boolean deserialize_key, 
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    if(deserialize_encapsulation) {
        if (!stream.deserialize_and_set_cdr_encapsulation()) {
            return false;
        }

        position = stream.reset_alignment();

    }

    if (deserialize_key) {

        if (!deserialize_sample(
                endpoint_data,
                sample,
                stream,
                deserialize_encapsulation,
                deserialize_key,
                endpoint_plugin_qos)) {
            return false;
        }

    }


    if(deserialize_encapsulation) {
        stream.restore_alignment(position);
    }


    return true;
}




/* ------------------------------------------------------------------------
 * Plug-in Lifecycle Methods
 * ------------------------------------------------------------------------ */

PrimeNumberReplyPlugin^
PrimeNumberReplyPlugin::get_instance() {
    if (_singleton == nullptr) {
        _singleton = gcnew PrimeNumberReplyPlugin();
    }
    return _singleton;
}


void
PrimeNumberReplyPlugin::dispose() {
    delete _singleton;
    _singleton = nullptr;
}
