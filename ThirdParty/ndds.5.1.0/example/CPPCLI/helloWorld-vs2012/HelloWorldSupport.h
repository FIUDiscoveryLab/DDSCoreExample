/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from HelloWorld.idl using "rtiddsgen".
  The rtiddsgen tool is part of the RTI Connext distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the RTI Connext manual.
*/

#pragma once

#include "HelloWorld.h"


class DDSDataWriter;
class DDSDataReader;
    
// ---------------------------------------------------------------------------
// HelloWorldTypeSupport
// ---------------------------------------------------------------------------

ref class HelloWorldPlugin;

/* A collection of useful methods for dealing with objects of type
 * HelloWorld.
 */
public ref class HelloWorldTypeSupport
        : public DDS::TypedTypeSupport<HelloWorld^> {
    // --- Type name: --------------------------------------------------------
  public:
    static System::String^ TYPENAME = "HelloWorld";


    // --- Public Methods: ---------------------------------------------------
  public:
    /* Get the default name of this type.
     *
     * An application can choose to register a type under any name, so
     * calling this method is strictly optional.
     */
    static System::String^ get_type_name();

    /* Register this type with the given participant under the given logical
     * name. This type must be registered before a Topic can be created that
     * uses it.
     */
    static void register_type(
            DDS::DomainParticipant^ participant,
            System::String^ type_name);

    /* Unregister this type from the given participant, where it was
     * previously registered under the given name. No further Topic creation
     * using this type will be possible.
     *
     * Unregistration allows some middleware resources to be reclaimed.
     */
    static void unregister_type(
            DDS::DomainParticipant^ participant,
            System::String^ type_name);

    /* Create an instance of the HelloWorld type.
     */
    static HelloWorld^ create_data();

    /* If instances of the HelloWorld type require any
     * explicit finalization, perform it now on the given sample.
     */
    static void delete_data(HelloWorld^ data);

    /* Write the contents of the data sample to standard out.
     */
    static void print_data(HelloWorld^ a_data);

    /* Perform a deep copy of the contents of one data sample over those of
     * another, overwriting it.
     */
    static void copy_data(
        HelloWorld^ dst_data,
        HelloWorld^ src_data);


    // --- Implementation: ---------------------------------------------------
    /* The following code is for the use of the middleware infrastructure.
     * Applications are not expected to call it directly.
     */
public:
    virtual DDS::DataReader^ create_datareaderI(
        System::IntPtr impl) override;
    virtual DDS::DataWriter^ create_datawriterI(
        System::IntPtr impl) override;
        
    virtual HelloWorld^ create_data_untyped() override;
    
    virtual System::String^ get_type_name_untyped() override;
        

public:
    static HelloWorldTypeSupport^ get_instance();

    HelloWorldTypeSupport();

private:
    static HelloWorldTypeSupport^ _singleton;
    HelloWorldPlugin^ _type_plugin;
};


// ---------------------------------------------------------------------------
// HelloWorldDataReader
// ---------------------------------------------------------------------------

/**
 * A reader for the HelloWorld type.
 */
public ref class HelloWorldDataReader :
        public DDS::TypedDataReader<HelloWorld^> {
    /* The following code is for the use of the middleware infrastructure.
     * Applications are not expected to call it directly.
     */
  internal:
    HelloWorldDataReader(System::IntPtr impl);
};


// ---------------------------------------------------------------------------
// HelloWorldDataWriter
// ---------------------------------------------------------------------------

/**
 * A writer for the HelloWorld user type.
 */
public ref class HelloWorldDataWriter :
        public DDS::TypedDataWriter<HelloWorld^> {
    /* The following code is for the use of the middleware infrastructure.
     * Applications are not expected to call it directly.
     */
  internal:
    HelloWorldDataWriter(System::IntPtr impl);
};
