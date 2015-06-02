
/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from .idl using "rtiddsgen".
  The rtiddsgen tool is part of the RTI Connext distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the RTI Connext manual.
*/
    
package com.rti.hello.idl;
        

import com.rti.dds.infrastructure.*;
import com.rti.dds.infrastructure.Copyable;

import java.io.Serializable;
import com.rti.dds.cdr.CdrHelper;


public class HelloWorld implements Copyable, Serializable
{

    public String sender = ""; /* maximum length = ((com.rti.hello.idl.MAX_NAME_LEN.VALUE)) */
    public String message = ""; /* maximum length = ((com.rti.hello.idl.MAX_MSG_LEN.VALUE)) */
    public int count = 0;


    public HelloWorld() {

    }


    public HelloWorld(HelloWorld other) {

        this();
        copy_from(other);
    }



    public static Object create() {
        HelloWorld self;
        self = new HelloWorld();
         
        self.clear();
        
        return self;
    }

    public void clear() {
        
        sender = "";
            
        message = "";
            
        count = 0;
            
    }

    public boolean equals(Object o) {
                
        if (o == null) {
            return false;
        }        
        
        

        if(getClass() != o.getClass()) {
            return false;
        }

        HelloWorld otherObj = (HelloWorld)o;



        if(!sender.equals(otherObj.sender)) {
            return false;
        }
            
        if(!message.equals(otherObj.message)) {
            return false;
        }
            
        if(count != otherObj.count) {
            return false;
        }
            
        return true;
    }

    public int hashCode() {
        int __result = 0;

        __result += sender.hashCode();
                
        __result += message.hashCode();
                
        __result += (int)count;
                
        return __result;
    }
    

    /**
     * This is the implementation of the <code>Copyable</code> interface.
     * This method will perform a deep copy of <code>src</code>
     * This method could be placed into <code>HelloWorldTypeSupport</code>
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
        

        HelloWorld typedSrc = (HelloWorld) src;
        HelloWorld typedDst = this;

        typedDst.sender = typedSrc.sender;
            
        typedDst.message = typedSrc.message;
            
        typedDst.count = typedSrc.count;
            
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
        strBuffer.append("sender: ").append(sender).append("\n");
            
        CdrHelper.printIndent(strBuffer, indent+1);            
        strBuffer.append("message: ").append(message).append("\n");
            
        CdrHelper.printIndent(strBuffer, indent+1);            
        strBuffer.append("count: ").append(count).append("\n");
            
        return strBuffer.toString();
    }
    
}

