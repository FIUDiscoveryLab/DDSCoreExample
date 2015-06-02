<?xml version="1.0"?>
<!-- 
$Id: typePlugin.c.xsl,v 1.34 2013/10/29 05:09:30 fernando Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
Modification history:
- - - - - - - - - - -
5.1.0,27oct13,fcs CODEGEN-624: Missing useExtendedMemberId initialization in 
                  the serialize method for types with optional members
5.0.1,04jul13,fcs CODEGEN-601: Generate initial_w_params and finalize_w_params
5.0.1,16may13,fcs CODEGEN-587: DataReaders with mutable union types do not drop 
                  samples when the discriminator value for the selected member 
                  is unknown to the DataReader
5.0.1,10may13,acr CODEGEN-574 Support for optional members in non-mutable types
5.0.1,24apr13,acr CODEGEN-574 Modified return_sample function to finalize
                  optional members
5.0.0,12dec12,fcs Additional changes to fix CODEGEN-527
5.0.0,12dec12,fcs Fixed CODEGEN-535: Incorrect keyhash generation for samples 
                  where the type of any of the key members is a structure 
                  inheriting from another structure
5.0.0,08dec12,fcs Fixed bug CODEGEN-530: A DataReader may fail to deserialize 
                  samples if the underlying type is an extended type where the 
                  type of the last member requires 8-byte alignment
5.0.0,25nov12,fcs Fixed CODEGEN-527
5.0.0,21jul12,fcs Optimized code generation for non top level types
5.0.0,13jul12,fcs Added deserialized size methods (cont'd)
5.0.0,13jul12,fcs Added deserialized size methods
5.0.0,11jul12,fcs Added get_deserialized_sample_size
5.0.0,11jul12,fcs Bitbound support in enums
5.0.0,10jul12,fcs Mutable union support
10ae,23aug11,fcs Fixed sample deletion when allocation failed
10af,12jun11,fcs Support BYTE bitsets
10af, 01jun11,ai  XTYpes: added support for PID_LIST_END memberId. 
                           Also, fixed size of length and memberID for mutable types
10af,13apr11,ai  Added support for bitsets
10af,06apr11,ai  XType: added support for struct inheritance, extensible and mutable types
10ae,15apr11,fcs Fixed bug 13926
10ae,13oct10,fcs Fixed deletion of structure when
                 create_data_ex fails
10ae,27jun10,fcs Fixed 13495
10ae,18apr10,fcs Fixed bug 13415
10ae,27feb10,fcs Removed include guard usage
10ac,04feb10,fcs Fixed bug 13275
10ac,12jan10,tk  Merged from tk-2009-12-28-TAG_BRANCH_NDDS45A_NORTH12_MERGE_TO_HEAD
10ac,6sep09,fcs Fixed bug 12542
10ac,11sep09,fcs Set deserializeKeySampleFnc
10ac,29aug09,fcs Double pointer indirection and dropSample
                 in deserialize function
10ac,20aug09,fcs Added encapsulation error detection &
                 Removed CDR_NATIVE usage
10u,10aug09,fcs get_serialized_sample_size support
10u,06may09,fcs Fixed instanceToKeyHash
10u,23jul08,fcs Removed sequence_length variables
10u,19jul08,fcs Removed include tag template
10u,16jul08,tk  Removed utils.xsl
10u,22apr08,fb  Updated for new type plug-in changes (external writer
                buffer management)
10u,17apr08,eys Fixed TypePlugin_new() null checking
10u,12mar08,fcs Compatibility mode for batch
10u,09mar08,eys Added const to participant and endpoint info parameter in
	        on_participant/endpoint_attached() callbacks
10s,07mar08,fcs Fixed get_serialized_xxx_max(min)_size functions
10s,07mar08,jpl Refactored new type plug-in interface
10s,05mar08,fcs Added rtidds42e code generation
10s,01mar08,fcs Fixed serialized_sample_to_keyhash
10s,29feb08,fcs Support for get_min_size_serialized
10s,21feb08,eys Fixed bug 12174: check for null after allocating plugin
10s,18feb08,fcs MD5 KeyHash generation support
10s,15feb08,fcs Added skip support
10q,01feb08,fcs Removed static declaration of plugin
10q,01feb08,fcs Updated for new type plug-in interface
10q,20nov07,fcs Fixed serialized_instance_to_id
10q,07sep07,fcs Added serialized_instance_data_to_id function to type plug-in API
10q,20sep07,jpl Added functions to (de)serialize encapsulation to type plug-in API
10q,07sep07,jpl Added serialized_instance_to_id function to type plug-in API
10p,16jul07,eh  Add plugin version
10p,11jul07,eh  Refactor data encapsulation to support previous nddsgen-generated plugins;
                use existing (de)serialize() prototype when add data encapsulation header
10p,15may07,eh  RTPS 2.0 compliance: instance_to_id handles larger Id, and
                data encapsulation
10o,01mar07,fcs Added key serialization routines
10l,16aug96,kaj 64 bit: change parameters from long to DDS_Long for API
10l,22mar06,fcs Added DDSQL support
10h,15dec05,fcs 4.0g compatibility (Code generated with nddsgen 4.0g can be 
                compiled in 4.1)       
10h,13dec05,fcs Removed warnings        
10h,13dec05,fcs Changed the key behavior for value types        
10h,08dec05,fcs Removed compilation warnings        
10h,07dec05,fcs Value type support        
10f,17aug05,fcs Removed X
10f,27jul05,fcs Modified string array detection condition in key generation code
10f,27jul05,fcs Included warnings messages in nddsgen when the generated key code 
                can introduce loss of key data
10f,27jul05,fcs Fixed bug 10490
10f,21jul05,fcs Global parameters are moved to typeCommon.c.xsl.
10f,10jul05,eys Changed type code from global variable to get_typecode() method
10f,27jun05,fcs Added TypeCode support
10e,20may05,fcs Pointers Support
10e,02apr05,fcs * The condition "name(.)='typedef' and $optLevel='2'" that is necessary 
                to not generate code is moved to the template isNecessaryGenerateCode in
                typeCommon.c.xsl
                * Declared "i" in Plugin_instance_to_keyX and Plugin_key_to_instanceX when we have
                array of sequences keys members.
10e,29mar05,rw  Bug #10270: delegate copy to type itself; eliminate unneeded
                initialize() and finalize() wrapper functions
10e,28mar05,rw  Bug #10270: unified copy and copy_key_fields method templates
10e,16mar05,fcs a) Refactoring Key Support to take into account the base type information
                b) Modified Wstring keys support to be consistent with the new implementation of
                Wstring (RTICdrWchar *)
                c) Refactoring for being compatible with the new simplified XML document.
10e,14dec04,eys Do not put an include guard around TypeSupport.h, because it
                may contain liternal path
10d,22nov04,eys For C++, initialize sequence by calling constructor of 
                the type.
10d,08nov04,eys Type plugin refactoring
10d,10sep04,rw  Fixed wstring byte swapping bug; fixed inconsistent
                variable name
10d,07sep04,rw  Updated key API's in response to review feedback
10d,30aug04,rw  If user specifies only 1 or 2 key fields, zero the rest of
                the topic key
10d,23aug04,rw  Added comment telling user not to fill in
                instance_to_topic_key() entirely with zeroes
10d,17aug04,rw  Updated based on review feedback; short strings are now
                safe to use as keys
10d,16aug04,rw  Reflected change in PRES getKeyKindFnc() signature
10d,09aug04,rw  Removed obsolete generated comments
10d,05aug04,rw  Guard non-standard types with #ifdef
10d,04aug04,rw  Don't call htonl(): mig already does byte swapping;
                streamlined error detection; allow #errors to be suppressed
10d,29jul04,rw  More aggressive error reporting when translating user keys
                to topic keys
10d,28jul04,rw  Added generation of key support code
10d,22jul04,rw  Updated method names to match DDS conventions
10d,29jun04,eys Replace xxx.idl with actual name
10c,26may04,rrl Fixed #8866 by calling assert on each member type
                and replaced tabs by 4 spaces to make output prettier
10c,18may04,eys Use copy() method in instanceToKey() and
                keyToInstance(). See Bug #8963.
10c,11may04,rrl Fixed union's computation for maxSizeSerialized.
10c,05may04,eys Added getSharedInstance() and copy() method
10c,30apr04,eys Fixed instanceToGuid
10c,05apr04,eys Added struct keyword in front of plugin to compile for C
10c,09feb04,sjr Integrated newly refactored dds_c and dds_cpp.
40b,03feb04,rrl Support typedef
40b,14jan04,rrl Support unions
40a,23oct03,eys Added enum support
40a,23oct03,eys Added USER_KEY support
40a,22oct03,eys Fixed bug in finalized
40a,15oct03,eys Make sure buffer created for serialization has a size that
                is a multiple of 4 plus REDABuffer size.
40a,29sep03,eys Added getBasePlugin() method
40a,25sep03,eys Fixed include of other idl files
40a,09sep03,eys Fixed spelling.
40a,25sep03,eys Fixed octet, wchar type output.
            added #define if there are long long or long double fields
40a,09sep03,eys Fixed output after comparing with presentation typePlugin
            examples
40a,09sep03,eys Added variable declaration in finalizeInstance
40a,09sep03,eys Added code to allocate memory for all pointers field
40a,07sep03,rrl Support all the remaining methods including finalizeInstance()
40a,04sep03,rrl Enable error checking
40a,27aug03,rrl Support for sequences and wstring. Refactored to use method templates
                from generation-info.c.xml.
40a,18aug02,rrl Heavily refactored to improve scalability. Added print and init method
                generation.
40a,14aug03,rrl Refactored to use template strings for method generation.                
40a,08aug03,rrl Modified variable names to use a more consistent style
-->

<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
<!ENTITY namespaceSeperator "_">    <!-- namespace separator -->
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:xalan = "http://xml.apache.org/xalan">

<xsl:include href="typeCommon.c.xsl"/>

<xsl:param name="rtidds42e"/>
<xsl:param name="metp"/>
<xsl:param name="noKeyCode"/>
<xsl:param name="mutExtEncapsulation"/>

<xsl:output method="text"/>

<xsl:variable name="sourcePreamble" select="$generationInfo/sourcePreamble[@kind = 'type-plugin-source']"/>

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
<xsl:value-of select="$sourcePreamble"/>
#include "<xsl:value-of select="concat($idlFileBaseName, 'Plugin', '.h')"/>"

<xsl:if test="$metp ='yes'">
#include "metp/metp_type_plugin.h"
</xsl:if>

<xsl:apply-templates/>
</xsl:template>


<!--
 E n u m     T y p e s
-->

<!-- Output form:
     
    RTIBool <fullyQualifiedName>_serialize(...) {
         [serialize value]
    }
    
    ... same for deserialization, print, init ...     
-->

<xsl:template match="enum">
    <xsl:param name="containerNamespace"/>
    <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace, @name)"/>
    <xsl:variable name="isBitSet" select="./@bitSet"/>

    <xsl:variable name="xType">
        <xsl:call-template name="getExtensibilityKind">
            <xsl:with-param name="structName" select="./@name"/>
            <xsl:with-param name="node" select="."/>
            <xsl:with-param name="typeKind" select="'enum'"/>
        </xsl:call-template>
    </xsl:variable>

  <xsl:variable name="className">
      <xsl:if test="$isBitSet='no'"> <!-- ENUM -->
          <xsl:choose>
              <xsl:when test="((./@bitBound &gt; 16) and (./@bitBound &lt; 33)) or not(./@bitBound)">
                  <xsl:text>Enum</xsl:text>
              </xsl:when>
              <xsl:when test="(./@bitBound &gt; 0) and (./@bitBound &lt; 17)">
                  <xsl:text>Short</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                  <xsl:message terminate="yes"> <!-- unaccebtable  value-->
    Error. Invalid value for "bitBound" directive associated to <xsl:value-of select="$fullyQualifiedStructName"/> enum.
    Valid range is 1-64.
                  </xsl:message>
              </xsl:otherwise>
          </xsl:choose>
      </xsl:if>
      <xsl:if test="$isBitSet='yes'"> <!-- BITSET -->
          <xsl:choose>
          <xsl:when test="(./@bitBound &lt; 1) or (./@bitBound &gt; 64)">
              <xsl:message terminate="yes"> <!-- unaccebtable  value-->
Error. Invalid value for "bitBound" directive associated to <xsl:value-of select="$fullyQualifiedStructName"/> enum.
Valid range is 1-64.
              </xsl:message>
          </xsl:when>
          <xsl:when test="(./@bitBound &gt; 0) and (./@bitBound &lt; 9)">
              <xsl:text>Octet</xsl:text>
          </xsl:when>
          <xsl:when test="(./@bitBound &gt; 8) and (./@bitBound &lt; 17)">
              <xsl:text>UnsignedShort</xsl:text>
          </xsl:when>
          <xsl:when test="(./@bitBound &gt; 16) and (./@bitBound &lt; 33)">
              <xsl:text>UnsignedLong</xsl:text>
          </xsl:when>
          <xsl:when test="(./@bitBound &gt; 32) and (./@bitBound &lt; 65)">
              <xsl:text>UnsignedLongLong</xsl:text>
          </xsl:when>
      </xsl:choose>
      </xsl:if>
  </xsl:variable>

    <xsl:variable name="fullyQualifiedStructNameCPP">
        <xsl:value-of select="'::'"/>
        <xsl:for-each select="./ancestor::module">
            <xsl:value-of select="@name"/>
            <xsl:text>::</xsl:text>                
        </xsl:for-each>
        <xsl:value-of select="@name"/>
    </xsl:variable>

    <xsl:variable name="selfFullyQualifiedStructName">
        <xsl:choose>
            <xsl:when test="$language = 'C++' and $namespace='yes'">
                <xsl:value-of select="$fullyQualifiedStructNameCPP"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$fullyQualifiedStructName"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

/* ------------------------------------------------------------------------
   Enum Type: <xsl:value-of select="$fullyQualifiedStructName"/>
 * ------------------------------------------------------------------------- */
 
/* ------------------------------------------------------------------------
 * (De)Serialization Methods
 * ------------------------------------------------------------------------ */

<!-- serialize method -->
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_serialize(
    PRESTypePluginEndpointData endpoint_data,
    const <xsl:value-of select="$fullyQualifiedStructName"/> *sample,
    struct RTICdrStream *stream, 
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_sample,
    void *endpoint_plugin_qos)
{
    char * position = NULL;
<xsl:if test="$rtidds42e='yes'">
    RTIBool topLevel;
</xsl:if>
<xsl:if test="$className != 'Enum'">
    DDS_<xsl:value-of select="$className"/> tmpSample;
</xsl:if>

    if (endpoint_data) {} /* To avoid warnings */
    if (endpoint_plugin_qos) {} /* To avoid warnings */

<xsl:if test="$className != 'Enum'">
    tmpSample = (DDS_<xsl:value-of select="$className"/>) *sample;
</xsl:if>

    if(serialize_encapsulation) {
        if (!RTICdrStream_serializeAndSetCdrEncapsulation(stream, encapsulation_id)) {
            return RTI_FALSE;
        }

<xsl:if test="$rtidds42e='no'">
        position = RTICdrStream_resetAlignment(stream);
</xsl:if>
    }

    if(serialize_sample) {
<xsl:if test="$rtidds42e='yes'">
        topLevel = !RTICdrStream_isDirty(stream);
        RTICdrStream_setDirtyBit(stream,RTI_TRUE);

        if (!serialize_encapsulation &amp;&amp; topLevel) {
            position = RTICdrStream_resetAlignmentWithOffset(stream,4);
        }
</xsl:if>

<xsl:if test="$className != 'Enum'">
        if (!RTICdrStream_serialize<xsl:value-of select="$className"/>(stream, &amp;tmpSample))
        {
            return RTI_FALSE;
        }
</xsl:if>
<xsl:if test="$className = 'Enum'">
        if (!RTICdrStream_serialize<xsl:value-of select="$className"/>(stream, sample))
        {
            return RTI_FALSE;
        }
</xsl:if>

<xsl:if test="$rtidds42e='yes'">
        if (!serialize_encapsulation &amp;&amp; topLevel) {
            RTICdrStream_restoreAlignment(stream,position);
        }
</xsl:if>
    }

<xsl:if test="$rtidds42e='no'">
    if(serialize_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }
</xsl:if>

    return RTI_TRUE;
}

<!-- deserialize_sample method -->
RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_deserialize_sample(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> *sample,
    struct RTICdrStream *stream, 
    RTIBool deserialize_encapsulation,  
    RTIBool deserialize_sample, 
    void *endpoint_plugin_qos)
{
    char * position = NULL;
<xsl:if test="$isBitSet='no' and ($xType='MUTABLE_EXTENSIBILITY' or $xType='EXTENSIBLE_EXTENSIBILITY')"> 
    DDS_<xsl:value-of select="$className"/> enum_tmp; 
</xsl:if>

<xsl:if test="$rtidds42e='yes'">
    RTIBool topLevel;
</xsl:if>
    if (endpoint_data) {} /* To avoid warnings */
    if (endpoint_plugin_qos) {} /* To avoid warnings */

    if(deserialize_encapsulation) {
        if (!RTICdrStream_deserializeAndSetCdrEncapsulation(stream)) {
            return RTI_FALSE;
        }

<xsl:if test="$rtidds42e='no'">
        position = RTICdrStream_resetAlignment(stream);
</xsl:if>
    }

    if(deserialize_sample) {
<xsl:if test="$rtidds42e='yes'">
        topLevel = !RTICdrStream_isDirty(stream);
        RTICdrStream_setDirtyBit(stream,RTI_TRUE);

        if (!deserialize_encapsulation &amp;&amp; topLevel) {
            position = RTICdrStream_resetAlignmentWithOffset(stream,4);
        }
</xsl:if>

<xsl:if test="$isBitSet='no' and ($xType='MUTABLE_EXTENSIBILITY' or $xType='EXTENSIBLE_EXTENSIBILITY')"> 
        if (!RTICdrStream_deserialize<xsl:value-of select="$className"/>(stream, &amp;enum_tmp))
        {
            return RTI_FALSE;
        }
        switch (enum_tmp) {
</xsl:if>


<xsl:apply-templates mode="code-generation">
     <xsl:with-param name="generationMode" select="'deserialize'"/>
     <xsl:with-param name="xType" select="$xType"/>
     <xsl:with-param name="isBitSet" select="$isBitSet"/>
</xsl:apply-templates>

<xsl:if test="$isBitSet='yes' or ($xType!='MUTABLE_EXTENSIBILITY' and $xType!='EXTENSIBLE_EXTENSIBILITY')"> 
        if (!RTICdrStream_deserialize<xsl:value-of select="$className"/>(stream, sample))
        {
            return RTI_FALSE;
        } 
</xsl:if>

<xsl:if test="$isBitSet='no' and ($xType='MUTABLE_EXTENSIBILITY' or $xType='EXTENSIBLE_EXTENSIBILITY')">
            default:
            {
                stream->_xTypesState.unassignable = RTI_TRUE;
                return RTI_FALSE;
            }
        }
</xsl:if>

<xsl:if test="$rtidds42e='yes'">
        if (!deserialize_encapsulation &amp;&amp; topLevel) {
            RTICdrStream_restoreAlignment(stream,position);
        }
</xsl:if>
    }

<xsl:if test="$rtidds42e='no'">
    if(deserialize_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }
</xsl:if>

    return RTI_TRUE;
}

<!-- skip method -->
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_skip(
    PRESTypePluginEndpointData endpoint_data,
    struct RTICdrStream *stream, 
    RTIBool skip_encapsulation,  
    RTIBool skip_sample, 
    void *endpoint_plugin_qos)
{
    char * position = NULL;
<xsl:if test="$rtidds42e='yes'">
    RTIBool topLevel;
</xsl:if>

    if (endpoint_data) {} /* To avoid warnings */
    if (endpoint_plugin_qos) {} /* To avoid warnings */

    if(skip_encapsulation) {
        if (!RTICdrStream_skipEncapsulation(stream)) {
            return RTI_FALSE;
        }

<xsl:if test="$rtidds42e='no'">
        position = RTICdrStream_resetAlignment(stream);
</xsl:if>
    }

    if(skip_sample) {
<xsl:if test="$rtidds42e='yes'">
        topLevel = !RTICdrStream_isDirty(stream);
        RTICdrStream_setDirtyBit(stream,RTI_TRUE);

        if (!skip_encapsulation &amp;&amp; topLevel) {
            RTICdrStream_setDirtyBit(stream,RTI_TRUE);
            position = RTICdrStream_resetAlignmentWithOffset(stream,4);
        }
</xsl:if>
        if (!RTICdrStream_skip<xsl:value-of select="$className"/>(stream)) {
            return RTI_FALSE;
        }
<xsl:if test="$rtidds42e='yes'">
        if (!skip_encapsulation &amp;&amp; topLevel) {
            RTICdrStream_restoreAlignment(stream,position);
        }
</xsl:if>

    }

<xsl:if test="$rtidds42e='no'">
    if(skip_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }
</xsl:if>

    return RTI_TRUE;
}

<!-- get_max_size_serialized method -->
unsigned int <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_serialized_sample_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment)
{
    unsigned int initial_alignment = current_alignment;
<xsl:if test="$rtidds42e='no'">
    unsigned int encapsulation_size = current_alignment;
</xsl:if>

    if (endpoint_data) {} /* To avoid warnings */

    if (include_encapsulation) {
        if (!RTICdrEncapsulation_validEncapsulationId(encapsulation_id)) {
            return 1;
        }

<xsl:if test="$rtidds42e='no'">
        RTICdrStream_getEncapsulationSize(encapsulation_size);
        encapsulation_size -= current_alignment;
        current_alignment = 0;
        initial_alignment = 0;
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
        RTICdrStream_getEncapsulationSize(current_alignment);
</xsl:if>
    }

    current_alignment += RTICdrType_get<xsl:value-of select="$className"/>MaxSizeSerialized(current_alignment);

<xsl:if test="$rtidds42e='no'">
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }
</xsl:if>

    return current_alignment - initial_alignment;
}

<!-- get_min_size_serialized method -->
unsigned int <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_serialized_sample_min_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment)
{
    unsigned int initial_alignment = current_alignment;

    current_alignment += <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_get_serialized_sample_max_size(
        endpoint_data,include_encapsulation,
        encapsulation_id, current_alignment);

    return current_alignment - initial_alignment;
}

<!-- get_serialized_sample_size method -->
unsigned int
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_serialized_sample_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment,
    const <xsl:value-of select="$fullyQualifiedStructName"/> * sample) 
{
    unsigned int initial_alignment = current_alignment;

    if (sample) {} /* To avoid warnings */ 

    current_alignment += <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_get_serialized_sample_max_size(
        endpoint_data,include_encapsulation,
        encapsulation_id, current_alignment);

    return current_alignment - initial_alignment;
}

<!-- ************************************************************************** -->
<!-- ************************************************************************** -->
<!-- ************************************************************************** -->

<xsl:if test="$desSampleCode = 'yes'">
<!-- get_deserialized_sample_min_size method -->
unsigned int
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_deserialized_sample_min_size(
    PRESTypePluginEndpointData endpoint_data,
    unsigned int current_alignment,
    RTIBool only_members)
{
    unsigned int size = 0;

    if (!only_members) {
        size = (unsigned int)
                    RTIOsapiAlignment_alignSizeUp(
                        (unsigned int)current_alignment, 
                        sizeof(<xsl:value-of select="$fullyQualifiedStructName"/>));
        size += sizeof(<xsl:value-of select="$selfFullyQualifiedStructName"/>);
        size -= current_alignment;
    }
    return size;
}

<!-- get_deserialized_sample_size method -->
RTIBool
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_deserialized_sample_size(
    PRESTypePluginEndpointData endpoint_data,
    unsigned int * size,
    RTIBool skip_encapsulation,
    RTIBool skip_sample,
    unsigned int current_alignment,
    RTIBool only_members,
    struct RTICdrStream *stream,
    void *endpoint_plugin_qos)
{
    char * position = NULL;

    if (endpoint_plugin_qos) {} /* To avoid warnings */
    if (endpoint_data) {} /* To avoid warnings */

    if(skip_encapsulation) {
        if (!RTICdrStream_skipEncapsulation(stream)) {
            return RTI_FALSE;
        }

        position = RTICdrStream_resetAlignment(stream);
    }

    if(skip_sample) {
        if (!RTICdrStream_skip<xsl:value-of select="$className"/>(stream)) {
            return RTI_FALSE;
        }
        
        *size = <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_get_deserialized_sample_min_size(
                   endpoint_data, current_alignment, only_members);
    }

    if(skip_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }

    return RTI_TRUE;
}


RTIBool
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_initialize_deserialization_buffer_pointers(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> * sample,
    struct REDABufferManager *buffer_manager,
    void *endpoint_plugin_qos)
{
    if (endpoint_plugin_qos) {} /* To avoid warnings */
    if (endpoint_data) {} /* To avoid warnings */
    if (sample) {} /* To avoid warnings */
    
    return RTI_TRUE;
}

RTIBool
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_initialize_deserialization_buffer_pointers_from_stream(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> * sample,
    RTIBool skip_encapsulation,
    RTIBool skip_sample,
    struct REDABufferManager *buffer_manager,
    struct RTICdrStream *stream,
    void *endpoint_plugin_qos)
{
    char * position = NULL;

    if (endpoint_plugin_qos) {} /* To avoid warnings */
    if (endpoint_data) {} /* To avoid warnings */

    if(skip_encapsulation) {
        if (!RTICdrStream_skipEncapsulation(stream)) {
            return RTI_FALSE;
        }

        position = RTICdrStream_resetAlignment(stream);
    }

    if(skip_sample) {
        if (!RTICdrStream_skip<xsl:value-of select="$className"/>(stream)) {
            return RTI_FALSE;
        }
    }

    if(skip_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }

    return RTI_TRUE;
}

RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_initialize_deserialization_buffer_pointers_from_sample(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> *dst,
    struct REDABufferManager *buffer_manager,
    const <xsl:value-of select="$fullyQualifiedStructName"/> *src) {

    if (endpoint_data) {} /* To avoid warnings */
    if (dst) {} /* To avoid warnings */
    if (src) {} /* To avoid warnings */
    if (buffer_manager) {} /* To avoid warnings */
    
    return RTI_TRUE;
}

</xsl:if>

<!-- ************************************************************************** -->
<!-- ************************************************************************** -->
<!-- ************************************************************************** -->

<xsl:if test="$noKeyCode='no'">
/* ------------------------------------------------------------------------
    Key Management functions:
 * ------------------------------------------------------------------------ */

<!-- serialize_key method -->
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_serialize_key(
    PRESTypePluginEndpointData endpoint_data,
    const <xsl:value-of select="$fullyQualifiedStructName"/> *sample, 
    struct RTICdrStream *stream, 
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_key,
    void *endpoint_plugin_qos)
{   
    return <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_serialize(
            endpoint_data, sample, stream, 
            serialize_encapsulation, encapsulation_id, 
            serialize_key, endpoint_plugin_qos);
}

<!-- deserialize_key_sample method -->
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_deserialize_key_sample(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> *sample,
    struct RTICdrStream *stream, 
    RTIBool deserialize_encapsulation,  
    RTIBool deserialize_key, 
    void *endpoint_plugin_qos)
{   
    return <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_deserialize_sample(
            endpoint_data, sample, stream, deserialize_encapsulation, 
            deserialize_key, endpoint_plugin_qos);
}

<!-- serialized_key_max_size method -->
unsigned int <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_serialized_key_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment)
{
    unsigned int initial_alignment = current_alignment;

    current_alignment += <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_get_serialized_sample_max_size(
        endpoint_data,include_encapsulation,
        encapsulation_id, current_alignment);

    return current_alignment - initial_alignment;
}

<!-- serialized_sample_to_key -->
RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_serialized_sample_to_key(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> *sample,
    struct RTICdrStream *stream, 
    RTIBool deserialize_encapsulation,  
    RTIBool deserialize_key, 
    void *endpoint_plugin_qos)
{    
    return <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_deserialize_sample(
            endpoint_data, sample, stream, deserialize_encapsulation, 
            deserialize_key, endpoint_plugin_qos);
}

</xsl:if> <!--  noKeyCode -->
/* ----------------------------------------------------------------------------
    Support functions:
 * ---------------------------------------------------------------------------- */

<!-- print_data method -->
void <xsl:value-of select="$fullyQualifiedStructName"/>PluginSupport_print_data(
    const <xsl:value-of select="$fullyQualifiedStructName"/> *sample,
    const char *description, int indent_level)
{
    if (description != NULL) {
        RTICdrType_printIndent(indent_level);
        RTILog_debug("%s:\n", description);
    }

    if (sample == NULL) {
        RTICdrType_printIndent(indent_level+1);
        RTILog_debug("NULL\n");
        return;
    }

    RTICdrType_print<xsl:value-of select="$className"/>((RTICdr<xsl:value-of select="$className"/> *)sample, "<xsl:value-of select="$fullyQualifiedStructName"/>", indent_level + 1);
}

</xsl:template>


<!--
 
  S t r u c t     T y p e s 

-->

<xsl:template match="struct|typedef">
  <xsl:param name="containerNamespace"/>
  <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace, @name)"/>

  <xsl:variable name="xType">
    <xsl:call-template name="getExtensibilityKind">
        <xsl:with-param name="structName" select="./@name"/>
        <xsl:with-param name="node" select="."/>
    </xsl:call-template>
  </xsl:variable>
  
  <xsl:variable name="mutableTypeStartDesBlock">
        <xsl:text>
        while (end != RTI_TRUE &amp;&amp; RTICdrStream_getRemainder(stream) > 0) {
            if (!RTICdrStream_deserializeParameterHeader(
                     stream,
                     &amp;state,
                     &amp;memberId,
                     &amp;length,
                     &amp;extended,
                     &amp;mustUnderstand)) {
                return RTI_FALSE;
            }
            
            if (!extended) {
                if (memberId == RTI_CDR_PID_LIST_END) {
                    end = RTI_TRUE;
                    RTICdrStream_moveToNextParameterHeader(stream, &amp;state, length);
                    continue;
                } else if (memberId == RTI_CDR_PID_IGNORE) {
                    RTICdrStream_moveToNextParameterHeader(stream, &amp;state, length);
                    continue;
                }
            }
            
            switch (memberId) {</xsl:text>
  </xsl:variable>
  
  <xsl:variable name="mutableTypeEndDesBlock">
    <xsl:text>
                default:</xsl:text>
      <xsl:if test="@kind!='union'">
    <xsl:text>
                    if (mustUnderstand) {</xsl:text>
      </xsl:if>
    <xsl:text>
                        return RTI_FALSE;</xsl:text>
      <xsl:if test="@kind!='union'">
    <xsl:text>
                    } break; </xsl:text>
      </xsl:if>
    <xsl:text>
            }
            RTICdrStream_moveToNextParameterHeader(stream, &amp;state, length);
        }</xsl:text>
  </xsl:variable>

  <xsl:variable name="fullyQualifiedStructNameCPP">
      <xsl:value-of select="'::'"/>
      <xsl:for-each select="./ancestor::module">
          <xsl:value-of select="@name"/>
          <xsl:text>::</xsl:text>                
      </xsl:for-each>
      <xsl:value-of select="@name"/>
  </xsl:variable>

  <xsl:variable name="selfFullyQualifiedStructName">
      <xsl:choose>
          <xsl:when test="$language = 'C++' and $namespace='yes'">
              <xsl:value-of select="$fullyQualifiedStructNameCPP"/>
          </xsl:when>
          <xsl:otherwise>
              <xsl:value-of select="$fullyQualifiedStructName"/>
          </xsl:otherwise>
      </xsl:choose>
  </xsl:variable>

  <xsl:variable name="sequenceFields" select="member[@kind='sequence']"/>
  <xsl:variable name="keyFields"
      select="member[following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'key']]"/>
  <xsl:variable name="isKeyed">
      <xsl:choose>
          <xsl:when test="directive[@kind='key'] or (@keyedBaseClass and @keyedBaseClass='yes')">yes</xsl:when>
          <xsl:otherwise>no</xsl:otherwise>
      </xsl:choose>
  </xsl:variable>

  <xsl:apply-templates mode="error-checking"/>
  
<xsl:variable name="topLevel">
    <xsl:call-template name="isTopLevelType">
        <xsl:with-param name="typeNode" select="."/>
    </xsl:call-template>
</xsl:variable>

<xsl:variable name="generateCode">
    <xsl:call-template name="isNecessaryGenerateCode">
        <xsl:with-param name="typedefNode" select="."/>
    </xsl:call-template>                                
</xsl:variable>

<xsl:if test="$generateCode='yes'">
/* --------------------------------------------------------------------------------------
 *  Type <xsl:value-of select="$fullyQualifiedStructName"/>
 * -------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------
    Support functions:
 * -------------------------------------------------------------------------------------- */

<xsl:if test="$metp ='yes'">

RTI_UINT64 
<xsl:value-of select="$selfFullyQualifiedStructName"/>PluginSupport_get_max_deserialized_size_metp(void)
{
    return (RTI_UINT64)sizeof(<xsl:value-of select="$fullyQualifiedStructName"/>);
}

</xsl:if>    

<!-- create_data_w_params method -->
<xsl:value-of select="$fullyQualifiedStructName"/>*
<xsl:value-of select="$fullyQualifiedStructName"/>PluginSupport_create_data_w_params(
    const struct DDS_TypeAllocationParams_t * alloc_params){
    <xsl:value-of select="$fullyQualifiedStructName"/> *sample = NULL;

    RTIOsapiHeap_allocateStructure(
        &amp;sample, <xsl:value-of select="$fullyQualifiedStructName"/>);

    if(sample != NULL) {
        if (!<xsl:value-of select="$selfFullyQualifiedStructName"/>_initialize_w_params(sample,alloc_params)) {
            RTIOsapiHeap_freeStructure(sample);
            return NULL;
        }
    }        
    return sample; 
}

<!-- create_data_ex method -->
<xsl:value-of select="$fullyQualifiedStructName"/> *
<xsl:value-of select="$fullyQualifiedStructName"/>PluginSupport_create_data_ex(RTIBool allocate_pointers){
    <xsl:value-of select="$fullyQualifiedStructName"/> *sample = NULL;

    RTIOsapiHeap_allocateStructure(
        &amp;sample, <xsl:value-of select="$fullyQualifiedStructName"/>);

    if(sample != NULL) {
        if (!<xsl:value-of select="$selfFullyQualifiedStructName"/>_initialize_ex(sample,allocate_pointers, RTI_TRUE)) {
            RTIOsapiHeap_freeStructure(sample);
            return NULL;
        }
    }        
    return sample; 
}

<!-- create_data method -->
<xsl:value-of select="$fullyQualifiedStructName"/> *
<xsl:value-of select="$fullyQualifiedStructName"/>PluginSupport_create_data(void)
{
    return <xsl:value-of select="$selfFullyQualifiedStructName"/>PluginSupport_create_data_ex(RTI_TRUE);
}

<!-- destroy_data_w_params method -->
void 
<xsl:value-of select="$fullyQualifiedStructName"/>PluginSupport_destroy_data_w_params(
    <xsl:value-of select="$fullyQualifiedStructName"/> *sample,
    const struct DDS_TypeDeallocationParams_t * dealloc_params) {

    <xsl:value-of select="$selfFullyQualifiedStructName"/>_finalize_w_params(sample,dealloc_params);

    RTIOsapiHeap_freeStructure(sample);
}

<!-- destroy_data_ex method -->
void 
<xsl:value-of select="$fullyQualifiedStructName"/>PluginSupport_destroy_data_ex(
    <xsl:value-of select="$fullyQualifiedStructName"/> *sample,RTIBool deallocate_pointers) {

    <xsl:value-of select="$selfFullyQualifiedStructName"/>_finalize_ex(sample,deallocate_pointers);

    RTIOsapiHeap_freeStructure(sample);
}

<!-- destroy_data method -->
void 
<xsl:value-of select="$fullyQualifiedStructName"/>PluginSupport_destroy_data(
    <xsl:value-of select="$fullyQualifiedStructName"/> *sample) {

    <xsl:value-of select="$selfFullyQualifiedStructName"/>PluginSupport_destroy_data_ex(sample,RTI_TRUE);

}

<!-- copy_data method -->
RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>PluginSupport_copy_data(
    <xsl:value-of select="$fullyQualifiedStructName"/> *dst,
    const <xsl:value-of select="$fullyQualifiedStructName"/> *src)
{
    return <xsl:value-of select="$selfFullyQualifiedStructName"/>_copy(dst,src);
}

<!-- print_data method -->
void 
<xsl:value-of select="$fullyQualifiedStructName"/>PluginSupport_print_data(
    const <xsl:value-of select="$fullyQualifiedStructName"/> *sample,
    const char *desc,
    unsigned int indent_level)
{
<xsl:if test="member[@bitField]">
    RTICdrLong bit_val = 0;
</xsl:if>

    RTICdrType_printIndent(indent_level);

    if (desc != NULL) {
      RTILog_debug("%s:\n", desc);
    } else {
      RTILog_debug("\n");
    }

    if (sample == NULL) {
      RTILog_debug("NULL\n");
      return;
    }

<xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass != ''">
  <xsl:text>    </xsl:text>
  <xsl:value-of select="@baseClass"/>
  <xsl:text>PluginSupport_print_data((const </xsl:text>
  <xsl:value-of select="@baseClass"/>
  <xsl:text>*)sample,"",indent_level);&nl;</xsl:text>        
</xsl:if>

<xsl:if test="@kind = 'union'">
<!-- Don't generate any code for unions, since using pointer fields in union is dangerous -->
  <xsl:call-template name="generateMemberCode">
    <xsl:with-param name="generationMode" select="'print'"/>
    <xsl:with-param name="member" select="./discriminator"/>
  </xsl:call-template>
</xsl:if>

<xsl:apply-templates mode="code-generation">
  <xsl:with-param name="generationMode" select="'print'"/>
</xsl:apply-templates>

}

<xsl:if test="$isKeyed='yes'"> <!-- ONLY for Keyed types -->

<!-- create_key_ex method -->
<xsl:value-of select="$fullyQualifiedStructName"/> *
<xsl:value-of select="$fullyQualifiedStructName"/>PluginSupport_create_key_ex(RTIBool allocate_pointers){
    <xsl:value-of select="$fullyQualifiedStructName"/> *key = NULL;

    RTIOsapiHeap_allocateStructure(
        &amp;key, <xsl:value-of select="$fullyQualifiedStructName"/>KeyHolder);

    <xsl:value-of select="$selfFullyQualifiedStructName"/>_initialize_ex(key,allocate_pointers,RTI_TRUE);
    return key;
}

<!-- create_key method -->
<xsl:value-of select="$fullyQualifiedStructName"/> *
<xsl:value-of select="$fullyQualifiedStructName"/>PluginSupport_create_key(void)
{
    return  <xsl:value-of select="$selfFullyQualifiedStructName"/>PluginSupport_create_key_ex(RTI_TRUE);
}

<!-- destroy_key_ex method -->
void 
<xsl:value-of select="$fullyQualifiedStructName"/>PluginSupport_destroy_key_ex(
    <xsl:value-of select="$fullyQualifiedStructName"/>KeyHolder *key,RTIBool deallocate_pointers)
{
    <xsl:value-of select="$selfFullyQualifiedStructName"/>_finalize_ex(key,deallocate_pointers);

    RTIOsapiHeap_freeStructure(key);
}

<!-- destroy_key method -->
void 
<xsl:value-of select="$fullyQualifiedStructName"/>PluginSupport_destroy_key(
    <xsl:value-of select="$fullyQualifiedStructName"/>KeyHolder *key) {

  <xsl:value-of select="$selfFullyQualifiedStructName"/>PluginSupport_destroy_key_ex(key,RTI_TRUE);

}

</xsl:if>

<xsl:if test="$topLevel='yes'">
/* ----------------------------------------------------------------------------
    Callback functions:
 * ---------------------------------------------------------------------------- */
<xsl:if test="$metp ='yes'">

RTI_PRIVATE <xsl:value-of select="$fullyQualifiedStructName"/>*
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_create_metp_data(void)
{
    return (<xsl:value-of select="$fullyQualifiedStructName"/>*)RTI_METP_INVALID_SAMPLE_ADDRESS;
}

RTI_PRIVATE void
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_destroy_metp_data(void* sample)
{
}
</xsl:if>

<!-- on_participant_attached method -->
PRESTypePluginParticipantData 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_on_participant_attached(
    void *registration_data,
    const struct PRESTypePluginParticipantInfo *participant_info,
    RTIBool top_level_registration,
    void *container_plugin_context,
    RTICdrTypeCode *type_code)
{
<xsl:if test="$metp ='yes'">
    PRESTypePluginParticipantData epd;
    
    epd = PRESTypePluginDefaultParticipantData_new(participant_info);
    
    return METypePlugin_on_participant_attached(epd,
                                                registration_data,
                                                participant_info,
                                                top_level_registration,
                                                container_plugin_context,
                                                type_code);
</xsl:if>
<xsl:if test="$metp ='no'">
    if (registration_data) {} /* To avoid warnings */
    if (participant_info) {} /* To avoid warnings */
    if (top_level_registration) {} /* To avoid warnings */
    if (container_plugin_context) {} /* To avoid warnings */
    if (type_code) {} /* To avoid warnings */
    return PRESTypePluginDefaultParticipantData_new(participant_info);
</xsl:if>
}

<!-- on_participant_detached method -->
void 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_on_participant_detached(
    PRESTypePluginParticipantData participant_data)
{
<xsl:if test="$metp ='yes'">
  METypePlugin_on_participant_detached(participant_data);
</xsl:if>
  PRESTypePluginDefaultParticipantData_delete(participant_data);
}

<!-- on_endpoint_attached method -->
PRESTypePluginEndpointData
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_on_endpoint_attached(
    PRESTypePluginParticipantData participant_data,
    const struct PRESTypePluginEndpointInfo *endpoint_info,
    RTIBool top_level_registration, 
    void *containerPluginContext)
{
    PRESTypePluginEndpointData epd = NULL;
<xsl:if test="$metp='yes'">
    void *plugin = NULL;
</xsl:if>
    unsigned int serializedSampleMaxSize;
<xsl:choose>
    <xsl:when test="$isKeyed='yes'">
    unsigned int serializedKeyMaxSize;

    if (top_level_registration) {} /* To avoid warnings */
    if (containerPluginContext) {} /* To avoid warnings */

<xsl:if test="$metp='yes'">
   if (endpoint_info->endpointKind == PRES_TYPEPLUGIN_ENDPOINT_WRITER) {
        plugin = DDS_Entity_get_reserved_dataI(
                DDS_DataWriter_as_entity(endpoint_info->reserved));
    } else {
        plugin = DDS_Entity_get_reserved_dataI(
                DDS_DataReader_as_entity(endpoint_info->reserved));
    }
    if (plugin != NULL) {
        epd = PRESTypePluginDefaultEndpointData_new(
            participant_data,
            endpoint_info,
            (PRESTypePluginDefaultEndpointDataCreateSampleFunction)
            <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_create_metp_data,
            (PRESTypePluginDefaultEndpointDataDestroySampleFunction)
            <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_destroy_metp_data,
            (PRESTypePluginDefaultEndpointDataCreateKeyFunction)
            <xsl:value-of select="$selfFullyQualifiedStructName"/>PluginSupport_create_key,
            (PRESTypePluginDefaultEndpointDataDestroyKeyFunction)
            <xsl:value-of select="$selfFullyQualifiedStructName"/>PluginSupport_destroy_key);
    } else {
        epd = PRESTypePluginDefaultEndpointData_new(
            participant_data,
            endpoint_info,
            (PRESTypePluginDefaultEndpointDataCreateSampleFunction)
            <xsl:value-of select="$selfFullyQualifiedStructName"/>PluginSupport_create_data,
            (PRESTypePluginDefaultEndpointDataDestroySampleFunction)
            <xsl:value-of select="$selfFullyQualifiedStructName"/>PluginSupport_destroy_data,
            (PRESTypePluginDefaultEndpointDataCreateKeyFunction)
            <xsl:value-of select="$selfFullyQualifiedStructName"/>PluginSupport_create_key,
            (PRESTypePluginDefaultEndpointDataDestroyKeyFunction)
            <xsl:value-of select="$selfFullyQualifiedStructName"/>PluginSupport_destroy_key);        
    }
            
</xsl:if>
<xsl:if test="$metp ='no'">
    epd = PRESTypePluginDefaultEndpointData_new(
            participant_data,
            endpoint_info,
            (PRESTypePluginDefaultEndpointDataCreateSampleFunction)
            <xsl:value-of select="$selfFullyQualifiedStructName"/>PluginSupport_create_data,
            (PRESTypePluginDefaultEndpointDataDestroySampleFunction)
            <xsl:value-of select="$selfFullyQualifiedStructName"/>PluginSupport_destroy_data,
            (PRESTypePluginDefaultEndpointDataCreateKeyFunction)
            <xsl:value-of select="$selfFullyQualifiedStructName"/>PluginSupport_create_key,
            (PRESTypePluginDefaultEndpointDataDestroyKeyFunction)
            <xsl:value-of select="$selfFullyQualifiedStructName"/>PluginSupport_destroy_key);
</xsl:if>
    if (epd == NULL) {
        return NULL;
    }
   
    serializedKeyMaxSize = <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_get_serialized_key_max_size(
        epd,RTI_FALSE,RTI_CDR_ENCAPSULATION_ID_CDR_BE,0);
    
    if (!PRESTypePluginDefaultEndpointData_createMD5Stream(
            epd,serializedKeyMaxSize)) 
    {
        PRESTypePluginDefaultEndpointData_delete(epd);
        return NULL;
    }
    
    </xsl:when>
    <xsl:otherwise>
   if (top_level_registration) {} /* To avoid warnings */
   if (containerPluginContext) {} /* To avoid warnings */
<xsl:if test="$metp='yes'">

   if (endpoint_info->endpointKind == PRES_TYPEPLUGIN_ENDPOINT_WRITER) {
        plugin = DDS_Entity_get_reserved_dataI(
                DDS_DataWriter_as_entity(endpoint_info->reserved));
    } else {
        plugin = DDS_Entity_get_reserved_dataI(
                DDS_DataReader_as_entity(endpoint_info->reserved));
    }
    if (plugin != NULL) {
        epd = PRESTypePluginDefaultEndpointData_new(
            participant_data,
            endpoint_info,
            (PRESTypePluginDefaultEndpointDataCreateSampleFunction)
            <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_create_metp_data,
            (PRESTypePluginDefaultEndpointDataDestroySampleFunction)
            <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_destroy_metp_data,
            NULL, NULL);
    } else {
        epd = PRESTypePluginDefaultEndpointData_new(
            participant_data,
            endpoint_info,
            (PRESTypePluginDefaultEndpointDataCreateSampleFunction)
            <xsl:value-of select="$selfFullyQualifiedStructName"/>PluginSupport_create_data,
            (PRESTypePluginDefaultEndpointDataDestroySampleFunction)
            <xsl:value-of select="$selfFullyQualifiedStructName"/>PluginSupport_destroy_data,
            NULL, NULL);
    }
</xsl:if>
<xsl:if test="$metp='no'">
    epd = PRESTypePluginDefaultEndpointData_new(
            participant_data,
            endpoint_info,
            (PRESTypePluginDefaultEndpointDataCreateSampleFunction)
            <xsl:value-of select="$selfFullyQualifiedStructName"/>PluginSupport_create_data,
            (PRESTypePluginDefaultEndpointDataDestroySampleFunction)
            <xsl:value-of select="$selfFullyQualifiedStructName"/>PluginSupport_destroy_data,
            NULL, NULL);
</xsl:if>
    if (epd == NULL) {
        return NULL;
    }

    </xsl:otherwise>
</xsl:choose>

    if (endpoint_info->endpointKind == PRES_TYPEPLUGIN_ENDPOINT_WRITER) {
        serializedSampleMaxSize = <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_get_serialized_sample_max_size(
            epd,RTI_FALSE,RTI_CDR_ENCAPSULATION_ID_CDR_BE,0);
            
        PRESTypePluginDefaultEndpointData_setMaxSizeSerializedSample(epd, serializedSampleMaxSize);

        if (PRESTypePluginDefaultEndpointData_createWriterPool(
                epd,
                endpoint_info,
            (PRESTypePluginGetSerializedSampleMaxSizeFunction)
                <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_get_serialized_sample_max_size, epd,
            (PRESTypePluginGetSerializedSampleSizeFunction)
            <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_get_serialized_sample_size,
            epd) == RTI_FALSE) {
            PRESTypePluginDefaultEndpointData_delete(epd);
            return NULL;
        }
    }
    
<xsl:if test="$metp ='yes'">
    if (!METypePlugin_on_endpoint_attached(participant_data,
                                           epd,
                                           endpoint_info,
                                           top_level_registration,
                                           containerPluginContext,
                                           (RTI_UINT64 (*)(void))
    <xsl:value-of select="$selfFullyQualifiedStructName"/>PluginSupport_get_max_deserialized_size_metp,
    (RTIBool(*)(void *,RTIBool))<xsl:value-of select="$selfFullyQualifiedStructName"/>_initialize_ex)) {
    }
</xsl:if>

    return epd;    
}

<!-- on_endpoint_detached method -->
void 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_on_endpoint_detached(
    PRESTypePluginEndpointData endpoint_data)
{  
<xsl:if test="$metp ='yes'">
    METypePlugin_on_endpoint_detached(endpoint_data);
</xsl:if>
    PRESTypePluginDefaultEndpointData_delete(endpoint_data);
}

<!-- return_sample method -->
void    
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_return_sample(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> *sample,
    void *handle)
{
    <!-- Release only optional members -->
    <xsl:value-of select="$fullyQualifiedStructName"/>_finalize_optional_members(sample, RTI_TRUE);
           
    PRESTypePluginDefaultEndpointData_returnSample(
        endpoint_data, sample, handle);
}
</xsl:if> <!--  topLevel -->

<!-- copy_sample method -->
RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_copy_sample(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> *dst,
    const <xsl:value-of select="$fullyQualifiedStructName"/> *src)
{
    if (endpoint_data) {} /* To avoid warnings */
    return <xsl:value-of select="$selfFullyQualifiedStructName"/>PluginSupport_copy_data(dst,src);
}

/* --------------------------------------------------------------------------------------
    (De)Serialize functions:
 * -------------------------------------------------------------------------------------- */

unsigned int 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_serialized_sample_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment);

<!-- serialize method -->
RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_serialize(
    PRESTypePluginEndpointData endpoint_data,
    const <xsl:value-of select="$fullyQualifiedStructName"/> *sample, 
    struct RTICdrStream *stream,    
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_sample, 
    void *endpoint_plugin_qos)
{
    char * position = NULL;
    RTIBool retval = RTI_TRUE;
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY' or (@kind!='union' and member[@optional='true'])">
    DDS_UnsignedLong memberId = 0;
    char *memberLengthPosition = NULL;
    RTIBool extended;
    struct RTICdrStreamState state;
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">    
    RTIBool ignoreListEndId = RTI_FALSE;
</xsl:if>
</xsl:if>

<xsl:if test="$metp ='yes'">
    RTIBool metp = RTI_FALSE;
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
    RTIBool topLevel;
</xsl:if>
<xsl:if test="member[@bitField]">
    RTICdrUnsignedLong bit_val = 0;
</xsl:if>

<xsl:if test="$metp ='no' and not((@kind='valuetype' or @kind='struct') and @baseClass != '')">
    if (endpoint_data) {} /* To avoid warnings */
    if (endpoint_plugin_qos) {} /* To avoid warnings */
</xsl:if>

    if(serialize_encapsulation) {
  <xsl:if test="$xType='MUTABLE_EXTENSIBILITY' or (@kind!='union' and member[@optional='true'])"> 
        if (encapsulation_id == RTI_CDR_ENCAPSULATION_ID_CDR_BE) {
            encapsulation_id = RTI_CDR_ENCAPSULATION_ID_PL_CDR_BE;
        } else if (encapsulation_id == RTI_CDR_ENCAPSULATION_ID_CDR_LE) {
            encapsulation_id = RTI_CDR_ENCAPSULATION_ID_PL_CDR_LE;
        }
  </xsl:if>
<xsl:if test="$metp ='yes'">
    if (!METypePlugin_serializeAndSetCdrEncapsulation(endpoint_data,stream,encapsulation_id,&amp;metp)) {
        return RTI_FALSE;
    }
</xsl:if>
<xsl:if test="$metp ='no'">
        if (!RTICdrStream_serializeAndSetCdrEncapsulation(stream, encapsulation_id)) {
            return RTI_FALSE;
        }
</xsl:if>

<xsl:if test="$rtidds42e='no'">
        position = RTICdrStream_resetAlignment(stream);
</xsl:if>
    }

<xsl:if test="$metp ='yes'">
    if(metp &amp;&amp; serialize_sample) {
        if (!METypePlugin_serialize(endpoint_data,
                                    sample,
                                    stream,
                                    serialize_encapsulation,
                                    encapsulation_id,
                                    serialize_sample,
                                    endpoint_plugin_qos,
                                    &amp;metp)) {
            return RTI_FALSE;
        }
    } else if(!metp &amp;&amp; METypePlugin_cdrEnabled(endpoint_data) &amp;&amp; serialize_sample) {
        METypePlugin_set_sample_serialized((const void*)sample);
</xsl:if>
<xsl:if test="$metp ='no'">
    if(serialize_sample) {
    <xsl:if test="$xType='MUTABLE_EXTENSIBILITY' or (@kind!='union' and member[@optional='true'])">
        if (RTICdrStream_isDirty(stream)) {
          <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
            ignoreListEndId = stream->_xTypesState.skipListEndId; 
          </xsl:if>
        } else {
            /* Top level */
            RTICdrStream_setDirtyBit(stream,RTI_TRUE);

<xsl:if test="$mutExtEncapsulation='yes'">
            stream->_xTypesState.useExtendedId = RTI_TRUE;
</xsl:if>
<xsl:if test="$mutExtEncapsulation='no'">
            if (PRESTypePluginDefaultEndpointData_getMaxSizeSerializedSample(endpoint_data) > 65535) {
                stream->_xTypesState.useExtendedId = RTI_TRUE;
            } else {
                stream->_xTypesState.useExtendedId = RTI_FALSE;
            }
</xsl:if>

        }

      <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        stream->_xTypesState.skipListEndId = RTI_FALSE;
      </xsl:if>
<xsl:text>&nl;</xsl:text>
    </xsl:if>
</xsl:if>

<xsl:if test="$rtidds42e='yes'">
    topLevel = !RTICdrStream_isDirty(stream);
    RTICdrStream_setDirtyBit(stream,RTI_TRUE);

    if (!serialize_encapsulation &amp;&amp; topLevel) {
      position = RTICdrStream_resetAlignmentWithOffset(stream,4);
    }
</xsl:if>

  <xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass != ''">
      <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        stream->_xTypesState.skipListEndId = RTI_TRUE;
      </xsl:if>
      <xsl:text>    if (!</xsl:text>
      <xsl:value-of select="@baseClass"/>
      <xsl:text>Plugin_serialize(endpoint_data,(const </xsl:text>
      <xsl:value-of select="@baseClass"/>
      <xsl:text>*)sample,stream,RTI_FALSE,encapsulation_id,RTI_TRUE,endpoint_plugin_qos)) {&nl;</xsl:text>        
      <xsl:text>        return RTI_FALSE;&nl;</xsl:text>
      <xsl:text>    }</xsl:text>
      <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        stream->_xTypesState.skipListEndId = RTI_FALSE;
      </xsl:if>
  </xsl:if>

  <xsl:if test="@kind = 'union'">
      <!-- For unions, create a member named _d (the union discriminator) and generate code for it -->
      <xsl:call-template name="generateMemberCode">
          <xsl:with-param name="generationMode" select="'serialize'"/>
          <xsl:with-param name="member" select="./discriminator"/>
      </xsl:call-template>
  </xsl:if>
  <xsl:apply-templates mode="code-generation">
      <xsl:with-param name="generationMode" select="'serialize'"/>
  </xsl:apply-templates>

<xsl:if test="$rtidds42e='yes'">
    if (!serialize_encapsulation &amp;&amp; topLevel) {
      RTICdrStream_restoreAlignment(stream,position);
    }
</xsl:if>

<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        if (!ignoreListEndId) {
            if (!RTICdrStream_serializeParameterHeader(
                stream,
                NULL,
                RTI_FALSE,
                RTI_CDR_PID_LIST_END,
                RTI_TRUE)) {
                return RTI_FALSE;
            }
        }
        stream->_xTypesState.skipListEndId = ignoreListEndId;
</xsl:if>
    }

<xsl:if test="$metp ='yes'">
else if (serialize_sample) {
    retval = RTI_FALSE;
}
</xsl:if>

<xsl:if test="$rtidds42e='no'">
    if(serialize_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }
</xsl:if>

  return retval;
}

<!-- deserialize_sample -->
RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_deserialize_sample(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> *sample,
    struct RTICdrStream *stream,   
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_sample, 
    void *endpoint_plugin_qos)
{
    char * position = NULL;
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY' or member[@optional='true']">
    DDS_UnsignedLong memberId = 0;
    DDS_UnsignedLong length = 0;
    RTIBool mustUnderstand = RTI_FALSE;
    struct RTICdrStreamState state;
    RTIBool extended;
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    RTIBool end = RTI_FALSE;
</xsl:if>    
</xsl:if>
<xsl:if test="(@kind='struct' or @kind='valuetype') and $xType='EXTENSIBLE_EXTENSIBILITY'">
    RTIBool done = RTI_FALSE;
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
    RTIBool topLevel;
</xsl:if>
<xsl:if test="member[@bitField]">
    RTICdrUnsignedLong bit_val = 0;
</xsl:if>

<xsl:if test="not((@kind='valuetype' or @kind='struct') and @baseClass != '')">
    if (endpoint_data) {} /* To avoid warnings */
    if (endpoint_plugin_qos) {} /* To avoid warnings */
</xsl:if>

    if(deserialize_encapsulation) {
        /* Deserialize encapsulation */
        if (!RTICdrStream_deserializeAndSetCdrEncapsulation(stream)) {
            return RTI_FALSE;
        }
<xsl:if test="$rtidds42e='no'">
        position = RTICdrStream_resetAlignment(stream);
</xsl:if>
    }
    
    <xsl:text>
    if(deserialize_sample) {
    </xsl:text>
<xsl:if test="$rtidds42e='yes'">
        topLevel = !RTICdrStream_isDirty(stream);
        RTICdrStream_setDirtyBit(stream,RTI_TRUE);
        if (!deserialize_encapsulation &amp;&amp; topLevel) {
            position = RTICdrStream_resetAlignmentWithOffset(stream,4);
        }
</xsl:if>

    <xsl:if test="($xType='MUTABLE_EXTENSIBILITY' or $xType='EXTENSIBLE_EXTENSIBILITY') and not(@kind = 'union')">
    <xsl:text>    </xsl:text><xsl:value-of select="$selfFullyQualifiedStructName"/>_initialize_ex(sample, RTI_FALSE, RTI_FALSE);
    </xsl:if>

  <xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass != ''">
      <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
          {
              char *begin = RTICdrStream_getCurrentPosition(stream);
              RTICdrStream_pushState(
                stream, &amp;state, -1);
      </xsl:if>
      <xsl:text>        if (!</xsl:text>
      <xsl:value-of select="@baseClass"/>
      <xsl:text>Plugin_deserialize_sample(endpoint_data,( </xsl:text>
      <xsl:value-of select="@baseClass"/>
      <xsl:text>*)sample,stream,RTI_FALSE,RTI_TRUE,endpoint_plugin_qos)) {&nl;</xsl:text> 
      <xsl:text>            return RTI_FALSE;&nl;</xsl:text>
      <xsl:text>        }</xsl:text>
      <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
            RTICdrStream_popState(
                stream, &amp;state);
            RTICdrStream_setCurrentPosition(stream, begin);
        }
      </xsl:if>
  </xsl:if>
  <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    <xsl:value-of select="$mutableTypeStartDesBlock"/>
  </xsl:if>
  <xsl:if test="@kind = 'union'">
      <!-- For unions, create a member named _d (the union discriminator) and generate code for it -->
      <xsl:call-template name="generateMemberCode">
          <xsl:with-param name="generationMode" select="'deserialize'"/>
          <xsl:with-param name="member" select="./discriminator"/>
      </xsl:call-template>
  </xsl:if>
  <xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'deserialize'"/>
  </xsl:apply-templates>
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    <xsl:value-of select="$mutableTypeEndDesBlock"/>
</xsl:if>
  <xsl:if test="$rtidds42e='yes'">
        if (!deserialize_encapsulation &amp;&amp; topLevel) {
            RTICdrStream_restoreAlignment(stream,position);
        }
</xsl:if>

<xsl:text>
    }
</xsl:text>
<xsl:if test="(@kind='struct' or @kind='valuetype') and $xType='EXTENSIBLE_EXTENSIBILITY'">
    done = RTI_TRUE;
fin:
    if (done != RTI_TRUE &amp;&amp; 
        RTICdrStream_getRemainder(stream) >=
            RTI_CDR_PARAMETER_HEADER_ALIGNMENT) {
        return RTI_FALSE;   
    }
</xsl:if>

<xsl:if test="$rtidds42e='no'">
    if(deserialize_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }
</xsl:if>

    return RTI_TRUE;
}

 <!-- deserialize_sample_metp -->
<xsl:if test="$metp ='yes'">
RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_deserialize_sample_metp(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> **sample_in,
    RTIBool *drop_sample,
    struct RTICdrStream *stream,   
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_sample, 
    void *endpoint_plugin_qos)
{
    char * position = NULL;
    RTIBool metp = RTI_FALSE;
<xsl:if test="$rtidds42e='yes'">
    RTIBool topLevel;
</xsl:if>
<xsl:if test="member[@bitField]">
    RTICdrUnsignedLong bit_val = 0;
</xsl:if>
    <xsl:value-of select="$fullyQualifiedStructName"/> *sample = *sample_in;
    if(deserialize_encapsulation) {
        /* Deserialize encapsulation */
        if (!METypePlugin_deserializeAndSetCdrEncapsulation(endpoint_data,stream,&amp;metp)) {
            return RTI_FALSE;
        }
<xsl:if test="$rtidds42e='no'">
        position = RTICdrStream_resetAlignment(stream);
</xsl:if>
    }
    
    *drop_sample = RTI_FALSE;
    
    if (metp &amp;&amp; deserialize_sample) {
        if (!METypePlugin_deserialize(endpoint_data,
                                    (void**)sample_in,
                                    drop_sample,
                                    stream,
                                    deserialize_encapsulation,
                                    deserialize_sample,
                                    endpoint_plugin_qos,
                                    &amp;metp)) {
            return RTI_FALSE;
        }
    } else if(!metp &amp;&amp; METypePlugin_cdrEnabled(endpoint_data) &amp;&amp; deserialize_sample) {
<xsl:if test="$rtidds42e='yes'">
        topLevel = !RTICdrStream_isDirty(stream);
        RTICdrStream_setDirtyBit(stream,RTI_TRUE);

        if (!deserialize_encapsulation &amp;&amp; topLevel) {
            position = RTICdrStream_resetAlignmentWithOffset(stream,4);
        }
</xsl:if>
        <!-- Get a sample from the METP DataReader plugin -->
        if (sample == (void*)RTI_METP_INVALID_SAMPLE_ADDRESS) {
             *sample_in = (<xsl:value-of select="$fullyQualifiedStructName"/> *)
                                    METypePlugin_get_sample(endpoint_data);
            sample = *sample_in;
        }
  <xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass != ''">
      <xsl:text>        if (!</xsl:text>
      <xsl:value-of select="@baseClass"/>
      <xsl:text>Plugin_deserialize_sample(endpoint_data,( </xsl:text>
      <xsl:value-of select="@baseClass"/>
      <xsl:text>*)((sample != NULL)?*sample:NULL),stream,RTI_FALSE,RTI_TRUE,endpoint_plugin_qos)) {&nl;</xsl:text>        
      <xsl:text>            return RTI_FALSE;&nl;</xsl:text>
      <xsl:text>        }</xsl:text>
  </xsl:if>
  <xsl:if test="@kind = 'union'">
      <!-- For unions, create a member named _d (the union discriminator) and generate code for it -->
      <xsl:call-template name="generateMemberCode">
          <xsl:with-param name="generationMode" select="'deserialize'"/>
          <xsl:with-param name="member" select="./discriminator"/>
      </xsl:call-template>
  </xsl:if>
  <xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'deserialize'"/>
  </xsl:apply-templates>
<xsl:if test="$rtidds42e='yes'">
        if (!deserialize_encapsulation &amp;&amp; topLevel) {
            RTICdrStream_restoreAlignment(stream,position);
        }
</xsl:if>
    } else if (deserialize_sample) {
        *drop_sample = RTI_TRUE;
    }

<xsl:if test="$rtidds42e='no'">
    if(deserialize_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }
</xsl:if>

    return RTI_TRUE;
}
</xsl:if> 

<xsl:if test="name(.) != 'typedef'"> 
<!-- deserialize -->
RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_deserialize(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> **sample,
    RTIBool * drop_sample,
    struct RTICdrStream *stream,   
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_sample, 
    void *endpoint_plugin_qos)
{
<xsl:if test="$metp ='yes'">
    return <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_deserialize_sample_metp( 
        endpoint_data, sample,drop_sample,
        stream, deserialize_encapsulation, deserialize_sample, 
        endpoint_plugin_qos);
</xsl:if>
<xsl:if test="$metp ='no'">
    RTIBool result;
    if (drop_sample) {} /* To avoid warnings */
    
    stream->_xTypesState.unassignable = RTI_FALSE;

    result = <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_deserialize_sample( 
        endpoint_data, (sample != NULL)?*sample:NULL,
        stream, deserialize_encapsulation, deserialize_sample, 
        endpoint_plugin_qos);
        
    if (result) {
        if (stream->_xTypesState.unassignable) {
            result = RTI_FALSE;
        }
    }
    
    return result;
</xsl:if> 
}

<xsl:if test="$desSampleCode = 'yes'">

<!-- clone_to_buffer -->
RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_clone_to_buffer(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> **dst,
    const <xsl:value-of select="$fullyQualifiedStructName"/> *src,     
    struct REDABufferManager *buffer_manager)
{
    RTIOsapiMemory_zero(buffer_manager->buffer.pointer, buffer_manager->buffer.length);

    *dst = (<xsl:value-of select="$fullyQualifiedStructName"/> *) REDABufferManager_getBuffer(
        buffer_manager, (unsigned int) sizeof(<xsl:value-of select="$fullyQualifiedStructName"/>), 8);
    if (*dst == NULL) {
        return RTI_FALSE;
    }    

    if (!<xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_initialize_deserialization_buffer_pointers_from_sample(
            endpoint_data,
            *dst,
            buffer_manager,
            src)){
        return RTI_FALSE;
    }

    if (!<xsl:value-of select="$selfFullyQualifiedStructName"/>_copy(
             *dst,src)) {
        return RTI_FALSE;    
    }

    return RTI_TRUE;
}

<!-- deserialize to contiguous buffer -->
NDDSUSERDllExport extern RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_deserialize_to_buffer(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> **sample, 
    RTIBool * drop_sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_sample, 
    struct REDABufferManager *buffer_manager,
    void *endpoint_plugin_qos)
{
    if (drop_sample) {} /* To avoid warnings */

    RTIOsapiMemory_zero(buffer_manager->buffer.pointer, buffer_manager->buffer.length);

    *sample = (<xsl:value-of select="$fullyQualifiedStructName"/> *) REDABufferManager_getBuffer(
        buffer_manager, (unsigned int) sizeof(<xsl:value-of select="$fullyQualifiedStructName"/>), 8);
    if (*sample == NULL) {
        return RTI_FALSE;
    }    

    if (!<xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_initialize_deserialization_buffer_pointers_from_stream(
            endpoint_data,
            *sample,
            deserialize_encapsulation,
            deserialize_sample,
            buffer_manager,
            stream,
            endpoint_plugin_qos)){
        return RTI_FALSE;
    }

    RTICdrStream_resetPosition(stream);
    RTICdrStream_setDirtyBit(stream,RTI_FALSE);

    if (!<xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_deserialize_sample(
        endpoint_data, *sample, stream, deserialize_encapsulation,
        deserialize_sample, endpoint_plugin_qos)) {
        return RTI_FALSE;
    }

    return RTI_TRUE;
}
</xsl:if>

</xsl:if>

<!-- skip method -->
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_skip(
    PRESTypePluginEndpointData endpoint_data,
    struct RTICdrStream *stream,   
    RTIBool skip_encapsulation,
    RTIBool skip_sample, 
    void *endpoint_plugin_qos)
{
    char * position = NULL;
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY' or member[@optional='true']">
    DDS_UnsignedLong memberId = 0;
    DDS_UnsignedLong length = 0;
    RTIBool mustUnderstand = RTI_FALSE;
    struct RTICdrStreamState state;
    RTIBool extended;
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    RTIBool end = RTI_FALSE;
</xsl:if>    
</xsl:if>    
<xsl:if test="$rtidds42e='yes'">
    RTIBool topLevel;
</xsl:if>
<xsl:if test="(@kind='struct' or @kind='valuetype') and $xType='EXTENSIBLE_EXTENSIBILITY'">
    RTIBool done = RTI_FALSE;
</xsl:if>

<xsl:if test="not((@kind='valuetype' or @kind='struct') and @baseClass != '')">
    if (endpoint_data) {} /* To avoid warnings */
    if (endpoint_plugin_qos) {} /* To avoid warnings */
</xsl:if>

    if(skip_encapsulation) {
        if (!RTICdrStream_skipEncapsulation(stream)) {
            return RTI_FALSE;
        }

<xsl:if test="$rtidds42e='no'">
        position = RTICdrStream_resetAlignment(stream);
</xsl:if>
    }

    if (skip_sample) {
<xsl:if test="$rtidds42e='yes'">
        topLevel = !RTICdrStream_isDirty(stream);
        RTICdrStream_setDirtyBit(stream,RTI_TRUE);

        if (!skip_encapsulation &amp;&amp; topLevel) {
            position = RTICdrStream_resetAlignmentWithOffset(stream,4);
        }
</xsl:if>
        <xsl:if test="@kind = 'union'">
            <xsl:call-template name="obtainNativeType">
                <xsl:with-param name="idlType" select="./discriminator/@type"/>        	
            </xsl:call-template>
            <xsl:text>    disc;&nl;</xsl:text>
        </xsl:if>

        <xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass != ''">
        
            <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
       {
            char *begin = RTICdrStream_getCurrentPosition(stream);
            RTICdrStream_pushState(
                stream, &amp;state, -1);
            </xsl:if>
            <xsl:text>    if (!</xsl:text>
            <xsl:value-of select="@baseClass"/>
            <xsl:text>Plugin_skip(</xsl:text>
            <xsl:text>endpoint_data,stream,</xsl:text>
            <xsl:text>RTI_FALSE,RTI_TRUE,endpoint_plugin_qos)) {&nl;</xsl:text>   
            <xsl:text>        return RTI_FALSE;&nl;</xsl:text>
            <xsl:text>    }</xsl:text>
            <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
            RTICdrStream_popState(
                stream, &amp;state);
            RTICdrStream_setCurrentPosition(stream, begin);
       }
            </xsl:if>
        </xsl:if>
            
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    <xsl:value-of select="$mutableTypeStartDesBlock"/>
</xsl:if>
        <xsl:if test="@kind = 'union'">
            <!-- For unions, create a member named _d (the union discriminator) and generate code for it -->
            <xsl:call-template name="generateMemberCode">
                <xsl:with-param name="generationMode" select="'deserialize'"/>
                <xsl:with-param name="discContainer" select="'disc'"/>
                <xsl:with-param name="member" select="./discriminator"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:apply-templates mode="code-generation">
            <xsl:with-param name="generationMode" select="'skip'"/>
            <xsl:with-param name="discContainer" select="'disc'"/>
        </xsl:apply-templates>

<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    <xsl:value-of select="$mutableTypeEndDesBlock"/>
</xsl:if>    

<xsl:if test="$rtidds42e='yes'">
        if (!skip_encapsulation &amp;&amp; topLevel) {
            RTICdrStream_restoreAlignment(stream,position);
        }
</xsl:if>

    }
    
<xsl:if test="(@kind='struct' or @kind='valuetype') and $xType='EXTENSIBLE_EXTENSIBILITY'">
    done = RTI_TRUE;
fin:
    if (done != RTI_TRUE &amp;&amp; 
        RTICdrStream_getRemainder(stream) >=
            RTI_CDR_PARAMETER_HEADER_ALIGNMENT) {
        return RTI_FALSE;   
    }
</xsl:if>

<xsl:if test="$rtidds42e='no'">
    if(skip_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }
</xsl:if>

    return RTI_TRUE;
}

<!-- get_serialized_sample_max_size method -->
unsigned int 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_serialized_sample_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment)
{
<xsl:if test="$metp ='yes'">
    RTIBool metp = RTI_FALSE;
</xsl:if>    
<xsl:if test="@kind='union'">
    unsigned int union_max_size_serialized = 0;
</xsl:if>            
<xsl:if test="member[@bitField]">
    unsigned int current_bits = 0;
</xsl:if>
    unsigned int initial_alignment = current_alignment;
<xsl:if test="$rtidds42e='no'">
    unsigned int encapsulation_size = current_alignment;
</xsl:if>

<xsl:if test="$metp ='no' and not((@kind='valuetype' or @kind='struct') and @baseClass != '')">
    if (endpoint_data) {} /* To avoid warnings */
</xsl:if>

    if (include_encapsulation) {
<xsl:if test="$metp ='yes'">
        if (!METypePlugin_validEncapsulationId(encapsulation_id) &amp;&amp; 
            !RTICdrEncapsulation_validEncapsulationId(encapsulation_id)) {
            return 1;
        }
</xsl:if>
<xsl:if test="$metp ='no'">
        if (!RTICdrEncapsulation_validEncapsulationId(encapsulation_id)) {
            return 1;
        }
</xsl:if>

<xsl:if test="$rtidds42e='no'">
        RTICdrStream_getEncapsulationSize(encapsulation_size);
        encapsulation_size -= current_alignment;
        current_alignment = 0;
        initial_alignment = 0;
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
        RTICdrStream_getEncapsulationSize(current_alignment);
</xsl:if>
    }

<xsl:if test="$metp ='yes'">
        current_alignment += METypePlugin_get_serialized_sample_max_size(
                    endpoint_data,
                    include_encapsulation,
                    encapsulation_id,
                    current_alignment,
                    &amp;metp);
 if (!metp) {
</xsl:if>

<xsl:if test="@kind = 'union'">
    <!-- For unions, create a member named _d (the union discriminator) and generate code for it -->

    <xsl:call-template name="generateMemberCode">
        <xsl:with-param name="generationMode" select="'get_max_size_serialized'"/>
        <xsl:with-param name="member" select="./discriminator"/>
    </xsl:call-template>

</xsl:if>
<xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass != ''">
    <xsl:text>    current_alignment += </xsl:text>
    <xsl:value-of select="@baseClass"/>
    <xsl:text>Plugin_get_serialized_sample_max_size(endpoint_data,RTI_FALSE,encapsulation_id,current_alignment);&nl;</xsl:text>        
</xsl:if>
 
<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'get_max_size_serialized'"/>
</xsl:apply-templates>
<xsl:if test="$metp ='yes'">
    }
</xsl:if>
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    /* Sentinel */
<xsl:choose>
    <xsl:when test="not(@kind = 'union')">
    current_alignment += RTICdrStream_getExtendedParameterHeaderMaxSizeSerialized(current_alignment);</xsl:when>
    <xsl:otherwise>
    union_max_size_serialized += RTICdrStream_getExtendedParameterHeaderMaxSizeSerialized(union_max_size_serialized);</xsl:otherwise>
</xsl:choose>
</xsl:if>
<xsl:if test="$rtidds42e='no'">
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }
</xsl:if>
<xsl:choose>
    <xsl:when test="not(@kind = 'union')">
    return current_alignment - initial_alignment;</xsl:when>
    <xsl:otherwise>
    return union_max_size_serialized + current_alignment - initial_alignment;</xsl:otherwise>
</xsl:choose>
}

<!-- get_serialized_sample_min_size method -->
unsigned int 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_serialized_sample_min_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment)
{
<xsl:if test="$metp ='yes'">
    RTIBool metp = RTI_FALSE;
</xsl:if>            
<xsl:if test="@kind='union'">
    unsigned int union_min_size_serialized = 0xffffffff;
</xsl:if>            
<xsl:if test="member[@bitField]">
    unsigned int current_bits = 0;
</xsl:if>
    unsigned int initial_alignment = current_alignment;
<xsl:if test="$rtidds42e='no'">
    unsigned int encapsulation_size = current_alignment;
</xsl:if>

<xsl:if test="$metp ='no' and not((@kind='valuetype' or @kind='struct') and @baseClass != '')">
    if (endpoint_data) {} /* To avoid warnings */
</xsl:if>

    if (include_encapsulation) {
<xsl:if test="$metp ='yes'">
        if (!METypePlugin_validEncapsulationId(encapsulation_id) &amp;&amp; 
            !RTICdrEncapsulation_validEncapsulationId(encapsulation_id)) {
            return 1;
        }
</xsl:if>
<xsl:if test="$metp ='no'">
        if (!RTICdrEncapsulation_validEncapsulationId(encapsulation_id)) {
            return 1;
        }
</xsl:if>

<xsl:if test="$rtidds42e='no'">
        RTICdrStream_getEncapsulationSize(encapsulation_size);
        encapsulation_size -= current_alignment;
        current_alignment = 0;
        initial_alignment = 0;
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
        RTICdrStream_getEncapsulationSize(current_alignment);
</xsl:if>
    }

<xsl:if test="$metp ='yes'">
        current_alignment += METypePlugin_get_serialized_sample_min_size(
                    endpoint_data,
                    include_encapsulation,
                    encapsulation_id,
                    current_alignment,
                    &amp;metp);
    if (!metp) {
</xsl:if>

<xsl:if test="@kind = 'union'">
    <!-- For unions, create a member named _d (the union discriminator) and generate code for it -->

    <xsl:call-template name="generateMemberCode">
        <xsl:with-param name="generationMode" select="'get_min_size_serialized'"/>
        <xsl:with-param name="member" select="./discriminator"/>
    </xsl:call-template>

</xsl:if>
<xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass != ''">
    <xsl:text>    current_alignment += </xsl:text>
    <xsl:value-of select="@baseClass"/>
    <xsl:text>Plugin_get_serialized_sample_min_size(endpoint_data,RTI_FALSE,encapsulation_id,current_alignment);&nl;</xsl:text>        
</xsl:if>
 
<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'get_min_size_serialized'"/>
</xsl:apply-templates>
<xsl:if test="$metp ='yes'">
    }
</xsl:if>
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> 
    /* Sentinel */
<xsl:choose>
    <xsl:when test="not(@kind = 'union')">
    current_alignment += RTICdrStream_getParameterHeaderMaxSizeSerialized(current_alignment);</xsl:when>
    <xsl:otherwise>
    union_min_size_serialized += RTICdrStream_getParameterHeaderMaxSizeSerialized(union_min_size_serialized);</xsl:otherwise>
</xsl:choose>
</xsl:if>    
<xsl:if test="$rtidds42e='no'">
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }
</xsl:if>
<xsl:choose>
    <xsl:when test="not(@kind = 'union')">
    return current_alignment - initial_alignment;</xsl:when>
    <xsl:otherwise>
    return union_min_size_serialized + current_alignment - initial_alignment;</xsl:otherwise>
</xsl:choose>
}

<!-- get_serialized_sample_size  method -->
/* Returns the size of the sample in its serialized form (in bytes).
 * It can also be an estimation in excess of the real buffer needed 
 * during a call to the serialize() function.
 * The value reported does not have to include the space for the
 * encapsulation flags.
 */
unsigned int
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_serialized_sample_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment,
    const <xsl:value-of select="$fullyQualifiedStructName"/> * sample) 
{
<xsl:if test="$metp ='yes'">
    RTIBool metp = RTI_FALSE;
</xsl:if>

<xsl:if test="member[@bitField]">
    unsigned int current_bits = 0;
</xsl:if>
    unsigned int initial_alignment = current_alignment;
<xsl:if test="$rtidds42e='no'">
    unsigned int encapsulation_size = current_alignment;
</xsl:if>

<xsl:if test="$metp ='no' and not((@kind='valuetype' or @kind='struct') and @baseClass != '')">
    if (endpoint_data) {} /* To avoid warnings */
    if (sample) {} /* To avoid warnings */
</xsl:if>

    if (include_encapsulation) {
<xsl:if test="$metp ='yes'">
        if (!METypePlugin_validEncapsulationId(encapsulation_id) &amp;&amp; 
            !RTICdrEncapsulation_validEncapsulationId(encapsulation_id)) {
            return 1;
        }
</xsl:if>
<xsl:if test="$metp ='no'">
        if (!RTICdrEncapsulation_validEncapsulationId(encapsulation_id)) {
            return 1;
        }
</xsl:if>

<xsl:if test="$rtidds42e='no'">
        RTICdrStream_getEncapsulationSize(encapsulation_size);
        encapsulation_size -= current_alignment;
        current_alignment = 0;
        initial_alignment = 0;
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
        RTICdrStream_getEncapsulationSize(current_alignment);
</xsl:if>
    }

<xsl:if test="$metp ='yes'">
        current_alignment += METypePlugin_get_serialized_sample_size(
                    endpoint_data,
                    include_encapsulation,
                    encapsulation_id,
                    current_alignment,
                    &amp;metp);
    if (!metp) {
</xsl:if>

<xsl:if test="@kind = 'union'">
    <xsl:call-template name="generateMemberCode">
        <xsl:with-param name="generationMode" select="'get_serialized_sample_size'"/>
        <xsl:with-param name="member" select="./discriminator"/>
    </xsl:call-template>
</xsl:if>
<xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass != ''">
    <xsl:text>    current_alignment += </xsl:text>
    <xsl:value-of select="@baseClass"/>
    <xsl:text>Plugin_get_serialized_sample_size(endpoint_data,RTI_FALSE,encapsulation_id,current_alignment,</xsl:text>        
    <xsl:text>(const </xsl:text>
    <xsl:value-of select="@baseClass"/>
    <xsl:text>*)sample);&nl;</xsl:text>
</xsl:if>
 
<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'get_serialized_sample_size'"/>
</xsl:apply-templates>
<xsl:if test="$metp ='yes'">
    }
</xsl:if>
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> 
    /* Sentinel */
    current_alignment += RTICdrStream_getParameterHeaderMaxSizeSerialized(current_alignment);
</xsl:if>
<xsl:if test="$rtidds42e='no'">
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }
</xsl:if>
    return current_alignment - initial_alignment;
}

<!-- ************************************************************************** -->
<!-- ************************************************************************** -->
<!-- ************************************************************************** -->

<xsl:if test="$desSampleCode = 'yes'">

<!-- get_deserialized_sample_min_size method -->
unsigned int
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_deserialized_sample_min_size(
    PRESTypePluginEndpointData endpoint_data,
    unsigned int current_alignment,
    RTIBool only_members)
{
    unsigned int initial_alignment = current_alignment;
    
    if (endpoint_data) {} /* To avoid warnings */

    if (!only_members) {
        current_alignment = (unsigned int)
                        RTIOsapiAlignment_alignSizeUp(
                            current_alignment,8);
        current_alignment += sizeof(<xsl:value-of select="$selfFullyQualifiedStructName"/>);
    }
    
<xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass != ''">
    <xsl:text>    current_alignment += </xsl:text>
    <xsl:value-of select="@baseClass"/>
    <xsl:text>Plugin_get_deserialized_sample_min_size(endpoint_data,current_alignment,RTI_TRUE);&nl;</xsl:text>        
</xsl:if>

<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'get_min_size_deserialized'"/>
</xsl:apply-templates>

    return current_alignment - initial_alignment;
}

<!-- get_deserialized_sample_size method -->
RTIBool
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_deserialized_sample_size(
    PRESTypePluginEndpointData endpoint_data,
    unsigned int * size,
    RTIBool skip_encapsulation,
    RTIBool skip_sample,
    unsigned int current_alignment,
    RTIBool only_members,
    struct RTICdrStream *stream,
    void *endpoint_plugin_qos)
{
    char * position = NULL;
    unsigned int initial_alignment = current_alignment;
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    DDS_UnsignedLong memberId = 0;
    DDS_UnsignedLong length = 0;
    RTIBool mustUnderstand = RTI_FALSE;
    RTIBool end = RTI_FALSE;
    struct RTICdrStreamState state;
    RTIBool extended;
</xsl:if>
<xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass != ''">
    unsigned int tmpSize;
</xsl:if>
<xsl:if test="(@kind='valuetype' or @kind='struct') and $xType='EXTENSIBLE_EXTENSIBILITY'">
    RTIBool done = RTI_FALSE;
</xsl:if>

<xsl:if test="not((@kind='valuetype' or @kind='struct') and @baseClass != '')">
    if (endpoint_data) {} /* To avoid warnings */
    if (endpoint_plugin_qos) {} /* To avoid warnings */
</xsl:if>

<xsl:if test="(@kind='valuetype' or @kind='struct') and $xType='EXTENSIBLE_EXTENSIBILITY'">
    if (size == NULL) goto fin; /* To avoid warnings */
</xsl:if>

    if(skip_encapsulation) {
        if (!RTICdrStream_skipEncapsulation(stream)) {
            return RTI_FALSE;
        }

        position = RTICdrStream_resetAlignment(stream);
    }

    if (skip_sample) {
        <xsl:if test="@kind = 'union'">
            <xsl:call-template name="obtainNativeType">
                <xsl:with-param name="idlType" select="./discriminator/@type"/>         
            </xsl:call-template>
            <xsl:text>    disc;&nl;</xsl:text>
        </xsl:if>
                
        if (!only_members) {
            current_alignment = (unsigned int)
                            RTIOsapiAlignment_alignSizeUp(
                                current_alignment,8);
            current_alignment += sizeof(<xsl:value-of select="$selfFullyQualifiedStructName"/>);
        }

<xsl:if test="($xType='MUTABLE_EXTENSIBILITY' or $xType='EXTENSIBLE_EXTENSIBILITY') and @kind!='union'">
        current_alignment += <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_get_deserialized_sample_min_size(
            endpoint_data, current_alignment, RTI_TRUE);
</xsl:if>
        
        <xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass != ''">
        
            <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        {
            char *begin = RTICdrStream_getCurrentPosition(stream);
            RTICdrStream_pushState(
                stream, &amp;state, -1);
            </xsl:if>
            <xsl:text>if (!</xsl:text>
            <xsl:value-of select="@baseClass"/>
            <xsl:text>Plugin_get_deserialized_sample_size(</xsl:text>
            <xsl:text>endpoint_data,&amp;tmpSize,RTI_FALSE,RTI_TRUE,current_alignment,RTI_TRUE,stream,endpoint_plugin_qos)) {&nl;</xsl:text>
            <xsl:text>                return RTI_FALSE;&nl;</xsl:text>
            <xsl:text>            }</xsl:text>
            <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
            RTICdrStream_popState(
                stream, &amp;state);
            RTICdrStream_setCurrentPosition(stream, begin);
        }
            </xsl:if>
            current_alignment += tmpSize;
        </xsl:if>
            
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    <xsl:value-of select="$mutableTypeStartDesBlock"/>
</xsl:if>
        <xsl:if test="@kind = 'union'">
            <xsl:call-template name="generateMemberCode">
                <xsl:with-param name="generationMode" select="'deserialize'"/>
                <xsl:with-param name="discContainer" select="'disc'"/>
                <xsl:with-param name="member" select="./discriminator"/>
            </xsl:call-template>

            <xsl:apply-templates mode="code-generation">
                <xsl:with-param name="generationMode" select="'union_skip_and_get_deserialized_length'"/>
                <xsl:with-param name="discContainer" select="'disc'"/>
            </xsl:apply-templates>
        </xsl:if>
        
        <xsl:if test="not(@kind = 'union')">
            <xsl:apply-templates mode="code-generation">
                <xsl:with-param name="generationMode" select="'skip_and_get_deserialized_length'"/>
                <xsl:with-param name="discContainer" select="'disc'"/>
            </xsl:apply-templates>
        </xsl:if>

<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    <xsl:value-of select="$mutableTypeEndDesBlock"/>
</xsl:if>    

        *size = current_alignment - initial_alignment;
    }
    
<xsl:if test="(@kind='valuetype' or @kind='struct') and $xType='EXTENSIBLE_EXTENSIBILITY'">
    done = RTI_TRUE;
fin:
    if (done != RTI_TRUE &amp;&amp; 
        RTICdrStream_getRemainder(stream) >=
            RTI_CDR_PARAMETER_HEADER_ALIGNMENT) {
        return RTI_FALSE;   
    }
</xsl:if>

    if(skip_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }

    return RTI_TRUE;
}

<!-- initialize_deserialization_buffer_pointers method -->

RTIBool
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_initialize_deserialization_buffer_pointers(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> * sample,
    struct REDABufferManager *buffer_manager,
    void *endpoint_plugin_qos)
{
    if (endpoint_plugin_qos) {} /* To avoid warnings */
    if (endpoint_data) {} /* To avoid warnings */
    if (sample) {} /* To avoid warnings */

    <xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass != ''">
        <xsl:text>if (!</xsl:text>
        <xsl:value-of select="@baseClass"/>
        <xsl:text>Plugin_initialize_deserialization_buffer_pointers(&nl;</xsl:text>
        <xsl:text>            endpoint_data,&nl;</xsl:text>
        <xsl:text>            (</xsl:text>
        <xsl:value-of select="@baseClass"/>
        <xsl:text>*)sample,&nl;</xsl:text>
        <xsl:text>            buffer_manager, endpoint_plugin_qos)) {&nl;</xsl:text>
        <xsl:text>                return RTI_FALSE;&nl;</xsl:text>
        <xsl:text>        }</xsl:text>
    </xsl:if>
      
<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'initialize_des_buffer'"/>
</xsl:apply-templates>

    return RTI_TRUE;
}

<!-- initialize_deserialization_buffer_from_stream method -->
RTIBool
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_initialize_deserialization_buffer_pointers_from_stream(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> * sample,
    RTIBool skip_encapsulation,
    RTIBool skip_sample,
    struct REDABufferManager *buffer_manager,
    struct RTICdrStream *stream,
    void *endpoint_plugin_qos)
{
    char * position = NULL;
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    DDS_UnsignedLong memberId = 0;
    DDS_UnsignedLong length = 0;
    RTIBool mustUnderstand = RTI_FALSE;
    RTIBool end = RTI_FALSE;
    struct RTICdrStreamState state;
    RTIBool extended;
</xsl:if>
<xsl:if test="(@kind='valuetype' or @kind='struct') and $xType='EXTENSIBLE_EXTENSIBILITY'">
    RTIBool done = RTI_FALSE;
</xsl:if>

<xsl:if test="not((@kind='valuetype' or @kind='struct') and @baseClass != '')">
    if (endpoint_data) {} /* To avoid warnings */
    if (endpoint_plugin_qos) {} /* To avoid warnings */
</xsl:if>

<xsl:if test="(@kind='valuetype' or @kind='struct') and $xType='EXTENSIBLE_EXTENSIBILITY'">
    if (sample == NULL) goto fin; /* To avoid warnings */
</xsl:if>

    if(skip_encapsulation) {
        if (!RTICdrStream_skipEncapsulation(stream)) {
            return RTI_FALSE;
        }

        position = RTICdrStream_resetAlignment(stream);
    }

    if (skip_sample) {
        <xsl:if test="@kind = 'union'">
            <xsl:call-template name="obtainNativeType">
                <xsl:with-param name="idlType" select="./discriminator/@type"/>         
            </xsl:call-template>
            <xsl:text>    disc;&nl;</xsl:text>
        </xsl:if>

<xsl:if test="($xType='MUTABLE_EXTENSIBILITY' or $xType='EXTENSIBLE_EXTENSIBILITY') and @kind!='union'">
        if (!<xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_initialize_deserialization_buffer_pointers(
                    endpoint_data, sample, buffer_manager, endpoint_plugin_qos)) {
            return RTI_FALSE;
        }
</xsl:if>

        <xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass != ''">
        
            <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        {
            char *begin = RTICdrStream_getCurrentPosition(stream);
            RTICdrStream_pushState(
                stream, &amp;state, -1);
            </xsl:if>
            <xsl:text>if (!</xsl:text>
            <xsl:value-of select="@baseClass"/>
            <xsl:text>Plugin_initialize_deserialization_buffer_pointers_from_stream(&nl;</xsl:text>
            <xsl:text>            endpoint_data,&nl;</xsl:text>
            <xsl:text>            (</xsl:text>
            <xsl:value-of select="@baseClass"/>
            <xsl:text>*)sample,&nl;</xsl:text>
            <xsl:text>            RTI_FALSE, RTI_TRUE, buffer_manager, stream, endpoint_plugin_qos)) {&nl;</xsl:text>
            <xsl:text>                return RTI_FALSE;&nl;</xsl:text>
            <xsl:text>        }</xsl:text>
            <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
            RTICdrStream_popState(
                stream, &amp;state);
            RTICdrStream_setCurrentPosition(stream, begin);
        }
            </xsl:if>
        </xsl:if>
            
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    <xsl:value-of select="$mutableTypeStartDesBlock"/>
</xsl:if>
        <xsl:if test="@kind = 'union'">
            <xsl:call-template name="generateMemberCode">
                <xsl:with-param name="generationMode" select="'deserialize'"/>
                <xsl:with-param name="discContainer" select="'disc'"/>
                <xsl:with-param name="member" select="./discriminator"/>
            </xsl:call-template>
            <xsl:apply-templates mode="code-generation">
                <xsl:with-param name="generationMode" select="'union_initialize_des_buffer_from_stream'"/>
                <xsl:with-param name="discContainer" select="'disc'"/>
            </xsl:apply-templates>
        </xsl:if>
        <xsl:if test="not(@kind = 'union')">
            <xsl:apply-templates mode="code-generation">
                <xsl:with-param name="generationMode" select="'initialize_des_buffer_from_stream'"/>
                <xsl:with-param name="discContainer" select="'disc'"/>
            </xsl:apply-templates>
        </xsl:if>
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    <xsl:value-of select="$mutableTypeEndDesBlock"/>
</xsl:if>    
    }
    
<xsl:if test="(@kind='valuetype' or @kind='struct') and $xType='EXTENSIBLE_EXTENSIBILITY'">
    done = RTI_TRUE;
fin:
    if (done != RTI_TRUE &amp;&amp; 
        RTICdrStream_getRemainder(stream) >=
            RTI_CDR_PARAMETER_HEADER_ALIGNMENT) {
        return RTI_FALSE;   
    }
</xsl:if>

    if(skip_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }

    return RTI_TRUE;
}

<!-- copy_sample_from_deserialization_buffer method -->
RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_initialize_deserialization_buffer_pointers_from_sample(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> *dst,
    struct REDABufferManager *buffer_manager,
    const <xsl:value-of select="$fullyQualifiedStructName"/> *src) 
{
    if (endpoint_data) {} /* To avoid warnings */

    <xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass != ''">
        <xsl:text>if (!</xsl:text>
        <xsl:value-of select="@baseClass"/>
        <xsl:text>Plugin_initialize_deserialization_buffer_pointers_from_sample(&nl;</xsl:text>
        <xsl:text>            endpoint_data,&nl;</xsl:text>
        <xsl:text>            (</xsl:text><xsl:value-of select="@baseClass"/><xsl:text>*)dst,&nl;</xsl:text>
        <xsl:text>            buffer_manager,&nl;</xsl:text>
        <xsl:text>            (</xsl:text><xsl:value-of select="@baseClass"/><xsl:text>*)src)) {&nl;</xsl:text>
        <xsl:text>                return RTI_FALSE;&nl;</xsl:text>
        <xsl:text>        }</xsl:text>
    </xsl:if>

    <xsl:if test="@kind = 'union'">
        <xsl:call-template name="generateMemberCode">
            <xsl:with-param name="generationMode" select="'initialize_des_buffer_from_sample'"/>
            <xsl:with-param name="member" select="./discriminator"/>
        </xsl:call-template>
    </xsl:if>
      
<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'initialize_des_buffer_from_sample'"/>
    <xsl:with-param name="unionVariableName" select="'src'"/>
</xsl:apply-templates>

    return RTI_TRUE;
}

</xsl:if>

<!-- ************************************************************************** -->
<!-- ************************************************************************** -->
<!-- ************************************************************************** -->

<xsl:if test="$noKeyCode='no'">

/* --------------------------------------------------------------------------------------
    Key Management functions:
 * -------------------------------------------------------------------------------------- */

<!-- get_key_kind method -->
PRESTypePluginKeyKind 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_key_kind(void)
{
<xsl:choose>
    <!-- If this type contains at least one 'directive' child with a 'kind'
         attribute of 'key', consider it a keyed type. Otherwise, consider
         it unkeyed. -->        
    <xsl:when test="$isKeyed = 'yes'">
    return PRES_TYPEPLUGIN_USER_KEY;
    </xsl:when>
    <xsl:otherwise>
    return PRES_TYPEPLUGIN_NO_KEY;
    </xsl:otherwise>
</xsl:choose> 
}

<!-- serialize_key method -->
RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_serialize_key(
    PRESTypePluginEndpointData endpoint_data,
    const <xsl:value-of select="$fullyQualifiedStructName"/> *sample, 
    struct RTICdrStream *stream,    
    RTIBool serialize_encapsulation,
    RTIEncapsulationId encapsulation_id,
    RTIBool serialize_key,
    void *endpoint_plugin_qos)
{
    char * position = NULL;
<xsl:if test="$rtidds42e='yes'">
    RTIBool topLevel;
</xsl:if>
<xsl:if test="$keyFields[@bitField]">
    RTICdrUnsignedLong bit_val = 0;
</xsl:if>

<xsl:if test="not((@kind='valuetype' or @kind='struct') and @baseClass != '' and @keyedBaseClass='yes')">
    if (endpoint_data) {} /* To avoid warnings */
    if (endpoint_plugin_qos) {} /* To avoid warnings */
</xsl:if>

    if(serialize_encapsulation) {
    <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> 
        if (encapsulation_id == RTI_CDR_ENCAPSULATION_ID_CDR_BE) {
            encapsulation_id = RTI_CDR_ENCAPSULATION_ID_PL_CDR_BE;
        } else if (encapsulation_id == RTI_CDR_ENCAPSULATION_ID_CDR_LE) {
            encapsulation_id = RTI_CDR_ENCAPSULATION_ID_PL_CDR_LE;
        }
    </xsl:if>
        if (!RTICdrStream_serializeAndSetCdrEncapsulation(stream, encapsulation_id)) {
            return RTI_FALSE;
        }

<xsl:if test="$rtidds42e='no'">
        position = RTICdrStream_resetAlignment(stream);
</xsl:if>
    }

    if(serialize_key) {
<xsl:if test="$rtidds42e='yes'">
        topLevel = !RTICdrStream_isDirty(stream);
        RTICdrStream_setDirtyBit(stream,RTI_TRUE);

        if (!serialize_encapsulation &amp;&amp; topLevel) {
            position = RTICdrStream_resetAlignmentWithOffset(stream,4);
        }
</xsl:if>
<xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass != '' and @keyedBaseClass='yes'">
    <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        stream->_xTypesState.skipListEndId = RTI_TRUE;
    </xsl:if>
    <xsl:text>        if (!</xsl:text>
    <xsl:value-of select="@baseClass"/>
    <xsl:text>Plugin_serialize_key(endpoint_data, (const </xsl:text>
    <xsl:value-of select="@baseClass"/>
    <xsl:text>*)sample, stream, RTI_FALSE, encapsulation_id,RTI_TRUE, endpoint_plugin_qos)) {&nl;</xsl:text>
    <xsl:text>            return RTI_FALSE;&nl;</xsl:text>
    <xsl:text>        }</xsl:text>
    <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        stream->_xTypesState.skipListEndId = RTI_FALSE;
    </xsl:if>
</xsl:if>

<xsl:choose>  
    <xsl:when test="name(.) = 'typedef'">
        <xsl:apply-templates select="./member"
                             mode="code-generation">
            <xsl:with-param name="generationMode" select="'serialize_key'"/>
        </xsl:apply-templates>
    </xsl:when>
    <xsl:when test="not($keyFields) and (not(@keyedBaseClass) or @keyedBaseClass='no')">
        if (!<xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_serialize(
                endpoint_data,
                sample,
                stream,
                RTI_FALSE, encapsulation_id,
                RTI_TRUE,
                endpoint_plugin_qos)) {
            return RTI_FALSE;
        }
    </xsl:when>
    <xsl:otherwise>
       <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> 
        {
            RTIBool ignoreListEndId = RTI_FALSE;
            DDS_UnsignedLong memberId = 0;
            char *memberLengthPosition = NULL;
            RTIBool extended = RTI_FALSE;
            struct RTICdrStreamState state;
            
            if (RTICdrStream_isDirty(stream)) {
                ignoreListEndId = stream->_xTypesState.skipListEndId; 
            } else {
                /* Top level */
                RTICdrStream_setDirtyBit(stream,RTI_TRUE);
 
<xsl:if test="$mutExtEncapsulation='yes'">
                stream->_xTypesState.useExtendedId = RTI_TRUE;
</xsl:if>
<xsl:if test="$mutExtEncapsulation='no'">
                if (PRESTypePluginDefaultEndpointData_getMaxSizeSerializedSample(endpoint_data) > 65535) {
                    stream->_xTypesState.useExtendedId = RTI_TRUE;
                } else {
                    stream->_xTypesState.useExtendedId = RTI_FALSE;
                }
</xsl:if>
            }
            stream->_xTypesState.skipListEndId = RTI_FALSE;
       </xsl:if>    
	<xsl:apply-templates select="member[following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'key']]"
			     mode="code-generation">
	    <xsl:with-param name="generationMode" select="'serialize_key'"/>
	</xsl:apply-templates>
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
            if (!ignoreListEndId) {
                if (!RTICdrStream_serializeParameterHeader(
                    stream,
                    NULL,
                    RTI_FALSE,
                    RTI_CDR_PID_LIST_END,
                    RTI_TRUE)) {
                    return RTI_FALSE;
                }
            }
            stream->_xTypesState.skipListEndId = ignoreListEndId;
        }
        </xsl:if>
   </xsl:otherwise>
</xsl:choose>
<xsl:if test="$rtidds42e='yes'">
        if (!serialize_encapsulation &amp;&amp; topLevel) {
            RTICdrStream_restoreAlignment(stream,position);
        }
</xsl:if>
    }

<xsl:if test="$rtidds42e='no'">
    if(serialize_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }
</xsl:if>

    return RTI_TRUE;
}

<!-- deserialize_key_sample method -->
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_deserialize_key_sample(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> *sample, 
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_key,
    void *endpoint_plugin_qos)
{
    char * position = NULL;
<xsl:if test="$rtidds42e='yes'">
    RTIBool topLevel;
</xsl:if>
<xsl:if test="$keyFields[@bitField]">
    RTICdrUnsignedLong bit_val = 0;
</xsl:if>

<xsl:if test="not((@kind='valuetype' or @kind='struct') and @baseClass != '' and @keyedBaseClass='yes')">
    if (endpoint_data) {} /* To avoid warnings */
    if (endpoint_plugin_qos) {} /* To avoid warnings */
</xsl:if>

    if(deserialize_encapsulation) {
        /* Deserialize encapsulation */
        if (!RTICdrStream_deserializeAndSetCdrEncapsulation(stream)) {
            return RTI_FALSE;  
        }

<xsl:if test="$rtidds42e='no'">
        position = RTICdrStream_resetAlignment(stream);
</xsl:if>
    }

    if (deserialize_key) {
<xsl:if test="$rtidds42e='yes'">
        topLevel = !RTICdrStream_isDirty(stream);
        RTICdrStream_setDirtyBit(stream,RTI_TRUE);

        if (!deserialize_encapsulation &amp;&amp; topLevel) {
            position = RTICdrStream_resetAlignmentWithOffset(stream,4);
        }
</xsl:if>
<xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass != '' and @keyedBaseClass='yes'">
    <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        {
            struct RTICdrStreamState state;
            char * begin = RTICdrStream_getCurrentPosition(stream);
            RTICdrStream_pushState(
                stream, &amp;state, -1);
    </xsl:if>
    <xsl:text>        if (!</xsl:text>
    <xsl:value-of select="@baseClass"/>
    <xsl:text>Plugin_deserialize_key_sample(endpoint_data,(</xsl:text>
    <xsl:value-of select="@baseClass"/>
    <xsl:text>*)sample,stream,RTI_FALSE,RTI_TRUE,endpoint_plugin_qos)) {&nl;</xsl:text>     
    <xsl:text>            return RTI_FALSE;&nl;</xsl:text>
    <xsl:text>        }</xsl:text>
    <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
            RTICdrStream_popState(
                stream, &amp;state);
            RTICdrStream_setCurrentPosition(stream, begin);
        }
    </xsl:if>
</xsl:if>

<xsl:choose>
    <xsl:when test="name(.) = 'typedef'">
        <xsl:apply-templates select="./member"
                             mode="code-generation">
            <xsl:with-param name="generationMode" select="'deserialize_key'"/>
        </xsl:apply-templates>
    </xsl:when>
    <xsl:when test="not($keyFields) and (not(@keyedBaseClass) or @keyedBaseClass='no')">
        if (!<xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_deserialize_sample(
                endpoint_data, sample, stream,
                RTI_FALSE, RTI_TRUE, 
                endpoint_plugin_qos)) {
            return RTI_FALSE;
        }
    </xsl:when>
    <xsl:otherwise>
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        {
            DDS_UnsignedLong memberId = 0;
            DDS_UnsignedLong length = 0;
            RTIBool mustUnderstand = RTI_FALSE;
            RTIBool end = RTI_FALSE;
            struct RTICdrStreamState state;
            RTIBool extended;

    <xsl:value-of select="$mutableTypeStartDesBlock"/>
</xsl:if>
	<xsl:apply-templates select="member[following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'key']]"
			     mode="code-generation">
	    <xsl:with-param name="generationMode" select="'deserialize_key'"/>
	</xsl:apply-templates>
    
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    <xsl:value-of select="$mutableTypeEndDesBlock"/>
    <xsl:text>            
        }</xsl:text>
</xsl:if>
   </xsl:otherwise>
</xsl:choose>
<xsl:if test="$rtidds42e='yes'">
        if (!deserialize_encapsulation &amp;&amp; topLevel) {
            RTICdrStream_restoreAlignment(stream,position);
        }
</xsl:if>
    }

<xsl:if test="$rtidds42e='no'">
    if(deserialize_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }
</xsl:if>

    return RTI_TRUE;
}

<!-- deserialize_key method -->
<xsl:if test="name(.) != 'typedef'"> 
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_deserialize_key(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> **sample, 
    RTIBool * drop_sample,
    struct RTICdrStream *stream,
    RTIBool deserialize_encapsulation,
    RTIBool deserialize_key,
    void *endpoint_plugin_qos)
{
    RTIBool result;
    if (drop_sample) {} /* To avoid warnings */
    
    stream->_xTypesState.unassignable = RTI_FALSE;
    
    result = <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_deserialize_key_sample(
        endpoint_data, (sample != NULL)?*sample:NULL, stream,
        deserialize_encapsulation, deserialize_key, endpoint_plugin_qos);
        
    if (result) {
        if (stream->_xTypesState.unassignable) {
            result = RTI_FALSE;
        }
    }
    
    return result;
}
</xsl:if>

<!-- get_serialized_key_max_size method -->
unsigned int
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_serialized_key_max_size(
    PRESTypePluginEndpointData endpoint_data,
    RTIBool include_encapsulation,
    RTIEncapsulationId encapsulation_id,
    unsigned int current_alignment)
{
<xsl:if test="$keyFields[@bitField]">
    unsigned int current_bits = 0;
</xsl:if>
<xsl:if test="$rtidds42e='no'">
    unsigned int encapsulation_size = current_alignment;
</xsl:if>

    unsigned int initial_alignment = current_alignment;

<xsl:if test="not((@kind='valuetype' or @kind='struct') and @baseClass != '' and @keyedBaseClass='yes')">
    if (endpoint_data) {} /* To avoid warnings */
</xsl:if>

    if (include_encapsulation) {
        if (!RTICdrEncapsulation_validEncapsulationId(encapsulation_id)) {
            return 1;
        }

<xsl:if test="$rtidds42e='no'">
        RTICdrStream_getEncapsulationSize(encapsulation_size);
        encapsulation_size -= current_alignment;
        current_alignment = 0;
        initial_alignment = 0;
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
        RTICdrStream_getEncapsulationSize(current_alignment);
</xsl:if>
    }
        
<xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass != '' and @keyedBaseClass='yes'">
    <xsl:text>    current_alignment += </xsl:text>
    <xsl:value-of select="@baseClass"/>Plugin_get_serialized_key_max_size(
        endpoint_data,
        RTI_FALSE, encapsulation_id,
        current_alignment);
</xsl:if>
        
<xsl:choose>
    <xsl:when test="name(.) = 'typedef'">
        <xsl:apply-templates select="./member"
                             mode="code-generation">
            <xsl:with-param name="generationMode" select="'get_max_size_serialized_key'"/>
        </xsl:apply-templates>
    </xsl:when>
    <xsl:when test="not($keyFields) and (not(@keyedBaseClass) or @keyedBaseClass='no')">
    current_alignment += <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_get_serialized_sample_max_size(
        endpoint_data,RTI_FALSE, encapsulation_id, current_alignment);
    </xsl:when>
    <xsl:otherwise>
	<xsl:apply-templates select="member[following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'key']]"
                     mode="code-generation">
	    <xsl:with-param name="generationMode" select="'get_max_size_serialized_key'"/>
	</xsl:apply-templates>
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> 
    /* Sentinel */
    current_alignment += RTICdrStream_getExtendedParameterHeaderMaxSizeSerialized(current_alignment);
        </xsl:if>

   </xsl:otherwise>
</xsl:choose>
<xsl:if test="$rtidds42e='no'">
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }
</xsl:if>
    return current_alignment - initial_alignment;
}

<!-- serialized_sample_to_key method -->
RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_serialized_sample_to_key(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> *sample,
    struct RTICdrStream *stream, 
    RTIBool deserialize_encapsulation,  
    RTIBool deserialize_key, 
    void *endpoint_plugin_qos)
{
    char * position = NULL;
<xsl:if test="(@kind='struct' or @kind='valuetype') and $xType='EXTENSIBLE_EXTENSIBILITY'">
    RTIBool done = RTI_FALSE;
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
    RTIBool topLevel;
</xsl:if>
<xsl:if test="($isKeyed='yes' or name(.) = 'typedef') 
              and ($xType='MUTABLE_EXTENSIBILITY' or member[@optional='true'])">
    DDS_UnsignedLong memberId = 0;
    DDS_UnsignedLong length = 0;
    RTIBool extended;
    RTIBool mustUnderstand = RTI_FALSE;
    struct RTICdrStreamState state;
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    RTIBool end = RTI_FALSE;
</xsl:if>
</xsl:if>    
<xsl:if test="$keyFields[@bitField]">
    RTICdrUnsignedLong bit_val = 0;
</xsl:if>

<xsl:if test="not($isKeyed='no' and name(.) != 'typedef')">
    if (endpoint_data) {} /* To avoid warnings */
    if (endpoint_plugin_qos) {} /* To avoid warnings */
</xsl:if>

<xsl:if test="(@kind='struct' or @kind='valuetype') and $xType='EXTENSIBLE_EXTENSIBILITY'">
    if (stream == NULL) goto fin; /* To avoid warnings */
</xsl:if>

    if(deserialize_encapsulation) {
        if (!RTICdrStream_deserializeAndSetCdrEncapsulation(stream)) {
            return RTI_FALSE;
        }
<xsl:if test="$rtidds42e='no'">
        position = RTICdrStream_resetAlignment(stream);
</xsl:if>
    }

    if (deserialize_key) {
<xsl:if test="$rtidds42e='yes'">
        topLevel = !RTICdrStream_isDirty(stream);
        RTICdrStream_setDirtyBit(stream,RTI_TRUE);

        if (!deserialize_encapsulation &amp;&amp; topLevel) {
            position = RTICdrStream_resetAlignmentWithOffset(stream,4);
        }
</xsl:if>

<xsl:if test="$isKeyed='no' and name(.) != 'typedef'">
        if (!<xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_deserialize_sample(
            endpoint_data, sample, stream, RTI_FALSE, 
            RTI_TRUE, endpoint_plugin_qos)) {
            return RTI_FALSE;
        }
</xsl:if>

<xsl:if test="$isKeyed='yes' or name(.) = 'typedef'">
    <xsl:if test="@kind='valuetype' or @kind='struct'">
        <xsl:choose>
            <xsl:when test="@baseClass != '' and @keyedBaseClass='yes'">
            
                <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
                    {
                    char * begin = RTICdrStream_getCurrentPosition(stream);
                    RTICdrStream_pushState(
                        stream, &amp;state, -1);
                </xsl:if>
                <xsl:text>        if (!</xsl:text>
                <xsl:value-of select="@baseClass"/>
                <xsl:text>Plugin_serialized_sample_to_key(endpoint_data,&nl;</xsl:text>
                <xsl:text>                (</xsl:text><xsl:value-of select="@baseClass"/>
                <xsl:text> *)sample,&nl;</xsl:text>
                <xsl:text>                stream, RTI_FALSE, RTI_TRUE,&nl;</xsl:text>
                <xsl:text>                endpoint_plugin_qos)) {&nl;</xsl:text>
                <xsl:text>            return RTI_FALSE;&nl;</xsl:text>
                <xsl:text>        }&nl;</xsl:text>        
                <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
                    RTICdrStream_popState(
                        stream, &amp;state);
                    RTICdrStream_setCurrentPosition(stream, begin);
                    }
                </xsl:if>
            </xsl:when>
            <xsl:when test="@baseClass != ''">
                <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
                    {
                    char *begin = RTICdrStream_getCurrentPosition(stream);
                    RTICdrStream_pushState(
                        stream, &amp;state, -1);
                </xsl:if>
                <xsl:text>        if (!</xsl:text>
                <xsl:value-of select="@baseClass"/>
                <xsl:text>Plugin_skip(endpoint_data, stream,&nl;</xsl:text>
                <xsl:text>                RTI_FALSE, RTI_TRUE,&nl;</xsl:text>
                <xsl:text>                endpoint_plugin_qos)) {&nl;</xsl:text>
                <xsl:text>            return RTI_FALSE;&nl;</xsl:text>
                <xsl:text>        }&nl;</xsl:text>        
                <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
                    RTICdrStream_popState(
                        stream, &amp;state);
                    RTICdrStream_setCurrentPosition(stream, begin);
                    }
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:if>

    <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        <xsl:value-of select="$mutableTypeStartDesBlock"/>
    </xsl:if>  
    <xsl:for-each select="./member">
        <xsl:choose>
            <xsl:when test="name(..) = 'typedef'">
                <xsl:apply-templates select="."
                                     mode="code-generation">
                    <xsl:with-param name="generationMode" select="'serialized_sample_to_key'"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="not(following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'key'])">
                <xsl:apply-templates select="."
        			     mode="code-generation">
        	    <xsl:with-param name="generationMode" select="'skip'"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="."
        			     mode="code-generation">
        	    <xsl:with-param name="generationMode" select="'serialized_sample_to_key'"/>
                </xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:for-each>  
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    <xsl:value-of select="$mutableTypeEndDesBlock"/>
</xsl:if>
</xsl:if>
    }

<xsl:if test="(@kind='struct' or @kind='valuetype') and $xType='EXTENSIBLE_EXTENSIBILITY'">
    done = RTI_TRUE;
fin:
    if (done != RTI_TRUE &amp;&amp; 
        RTICdrStream_getRemainder(stream) >=
            RTI_CDR_PARAMETER_HEADER_ALIGNMENT) {
        return RTI_FALSE;   
    }
</xsl:if>

<xsl:if test="$rtidds42e='yes'">
        if (!deserialize_encapsulation &amp;&amp; topLevel) {
            RTICdrStream_restoreAlignment(stream,position);
        }
</xsl:if>
<xsl:if test="$rtidds42e='no'">
    if(deserialize_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }
</xsl:if>

    return RTI_TRUE;
}


<xsl:if test="$isKeyed='yes'">

<!-- instance_to_key method -->
RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_instance_to_key(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/>KeyHolder *dst, 
    const <xsl:value-of select="$fullyQualifiedStructName"/> *src)
{  
<xsl:if test="not((@kind='valuetype' or @kind='struct') and @baseClass != '' and @keyedBaseClass='yes')">
    if (endpoint_data) {} /* To avoid warnings */
</xsl:if>
  
<xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass != '' and @keyedBaseClass='yes'">
    <xsl:text>    if (!</xsl:text>
    <xsl:value-of select="@baseClass"/>
    <xsl:text>Plugin_instance_to_key(endpoint_data,(</xsl:text>
    <xsl:value-of select="@baseClass"/><xsl:text> *)</xsl:text>
    <xsl:text>dst,(const </xsl:text>
    <xsl:value-of select="@baseClass"/>
    <xsl:text>*)src)) {&nl;</xsl:text>        
    <xsl:text>        return RTI_FALSE;&nl;</xsl:text>
    <xsl:text>    }</xsl:text>
</xsl:if>

<xsl:apply-templates select="member[following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'key']]"
                     mode="code-generation">
    <xsl:with-param name="generationMode" select="'copy'"/>
</xsl:apply-templates>
    return RTI_TRUE;
}

<!-- key_to_instance method -->
RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_key_to_instance(
    PRESTypePluginEndpointData endpoint_data,
    <xsl:value-of select="$fullyQualifiedStructName"/> *dst, const
    <xsl:value-of select="$fullyQualifiedStructName"/>KeyHolder *src)
{
<xsl:if test="not((@kind='valuetype' or @kind='struct') and @baseClass != '' and @keyedBaseClass='yes')">
    if (endpoint_data) {} /* To avoid warnings */
</xsl:if>

<xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass != '' and @keyedBaseClass='yes'">
    <xsl:text>    if (!</xsl:text>
    <xsl:value-of select="@baseClass"/>
    <xsl:text>Plugin_key_to_instance(endpoint_data,(</xsl:text>
    <xsl:value-of select="@baseClass"/><xsl:text> *)</xsl:text>
    <xsl:text>dst,(const </xsl:text>
    <xsl:value-of select="@baseClass"/>
    <xsl:text>*)src)) {&nl;</xsl:text>        
    <xsl:text>        return RTI_FALSE;&nl;</xsl:text>
    <xsl:text>    }</xsl:text>
</xsl:if>

<xsl:apply-templates select="member[following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'key']]"
                     mode="code-generation">
    <xsl:with-param name="generationMode" select="'copy'"/>
</xsl:apply-templates>
    return RTI_TRUE;
}

<!-- instance_to_keyhash method -->
RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_instance_to_keyhash(
    PRESTypePluginEndpointData endpoint_data,
    DDS_KeyHash_t *keyhash,
    const <xsl:value-of select="$fullyQualifiedStructName"/> *instance)
{
    struct RTICdrStream * md5Stream = NULL;

    md5Stream = PRESTypePluginDefaultEndpointData_getMD5Stream(endpoint_data);

    if (md5Stream == NULL) {
        return RTI_FALSE;
    }

    RTIOsapiMemory_zero(
        RTICdrStream_getBuffer(md5Stream),
        RTICdrStream_getBufferLength(md5Stream));
    RTICdrStream_resetPosition(md5Stream);
    RTICdrStream_setDirtyBit(md5Stream, RTI_TRUE);

    if (!<xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_serialize_key(
            endpoint_data,instance,md5Stream, RTI_FALSE, RTI_CDR_ENCAPSULATION_ID_CDR_BE, RTI_TRUE,NULL)) {
        return RTI_FALSE;
    }
    
    if (PRESTypePluginDefaultEndpointData_getMaxSizeSerializedKey(endpoint_data) &gt; (unsigned int)(MIG_RTPS_KEY_HASH_MAX_LENGTH)) {
        RTICdrStream_computeMD5(md5Stream, keyhash->value);
    } else {
        RTIOsapiMemory_zero(keyhash->value,MIG_RTPS_KEY_HASH_MAX_LENGTH);
        RTIOsapiMemory_copy(
            keyhash->value, 
            RTICdrStream_getBuffer(md5Stream), 
            RTICdrStream_getCurrentPositionOffset(md5Stream));
    }

    keyhash->length = MIG_RTPS_KEY_HASH_MAX_LENGTH;
    return RTI_TRUE;
}

<!-- serialized_sample_to_keyhash method -->
RTIBool 
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_serialized_sample_to_keyhash(
    PRESTypePluginEndpointData endpoint_data,
    struct RTICdrStream *stream, 
    DDS_KeyHash_t *keyhash,
    RTIBool deserialize_encapsulation,
    void *endpoint_plugin_qos) 
{   
    char * position = NULL;
<xsl:if test="$rtidds42e='yes'">
    RTIBool topLevel;
</xsl:if>
<xsl:if test="(@kind='valuetype' or @kind='struct') and $xType='EXTENSIBLE_EXTENSIBILITY'">
    RTIBool done = RTI_FALSE;
</xsl:if>
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY' or member[@optional='true']">
    DDS_UnsignedLong memberId = 0;
    DDS_UnsignedLong length = 0;
    RTIBool mustUnderstand = RTI_FALSE;
    RTIBool extended;
    struct RTICdrStreamState state;
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    RTIBool end = RTI_FALSE;
</xsl:if>        
</xsl:if>
<xsl:if test="member[@bitField]">
    RTICdrUnsignedLong bit_val = 0;
</xsl:if>
    <xsl:text>    </xsl:text>
    <xsl:value-of select="$fullyQualifiedStructName"/> * sample = NULL;

    if (endpoint_plugin_qos) {} /* To avoid warnings */

<xsl:if test="(@kind='valuetype' or @kind='struct') and $xType='EXTENSIBLE_EXTENSIBILITY'">
    if (stream == NULL) goto fin; /* To avoid warnings */
</xsl:if>

<xsl:if test="$rtidds42e='yes'">
    topLevel = !RTICdrStream_isDirty(stream);
    RTICdrStream_setDirtyBit(stream,RTI_TRUE);
</xsl:if>

    if(deserialize_encapsulation) {
        if (!RTICdrStream_deserializeAndSetCdrEncapsulation(stream)) {
            return RTI_FALSE;
        }
<xsl:if test="$rtidds42e='no'">
        position = RTICdrStream_resetAlignment(stream);
    }
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
    } else if (topLevel) {
        position = RTICdrStream_resetAlignmentWithOffset(stream,4);
    }
</xsl:if>

    sample = (<xsl:value-of select="$fullyQualifiedStructName"/> *)
                PRESTypePluginDefaultEndpointData_getTempSample(endpoint_data);

    if (sample == NULL) {
        return RTI_FALSE;
    }

<xsl:if test="@kind='valuetype' or @kind='struct'">
    <xsl:choose>
        <xsl:when test="@baseClass != '' and @keyedBaseClass='yes'">
            <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
                {
                    char *begin = RTICdrStream_getCurrentPosition(stream);
                    RTICdrStream_pushState(
                        stream, &amp;state, -1);
            </xsl:if>
            <xsl:text>    if (!</xsl:text>
            <xsl:value-of select="@baseClass"/>
            <xsl:text>Plugin_serialized_sample_to_key(endpoint_data,&nl;</xsl:text>
            <xsl:text>            (</xsl:text><xsl:value-of select="@baseClass"/>
            <xsl:text> *)sample,&nl;</xsl:text>
            <xsl:text>            stream, RTI_FALSE, RTI_TRUE,&nl;</xsl:text>
            <xsl:text>            endpoint_plugin_qos)) {&nl;</xsl:text>
            <xsl:text>        return RTI_FALSE;&nl;</xsl:text>
            <xsl:text>    }&nl;</xsl:text>
            <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
                    RTICdrStream_popState(
                        stream, &amp;state);
                    RTICdrStream_setCurrentPosition(stream, begin);
                }
            </xsl:if>
        </xsl:when>
        <xsl:when test="@baseClass != ''">
            <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
                {
                    char *begin = RTICdrStream_getCurrentPosition(stream);
                    RTICdrStream_pushState(
                        stream, &amp;state, -1);
            </xsl:if>
            <xsl:text>    if (!</xsl:text>
            <xsl:value-of select="@baseClass"/>
            <xsl:text>Plugin_skip(endpoint_data, stream,&nl;</xsl:text>
            <xsl:text>            RTI_FALSE, RTI_TRUE,&nl;</xsl:text>
            <xsl:text>            endpoint_plugin_qos)) {&nl;</xsl:text>
            <xsl:text>        return RTI_FALSE;&nl;</xsl:text>
            <xsl:text>    }&nl;</xsl:text>
            <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
                    RTICdrStream_popState(
                        stream, &amp;state);
                    RTICdrStream_setCurrentPosition(stream, begin);
                }
            </xsl:if>
        </xsl:when>
        <xsl:otherwise>
        </xsl:otherwise>
    </xsl:choose>
</xsl:if>
    
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    <xsl:value-of select="$mutableTypeStartDesBlock"/>
</xsl:if>  
<xsl:for-each select="./member[following-sibling::node()[name() = 'directive' and @kind = 'key']]">
    <xsl:choose>
        <xsl:when test="not(following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'key'])">
            <xsl:apply-templates select="."
    			     mode="code-generation">
    	    <xsl:with-param name="generationMode" select="'skip'"/>
            </xsl:apply-templates>
        </xsl:when>
        <xsl:otherwise>
            <xsl:apply-templates select="."
    			     mode="code-generation">
    	    <xsl:with-param name="generationMode" select="'serialized_sample_to_key'"/>
            </xsl:apply-templates>
        </xsl:otherwise>
    </xsl:choose>
</xsl:for-each>  
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    <xsl:value-of select="$mutableTypeEndDesBlock"/>
</xsl:if>

<xsl:if test="(@kind='valuetype' or @kind='struct') and $xType='EXTENSIBLE_EXTENSIBILITY'">
    done = RTI_TRUE;
fin:
    if (done != RTI_TRUE &amp;&amp; 
        RTICdrStream_getRemainder(stream) >=
            RTI_CDR_PARAMETER_HEADER_ALIGNMENT) {
        return RTI_FALSE;   
    }
</xsl:if>

<xsl:if test="$rtidds42e='no'">
    if(deserialize_encapsulation) {
        RTICdrStream_restoreAlignment(stream,position);
    }
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
    if (!deserialize_encapsulation &amp;&amp; topLevel) {
        RTICdrStream_restoreAlignment(stream,position);
    }
</xsl:if>

    if (!<xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_instance_to_keyhash(
            endpoint_data, keyhash, sample)) {
        return RTI_FALSE;
    }

    return RTI_TRUE;
}
</xsl:if> <!-- $isKeyed='yes' -->

</xsl:if> <!-- noKeyCode -->

<xsl:if test="$metp ='yes'">
void*
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_sample_metp(
                                   PRESTypePluginEndpointData endpointData,
                                   void **handle)
{
    return PRESTypePluginDefaultEndpointData_getSample(endpointData,handle);
}

void
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_return_sample_metp(
                                      PRESTypePluginEndpointData endpointData,
                                      void *sample, 
                                      void *handle)
{
    METypePlugin_return_sample(endpointData,sample,handle);
    PRESTypePluginDefaultEndpointData_returnSample(endpointData,sample,handle);
}
</xsl:if>

/* ------------------------------------------------------------------------
 * Plug-in Installation Methods
 * ------------------------------------------------------------------------ */
<xsl:if test="name(.) != 'typedef' and $topLevel = 'yes'"> 
struct PRESTypePlugin *<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_new(void) 
{ 
    struct PRESTypePlugin *plugin = NULL;
    const struct PRESTypePluginVersion PLUGIN_VERSION = 
        PRES_TYPE_PLUGIN_VERSION_2_0;

    RTIOsapiHeap_allocateStructure(
        &amp;plugin, struct PRESTypePlugin);
    if (plugin == NULL) {
       return NULL;
    }

    plugin->version = PLUGIN_VERSION;

    /* set up parent's function pointers */
    plugin->onParticipantAttached =
        (PRESTypePluginOnParticipantAttachedCallback)
        <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_on_participant_attached;
    plugin->onParticipantDetached =
        (PRESTypePluginOnParticipantDetachedCallback)
        <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_on_participant_detached;
    plugin->onEndpointAttached =
        (PRESTypePluginOnEndpointAttachedCallback)
        <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_on_endpoint_attached;
    plugin->onEndpointDetached =
        (PRESTypePluginOnEndpointDetachedCallback)
        <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_on_endpoint_detached;

    plugin->copySampleFnc =
        (PRESTypePluginCopySampleFunction)
        <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_copy_sample;
    plugin->createSampleFnc =
        (PRESTypePluginCreateSampleFunction)
        <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_create_sample;
    plugin->destroySampleFnc =
        (PRESTypePluginDestroySampleFunction)
        <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_destroy_sample;

    plugin->serializeFnc =
        (PRESTypePluginSerializeFunction)
        <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_serialize;
    plugin->deserializeFnc =
        (PRESTypePluginDeserializeFunction)
        <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_deserialize;
    plugin->getSerializedSampleMaxSizeFnc =
        (PRESTypePluginGetSerializedSampleMaxSizeFunction)
        <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_get_serialized_sample_max_size;
    plugin->getSerializedSampleMinSizeFnc =
        (PRESTypePluginGetSerializedSampleMinSizeFunction)
        <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_get_serialized_sample_min_size;

<xsl:if test="$metp ='yes'">
    plugin->getSampleFnc =
        (PRESTypePluginGetSampleFunction)
        <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_sample_metp;
    plugin->returnSampleFnc =
        (PRESTypePluginReturnSampleFunction)
        <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_return_sample_metp;
</xsl:if>
<xsl:if test="$metp ='no'">
    plugin->getSampleFnc =
        (PRESTypePluginGetSampleFunction)
        <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_sample;
    plugin->returnSampleFnc =
        (PRESTypePluginReturnSampleFunction)
        <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_return_sample;
</xsl:if>
    plugin->getKeyKindFnc =
        (PRESTypePluginGetKeyKindFunction)
        <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_get_key_kind;

<xsl:choose>
    <!-- Key Functions -->
    <xsl:when test="$isKeyed = 'yes'">
    plugin->getSerializedKeyMaxSizeFnc =   
        (PRESTypePluginGetSerializedKeyMaxSizeFunction)
        <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_get_serialized_key_max_size;
    plugin->serializeKeyFnc =
        (PRESTypePluginSerializeKeyFunction)
        <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_serialize_key;
    plugin->deserializeKeyFnc =
        (PRESTypePluginDeserializeKeyFunction)
        <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_deserialize_key;
    plugin->deserializeKeySampleFnc =
        (PRESTypePluginDeserializeKeySampleFunction)
        <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_deserialize_key_sample;

    plugin->instanceToKeyHashFnc = 
        (PRESTypePluginInstanceToKeyHashFunction)
        <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_instance_to_keyhash;
    plugin->serializedSampleToKeyHashFnc = 
        (PRESTypePluginSerializedSampleToKeyHashFunction)
        <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_serialized_sample_to_keyhash;

    plugin->getKeyFnc =
        (PRESTypePluginGetKeyFunction)
        <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_key;
    plugin->returnKeyFnc =
        (PRESTypePluginReturnKeyFunction)
        <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_return_key;

    plugin->instanceToKeyFnc =
        (PRESTypePluginInstanceToKeyFunction)
        <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_instance_to_key;
    plugin->keyToInstanceFnc =
        (PRESTypePluginKeyToInstanceFunction)
        <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_key_to_instance;
    plugin->serializedKeyToKeyHashFnc = NULL; /* Not supported yet */
    </xsl:when>
    <xsl:otherwise> <!-- Unkeyed types -->
    /* These functions are only used for keyed types. As this is not a keyed
    type they are all set to NULL
    */
    plugin->serializeKeyFnc = NULL;
    plugin->deserializeKeyFnc = NULL;
    plugin->getKeyFnc = NULL;
    plugin->returnKeyFnc = NULL;
    plugin->instanceToKeyFnc = NULL;
    plugin->keyToInstanceFnc = NULL;
    plugin->getSerializedKeyMaxSizeFnc = NULL;
    plugin->instanceToKeyHashFnc = NULL;
    plugin->serializedSampleToKeyHashFnc = NULL;
    plugin->serializedKeyToKeyHashFnc = NULL;
    </xsl:otherwise>
</xsl:choose>

<xsl:choose>
    <xsl:when test="$typecode='yes'">
    plugin->typeCode =  (struct RTICdrTypeCode *)<xsl:value-of select="$selfFullyQualifiedStructName"/>_get_typecode();
    </xsl:when>
    <xsl:otherwise>
    plugin->typeCode = NULL; 
    </xsl:otherwise>
</xsl:choose>
    plugin->languageKind = PRES_TYPEPLUGIN_DDS_TYPE; 

    /* Serialized buffer */
    plugin->getBuffer = 
        (PRESTypePluginGetBufferFunction)
        <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_get_buffer;
    plugin->returnBuffer = 
        (PRESTypePluginReturnBufferFunction)
        <xsl:value-of select="$fullyQualifiedStructName"/>Plugin_return_buffer;
    plugin->getSerializedSampleSizeFnc =
        (PRESTypePluginGetSerializedSampleSizeFunction)
        <xsl:value-of select="$selfFullyQualifiedStructName"/>Plugin_get_serialized_sample_size;

    plugin->endpointTypeName = <xsl:value-of select="$fullyQualifiedStructName"/>TYPENAME;

    return plugin;
}

void
<xsl:value-of select="$fullyQualifiedStructName"/>Plugin_delete(struct PRESTypePlugin *plugin)
{
    RTIOsapiHeap_freeStructure(plugin);
} 
</xsl:if>

</xsl:if> <!-- Generate Code -->

</xsl:template>

</xsl:stylesheet>

<!-- $Id: typePlugin.c.xsl,v 1.34 2013/10/29 05:09:30 fernando Exp $ -->
