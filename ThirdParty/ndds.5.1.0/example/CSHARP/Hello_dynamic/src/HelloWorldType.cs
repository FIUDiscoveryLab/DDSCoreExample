/* ****************************************************************************
*         (c) Copyright, Real-Time Innovations, All rights reserved.       
*                                                                          
*         Permission to modify and use for internal purposes granted.      
* This software is provided "as is", without warranty, express or implied. 
*                                                                          
* ****************************************************************************
*/
using System;
using System.Collections.Generic;
using System.Text;

namespace Hello
{
    /**
     * A simple class containing utility methods (static) to create HelloWorld
     * data type dynamically. 
     */
    class HelloWorldType
    {
        public const int HELLODDS_MAX_STRING_SIZE = 64;
        public const int HELLODDS_MAX_PAYLOAD_SIZE = 8192;

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
        public static DDS.TypeCode create()
        {
            DDS.TypeCodeFactory factory = DDS.TypeCodeFactory.get_instance();
            if (factory == null)
            {
                Console.Error.WriteLine("! Unable to get type code factory singleton");
                return null;
            }
            /* Create typecode for 'prefix' string of max size 
             * HELLODDS_MAX_STRING_SIZE
             */
            DDS.TypeCode stringTc = null;
            try
            {
                stringTc = factory.create_string_tc(HELLODDS_MAX_STRING_SIZE);
            }
            catch (DDS.ExceptionCode_BadParam err)
            {
                Console.Error.WriteLine("! Unable to create 'prefix' string typecode: " +
                    err.Message);
                return null;
            }
            /* Create typecode for 'payload' octet sequence */
            DDS.TypeCode sequenceTc = null;
            try
            {
                sequenceTc = factory.create_sequence_tc(HELLODDS_MAX_PAYLOAD_SIZE,
                        factory.get_primitive_tc(DDS.TCKind.TK_OCTET));
            }
            catch(DDS.ExceptionCode_BadParam err) {
                Console.Error.WriteLine("! Unable to create 'payload' sequence typecode: " +
                    err.Message);
                return null;
            }
            /* Populate the members of the top-level structure */
            DDS.StructMemberSeq members = new DDS.StructMemberSeq();
            members.ensure_length(3, 3);

            members.buffer[0] = new DDS.StructMember();
            members.buffer[0].name = "prefix";
            members.buffer[0].is_pointer = false;
            members.buffer[0].bits = (short)-1;
            members.buffer[0].is_key = false;
            members.buffer[0].type = stringTc;
            
            members.buffer[1] = new DDS.StructMember();
            members.buffer[1].name = "sampleId";
            members.buffer[1].is_pointer = false;
            members.buffer[1].bits = (short)-1;
            members.buffer[1].is_key = false;
            members.buffer[1].type = factory.get_primitive_tc(DDS.TCKind.TK_LONG);

            members.buffer[2] = new DDS.StructMember();
            members.buffer[2].name = "payload";
            members.buffer[2].is_pointer = false;
            members.buffer[2].bits = (short)-1;
            members.buffer[2].is_key = false;
            members.buffer[2].type = sequenceTc;

            DDS.TypeCode structTc = null;
            try {
                structTc = factory.create_struct_tc("HelloWorld", members);
            }
            catch(DDS.ExceptionCode_BadParam err) {
                Console.Error.WriteLine("! Unable to create struct typecode: " 
                    + err.Message);
                return null;
            }
            return structTc;                
        }

        public static void delete(DDS.TypeCode type) {
            if (type != null) {
                DDS.TypeCodeFactory.get_instance().delete_tc(type);
            }
        }
    }
}
