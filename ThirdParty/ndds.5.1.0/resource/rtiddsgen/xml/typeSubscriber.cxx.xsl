<?xml version="1.0"?>

<!-- 
/* $Id: typeSubscriber.cxx.xsl,v 1.5 2012/04/23 16:44:18 fernando Exp $
/* $Id: typeSubscriber.cxx.xsl,v 1.5 2012/04/23 16:44:18 fernando Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2005.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
Modification history:
- - - - - - - - - - - 
1.0l,29feb12,yy  Fixed RTI-346
1.0 ,23feb11,vtg Added Vx653 support
10ae,22nov10,fcs Added dataWriterSuffix
1.0l,25may10,yy  Added warning message about disabling UDPv4 if metp
10ae,26feb10,fcs Sequence suffix support
1.0l,18feb09,fcs Replaced NDDS_QOS_PROFILES with USER_QOS_PROFILES
1.0l,21nov08,fcs Namespace support
1.0l,10nov08,fb  Removed check if new operator on the reader listener return
                 NULL. new() never return NULL, if out of memory it throws
                 std::bad_alloc instead.
1.0l,21oct08,fcs Removed database option
1.0l,21oct08,fcs QoS Profiles support
1.0l,04aug08,ao  corrected typos
1.0l,16jul08,tk  Removed utils.xsl
1.0l,23oct07,vtg Changed order of includes to make corba applications build on 
                 Windows.
1.0l,17feb07,eys Added TypeSupport_finalize to cleanup memory in use
1.0l,15sep06,ch  Replaced RTI_RTP with __RTP__
1.0l,07sep06,eys Fixed paramter parsing for CE
1.0l,16aug06,vtg Changed WinMain to wmain for Windows CE
1.0l,31jul06,vtg Ported to Windows CE: Added WinMain
1.0h,10may06,eys Replaced %%archName%% with <arch>
1.0l,22mar06,fcs DDSQL support
1.0h,20dec05,fcs Added corbaHeader param       
1.0h,20dec05,fcs Removed extra definition of module template        
1.0h,14dec05,fcs C++ namespaces support        
1.0h,14dec05,fcs Redefinition of module template to work with C++
                 namespaces
1.0g,26oct05,eys added delete_contained_entities()
1.0f,12oct05,rj  Merged changes from BRANCH_NDDS40GAR
1.0g,01sep05,rj  Using default participant index
1.0g,29aug05,eys Fixed receive_period
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
1.0g,26jul05,fcs Fixed identation in the XSL template
1.0g,26jul05,fcs Code is generated only for the last less deep top level structure/union
1.0g,22jul05,fcs Ignored copy directives for the example code
1.0g,22jul05,rj  Transitioned to string based addressing. Now supports any number
		 of peer descriptor strings on the command line. Effectively
                 generates an "nddsping" for the user data.
1.0g,10jul05,eys Renamed on_subscription_match to on_subscription_matched
1.0g,30jun05,eys Fixed sleep
GAR,15jun05,rj  Now using NDDS_Transport_Address_from_string()
10g,13jun05,eys Fixed bub 10414. Removed copyright notice
1.0f,06may05,jml Bug #9333 Foo::type_name() renamed as Foo::get_type_name() 
1.0f,02apr05,eys Fixed bug 9595. Added narrow() method to DataReader
10d,23mar05,eys Cleanup example code after code review
10f,23mar05,hoc Added a commented block containing usage of participant factory
                 finalize_instance
10d,18mar05,eys Check for valid data before printing
                Replace tab with space
10d,01mac05,eys Fixed error message
10d,09feb05,rw  Peer participants are no longer referred to in terms of
                "locators"
1.0e,04feb05,eys Updated template to latest transport API
1.0e,27jan05,hhw Transport-Plugin refactoring phase II.
1.0e,03jan05,hhw Updated for transport plugin refactor.
10e,14dec04,hoc Added deletion example
10d,29nov04,rj  Updated for refactored DiscoveryQosPolicy
10c,30nov04,eys Changed from RTINetioAddress_getIpv4AddressByName() to
                RTINetioIp_stringToAddress()
10c,16jun04,eys Fixed statement unreachable warning on integrity.
10c,14jun04,eys Use different default participant index for pub and sub
                Changed printf to RTILog_debug
10c,10jun04,eys Check compilation
1.0d,10jun04,eys Renamed DataType to TypeSupport
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

<xsl:param name="corbaHeader"/>        
<xsl:param name="useQosProfile"/>
<xsl:param name="typeSeqSuffix"/>
<xsl:param name="dataReaderSuffix"/>
<xsl:param name="metp"/>

<xsl:include href="typeCommon.c.xsl"/>

<xsl:output method="text"/>

<xsl:template match="/">
	<xsl:apply-templates/>
</xsl:template>

<!-- Refedefinition of module template to work with C++ namespaces -->
<xsl:template match="module">
    <xsl:param name="containerNamespace"/>
        
    <xsl:variable name="newNamespace">
        <xsl:choose>
            <xsl:when test="$language='C' or ($namespace='no' and $corbaHeader ='none')">                    
                <xsl:value-of select="concat($containerNamespace, @name, '&namespaceSeperator;')"/>
            </xsl:when>                
            <xsl:otherwise>                    
                <xsl:value-of select="concat($containerNamespace, @name,'::')"/>                    
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
                       
    <xsl:apply-templates>
        <xsl:with-param name="containerNamespace" select="$newNamespace"/>
    </xsl:apply-templates>                
</xsl:template>
                        
<xsl:template match="struct">
    <xsl:param name="containerNamespace"/>
    <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace, @name)"/>

    <xsl:variable name="fullyQualifiedStructNameC">
        <xsl:choose>
            <xsl:when test="$language='C' or ($namespace='no' and $corbaHeader ='none')">
                <xsl:value-of select="$fullyQualifiedStructName"/>                       
            </xsl:when>                         
            <xsl:otherwise>
                <xsl:for-each select="./ancestor::module">
                    <xsl:value-of select="@name"/>
                    <xsl:text>_</xsl:text>        
                </xsl:for-each>
                <xsl:value-of select="@name"/>
            </xsl:otherwise>                  
        </xsl:choose>                
    </xsl:variable>    

    <xsl:variable name="ddsPrefixWithUnder">
        <xsl:if test="$namespace='no'">DDS_</xsl:if>
    </xsl:variable>

    <xsl:variable name="ddsPrefix">
        <xsl:if test="$namespace='no'">DDS</xsl:if>
    </xsl:variable>
        
    <xsl:variable name="replacementMap">
	<map nativeType="{$fullyQualifiedStructName}" nativeTypeC="{$fullyQualifiedStructNameC}" IDLFileBaseName="{$idlFileBaseName}" archName="{$archName}"
             ddsPrefix="{$ddsPrefix}" ddsPrefixWithUnder="{$ddsPrefixWithUnder}" typeSeqSuffix="{$typeSeqSuffix}" dataReaderSuffix="{$dataReaderSuffix}" coreProduct="{$coreProduct}"/>
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

<xsl:text><![CDATA[/* %%IDLFileBaseName%%_subscriber.cxx

   A subscription example

   This file is derived from code automatically generated by the rtiddsgen 
   command:

   rtiddsgen -language C++ -example <arch> %%IDLFileBaseName%%.idl

   Example subscription of type %%nativeType%% automatically generated by 
   'rtiddsgen'. To test them follow these steps:

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
                          
       On Unix: 
       
       objs/<arch>/%%IDLFileBaseName%%_publisher <domain_id> 
       objs/<arch>/%%IDLFileBaseName%%_subscriber <domain_id> 
                            
       On Windows:
       
       objs\<arch>\%%IDLFileBaseName%%_publisher <domain_id>  
       objs\<arch>\%%IDLFileBaseName%%_subscriber <domain_id>   
              
       
modification history
------------ -------       
*/

#include <stdio.h>
#include <stdlib.h>
#ifdef RTI_VX653
#include <vThreadsData.h>
#endif
#include "%%IDLFileBaseName%%.h"
#include "%%IDLFileBaseName%%Support.h"
#include "ndds/ndds_cpp.h"
]]></xsl:text>
<xsl:if test="$namespace='yes'">
#include "ndds/ndds_namespace_cpp.h"

using namespace DDS;
</xsl:if>
<xsl:text><![CDATA[
class %%nativeTypeC%%Listener : public %%ddsPrefix%%DataReaderListener {
  public:
    virtual void on_requested_deadline_missed(
        %%ddsPrefix%%DataReader* /*reader*/,
        const %%ddsPrefixWithUnder%%RequestedDeadlineMissedStatus& /*status*/) {}
    
    virtual void on_requested_incompatible_qos(
        %%ddsPrefix%%DataReader* /*reader*/,
        const %%ddsPrefixWithUnder%%RequestedIncompatibleQosStatus& /*status*/) {}
    
    virtual void on_sample_rejected(
        %%ddsPrefix%%DataReader* /*reader*/,
        const %%ddsPrefixWithUnder%%SampleRejectedStatus& /*status*/) {}

    virtual void on_liveliness_changed(
        %%ddsPrefix%%DataReader* /*reader*/,
        const %%ddsPrefixWithUnder%%LivelinessChangedStatus& /*status*/) {}

    virtual void on_sample_lost(
        %%ddsPrefix%%DataReader* /*reader*/,
        const %%ddsPrefixWithUnder%%SampleLostStatus& /*status*/) {}

    virtual void on_subscription_matched(
        %%ddsPrefix%%DataReader* /*reader*/,
        const %%ddsPrefixWithUnder%%SubscriptionMatchedStatus& /*status*/) {}

    virtual void on_data_available(%%ddsPrefix%%DataReader* reader);
};

void %%nativeTypeC%%Listener::on_data_available(%%ddsPrefix%%DataReader* reader)
{
    %%nativeType%%%%dataReaderSuffix%% *%%nativeTypeC%%_reader = NULL;
    %%nativeType%%%%typeSeqSuffix%% data_seq;
    %%ddsPrefixWithUnder%%SampleInfoSeq info_seq;
    %%ddsPrefixWithUnder%%ReturnCode_t retcode;
    int i;

    %%nativeTypeC%%_reader = %%nativeType%%%%dataReaderSuffix%%::narrow(reader);
    if (%%nativeTypeC%%_reader == NULL) {
        printf("DataReader narrow error\n");
        return;
    }

    retcode = %%nativeTypeC%%_reader->take(
        data_seq, info_seq, %%ddsPrefixWithUnder%%LENGTH_UNLIMITED,
        %%ddsPrefixWithUnder%%ANY_SAMPLE_STATE, %%ddsPrefixWithUnder%%ANY_VIEW_STATE, %%ddsPrefixWithUnder%%ANY_INSTANCE_STATE);

    if (retcode == %%ddsPrefixWithUnder%%RETCODE_NO_DATA) {
        return;
    } else if (retcode != %%ddsPrefixWithUnder%%RETCODE_OK) {
        printf("take error %d\n", retcode);
        return;
    }

    for (i = 0; i < data_seq.length(); ++i) {
        if (info_seq[i].valid_data) {
            %%nativeType%%TypeSupport::print_data(&data_seq[i]);
        }
    }

    retcode = %%nativeTypeC%%_reader->return_loan(data_seq, info_seq);
    if (retcode != %%ddsPrefixWithUnder%%RETCODE_OK) {
        printf("return loan error %d\n", retcode);
    }
}

/* Delete all entities */
static int subscriber_shutdown(
    %%ddsPrefix%%DomainParticipant *participant)
{
    %%ddsPrefixWithUnder%%ReturnCode_t retcode;
    int status = 0;

    if (participant != NULL) {
        retcode = participant->delete_contained_entities();
        if (retcode != %%ddsPrefixWithUnder%%RETCODE_OK) {
            printf("delete_contained_entities error %d\n", retcode);
            status = -1;
        }

        retcode = %%ddsPrefix%%TheParticipantFactory->delete_participant(participant);
        if (retcode != %%ddsPrefixWithUnder%%RETCODE_OK) {
            printf("delete_participant error %d\n", retcode);
            status = -1;
        }
    }

    /* %%coreProduct%% provides the finalize_instance() method on
       domain participant factory for people who want to release memory used
       by the participant factory. Uncomment the following block of code for
       clean destruction of the singleton. */
/*
    retcode = %%ddsPrefix%%DomainParticipantFactory::finalize_instance();
    if (retcode != %%ddsPrefixWithUnder%%RETCODE_OK) {
        printf("finalize_instance error %d\n", retcode);
        status = -1;
    }
*/
    return status;
}

extern "C" int subscriber_main(int domainId, int sample_count)
{
    %%ddsPrefix%%DomainParticipant *participant = NULL;
    %%ddsPrefix%%Subscriber *subscriber = NULL;
    %%ddsPrefix%%Topic *topic = NULL;
    %%nativeTypeC%%Listener *reader_listener = NULL; 
    %%ddsPrefix%%DataReader *reader = NULL;
    %%ddsPrefixWithUnder%%ReturnCode_t retcode;
    const char *type_name = NULL;
    int count = 0;
    %%ddsPrefixWithUnder%%Duration_t receive_period = {4,0};
    int status = 0;
]]></xsl:text>
    <xsl:if test="$useQosProfile = 'no'">
    /* To customize the participant QoS, use 
       %%ddsPrefix%%TheParticipantFactory->get_default_participant_qos() */
    </xsl:if>
    <xsl:if test="$useQosProfile = 'yes'">
    /* To customize the participant QoS, use 
       the configuration file USER_QOS_PROFILES.xml */
    </xsl:if>
<xsl:text><![CDATA[participant = %%ddsPrefix%%TheParticipantFactory->create_participant(
        domainId, %%ddsPrefixWithUnder%%PARTICIPANT_QOS_DEFAULT, 
        NULL /* listener */, %%ddsPrefixWithUnder%%STATUS_MASK_NONE);
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
    /* To customize the subscriber QoS, use
       participant->get_default_subscriber_qos() */
    </xsl:if>
    <xsl:if test="$useQosProfile = 'yes'">
    /* To customize the subscriber QoS, use 
       the configuration file USER_QOS_PROFILES.xml */
    </xsl:if>
<xsl:text><![CDATA[subscriber = participant->create_subscriber(
        %%ddsPrefixWithUnder%%SUBSCRIBER_QOS_DEFAULT, NULL /* listener */, %%ddsPrefixWithUnder%%STATUS_MASK_NONE);
    if (subscriber == NULL) {
        printf("create_subscriber error\n");
        subscriber_shutdown(participant);
        return -1;
    }

    /* Register the type before creating the topic */
    type_name = %%nativeType%%TypeSupport::get_type_name();
    retcode = %%nativeType%%TypeSupport::register_type(
        participant, type_name);
    if (retcode != %%ddsPrefixWithUnder%%RETCODE_OK) {
        printf("register_type error %d\n", retcode);
        subscriber_shutdown(participant);
        return -1;
    }
]]></xsl:text>
    <xsl:if test="$useQosProfile = 'no'">
    /* To customize the topic QoS, use
       participant->get_default_topic_qos() */
    </xsl:if>
    <xsl:if test="$useQosProfile = 'yes'">
    /* To customize the topic QoS, use 
       the configuration file USER_QOS_PROFILES.xml */
    </xsl:if>
<xsl:text><![CDATA[topic = participant->create_topic(
        "Example %%nativeType%%",
        type_name, %%ddsPrefixWithUnder%%TOPIC_QOS_DEFAULT, NULL /* listener */,
        %%ddsPrefixWithUnder%%STATUS_MASK_NONE);
    if (topic == NULL) {
        printf("create_topic error\n");
        subscriber_shutdown(participant);
        return -1;
    }

    /* Create a data reader listener */
    reader_listener = new %%nativeTypeC%%Listener();
]]></xsl:text>
    <xsl:if test="$useQosProfile = 'no'">
    /* To customize the data reader QoS, use
       subscriber->get_default_datareader_qos() */
    </xsl:if>
    <xsl:if test="$useQosProfile = 'yes'">
    /* To customize the data reader QoS, use 
       the configuration file USER_QOS_PROFILES.xml */
    </xsl:if>
<xsl:text><![CDATA[reader = subscriber->create_datareader(
        topic, %%ddsPrefixWithUnder%%DATAREADER_QOS_DEFAULT, reader_listener,
        %%ddsPrefixWithUnder%%STATUS_MASK_ALL);
    if (reader == NULL) {
        printf("create_datareader error\n");
        subscriber_shutdown(participant);
        delete reader_listener;
        return -1;
    }

    /* Main loop */
    for (count=0; (sample_count == 0) || (count < sample_count); ++count) {

        printf("%%nativeType%% subscriber sleeping for %d sec...\n",
               receive_period.sec);

        NDDSUtility::sleep(receive_period);
    }

    /* Delete all entities */
    status = subscriber_shutdown(participant);
    delete reader_listener;

    return status;
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
    NDDSConfigLogger::get_instance()->
        set_verbosity_by_category(NDDS_CONFIG_LOG_CATEGORY_API, 
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
    NDDSConfigLogger::get_instance()->
        set_verbosity_by_category(NDDS_CONFIG_LOG_CATEGORY_API, 
                                  NDDS_CONFIG_LOG_VERBOSITY_STATUS_ALL);
    */
                                  
    return subscriber_main(domainId, sample_count);
}
#endif

#ifdef RTI_VX653
const unsigned char* __ctype = *(__ctypePtrGet());

extern "C" void usrAppInit ()
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
