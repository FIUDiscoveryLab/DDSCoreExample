/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from Primes.idl using "rtiddsgen".
  The rtiddsgen tool is part of the RTI Connext distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the RTI Connext manual.
*/

    
#pragma unmanaged
#include "ndds/ndds_cpp.h"
#pragma managed

using namespace System;
using namespace System::Collections;
using namespace DDS;
    

#include "Primes.h"
    
/* ========================================================================= */
Foo::Foo() {

    message = "";
            
}

void Foo::clear() {
  
    message = "";
          
}

  

System::Boolean Foo::copy_from(Foo^ src) {
    Foo^ dst = this;

    dst->message = src->message;

    return true;
}

Boolean Foo::Equals(Object^ other) {
    if (other == nullptr) {
        return false;
    }        
    if (this == other) {
        return true;
    }

    Foo^ otherObj =
        dynamic_cast<Foo^>(other);
    if (otherObj == nullptr) {
        return false;
    }


    if (!message->Equals(otherObj->message)) {
        return false;
    }
            
    return true;
}



DDS::TypeCode^ Foo::get_typecode() {
    if (_typecode == nullptr) {
        _typecode = gcnew DDS::TypeCode(Foo_get_typecode());
    }
    return _typecode;
}


DDS_TypeCode* Foo_get_typecode()
{
    static RTIBool is_initialized = RTI_FALSE;

    static DDS_TypeCode Foo_g_tc_message_string = DDS_INITIALIZE_STRING_TYPECODE(255);

    static DDS_TypeCode_Member Foo_g_tc_members[1]=
    {
        {
            (char *)"message",/* Member name */
            {
                0,/* Representation ID */
                DDS_BOOLEAN_FALSE,/* Is a pointer? */
                -1, /* Bitfield bits */
                NULL/* Member type code is assigned later */
            },
            0, /* Ignored */
            0, /* Ignored */
            0, /* Ignored */
            NULL, /* Ignored */
            RTI_CDR_REQUIRED_MEMBER, /* Member flags */
            DDS_PRIVATE_MEMBER,/* Ignored */
            1,
            NULL/* Ignored */
        }
    };

    static DDS_TypeCode Foo_g_tc =
    {{
        DDS_TK_STRUCT,/* Kind */
        DDS_BOOLEAN_FALSE, /* Ignored */
        -1,/* Ignored */
        (char *)"Foo", /* Name */
        NULL, /* Ignored */
        0, /* Ignored */
        0, /* Ignored */
        NULL, /* Ignored */
        1, /* Number of members */
        Foo_g_tc_members, /* Members */
        DDS_VM_NONE /* Ignored */
    }}; /* Type code for Foo*/

    if (is_initialized) {
        return &Foo_g_tc;
    }


    Foo_g_tc_members[0]._representation._typeCode = (RTICdrTypeCode *)&Foo_g_tc_message_string;

    is_initialized = RTI_TRUE;

    return &Foo_g_tc;
}

/* ========================================================================= */
Bar::Bar() {

    message = "";
            
}

void Bar::clear() {
  
    message = "";
          
}

  

System::Boolean Bar::copy_from(Bar^ src) {
    Bar^ dst = this;

    dst->message = src->message;

    return true;
}

Boolean Bar::Equals(Object^ other) {
    if (other == nullptr) {
        return false;
    }        
    if (this == other) {
        return true;
    }

    Bar^ otherObj =
        dynamic_cast<Bar^>(other);
    if (otherObj == nullptr) {
        return false;
    }


    if (!message->Equals(otherObj->message)) {
        return false;
    }
            
    return true;
}



DDS::TypeCode^ Bar::get_typecode() {
    if (_typecode == nullptr) {
        _typecode = gcnew DDS::TypeCode(Bar_get_typecode());
    }
    return _typecode;
}


DDS_TypeCode* Bar_get_typecode()
{
    static RTIBool is_initialized = RTI_FALSE;

    static DDS_TypeCode Bar_g_tc_message_string = DDS_INITIALIZE_STRING_TYPECODE(255);

    static DDS_TypeCode_Member Bar_g_tc_members[1]=
    {
        {
            (char *)"message",/* Member name */
            {
                0,/* Representation ID */
                DDS_BOOLEAN_FALSE,/* Is a pointer? */
                -1, /* Bitfield bits */
                NULL/* Member type code is assigned later */
            },
            0, /* Ignored */
            0, /* Ignored */
            0, /* Ignored */
            NULL, /* Ignored */
            RTI_CDR_REQUIRED_MEMBER, /* Member flags */
            DDS_PRIVATE_MEMBER,/* Ignored */
            1,
            NULL/* Ignored */
        }
    };

    static DDS_TypeCode Bar_g_tc =
    {{
        DDS_TK_STRUCT,/* Kind */
        DDS_BOOLEAN_FALSE, /* Ignored */
        -1,/* Ignored */
        (char *)"Bar", /* Name */
        NULL, /* Ignored */
        0, /* Ignored */
        0, /* Ignored */
        NULL, /* Ignored */
        1, /* Number of members */
        Bar_g_tc_members, /* Members */
        DDS_VM_NONE /* Ignored */
    }}; /* Type code for Bar*/

    if (is_initialized) {
        return &Bar_g_tc;
    }


    Bar_g_tc_members[0]._representation._typeCode = (RTICdrTypeCode *)&Bar_g_tc_message_string;

    is_initialized = RTI_TRUE;

    return &Bar_g_tc;
}

/* ========================================================================= */
PrimeNumberRequest::PrimeNumberRequest() {

    n = 0;
            
    primes_per_reply = 0;
            
}

void PrimeNumberRequest::clear() {
  
    n = 0;
          
    primes_per_reply = 0;
          
}

  

System::Boolean PrimeNumberRequest::copy_from(PrimeNumberRequest^ src) {
    PrimeNumberRequest^ dst = this;

    dst->n = src->n;
    dst->primes_per_reply = src->primes_per_reply;

    return true;
}

Boolean PrimeNumberRequest::Equals(Object^ other) {
    if (other == nullptr) {
        return false;
    }        
    if (this == other) {
        return true;
    }

    PrimeNumberRequest^ otherObj =
        dynamic_cast<PrimeNumberRequest^>(other);
    if (otherObj == nullptr) {
        return false;
    }


    if (n != otherObj->n) {
        return false;
    }
            
    if (primes_per_reply != otherObj->primes_per_reply) {
        return false;
    }
            
    return true;
}



DDS::TypeCode^ PrimeNumberRequest::get_typecode() {
    if (_typecode == nullptr) {
        _typecode = gcnew DDS::TypeCode(PrimeNumberRequest_get_typecode());
    }
    return _typecode;
}


DDS_TypeCode* PrimeNumberRequest_get_typecode()
{
    static RTIBool is_initialized = RTI_FALSE;


    static DDS_TypeCode_Member PrimeNumberRequest_g_tc_members[2]=
    {
        {
            (char *)"n",/* Member name */
            {
                0,/* Representation ID */
                DDS_BOOLEAN_FALSE,/* Is a pointer? */
                -1, /* Bitfield bits */
                NULL/* Member type code is assigned later */
            },
            0, /* Ignored */
            0, /* Ignored */
            0, /* Ignored */
            NULL, /* Ignored */
            RTI_CDR_REQUIRED_MEMBER, /* Member flags */
            DDS_PRIVATE_MEMBER,/* Ignored */
            1,
            NULL/* Ignored */
        },
        {
            (char *)"primes_per_reply",/* Member name */
            {
                1,/* Representation ID */
                DDS_BOOLEAN_FALSE,/* Is a pointer? */
                -1, /* Bitfield bits */
                NULL/* Member type code is assigned later */
            },
            0, /* Ignored */
            0, /* Ignored */
            0, /* Ignored */
            NULL, /* Ignored */
            RTI_CDR_REQUIRED_MEMBER, /* Member flags */
            DDS_PRIVATE_MEMBER,/* Ignored */
            1,
            NULL/* Ignored */
        }
    };

    static DDS_TypeCode PrimeNumberRequest_g_tc =
    {{
        DDS_TK_STRUCT,/* Kind */
        DDS_BOOLEAN_FALSE, /* Ignored */
        -1,/* Ignored */
        (char *)"PrimeNumberRequest", /* Name */
        NULL, /* Ignored */
        0, /* Ignored */
        0, /* Ignored */
        NULL, /* Ignored */
        2, /* Number of members */
        PrimeNumberRequest_g_tc_members, /* Members */
        DDS_VM_NONE /* Ignored */
    }}; /* Type code for PrimeNumberRequest*/

    if (is_initialized) {
        return &PrimeNumberRequest_g_tc;
    }


    PrimeNumberRequest_g_tc_members[0]._representation._typeCode = (RTICdrTypeCode *)&DDS_g_tc_long;
    PrimeNumberRequest_g_tc_members[1]._representation._typeCode = (RTICdrTypeCode *)&DDS_g_tc_long;

    is_initialized = RTI_TRUE;

    return &PrimeNumberRequest_g_tc;
}

/* ========================================================================= */

DDS_TypeCode* PrimeNumberCalculationStatus_get_typecode()
{
    static RTIBool is_initialized = RTI_FALSE;

    static DDS_TypeCode_Member PrimeNumberCalculationStatus_g_tc_members[3] =
    {
        {
            (char *)"REPLY_IN_PROGRESS",/* Member name */
            {
                0,/* Ignored */
                DDS_BOOLEAN_FALSE, /* Ignored */
                -1, /* Ignored */
                NULL /* Ignored */
            },
            (RTICdrLong) PrimeNumberCalculationStatus::REPLY_IN_PROGRESS, /* Enumerator ordinal */
            0, /* Ignored */
            0, /* Ignored */
            NULL, /* Ignored */
            RTI_CDR_REQUIRED_MEMBER, /* Ignored */
            DDS_PRIVATE_MEMBER,/* Ignored */
            1,
            NULL/* Ignored */
        },
        {
            (char *)"REPLY_COMPLETED",/* Member name */
            {
                0,/* Ignored */
                DDS_BOOLEAN_FALSE, /* Ignored */
                -1, /* Ignored */
                NULL /* Ignored */
            },
            (RTICdrLong) PrimeNumberCalculationStatus::REPLY_COMPLETED, /* Enumerator ordinal */
            0, /* Ignored */
            0, /* Ignored */
            NULL, /* Ignored */
            RTI_CDR_REQUIRED_MEMBER, /* Ignored */
            DDS_PRIVATE_MEMBER,/* Ignored */
            1,
            NULL/* Ignored */
        },
        {
            (char *)"REPLY_ERROR",/* Member name */
            {
                0,/* Ignored */
                DDS_BOOLEAN_FALSE, /* Ignored */
                -1, /* Ignored */
                NULL /* Ignored */
            },
            (RTICdrLong) PrimeNumberCalculationStatus::REPLY_ERROR, /* Enumerator ordinal */
            0, /* Ignored */
            0, /* Ignored */
            NULL, /* Ignored */
            RTI_CDR_REQUIRED_MEMBER, /* Ignored */
            DDS_PRIVATE_MEMBER,/* Ignored */
            1,
            NULL/* Ignored */
        }
    };

    static DDS_TypeCode PrimeNumberCalculationStatus_g_tc = 
    {{
        DDS_TK_ENUM, /* Kind */
        DDS_BOOLEAN_FALSE, /* Ignored */
        -1, /* Ignored */
        (char *)"PrimeNumberCalculationStatus", /* Name */
        NULL, /* Ignored */
        0, /* Ignored */
        0, /* Ignored */
        NULL, /* Ignored */
        3, /* Number of enumerators */
        PrimeNumberCalculationStatus_g_tc_members, /* Enumerators */
        DDS_VM_NONE /* Ignored */
}    };

    if (is_initialized) {
        return &PrimeNumberCalculationStatus_g_tc;
    }

    is_initialized = RTI_TRUE;
    return &PrimeNumberCalculationStatus_g_tc;
}
PrimeNumberCalculationStatus PrimeNumberCalculationStatus_get_default_value() {
    return PrimeNumberCalculationStatus::REPLY_IN_PROGRESS;
}


/* ========================================================================= */
PrimeNumberReply::PrimeNumberReply() {

    primes = gcnew DDS::IntSeq(((PRIME_SEQUENCE_MAX_LENGTH::VALUE)));
            
    status = PrimeNumberCalculationStatus_get_default_value();
            
}

void PrimeNumberReply::clear() {
  
    primes->length = 0;
          
    status = PrimeNumberCalculationStatus_get_default_value();
          
}

  

System::Boolean PrimeNumberReply::copy_from(PrimeNumberReply^ src) {
    PrimeNumberReply^ dst = this;

    if (!dst->primes->copy_from_no_alloc(src->primes)) {
        return false;
    }
            
    dst->status = src->status;
            

    return true;
}

Boolean PrimeNumberReply::Equals(Object^ other) {
    if (other == nullptr) {
        return false;
    }        
    if (this == other) {
        return true;
    }

    PrimeNumberReply^ otherObj =
        dynamic_cast<PrimeNumberReply^>(other);
    if (otherObj == nullptr) {
        return false;
    }


    if (!primes->Equals(otherObj->primes)) {
        return false;
    }
            
    if (status != otherObj->status) {
        return false;
    }
            
    return true;
}



DDS::TypeCode^ PrimeNumberReply::get_typecode() {
    if (_typecode == nullptr) {
        _typecode = gcnew DDS::TypeCode(PrimeNumberReply_get_typecode());
    }
    return _typecode;
}


DDS_TypeCode* PrimeNumberReply_get_typecode()
{
    static RTIBool is_initialized = RTI_FALSE;

    static DDS_TypeCode PrimeNumberReply_g_tc_primes_sequence = DDS_INITIALIZE_SEQUENCE_TYPECODE((PRIME_SEQUENCE_MAX_LENGTH::VALUE),NULL);

    static DDS_TypeCode_Member PrimeNumberReply_g_tc_members[2]=
    {
        {
            (char *)"primes",/* Member name */
            {
                0,/* Representation ID */
                DDS_BOOLEAN_FALSE,/* Is a pointer? */
                -1, /* Bitfield bits */
                NULL/* Member type code is assigned later */
            },
            0, /* Ignored */
            0, /* Ignored */
            0, /* Ignored */
            NULL, /* Ignored */
            RTI_CDR_REQUIRED_MEMBER, /* Member flags */
            DDS_PRIVATE_MEMBER,/* Ignored */
            1,
            NULL/* Ignored */
        },
        {
            (char *)"status",/* Member name */
            {
                1,/* Representation ID */
                DDS_BOOLEAN_FALSE,/* Is a pointer? */
                -1, /* Bitfield bits */
                NULL/* Member type code is assigned later */
            },
            0, /* Ignored */
            0, /* Ignored */
            0, /* Ignored */
            NULL, /* Ignored */
            RTI_CDR_REQUIRED_MEMBER, /* Member flags */
            DDS_PRIVATE_MEMBER,/* Ignored */
            1,
            NULL/* Ignored */
        }
    };

    static DDS_TypeCode PrimeNumberReply_g_tc =
    {{
        DDS_TK_STRUCT,/* Kind */
        DDS_BOOLEAN_FALSE, /* Ignored */
        -1,/* Ignored */
        (char *)"PrimeNumberReply", /* Name */
        NULL, /* Ignored */
        0, /* Ignored */
        0, /* Ignored */
        NULL, /* Ignored */
        2, /* Number of members */
        PrimeNumberReply_g_tc_members, /* Members */
        DDS_VM_NONE /* Ignored */
    }}; /* Type code for PrimeNumberReply*/

    if (is_initialized) {
        return &PrimeNumberReply_g_tc;
    }

    PrimeNumberReply_g_tc_primes_sequence._data._typeCode = (RTICdrTypeCode *)&DDS_g_tc_long;

    PrimeNumberReply_g_tc_members[0]._representation._typeCode = (RTICdrTypeCode *)&PrimeNumberReply_g_tc_primes_sequence;
    PrimeNumberReply_g_tc_members[1]._representation._typeCode = (RTICdrTypeCode *)PrimeNumberCalculationStatus_get_typecode();

    is_initialized = RTI_TRUE;

    return &PrimeNumberReply_g_tc;
}
