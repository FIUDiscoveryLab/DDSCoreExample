<?xml version="1.0"?>
<!-- 
/* $Id: inputXMLXSDtransform.xsl,v 1.7 2013/09/12 14:22:27 fernando Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
modification history:
- - - - - - - - - - -
5.0.1,15apr13,acr CODEGEN-573: set minOccurs=0 for optional members
                  (as per the XSD type representation spec in XTypes)
10y,09jun11,fcs CXTYPES-88: Generate XML and XSD code for new features in Phase 1
10y,04mar10,fcs Fixed getPathWithoutTypeName
10y,27aug09,fcs Fixed bug 13103
10y,07apr09,fcs Added boolean operators to consts
10y,09mar09,fcs Fixed bug 12802
10y,09mar09,fcs Removed NOT yet implemented message (bug 12801)
10y,08mar09,fcs Added cases and ordinal as annotations
10y,08mar09,fcs Fixed array/sequence of bounded strings
10y,07mar09,fcs Fixed base attribute assignment in xsd:extension (bug 12800)
10y,21nov08,jlv Changed maxLengthSequence for sequenceMaxLength and maxLengthString for
                stringMaxLength in XML format.
10y,18nov08,jlv Changed the way unions are parsed in XML. Now members are children of cases.
10y,17nov08,jlv Added nonBasic type and nonBasicTypeName attribute.
10y,16nov08,jlv Removed sequence='true', now we use maxLengthSequence='-1' for unbounded sequences.
                Added maxLengthString='-1' case.
                Changed some types name.
10y,10nov08,jlv Added WSDL generation. Solve little bugs in typedefs structs and unions.
                Changed array types to lower case.
10y,08nov08,jlv Finished support of typedefs of typedefs.
10y,07nov08,jlv Changed the old way to parse arrays and sequences (changed the way the
                names are constructed). Added typedefs of typedefs of arrays.
10y,06nov08,jlv Fixed little bugs. Added typedefs of typedefs of structs and typedefs of unions.
10y,05nov08,jlv Added targetNamespace and tns: Fixed little bugs.
10y,04nov08,jlv Added a new way to parse arrays and sequences (when inlineArrayDcl and
                inlineSeqDcl are equals to true).
10y,03nov08,jlv Changed baseClass for xsd:extension base attribute.
10y,31oct08,jlv Changed char to dds:char. Changed the way unbounded strings/wstrings
                are transformed. Added @ to all attributes passed as comments. Changed the way
                valuetypes are identified. Changed dimensions to arrayDimensions. Changed 
                kind='sequence' to sequence='true'
10y,30oct08,jlv Changed ' ' to ',' in dimensions attribute. Changed the name of the
                directives resolve-name and top-level.
10y,29oct08,fcs Replaced ddsTypes.xsd with rti_dds_topic_types_common.xsd
10y,14oct08,jlv Changed forward_dcl to forwardDclValueType/forwardDclStruct/
                forwardDclUnion. Changed rtiddstypes: to dds: . Changed maxOccurs for
                unbounded sequences (now is 'unbounded').
10y,02oct08,jlv Added some documentation.
10y,01oct08,jlv Added constant resolution support.
10y,30sep08,jlv Created
-->
<xsl:transform version="1.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
               xmlns:xsd="http://www.w3.org/2001/XMLSchema"
               xmlns:tns="http://www.omg.org/IDL-Mapped/"
               xmlns:dds="http://www.omg.org/dds" 
               xmlns:mathParser="com.rti.ndds.nddsgen.transformation.MathParser"
               extension-element-prefixes="mathParser"
               exclude-result-prefixes="mathParser">

  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
  <xsl:strip-space elements="*"/>

  <xsl:param name="generateWSDL" select="'false'"/>

  <xsl:variable name="inlineArrayDcl">false</xsl:variable>
  <xsl:variable name="inlineSeqDcl">false</xsl:variable>


  <!-- Default template -->
  <xsl:template match="/">
    <xsl:apply-templates select="*">
      <xsl:with-param name="ind">0</xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>


  <!-- types template -->
  <xsl:template match="types">
    <xsl:param name="ind"/>

    <xsl:choose>
      <xsl:when test="$generateWSDL='true'">

        <definitions targetNamespace="http://www.omg.org/IDL-Mapped/"
                     xmlns:tns="http://www.omg.org/IDL-Mapped/"
                     xmlns="http://schemas.xmlsoap.org/wsdl/"
                     xmlns:xsd="http://www.w3.org/2001/XMLSchema">

          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind+1"/>
          </xsl:call-template>
          <types>
            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind+2"/>
            </xsl:call-template>
            <xsd:schema targetNamespace="http://www.omg.org/IDL-Mapped/"
                        xmlns:tns="http://www.omg.org/IDL-Mapped/"
                        xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
                        xmlns:dds="http://www.omg.org/dds">
              <xsl:call-template name="printBR">
                <xsl:with-param name="ind" select="$ind+3"/>
              </xsl:call-template>
              <xsd:import>
                <xsl:attribute name="namespace">
                  <xsl:text>http://www.omg.org/dds</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="schemaLocation">
                  <xsl:text>rti_dds_topic_types_common.xsd</xsl:text>
                </xsl:attribute>
              </xsd:import>
              <!-- First, apply include, included and directive templates -->
              <xsl:apply-templates select="include|included|directive">
                <xsl:with-param name="ind" select="$ind+3"/>
              </xsl:apply-templates>

              <!-- Second, expand all the nested arrays and sequences -->
              <xsl:if test="$inlineArrayDcl!='true'">
                <xsl:apply-templates select="./*//member[@arrayDimensions]">
                  <xsl:with-param name="ind" select="$ind+3"/>
                  <xsl:with-param name="isDeclarationOfNestedArrays">true</xsl:with-param>
                </xsl:apply-templates>
              </xsl:if>
              <xsl:if test="$inlineSeqDcl!='true'">
                <xsl:apply-templates select="./*//member[(@sequenceMaxLength and @sequenceMaxLength!='') and not(@arrayDimensions)]">
                  <xsl:with-param name="ind" select="$ind+3"/>
                  <xsl:with-param name="isDeclarationOfNestedArrays">true</xsl:with-param>
                </xsl:apply-templates>
              </xsl:if>

              <!-- Finally, apply all the other templates-->
              <xsl:apply-templates select="./*[not(self::include|self::directive|self::included)]">
                <xsl:with-param name="ind" select="$ind+3"/>
              </xsl:apply-templates>
              <xsl:call-template name="printBR">
                <xsl:with-param name="ind" select="$ind+2"/>
              </xsl:call-template>
            </xsd:schema>
            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind+1"/>
            </xsl:call-template>
          </types>
        </definitions>
      </xsl:when>
      <xsl:otherwise>
        <xsd:schema targetNamespace="http://www.omg.org/IDL-Mapped/"
                    xmlns:tns="http://www.omg.org/IDL-Mapped/"
                    xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
                    xmlns:dds="http://www.omg.org/dds">
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind+1"/>
          </xsl:call-template>
          <xsd:import>
            <xsl:attribute name="namespace">
              <xsl:text>http://www.omg.org/dds</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="schemaLocation">
              <xsl:text>rti_dds_topic_types_common.xsd</xsl:text>
            </xsl:attribute>
          </xsd:import>
          <!-- First, apply include, included and directive templates -->
          <xsl:apply-templates select="include|included|directive">
            <xsl:with-param name="ind" select="$ind+1"/>
          </xsl:apply-templates>

          <!-- Second, expand all the nested arrays and sequences -->
          <xsl:if test="$inlineArrayDcl!='true'">
            <xsl:apply-templates select=".//member[@arrayDimensions and not(ancestor::included)]">
              <xsl:with-param name="ind" select="$ind+1"/>
              <xsl:with-param name="isDeclarationOfNestedArrays">true</xsl:with-param>
            </xsl:apply-templates>
          </xsl:if>
          <xsl:if test="$inlineSeqDcl!='true'">
            <xsl:apply-templates select=".//member[(@sequenceMaxLength and @sequenceMaxLength!='') 
                                                   and not(@arrayDimensions) and
                                                   not(ancestor::included)]">
              <xsl:with-param name="ind" select="$ind+1"/>
              <xsl:with-param name="isDeclarationOfNestedArrays">true</xsl:with-param>
            </xsl:apply-templates>
          </xsl:if>

          <!-- Finally, apply all the other templates-->
          <xsl:apply-templates select="./*[not(self::include|self::directive|self::included)]">
            <xsl:with-param name="ind" select="$ind+1"/>
          </xsl:apply-templates>
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind"/>
          </xsl:call-template>
        </xsd:schema>    
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- const template - In fact, constants are not supported in XSD, so just ignore -->
  <xsl:template match="const">
    <!--    <xsl:param name="ind"/>
    <xsl:param name="module"/>
    <xsl:call-template name="printBR">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
    <xsd:element>
      <xsl:attribute name="name">
        <xsl:value-of select="string(concat(string($module),@name))"/>
      </xsl:attribute>
      <xsl:attribute name="fixed">
        <xsl:value-of select="@value"/>
      </xsl:attribute>
      <xsl:attribute name="type">
        <xsl:choose>
          <xsl:when test="@type='longlong'">
            <xsl:value-of select="concat('dds:constant_','long')"/>
          </xsl:when>
          <xsl:when test="@type='long'">
            <xsl:value-of select="concat('dds:constant_','int')"/>
          </xsl:when>
          <xsl:when test="@type='longdouble'">
            <xsl:value-of select="concat('dds:constant_','longDouble')"/>
          </xsl:when>
          <xsl:when test="@type='double'">
            <xsl:value-of select="concat('dds:constant_','double')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="concat('dds:constant_',string(@type))"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </xsd:element>
    <xsl:if test="@resolveName">
      <xsl:comment>@resolveName <xsl:value-of select="@resolveName"/></xsl:comment>
    </xsl:if>-->
  </xsl:template>


  <!-- copy/directive template -->
  <xsl:template name="copy" match="directive">
    <xsl:param name="ind"/>
    <xsl:call-template name="printBR">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
    <xsl:comment>
      <xsl:text> @</xsl:text>
      <xsl:value-of select="@kind"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="."/>
      <xsl:text> </xsl:text>
    </xsl:comment>
  </xsl:template>


  <!-- discriminator template -->
  <xsl:template match="discriminator">
    <xsl:param name="ind"/>
    <xsl:call-template name="printBR">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
    <xsd:element>
      <xsl:attribute name="name">discriminator</xsl:attribute>
      <xsl:call-template name="solveType">
        <xsl:with-param name="ind" select="$ind+1"/>
      </xsl:call-template>
    </xsd:element>
  </xsl:template>


  <!-- enum template -->
  <xsl:template match="enum|bitset">
    <xsl:param name="ind"/>
    <xsl:param name="module"/>

    <xsl:call-template name="printBR">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
    <xsd:simpleType>
      <xsl:attribute name="name">
        <xsl:value-of select="concat($module,@name)"/>
      </xsl:attribute>
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind+1"/>
      </xsl:call-template>
      <xsd:restriction>
        <xsl:attribute name="base">xsd:string</xsl:attribute>
        <xsl:apply-templates select="enumerator|flag">
          <xsl:with-param name="ind" select="$ind+2"/>
        </xsl:apply-templates>
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind+1"/>
        </xsl:call-template>
      </xsd:restriction>
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind"/>
      </xsl:call-template>
    </xsd:simpleType>

    <xsl:if test="local-name(.)='bitset'">
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind"/>
        </xsl:call-template>
        <xsl:comment>
          <xsl:text> @bitSet </xsl:text>
        </xsl:comment>
    </xsl:if>

    <xsl:call-template name="processDirectives">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
  </xsl:template>


  <!-- case template -->
  <xsl:template match="case">
   <xsl:param name="ind"/>

    <xsl:call-template name="printBR">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
    <xsl:comment>
      <xsl:text> case </xsl:text>
      <xsl:for-each select="caseDiscriminator">
        <xsl:value-of select="@value"/>
        <xsl:if test="local-name(following-sibling::*[1])='caseDiscriminator'">
          <xsl:text>,</xsl:text>
        </xsl:if>
      </xsl:for-each>
      <xsl:text> </xsl:text>
    </xsl:comment>

    <xsl:apply-templates select="member">
      <xsl:with-param name="ind" select="$ind"/>
      <xsl:with-param name="caseNode" select="."/>
    </xsl:apply-templates>

  </xsl:template>


  <!-- enumerator template -->
  <xsl:template match="enumerator|flag">
    <xsl:param name="ind"/>
    <xsl:call-template name="printBR">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
    <xsd:enumeration>
      <xsl:attribute name="value">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
      <xsl:if test="@value and @value!=''">
        <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind+1"/>
        </xsl:call-template>
        <xsd:annotation>
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind+2"/>
          </xsl:call-template>
          <xsd:appinfo>            
            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind+3"/>
            </xsl:call-template>
            <ordinal><xsl:value-of select="@value"/></ordinal>
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind+2"/>
          </xsl:call-template>
          </xsd:appinfo>
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind+1"/>
        </xsl:call-template>
        </xsd:annotation>
      </xsl:if>
    <xsl:call-template name="printBR">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
    </xsd:enumeration>
    <xsl:if test="@value and @value!=''">
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind"/>
      </xsl:call-template>
      <xsl:comment>
        <xsl:text> @ordinal </xsl:text>
        <xsl:value-of select="@value"/>
        <xsl:text> </xsl:text>
      </xsl:comment>
    </xsl:if>
  </xsl:template>


  <!-- forward_dcl template -->
  <xsl:template match="forward_dcl">
    <xsl:param name="ind"/>
    <xsl:param name="module"/>

    <xsl:call-template name="printBR">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
    <xsd:element>
      <xsl:attribute name="name">
        <xsl:value-of select="string(concat($module,@name,'_forwardDcl'))"/>
      </xsl:attribute>
      <xsl:choose>
        <xsl:when test="@kind='valuetype'">
          <xsl:attribute name="type">dds:forwardDclValueType</xsl:attribute>
        </xsl:when>
        <xsl:when test="@kind='struct'">
          <xsl:attribute name="type">dds:forwardDclStruct</xsl:attribute>
        </xsl:when>
        <xsl:when test="@kind='union'">
          <xsl:attribute name="type">dds:forwardDclUnion</xsl:attribute>
        </xsl:when>
      </xsl:choose>
    </xsd:element>
  </xsl:template>


  <!-- include template -->
  <xsl:template match="include">
    <xsl:param name="ind"/>
    <xsl:call-template name="printBR">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
    <xsd:include>
      <xsl:attribute name="schemaLocation">
        <xsl:choose>
         <xsl:when test="$generateWSDL='true'">
           <xsl:value-of select="concat(substring(@file,1,string-length(@file)-4),'.wsdl')"/>
         </xsl:when>
         <xsl:otherwise>
           <xsl:value-of select="concat(substring(@file,1,string-length(@file)-4),'.xsd')"/>
         </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </xsd:include>
  </xsl:template>


  <!-- included template -->
  <xsl:template match="included">
    <xsl:param name="ind"/>
    <xsl:call-template name="printBR">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
    <xsd:include>
      <xsl:attribute name="schemaLocation">
        <xsl:choose>
         <xsl:when test="$generateWSDL='true'">
           <xsl:value-of select="concat(substring(@src,1,string-length(@src)-4),'.wsdl')"/>
         </xsl:when>
         <xsl:otherwise>
           <xsl:value-of select="concat(substring(@src,1,string-length(@src)-4),'.xsd')"/>
         </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </xsd:include>
    <!--<xsl:comment>included: <xsl:value-of select="@src"/></xsl:comment>-->
  </xsl:template>


  <!-- member template -->
  <xsl:template match="member" name="member">
    <xsl:param name="ind"/>
    <xsl:param name="module"/>
    <xsl:param name="caseNode"/>

    <xsl:call-template name="printBR">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
    <xsd:element>
      <xsl:attribute name="name">
        <xsl:choose>
          <xsl:when test="@name and @name!=''">
            <xsl:value-of select="string(@name)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="string(concat('_ANONYMOUS_',position()))"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="minOccurs">
        <xsl:choose>
          <xsl:when test="$caseNode">0</xsl:when>
          <xsl:when test="@optional='true'">0</xsl:when>
          <xsl:otherwise>1</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="maxOccurs">1</xsl:attribute>

      <xsl:choose>
        <xsl:when test="$inlineArrayDcl!='true' and @arrayDimensions and @arrayDimensions!=''">
          <xsl:attribute name="type">

            <xsl:variable name="arrayType">
              <xsl:call-template name="solveTypeForArrays"/>
            </xsl:variable>

            <xsl:choose>
              <xsl:when test="local-name(..)='case'">
                <xsl:value-of select="concat('tns:',$module,string(../../@name),'_',string(@name),'_')"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="concat('tns:',$module,string(../@name),'_',string(@name),'_')"/>
              </xsl:otherwise>
            </xsl:choose>

            <xsl:call-template name="solveExplicitArrayOrSequenceName">
              <xsl:with-param name="arrayDimensions" select="concat(@arrayDimensions,',')"/>
              <xsl:with-param name="sequenceMaxLength" select="@sequenceMaxLength"/>
              <xsl:with-param name="type" select="$arrayType"/>
            </xsl:call-template>

          </xsl:attribute>
          <xsl:if test="$caseNode">
            <xsl:call-template name="processCase">
              <xsl:with-param name="ind" select="$ind + 1"/>
              <xsl:with-param name="caseNode" select="$caseNode"/>
            </xsl:call-template>
          </xsl:if>
        </xsl:when>
        <xsl:when test="@arrayDimensions and @arrayDimensions!=''">
          <xsl:variable name="reversedDimensions">
            <xsl:call-template name="reverseDimensions">
              <xsl:with-param name="arrayDimensions" select="string(concat(@arrayDimensions,','))"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:call-template name="solveNestedArrayOrSequenceMember">
            <xsl:with-param name="ind" select="$ind+1"/>
            <xsl:with-param name="arrayDimensions" select="$reversedDimensions"/>
            <xsl:with-param name="sequenceMaxLength" select="@sequenceMaxLength"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="$inlineSeqDcl!='true' and @sequenceMaxLength and @sequenceMaxLength!=''">
          <xsl:attribute name="type">

            <xsl:variable name="arrayType">
              <xsl:call-template name="solveTypeForArrays"/>
            </xsl:variable>

            <xsl:choose>
              <xsl:when test="local-name(..)='case'">
                <xsl:value-of select="concat('tns:',$module,string(../../@name),'_',string(@name),'_')"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="concat('tns:',$module,string(../@name),'_',string(@name),'_')"/>
              </xsl:otherwise>
            </xsl:choose>

            <xsl:call-template name="solveExplicitArrayOrSequenceName">
              <xsl:with-param name="arrayDimensions" select="concat(@arrayDimensions,',')"/>
              <xsl:with-param name="sequenceMaxLength" select="@sequenceMaxLength"/>
              <xsl:with-param name="type" select="$arrayType"/>
            </xsl:call-template>

          </xsl:attribute>
          <xsl:if test="$caseNode">
            <xsl:call-template name="processCase">
              <xsl:with-param name="ind" select="$ind+1"/>
              <xsl:with-param name="caseNode" select="$caseNode"/>
            </xsl:call-template>
          </xsl:if>
        </xsl:when>
        <xsl:when test="@sequenceMaxLength and @sequenceMaxLength!=''">
          <xsl:call-template name="solveNestedArrayOrSequenceMember">
            <xsl:with-param name="ind" select="$ind+1"/>
            <xsl:with-param name="arrayDimensions" select="''"/>
            <xsl:with-param name="sequenceMaxLength" select="@sequenceMaxLength"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="solveType">
            <xsl:with-param name="ind" select="$ind+1"/>
            <xsl:with-param name="caseNode" select="$caseNode"/>
          </xsl:call-template>

          <xsl:apply-templates select="./*[not(case)]">
            <xsl:with-param name="ind" select="$ind+1"/>
          </xsl:apply-templates>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="((@type='string' or @type='wstring') and @stringMaxLength and @stringMaxLength!='' and @stringMaxLength!='-1') or ($inlineSeqDcl='true' and @sequenceMaxLength and @sequenceMaxLength!='') or ($inlineArrayDcl='true' and @arrayDimensions and @arrayDimensions!='') or $caseNode">
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind"/>
        </xsl:call-template>
      </xsl:if>
    </xsd:element>
    <xsl:call-template name="processDirectives">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
  </xsl:template>


  <!-- processDirectives template -->
  <xsl:template name="processCase">
    <xsl:param name="ind"/>
    <xsl:param name="caseNode"/>
    <xsl:call-template name="printBR">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
    <xsd:annotation>
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind+1"/>
      </xsl:call-template>
      <xsd:appinfo>          
        <xsl:for-each select="$caseNode/caseDiscriminator">
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind+2"/>
          </xsl:call-template>
          <case><xsl:value-of select="@value"/></case>
        </xsl:for-each>
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind+1"/>
      </xsl:call-template>
      </xsd:appinfo>
    <xsl:call-template name="printBR">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
    </xsd:annotation>
  </xsl:template>

  <!-- processDirectives template -->
  <xsl:template name="processDirectives">
    <xsl:param name="ind"/>
    <xsl:if test="@bitField">
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind+1"/>
      </xsl:call-template>

      <xsl:variable name="tempNum">
        <xsl:call-template name="resolveConstantValue">
          <xsl:with-param name="constantName" select="concat('(',@bitField,')')"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:comment>
        <xsl:text> @bitField </xsl:text>
        <xsl:value-of select="mathParser:resolveMathExpression($tempNum)"/>
        <xsl:text> </xsl:text>
      </xsl:comment>
    </xsl:if>
    <xsl:if test="@pointer">
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind+1"/>
      </xsl:call-template>
      <xsl:comment>
        <xsl:text> @pointer </xsl:text>
        <xsl:value-of select="@pointer"/>
        <xsl:text> </xsl:text>
      </xsl:comment>
    </xsl:if>
    <xsl:if test="@visibility">
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind"/>
      </xsl:call-template>
      <xsl:comment>
        <xsl:text> @visibility </xsl:text>
        <xsl:value-of select="@visibility"/>
        <xsl:text> </xsl:text>
      </xsl:comment>
    </xsl:if>
    <xsl:if test="@key">
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind+1"/>
      </xsl:call-template>
      <xsl:comment>
        <xsl:text> @key </xsl:text>
        <xsl:value-of select="@key"/>
        <xsl:text> </xsl:text>
      </xsl:comment>
    </xsl:if>
    <xsl:if test="@id">
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind+1"/>
      </xsl:call-template>
      <xsl:comment>
        <xsl:text> @id </xsl:text>
        <xsl:value-of select="@id"/>
        <xsl:text> </xsl:text>
      </xsl:comment>
    </xsl:if>
    <xsl:if test="@bitBound">
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind"/>
      </xsl:call-template>
      <xsl:comment>
        <xsl:text> @bitBound </xsl:text>
        <xsl:value-of select="@bitBound"/>
        <xsl:text> </xsl:text>
      </xsl:comment>
    </xsl:if>
    <xsl:if test="@resolveName">
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind+1"/>
      </xsl:call-template>
      <xsl:comment>
        <xsl:text> @resolveName </xsl:text>
        <xsl:value-of select="@resolveName"/>
        <xsl:text> </xsl:text>
      </xsl:comment>
    </xsl:if>
    <xsl:if test="@topLevel">
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind+1"/>
      </xsl:call-template>
      <xsl:comment>
        <xsl:text> @topLevel </xsl:text>
        <xsl:value-of select="@topLevel"/>
        <xsl:text> </xsl:text>
      </xsl:comment>
    </xsl:if>
    <xsl:if test="@typeModifier">
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind"/>
      </xsl:call-template>
      <xsl:comment>
        <xsl:text> @typeModifier </xsl:text>
        <xsl:value-of select="@typeModifier"/>
        <xsl:text> </xsl:text>
      </xsl:comment>
    </xsl:if>
    <xsl:if test="@extensibility">
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind+1"/>
      </xsl:call-template>
      <xsl:comment>
        <xsl:text> @extensibility </xsl:text>
        <xsl:choose>
            <xsl:when test="@extensibility = 'extensible'">
                <xsl:text>EXTENSIBLE_EXTENSIBILITY</xsl:text>
            </xsl:when>
            <xsl:when test="@extensibility = 'mutable'">
                <xsl:text>MUTABLE_EXTENSIBILITY</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>FINAL_EXTENSIBILITY</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text> </xsl:text>
      </xsl:comment>
    </xsl:if>
    <!--
    <xsl:if test="@baseClass">
      <xsl:variable name="baseClass">
        <xsl:call-template name="resolveName">
          <xsl:with-param name="typeDefType" select="@baseClass"/>
          <xsl:with-param name="typeDefName" select="@name"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind+1"/>
      </xsl:call-template>
      <xsl:comment>
        <xsl:text> @baseClass </xsl:text><xsl:value-of select="$baseClass"/>
        <xsl:text> </xsl:text>
      </xsl:comment>
    </xsl:if>
-->
  </xsl:template>


  <!-- module template -->
  <xsl:template match="module">
    <xsl:param name="ind"/>
    <xsl:param name="module"/>

    <xsl:apply-templates>
      <xsl:with-param name="ind" select="$ind"/>
      <xsl:with-param name="module" select="concat($module,@name,'.')"/>
    </xsl:apply-templates>

  </xsl:template>


  <!-- struct template -->
  <xsl:template match="struct" name="struct">
    <xsl:param name="ind"/>
    <xsl:param name="module"/>
    <xsl:param name="isValueType"/>

    <xsl:call-template name="printBR">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>

    <xsl:choose>
      <xsl:when test="@baseClass!='' or @baseType!=''">

        <xsl:variable name="baseClass">
          <xsl:value-of select="'tns:'"/>

          <xsl:if test="@baseClass!=''">
              <xsl:call-template name="resolveName">
                <xsl:with-param name="typeDefType" select="@baseClass"/>
                <xsl:with-param name="typeDefName" select="@name"/>
              </xsl:call-template>
          </xsl:if>

          <xsl:if test="@baseType!=''">
              <xsl:call-template name="resolveName">
                <xsl:with-param name="typeDefType" select="@baseType"/>
                <xsl:with-param name="typeDefName" select="@name"/>
              </xsl:call-template>
          </xsl:if>
        </xsl:variable>

        <xsd:complexType>
          <xsl:attribute name="name">
            <xsl:value-of select="string(concat(string($module),@name))"/>
          </xsl:attribute>

          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind+1"/>
          </xsl:call-template>

          <xsd:complexContent>

            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind+2"/>
            </xsl:call-template>

            <xsd:extension>

              <xsl:attribute name="base">
                <xsl:value-of select="$baseClass"/>
              </xsl:attribute>

              <xsl:call-template name="printBR">
                <xsl:with-param name="ind" select="$ind+3"/>
              </xsl:call-template>

              <xsd:sequence>
                <xsl:apply-templates select="./*">
                  <xsl:with-param name="ind" select="$ind+4"/>
                  <xsl:with-param name="module" select="$module"/>
                </xsl:apply-templates>

                <xsl:call-template name="printBR">
                  <xsl:with-param name="ind" select="$ind+3"/>
                </xsl:call-template>
              </xsd:sequence>
              <!--
              <xsl:if test="$isValueType='true'">
                <xsl:call-template name="printBR">
                  <xsl:with-param name="ind" select="$ind+3"/>
                </xsl:call-template>
                <xsd:attribute name="id" type="xsd:ID" use="optional"/>
              </xsl:if>
-->
              <xsl:call-template name="printBR">
                <xsl:with-param name="ind" select="$ind+2"/>
              </xsl:call-template>
            </xsd:extension>

            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind+1"/>
            </xsl:call-template>
          </xsd:complexContent>

          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind"/>
          </xsl:call-template>
        </xsd:complexType>
      </xsl:when>
      <xsl:otherwise>

        <xsd:complexType>
          <xsl:attribute name="name">
            <xsl:value-of select="string(concat(string($module),@name))"/>
          </xsl:attribute>
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind+1"/>
          </xsl:call-template>
          <xsd:sequence>
            <xsl:apply-templates select="./*">
              <xsl:with-param name="ind" select="$ind+2"/>
              <xsl:with-param name="module" select="$module"/>
            </xsl:apply-templates>
            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind+1"/>
            </xsl:call-template>
          </xsd:sequence>
          <!--
          <xsl:if test="$isValueType='true'">
            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind+1"/>
            </xsl:call-template>
            <xsd:attribute name="id" type="xsd:ID" use="optional"/>
          </xsl:if>
-->
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind"/>
          </xsl:call-template>
        </xsd:complexType>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:if test="$isValueType='true'">
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind"/>
      </xsl:call-template>
      <xsl:comment>
        <xsl:text> @valuetype </xsl:text>
        <xsl:text>true </xsl:text>
      </xsl:comment>
    </xsl:if>
    <xsl:if test="$isValueType!='true'">
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind"/>
      </xsl:call-template>
      <xsl:comment>
        <xsl:text> @struct </xsl:text>
        <xsl:text>true </xsl:text>
      </xsl:comment>
    </xsl:if>
    <xsl:call-template name="processDirectives">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
  </xsl:template>


  <!-- typedef template -->
  <xsl:template match="typedef">
    <xsl:param name="ind"/>
    <xsl:param name="module"/>

    <xsl:variable name="name">
      <xsl:value-of select="concat($module,@name)"/>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$inlineArrayDcl!='true' and @arrayDimensions and @arrayDimensions!=''">

        <xsl:variable name="reversedDimensions">
          <xsl:call-template name="reverseDimensions">
            <xsl:with-param name="arrayDimensions" select="string(concat(@arrayDimensions,','))"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="resolvedDimensions">
          <xsl:call-template name="resolveDimensions">
            <xsl:with-param name="arrayDimensions" select="$reversedDimensions"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:call-template name="array">
          <xsl:with-param name="ind" select="$ind"/>
          <xsl:with-param name="arrayDimensions" select="$resolvedDimensions"/>
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="$inlineSeqDcl!='true' and @sequenceMaxLength and @sequenceMaxLength!=''">
        <xsl:call-template name="sequence">
          <xsl:with-param name="ind" select="$ind"/>
          <xsl:with-param name="module" select="$module"/>
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="@arrayDimensions and @arrayDimensions!='' or @sequenceMaxLength and @sequenceMaxLength!=''">

        <xsl:variable name="reversedDimensions">
          <xsl:call-template name="reverseDimensions">
            <xsl:with-param name="arrayDimensions" select="string(concat(@arrayDimensions,','))"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:call-template name="solveNestedArrayOrSequenceMember">
          <xsl:with-param name="arrayDimensions" select="$reversedDimensions"/>
          <xsl:with-param name="ind" select="$ind"/>
          <xsl:with-param name="sequenceMaxLength" select="@sequenceMaxLength"/>
          <xsl:with-param name="complexTypeName" select="$name"/>
        </xsl:call-template>
        <xsl:call-template name="processDirectives">
          <xsl:with-param name="ind" select="$ind"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="@type='short' or @type='double' or @type='boolean' or @type='float'  or @type='long' or @type='unsignedShort' or @type='unsignedLong' or @type='octet'  or @type='longLong' or @type='unsignedLongLong' or @type='wchar' or @type='longDouble' or @type='char' or @type='string'  or @type='wstring'">
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind"/>
        </xsl:call-template>
        <xsd:simpleType>
          <xsl:attribute name="name">
            <xsl:value-of select="concat($module,@name)"/>
          </xsl:attribute>
          <xsl:call-template name="solveType">
            <xsl:with-param name="ind" select="$ind+1"/>
            <xsl:with-param name="isTypedef">true</xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind"/>
          </xsl:call-template>
        </xsd:simpleType>
        <xsl:call-template name="processDirectives">
          <xsl:with-param name="ind" select="$ind"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="resolveName">
          <xsl:with-param name="ind" select="$ind"/>
          <xsl:with-param name="typeDefType" select="@nonBasicTypeName"/>
          <xsl:with-param name="typeDefName" select="concat($module,@name)"/>
          <xsl:with-param name="isTypedef" select="'true'"/>
        </xsl:call-template>

        <xsl:call-template name="processDirectives">
          <xsl:with-param name="ind" select="$ind"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- union template -->
  <xsl:template match="union">
    <xsl:param name="ind"/>
    <xsl:param name="module"/>

    <xsl:variable name="name">
      <xsl:value-of select="concat($module,@name)"/>
    </xsl:variable>

    <xsl:call-template name="printBR">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
    <xsd:complexType>
      <xsl:attribute name="name">
        <xsl:value-of select="$name"/>
      </xsl:attribute>
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind+1"/>
      </xsl:call-template>
      <xsd:sequence>
        <xsl:apply-templates select="discriminator">
          <xsl:with-param name="ind" select="$ind+2"/>
        </xsl:apply-templates>
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind+2"/>
        </xsl:call-template>
        <xsd:choice>
          <xsl:apply-templates select="case">
            <xsl:with-param name="ind" select="$ind+3"/>
          </xsl:apply-templates>
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind+2"/>
          </xsl:call-template>
        </xsd:choice>
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind+1"/>
        </xsl:call-template>
      </xsd:sequence>
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind"/>
      </xsl:call-template>
    </xsd:complexType>
    <xsl:call-template name="processDirectives">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
  </xsl:template>

  <!-- valuetype template -->
  <xsl:template match="valuetype">
    <xsl:param name="ind"/>
    <xsl:param name="module"/>

    <xsl:call-template name="struct">
      <xsl:with-param name="ind" select="$ind"/>
      <xsl:with-param name="isValueType">true</xsl:with-param>
      <xsl:with-param name="module">
        <xsl:value-of select="$module"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- @arrayDimensions template - is used to expand nested arrays that are INSIDE 
       a struct member -->
  <xsl:template match="member[@arrayDimensions]">
    <xsl:param name="ind"/>
    <xsl:param name="isDeclarationOfNestedArrays"/>
    <xsl:param name="caseNode"/>

    <xsl:variable name="modules">
      <xsl:call-template name="getFullPath"/>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$isDeclarationOfNestedArrays='true'">

        <!-- Nested array, used in a structure -->
        <xsl:choose>
          <xsl:when test="$modules and $modules!=''">
            <xsl:variable name="reversedDimensions">
              <xsl:call-template name="reverseDimensions">
                <xsl:with-param name="arrayDimensions" select="string(concat(@arrayDimensions,','))"/>
              </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="resolvedDimensions">
              <xsl:call-template name="resolveDimensions">
                <xsl:with-param name="arrayDimensions" select="$reversedDimensions"/>
              </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="childArrayName">
              <xsl:variable name="arrayType">
                <xsl:call-template name="solveTypeForArrays"/>
              </xsl:variable>

              <xsl:choose>
                <xsl:when test="local-name(..)='case'">
                  <xsl:value-of select="concat($modules,string(../../@name),'_',string(@name),'_')"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="concat($modules,string(../@name),'_',string(@name),'_')"/>
                </xsl:otherwise>
              </xsl:choose>

              <xsl:call-template name="solveExplicitArrayOrSequenceName">
                <xsl:with-param name="arrayDimensions" select="concat(@arrayDimensions,',')"/>
                <xsl:with-param name="sequenceMaxLength" select="@sequenceMaxLength"/>
                <xsl:with-param name="type" select="$arrayType"/>
              </xsl:call-template>

            </xsl:variable>

            <xsl:call-template name="array">
              <xsl:with-param name="ind" select="$ind"/>
              <xsl:with-param name="isDeclarationOfNestedArrays">true</xsl:with-param>
              <xsl:with-param name="arrayDimensions" select="$resolvedDimensions"/>
              <xsl:with-param name="childArrayName" select="$childArrayName"/>
            </xsl:call-template>
          </xsl:when>

          <xsl:when test="ancestor::module">
            <!-- In this case (a module ancestor exist, but $module is empty, just ignore -->
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="reversedDimensions">
              <xsl:call-template name="reverseDimensions">
                <xsl:with-param name="arrayDimensions" select="string(concat(@arrayDimensions,','))"/>
              </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="resolvedDimensions">
              <xsl:call-template name="resolveDimensions">
                <xsl:with-param name="arrayDimensions" select="$reversedDimensions"/>
              </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="childArrayName">

              <xsl:variable name="arrayType">
                <xsl:call-template name="solveTypeForArrays"/>
              </xsl:variable>

              <xsl:choose>
                <xsl:when test="local-name(..)='case'">
                  <xsl:value-of select="concat($modules,string(../../@name),'_',string(@name),'_')"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="concat($modules,string(../@name),'_',string(@name),'_')"/>
                </xsl:otherwise>
              </xsl:choose>

              <xsl:call-template name="solveExplicitArrayOrSequenceName">
                <xsl:with-param name="arrayDimensions" select="concat(@arrayDimensions,',')"/>
                <xsl:with-param name="sequenceMaxLength" select="@sequenceMaxLength"/>
                <xsl:with-param name="type" select="$arrayType"/>
              </xsl:call-template>

            </xsl:variable>

            <xsl:call-template name="array">
              <xsl:with-param name="ind" select="$ind"/>
              <xsl:with-param name="isDeclarationOfNestedArrays">true</xsl:with-param>
              <xsl:with-param name="arrayDimensions" select="$resolvedDimensions"/>
              <xsl:with-param name="childArrayName" select="$childArrayName"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="member">
          <xsl:with-param name="ind" select="$ind"/>
          <xsl:with-param name="caseNode" select="$caseNode"/>
          <xsl:with-param name="module" select="$modules"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- kindSequence template - is used to expand nested sequences that are INSIDE 
       a struct member-->
  <xsl:template match="*//member[(@sequenceMaxLength and @sequenceMaxLength!='') and not(@arrayDimensions)]">
    <xsl:param name="ind"/>
    <xsl:param name="isDeclarationOfNestedArrays"/>
    <xsl:param name="module"/>
    <xsl:param name="caseNode"/>
    <xsl:choose>
      <xsl:when test="$isDeclarationOfNestedArrays='true'">

        <xsl:variable name="modules">
          <xsl:call-template name="getFullPath"/>
        </xsl:variable>
        <xsl:variable name="arrayType">
          <xsl:call-template name="solveTypeForArrays"/>
        </xsl:variable>

        <!-- Nested sequence, used in a structure -->
        <xsl:choose>
          <xsl:when test="$modules and $modules!=''">
            <xsl:call-template name="sequence">
              <xsl:with-param name="ind" select="$ind+1"/>
              <xsl:with-param name="isDeclarationOfNestedArrays">true</xsl:with-param>
              <xsl:with-param name="childArrayName">
                <xsl:choose>
                  <xsl:when test="local-name(..)='case'">
                    <xsl:value-of select="concat($modules,string(../../@name),'_',string(@name),'_SequenceOf',$arrayType)"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="concat($modules,string(../@name),'_',string(@name),'_SequenceOf',$arrayType)"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:when>

          <xsl:when test="ancestor::module">
            <!-- In this case (a module ancestor exist, but $module is empty, just ignore -->
          </xsl:when>

          <xsl:otherwise>
            <xsl:call-template name="sequence">
              <xsl:with-param name="ind" select="$ind"/>
              <xsl:with-param name="isDeclarationOfNestedArrays">true</xsl:with-param>
              <xsl:with-param name="childArrayName">
                <xsl:choose>
                  <xsl:when test="local-name(..)='case'">
                    <xsl:value-of select="concat($modules,string(../../@name),'_',string(@name),'_SequenceOf',$arrayType)"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="concat($modules,string(../@name),'_',string(@name),'_SequenceOf',$arrayType)"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:with-param>

            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="member">
          <xsl:with-param name="ind" select="$ind"/>
          <xsl:with-param name="caseNode" select="$caseNode"/>
          <xsl:with-param name="module" select="$module"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- array template -->
  <xsl:template name="array">
    <xsl:param name="ind"/>
    <xsl:param name="arrayDimensions"/>
    <xsl:param name="childArrayName"/>
    <xsl:param name="isDeclarationOfNestedArrays"/>
    <xsl:param name="nestedElementsCount"/>

    <xsl:variable name="name">
      <!-- If the array is a child, we take the childArrayName-->
      <xsl:choose>
        <xsl:when test="$childArrayName and $childArrayName!=''">
          <xsl:choose>
            <xsl:when test="substring($childArrayName,string-length($childArrayName),string-length($childArrayName))='_'">
              <xsl:value-of select="substring($childArrayName,1,string-length($childArrayName)-1)"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$childArrayName"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="getFullPath"/>
          <xsl:value-of select="string(@name)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="baseName">
      <!-- If the array is a child, we take it's name-->
      <xsl:choose>
        <xsl:when test="$childArrayName and $childArrayName!=''">
          <xsl:value-of select="$name"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="arrayType">
            <xsl:call-template name="solveTypeForArrays"/>
          </xsl:variable>
          <xsl:value-of select="concat($name,'_')"/>
          <xsl:call-template name="solveExplicitArrayOrSequenceName">
            <xsl:with-param name="arrayDimensions" select="concat(@arrayDimensions,',')"/>
            <xsl:with-param name="sequenceMaxLength" select="@sequenceMaxLength"/>
            <xsl:with-param name="type" select="$arrayType"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="nestedElements">
      <xsl:choose>
        <xsl:when test="$nestedElementsCount and $nestedElementsCount!=''">
          <xsl:value-of select="$nestedElementsCount"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="getNumberOfNestedArraySeq">
            <xsl:with-param name="arrayDimensions" select="$arrayDimensions"/>
            <xsl:with-param name="currentCount" select="0"/>
            <xsl:with-param name="sequenceMaxLength" select="@sequenceMaxLength"/>
          </xsl:call-template>    
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- First, expand the first dimension of the array -->
    <xsl:call-template name="printBR">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
    <xsd:complexType>

      <xsl:attribute name="name">
        <xsl:value-of select="$name"/>
      </xsl:attribute>

      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind+1"/>
      </xsl:call-template>
      <xsd:sequence>
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind+2"/>
        </xsl:call-template>
        <xsd:element>
          <xsl:attribute name="name">
            <xsl:choose>
              <xsl:when test="$nestedElements='0'">
                <xsl:value-of select="'item'"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="concat('item',$nestedElements)"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:attribute name="minOccurs">
            <xsl:value-of select="substring-before($arrayDimensions,',')"/>
          </xsl:attribute>
          <xsl:attribute name="maxOccurs">
            <xsl:value-of select="substring-before($arrayDimensions,',')"/>
          </xsl:attribute>
          <!-- Arrays can have nested arrays, nested sequences or just a simpleType -->
          <xsl:choose>
            <xsl:when test="(substring-after($arrayDimensions,','))!=''">
              <xsl:attribute name="type">
                <xsl:value-of select="concat('tns:',substring-before($baseName,'ArrayOf'),substring-after($baseName,'ArrayOf'))"/>
              </xsl:attribute>
            </xsl:when>

            <xsl:when test="$inlineSeqDcl!='true' and @sequenceMaxLength and @sequenceMaxLength!=''">
              <xsl:attribute name="type">
                <xsl:value-of select="concat('tns:',substring-before($baseName,'ArrayOf'),substring-after($baseName,'ArrayOf'))"/>
              </xsl:attribute>
            </xsl:when>

            <xsl:when test="@sequenceMaxLength and @sequenceMaxLength!=''">
              <xsl:call-template name="solveNestedArrayOrSequenceMember">
                <xsl:with-param name="ind" select="$ind+3"/>
                <xsl:with-param name="arrayDimensions" select="''"/>
                <xsl:with-param name="sequenceMaxLength" select="@sequenceMaxLength"/>
              </xsl:call-template>
            </xsl:when>

            <xsl:otherwise>
              <xsl:call-template name="solveType">
                <xsl:with-param name="ind" select="$ind+3"/>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:if test="((@type='string' or @type='wstring') and @stringMaxLength and @stringMaxLength!='')">
            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind+2"/>
            </xsl:call-template>
          </xsl:if>
        </xsd:element>
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind+1"/>
        </xsl:call-template>
      </xsd:sequence>
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind"/>
      </xsl:call-template>
    </xsd:complexType>
    <xsl:call-template name="processDirectives">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>

    <!-- If this array has a nested array or sequence, it's necessary to call the correct template -->
    <xsl:choose>
      <xsl:when test="substring-after($arrayDimensions,',')!=''">

        <xsl:call-template name="array">
          <xsl:with-param name="ind" select="$ind"/>
          <xsl:with-param name="arrayDimensions" select="substring-after($arrayDimensions,',')"/>
          <xsl:with-param name="childArrayName" select="concat(substring-before($baseName,'ArrayOf'),substring-after($baseName,'ArrayOf'))"/>
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="$inlineSeqDcl!='true' and @sequenceMaxLength and @sequenceMaxLength!=''">

        <xsl:call-template name="sequence">
          <xsl:with-param name="ind" select="$ind"/>
          <xsl:with-param name="childArrayName" select="concat(substring-before($baseName,'ArrayOf'),substring-after($baseName,'ArrayOf'))"/>
        </xsl:call-template>
      </xsl:when>

      <xsl:otherwise>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- resolveCompleteQualifiedName - Resolves the complete quealified name of a type -->
  <xsl:template name="resolveQualifiedName">
    <xsl:for-each select="ancestor::module">
      <xsl:value-of select="concat(./@name,'.')"/>
    </xsl:for-each>
    <xsl:value-of select="@name"/>
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
                <xsl:call-template name="resolveName">
                  <xsl:with-param name="isConstant" select="'true'"/>
                  <xsl:with-param name="typeDefType" select="$substring"/>
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


  <!-- resolveConstantValueOld - DEPRECATED -->
  <xsl:template name="resolveConstantValueOld">
    <xsl:param name="constantName"/>

    <xsl:variable name="deParentesizedConstantName">
      <xsl:call-template name="deParentesize">
        <xsl:with-param name="str" select="$constantName"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:call-template name="resolveName">
      <xsl:with-param name="isConstant" select="'true'"/>
      <xsl:with-param name="typeDefType" select="$deParentesizedConstantName"/>
    </xsl:call-template>
  </xsl:template>

  <!--
      Get the ordinal value for a member of a enumeration
  -->
  <xsl:template name="getEnumValue">
      <xsl:param name="enum"/>
      <xsl:param name="enumeratorName"/>                        

      <xsl:variable name="enumerator"
           select="$enum/enumerator[@name=$enumeratorName]"/>

      <xsl:choose>
          <xsl:when test="$enumerator/@value">
              <xsl:value-of select="$enumerator/@value"/>
          </xsl:when>
          <xsl:when test="$enumerator/preceding-sibling::node()[./@value]">

              <xsl:variable name="baseOrdinal">
                  <xsl:for-each select="$enumerator/preceding-sibling::node()[./@value]">
                      <xsl:if test="position()=last()">
                          <xsl:value-of select="./@value"/>
                      </xsl:if>
                  </xsl:for-each>
              </xsl:variable>

              <xsl:variable name="basePosition">
                  <xsl:for-each select="$enumerator/preceding-sibling::node()[./@value]">
                      <xsl:if test="position()=last()">
                          <xsl:if test="preceding-sibling::node()">
                              <xsl:for-each select="preceding-sibling::node()">
                                  <xsl:if test="position()=last()">
                                      <xsl:value-of select="position()+1"/>
                                  </xsl:if>
                              </xsl:for-each>
                          </xsl:if>
                          <xsl:if test="not(preceding-sibling::node())">
                              <xsl:value-of select="1"/>
                          </xsl:if>
                      </xsl:if>
                  </xsl:for-each>
              </xsl:variable>

              <xsl:variable name="position">
                  <xsl:for-each select="$enum/enumerator">
                      <xsl:if test="./@name = $enumeratorName">
                            <xsl:value-of select="position()"/>
                      </xsl:if>
                  </xsl:for-each>
              </xsl:variable>

              <xsl:value-of select="$position - $basePosition + $baseOrdinal"/>
          </xsl:when>
          <xsl:otherwise>
              <xsl:variable name="position">
                  <xsl:for-each select="$enum/enumerator">
                      <xsl:if test="./@name = $enumeratorName">
                            <xsl:value-of select="position()"/>
                      </xsl:if>
                  </xsl:for-each>
              </xsl:variable>

              <xsl:value-of select="$position - 1"/>
          </xsl:otherwise>
      </xsl:choose>
  </xsl:template>

  <!-- resolveNameInModule template - Template that is called from resolveNameRecursive2
       template and search recursively for the correct type that match the nameToResolve
       in the given path -->
  <xsl:template name="resolveNameInModule">
    <xsl:param name="ind"/>
    <xsl:param name="nameToResolve"/>
    <xsl:param name="newTypeName"/>
    <xsl:param name="path"/>
    <xsl:param name="node"/>
    <xsl:param name="beforeRecursiveCallNode"/>
    <xsl:param name="beforeRecursiveCallPath"/>
    <xsl:param name="isTypedef"/>
    <xsl:param name="isConstant"/>
    <xsl:param name="initialNameToResolve"/>
    <xsl:param name="checkOnly" select="'false'"/>

    <xsl:variable name="module">
      <xsl:choose>
        <xsl:when test="contains($path,'/')">
          <xsl:value-of select="substring-before($path,'/')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$path"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="nestedModules">
      <xsl:choose>
        <xsl:when test="contains($path,'/')">
          <xsl:value-of select="substring-after($path,'/')"/>
        </xsl:when>
        <xsl:otherwise>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:choose>
      <!-- First, check if the current node has the correct module as a child -->
      <xsl:when test="$node/child::*[@name=$module]">
        <xsl:for-each select="$node/child::*[@name=$module]">
          <xsl:choose>
            <!-- If current the scoped type is in a module that is nested in the
            current one, call recursively this resolveNameInModule template -->
            <xsl:when test="$nestedModules and $nestedModules!=''">                
              <xsl:call-template name="resolveNameInModule">
                <xsl:with-param name="ind" select="$ind"/>
                <xsl:with-param name="nameToResolve" select="$nameToResolve"/>
                <xsl:with-param name="node" select="."/>
                <xsl:with-param name="beforeRecursiveCallNode" select="$beforeRecursiveCallNode"/>
                <xsl:with-param name="path" select="$nestedModules"/>
                <xsl:with-param name="beforeRecursiveCallPath" select="$beforeRecursiveCallPath"/>
                <xsl:with-param name="newTypeName" select="$newTypeName"/>
                <xsl:with-param name="isTypedef" select="$isTypedef"/>
                <xsl:with-param name="isConstant" select="$isConstant"/>
                <xsl:with-param name="initialNameToResolve" select="$initialNameToResolve"/>
                <xsl:with-param name="checkOnly" select="$checkOnly"/>
              </xsl:call-template>
            </xsl:when>

            <!-- If not: check if scoped type is inside the current module -->
            <xsl:otherwise>
               <xsl:choose>
                <xsl:when test="$isConstant='true' and ./enum/enumerator[@name=$nameToResolve]">
                  <xsl:if test="$checkOnly = 'false'">
                    <xsl:call-template name="getEnumValue">
                        <xsl:with-param name="enum" select="./enum[enumerator/@name=$nameToResolve]"/>
                        <xsl:with-param name="enumeratorName" select="$nameToResolve"/>                        
                    </xsl:call-template>
                  </xsl:if>

                  <xsl:if test="$checkOnly = 'true'">
                      <xsl:text>true</xsl:text>
                  </xsl:if>
                </xsl:when>
                <xsl:when test="./child::*[@name=$nameToResolve]">
                  <xsl:for-each select="./child::*[@name=$nameToResolve]">
                  <xsl:if test="$checkOnly = 'false'">
                    <xsl:choose>
                      <xsl:when test="$isTypedef='true'">
                        <xsl:if test="local-name(.)='struct' or local-name(.)='valuetype'">
                          <xsl:call-template name="typedefStruct">
                            <xsl:with-param name="ind" select="$ind"/>
                            <xsl:with-param name="typeDefName" select="$newTypeName"/>
                          </xsl:call-template>
                        </xsl:if>
                        <xsl:if test="local-name(.)='enum'">
                          <xsl:call-template name="typedefEnum">
                            <xsl:with-param name="ind" select="$ind"/>
                            <xsl:with-param name="typeDefName" select="$newTypeName"/>
                          </xsl:call-template>
                        </xsl:if>
                        <xsl:if test="local-name(.)='union'">
                          <xsl:call-template name="typedefUnion">
                            <xsl:with-param name="ind" select="$ind"/>
                            <xsl:with-param name="typeDefName" select="$newTypeName"/>
                          </xsl:call-template>
                        </xsl:if>
                        <xsl:if test="local-name(.)='typedef'">
                          <xsl:choose>
                            <xsl:when test="@arrayDimensions and @arrayDimensions!=''">
                              <xsl:call-template name="typedefTypedefArray">
                                <xsl:with-param name="ind" select="$ind"/>
                                <xsl:with-param name="typeDefName" select="$newTypeName"/>
                              </xsl:call-template>
                            </xsl:when>
                            <xsl:when test="@sequenceMaxLength and @sequenceMaxLength!=''">
                              <xsl:call-template name="typedefTypedefSequence">
                                <xsl:with-param name="ind" select="$ind"/>
                                <xsl:with-param name="typeDefName" select="$newTypeName"/>
                              </xsl:call-template>
                            </xsl:when>
                            <xsl:when test="@type='short' or @type='double' or @type='boolean' or @type='float'  or @type='long' or @type='unsignedShort' or @type='unsignedLong' or @type='octet'  or @type='longLong' or @type='unsignedLongLong' or @type='wchar' or @type='longDouble' or @type='char' or @type='string'  or @type='wstring'">
                              <xsl:call-template name="typedefTypedefPrimitive">
                                <xsl:with-param name="ind" select="$ind"/>
                                <xsl:with-param name="typeDefName" select="$newTypeName"/>
                              </xsl:call-template>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:variable name="typeDefTypePath">
                                <xsl:call-template name="changeDotsForSlash">
                                  <xsl:with-param name="nameToResolve" select="@nonBasicTypeName"/>
                                </xsl:call-template>
                              </xsl:variable>

                              <xsl:variable name="typeDefTypeName">
                                <xsl:call-template name="getTypeNameFromPath">
                                  <xsl:with-param name="nameToResolve" select="$typeDefTypePath"/>
                                </xsl:call-template>
                              </xsl:variable>

                              <xsl:variable name="modulesPath">
                                <xsl:call-template name="getPathWithoutTypeName">
                                  <xsl:with-param name="fullPath" select="$typeDefTypePath"/>
                                </xsl:call-template>
                              </xsl:variable>

                              <xsl:call-template name="resolveNameRecursive">
                                <xsl:with-param name="ind" select="$ind"/>
                                <xsl:with-param name="nameToResolve" select="$typeDefTypeName"/>
                                <xsl:with-param name="newTypeName" select="$newTypeName"/>
                                <xsl:with-param name="node" select="."/>
                                <xsl:with-param name="path" select="$modulesPath"/>
                                <xsl:with-param name="isTypedef" select="$isTypedef"/>
                                <xsl:with-param name="isConstant" select="$isConstant"/>
                                <xsl:with-param name="checkOnly" select="$checkOnly"/>
                              </xsl:call-template>
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:if>
                      </xsl:when>
                      <xsl:when test="$isConstant='true'">
                        <xsl:value-of select="@value"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:if test="local-name(.)!='forward_dcl'">
                          <xsl:call-template name="resolveQualifiedName"/>
                        </xsl:if>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:if>

                  <xsl:if test="$checkOnly = 'true'">
                      <xsl:text>true</xsl:text>
                  </xsl:if>

                  </xsl:for-each>
                </xsl:when>

                <!-- If not: if the value of $node before the first call to resolveNameInModule is not types,
                go up one level -->
                <xsl:otherwise>
                  <xsl:if test="local-name($beforeRecursiveCallNode/self::*)!='types' and local-name($beforeRecursiveCallNode/self::*)!='included'">
                    <xsl:call-template name="resolveNameRecursive">
                      <xsl:with-param name="ind" select="$ind"/>
                      <xsl:with-param name="nameToResolve" select="$nameToResolve"/>
                      <xsl:with-param name="newTypeName" select="$newTypeName"/>
                      <xsl:with-param name="node" select="$beforeRecursiveCallNode/parent::*"/>
                      <xsl:with-param name="path" select="$beforeRecursiveCallPath"/>
                      <xsl:with-param name="isTypedef" select="$isTypedef"/>
                      <xsl:with-param name="isConstant" select="$isConstant"/>
                      <xsl:with-param name="initialNameToResolve" select="$initialNameToResolve"/>
                      <xsl:with-param name="checkOnly" select="$checkOnly"/>
                    </xsl:call-template>
                  </xsl:if>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:when>

      <!-- If not: if the value of $node before the first call to resolveNameInModule is not types,
       go up one level -->
      <xsl:when test="local-name($beforeRecursiveCallNode/self::*)!='types' and local-name($beforeRecursiveCallNode/self::*)!='included'">
          <xsl:call-template name="resolveNameRecursive">
            <xsl:with-param name="ind" select="$ind"/>
            <xsl:with-param name="nameToResolve" select="$nameToResolve"/>
            <xsl:with-param name="newTypeName" select="$newTypeName"/>
            <xsl:with-param name="node" select="$beforeRecursiveCallNode/parent::*"/>
            <xsl:with-param name="path" select="$beforeRecursiveCallPath"/>
            <xsl:with-param name="isTypedef" select="$isTypedef"/>
            <xsl:with-param name="isConstant" select="$isConstant"/>
            <xsl:with-param name="initialNameToResolve" select="$initialNameToResolve"/>
            <xsl:with-param name="checkOnly" select="$checkOnly"/>
          </xsl:call-template>
      </xsl:when>

      <xsl:otherwise>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- resolveNameRecursive is called from resolveName template and search recursively
  for the correct type that match the nameToResolve in the given path -->
  <xsl:template name="resolveNameRecursive">
    <xsl:param name="ind"/>
    <xsl:param name="nameToResolve"/>
    <xsl:param name="newTypeName"/>
    <xsl:param name="path"/>
    <xsl:param name="node"/>
    <xsl:param name="isTypedef"/>
    <xsl:param name="isConstant"/>
    <xsl:param name="initialNameToResolve"/>
    <xsl:param name="checkOnly" select="'false'"/>

    <xsl:choose>
      <!-- First, if the scoped type is inside a module node ($path is not null), check if
           the scoped type is descendant of the current node -->
      <xsl:when test="$path and $path!='' and $node/module/descendant::*[@name=$nameToResolve]">
        <xsl:call-template name="resolveNameInModule">
          <xsl:with-param name="ind" select="$ind"/>
          <xsl:with-param name="nameToResolve" select="$nameToResolve"/>
          <xsl:with-param name="newTypeName" select="$newTypeName"/>
          <xsl:with-param name="node" select="$node"/>
          <xsl:with-param name="path" select="$path"/>
          <xsl:with-param name="beforeRecursiveCallNode" select="$node"/>
          <xsl:with-param name="beforeRecursiveCallPath" select="$path"/>
          <xsl:with-param name="isTypedef" select="$isTypedef"/>
          <xsl:with-param name="isConstant" select="$isConstant"/>
          <xsl:with-param name="initialNameToResolve" select="$initialNameToResolve"/>
          <xsl:with-param name="checkOnly" select="$checkOnly"/>
        </xsl:call-template>
      </xsl:when>

      <!-- If not, we check if scoped type is direct child of the current node  -->
      <xsl:when test="(not($path) or $path='') and $node/child::*[@name=$nameToResolve]">
        <xsl:for-each select="$node/child::*[@name=$nameToResolve]">                     
        <xsl:if test="$checkOnly = 'false'">
            <xsl:choose>
              <xsl:when test="$isTypedef='true'">
                <xsl:choose>
                  <xsl:when test="local-name(.)='struct' or local-name(.)='valuetype'">
                    <xsl:call-template name="typedefStruct">
                      <xsl:with-param name="ind" select="$ind"/>
                      <xsl:with-param name="typeDefName" select="$newTypeName"/>
                      <xsl:with-param name="initialNameToResolve" select="$initialNameToResolve"/>
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:when test="local-name(.)='enum'">
                    <xsl:call-template name="typedefEnum">
                      <xsl:with-param name="ind" select="$ind"/>
                      <xsl:with-param name="typeDefName" select="$newTypeName"/>
                      <xsl:with-param name="initialNameToResolve" select="$initialNameToResolve"/>
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:when test="local-name(.)='union'">
                    <xsl:call-template name="typedefUnion">
                      <xsl:with-param name="ind" select="$ind"/>
                      <xsl:with-param name="typeDefName" select="$newTypeName"/>
                      <xsl:with-param name="initialNameToResolve" select="$initialNameToResolve"/>
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:when test="@arrayDimensions and @arrayDimensions!=''">
                    <xsl:call-template name="typedefTypedefArray">
                      <xsl:with-param name="ind" select="$ind"/>
                      <xsl:with-param name="typeDefName" select="$newTypeName"/>
                      <xsl:with-param name="initialNameToResolve" select="$initialNameToResolve"/>
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:when test="@sequenceMaxLength and @sequenceMaxLength!=''">
                    <xsl:call-template name="typedefTypedefSequence">
                      <xsl:with-param name="ind" select="$ind"/>
                      <xsl:with-param name="typeDefName" select="$newTypeName"/>
                      <xsl:with-param name="initialNameToResolve" select="$initialNameToResolve"/>
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:when test="@type='short' or @type='double' or @type='boolean' or @type='float'  or @type='long' or @type='unsignedShort' or @type='unsignedLong' or @type='octet'  or @type='longLong' or @type='unsignedLongLong' or @type='wchar' or @type='longDouble' or @type='char' or @type='string'  or @type='wstring'">
                    <xsl:call-template name="typedefTypedefPrimitive">
                      <xsl:with-param name="ind" select="$ind"/>
                      <xsl:with-param name="typeDefName" select="$newTypeName"/>
                      <xsl:with-param name="initialNameToResolve" select="$initialNameToResolve"/>
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:when test="local-name(.)='typedef'">
                    <xsl:variable name="typeDefTypePath">
                      <xsl:call-template name="changeDotsForSlash">
                        <xsl:with-param name="nameToResolve" select="@nonBasicTypeName"/>
                      </xsl:call-template>
                    </xsl:variable>

                    <xsl:variable name="typeDefTypeName">
                      <xsl:call-template name="getTypeNameFromPath">
                        <xsl:with-param name="nameToResolve" select="$typeDefTypePath"/>
                      </xsl:call-template>
                    </xsl:variable>

                    <xsl:variable name="modulesPath">
                      <xsl:call-template name="getPathWithoutTypeName">
                        <xsl:with-param name="fullPath" select="$typeDefTypePath"/>
                      </xsl:call-template>
                    </xsl:variable>

                    <xsl:call-template name="resolveNameRecursive">
                      <xsl:with-param name="ind" select="$ind"/>
                      <xsl:with-param name="nameToResolve" select="$typeDefTypeName"/>
                      <xsl:with-param name="newTypeName" select="$newTypeName"/>
                      <xsl:with-param name="node" select="."/>
                      <xsl:with-param name="path" select="$modulesPath"/>
                      <xsl:with-param name="isTypedef" select="$isTypedef"/>
                      <xsl:with-param name="isConstant" select="$isConstant"/>
                      <xsl:with-param name="checkOnly" select="$checkOnly"/>
                    </xsl:call-template>
                  </xsl:when>
                </xsl:choose>
              </xsl:when>
              <xsl:when test="$isConstant='true'">
                <xsl:value-of select="@value"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:if test="local-name(.)!='forward_dcl'">
                  <xsl:call-template name="resolveQualifiedName"/>
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
        </xsl:if>

        <xsl:if test="$checkOnly = 'true'">
            <xsl:text>true</xsl:text>
        </xsl:if>

        </xsl:for-each>
      </xsl:when>

      <!-- Enums as constants -->
      <xsl:when test="(not($path) or $path='') and $isConstant='true' and $node/enum/enumerator[@name=$nameToResolve]">
        <xsl:if test="$checkOnly = 'false'">
          <xsl:call-template name="getEnumValue">
              <xsl:with-param name="enum" select="$node/enum[enumerator/@name=$nameToResolve]"/>
              <xsl:with-param name="enumeratorName" select="$nameToResolve"/>                        
          </xsl:call-template>
        </xsl:if>

        <xsl:if test="$checkOnly = 'true'">
            <xsl:text>true</xsl:text>
        </xsl:if>
      </xsl:when>

      <!-- If not, check if we are in the types node -->
      <xsl:when test="name($node) = 'types'">
        <!-- Look for the scoped type inside each included node -->
        <!-- We do not have to look in the type node because we already did it -->
        <xsl:for-each select="$node//included[(./descendant::*/@name)=$nameToResolve]">
          <xsl:call-template name="resolveNameRecursive">
            <xsl:with-param name="ind" select="$ind"/>
            <xsl:with-param name="nameToResolve" select="$nameToResolve"/>
            <xsl:with-param name="newTypeName" select="$newTypeName"/>
            <xsl:with-param name="node" select="."/>
            <xsl:with-param name="path" select="$path"/>
            <xsl:with-param name="isTypedef" select="$isTypedef"/>
            <xsl:with-param name="isConstant" select="$isConstant"/>
            <xsl:with-param name="initialNameToResolve" select="$initialNameToResolve"/>
            <xsl:with-param name="checkOnly" select="$checkOnly"/>
          </xsl:call-template>
        </xsl:for-each>
      </xsl:when>

      <!-- If not, go up to the parent node of the current one -->
      <!-- We only go up if the node is different than included -->
      <xsl:when test="name($node) != 'included'">
        <xsl:call-template name="resolveNameRecursive">
          <xsl:with-param name="ind" select="$ind"/>
          <xsl:with-param name="nameToResolve" select="$nameToResolve"/>
          <xsl:with-param name="newTypeName" select="$newTypeName"/>
          <xsl:with-param name="node" select="$node/parent::*"/>
          <xsl:with-param name="path" select="$path"/>
          <xsl:with-param name="isTypedef" select="$isTypedef"/>
          <xsl:with-param name="isConstant" select="$isConstant"/>
          <xsl:with-param name="initialNameToResolve" select="$initialNameToResolve"/>
          <xsl:with-param name="checkOnly" select="$checkOnly"/>
        </xsl:call-template>
      </xsl:when>

      <xsl:otherwise/>
    </xsl:choose>
  </xsl:template>


  <!-- resolveName template search for the correct type that match the typeDefType.
        When isTypedef is true, it returns the correct XSD definition for an
        enum, valuetype or struct typedef.
        When isConstant is true, it returns the correct value for that constant.
        Else, it returns the qualified name of the type in typeDefType -->
  <xsl:template name="resolveName">
    <xsl:param name="ind"/>
    <xsl:param name="typeDefName"/>
    <xsl:param name="typeDefType"/>
    <xsl:param name="isTypedef"/>
    <xsl:param name="isConstant"/>

    <xsl:variable name="typeDefTypePath">
      <xsl:call-template name="changeDotsForSlash">
        <xsl:with-param name="nameToResolve" select="$typeDefType"/>
      </xsl:call-template>
    </xsl:variable>

    <!--<xsl:comment>DEBUG1: <xsl:value-of select="$typeDefName"/>
      DEBUG2: <xsl:value-of select="$typeDefType"/>
      DEBUG3: <xsl:value-of select="$typeDefTypePath"/></xsl:comment>-->

    <xsl:variable name="typeDefTypeName">
      <xsl:call-template name="getTypeNameFromPath">
        <xsl:with-param name="nameToResolve" select="$typeDefTypePath"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="modulesPath">
      <xsl:call-template name="getPathWithoutTypeName">
        <xsl:with-param name="fullPath" select="$typeDefTypePath"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="@resolveName='false' and $isTypedef!='true' and $isConstant!='true'">
        <xsl:value-of select="$typeDefTypeName"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$isConstant!='true'">         
          <xsl:variable name="existsName">
            <xsl:call-template name="resolveNameRecursive">
              <xsl:with-param name="ind" select="$ind"/>
              <xsl:with-param name="nameToResolve" select="$typeDefTypeName"/>
              <xsl:with-param name="newTypeName" select="$typeDefName"/>
              <xsl:with-param name="node" select="."/>
              <xsl:with-param name="path" select="$modulesPath"/>
              <xsl:with-param name="isTypedef" select="$isTypedef"/>
              <xsl:with-param name="isConstant" select="$isConstant"/>
              <xsl:with-param name="checkOnly" select="'true'"/>
            </xsl:call-template>
          </xsl:variable>

          <xsl:if test="not(contains($existsName,'true'))">
              <xsl:if test="$modulesPath != ''">
                  <xsl:variable name="cppPath">
                      <xsl:call-template name="slashToCppName">
                        <xsl:with-param name="nameToResolve" select="$modulesPath"/>
                      </xsl:call-template>
                  </xsl:variable>
                  <xsl:message terminate="yes"><xsl:value-of select="concat($cppPath,'::',$typeDefTypeName)"/><xsl:text> not found</xsl:text></xsl:message>
              </xsl:if>
              <xsl:if test="$modulesPath = ''">
                  <xsl:message terminate="yes"><xsl:value-of select="$typeDefTypeName"/><xsl:text> not found</xsl:text></xsl:message>
              </xsl:if>
          </xsl:if>
        </xsl:if>

        <xsl:call-template name="resolveNameRecursive">
          <xsl:with-param name="ind" select="$ind"/>
          <xsl:with-param name="nameToResolve" select="$typeDefTypeName"/>
          <xsl:with-param name="newTypeName" select="$typeDefName"/>
          <xsl:with-param name="node" select="."/>
          <xsl:with-param name="path" select="$modulesPath"/>
          <xsl:with-param name="isTypedef" select="$isTypedef"/>
          <xsl:with-param name="isConstant" select="$isConstant"/>
          <xsl:with-param name="checkOnly" select="'false'"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- resolveDimensions template - Resolve recursively the dimensions of an
       array, replacing constant names for their value -->
  <xsl:template name="resolveDimensions">
    <xsl:param name="arrayDimensions"/>
    <xsl:param name="resolvedDimensions"/>

    <xsl:variable name="newDimension">
      <xsl:value-of select="substring-before($arrayDimensions,',')"/>
    </xsl:variable>

    <xsl:variable name="isNumber">
      <xsl:call-template name="isNumber">
        <xsl:with-param name="str" select="$newDimension"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="newResolvedDimensions">
      <xsl:choose>
        <xsl:when test="$isNumber='true'">
          <xsl:value-of select="concat($resolvedDimensions,$newDimension)"/>
        </xsl:when>
        <xsl:otherwise>

          <xsl:variable name="tempNum">
            <xsl:call-template name="resolveConstantValue">
              <xsl:with-param name="constantName" select="concat('(',$newDimension,')')"/>
            </xsl:call-template>
          </xsl:variable>

          <xsl:variable name="newResolvedDim">
            <xsl:value-of select="mathParser:resolveMathExpression($tempNum)"/>
          </xsl:variable>

          <xsl:value-of select="concat($resolvedDimensions,$newResolvedDim)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="substring-after($arrayDimensions,',')">
        <xsl:call-template name="resolveDimensions">
          <xsl:with-param name="arrayDimensions" select="substring-after($arrayDimensions,',')"/>
          <xsl:with-param name="resolvedDimensions" select="concat($newResolvedDimensions,',')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat($newResolvedDimensions,',')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- reverseDimensions template - This template is necessary due to the way
       that nested arrays are ordered in XSD -->
  <xsl:template name="reverseDimensions">
    <xsl:param name="arrayDimensions"/>

    <xsl:choose>
      <xsl:when test="substring-after($arrayDimensions,',')!=''">
        <xsl:variable name="reversedDimensions">
          <xsl:call-template name="reverseDimensions">
            <xsl:with-param name="arrayDimensions" select="substring-after($arrayDimensions,',')"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="concat($reversedDimensions,substring-before($arrayDimensions,','),',')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$arrayDimensions"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- sequence template -->
  <xsl:template name="sequence">
    <xsl:param name="ind"/>
    <xsl:param name="module"/>
    <xsl:param name="childArrayName"/>
    <xsl:param name="isDeclarationOfNestedArrays"/>

    <xsl:variable name="name">
      <xsl:value-of select="concat($module,@name)"/>
    </xsl:variable>

    <xsl:call-template name="printBR">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
    <xsd:complexType>
      <xsl:attribute name="name">
        <xsl:choose>
          <xsl:when test="$childArrayName and $childArrayName!=''">
            <xsl:value-of select="string($childArrayName)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="string($name)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind+1"/>
      </xsl:call-template>
      <xsd:sequence>
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind+2"/>
        </xsl:call-template>
        <xsd:element>
          <xsl:attribute name="name">item</xsl:attribute>
          <xsl:attribute name="minOccurs">0</xsl:attribute>
          <xsl:call-template name="solveSequenceLength">
            <xsl:with-param name="ind" select="$ind+3"/>
          </xsl:call-template>
          <xsl:call-template name="solveType">
            <xsl:with-param name="ind" select="$ind+3"/>
          </xsl:call-template>
          <xsl:if test="((@type='string' or @type='wstring') and @stringMaxLength and @stringMaxLength!='' and @stringMaxLength!='-1')">
            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind+2"/>
            </xsl:call-template>
          </xsl:if>
        </xsd:element>
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind+1"/>
        </xsl:call-template>
      </xsd:sequence>
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind"/>
      </xsl:call-template>
    </xsd:complexType>
    <xsl:call-template name="processDirectives">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
  </xsl:template>

  <!-- getNumberOfNestedArraySeq template -->
  <xsl:template name="getNumberOfNestedArraySeq">
    <xsl:param name="arrayDimensions"/>
    <xsl:param name="currentCount"/>
    <xsl:param name="sequenceMaxLength"/>

    <xsl:variable name="dimensions">
      <xsl:value-of select="substring-after($arrayDimensions,',')"/>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$dimensions and $dimensions!=''">
        <xsl:call-template name="getNumberOfNestedArraySeq">
          <xsl:with-param name="arrayDimensions" select="$dimensions"/>
          <xsl:with-param name="currentCount" select="$currentCount+1"/>
          <xsl:with-param name="sequenceMaxLength" select="$sequenceMaxLength"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$sequenceMaxLength and $sequenceMaxLength!=''">
        <xsl:value-of select="$currentCount+1"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$currentCount"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- solveExplicitArrayOrSequenceName template -->
  <xsl:template name="solveExplicitArrayOrSequenceName">
    <xsl:param name="arrayDimensions"/>
    <xsl:param name="sequenceMaxLength"/>
    <xsl:param name="type"/>

    <xsl:variable name="dimensions">
      <xsl:value-of select="substring-before($arrayDimensions,',')"/>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$dimensions and $dimensions!=''">
        <xsl:value-of select="'ArrayOf'"/>
        <xsl:call-template name="solveExplicitArrayOrSequenceName">
          <xsl:with-param name="arrayDimensions" select="substring-after($arrayDimensions,',')"/>
          <xsl:with-param name="type" select="$type"/>
          <xsl:with-param name="sequenceMaxLength" select="$sequenceMaxLength"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$sequenceMaxLength and $sequenceMaxLength!=''">
        <xsl:value-of select="'SequenceOf'"/>
        <xsl:value-of select="$type"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$type"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- solveNestedArrayOrSequenceMember template -->
  <xsl:template name="solveNestedArrayOrSequenceMember">
    <xsl:param name="ind"/>
    <xsl:param name="arrayDimensions"/>
    <xsl:param name="sequenceMaxLength"/>
    <xsl:param name="complexTypeName"/>
    <xsl:param name="nestedElementsCount"/>


    <xsl:variable name="nestedElements">
      <xsl:choose>
        <xsl:when test="$nestedElementsCount and $nestedElementsCount!=''">
          <xsl:value-of select="$nestedElementsCount"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="getNumberOfNestedArraySeq">
            <xsl:with-param name="arrayDimensions" select="$arrayDimensions"/>
            <xsl:with-param name="currentCount" select="0"/>
            <xsl:with-param name="sequenceMaxLength" select="$sequenceMaxLength"/>
          </xsl:call-template>    
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:choose>

      <xsl:when test="$arrayDimensions and substring-before($arrayDimensions,',')!=''">

        <xsl:variable name="newDim">
          <xsl:value-of select="substring-before($arrayDimensions,',')"/>
        </xsl:variable>

        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind"/>
        </xsl:call-template>

        <xsd:complexType>

          <xsl:if test="$complexTypeName and $complexTypeName!=''">
            <xsl:attribute name="name">
              <xsl:value-of select="$complexTypeName"/>
            </xsl:attribute>
          </xsl:if>

          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind+1"/>
          </xsl:call-template>

          <xsd:sequence>

            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind+2"/>
            </xsl:call-template>
            <xsd:element>
              <xsl:attribute name="name">
                <xsl:choose>
                  <xsl:when test="$nestedElements='0'">
                    <xsl:value-of select="'item'"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="concat('item',$nestedElements)"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
              <xsl:attribute name="minOccurs">
                <xsl:value-of select="$newDim"/>
              </xsl:attribute>
              <xsl:attribute name="maxOccurs">
                <xsl:value-of select="$newDim"/>
              </xsl:attribute>

              <xsl:call-template name="solveNestedArrayOrSequenceMember">
                <xsl:with-param name="ind" select="$ind+3"/>
                <xsl:with-param name="arrayDimensions" select="substring-after($arrayDimensions,',')"/>
                <xsl:with-param name="sequenceMaxLength" select="$sequenceMaxLength"/>
                <xsl:with-param name="nestedElementsCount" select="$nestedElements - 1"/>
              </xsl:call-template>

              <xsl:if test="$nestedElements!=0 or ((@type='string' or @type='wstring') and @stringMaxLength and @stringMaxLength!='' and @stringMaxLength!='-1')">
                <xsl:call-template name="printBR">
                  <xsl:with-param name="ind" select="$ind+2"/>
                </xsl:call-template>
              </xsl:if>
            </xsd:element>

            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind+1"/>
            </xsl:call-template>
          </xsd:sequence>

          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind"/>
          </xsl:call-template>
        </xsd:complexType>
      </xsl:when>
      <xsl:when test="$sequenceMaxLength and $sequenceMaxLength!=''">

        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind"/>
        </xsl:call-template>
        <xsd:complexType>

          <xsl:if test="$complexTypeName and $complexTypeName!=''">
            <xsl:attribute name="name">
              <xsl:value-of select="$complexTypeName"/>
            </xsl:attribute>
          </xsl:if>

          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind+1"/>
          </xsl:call-template>

          <xsd:sequence>

            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind+2"/>
            </xsl:call-template>
            <xsd:element>
              <xsl:attribute name="name">
                <xsl:choose>
                  <xsl:when test="$nestedElements='0'">
                    <xsl:value-of select="'item'"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="concat('item',$nestedElements)"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
              <xsl:attribute name="minOccurs">0</xsl:attribute>
              <xsl:attribute name="maxOccurs">
                <xsl:choose>
                  <xsl:when test="$sequenceMaxLength and $sequenceMaxLength!='-1'">
                    <xsl:value-of select="$sequenceMaxLength"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="'unbounded'"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>

              <xsl:call-template name="solveType">
                <xsl:with-param name="ind" select="$ind+4"/>
              </xsl:call-template>

              <xsl:call-template name="printBR">
                <xsl:with-param name="ind" select="$ind+3"/>
              </xsl:call-template>
            </xsd:element>

            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind+1"/>
            </xsl:call-template>
          </xsd:sequence>

          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind"/>
          </xsl:call-template>
        </xsd:complexType>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="solveType">
          <xsl:with-param name="ind" select="$ind"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- solveStringLength template -->
  <xsl:template name="solveStringLength">
    <xsl:param name="ind"/>

    <xsl:variable name="maxLength">
      <xsl:if test="@stringMaxLength and @stringMaxLength!='' and @stringMaxLength!='-1'">
        <xsl:value-of select="@stringMaxLength"/>
      </xsl:if>
    </xsl:variable>

    <xsl:variable name="isNumber">
      <xsl:call-template name="isNumber">
        <xsl:with-param name="str" select="$maxLength"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$isNumber='true'">
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind"/>
        </xsl:call-template>
        <xsd:maxLength>
          <xsl:attribute name="value">
            <xsl:value-of select="$maxLength"/>
          </xsl:attribute>
          <xsl:attribute name="fixed">true</xsl:attribute>
        </xsd:maxLength>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$maxLength and $maxLength!=''">
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind"/>
          </xsl:call-template>
          <xsd:maxLength>
            <xsl:variable name="tempNum">
              <xsl:call-template name="resolveConstantValue">
                <xsl:with-param name="constantName" select="concat('(',$maxLength,')')"/>
              </xsl:call-template>
            </xsl:variable>
            <xsl:attribute name="value">
              <xsl:value-of select="mathParser:resolveMathExpression($tempNum)"/>
            </xsl:attribute>
            <xsl:attribute name="fixed">true</xsl:attribute>
          </xsd:maxLength>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- solveSequenceLength template -->
  <xsl:template name="solveSequenceLength">
    <xsl:param name="ind"/>

    <xsl:variable name="maxLength">
      <xsl:if test="@sequenceMaxLength and @sequenceMaxLength!='' and @sequenceMaxLength!='-1'">
        <xsl:value-of select="@sequenceMaxLength"/>
      </xsl:if>
    </xsl:variable>

    <xsl:variable name="isNumber">
      <xsl:call-template name="isNumber">
        <xsl:with-param name="str" select="$maxLength"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$isNumber='true'">
        <xsl:attribute name="maxOccurs">
          <xsl:value-of select="$maxLength"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:when test="$maxLength and $maxLength!=''">
        <xsl:variable name="tempNum">
          <xsl:call-template name="resolveConstantValue">
            <xsl:with-param name="constantName" select="concat('(',$maxLength,')')"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:attribute name="maxOccurs">
          <xsl:value-of select="mathParser:resolveMathExpression($tempNum)"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="maxOccurs">unbounded</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- solveType template -->
  <xsl:template name="solveType">
    <xsl:param name="ind"/>
    <xsl:param name="isTypedef"/>
    <xsl:param name="isTypedefStruct" select="'false'"/>
    <xsl:param name="caseNode"/>

    <xsl:choose>
      <xsl:when test="@type='short' or @type='double' or @type='boolean' or @type='float'">
        <xsl:call-template name="type">
          <xsl:with-param name="ind" select="$ind"/>
          <xsl:with-param name="isTypedef" select="$isTypedef"/>
          <xsl:with-param name="isTypedefStruct" select="$isTypedefStruct"/>
          <xsl:with-param name="type" select="string(concat('xsd:',@type))"/>
          <xsl:with-param name="caseNode" select="$caseNode"/>
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="@type='long'">
        <xsl:call-template name="type">
          <xsl:with-param name="ind" select="$ind"/>
          <xsl:with-param name="isTypedef" select="$isTypedef"/>
          <xsl:with-param name="isTypedefStruct" select="$isTypedefStruct"/>
          <xsl:with-param name="type">xsd:int</xsl:with-param>
          <xsl:with-param name="caseNode" select="$caseNode"/>
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="@type='unsignedShort'">
        <xsl:call-template name="type">
          <xsl:with-param name="ind" select="$ind"/>
          <xsl:with-param name="isTypedef" select="$isTypedef"/>
          <xsl:with-param name="type">xsd:unsignedShort</xsl:with-param>
          <xsl:with-param name="isTypedefStruct" select="$isTypedefStruct"/>
          <xsl:with-param name="caseNode" select="$caseNode"/>
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="@type='unsignedLong'">
        <xsl:call-template name="type">
          <xsl:with-param name="ind" select="$ind"/>
          <xsl:with-param name="isTypedef" select="$isTypedef"/>
          <xsl:with-param name="type">xsd:unsignedInt</xsl:with-param>
          <xsl:with-param name="isTypedefStruct" select="$isTypedefStruct"/>
          <xsl:with-param name="caseNode" select="$caseNode"/>
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="@type='octet'">
        <xsl:call-template name="type">
          <xsl:with-param name="ind" select="$ind"/>
          <xsl:with-param name="isTypedef" select="$isTypedef"/>
          <xsl:with-param name="type">xsd:unsignedByte</xsl:with-param>
          <xsl:with-param name="isTypedefStruct" select="$isTypedefStruct"/>
          <xsl:with-param name="caseNode" select="$caseNode"/>
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="@type='longLong'">
        <xsl:call-template name="type">
          <xsl:with-param name="ind" select="$ind"/>
          <xsl:with-param name="isTypedef" select="$isTypedef"/>
          <xsl:with-param name="type">xsd:long</xsl:with-param>
          <xsl:with-param name="isTypedefStruct" select="$isTypedefStruct"/>
          <xsl:with-param name="caseNode" select="$caseNode"/>
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="@type='unsignedLongLong'">
        <xsl:call-template name="type">
          <xsl:with-param name="ind" select="$ind"/>
          <xsl:with-param name="isTypedef" select="$isTypedef"/>
          <xsl:with-param name="type">xsd:unsignedLong</xsl:with-param>
          <xsl:with-param name="isTypedefStruct" select="$isTypedefStruct"/>
          <xsl:with-param name="caseNode" select="$caseNode"/>
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="@type='wchar'">
<!--        <xsl:if test="$isTypedefStruct='false'">-->
        <xsl:call-template name="type">
          <xsl:with-param name="ind" select="$ind"/>
          <xsl:with-param name="isTypedef" select="$isTypedef"/>
          <xsl:with-param name="type">dds:wchar</xsl:with-param>
          <xsl:with-param name="isTypedefStruct" select="$isTypedefStruct"/>
          <xsl:with-param name="caseNode" select="$caseNode"/>
        </xsl:call-template>
<!--        </xsl:if>-->
      </xsl:when>

      <xsl:when test="@type='char'">
<!--        <xsl:if test="$isTypedefStruct='false'">-->
        <xsl:call-template name="type">
          <xsl:with-param name="ind" select="$ind"/>
          <xsl:with-param name="isTypedef" select="$isTypedef"/>
          <xsl:with-param name="type">dds:char</xsl:with-param>
          <xsl:with-param name="isTypedefStruct" select="$isTypedefStruct"/>
          <xsl:with-param name="caseNode" select="$caseNode"/>
        </xsl:call-template>
<!--        </xsl:if>-->
      </xsl:when>

      <xsl:when test="@type='longDouble'">
        <xsl:call-template name="type">
          <xsl:with-param name="ind" select="$ind"/>
          <xsl:with-param name="isTypedef" select="$isTypedef"/>
          <xsl:with-param name="type">dds:longDouble</xsl:with-param>
          <xsl:with-param name="isTypedefStruct" select="$isTypedefStruct"/>
          <xsl:with-param name="caseNode" select="$caseNode"/>
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="@type='string' or @type='wstring'">
        <xsl:choose>
          <xsl:when test="$isTypedefStruct='true'">
          </xsl:when>
          <xsl:when test="$isTypedef='true'">
            <xsl:variable name="type">
              <xsl:value-of select="@type"/>
            </xsl:variable>
            <xsl:call-template name="type">
              <xsl:with-param name="ind" select="$ind"/>
              <xsl:with-param name="isTypedef" select="$isTypedef"/>
              <xsl:with-param name="isTypedefStruct" select="$isTypedefStruct"/>
              <xsl:with-param name="type" select="$type"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="@stringMaxLength and @stringMaxLength!='' and @stringMaxLength!='-1'">
            <xsl:if test="$caseNode">
              <xsl:call-template name="processCase">
                <xsl:with-param name="ind" select="$ind"/>
                <xsl:with-param name="caseNode" select="$caseNode"/>
              </xsl:call-template>
            </xsl:if>
            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind"/>
            </xsl:call-template>
            <xsd:simpleType>
              <xsl:variable name="type">
                <xsl:value-of select="@type"/>
              </xsl:variable>
              <xsl:call-template name="type">
                <xsl:with-param name="ind" select="$ind+1"/>
                <xsl:with-param name="isTypedef" select="$isTypedef"/>
                <xsl:with-param name="type" select="$type"/>
                <xsl:with-param name="isTypedefStruct" select="$isTypedefStruct"/>
              </xsl:call-template>
              <xsl:call-template name="printBR">
                <xsl:with-param name="ind" select="$ind"/>
              </xsl:call-template>
            </xsd:simpleType>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="type">
              <xsl:value-of select="@type"/>
            </xsl:variable>
            <xsl:call-template name="type">
              <xsl:with-param name="ind" select="$ind+1"/>
              <xsl:with-param name="isTypedef" select="$isTypedef"/>
              <xsl:with-param name="type" select="$type"/>
              <xsl:with-param name="isTypedefStruct" select="$isTypedefStruct"/>
              <xsl:with-param name="caseNode" select="$caseNode"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="type">
          <xsl:value-of select="'tns:'"/>
          <xsl:call-template name="resolveName">
            <xsl:with-param name="typeDefType" select="@nonBasicTypeName"/>
            <xsl:with-param name="typeDefName" select="@name"/>
          </xsl:call-template>
        </xsl:attribute>
        <xsl:if test="$caseNode">
          <xsl:call-template name="processCase">
            <xsl:with-param name="ind" select="$ind"/>
            <xsl:with-param name="caseNode" select="$caseNode"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- solveTypeForArrays template -->
  <xsl:template name="solveTypeForArrays">
    <xsl:choose>
      <xsl:when test="@type='short'">short</xsl:when>
      <xsl:when test="@type='double'">double</xsl:when>
      <xsl:when test="@type='boolean'">boolean</xsl:when>
      <xsl:when test="@type='float'">float</xsl:when>
      <xsl:when test="@type='long'">long</xsl:when>
      <xsl:when test="@type='unsignedShort'">unsignedShort</xsl:when>
      <xsl:when test="@type='unsignedLong'">unsignedLong</xsl:when>
      <xsl:when test="@type='octet'">octet</xsl:when>
      <xsl:when test="@type='longLong'">longLong</xsl:when>
      <xsl:when test="@type='unsignedLongLong'">unsignedLongLong</xsl:when>
      <xsl:when test="@type='wchar'">wchar</xsl:when>
      <xsl:when test="@type='char'">char</xsl:when>
      <xsl:when test="@type='longDouble'">longDouble</xsl:when>
      <xsl:when test="@type='string'">string</xsl:when>
      <xsl:when test="@type='wstring'">wstring</xsl:when>
      <xsl:otherwise>
          <xsl:call-template name="cppToCsdName">
            <xsl:with-param name="nameToResolve" select="@nonBasicTypeName"/>
          </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="isPrimitiveType">
    <xsl:param name="typeName"/>
    <xsl:choose>
      <xsl:when test="$typeName='short'">yes</xsl:when>
      <xsl:when test="$typeName='double'">yes</xsl:when>
      <xsl:when test="$typeName='boolean'">yes</xsl:when>
      <xsl:when test="$typeName='float'">yes</xsl:when>
      <xsl:when test="$typeName='long'">yes</xsl:when>
      <xsl:when test="$typeName='unsignedShort'">yes</xsl:when>
      <xsl:when test="$typeName='unsignedLong'">yes</xsl:when>
      <xsl:when test="$typeName='octet'">yes</xsl:when>
      <xsl:when test="$typeName='longLong'">yes</xsl:when>
      <xsl:when test="$typeName='unsignedLongLong'">yes</xsl:when>
      <xsl:when test="$typeName='wchar'">yes</xsl:when>
      <xsl:when test="$typeName='char'">yes</xsl:when>
      <xsl:when test="$typeName='longDouble'">yes</xsl:when>
      <xsl:when test="$typeName='string'">yes</xsl:when>
      <xsl:when test="$typeName='wstring'">yes</xsl:when>
      <xsl:otherwise>no</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="getPrimitiveType">
    <xsl:param name="typeName"/>
    <xsl:choose>
      <xsl:when test="$typeName='short'">xsd:short</xsl:when>
      <xsl:when test="$typeName='double'">xsd:double</xsl:when>
      <xsl:when test="$typeName='boolean'">xsd:boolean</xsl:when>
      <xsl:when test="$typeName='float'">xsd:float</xsl:when>
      <xsl:when test="$typeName='long'">xsd:int</xsl:when>
      <xsl:when test="$typeName='unsignedShort'">xsd:unisgnedShort</xsl:when>
      <xsl:when test="$typeName='unsignedLong'">xsd:unsignedLong</xsl:when>
      <xsl:when test="$typeName='octet'">xsd:octet</xsl:when>
      <xsl:when test="$typeName='longLong'">xsd:longLong</xsl:when>
      <xsl:when test="$typeName='unsignedLongLong'">xsd:unsignedLongLong</xsl:when>
      <xsl:when test="$typeName='wchar'">dds:wchar</xsl:when>
      <xsl:when test="$typeName='char'">dds:char</xsl:when>
      <xsl:when test="$typeName='longDouble'">xsd:double</xsl:when>
      <xsl:when test="$typeName='string'">xsd:string</xsl:when>
      <xsl:when test="$typeName='wstring'">dds:wstring</xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- type template -->
  <xsl:template name="type">
    <xsl:param name="ind"/>
    <xsl:param name="isTypedef"/>
    <xsl:param name="type"/>
    <xsl:param name="isTypedefStruct" select="'false'"/>
    <xsl:param name="caseNode"/>

    <xsl:choose>
<!--      <xsl:when test="$type='char' and $isTypedefStruct='false'">
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind"/>
        </xsl:call-template>
        <xsd:restriction>
          <xsl:attribute name="base">xsd:string</xsl:attribute>
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind"/>
          </xsl:call-template>
          <xsd:length>
            <xsl:attribute name="value">1</xsl:attribute>
            <xsl:attribute name="fixed">true</xsl:attribute>
            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind"/>
            </xsl:call-template>
          </xsd:length>
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind"/>
          </xsl:call-template>
        </xsd:restriction>
      </xsl:when>
-->
      <xsl:when test="$type='string' and $isTypedefStruct='false'">

        <xsl:choose>
          <xsl:when test="$isTypedef='true' or (@stringMaxLength and @stringMaxLength!='' and @stringMaxLength!='-1')">
            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind"/>
            </xsl:call-template>
            <xsd:restriction>
              <xsl:attribute name="base">xsd:string</xsl:attribute>
              <xsl:call-template name="solveStringLength">
                <xsl:with-param name="ind" select="$ind+1"/>
              </xsl:call-template>
              <xsl:call-template name="printBR">
                <xsl:with-param name="ind" select="$ind"/>
              </xsl:call-template>
            </xsd:restriction>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="type">xsd:string</xsl:attribute>
            <xsl:if test="$caseNode">
              <xsl:call-template name="processCase">
                <xsl:with-param name="ind" select="$ind - 1"/>
                <xsl:with-param name="caseNode" select="$caseNode"/>
              </xsl:call-template>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$type='wstring' and $isTypedefStruct='false'">

        <xsl:choose>
          <xsl:when test="$isTypedef='true' or (@stringMaxLength and @stringMaxLength!='' and @stringMaxLength!='-1')">
            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind"/>
            </xsl:call-template>
            <xsd:restriction>
              <xsl:attribute name="base">dds:wstring</xsl:attribute>
              <xsl:call-template name="solveStringLength">
                <xsl:with-param name="ind" select="$ind+1"/>
              </xsl:call-template>
              <xsl:call-template name="printBR">
                <xsl:with-param name="ind" select="$ind"/>
              </xsl:call-template>
            </xsd:restriction>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="type">dds:wstring</xsl:attribute>
            <xsl:if test="$caseNode">
              <xsl:call-template name="processCase">
                <xsl:with-param name="ind" select="$ind - 1"/>
                <xsl:with-param name="caseNode" select="$caseNode"/>
              </xsl:call-template>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$isTypedef='true' and $isTypedefStruct='false'">
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind"/>
        </xsl:call-template>
        <xsd:restriction>
          <xsl:attribute name="base">
            <xsl:value-of select="$type"/>
          </xsl:attribute>
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind"/>
          </xsl:call-template>
        </xsd:restriction>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="type">
          <xsl:value-of select="$type"/>
        </xsl:attribute>
        <xsl:if test="$caseNode">
          <xsl:call-template name="processCase">
            <xsl:with-param name="ind" select="$ind"/>
            <xsl:with-param name="caseNode" select="$caseNode"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- typedefEnum template -->
  <xsl:template name="typedefEnum">
    <xsl:param name="typeDefName"/>
    <xsl:param name="ind"/>
    <xsl:param name="initialNameToResolve"/>

    <xsl:variable name="typeName">
      <xsl:choose>
        <xsl:when test="$initialNameToResolve and $initialNameToResolve!=''">
          <xsl:value-of select="$initialNameToResolve"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="resolveQualifiedName"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:call-template name="printBR">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
    <xsd:simpleType>
      <xsl:attribute name="name">
        <xsl:value-of select="$typeDefName"/>
      </xsl:attribute>
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind+1"/>
      </xsl:call-template>
      <xsd:restriction>
        <xsl:attribute name="base">
          <xsl:value-of select="concat('tns:',$typeName)"/>
        </xsl:attribute>
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind+1"/>
        </xsl:call-template>
      </xsd:restriction>
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind"/>
      </xsl:call-template>
    </xsd:simpleType>
  </xsl:template>


  <!-- typedefStruct template -->
  <xsl:template name="typedefStruct">
    <xsl:param name="typeDefName"/>
    <xsl:param name="ind"/>
    <xsl:param name="initialNameToResolve"/>

    <xsl:variable name="typeName">
      <xsl:choose>
        <xsl:when test="$initialNameToResolve and $initialNameToResolve!=''">
          <xsl:value-of select="$initialNameToResolve"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="resolveQualifiedName"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:call-template name="printBR">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
    <xsd:complexType>
      <xsl:attribute name="name">
        <xsl:value-of select="$typeDefName"/>
      </xsl:attribute>
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind+1"/>
      </xsl:call-template>
      <xsd:complexContent>
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind+2"/>
        </xsl:call-template>
        <xsd:restriction>
          <xsl:attribute name="base">
            <xsl:value-of select="concat('tns:',$typeName)"/>
          </xsl:attribute>
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind+3"/>
          </xsl:call-template>
          <xsd:sequence>
            <xsl:for-each select="./member">
              <xsl:call-template name="printBR">
                <xsl:with-param name="ind" select="$ind+4"/>
              </xsl:call-template>
              <xsd:element>
                <xsl:attribute name="name">
                  <xsl:value-of select="@name"/>
                </xsl:attribute>

                <xsl:choose>
                  <xsl:when test="(@arrayDimensions and @arrayDimensions!='') or (@sequenceMaxLength and @sequenceMaxLength!='')">
                    <xsl:attribute name="type">
                      <xsl:variable name="arrayType">
                        <xsl:call-template name="solveTypeForArrays"/>
                      </xsl:variable>
                      <xsl:value-of select="concat('tns:',../@name,'_',@name,'_')"/>
                      <xsl:call-template name="solveExplicitArrayOrSequenceName">
                        <xsl:with-param name="arrayDimensions" select="concat(@arrayDimensions,',')"/>
                        <xsl:with-param name="sequenceMaxLength" select="@sequenceMaxLength"/>
                       <xsl:with-param name="type" select="$arrayType"/>
                      </xsl:call-template>     
                    </xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:call-template name="solveType">
                      <xsl:with-param name="ind" select="$ind+5"/>
                      <xsl:with-param name="isTypedef">true</xsl:with-param>
                      <xsl:with-param name="isTypedefStruct">true</xsl:with-param>
                    </xsl:call-template>
                  </xsl:otherwise>
                </xsl:choose>

                <xsl:attribute name="minOccurs">1</xsl:attribute>
                <xsl:attribute name="maxOccurs">1</xsl:attribute>
              </xsd:element>
            </xsl:for-each>
            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind+3"/>
            </xsl:call-template>
          </xsd:sequence>
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind+2"/>
          </xsl:call-template>
        </xsd:restriction>
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind+1"/>
        </xsl:call-template>
      </xsd:complexContent>
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind"/>
      </xsl:call-template>
    </xsd:complexType>
  </xsl:template>


  <!-- typedefTypedefArray template -->
  <xsl:template name="typedefTypedefArray">
    <xsl:param name="typeDefName"/>
    <xsl:param name="ind"/>
    <xsl:param name="initialNameToResolve"/>

    <xsl:variable name="typeName">
      <xsl:choose>
        <xsl:when test="$initialNameToResolve and $initialNameToResolve!=''">
          <xsl:value-of select="$initialNameToResolve"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="resolveQualifiedName"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="nestedElements">
      <xsl:call-template name="getNumberOfNestedArraySeq">
        <xsl:with-param name="arrayDimensions" select="@arrayDimensions"/>
        <xsl:with-param name="currentCount" select="0"/>
        <xsl:with-param name="sequenceMaxLength" select="@sequenceMaxLength"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="newDimension">
      <xsl:variable name="reversedDimensions">
        <xsl:call-template name="reverseDimensions">
          <xsl:with-param name="arrayDimensions" select="string(concat(@arrayDimensions,','))"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:value-of select="substring-before($reversedDimensions,',')"/>
    </xsl:variable>

    <xsl:variable name="nestedTypeName">     
      <xsl:variable name="arrayType">
        <xsl:call-template name="solveTypeForArrays"/>
      </xsl:variable>

      <xsl:variable name="primitiveType">
        <xsl:call-template name="isPrimitiveType">
          <xsl:with-param name="typeName" select="$arrayType"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:choose>
        <xsl:when test="$primitiveType = 'yes' and $nestedElements = 0">
          <xsl:call-template name="getPrimitiveType">
            <xsl:with-param name="typeName" select="$arrayType"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="$primitiveType = 'no' and $nestedElements = 0">
          <xsl:call-template name="solveExplicitArrayOrSequenceName">
            <xsl:with-param name="arrayDimensions" select="concat(@arrayDimensions,',')"/>
            <xsl:with-param name="sequenceMaxLength" select="@sequenceMaxLength"/>
            <xsl:with-param name="type" select="$arrayType"/>
          </xsl:call-template>     
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat($typeName,'_')"/>
          <xsl:call-template name="solveExplicitArrayOrSequenceName">
            <xsl:with-param name="arrayDimensions" select="concat(@arrayDimensions,',')"/>
            <xsl:with-param name="sequenceMaxLength" select="@sequenceMaxLength"/>
            <xsl:with-param name="type" select="$arrayType"/>
          </xsl:call-template>     
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:call-template name="printBR">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
    <xsd:complexType>
      <xsl:attribute name="name">
        <xsl:value-of select="$typeDefName"/>
      </xsl:attribute>
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind+1"/>
      </xsl:call-template>
      <xsd:complexContent>
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind+2"/>
        </xsl:call-template>
        <xsd:restriction>
          <xsl:attribute name="base">
            <xsl:value-of select="concat('tns:',$typeName)"/>
          </xsl:attribute>
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind+3"/>
          </xsl:call-template>
          <xsd:sequence>

            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind+4"/>
            </xsl:call-template>
            <xsd:element>
              <xsl:attribute name="name">
                <xsl:choose>
                  <xsl:when test="$nestedElements='0'">
                    <xsl:value-of select="'item'"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="concat('item',$nestedElements)"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
              <xsl:attribute name="minOccurs">
                <xsl:value-of select="$newDimension"/>
              </xsl:attribute>
              <xsl:attribute name="maxOccurs">
                <xsl:value-of select="$newDimension"/>
              </xsl:attribute>
              <xsl:choose>
                  <xsl:when test="((@type='string' or @type='wstring') and @stringMaxLength and @stringMaxLength!='' and @stringMaxLength!='-1')">
                      <xsl:call-template name="solveType">
                        <xsl:with-param name="ind" select="$ind+5"/>
                        <xsl:with-param name="isTypedef">true</xsl:with-param>
                        <xsl:with-param name="isTypedefStruct">false</xsl:with-param>
                      </xsl:call-template>
                      <xsl:call-template name="printBR">
                        <xsl:with-param name="ind" select="$ind+4"/>
                      </xsl:call-template>
                  </xsl:when>
                  <xsl:when test="substring-before($nestedTypeName,'ArrayOf') != '' or substring-after($nestedTypeName,'ArrayOf') != ''">
                    <xsl:attribute name="type">
                        <xsl:value-of select="concat('tns:',substring-before($nestedTypeName,'ArrayOf'),substring-after($nestedTypeName,'ArrayOf'))"/>
                    </xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:attribute name="type">
                        <xsl:value-of select="$nestedTypeName"/>
                    </xsl:attribute>
                  </xsl:otherwise>
              </xsl:choose>
            </xsd:element>

            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind+3"/>
            </xsl:call-template>
          </xsd:sequence>
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind+2"/>
          </xsl:call-template>
        </xsd:restriction>
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind+1"/>
        </xsl:call-template>
      </xsd:complexContent>
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind"/>
      </xsl:call-template>
    </xsd:complexType>
  </xsl:template>

  <!-- typedefTypedefPrimitive template -->
  <xsl:template name="typedefTypedefPrimitive">
    <xsl:param name="typeDefName"/>
    <xsl:param name="ind"/>
    <xsl:param name="initialNameToResolve"/>

    <xsl:variable name="typeName">
      <xsl:choose>
        <xsl:when test="$initialNameToResolve and $initialNameToResolve!=''">
          <xsl:value-of select="$initialNameToResolve"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="resolveQualifiedName"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:call-template name="printBR">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
    <xsd:simpleType>
      <xsl:attribute name="name">
        <xsl:value-of select="$typeDefName"/>
      </xsl:attribute>
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind+1"/>
      </xsl:call-template>
      <xsd:restriction>
        <xsl:attribute name="base">
          <xsl:value-of select="concat('tns:',$typeName)"/>
        </xsl:attribute>
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind+1"/>
        </xsl:call-template>
      </xsd:restriction>
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind"/>
      </xsl:call-template>
    </xsd:simpleType>
  </xsl:template>

  <!-- typedefTypedefSequence template -->
  <xsl:template name="typedefTypedefSequence">
    <xsl:param name="typeDefName"/>
    <xsl:param name="ind"/>
    <xsl:param name="initialNameToResolve"/>

    <xsl:variable name="typeName">
      <xsl:choose>
        <xsl:when test="$initialNameToResolve and $initialNameToResolve!=''">
          <xsl:value-of select="$initialNameToResolve"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="resolveQualifiedName"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:call-template name="printBR">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
    <xsd:complexType>
      <xsl:attribute name="name">
        <xsl:value-of select="$typeDefName"/>
      </xsl:attribute>
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind+1"/>
      </xsl:call-template>
      <xsd:complexContent>
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind+2"/>
        </xsl:call-template>
        <xsd:restriction>
          <xsl:attribute name="base">
            <xsl:value-of select="concat('tns:',$typeName)"/>
          </xsl:attribute>
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind+3"/>
          </xsl:call-template>
          <xsd:sequence>

            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind+4"/>
            </xsl:call-template>
            <xsd:element>
              <xsl:attribute name="name">item</xsl:attribute>
              <xsl:attribute name="minOccurs">
                <xsl:value-of select="0"/>
              </xsl:attribute>
              <xsl:attribute name="maxOccurs">
                <xsl:choose>
                  <xsl:when test="@sequenceMaxLength and @sequenceMaxLength!='' and @sequenceMaxLength!='-1'">
                    <xsl:value-of select="@sequenceMaxLength"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="'unbounded'"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
              <xsl:choose>
                  <xsl:when test="((@type='string' or @type='wstring') and @stringMaxLength and @stringMaxLength!='' and @stringMaxLength!='-1')">
                      <xsl:call-template name="solveType">
                        <xsl:with-param name="ind" select="$ind+5"/>
                        <xsl:with-param name="isTypedef">true</xsl:with-param>
                        <xsl:with-param name="isTypedefStruct">false</xsl:with-param>
                      </xsl:call-template>
                      <xsl:call-template name="printBR">
                        <xsl:with-param name="ind" select="$ind+4"/>
                      </xsl:call-template>
                  </xsl:when>
                  <xsl:when test="@type='string'">
                      <xsl:attribute name="type">xsd:<xsl:value-of select="@type"/></xsl:attribute>
                  </xsl:when>
                  <xsl:when test="@type='wstring'">
                      <xsl:attribute name="type">dds:<xsl:value-of select="@type"/></xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                      <xsl:call-template name="solveType">
                        <xsl:with-param name="ind" select="$ind+5"/>
                        <xsl:with-param name="isTypedef">true</xsl:with-param>
                        <xsl:with-param name="isTypedefStruct">true</xsl:with-param>
                      </xsl:call-template>
                  </xsl:otherwise>
              </xsl:choose>
            </xsd:element>

            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind+3"/>
            </xsl:call-template>
          </xsd:sequence>
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind+2"/>
          </xsl:call-template>
        </xsd:restriction>
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind+1"/>
        </xsl:call-template>
      </xsd:complexContent>
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind"/>
      </xsl:call-template>
    </xsd:complexType>
  </xsl:template>


  <!-- typedefUnion template -->
  <xsl:template name="typedefUnion">
    <xsl:param name="typeDefName"/>
    <xsl:param name="ind"/>
    <xsl:param name="initialNameToResolve"/>

    <xsl:variable name="typeName">
      <xsl:choose>
        <xsl:when test="$initialNameToResolve and $initialNameToResolve!=''">
          <xsl:value-of select="$initialNameToResolve"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="resolveQualifiedName"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:call-template name="printBR">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
    <xsd:complexType>
      <xsl:attribute name="name">
        <xsl:value-of select="$typeDefName"/>
      </xsl:attribute>
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind+1"/>
      </xsl:call-template>
      <xsd:complexContent>
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind+2"/>
        </xsl:call-template>
        <xsd:restriction>
          <xsl:attribute name="base">
            <xsl:value-of select="concat('tns:',$typeName)"/>
          </xsl:attribute>

          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind+3"/>
          </xsl:call-template>
          <xsd:sequence>

            <xsl:apply-templates select="discriminator">
              <xsl:with-param name="ind" select="$ind+4"/>
            </xsl:apply-templates>
  
            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind+4"/>
            </xsl:call-template>
            <xsd:choice>
                <xsl:apply-templates select="case">
                  <xsl:with-param name="ind" select="$ind+5"/>
                </xsl:apply-templates>
              <xsl:call-template name="printBR">
                <xsl:with-param name="ind" select="$ind+4"/>
              </xsl:call-template>
            </xsd:choice>
            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind+3"/>
            </xsl:call-template>
          </xsd:sequence>
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind+2"/>
          </xsl:call-template>
        </xsd:restriction>
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind+1"/>
        </xsl:call-template>
      </xsd:complexContent>
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind"/>
      </xsl:call-template>
    </xsd:complexType>
  </xsl:template>


  <!-- changeDotsForSlash template -->
  <xsl:template name="changeDotsForSlash">
    <xsl:param name="nameToResolve"/>
    <xsl:choose>
      <xsl:when test="contains($nameToResolve,'::')">
        <xsl:call-template name="changeDotsForSlash">
          <xsl:with-param name="nameToResolve" select="concat(substring-before($nameToResolve,'::'),'/',substring-after($nameToResolve,'::'))"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($nameToResolve,'.')">
        <xsl:call-template name="changeDotsForSlash">
          <xsl:with-param name="nameToResolve" select="concat(substring-before($nameToResolve,'.'),'/',substring-after($nameToResolve,'.'))"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$nameToResolve"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- changeDotsForSlash template -->
  <xsl:template name="cppToCsdName">
    <xsl:param name="nameToResolve"/>
    <xsl:choose>
      <xsl:when test="contains($nameToResolve,'::')">
        <xsl:call-template name="cppToCsdName">
          <xsl:with-param name="nameToResolve" select="concat(substring-before($nameToResolve,'::'),'.',substring-after($nameToResolve,'::'))"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$nameToResolve"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- changeDotsForSlash template -->
  <xsl:template name="slashToCppName">
    <xsl:param name="nameToResolve"/>
    <xsl:choose>
      <xsl:when test="contains($nameToResolve,'/')">
        <xsl:call-template name="slashToCppName">
          <xsl:with-param name="nameToResolve" select="concat(substring-before($nameToResolve,'/'),'::',substring-after($nameToResolve,'/'))"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$nameToResolve"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- deParentesize template -->
  <xsl:template name="deParentesize">
    <xsl:param name="str"/>
    <xsl:choose>
      <xsl:when test="starts-with($str,'(') and substring($str,string-length($str))=')'">
        <xsl:call-template name="deParentesize">
          <xsl:with-param name="str" select="substring($str,2,string-length($str)-2)"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$str"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- getFullPath template -->
  <xsl:template name="getFullPath">
    <xsl:for-each select="ancestor-or-self::module">
      <xsl:value-of select="concat(@name,'.')"/>
    </xsl:for-each>
  </xsl:template>


  <!-- getTypeNameFromPath template-->
  <xsl:template name="getTypeNameFromPath">
    <xsl:param name="nameToResolve"/>
    <xsl:choose>
      <xsl:when test="contains($nameToResolve,'/')">
        <xsl:call-template name="getTypeNameFromPath">
          <xsl:with-param name="nameToResolve" select="substring-after($nameToResolve,'/')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($nameToResolve,'::')">
        <xsl:call-template name="getTypeNameFromPath">
          <xsl:with-param name="nameToResolve" select="substring-after($nameToResolve,'::')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($nameToResolve,'.')">
        <xsl:call-template name="getTypeNameFromPath">
          <xsl:with-param name="nameToResolve" select="substring-after($nameToResolve,'.')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$nameToResolve"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- getPathWithoutTypeName template-->
  <xsl:template name="getPathWithoutTypeName">
    <xsl:param name="fullPath"/>

    <xsl:if test="contains($fullPath,'/')">
      <xsl:value-of select="substring-before($fullPath,'/')"/>

      <xsl:variable name="nestedPath" select="substring-after($fullPath,'/')"/>

      <xsl:if test="contains($nestedPath,'/')">
          <xsl:text>/</xsl:text>
      </xsl:if>

      <xsl:call-template name="getPathWithoutTypeName">
          <xsl:with-param name="fullPath" select="$nestedPath"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>


  <!-- isNumber template -->
  <xsl:template name="isNumber">
    <xsl:param name="str"/>
    <xsl:if test="number($str)=number($str)">true</xsl:if>
  </xsl:template>


  <!-- printIndent template according to the depth -->
  <xsl:template name="printIndent">
    <xsl:param name="ind"/>
    <xsl:text>    </xsl:text>
    <xsl:if test="($ind - 1) &gt; 0">
      <xsl:call-template name="printIndent">
        <xsl:with-param name="ind" select="$ind - 1"/>
      </xsl:call-template>
    </xsl:if>
    <!--    <xsl:comment>
      <xsl:value-of select="$ind"/>
    </xsl:comment>-->
  </xsl:template>


  <!-- printBR template -->
  <xsl:template name="printBR">
    <xsl:param name="ind"/>

    <xsl:text>
</xsl:text>
    <xsl:if test="$ind &gt; 0">
      <xsl:call-template name="printIndent">
        <xsl:with-param name="ind" select="$ind"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
</xsl:transform>
