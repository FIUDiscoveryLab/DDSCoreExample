<?xml version="1.0"?>
<!-- 
/* $Id: utils.xsl,v 1.2 2010/05/29 00:04:01 fernando Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
modification history:
- - - - - - - - - - -
10y,28may10,fcs Added lower-case template
10y,29sep08,jlv Added substring-before-last and substring-after-last templates.
10y,17sep08,jlv Added changeFileExtension template.
10d,04feb05,rw  Fixed duplicate variable declaration
40a,28aug02,rrl Refactored out of typePlugin.c.xsl
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <!-- changeFileExtension template : Changes the extension of a file for
      another one 
      @param fileName The name of the file
      @param newExtension The new extension with dot. If is empty, the template return 
             the name of the file without the original extension
      @param subString Substring for recursive call
    -->
    <xsl:template name="changeFileExtension">
      <xsl:param name="fileName"/>
      <xsl:param name="newExtension"/>
      <xsl:param name="subString"/>

      <xsl:choose>
        <xsl:when test="contains($fileName,'.')">
          <xsl:call-template name="changeFileExtension">
            <xsl:with-param name="fileName" select="substring-after($fileName,'.')"/>
            <xsl:with-param name="newExtension" select="$newExtension"/>
            <xsl:with-param name="subString" select="concat($subString,substring-before($fileName,'.'),'.')"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="$subString and $subString!=''">
              <xsl:value-of select="concat(substring($subString,1,string-length($subString)-1),$newExtension)"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="concat($fileName,$newExtension)"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:template>

<!--
Replace parameters in the input string per the replacement map supplied
@param inputString Template input string with each parameter surrounded by %%. 
                   For example "%%name%%'s type is %%type%%"
@param replacementParamsMap an element with attributes defining the replacement map.
                            For example,
                            <type-map name="int_member" type"int"/>
@return a string with each templetized parameter repalced with the corrsponding value from the replacement map.
        In the above example, the output will be "int_member's type is int".
-->
<xsl:template name="replace-string-from-map">
	<xsl:param name="inputString"/>
	<xsl:param name="replacementParamsMap"/>
	<xsl:param name="currentIndex" select="1"/>
  	
	<xsl:variable name="replacementAttribute" select="$replacementParamsMap/@*[$currentIndex]"/>
	
	<xsl:variable name="resultText">
		<xsl:call-template name="replace-string">
			<xsl:with-param name="text" select="$inputString"/>
			<xsl:with-param name="search">%%<xsl:value-of select="name($replacementAttribute)"/>%%</xsl:with-param>
			<xsl:with-param name="replace" select="$replacementAttribute"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:choose>
		<xsl:when test="$currentIndex != count($replacementParamsMap/@*)">		
			<xsl:call-template name="replace-string-from-map">
				<xsl:with-param name="inputString" select="$resultText"/>
				<xsl:with-param name="replacementParamsMap" select="$replacementParamsMap"/>
				<xsl:with-param name="currentIndex" select="$currentIndex + 1"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$resultText"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- 
Replace all occurance of a string with the supplied string.

@param text the input text
@param search text to search
@param replace text to replace
@return the replaced string
-->
<xsl:template name="replace-string">
    <xsl:param name="text"/>
    <xsl:param name="search"/>
    <xsl:param name="replace"/>

    <xsl:choose>
    	<xsl:when test="contains($text,$search)">
        	<xsl:value-of select="substring-before($text,$search)"/>
		<xsl:value-of select="$replace"/>
		<xsl:call-template name="replace-string">
			<xsl:with-param name="text" select="substring-after($text,$search)"/>
			<xsl:with-param name="search" select="$search"/>
    			<xsl:with-param name="replace" select="$replace"/>
		</xsl:call-template>
	</xsl:when>
	<xsl:otherwise>
		<xsl:value-of select="$text"/>
	</xsl:otherwise>
    </xsl:choose>
</xsl:template>

  <!-- substring-after-last template : Returns the string part following the last occurence
       of the second passed string inside the first passed string. If the first string does
       not contains the second one, returns empty string.
       @param string The string containing the pattern
       @param pattern The pattern to strip out
       @param substring Param for recursive call
         -->
  <xsl:template name="substring-after-last">
    <xsl:param name="string"/>
    <xsl:param name="pattern"/>
    <xsl:param name="substring"/>

    <xsl:choose>
      <xsl:when test="contains($string,$pattern)">
        <xsl:call-template name="substring-after-last">
          <xsl:with-param name="string" select="substring-after($string,$pattern)"/>
          <xsl:with-param name="pattern" select="$pattern"/>
          <xsl:with-param name="substring" select="concat($substring,substring-before($string,$pattern),$pattern)"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="contains($substring,$pattern)">
            <xsl:value-of select="$string"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="''"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- substring-before-last template : Returns the string part preceding the last occurence
       of the second passed string inside the first passed string. If the first string does
       not contains the second one, returns empty string.
       @param string The string containing the pattern
       @param pattern The pattern to strip out
       @param substring Param for recursive call
         -->
  <xsl:template name="substring-before-last">
    <xsl:param name="string"/>
    <xsl:param name="pattern"/>
    <xsl:param name="substring"/>

    <xsl:choose>
      <xsl:when test="contains($string,$pattern)">
        <xsl:call-template name="substring-before-last">
          <xsl:with-param name="string" select="substring-after($string,$pattern)"/>
          <xsl:with-param name="pattern" select="$pattern"/>
          <xsl:with-param name="substring" select="concat($substring,substring-before($string,$pattern),$pattern)"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="contains($substring,$pattern)">
            <xsl:value-of select="substring($substring,1,string-length($substring)-string-length($pattern))"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="''"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!--
  Template to convert to lower case
  -->
  <xsl:template name="lower-case">
    <xsl:param name="text"/>
    <xsl:variable name="lcletters">abcdefghijklmnopqrstuvwxyz</xsl:variable>
    <xsl:variable name="ucletters">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
    <xsl:value-of select="translate($text,$ucletters,$lcletters)"/>
  </xsl:template>

</xsl:stylesheet>
