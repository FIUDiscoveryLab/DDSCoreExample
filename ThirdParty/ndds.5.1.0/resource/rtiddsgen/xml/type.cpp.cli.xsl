<?xml version="1.0"?>
<!--
   $Id: type.cpp.cli.xsl,v 1.7 2013/10/26 00:28:19 fernando Exp $

   (c) Copyright 2007, Real-Time Innovations, Inc.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.

Modification history
 - - - - - - - - - -
5.1.0,25oct13,fcs CODEGEN-584: Received samples for an Extensible type may contain 
                  invalid values for fields not present on the wire
10x,28sep13,fcs Fixed CODEGEN-615
10x,23jun09,fcs Fixed bug 13015
10x,16jul08,tk  Removed utils.xsl
10x,22may08,rbw Made copying more type-safe
10x,12may08,rbw Removed IUserObjectLifecycle interface: unnecessary
10x,08may08,rbw Added union support
10x,08may08,rbw Unified struct and typedef support
10x,07may08,rbw Added typedef support
10w,15apr08,rbw Refactored ICopyable out of IUserObjectLifecycle
10v,10apr08,rbw Refactored header inclusion to generation-info
10v,22mar08,rbw Added Object::Equals() override
10v,20mar08,rbw Renamed types used in generated code
10v,17mar08,rbw Removed explicit destructors/finalizers: unnecessary
10v,13mar08,rbw Fixed key copying and valuetype inheritance
10v,11mar08,rbw Added enum support
10s,06mar08,rbw Removed dead code related to array and sequence processing
10s,04mar08,rbw Fixed compile error in initialize(Boolean)
10s,04mar08,rbw Fixed lots of compile errors
10s,29feb08,rbw Improvements to lifecycle and TypeCode methods
10s,28feb08,rbw Improved type code; added namespace for managed code;
                removed unnecessary "container namespace"
10s,13feb08,rbw Created
-->


<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0"
                xmlns:xalan = "http://xml.apache.org/xalan">

<xsl:include href="typeCommon.cppcli.xsl"/>
<xsl:include href="typeCode.c.xsl"/>

<xsl:output method="text"/>

<xsl:variable name="sourcePreamble"
              select="$generationInfo/sourcePreamble[@kind = 'type-source']"/>


<!-- ===================================================================== -->
<!-- Document Root                                                         -->
<!-- ===================================================================== -->

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

    <xsl:value-of select="$sourcePreamble"/>

#include "<xsl:value-of select="$idlFileBaseName"/>.h"
    <xsl:apply-templates/>
</xsl:template>

                
<!-- ===================================================================== -->
<!-- Enum Declaration                                                      -->
<!-- ===================================================================== -->

<xsl:template match="enum">
    <xsl:variable name="members" select="./enumerator"/>

    <xsl:apply-templates mode="error-checking"/>

  <xsl:text>&nl;/* ========================================================================= */&nl;</xsl:text>    

    <xsl:if test="$typecode='yes'">
        <xsl:call-template name="generateEnumTypeCode">
            <xsl:with-param name="enumNode" select="."/>
        </xsl:call-template>
        <!-- TODO: Create managed type code accessor! -->
    </xsl:if> <!-- if typecode -->

<xsl:value-of select="@name"/><xsl:text> </xsl:text><xsl:value-of select="@name"/>_get_default_value() {
    return <xsl:value-of select="@name"/>::<xsl:value-of select="./enumerator[position() = 1]/@name"/>;
}

</xsl:template>


<!-- 
    This template is used to generate the default modfier body
-->
<xsl:template name="getDefaultModifierBody">
    <xsl:param name="discBaseType"/>
    <xsl:param name="discNativeBaseType"/>
    <xsl:param name="discBaseEnum"/>
    <xsl:param name="caseList"/>

    <xsl:choose>
        <!--  if discriminator is a boolean -->
        <xsl:when test="$discBaseType='boolean'">
            <xsl:choose>
                <xsl:when test="$caseList[@value = 'true']">
                    <xsl:text>        return false</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>        return true</xsl:text>

                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>;&nl;</xsl:text>
        </xsl:when>
        <!-- end boolean  -->

        <!--  if discriminator is an enum -->
        <xsl:when test="$discBaseEnum = 'yes'">
            <xsl:if test="not($caseList[@value='default'])">
                // explicit default value was not defined. Descriminator is assigned to the case with the lowest ordinal.
                int index = 0;
                <xsl:value-of select="$discNativeBaseType"/> tmp = <xsl:value-of select="$caseList[position() = 1]/@value"/>;
                for (index = 0; index &lt; <xsl:value-of select="count($caseList)"/>; ++index) {
                <xsl:for-each select="$caseList">
                    if (tmp &gt; <xsl:value-of select="./@value"/>) tmp = <xsl:value-of select="./@value"/>;
                </xsl:for-each>
                }
                return tmp;
            </xsl:if>
            <xsl:if test="$caseList[@value='default']">
                <xsl:text>  Array^ enumOrdinals = Enum::</xsl:text>
                <xsl:text>GetValues(</xsl:text><xsl:value-of select="$discNativeBaseType"/><xsl:text>::typeid);&nl;</xsl:text>
                <xsl:text>  Array^ caseOrdinals = Array::CreateInstance(</xsl:text><xsl:value-of select="$discNativeBaseType"/>
                <xsl:text>::typeid, enumOrdinals->Length);&nl;</xsl:text>
                <xsl:text>  int i = 0, j;&nl;</xsl:text>
                <xsl:value-of select="$discNativeBaseType"/> <xsl:text> tmp = &nl;</xsl:text>
                <xsl:text>  (</xsl:text><xsl:value-of select="$discNativeBaseType"/><xsl:text>)enumOrdinals->GetValue(0);&nl;&nl;</xsl:text>
    
                <xsl:for-each select="$caseList[@value != 'default']">
                    <xsl:text>  caseOrdinals->SetValue(</xsl:text><xsl:value-of select="@value"/><xsl:text>, i++);&nl;</xsl:text>
                </xsl:for-each>
    
                <xsl:text>&nl;</xsl:text>
    
                <xsl:text>  for (i=0; i&lt; enumOrdinals->Length; i++) {&nl;</xsl:text>
                <xsl:text>      for (j=0; j&lt;</xsl:text>
                <xsl:value-of select="count($caseList[@value != 'default'])"/>
                <xsl:text> ;j++) {&nl;</xsl:text>
                <xsl:text>          if (enumOrdinals->GetValue(i) == caseOrdinals->GetValue(j))  {&nl;</xsl:text>
                <xsl:text>              if (tmp > (</xsl:text><xsl:value-of select="$discNativeBaseType"/><xsl:text>)enumOrdinals->GetValue(i)) {&nl;</xsl:text>
                <xsl:text>                  tmp = (</xsl:text><xsl:value-of select="$discNativeBaseType"/><xsl:text>)enumOrdinals->GetValue(i);&nl;</xsl:text>
                <xsl:text>              }&nl;</xsl:text>
                <xsl:text>              break;&nl;</xsl:text>                                  
                <xsl:text>          }&nl;</xsl:text>
                <xsl:text>      }&nl;</xsl:text>
                <xsl:text>      if (j == </xsl:text>
                <xsl:value-of select="count($caseList[@value != 'default'])"/>
                <xsl:text>) {&nl;</xsl:text>
                <xsl:text>          return (</xsl:text><xsl:value-of select="$discNativeBaseType"/><xsl:text>)enumOrdinals->GetValue(i);&nl;</xsl:text>
                <xsl:text>      }&nl;</xsl:text>
                <xsl:text>  }&nl;</xsl:text>
                <xsl:text>  return tmp;&nl;</xsl:text>
            </xsl:if>
        </xsl:when>
        <!-- end enum -->   
         
        <!--  if discriminator is a long -->
        <xsl:otherwise>
            <xsl:if test="not($caseList[@value='default'])">
                // explicit default value was not defined. Descriminator is assigned to the case with the lowest number.
                <xsl:value-of select="$discNativeBaseType"/> tmp = <xsl:value-of select="$caseList[position() = 1]/@value"/>;
                <xsl:for-each select="$caseList">
                if (tmp &gt; <xsl:value-of select="./@value"/>) tmp = <xsl:value-of select="./@value"/>;
                </xsl:for-each>
                return tmp;
            </xsl:if>
            <xsl:if test="$caseList[@value='default']">
                <xsl:text>        </xsl:text>
                <xsl:value-of select="$discNativeBaseType"/>
                <xsl:text> i;&nl;</xsl:text>
    
                <xsl:text>        for (</xsl:text>
                <xsl:text> i = 0; i &lt; </xsl:text>
                <xsl:value-of select="$discNativeBaseType"/>
                <xsl:text>::MaxValue; i++) {&nl;</xsl:text>
                <xsl:for-each select="$caseList[@value != 'default']">
                    <xsl:text>            if ((</xsl:text>
    
                    <xsl:value-of select="@value"/>
                    <xsl:text>)== i) continue;&nl;</xsl:text>
                </xsl:for-each>
                <xsl:text>            break;&nl;</xsl:text>
                <xsl:text>        }&nl;</xsl:text>
                <xsl:text>        return i;&nl;</xsl:text>
            </xsl:if>
        </xsl:otherwise>
            
    </xsl:choose>

</xsl:template>

<!-- ===================================================================== -->
<!-- Struct or Typedef Declaration                                         -->
<!-- ===================================================================== -->

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

    <xsl:variable name="xType">
      <xsl:call-template name="getExtensibilityKind">
        <xsl:with-param name="structName" select="./@name"/>
        <xsl:with-param name="node" select="."/>
      </xsl:call-template>
    </xsl:variable>

  <xsl:if test="$generateClass='yes'">

    <xsl:text>&nl;/* ========================================================================= */&nl;</xsl:text>

    <xsl:variable name="sequenceFields" select="member[@kind='sequence']"/>
    <xsl:variable name="sequenceArrayFields"
                  select="member[@kind='sequence' and ./cardinality]"/>

<xsl:value-of select="@name"/>::<xsl:value-of select="@name"/>() {
<xsl:if test="@kind = 'union'">
    _u = gcnew <xsl:value-of select="@name"/>_u();
</xsl:if>
        
<!-- Don't generate any code for unions because using pointer fields
     in a union is dangerous. -->
<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'initialize'"/>
</xsl:apply-templates>

 <xsl:if test="@kind = 'union'">
   _d = get_default_discriminator();
 </xsl:if>
}

void <xsl:value-of select="@name"/>::clear() {
  <xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass!=''">
    <xsl:value-of select="@baseClass"/>::clear();
  </xsl:if>
  <xsl:if test="@kind = 'union'">
    _d = get_default_discriminator();
  </xsl:if>
  <xsl:apply-templates mode="code-generation">
      <xsl:with-param name="generationMode" select="'clear'"/>
      <xsl:with-param name="discContainer" select="'_d'"/>
  </xsl:apply-templates>
}

  <xsl:if test="@kind = 'union'">
    <!-- discriminator information -->
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

    <xsl:variable name="discBaseEnum">
        <xsl:call-template name="isBaseEnum">
            <xsl:with-param name="member" select="./discriminator"/>
        </xsl:call-template>
    </xsl:variable>
        
    <xsl:value-of select="$discNativeBaseType"/> <xsl:text> </xsl:text><xsl:value-of select="@name"/><xsl:text>::get_default_discriminator() {&nl;</xsl:text>
        <xsl:call-template name="getDefaultModifierBody">
            <xsl:with-param name="discBaseType" select="$discBaseType"/>
            <xsl:with-param name="discNativeBaseType" select="$discNativeBaseType"/>
            <xsl:with-param name="discBaseEnum" select="$discBaseEnum"/>
            <xsl:with-param name="caseList" select=".//cases/case"/>
        </xsl:call-template>
    <xsl:text>}&nl;</xsl:text>

</xsl:if>

System::Boolean <xsl:value-of select="@name"/>::copy_from(<xsl:text/>
    <xsl:value-of select="@name"/>^ src) {
<xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass != ''">
    <xsl:text>&indent;if(!</xsl:text>                        
    <xsl:value-of select="@baseClass"/>
    <xsl:text>::copy_from((</xsl:text>
    <xsl:value-of select="@baseClass"/>
    <xsl:text>^) src)) {&nl;</xsl:text>
    <xsl:text>&indent;&indent;return false;&nl;</xsl:text>
    <xsl:text>&indent;}&nl;</xsl:text>
</xsl:if>
        
    <xsl:text>&indent;</xsl:text>
    <xsl:value-of select="@name"/>^ dst = this;
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

    return true;
}

Boolean <xsl:value-of select="@name"/>::Equals(Object^ other) {
    if (other == nullptr) {
        return false;
    }        
    if (this == other) {
        return true;
    }

<xsl:if test="(@kind = 'valuetype' or @kind='struct') and @baseClass!=''">
    if (!<xsl:value-of select="@baseClass"/>::Equals(other)) {
        return false;
    }
</xsl:if>        

    <xsl:text>&indent;</xsl:text>
    <xsl:value-of select="@name"/>^ otherObj =
        dynamic_cast&lt;<xsl:value-of select="@name"/>^&gt;(other);
    if (otherObj == nullptr) {
        return false;
    }

<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'equals'"/>
    <xsl:with-param name="unionVariableName" select="'this'"/>
</xsl:apply-templates>
    return true;
}

<!-- TODO: Implement ToString() for structs too! -->
<xsl:if test="name(.)='typedef'">
String^ <xsl:value-of select="@name"/>::ToString() {
    if (Value == nullptr) {
        return "";
    }
    return Value->ToString();
}
</xsl:if>

    <!-- Typecode member method -->
    <xsl:if test="$typecode='yes'">
DDS::TypeCode^ <xsl:value-of select="@name"/>::get_typecode() {
    if (_typecode == nullptr) {
        _typecode = gcnew DDS::TypeCode(<xsl:value-of select="@name"/>_get_typecode());
    }
    return _typecode;
}&nl;&nl;<xsl:text/>
    </xsl:if> <!-- if typecode -->

    </xsl:if> <!-- end generateClass -->

    <!-- Typecode function -->
    <!--
    Generate unmanaged typecode accessor even if we don't generate a managed
    wrapper class.
    -->
    <xsl:if test="$typecode='yes'">
        <xsl:if test="name(.)='typedef'">
            <xsl:call-template name="generateTypedefTypeCode">
                <xsl:with-param name="typedefNode" select="."/>
                <xsl:with-param name="xType" select="$xType"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:if test="name(.)='struct'">
            <xsl:call-template name="generateStructTypeCode">
                <xsl:with-param name="structNode" select="."/>
                <xsl:with-param name="xType" select="$xType"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:if> <!-- if typecode -->

</xsl:template>

</xsl:stylesheet>
