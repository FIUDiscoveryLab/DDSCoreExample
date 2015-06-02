/*****************************************************************************/
/*         (c) Copyright, Real-Time Innovations, All rights reserved.        */
/*                                                                           */
/*         Permission to modify and use for internal purposes granted.       */
/* This software is provided "as is", without warranty, express or implied.  */
/*                                                                           */
/*****************************************************************************/

#include <iostream>
#include "dds_cpp/dds_cpp_domain.h"
#include "ndds/ndds_cpp.h"
#include "HelloWorldType.h"
#include "Hello.h"  // Contains the constants HELLODDS_MAX_PAYLOAD_SIZE
                    // and HELLODDS_MAX_STRING_SIZE.


/*****************************************************************************/
/* HelloWorldType_get_type_name                                              */
/*                                                                           */
/* Returns a C String with the name of this data type                        */
/*****************************************************************************/
const char *HelloWorldType_get_type_name() {
    return "HelloWorld";
}



/*****************************************************************************/
/* HelloWorldType_create                                                     */
/*                                                                           */
/* Creates type code for a structure corresponding to:                       */
/*                                                                           */
/* struct HelloWorld {                                                       */
/*    string<HELLODDS_MAX_STRING_SIZE>             prefix;                   */
/*    long                                         sampleId;                 */
/*    sequence<octet, HELLODDS_MAX_PAYLOAD_SIZE>   payload;                  */
/* };                                                                        */
/*                                                                           */
/* Returns NULL in case of error                                             */
/*****************************************************************************/
DDS_TypeCode *HelloWorldType_create() {
    DDS_TypeCodeFactory * factory = NULL;
    DDS_TypeCode * sequenceTc = NULL;   // Typecode for the 'payload' sequence
    DDS_TypeCode * stringTc = NULL;     // Typecode for the 'prefix' string;
    DDS_TypeCode * structTc = NULL;     // Top-level typecode
    DDS_ExceptionCode_t ex;

    factory = DDS_TypeCodeFactory::get_instance();
    if (factory == NULL) {
        std::cerr << "! Unable to get type code factory singleton" 
                  << std::endl;
        goto done;
    }
    
    // Create typecode for 'prefix' string of max size HELLODDS_MAX_STRING_SIZE
    stringTc = factory->create_string_tc(HELLODDS_MAX_STRING_SIZE, ex);
    if (ex != DDS_NO_EXCEPTION_CODE) {
        std::cerr << "! Unable to create 'prefix' string typecode: " << ex 
                  << std::endl;
        goto done;
    }
    
    // Create typecode for 'payload' octet sequence
    sequenceTc = factory->create_sequence_tc(HELLODDS_MAX_PAYLOAD_SIZE,
                        factory->get_primitive_tc(DDS_TK_OCTET),
                        ex);
    if (ex != DDS_NO_EXCEPTION_CODE) {
        std::cerr << "! Unable to create 'payload' sequence typecode: " << ex
                  << std::endl;
        goto done;
    }
    structTc = factory->create_struct_tc("HelloWorld", DDS_StructMemberSeq(), 
                        ex);
    if (ex != DDS_NO_EXCEPTION_CODE) {
        std::cerr << "! Unable to create struct typecode, error=" << ex 
                  << std::endl;
        goto done;
    }
    structTc->add_member("prefix",
                        DDS_MEMBER_ID_INVALID,
                        stringTc,
                        DDS_TYPECODE_NONKEY_MEMBER,
                        ex);
    if (ex != DDS_NO_EXCEPTION_CODE) {
        std::cerr << "! Unable to add member to struct typecode, error=" << ex 
                  << std::endl;
        goto done;
    }

    structTc->add_member("sampleId",
                        DDS_MEMBER_ID_INVALID,
                        factory->get_primitive_tc(DDS_TK_LONG),
                        DDS_TYPECODE_NONKEY_MEMBER,
                        ex);
    if (ex != DDS_NO_EXCEPTION_CODE) {
        std::cerr << "! Unable to add member to struct typecode, error=" << ex 
                  << std::endl;
        goto done;
    }
    
    structTc->add_member("payload",
                        DDS_MEMBER_ID_INVALID,
                        sequenceTc,
                        DDS_TYPECODE_NONKEY_MEMBER,
                        ex);
    if (ex != DDS_NO_EXCEPTION_CODE) {
        std::cerr << "! Unable to add member to struct typecode, error=" << ex 
                  << std::endl;
        goto done;
    }

    if (sequenceTc != NULL) {
        factory->delete_tc(sequenceTc, ex);
        sequenceTc = NULL;
    }
    if (stringTc != NULL) {
        factory->delete_tc(stringTc, ex);
        stringTc = NULL;
    }

    return structTc;

done:
    // In case of failure, do a cleanup of all the temporary data structures
    if (sequenceTc != NULL) {
        factory->delete_tc(sequenceTc, ex);
    }
    if (stringTc != NULL) {
        factory->delete_tc(stringTc, ex);
    }
    if (structTc != NULL) {
        factory->delete_tc(structTc, ex);
    }
    return NULL;
}




/* Use the following version if you want to use sparse data types.
 * With Sparse data types, you cannot communicate with from another
 * publisher/subscriber that uses IDL-based types (i.e. Hello_idl).
 * struct HelloWorld {                                        //@SPARSE
 *    string<HELLODDS_MAX_STRING_SIZE>             prefix;
 *    long                                         sampleId;
 *    sequence<octet, HELLODDS_MAX_PAYLOAD_SIZE>   payload;
 * };
 */
#if 0
DDS_TypeCode *HelloWorldType_create() {
    DDS_TypeCodeFactory * factory = NULL;
    DDS_TypeCode * sequenceTc = NULL;   // Typecode for the 'payload' sequence
    DDS_TypeCode * stringTc = NULL;     // Typecode for the 'prefix' string;
    DDS_TypeCode * sparseTc = NULL;     // Top-level typecode
    DDS_ExceptionCode_t ex;
    DDS_UnsignedLong index;             // Unused index

    factory = DDS_TypeCodeFactory::get_instance();
    if (factory == NULL) {
        std::cerr << "! Unable to get type code factory singleton" 
                  << std::endl;
        goto done;
    }

    // Create typecode for top level sparse type
    sparseTc = factory->create_sparse_tc("HelloWorld", DDS_VM_NONE, NULL, ex);
    if (ex != DDS_NO_EXCEPTION_CODE) {
        std::cerr << "! Unable to create sparse typecode, error=" << ex 
                  << std::endl;
        goto done;
    }
    
    // Create typecode for 'prefix' string of max size HELLODDS_MAX_STRING_SIZE
    stringTc = factory->create_string_tc(HELLODDS_MAX_STRING_SIZE, ex);
    if (ex != DDS_NO_EXCEPTION_CODE) {
        std::cerr << "! Unable to create 'prefix' string typecode: " << ex 
                  << std::endl;
        goto done;
    }
    
    // Create typecode for 'payload' octet sequence
    sequenceTc = factory->create_sequence_tc(HELLODDS_MAX_PAYLOAD_SIZE,
                        factory->get_primitive_tc(DDS_TK_OCTET),
                        ex);
    if (ex != DDS_NO_EXCEPTION_CODE) {
        std::cerr << "! Unable to create 'payload' sequence typecode: " << ex
                  << std::endl;
        goto done;
    }

    // Now add the members to the 'sparseTc' top level structure
    index = sparseTc->add_member("prefix", 10, stringTc, DDS_BOOLEAN_FALSE, ex);
    if (ex != DDS_NO_EXCEPTION_CODE) {
        std::cerr << "! Unable to add member 'prefix' to top-level type: " 
                  << ex << std::endl;
        goto done;
    }

    index = sparseTc->add_member("sampleId",
                                 11,
                                 factory->get_primitive_tc(DDS_TK_LONG),
                                 DDS_BOOLEAN_FALSE,
                                 ex);
    if (ex != DDS_NO_EXCEPTION_CODE) {
        std::cerr << "! Unable to add member 'sampleId' to top-level type: " << ex
                  << std::endl;
        goto done;
    }

    index = sparseTc->add_member("payload", 12, sequenceTc, DDS_BOOLEAN_FALSE, ex);
    if (ex != DDS_NO_EXCEPTION_CODE) {
        std::cerr << "! Unable to add member 'payload' to top-level type: " << ex
                  << std::endl;
        goto done;
    }

    if (sequenceTc != NULL) {
        factory->delete_tc(sequenceTc, ex);
        sequenceTc = NULL;
    }
    if (stringTc != NULL) {
        factory->delete_tc(stringTc, ex);
        stringTc = NULL;
    }

    return sparseTc;

done:
    // In case of failure, do a cleanup of all the temporary data structures
    if (sequenceTc != NULL) {
        factory->delete_tc(sequenceTc, ex);
    }
    if (stringTc != NULL) {
        factory->delete_tc(stringTc, ex);
    }
    if (sparseTc != NULL) {
        factory->delete_tc(sparseTc, ex);
    }
    return NULL;
}

#endif

/*****************************************************************************/
/* HelloWorldType_delete                                                     */
/*                                                                           */
/* Deletes type code created by HellOWorldType_create                        */
/*                                                                           */
/*****************************************************************************/
void HelloWorldType_delete(DDS_TypeCode *type) {
    DDS_TypeCodeFactory * factory = NULL;
    DDS_ExceptionCode_t ex;

    factory = DDS_TypeCodeFactory::get_instance();
    if (factory == NULL) {
        std::cerr << "! Unable to get type code factory singleton" 
                  << std::endl;
        return;
    }

    if (type != NULL) {
        factory->delete_tc(type, ex);
    }
    if (ex != DDS_NO_EXCEPTION_CODE) {
        std::cerr << "! Unable to delete typecode: " << ex 
                  << std::endl;
        return;
    }

}
