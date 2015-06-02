<?xml version="1.0"?>
<!-- 
/* $Id: type2c8.xsl,v 1.12 2010/07/15 18:35:56 jim Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
modification history:
- - - - - - - - - - -
10ae,15jul10,jim Fixed problem with CCL and CCS and seperators in module names
10ae,13jul10,jim Fixed constants inside of namespaces not working.
10z, 16apr10,jim Created
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nl "&#xa;">
  <!--   new line  -->
  <!ENTITY indent "    ">
  <!-- indentation -->
  <!ENTITY namespaceSeperator "::">
  <!-- namespace separator -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
        xmlns:xalan = "http://xml.apache.org/xalan"
        xmlns:mathParser="com.rti.ndds.nddsgen.transformation.MathParser"
        extension-element-prefixes="mathParser"
        exclude-result-prefixes="mathParser"                
        >

  <xsl:param name="CCSExOctSeq"/>
  <xsl:param name="CCSExCharSeq"/>
  
  <xsl:include href="typeCommon.xsl"/>

	<!-- Module declarations.
     The purpose of processing module is to build up the string that represents
     the current namespace, that contains concatenated module names separated
     by "_"s. We pass on the namespace accumulated so far to the next nested elements
     though use of xsl:with-param.
-->
	<xsl:template match="module">
		<xsl:param name="containerNamespace"/>

		<xsl:variable name="newNamespace">
			<xsl:value-of select="concat($containerNamespace, @name, '&namespaceSeperator;')"/>
		</xsl:variable>

		<xsl:apply-templates>
			<xsl:with-param name="containerNamespace" select="$newNamespace"/>
		</xsl:apply-templates>
	</xsl:template>

	<!-- This is called to find a constant and return the value -->
  <xsl:template name="findConstant">
    <xsl:param name="module"/>
    <xsl:param name="constName"/>

    <xsl:choose>
      <!-- If a struct just matches the type we want, recurse -->
      <xsl:when test="$module/const[@name = $constName]">
        <xsl:value-of select="$module/const[@name = $constName]/@value"/>
      </xsl:when>
      <xsl:otherwise>
        <!-- Deal with modules in the name -->
        <xsl:variable name="moduleName">
          <xsl:value-of select="substring-before($constName,'&namespaceSeperator;')"/>
        </xsl:variable>

        <xsl:if test="$moduleName != ''">
          <!-- Modules can be reopened -->
          <xsl:for-each select="$module/module[@name = $moduleName]">
            <xsl:variable name="newConstName">
              <xsl:value-of select="substring-after($constName,'&namespaceSeperator;')"/>
            </xsl:variable>
            <xsl:call-template name="findConstant">
              <xsl:with-param name="module" select="."/>
              <xsl:with-param name="constName" select="$newConstName"/>
            </xsl:call-template>
          </xsl:for-each>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- This is used to remove the :: and replace with _ -->
  <xsl:template name="replaceSeperators">
    <xsl:param name="typeName"/>
    <xsl:param name="result"/>

    <xsl:variable name="before">
      <xsl:value-of select="substring-before($typeName,'&namespaceSeperator;')"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$before != ''">
        <xsl:variable name="newTypeName">
          <xsl:value-of select="substring-after($typeName, '&namespaceSeperator;')"/>
        </xsl:variable>
        <xsl:variable name="newResult">
          <xsl:value-of select="concat($result, $before, '_')"/>
        </xsl:variable>
        <xsl:call-template name="replaceSeperators">
          <xsl:with-param name="typeName" select="$newTypeName"/>
          <xsl:with-param name="result" select="$newResult"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat($result, $typeName)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- This is called from the recursive template to decode user types -->
  <xsl:template name="generateCCLType">
    <xsl:param name="module"/>
    <xsl:param name="typeName"/>
    <xsl:param name="parentName"/>
    <xsl:param name="first"/>

    <xsl:variable name="firstMember">
      <xsl:if test="string-length($first) > 0 and position() = 1">
        <xsl:text>true</xsl:text>
      </xsl:if>
    </xsl:variable>

    <xsl:choose>
      <!-- If a struct just matches the type we want, recurse -->
      <xsl:when test="$module/struct[@name = $typeName]">
        <xsl:for-each select="$module/struct[@name = $typeName]/member">
          <xsl:call-template name="generateCCLMemberRec">
            <xsl:with-param name="member" select="."/>
            <xsl:with-param name="parentName" select="$parentName"/>
            <xsl:with-param name="first" select="$firstMember"/>
          </xsl:call-template>
        </xsl:for-each>
        <xsl:if test="$module/struct[@name = $typeName]/@kind = 'union'">
          <!-- add discriminator -->
          <xsl:call-template name="generateCCLMemberRec">
            <xsl:with-param name="member" select="$module/struct[@name = $typeName]/discriminator"/>
            <xsl:with-param name="parentName" select="$parentName" />
          </xsl:call-template>
        </xsl:if>
      </xsl:when>
      <xsl:when test="$module/typedef[@name = $typeName]">
        <xsl:for-each select="$module/typedef[@name = $typeName]/member">
          <xsl:call-template name="generateCCLMemberRec">
            <xsl:with-param name="member" select="."/>
            <xsl:with-param name="parentName" select="$parentName"/>
            <xsl:with-param name="first" select="$firstMember"/>
          </xsl:call-template>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <!-- Deal with modules in the name -->
        <xsl:variable name="moduleName">
          <xsl:value-of select="substring-before($typeName,'&namespaceSeperator;')"/>
        </xsl:variable>

        <xsl:if test="$moduleName != ''">
          <!-- Modules can be reopened -->
          <xsl:for-each select="$module/module[@name = $moduleName]">
            <xsl:variable name="newTypeName">
              <xsl:value-of select="substring-after($typeName,'&namespaceSeperator;')"/>
            </xsl:variable>
            <xsl:call-template name="generateCCLType">
              <xsl:with-param name="module" select="."/>
              <xsl:with-param name="typeName" select="$newTypeName"/>
              <xsl:with-param name="parentName" select="$parentName"/>
              <xsl:with-param name="first" select="$firstMember"/>
            </xsl:call-template>
          </xsl:for-each>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Generates the output name to be used -->
  <xsl:template name="generateColumnName">
    <xsl:param name="member"/>
    <xsl:param name="parentName"/>
    <xsl:choose>
      <xsl:when test="$member/@name">
        <xsl:if test="string-length($parentName) > 0">
          <xsl:value-of select="$parentName"/>
          <xsl:text>_</xsl:text>
        </xsl:if>
        <xsl:value-of select="$member/@name"/>
      </xsl:when>
      <xsl:otherwise>
        <!-- We don't have a name, so just use parentName -->
        <xsl:value-of select="$parentName"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- returns true if the typeKind is a user kind 
       (user kinds generally mean lookup base kind -->
  <xsl:template name="isUserKind">
    <xsl:param name="member"/>

    <xsl:variable name="typeKind">
      <xsl:call-template name="obtainTypeKind">
        <xsl:with-param name="member" select="$member"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="isEnum">
      <xsl:call-template name="isBaseEnum">
        <xsl:with-param name="member" select="$member"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:if test="$isEnum = 'no'">
      <xsl:if test="$typeKind = 'user' and $member/@type != 'string' and $member/@type != 'wstring'">
        <xsl:text>true</xsl:text>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <!-- resolveConstantValue - Resolves the values of all the constants in a expression.
       For a correct behavior, the first call of this template should include the expression
       to evaluate between parenthesis '(' ')'. -->
  <xsl:template name="resolveConstantValue">
    <xsl:param name="constantName"/>
    <xsl:param name="substring"/>

    <!-- First, take the firs character of the expression -->
    <xsl:variable name="characterToEvaluate">
      <xsl:value-of select="substring($constantName,1,1)"/>
    </xsl:variable>

    <xsl:choose>
      <!-- If the character is a special character ('+','-','*','/','(',')' or ' '),
           evaluate $substring (if that is not empty), return the character and
           continue with the parsing (if $constantName has more characters) -->
      <xsl:when test="$characterToEvaluate='+' or $characterToEvaluate='-' or 
                        $characterToEvaluate='*' or $characterToEvaluate='/' or 
                        $characterToEvaluate='|' or $characterToEvaluate='&amp;' or
                        $characterToEvaluate='^' or $characterToEvaluate='&gt;' or
                        $characterToEvaluate='~' or
                        $characterToEvaluate='&lt;' or $characterToEvaluate='%' or
                        $characterToEvaluate='(' or $characterToEvaluate=')' or 
                        $characterToEvaluate=' '">
        <!-- If $substring is not empty, evaluate and print its value -->
        <xsl:if test="$substring and $substring!=''">
          <xsl:variable name="isNumber">
            <xsl:call-template name="isNumber">
              <xsl:with-param name="str" select="$substring"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:choose>
            <xsl:when test="$isNumber='true'">
              <xsl:value-of select="$substring"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:variable name="resolvedConstant">
                <xsl:call-template name="findConstant">
                  <xsl:with-param name="module" select="/specification"/>
                  <xsl:with-param name="constName" select="$substring"/>
                </xsl:call-template>
              </xsl:variable>
              <xsl:call-template name="resolveConstantValue">
                <xsl:with-param name="constantName" select="concat('(',$resolvedConstant,')')"/>
                <xsl:with-param name="substring" select="''"/>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>

        <!-- Print the new character -->
        <xsl:value-of select="$characterToEvaluate"/>

        <!-- If $constantName has more characters, continue with evaluation -->
        <xsl:if test="substring-after($constantName,$characterToEvaluate)!=''">
          <xsl:call-template name="resolveConstantValue">
            <xsl:with-param name="constantName" select="substring-after($constantName,$characterToEvaluate)"/>
            <xsl:with-param name="substring" select="''"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:when>
      <!-- If $constantName has more characters, continue with evaluation -->
      <xsl:when test="substring-after($constantName,$characterToEvaluate)!=''">
        <xsl:call-template name="resolveConstantValue">
          <xsl:with-param name="constantName" select="substring-after($constantName,$characterToEvaluate)"/>
          <xsl:with-param name="substring" select="concat($substring,$characterToEvaluate)"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <!-- THIS CASE SHOULD NEVER OCCUR -->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- isNumber template -->
  <xsl:template name="isNumber">
    <xsl:param name="str"/>
    <xsl:if test="number($str)=number($str)">true</xsl:if>
  </xsl:template>

  <!-- evalConstant template -->
  <xsl:template name="evalConstant">
    <xsl:param name="len"/>

    <xsl:variable name="isNumber">
      <xsl:call-template name="isNumber">
        <xsl:with-param name="str" select="$len"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$isNumber='true'">
          <xsl:value-of select="$len"/>
      </xsl:when>
      <xsl:when test="$len and $len!=''">
        <xsl:variable name="tempNum">
          <xsl:call-template name="resolveConstantValue">
            <xsl:with-param name="constantName" select="concat('(',$len,')')"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="mathParser:resolveMathExpression($tempNum)"/>
      </xsl:when>
      <xsl:otherwise>
        <!-- unbounded... should be error, we'll just populate -->
        <xsl:text>32</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- The maxLengthSequence can either be in the member or in the first child -->
  <xsl:template name="getMaxLenSequence">
    <xsl:param name="member"/>
    <xsl:choose>
      <xsl:when test="$member/@maxLengthSequence">
        <xsl:value-of select="$member/@maxLengthSequence"/>
      </xsl:when>
      <xsl:when test="$member/member/@maxLengthSequence">
        <xsl:value-of select="$member/member/@maxLengthSequence"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <!-- The recursive part of the For Loop. Used for both
       sequences and arrays -->
  <xsl:template name="sequenceForLoop">
    <xsl:param name="index" />
    <xsl:param name="count" />
    <xsl:param name="member" />
    <xsl:param name="parentName" />
    <xsl:param name="first" />
    <xsl:param name="fromArray"/>

    <!-- The body of the for loop -->
    <xsl:if test="$index &lt; $count">
      <xsl:variable name="memberName">
        <xsl:value-of select="$parentName"/>
        <xsl:text>_</xsl:text>
        <xsl:value-of select="$index"/>
        <xsl:text>_</xsl:text>
      </xsl:variable>

      <xsl:variable name="isUser">
        <xsl:call-template name="isUserKind">
          <xsl:with-param name="member" select="$member"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="$fromArray = 'true' and $member/@kind = 'sequence'">
          <!-- Array of sequences... ick! -->
          <xsl:call-template name="generateCCLMemberRec">
            <xsl:with-param name="member" select="$member"/>
            <xsl:with-param name="parentName" select="$memberName"/>
            <xsl:with-param name="first" select="$first"/>
            <xsl:with-param name="fromArray" select="$fromArray"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="$isUser = 'true'">
          <xsl:call-template name="generateCCLType">
            <xsl:with-param name="module" select="/specification"/>
            <xsl:with-param name="typeName" select="$member/@type"/>
            <xsl:with-param name="parentName" select="$memberName" />
            <xsl:with-param name="first" select="$first"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
			<xsl:variable name="isEnum">
				<xsl:call-template name="isBaseEnum">
					<xsl:with-param name="member" select="$member"/>
				</xsl:call-template>
			</xsl:variable>

			<xsl:variable name="baseType">
				<xsl:choose>
					<!-- If it's an enum, ignore the type and just emit enum,
                 since all enums will become an int type -->
					<xsl:when test="$isEnum = 'yes'">
						<xsl:text>enum</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="getBaseType">
							<xsl:with-param name="member" select="$member"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:if test="not($member/@bitField)">
				<xsl:call-template name="generateCCLColumn">
					<xsl:with-param name="name" select="$memberName"/>
					<xsl:with-param name="type" select="$baseType"/>
					<xsl:with-param name="first" select="$first"/>
				</xsl:call-template>
			</xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>

    <!-- Increment and recursively call the loop template -->
    <xsl:if test="$index &lt; $count">
      <xsl:call-template name="sequenceForLoop">
        <xsl:with-param name="index">
          <xsl:value-of select="$index + 1"/>
        </xsl:with-param>
        <xsl:with-param name="count">
          <xsl:value-of select="$count"/>
        </xsl:with-param>
        <xsl:with-param name="member" select="$member"/>
        <xsl:with-param name="parentName" select="$parentName"/>
        <xsl:with-param name="fromArray" select="$fromArray"/>
        <!-- first is always false now, so not passing -->
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- This template creates the length field for sequences -->
  <xsl:template name="generateLengthColumn">
	  <xsl:param name="member"/>
	  <xsl:param name="parentName"/>
	  <xsl:param name="first"/>

	  <xsl:variable name="maxLenSequence">
		  <xsl:call-template name="getMaxLenSequence">
			  <xsl:with-param name="member" select="$member"/>
		  </xsl:call-template>
	  </xsl:variable>

	  <xsl:variable name="len">
		  <xsl:call-template name="evalConstant">
			  <xsl:with-param name="len" select="$maxLenSequence"/>
		  </xsl:call-template>
	  </xsl:variable>

	  <xsl:variable name="lengthName">
		  <xsl:value-of select="$parentName"/>
		  <xsl:text>_length</xsl:text>
	  </xsl:variable>

	  <xsl:call-template name="generateCCLColumn">
		  <xsl:with-param name="name" select="$lengthName"/>
		  <xsl:with-param name="type" select="'long'"/>
		  <xsl:with-param name="first" select="$first"/>
	  </xsl:call-template>
  </xsl:template>
	
  <!-- This template sets up the loop to handle sequences -->
  <xsl:template name="generateCCLSequence">
    <xsl:param name="member"/>
    <xsl:param name="parentName"/>
    <xsl:param name="first"/>

    <xsl:variable name="maxLenSequence">
      <xsl:call-template name="getMaxLenSequence">
        <xsl:with-param name="member" select="$member"/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="len">
      <xsl:call-template name="evalConstant">
        <xsl:with-param name="len" select="$maxLenSequence"/>
      </xsl:call-template>
    </xsl:variable>

	  <xsl:call-template name="generateLengthColumn">
		  <xsl:with-param name="member" select="$member"/>
		  <xsl:with-param name="parentName" select="$parentName"/>
		  <xsl:with-param name="first" select="$first"/>
	  </xsl:call-template>
	  
	  <xsl:call-template name="sequenceForLoop">
      <xsl:with-param name="index" select="0"/>
      <xsl:with-param name="count" select="$len"/>
      <xsl:with-param name="member" select="$member"/>
      <xsl:with-param name="parentName" select="$parentName"/>
	  <!-- not sending first, because length field is before the loop -->
    </xsl:call-template>

  </xsl:template>

  <!-- This loop goes thru all the dimensions for multidimensional arrays -->
  <xsl:template name="dimensionForLoop">
    <xsl:param name="index" />
    <xsl:param name="count" />
    <xsl:param name="member" />
    <xsl:param name="parentName" />
    <xsl:param name="level" />
    <xsl:param name="fromArray" />
    <xsl:param name="first" />
    
    <!-- The body of the for loop -->
    <xsl:if test="$index &lt; $count">
      <xsl:variable name="memberName">
        <xsl:value-of select="$parentName"/>
        <xsl:text>_</xsl:text>
        <xsl:value-of select="$index"/>
        <xsl:text>_</xsl:text>
      </xsl:variable>

      <xsl:variable name="len">
        <xsl:call-template name="evalConstant">
          <xsl:with-param name="len" select="$member/cardinality/dimension[$level+1]/@size"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:choose>
        <!-- If the next dimension is the last, then generate names -->
        <xsl:when test="$level = count($member/cardinality/dimension)-1">
          <xsl:call-template name="sequenceForLoop">
            <xsl:with-param name="index" select="0"/>
            <xsl:with-param name="count" select="$len"/>
            <xsl:with-param name="member" select="$member"/>
            <xsl:with-param name="parentName" select="$memberName"/>
            <xsl:with-param name="first" select="$first"/>
            <xsl:with-param name="fromArray" select="'true'"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <!-- recurse down a level, there's more than 1 remaining -->
          <xsl:call-template name="dimensionForLoop">
            <xsl:with-param name="index" select="0" />
            <xsl:with-param name="count" select="$len" />
            <xsl:with-param name="member" select="$member" />
            <xsl:with-param name="parentName" select="$memberName" />
            <xsl:with-param name="level" select="$level + 1" />
            <xsl:with-param name="fromArray" select="$fromArray"/>
            <xsl:with-param name="first" select="$first" />
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>

    <!-- Increment and recursively call the loop template -->
    <xsl:if test="$index &lt; $count">
      <xsl:call-template name="dimensionForLoop">
        <xsl:with-param name="index">
          <xsl:value-of select="$index + 1"/>
        </xsl:with-param>
        <xsl:with-param name="count">
          <xsl:value-of select="$count"/>
        </xsl:with-param>
        <xsl:with-param name="member" select="$member"/>
        <xsl:with-param name="parentName" select="$parentName"/>
        <xsl:with-param name="level" select="$level" />
        <xsl:with-param name="fromArray" select="$fromArray"/>
        <!-- first is always false now, so not passing -->
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- This template sets up the loop to handle arrays -->
  <xsl:template name="generateCCLArray">
    <xsl:param name="member"/>
    <xsl:param name="parentName"/>
    <xsl:param name="first"/>

    <xsl:variable name="len">
      <xsl:call-template name="evalConstant">
        <xsl:with-param name="len" select="$member/cardinality/dimension[1]/@size"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:choose>
      <!-- Is it multi-dimensional? -->
      <xsl:when test="count($member/cardinality/dimension) > 1">
        <xsl:call-template name="dimensionForLoop">
          <xsl:with-param name="index" select="0" />
          <xsl:with-param name="count" select="$len" />
          <xsl:with-param name="member" select="$member"/>
          <xsl:with-param name="parentName" select="$parentName"/>
          <xsl:with-param name="level" select="1" />
          <xsl:with-param name="fromArray" select="'true'"/>
          <xsl:with-param name="first" select="$first" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <!-- single dimensional -->
        <xsl:call-template name="sequenceForLoop">
          <xsl:with-param name="index" select="0"/>
          <xsl:with-param name="count" select="$len"/>
          <xsl:with-param name="member" select="$member"/>
          <xsl:with-param name="parentName" select="$parentName"/>
          <xsl:with-param name="first" select="$first"/>
          <xsl:with-param name="fromArray" select="'true'"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- This is the recursive "main" template that decodes types -->
  <xsl:template name="generateCCLMemberRec">
    <xsl:param name="member"/>
    <xsl:param name="parentName"/>
    <!-- first is non-null only when we are in the first member
         in the first level -->
    <xsl:param name="first"/>
    <xsl:param name="fromArray"/>

    
    <xsl:variable name="memberKind">
      <xsl:call-template name="obtainMemberKind">
        <xsl:with-param name="member" select="$member"/>
      </xsl:call-template>
    </xsl:variable>

    <!-- Construct the name to use for this member in the output -->
    <xsl:variable name="fullName">
      <xsl:choose>
        <xsl:when test="$fromArray = 'true'">
          <xsl:value-of select="$parentName"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="generateColumnName">
            <xsl:with-param name="member" select="$member"/>
            <xsl:with-param name="parentName" select="$parentName"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="isEnum">
      <xsl:call-template name="isBaseEnum">
        <xsl:with-param name="member" select="$member"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="baseType">
      <xsl:choose>
        <!-- If it's an enum, ignore the type and just emit enum,
                 since all enums will become an int type -->
        <xsl:when test="$isEnum = 'yes'">
          <xsl:text>enum</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="getBaseType">
            <xsl:with-param name="member" select="$member"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- doing this in multiple lines because xalan barfed on it all at once -->
    <xsl:variable name="de1" select="$CCSExCharSeq != 'yes'"/>
    <xsl:variable name ="de2" select="not(boolean($CCSExOctSeq))"/>
    <xsl:variable name="deChar" select="$baseType = 'char' and $de1"/>
    <xsl:variable name="deOct" select="$baseType = 'octet' and $de2"/>
    <xsl:variable name="doExpansion" select="not($deChar or $deOct)"/>
    
    <xsl:variable name="isUser">
      <xsl:call-template name="isUserKind">
        <xsl:with-param name="member" select="$member"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:choose>
      <!-- Order matters here between these two when clauses, as we need to do arrays before
           sequences in the case of arraySequences -->
      <xsl:when test="($memberKind = 'arraySequence' or $memberKind = 'array') and $doExpansion and $fromArray != 'true'">
        <xsl:call-template name="generateCCLArray">
          <xsl:with-param name="member" select="$member"/>
          <xsl:with-param name="parentName" select="$fullName"/>
          <xsl:with-param name="first" select="$first"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="($memberKind = 'arraySequence' or $memberKind = 'sequence') and $doExpansion">
        <xsl:call-template name="generateCCLSequence">
          <xsl:with-param name="member" select="$member"/>
          <xsl:with-param name="parentName" select="$fullName"/>
          <xsl:with-param name="first" select="$first"/>
        </xsl:call-template>
      </xsl:when>
      <!-- This member isn't a sequence -->
      <xsl:otherwise>
        <xsl:choose>
          <!-- Is it a user type? (strings dont count as a user type) -->
          <xsl:when test="$isUser = 'true'" >
            <xsl:variable name="firstMember">
              <xsl:if test="string-length($first) > 0 and position() = 1">
                <xsl:text>true</xsl:text>
              </xsl:if>
            </xsl:variable>
            <xsl:call-template name="generateCCLType">
              <xsl:with-param name="module" select="/specification"/>
              <xsl:with-param name="typeName" select="$member/@type"/>
              <xsl:with-param name="parentName" select="$fullName" />
              <xsl:with-param name="first" select="$firstMember"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <!-- If we are here, then it's not a user type -->
            <xsl:choose>
              <!-- By default, we turn char sequences into strings -->
              <xsl:when test="$doExpansion != 'true' and $baseType = 'char' and 
                        ($memberKind = 'sequence' or 
                        $memberKind = 'arraySequence' or
                        $memberKind = 'array')" >
				  <!-- and now the string substitute for the char sequence-->
				  <xsl:call-template name="generateCCLColumn">
                    <xsl:with-param name="name" select="$fullName"/>
                    <xsl:with-param name="type" select="'string'"/>
                    <xsl:with-param name="first" select="$first"/>
                    </xsl:call-template>
				  <xsl:if test="$memberKind = 'sequence'">
					  <!-- add the length column-->
					  <xsl:call-template name="generateLengthColumn">
						  <xsl:with-param name="member" select="$member"/>
						  <xsl:with-param name="parentName" select="$fullName"/>
						  <!-- not setting first, because this wont ever be first col -->
					  </xsl:call-template>
				  </xsl:if>
			  </xsl:when>
              <!-- By default, we turn octet sequences into blobs -->
              <xsl:when test="$doExpansion != 'true' and $baseType = 'octet' and 
                        ($memberKind = 'sequence' or 
                        $memberKind = 'arraySequence' or
                        $memberKind = 'array')">
                <xsl:call-template name="generateCCLColumn">
                  <xsl:with-param name="name" select="$fullName"/>
                  <xsl:with-param name="type" select="'blob'"/>
                  <xsl:with-param name="first" select="$first"/>
                </xsl:call-template>
				  <xsl:if test="$memberKind = 'sequence'">
					  <!-- add the length column-->
					  <xsl:call-template name="generateLengthColumn">
						  <xsl:with-param name="member" select="$member"/>
						  <xsl:with-param name="parentName" select="$fullName"/>
						  <!-- not setting first, because this wont ever be first col -->
					  </xsl:call-template>
				  </xsl:if>
			  </xsl:when>
              <xsl:otherwise>
				<xsl:if test="not($member/@bitField)">
					<xsl:call-template name="generateCCLColumn">
					  <xsl:with-param name="name" select="$fullName"/>
					  <xsl:with-param name="type" select="$baseType"/>
					  <xsl:with-param name="first" select="$first"/>
					</xsl:call-template>
				</xsl:if>
              </xsl:otherwise> 
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>