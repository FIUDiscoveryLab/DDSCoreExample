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

static void on_data_available_callback(void*, DDS_DataReader*);

DDS_Boolean shutdown_flag = DDS_BOOLEAN_FALSE;

int main() {
    DDS_DomainParticipant *       participant = NULL;
    DDS_Topic *                   topic = NULL;
    DDS_DataReader *              data_reader = NULL;
    struct DDS_DataReaderListener listener = DDS_DataReaderListener_INITIALIZER;
    DDS_ReturnCode_t              retcode;
    int                           main_result = 1; /* error by default */

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
    
    /* Create the data reader using the default publisher */
    listener.on_data_available = on_data_available_callback;
    data_reader = DDS_DomainParticipant_create_datareader(
                        participant,
                        DDS_Topic_as_topicdescription(topic),
                        &DDS_DATAREADER_QOS_DEFAULT,    /* QoS */
                        &listener,                      /* Listener */
                        DDS_DATA_AVAILABLE_STATUS);
    if (data_reader == NULL) {
        puts("Unable to create data reader.");
        goto clean_exit;
    }
    
    /* --- Sleep During Asynchronous Reception ---------------------------- */

    /* This thread sleeps forever. When a sample is received, RTI Data
     * Distribution Service will call the on_data_available_callback function.
     */
    puts("Ready to read data.");
    puts("Press CTRL+C to terminate.");
    for (;;) {
#ifdef RTI_WIN32
        Sleep(2000);
#else
        sleep(2);
#endif
        if(shutdown_flag){
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

/* on_data_available_callback
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~
 * This is the callback function that is invoked by RTI Connext whenever a new sample is received.
 */
static void on_data_available_callback(void *listener_data /* unused */, 
                                       DDS_DataReader* data_reader) {
    DDS_StringDataReader *string_reader = NULL;
    char                  sample[MAX_STRING_SIZE]; 
    struct DDS_SampleInfo info;
    DDS_ReturnCode_t      retcode;

    /* Perform a safe type-cast from a generic data reader into a
     * specific data reader for the type "DDS::String"
     */
    string_reader = DDS_StringDataReader_narrow(data_reader);
    if (string_reader == NULL) {
        /* In this specific case, this will never fail */
        puts("DDS_StringDataReader_narrow failed.");
        return;
    }
    /* Loop until there are messages available in the queue */
    for(;;) {
        retcode = DDS_StringDataReader_take_next_sample(
                            string_reader,
                            sample,
                            &info);
        if (retcode == DDS_RETCODE_NO_DATA) {
            /* No more samples */
            break;
        } else if (retcode != DDS_RETCODE_OK) {
            printf("Unable to take data from data reader, error %d\n", retcode);
            return;
        }
        if (info.valid_data) {
            /* Data is valid (this isn't just a lifecycle sample): print it */
            puts(sample);
            /* If empty string is received, clean shutdown*/
            if(strlen(sample) == 0){
                shutdown_flag = DDS_BOOLEAN_TRUE;	
            }
        }
    }
}



