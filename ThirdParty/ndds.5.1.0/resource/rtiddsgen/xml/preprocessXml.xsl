<?xml version="1.0"?>
<!-- 
/* $Id: preprocessXml.xsl,v 1.1 2009/04/02 06:18:47 fernando Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
modification history:
- - - - - - - - - - -
10y,26sep08,jlv Added sourceFilesType parameter
10y,20ago08,jlv Removed dds: label from tags
10y,19ago08,jlv Fixed //include template, now preprocessor works fine
10s,21jan08,jpm Created
-->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:java="http://xml.apache.org/xslt/java"
	xmlns:xalan="http://xml.apache.org/xalan"
	xmlns:pp="com.rti.ndds.nddsgen.XMLPreprocessor"
	extension-element-prefixes="pp"
	exclude-result-prefixes="java">
  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

  <xsl:param name="inputfile"/>
  <xsl:param name="fileurl"/>
  <xsl:param name="searchPath"/>
  <xsl:param name="sourceFilesType"/>

  <xsl:template match="/types">
    <types>
      <ppheader/>
      <xsl:apply-templates>
        <xsl:with-param name="includelist">
          <xsl:value-of select="$inputfile"/>
        </xsl:with-param>
      </xsl:apply-templates>
    </types>
  </xsl:template>

  <xsl:template match="@*|node()">
    <xsl:param name="includelist"/>
    <xsl:copy>
      <xsl:apply-templates select="@*|node()">
        <xsl:with-param name="includelist">
          <xsl:value-of select="$includelist"/>
        </xsl:with-param>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="//include">
    <xsl:param name="includelist"/>
    <xsl:variable name="included">
      <xsl:value-of select="concat($includelist,'>>',./@file)"/>
    </xsl:variable>
    <xsl:element name="included">
      <xsl:attribute name="src"><xsl:value-of select="./@file"/></xsl:attribute>
      <xsl:for-each select="pp:document(@file,$searchPath,$sourceFilesType)/types/*">
        <xsl:if test="local-name(.)='include' and contains($includelist,./@file)">
          <xsl:message terminate="no">Error on <xsl:value-of select="$inputfile"/>! 
Avoiding infinite recursion of includes. 
Trying to include '<xsl:value-of select="./@file"/>' from '<xsl:value-of select="$included"/>'</xsl:message>
          <xsl:message terminate="yes">Abort!</xsl:message>
        </xsl:if>
        <xsl:apply-templates select=".">
          <xsl:with-param name="includelist" select="$included"/>
        </xsl:apply-templates>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>
