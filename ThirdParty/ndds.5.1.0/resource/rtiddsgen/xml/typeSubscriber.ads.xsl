<?xml version="1.0"?>

<!-- 
/* $Id: typeSubscriber.ads.xsl,v 1.3 2011/12/04 01:50:15 fernando Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2005.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
Modification history:
- - - - - - - - - - -
10o,19jul10,eys Updated to work with 4.5c
10o,17jun08,fcs Group types into modules
10o,16jun08,fcs 06/16/08 Merge changes
10o,29nov07,fcs 11/29/07 Merge changes
10o,09nov07,fcs Mark changes 11/02/07
10o,09jul07,fcs Created
-->

<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
<!ENTITY namespaceSeperator "_">    <!-- namespace separator -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:xalan = "http://xml.apache.org/xalan">

<xsl:include href="typeCommon.ada.xsl"/>

<xsl:output method="xml"/>

<xsl:template match="/">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="struct">
    <xsl:param name="containerNamespace"/>
    <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace, @name)"/>

    <xsl:variable name="newContainerNamespace">
        <xsl:if test="name(..) = 'specification'">
            <xsl:value-of select="concat($idlFileBaseName,'_IDL_File')"/>
        </xsl:if>
        <xsl:if test="name(..) = 'module'">
            <xsl:value-of select="$containerNamespace"/>
        </xsl:if>
    </xsl:variable>

    <xsl:variable name="typePackageName">
        <xsl:value-of select="$newContainerNamespace"/>
    </xsl:variable>

    <xsl:variable name="fullyQualifiedAdaTypeName" select="concat($typePackageName,'.',@name)"/>

    <xsl:variable name="replacementMap">
        <map typePackageName="{$typePackageName}" fullQualifiednativeType="{$fullyQualifiedAdaTypeName}" 
             nativeType="{@name}"
             IDLFileBaseName="{$idlFileBaseName}" archName="{$archName}" 
             modifyPubData="{$modifyPubData}"/>
    </xsl:variable>
    
    <xsl:variable name="lastTopLevel">
        <xsl:call-template name="isLastLessDeepTopLevelType">
            <xsl:with-param name="typeNode" select="."/>
        </xsl:call-template>        
    </xsl:variable>

    <xsl:if test="$lastTopLevel = 'yes'">
        <xsl:variable name="adsFile">
            <xsl:call-template name="obtainSourceFileName">
                <xsl:with-param name="directory"
                                select="'./samples'"/>
                <xsl:with-param name="containerNamespace"
                                select="$newContainerNamespace"/>
                <xsl:with-param name="typeName" select="concat(@name,'_subscriber')"/>
                <xsl:with-param name="fileExt" select="'ads'"/>
            </xsl:call-template>
        </xsl:variable>

        <file name="{$adsFile}">
            <xsl:text>procedure </xsl:text>
            <xsl:value-of select="$fullyQualifiedAdaTypeName"/>
            <xsl:text>_Subscriber;&nl;</xsl:text>
        </file>

        <xsl:variable name="listenerAdsFile">
            <xsl:call-template name="obtainSourceFileName">
                <xsl:with-param name="directory"
                                select="'./samples'"/>
                <xsl:with-param name="containerNamespace"
                                select="$newContainerNamespace"/>
                <xsl:with-param name="typeName" select="concat(@name,'_subscriberlistener')"/>
                <xsl:with-param name="fileExt" select="'ads'"/>
            </xsl:call-template>
        </xsl:variable>

        <file name="{$listenerAdsFile}">
            <xsl:call-template name="replace-string-from-map">
                <xsl:with-param name="search" select="'%%nativeType%%'"/>
                <xsl:with-param name="replacementParamsMap" select="xalan:nodeset($replacementMap)/node()"/>
                <xsl:with-param name="inputString">
<xsl:text><![CDATA[
with DDS.DataReaderListener;
with DDS.DataReader;

package %%fullQualifiednativeType%%_SubscriberListener is
   type My_Listener is new Standard.DDS.DataReaderListener.Ref with null record;
   type My_Listener_Access is access all My_Listener'Class;

   procedure On_Data_Available
     (Self       : not null access My_Listener;
      The_Reader : in out Standard.DDS.DataReader.Ref'Class);

   procedure On_Subscription_Matched
     (Self       : not null access My_Listener;
      The_Reader : access constant Standard.DDS.DataReader.Ref'Class'Class;
      Status     : in Standard.DDS.SubscriptionMatchedStatus)
   is null;

   procedure On_Sample_Lost
     (Self       : not null access My_Listener;
      The_Reader : access constant Standard.DDS.DataReader.Ref'Class'Class;
      Status     : in Standard.DDS.SampleLostStatus)
   is null;

   procedure On_Requested_Deadline_Missed
     (Self       : not null access My_Listener;
      The_Reader : access constant Standard.DDS.DataReader.Ref'Class'Class;
      Status     : in Standard.DDS.RequestedDeadlineMissedStatus)
   is null;

   procedure On_Requested_Incompatible_Qos
     (Self       : not null access My_Listener;
      The_Reader : access constant Standard.DDS.DataReader.Ref'Class'Class;
      Status     : in Standard.DDS.RequestedIncompatibleQosStatus)
   is null;

   procedure On_Sample_Rejected
     (Self       : not null access My_Listener;
      The_Reader : access constant Standard.DDS.DataReader.Ref'Class;
      Status     : in Standard.DDS.SampleRejectedStatus)
   is null;

   procedure On_Liveliness_Changed
     (Self       : not null access My_Listener;
      The_Reader : access constant Standard.DDS.DataReader.Ref'Class;
      Status     : in Standard.DDS.LivelinessChangedStatus)
   is null;

end %%fullQualifiednativeType%%_SubscriberListener;
]]>&nl;</xsl:text>
                </xsl:with-param>
            </xsl:call-template>
        </file>

    </xsl:if>    
</xsl:template>

<!--
Process directives
We ignore the copy directives for the example code
-->
<xsl:template match="directive[@kind = 'copy' or @kind = 'copy-ada']">
</xsl:template>

<xsl:template match="directive[@kind = 'copy' or @kind = 'copy-ada']"
              mode="code-generation">
</xsl:template>

</xsl:stylesheet>
