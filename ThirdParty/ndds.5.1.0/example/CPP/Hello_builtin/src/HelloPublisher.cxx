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
                        DDS_Long verbose,
                        DDS_Long dataSize,
                        DDS_Long sampleCount) {
    
    DDSDataWriter *dataWriter            = NULL;
    DDSStringDataWriter *helloWriter     = NULL;
    char *instance                       = NULL;
    bool returnValue                     = false;
    DDS_Long i, count;
    DDS_ReturnCode_t rc;
    
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
    helloWriter = DDSStringDataWriter::narrow(dataWriter);
    if (helloWriter == NULL) {
        std::cerr << "! Unable to narrow data writer into DDSStringDataWriter"
                  << std::endl;
        goto exitFn;
    }

    /* The string we are sending will have the following form:
     * - 10 characters (padded with spaces) will contain a sequence number,
     *   in ASCII character
     * - the rest of the string (data_size - 10) will contain just 'ABCDEF...'
     * The string buffer is managed by the application.
     */
    instance = DDS_String_alloc(dataSize);
    if (instance == NULL) {
        std::cerr << "! Unable to create an instance of the data" << std::endl;
        std::cerr << "! This problem most likely is caused by out of memory"
                  << std::endl;
        goto exitFn;
    }

 
    /* Fill up the buffer with some valid data:
     * The content of the payload buffer is a progressive series of incremental
     * numbers, starting from 0.
     */
    for (i = 0; i < dataSize; ++i) {
        instance[i] = (i < 11) ? ' ' : ('A' + (i % 26));
    }
    instance[i] = '\0'; // write() will use strlen to determine the length

    // Send the data!
    std::cout << "Sending data..." << std::endl;
    i = 0; /* Use 'i' to keep track of consecutive write errors */
    for (count = 0;; ++count) {
        /* Conversion of an integer to a string in snprintf is relatively
         * expensive and could impact the throughput. But since this is
         * just an example, let's keep it simple.
         */
        RTI_SNPRINTF(instance, 10, "%9d", count);
        instance[9] = ' '; /* Remove the '\0' introduced by snprintf */
        rc = helloWriter->write(
                        instance, 
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
        DDS_String_free(instance);
        instance = NULL;
    }
    
    return returnValue;
}

