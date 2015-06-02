/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from HelloWorld.idl using "rtiddsgen".
  The rtiddsgen tool is part of the RTI Connext distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the RTI Connext manual.
*/

#include "HelloWorldSupport.h"
#include "HelloWorldPlugin.h"


using namespace System;
using namespace DDS;
    
/* ========================================================================= */

// ---------------------------------------------------------------------------
// HelloWorldDataWriter
// ---------------------------------------------------------------------------

HelloWorldDataWriter::HelloWorldDataWriter(
        System::IntPtr impl) : DDS::TypedDataWriter<HelloWorld^>(impl) {
    // empty
}


// ---------------------------------------------------------------------------
// HelloWorldDataReader
// ---------------------------------------------------------------------------

HelloWorldDataReader::HelloWorldDataReader(
        System::IntPtr impl) : DDS::TypedDataReader<HelloWorld^>(impl) {
    // empty
}


// ---------------------------------------------------------------------------
// HelloWorldTypeSupport
// ---------------------------------------------------------------------------

HelloWorldTypeSupport::HelloWorldTypeSupport()
        : DDS::TypedTypeSupport<HelloWorld^>(
            HelloWorldPlugin::get_instance()) {

    _type_plugin = HelloWorldPlugin::get_instance();
}

void HelloWorldTypeSupport::register_type(
        DDS::DomainParticipant^ participant,
        System::String^ type_name) {

    get_instance()->register_type_untyped(participant, type_name);
}

void HelloWorldTypeSupport::unregister_type(
        DDS::DomainParticipant^ participant,
        System::String^ type_name) {

    get_instance()->unregister_type_untyped(participant, type_name);
}

HelloWorld^ HelloWorldTypeSupport::create_data() {
    return gcnew HelloWorld();
}

HelloWorld^ HelloWorldTypeSupport::create_data_untyped() {
    return create_data();
}

void HelloWorldTypeSupport::delete_data(
        HelloWorld^ a_data) {
    /* If the generated type does not implement IDisposable (the default),
     * the following will no a no-op.
     */
    delete a_data;
}

void HelloWorldTypeSupport::print_data(HelloWorld^ a_data) {
     get_instance()->_type_plugin->print_data(a_data, nullptr, 0);
}

void HelloWorldTypeSupport::copy_data(
        HelloWorld^ dst, HelloWorld^ src) {

    get_instance()->copy_data_untyped(dst, src);
}

System::String^ HelloWorldTypeSupport::get_type_name() {
    return TYPENAME;
}

System::String^ HelloWorldTypeSupport::get_type_name_untyped() {
    return TYPENAME;
}

DDS::DataReader^ HelloWorldTypeSupport::create_datareaderI(
        System::IntPtr impl) {

    return gcnew HelloWorldDataReader(impl);
}

DDS::DataWriter^ HelloWorldTypeSupport::create_datawriterI(
        System::IntPtr impl) {

    return gcnew HelloWorldDataWriter(impl);
}

HelloWorldTypeSupport^
HelloWorldTypeSupport::get_instance() {
    if (_singleton == nullptr) {
        _singleton = gcnew HelloWorldTypeSupport();
    }
    return _singleton;
}
    