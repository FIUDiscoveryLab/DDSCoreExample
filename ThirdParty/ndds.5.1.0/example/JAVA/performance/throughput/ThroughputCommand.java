
/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from .idl using "rtiddsgen".
  The rtiddsgen tool is part of the RTI Connext distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the RTI Connext manual.
*/
    

import com.rti.dds.infrastructure.*;
import com.rti.dds.infrastructure.Copyable;

import java.io.Serializable;
import com.rti.dds.cdr.CdrHelper;


public class ThroughputCommand implements Copyable, Serializable
{

    public byte[] signature = new byte[4];
    public ThroughputCommandKind command = (ThroughputCommandKind) ThroughputCommandKind.create();
    public int data_length = 0;
    public int current_publisher_effort = 0;
    public int final_publisher_effort = 0;


    public ThroughputCommand() {

    }


    public ThroughputCommand(ThroughputCommand other) {

        this();
        copy_from(other);
    }



    public static Object create() {
        ThroughputCommand self;
        self = new ThroughputCommand();
         
        self.clear();
        
        return self;
    }

    public void clear() {
        
        
        for(int i1__ = 0; i1__ < 4; ++i1__) {
        
            signature[i1__] = 0;
        
        }
                                                                  
            
        command = ThroughputCommandKind.create();
            
        data_length = 0;
            
        current_publisher_effort = 0;
            
        final_publisher_effort = 0;
            
    }

    public boolean equals(Object o) {
                
        if (o == null) {
            return false;
        }        
        
        

        if(getClass() != o.getClass()) {
            return false;
        }

        ThroughputCommand otherObj = (ThroughputCommand)o;



        
        for(int i1__ = 0; i1__ < 4; ++i1__) {
        
        if(signature[i1__] != otherObj.signature[i1__]) {
            return false;
        }
        
        }
                                                  
            
        if(!command.equals(otherObj.command)) {
            return false;
        }
            
        if(data_length != otherObj.data_length) {
            return false;
        }
            
        if(current_publisher_effort != otherObj.current_publisher_effort) {
            return false;
        }
            
        if(final_publisher_effort != otherObj.final_publisher_effort) {
            return false;
        }
            
        return true;
    }

    public int hashCode() {
        int __result = 0;

        
        for(int i1__ = 0; i1__ < 4; ++i1__) {
        
             __result += (int)signature[i1__];
        
        }
                                                  
                
        __result += command.hashCode();
                
        __result += (int)data_length;
                
        __result += (int)current_publisher_effort;
                
        __result += (int)final_publisher_effort;
                
        return __result;
    }
    

    /**
     * This is the implementation of the <code>Copyable</code> interface.
     * This method will perform a deep copy of <code>src</code>
     * This method could be placed into <code>ThroughputCommandTypeSupport</code>
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
        

        ThroughputCommand typedSrc = (ThroughputCommand) src;
        ThroughputCommand typedDst = this;

        
            System.arraycopy(typedSrc.signature, 0, 
                             typedDst.signature, 0, 
                             typedSrc.signature.length);
        
            
        typedDst.command = (ThroughputCommandKind) typedDst.command.copy_from(typedSrc.command);
            
        typedDst.data_length = typedSrc.data_length;
            
        typedDst.current_publisher_effort = typedSrc.current_publisher_effort;
            
        typedDst.final_publisher_effort = typedSrc.final_publisher_effort;
            
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
        strBuffer.append("signature: ");
        
        for(int i1__ = 0; i1__ < 4; ++i1__) {
        
        strBuffer.append(signature[i1__]).append(", ");
        
        }
                                            
        strBuffer.append("\n");      
            
        strBuffer.append(command.toString("command ", indent+1));
            
        CdrHelper.printIndent(strBuffer, indent+1);            
        strBuffer.append("data_length: ").append(data_length).append("\n");
            
        CdrHelper.printIndent(strBuffer, indent+1);            
        strBuffer.append("current_publisher_effort: ").append(current_publisher_effort).append("\n");
            
        CdrHelper.printIndent(strBuffer, indent+1);            
        strBuffer.append("final_publisher_effort: ").append(final_publisher_effort).append("\n");
            
        return strBuffer.toString();
    }
    
}

