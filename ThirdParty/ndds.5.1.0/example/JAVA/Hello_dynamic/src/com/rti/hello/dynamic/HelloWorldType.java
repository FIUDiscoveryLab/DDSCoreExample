// ****************************************************************************
//         (c) Copyright, Real-Time Innovations, All rights reserved.       
//                                                                          
//         Permission to modify and use for internal purposes granted.      
// This software is provided "as is", without warranty, express or implied. 
//                                                                          
// ****************************************************************************

package com.rti.hello.dynamic;

import com.rti.dds.infrastructure.BAD_PARAM;
import com.rti.dds.infrastructure.BadKind;
import com.rti.dds.infrastructure.BadMemberId;
import com.rti.dds.infrastructure.BadMemberName;
import com.rti.dds.typecode.StructMember;
import com.rti.dds.typecode.TCKind;
import com.rti.dds.typecode.TypeCode;
import com.rti.dds.typecode.TypeCodeFactory;

//****************************************************************************
/**
 * A simple class containing utility methods (static) to create HelloWorld
 * data type dynamically. 
 */
public final class HelloWorldType {
    public static final int HELLODDS_MAX_STRING_SIZE = 64;
    public static final int HELLODDS_MAX_PAYLOAD_SIZE = 8192;
    

    /**************************************************************************
     * Returns the name of the type
     */
    public static String getTypeName() {
        return "HelloWorld";
    }
    
    /**************************************************************************
     * Creates type code for a structure corresponding to:
     *
     * struct HelloWorld {
     *    string<HELLODDS_MAX_STRING_SIZE>             prefix;
     *    long                                         sampleId;
     *    sequence<octet, HELLODDS_MAX_PAYLOAD_SIZE>   payload;
     * };
     *
     * Returns NULL in case of error
     */
    public static TypeCode create() {
        TypeCodeFactory factory = TypeCodeFactory.get_instance();
        if (factory == null) {
            System.err.println("! Unable to get type code factory singleton");
            return null;
        }
        
        // Create typecode for 'prefix' string of max size 
        // HELLODDS_MAX_STRING_SIZE
        TypeCode stringTc = null;
        try {
            stringTc = factory.create_string_tc(HELLODDS_MAX_STRING_SIZE);
        
            // Create typecode for 'payload' octet sequence
            TypeCode sequenceTc = null;
            sequenceTc = factory.create_sequence_tc(HELLODDS_MAX_PAYLOAD_SIZE, 
                        factory.get_primitive_tc(TCKind.TK_OCTET));

            TypeCode structTc = null;
            structTc = factory.create_struct_tc("HelloWorld", new StructMember[0]);
            structTc.add_member("prefix",               // name
                                TypeCode.MEMBER_ID_INVALID, // initial_id
                                stringTc,               // Typecode 
                                TypeCode.NONKEY_MEMBER, // member_flags
                                (short)-1,              // access
                                false,                  // is_pointer
                                (short)-1);             // bits
            structTc.add_member("sampleId",
                                TypeCode.MEMBER_ID_INVALID, 
                                factory.get_primitive_tc(TCKind.TK_LONG), 
                                TypeCode.NONKEY_MEMBER, 
                                (short)-1, 
                                false, 
                                (short)-1);
            structTc.add_member("payload",  
                                TypeCode.MEMBER_ID_INVALID, 
                                sequenceTc, 
                                TypeCode.NONKEY_MEMBER, 
                                (short)-1, 
                                false, 
                                (short)-1);
            return structTc;
        }
        catch(BAD_PARAM err) {
            System.err.println("! Typecode creation error: bad param: "+
                        err.getMessage());
        }
        catch(BadMemberId err) {
            System.err.println("! Typecode creation error: bad member ID: "+
                        err.getMessage());
        }
        catch(BadMemberName err) {
            System.err.println("! Typecode creation error: bad member name: "+
                        err.getMessage());
        }
        catch(BadKind err) {
            System.err.println("! Typecode creation error: bad kind: "+
                        err.getMessage());
        }
        return null;
    }


    public static void delete(TypeCode type) {
        TypeCodeFactory.get_instance().delete_tc(type);
    }


    private HelloWorldType() {
        // nothing to do
    }

}
