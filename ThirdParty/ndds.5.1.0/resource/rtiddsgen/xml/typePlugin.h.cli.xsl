<?xml version="1.0"?>
<!-- 
$Id: typePlugin.h.cli.xsl,v 1.9 2013/09/12 14:22:28 fernando Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
Modification history:
- - - - - - - - - - -
5.0.1,22may13,fcs CODEGEN-594: Added suffix to DLL_EXPORT_MACRO
10ae,31jan12,vtg RTI-110 Add support to rtiddsgen to produce dll importable code on windows
10ac,14aug11,fcs Fixed bug 14079
1.0ae,12jul10,jim Fixed 13514
1.0ac,29aug09,fcs Double pointer indirection and dropSample
                  in deserialize function
1.0ac,18aug09,fcs Fixed get_serialized_sample_size declaration
1.0ac,10aug09,fcs get_serialized_sample_size support
10y,09jul09,fcs Fixed bug 13033
10x,16jul08,tk  Removed utils.xsl
10x,07may08,rbw Added typedef support
10v,11apr08,rbw Removed unsupported database header inclusion
10v,10apr08,rbw Removed dead unmanaged code
10v,09apr08,rbw Type plug-in API is now managed
10v,19mar08,rbw Fixed enum (de)serialization bugs; fixed alignment
10v,17mar08,fcs Fixed key management
10v,13mar08,rbw Fixed incorrect key-related declarations
10v,12mar08,rbw Made method names more consistent
10v,12mar08,rbw Merged in keyhash support
10v,11mar08,rbw Added enum support
10s,06mar08,rbw Refactored (de)serialize to handle nested instances better
10s,04mar08,rbw Fixed lots of compile errors
10s,01mar08,rbw Created
-->


<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0"
                xmlns:xalan = "http://xml.apache.org/xalan">

<xsl:include href="typeCommon.cppcli.xsl"/>
<xsl:include href="typeDatabasePlugin.h.xsl"/>

<xsl:output method="text"/>

<xsl:param name="rtidds42e"/>


<!-- ===================================================================== -->
<!-- Document Root                                                         -->
<!-- ===================================================================== -->

<xsl:variable name="sourcePreamble"
              select="$generationInfo/sourcePreamble[@kind = 'type-plugin-header']"/>
<!-- When the root of document is matched, print the source preamble specified in
     the generation-info.c.xml file. The source preamble contains the standard blurb 
     as well as #include for the needed header file. -->
<xsl:template match="/">
    <xsl:text/>/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from <xsl:value-of select="$idlFileBaseName"/>.idl using "rtiddsgen".
  The rtiddsgen tool is part of the <xsl:value-of select="$coreProduct"/> distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the <xsl:value-of select="$coreProduct"/> manual.
*/

#pragma once

#include "<xsl:value-of select="$idlFileBaseName"/>.h"

<xsl:value-of select="$sourcePreamble"/>

<xsl:apply-templates/>

</xsl:template>

<!-- ===================================================================== -->
<!-- Include                                                               -->
<!-- ===================================================================== -->

<xsl:template match="include">
  <xsl:variable name="includedFile">
        <xsl:call-template name="changeFileExtension">
          <xsl:with-param name="fileName" select="@file"/>
          <xsl:with-param name="newExtension" select="'Plugin.h'"/>
        </xsl:call-template>
  </xsl:variable>
#include "<xsl:value-of select="$includedFile"/>"
</xsl:template>

<!-- ===================================================================== -->
<!-- Enumerated Types                                                      -->
<!-- ===================================================================== -->

<xsl:template match="enum">
    <xsl:apply-templates mode="error-checking"/>

<xsl:if test="$dllImportableCode='yes'">
<xsl:text>&nl;#if defined(NDDS_USER_DLL_EXPORT</xsl:text><xsl:value-of select="$dllExportMacroFinalSuffix"/>)
</xsl:if>
/* ------------------------------------------------------------------------
 * Enum Type: <xsl:value-of select="@name"/>
 * ------------------------------------------------------------------------ */

public ref class <xsl:value-of select="@name"/>Plugin {
// --- (De)Serialization Methods: --------------------------------------------
public:
    System::Boolean serialize(
        TypePluginEndpointData^ endpoint_data,
        <xsl:value-of select="@name"/> sample,
        CdrStream% stream,
        System::Boolean serialize_encapsulation,
        System::UInt16  encapsulation_id,
        System::Boolean serialize_sample,
        System::Object^ endpoint_plugin_qos);

    System::Boolean deserialize_sample(
        TypePluginEndpointData^ endpoint_data,
        <xsl:value-of select="@name"/>% sample,
        CdrStream% stream,
        System::Boolean deserialize_encapsulation,
        System::Boolean deserialize_sample, 
        System::Object^ endpoint_plugin_qos);

    System::Boolean skip(
        TypePluginEndpointData^ endpoint_data,
        CdrStream% stream,
        System::Boolean skip_encapsulation,
        System::Boolean skip_sample, 
        System::Object^ endpoint_plugin_qos);

    System::UInt32 get_serialized_sample_max_size(
        TypePluginEndpointData^ endpoint_data,
        System::Boolean include_encapsulation,
        System::UInt16  encapsulation_id,
        System::UInt32 size);

    System::UInt32 get_serialized_sample_min_size(
        TypePluginEndpointData^ endpoint_data,
        System::Boolean include_encapsulation,
        System::UInt16  encapsulation_id,
        System::UInt32 size);

    System::UInt32 get_serialized_sample_size(
        TypePluginEndpointData^ endpoint_data,
        Boolean include_encapsulation,
        UInt16 encapsulation_id,
        UInt32 current_alignment,
        <xsl:value-of select="@name"/> sample);

// --- Key Management functions: ---------------------------------------------
public:
    System::Boolean serialize_key(
        TypePluginEndpointData^ endpoint_data,
        <xsl:value-of select="@name"/> key,
        CdrStream% stream,
        System::Boolean serialize_encapsulation,
        System::UInt16  encapsulation_id,
        System::Boolean serialize_sample,
        System::Object^ endpoint_plugin_qos);

    System::Boolean deserialize_key_sample(
        TypePluginEndpointData^ endpoint_data,
        <xsl:value-of select="@name"/>% key,
        CdrStream% stream,
        System::Boolean deserialize_encapsulation,
        System::Boolean deserialize_sample,
        System::Object^ endpoint_plugin_qos);

    System::UInt32 get_serialized_key_max_size(
        TypePluginEndpointData^ endpoint_data,
        System::Boolean include_encapsulation,
        System::UInt16  encapsulation_id,
        System::UInt32 current_alignment);

    System::Boolean serialized_sample_to_key(
        TypePluginEndpointData^ endpoint_data,
        <xsl:value-of select="@name"/>% sample,
        CdrStream% stream, 
        Boolean deserialize_encapsulation,  
        Boolean deserialize_key, 
        Object^ endpoint_plugin_qos);


// --- Support functions: ----------------------------------------------------
public:
    void print_data(
        <xsl:value-of select="@name"/> sample,
        System::String^ desc,
        System::UInt32 indent_level);

    <!-- database methods -->
<xsl:if test="$database = 'yes'">
    <xsl:call-template name="generateRequiredDatabaseDeclarations">
        <xsl:with-param name="typeNode" select="."/>            
    </xsl:call-template>
</xsl:if>


// ---  Plug-in lifecycle management methods: --------------------------------
public:
    static <xsl:value-of select="@name"/>Plugin^ get_instance();

    static void dispose();

private:
    <xsl:value-of select="@name"/>Plugin() { /*empty*/ }

    static <xsl:value-of select="@name"/>Plugin^ _singleton;
};  
<xsl:if test="$dllImportableCode='yes'">      
<xsl:text>#endif /* defined(NDDS_USER_DLL_EXPORT</xsl:text><xsl:value-of select="$dllExportMacroFinalSuffix"/>)<xsl:text> */ &nl;</xsl:text>
</xsl:if>
</xsl:template>


<!-- ===================================================================== -->
<!-- Structures and Typedefs                                               -->
<!-- ===================================================================== -->

<xsl:template match="struct|typedef">
    <xsl:variable name="isKeyed">
        <xsl:choose>
            <xsl:when test="directive[@kind='key'] or (@keyedBaseClass and @keyedBaseClass='yes')">yes</xsl:when>
            <xsl:otherwise>no</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:apply-templates mode="error-checking"/>

    <xsl:if test="$dllImportableCode='yes'">
    <xsl:text>&nl;#if defined(NDDS_USER_DLL_EXPORT</xsl:text><xsl:value-of select="$dllExportMacroFinalSuffix"/>)
    </xsl:if>

    <xsl:variable name="generateCode">
        <xsl:call-template name="isNecessaryGenerateCode">
            <xsl:with-param name="typedefNode" select="."/>
        </xsl:call-template>                                
    </xsl:variable>

    <xsl:if test="$generateCode='yes'">
/* ------------------------------------------------------------------------
 * Type: <xsl:value-of select="@name"/>
 * ------------------------------------------------------------------------ */

public ref class <xsl:value-of select="@name"/>Plugin :
    DefaultTypePlugin&lt;<xsl:value-of select="@name"/>^&gt; {
// --- Support methods: ------------------------------------------------------
public:
    void print_data(
        <xsl:value-of select="@name"/>^ sample,
        System::String^ desc,
        System::UInt32 indent);


// --- (De)Serialize methods: ------------------------------------------------
public:
    virtual System::Boolean serialize(
        TypePluginDefaultEndpointData^ endpoint_data,
        <xsl:value-of select="@name"/>^ sample,
        CdrStream% stream,
        System::Boolean serialize_encapsulation,
        System::UInt16  encapsulation_id,
        System::Boolean serialize_sample,
        System::Object^ endpoint_plugin_qos) override;

    virtual System::Boolean deserialize_sample(
        TypePluginDefaultEndpointData^ endpoint_data,
        <xsl:value-of select="@name"/>^ sample,
        CdrStream% stream,
        System::Boolean deserialize_encapsulation,
        System::Boolean deserialize_sample, 
        System::Object^ endpoint_plugin_qos) override;

    System::Boolean skip(
        TypePluginDefaultEndpointData^ endpoint_data,
        CdrStream% stream,
        System::Boolean skip_encapsulation,  
        System::Boolean skip_sample, 
        System::Object^ endpoint_plugin_qos);

    virtual System::UInt32 get_serialized_sample_max_size(
        TypePluginDefaultEndpointData^ endpoint_data,
        System::Boolean include_encapsulation,
        System::UInt16  encapsulation_id,
        System::UInt32 size) override;

    virtual System::UInt32 get_serialized_sample_min_size(
        TypePluginDefaultEndpointData^ endpoint_data,
        System::Boolean include_encapsulation,
        System::UInt16  encapsulation_id,
        System::UInt32 size) override;

    virtual System::UInt32 get_serialized_sample_size(
        TypePluginDefaultEndpointData^ endpoint_data,
        Boolean include_encapsulation,
        UInt16 encapsulation_id,
        UInt32 current_alignment,
        <xsl:value-of select="@name"/>^ sample) override;

// ---  Key Management functions: --------------------------------------------
public:
    virtual System::UInt32 get_serialized_key_max_size(
        TypePluginDefaultEndpointData^ endpoint_data,
        System::Boolean include_encapsulation,
        System::UInt16  encapsulation_id,
        System::UInt32 current_alignment) override;

    virtual System::Boolean serialize_key(
        TypePluginDefaultEndpointData^ endpoint_data,
        <xsl:value-of select="@name"/>^ key,
        CdrStream% stream,
        System::Boolean serialize_encapsulation,
        System::UInt16  encapsulation_id,
        System::Boolean serialize_sample,
        System::Object^ endpoint_plugin_qos) override;

    virtual System::Boolean deserialize_key_sample(
        TypePluginDefaultEndpointData^ endpoint_data,
        <xsl:value-of select="@name"/>^ key,
        CdrStream% stream,
        System::Boolean deserialize_encapsulation,
        System::Boolean deserialize_sample,
        System::Object^ endpoint_plugin_qos) override;

    System::Boolean serialized_sample_to_key(
        TypePluginDefaultEndpointData^ endpoint_data,
        <xsl:value-of select="@name"/>^ sample,
        CdrStream% stream,
        System::Boolean deserialize_encapsulation,
        System::Boolean deserialize_key,
        System::Object^ endpoint_plugin_qos);

<xsl:if test="$isKeyed='yes'"> <!-- For Keyed Types -->

    virtual System::Boolean instance_to_key(
        TypePluginDefaultEndpointData^ endpoint_data,
        <xsl:value-of select="@name"/>^ key,
        <xsl:value-of select="@name"/>^ instance) override;

    virtual System::Boolean key_to_instance(
        TypePluginDefaultEndpointData^ endpoint_data,
        <xsl:value-of select="@name"/>^ instance,
        <xsl:value-of select="@name"/>^ key) override;

    virtual System::Boolean serialized_sample_to_key_hash(
        TypePluginDefaultEndpointData^ endpoint_data,
        CdrStream% stream,
        KeyHash_t% key_hash,
        System::Boolean deserialize_encapsulation,
        System::Object^ endpoint_plugin_qos) override;

</xsl:if> <!-- End for Keyed types -->

<xsl:if test="name()='struct' and not(@kind='union')">

<!-- Database methods -->
<xsl:if test = "$database = 'yes'">
    <xsl:call-template name="generateRequiredDatabaseDeclarations">
        <xsl:with-param name="typeNode" select="."/>            
    </xsl:call-template>        
        
    <xsl:if test="name()='struct'">
        <xsl:variable name="topLevel">
            <xsl:call-template name="isTopLevelType">
                <xsl:with-param name="typeNode" select="."/>
            </xsl:call-template>
        </xsl:variable>
    
        <xsl:if test = "$topLevel = 'yes'">            
            <xsl:call-template name="generateTopLevelDatabaseDeclarations">
                <xsl:with-param name="typeNode" select="."/>            
            </xsl:call-template>        
        </xsl:if>            
    </xsl:if>        
</xsl:if>

</xsl:if> <!-- name()='struct' and not(@kind='union') -->


// ---  Plug-in lifecycle management methods: --------------------------------
public:
    static <xsl:value-of select="@name"/>Plugin^ get_instance();

    static void dispose();

private:
    <xsl:value-of select="@name"/>Plugin()
            : DefaultTypePlugin(
                "<xsl:value-of select="@name"/>",
<xsl:choose>
    <xsl:when test="$isKeyed='yes'">
                true, // keyed
    </xsl:when>
    <xsl:otherwise>
                false, // not keyed
    </xsl:otherwise>
</xsl:choose>
<xsl:choose>
    <xsl:when test="$rtidds42e='yes'">
                true, // use legacy 4.2 alignment
    </xsl:when>
    <xsl:otherwise>
                false, // use RTPS-compliant alignment
    </xsl:otherwise>
</xsl:choose>
    <xsl:text>               </xsl:text>
<xsl:choose>
    <xsl:when test="$typecode='yes'">
        <xsl:value-of select="@name"/>::get_typecode()<xsl:text/>
    </xsl:when>
    <xsl:otherwise>nullptr</xsl:otherwise>
</xsl:choose>) {
        // empty
    }

    static <xsl:value-of select="@name"/>Plugin^ _singleton;
};
</xsl:if> <!-- end if generateCode -->

<xsl:if test="$dllImportableCode='yes'">
<xsl:text>#endif /* defined(NDDS_USER_DLL_EXPORT</xsl:text><xsl:value-of select="$dllExportMacroFinalSuffix"/>)<xsl:text> */ &nl;</xsl:text>
</xsl:if>

</xsl:template>

</xsl:stylesheet>
