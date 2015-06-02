/*****************************************************************************/
/*         (c) Copyright, Real-Time Innovations, All rights reserved.        */
/*                                                                           */
/*         Permission to modify and use for internal purposes granted.       */
/* This software is provided "as is", without warranty, express or implied.  */
/*                                                                           */
/*****************************************************************************/

#include <stdio.h>
#include <string>
#include <sstream>
#include <ndds/ndds_c.h>
#include "Hello.h"
#include "rti_dl/rti_dl_cpp.h"
#ifndef dds_cpp_domain_h
  #include "dds_cpp/dds_cpp_domain.h"
#endif

using namespace std;
/*****************************************************************************/
/* Local constants & macros                                                  */
/*****************************************************************************/

/* Command line defaults */
/* Change here the default domain ID or pass it as a parameter when calling to
 * the executable. For example, to run it in domain 115 do:
 *  Hello 115
 */
#define DEFAULT_DOMAIN_ID       0
#define DEFAULT_MESSAGE         "This is an example of RTI Distributed Logger"
#define MAX_STRING_SIZE	        1024

/* The maximum value for Domain ID. The effective value depends on the QoS,
 * in particular to the value of the field:
 *              DDS_RtpsWellKnownPorts_t.domainId_gain
 * The default value is 250, so we just limit to that statically so we can
 * check the validity before attempting to create the domain participant.
 */
#define DOMAIN_ID_MAX               250

/*****************************************************************************/
/* main                                                                      */
/*                                                                           */
/* Application main entry point                                              */
/*****************************************************************************/
int hello_main(int domainId) {

    int main_result = 1; /* error by default */
    DDS_ReturnCode_t retcode = DDS_RETCODE_OK;
    char message[MAX_STRING_SIZE];
    bool ok = false;
    RTI_DLDistLogger *dl = NULL;

    /* --- Set Up --------------------------------------------------------- */

    printf("RTI Distributed Logger Example Application\n");
    printf("Copyright 2011 Real-Time Innovations, Inc.\n\n");

    /* First we need to create the options
     If no options are provided, RTI DL creates
     default ones and work with them.
     */
    printf("Creating default options\n");
    RTI_DLOptions dlOptions;

    /* We can personalize RTI DL using the Options */
    printf("Configuring options\n");
    retcode = dlOptions.setDomainId(domainId);
    if(retcode != DDS_RETCODE_OK){
        printf("Error: Unable to set Domain Id\n");
        goto clean_exit;
    }
    retcode = dlOptions.setApplicationKind("Hello Distributed Logger C++ Example");
    if(retcode != DDS_RETCODE_OK){
        fprintf(stderr,"Error: Unable to set Application Kind\n");
        goto clean_exit;
    }

    /* Before using the RTI DL, we set the Options
     otherwise, default options are created */
    printf("Setting options\n");
    ok = RTI_DLDistLogger::setOptions(dlOptions);
    if(!ok){
        fprintf(stderr,"Error: Unable to set Options\n");
        goto clean_exit;
    }

    /* instantiate the logger instance */
    printf("Getting Distributed Logger\n");
    dl = RTI_DLDistLogger::getInstance();
    if (dl == NULL) {
	    fprintf(stderr,"Error: Unable to get RTI Distributed Logger Instance\n");
        goto clean_exit;
    }

    printf("Ready to use RTI DL in domain %d.",domainId);
    printf("We are going to send messages with different error levels.\n");
    printf("Press CTRL+C to terminate or wait until # reaches 99.\n");

    /* RTI provides APIs for detecting when data readers and data writers
     * join the network. You can also configure data durability so that data
     * readers can receive data that were written before they started.
     * However, for the sake of keeping this example as simple as possible,
     * it asks you to use RTI Monitor.
     */

    /* Sending error messages */
    for (int i = 0; i < 100; i++) {
        sprintf(message, "%s #%d", DEFAULT_MESSAGE, i);
        printf("%s\n",message);
        dl->error(message);
        dl->debug(message);
        dl->warning(message);

        RTI_DLUtility::sleep(1000);
    }

    main_result = 0;
clean_exit:
    printf("Exiting...\n");

    if (dl != NULL) {
        /* If we don't finalize it, it will forward all the log messages */
        dl->finalizeInstance();
        /* If this is the last RTI DDS application running, we should finalize everything*/
        DDSTheParticipantFactory->finalize_instance();
    }
    // Application terminates if sampleCount is set.
    printf("Done.\n");
    return EXIT_SUCCESS;
}
#if !(defined(RTI_VXWORKS) && !defined(__RTP__))
int main(int argc, char *argv[])
{
    int domainId = DEFAULT_DOMAIN_ID;

    if (argc >= 2) {
        domainId = atoi(argv[1]);
    }

    /* Uncomment this to turn on additional logging
 *  *  *     NDDS_Config_Logger_set_verbosity_by_category(
 *   *   *             NDDS_Config_Logger_get_instance(),
 *    *    *                     NDDS_CONFIG_LOG_CATEGORY_API,
 *     *     *                             NDDS_CONFIG_LOG_VERBOSITY_STATUS_ALL);
 *      *      *                                 */

    return hello_main(domainId);
}
#endif

