<?xml version="1.0"?>
<!--
/* $Id: typeDataReader.java.xsl,v 1.3 2011/12/04 01:50:15 fernando Exp $

   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.

Modification history:
- - - - - - - - - - -
1.0ae,28apr11,kaj Fixed Bug #13946, adding api for read/take_instance_w_condition
1.0ac,08dec10,fcs Added copy-java-begin and copy-java-declaration-begin
10ae,22nov10,fcs Added dataReaderSuffix
10ae,26feb10,fcs Sequence suffix support
10u,16jul08,tk  Removed utils.xsl
10u,01jul08,rbw RFE #243: Refactored to expose statically un-type-safe
                reader APIs
10p,31dec07,vtg Made consistent with new type plugin API [First pass]
10l,22apr06,fcs Fixed bug 11070
10l,19apr06,fcs Removed final from the DataReader class declaration
10l,22mar06,fcs DDSQL support
10g,08oct05,jml Fixed read/take_next_instance_w_condition impl calls
10g,07oct05,jml Fixed parameters read/take_w_condition
10f,26jul05,kaj Added API for typeDataReader lookup_instance.
10f,21jul05,fcs Modified processGlobalElements template call to include element parameter                
10d,13jul05,kaj Moved InstanceHandle_t from topic to infrastructure
10d,09apr05,fcs Generated DataReader code only if the structure/union is a top-level type
10d,08apr05,fcs DataReader code for enumeration types is not generated anymore
10d,25aug04,rw  Call processGlobalElements
10d,24aug04,rw  Replaced tabs with spaces to improve readability of generated
                code
10c,11may04,rrl Changed DataType suffix to TypeSupport.
40b,05may05,rrl Fixed #8739 by adding the needed method implementation.
40b,26apr04,rrl Modifications to support new deserialize_objectX() API and enum support
                as well as API changes in DataTypeImpl from *I() to *X()
40c,05apr04,rrl Created
-->

<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
<!ENTITY namespaceSeperator ".">    <!-- namespace separator -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xalan="http://xml.apache.org/xalan"
    version="1.0">

<xsl:include href="typeCommon.java.xsl"/>

<xsl:output method="xml"/>

<xsl:template match="struct">
    <xsl:param name="containerNamespace"/>
    
    <xsl:variable name="topLevel">
        <xsl:call-template name="isTopLevelType">
            <xsl:with-param name="typeNode" select="."/>
        </xsl:call-template>
    </xsl:variable>

<xsl:if test="$topLevel='yes'">
    
    <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace, @name)"/>
<xsl:variable name="sourceFile">
    <xsl:call-template name="obtainSourceFileName">
        <xsl:with-param name="containerNamespace" select="$containerNamespace"/>
        <xsl:with-param name="typeName" select="concat(@name, $dataReaderSuffix)"/>
    </xsl:call-template>
</xsl:variable>
    
    <xsl:apply-templates mode="error-checking"/>

<file name="{$sourceFile}">
<xsl:call-template name="printPackageStatement">
    <xsl:with-param name="containerNamespace" select="$containerNamespace"/>
</xsl:call-template>

<xsl:call-template name="replace-string">
    <xsl:with-param name="search" select="'%%nativeType%%'"/>
    <xsl:with-param name="replace" select="@name"/>
    <xsl:with-param name="text">
<xsl:text><![CDATA[
import com.rti.dds.infrastructure.InstanceHandle_t;
import com.rti.dds.subscription.DataReaderImpl;
import com.rti.dds.subscription.DataReaderListener;
import com.rti.dds.subscription.ReadCondition;
import com.rti.dds.subscription.SampleInfo;
import com.rti.dds.subscription.SampleInfoSeq;
import com.rti.dds.topic.TypeSupportImpl;
]]></xsl:text>
    </xsl:with-param>
</xsl:call-template>

<xsl:apply-templates select="./preceding-sibling::node()[@kind = 'copy-java-begin']" 
                     mode="code-generation-begin">
    <xsl:with-param name="associatedType" select="."/>
</xsl:apply-templates>

<xsl:call-template name="processGlobalElements">
    <xsl:with-param name="element" select="."/>
</xsl:call-template>

<xsl:variable name="replacementMap">
    <map nativeType="{@name}" seqSuffix="{$typeSeqSuffix}" dataReaderSuffix="{$dataReaderSuffix}"/>
</xsl:variable>

<xsl:call-template name="replace-string-from-map">
    <xsl:with-param name="replacementParamsMap" select="xalan:nodeset($replacementMap)/node()"/>
    <xsl:with-param name="inputString">
<xsl:text><![CDATA[

// ===========================================================================

/**
 * A reader for the %%nativeType%% user type.
 */
public class %%nativeType%%%%dataReaderSuffix%% extends DataReaderImpl {
    // -----------------------------------------------------------------------
    // Public Methods
    // -----------------------------------------------------------------------

    public void read(%%nativeType%%%%seqSuffix%% received_data, SampleInfoSeq info_seq,
             int max_samples,
             int sample_states, int view_states, int instance_states) {
        read_untyped(received_data, info_seq, max_samples, sample_states,
             view_states, instance_states);
    }


    public void take(%%nativeType%%%%seqSuffix%% received_data, SampleInfoSeq info_seq,
             int max_samples,
             int sample_states, int view_states, int instance_states) {
        take_untyped(received_data, info_seq, max_samples, sample_states,
             view_states, instance_states);
    }


    public void read_w_condition(%%nativeType%%%%seqSuffix%% received_data, 
                 SampleInfoSeq info_seq,
                 int max_samples,
                 ReadCondition condition) {
        read_w_condition_untyped(received_data, info_seq, max_samples,
                 condition);
    }


    public void take_w_condition(%%nativeType%%%%seqSuffix%% received_data, 
                 SampleInfoSeq info_seq,
                 int max_samples,
                 ReadCondition condition) {
        take_w_condition_untyped(received_data, info_seq, max_samples,
                 condition);
    }


    public void read_next_sample(%%nativeType%% received_data, SampleInfo sample_info) {
        read_next_sample_untyped(received_data, sample_info);
    }


    public void take_next_sample(%%nativeType%% received_data, SampleInfo sample_info) {
        take_next_sample_untyped(received_data, sample_info);
    }


    public void read_instance(%%nativeType%%%%seqSuffix%% received_data, SampleInfoSeq info_seq,
            int max_samples, InstanceHandle_t a_handle, int sample_states,
            int view_states, int instance_states) {

        read_instance_untyped(received_data, info_seq, max_samples, a_handle,
            sample_states, view_states, instance_states);
    }


    public void take_instance(%%nativeType%%%%seqSuffix%% received_data, SampleInfoSeq info_seq,
            int max_samples, InstanceHandle_t a_handle, int sample_states,
            int view_states, int instance_states) {

        take_instance_untyped(received_data, info_seq, max_samples, a_handle,
            sample_states, view_states, instance_states);
    }


      public void read_instance_w_condition(%%nativeType%%%%seqSuffix%% received_data,
              SampleInfoSeq info_seq, int max_samples,
              InstanceHandle_t a_handle, ReadCondition condition) {

          read_instance_w_condition_untyped(received_data, info_seq, 
              max_samples, a_handle, condition);
      }


      public void take_instance_w_condition(%%nativeType%%%%seqSuffix%% received_data,
              SampleInfoSeq info_seq, int max_samples,
              InstanceHandle_t a_handle, ReadCondition condition) {

          take_instance_w_condition_untyped(received_data, info_seq, 
              max_samples, a_handle, condition);
      }


    public void read_next_instance(%%nativeType%%%%seqSuffix%% received_data,
            SampleInfoSeq info_seq, int max_samples,
            InstanceHandle_t a_handle, int sample_states, int view_states,
            int instance_states) {

        read_next_instance_untyped(received_data, info_seq, max_samples,
            a_handle, sample_states, view_states, instance_states);
    }


    public void take_next_instance(%%nativeType%%%%seqSuffix%% received_data,
            SampleInfoSeq info_seq, int max_samples,
            InstanceHandle_t a_handle, int sample_states, int view_states,
            int instance_states) {

        take_next_instance_untyped(received_data, info_seq, max_samples,
            a_handle, sample_states, view_states, instance_states);
    }


    public void read_next_instance_w_condition(%%nativeType%%%%seqSuffix%% received_data,
            SampleInfoSeq info_seq, int max_samples,
            InstanceHandle_t a_handle, ReadCondition condition) {

        read_next_instance_w_condition_untyped(received_data, info_seq, 
            max_samples, a_handle, condition);
    }


    public void take_next_instance_w_condition(%%nativeType%%%%seqSuffix%% received_data,
            SampleInfoSeq info_seq, int max_samples,
            InstanceHandle_t a_handle, ReadCondition condition) {

        take_next_instance_w_condition_untyped(received_data, info_seq, 
            max_samples, a_handle, condition);
    }


    public void return_loan(%%nativeType%%%%seqSuffix%% received_data, SampleInfoSeq info_seq) {
        return_loan_untyped(received_data, info_seq);
    }


    public void get_key_value(%%nativeType%% key_holder, InstanceHandle_t handle){
        get_key_value_untyped(key_holder, handle);
    }


    public InstanceHandle_t lookup_instance(%%nativeType%% key_holder) {
        return lookup_instance_untyped(key_holder);
    }

    // -----------------------------------------------------------------------
    // Package Methods
    // -----------------------------------------------------------------------

    // --- Constructors: -----------------------------------------------------

    /*package*/ %%nativeType%%%%dataReaderSuffix%%(long native_reader, DataReaderListener listener,
                              int mask, TypeSupportImpl data_type) {
        super(native_reader, listener, mask, data_type);
    }

}
]]></xsl:text>

</xsl:with-param>
    </xsl:call-template>
</file>

</xsl:if> <!-- if topLevel -->

</xsl:template>

</xsl:stylesheet>
