<?xml version="1.0"?>
<!-- 
$Id: typePlugin.h.xsl,v 1.21 2013/10/07 22:04:30 roshan Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
Modification history:
- - - - - - - - - - -
5.1.0,07oct13,rk   Fixed CODEGEN-349 : replaced hyphen with underscore
5.0.1,26sep13,rk  Fixed CODEGEN-349 : replaced period with underscore
5.0.1,04jul13,fcs CODEGEN-601: Generate initial_w_params and finalize_w_params
5.0.1,01jun13,fcs CODEGEN-586: Fixed usage of NDDS_USER_DLL_EXPORT macro
                  when there are include files
5.0.1,22may13,fcs CODEGEN-594: Added suffix to DLL_EXPORT_MACRO
5.0.1,24apr13,acr CODEGEN-574 Modified return_sample function to finalize
                  optional members
5.0.0,09sep12,fcs Moved LAST_MEMBER_ID to type.h
5.0.0,21jul12,fcs Optimized code generation for non top level types
5.0.0,13jul12,fcs Added deserialized size methods (cont'd)
5.0.0,13jul12,fcs Added deserialized size methods
5.0.0,11jul12,fcs Added get_deserialized_sample_size
10ae,31jan12,vtg RTI-110 Add support to rtiddsgen to produce dll importable code on windows
10af,12jul11,ai  Fixed bug #13987
10af,28jun11,fcs Fixed memberID assignment with base structs
10ae,27feb10,fcs Used executionId for include guard
1.0ac,12jan10,tk  Merged from tk-2009-12-28-TAG_BRANCH_NDDS45A_NORTH12_MERGE_TO_HEAD
1.0ac,29aug09,fcs Double pointer indirection and dropSample
                  in deserialize function
1.0v,10aug09,fcs get_serialized_sample_size support
1.0v,08apr09,vtg Fixed bug #12876: Value type warnings in C++
10ab,01apr09,rbw+ds Bug #12833: DLL export plug-in functions
10y,17sep08,jlv Fixed include. Now files with more than one dot in the name 
                (or with an extension different to 'idl') are allowed.
10u,19jul08,fcs Added include template
10u,16jul08,tk  Removed utils.xsl
10u,22apr08,fb  Updated for new type plug-in changes (external writer
                buffer management)
10u,09mar08,eys Added const to participant and endpoint info parameter in
	        on_participant/endpoint_attached() callbacks
10s,07mar08,jpl Refactored new type plug-in interface
10s,01mar08,fcs Fixed serialized_sample_to_keyhash
10s,29feb08,fcs Support for get_min_size_serialized
10s,18feb08,fcs MD5 KeyHash generation support
10s,15feb08,fcs Added skip support
10q,01feb08,fcs Updated for new type plug-in interface
10q,07sep07,fcs Added serialized_instance_data_to_id function to type plug-in API
10q,20sep07,jpl Added functions to (de)serialize encapsulation to type plug-in API
10q,07sep07,jpl Added serialized_instance_to_id function to type plug-in API
10p,11jul07,eh  Refactor data encapsulation to support previous nddsgen-generated plugins;
                use existing (de)serialize() prototype when add data encapsulation header
10p,15may07,eh  Support data encapsulation of RTPS 2.0
10o,01mar07,fcs Added key serialization routines
10l,22mar06,fcs Added DDSQL support
10h,15dec05,fcs 4.0g compatibility (Code generated with nddsgen 4.0g can be 
                compiled in 4.1)        
10h,09dec05,fcs C++ namespace support
10f,17aug05,fcs Removed X
10f,21jul05,fcs Global parameters are moved to typeCommon.c.xsl.
10f,21jul05,fcs Removed Plugin_copy,Plugin_initialize and Plugin_finalize declarations.
                This declarations were moved to type.h.xsl
10e,20may05,fcs Delete copy,initialize and finalize functions declaration. These functions 
                have been moved to type.h.xsl              
10e,20may05,fcs Pointers support              
10e,16mar05,fcs Added Optimization Level support
10d,07feb05,rw  Added missing #include to output
10d,08nov04,eys Type plugin refactoring
10d,07sep04,rw  Updated key API's in response to review feedback
10d,17aug04,rw  Changed method name in response to review feedback
10d,16aug04,rw  Reflected change in PRES getKeyKindFnc() signature
10d,27jul04,rw  Added FooKeyHolder typedef generation
10d,26jul04,rw  Fixed incorrect signature of user_key_to_topic_key();
                improved file organization
10d,22jul04,rw  Updated method names to match DDS conventions
10d,29jun04,eys Replace xxx.idl with actual name
10c,26may04,rrl Fixed #8866 by calling assert on each member type
                and replaced tabs by 4 spaces to make output prettier
10c,05may04,eys Added getSharedInstance() and copy() method.
10c,05apr04,eys Added struct keyword in front of plugin to compile for C
40b,03feb04,rrl Support typedef
40a,23oct03,eys Added enum support
40a,23oct03,eys Added USER_KEY support
40a,13oct03,eys Fixed includes
40a,29sep03,eys Added getBasePlugin() method
30a,29sep03,eys Fixed includes
40a,25sep03,eys Fixed include of other idl files
40a,25sep03,eys Changed type plugin property.
40a,07sep03,rrl Support all the remaining methods.
40a,06sep03,rrl Moved constants and struct declaration part over to type.h.xsl
40a,04sep03,rrl Enable error checking
40a,04sep03,rrl Add typedef to struct definition to allow using it 
                as a member of other structs without "struct" in front of each.
                Also added typedefs for <Type>_Ptr and a string <Type>TYPENAME
40a,03sep03,rrl Support #include preprocessor directive.
40a,03sep03,rrl Use just one line for each method (let it exceed 80 characters), 
                following Howard's suggestion.
40a,28aug03,rrl Created (by refactoring typePlugin.c.xsl)
-->
<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
<!ENTITY namespaceSeperator "_">    <!-- namespace separator -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:xalan = "http://xml.apache.org/xalan">

<xsl:include href="typeCommon.c.xsl"/>
<xsl:include href="typeDatabasePlugin.h.xsl"/>

<xsl:param name="metp"/>
<xsl:param name="noKeyCode"/>

<xsl:output method="text"/>

<xsl:variable name="sourcePreamble" select="$generationInfo/sourcePreamble[@kind = 'type-plugin-header']"/>
<!-- When the root of document is matched, print the source preamble specified in
     the generation-info.c.xml file. The source preamble contains the standard blurb 
     as well as #include for the needed header file. -->
<xsl:template match="/">
/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from <xsl:value-of select="$idlFileBaseName"/>.idl using "rtiddsgen".
  The rtiddsgen tool is part of the <xsl:value-of select="$coreProduct"/> distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the <xsl:value-of select="$coreProduct"/> manual.
*/

#ifndef <xsl:value-of select="concat(translate($idlFileBaseName,'.-','__'), 'Plugin', '_', $executionId, '_h')"/>
#define <xsl:value-of select="concat(translate($idlFileBaseName,'.-','__'), 'Plugin', '_', $executionId, '_h')"/>

#include "<xsl:value-of select="concat($idlFileBaseName, '.h')"/>"
<xsl:apply-templates select=".//include" mode="include"/>

<xsl:if test="$metp ='yes'">
#include "metp/metp_type_plugin.h"
</xsl:if>

<xsl:if test="$database = 'yes'">
#include "ddsql/ddsql_c_impl.h"
</xsl:if>        

<xsl:value-of select="$sourcePreamble"/>

struct RTICdrStream;

#ifndef pres_typePlugin_h
#include "pres/pres_typePlugin.h"
#endif


#if (defined(RTI_WIN32) || defined (RTI_WINCE)) &amp;&amp; defined(NDDS_USER_DLL_EXPORT<xsl:value-of select="$dllExportMacroFinalSuffix"/>)
/* If the code is building on Windows, start exporting symbols.
*/
#undef NDDSUSERDllExport
#define NDDSUSERDllExport __declspec(dllexport)
#endif

<xsl:if test="$language = 'C' or $namespace='no'">
#ifdef __cplusplus
extern "C" {
#endif
</xsl:if>        

<xsl:apply-templates/>

<xsl:if test="$language = 'C' or $namespace='no'">
#ifdef __cplusplus
}
#endif
</xsl:if>
        
#if (defined(RTI_WIN32) || defined (RTI_WINCE)) &amp;&amp; defined(NDDS_USER_DLL_EXPORT<xsl:value-of select="$dllExportMacroFinalSuffix"/>)
/* If the code is building on Windows, stop exporting symbols.
*/
#undef NDDSUSERDllExport
#define NDDSUSERDllExport
#endif        

#endif /* <xsl:value-of select="concat(translate($idlFileBaseName,'.-','__'), 'Plugin', '_', $executionId, '_h')"/> */
</xsl:template>

<!-- ===================================================================== -->
<!-- Include                                                               -->
<!-- ===================================================================== -->

<xsl:template match="include" mode="include">
  <xsl:variable name="includedFile">
        <xsl:call-template name="changeFileExtension">
          <xsl:with-param name="fileName" select="@file"/>
          <xsl:with-param name="newExtension" select="'Plugin.h'"/>
        </xsl:call-template>
  </xsl:variable>
#include "<xsl:value-of select="$includedFile"/>"
<!--#include "<xsl:value-of select="concat(substring-before(@file, '.idl'), 'Plugin', '.h')"/>"-->
</xsl:template>

<!-- ===================================================================== -->
<!-- Enumerated Types                                                      -->
<!-- ===================================================================== -->

<xsl:template match="enum">
    <xsl:param name="containerNamespace"/>
    <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace, @name)"/>

    <xsl:apply-templates mode="error-checking"/>

/* ------------------------------------------------------------------------
 * (De)Serialization Methods
 * ------------------------------------------------------------------------ */

NDDSUSERDllExport extern RTIBool
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_serialize(
    PRESTypePluginEndpointData endpoint_data,
    const <xsl:value-of select="$fullyQualifiedStructName"/> *sample, struct RTICdrStream *stream,
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_sample, 
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern RTIBool
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_deserialize_sample(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> *sample, 
    struct RTICdrStream *stream, 
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_sample, 
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern RTIBool
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_skip(
    PRESTypePluginEndpointData endpoint_data,
    struct RTICdrStream *stream, 
    RTIBool skip_encapsulation,  
    RTIBool skip_sample, 
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern unsigned int
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_serialized_sample_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern unsigned int
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_serialized_sample_min_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern unsigned int
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_serialized_sample_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment,
    const <xsl:value-of select="$fullyQualifiedStructName"/> * sample);

<xsl:if test="$desSampleCode = 'yes'">
NDDSUSERDllExport extern unsigned int
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_deserialized_sample_min_size(
    PRESTypePluginEndpointData endpoint_data,
    unsigned int current_alignment,
    RTIBool only_members);

NDDSUSERDllExport extern RTIBool
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_deserialized_sample_size(
    PRESTypePluginEndpointData endpoint_data,
    unsigned int * size,
    RTIBool skip_encapsulation,
    RTIBool skip_sample,
    unsigned int current_alignment,
    RTIBool only_members,
    struct RTICdrStream *stream,
    void *endpoint_plugin_qos);
        
NDDSUSERDllExport extern RTIBool
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_initialize_deserialization_buffer_pointers(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> * sample,
    struct REDABufferManager *buffer_manager,
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern RTIBool
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_initialize_deserialization_buffer_pointers_from_stream(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> * sample,
    RTIBool skip_encapsulation,
    RTIBool skip_sample,
    struct REDABufferManager *buffer_manager,
    struct RTICdrStream *stream,
    void *endpoint_plugin_qos);
    
NDDSUSERDllExport extern RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_initialize_deserialization_buffer_pointers_from_sample(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> *dst,
    struct REDABufferManager *buffer_manager,
    const <xsl:value-of select="$fullyQualifiedStructName"/> *src);
</xsl:if>

<xsl:if test="$noKeyCode='no'">
/* ------------------------------------------------------------------------
    Key Management functions:
 * ------------------------------------------------------------------------ */

NDDSUSERDllExport extern RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_serialize_key(
    PRESTypePluginEndpointData endpoint_data,
    const <xsl:value-of select="$fullyQualifiedStructName"/> *sample,
    struct RTICdrStream *stream,
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_key,
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_deserialize_key_sample(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> *sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_key,
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern unsigned int 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_serialized_key_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern RTIBool
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_serialized_sample_to_key(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> *sample,
    struct RTICdrStream *stream, 
    RTIBool deserialize_encapsulation,  
    RTIBool deserialize_key, 
    void *endpoint_plugin_qos);

</xsl:if> <!--  No key code  -->


/* ----------------------------------------------------------------------------
    Support functions:
 * ---------------------------------------------------------------------------- */

NDDSUSERDllExport extern void
<xsl:value-of select="$fullyQualifiedStructName"/>PluginSupport_print_data(
    const <xsl:value-of select="$fullyQualifiedStructName"/> *sample, const char *desc, int indent_level);

<xsl:if test="$database = 'yes'">
    <xsl:call-template name="generateRequiredDatabaseDeclarations">
        <xsl:with-param name="containerNamespace" select="$containerNamespace"/>
        <xsl:with-param name="typeNode" select="."/>            
    </xsl:call-template>
</xsl:if>
        
</xsl:template>


<!-- ===================================================================== -->
<!-- Structure and Typedef Types                                           -->
<!-- ===================================================================== -->

<xsl:template match="struct|typedef">
    <xsl:param name="containerNamespace"/>
    <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace, @name)"/>
    <xsl:variable name="isKeyed">
        <xsl:choose>
            <xsl:when test="directive[@kind='key'] or (@keyedBaseClass and @keyedBaseClass='yes')">yes</xsl:when>
            <xsl:otherwise>no</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="fullyQualifiedStructNameC">
        <xsl:for-each select="./ancestor::module">
            <xsl:value-of select="@name"/>
            <xsl:text>_</xsl:text>        
        </xsl:for-each>
        <xsl:value-of select="@name"/>
    </xsl:variable>    

    <xsl:apply-templates mode="error-checking"/>

<xsl:variable name="generateCode">
    <xsl:call-template name="isNecessaryGenerateCode">
        <xsl:with-param name="typedefNode" select="."/>
    </xsl:call-template>                                
</xsl:variable>

<xsl:variable name="topLevel">
    <xsl:call-template name="isTopLevelType">
        <xsl:with-param name="typeNode" select="."/>
    </xsl:call-template>
</xsl:variable>
               
<xsl:if test="$generateCode='yes'">

<xsl:if test="$isKeyed='yes'">
/* The type used to store keys for instances of type struct
 * <xsl:value-of select="$fullyQualifiedStructName"/>.
 *
 * By default, this type is struct <xsl:value-of select="$fullyQualifiedStructName"/>
 * itself. However, if for some reason this choice is not practical for your
 * system (e.g. if sizeof(struct <xsl:value-of select="$fullyQualifiedStructName"/>)
 * is very large), you may redefine this typedef in terms of another type of
 * your choosing. HOWEVER, if you define the KeyHolder type to be something
 * other than struct <xsl:value-of select="$fullyQualifiedStructName"/>, the
 * following restriction applies: the key of struct
 * <xsl:value-of select="$fullyQualifiedStructName"/> must consist of a
 * single field of your redefined KeyHolder type and that field must be the
 * first field in struct <xsl:value-of select="$fullyQualifiedStructName"/>.
*/
typedef <xsl:choose> 
            <xsl:when test="(@kind='valuetype' or @kind='struct') and $language = 'C++'">
                <xsl:text> class </xsl:text>
            </xsl:when> 
            <xsl:otherwise> 
                <xsl:text> struct </xsl:text>
            </xsl:otherwise> 
        </xsl:choose> 
    <xsl:value-of select="$fullyQualifiedStructName"/><xsl:text> </xsl:text> 
  <xsl:value-of select="$fullyQualifiedStructName"/>KeyHolder;
</xsl:if>

#define <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_sample PRESTypePluginDefaultEndpointData_getSample  
#define <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_buffer PRESTypePluginDefaultEndpointData_getBuffer 
#define <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_return_buffer PRESTypePluginDefaultEndpointData_returnBuffer 
<xsl:if test="$isKeyed='yes'">
#define <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_key PRESTypePluginDefaultEndpointData_getKey 
#define <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_return_key PRESTypePluginDefaultEndpointData_returnKey
</xsl:if> 

#define <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_create_sample PRESTypePluginDefaultEndpointData_createSample 
#define <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_destroy_sample PRESTypePluginDefaultEndpointData_deleteSample 

/* --------------------------------------------------------------------------------------
    Support functions:
 * -------------------------------------------------------------------------------------- */

NDDSUSERDllExport extern <xsl:value-of select="$fullyQualifiedStructName"/>*
<xsl:value-of select="$fullyQualifiedStructName"/>PluginSupport_create_data_w_params(
    const struct DDS_TypeAllocationParams_t * alloc_params);

NDDSUSERDllExport extern <xsl:value-of select="$fullyQualifiedStructName"/>*
<xsl:value-of select="$fullyQualifiedStructName"/>PluginSupport_create_data_ex(RTIBool allocate_pointers);

NDDSUSERDllExport extern <xsl:value-of select="$fullyQualifiedStructName"/>*
<xsl:value-of select="$fullyQualifiedStructName"/>PluginSupport_create_data(void);

NDDSUSERDllExport extern RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>PluginSupport_copy_data(
    <xsl:value-of select="$fullyQualifiedStructName"/> *out,
    const <xsl:value-of select="$fullyQualifiedStructName"/> *in);

NDDSUSERDllExport extern void 
<xsl:value-of select="$fullyQualifiedStructName"/>PluginSupport_destroy_data_w_params(
    <xsl:value-of select="$fullyQualifiedStructName"/> *sample,
    const struct DDS_TypeDeallocationParams_t * dealloc_params);

NDDSUSERDllExport extern void 
<xsl:value-of select="$fullyQualifiedStructName"/>PluginSupport_destroy_data_ex(
    <xsl:value-of select="$fullyQualifiedStructName"/> *sample,RTIBool deallocate_pointers);

NDDSUSERDllExport extern void 
<xsl:value-of select="$fullyQualifiedStructName"/>PluginSupport_destroy_data(
    <xsl:value-of select="$fullyQualifiedStructName"/> *sample);

NDDSUSERDllExport extern void 
<xsl:value-of select="$fullyQualifiedStructName"/>PluginSupport_print_data(
    const <xsl:value-of select="$fullyQualifiedStructName"/> *sample,
    const char *desc,
    unsigned int indent);

<xsl:if test="$isKeyed = 'yes'">
NDDSUSERDllExport extern <xsl:value-of select="$fullyQualifiedStructName"/>*
<xsl:value-of select="$fullyQualifiedStructName"/>PluginSupport_create_key_ex(RTIBool allocate_pointers);

NDDSUSERDllExport extern <xsl:value-of select="$fullyQualifiedStructName"/>*
<xsl:value-of select="$fullyQualifiedStructName"/>PluginSupport_create_key(void);

NDDSUSERDllExport extern void 
<xsl:value-of select="$fullyQualifiedStructName"/>PluginSupport_destroy_key_ex(
    <xsl:value-of select="$fullyQualifiedStructName"/>KeyHolder *key,RTIBool deallocate_pointers);

NDDSUSERDllExport extern void 
<xsl:value-of select="$fullyQualifiedStructName"/>PluginSupport_destroy_key(
    <xsl:value-of select="$fullyQualifiedStructName"/>KeyHolder *key);
</xsl:if> <!-- End For Keyed Types -->

<xsl:if test="$topLevel='yes'">
/* ----------------------------------------------------------------------------
    Callback functions:
 * ---------------------------------------------------------------------------- */

NDDSUSERDllExport extern PRESTypePluginParticipantData 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_on_participant_attached(
    void *registration_data, 
    const struct PRESTypePluginParticipantInfo *participant_info,
    RTIBool top_level_registration, 
    void *container_plugin_context,
    RTICdrTypeCode *typeCode);

NDDSUSERDllExport extern void 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_on_participant_detached(
    PRESTypePluginParticipantData participant_data);
    
NDDSUSERDllExport extern PRESTypePluginEndpointData 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_on_endpoint_attached(
    PRESTypePluginParticipantData participant_data,
    const struct PRESTypePluginEndpointInfo *endpoint_info,
    RTIBool top_level_registration, 
    void *container_plugin_context);

NDDSUSERDllExport extern void 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_on_endpoint_detached(
    PRESTypePluginEndpointData endpoint_data);
    
NDDSUSERDllExport extern void    
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_return_sample(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> *sample,
    void *handle);    
</xsl:if> <!-- topLevel='yes' -->

NDDSUSERDllExport extern RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_copy_sample(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> *out,
    const <xsl:value-of select="$fullyQualifiedStructName"/> *in);

/* --------------------------------------------------------------------------------------
    (De)Serialize functions:
 * -------------------------------------------------------------------------------------- */

NDDSUSERDllExport extern RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_serialize(
    PRESTypePluginEndpointData endpoint_data,
    const <xsl:value-of select="$fullyQualifiedStructName"/> *sample,
    struct RTICdrStream *stream, 
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_sample, 
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_deserialize_sample(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> *sample, 
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_sample, 
    void *endpoint_plugin_qos);

<xsl:if test="name(.) != 'typedef'"> 
NDDSUSERDllExport extern RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_deserialize(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> **sample, 
    RTIBool * drop_sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_sample, 
    void *endpoint_plugin_qos);

<xsl:if test="$desSampleCode = 'yes'">
NDDSUSERDllExport extern RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_deserialize_to_buffer(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> **sample, 
    RTIBool * drop_sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_sample, 
    struct REDABufferManager *buffer_manager,
    void *endpoint_plugin_qos);
    
NDDSUSERDllExport extern RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_clone_to_buffer(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> **dst,
    const <xsl:value-of select="$fullyQualifiedStructName"/> *src,     
    struct REDABufferManager *buffer_manager);
</xsl:if>

</xsl:if>

<!-- skip method -->
NDDSUSERDllExport extern RTIBool
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_skip(
    PRESTypePluginEndpointData endpoint_data,
    struct RTICdrStream *stream, 
    RTIBool skip_encapsulation,  
    RTIBool skip_sample, 
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern unsigned int 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_serialized_sample_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern unsigned int 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_serialized_sample_min_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern unsigned int
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_serialized_sample_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment,
    const <xsl:value-of select="$fullyQualifiedStructName"/> * sample);

<xsl:if test="$desSampleCode = 'yes'">   
NDDSUSERDllExport extern unsigned int
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_deserialized_sample_min_size(
    PRESTypePluginEndpointData endpoint_data,
    unsigned int current_alignment,
    RTIBool only_members);

NDDSUSERDllExport extern RTIBool
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_deserialized_sample_size(
    PRESTypePluginEndpointData endpoint_data,
    unsigned int * size,
    RTIBool skip_encapsulation,
    RTIBool skip_sample,
    unsigned int current_alignment,
    RTIBool only_members,
    struct RTICdrStream *stream,
    void *endpoint_plugin_qos);
    
NDDSUSERDllExport extern RTIBool
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_initialize_deserialization_buffer_pointers(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> * sample,
    struct REDABufferManager *buffer_manager,
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern RTIBool
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_initialize_deserialization_buffer_pointers_from_stream(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> * sample,
    RTIBool skip_encapsulation,
    RTIBool skip_sample,
    struct REDABufferManager *buffer_manager,
    struct RTICdrStream *stream,
    void *endpoint_plugin_qos);
    
NDDSUSERDllExport extern RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_initialize_deserialization_buffer_pointers_from_sample(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> *dst,
    struct REDABufferManager *buffer_manager,
    const <xsl:value-of select="$fullyQualifiedStructName"/> *src);
    
</xsl:if>

<xsl:if test="$noKeyCode='no'">

/* --------------------------------------------------------------------------------------
    Key Management functions:
 * -------------------------------------------------------------------------------------- */

NDDSUSERDllExport extern PRESTypePluginKeyKind 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_key_kind(void);

NDDSUSERDllExport extern unsigned int 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_serialized_key_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

NDDSUSERDllExport extern RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_serialize_key(
    PRESTypePluginEndpointData endpoint_data,
    const <xsl:value-of select="$fullyQualifiedStructName"/> *sample,
    struct RTICdrStream *stream,
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_key,
    void *endpoint_plugin_qos);

NDDSUSERDllExport extern RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_deserialize_key_sample(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> * sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_key,
    void *endpoint_plugin_qos);

<xsl:if test="name(.) != 'typedef'"> 
NDDSUSERDllExport extern RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_deserialize_key(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> ** sample,
    RTIBool * drop_sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_key,
    void *endpoint_plugin_qos);
</xsl:if>

NDDSUSERDllExport extern RTIBool
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_serialized_sample_to_key(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> *sample,
    struct RTICdrStream *stream, 
    RTIBool deserialize_encapsulation,  
    RTIBool deserialize_key, 
    void *endpoint_plugin_qos);

<xsl:if test="$isKeyed = 'yes'"> <!-- For Keyed Types -->
NDDSUSERDllExport extern RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_instance_to_key(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/>KeyHolder *key, 
    const <xsl:value-of select="$fullyQualifiedStructName"/> *instance);

NDDSUSERDllExport extern RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_key_to_instance(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> *instance, 
    const <xsl:value-of select="$fullyQualifiedStructName"/>KeyHolder *key);

NDDSUSERDllExport extern RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_instance_to_keyhash(
    PRESTypePluginEndpointData endpoint_data,
    DDS_KeyHash_t *keyhash,
    const <xsl:value-of select="$fullyQualifiedStructName"/> *instance);

NDDSUSERDllExport extern RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_serialized_sample_to_keyhash(
    PRESTypePluginEndpointData endpoint_data,
    struct RTICdrStream *stream, 
    DDS_KeyHash_t *keyhash,
    RTIBool deserialize_encapsulation,
    void *endpoint_plugin_qos); 
</xsl:if> <!-- End for Keyed types -->

</xsl:if> <!--  End for keyed code -->

<xsl:if test="name(.) != 'typedef' and $topLevel='yes'">     
/* Plugin Functions */
NDDSUSERDllExport extern struct PRESTypePlugin*
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_new(void);

NDDSUSERDllExport extern void
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_delete(struct PRESTypePlugin *);
</xsl:if>

<xsl:if test="name()='struct' and not(@kind='union')">

<!-- Database methods -->
<xsl:if test = "$database = 'yes'">
    <xsl:call-template name="generateRequiredDatabaseDeclarations">
        <xsl:with-param name="containerNamespace" select="$containerNamespace"/>
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
                <xsl:with-param name="containerNamespace" select="$containerNamespace"/>
                <xsl:with-param name="typeNode" select="."/>            
            </xsl:call-template>        
        </xsl:if>            
    </xsl:if>        
</xsl:if>

</xsl:if> <!-- name()='struct' and not(@kind='union') -->

</xsl:if> <!-- end if generateCode -->

</xsl:template>
</xsl:stylesheet>
