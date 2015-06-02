/*****************************************************************************/
/*         (c) Copyright, Real-Time Innovations, All rights reserved.        */
/*                                                                           */
/*         Permission to modify and use for internal purposes granted.       */
/* This software is provided "as is", without warranty, express or implied.  */
/*                                                                           */
/*****************************************************************************/

#include <stdio.h>
#include <ndds/ndds_c.h>

/* By default DDS::String type manage strings up to 1k */
#define MAX_STRING_SIZE         1024

int main() {
    DDS_DomainParticipant * participant = NULL;
    DDS_Topic *             topic = NULL;
    DDS_DataWriter *        data_writer = NULL;
    DDS_StringDataWriter *  string_writer = NULL;
    DDS_ReturnCode_t        retcode;
    char                    sample[MAX_STRING_SIZE];
    int                     main_result = 1; /* error by default */
    
    /* --- Set Up --------------------------------------------------------- */

    /* Uncomment the following lines to increase the verbosity of the log
     * messages output by RTI Connext:
    NDDS_Config_Logger_set_verbosity(
                        NDDS_Config_Logger_get_instance(),
                        NDDS_CONFIG_LOG_VERBOSITY_STATUS_ALL );
    */

    /* Create the domain participant on domain ID 0 */
    participant = DDS_DomainParticipantFactory_create_participant(
                        DDS_TheParticipantFactory,
                        0,                              /* Domain ID */
                        &DDS_PARTICIPANT_QOS_DEFAULT,   /* QoS */
                        NULL,                           /* Listener */
                        DDS_STATUS_MASK_NONE);
    if (participant == NULL) {
        puts("Unable to create domain participant.");
        goto clean_exit;
    }

    /* Create the topic "Hello, World" for the String type */    
    topic = DDS_DomainParticipant_create_topic(
                        participant, 
                        "Hello, World",                        /* Topic name*/
                        DDS_StringTypeSupport_get_type_name(), /* Type name */
                        &DDS_TOPIC_QOS_DEFAULT,                /* Topic QoS */
                        NULL,                                  /* Listener  */
                        DDS_STATUS_MASK_NONE);
    if (topic == NULL) {
        puts("Unable to create topic.");
        goto clean_exit;
    }
    
    /* Create the data writer using the default publisher */
    data_writer = DDS_DomainParticipant_create_datawriter(
                                participant,
                                topic,
                                &DDS_DATAWRITER_QOS_DEFAULT,    /* QoS */
                                NULL,                           /* Listener */
                                DDS_STATUS_MASK_NONE);
    if (data_writer == NULL) {
        puts("Unable to create data writer.");
        goto clean_exit;
    }

    /* Perform a safe type-cast from a generic data writer into a
     * specific data writer for the type "DDS::String"
     */
    string_writer = DDS_StringDataWriter_narrow(data_writer);
    if (string_writer == NULL) {
        /* In this specific case, this will never fail */
        puts("DDS_StringDataWriter_narrow failed.");
        goto clean_exit;
    }

    /* --- Write Data ----------------------------------------------------- */

    puts("Ready to write data.");
    puts("When the subscriber is ready, you can start writing.");
    puts("Press CTRL+C to terminate or enter an empty line to do a clean shutdown.");
    puts("");
    /* RTI provides APIs for detecting when data readers and data writers
     * join the network. You can also configure data durability so that data
     * readers can receive data that were written before they started.
     * However, for the sake of keeping this example as simple as possible,
     * it asks you to wait for both sides to start before continuing.
     */

    for (;;) {
        printf("Please type a message> ");
        if (fgets(sample, MAX_STRING_SIZE-1, stdin) == NULL) {
            break;
        }
        /* Removes the newline from input string */
        sample[strlen(sample)-1] = '\0';
        retcode = DDS_StringDataWriter_write(
                            string_writer, 
                            sample,
                            &DDS_HANDLE_NIL);
        if (retcode != DDS_RETCODE_OK) {
            printf("Write failed: %d\n", retcode);
        }
        if (strlen(sample) == 0) {
            break;
        }
    }

    /* --- Clean Up ------------------------------------------------------- */

    main_result = 0;
clean_exit:
    puts("Exiting...");
    if (participant != NULL) {
        retcode = DDS_DomainParticipant_delete_contained_entities(
                        participant);
        if (retcode != DDS_RETCODE_OK) {
            puts("Deletion failed.");
            main_result = 1;
        }
        retcode = DDS_DomainParticipantFactory_delete_participant(
                        DDS_TheParticipantFactory,
                        participant);
        if (retcode != DDS_RETCODE_OK) {
            puts("Deletion failed.");
            main_result = 1;
        }
    }
    return main_result;
}

