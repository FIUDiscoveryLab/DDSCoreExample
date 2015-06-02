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

/* Delete all entities */
static int publisherShutdown(
    DDSDomainParticipant * participant)
{
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
    
    /* Release memory associated with participant factory */
    retCode = DDSDomainParticipantFactory::finalize_instance();
    if (retCode != DDS_RETCODE_OK) {
        printf("finalize_instance error %d\n", retCode);
        status = -1;
    }

    return status;
}

extern "C" int publisherMain(int sampleCount)
{
    DDS_ReturnCode_t retCode;
    int count = 0;  
    DDS_Duration_t sendPeriod = {4,0};
    DDS_ReturnCode_t lastSetError = DDS_RETCODE_OK;

    /* To customize participant QoS, use 
       the configuration file USER_QOS_PROFILES.xml */    
    DDSDomainParticipant * participant = DDSTheParticipantFactory->
            create_participant_from_config(
                                "MyParticipantLibrary::PublicationParticipant");
    if (participant == NULL) {
        printf("create_participant_from_config error\n");
        publisherShutdown(participant);
        return -1;
    }
    
    DDSDynamicDataWriter * dynamicWriter = DDSDynamicDataWriter::narrow(
            participant->lookup_datawriter_by_name(
                                      "MyPublisher::HelloWorldWriter"));    
    if (dynamicWriter == NULL) {
        printf("lookup_datawriter_by_name error\n");
        publisherShutdown(participant);
        return -1;
    }
    
    DDS_DynamicData * dynamicData = 
            dynamicWriter->create_data(DDS_DYNAMIC_DATA_PROPERTY_DEFAULT);
    if (dynamicData == NULL) {
        printf("create_data error\n");
        publisherShutdown(participant);
        return -1;
    }    
       
    /* Main loop */
    for (count=0; (sampleCount == 0) || (count < sampleCount); ++count) {
        printf("Writing HelloWorld, count: %d\n", count);
        
        /* Set the data fields */
        retCode = dynamicData->set_string("sender", 
                                         DDS_DYNAMIC_DATA_MEMBER_ID_UNSPECIFIED, 
                                         "John Smith");
        if ( retCode != DDS_RETCODE_OK) { lastSetError = retCode; }
 
        retCode = dynamicData->set_string("message", 
                                         DDS_DYNAMIC_DATA_MEMBER_ID_UNSPECIFIED, 
                                         "Hello World!");
        if ( retCode != DDS_RETCODE_OK) { lastSetError = retCode; }
 
        retCode = dynamicData->set_long("count", 
                                   DDS_DYNAMIC_DATA_MEMBER_ID_UNSPECIFIED, 
                                   count);
        if ( retCode != DDS_RETCODE_OK) { lastSetError = retCode; }


        if ( lastSetError != DDS_RETCODE_OK ) {            
            printf("Error setting dynamic data: %d\n", lastSetError);
            publisherShutdown(participant);
            return -1;
        }                
       
        retCode = dynamicWriter->write(*dynamicData, DDS_HANDLE_NIL);
        if (retCode != DDS_RETCODE_OK) {
            printf("write error %d\n", retCode);
            publisherShutdown(participant);
            return -1;
        }        

        NDDSUtility::sleep(sendPeriod);
    }

    /* Delete data sample */
    dynamicWriter->delete_data(dynamicData);

    /* Delete all entities */
    return publisherShutdown(participant);
}

 
int main(int argc, char *argv[]){

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


