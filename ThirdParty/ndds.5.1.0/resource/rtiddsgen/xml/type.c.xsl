<?xml version="1.0"?>
<!-- 
/* $Id: type.c.xsl,v 1.14 2013/10/28 05:04:15 fernando Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
Modification history:
- - - - - - - - - - -
5.1.0,27oct13,fcs CODEGEN-620: Fixed compilation warning in finalize_w_params
5.0.1,18jul13,fcs Fixed compilation warnings
5.0.1,04jul13,fcs CODEGEN-601: Generate initial_w_params and finalize_w_params
5.0.1,24apr13,acr CODEGEN-574 Added new function finalizeOptionalMembers
5.0.1,05nov12,fcs Fixed CODEGEN-519
5.0.1,04nov12,fcs Fixed CODEGEN-525
5.0.0,10oct12,fcs Fixed return value in getDefaultDiscriminator for boolean
                  discriminator
5.0.0,21jul12,fcs Fixed issues in finalize and get_serialized_size methods to
                  support XTypes
10ac,12jun11,fcs Support BYTE bitsets
10ac,12jun11,fcs Fixed getDefaultDiscriminator for unions with enum disc
10ac,09jun11,fcs Fixed getDefaultDiscriminator for unions
10ea,11jun11,fcs Fixed compilation warnings
10ac,11may11,ai  XTypes: added xType variable in the struct template
10af,13apr11,ai  Added support for bitsets
10af,06apr11,ai  XType: take into account inheritance when declaring structs
10ae,15apr11,fcs Fixed bug 13926
10ae,27feb10,fcs Removed include guard usage
10ac,10feb10,fcs Fixed typename
10ac,04feb10,fcs Fixed bug 13275
10ac,6sep09,fcs Fixed bug 12542
10u,16jul08,tk  Removed utils.xsl
10m,27feb08,fcs Removed compilation warnings
10m,08jun06,fcs Removed const template
10m,31may06,fcs The Type Code code is moved to typeCode.c.xsl
10l,11may06,fcs Fixed type codes compilation warnings in CC
10l,19apr06,fcs Fixed bug 10994
10l,08mar06,fcs Added type code support for value types and keys
10h,17feb06,fcs Fixed compilation when generating a type code for a value type                
10h,17dec05,fcs Used T_initialize_ex cut point in sequences instead T_initialize 
10h,15dec05,fcs 4.0g compatibility (Code generated with nddsgen 4.0g can be 
                compiled in 4.1)        
10h,11dec05,fcs For C++ (using -namespace flag), OMG IDL constants are mapped 
                directly to a C++ constant definition (not a define)
10h,11dec05,fcs C++ namespace support        
10h,08dec05,fcs Removed compilation warnings        
10h,07dec05,fcs Value type support        
10f,22aug05,fcs The Type code type for C ad C++ is the same
10f,02aug05,fcs Standalone type support
10f,21jul05,fcs Global parameters are moved to typeCommon.c.xsl.
10g,15jul05,fcs Replaced 0x80000001 for RTI_CDR_TYPE_CODE_UNION_DEFAULT_LABEL
                to reference the default label.
10g,14jul05,fcs Fixed identation problems for typecode.
10g,11jul05,eys Check if type code is initialized.
10g,10jul05,eys Changed type code from global variable to get_typecode() method.
10f,27jun05,fcs Added type code support.
10e,02jun05,fcs Used T_initialize_2 cut point in sequences instead T_initialize
10e,26may05,fcs Pointers support
10e,02apr05,fcs To generate Sequences of Arrays is defined the constant "T_no_get". This
                constant prevent the generation of the sequence get method
                Used template isNecessaryGenerateCode to generate or not generate code (initialization,
                finalization,copy,sequence declaration) for the typedef declarations.
10e,29mar05,rw  Bug #10270: removed dependency on PRESTypePlugin
10e,29mar05,rw  Bug #10270: refactored copy here from type plug-in
10e,28mar05,rw  Bug #10270: refactored initialize/finalize here from
                type plug-in
10e,25mar05,rw  Added missing extern "C" declarations
10e,24mar05,rw  Bug #10270: defined initialization/finalization methods
                for sequence elements; simplified templates
10d,16mar05,fcs Refactoring of typedef mapping
10d,15nov0e,eys define typename in type.c instead of typesupport.c
10d,29jun04,eys Replace xxx.idl with actual name
10c,05apr04,eys Use c-style comment
10c,06feb04,sjr Integrated newly refactored dds_c and dds_cpp.
40a,23oct03,eys Added enums support
40a,23oct03,eys Fixed ptr type
40a,20oct03,eys Created
-->

<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
<!ENTITY namespaceSeperator "_">    <!-- namespace separator -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
        xmlns:xalan = "http://xml.apache.org/xalan">

<xsl:include href="typeCommon.c.xsl"/>
<xsl:include href="typeCode.c.xsl"/>

<xsl:output method="text"/>

<xsl:variable name="sourcePreamble" select="$generationInfo/sourcePreamble[@kind = 'type-source']"/>

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

#include "<xsl:value-of select="concat($idlFileBaseName, '.h')"/>"

<xsl:apply-templates/>
</xsl:template>
                
<xsl:template match="enum">
    <xsl:param name="containerNamespace"/>
    <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace, @name)"/>
    <xsl:variable name="members" select="./enumerator"/>
    <xsl:variable name="isBitSet" select="./@bitSet"/>
    
    <xsl:variable name="xType">
        <xsl:call-template name="getExtensibilityKind">
            <xsl:with-param name="structName" select="./@name"/>
            <xsl:with-param name="typeKind" select="'enum'"/>
            <xsl:with-param name="node" select="."/>
        </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="className">
        <xsl:if test="$isBitSet='no'"> <!-- ENUM -->
            <xsl:text>Enum</xsl:text>
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
    

    <xsl:apply-templates mode="error-checking"/>

    <xsl:text>/* ========================================================================= */&nl;</xsl:text>    
        
    <!-- Typename -->    
    <xsl:variable name="fullyQualifiedStructNameCPPNoRoot">
        <xsl:for-each select="./ancestor::module">
            <xsl:value-of select="@name"/>
            <xsl:text>::</xsl:text>                
        </xsl:for-each>
        <xsl:value-of select="@name"/>
    </xsl:variable>    

    <xsl:variable name="fullyQualifiedStructNameCPP">
        <xsl:value-of select="'::'"/>
        <xsl:value-of select="$fullyQualifiedStructNameCPPNoRoot"/>
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

    <xsl:text>const char *</xsl:text>
    <xsl:value-of select="$fullyQualifiedStructName"/>
    <xsl:text>TYPENAME = "</xsl:text><xsl:value-of select="$fullyQualifiedStructNameCPPNoRoot"/>
    <xsl:text>";&nl;</xsl:text>

    <xsl:if test="$typecode='yes'">

        <xsl:if test="$isBitSet='no'"> <!-- ENUM -->        
            <xsl:call-template name="generateEnumTypeCode">
                <xsl:with-param name="containerNamespace" select="$containerNamespace"/>
                <xsl:with-param name="enumNode" select="."/>
                <xsl:with-param name="xType" select="$xType"/>
            </xsl:call-template>
        </xsl:if>

        <xsl:if test="$isBitSet='yes'"> <!-- BITSET -->        
            <xsl:call-template name="generateBitsetTypeCode">
                <xsl:with-param name="containerNamespace" select="$containerNamespace"/>
                <xsl:with-param name="bitsetNode" select="."/>
            </xsl:call-template>
        </xsl:if>

    </xsl:if> <!-- if typecode -->

RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_initialize(
    <xsl:value-of select="$fullyQualifiedStructName"/>* sample)
{
    *sample = <xsl:value-of select="./enumerator[position() = 1]/@name"/>;
    return RTI_TRUE;
}
        
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_initialize_ex(
    <xsl:value-of select="$fullyQualifiedStructName"/>* sample,RTIBool allocatePointers,RTIBool allocateMemory)
{
    if (allocatePointers) {} /* To avoid warnings */
    if (allocateMemory) {} /* To avoid warnings */
    *sample = <xsl:value-of select="./enumerator[position() = 1]/@name"/>;
    return RTI_TRUE;
}

RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_initialize_w_params(
        <xsl:value-of select="$fullyQualifiedStructName"/>* sample,
        const struct DDS_TypeAllocationParams_t * allocParams)
{
    if (allocParams) {} /* To avoid warnings */
    *sample = <xsl:value-of select="./enumerator[position() = 1]/@name"/>;
    return RTI_TRUE;
}

void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize(
    <xsl:value-of select="$fullyQualifiedStructName"/>* sample)
{
    if (sample) {} /* To avoid warnings */
    /* empty */
}
        
void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize_ex(
    <xsl:value-of select="$fullyQualifiedStructName"/>* sample,RTIBool deletePointers)
{
    if (sample) {} /* To avoid warnings */
    if (deletePointers) {} /* To avoid warnings */
    /* empty */
}

void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize_w_params(
        <xsl:value-of select="$fullyQualifiedStructName"/>* sample,
        const struct DDS_TypeDeallocationParams_t * deallocParams)
{
    if (sample) {} /* To avoid warnings */
    if (deallocParams) {} /* To avoid warnings */
    /* empty */
}

RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_copy(
    <xsl:value-of select="$fullyQualifiedStructName"/>* dst,
    const <xsl:value-of select="$fullyQualifiedStructName"/>* src)
{
    return RTICdrType_copy<xsl:value-of select="$className"/>((RTICdr<xsl:value-of select="$className"/> *)dst, (RTICdr<xsl:value-of select="$className"/> *)src);
}

<xsl:choose>
    <xsl:when test="$language = 'C++'">
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_getValues(<xsl:value-of select="$fullyQualifiedStructName"/>Seq * values) 
    </xsl:when>
    <xsl:otherwise>
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_getValues(struct <xsl:value-of select="$fullyQualifiedStructName"/>Seq * values)
    </xsl:otherwise>
</xsl:choose>
{
    int i = 0;
    <xsl:value-of select="$fullyQualifiedStructName"/> * buffer;

<xsl:choose>
    <xsl:when test="$language = 'C++'">
    if (!values->maximum(<xsl:value-of select="count($members)"/>)) {
        return RTI_FALSE;
    }

    if (!values->length(<xsl:value-of select="count($members)"/>)) {
        return RTI_FALSE;
    }

    buffer = values->get_contiguous_buffer();
    </xsl:when>
    <xsl:otherwise>
    if (!<xsl:value-of select="$fullyQualifiedStructName"/>Seq_set_maximum(values,<xsl:value-of select="count($members)"/>)) {
        return RTI_FALSE;
    }

    if (!<xsl:value-of select="$fullyQualifiedStructName"/>Seq_set_length(values,<xsl:value-of select="count($members)"/>)) {
        return RTI_FALSE;
    }

    buffer = <xsl:value-of select="$fullyQualifiedStructName"/>Seq_get_contiguous_buffer(values);
    </xsl:otherwise>
</xsl:choose>

    <xsl:for-each select="$members">
    buffer[i] = <xsl:value-of select="./@name"/>;
    i++;
    </xsl:for-each>

    return RTI_TRUE;
}

/**
 * <![CDATA[<<IMPLEMENTATION>>]]>
 *
 * Defines:  TSeq, T
 *
 * Configure and implement '<xsl:value-of select="$fullyQualifiedStructName"/>' sequence class.
 */
#define T <xsl:value-of select="$fullyQualifiedStructName"/>
#define TSeq <xsl:value-of select="$fullyQualifiedStructName"/>Seq
#define T_initialize_w_params <xsl:value-of select="$fullyQualifiedStructName"/>_initialize_w_params
#define T_finalize_w_params   <xsl:value-of select="$fullyQualifiedStructName"/>_finalize_w_params
#define T_copy       <xsl:value-of select="$fullyQualifiedStructName"/>_copy

#ifndef NDDS_STANDALONE_TYPE
#include "dds_c/generic/dds_c_sequence_TSeq.gen"
#ifdef __cplusplus
#include "dds_cpp/generic/dds_cpp_sequence_TSeq.gen"
#endif
#else
#include "dds_c_sequence_TSeq.gen"
#ifdef __cplusplus
#include "dds_cpp_sequence_TSeq.gen"
#endif
#endif

#undef T_copy
#undef T_finalize_w_params
#undef T_initialize_w_params
#undef TSeq
#undef T
</xsl:template>

<xsl:template name="findEnumName">
    <xsl:param name="alias"/>
    <xsl:choose>
        <xsl:when test="../typedef[@name=$alias]/member[@enum='yes']">
            <xsl:value-of select="../typedef[@name=$alias]/member[@enum='yes']/@type"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:call-template name="findEnumName">
                <xsl:with-param name="alias" select="$alias"/>
            </xsl:call-template>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="struct">
    <xsl:param name="containerNamespace"/>
            
    <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace, @name)"/>
    <xsl:variable name="members" select="member"/>

    <xsl:variable name="xType">
        <xsl:call-template name="getExtensibilityKind">
            <xsl:with-param name="structName" select="./@name"/>
            <xsl:with-param name="node" select="."/>
        </xsl:call-template>
    </xsl:variable>
                    
    <xsl:apply-templates mode="error-checking"/>

    <xsl:text>/* ========================================================================= */&nl;</xsl:text>
        
    <!-- Typename -->
    <xsl:variable name="fullyQualifiedStructNameCPPNoRoot">
        <xsl:for-each select="./ancestor::module">
            <xsl:value-of select="@name"/>
            <xsl:text>::</xsl:text>                
        </xsl:for-each>
        <xsl:value-of select="@name"/>
    </xsl:variable>    

    <xsl:variable name="fullyQualifiedStructNameCPP">
        <xsl:value-of select="'::'"/>
        <xsl:value-of select="$fullyQualifiedStructNameCPPNoRoot"/>
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
        
    <xsl:text>const char *</xsl:text>
    <xsl:value-of select="$fullyQualifiedStructName"/>
    <xsl:text>TYPENAME = "</xsl:text><xsl:value-of select="$fullyQualifiedStructNameCPPNoRoot"/>
    <xsl:text>";&nl;</xsl:text>

    <!-- Typecode -->
    <xsl:if test="$typecode='yes'">
        
        <xsl:call-template name="generateStructTypeCode">
            <xsl:with-param name="containerNamespace" select="$containerNamespace"/>
            <xsl:with-param name="structNode" select="."/>
            <xsl:with-param name="xType" select="$xType"/>
        </xsl:call-template>

    </xsl:if> <!-- if typecode -->

    <!-- Typeobject 
    <xsl:if test="$typecode='yes'">
        <xsl:message terminate="no"> .....generating type object </xsl:message>
        <xsl:call-template name="generateStructTypeObject">
            <xsl:with-param name="containerNamespace" select="$containerNamespace"/>
            <xsl:with-param name="structNode" select="."/>
        </xsl:call-template>

    </xsl:if>-->
    <!-- if typeobject -->

<xsl:variable name="sequenceFields" select="member[@kind='sequence']"/>
<xsl:variable name="sequenceArrayFields" select="member[@kind='sequence' and ./cardinality]"/>

<xsl:if test="@kind='union'">

    <xsl:variable name="baseDiscType">
        <xsl:call-template name="getBaseType">
            <xsl:with-param name="member" select="./discriminator"/>
        </xsl:call-template>        
    </xsl:variable>
    
    <xsl:variable name="baseNativeDiscType">
        <xsl:call-template name="obtainNativeType">
            <xsl:with-param name="idlType" select="$baseDiscType"/>
        </xsl:call-template>    
    </xsl:variable>

    <xsl:variable name="baseEnum">    
        <xsl:call-template name="isBaseEnum">
            <xsl:with-param name="member" select="./discriminator"/>
        </xsl:call-template>        
    </xsl:variable>

    <!--  if discriminator is a boolean -->
    <xsl:choose> 
    <xsl:when test="$baseDiscType='boolean'">
DDS_Boolean <xsl:value-of select="$fullyQualifiedStructName"/>_getDefaultDiscriminator()
{
<xsl:if test="not(./member/cases/case[@value = 'default'])">
            <xsl:choose>
                <xsl:when test="./member/cases/case[@value = 'DDS_BOOLEAN_TRUE']">
<xsl:text>    return DDS_BOOLEAN_TRUE;</xsl:text>
                </xsl:when>
                <xsl:otherwise>
<xsl:text>    return DDS_BOOLEAN_FALSE;</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
</xsl:if>
<xsl:if test="./member/cases/case[@value = 'default']">
            <xsl:choose>
                <xsl:when test="./member/cases/case[@value = 'DDS_BOOLEAN_TRUE']">
<xsl:text>    return DDS_BOOLEAN_FALSE;</xsl:text>
                </xsl:when>
                <xsl:otherwise>
<xsl:text>    return DDS_BOOLEAN_TRUE;</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
</xsl:if>
}
    </xsl:when>
    <!-- end boolean  -->

    <!--  if discriminator is an enum -->
    <xsl:when test="$baseEnum = 'yes' ">
        <xsl:variable name="enumCount">
            <xsl:choose>
                <xsl:when test="./discriminator/@enum='yes'">
                    <xsl:value-of select="./discriminator/@enumCount"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="./discriminator/member/@enumCount"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_isCaseHandled(<xsl:value-of select="./discriminator/@type"/> value) 
{
<xsl:for-each select="./member/cases/case[@value != 'default']">
    if (value == <xsl:value-of select="./@value"/>) return RTI_TRUE;
</xsl:for-each>
    return RTI_FALSE;
}

<xsl:value-of select="./discriminator/@type"/><xsl:text> </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/>_getDefaultDiscriminator()
{
    int i;
<xsl:if test="not(./member/cases/case[@value = 'default'])">
<xsl:text>    </xsl:text><xsl:value-of select="./discriminator/@type"/> tmp = <xsl:value-of select="./member/cases/case[position() = 1]/@value"/>;
    for (i =0; i &lt; <xsl:value-of select="$enumCount"/>; ++i) {
    <xsl:for-each select="./member/cases/case">
        if (tmp &gt; <xsl:value-of select="./@value"/>) tmp = <xsl:value-of select="./@value"/>;
    </xsl:for-each>
    }
    return tmp;
</xsl:if>
<xsl:if test="./member/cases/case[@value = 'default']">
    <xsl:choose>
        <xsl:when test="$language = 'C++'">
<xsl:text>    </xsl:text><xsl:value-of select="$baseDiscType"/><xsl:text>Seq enumValues;</xsl:text>
        </xsl:when>
        <xsl:otherwise>
<xsl:text>    </xsl:text>struct <xsl:value-of select="$baseDiscType"/><xsl:text>Seq enumValues = DDS_SEQUENCE_INITIALIZER;</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
<xsl:text>&nl;    </xsl:text><xsl:value-of select="$baseDiscType"/> tmp;
<xsl:text>&nl;    </xsl:text><xsl:value-of select="$baseDiscType"/> * buffer;

    if (!<xsl:value-of select="$baseDiscType"/>_getValues(&amp;enumValues)) {
        <xsl:if test="./member/cases/case[@value != 'default']">
        return (<xsl:value-of select="./discriminator/@type"/>) <xsl:value-of select="./member/cases/case[@value != 'default']/@value"/>;
        </xsl:if>
    }

<xsl:choose>
    <xsl:when test="$language = 'C++'">
    buffer = enumValues.get_contiguous_buffer();
    </xsl:when>
    <xsl:otherwise>
    buffer = <xsl:value-of select="$baseDiscType"/>Seq_get_contiguous_buffer(&amp;enumValues);
    </xsl:otherwise>
</xsl:choose>

    tmp = buffer[0];

    for (i=0; i&lt;<xsl:value-of select="$enumCount"/>; i++) {
        if (!<xsl:value-of select="$fullyQualifiedStructName"/>_isCaseHandled(buffer[i])) {
            tmp = buffer[i];
            <xsl:if test="$language != 'C++'">            
            <xsl:value-of select="$baseDiscType"/>Seq_finalize(&amp;enumValues);
            </xsl:if>
            return (<xsl:value-of select="./discriminator/@type"/>)tmp;
        } else if (tmp &gt; buffer[i]) {
            tmp = buffer[i];
        }
    }

<xsl:if test="$language != 'C++'">
<xsl:text>    </xsl:text><xsl:value-of select="$baseDiscType"/>Seq_finalize(&amp;enumValues);
</xsl:if>
    return (<xsl:value-of select="./discriminator/@type"/>)tmp;
</xsl:if>
}
        </xsl:when>
    <!-- end enum  -->

    <!--  if discriminator is a long -->
        <xsl:otherwise>
<xsl:value-of select="$baseNativeDiscType"/>
<xsl:text> </xsl:text>
<xsl:value-of select="$fullyQualifiedStructName"/>_getDefaultDiscriminator()
{
<xsl:if test="not(./member/cases/case[@value = 'default'])">
    DDS_LongLong tmp = <xsl:value-of select="./member/cases/case[position() = 1]/@value"/>;
    <xsl:for-each select="./member/cases/case">
    if (tmp &gt; <xsl:value-of select="./@value"/>) tmp = <xsl:value-of select="./@value"/>;
    </xsl:for-each>
    return (<xsl:value-of select="$baseNativeDiscType"/>)tmp;
</xsl:if>
<xsl:if test="./member/cases/case[@value = 'default']">
    DDS_UnsignedLong maxValue = 0xFFFFFFFF;
    DDS_UnsignedLong i = 0;
    for (i = 0; i &lt; maxValue; ++i) {
    <xsl:for-each select="./member/cases/case[@value != 'default']">
        if (i == <xsl:value-of select="./@value"/>) continue;
     </xsl:for-each>
        break;
    }
    return (<xsl:value-of select="$baseNativeDiscType"/>)i;
</xsl:if>
}
        </xsl:otherwise>
    </xsl:choose>
</xsl:if>

RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_initialize(
    <xsl:value-of select="$fullyQualifiedStructName"/>* sample) {
  return <xsl:value-of select="$selfFullyQualifiedStructName"/>_initialize_ex(sample,RTI_TRUE,RTI_TRUE);
}
        
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_initialize_ex(
    <xsl:value-of select="$fullyQualifiedStructName"/>* sample,RTIBool allocatePointers,RTIBool allocateMemory)
{
    struct DDS_TypeAllocationParams_t allocParams =
        DDS_TYPE_ALLOCATION_PARAMS_DEFAULT;
        
    allocParams.allocate_pointers =  (DDS_Boolean)allocatePointers;
    allocParams.allocate_memory = (DDS_Boolean)allocateMemory;
    
    return <xsl:value-of select="$selfFullyQualifiedStructName"/>_initialize_w_params(
        sample,&amp;allocParams);
}

RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_initialize_w_params(
        <xsl:value-of select="$fullyQualifiedStructName"/>* sample,
        const struct DDS_TypeAllocationParams_t * allocParams)
{
<xsl:if test="$sequenceFields">
    void* buffer = NULL;
    if (buffer) {} /* To avoid warnings */
</xsl:if>        
    
    if (allocParams) {} /* To avoid warnings */
        
<xsl:if test="@kind='union'">
    sample->_d = <xsl:value-of select="$fullyQualifiedStructName"/>_getDefaultDiscriminator();
</xsl:if>
<xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass != ''">
    <xsl:text>    if (!</xsl:text>
    <xsl:value-of select="@baseClass"/>
    <xsl:text>_initialize_w_params((</xsl:text>
    <xsl:value-of select="@baseClass"/>
    <xsl:text>*)sample,allocParams)) {&nl;</xsl:text>        
    <xsl:text>        return RTI_FALSE;&nl;</xsl:text>
    <xsl:text>    }</xsl:text>
</xsl:if>
        
<!-- Don't generate any code for unions because using pointer fields
     in a union is dangerous. -->
<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'initialize'"/>
</xsl:apply-templates>

    return RTI_TRUE;
}

void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize(
    <xsl:value-of select="$fullyQualifiedStructName"/>* sample)
{
    <xsl:value-of select="$selfFullyQualifiedStructName"/>_finalize_ex(sample,RTI_TRUE);
}
        
void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize_ex(
    <xsl:value-of select="$fullyQualifiedStructName"/>* sample,RTIBool deletePointers)
{        
    struct DDS_TypeDeallocationParams_t deallocParams =
            DDS_TYPE_DEALLOCATION_PARAMS_DEFAULT;

    if (sample) { } /* To avoid warnings */
    
    deallocParams.delete_pointers = (DDS_Boolean)deletePointers;

    <xsl:value-of select="$selfFullyQualifiedStructName"/>_finalize_w_params(
        sample,&amp;deallocParams);
}

void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize_w_params(
        <xsl:value-of select="$fullyQualifiedStructName"/>* sample,
        const struct DDS_TypeDeallocationParams_t * deallocParams)
{    
    if (sample) { } /* To avoid warnings */
    if (deallocParams) {} /* To avoid warnings */

<xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass != ''">
    <xsl:text>    </xsl:text>
    <xsl:value-of select="@baseClass"/>
    <xsl:text>_finalize_w_params((</xsl:text><xsl:value-of select="@baseClass"/><xsl:text>*)sample,deallocParams);&nl;</xsl:text>        
</xsl:if>        
        
<xsl:if test="@kind = 'union' and $useUnion = 'yes'">
<!-- Don't generate any code for unions, since using pointer fields in union is dangerous -->
    <xsl:call-template name="generateMemberCode">
        <xsl:with-param name="generationMode" select="'finalize'"/>
        <xsl:with-param name="member" select="./discriminator"/>
    </xsl:call-template>
</xsl:if>
      
<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'finalize'"/>
</xsl:apply-templates>
}

void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize_optional_members(
    <xsl:value-of select="$fullyQualifiedStructName"/>* sample, RTIBool deletePointers)
{
    struct DDS_TypeDeallocationParams_t deallocParamsTmp =
        DDS_TYPE_DEALLOCATION_PARAMS_DEFAULT;
    struct DDS_TypeDeallocationParams_t * deallocParams =
        &amp;deallocParamsTmp;
    if (sample) { } /* To avoid warnings */
    if (deallocParams) {} /* To avoid warnings */

<xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass != ''">
    <xsl:text>    </xsl:text>
    <xsl:value-of select="@baseClass"/>
    <xsl:text>_finalize_optional_members((</xsl:text><xsl:value-of select="@baseClass"/><xsl:text>*)sample, deletePointers);&nl;</xsl:text>        
</xsl:if>        

    deallocParamsTmp.delete_pointers = (DDS_Boolean)deletePointers;
    deallocParamsTmp.delete_optional_members = DDS_BOOLEAN_TRUE;    
             
<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'finalize_optional'"/>
</xsl:apply-templates>
}

RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_copy(
    <xsl:value-of select="$fullyQualifiedStructName"/>* dst,
    const <xsl:value-of select="$fullyQualifiedStructName"/>* src)
{
<xsl:if test="member[@optional='true']">
    struct DDS_TypeDeallocationParams_t deallocParamsTmp =
        DDS_TYPE_DEALLOCATION_PARAMS_DEFAULT;
    struct DDS_TypeDeallocationParams_t * deallocParams =
        &amp;deallocParamsTmp;
        
    if (deallocParams) {} /* To avoid warnings */
        
    deallocParamsTmp.delete_pointers = DDS_BOOLEAN_TRUE;
    deallocParamsTmp.delete_optional_members = DDS_BOOLEAN_TRUE;    
</xsl:if>

<xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass != ''">
    <xsl:text>    if(!</xsl:text>                        
    <xsl:value-of select="@baseClass"/>
    <xsl:text>_copy((</xsl:text>
    <xsl:value-of select="@baseClass"/><xsl:text>*)dst,(</xsl:text>
    <xsl:value-of select="@baseClass"/><xsl:text>*)src)) {&nl;</xsl:text>
    <xsl:text>        return RTI_FALSE;&nl;</xsl:text>
    <xsl:text>    }&nl;</xsl:text>
</xsl:if>
        
<xsl:if test="@kind = 'union'">
<!-- Don't generate any code for unions, since using pointer fields in union is dangerous -->
    <xsl:call-template name="generateMemberCode">
        <xsl:with-param name="generationMode" select="'copy'"/>
        <xsl:with-param name="member" select="./discriminator"/>
    </xsl:call-template>
</xsl:if>

<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="unionVariableName" select="'src'"/>
    <xsl:with-param name="generationMode" select="'copy'"/>
</xsl:apply-templates>

    return RTI_TRUE;
}


/**
 * <![CDATA[<<IMPLEMENTATION>>]]>
 *
 * Defines:  TSeq, T
 *
 * Configure and implement '<xsl:value-of select="$fullyQualifiedStructName"/>' sequence class.
 */
#define T <xsl:value-of select="$fullyQualifiedStructName"/>
#define TSeq <xsl:value-of select="$fullyQualifiedStructName"/>Seq
#define T_initialize_w_params <xsl:value-of select="$selfFullyQualifiedStructName"/>_initialize_w_params
#define T_finalize_w_params   <xsl:value-of select="$selfFullyQualifiedStructName"/>_finalize_w_params
#define T_copy       <xsl:value-of select="$selfFullyQualifiedStructName"/>_copy

#ifndef NDDS_STANDALONE_TYPE
#include "dds_c/generic/dds_c_sequence_TSeq.gen"
#ifdef __cplusplus
#include "dds_cpp/generic/dds_cpp_sequence_TSeq.gen"
#endif
#else
#include "dds_c_sequence_TSeq.gen"
#ifdef __cplusplus
#include "dds_cpp_sequence_TSeq.gen"
#endif
#endif

#undef T_copy
#undef T_finalize_w_params
#undef T_initialize_w_params
#undef TSeq
#undef T

</xsl:template>

<xsl:template match="typedef">
    <xsl:param name="containerNamespace"/>
    <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace, @name)"/>

    <xsl:apply-templates mode="error-checking"/>

    <xsl:variable name="baseMemberKind">
        <xsl:call-template name="obtainBaseMemberKind">
            <xsl:with-param name="member" select="./member"/>
        </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="description">
        <xsl:call-template name="getMemberDescription">
            <xsl:with-param name="member" select="./member"/>
        </xsl:call-template>
    </xsl:variable>    
    
    <xsl:variable name="descriptionNode" select="xalan:nodeset($description)/node()"/>    

    <xsl:variable name="implementSequence">
        <xsl:call-template name="isNecessaryGenerateCode">
            <xsl:with-param name="typedefNode" select="."/>
        </xsl:call-template>                                
    </xsl:variable>
    
    <xsl:variable name="pointer">
        <xsl:choose>
            <xsl:when test="./member/@pointer = 'yes'">DDS_BOOLEAN_TRUE</xsl:when>            
            <xsl:otherwise>DDS_BOOLEAN_FALSE</xsl:otherwise>
        </xsl:choose>                                
    </xsl:variable>

    <!-- Typename -->
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

    <xsl:text>/* ========================================================================= */&nl;</xsl:text>    

    <!-- Typecode -->
    <xsl:if test="$typecode='yes'">

        <xsl:call-template name="generateTypedefTypeCode">
            <xsl:with-param name="containerNamespace" select="$containerNamespace"/>
            <xsl:with-param name="typedefNode" select="."/>
        </xsl:call-template>

    </xsl:if> <!-- if typecode -->

    <xsl:if test="$implementSequence='yes'">
<xsl:variable name="sequenceFields" select="member[@kind='sequence']"/>
<xsl:variable name="sequenceArrayFields" select="member[@kind='sequence' and ./cardinality]"/>

RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_initialize(
    <xsl:value-of select="$fullyQualifiedStructName"/>* sample)
{
    return <xsl:value-of select="$selfFullyQualifiedStructName"/>_initialize_ex(sample,RTI_TRUE,RTI_TRUE);
}

RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_initialize_ex(
    <xsl:value-of select="$fullyQualifiedStructName"/>* sample,RTIBool allocatePointers,RTIBool allocateMemory)
{
    struct DDS_TypeAllocationParams_t allocParams =
        DDS_TYPE_ALLOCATION_PARAMS_DEFAULT;
        
    allocParams.allocate_pointers =  (DDS_Boolean)allocatePointers;
    allocParams.allocate_memory = (DDS_Boolean)allocateMemory;
    
    return <xsl:value-of select="$selfFullyQualifiedStructName"/>_initialize_w_params(
        sample,&amp;allocParams);
}

RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_initialize_w_params(
        <xsl:value-of select="$fullyQualifiedStructName"/>* sample,
        const struct DDS_TypeAllocationParams_t * allocParams)
{
<xsl:if test="$sequenceFields">
    void* buffer = NULL;
    if (buffer) {} /* To avoid warnings */
</xsl:if>        
    
    if (allocParams) {} /* To avoid warnings */
        
<!-- Don't generate any code for unions because using pointer fields
     in a union is dangerous. -->
<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'initialize'"/>
</xsl:apply-templates>

    return RTI_TRUE;
}

void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize(
    <xsl:value-of select="$fullyQualifiedStructName"/>* sample)
{
    <xsl:value-of select="$selfFullyQualifiedStructName"/>_finalize_ex(sample,RTI_TRUE);
}
 
void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize_ex(
    <xsl:value-of select="$fullyQualifiedStructName"/>* sample,RTIBool deletePointers)
{        
    struct DDS_TypeDeallocationParams_t deallocParams =
            DDS_TYPE_DEALLOCATION_PARAMS_DEFAULT;

    if (sample) { } /* To avoid warnings */
    
    deallocParams.delete_pointers = (DDS_Boolean)deletePointers;

    <xsl:value-of select="$selfFullyQualifiedStructName"/>_finalize_w_params(
        sample,&amp;deallocParams);
}
           
void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize_w_params(
    <xsl:value-of select="$fullyQualifiedStructName"/>* sample,
    const struct DDS_TypeDeallocationParams_t * deallocParams)
{
    if (sample) { } /* To avoid warnings */

<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'finalize'"/>
</xsl:apply-templates>
}

void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize_optional_members(
    <xsl:value-of select="$fullyQualifiedStructName"/>* sample, RTIBool deletePointers)
{   
    struct DDS_TypeDeallocationParams_t deallocParamsTmp =
        DDS_TYPE_DEALLOCATION_PARAMS_DEFAULT;
    struct DDS_TypeDeallocationParams_t * deallocParams =
        &amp;deallocParamsTmp;
     
    if (sample) { } /* To avoid warnings */
    if (deallocParams) {} /* To avoid warnings */
    
    deallocParamsTmp.delete_pointers = (DDS_Boolean)deletePointers;
    deallocParamsTmp.delete_optional_members = DDS_BOOLEAN_TRUE;    

<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'finalize_optional'"/>
</xsl:apply-templates>
}

RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_copy(
    <xsl:value-of select="$fullyQualifiedStructName"/>* dst,
    const <xsl:value-of select="$fullyQualifiedStructName"/>* src)
{
<xsl:if test="@kind = 'union'">
<!-- Don't generate any code for unions, since using pointer fields in union is dangerous -->
    <xsl:call-template name="generateMemberCode">
        <xsl:with-param name="generationMode" select="'copy'"/>
        <xsl:with-param name="member" select="./discriminator"/>
    </xsl:call-template>
</xsl:if>

<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="unionVariableName" select="'src'"/>
    <xsl:with-param name="generationMode" select="'copy'"/>
</xsl:apply-templates>

    return RTI_TRUE;
}

    </xsl:if><!-- test="$implementSequence='yes'" -->
    <xsl:if test="$implementSequence='yes'">
/**
 * <![CDATA[<<IMPLEMENTATION>>]]>
 *
 * Defines:  TSeq, T
 *
 * Configure and implement '<xsl:value-of select="$fullyQualifiedStructName"/>' sequence class.
 */
#define T            <xsl:value-of select="$fullyQualifiedStructName"/>
#define TSeq         <xsl:value-of select="$fullyQualifiedStructName"/>Seq
#define T_initialize_w_params <xsl:value-of select="$selfFullyQualifiedStructName"/>_initialize_w_params
#define T_finalize_w_params   <xsl:value-of select="$selfFullyQualifiedStructName"/>_finalize_w_params
#define T_copy       <xsl:value-of select="$selfFullyQualifiedStructName"/>_copy

<xsl:if test="$baseMemberKind='array' or $baseMemberKind='arraySequence'">
#define T_no_get        
</xsl:if>
#ifndef NDDS_STANDALONE_TYPE
#include "dds_c/generic/dds_c_sequence_TSeq.gen"
#ifdef __cplusplus
#include "dds_cpp/generic/dds_cpp_sequence_TSeq.gen"
#endif
#else
#include "dds_c_sequence_TSeq.gen"
#ifdef __cplusplus
#include "dds_cpp_sequence_TSeq.gen"
#endif
#endif
<xsl:if test="$baseMemberKind='array' or $baseMemberKind='arraySequence'">
#undef T_no_get
</xsl:if>
#undef T_copy
#undef T_finalize_w_params
#undef T_initialize_w_params
#undef TSeq
#undef T

</xsl:if><!-- test="$implementSequence='yes'" -->
</xsl:template>

</xsl:stylesheet>
