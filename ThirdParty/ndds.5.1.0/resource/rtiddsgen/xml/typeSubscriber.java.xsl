<?xml version="1.0"?>

<!-- 
/* $Id: typeSubscriber.java.xsl,v 1.4 2012/04/23 16:44:18 fernando Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
Modification history:
- - - - - - - - - - -
10ae,22nov10,fcs Added dataReaderSuffix
10ae,26feb10,fcs Sequence suffix support
1.0l,18feb09,fcs Replaced NDDS_QOS_PROFILES with USER_QOS_PROFILES
1.0l,21oct08,fcs Removed database option
1.0l,21oct08,fcs QoS Profiles support
10p,04aug08,ao  corrected typos
10p,16jul08,tk  Removed utils.xsl
                set output mode to XML instead of text (AIX problem)
10p,31dec07,vtg Made consistent with new type plugin API [First pass]
1.0o,17jul07,la  Added null handling after object creation (bug 11815).
10m,08dec06,fcs Fixed bug 11636
10m,06sep06,eys User is allowed to modify the generated subscriber file
10m,05sep06,krb Updated to properly generate subscriber code when -corba is used.
1.0l,22mar06,fcs DDSQL support
1.0g,22oct05,eys Implemented delete_contained_entities
1.0f,12oct05,rj Merged changes from BRANCH_NDDS40GAR
1.0h,28aug05,rj Simplifiled code. No longer need participant_index.
10h,24aug05,eys Fixed indentation
10h,23aug05,rj  Removed initial_peer command line arguments.
10h,19aug05,rj  Changed the Main() arg ordering to be consistent with C/C++
10h,10aug05,rj  Updated instructions on running the app.
10g,27jul05,rj  Added more detailed instructions on how to run the java example
10g,27jul05,rj  Transitioned to string based addressing. Now supports any number
		of peer descriptor strings on the command line.  Effectively
                generates an "nddsping" for the user data.
10g,26jul05,fcs Code is generated only for the last less deep top level structure/union
10g,26jul05,fcs Fixed identation in the XSL template
10g,13jun05,eys Fixed bub 10414. Removed copyright notice
10f,06may05,jml Bug #9333 Foo::type_name() renamed as Foo::get_type_name()
10e,07apr05,rw  Bug #6693: moved LENGTH_UNLIMITED from DataReader to
                ResourceLimitsQosPolicy
10d,25mar05,fcs Changed the code to print the data. 
                This code has been moved from the plugin code (TypeSupport) to the type class code.
10d,23mar05,eys Cleanup example code after code review
23mar05,hoc Added a commented block containing usage of participant factory
            finalize_instance
10d,09feb05,rw  Peer participants are no longer referred to in terms of
                "locators"
10e,14dec04,hoc Add deletion example
10d,14dec04,rj  Updated for refactored DiscoveryQosPolicy
10c,14jun04,eys Use different default participant index for pub and sub
10c,12may04,rrl Created
-->

<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:xalan="http://xml.apache.org/xalan" version="1.0">

<xsl:include href="typeCommon.java.xsl"/>

<xsl:output method="xml"/>

<xsl:param name="corbaHeader"/>
<xsl:param name="useQosProfile"/>

<xsl:template match="/">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="struct">
    <xsl:param name="containerNamespace"/>
    <xsl:variable name="sourceFile">
        <xsl:call-template name="obtainSourceFileName">
            <xsl:with-param name="containerNamespace" select="$containerNamespace"/>
            <xsl:with-param name="typeName" select="concat(@name, 'Subscriber')"/>
        </xsl:call-template>
    </xsl:variable>    
    
    <xsl:variable name="lastTopLevel">
        <xsl:call-template name="isLastLessDeepTopLevelType">
            <xsl:with-param name="typeNode" select="."/>
        </xsl:call-template>        
    </xsl:variable>

    <xsl:if test="$lastTopLevel = 'yes'">
            
<file name="{$sourceFile}">
    <xsl:call-template name="printPackageStatement">
        <xsl:with-param name="containerNamespace" select="$containerNamespace"/>
        <xsl:with-param name="printText" select="0"/>
    </xsl:call-template>

    <xsl:variable name="replacementMap">
        <map nativeType="{@name}" IDLFileBaseName="{$idlFileBaseName}" archName="{$archName}" 
             seqSuffix="{$typeSeqSuffix}" dataReaderSuffix="{$dataReaderSuffix}" coreProduct="{$coreProduct}"/>
    </xsl:variable>
    <xsl:call-template name="replace-string-from-map">
        <xsl:with-param name="search" select="'%%%nativeType%%%'"/>
        <xsl:with-param name="replacementParamsMap" select="xalan:nodeset($replacementMap)/node()"/>        

<!-- The template for Support of each struct -->
        <xsl:with-param name="inputString">
<![CDATA[/* %%nativeType%%Subscriber.java

   A publication of data of type %%nativeType%%

   This file is derived from code automatically generated by the rtiddsgen 
   command:

   rtiddsgen -language java -example <arch> %%IDLFileBaseName%%.idl

   Example publication of type %%nativeType%% automatically generated by 
   'rtiddsgen' To test them follow these steps:

   (1) Compile this file and the example subscription.

   (2) Start the subscription on the same domain used for with the command
       java %%nativeType%%Subscriber <domain_id> <sample_count>

   (3) Start the publication with the command
       java %%nativeType%%Publisher <domain_id> <sample_count>

   (4) [Optional] Specify the list of discovery initial peers and 
       multicast receive addresses via an environment variable or a file 
       (in the current working directory) called NDDS_DISCOVERY_PEERS. 
       
   You can run any number of publishers and subscribers programs, and can 
   add and remove them dynamically from the domain.
              
                                   
   Example:
        
       To run the example application on domain <domain_id>:
            
       Ensure that $(NDDSHOME)/lib/<arch> is on the dynamic library path for
       Java.                       
       
        On UNIX systems: 
             add $(NDDSHOME)/lib/<arch> to the 'LD_LIBRARY_PATH' environment
             variable
                                         
        On Windows systems:
             add %NDDSHOME%\lib\<arch> to the 'Path' environment variable
                        

       Run the Java applications:
       
        java -Djava.ext.dirs=$NDDSHOME/class %%nativeType%%Publisher <domain_id>

        java -Djava.ext.dirs=$NDDSHOME/class %%nativeType%%Subscriber <domain_id>  
       
       
modification history
------------ -------   
*/

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Arrays;

import com.rti.dds.domain.*;
import com.rti.dds.infrastructure.*;
import com.rti.dds.subscription.*;
import com.rti.dds.topic.*;
import com.rti.ndds.config.*;

// ===========================================================================

public class %%nativeType%%Subscriber {
    // -----------------------------------------------------------------------
    // Public Methods
    // -----------------------------------------------------------------------
    
    public static void main(String[] args) {
        // --- Get domain ID --- //
        int domainId = 0;
        if (args.length >= 1) {
            domainId = Integer.valueOf(args[0]).intValue();
        }
        
        // -- Get max loop count; 0 means infinite loop --- //
        int sampleCount = 0;
        if (args.length >= 2) {
            sampleCount = Integer.valueOf(args[1]).intValue();
        }
        
        
        /* Uncomment this to turn on additional logging
        Logger.get_instance().set_verbosity_by_category(
            LogCategory.NDDS_CONFIG_LOG_CATEGORY_API,
            LogVerbosity.NDDS_CONFIG_LOG_VERBOSITY_STATUS_ALL);
        */
        
        // --- Run --- //
        subscriberMain(domainId, sampleCount);
    }
    
    
    
    // -----------------------------------------------------------------------
    // Private Methods
    // -----------------------------------------------------------------------
    
    // --- Constructors: -----------------------------------------------------
    
    private %%nativeType%%Subscriber() {
        super();
    }
    
    
    // -----------------------------------------------------------------------
    
    private static void subscriberMain(int domainId, int sampleCount) {

        DomainParticipant participant = null;
        Subscriber subscriber = null;
        Topic topic = null;
        DataReaderListener listener = null;
        %%nativeType%%%%dataReaderSuffix%% reader = null;

        try {

            // --- Create participant --- //]]>
    <xsl:if test="$useQosProfile = 'no'">
            /* To customize participant QoS, use
               DomainParticipantFactory.TheParticipantFactory.
               get_default_participant_qos() */
    </xsl:if>
    <xsl:if test="$useQosProfile = 'yes'">
            /* To customize participant QoS, use
               the configuration file
               USER_QOS_PROFILES.xml */
    </xsl:if>
<![CDATA[            participant = DomainParticipantFactory.TheParticipantFactory.
                create_participant(
                    domainId, DomainParticipantFactory.PARTICIPANT_QOS_DEFAULT,
                    null /* listener */, StatusKind.STATUS_MASK_NONE);
            if (participant == null) {
                System.err.println("create_participant error\n");
                return;
            }                         

            // --- Create subscriber --- //]]>
    <xsl:if test="$useQosProfile = 'no'">
            /* To customize subscriber QoS, use
               participant.get_default_subscriber_qos() */
    </xsl:if>
    <xsl:if test="$useQosProfile = 'yes'">
            /* To customize subscriber QoS, use
               the configuration file USER_QOS_PROFILES.xml */
    </xsl:if>
<![CDATA[            subscriber = participant.create_subscriber(
                DomainParticipant.SUBSCRIBER_QOS_DEFAULT, null /* listener */,
                StatusKind.STATUS_MASK_NONE);
            if (subscriber == null) {
                System.err.println("create_subscriber error\n");
                return;
            }     
                
            // --- Create topic --- //
        
            /* Register type before creating topic */
            String typeName = %%nativeType%%TypeSupport.get_type_name(); 
            %%nativeType%%TypeSupport.register_type(participant, typeName);]]>
    <xsl:if test="$useQosProfile = 'no'">
            /* To customize topic QoS, use
               participant.get_default_topic_qos() */
    </xsl:if>
    <xsl:if test="$useQosProfile = 'yes'">
            /* To customize topic QoS, use
               the configuration file USER_QOS_PROFILES.xml */
    </xsl:if>
<![CDATA[            topic = participant.create_topic(
                "Example %%nativeType%%",
                typeName, DomainParticipant.TOPIC_QOS_DEFAULT,
                null /* listener */, StatusKind.STATUS_MASK_NONE);
            if (topic == null) {
                System.err.println("create_topic error\n");
                return;
            }                     
        
            // --- Create reader --- //

            listener = new %%nativeType%%Listener();]]>
    <xsl:if test="$useQosProfile = 'no'">
            /* To customize data reader QoS, use
               subscriber.get_default_datareader_qos() */
    </xsl:if>
    <xsl:if test="$useQosProfile = 'yes'">
            /* To customize data reader QoS, use
               the configuration file USER_QOS_PROFILES.xml */
    </xsl:if>
<![CDATA[            reader = (%%nativeType%%%%dataReaderSuffix%%)
                subscriber.create_datareader(
                    topic, Subscriber.DATAREADER_QOS_DEFAULT, listener,
                    StatusKind.STATUS_MASK_ALL);
            if (reader == null) {
                System.err.println("create_datareader error\n");
                return;
            }                         
        
            // --- Wait for data --- //

            final long receivePeriodSec = 4;

            for (int count = 0;
                 (sampleCount == 0) || (count < sampleCount);
                 ++count) {
                System.out.println("%%nativeType%% subscriber sleeping for "
                                   + receivePeriodSec + " sec...");
                try {
                    Thread.sleep(receivePeriodSec * 1000);  // in millisec
                } catch (InterruptedException ix) {
                    System.err.println("INTERRUPTED");
                    break;
                }
            }
        } finally {

            // --- Shutdown --- //

            if(participant != null) {
                participant.delete_contained_entities();

                DomainParticipantFactory.TheParticipantFactory.
                    delete_participant(participant);
            }
            /* %%coreProduct%% provides the finalize_instance()
               method for users who want to release memory used by the
               participant factory singleton. Uncomment the following block of
               code for clean destruction of the participant factory
               singleton. */
            //DomainParticipantFactory.finalize_instance();
        }
    }
    
    // -----------------------------------------------------------------------
    // Private Types
    // -----------------------------------------------------------------------
    
    // =======================================================================
    
    private static class %%nativeType%%Listener extends DataReaderAdapter {
            
        %%nativeType%%%%seqSuffix%% _dataSeq = new %%nativeType%%%%seqSuffix%%();
        SampleInfoSeq _infoSeq = new SampleInfoSeq();

        public void on_data_available(DataReader reader) {
            %%nativeType%%%%dataReaderSuffix%% %%nativeType%%Reader =
                (%%nativeType%%%%dataReaderSuffix%%)reader;
            
            try {
                %%nativeType%%Reader.take(
                    _dataSeq, _infoSeq,
                    ResourceLimitsQosPolicy.LENGTH_UNLIMITED,
                    SampleStateKind.ANY_SAMPLE_STATE,
                    ViewStateKind.ANY_VIEW_STATE,
                    InstanceStateKind.ANY_INSTANCE_STATE);

                for(int i = 0; i < _dataSeq.size(); ++i) {
                    SampleInfo info = (SampleInfo)_infoSeq.get(i);

                    if (info.valid_data) {
                        System.out.println(]]>
<xsl:choose>
    <xsl:when test="$corbaHeader != 'none'">
<xsl:text>                            %%nativeType%%TypeSupport.get_instance().sample_toString((%%nativeType%%)_dataSeq.get(i),"Received",0));&nl;</xsl:text>
    </xsl:when>
    <xsl:otherwise>
<xsl:text>                            ((%%nativeType%%)_dataSeq.get(i)).toString("Received",0));&nl;</xsl:text>
    </xsl:otherwise>
</xsl:choose>
<![CDATA[
                    }
                }
            } catch (RETCODE_NO_DATA noData) {
                // No data to process
            } finally {
                %%nativeType%%Reader.return_loan(_dataSeq, _infoSeq);
            }
        }
    }
}
]]>

        </xsl:with-param>
    </xsl:call-template>
</file>
    
    </xsl:if>
</xsl:template>

</xsl:stylesheet>
