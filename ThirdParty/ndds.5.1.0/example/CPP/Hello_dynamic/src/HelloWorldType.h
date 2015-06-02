/*****************************************************************************/
/*         (c) Copyright, Real-Time Innovations, All rights reserved.        */
/*                                                                           */
/*         Permission to modify and use for internal purposes granted.       */
/* This software is provided "as is", without warranty, express or implied.  */
/*                                                                           */
/*****************************************************************************/

/* The HelloWorldType provides the functionality to create the definition
 * of the type used in this example.
 *
 * The type is compatible with the same used in the Hello_idl example:
 * 
 * const long HELLODDS_MAX_PAYLOAD_SIZE = 8192;
 * const long HELLODDS_MAX_STRING_SIZE = 64;
 * struct HelloWorld {
 *     string<HELLODDS_MAX_STRING_SIZE>             prefix;
 *     long                                         sampleId;
 *     sequence<octet, HELLODDS_MAX_PAYLOAD_SIZE>   payload;
 * };
 */

/* Simply returns the name of this type ("HelloWorld") */
const char * HelloWorldType_get_type_name();

/* Creates and return the DDS_TypeCode definition for the HelloWorld type */
DDS_TypeCode *HelloWorldType_create();

/* Deletes the DDS_TypeCode definition created by HelloWorldType_create() */
void HelloWorldType_delete(DDS_TypeCode *type);

