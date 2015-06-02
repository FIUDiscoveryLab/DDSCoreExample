
/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from .idl using "rtiddsgen".
  The rtiddsgen tool is part of the RTI Connext distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the RTI Connext manual.
*/
    
package com.rti.example.primes.idl;
        
import com.rti.dds.typecode.*;


public class PrimeNumberRequestTypeCode {
    public static final TypeCode VALUE = getTypeCode();

    private static TypeCode getTypeCode() {
        TypeCode tc = null;
        int i=0;
        StructMember sm[] = new StructMember[2];

        sm[i]=new StructMember("n",false,(short)-1,false,(TypeCode)TypeCode.TC_LONG,0,false); i++;
        sm[i]=new StructMember("primes_per_reply",false,(short)-1,false,(TypeCode)TypeCode.TC_LONG,1,false); i++;

        tc = TypeCodeFactory.TheTypeCodeFactory.create_struct_tc("PrimeNumberRequest",ExtensibilityKind.EXTENSIBLE_EXTENSIBILITY,sm);
        return tc;
    }
}
