
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


public class PrimeNumberRequest implements Copyable, Serializable
{

    public int n = 0;
    public int primes_per_reply = 0;


    public PrimeNumberRequest() {

    }


    public PrimeNumberRequest(PrimeNumberRequest other) {

        this();
        copy_from(other);
    }



    public static Object create() {
        PrimeNumberRequest self;
        self = new PrimeNumberRequest();
         
        self.clear();
        
        return self;
    }

    public void clear() {
        
        n = 0;
            
        primes_per_reply = 0;
            
    }

    public boolean equals(Object o) {
                
        if (o == null) {
            return false;
        }        
        
        

        if(getClass() != o.getClass()) {
            return false;
        }

        PrimeNumberRequest otherObj = (PrimeNumberRequest)o;



        if(n != otherObj.n) {
            return false;
        }
            
        if(primes_per_reply != otherObj.primes_per_reply) {
            return false;
        }
            
        return true;
    }

    public int hashCode() {
        int __result = 0;

        __result += (int)n;
                
        __result += (int)primes_per_reply;
                
        return __result;
    }
    

    /**
     * This is the implementation of the <code>Copyable</code> interface.
     * This method will perform a deep copy of <code>src</code>
     * This method could be placed into <code>PrimeNumberRequestTypeSupport</code>
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
        

        PrimeNumberRequest typedSrc = (PrimeNumberRequest) src;
        PrimeNumberRequest typedDst = this;

        typedDst.n = typedSrc.n;
            
        typedDst.primes_per_reply = typedSrc.primes_per_reply;
            
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
        strBuffer.append("n: ").append(n).append("\n");
            
        CdrHelper.printIndent(strBuffer, indent+1);            
        strBuffer.append("primes_per_reply: ").append(primes_per_reply).append("\n");
            
        return strBuffer.toString();
    }
    
}

