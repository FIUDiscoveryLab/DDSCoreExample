/* HelloWorld_publisher.cxx

   A publication of data of type HelloWorld   

       
modification history
------------ -------       
*/

#include <stdio.h>
#include <stdlib.h>
#ifdef RTI_VX653
#include <vThreadsData.h>
#endif

#include "ndds/ndds_cpp.h"
#include "HelloWorldSupport.h"

/* Delete all entities */
int publisherShutdown(
    DDSDomainParticipant * participant) {
    DDS_ReturnCode_t retCode;
    int status = 0;

    if (participant != NULL) {
        retCode = participant->delete_contained_entities();
        if (retCode != DDS_RETCODE_OK) {
            printf("delete_contained_entities error %d\n", retCode);
            status = -1;
        }

        retCode = DDSTheParticipantFactory->delete_participant(participant);
        if (retCode != DDS_RETCODE_OK) {
            printf("delete_participant error %d\n", retCode);
            status = -1;
        }
    }

    /* RTI Connext provides finalize_instance() method on
       domain participant factory for people who want to release memory used
       by the participant factory. Uncomment the following block of code for
       clean destruction of the singleton. */
/*
    retcode = DDSDomainParticipantFactory::finalize_instance();
    if (retcode != DDS_RETCODE_OK) {
        printf("finalize_instance error %d\n", retcode);
        status = -1;
    }
*/

    return status;
}

int publisherMain(int sampleCount) {
    DDS_ReturnCode_t retCode;
    int count = 0;  
    DDS_Duration_t sendPeriod = {4,0};

    /* type registration */
    retCode = DDSTheParticipantFactory->register_type_support(
                                        HelloWorldTypeSupport::register_type, 
                                        "HelloWorldType");
    if (retCode != DDS_RETCODE_OK) {
        printf("register_type_support %d\n", retCode);
        publisherShutdown(NULL);
        return -1;
    }
    
    /* To customize participant QoS, use 
       the configuration file USER_QOS_PROFILES.xml */   
    DDSDomainParticipant * participant = DDSTheParticipantFactory->
            create_participant_from_config("MyParticipantLibrary::PublicationParticipant");
    if (participant == NULL) {
        printf("create_participant_from_config error\n");
        publisherShutdown(participant);
        return -1;
    }
    
    HelloWorldDataWriter * helloWorldWriter = HelloWorldDataWriter::narrow(
            participant->lookup_datawriter_by_name(
                                      "MyPublisher::HelloWorldWriter"));    
    if (helloWorldWriter == NULL) {
        printf("lookup_datawriter_by_name error\n");
        publisherShutdown(participant);
        return -1;
    }
    
    HelloWorld * helloWorldData = HelloWorldTypeSupport::create_data();   
    if (helloWorldData == NULL) {
        printf("HelloWorldTypeSupport_create_data error\n");
        publisherShutdown(participant);
        return -1;
    }
            
    /* Main loop */
    for (count=0; (sampleCount == 0) || (count < sampleCount); ++count) {
        printf("Writing HelloWorld, count: %d\n", count);

        /* Set the data fields */
		strncpy(helloWorldData->sender,  "John Smith", MAX_NAME_LEN); 
		strncpy(helloWorldData->message, "Hello World!", MAX_MSG_LEN); 
		helloWorldData->count   = count; 

        retCode = helloWorldWriter->write(*helloWorldData, DDS_HANDLE_NIL);
        if (retCode != DDS_RETCODE_OK) {
            printf("write error %d\n", retCode);
            publisherShutdown(participant);
            return -1;
        }
        
        NDDSUtility::sleep(sendPeriod);
    }

    /* Delete data sample */
    HelloWorldTypeSupport::delete_data(helloWorldData);

    /* Delete all entities */
    return publisherShutdown(participant);
}
 
int main(int argc, char *argv[])
{
    int sampleCount = 0; /* infinite loop */   
    
    if (argc >= 2) {
        sampleCount = atoi(argv[1]);
    }

    /* Uncomment this to turn on additional logging
    NDDSConfigLogger::get_instance()->
        set_verbosity_by_category(NDDS_CONFIG_LOG_CATEGORY_API, 
                                  NDDS_CONFIG_LOG_VERBOSITY_STATUS_ALL);
    */
    
    return publisherMain(sampleCount);
}

