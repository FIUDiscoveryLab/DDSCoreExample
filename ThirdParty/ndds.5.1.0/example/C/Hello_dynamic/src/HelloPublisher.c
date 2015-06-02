/*****************************************************************************/
/*         (c) Copyright, Real-Time Innovations, All rights reserved.        */
/*                                                                           */
/*         Permission to modify and use for internal purposes granted.       */
/* This software is provided "as is", without warranty, express or implied.  */
/*                                                                           */
/*****************************************************************************/


#include "Hello.h"
#include "HelloPublisher.h"

/* Defines the maximum number of consecutive write errors. */
#define MAX_CONSECUTIVE_WRITE_ERROR         10



/*****************************************************************************/
/* start_publisher                                                           */
/*                                                                           */
/* Creates the DDS publisher and data writers, then start sending the data.  */
/*                                                                           */
/* Input:                                                                    */
/*   participant: the DDS domain participant to use                          */
/*   topic: the DDS topic to use for publishing                              */
/*   dataSise: size of the payload buffer to send                            */
/*                                                                           */
/* Returns:                                                                  */
/*   The boolean value DDS_BOOLEAN_TRUE if an error occurred.                */
/*                                                                           */
/*****************************************************************************/
DDS_Boolean start_publisher(
                        DDS_DomainParticipant *participant,
                        DDS_Topic *topic,
                        struct DDS_DynamicDataTypeSupport *typeSupport,
                        DDS_Boolean verbose,
                        DDS_Long data_size,
                        DDS_Long sampleCount) {
    DDS_DataWriter *data_writer          = NULL;
    DDS_DynamicDataWriter *hello_writer  = NULL;
    DDS_DynamicData *instance            = NULL;
    DDS_Boolean return_value             = DDS_BOOLEAN_FALSE;
    DDS_Long i;
    DDS_Octet * ptr_payload              = NULL;
    DDS_Long count;
    DDS_ReturnCode_t rc;
    struct DDS_OctetSeq payload_sequence;
    
    /* Creates the DDS Data writer. 
     * Just like before, if you want to customize the writer QoS,
     * use DDS_Publisher_get_default_datawriter_qos() to 
     * initialize a local copy of the default QoS, modify them, then
     * use them in the creation call below instead of 
     * DDS_DATAWRITER_QOS_DEFAULT.
     * For more data writer API info, see:
     *     $NDDSHOME/doc/html/api_c/group__DDSWriterModule.html
     */
    if (verbose) {
        printf("Creating the data writer...\n");
    }
    data_writer = DDS_DomainParticipant_create_datawriter(
                        participant, 
                        topic,
                        &DDS_DATAWRITER_QOS_DEFAULT,
                        NULL,           /* listener */
                        DDS_STATUS_MASK_NONE);
    if (data_writer == NULL) {
        fprintf(stderr, "! Unable to create DDS data writer\n");
        goto exitFn;
    }

    /* The following narrow function should never fail, as it performs 
     * only a safe cast of the generic data writer into a specific
     * DDS_StringDataWriter.
     * In our case the following cast would do the same job:
     *     hello_writer = (DDS_StringDataWriter *)data_writer;
     */
    hello_writer = DDS_DynamicDataWriter_narrow(data_writer);
    if (hello_writer == NULL) {
        fprintf(stderr, "! Unable to narrow data writer into "
                        "DDS_StringDataWriter\n");
        goto exitFn;
    }
    
    /* Creates an instance of the sparse data we are about to send
     */
    instance = DDS_DynamicDataTypeSupport_create_data(typeSupport);
    if (instance == NULL) {
        fprintf(stderr, "! Unable to create an instance of the data\n");
        fprintf(stderr, "! This problem most likely is caused by out of memory\n");
        goto exitFn;
    }

    /* The DynamicDataType has been defined (in HelloWorldType.c) to hold
     * a structure like the following one:
     * struct HelloWorld {
     *     string<64>            prefix;
     *     long                  sampleId;
     *     sequence<octet, 8192> payload;
     * };
     */
    DDS_DynamicData_set_string(instance,
                        "prefix", 
                        DDS_DYNAMIC_DATA_MEMBER_ID_UNSPECIFIED, 
                        "Hello World!");
    DDS_DynamicData_set_long(instance,
                        "sampleId", 
                        DDS_DYNAMIC_DATA_MEMBER_ID_UNSPECIFIED, 
                        0);
    DDS_OctetSeq_initialize(&payload_sequence);
    DDS_OctetSeq_ensure_length(&payload_sequence, data_size, data_size);
    ptr_payload = DDS_OctetSeq_get_contiguous_buffer(&payload_sequence);
    for (i = 0; i < data_size; ++i) {
       *(ptr_payload+i) = (i % 0xff);
    }
    DDS_DynamicData_set_octet_seq(instance,
                        "payload",
                        DDS_DYNAMIC_DATA_MEMBER_ID_UNSPECIFIED, 
                        &payload_sequence);
    
    /* Send the data! */
    printf("Sending data...\n");
    i = 0; /* Use 'i' to keep track of consecutive write errors */
    for (count = 0;; ++count ) {
        rc = DDS_DynamicData_set_long(instance,
                        "sampleId", 
                        DDS_DYNAMIC_DATA_MEMBER_ID_UNSPECIFIED, 
                        count);
        if (rc != DDS_RETCODE_OK) {
            fprintf(stderr, "! Unable to set value (%d) for sampleId. "
                        "Error=%d\n", count, rc);
            continue;
        }
    
        rc = DDS_DynamicDataWriter_write(
                        hello_writer, 
                        instance, 
                        &DDS_HANDLE_NIL);
        if (rc != DDS_RETCODE_OK) {
            fprintf(stderr, "! Write error %d\n", rc);
            if (++i > MAX_CONSECUTIVE_WRITE_ERROR) {
                fprintf(stderr, "! Reached maximum number of failure, "
                       "stopping writer...\n");
                goto exitFn;
            }
        }
        i = 0;  /* Always clear the error count in case of successful write */
        if (verbose && (count % 10000) == 0) {
            printf("Sent %d samples...\n", count);
        }
        /* Stop after sampleCount sent */
        if (sampleCount != 0 && (count >= sampleCount)) {
            printf("\nSent %d samples.\n", count);
            break;
        }
    }
    
    /* This code is reached only if sampleCount is set */
    return_value = DDS_BOOLEAN_TRUE;

exitFn:
    if (instance != NULL) {
        DDS_DynamicData_delete(instance);
        instance = NULL;
    }

    DDS_OctetSeq_finalize(&payload_sequence);
    
    return return_value;
}

