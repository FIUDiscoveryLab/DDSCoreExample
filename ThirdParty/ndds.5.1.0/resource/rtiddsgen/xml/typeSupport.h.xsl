<?xml version="1.0"?>
<!-- 
/* $Id: typeSupport.h.xsl,v 1.8 2013/10/07 22:04:30 roshan Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
Modification history:
- - - - - - - - - - -
5.1.0,07oct13,rk   Fixed CODEGEN-349 : replaced hyphen with underscore
5.0.1,26sep13,rk  Fixed CODEGEN-349 : replaced period with underscore
5.0.1,16jul13,fcs Removed class import statements
5.0.1,22may13,fcs CODEGEN-594: Added suffix to DLL_EXPORT_MACRO
10ae,31jan12,vtg RTI-110 Add support to rtiddsgen to produce dll importable code on windows
10ae,27feb10,fcs Used executionId for include guard
10l,12jan10,tk  Merged from tk-2009-12-28-TAG_BRANCH_NDDS45A_NORTH12_MERGE_TO_HEAD
10l,08apr09,vtg Fixed bug #12876: Value type warnings in C++
10l,16jul08,tk  Removed utils.xsl (include in common)
10l,22mar06,fcs DDSQL support
10d,12dec05,fcs Fixed Windows namespace bug        
10g,12jul05,jml from Elaine: class dll imports only needed if the user 
                is building his own DLL.
10d,09apr05,fcs Generated Support code only if the structure/union is a top-level type
10e,31mar05,rw  Bug #10076: import base types when building Windows DLL's
10d,29jun04,eys Replace xxx.idl with actual name
10d,10jun04,eys Renamed DataType to TypeSupport
10c,10jun04,eys Fixded c and cpp includes
10c,06feb04,sjr Integrated newly refactored dds_c and dds_cpp.
40a,27oct03,eys Fixed dds includes
40a,20oct03,eys Refactored sequence
40a,13oct03,eys Fixed includes, fixed sequence definitions
40a,08oct03,eys generic template refactored
40a,28sep03,eys Renamed from readerwriter
40a,28sep03,eys Added template for reader writer header file
40a,06sep03,rrl Created
-->

<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
<!ENTITY namespaceSeperator "_">    <!-- namespace separator -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:include href="typeCommon.c.xsl"/>

<xsl:output method="text"/>

<xsl:param name="metp"/>

<xsl:variable name="sourcePreamble" select="$generationInfo/sourcePreamble[@kind = 'support-header']"/>

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

#ifndef <xsl:value-of select="concat(translate($idlFileBaseName,'.-','__'), 'Support', '_', $executionId, '_h')"/>
#define <xsl:value-of select="concat(translate($idlFileBaseName,'.-','__'), 'Support', '_', $executionId, '_h')"/>

/* Uses */
#include "<xsl:value-of select="concat($idlFileBaseName, '.h')"/>"

<xsl:if test="$database = 'yes'">
#include "ddsql/ddsql_c_impl.h"
</xsl:if>

<xsl:value-of select="$sourcePreamble"/>

    <xsl:apply-templates/>

#endif  /* <xsl:value-of select="concat(translate($idlFileBaseName,'.-','__'), 'Support', '_', $executionId, '_h')"/> */
</xsl:template>

<xsl:template match="struct">
	<xsl:param name="containerNamespace"/>
	<xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace, @name)"/>

    <xsl:variable name="topLevel">
        <xsl:call-template name="isTopLevelType">
            <xsl:with-param name="typeNode" select="."/>
        </xsl:call-template>
    </xsl:variable>
       
<xsl:if test="$topLevel='yes'">

    <xsl:apply-templates mode="error-checking"/>
        
    <xsl:variable name="scopeSymbol">            
        <xsl:if test="$language='C++' and $namespace='yes'">
            <xsl:text>::</xsl:text>                
        </xsl:if>
    </xsl:variable>        

/* ========================================================================= */
/**
   Uses:     T

   Defines:  TTypeSupport, TDataWriter, TDataReader

   Organized using the well-documented "Generics Pattern" for
   implementing generics in C and C++.
*/

#if (defined(RTI_WIN32) || defined (RTI_WINCE)) &amp;&amp; defined(NDDS_USER_DLL_EXPORT<xsl:value-of select="$dllExportMacroFinalSuffix"/>)
  /* If the code is building on Windows, start exporting symbols.
  */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport __declspec(dllexport)
#endif

#ifdef __cplusplus
<xsl:if test="@kind='valuetype'">
    <xsl:text>#define RTI_VALUETYPE</xsl:text>
</xsl:if>
DDS_TYPESUPPORT_CPP(<xsl:value-of select="$fullyQualifiedStructName"/>TypeSupport, <xsl:value-of select="$fullyQualifiedStructName"/>);
<xsl:if test="$metp ='yes'">
DDS_DATAWRITER_CPP_METP(<xsl:value-of select="$fullyQualifiedStructName"/>DataWriter, <xsl:value-of select="$fullyQualifiedStructName"/>);
DDS_DATAREADER_CPP_METP(<xsl:value-of select="$fullyQualifiedStructName"/>DataReader, <xsl:value-of select="$fullyQualifiedStructName"/>Seq, <xsl:value-of select="$fullyQualifiedStructName"/>);
</xsl:if>
<xsl:if test="$metp ='no'">

<xsl:if test="$database = 'yes'">
DDSQL_DATAWRITER_CPP(<xsl:value-of select="$fullyQualifiedStructName"/>DataWriter, <xsl:value-of select="$fullyQualifiedStructName"/>);
DDSQL_DATAREADER_CPP(<xsl:value-of select="$fullyQualifiedStructName"/>DataReader, <xsl:value-of select="$fullyQualifiedStructName"/>Seq, <xsl:value-of select="$fullyQualifiedStructName"/>);
</xsl:if>
<xsl:if test="$database = 'no'">
DDS_DATAWRITER_CPP(<xsl:value-of select="$fullyQualifiedStructName"/>DataWriter, <xsl:value-of select="$fullyQualifiedStructName"/>);
DDS_DATAREADER_CPP(<xsl:value-of select="$fullyQualifiedStructName"/>DataReader, <xsl:value-of select="$fullyQualifiedStructName"/>Seq, <xsl:value-of select="$fullyQualifiedStructName"/>);
</xsl:if>
</xsl:if>

<xsl:if test="@kind='valuetype'">
    <xsl:text>#undef RTI_VALUETYPE</xsl:text>
</xsl:if>

#else

DDS_TYPESUPPORT_C(<xsl:value-of select="$fullyQualifiedStructName"/>TypeSupport, <xsl:value-of select="$fullyQualifiedStructName"/>);
DDS_DATAWRITER_C(<xsl:value-of select="$fullyQualifiedStructName"/>DataWriter, <xsl:value-of select="$fullyQualifiedStructName"/>);
DDS_DATAREADER_C(<xsl:value-of select="$fullyQualifiedStructName"/>DataReader, <xsl:value-of select="$fullyQualifiedStructName"/>Seq, <xsl:value-of select="$fullyQualifiedStructName"/>);

#endif

#if (defined(RTI_WIN32) || defined (RTI_WINCE)) &amp;&amp; defined(NDDS_USER_DLL_EXPORT<xsl:value-of select="$dllExportMacroFinalSuffix"/>)
  /* If the code is building on Windows, stop exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport
#endif

</xsl:if> <!-- if topLevel -->

</xsl:template>

</xsl:stylesheet>
