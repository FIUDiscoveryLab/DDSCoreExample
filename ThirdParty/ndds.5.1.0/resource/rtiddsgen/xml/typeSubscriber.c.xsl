<?xml version="1.0"?>

<!-- 
/* $Id: typeSubscriber.c.xsl,v 1.4 2012/04/23 16:44:18 fernando Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
Modification history:
- - - - - - - - - - -
1.0 ,23feb11,vtg Added Vx653 support
1.0l,25may10,yy  Added warning message about disabling UDPv4 if metp
1.0l,18feb09,fcs Replaced NDDS_QOS_PROFILES with USER_QOS_PROFILES
1.0l,21oct08,fcs Removed database option
1.0l,21oct08,fcs QoS Profiles support
1.0l,04aug08,ao  corrected typos
1.0l,16jul08,tk  Removed utils.xsl (moved to common)
1.0l,17feb07,eys Added TypeSupport_finalize to cleanup memory in use
1.0l,15sep06,ch  Replaced RTI_RTP with __RTP__
1.0l,07sep06,eys Fixed paramter parsing for CE
1.0l,16aug06,vtg Changed WinMain to wmain for Windows CE
1.0l,31jul06,vtg Ported to Windows CE: Added WinMain
1.0l,10may06,eys Replaced %%archName%% with <arch>
1.0l,22mar06,fcs DDSQL support
1.0g,26oct05,eys added delete_contained_entities()
1.0f,12oct05,rj  Merged changes from BRANCH_NDDS40GAR
1.0h,28aug05,rj  Simplifiled code. No longer need participant_index.
1.0h,24aug05,eys Fixed indentation
1.0h,24aug05,fcs Removed initial blank lines
1.0h,24aug05,fcs Removed NDDS_EXAMPLE_DEFINED
1.0h,23aug05,rj  Removed initial_peer command line arguments.
1.0h,22aug05,fcs Added new line at the end of the generated code
1.0h,19aug05,rj  Since VxWorks command line allows ommitting the trailing arguments
		 to a method, and these may not be initialized to 0, we access 
                 initial_peers only if initial_peers_length > 0.
1.0h,19aug05,rj  Changed the _main() arg ordering to better support VxWorks
1.0h,10aug05,rj  Updated instructions on running the app.
1.0g,27jul05,rj  Removed PeerDescriptionX
1.0g,26jul05,fcs Fixed identation in the XSL template
1.0g,26jul05,fcs Code is generated only for the last less deep top level structure/union
1.0g,22jul05,fcs Ignored copy directives for the example code
1.0g,22jul05,rj  Transitioned to string based addressing. Now supports any number
		 of peer descriptor strings on the command line. Fixed cleanup.
                 Effectively generates an "nddsping" for the user data.
1.0g,19jul05,eys duration is passed as pointer to sleep
1.0g,20jul05,jml xxxListener_NEW renamed to xxxListener_INITIALIZER
1.0g,20jul05,jml _NEW constants now are #defines called _INITIALIZER for qos and
                 statuses. Modified also the initialize methods.
1.0g,10jul05,eys Renamed on_subscription_match to on_subscription_matched
1.0g,09jul05,jml Fixed bug #9338. See bugzilla for details.
1.0g,30jun05,eys Fixed sleep
GAR,15jun05,rj  Now using NDDS_Transport_Address_from_string()
10g,13jun05,eys Fixed bub 10414. Removed copyright notice
1.0f,02jun05,jml Bug #9621: Initialize/Copy/Finalize Bug
1.0f,06may05,jml Bug #9333 Foo::type_name() renamed as Foo::get_type_name()
1.0f,02apr05,eys Fixed bug 9595. Added narrow() method to DataReader
10d,01apr05,eys Fixed bug 9104. Listener initializer is changed.
10d,23mar05,eys Cleanup example code after code review
23mar05,hoc Added a commented block containing usage of participant factory
            finalize_instance
10d,18mar05,eys Check for valid data before printing, check return code,
                replace tab with space
10d,01mac05,eys Fixed error message
10d,11feb05,rw  Renamed DDS_Topic supertype accessor
10d,09feb05,rw  Peer participants are no longer referred to in terms of
                "locators"
1.0e,04feb05,eys Updated template to latest transport API
1.0e,27jan05,hhw Transport-Plugin refactoring phase II.
1.0e,03jan05,hhw Updated for transport plugin refactor.
10e,14dec04,hoc Added deletion code
10d,29nov04,rj  Updated for refactored DiscoveryQosPolicy
10c,30nov04,eys Changed from RTINetioAddress_getIpv4AddressByName() to
                RTINetioIp_stringToAddress()
10c,16jun04,eys Fixed statement unreachable warning on integrity.
10c,14jun04,eys Use different default participant index for pub and sub.
                Changed printf to RTILog_debug
10c,10jun04,eys Check compilation
10c,10jun04,eys Renamed DataType to TypeSupport
10a,10may04,hcs copied from C++ to create c example
10c,14apr04,eys take() and return_loan() API changes
10c,14apr04,eys New callbacks are added to DataReaderListener
10c,05apr04,eys peer is a keyword in C. Use c-style comment. QoS name change.
10c,09feb04,sjr Integrated newly refactored dds_c and dds_cpp.
40a,06sep03,rrl Created for resource/CPP/subscriber_template
-->

<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
<!ENTITY namespaceSeperator "_">    <!-- namespace separator -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
				xmlns:xalan="http://xml.apache.org/xalan" version="1.0">

<xsl:include href="typeCommon.c.xsl"/>
<xsl:param name="useQosProfile"/>
<xsl:param name="metp"/>

<xsl:output method="text"/>

<xsl:template match="/">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="struct">
	<xsl:param name="containerNamespace"/>
	<xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace, @name)"/>

	<xsl:variable name="replacementMap">
		<map nativeType="{$fullyQualifiedStructName}" IDLFileBaseName="{$idlFileBaseName}" archName="{$archName}" coreProduct="{$coreProduct}"/>
	</xsl:variable>
    
    <xsl:variable name="lastTopLevel">
        <xsl:call-template name="isLastLessDeepTopLevelType">
            <xsl:with-param name="typeNode" select="."/>
        </xsl:call-template>        
    </xsl:variable>
    
    <xsl:if test="$lastTopLevel = 'yes'">
        
        <xsl:call-template name="replace-string-from-map">
            <xsl:with-param name="search" select="'%%nativeType%%'"/>
	    <xsl:with-param name="replacementParamsMap" select="xalan:nodeset($replacementMap)/node()"/>                
            <!-- The template for Support of each struct -->
            <xsl:with-param name="inputString">

<xsl:text><![CDATA[/* %%IDLFileBaseName%%_subscriber.c

   A subscription example

   This file is derived from code automatically generated by the rtiddsgen 
   command:

   rtiddsgen -language C -example <arch> %%IDLFileBaseName%%.idl

   Example subscription of type %%nativeType%% automatically generated by 
   'rtiddsgen'. To test them, follow these steps:

   (1) Compile this file and the example publication.

   (2) Start the subscription with the command
       objs/<arch>/%%IDLFileBaseName%%_subscriber <domain_id> <sample_count>

   (3) Start the publication with the command
       objs/<arch>/%%IDLFileBaseName%%_publisher <domain_id> <sample_count>

   (4) [Optional] Specify the list of discovery initial peers and 
       multicast receive addresses via an environment variable or a file 
       (in the current working directory) called NDDS_DISCOVERY_PEERS. 
       
   You can run any number of publishers and subscribers programs, and can 
   add and remove them dynamically from the domain.
              
                                   
   Example:
        
       To run the example application on domain <domain_id>:
                          
       On UNIX systems: 
       
       objs/<arch>/%%IDLFileBaseName%%_publisher <domain_id> 
       objs/<arch>/%%IDLFileBaseName%%_subscriber <domain_id> 
                            
       On Windows systems:
       
       objs\<arch>\%%IDLFileBaseName%%_publisher <domain_id>  
       objs\<arch>\%%IDLFileBaseName%%_subscriber <domain_id>   
       
       
modification history
------------ -------       
*/

#include <stdio.h>
#include <stdlib.h>
#include "ndds/ndds_c.h"
#include "%%IDLFileBaseName%%.h"
#include "%%IDLFileBaseName%%Support.h"

void %%nativeType%%Listener_on_requested_deadline_missed(
    void* listener_data,
    DDS_DataReader* reader,
    const struct DDS_RequestedDeadlineMissedStatus *status)
{
}

void %%nativeType%%Listener_on_requested_incompatible_qos(
    void* listener_data,
    DDS_DataReader* reader,
    const struct DDS_RequestedIncompatibleQosStatus *status)
{
}

void %%nativeType%%Listener_on_sample_rejected(
    void* listener_data,
    DDS_DataReader* reader,
    const struct DDS_SampleRejectedStatus *status)
{
}

void %%nativeType%%Listener_on_liveliness_changed(
    void* listener_data,
    DDS_DataReader* reader,
    const struct DDS_LivelinessChangedStatus *status)
{
}

void %%nativeType%%Listener_on_sample_lost(
    void* listener_data,
    DDS_DataReader* reader,
    const struct DDS_SampleLostStatus *status)
{
}

void %%nativeType%%Listener_on_subscription_matched(
    void* listener_data,
    DDS_DataReader* reader,
    const struct DDS_SubscriptionMatchedStatus *status)
{
}

void %%nativeType%%Listener_on_data_available(
    void* listener_data,
    DDS_DataReader* reader)
{
    %%nativeType%%DataReader *%%nativeType%%_reader = NULL;
    struct %%nativeType%%Seq data_seq = DDS_SEQUENCE_INITIALIZER;
    struct DDS_SampleInfoSeq info_seq = DDS_SEQUENCE_INITIALIZER;
    DDS_ReturnCode_t retcode;
    int i;

    %%nativeType%%_reader = %%nativeType%%DataReader_narrow(reader);
    if (%%nativeType%%_reader == NULL) {
        printf("DataReader narrow error\n");
        return;
    }

    retcode = %%nativeType%%DataReader_take(
        %%nativeType%%_reader,
        &data_seq, &info_seq, DDS_LENGTH_UNLIMITED,
        DDS_ANY_SAMPLE_STATE, DDS_ANY_VIEW_STATE, DDS_ANY_INSTANCE_STATE);
    if (retcode == DDS_RETCODE_NO_DATA) {
        return;
    } else if (retcode != DDS_RETCODE_OK) {
        printf("take error %d\n", retcode);
        return;
    }

    for (i = 0; i < %%nativeType%%Seq_get_length(&data_seq); ++i) {
        if (DDS_SampleInfoSeq_get_reference(&info_seq, i)->valid_data) {
            %%nativeType%%TypeSupport_print_data(
                %%nativeType%%Seq_get_reference(&data_seq, i));
        }
    }

    retcode = %%nativeType%%DataReader_return_loan(
        %%nativeType%%_reader,
        &data_seq, &info_seq);
    if (retcode != DDS_RETCODE_OK) {
        printf("return loan error %d\n", retcode);
    }
}

/* Delete all entities */
static int subscriber_shutdown(
    DDS_DomainParticipant *participant)
{
    DDS_ReturnCode_t retcode;
    int status = 0;

    if (participant != NULL) {
        retcode = DDS_DomainParticipant_delete_contained_entities(participant);
        if (retcode != DDS_RETCODE_OK) {
            printf("delete_contained_entities error %d\n", retcode);
            status = -1;
        }

        retcode = DDS_DomainParticipantFactory_delete_participant(
            DDS_TheParticipantFactory, participant);
        if (retcode != DDS_RETCODE_OK) {
            printf("delete_participant error %d\n", retcode);
            status = -1;
        }
    }

    /* %%coreProduct%% provides the finalize_instance() method on
       domain participant factory for users who want to release memory used
       by the participant factory. Uncomment the following block of code for
       clean destruction of the singleton. */
/*
    retcode = DDS_DomainParticipantFactory_finalize_instance();
    if (retcode != DDS_RETCODE_OK) {
        printf("finalize_instance error %d\n", retcode);
        status = -1;
    }
*/

    return status;
}

static int subscriber_main(int domainId, int sample_count)
{
    DDS_DomainParticipant *participant = NULL;
    DDS_Subscriber *subscriber = NULL;
    DDS_Topic *topic = NULL;
    struct DDS_DataReaderListener reader_listener =
        DDS_DataReaderListener_INITIALIZER;
    DDS_DataReader *reader = NULL;
    DDS_ReturnCode_t retcode;
    const char *type_name = NULL;
    int count = 0;
    struct DDS_Duration_t poll_period = {4,0};
]]></xsl:text>
    <xsl:if test="$useQosProfile = 'no'">
    /* To customize participant QoS, use 
       DDS_DomainParticipantFactory_get_default_participant_qos() */
    </xsl:if>
    <xsl:if test="$useQosProfile = 'yes'">
    /* To customize participant QoS, use 
       the configuration file USER_QOS_PROFILES.xml */
    </xsl:if>
<xsl:text><![CDATA[participant = DDS_DomainParticipantFactory_create_participant(
        DDS_TheParticipantFactory, domainId, &DDS_PARTICIPANT_QOS_DEFAULT,
        NULL /* listener */, DDS_STATUS_MASK_NONE);
    if (participant == NULL) {
        printf("create_participant error\n");
        subscriber_shutdown(participant);
        return -1;
    }
]]></xsl:text>
<xsl:if test="$metp ='yes'">
    <xsl:text><![CDATA[    
    printf("NOTE: THE QOS PROFILE HAS DISABLED UDPv4 FOR THIS PARTICIPANT\n");
    ]]></xsl:text>
</xsl:if>				
    <xsl:if test="$useQosProfile = 'no'">
    /* To customize subscriber QoS, use
       DDS_DomainParticipant_get_default_subscriber_qos() */
    </xsl:if>
    <xsl:if test="$useQosProfile = 'yes'">
    /* To customize subscriber QoS, use 
       the configuration file USER_QOS_PROFILES.xml */
    </xsl:if>
<xsl:text><![CDATA[subscriber = DDS_DomainParticipant_create_subscriber(
        participant, &DDS_SUBSCRIBER_QOS_DEFAULT, NULL /* listener */,
        DDS_STATUS_MASK_NONE);
    if (subscriber == NULL) {
        printf("create_subscriber error\n");
        subscriber_shutdown(participant);
        return -1;
    }

    /* Register the type before creating the topic */
    type_name = %%nativeType%%TypeSupport_get_type_name();
    retcode = %%nativeType%%TypeSupport_register_type(participant, type_name);
    if (retcode != DDS_RETCODE_OK) {
        printf("register_type error %d\n", retcode);
        subscriber_shutdown(participant);
        return -1;
    }
]]></xsl:text>
    <xsl:if test="$useQosProfile = 'no'">
    /* To customize topic QoS, use
       DDS_DomainParticipant_get_default_topic_qos() */
    </xsl:if>
    <xsl:if test="$useQosProfile = 'yes'">
    /* To customize topic QoS, use 
       the configuration file USER_QOS_PROFILES.xml */
    </xsl:if>
<xsl:text><![CDATA[topic = DDS_DomainParticipant_create_topic(
        participant, "Example %%nativeType%%",
        type_name, &DDS_TOPIC_QOS_DEFAULT, NULL /* listener */,
        DDS_STATUS_MASK_NONE);
    if (topic == NULL) {
        printf("create_topic error\n");
        subscriber_shutdown(participant);
        return -1;
    }

    /* Set up a data reader listener */
    reader_listener.on_requested_deadline_missed  =
        %%nativeType%%Listener_on_requested_deadline_missed;
    reader_listener.on_requested_incompatible_qos =
        %%nativeType%%Listener_on_requested_incompatible_qos;
    reader_listener.on_sample_rejected =
        %%nativeType%%Listener_on_sample_rejected;
    reader_listener.on_liveliness_changed =
        %%nativeType%%Listener_on_liveliness_changed;
    reader_listener.on_sample_lost =
        %%nativeType%%Listener_on_sample_lost;
    reader_listener.on_subscription_matched =
        %%nativeType%%Listener_on_subscription_matched;
    reader_listener.on_data_available =
        %%nativeType%%Listener_on_data_available;
]]></xsl:text>
    <xsl:if test="$useQosProfile = 'no'">
    /* To customize the data reader QoS, use
       DDS_Subscriber_get_default_datareader_qos() */
    </xsl:if>
    <xsl:if test="$useQosProfile = 'yes'">
    /* To customize data reader QoS, use 
       the configuration file USER_QOS_PROFILES.xml */
    </xsl:if>
<xsl:text><![CDATA[reader = DDS_Subscriber_create_datareader(
        subscriber, DDS_Topic_as_topicdescription(topic),
        &DDS_DATAREADER_QOS_DEFAULT, &reader_listener, DDS_STATUS_MASK_ALL);
    if (reader == NULL) {
        printf("create_datareader error\n");
        subscriber_shutdown(participant);
        return -1;
    }

    /* Main loop */
    for (count=0; (sample_count == 0) || (count < sample_count); ++count) {
        printf("%%nativeType%% subscriber sleeping for %d sec...\n",
               poll_period.sec);
        NDDS_Utility_sleep(&poll_period);
    }

    /* Cleanup and delete all entities */ 
    return subscriber_shutdown(participant);
}

#if defined(RTI_WINCE)
int wmain(int argc, wchar_t** argv)
{
    int domainId = 0;
    int sample_count = 0; /* infinite loop */
    
    if (argc >= 2) {
        domainId = _wtoi(argv[1]);
    }
    if (argc >= 3) {
        sample_count = _wtoi(argv[2]);
    }

    /* Uncomment this to turn on additional logging
    NDDS_Config_Logger_set_verbosity_by_category(
        NDDS_Config_Logger_get_instance(),
        NDDS_CONFIG_LOG_CATEGORY_API, 
        NDDS_CONFIG_LOG_VERBOSITY_STATUS_ALL);
    */
    
    return subscriber_main(domainId, sample_count);
}
#elif !(defined(RTI_VXWORKS) && !defined(__RTP__)) && !defined(RTI_PSOS)
int main(int argc, char *argv[])
{
    int domainId = 0;
    int sample_count = 0; /* infinite loop */

    if (argc >= 2) {
        domainId = atoi(argv[1]);
    }
    if (argc >= 3) {
        sample_count = atoi(argv[2]);
    }

    /* Uncomment this to turn on additional logging
    NDDS_Config_Logger_set_verbosity_by_category(
        NDDS_Config_Logger_get_instance(),
        NDDS_CONFIG_LOG_CATEGORY_API, 
        NDDS_CONFIG_LOG_VERBOSITY_STATUS_ALL);
    */
    
    return subscriber_main(domainId, sample_count);
}
#endif

#ifdef RTI_VX653
const unsigned char* __ctype = NULL;

void usrAppInit ()
{
#ifdef  USER_APPL_INIT
    USER_APPL_INIT;         /* for backwards compatibility */
#endif
    
    /* add application specific code here */
    taskSpawn("sub", RTI_OSAPI_THREAD_PRIORITY_NORMAL, 0x8, 0x150000, (FUNCPTR)subscriber_main, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
   
}
#endif
]]></xsl:text>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:if>
</xsl:template>

<!--
Process directives

We ignore the copy directives for the example code
-->
<xsl:template match="directive[@kind = 'copy' or @kind = 'copy-c']">
</xsl:template>

<xsl:template match="directive[@kind = 'copy' or @kind = 'copy-c']"
              mode="code-generation">
</xsl:template>
       
</xsl:stylesheet>
