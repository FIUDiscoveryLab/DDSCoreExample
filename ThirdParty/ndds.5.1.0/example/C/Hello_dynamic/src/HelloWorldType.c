/*****************************************************************************/
/*         (c) Copyright, Real-Time Innovations, All rights reserved.        */
/*                                                                           */
/*         Permission to modify and use for internal purposes granted.       */
/* This software is provided "as is", without warranty, express or implied.  */
/*                                                                           */
/*****************************************************************************/

#include "ndds/ndds_c.h"
#include "HelloWorldType.h"
#include "Hello.h"  /* Contains the constants HELLODDS_MAX_PAYLOAD_SIZE      */
                    /* and HELLODDS_MAX_STRING_SIZE.                         */


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
    struct DDS_TypeCodeFactory * factory = NULL;
    struct DDS_TypeCode * sequenceTc = NULL;   /* Typecode for 'payload'     */
    struct DDS_TypeCode * stringTc = NULL;     /* Typecode for 'prefix'      */
    struct DDS_TypeCode * structTc = NULL;     /* Top-level typecode         */
    DDS_ExceptionCode_t ex;
    struct DDS_StructMemberSeq memberSeq = DDS_SEQUENCE_INITIALIZER;

    factory = DDS_TypeCodeFactory_get_instance();
    if (factory == NULL) {
        fprintf(stderr, "! Unable to get type code factory singleton\n");
        goto done;
    }
    
    /* Create typecode for prefix field of max size HELLODDS_MAX_STRING_SIZE */
    stringTc = DDS_TypeCodeFactory_create_string_tc(
                        factory,
                        HELLODDS_MAX_STRING_SIZE,
                        &ex);
    if (ex != DDS_NO_EXCEPTION_CODE) {
        fprintf(stderr, "! Unable to create 'prefix' string typecode: \n");
        goto done;
    }
    
    /* Create typecode for 'payload' octet sequence */
    sequenceTc = DDS_TypeCodeFactory_create_sequence_tc(
                        factory,
                        HELLODDS_MAX_PAYLOAD_SIZE,
                        DDS_TypeCodeFactory_get_primitive_tc(factory, 
                                                             DDS_TK_OCTET),
                        &ex);
    if (ex != DDS_NO_EXCEPTION_CODE) {
        fprintf(stderr, "! Unable to create 'payload' sequence typecode: %d\n", 
                        ex);
        goto done;
    }

    structTc = DDS_TypeCodeFactory_create_struct_tc(
                        factory,
                        "HelloWorld", 
                        &memberSeq, 
                        &ex);
    if (ex != DDS_NO_EXCEPTION_CODE) {
        fprintf(stderr, "! Unable to create struct typecode, error=%d\n", ex);
        goto done;
    }
    
    DDS_TypeCode_add_member(structTc, 
                        "prefix",
                        DDS_MEMBER_ID_INVALID,
                        stringTc,
                        DDS_TYPECODE_NONKEY_MEMBER,
                        &ex);
    if (ex != DDS_NO_EXCEPTION_CODE) {
        fprintf(stderr, "! Unable to add member to struct typecode, error=%d\n", 
                        ex);
        goto done;
    }

    DDS_TypeCode_add_member(structTc,
                        "sampleId",
                        DDS_MEMBER_ID_INVALID,
                        DDS_TypeCodeFactory_get_primitive_tc(factory, 
                                                             DDS_TK_LONG),
                        DDS_TYPECODE_NONKEY_MEMBER,
                        &ex);
    if (ex != DDS_NO_EXCEPTION_CODE) {
        fprintf(stderr, "! Unable to add member to struct typecode, error=%d\n", 
                        ex);
        goto done;
    }
    
    DDS_TypeCode_add_member(structTc,
                        "payload",
                        DDS_MEMBER_ID_INVALID,
                        sequenceTc,
                        DDS_TYPECODE_NONKEY_MEMBER,
                        &ex);
    if (ex != DDS_NO_EXCEPTION_CODE) {
        fprintf(stderr, "! Unable to add member to struct typecode, error=%d\n", 
                        ex);
        goto done;
    }

#if 0    
    
    
    /* Populate the members of the top-level structure */
    DDS_StructMemberSeq_ensure_length(&memberSeq, 3, 3);
    ptrMember = DDS_StructMemberSeq_get_reference(&memberSeq, 0);
    ptrMember->name = "prefix";
    ptrMember->type = stringTc;
    ptrMember->is_pointer = DDS_BOOLEAN_FALSE;
    ptrMember->bits = -1;
    ptrMember->is_key = DDS_TYPECODE_NONKEY_MEMBER;

    ptrMember = DDS_StructMemberSeq_get_reference(&memberSeq, 1);
    ptrMember->name = "sampleId";
    ptrMember->type = DDS_TypeCodeFactory_get_primitive_tc(factory, 
                        DDS_TK_LONG);
    ptrMember->is_pointer = DDS_BOOLEAN_FALSE;
    ptrMember->bits = -1;
    ptrMember->is_key = DDS_TYPECODE_NONKEY_MEMBER;

    ptrMember = DDS_StructMemberSeq_get_reference(&memberSeq, 2);
    ptrMember->name = "payload";
    ptrMember->type = sequenceTc;
    ptrMember->is_pointer = DDS_BOOLEAN_FALSE;
    ptrMember->bits = -1;
    ptrMember->is_key = DDS_TYPECODE_NONKEY_MEMBER;

    structTc = DDS_TypeCodeFactory_create_struct_tc(
                        factory,
                        "HelloWorld", 
                        &memberSeq, 
                        &ex);
    if (ex != DDS_NO_EXCEPTION_CODE) {
        fprintf(stderr, "! Unable to create struct typecode, error=%d\n", ex);
        goto done;
    }
#endif

    if (sequenceTc != NULL) {
        DDS_TypeCodeFactory_delete_tc(factory, sequenceTc, &ex);
        sequenceTc = NULL;
    }
    if (stringTc != NULL) {
        DDS_TypeCodeFactory_delete_tc(factory, stringTc, &ex);
        stringTc = NULL;
    }

    return structTc;

done:
    /* In case of failure, do a cleanup of all the temporary data structures */
    if (sequenceTc != NULL) {
        DDS_TypeCodeFactory_delete_tc(factory, sequenceTc, &ex);
    }
    if (stringTc != NULL) {
        DDS_TypeCodeFactory_delete_tc(factory, stringTc, &ex);
    }
    if (structTc != NULL) {
        DDS_TypeCodeFactory_delete_tc(factory, structTc, &ex);
    }
    return NULL;
}

/*****************************************************************************/
/* HelloWorldType_delete                                                     */
/*                                                                           */
/* Deletes type code created by HellOWorldType_create                        */
/*                                                                           */
/*****************************************************************************/
void HelloWorldType_delete(DDS_TypeCode *type) {
    struct DDS_TypeCodeFactory * factory = NULL;
    DDS_ExceptionCode_t ex;

    if (type == NULL) {
        return;
    }

    factory = DDS_TypeCodeFactory_get_instance();
    if (factory == NULL) {
        fprintf(stderr, "! Unable to get type code factory singleton\n");
        return;
    }

    /* delete topc-level type code */
    DDS_TypeCodeFactory_delete_tc(factory, type, &ex);
    if (ex != DDS_NO_EXCEPTION_CODE) {
        fprintf(stderr, "! Unable to delete typecode\n");
        return;
    }

}
