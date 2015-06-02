/*****************************************************************************/
/*         (c) Copyright, Real-Time Innovations, All rights reserved.        */
/*                                                                           */
/*         Permission to modify and use for internal purposes granted.       */
/* This software is provided "as is", without warranty, express or implied.  */
/*                                                                           */
/*****************************************************************************/

#include <stdio.h>
#include <ndds/ndds_c.h>
#include "Hello.h"
/* Add the distributed logger functionality */
#include <rti_dl/rti_dl_c.h>

/* By default DDS::String type manage strings up to 1k */
#define DEFAULT_MESSAGE         "Logging a message using RTI DL"
/* Change here the default domain ID or pass it as a parameter when calling to
 * the executable. For example, to run it in domain 115 do:
 *  Hello 115
 */
#define DEFAULT_DOMAIN_ID       0
#define MAX_STRING_SIZE         1024

int hello_main(int domainId) {
    char message[MAX_STRING_SIZE];
    int main_result = 1; /* error by default */
    RTI_DL_DistLogger *dl = NULL;
    RTI_DL_Options *dlOptions = NULL;
    DDS_ReturnCode_t retcode = DDS_RETCODE_OK;
    RTIBool ok = RTI_FALSE;
    int i;

    /* --- Set Up --------------------------------------------------------- */

    printf("RTI Distributed Logger Example Application\n");
    printf("Copyright 2011 Real-Time Innovations, Inc.\n\n");

    /* First we need to create the options
     If no options are provided, RTI DL creates
     default ones and work with them.
     */
    printf("Creating default options\n");
    dlOptions = RTI_DL_Options_createDefault();

    /* We can personalize RTI DL using the Options */
    printf("Configuring options\n");
    retcode = RTI_DL_Options_setDomainId(dlOptions, domainId);
    if (retcode != DDS_RETCODE_OK){
        printf("Error setting domain ID\n");
        goto clean_exit;
    }
    RTI_DL_Options_setApplicationKind(dlOptions,
            "Hello Distributed Logger C Example");
    if (retcode != DDS_RETCODE_OK){
        printf("Error setting application kind\n");
        goto clean_exit;
    }

    /* Before using the RTI DL, we set the Options
     otherwise, default options are created */
    printf("Setting options\n");
    ok = RTI_DL_DistLogger_setOptions(dlOptions);
    if(!ok){
        printf("Error setting options\n");
        goto clean_exit;
    }

    /* instantiate the logger instance */
    printf("Getting Distributed Logger\n");
    dl = RTI_DL_DistLogger_getInstance();
    if (dl == NULL) {
        printf("Error: Unable to get RTI Distributed Logger Instance");
        goto clean_exit;
    }

    puts("Ready to use RTI DL.");
    puts("We are going to send messages with different error levels.");
    puts("Press CTRL+C to terminate or wait until # reaches 99.");
    puts("");
    /* RTI provides APIs for detecting when data readers and data writers
     * join the network. You can also configure data durability so that data
     * readers can receive data that were written before they started.
     * However, for the sake of keeping this example as simple as possible,
     * it asks you to use RTI Monitor.
     */

    /* Sending error messages */
    /*If you want to make this example an infinit loop, 
     comment out the for loop and use a while loop instead.
     */
    for (i = 0; i < 100; i++) {
        sprintf(message, "%s #%d", DEFAULT_MESSAGE, i);
        printf("%s\n", message);
        RTI_DL_DistLogger_error(dl, message);
        RTI_DL_DistLogger_debug(dl, message);
        RTI_DL_DistLogger_warning(dl, message);

        RTI_DL_Utility_sleep(1000);
    }

    /* --- Clean Up ------------------------------------------------------- */

    main_result = 0;
    clean_exit: puts("Exiting...");

    if (dlOptions != NULL) {
        RTI_DL_Options_delete(dlOptions);
    }

    if (dl != NULL) {
        /* If we don't finalize it, it will forward all the log messages */
        retcode = RTI_DL_DistLogger_finalizeInstance();
        if (retcode != DDS_RETCODE_OK) {
            printf(
                    "Error: Unable to finalize RTI Distributed Logger instance");
            main_result = 1;
        }
        /*Remember to finalize the factory once your DDS program is finished */
        DDS_DomainParticipantFactory_finalize_instance();

    }

    return main_result;
}

#if !(defined(RTI_VXWORKS) && !defined(__RTP__))
int main(int argc, char *argv[])
{
    int domainId = DEFAULT_DOMAIN_ID;

    if (argc >= 2) {
        domainId = atoi(argv[1]);
    }
    /* Uncomment this to turn on additional logging
 *     NDDS_Config_Logger_set_verbosity_by_category(
 *             NDDS_Config_Logger_get_instance(),
 *                     NDDS_CONFIG_LOG_CATEGORY_API, 
 *                             NDDS_CONFIG_LOG_VERBOSITY_STATUS_ALL);
 *                                 */

    return hello_main(domainId);
}
#endif

