<?xml version="1.0"?>
<!-- 
/* $Id: typeSupport.c.xsl,v 1.5 2012/04/23 16:44:18 fernando Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
Modification history:
- - - - - - - - - - -
10ae,27feb10,fcs Removed include guard usage
10ac,04feb10,fcs Fixed bug 13275
10l,08apr09,vtg Fixed bug #12876: Value type warnings in C++
10l,16jul08,tk  Removed utils.xsl
10l,22feb07,fcs Removed fullyQualifiedStructNameC
10l,22feb07,eys Use fullyQualifiedStructName for TPlugin_new
10l,17feb07,eys Added define for TPlugin_delete
10l,22mar06,fcs DDSQL support
10h,19jan06,fcs Changed the place where sourcePreamble is printed in order
                to resolve a compilation problem (with DLL) in Windows
10h,12jan06,fcs Define TTYPENAME for the DataReader and DataWriter
10d,09apr05,fcs Generated Support code only if the structure/union is a top-level type
10d,15nov04,eys Type plugin refactoring
10d,29jun04,eys Replace xxx.idl with actual name
10c,10jun04,eys Renamed DataType to TypeSupport
10c,05apr04,eys Use c-style comment
10c,09feb04,sjr Integrated newly refactored dds_c and dds_cpp.
40a,23oct03,eys Fixed ptr type
40a,23oct03,eys Changed from TDataSeq to TDataPtrSeq
40a,20oct03,eys Refactored sequence
40a,08oct03,eys generic template refactored
40a,28sep03,eys Renamed from readerwriter
30a,29sep03,eys Fixed includes
40a,28sep03,eys Added template for reader writer file
40a,06sep03,rrl Created
-->

<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
<!ENTITY namespaceSeperator "_">    <!-- namespace separator -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xalan="http://xml.apache.org/xalan" version="1.0">


<xsl:include href="typeCommon.c.xsl"/>

<xsl:output method="text"/>

<xsl:variable name="sourcePreamble" select="$generationInfo/sourcePreamble[@kind = 'support-source']"/>

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

#include "<xsl:value-of select="concat($idlFileBaseName, 'Support', '.h')"/>"
#include "<xsl:value-of select="concat($idlFileBaseName, 'Plugin', '.h')"/>"

<xsl:value-of select="$sourcePreamble"/>

<xsl:apply-templates/>

</xsl:template>

<xsl:template match="struct">
    <xsl:param name="containerNamespace"/>
    <xsl:variable name="structName" select="concat($containerNamespace, @name)"/>

    <xsl:variable name="fullyQualifiedStructName">
        <xsl:choose>
            <xsl:when test="$language='C' or $namespace='no'">                    
                <xsl:value-of select="$structName"/>
            </xsl:when>                
            <xsl:otherwise>                    
                <xsl:value-of select="'::'"/>
                <xsl:for-each select="./ancestor::module">
                    <xsl:value-of select="@name"/>
                    <xsl:text>::</xsl:text>
                </xsl:for-each>
                <xsl:value-of select="@name"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="replacementMap">
        <map structName="{$structName}" fullyQualifiedStructName="{$fullyQualifiedStructName}"/>
    </xsl:variable>

    <xsl:variable name="topLevel">
        <xsl:call-template name="isTopLevelType">
            <xsl:with-param name="typeNode" select="."/>
        </xsl:call-template>
    </xsl:variable>
       
<xsl:if test="$topLevel='yes'">

    <xsl:apply-templates mode="error-checking"/>

    <xsl:call-template name="replace-string-from-map">
        <xsl:with-param name="replacementParamsMap" select="xalan:nodeset($replacementMap)/node()"/>
        
<!-- The template for Support of each struct -->
        <xsl:with-param name="inputString">
<![CDATA[

/* ========================================================================= */
/**
   <<IMPLEMENTATION>>

   Defines:   TData,
              TDataWriter,
              TDataReader,
              TTypeSupport

   Configure and implement '%%structName%%' support classes.

   Note: Only the #defined classes get defined
*/

/* ----------------------------------------------------------------- */
/* DDSDataWriter
*/

/**
  <<IMPLEMENTATION >>

   Defines:   TDataWriter, TData
*/

/* Requires */
#define TTYPENAME   %%structName%%TYPENAME

/* Defines */
#define TDataWriter %%structName%%DataWriter
#define TData       %%fullyQualifiedStructName%%
]]>
<xsl:if test="$database = 'no'">
#ifdef __cplusplus
#include "dds_cpp/generic/dds_cpp_data_TDataWriter.gen"
#else
#include "dds_c/generic/dds_c_data_TDataWriter.gen"
#endif
</xsl:if>
<xsl:if test="$database = 'yes'">
#ifdef __cplusplus
#include "ddsql/ddsql_cpp_data_TDataWriter.gen"
#else
#include "ddsql/ddsql_c_data_TDataWriter.gen"
#endif
</xsl:if>
<![CDATA[
#undef TDataWriter
#undef TData

#undef TTYPENAME

/* ----------------------------------------------------------------- */
/* DDSDataReader
*/

/**
  <<IMPLEMENTATION >>

   Defines:   TDataReader, TDataSeq, TData
*/

/* Requires */
#define TTYPENAME   %%structName%%TYPENAME

/* Defines */
#define TDataReader %%structName%%DataReader
#define TDataSeq    %%structName%%Seq
#define TData       %%fullyQualifiedStructName%%
]]>
<xsl:if test="$database = 'no'">
#ifdef __cplusplus
#include "dds_cpp/generic/dds_cpp_data_TDataReader.gen"
#else
#include "dds_c/generic/dds_c_data_TDataReader.gen"
#endif
</xsl:if>
<xsl:if test="$database = 'yes'">
#ifdef __cplusplus
#include "ddsql/ddsql_cpp_data_TDataReader.gen"
#else
#include "ddsql/ddsql_c_data_TDataReader.gen"
#endif
</xsl:if>
<![CDATA[
#undef TDataReader
#undef TDataSeq
#undef TData

#undef TTYPENAME

/* ----------------------------------------------------------------- */
/* TypeSupport

  <<IMPLEMENTATION >>

   Requires:  TTYPENAME,
              TPlugin_new
              TPlugin_delete
   Defines:   TTypeSupport, TData, TDataReader, TDataWriter
*/

/* Requires */
#define TTYPENAME    %%structName%%TYPENAME
#define TPlugin_new  %%fullyQualifiedStructName%%Plugin_new
#define TPlugin_delete  %%fullyQualifiedStructName%%Plugin_delete

/* Defines */
#define TTypeSupport %%structName%%TypeSupport
#define TData        %%fullyQualifiedStructName%%
#define TDataReader  %%structName%%DataReader
#define TDataWriter  %%structName%%DataWriter
#ifdef __cplusplus
]]>
<xsl:if test="@kind='valuetype'">
    <xsl:text>#define RTI_VALUETYPE</xsl:text>
</xsl:if>
<![CDATA[
#include "dds_cpp/generic/dds_cpp_data_TTypeSupport.gen"
]]>
<xsl:if test="@kind='valuetype'">
    <xsl:text>#undef RTI_VALUETYPE</xsl:text>
</xsl:if>
<![CDATA[
#else
#include "dds_c/generic/dds_c_data_TTypeSupport.gen"
#endif
#undef TTypeSupport
#undef TData
#undef TDataReader
#undef TDataWriter

#undef TTYPENAME
#undef TPlugin_new
#undef TPlugin_delete
]]>

</xsl:with-param>
    </xsl:call-template>

</xsl:if> <!-- if topLevel -->
</xsl:template>

</xsl:stylesheet>
