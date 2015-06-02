<?xml version="1.0"?>
<!-- 
/* $Id: simplifiedXmlTransform.xsl,v 1.6 2013/03/10 19:09:35 fernando Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
modification history:
- - - - - - - - - - -
5.0.0,13oct12,fcs Ext annotation support in valuetypes
5.0.0,11jul12,fcs Bitbound support in enums
5.0.0,10jul12,fcs Mutable union support
1.0ac,09jun11,fcs CXTYPES-88: Generate XML and XSD code for new features in Phase 1
1.0ac,08dec10,fcs Added copy-java-begin and copy-java-declaration-begin
10z, 26mar09,fcs enumCount support
10z, 08dec08,eh  Remove xmlns from exclude-result-prefixes
10y, 25nov08,jlv Improved external XSD validation support.
10y, 21nov08,jlv Changed maxLengthSequence for sequenceMaxLength and maxLengthString for
                 stringMaxLength in the output. 
                 Added XSD validation support.
10y, 17nov08,jlv Changed the way unions are parsed. Now members are children of cases.
10y, 16nov08,jlv Removed sequence='true', now we use maxLengthSequence='-1' for unbounded sequences.
                 Added nonBasic type and nonBasicTypeName attribute.
                 Changed some types name.
10y, 31oct08,jlv Changed kind='sequence' to sequence='true'
10y, 30oct08,jlv Removed 'yes' and 'no' values. Changed ' ' to ',' in dimensions attribute.
                 Changed the name of the directives. Added copyCppcli and
                 copyCppcliDeclaration directives. Changed dimensions to arrayDimensions.
10y, 29oct08,fcs Fixed typo
10y, 14oct08,jlv Changes to typedef, member, const and valuetype templates
                 to generate name attribute in first place.
10y, 29sep08,jlv maxLength renamed to maxLengthString and maxLengthSequence.
                 Added rules to ignore bounded attribute. Fixed forward_dcl template
                 (this fix required a template included in utils.xsl).
10y, 20ago08,jlv Removed dds: label from tags
10y, 15aug08,jlv Fixed forward_dcl template
10s, 16jul08,tk  Removed utils.xsl
                 Do not traverse empty nodes
10s, 06feb08,fcs Added keyedBaseClass management
10s, 21jan08,jpm Created
-->
<xsl:transform version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

<xsl:output method="xml" indent="yes" encoding="UTF-8"/>

<xsl:strip-space elements="*"/>
<xsl:include href="utils.xsl"/>

<xsl:param name="xsdValidationFile"/>

<!-- Default rule (pass through) -->
<xsl:template match="*">
  <xsl:element name="{name()}">
    <xsl:apply-templates select="@*"/>
    <xsl:apply-templates select="./*"/>
  <xsl:if test="local-name(following-sibling::*[1])='directive'">
    <xsl:call-template name="processDirectives">
      <xsl:with-param name="directive" select="following-sibling::*[1]"/>
    </xsl:call-template>
  </xsl:if>
  </xsl:element>
</xsl:template>

<xsl:template match="@bounded">
  <!-- Just ignore this attribute -->
</xsl:template>

<xsl:template match="@boundedStr">
  <!-- Just ignore this attribute -->
</xsl:template>

<xsl:template match="@kind[.='sequence']">
  <!--<xsl:attribute name="sequence">true</xsl:attribute>-->
</xsl:template>

<xsl:template match="@type">

    <xsl:variable name="type">
      <xsl:choose>
        <xsl:when test=".='char'">
          <xsl:text>char</xsl:text>
        </xsl:when>
        <xsl:when test=".='string'">
          <xsl:text>string</xsl:text>
        </xsl:when>
        <xsl:when test=".='short'">
          <xsl:text>short</xsl:text>
        </xsl:when>
        <xsl:when test=".='long'">
          <xsl:text>long</xsl:text>
        </xsl:when>
        <xsl:when test=".='float'">
          <xsl:text>float</xsl:text>
        </xsl:when>
        <xsl:when test=".='boolean'">
          <xsl:text>boolean</xsl:text>
        </xsl:when>
        <xsl:when test=".='double'">
          <xsl:text>double</xsl:text>
        </xsl:when>
        <xsl:when test=".='octet'">
          <xsl:text>octet</xsl:text>
        </xsl:when>
        <xsl:when test=".='wchar'">
          <xsl:text>wchar</xsl:text>
        </xsl:when>
        <xsl:when test=".='wstring'">
          <xsl:text>wstring</xsl:text>
        </xsl:when>
        <xsl:when test=".='longlong'">
          <xsl:text>longLong</xsl:text>
        </xsl:when>
        <xsl:when test=".='unsignedlonglong'">
          <xsl:text>unsignedLongLong</xsl:text>
        </xsl:when>
        <xsl:when test=".='longshort'">
          <xsl:text>longShort</xsl:text>
        </xsl:when>
        <xsl:when test=".='longdouble'">
          <xsl:text>longDouble</xsl:text>
        </xsl:when>
        <xsl:when test=".='unsignedshort'">
          <xsl:text>unsignedShort</xsl:text>
        </xsl:when>
        <xsl:when test=".='unsignedlong'">
          <xsl:text>unsignedLong</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'nonBasic'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:attribute name="type">
      <xsl:value-of select="$type"/>
    </xsl:attribute>

    <xsl:if test="$type='nonBasic'">
      <xsl:attribute name="nonBasicTypeName">
        <xsl:value-of select="."/>
      </xsl:attribute>
    </xsl:if>
</xsl:template>

<xsl:template match="@maxLengthSequence">
<!--  <xsl:choose>
    <xsl:when test="../@maxLengthString">-->
    <xsl:choose>
      <xsl:when test="../@bounded='yes'">
        <xsl:attribute name="sequenceMaxLength">
          <xsl:call-template name="deParentesize">
            <xsl:with-param name="str" select="."/>
          </xsl:call-template>
        </xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="sequenceMaxLength">
          <xsl:value-of select="'-1'"/>
        </xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>
<!--    </xsl:when>
    <xsl:otherwise>
      <xsl:attribute name="maxLength">
        <xsl:call-template name="deParentesize">
          <xsl:with-param name="str" select="."/>
        </xsl:call-template>
      </xsl:attribute>
    </xsl:otherwise>
  </xsl:choose>  -->
</xsl:template>

<xsl:template match="@maxLengthString">
<!--  <xsl:choose>
    <xsl:when test="../@kind='sequence'">-->
    <xsl:if test="../@boundedStr='yes'">
      <xsl:attribute name="stringMaxLength">
        <xsl:call-template name="deParentesize">
          <xsl:with-param name="str" select="."/>
        </xsl:call-template>
      </xsl:attribute>
    </xsl:if>
<!--    </xsl:when>
    <xsl:otherwise>
      <xsl:attribute name="maxLength">
        <xsl:call-template name="deParentesize">
          <xsl:with-param name="str" select="."/>
        </xsl:call-template>
      </xsl:attribute>
    </xsl:otherwise>
  </xsl:choose>  -->
</xsl:template>


<xsl:template match="cases">
  <!-- Just ignore -->
</xsl:template>

<xsl:template match="include">
  <xsl:element name="include">
    <xsl:attribute name="file">
      <xsl:value-of select="concat(
                            substring(@file,1,string-length(@file)-4),
                            '.xml')"/>
    </xsl:attribute>
  </xsl:element>
</xsl:template>

<xsl:template match="member/@visibility">
  <xsl:if test="normalize-space(.)!=''">
    <xsl:copy-of select="."/>
  </xsl:if>
</xsl:template>

<xsl:template match="@*[normalize-space()!='' and name()!='type' and
                    name()!='maxLengthSequence' and
                    name()!='maxLengthString' and
                    name()!='bounded' and 
                    name()!='boundedStr' and
                    name()!='kind']">
    <xsl:attribute name="{local-name()}">
    <xsl:call-template name="deParentesize">
      <xsl:with-param name="str" select="."/>
    </xsl:call-template>
    </xsl:attribute>
</xsl:template>

<xsl:template name="deParentesize">
  <xsl:param name="str"/>
  <xsl:choose>
    <!-- Only eliminate parenthesis when expression does not have internal 
    parentheses (p.e. a parenthesized scoped name -->
    <xsl:when test="starts-with($str,'(') and 
                    substring($str,string-length($str))=')' and
                    not(contains(substring($str,2,string-length($str)-2),'('))">
      <xsl:value-of select="substring($str,2,string-length($str)-2)"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$str"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="specification">
  <types xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <xsl:if test="$xsdValidationFile and $xsdValidationFile!=''">      
      <xsl:attribute name="xsi:noNamespaceSchemaLocation">
        <xsl:value-of select="$xsdValidationFile"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:apply-templates/>
  </types>
</xsl:template>

<xsl:template match="forward_dcl">
  <forward_dcl>
     <xsl:attribute name="name" >            
       <xsl:choose>
         <xsl:when test="contains(./@name,'::')">
           <!--<xsl:value-of select="substring-after(./@name,'::')"/>-->
           <xsl:call-template name="substring-after-last">
             <xsl:with-param name="string" select="./@name"/>
             <xsl:with-param name="pattern" select="'::'"/>
           </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
           <xsl:value-of select="./@name"/>
         </xsl:otherwise>
       </xsl:choose>
     </xsl:attribute>
     <xsl:attribute name="kind">
       <xsl:value-of select="./@kind"/></xsl:attribute>
     <xsl:value-of select="."/>
  </forward_dcl>
</xsl:template>

<xsl:template match="enumerator">
    <xsl:if test="../@bitSet='yes'">
        <flag>
            <xsl:attribute name="name"><xsl:value-of select="./@name"/></xsl:attribute>
            <xsl:if test="@value">
                <xsl:attribute name="value"><xsl:value-of select="./@value"/></xsl:attribute>
            </xsl:if>
        </flag>
    </xsl:if>
    <xsl:if test="../@bitSet='no'">
        <enumerator>
            <xsl:attribute name="name"><xsl:value-of select="./@name"/></xsl:attribute>
            <xsl:if test="@value">
                <xsl:attribute name="value"><xsl:value-of select="./@value"/></xsl:attribute>
            </xsl:if>
        </enumerator>
    </xsl:if>
</xsl:template>

<xsl:template match="enum">
  <xsl:if test="@bitSet='yes'">
      <bitset>
          <xsl:attribute name="name"><xsl:value-of select="./@name"/></xsl:attribute>
          <xsl:if test="@bitBound and @bitBound != ''">
              <xsl:attribute name="bitBound"><xsl:value-of select="./@bitBound"/></xsl:attribute>
          </xsl:if>
          <xsl:variable name="nextSibling" select="following-sibling::*[1]"/>
          <xsl:if test="local-name($nextSibling)='directive'">
            <xsl:call-template name="processDirectives">
              <xsl:with-param name="directive" select="$nextSibling"/>
            </xsl:call-template>
          </xsl:if>
          <xsl:apply-templates select="./*"/>
      </bitset>
  </xsl:if>
  <xsl:if test="@bitSet='no'">
      <enum>
          <xsl:attribute name="name"><xsl:value-of select="./@name"/></xsl:attribute>
          <xsl:if test="@bitBound and @bitBound != ''">
              <xsl:attribute name="bitBound"><xsl:value-of select="./@bitBound"/></xsl:attribute>
          </xsl:if>
          <xsl:variable name="nextSibling" select="following-sibling::*[1]"/>
          <xsl:if test="local-name($nextSibling)='directive'">
            <xsl:call-template name="processDirectives">
              <xsl:with-param name="directive" select="$nextSibling"/>
            </xsl:call-template>
          </xsl:if>
          <xsl:apply-templates select="./*"/>
      </enum>
  </xsl:if>
</xsl:template>

<!-- Typedef Output:
Description: the typedefs are built as member based structure in
simplified-XML. We have to transform now in a typedef structure 
according to ddstypes.dtd
 -->
<xsl:template match="typedef">
  <typedef>
     <xsl:attribute name="name" >
       <xsl:value-of select="self::node()/@name"/>
     </xsl:attribute>
       <!--<xsl:value-of select="self::node()/member/@type"/>-->
       <xsl:for-each select="self::node()/member/@*">
          <xsl:choose>
            <xsl:when test="local-name(.)='pointer'">
              <xsl:if test=".='yes'">
                <xsl:attribute name="pointer">true</xsl:attribute>
              </xsl:if>
            </xsl:when>
            <xsl:when test="local-name(.)='type'">
              <xsl:apply-templates select="."/>
            </xsl:when>
            <xsl:when test="local-name(.)='maxLengthString'">
              <xsl:if test="../@boundedStr='yes'">
                <xsl:apply-templates select="."/>
              </xsl:if>
            </xsl:when>
            <xsl:when test="local-name(.)='maxLengthSequence'">
              <xsl:apply-templates select="."/>
            </xsl:when>
            <xsl:when test="local-name(.)='enum'">
              <!-- Just ignore -->
            </xsl:when>
            <xsl:when test="local-name(.)='enumCount'">
              <!-- Just ignore -->
            </xsl:when>
            <xsl:when test="local-name(.)='bounded'">
              <!-- Just ignore -->
            </xsl:when>
            <xsl:when test="local-name(.)='boundedStr'">
              <!-- Just ignore -->
            </xsl:when>
            <xsl:when test="local-name(.)='kind'">
              <xsl:apply-templates select="."/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:copy>
                <xsl:apply-templates select="."/>
              </xsl:copy>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:for-each>
    <xsl:if test="./member/cardinality"> 
      <xsl:call-template name="processCardinality">
        <xsl:with-param name="cardinalityNode" select="./member/cardinality"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:variable name="nextSibling" select="following-sibling::*[1]"/>
    <xsl:if test="local-name($nextSibling)='directive'">
      <xsl:call-template name="processDirectives">
        <xsl:with-param name="directive" select="$nextSibling"/>
      </xsl:call-template>
    </xsl:if>

    <xsl:apply-templates select="self::node()/member/*"/>
  </typedef>
</xsl:template>

<xsl:template match="discriminator">
  <discriminator>
    <xsl:for-each select="@*">
      <xsl:if test="not(local-name(.)='name' or 
                    local-name(.)='enum' or 
                    local-name(.)='enumCount' or 
                    local-name(.)='type' or
                    local-name(.)='uniondisc')">
         <xsl:copy-of select="."/>
      </xsl:if>
      <xsl:if test="local-name(.)='type' and .!=''">
        <xsl:apply-templates select="."/>
      </xsl:if>
    </xsl:for-each>
  </discriminator> 
</xsl:template>


<!-- Struct Rule : change struct (kind=union) into Union tag -->  
<xsl:template match="struct[@kind='union']">
  <xsl:element name="union">
    <xsl:attribute name="name"><xsl:value-of select="./@name"/></xsl:attribute>
    <xsl:variable name="nextSibling" select="following-sibling::*[1]"/>
    <xsl:if test="local-name($nextSibling)='directive'">
      <xsl:call-template name="processDirectives">
        <xsl:with-param name="directive" select="$nextSibling"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates select="./*"/>
  </xsl:element>
</xsl:template>

<xsl:template match="struct[@kind='valuetype']">
  <xsl:element name="valuetype">
    <xsl:if test="@name and @name!=''">
      <xsl:attribute name="name">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:variable name="nextSibling" select="following-sibling::*[1]"/>
    <xsl:if test="local-name($nextSibling)='directive'">
        <xsl:call-template name="processDirectives">
          <xsl:with-param name="directive" select="following-sibling::*[1]"/>
        </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates select="@*[not(name()='name' or name()='kind' or name()='keyedBaseClass' or .='')]"/>
    <xsl:apply-templates select="./*"/>
  </xsl:element>
</xsl:template>


<xsl:template match="struct">
  <struct>
    <xsl:attribute name="name"><xsl:value-of select="./@name"/></xsl:attribute>

    <xsl:if test="@baseClass and @baseClass != ''">
        <xsl:attribute name="baseType"><xsl:value-of select="./@baseClass"/></xsl:attribute>
    </xsl:if>

    <xsl:variable name="nextSibling" select="following-sibling::*[1]"/>
    <xsl:if test="local-name($nextSibling)='directive' and 
                  ($nextSibling[@kind='top-level'] or
                  $nextSibling[@kind='Extensibility'])">
      <xsl:call-template name="processDirectives">
        <xsl:with-param name="directive" select="$nextSibling"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates/>
  </struct>
</xsl:template>


<xsl:template match="const">
  <const>

    <xsl:if test="@name and @name!=''">
      <xsl:attribute name="name">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
    </xsl:if>

    <xsl:if test="@type and @type!=''">
        <xsl:apply-templates select="@type"/>
    </xsl:if>

    <xsl:for-each select="@*[name(.)!='name' and name(.)!='type']">
     <xsl:choose>
       <xsl:when test="not(.='')">
         <xsl:apply-templates select="."/>
       </xsl:when>
     </xsl:choose>
    </xsl:for-each>
   <xsl:if test="local-name(following-sibling::*[1])='directive'">
    <xsl:call-template name="processDirectives">
      <xsl:with-param name="directive" select="following-sibling::*[1]"/>
    </xsl:call-template>
   </xsl:if>
  </const>
</xsl:template>

<xsl:template match="member">
  <xsl:variable name="next-sibling" select="following-sibling::*[1]"/>

  <xsl:choose>
    <xsl:when test="./cases">
      <case>
        <xsl:for-each select="./cases/case">
          <caseDiscriminator>
            <xsl:attribute name="value">
              <xsl:value-of select="@value"/>
            </xsl:attribute>
          </caseDiscriminator>
        </xsl:for-each>

        <member>

          <xsl:if test="@name and @name!=''">
            <xsl:attribute name="name">
              <xsl:value-of select="@name"/>
            </xsl:attribute>
          </xsl:if>

          <xsl:for-each select="@*[. != '' and name(.)!='name']">
            <xsl:choose>
              <xsl:when test="name(.)='type'">
                 <xsl:apply-templates select="."/>
              </xsl:when>
              <xsl:when test="name(.)='pointer'">
                <xsl:if test=".='yes'">
                  <xsl:attribute name="pointer">true</xsl:attribute>
                </xsl:if>
              </xsl:when>
              <xsl:when test="local-name(.)='maxLengthString'">
                  <xsl:if test="../@boundedStr">
                    <xsl:apply-templates select="."/> 
                  </xsl:if>
                  <!--<xsl:if test="../@boundedStr or 
                                (../../@kind='union' and 
                                (../@type='string' or ../@type='wstring'))">
                    <xsl:apply-templates select="."/> 
                  </xsl:if>-->
              </xsl:when>
              <xsl:when test="name(.)='maxLengthSequence'">
                  <xsl:apply-templates select="."/>
              </xsl:when>
              <xsl:when test="name(.)='memberId'">
                  <xsl:attribute name="id">
                      <xsl:value-of select="."/>
                  </xsl:attribute>
              </xsl:when>
              <xsl:when test="local-name(.)='enum' or local-name(.)='enumCount' or local-name(.)='access'">
                    <!-- Just ignore -->
              </xsl:when>
              <xsl:otherwise>
                 <xsl:apply-templates select="."/>
              </xsl:otherwise>        
            </xsl:choose>
          </xsl:for-each>
          <xsl:if test="./cardinality"> 
            <xsl:call-template name="processCardinality">
              <xsl:with-param name="cardinalityNode" select="./cardinality"/>
            </xsl:call-template>
          </xsl:if>
          <xsl:if test="local-name($next-sibling)='directive'">
            <xsl:call-template name="processDirectives">
              <xsl:with-param name="directive" select="$next-sibling"/>
            </xsl:call-template>
          </xsl:if>
          <xsl:apply-templates />
        </member>
      </case>

    </xsl:when>
    <xsl:otherwise>
      <member>

        <xsl:if test="@name and @name!=''">
          <xsl:attribute name="name">
            <xsl:value-of select="@name"/>
          </xsl:attribute>
        </xsl:if>

        <xsl:for-each select="@*[. != '' and name(.)!='name']">
          <xsl:choose>
            <xsl:when test="name(.)='type'">
               <xsl:apply-templates select="."/>
            </xsl:when>
            <xsl:when test="name(.)='pointer'">
              <xsl:if test=".='yes'">
                <xsl:attribute name="pointer">true</xsl:attribute>
              </xsl:if>
            </xsl:when>
            <xsl:when test="local-name(.)='maxLengthString'">
                <xsl:if test="../@boundedStr">
                  <xsl:apply-templates select="."/> 
                </xsl:if>
                <!--<xsl:if test="../@boundedStr or 
                              (../../@kind='union' and 
                              (../@type='string' or ../@type='wstring'))">
                  <xsl:apply-templates select="."/> 
                </xsl:if>-->
            </xsl:when>
            <xsl:when test="name(.)='maxLengthSequence'">
                <xsl:apply-templates select="."/>
            </xsl:when>
            <xsl:when test="name(.)='memberId'">
                <xsl:attribute name="id">
                    <xsl:value-of select="."/>
                </xsl:attribute>
            </xsl:when>
            <xsl:when test="local-name(.)='enum' or local-name(.)='enumCount' or local-name(.)='access'">
                  <!-- Just ignore -->
            </xsl:when>
            <xsl:otherwise>
               <xsl:apply-templates select="."/>
            </xsl:otherwise>        
          </xsl:choose>
        </xsl:for-each>
        <xsl:if test="./cardinality"> 
          <xsl:call-template name="processCardinality">
            <xsl:with-param name="cardinalityNode" select="./cardinality"/>
          </xsl:call-template>
        </xsl:if>
        <xsl:if test="local-name($next-sibling)='directive'">
          <xsl:call-template name="processDirectives">
            <xsl:with-param name="directive" select="$next-sibling"/>
          </xsl:call-template>
          <xsl:if test="local-name(following-sibling::*[2])='directive'">
            <xsl:call-template name="processDirectives">
              <xsl:with-param name="directive" select="following-sibling::*[2]"/>
            </xsl:call-template>
          </xsl:if>
        </xsl:if>
        <xsl:apply-templates />
      </member>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="cardinality">
</xsl:template>

<xsl:template name="processCardinality">
  <xsl:param name="cardinalityNode"/>
  <xsl:variable name="dimensionValue">
    <xsl:for-each select="$cardinalityNode/dimension">
      <xsl:value-of select="./@size"/>
      <xsl:if test="position()!=last()">
        <xsl:text>,</xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:variable>

  <xsl:attribute name="arrayDimensions">
    <xsl:value-of select="$dimensionValue"/>
  </xsl:attribute>
  
</xsl:template>

<xsl:template match="directive">
  <xsl:if test="not(@kind='key' or @kind='top-level' or @kind='resolve-name' or @kind='Extensibility' or @kind='BitSet' or @kind='BitBound')">
      <directive>
        <xsl:attribute name="kind">
          <!--<xsl:value-of select="./@kind"/>-->
          <xsl:choose>
            <xsl:when test="@kind='copy-c'">
              <xsl:value-of select="'copyC'"/>
            </xsl:when>
            <xsl:when test="@kind='copy-java'">
              <xsl:value-of select="'copyJava'"/>
            </xsl:when>
            <xsl:when test="@kind='copy-java-begin'">
              <xsl:value-of select="'copyJavaBegin'"/>
            </xsl:when>
            <xsl:when test="@kind='copy-declaration'">
              <xsl:value-of select="'copyDeclaration'"/>
            </xsl:when>
            <xsl:when test="@kind='copy-java-declaration'">
              <xsl:value-of select="'copyJavaDeclaration'"/>
            </xsl:when>
            <xsl:when test="@kind='copy-java-declaration-begin'">
              <xsl:value-of select="'copyJavaDeclarationBegin'"/>
            </xsl:when>
            <xsl:when test="@kind='copy-c-declaration'">
              <xsl:value-of select="'copyCDeclaration'"/>
            </xsl:when>
            <xsl:when test="@kind='copy-cppcli'">
              <xsl:value-of select="'copyCppcli'"/>
            </xsl:when>
            <xsl:when test="@kind='copy-cppcli-declaration'">
              <xsl:value-of select="'copyCppcliDeclaration'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="./@kind"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:value-of select="."/>
      </directive>
  </xsl:if>
</xsl:template>


<xsl:template name="processDirectives">
  <xsl:param name="directive"/>
  <xsl:choose>
    <xsl:when test="$directive/@kind='key'">
      <xsl:attribute name="key">true</xsl:attribute>
    </xsl:when>
    <xsl:when test="$directive/@kind='resolve-name'">
      <xsl:attribute name="resolveName">
        <xsl:value-of select="normalize-space($directive)"/>
      </xsl:attribute>
    </xsl:when>
    <xsl:when test="$directive/@kind='top-level'">
      <xsl:attribute name="topLevel">  
        <xsl:value-of select="normalize-space($directive)"/>
      </xsl:attribute>
    </xsl:when>
    <xsl:when test="$directive/@kind='Extensibility'">
      <xsl:attribute name="extensibility">
        <xsl:if test="$directive/text() = 'EXTENSIBLE_EXTENSIBILITY'">
            <xsl:text>extensible</xsl:text>
        </xsl:if>
        <xsl:if test="$directive/text() = 'MUTABLE_EXTENSIBILITY'">
            <xsl:text>mutable</xsl:text>
        </xsl:if>
        <xsl:if test="$directive/text() = 'FINAL_EXTENSIBILITY'">
            <xsl:text>final</xsl:text>
        </xsl:if>
      </xsl:attribute>
    </xsl:when>
    <xsl:when test="$directive/@bitBound">
      <xsl:attribute name="bitBound">  
        <xsl:value-of select="normalize-space($directive)"/>
      </xsl:attribute>
    </xsl:when>
  </xsl:choose>

  <xsl:variable name="nextSibling" select="$directive/following-sibling::*[1]"/>
  <xsl:if test="local-name($nextSibling)='directive'">
    <xsl:call-template name="processDirectives">
      <xsl:with-param name="directive" select="$nextSibling"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>

</xsl:transform>
