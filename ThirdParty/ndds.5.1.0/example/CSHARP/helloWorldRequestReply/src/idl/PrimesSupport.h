/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from Primes.idl using "rtiddsgen".
  The rtiddsgen tool is part of the RTI Connext distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the RTI Connext manual.
*/

#pragma once

#include "Primes.h"


class DDSDataWriter;
class DDSDataReader;
    
// ---------------------------------------------------------------------------
// FooTypeSupport
// ---------------------------------------------------------------------------

ref class FooPlugin;

/* A collection of useful methods for dealing with objects of type
 * Foo.
 */
public ref class FooTypeSupport
        : public DDS::TypedTypeSupport<Foo^> {
    // --- Type name: --------------------------------------------------------
  public:
    static System::String^ TYPENAME = "Foo";


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

    /* Create an instance of the Foo type.
     */
    static Foo^ create_data();

    /* If instances of the Foo type require any
     * explicit finalization, perform it now on the given sample.
     */
    static void delete_data(Foo^ data);

    /* Write the contents of the data sample to standard out.
     */
    static void print_data(Foo^ a_data);

    /* Perform a deep copy of the contents of one data sample over those of
     * another, overwriting it.
     */
    static void copy_data(
        Foo^ dst_data,
        Foo^ src_data);


    // --- Implementation: ---------------------------------------------------
    /* The following code is for the use of the middleware infrastructure.
     * Applications are not expected to call it directly.
     */
public:
    virtual DDS::DataReader^ create_datareaderI(
        System::IntPtr impl) override;
    virtual DDS::DataWriter^ create_datawriterI(
        System::IntPtr impl) override;
        
    virtual Foo^ create_data_untyped() override;
    
    virtual System::String^ get_type_name_untyped() override;
        

public:
    static FooTypeSupport^ get_instance();

    FooTypeSupport();

private:
    static FooTypeSupport^ _singleton;
    FooPlugin^ _type_plugin;
};


// ---------------------------------------------------------------------------
// FooDataReader
// ---------------------------------------------------------------------------

/**
 * A reader for the Foo type.
 */
public ref class FooDataReader :
        public DDS::TypedDataReader<Foo^> {
    /* The following code is for the use of the middleware infrastructure.
     * Applications are not expected to call it directly.
     */
  internal:
    FooDataReader(System::IntPtr impl);
};


// ---------------------------------------------------------------------------
// FooDataWriter
// ---------------------------------------------------------------------------

/**
 * A writer for the Foo user type.
 */
public ref class FooDataWriter :
        public DDS::TypedDataWriter<Foo^> {
    /* The following code is for the use of the middleware infrastructure.
     * Applications are not expected to call it directly.
     */
  internal:
    FooDataWriter(System::IntPtr impl);
};

// ---------------------------------------------------------------------------
// BarTypeSupport
// ---------------------------------------------------------------------------

ref class BarPlugin;

/* A collection of useful methods for dealing with objects of type
 * Bar.
 */
public ref class BarTypeSupport
        : public DDS::TypedTypeSupport<Bar^> {
    // --- Type name: --------------------------------------------------------
  public:
    static System::String^ TYPENAME = "Bar";


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

    /* Create an instance of the Bar type.
     */
    static Bar^ create_data();

    /* If instances of the Bar type require any
     * explicit finalization, perform it now on the given sample.
     */
    static void delete_data(Bar^ data);

    /* Write the contents of the data sample to standard out.
     */
    static void print_data(Bar^ a_data);

    /* Perform a deep copy of the contents of one data sample over those of
     * another, overwriting it.
     */
    static void copy_data(
        Bar^ dst_data,
        Bar^ src_data);


    // --- Implementation: ---------------------------------------------------
    /* The following code is for the use of the middleware infrastructure.
     * Applications are not expected to call it directly.
     */
public:
    virtual DDS::DataReader^ create_datareaderI(
        System::IntPtr impl) override;
    virtual DDS::DataWriter^ create_datawriterI(
        System::IntPtr impl) override;
        
    virtual Bar^ create_data_untyped() override;
    
    virtual System::String^ get_type_name_untyped() override;
        

public:
    static BarTypeSupport^ get_instance();

    BarTypeSupport();

private:
    static BarTypeSupport^ _singleton;
    BarPlugin^ _type_plugin;
};


// ---------------------------------------------------------------------------
// BarDataReader
// ---------------------------------------------------------------------------

/**
 * A reader for the Bar type.
 */
public ref class BarDataReader :
        public DDS::TypedDataReader<Bar^> {
    /* The following code is for the use of the middleware infrastructure.
     * Applications are not expected to call it directly.
     */
  internal:
    BarDataReader(System::IntPtr impl);
};


// ---------------------------------------------------------------------------
// BarDataWriter
// ---------------------------------------------------------------------------

/**
 * A writer for the Bar user type.
 */
public ref class BarDataWriter :
        public DDS::TypedDataWriter<Bar^> {
    /* The following code is for the use of the middleware infrastructure.
     * Applications are not expected to call it directly.
     */
  internal:
    BarDataWriter(System::IntPtr impl);
};

// ---------------------------------------------------------------------------
// PrimeNumberRequestTypeSupport
// ---------------------------------------------------------------------------

ref class PrimeNumberRequestPlugin;

/* A collection of useful methods for dealing with objects of type
 * PrimeNumberRequest.
 */
public ref class PrimeNumberRequestTypeSupport
        : public DDS::TypedTypeSupport<PrimeNumberRequest^> {
    // --- Type name: --------------------------------------------------------
  public:
    static System::String^ TYPENAME = "PrimeNumberRequest";


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

    /* Create an instance of the PrimeNumberRequest type.
     */
    static PrimeNumberRequest^ create_data();

    /* If instances of the PrimeNumberRequest type require any
     * explicit finalization, perform it now on the given sample.
     */
    static void delete_data(PrimeNumberRequest^ data);

    /* Write the contents of the data sample to standard out.
     */
    static void print_data(PrimeNumberRequest^ a_data);

    /* Perform a deep copy of the contents of one data sample over those of
     * another, overwriting it.
     */
    static void copy_data(
        PrimeNumberRequest^ dst_data,
        PrimeNumberRequest^ src_data);


    // --- Implementation: ---------------------------------------------------
    /* The following code is for the use of the middleware infrastructure.
     * Applications are not expected to call it directly.
     */
public:
    virtual DDS::DataReader^ create_datareaderI(
        System::IntPtr impl) override;
    virtual DDS::DataWriter^ create_datawriterI(
        System::IntPtr impl) override;
        
    virtual PrimeNumberRequest^ create_data_untyped() override;
    
    virtual System::String^ get_type_name_untyped() override;
        

public:
    static PrimeNumberRequestTypeSupport^ get_instance();

    PrimeNumberRequestTypeSupport();

private:
    static PrimeNumberRequestTypeSupport^ _singleton;
    PrimeNumberRequestPlugin^ _type_plugin;
};


// ---------------------------------------------------------------------------
// PrimeNumberRequestDataReader
// ---------------------------------------------------------------------------

/**
 * A reader for the PrimeNumberRequest type.
 */
public ref class PrimeNumberRequestDataReader :
        public DDS::TypedDataReader<PrimeNumberRequest^> {
    /* The following code is for the use of the middleware infrastructure.
     * Applications are not expected to call it directly.
     */
  internal:
    PrimeNumberRequestDataReader(System::IntPtr impl);
};


// ---------------------------------------------------------------------------
// PrimeNumberRequestDataWriter
// ---------------------------------------------------------------------------

/**
 * A writer for the PrimeNumberRequest user type.
 */
public ref class PrimeNumberRequestDataWriter :
        public DDS::TypedDataWriter<PrimeNumberRequest^> {
    /* The following code is for the use of the middleware infrastructure.
     * Applications are not expected to call it directly.
     */
  internal:
    PrimeNumberRequestDataWriter(System::IntPtr impl);
};

// ---------------------------------------------------------------------------
// PrimeNumberReplyTypeSupport
// ---------------------------------------------------------------------------

ref class PrimeNumberReplyPlugin;

/* A collection of useful methods for dealing with objects of type
 * PrimeNumberReply.
 */
public ref class PrimeNumberReplyTypeSupport
        : public DDS::TypedTypeSupport<PrimeNumberReply^> {
    // --- Type name: --------------------------------------------------------
  public:
    static System::String^ TYPENAME = "PrimeNumberReply";


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

    /* Create an instance of the PrimeNumberReply type.
     */
    static PrimeNumberReply^ create_data();

    /* If instances of the PrimeNumberReply type require any
     * explicit finalization, perform it now on the given sample.
     */
    static void delete_data(PrimeNumberReply^ data);

    /* Write the contents of the data sample to standard out.
     */
    static void print_data(PrimeNumberReply^ a_data);

    /* Perform a deep copy of the contents of one data sample over those of
     * another, overwriting it.
     */
    static void copy_data(
        PrimeNumberReply^ dst_data,
        PrimeNumberReply^ src_data);


    // --- Implementation: ---------------------------------------------------
    /* The following code is for the use of the middleware infrastructure.
     * Applications are not expected to call it directly.
     */
public:
    virtual DDS::DataReader^ create_datareaderI(
        System::IntPtr impl) override;
    virtual DDS::DataWriter^ create_datawriterI(
        System::IntPtr impl) override;
        
    virtual PrimeNumberReply^ create_data_untyped() override;
    
    virtual System::String^ get_type_name_untyped() override;
        

public:
    static PrimeNumberReplyTypeSupport^ get_instance();

    PrimeNumberReplyTypeSupport();

private:
    static PrimeNumberReplyTypeSupport^ _singleton;
    PrimeNumberReplyPlugin^ _type_plugin;
};


// ---------------------------------------------------------------------------
// PrimeNumberReplyDataReader
// ---------------------------------------------------------------------------

/**
 * A reader for the PrimeNumberReply type.
 */
public ref class PrimeNumberReplyDataReader :
        public DDS::TypedDataReader<PrimeNumberReply^> {
    /* The following code is for the use of the middleware infrastructure.
     * Applications are not expected to call it directly.
     */
  internal:
    PrimeNumberReplyDataReader(System::IntPtr impl);
};


// ---------------------------------------------------------------------------
// PrimeNumberReplyDataWriter
// ---------------------------------------------------------------------------

/**
 * A writer for the PrimeNumberReply user type.
 */
public ref class PrimeNumberReplyDataWriter :
        public DDS::TypedDataWriter<PrimeNumberReply^> {
    /* The following code is for the use of the middleware infrastructure.
     * Applications are not expected to call it directly.
     */
  internal:
    PrimeNumberReplyDataWriter(System::IntPtr impl);
};
