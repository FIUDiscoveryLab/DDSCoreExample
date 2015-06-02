/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from HelloWorld.idl using "rtiddsgen".
  The rtiddsgen tool is part of the RTI Connext distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the RTI Connext manual.
*/

#pragma once


struct DDS_TypeCode;
    

using namespace System;
using namespace DDS;

    

public ref struct HelloWorld
        : public DDS::ICopyable<HelloWorld^> {
    // --- Declared members: -------------------------------------------------
  public:            
    
    System::String^ msg; // maximum length = (128)

    // --- Static constants: -------------------------------------    
public:
    


#define HelloWorld_LAST_MEMBER_ID 0

    // --- Constructors and destructors: -------------------------------------
  public:
    HelloWorld();

  // --- Utility methods: --------------------------------------------------
  public:
  virtual void clear();

  virtual System::Boolean copy_from(HelloWorld^ src);

    virtual System::Boolean Equals(System::Object^ other) override;

    
    static DDS::TypeCode^ get_typecode();

  private:
    static DDS::TypeCode^ _typecode;

}; // class HelloWorld




public ref class HelloWorldSeq sealed
        : public DDS::UserRefSequence<HelloWorld^> {
public:
    HelloWorldSeq() :
            DDS::UserRefSequence<HelloWorld^>() {
        // empty
    }
    HelloWorldSeq(System::Int32 max) :
            DDS::UserRefSequence<HelloWorld^>(max) {
        // empty
    }
    HelloWorldSeq(HelloWorldSeq^ src) :
            DDS::UserRefSequence<HelloWorld^>(src) {
        // empty
    }
};


  #define NDDSUSERDllExport

NDDSUSERDllExport DDS_TypeCode* HelloWorld_get_typecode();
