
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


public class Throughput implements Copyable, Serializable
{

    public int key = 0;
    public int sequence_number = 0;
    public ByteSeq data = new ByteSeq(((THROUGHPUT_TEST_PACKET_DATA_SIZE_MAX.VALUE)));


    public Throughput() {

    }


    public Throughput(Throughput other) {

        this();
        copy_from(other);
    }



    public static Object create() {
        Throughput self;
        self = new Throughput();
         
        self.clear();
        
        return self;
    }

    public void clear() {
        
        key = 0;
            
        sequence_number = 0;
            
        if (data != null) {
            data.clear();
        }
            
    }

    public boolean equals(Object o) {
                
        if (o == null) {
            return false;
        }        
        
        

        if(getClass() != o.getClass()) {
            return false;
        }

        Throughput otherObj = (Throughput)o;



        if(key != otherObj.key) {
            return false;
        }
            
        if(sequence_number != otherObj.sequence_number) {
            return false;
        }
            
        if(!data.equals(otherObj.data)) {
            return false;
        }
            
        return true;
    }

    public int hashCode() {
        int __result = 0;

        __result += (int)key;
                
        __result += (int)sequence_number;
                
        __result += data.hashCode();
                
        return __result;
    }
    

    /**
     * This is the implementation of the <code>Copyable</code> interface.
     * This method will perform a deep copy of <code>src</code>
     * This method could be placed into <code>ThroughputTypeSupport</code>
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
        

        Throughput typedSrc = (Throughput) src;
        Throughput typedDst = this;

        typedDst.key = typedSrc.key;
            
        typedDst.sequence_number = typedSrc.sequence_number;
            
        typedDst.data.copy_from(typedSrc.data);
            
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
        strBuffer.append("key: ").append(key).append("\n");
            
        CdrHelper.printIndent(strBuffer, indent+1);            
        strBuffer.append("sequence_number: ").append(sequence_number).append("\n");
            
        CdrHelper.printIndent(strBuffer, indent+1);
        strBuffer.append("data: ");
        for(int i__ = 0; i__ < data.size(); ++i__) {
            if (i__!=0) strBuffer.append(", ");        
            strBuffer.append(data.get(i__));
        }
        strBuffer.append("\n");
            
        return strBuffer.toString();
    }
    
}

