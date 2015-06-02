<?xml version="1.0"?>

<!-- 
/* $Id: qosProfile.xsl,v 1.15 2013/10/31 23:41:55 erin Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2005.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
Modification history:
- - - - - - - - - - -
10aj,15oct13,eam CORE-5587: mention and inherit from the builtin qos profiles
10ab,16jun13,fcs Fixed small typo
10ab,29mar13,fcs Fixed CODEGEN-566
10ab,24may10,yy  Enabled ZCSHMEM for metp
10ab,31oct09,fcs Removed copyright notice
10ab,10jul09,rbw Uncommented participant name
10ab,10jul09,rbw Added commented participant name so that users know about it
10z,01apr09,fcs Added version attribute
10z,04dec08,fcs Configured history in datareader_qos
10z,01dec08,fcs Fixed QoS values for reliable communication
10z,26nov08,jlv Modified for XSD compliance. Changed domainparticipant to participant.
10z,25nov08,jlv Added external XSD validation support
10z,20oct08,fcs Created
-->

<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
<!ENTITY namespaceSeperator "_">    <!-- namespace separator -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
				xmlns:xalan="http://xml.apache.org/xalan" version="1.0">
    <xsl:include href="utils.xsl"/>

    <xsl:variable name="idlFileBaseName" select="/specification/@idlFileName"/>
    <xsl:param name="xsdValidationFile"/>
    <xsl:param name="ddsVersion"/>
    <xsl:param name="metp"/>

    <!-- Output -->
    <xsl:output method="text"/>    

    <xsl:template match="/">
        <xsl:variable name="replacementMap">
            <map IDLFileBaseName="{$idlFileBaseName}" XSDValidationFile="{$xsdValidationFile}" Version="{$ddsVersion}"/>
        </xsl:variable>
        <xsl:call-template name="replace-string-from-map">
            <xsl:with-param name="replacementParamsMap" select="xalan:nodeset($replacementMap)/node()"/>        
            <!-- The template for Support of each struct -->
            <xsl:with-param name="inputString">
                <xsl:text><![CDATA[<?xml version="1.0"?>
<!-- 
Description
XML QoS Profile for %%IDLFileBaseName%%

The QoS configuration of the DDS entities in the generated example is loaded 
from this file.

This file is used only when it is in the current working directory or when the
environment variable NDDS_QOS_PROFILES is defined and points to this file.

The profile in this file inherits from the builtin QoS profile 
BuiltinQosLib::Generic.StrictReliable. That profile, along with all of the 
other built-in QoS profiles can be found in the 
BuiltinProfiles.documentationONLY.xml file located in the 
$NDDSHOME/resource/qos_profiles_%%Version%%/xml/ directory.

You may use any of these QoS configurations in your application simply by 
referring to them by the name shown in the 
BuiltinProfiles.documentationONLY.xml file and listed below: 

* In library "BuiltinQosLib":
** Baseline
** Baseline.5.0.0
** Baseline.5.1.0
** Generic.Common
** Generic.Monitoring.Common
** Generic.ConnextMicroCompatibility
** Generic.OtherDDSVendorCompatibility

* In library "BuiltinQosLibExp":
** Generic.StrictReliable
** Generic.KeepLastReliable
** Generic.BestEffort
** Generic.StrictReliable.HighThroughput
** Generic.StrictReliable.LowLatency
** Generic.Participant.LargeData
** Generic.Participant.LargeData.Monitoring
** Generic.StrictReliable.LargeData
** Generic.KeepLastReliable.LargeData
** Generic.StrictReliable.LargeData.FastFlow
** Generic.StrictReliable.LargeData.MediumFlow
** Generic.StrictReliable.LargeData.SlowFlow
** Generic.KeepLastReliable.LargeData.FastFlow
** Generic.KeepLastReliable.LargeData.MediumFlow
** Generic.KeepLastReliable.LargeData.SlowFlow
** Generic.KeepLastReliable.TransientLocal
** Generic.KeepLastReliable.Transient
** Generic.KeepLastReliable.Persistent
** Generic.AutoTuning
** Pattern.PeriodicData
** Pattern.Streaming
** Pattern.ReliableStreaming
** Pattern.Event
** Pattern.AlarmEvent
** Pattern.Status
** Pattern.AlarmStatus
** Pattern.LastValueCache

You should not edit the file BuiltinProfiles.documentationONLY.xml directly.
However, if you wish to modify any of the values in a built-in profile, the
recommendation is to create a profile of your own and inherit from the built-in
profile you wish to modify. The NDDS_QOS_PROFILES.example.xml file (contained in 
the same directory as the BuiltinProfiles.documentationONLY.xml file) shows how
to inherit from the built-in profiles. 

For more information about XML QoS Profiles see Chapter 15 in the 
RTI Connext user manual.
-->
<dds xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
     xsi:noNamespaceSchemaLocation="%%XSDValidationFile%%"
     version="%%Version%%">
    <!-- QoS Library containing the QoS profile used in the generated example.

        A QoS library is a named set of QoS profiles.
    -->
    <qos_library name="%%IDLFileBaseName%%_Library">

        <!-- QoS profile used to configure reliable communication between the DataWriter 
             and DataReader created in the example code.

             A QoS profile groups a set of related QoS.
        -->
        <qos_profile name="%%IDLFileBaseName%%_Profile" base_name="BuiltinQosLibExp::Generic.StrictReliable" is_default_qos="true">
            <!-- QoS used to configure the data writer created in the example code -->                
            <datawriter_qos>
                <publication_name>
                    <name>%%IDLFileBaseName%%DataWriter</name>
                </publication_name>
            </datawriter_qos>

            <!-- QoS used to configure the data reader created in the example code -->                
            <datareader_qos>
                <subscription_name>
                    <name>%%IDLFileBaseName%%DataReader</name>
                </subscription_name>
            </datareader_qos>

            <participant_qos>
                <!--
                The participant name, if it is set, will be displayed in the
                RTI tools, making it easier for you to tell one
                application from another when you're debugging.
                -->
                <participant_name>
                    <name>%%IDLFileBaseName%%Participant</name>
                    <role_name>%%IDLFileBaseName%%ParticipantRole</role_name>
                </participant_name>

            </participant_qos>
        </qos_profile>

    </qos_library>
</dds>
]]></xsl:text>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

</xsl:stylesheet>
