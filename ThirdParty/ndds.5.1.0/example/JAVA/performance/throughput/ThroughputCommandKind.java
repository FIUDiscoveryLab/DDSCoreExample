
/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from .idl using "rtiddsgen".
  The rtiddsgen tool is part of the RTI Connext distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the RTI Connext manual.
*/
    

import com.rti.dds.util.Enum;
import com.rti.dds.cdr.CdrHelper;
import java.util.Arrays;
import java.io.ObjectStreamException;



public class ThroughputCommandKind extends Enum
{

    public static final ThroughputCommandKind THROUGHPUT_COMMAND_IDLE = new ThroughputCommandKind("THROUGHPUT_COMMAND_IDLE", 0);
    public static final int _THROUGHPUT_COMMAND_IDLE = 0;
    
    public static final ThroughputCommandKind THROUGHPUT_COMMAND_START = new ThroughputCommandKind("THROUGHPUT_COMMAND_START", 1);
    public static final int _THROUGHPUT_COMMAND_START = 1;
    
    public static final ThroughputCommandKind THROUGHPUT_COMMAND_FINISH = new ThroughputCommandKind("THROUGHPUT_COMMAND_FINISH", 2);
    public static final int _THROUGHPUT_COMMAND_FINISH = 2;
    
    public static final ThroughputCommandKind THROUGHPUT_COMMAND_COMPLETE = new ThroughputCommandKind("THROUGHPUT_COMMAND_COMPLETE", 3);
    public static final int _THROUGHPUT_COMMAND_COMPLETE = 3;
    


    public static ThroughputCommandKind valueOf(int ordinal) {
        switch(ordinal) {
            
              case 0: return ThroughputCommandKind.THROUGHPUT_COMMAND_IDLE;
            
              case 1: return ThroughputCommandKind.THROUGHPUT_COMMAND_START;
            
              case 2: return ThroughputCommandKind.THROUGHPUT_COMMAND_FINISH;
            
              case 3: return ThroughputCommandKind.THROUGHPUT_COMMAND_COMPLETE;
            

        }
        return null;
    }

    public static ThroughputCommandKind from_int(int __value) {
        return valueOf(__value);
    }

    public static int[] getOrdinals() {
        int i = 0;
        int[] values = new int[4];
        
        
        values[i] = THROUGHPUT_COMMAND_IDLE.ordinal();
        i++;
        
        values[i] = THROUGHPUT_COMMAND_START.ordinal();
        i++;
        
        values[i] = THROUGHPUT_COMMAND_FINISH.ordinal();
        i++;
        
        values[i] = THROUGHPUT_COMMAND_COMPLETE.ordinal();
        i++;
        

        Arrays.sort(values);
        return values;
    }

    public int value() {
        return super.ordinal();
    }

    /**
     * Create a default instance
     */  
    public static ThroughputCommandKind create() {
        

        return valueOf(0);
    }
    
    /**
     * Print Method
     */     
    public String toString(String desc, int indent) {
        StringBuffer strBuffer = new StringBuffer();

        CdrHelper.printIndent(strBuffer, indent);
            
        if (desc != null) {
            strBuffer.append(desc).append(": ");
        }
        
        strBuffer.append(this);
        strBuffer.append("\n");              
        return strBuffer.toString();
    }

    private Object readResolve() throws ObjectStreamException {
        return valueOf(ordinal());
    }

    private ThroughputCommandKind(String name, int ordinal) {
        super(name, ordinal);
    }
}

