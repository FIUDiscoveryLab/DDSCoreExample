
/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from .idl using "rtiddsgen".
  The rtiddsgen tool is part of the RTI Connext distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the RTI Connext manual.
*/
    
package com.rti.example.primes.idl;
        

import com.rti.dds.infrastructure.*;
import com.rti.dds.infrastructure.Copyable;

import java.io.Serializable;
import com.rti.dds.cdr.CdrHelper;


public class PrimeNumberReply implements Copyable, Serializable
{

    public IntSeq primes = new IntSeq(((com.rti.example.primes.idl.PRIME_SEQUENCE_MAX_LENGTH.VALUE)));
    public com.rti.example.primes.idl.PrimeNumberCalculationStatus status = (com.rti.example.primes.idl.PrimeNumberCalculationStatus) com.rti.example.primes.idl.PrimeNumberCalculationStatus.create();


    public PrimeNumberReply() {

    }


    public PrimeNumberReply(PrimeNumberReply other) {

        this();
        copy_from(other);
    }



    public static Object create() {
        PrimeNumberReply self;
        self = new PrimeNumberReply();
         
        self.clear();
        
        return self;
    }

    public void clear() {
        
        if (primes != null) {
            primes.clear();
        }
            
        status = com.rti.example.primes.idl.PrimeNumberCalculationStatus.create();
            
    }

    public boolean equals(Object o) {
                
        if (o == null) {
            return false;
        }        
        
        

        if(getClass() != o.getClass()) {
            return false;
        }

        PrimeNumberReply otherObj = (PrimeNumberReply)o;



        if(!primes.equals(otherObj.primes)) {
            return false;
        }
            
        if(!status.equals(otherObj.status)) {
            return false;
        }
            
        return true;
    }

    public int hashCode() {
        int __result = 0;

        __result += primes.hashCode();
                
        __result += status.hashCode();
                
        return __result;
    }
    

    /**
     * This is the implementation of the <code>Copyable</code> interface.
     * This method will perform a deep copy of <code>src</code>
     * This method could be placed into <code>PrimeNumberReplyTypeSupport</code>
     * rather than here by using the <code>-noCopyable</code> option
     * to rtiddsgen.
     * 
     * @param src The Object which contains the data to be copied.
     * @return Returns <code>this</code>.
     * @exception NullPointerException If <code>src</code> is null.
     * @exception ClassCastException If <code>src</code> is not the 
     * same type as <code>this</code>.
     * @see com.rti.dds.infrastructure.Copyable#copy_from(java.lang.Object)
     */
    public Object copy_from(Object src) {
        

        PrimeNumberReply typedSrc = (PrimeNumberReply) src;
        PrimeNumberReply typedDst = this;

        typedDst.primes.copy_from(typedSrc.primes);
            
        typedDst.status = (com.rti.example.primes.idl.PrimeNumberCalculationStatus) typedDst.status.copy_from(typedSrc.status);
            
        return this;
    }


    
    public String toString(){
        return toString("", 0);
    }
        
    
    public String toString(String desc, int indent) {
        StringBuffer strBuffer = new StringBuffer();        
                        
        
        if (desc != null) {
            CdrHelper.printIndent(strBuffer, indent);
            strBuffer.append(desc).append(":\n");
        }
        
        
        CdrHelper.printIndent(strBuffer, indent+1);
        strBuffer.append("primes: ");
        for(int i__ = 0; i__ < primes.size(); ++i__) {
            if (i__!=0) strBuffer.append(", ");        
            strBuffer.append(primes.get(i__));
        }
        strBuffer.append("\n");
            
        strBuffer.append(status.toString("status ", indent+1));
            
        return strBuffer.toString();
    }
    
}

