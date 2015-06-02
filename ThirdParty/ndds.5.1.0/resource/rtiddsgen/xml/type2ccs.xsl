<?xml version="1.0"?>
<!-- 
/* $Id: type2ccs.xsl,v 1.7 2010/07/15 18:35:56 jim Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
modification history:
- - - - - - - - - - -
10ae,15jul10,jim Fixed problem with CCL and CCS and seperators in module names
10z, 16apr10,jim Created
-->

<!DOCTYPE xsl:stylesheet [
  <!ENTITY nl "&#xa;">
  <!--   new line  -->
  <!ENTITY indent "    ">
  <!-- indentation -->
  <!ENTITY namespaceSeperator "_">
  <!-- namespace separator -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
        xmlns:xalan = "http://xml.apache.org/xalan"
        xmlns:msxsl="urn:schemas-microsoft-com:xslt"
        >

  <xsl:param name="outputType"/>
	
  <xsl:strip-space elements="*"/>
  <xsl:output method="text"/>
  
  <xsl:include href="type2c8.xsl"/>

  <xsl:variable name="idlFileBaseName" select="/specification/@idlFileName"/>
  <xsl:variable name="generationInfo" select="document('generation-info.c.xml')/generationInfo"/>
  <xsl:variable name="generationInfoCCL" select="document('generation-info.ccl.xml')/generationInfoCCL"/>
  <xsl:variable name="typeInfoMap" select="$generationInfo/typeInfoMap"/>
  <xsl:variable name="typeInfoMapCCL" select="$generationInfoCCL/typeInfoMap"/>
  <xsl:variable name="methodInfoMap" select="$generationInfo/methodInfoMap"/>
  <xsl:variable name="language">C++</xsl:variable>

	<xsl:template match="@*|node()" mode="ccs">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>

	<!-- This template generates the actual output text -->
  <xsl:template name="generateCCLColumn">
    <xsl:param name="name"/>
    <xsl:param name="type"/>
    <xsl:param name="first"/>

    <xsl:text disable-output-escaping="yes">    &lt;Column Name=&quot;</xsl:text>
    <xsl:value-of select="$name"/>
    <xsl:text disable-output-escaping="yes">&quot; xmlns:xsi=&quot;http://www.w3.org/2001/XMLSchema-instance&quot; xsi:type=&quot;</xsl:text>
    <xsl:value-of select="$typeInfoMapCCL/type[@idlType=$type]/@ccsType"/>
    <xsl:text disable-output-escaping="yes">&quot;/&gt;&nl;</xsl:text>
  </xsl:template>

  <!-- This is the template that matches top level structs and 
       calls the recursive member decoder to create the output -->
  <xsl:template match="struct">
    <xsl:param name="containerNamespace"/>
    <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace, @name)"/>
	  <xsl:apply-templates mode="error-checking"/>
	  <xsl:variable name="topLevel">
      <xsl:call-template name="isTopLevelType">
        <xsl:with-param name="typeNode" select="."/>
      </xsl:call-template>
    </xsl:variable>

    <!-- NOTE:  I gave up trying to get XSLT to spit out XML in the exact format to match
     what was in the .ccs file with namespaces and such.  So I brute forced text instead.-->

	  <xsl:if test="string-length($outputType) = 0 or
        $fullyQualifiedStructName = $outputType">
		  <xsl:if test="$topLevel = 'yes'">
        <xsl:variable name="fixedName">
          <xsl:call-template name="replaceSeperators">
            <xsl:with-param name="typeName" select="$fullyQualifiedStructName"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:text disable-output-escaping="yes">&lt;StreamSchema xmlns=&quot;http://www.coral8.com/cpl/2004/04/&quot; Name=&quot;</xsl:text>
			  <xsl:value-of select="$fixedName"/>
			  <xsl:text disable-output-escaping="yes">&quot;&gt;&nl;  &lt;Columns&gt;&nl;</xsl:text>
			  <xsl:for-each select="member">
				  <xsl:variable name="first">
					  <xsl:if test="position() = 1">
						  <xsl:text>true</xsl:text>
					  </xsl:if>
				  </xsl:variable>
				  <xsl:call-template name="generateCCLMemberRec">
					  <xsl:with-param name="member" select="."/>
					  <!-- <xsl:with-param name="parentName" select="$containerNamespace" /> -->
					  <xsl:with-param name="first" select="$first"/>
				  </xsl:call-template>
			  </xsl:for-each>
			  <xsl:if test="@kind = 'union'">
				  <!-- add discriminator -->
				  <xsl:call-template name="generateCCLMemberRec">
					  <xsl:with-param name="member" select="./discriminator"/>
					  <!-- <xsl:with-param name="parentName" select="$containerNamespace" /> -->
				  </xsl:call-template>
			  </xsl:if>
			  <xsl:text disable-output-escaping="yes">  &lt;/Columns&gt;&nl;</xsl:text>
			  <xsl:text disable-output-escaping="yes">&lt;/StreamSchema&gt;&nl;</xsl:text>
		  </xsl:if>
	  </xsl:if>
  </xsl:template>

</xsl:stylesheet>