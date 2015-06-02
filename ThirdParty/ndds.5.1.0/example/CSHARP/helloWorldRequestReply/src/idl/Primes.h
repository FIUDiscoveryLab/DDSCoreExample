/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from Primes.idl using "rtiddsgen".
  The rtiddsgen tool is part of the RTI Connext distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the RTI Connext manual.
*/

#pragma once


struct DDS_TypeCode;
    

using namespace System;
using namespace DDS;

    

public ref struct Foo
        : public DDS::ICopyable<Foo^> {
    // --- Declared members: -------------------------------------------------
  public:            
    
    System::String^ message; // maximum length = (255)

    // --- Static constants: -------------------------------------    
public:
    


#define Foo_LAST_MEMBER_ID 0

    // --- Constructors and destructors: -------------------------------------
  public:
    Foo();

  // --- Utility methods: --------------------------------------------------
  public:
  virtual void clear();

  virtual System::Boolean copy_from(Foo^ src);

    virtual System::Boolean Equals(System::Object^ other) override;

    
    static DDS::TypeCode^ get_typecode();

  private:
    static DDS::TypeCode^ _typecode;

}; // class Foo




public ref class FooSeq sealed
        : public DDS::UserRefSequence<Foo^> {
public:
    FooSeq() :
            DDS::UserRefSequence<Foo^>() {
        // empty
    }
    FooSeq(System::Int32 max) :
            DDS::UserRefSequence<Foo^>(max) {
        // empty
    }
    FooSeq(FooSeq^ src) :
            DDS::UserRefSequence<Foo^>(src) {
        // empty
    }
};


  #define NDDSUSERDllExport

NDDSUSERDllExport DDS_TypeCode* Foo_get_typecode();


public ref struct Bar
        : public DDS::ICopyable<Bar^> {
    // --- Declared members: -------------------------------------------------
  public:            
    
    System::String^ message; // maximum length = (255)

    // --- Static constants: -------------------------------------    
public:
    


#define Bar_LAST_MEMBER_ID 0

    // --- Constructors and destructors: -------------------------------------
  public:
    Bar();

  // --- Utility methods: --------------------------------------------------
  public:
  virtual void clear();

  virtual System::Boolean copy_from(Bar^ src);

    virtual System::Boolean Equals(System::Object^ other) override;

    
    static DDS::TypeCode^ get_typecode();

  private:
    static DDS::TypeCode^ _typecode;

}; // class Bar




public ref class BarSeq sealed
        : public DDS::UserRefSequence<Bar^> {
public:
    BarSeq() :
            DDS::UserRefSequence<Bar^>() {
        // empty
    }
    BarSeq(System::Int32 max) :
            DDS::UserRefSequence<Bar^>(max) {
        // empty
    }
    BarSeq(BarSeq^ src) :
            DDS::UserRefSequence<Bar^>(src) {
        // empty
    }
};


  #define NDDSUSERDllExport

NDDSUSERDllExport DDS_TypeCode* Bar_get_typecode();


public ref struct PrimeNumberRequest
        : public DDS::ICopyable<PrimeNumberRequest^> {
    // --- Declared members: -------------------------------------------------
  public:            
    
    System::Int32 n;
    System::Int32 primes_per_reply;

    // --- Static constants: -------------------------------------    
public:
    


#define PrimeNumberRequest_LAST_MEMBER_ID 1

    // --- Constructors and destructors: -------------------------------------
  public:
    PrimeNumberRequest();

  // --- Utility methods: --------------------------------------------------
  public:
  virtual void clear();

  virtual System::Boolean copy_from(PrimeNumberRequest^ src);

    virtual System::Boolean Equals(System::Object^ other) override;

    
    static DDS::TypeCode^ get_typecode();

  private:
    static DDS::TypeCode^ _typecode;

}; // class PrimeNumberRequest




public ref class PrimeNumberRequestSeq sealed
        : public DDS::UserRefSequence<PrimeNumberRequest^> {
public:
    PrimeNumberRequestSeq() :
            DDS::UserRefSequence<PrimeNumberRequest^>() {
        // empty
    }
    PrimeNumberRequestSeq(System::Int32 max) :
            DDS::UserRefSequence<PrimeNumberRequest^>(max) {
        // empty
    }
    PrimeNumberRequestSeq(PrimeNumberRequestSeq^ src) :
            DDS::UserRefSequence<PrimeNumberRequest^>(src) {
        // empty
    }
};


  #define NDDSUSERDllExport

NDDSUSERDllExport DDS_TypeCode* PrimeNumberRequest_get_typecode();


public ref class PRIME_SEQUENCE_MAX_LENGTH sealed {
public:
    static const System::Int32 VALUE =
        1024;

private:
    PRIME_SEQUENCE_MAX_LENGTH() {}
};



public enum class PrimeNumberCalculationStatus : System::Int32 {
    
    REPLY_IN_PROGRESS, 
    REPLY_COMPLETED, 
    REPLY_ERROR
};

PrimeNumberCalculationStatus PrimeNumberCalculationStatus_get_default_value();

public ref class PrimeNumberCalculationStatusSeq
        : public DDS::UserValueSequence<PrimeNumberCalculationStatus> {
public:
    PrimeNumberCalculationStatusSeq() :
            DDS::UserValueSequence<PrimeNumberCalculationStatus>() {
        // empty
    }
    PrimeNumberCalculationStatusSeq(System::Int32 max) :
            DDS::UserValueSequence<PrimeNumberCalculationStatus>(max) {
        // empty
    }
    PrimeNumberCalculationStatusSeq(PrimeNumberCalculationStatusSeq^ src) :
            DDS::UserValueSequence<PrimeNumberCalculationStatus>(src) {
        // empty
    }
};


  #define NDDSUSERDllExport
NDDSUSERDllExport DDS_TypeCode* PrimeNumberCalculationStatus_get_typecode();


public ref struct PrimeNumberReply
        : public DDS::ICopyable<PrimeNumberReply^> {
    // --- Declared members: -------------------------------------------------
  public:            
    
    DDS::IntSeq^ primes;
    PrimeNumberCalculationStatus status;

    // --- Static constants: -------------------------------------    
public:
    


#define PrimeNumberReply_LAST_MEMBER_ID 1

    // --- Constructors and destructors: -------------------------------------
  public:
    PrimeNumberReply();

  // --- Utility methods: --------------------------------------------------
  public:
  virtual void clear();

  virtual System::Boolean copy_from(PrimeNumberReply^ src);

    virtual System::Boolean Equals(System::Object^ other) override;

    
    static DDS::TypeCode^ get_typecode();

  private:
    static DDS::TypeCode^ _typecode;

}; // class PrimeNumberReply




public ref class PrimeNumberReplySeq sealed
        : public DDS::UserRefSequence<PrimeNumberReply^> {
public:
    PrimeNumberReplySeq() :
            DDS::UserRefSequence<PrimeNumberReply^>() {
        // empty
    }
    PrimeNumberReplySeq(System::Int32 max) :
            DDS::UserRefSequence<PrimeNumberReply^>(max) {
        // empty
    }
    PrimeNumberReplySeq(PrimeNumberReplySeq^ src) :
            DDS::UserRefSequence<PrimeNumberReply^>(src) {
        // empty
    }
};


  #define NDDSUSERDllExport

NDDSUSERDllExport DDS_TypeCode* PrimeNumberReply_get_typecode();
