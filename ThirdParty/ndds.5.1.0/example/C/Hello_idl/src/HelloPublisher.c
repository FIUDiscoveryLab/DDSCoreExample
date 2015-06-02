/*****************************************************************************/
/*         (c) Copyright, Real-Time Innovations, All rights reserved.        */
/*                                                                           */
/*         Permission to modify and use for internal purposes granted.       */
/* This software is provided "as is", without warranty, express or implied.  */
/*                                                                           */
/*****************************************************************************/


#include "Hello.h"
#include "HelloPublisher.h"
#include "HelloWorld.h"
#include "HelloWorldSupport.h"


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
                        DDS_Boolean verbose,
                        DDS_Long data_size,
                        DDS_Long sample_count) {

    DDS_Publisher *publisher             = NULL;
    DDS_DataWriter *data_writer          = NULL;
    HelloWorldDataWriter *hello_writer   = NULL;
    HelloWorld *instance                 = NULL;
    DDS_Octet * payload_buffer           = NULL;
    DDS_Boolean return_value             = DDS_BOOLEAN_FALSE;
    DDS_Long i;
    DDS_ReturnCode_t rc;
    
    /* Create the publisher. 
     * Just like the participant, if you want to customize the publisher QoS,
     * use DDS_DomainParticipant_get_default_publisher_qos() to 
     * initialize a local copy of the default QoS, modify them, then
     * use them in the creation call below instead of 
     * DDS_PUBLISHER_QOS_DEFAULT.
     * For more info on publisher API, see:
     *     $NDDSHOME/doc/html/api_c/group__DDSPublisherModule.html
     */
    if (verbose) {
        printf("Creating the publisher...\n");
    }
    publisher = DDS_DomainParticipant_create_publisher(
                        participant,
                        &DDS_PUBLISHER_QOS_DEFAULT,
                        NULL,           /* listener */
                        DDS_STATUS_MASK_NONE);
    if (publisher == NULL) {
        fprintf(stderr, "! Unable to create DDS Publisher\n");
        goto exitFn;
    }

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
    data_writer = DDS_Publisher_create_datawriter(
                        publisher, 
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
     * HelloWorldDataWriter.
     * In our case the following cast would do the same job:
     *     hello_writer = (HelloWorldDataWriter *)data_writer;
     */
    hello_writer = HelloWorldDataWriter_narrow(data_writer);
    if (hello_writer == NULL) {
        fprintf(stderr, "! Unable to narrow data writer into HelloWorldDataWriter\n");
        goto exitFn;
    }

    /* Everything is ready, start writing the data.
     * The create data function below simply allocates on the heap an 
     * instance of the data to send.
     * Alternatively you can allocate the HelloWorld instance on the
     * struct, and call the HelloWorld_initialize_ex() function
     * to initialize the field to a known value.
     * For more information on the user data type support, see:
     *     $NDDSHOME/doc/html/api_c/group__DDSUserDataModule.html
     *
     * In this case we create an instance of the data on the heap, but
     * we tell the HelloWorld_create_data_ex to skip allocation of the
     * inner buffers (in our case, the 'prefix' string).
     */
    instance = HelloWorldTypeSupport_create_data_ex(
                        DDS_BOOLEAN_FALSE);
    if (instance == NULL) {
        fprintf(stderr, "! Unable to create an instance of the data\n");
        fprintf(stderr, "! This problem most likely is caused by "
                        "out of memory\n");
        goto exitFn;
    }

    /* Sets the length of the sequence we are sending */
    if (!DDS_OctetSeq_ensure_length(&instance->payload, 
                        data_size, 
                        HELLODDS_MAX_PAYLOAD_SIZE)) {
        fprintf(stderr, "! Unable to set payload size to %d\n", data_size);
        fprintf(stderr, "! Perhaps you are using a value too big "
                        "(max allowed size is %d)\n", 
                        HELLODDS_MAX_PAYLOAD_SIZE);
        goto exitFn;
    }
    
    /* The payload_buffer has been already allocated during the previous call
     * now we get a pointer to the buffer used to manage the sequence
     * so we can address directly the bytes.
     * For more information on sequence, see:
     *     $NDDSHOME/doc/html/api_c/group__DDSSequenceModule.html
     *
     */
    payload_buffer = DDS_OctetSeq_get_contiguous_buffer(&instance->payload);
    

    /* Fill up the buffer with some valid data:
     * The content of the payload buffer is a progressive series of incremental
     * numbers, starting from 0.
     */
    for (i = 0; i < data_size; ++i) {
        payload_buffer[i] = (i & 0xff);
    }
    
    sprintf(instance->prefix, "Hello world");
    
    /* Send the data! */
    printf("Sending data...\n");
    i = 0; /* Use 'i' to keep track of consecutive write errors */
    for (instance->sampleId = 0;; ++(instance->sampleId) ) {
        rc = HelloWorldDataWriter_write(
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
        i = 0;  /* Always clear the error count after a successful write */
        if (verbose && (instance->sampleId % 10000) == 0) {
            printf("Sent %d samples...\n", instance->sampleId);
        }
        if (sample_count != 0 && instance->sampleId >= sample_count) {
            printf("\nSent %d samples.\n", instance->sampleId);
            break;
        }
    }
    
    /* This code is reached when sampleCount is set */
    return_value = DDS_BOOLEAN_TRUE;

exitFn:
    if (instance != NULL) {
        HelloWorldTypeSupport_delete_data_ex(instance,
                        DDS_BOOLEAN_FALSE);
        instance = NULL;
    }
    
    return return_value;
}

