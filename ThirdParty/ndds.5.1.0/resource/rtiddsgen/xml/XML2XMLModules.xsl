<?xml version="1.0"?>
<!-- 
/* $Id: XML2XMLModules.xsl,v 1.1 2009/04/02 06:18:47 fernando Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
modification history:
- - - - - - - - - - -
10y,29oct08,fcs Removed rtiddstypes namespace
10y,02oct08,jlv Added some documentation.
10y,30sep08,jlv Created
-->
<!-- This template transform a XML to another one who has all the consecutive
     modules that have the same name together-->
<xsl:transform version="1.0" 
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
               xmlns:xsd="http://www.w3.org/2001/XMLSchema"              
               exclude-result-prefixes="xsd">

  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
  <xsl:strip-space elements="*"/>

  <!-- Default template -->
  <xsl:template match="/">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="*"/>
    </xsl:copy>
  </xsl:template>

  <!-- ALL template -->
  <xsl:template match="*|@*">
    <xsl:param name="path"/>

    <xsl:choose>
      <!-- If current tag is a module, check if has been declared before. If has not
           been declared before, return the appropiate module tag -->
      <xsl:when test="local-name(.)='module'">

        <xsl:variable name="isDeclaredBefore">
          <xsl:call-template name="isDeclaredBefore"/>
        </xsl:variable>

        <xsl:if test="$isDeclaredBefore='false' or $isDeclaredBefore=''">
          <xsl:variable name="currentName">
            <xsl:value-of select="@name"/>
          </xsl:variable>
          <module>
            <xsl:attribute name="name">
              <xsl:value-of select="@name"/>
            </xsl:attribute>

            <xsl:variable name="fullPath">
              <xsl:call-template name="getFullPath"/>
            </xsl:variable>

            <xsl:apply-templates select="*">
              <xsl:with-param name="path" select="$path"/>
              <xsl:with-param name="fullPath" select="$fullPath"/>
            </xsl:apply-templates>

            <xsl:call-template name="resolveNextNode">
              <xsl:with-param name="currentName" select="$currentName"/>
              <xsl:with-param name="path" select="concat($path,$currentName,'.')"/>
              <xsl:with-param name="fullPath" select="$fullPath"/>
            </xsl:call-template>
          </module>
        </xsl:if>
      </xsl:when>
      <!-- If the current tag is not a module, just copy all its attributes and children -->
      <xsl:otherwise>
        <xsl:copy>
          <xsl:apply-templates select="@*"/>
          <xsl:apply-templates select="*|text()|comment()"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- checkPath template - Check if the $path match with the path
       to the current tag -->
  <xsl:template name="checkPath">
    <xsl:param name="path"/>

    <xsl:choose>
      <xsl:when test="substring-before($path,'.')=@name">
        <xsl:choose>
          <xsl:when test="substring-after($path,'.')=''">
            <xsl:value-of select="'true'"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:for-each select="child::*[1]">
              <xsl:call-template name="checkPath">
                <xsl:with-param name="path" select="substring-after($path,'.')"/>
              </xsl:call-template>
            </xsl:for-each>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'false'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- getFullPath template - Get the complete path to the current tag -->
  <xsl:template name="getFullPath">
    <xsl:for-each select="ancestor-or-self::module">
      <xsl:value-of select="concat(@name,'.')"/>
    </xsl:for-each>
  </xsl:template>

  <!-- isDeclaredBefore template - Check if a module has been declared already -->
  <xsl:template name="isDeclaredBefore">
    <xsl:variable name="path">
      <xsl:call-template name="getFullPath"/>
    </xsl:variable>
    <xsl:for-each select="ancestor-or-self::module">
      <xsl:if test="position()=1">
        <xsl:for-each select="preceding-sibling::*[position()=1]">
          <xsl:call-template name="checkPath">
            <xsl:with-param name="path" select="$path"/>
          </xsl:call-template>
        </xsl:for-each>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <!-- resolveNextNode template - Resolve next module that has the
       same name that the current one and has the same parent modules,
       ONLY if there is not any no-module-tag between them -->
  <xsl:template name="resolveNextNode">
    <xsl:param name="currentName"/>
    <xsl:param name="path"/>
    <xsl:param name="fullPath"/>

    <xsl:for-each select="ancestor-or-self::module">
      <xsl:if test="position()=1">        
        <xsl:for-each select="following-sibling::*[position()=1]">          
          <xsl:if test="local-name(.)='module'">
            <xsl:call-template name="resolveModulePath">
              <xsl:with-param name="path" select="$fullPath"/>
              <xsl:with-param name="fullPath" select="$fullPath"/>
            </xsl:call-template>
          </xsl:if>
        </xsl:for-each>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <!-- resolveModulePath template - Look for a module which that
       matches $path -->
  <xsl:template name="resolveModulePath">
    <xsl:param name="path"/>
    <xsl:param name="fullPath"/>

    <xsl:if test="substring-before($path,'.')=@name">
      <xsl:choose>
        <xsl:when test="substring-after($path,'.')!=''">
          <xsl:for-each select="child::*[1]">            
            <xsl:if test="local-name(.)='module'">
              <xsl:call-template name="resolveModulePath">
                <xsl:with-param name="path" select="substring-after($path,'.')"/>
                <xsl:with-param name="fullPath" select="$fullPath"/>
              </xsl:call-template>
            </xsl:if>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>          
          <xsl:apply-templates select="*">
            <xsl:with-param name="path" select="$path"/>
            <xsl:with-param name="fullPath" select="$fullPath"/>
          </xsl:apply-templates>          
          <xsl:call-template name="resolveNextNode">
            <xsl:with-param name="currentName" select="@name"/>
            <xsl:with-param name="path" select="$path"/>
            <xsl:with-param name="fullPath" select="$fullPath"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
</xsl:transform>
