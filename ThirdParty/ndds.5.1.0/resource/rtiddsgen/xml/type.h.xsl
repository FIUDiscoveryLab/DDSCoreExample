<?xml version="1.0"?>
<!-- 
/* $Id: type.h.xsl,v 1.13 2013/10/07 22:04:30 roshan Exp $
 
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
5.0.1,22may13,fcs CODEGEN-594: Added suffix to DLL_EXPORT_MACRO
5.0.1,24apr13,acr CODEGEN-574 Added new function finalizeOptionalMembers
5.0.1,05nov12,fcs Fixed CODEGEN-519
5.0.0,09sep12,fcs Moved LAST_MEMBER_ID from typePlugin
5.0.0,10jul12,fcs Fixed CODEGEN-502
10ae,31jan12,vtg RTI-110 Add support to rtiddsgen to produce dll importable code on windows
10ae,23jan12,fcs RTI-98 Modification to the C++ code generation to support C++ template programming
10ac,27jun11,fcs Fixed bitset generation for 8 bits
10ac,09jun11,fcs Fixed getDefaultDiscriminator for unions
10af,13apr11,ai  Added support for bitsets
10af,06apr11,ai  XType: take into account inheritance when declaring structs
10ae,27feb10,fcs Used executionId for include guard
10y,12jan10,tk  Merged from tk-2009-12-28-TAG_BRANCH_NDDS45A_NORTH12_MERGE_TO_HEAD
10y,17sep08,jlv Fixed include. Now files with more than one dot in the name 
                (or with an extension different to 'idl') are allowed.
10m,16jul08,tk  Removed utils.xsl
10m,18jul06,fcs Constant support inside value types
10m,08jun06,fcs Fixed bug 11140
10h,15dec05,fcs 4.0g compatibility (Code generated with nddsgen 4.0g can be 
                compiled in 4.1)        
10h,09dec05,fcs For C++ (using -namespace flag), OMG IDL constants are mapped 
                directly to a C++ constant definition (not a define)
10h,08dec05,fcs Added C++ namespace support
10h,07dec05,fcs Added value type support        
10f,22aug05,fcs The Type code type for C ad C++ is the same
10f,21jul05,fcs Added template for the copy-declaration and copy-c-declaration
                directives
10f,21jul05,fcs Moved process directives code to typeCommon.c.xsl in order to resolve bug
                10496
10f,21jul05,fcs Global parameters are moved to typeCommon.c.xsl.
10f,10jul05,eys Changed type code from global variable to get_typecode() method
10f,27jun05,fcs Added type code support
10e,26may05,fcs Added pointers support
10e,09apr05,fcs Allowed top-level directive. 
10e,08apr05,rw  Added generated type name to "_u" union member to avoid
                compile errors on Windows
10e,04apr05,rw  Bug #10076: generated functions are now DLL exported
10e,02apr05,fcs To generate Sequences of Arrays is used the macro DDS_SEQUENCE_NO_GET
                Used template isNecessaryGenerateCode to generate or not generate code (initialization,
                finalization,copy,sequence declaration) for the typedef declarations.
10e,31mar05,fcs Allowed resolve-name directive. 
                This directive is used to indicate to nddsgen if it should resolve the scope.
                When this directive is not present nddsgen resolves the scope.
10e,29mar05,rw  Bug #10270: added declarations for refactored copy
10e,28mar05,rw  Bug #10270: added declarations for refactored
                initialize/finalize
10d,16mar05,fcs Refactoring of typedef mapping
                Changed the union mapping (now it is an structure)
10d,25aug04,rw  Added support for copy-c directive
10d,22jul04,rw  Don't issue warning when encountering @key directive
10d,29jun04,eys Replace xxx.idl with actual name
10c,10jun04,eys Fixded c and cpp includes
10c,18may04,rrl Fixed problem of union discriminator not mapped using 
                idl->native type mapping 
10c,18may04,rrl Fixed #8720 by mapping typedefed types to native types.
10c,11feb04,rrl Support @copy directive
10c,06feb04,sjr Integrated newly refactored dds_c and dds_cpp.
40b,03feb04,rrl Support typedef
40b,26jan04,rrl Modified union declaration to use _u nested element 
                following the IDL spec.
40b,14jan04,rrl Support unions
40b,29dec03,rrl Support enums with values (typedef support in progress)
40a,27oct03,eys Fixed dds includes
40a,24oct03,eys Added enum support
40a,23oct03,eys Fixed ptr type
40a,20oct03,eys Refactored sequence
40a,13oct03,eys Fixed includes, added sequence definition
40a,03oct03,eys Include dds_common.h
40a,29sep03,eys Fixed include
40a,09sep03,eys make typename extern
40a,06sep03,rrl Created (by refactoring typePlugin.h.xsl)
-->

<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
<!ENTITY namespaceSeperator "_">    <!-- namespace separator -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
        xmlns:xalan = "http://xml.apache.org/xalan">

<xsl:include href="typeCommon.c.xsl"/>

<xsl:output method="text"/>

<xsl:variable name="sourcePreamble" select="$generationInfo/sourcePreamble[@kind = 'type-header']"/>

<xsl:variable name="typeCodeTypeName">
    <xsl:choose>
        <xsl:when test="$language = 'C'">                
            <xsl:text>DDS_TypeCode</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>DDS_TypeCode</xsl:text>                
        </xsl:otherwise>
    </xsl:choose>                
</xsl:variable>

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

#ifndef <xsl:value-of select="concat(translate($idlFileBaseName,'.-','__'), '_', $executionId, '_h')"/>
#define <xsl:value-of select="concat(translate($idlFileBaseName,'.-','__'), '_', $executionId, '_h')"/>

<xsl:value-of select="$sourcePreamble"/>

    <xsl:apply-templates/>

#endif /* <xsl:value-of select="concat(translate($idlFileBaseName,'.-','__'), '_', $executionId, '_h')"/> */
</xsl:template>

<!-- Forward declarations
-->
<xsl:template match="forward_dcl">
    <xsl:if test="(@kind='valuetype' or @kind='struct') and $language='C++'">            
class <xsl:value-of select="@name"/>;         
    </xsl:if>                        
    <xsl:if test="(@kind='valuetype' or @kind='struct') and $language='C'">            
struct <xsl:value-of select="@name"/>;
    </xsl:if>                                
</xsl:template>
        
<!-- Constant declarations 
-->
<xsl:template match="const">
    <xsl:param name="containerNamespace"/>
    <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace, @name)"/>

    <xsl:choose>
        <xsl:when test="$language='C++'">
            <xsl:variable name="nativeType">
                <xsl:call-template name="obtainNativeType">
                    <xsl:with-param name="idlType" select="@type"/>
                </xsl:call-template>                     
            </xsl:variable>             
static const <xsl:value-of select="concat($nativeType,' ',$fullyQualifiedStructName,' = ',@value,';')"/>
        </xsl:when>                               
        <xsl:otherwise>                
#define <xsl:value-of select="$fullyQualifiedStructName"/> (<xsl:value-of select="@value"/>)                
        </xsl:otherwise>
    </xsl:choose>                
</xsl:template>

<xsl:template match="include">
  <xsl:variable name="includedFile">
        <xsl:call-template name="changeFileExtension">
          <xsl:with-param name="fileName" select="@file"/>
          <xsl:with-param name="newExtension" select="'.h'"/>
        </xsl:call-template>
  </xsl:variable>
#include "<xsl:value-of select="$includedFile"/>"
<!--#include "<xsl:value-of select="concat(substring-before(@file, '.idl'), '.h')"/>"-->
</xsl:template>

<xsl:template match="typedef">
    <xsl:param name="containerNamespace"/>

    <xsl:variable name="fullyQualifiedStructName"
                  select="concat($containerNamespace, @name)"/>
                  
    <xsl:variable name="fullyQualifiedStructNameC">
        <xsl:for-each select="./ancestor::module">
            <xsl:value-of select="@name"/>
            <xsl:text>_</xsl:text>        
        </xsl:for-each>
        <xsl:value-of select="@name"/>
    </xsl:variable>    
    
    <xsl:variable name="struct">                
        <xsl:choose>
            <xsl:when test="$languageOption = 'C' or $languageOption = 'c'">struct</xsl:when>
            <xsl:otherwise></xsl:otherwise>
        </xsl:choose>        
    </xsl:variable>                        
    
    <xsl:variable name="description">
        <xsl:call-template name="getMemberDescription">
            <xsl:with-param name="member" select="./member"/>
        </xsl:call-template>
    </xsl:variable>    
    
    <xsl:variable name="descriptionNode" select="xalan:nodeset($description)/node()"/>    
    
    <xsl:variable name="nativeType">
         <xsl:call-template name="obtainNativeType">
             <xsl:with-param name="idlType" select="$descriptionNode/@type"/>
         </xsl:call-template>                
    </xsl:variable>
    
    <xsl:variable name="pointer">
        <xsl:if test="$descriptionNode/@pointer='yes'">*</xsl:if>
    </xsl:variable>
    
    <xsl:variable name="aliasDefinition">
	<xsl:value-of select="concat($pointer,' ',$fullyQualifiedStructName)"/><xsl:call-template name="obtainArrayDimensions"><xsl:with-param name="cardinality" select="member/cardinality"/></xsl:call-template>
    </xsl:variable>
    
<xsl:if test="not(./member[last()]/@memberId)">
<xsl:variable name="cBaseClass">
    <xsl:call-template name="replace-string">
        <xsl:with-param name="text" select="$descriptionNode/@type"/>
        <xsl:with-param name="search" select="'::'"/>
        <xsl:with-param name="replace" select="'_'"/>
    </xsl:call-template>
</xsl:variable>

#define <xsl:value-of select="concat($fullyQualifiedStructNameC,'_LAST_MEMBER_ID ', $cBaseClass, '_LAST_MEMBER_ID')"/>
</xsl:if>

<xsl:if test="./member[last()]/@memberId">
#define <xsl:value-of select="concat($fullyQualifiedStructNameC,'_LAST_MEMBER_ID ',./member[last()]/@memberId)"/>
</xsl:if>
        
    <!-- Generate type declaration -->
    <xsl:choose>
        <xsl:when test="($descriptionNode/@memberKind='sequence' 
                         or $descriptionNode/@memberKind='arraySequence') 
                         and $descriptionNode/@type='string'">
typedef <xsl:value-of select="concat($struct,' ','DDS_StringSeq ')"/><xsl:value-of select="$aliasDefinition"/>;
        </xsl:when>
        <xsl:when test="($descriptionNode/@memberKind='sequence' or 
                         $descriptionNode/@memberKind='arraySequence') 
                         and $descriptionNode/@type='wstring'">
typedef <xsl:value-of select="concat($struct,' ','DDS_WstringSeq ')"/><xsl:value-of select="$aliasDefinition"/>;
        </xsl:when>
        <xsl:when test="$descriptionNode/@memberKind='sequence' or
                        $descriptionNode/@memberKind='arraySequence'">
typedef <xsl:value-of select="concat($struct,' ',$nativeType)"/>Seq <xsl:value-of select="$aliasDefinition"/>;
        </xsl:when>
        <xsl:when test="$descriptionNode/@type='string'">
typedef char * <xsl:value-of select="$aliasDefinition"/>;                
        </xsl:when>                        
        <xsl:when test="$descriptionNode/@type='wstring'">
typedef DDS_Wchar* <xsl:value-of select="$aliasDefinition"/>;
        </xsl:when>        
        <xsl:otherwise>
typedef <xsl:value-of select="$nativeType"/><xsl:text> </xsl:text><xsl:value-of select="$aliasDefinition"/>;
        </xsl:otherwise>
    </xsl:choose>

    <!-- Generate the sequence & methods declarations -->
    <xsl:variable name="generateCode">
        <xsl:call-template name="isNecessaryGenerateCode">
            <xsl:with-param name="typedefNode" select="."/>
        </xsl:call-template>                                
    </xsl:variable>
    
#if (defined(RTI_WIN32) || defined (RTI_WINCE)) &amp;&amp; defined(NDDS_USER_DLL_EXPORT<xsl:value-of select="$dllExportMacroFinalSuffix"/>)
  /* If the code is building on Windows, start exporting symbols. */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport __declspec(dllexport)
#endif

    <xsl:if test="$typecode='yes'">
NDDSUSERDllExport <xsl:value-of select="concat($typeCodeTypeName,'* ',$fullyQualifiedStructName)"/>_get_typecode(void); /* Type code */
    </xsl:if>
            
    <xsl:if test="$descriptionNode/@memberKind='sequence' or
                  $descriptionNode/@memberKind='arraySequence' or
                  $generateCode='yes'">
        <xsl:variable name="baseMemberKind">
            <xsl:call-template name="obtainBaseMemberKind">
                <xsl:with-param name="member" select="./member"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:choose>
            <!-- We need to check $baseMemberKind and not just
                 $descriptionNode to be totally sure about the real base
                 type. -->
            <xsl:when test="$descriptionNode/@memberKind='arraySequence' or
                            ($generateCode='yes' and
                             ($baseMemberKind='array' or
                              $baseMemberKind='arraySequence'))">
DDS_SEQUENCE_NO_GET(<xsl:value-of select="$fullyQualifiedStructName"/>Seq, <xsl:value-of select="$fullyQualifiedStructName"/>);                
            </xsl:when>
            <xsl:otherwise>
DDS_SEQUENCE(<xsl:value-of select="$fullyQualifiedStructName"/>Seq, <xsl:value-of select="$fullyQualifiedStructName"/>);                                        
            </xsl:otherwise>
        </xsl:choose>
NDDSUSERDllExport
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_initialize(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self);
            
NDDSUSERDllExport
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_initialize_ex(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self,
        RTIBool allocatePointers,RTIBool allocateMemory);

NDDSUSERDllExport
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_initialize_w_params(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self,
        const struct DDS_TypeAllocationParams_t * allocParams);
                    
NDDSUSERDllExport
void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self);
            
NDDSUSERDllExport
void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize_ex(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self,RTIBool deletePointers);

NDDSUSERDllExport
void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize_w_params(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self,
        const struct DDS_TypeDeallocationParams_t * deallocParams);

NDDSUSERDllExport
void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize_optional_members(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self, RTIBool deletePointers);
                    
NDDSUSERDllExport
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_copy(
        <xsl:value-of select="$fullyQualifiedStructName"/>* dst,
        const <xsl:value-of select="$fullyQualifiedStructName"/>* src);

    </xsl:if>

#if (defined(RTI_WIN32) || defined (RTI_WINCE)) &amp;&amp; defined(NDDS_USER_DLL_EXPORT<xsl:value-of select="$dllExportMacroFinalSuffix"/>)
  /* If the code is building on Windows, stop exporting symbols. */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport
#endif

</xsl:template>

<!-- Enum declarations

    Output form:
    typedef enum <fullyQualifiedName> {
         [Members] <processed by another template>
    };

    if it's a bitSet, the output is:
    enum <fullyQualifiedName>Bits {
         [Members] <processed by another template>
    };

    typedef <unsigned_integer_equivalent> <fullyQualifiedName>;

    <usigned_integer_equivalent> is chosen based on the bitBound directive:

    bitBound       1-16                                            unsigned short
    bitBound       17-32                                          unsigned long
    bitBound       33-64                                          unsigned long long

    bitBound       not present (default is 32):         unisgned long

-->
<xsl:template match="enum">
    <xsl:param name="containerNamespace"/>
    <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace, @name)"/>
    <xsl:variable name="isBitSet" select="./@bitSet"/>

    <!-- not a BITSET -->
    <xsl:if test="$isBitSet='no'"> 
typedef enum <xsl:value-of select="$fullyQualifiedStructName"/>
{<xsl:apply-templates/><xsl:text>&nl;</xsl:text>
    <xsl:for-each select="enumerator">
        <xsl:variable name="enumString"><xsl:value-of select="@name"/><xsl:if test="@value"> = <xsl:value-of select="@value"/></xsl:if></xsl:variable>
        <xsl:choose>
            <xsl:when test="position()=last()">
                <xsl:text>    </xsl:text><xsl:value-of select="$enumString"/></xsl:when>
            <xsl:otherwise>
                <xsl:text>    </xsl:text><xsl:value-of select="$enumString"/>,<xsl:text>&nl;</xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:for-each>
} <xsl:value-of select="$fullyQualifiedStructName"/>;
    </xsl:if>

    <!-- BITSET -->
    <xsl:if test="$isBitSet='yes'">
        <xsl:variable name="classType">
        <xsl:choose>
            <xsl:when test="(./@bitBound &lt; 1) or (./@bitBound &gt; 64)">
                <xsl:message terminate="yes"> <!-- unaccebtable  value-->
Error. Invalid value for "bitBound" directive associated to <xsl:value-of select="$fullyQualifiedStructName"/> enum.
Valid range is 1-64.
                </xsl:message>
            </xsl:when>
            <xsl:when test="(./@bitBound &gt; 0) and (./@bitBound &lt; 9)">
                <xsl:text>unsigned char </xsl:text>
            </xsl:when>
            <xsl:when test="(./@bitBound &gt; 8) and (./@bitBound &lt; 17)">
                <xsl:text>unsigned short </xsl:text>
            </xsl:when>
            <xsl:when test="(./@bitBound &gt; 16) and (./@bitBound &lt; 33)">
                <xsl:text>unsigned long </xsl:text>
            </xsl:when>
            <xsl:when test="(./@bitBound &gt; 32) and (./@bitBound &lt; 65)">
                <xsl:text>unsigned long long </xsl:text>
            </xsl:when>
        </xsl:choose>
        </xsl:variable>

        <xsl:variable name="bitBound" select="./@bitBound"/>
        
enum <xsl:value-of select="$fullyQualifiedStructName"/>Bits
{<xsl:apply-templates/><xsl:text>&nl;</xsl:text>
     <xsl:for-each select="enumerator">
         <xsl:variable name="currentValue" select="./@value" />
         <xsl:variable name="enumeratorName" select="./@name"/>
         <!-- Verify constant's value does not exceed the bitBound -->
        <xsl:if test="@value &gt; $bitBound">
            <xsl:message terminate="yes"> 
Invalid value for the following enumerator: <xsl:value-of select="./@name"/>.
Its value(<xsl:value-of select="@value"/>)  cannot be greater than the bitBound(<xsl:value-of select="$bitBound"/>).
            </xsl:message>
        </xsl:if>
        <!-- Verify constant's value is unique among all the costants -->
        <xsl:for-each  select="../enumerator">
           <xsl:if test="@value = $currentValue and @name != $enumeratorName">
               <xsl:message terminate="yes"> Error! <xsl:value-of select="@name" /> enumerator does not have a unique value
               </xsl:message>
           </xsl:if>
       </xsl:for-each>

         <xsl:variable name="enumString"><xsl:value-of select="@name"/><xsl:if test="@value"> = (1 &lt;&lt; <xsl:value-of select="@value"/>)</xsl:if></xsl:variable>
        <xsl:choose>
            <xsl:when test="position()=last()">
                <xsl:text>    </xsl:text><xsl:value-of select="$enumString"/></xsl:when>
            <xsl:otherwise>
                <xsl:text>    </xsl:text><xsl:value-of select="$enumString"/>,<xsl:text>&nl;</xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:for-each>
}; 
typedef <xsl:value-of select="$classType"/> <xsl:value-of select="$fullyQualifiedStructName"/>;
    </xsl:if>

#if (defined(RTI_WIN32) || defined (RTI_WINCE)) &amp;&amp; defined(NDDS_USER_DLL_EXPORT<xsl:value-of select="$dllExportMacroFinalSuffix"/>)
  /* If the code is building on Windows, start exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport __declspec(dllexport)
#endif

    <xsl:if test="$typecode='yes'">
NDDSUSERDllExport <xsl:value-of select="concat($typeCodeTypeName,'* ',$fullyQualifiedStructName)"/>_get_typecode(void); /* Type code */
    </xsl:if>

DDS_SEQUENCE(<xsl:value-of select="$fullyQualifiedStructName"/>Seq, <xsl:value-of select="$fullyQualifiedStructName"/>);
        
NDDSUSERDllExport
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_initialize(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self);
        
NDDSUSERDllExport
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_initialize_ex(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self,
        RTIBool allocatePointers,RTIBool allocateMemory);
        
NDDSUSERDllExport
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_initialize_w_params(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self,
        const struct DDS_TypeAllocationParams_t * allocParams);

NDDSUSERDllExport
void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self);
                        
NDDSUSERDllExport
void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize_ex(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self,RTIBool deletePointers);
        
NDDSUSERDllExport
void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize_w_params(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self,
        const struct DDS_TypeDeallocationParams_t * deallocParams);

NDDSUSERDllExport
void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize_optional_members(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self, RTIBool deletePointers);
                
NDDSUSERDllExport
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_copy(
        <xsl:value-of select="$fullyQualifiedStructName"/>* dst,
        const <xsl:value-of select="$fullyQualifiedStructName"/>* src);

<xsl:choose>
    <xsl:when test="$language = 'C++'">
NDDSUSERDllExport
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_getValues(<xsl:value-of select="$fullyQualifiedStructName"/>Seq * values);
    </xsl:when>
    <xsl:otherwise>
NDDSUSERDllExport
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_getValues(struct <xsl:value-of select="$fullyQualifiedStructName"/>Seq * values);
    </xsl:otherwise>
</xsl:choose>

#if (defined(RTI_WIN32) || defined (RTI_WINCE)) &amp;&amp; defined(NDDS_USER_DLL_EXPORT<xsl:value-of select="$dllExportMacroFinalSuffix"/>)
  /* If the code is building on Windows, stop exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport
#endif

</xsl:template>

<!-- Struct declarations

    Output form:
    struct <fullyQualifiedStructName> {
         [Members] <processed by another template>
    };
-->
<xsl:template match="struct">
    <xsl:param name="containerNamespace"/>
    <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace, @name)"/>

    <xsl:variable name="topLevel">
        <xsl:call-template name="isTopLevelType">
            <xsl:with-param name="typeNode" select="."/>
        </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="fullyQualifiedStructNameC">
        <xsl:for-each select="./ancestor::module">
            <xsl:value-of select="@name"/>
            <xsl:text>_</xsl:text>        
        </xsl:for-each>
        <xsl:value-of select="@name"/>
    </xsl:variable>    
    
<xsl:if test="not(./member[last()]/@memberId)">
#define <xsl:value-of select="concat($fullyQualifiedStructNameC,'_LAST_MEMBER_ID ', '0')"/>
</xsl:if>
<xsl:if test="./member[last()]/@memberId">
#define <xsl:value-of select="concat($fullyQualifiedStructNameC,'_LAST_MEMBER_ID ',./member[last()]/@memberId)"/>
</xsl:if>

<xsl:if test="$language='C' or $namespace='no'">
#ifdef __cplusplus
extern "C" {
#endif
</xsl:if>
        
extern const char *<xsl:value-of select="$fullyQualifiedStructName"/>TYPENAME;
        
<xsl:if test="$language='C' or $namespace='no'">
#ifdef __cplusplus
}
#endif
</xsl:if>

<xsl:apply-templates mode="error-checking"/>

#ifdef __cplusplus
    struct <xsl:value-of select="$fullyQualifiedStructName"/>Seq;
<xsl:if test="$topLevel='yes'">
#ifndef NDDS_STANDALONE_TYPE
    class <xsl:value-of select="$fullyQualifiedStructName"/>TypeSupport;
    class <xsl:value-of select="$fullyQualifiedStructName"/>DataWriter;
    class <xsl:value-of select="$fullyQualifiedStructName"/>DataReader;
#endif
</xsl:if>
#endif

    <!-- struct definitions -->        
    <xsl:if test="not(@kind) or (@kind != 'valuetype' and @kind != 'struct')">
typedef struct <xsl:value-of select="$fullyQualifiedStructName"/>
{
#ifdef __cplusplus
    typedef struct <xsl:value-of select="$fullyQualifiedStructName"/>Seq Seq;
<xsl:if test="$topLevel='yes'">
#ifndef NDDS_STANDALONE_TYPE
    typedef <xsl:value-of select="$fullyQualifiedStructName"/>TypeSupport TypeSupport;
    typedef <xsl:value-of select="$fullyQualifiedStructName"/>DataWriter DataWriter;
    typedef <xsl:value-of select="$fullyQualifiedStructName"/>DataReader DataReader;
#endif
</xsl:if>
#endif
<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'structMember'"/>
</xsl:apply-templates><xsl:text>&nl;</xsl:text>
} <xsl:value-of select="$fullyQualifiedStructName"/>;
    </xsl:if>        
                        
    <xsl:if test="$language = 'C++' and (@kind='valuetype' or @kind='struct')">
        <xsl:if test="@baseClass!=''">
class <xsl:value-of select="$fullyQualifiedStructName"/> : public <xsl:value-of select="@baseClass"/>
        </xsl:if>                            
        <xsl:if test="@baseClass=''">
class <xsl:value-of select="$fullyQualifiedStructName"/>
        </xsl:if>                                        
{
public:            
#ifdef __cplusplus
    typedef struct <xsl:value-of select="$fullyQualifiedStructName"/>Seq Seq;
<xsl:if test="$topLevel='yes'">
#ifndef NDDS_STANDALONE_TYPE
    typedef <xsl:value-of select="$fullyQualifiedStructName"/>TypeSupport TypeSupport;
    typedef <xsl:value-of select="$fullyQualifiedStructName"/>DataWriter DataWriter;
    typedef <xsl:value-of select="$fullyQualifiedStructName"/>DataReader DataReader;
#endif
</xsl:if>
#endif
    <xsl:apply-templates select="./const"/>
<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'structMember'"/>
</xsl:apply-templates><xsl:text>&nl;</xsl:text>            
};                        
    </xsl:if>
        
    <xsl:if test="$language = 'C' and (@kind='valuetype' or @kind='struct')">
<xsl:text>typedef struct </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/>
<xsl:text>&nl;{&nl;</xsl:text>
        <xsl:if test="@baseClass!=''">
<xsl:text>    </xsl:text><xsl:value-of select="@baseClass"/><xsl:text> parent;</xsl:text>
        </xsl:if>                            
<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'structMember'"/>
</xsl:apply-templates><xsl:text>&nl;</xsl:text>            
} <xsl:value-of select="$fullyQualifiedStructName"/>;                        
    </xsl:if>
                            
#if (defined(RTI_WIN32) || defined (RTI_WINCE)) &amp;&amp; defined(NDDS_USER_DLL_EXPORT<xsl:value-of select="$dllExportMacroFinalSuffix"/>)
  /* If the code is building on Windows, start exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport __declspec(dllexport)
#endif

    <xsl:if test="$typecode='yes'">
NDDSUSERDllExport <xsl:value-of select="concat($typeCodeTypeName,'* ',$fullyQualifiedStructName)"/>_get_typecode(void); /* Type code */
    </xsl:if>

DDS_SEQUENCE(<xsl:value-of select="$fullyQualifiedStructName"/>Seq, <xsl:value-of select="$fullyQualifiedStructName"/>);
        
NDDSUSERDllExport
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_initialize(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self);
        
NDDSUSERDllExport
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_initialize_ex(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self,
        RTIBool allocatePointers,RTIBool allocateMemory);
        
NDDSUSERDllExport
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_initialize_w_params(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self,
        const struct DDS_TypeAllocationParams_t * allocParams);

NDDSUSERDllExport
void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self);
                        
NDDSUSERDllExport
void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize_ex(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self,RTIBool deletePointers);
       
NDDSUSERDllExport
void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize_w_params(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self,
        const struct DDS_TypeDeallocationParams_t * deallocParams);
        
NDDSUSERDllExport
void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize_optional_members(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self, RTIBool deletePointers);        
        
NDDSUSERDllExport
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_copy(
        <xsl:value-of select="$fullyQualifiedStructName"/>* dst,
        const <xsl:value-of select="$fullyQualifiedStructName"/>* src);

#if (defined(RTI_WIN32) || defined (RTI_WINCE)) &amp;&amp; defined(NDDS_USER_DLL_EXPORT<xsl:value-of select="$dllExportMacroFinalSuffix"/>)
  /* If the code is building on Windows, stop exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport
#endif

</xsl:template>

<!-- Union declarations

    Output form:
    struct <fullyQualifiedStructName> {
        <discriminator_type> _d;
        union {
           [Members] <processed by another template>
        } _u;
    };
-->
<xsl:template match="struct[@kind='union']">
    <xsl:param name="containerNamespace"/>
    <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace, @name)"/>
    
    <xsl:variable name="baseDiscType">
        <xsl:call-template name="getBaseType">
            <xsl:with-param name="member" select="./discriminator"/>
        </xsl:call-template>        
    </xsl:variable>

    <xsl:variable name="baseEnum">    
        <xsl:call-template name="isBaseEnum">
            <xsl:with-param name="member" select="./discriminator"/>
        </xsl:call-template>        
    </xsl:variable>

    <xsl:variable name="topLevel">
        <xsl:call-template name="isTopLevelType">
            <xsl:with-param name="typeNode" select="."/>
        </xsl:call-template>
    </xsl:variable>

<xsl:if test="$language='C' or $namespace='no'">
#ifdef __cplusplus
extern "C" {
#endif
</xsl:if>
                
extern const char *<xsl:value-of select="$fullyQualifiedStructName"/>TYPENAME;

<xsl:if test="$language='C' or $namespace='no'">
#ifdef __cplusplus
}
#endif
</xsl:if>

<xsl:apply-templates mode="error-checking"/>

#ifdef __cplusplus
    struct <xsl:value-of select="$fullyQualifiedStructName"/>Seq;
<xsl:if test="$topLevel='yes'">
#ifndef NDDS_STANDALONE_TYPE
    class <xsl:value-of select="$fullyQualifiedStructName"/>TypeSupport;
    class <xsl:value-of select="$fullyQualifiedStructName"/>DataWriter;
    class <xsl:value-of select="$fullyQualifiedStructName"/>DataReader;
#endif
</xsl:if>
#endif

<!-- struct definitions -->
typedef struct <xsl:value-of select="$fullyQualifiedStructName"/> {
#ifdef __cplusplus
    typedef struct <xsl:value-of select="$fullyQualifiedStructName"/>Seq Seq;
<xsl:if test="$topLevel='yes'">
#ifndef NDDS_STANDALONE_TYPE
    typedef <xsl:value-of select="$fullyQualifiedStructName"/>TypeSupport TypeSupport;
    typedef <xsl:value-of select="$fullyQualifiedStructName"/>DataWriter DataWriter;
    typedef <xsl:value-of select="$fullyQualifiedStructName"/>DataReader DataReader;
#endif
</xsl:if>
#endif
    <xsl:variable name="baseType">
        <xsl:if test="$optLevel = '0'"> 
            <xsl:value-of select="./discriminator/@type"/>               
        </xsl:if>
        <xsl:if test="not($optLevel = '0')">                
            <xsl:call-template name="getBaseType">
                <xsl:with-param name="member" select="./discriminator"/>        
            </xsl:call-template>                        
        </xsl:if>                       
    </xsl:variable>

    <xsl:call-template name="obtainNativeType"><xsl:with-param name="idlType" select="$baseType"/></xsl:call-template> _d;
<xsl:if test="$useUnion = 'yes'">
    union <xsl:value-of select="$fullyQualifiedStructName"/>_u
</xsl:if>
<xsl:if test="$useUnion = 'no'">
    struct <xsl:value-of select="$fullyQualifiedStructName"/>_u
</xsl:if>
    {<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'structMember'"/>
</xsl:apply-templates><xsl:text>&nl;</xsl:text>
    } _u;
} <xsl:value-of select="$fullyQualifiedStructName"/>;

#if (defined(RTI_WIN32) || defined (RTI_WINCE)) &amp;&amp; defined(NDDS_USER_DLL_EXPORT<xsl:value-of select="$dllExportMacroFinalSuffix"/>)
  /* If the code is building on Windows, start exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport __declspec(dllexport)
#endif

    <xsl:if test="$typecode='yes'">
NDDSUSERDllExport <xsl:value-of select="concat($typeCodeTypeName,'* ',$fullyQualifiedStructName)"/>_get_typecode(void); /* Type code */
    </xsl:if>

DDS_SEQUENCE(<xsl:value-of select="$fullyQualifiedStructName"/>Seq, <xsl:value-of select="$fullyQualifiedStructName"/>);

NDDSUSERDllExport
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_initialize(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self);
        
NDDSUSERDllExport
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_initialize_ex(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self,
        RTIBool allocatePointers,RTIBool allocateMemory);
        
NDDSUSERDllExport
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_initialize_w_params(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self,
        const struct DDS_TypeAllocationParams_t * allocParams);

NDDSUSERDllExport
void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self);
                        
NDDSUSERDllExport
void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize_ex(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self,RTIBool deletePointers);
        
NDDSUSERDllExport
void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize_w_params(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self,
        const struct DDS_TypeDeallocationParams_t * deallocParams);

NDDSUSERDllExport
void <xsl:value-of select="$fullyQualifiedStructName"/>_finalize_optional_members(
        <xsl:value-of select="$fullyQualifiedStructName"/>* self, RTIBool deletePointers);      
        
NDDSUSERDllExport
RTIBool <xsl:value-of select="$fullyQualifiedStructName"/>_copy(
        <xsl:value-of select="$fullyQualifiedStructName"/>* dst,
        const <xsl:value-of select="$fullyQualifiedStructName"/>* src);
        
<xsl:choose> 
    <xsl:when test="$baseDiscType='boolean'">
NDDSUSERDllExport
DDS_Boolean <xsl:value-of select="$fullyQualifiedStructName"/>_getDefaultDiscriminator();
    </xsl:when>
    <xsl:when test="$baseEnum = 'yes' ">
NDDSUSERDllExport
<xsl:value-of select="./discriminator/@type"/><xsl:text> </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/>_getDefaultDiscriminator();
    </xsl:when>
    <xsl:otherwise>
NDDSUSERDllExport
<xsl:call-template name="obtainNativeType"><xsl:with-param name="idlType" select="$baseType"/></xsl:call-template>
<xsl:text> </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/>_getDefaultDiscriminator();
    </xsl:otherwise>
</xsl:choose>

#if (defined(RTI_WIN32) || defined (RTI_WINCE)) &amp;&amp; defined(NDDS_USER_DLL_EXPORT<xsl:value-of select="$dllExportMacroFinalSuffix"/>)
  /* If the code is building on Windows, stop exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport
#endif

</xsl:template>

<xsl:template match="forward_dcl">
    <xsl:param name="containerNamespace"/>
    <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace, @name)"/>

    <xsl:choose>
        <xsl:when test="@kind = 'union' or $language='C'">
            <xsl:text>struct </xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>class </xsl:text>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="$fullyQualifiedStructName"/><xsl:text>;&nl;</xsl:text>
</xsl:template>

<!--
Process directives
-->
<xsl:template match="directive[@kind = 'copy-declaration' or @kind = 'copy-c-declaration']">
    <xsl:text>&nl;</xsl:text><xsl:value-of select="text()"/><xsl:text>&nl;</xsl:text>
</xsl:template>

<xsl:template match="directive[@kind = 'copy-declaration' or @kind = 'copy-c-declaration']"
              mode="code-generation">
    <xsl:text>&nl;</xsl:text><xsl:value-of select="text()"/><xsl:text>&nl;</xsl:text>
</xsl:template>

</xsl:stylesheet>
