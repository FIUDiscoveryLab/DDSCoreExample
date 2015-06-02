<?xml version="1.0"?>
<!--
   $Id: type.h.cli.xsl,v 1.5 2013/10/26 00:28:19 fernando Exp $

   (c) Copyright 2007, Real-Time Innovations, Inc.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.

Modification history
 - - - - - - - - - -
5.1.0,25oct13,fcs CODEGEN-584: Received samples for an Extensible type may contain 
                  invalid values for fields not present on the wire
5.0.1,22may13,fcs CODEGEN-594: Added suffix to DLL_EXPORT_MACRO
10ab,31jan12,vtg RTI-110 Add support to rtiddsgen to produce dll importable code on windows
10ab,31mar09,rbw Bug #12852: Removed extern "C"
10y,17sep08,jlv Fixed include. Now files with more than one dot in the name 
                (or with an extension different to 'idl') are allowed.
10x,16jul08,tk  Removed utils.xsl
10x,22may08,rbw Made copying more type-safe
10x,12may08,rbw Removed IUserObjectLifecycle interface: unnecessary
10x,08may08,rbw Unified struct and union support
10x,08may08,rbw Added union support
10x,08may08,rbw Unified struct and typedef support
10x,07may08,rbw Added typedef support
10w,15apr08,rbw Refactored ICopyable out of IUserObjectLifecycle
10v,22mar08,rbw Added Object::Equals() override
10v,20mar08,rbw Updated generated sequences
10v,17mar08,rbw Removed explicit destructors/finalizers: unnecessary
10v,13mar08,rbw Fixed namespaces and valuetype inheritance
10v,11mar08,rbw Added enum support
10s,29feb08,rbw Improvements to lifecycle and TypeCode methods
10s,28feb08,rbw Improved type code; added namespace for managed code;
                removed unnecessary "container namespace";
                fixed many compile errors
10s,21feb08,rbw Fixed typos;
                added InteropServices "using" for new marshaling attributes
10s,13feb08,rbw Created
-->


<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
        xmlns:xalan = "http://xml.apache.org/xalan">

<xsl:include href="typeCommon.cppcli.xsl"/>

<xsl:output method="text"/>


<!-- ===================================================================== -->
<!-- Document Root                                                         -->
<!-- ===================================================================== -->

<!--
When the root of document is matched, print the source preamble specified in
the generation-info.cppcli.xml file. The source preamble contains the
standard blurb as well as #include for the needed header file.
-->
<xsl:template match="/">
    <xsl:variable
        name="sourcePreamble"
        select="$generationInfo/sourcePreamble[@kind = 'type-header']"/>
<xsl:text/>/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from <xsl:value-of select="$idlFileBaseName"/>.idl using "rtiddsgen".
  The rtiddsgen tool is part of the <xsl:value-of select="$coreProduct"/> distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the <xsl:value-of select="$coreProduct"/> manual.
*/

#pragma once

<xsl:value-of select="$sourcePreamble"/>

using namespace System;
using namespace DDS;

    <xsl:apply-templates/>
</xsl:template>


<!-- ===================================================================== -->
<!-- Forward Declaration                                                   -->
<!-- ===================================================================== -->

<xsl:template match="forward_dcl">
ref struct <xsl:value-of select="@name"/>;
</xsl:template>
        

<!-- ===================================================================== -->
<!-- Constant Declaration                                                  -->
<!-- ===================================================================== -->

<xsl:template match="const">
    <xsl:variable name="theType">
        <xsl:variable name="baseType">
            <xsl:call-template name="getBaseType">
                <xsl:with-param name="member" select="."/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:call-template name="obtainNativeType">
            <xsl:with-param name="idlType" select="$baseType"/>
        </xsl:call-template>
    </xsl:variable>

<xsl:if test="$dllImportableCode='yes'">
<xsl:text>&nl;#if defined(NDDS_USER_DLL_EXPORT</xsl:text><xsl:value-of select="$dllExportMacroFinalSuffix"/>)
</xsl:if>

public ref class <xsl:value-of select="@name"/> sealed {
public:
    static const <xsl:value-of select="$theType"/> VALUE =
        <xsl:value-of select="@value"/>;

private:
    <xsl:value-of select="@name"/>() {}
};

<xsl:if test="$dllImportableCode='yes'">
<xsl:text>#endif /* defined(NDDS_USER_DLL_EXPORT</xsl:text><xsl:value-of select="$dllExportMacroFinalSuffix"/>)<xsl:text> */ &nl;</xsl:text>
</xsl:if>

</xsl:template>


<!-- ===================================================================== -->
<!-- Include                                                               -->
<!-- ===================================================================== -->

<xsl:template match="include">
  <xsl:variable name="includedFile">
        <xsl:call-template name="changeFileExtension">
          <xsl:with-param name="fileName" select="@file"/>
          <xsl:with-param name="newExtension" select="'.h'"/>
        </xsl:call-template>
  </xsl:variable>
#include "<xsl:value-of select="$includedFile"/>"
<!-- #include "<xsl:value-of select="substring-before(@file, '.idl')"/>.h" -->
</xsl:template>


<!-- ===================================================================== -->
<!-- Enum Declaration                                                      -->
<!-- ===================================================================== -->
<!-- Enum declarations

    Output form:
    public enum <fullyQualifiedName> : uint {
         [Members] <processed by another template>
    };
-->

<xsl:template match="enum">
    <xsl:variable name="fullyQualifiedUnmngEnumName">
        <xsl:for-each select="./ancestor::module">
            <xsl:value-of select="@name"/>
            <xsl:text>::</xsl:text>
        </xsl:for-each>
        <xsl:value-of select="@name"/>
    </xsl:variable>

<xsl:if test="$dllImportableCode='yes'">
<xsl:text>&nl;#if defined(NDDS_USER_DLL_EXPORT</xsl:text><xsl:value-of select="$dllExportMacroFinalSuffix"/>)
</xsl:if>

public enum class <xsl:value-of select="@name"/> : System::Int32 {
    <xsl:apply-templates/>
    <xsl:text>&nl;</xsl:text>

    <xsl:for-each select="enumerator">
        <xsl:variable name="enumString">
            <xsl:value-of select="@name"/>
            <xsl:if test="@value"> = <xsl:value-of select="@value"/>
            </xsl:if>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="position()=last()">
                <xsl:text>&indent;</xsl:text>
                <xsl:value-of select="$enumString"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>&indent;</xsl:text>
                <xsl:value-of select="$enumString"/>
                <xsl:text>, &nl;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:for-each>
};
<xsl:text>&nl;</xsl:text>
  
<xsl:value-of select="@name"/><xsl:text> </xsl:text><xsl:value-of select="@name"/>_get_default_value();

public ref class <xsl:value-of select="@name"/>Seq
        : public DDS::UserValueSequence&lt;<xsl:value-of select="@name"/>&gt; {
public:
    <xsl:value-of select="@name"/>Seq() :
            DDS::UserValueSequence&lt;<xsl:value-of select="@name"/>&gt;() {
        // empty
    }
    <xsl:value-of select="@name"/>Seq(System::Int32 max) :
            DDS::UserValueSequence&lt;<xsl:value-of select="@name"/>&gt;(max) {
        // empty
    }
    <xsl:value-of select="@name"/>Seq(<xsl:value-of select="@name"/>Seq^ src) :
            DDS::UserValueSequence&lt;<xsl:value-of select="@name"/>&gt;(src) {
        // empty
    }
};

<xsl:if test="$dllImportableCode='yes'">
<xsl:text>#endif /* defined(NDDS_USER_DLL_EXPORT</xsl:text><xsl:value-of select="$dllExportMacroFinalSuffix"/>)<xsl:text> */ &nl;</xsl:text>
</xsl:if>

<xsl:if test="$dllImportableCode='yes'">
#if defined(NDDS_USER_DLL_EXPORT<xsl:value-of select="$dllExportMacroFinalSuffix"/>)
  /* Start exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport __declspec(dllexport)
#else
</xsl:if>
  #define NDDSUSERDllExport
<xsl:if test="$dllImportableCode='yes'">
#endif
</xsl:if>

    <xsl:if test="$typecode='yes'">
        <xsl:text>NDDSUSERDllExport DDS_TypeCode* </xsl:text>
        <xsl:value-of select="@name"/>
        <xsl:text>_get_typecode();&nl;</xsl:text>
    </xsl:if>

<xsl:if test="$dllImportableCode='yes'">
#if defined(NDDS_USER_DLL_EXPORT<xsl:value-of select="$dllExportMacroFinalSuffix"/>)
  /* Stop exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport
#endif
</xsl:if>
</xsl:template>


<!-- ===================================================================== -->
<!-- Struct, Union, or Typedef Declaration                                 -->
<!-- ===================================================================== -->
<!--
Struct declarations:

    Output form:
    public ref struct <name> {
      public:
        [Members] <processed by another template>
    };

Union declarations:

    Output form:
    public ref struct <name> {
      public:
        <discriminator_type> _d;
        ref struct <name>_u {
            [Members] <processed by another template>
        };
        initonly <name>_u^ _u;
    };
-->

<xsl:template match="struct|typedef">
    <xsl:apply-templates mode="error-checking"/>

    <!--
    If the typedef is an array or a sequence, we generate a wrapper class for
    it. Otherwise, we resolve it to its base type.
    -->
    <xsl:variable name="generateClass">
        <xsl:call-template name="isNecessaryGenerateCode">
            <xsl:with-param name="typedefNode" select="."/>
        </xsl:call-template>                                
    </xsl:variable>
    
    <xsl:variable name="fullyQualifiedStructNameC">
        <xsl:for-each select="./ancestor::module">
            <xsl:value-of select="@name"/>
            <xsl:text>_</xsl:text>        
        </xsl:for-each>
        <xsl:value-of select="@name"/>
    </xsl:variable>    

<xsl:if test="$dllImportableCode='yes'">
<xsl:text>&nl;#if defined(NDDS_USER_DLL_EXPORT</xsl:text><xsl:value-of select="$dllExportMacroFinalSuffix"/>)
</xsl:if>
<xsl:if test="$generateClass='yes'">

public ref struct <xsl:value-of select="@name"/>
        : <xsl:text/>
    <xsl:if test="@baseClass != ''">
        <xsl:text> public </xsl:text><xsl:value-of select="@baseClass"/>
        <xsl:text>, </xsl:text>
    </xsl:if>
    <xsl:text>public DDS::ICopyable&lt;</xsl:text>
    <xsl:value-of select="@name"/>
    <xsl:text/>^&gt; {
    // --- Declared members: -------------------------------------------------
  public:            
    <xsl:apply-templates select="./const"/>

    <xsl:if test="@kind='union'">
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

        <xsl:call-template name="obtainNativeType">
            <xsl:with-param name="idlType" select="$baseType"/>
        </xsl:call-template> _d;

    ref struct <xsl:value-of select="@name"/>_u {
    </xsl:if><!-- test="@kind='union'" -->
    <xsl:apply-templates mode="code-generation">
        <xsl:with-param name="generationMode" select="'structMember'"/>
    </xsl:apply-templates>
    <xsl:if test="@kind='union'">
    };
    initonly <xsl:value-of select="@name"/>_u^ _u;
    </xsl:if><!-- test="@kind='union'" -->

    // --- Static constants: -------------------------------------    
public:
    <xsl:choose>
        <xsl:when test="./member[last()]/@memberId">
<!--        static const UInt32 LAST_MEMBER_ID =            -->
<!--    <xsl:value-of select="./member[last()]/@memberId"/>;-->
#define <xsl:value-of select="concat($fullyQualifiedStructNameC,'_LAST_MEMBER_ID ',./member[last()]/@memberId)"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:choose>
                <xsl:when test="name(.)='typedef'">

                    <xsl:variable name="description">
                        <xsl:call-template name="getMemberDescription">
                            <xsl:with-param name="member" select="./member"/>
                        </xsl:call-template>
                    </xsl:variable>
        
                    <xsl:variable name="descriptionNode" select="xalan:nodeset($description)/node()"/>
                    <xsl:variable name="descriptionNodeTypeModified">
                        <xsl:call-template name="replace-string">
                            <xsl:with-param name="text" select="$descriptionNode/@type"/>
                            <xsl:with-param name="search" select="'::'"/>
                            <xsl:with-param name="replace" select="'_'"/>
                        </xsl:call-template>
                    </xsl:variable>

                    <xsl:choose>
                        <xsl:when test="not($descriptionNode/@isEnum and $descriptionNode/@isEnum != 'yes') and $descriptionNode/@memberKind = 'scalar' and $descriptionNode/@typeKind = 'user'">
<!--        static const UInt32 <xsl:value-of select="concat('LAST_MEMBER_ID = ', $descriptionNode/@type, '::LAST_MEMBER_ID;')"/>-->
#define <xsl:value-of select="concat($fullyQualifiedStructNameC,'_LAST_MEMBER_ID ', $descriptionNodeTypeModified, '_LAST_MEMBER_ID')"/>
                        </xsl:when>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
<!--                static const UInt32 LAST_MEMBER_ID = 0;-->
#define <xsl:value-of select="concat($fullyQualifiedStructNameC,'_LAST_MEMBER_ID ', '0')"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:otherwise>
    </xsl:choose>

    // --- Constructors and destructors: -------------------------------------
  public:
    <xsl:value-of select="@name"/>();

  // --- Utility methods: --------------------------------------------------
  public:
  virtual void clear()<xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass!=''"> override</xsl:if>;

  virtual System::Boolean copy_from(<xsl:value-of select="@name"/>^ src);

    virtual System::Boolean Equals(System::Object^ other) override;

    <!-- TODO: Implement ToString() for structs too! -->
    <xsl:if test="name(.)='typedef'">
    virtual System::String^ ToString() override;
    </xsl:if>
    <xsl:if test="@kind = 'union'">
        <xsl:variable name="discBaseType">
            <xsl:call-template name="getBaseType">
                <xsl:with-param name="member" select="./discriminator"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="discNativeBaseType">
            <xsl:call-template name="obtainNativeType">
                <xsl:with-param name="idlType" select="$discBaseType"/>
             </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="$discNativeBaseType"/><xsl:text> get_default_discriminator();&nl;</xsl:text>
    </xsl:if>
    <xsl:if test="$typecode='yes'">
        <xsl:text>static DDS::TypeCode^ get_typecode();&nl;&nl;</xsl:text>
        <xsl:text>  private:&nl;</xsl:text>
        <xsl:text>&indent;static DDS::TypeCode^ _typecode;&nl;</xsl:text>
    </xsl:if>
}; // class <xsl:value-of select="@name"/><xsl:text>&nl;&nl;</xsl:text>


public ref class <xsl:value-of select="@name"/>Seq sealed
        : public DDS::UserRefSequence&lt;<xsl:value-of select="@name"/>^&gt; {
public:
    <xsl:value-of select="@name"/>Seq() :
            DDS::UserRefSequence&lt;<xsl:value-of select="@name"/>^&gt;() {
        // empty
    }
    <xsl:value-of select="@name"/>Seq(System::Int32 max) :
            DDS::UserRefSequence&lt;<xsl:value-of select="@name"/>^&gt;(max) {
        // empty
    }
    <xsl:value-of select="@name"/>Seq(<xsl:value-of select="@name"/>Seq^ src) :
            DDS::UserRefSequence&lt;<xsl:value-of select="@name"/>^&gt;(src) {
        // empty
    }
};

</xsl:if> <!-- end generateClass -->

<xsl:if test="$dllImportableCode='yes'">
<xsl:text>#endif /* defined(NDDS_USER_DLL_EXPORT</xsl:text><xsl:value-of select="$dllExportMacroFinalSuffix"/>)<xsl:text> */ &nl;</xsl:text>
</xsl:if>

<xsl:if test="$dllImportableCode='yes'">
#if defined(NDDS_USER_DLL_EXPORT<xsl:value-of select="$dllExportMacroFinalSuffix"/>)
  /* Start exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport __declspec(dllexport)
#else
</xsl:if>
  #define NDDSUSERDllExport
<xsl:if test="$dllImportableCode='yes'">
#endif
</xsl:if>

<!--
Generate unmanaged typecode accessor even if we don't generate a managed
wrapper class.
-->
<xsl:if test="$typecode='yes'">
NDDSUSERDllExport DDS_TypeCode* <xsl:value-of select="@name"/>_get_typecode();
</xsl:if>

<xsl:if test="$dllImportableCode='yes'">
#if defined(NDDS_USER_DLL_EXPORT<xsl:value-of select="$dllExportMacroFinalSuffix"/>)
  /* Stop exporting symbols.
   */
  #undef NDDSUSERDllExport
  #define NDDSUSERDllExport
#endif
</xsl:if>
</xsl:template>


<!-- ===================================================================== -->
<!-- Directives                                                            -->
<!-- ===================================================================== -->

<xsl:template match="directive[@kind = 'copy-declaration' or @kind = 'copy-cppcli-declaration']">
    <xsl:text>&nl;</xsl:text>
    <xsl:value-of select="text()"/>
    <xsl:text>&nl;</xsl:text>
</xsl:template>

<xsl:template match="directive[@kind = 'copy-declaration' or @kind = 'copy-cppcli-declaration']"
              mode="code-generation">
    <xsl:text>&nl;</xsl:text>
    <xsl:value-of select="text()"/>
    <xsl:text>&nl;</xsl:text>
</xsl:template>

</xsl:stylesheet>
