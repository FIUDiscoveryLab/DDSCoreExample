/*****************************************************************************/
/*         (c) Copyright, Real-Time Innovations, All rights reserved.        */
/*                                                                           */
/*         Permission to modify and use for internal purposes granted.       */
/* This software is provided "as is", without warranty, express or implied.  */
/*                                                                           */
/*****************************************************************************/

#include <iostream>
#include <string>
#include <cstdlib>
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
/*   The boolean value true if an error occurred.                            */
/*                                                                           */
/*****************************************************************************/
bool startPublisher(
                        DDSDomainParticipant *participant,
                        DDSTopic *topic,
                        DDSDynamicDataTypeSupport *typeSupport,
                        DDS_Long verbose,
                        DDS_Long dataSize,
                        DDS_Long sampleCount) {
    
    DDSDataWriter *dataWriter            = NULL;
    DDSDynamicDataWriter *helloWriter    = NULL;
    DDS_DynamicData *instance            = NULL;
    bool returnValue                     = false;
    DDS_Long i, count;
    DDS_ReturnCode_t rc;
    DDS_OctetSeq payloadSequence;

    /* Creates the DDS Data writer. 
     * Just like before, if you want to customize the writer QoS,
     * use DDSPublisher::get_default_datawriter_qos() to 
     * initialize a local copy of the default QoS, modify them, then
     * use them in the creation call below instead of 
     * DDS_DATAWRITER_QOS_DEFAULT.
     * For more data writer API info, see:
     *     $NDDSHOME/doc/html/api_cpp/group__DDSWriterModule.html
     */
    if (verbose) {
        std::cout << "Creating the data writer..." << std::endl;
    }
    dataWriter = participant->create_datawriter(
                        topic,
                        DDS_DATAWRITER_QOS_DEFAULT,
                        NULL,           /* listener */
                        DDS_STATUS_MASK_NONE);
    if (dataWriter == NULL) {
        std::cerr << "! Unable to create DDS data writer" << std::endl;
        goto exitFn;
    }

    /* The following narrow function should never fail, as it performs 
     * only a safe cast of the generic data writer into a specific
     * DDSStringDataWriter.
     * In our case the following cast would do the same job:
     *
          helloWriter = static_cast<DDSStringDataWriter *>(dataWriter);
     */
    helloWriter = DDSDynamicDataWriter::narrow(dataWriter);
    if (helloWriter == NULL) {
        std::cerr << "! Unable to narrow data writer into DDSDynamicDataWriter"
                  << std::endl;
        goto exitFn;
    }

    /* Creates an instance of the sparse data we are about to send
     */
    instance = typeSupport->create_data();
    if (instance == NULL) {
        std::cerr << "! Unable to create an instance of the data" << std::endl;
        std::cerr << "! This problem most likely is caused by out of memory"
                  << std::endl;
        goto exitFn;
    }

    /* The DynamicDataType has been defined (in HelloWorldType.cxx) to hold
     * a structure like the following one:
     * struct HelloWorld {
     *     string<64>            prefix;
     *     long                  sampleId;
     *     sequence<octet, 8192> payload;
     * };
     */
    instance->set_string("prefix", 
                        DDS_DYNAMIC_DATA_MEMBER_ID_UNSPECIFIED, 
                        "Hello World!");
    instance->set_long("sampleId", 
                        DDS_DYNAMIC_DATA_MEMBER_ID_UNSPECIFIED, 
                        0);
    payloadSequence.ensure_length(dataSize, dataSize);
    for (i = 0; i < dataSize; ++i) {
        payloadSequence[i] = (i % 0xff);
    }
    instance->set_octet_seq("payload",
                        DDS_DYNAMIC_DATA_MEMBER_ID_UNSPECIFIED, 
                        payloadSequence);
    
    // Send the data!
    std::cout << "Sending data..." << std::endl;
    i = 0; /* Use 'i' to keep track of consecutive write errors */
    for (count = 0;; ++count) {
        rc = instance->set_long("sampleId", 
                        DDS_DYNAMIC_DATA_MEMBER_ID_UNSPECIFIED, 
                        count);
        if (rc != DDS_RETCODE_OK) {
            std::cerr << "! Unable to set value (" << count
                      << ") for sampleId. Error=" << rc << std::endl;
            continue;
        }
        rc = helloWriter->write(
                        *instance, 
                        DDS_HANDLE_NIL);
        if (rc != DDS_RETCODE_OK) {
            std::cerr << "! Write error " <<  rc << std::endl;
            if (++i > MAX_CONSECUTIVE_WRITE_ERROR) {
                std::cerr << "! Reached maximum number of failure, "
                          << "stopping writer..." << std::endl;
                goto exitFn;
            }
        }
        i = 0;  /* Always clear the error count in case of successful write */
        if (verbose && (count % 10000) == 0) {
            std::cout << "Sent " << count
                      << " samples..." << std::endl;
        }
        if (sampleCount != 0 && (count >= sampleCount)) {
            std::cout << "\nSent " << count
                      << " samples." << std::endl;
            break;
        }
    }
    
    /* This code is reached if sampleCount is set */
    returnValue = true;

exitFn:
    if (instance != NULL) {
        rc = typeSupport->delete_data(instance);
        if (rc != DDS_RETCODE_OK) {
            std::cerr << "! Unable to delete instance data: " 
                      << rc << std::endl;
        }
        instance = NULL;
    }
    
    return returnValue;
}

