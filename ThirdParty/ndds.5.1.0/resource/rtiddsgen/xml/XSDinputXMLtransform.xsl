<?xml version="1.0"?>
<!-- 
/* $Id: XSDinputXMLtransform.xsl,v 1.6 2013/09/12 14:22:26 fernando Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
modification history:
- - - - - - - - - - -
5.0.1,15apr13,acr CODEGEN-573: generate optional attribute when a member's minOccurs is zero
                  (as per the XSD type representation spec in XTypes)
10y,09jun11,fcs CXTYPES-88: Generate XML and XSD code for new features in Phase 1
10y,17apr09,fcs Annotation support
10y,08mar09,fcs Fixed baseClass resolution
10y,22jan08,jlv Fixed a bug: Removed sequence='true' from typedef sequences.
10y,25nov08,jlv Improved external XSD validation support.
10y,21nov08,jlv Changed maxLengthSequence for sequenceMaxLength and maxLengthString for
                stringMaxLength in XML format.
                Added XSD validation support.
10y,18nov08,jlv Changed the way unions are parsed in XML. Now members are children of cases.
10y,17nov08,jlv Added nonBasic type and nonBasicTypeName attribute.
10y,16nov08,jlv Removed sequence='true', now we use maxLengthSequence='-1' for unbounded sequences.
                Changed some types name.
10y,09nov08,jlv Added changes to support WSDL
10y,08nov08,jlv Solved some bugs relative to the tns: namespace.
10y,07nov08,jlv Changed SeqOf for SequenceOf.
10y,06nov08,jlv Added support namespaces different to xsd.
10y,05nov08,jlv Added targetNamespace and tns:
10y,04nov08,jlv Added support to arrays and sequences inline declarations.
10y,03nov08,jlv Changed baseClass for xsd:extension base attribute.
10y,31oct08,jlv Changed char to dds:char. Added @ to all attributes passed as comments.
                Added a new way to identify valuetypes. Changed dimensions to arrayDimensions.
                Changed kind='sequence' to sequence='true'.
10y,30oct08,jlv Changed ' ' to ',' in dimensions attribute. Added support for xsd:schema when
                it is not the root. Changed the name of the directives. Added copyCppcli and
                copyCppcliDeclaration directives.
10y,14oct08,jlv Changed forward_dcl to forwardDclValueType/forwardDclStruct/
                forwardDclUnion. Changed rtiddstypes: to dds: . Changed maxOccurs for
                unbounded sequences (now is 'unbounded').
10y,02oct08,jlv Added some documentation.
10y,30sep08,jlv Created
-->
<xsl:transform version="1.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
               xmlns:xsd="http://www.w3.org/2001/XMLSchema"
               xmlns:tns="http://www.omg.org/IDL-Mapped/"
               xmlns:dds="http://www.omg.org/dds" 
               exclude-result-prefixes="xsd dds tns">

  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
  <xsl:strip-space elements="*"/>

  <xsl:param name="xsdValidationFile"/>
  
  <!-- Default template -->
  <xsl:template match="/">
    <xsl:apply-templates select=".//xsd:schema">
      <xsl:with-param name="ind">0</xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>


  <!-- comment() template -->
  <xsl:template match="comment()">
    <xsl:param name="ind"/>
    <xsl:if test="substring(.,1,2)=' @'">
      <xsl:choose>
        <xsl:when test="substring(.,2,string-length('@copyJava '))='@copyJava '">
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind"/>
          </xsl:call-template>
          <directive kind="copyJava">
            <xsl:value-of select="substring(.,string-length('@copyJava')+3)"/>
          </directive>
        </xsl:when>
        <xsl:when test="substring(.,2,string-length('@copyJavaBegin '))='@copyJavaBegin '">
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind"/>
          </xsl:call-template>
          <directive kind="copyJavaBegin">
            <xsl:value-of select="substring(.,string-length('@copyJavaBegin')+3)"/>
          </directive>
        </xsl:when>
        <xsl:when test="substring(.,2,string-length('@copyC '))='@copyC '">
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind"/>
          </xsl:call-template>
          <directive kind="copyC">
            <xsl:value-of select="substring(.,string-length('@copyC')+3)"/>
          </directive>
        </xsl:when>
        <xsl:when test="substring(.,2,string-length('@copyDeclaration '))='@copyDeclaration '">
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind"/>
          </xsl:call-template>
          <directive kind="copyDeclaration">
            <xsl:value-of select="substring(.,string-length('@copyDeclaration')+3)"/>
          </directive>
        </xsl:when>
        <xsl:when test="substring(.,2,string-length('@copyJavaDeclaration '))='@copyJavaDeclaration '">
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind"/>
          </xsl:call-template>
          <directive kind="copyJavaDeclaration">
            <xsl:value-of select="substring(.,string-length('@copyJavaDeclaration')+3)"/>
          </directive>
        </xsl:when>
        <xsl:when test="substring(.,2,string-length('@copyJavaDeclarationBegin '))='@copyJavaDeclarationBegin '">
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind"/>
          </xsl:call-template>
          <directive kind="copyJavaDeclarationBegin">
            <xsl:value-of select="substring(.,string-length('@copyJavaDeclarationBegin')+3)"/>
          </directive>
        </xsl:when>
        <xsl:when test="substring(.,2,string-length('@copyCDeclaration '))='@copyCDeclaration '">
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind"/>
          </xsl:call-template>
          <directive kind="copyCDeclaration">
            <xsl:value-of select="substring(.,string-length('@copyCDeclaration')+3)"/>
          </directive>
        </xsl:when>
        <xsl:when test="substring(.,2,string-length('@copyCppcli '))='@copyCppcli '">
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind"/>
          </xsl:call-template>
          <directive kind="copyCppcli">
            <xsl:value-of select="substring(.,string-length('@copyCppcli')+3)"/>
          </directive>
        </xsl:when>
        <xsl:when test="substring(.,2,string-length('@copyCppcliDeclaration '))='@copyCppcliDeclaration '">
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind"/>
          </xsl:call-template>
          <directive kind="copyCppcliDeclaration">
            <xsl:value-of select="substring(.,string-length('@copyCppcliDeclaration')+3)"/>
          </directive>
        </xsl:when>
        <xsl:when test="substring(.,2,string-length('@copy '))='@copy '">
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind"/>
          </xsl:call-template>
          <directive kind="copy">
            <xsl:value-of select="substring(.,string-length('@copy')+3)"/>
          </directive>
        </xsl:when>
      </xsl:choose>
    </xsl:if>
  </xsl:template>


  <!-- xsd:schema template -->
  <xsl:template match="xsd:schema">
    <xsl:param name="ind"/>
    <types xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
      <xsl:if test="$xsdValidationFile and $xsdValidationFile!=''">        
        <xsl:attribute name="xsi:noNamespaceSchemaLocation">
          <xsl:value-of select="$xsdValidationFile"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="*|comment()">
        <xsl:with-param name="ind" select="$ind+1"/>
      </xsl:apply-templates>
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind"/>
      </xsl:call-template>
    </types>
  </xsl:template>


  <!-- modules template -->
  <xsl:template name="modules" match="xsd:complexType[contains(@name,'.')]|xsd:simpleType[contains(@name,'.')]|//xsd:schema/xsd:element[contains(@name,'.')]">
    <xsl:param name="ind"/>
    <xsl:param name="nestedModules"/>

    <xsl:variable name="isTypedef">
      <xsl:call-template name="isTypedef">
        <xsl:with-param name="nameToResolve" select="@name"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="$isTypedef='true' or @type='dds:forwardDclValueType' or @type='dds:forwardDclStruct' or                   @type='dds:forwardDclUnion'">
      <xsl:variable name="name">
        <xsl:choose>
          <xsl:when test="$nestedModules and $nestedModules!=''">
            <xsl:value-of select="$nestedModules"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@name"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <xsl:choose>
        <xsl:when test="contains($name,'.')">
          <xsl:variable name="module">
            <xsl:value-of select="substring-before($name,'.')"/>
          </xsl:variable>

          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind"/>
          </xsl:call-template>
          <module>
            <xsl:attribute name="name">
              <xsl:value-of select="$module"/>
            </xsl:attribute>
            <xsl:call-template name="modules">
              <xsl:with-param name="ind" select="$ind+1"/>
              <xsl:with-param name="nestedModules" select="substring-after($name,'.')"/>
            </xsl:call-template>

            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind"/>
            </xsl:call-template>
          </module>
        </xsl:when>
        <xsl:otherwise>
          <xsl:if test="local-name(.)='complexType'">
            <xsl:call-template name="xsd:complexType">
              <xsl:with-param name="ind" select="$ind+1"/>
              <xsl:with-param name="nameInModule" select="$name"/>
            </xsl:call-template>
          </xsl:if>
          <xsl:if test="local-name(.)='simpleType'">
            <xsl:call-template name="xsd:simpleType">
              <xsl:with-param name="ind" select="$ind+1"/>
              <xsl:with-param name="nameInModule" select="$name"/>
            </xsl:call-template>
          </xsl:if>
          <xsl:if test="local-name(.)='element'">
            <xsl:call-template name="xsd:element">
              <xsl:with-param name="ind" select="$ind+1"/>
              <xsl:with-param name="nameInModule" select="$name"/>
            </xsl:call-template>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>


  <!-- xsd:complexType template -->
  <xsl:template match="xsd:complexType" name="xsd:complexType">
    <xsl:param name="ind"/>
    <xsl:param name="nameInModule"/>

    <xsl:variable name="name">
      <xsl:choose>
        <xsl:when test="$nameInModule and $nameInModule!=''">
          <xsl:value-of select="$nameInModule"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@name"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="isValuetype">
      <xsl:choose>
        <xsl:when test="xsd:attribute/@name='id'">
          <xsl:value-of select="'true'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="isValuetype"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="isStruct">
        <xsl:choose>
          <xsl:when test="xsd:sequence/xsd:element">
            <xsl:value-of select="'true'"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="isStruct"/>
          </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="xsd:sequence/xsd:choice">
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind"/>
        </xsl:call-template>
        <union>
          <xsl:attribute name="name">
            <xsl:value-of select="$name"/>
          </xsl:attribute>
          <xsl:call-template name="matchDirectives"/>
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind+1"/>
          </xsl:call-template>
          <discriminator>
            <xsl:for-each select="xsd:sequence/xsd:element">
              <xsl:call-template name="solveType"/>
            </xsl:for-each>
          </discriminator>
          <xsl:for-each select="xsd:sequence/xsd:choice/xsd:element">


           <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind+1"/>
            </xsl:call-template>
            <case>

              <xsl:if test="./xsd:annotation">
                  <xsl:for-each select=".//case">
                      <caseDiscriminator>
                        <xsl:attribute name="value">
                          <xsl:value-of select="."/>
                        </xsl:attribute>
                      </caseDiscriminator>
                  </xsl:for-each>
              </xsl:if>

              <xsl:if test="not(./xsd:annotation)">
                  <xsl:for-each select="preceding-sibling::comment()[1]">
                    <xsl:call-template name="solveUnionCases">
                      <xsl:with-param name="ind" select="$ind+3"/>
                      <xsl:with-param name="str" select="substring-before(substring-after(.,'case '),' ')"/>
                    </xsl:call-template>
                  </xsl:for-each>
              </xsl:if>

              <xsl:call-template name="printBR">
                <xsl:with-param name="ind" select="$ind+2"/>
              </xsl:call-template>
              <member>
                <xsl:attribute name="name">
                  <xsl:value-of select="@name"/>
                </xsl:attribute>

                <xsl:variable name="tmpType">                    
                  <xsl:choose>
                    <xsl:when test="contains(@type,':')">
                      <xsl:value-of select="substring-after(@type,':')"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="@type"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:variable>

                <xsl:choose>
                  <!-- Case Array or Sequence -->
                  <xsl:when test="//xsd:schema/xsd:complexType[starts-with(./xsd:sequence/xsd:element/@name,'item')]/@name=$tmpType">
                    <xsl:call-template name="solveArrayOrSequenceMember"/>
                  </xsl:when>

                  <!-- Case Nested Array or Sequence -->
                  <xsl:when test="starts-with(./xsd:complexType/xsd:sequence/xsd:element/@name,'item')">
                    <xsl:call-template name="solveNestedArrayOrSequenceMember"/>
                  </xsl:when>

                  <xsl:otherwise>
                    <xsl:call-template name="solveType"/>
                    <xsl:call-template name="solveLengthString"/>
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:call-template name="matchDirectives"/>
                <xsl:call-template name="printBR">
                  <xsl:with-param name="ind" select="$ind+2"/>
                </xsl:call-template>
              </member>

              <xsl:call-template name="printBR">
                <xsl:with-param name="ind" select="$ind+2"/>
              </xsl:call-template>
            </case>
          </xsl:for-each>
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind"/>
          </xsl:call-template>
        </union>
      </xsl:when>
      <xsl:when test="xsd:sequence/xsd:element[starts-with(@name,'item')]">
        <xsl:choose>
          <xsl:when test="xsd:sequence/xsd:element/@maxOccurs=xsd:sequence/xsd:element/@minOccurs">

            <xsl:variable name="isTypedef">
              <xsl:call-template name="isTypedef">
                <xsl:with-param name="nameToResolve" select="@name"/>
              </xsl:call-template>
            </xsl:variable>

            <xsl:if test="$isTypedef='true'">

              <xsl:if test="local-name(parent::*)='schema'">
                <xsl:call-template name="printBR">
                  <xsl:with-param name="ind" select="$ind"/>
                </xsl:call-template>
                <typedef>
                  <xsl:attribute name="name">
                    <xsl:value-of select="$name"/>
                  </xsl:attribute>

                  <xsl:choose>
                    <!-- Current item has nested arrays or sequences -->
                    <xsl:when test="starts-with(./xsd:sequence/xsd:element/xsd:complexType/xsd:sequence/xsd:element/@name,'item')">
                      <xsl:call-template name="solveNestedArrayOrSequenceMember"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:variable name="tmpType">                  
                        <xsl:choose>
                          <xsl:when test="contains(xsd:sequence/xsd:element/@type,':')">
                            <xsl:value-of select="substring-after(xsd:sequence/xsd:element/@type,':')"/>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:value-of select="xsd:sequence/xsd:element/@type"/>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:variable>
                      <xsl:call-template name="resolveArray">
                        <xsl:with-param name="nameToResolve" select="$tmpType"/>
                        <xsl:with-param name="resolvedDimensions" select="xsd:sequence/xsd:element/@maxOccurs"/>
                      </xsl:call-template>
                    </xsl:otherwise>
                  </xsl:choose>

                  <xsl:call-template name="matchDirectives"/>
                </typedef>
              </xsl:if>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>

            <xsl:variable name="isTypedef">
              <xsl:call-template name="isTypedef">
                <xsl:with-param name="nameToResolve" select="@name"/>
              </xsl:call-template>
            </xsl:variable>

            <xsl:if test="$isTypedef='true'">
              <xsl:if test="local-name(parent::*)='schema'">
                <xsl:call-template name="printBR">
                  <xsl:with-param name="ind" select="$ind"/>
                </xsl:call-template>
                <typedef>
                  <xsl:attribute name="name">
                    <xsl:value-of select="$name"/>
                  </xsl:attribute>
                  <xsl:for-each select="xsd:sequence/xsd:element">
                    <xsl:call-template name="solveType"/>
                  </xsl:for-each>
                  <xsl:call-template name="solveLengths"/>
                  <xsl:call-template name="matchDirectives"/>
                </typedef>
              </xsl:if>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$isValuetype='true' or $isValuetype='1'">
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind"/>
        </xsl:call-template>
        <valuetype>
          <xsl:attribute name="name">
            <xsl:value-of select="$name"/>
          </xsl:attribute>

          <xsl:if test="xsd:complexContent/xsd:extension/@base and xsd:complexContent/xsd:extension/@base!=''">
            <xsl:attribute name="baseClass">
              <xsl:call-template name="changeDotsForColon">
                <xsl:with-param name="nameToResolve">
                  <xsl:choose>
                    <xsl:when test="contains(xsd:complexContent/xsd:extension/@base,':')">
                      <xsl:value-of select="substring-after(xsd:complexContent/xsd:extension/@base,':')"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="xsd:complexContent/xsd:extension/@base"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:attribute>
          </xsl:if>

          <xsl:call-template name="matchDirectives"/>

          <xsl:for-each select="xsd:sequence/xsd:element | xsd:complexContent/xsd:extension/xsd:sequence/xsd:element">
            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind+1"/>
            </xsl:call-template>
            <member>
              <xsl:if test="substring(@name,1,string-length('_ANONYMOUS_'))!='_ANONYMOUS_'">
                <xsl:attribute name="name">
                  <xsl:value-of select="@name"/>
                </xsl:attribute>
              </xsl:if>

              <xsl:if test="@minOccurs='0'">
                  <xsl:attribute name="optional">true</xsl:attribute>
              </xsl:if>
              
              <xsl:variable name="tmpType">                  
                <xsl:choose>
                  <xsl:when test="contains(@type,':')">
                    <xsl:value-of select="substring-after(@type,':')"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="@type"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:variable>

              <xsl:choose>
                <!-- Case Array or Sequence -->
                <xsl:when test="//xsd:schema/xsd:complexType[starts-with(./xsd:sequence/xsd:element/@name,'item')]/@name=$tmpType">
                  <xsl:call-template name="solveArrayOrSequenceMember"/>
                </xsl:when>

                <!-- Case Nested Array or Sequence -->
                <xsl:when test="starts-with(./xsd:complexType/xsd:sequence/xsd:element/@name,'item')">
                  <xsl:call-template name="solveNestedArrayOrSequenceMember"/>
                </xsl:when>

                <xsl:otherwise>
                  <xsl:if test="@minOccurs='0'">
                      <xsl:attribute name="optional">true</xsl:attribute>
                  </xsl:if>                
                  <xsl:call-template name="solveType"/>
                  <xsl:call-template name="solveLengthString"/>
                </xsl:otherwise>
              </xsl:choose>

              <xsl:call-template name="matchDirectives"/>
            </member>
          </xsl:for-each>
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind"/>
          </xsl:call-template>
        </valuetype>
      </xsl:when>
      <xsl:when test="$isStruct = 'true'">
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind"/>
        </xsl:call-template>
        <struct>
          <xsl:attribute name="name">
            <xsl:value-of select="$name"/>
          </xsl:attribute>

          <xsl:if test="xsd:complexContent/xsd:extension/@base and xsd:complexContent/xsd:extension/@base!=''">
            <xsl:attribute name="baseType">
              <xsl:call-template name="changeDotsForColon">
                <xsl:with-param name="nameToResolve">
                  <xsl:choose>
                    <xsl:when test="contains(xsd:complexContent/xsd:extension/@base,':')">
                      <xsl:value-of select="substring-after(xsd:complexContent/xsd:extension/@base,':')"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="xsd:complexContent/xsd:extension/@base"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:attribute>
          </xsl:if>

          <xsl:call-template name="matchDirectives"/>

          <xsl:for-each select="xsd:sequence/xsd:element | xsd:complexContent/xsd:extension/xsd:sequence/xsd:element">
            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind+1"/>
            </xsl:call-template>
            <member>
              <xsl:if test="substring(@name,1,string-length('_ANONYMOUS_'))!='_ANONYMOUS_'">
                <xsl:attribute name="name">
                  <xsl:value-of select="@name"/>
                </xsl:attribute>
              </xsl:if>

              <xsl:if test="@minOccurs='0'">
                    <xsl:attribute name="optional">true</xsl:attribute>
              </xsl:if>
                  
              <xsl:variable name="tmpType">
                <xsl:choose>
                  <xsl:when test="contains(@type,':')">
                    <xsl:value-of select="substring-after(@type,':')"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="@type"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:variable>

              <xsl:choose>
                <!-- Case Explicit Array or Sequence -->
                <xsl:when test="//xsd:schema/xsd:complexType[starts-with(./xsd:sequence/xsd:element/@name,'item')]/@name=$tmpType">
                  <xsl:call-template name="solveArrayOrSequenceMember"/>
                </xsl:when>

                <!-- Case Nested Array or Sequence -->
                <xsl:when test="starts-with(./xsd:complexType/xsd:sequence/xsd:element/@name,'item')">
                  <xsl:call-template name="solveNestedArrayOrSequenceMember"/>
                </xsl:when>

                <xsl:otherwise>
                  <xsl:call-template name="solveType"/>
                  <xsl:call-template name="solveLengthString"/>
                </xsl:otherwise>
              </xsl:choose>

              <xsl:call-template name="matchDirectives"/>
            </member>
          </xsl:for-each>
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind"/>
          </xsl:call-template>
        </struct>
      </xsl:when>
      <xsl:when test="xsd:complexContent">
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind"/>
        </xsl:call-template>
        <typedef>
          <xsl:attribute name="name">
            <xsl:value-of select="$name"/>
          </xsl:attribute>
          <xsl:for-each select="xsd:complexContent">
            <xsl:call-template name="solveType"/>
          </xsl:for-each>
          <xsl:call-template name="matchDirectives"/>
        </typedef>
      </xsl:when>
    </xsl:choose>
  </xsl:template>


  <!-- xsd:element template -->
  <xsl:template match="xsd:element" name="xsd:element">
    <xsl:param name="ind"/>
    <xsl:param name="nameInModule"/>

    <xsl:variable name="name">
      <xsl:choose>
        <xsl:when test="$nameInModule and $nameInModule!=''">
          <xsl:value-of select="$nameInModule"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@name"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:if test="@type='dds:forwardDclValueType' or @type='dds:forwardDclStruct' or                   @type='dds:forwardDclUnion'">
      <xsl:call-template name="printBR">
        <xsl:with-param name="ind" select="$ind"/>
      </xsl:call-template>
      <forward_dcl>
        <xsl:attribute name="name">
          <xsl:value-of select="substring-before($name,'_forwardDcl')"/>
        </xsl:attribute>
        <xsl:choose>
          <xsl:when test="@type='dds:forwardDclValueType'">
            <xsl:attribute name="kind">valuetype</xsl:attribute>
          </xsl:when>
          <xsl:when test="@type='dds:forwardDclStruct'">
            <xsl:attribute name="kind">struct</xsl:attribute>
          </xsl:when>
          <xsl:when test="@type='dds:forwardDclUnion'">
            <xsl:attribute name="kind">union</xsl:attribute>
          </xsl:when>
        </xsl:choose>
      </forward_dcl>
    </xsl:if>
  </xsl:template>


  <!-- xsd:include template -->
  <xsl:template match="xsd:include">
    <xsl:param name="ind"/>
    <xsl:call-template name="printBR">
      <xsl:with-param name="ind" select="$ind"/>
    </xsl:call-template>
    <include>
      <xsl:attribute name="file">
        <xsl:choose>
          <xsl:when test="substring(@schemaLocation,string-length(@schemaLocation)-3,string-length(@schemaLocation))='.xsd'">
            <xsl:value-of select="concat(substring(@schemaLocation,1,string-length(@schemaLocation)-4),'.xml')"/>
          </xsl:when>
          <xsl:when test="substring(@schemaLocation,string-length(@schemaLocation)-4,string-length(@schemaLocation))='.wsdl'">
            <xsl:value-of select="concat(substring(@schemaLocation,1,string-length(@schemaLocation)-5),'.xml')"/>
          </xsl:when>
        </xsl:choose>
      </xsl:attribute>
    </include>
  </xsl:template>


  <!-- xsd:import template - Just ignore this tag -->
  <xsl:template match="xsd:import"></xsl:template>


  <!-- xsd:simpleType template -->
  <xsl:template match="xsd:simpleType" name="xsd:simpleType">
    <xsl:param name="ind"/>
    <xsl:param name="nameInModule"/>

    <xsl:variable name="name">
      <xsl:choose>
        <xsl:when test="$nameInModule and $nameInModule!=''">
          <xsl:value-of select="$nameInModule"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@name"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="isBitset">
        <xsl:call-template name="isBitset"/>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$isBitset='true'">
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind"/>
          </xsl:call-template>
          <bitset>
            <xsl:attribute name="name">
              <xsl:value-of select="$name"/>
            </xsl:attribute>

            <xsl:call-template name="matchDirectives"/>

            <xsl:for-each select="xsd:restriction/xsd:enumeration">
              <xsl:call-template name="printBR">
                <xsl:with-param name="ind" select="$ind+1"/>
              </xsl:call-template>
              <flag>
                <xsl:attribute name="name">
                  <xsl:value-of select="@value"/>
                </xsl:attribute>

                <xsl:if test="./xsd:annotation/xsd:appinfo/ordinal">
                    <xsl:attribute name="value">
                        <xsl:value-of select="./xsd:annotation/xsd:appinfo/ordinal"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="not(./xsd:annotation/xsd:appinfo/ordinal)">
                    <xsl:call-template name="matchEnumeratorOrdinal"/>
                </xsl:if>
              </flag>
            </xsl:for-each>
            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind"/>
            </xsl:call-template>
          </bitset>
      </xsl:when>
      <xsl:when test="xsd:restriction/xsd:enumeration">
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind"/>
        </xsl:call-template>
        <enum>
          <xsl:attribute name="name">
            <xsl:value-of select="$name"/>
          </xsl:attribute>

          <xsl:call-template name="matchDirectives"/>

          <xsl:for-each select="xsd:restriction/xsd:enumeration">
            <xsl:call-template name="printBR">
              <xsl:with-param name="ind" select="$ind+1"/>
            </xsl:call-template>
            <enumerator>
              <xsl:attribute name="name">
                <xsl:value-of select="@value"/>
              </xsl:attribute>

              <xsl:if test="./xsd:annotation/xsd:appinfo/ordinal">
                  <xsl:attribute name="value">
                      <xsl:value-of select="./xsd:annotation/xsd:appinfo/ordinal"/>
                  </xsl:attribute>
              </xsl:if>
              <xsl:if test="not(./xsd:annotation/xsd:appinfo/ordinal)">
                  <xsl:call-template name="matchEnumeratorOrdinal"/>
              </xsl:if>
            </enumerator>
          </xsl:for-each>
          <xsl:call-template name="printBR">
            <xsl:with-param name="ind" select="$ind"/>
          </xsl:call-template>
        </enum>
      </xsl:when>
      <xsl:when test="xsd:restriction">
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind"/>
        </xsl:call-template>
        <typedef>
          <xsl:attribute name="name">
            <xsl:value-of select="$name"/>
          </xsl:attribute>
          <xsl:call-template name="solveType"/>
          <xsl:call-template name="solveLengthString"/>
          <xsl:call-template name="matchDirectives"/>
        </typedef>
      </xsl:when>
    </xsl:choose>
  </xsl:template>


  <!-- changeDotsForColon template -->
  <xsl:template name="changeDotsForColon">
    <xsl:param name="nameToResolve"/>

    <xsl:choose>
      <xsl:when test="contains($nameToResolve,'.')">
        <xsl:call-template name="changeDotsForColon">
          <xsl:with-param name="nameToResolve" select="concat(substring-before($nameToResolve,'.'),'::',substring-after($nameToResolve,'.'))"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$nameToResolve"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- isMember - Template that determines if $nameToResolve is the name of a member of the 
       complexType named $complexTypeName -->
  <xsl:template name="isMember">
    <xsl:param name="nameToResolve"/>
    <xsl:param name="complexTypeName"/>
    <xsl:variable name="isMember">
      <xsl:for-each select="//xsd:schema/xsd:complexType[@name=$complexTypeName]/xsd:sequence//xsd:element/@name">
        <xsl:if test="contains($nameToResolve,.)">
          <xsl:value-of select="'true'"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$isMember and $isMember!=''">
        <xsl:value-of select="'true'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'false'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- isTypedef template Check if an array or sequence is typedef or just an explicit declaration
  of an array or sequence inside a struct, union or another typedef-->
  <xsl:template name="isTypedef">
    <xsl:param name="nameToResolve"/>
    <xsl:param name="subString"/>

    <xsl:variable name="nameToEvaluate">
      <xsl:value-of select="concat($subString,substring-before($nameToResolve,'_'))"/>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="//xsd:schema/xsd:complexType[@name=$nameToEvaluate]">

        <xsl:variable name="isMember">
          <xsl:call-template name="isMember">
            <xsl:with-param name="complexTypeName" select="$nameToEvaluate"/>
            <xsl:with-param name="nameToResolve" select="substring-after($nameToResolve,'_')"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:choose>
          <xsl:when test="contains(substring-after($nameToResolve,'_'),'ArrayOf')">
            <xsl:value-of select="'false'"/>
          </xsl:when>
          <xsl:when test="contains(substring-after($nameToResolve,'_'),'SequenceOf')">
            <xsl:value-of select="'false'"/>
          </xsl:when>
          <xsl:when test="$isMember='true'">
            <xsl:value-of select="'false'"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="'true'"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="substring-after($nameToResolve,'_')!=''">
            <xsl:call-template name="isTypedef">
              <xsl:with-param name="nameToResolve" select="substring-after($nameToResolve,'_')"/>
              <xsl:with-param name="subString" select="concat($subString,substring-before($nameToResolve,'_'),'_')"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="'true'"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- isValuetype template -->
  <xsl:template name="isValuetype">
    <xsl:for-each select="(following-sibling::comment()|following-sibling::*)[1]">
      <xsl:variable name="comment">
        <xsl:value-of select="."/>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="local-name(.)='#comment' or local-name(.)=''">
          <xsl:if test="contains($comment,'@valuetype')">
            <xsl:value-of select="substring(string($comment),string-length(' @valuetype ')+1,string-length($comment)-string-length(' @valuetype ')-1)"/>
          </xsl:if>
          <xsl:call-template name="isValuetype"/>
        </xsl:when>
        <xsl:otherwise>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="isStruct">
    <xsl:for-each select="(following-sibling::comment()|following-sibling::*)[1]">
      <xsl:variable name="comment">
        <xsl:value-of select="."/>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="local-name(.)='#comment' or local-name(.)=''">
          <xsl:if test="contains($comment,'@struct')">
            <xsl:value-of select="substring(string($comment),string-length(' @struct ')+1,string-length($comment)-string-length(' @struct ')-1)"/>
          </xsl:if>
          <xsl:call-template name="isStruct"/>
        </xsl:when>
        <xsl:otherwise>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="isBitset">
    <xsl:for-each select="(following-sibling::comment()|following-sibling::*)[1]">
      <xsl:variable name="comment">
        <xsl:value-of select="."/>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="local-name(.)='#comment' or local-name(.)=''">
          <xsl:if test="contains($comment,'@bitSet')">
            <xsl:value-of select="'true'"/>
          </xsl:if>
          <xsl:call-template name="isBitset"/>
        </xsl:when>
        <xsl:otherwise>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <!-- matchDirectives template -->
  <xsl:template name="matchDirectives">
    <xsl:for-each select="(following-sibling::comment()|following-sibling::*)[1]">
      <xsl:choose>
        <xsl:when test="local-name(.)='#comment' or local-name(.)=''">
          <xsl:call-template name="processDirectives">
            <xsl:with-param name="comment" select="."/>
          </xsl:call-template>
          <xsl:call-template name="matchDirectives"/>
        </xsl:when>
        <xsl:otherwise>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>


  <!-- matchEnumeratorOrdinal template -->
  <xsl:template name="matchEnumeratorOrdinal">
    <xsl:for-each select="following-sibling::comment()[position()=1]">
      <xsl:choose>
        <xsl:when test="local-name(.)='#comment' or local-name(.)=''">
          <xsl:variable name="comment">
            <xsl:value-of select="."/>
          </xsl:variable>
          <xsl:if test="contains($comment,'@ordinal')">
            <xsl:attribute name="value">
              <xsl:value-of select="substring(string($comment),string-length(' @ordinal ')+1,string-length($comment)-string-length(' @ordinal ')-1)"/>
            </xsl:attribute>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>


  <!-- processDirectives template -->
  <xsl:template name="processDirectives">
    <xsl:param name="comment"/>

    <xsl:if test="substring($comment,1,2)=' @'">
      <xsl:choose>
        <xsl:when test="substring($comment,3,string-length('key'))='key'">
          <xsl:attribute name="key">
            <xsl:value-of select="substring($comment,string-length(' @key ')+1,string-length($comment)-string-length(' @key ')-1)"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="substring($comment,3,string-length('topLevel'))='topLevel'">
          <xsl:attribute name="topLevel">
            <xsl:value-of select="substring($comment,string-length(' @topLevel ')+1,string-length($comment)-string-length(' @topLevel ')-1)"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="substring($comment,3,string-length('resolveName'))='resolveName'">
          <xsl:attribute name="resolveName">
            <xsl:value-of select="substring($comment,string-length(' @resolveName ')+1,string-length($comment)-string-length(' @resolveName ')-1)"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="substring($comment,3,string-length('bitField'))='bitField'">
          <xsl:attribute name="bitField">
            <xsl:value-of select="substring(string($comment),string-length(' @bitField ')+1,string-length($comment)-string-length(' @bitField ')-1)"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="substring($comment,3,string-length('pointer'))='pointer'">
          <xsl:attribute name="pointer">
            <xsl:value-of select="substring(string($comment),string-length(' @pointer ')+1,string-length($comment)-string-length(' @pointer ')-1)"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="substring($comment,3,string-length('visibility'))='visibility'">
          <xsl:attribute name="visibility">
            <xsl:value-of select="substring(string($comment),string-length(' @visibility ')+1,string-length($comment)-string-length(' @visibility ')-1)"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="substring($comment,3,string-length('typeModifier'))='typeModifier'">
          <xsl:attribute name="typeModifier">
            <xsl:value-of select="substring(string($comment),string-length(' @typeModifier ')+1,string-length($comment)-string-length(' @typeModifier ')-1)"/>
          </xsl:attribute>
        </xsl:when>

        <!-- Extensible types -->
        <xsl:when test="substring($comment,3,string-length('id'))='id'">
          <xsl:attribute name="id">
            <xsl:value-of select="substring($comment,string-length(' @id ')+1,string-length($comment)-string-length(' @id ')-1)"/>
          </xsl:attribute>
        </xsl:when>

        <xsl:when test="substring($comment,3,string-length('bitBound'))='bitBound'">
          <xsl:attribute name="bitBound">
            <xsl:value-of select="substring($comment,string-length(' @bitBound ')+1,string-length($comment)-string-length(' @bitBound ')-1)"/>
          </xsl:attribute>
        </xsl:when>

        <xsl:when test="substring($comment,3,string-length('extensibility'))='extensibility'">
          <xsl:attribute name="extensibility">
            <xsl:variable name="ext">
                <xsl:value-of select="substring($comment,string-length(' @extensibility ')+1,string-length($comment)-string-length(' @id ')-1)"/>
            </xsl:variable>
            <xsl:choose>
              <xsl:when test="contains($ext,'EXTENSIBLE_EXTENSIBILITY')">
                  <xsl:text>extensible</xsl:text>
              </xsl:when>
              <xsl:when test="contains($ext,'MUTABLE_EXTENSIBILITY')">
                  <xsl:text>mutable</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                  <xsl:text>final</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
        </xsl:when>

<!--
        <xsl:when test="substring($comment,3,string-length('baseClass'))='baseClass'">
          <xsl:variable name="baseClass">
            <xsl:call-template name="changeDotsForColon">
              <xsl:with-param name="nameToResolve" select="substring(string($comment),string-length(' @baseClass ')+1,string-length($comment)-string-length(' @baseClass ')-1)"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:attribute name="baseClass">
            <xsl:value-of select="$baseClass"/>
          </xsl:attribute>
        </xsl:when>
-->
      </xsl:choose>
    </xsl:if>
  </xsl:template>


  <!-- resolveArray template -->
  <xsl:template name="resolveArray">
    <xsl:param name="nameToResolve"/>
    <xsl:param name="resolvedDimensions"/>

    <xsl:choose>
      <xsl:when test="//xsd:schema/xsd:complexType[@name=$nameToResolve]">
        <xsl:for-each select="//xsd:schema/xsd:complexType[@name=$nameToResolve]">

          <xsl:variable name="isTypedef">
            <xsl:call-template name="isTypedef">
              <xsl:with-param name="nameToResolve" select="@name"/>
            </xsl:call-template>
          </xsl:variable>

          <xsl:choose>
            <!-- Case Typedef -->
            <xsl:when test="$isTypedef='true'">
              <xsl:attribute name="arrayDimensions">
                <xsl:call-template name="reverseDimensions">
                  <xsl:with-param name="arrayDimensions" select="$resolvedDimensions"/>
                </xsl:call-template>
              </xsl:attribute>

              <xsl:call-template name="solveNonBasicType">
                <xsl:with-param name="nonBasicTypeName" select="@name"/>
              </xsl:call-template>

            </xsl:when>
            <!-- Case array -->
            <xsl:when test="xsd:sequence/xsd:element/@maxOccurs=xsd:sequence/xsd:element/@minOccurs and starts-with(xsd:sequence/xsd:element/@name,'item')">
              <xsl:variable name="newDimension">
                <xsl:value-of select="./xsd:sequence/xsd:element/@maxOccurs"/>
              </xsl:variable>
              <xsl:variable name="type">
                <xsl:for-each select="./xsd:sequence/xsd:element">
                  <xsl:call-template name="getType"/>
                </xsl:for-each>
              </xsl:variable>
              <xsl:call-template name="resolveArray">
                <xsl:with-param name="nameToResolve" select="$type"/>
                <xsl:with-param name="resolvedDimensions" select="concat($resolvedDimensions,',',$newDimension)"/>
              </xsl:call-template>
            </xsl:when>
            <!-- Case sequence -->
            <xsl:when test="xsd:sequence/xsd:element/@maxOccurs!=xsd:sequence/xsd:element/@minOccurs and starts-with(xsd:sequence/xsd:element/@name,'item')">
              <xsl:call-template name="solveLengths"/>
              <xsl:attribute name="arrayDimensions">
                <xsl:call-template name="reverseDimensions">
                  <xsl:with-param name="arrayDimensions" select="$resolvedDimensions"/>
                </xsl:call-template>
              </xsl:attribute>
              <xsl:for-each select="./xsd:sequence/xsd:element">
                <xsl:call-template name="solveType"/>
              </xsl:for-each>
              <xsl:call-template name="matchDirectives"/>
            </xsl:when>
            <!-- Case type-->
            <xsl:otherwise>
              <xsl:attribute name="arrayDimensions">
                <xsl:call-template name="reverseDimensions">
                  <xsl:with-param name="arrayDimensions" select="$resolvedDimensions"/>
                </xsl:call-template>
              </xsl:attribute>

              <xsl:call-template name="solveNonBasicType">
                <xsl:with-param name="nonBasicTypeName" select="@name"/>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:when>

      <!-- Nested sequences/arrays support-->
      <xsl:when test="./xsd:sequence/xsd:element/xsd:complexType/xsd:sequence/xsd:element/@minOccurs='0'">

        <xsl:for-each select="./xsd:sequence/xsd:element/xsd:complexType">
          <xsl:attribute name="arrayDimensions">
            <xsl:call-template name="reverseDimensions">
              <xsl:with-param name="arrayDimensions" select="$resolvedDimensions"/>
            </xsl:call-template>
          </xsl:attribute>

          <xsl:for-each select="./xsd:sequence/xsd:element">
            <xsl:call-template name="solveType"/>
          </xsl:for-each>
          <xsl:call-template name="solveLengthString"/>
          <xsl:attribute name="sequenceMaxLength">
            <xsl:choose>
              <xsl:when test="./xsd:sequence/xsd:element/@maxOccurs!='unbounded'">              
                <xsl:value-of select="./xsd:sequence/xsd:element/@maxOccurs"/>
              </xsl:when>
              <xsl:otherwise>              
                <xsl:value-of select="'-1'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
        </xsl:for-each>
      </xsl:when>

      <xsl:otherwise>

        <xsl:attribute name="arrayDimensions">
          <xsl:call-template name="reverseDimensions">
            <xsl:with-param name="arrayDimensions" select="$resolvedDimensions"/>
          </xsl:call-template>
        </xsl:attribute>

        <xsl:for-each select="./xsd:sequence/xsd:element">
          <xsl:call-template name="solveType"/>
        </xsl:for-each>
        <xsl:call-template name="solveLengthString"/>
        <!--<xsl:call-template name="matchDirectives"/>-->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- reverseDimensions template -->
  <xsl:template name="reverseDimensions">
    <xsl:param name="arrayDimensions"/>

    <xsl:choose>
      <xsl:when test="substring-after($arrayDimensions,',')!=''">
        <xsl:variable name="reversedDimensions">
          <xsl:call-template name="reverseDimensions">
            <xsl:with-param name="arrayDimensions" select="substring-after($arrayDimensions,',')"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="concat($reversedDimensions,',',substring-before($arrayDimensions,','))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$arrayDimensions"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- solveArrayOrSequenceMember template -->
  <xsl:template name="solveArrayOrSequenceMember">
    <xsl:variable name="type">
      <xsl:choose>
        <xsl:when test="contains(@type,':')">
          <xsl:value-of select="substring-after(@type,':')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@type"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:for-each select="//xsd:schema/xsd:complexType[@name=$type]">

      <xsl:variable name="isTypedef">
        <xsl:call-template name="isTypedef">
          <xsl:with-param name="nameToResolve" select="@name"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:choose>
        <xsl:when test="xsd:sequence/xsd:element/@maxOccurs=xsd:sequence/xsd:element/@minOccurs">
          <xsl:choose>
            <xsl:when test="$isTypedef!='true'">
              <xsl:variable name="tmpType">                  
                <xsl:choose>
                  <xsl:when test="contains(xsd:sequence/xsd:element/@type,':')">
                    <xsl:value-of select="substring-after(xsd:sequence/xsd:element/@type,':')"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="xsd:sequence/xsd:element/@type"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:variable>
              <xsl:call-template name="resolveArray">
                <xsl:with-param name="nameToResolve" select="$tmpType"/>
                <xsl:with-param name="resolvedDimensions" select="xsd:sequence/xsd:element/@maxOccurs"/>
              </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <xsl:for-each select="xsd:sequence/xsd:element">
                <xsl:call-template name="solveNonBasicType">
                  <xsl:with-param name="nonBasicTypeName" select="../../@name"/>
                </xsl:call-template>
              </xsl:for-each>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>

          <xsl:for-each select="xsd:sequence/xsd:element">            
            <xsl:choose>
              <xsl:when test="$isTypedef='true'">
                <xsl:call-template name="solveNonBasicType">
                  <xsl:with-param name="nonBasicTypeName" select="../../@name"/>
                </xsl:call-template>
              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="solveType"/>
              </xsl:otherwise>
              </xsl:choose>
          </xsl:for-each>

          <xsl:if test="$isTypedef!='true'">
            <xsl:call-template name="solveLengths"/>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>


  <!-- solveNestedArrayOrSequenceMember template -->
  <xsl:template name="solveNestedArrayOrSequenceMember">

    <xsl:variable name="arrayDimensions">
      <xsl:for-each select=".//xsd:element[starts-with(@name,'item') and @maxOccurs=@minOccurs]">
        <xsl:value-of select="@maxOccurs"/>
        <xsl:text>,</xsl:text>
      </xsl:for-each>
    </xsl:variable>

    <xsl:variable name="reversedDimensions">
      <xsl:call-template name="reverseDimensions">
        <xsl:with-param name="arrayDimensions" select="substring($arrayDimensions,1,string-length($arrayDimensions)-1)"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="sequenceMaxLength">
      <xsl:for-each select=".//xsd:element[starts-with(@name,'item') and @maxOccurs!=@minOccurs]">
        <xsl:value-of select="@maxOccurs"/>
      </xsl:for-each>
    </xsl:variable>

    <xsl:variable name="type">
      <xsl:for-each select=".//xsd:element[@type and @type!='']|.//xsd:simpleType">
        <xsl:call-template name="getType"/>
      </xsl:for-each>
    </xsl:variable>

    <xsl:for-each select=".//xsd:simpleType">
      <xsl:call-template name="solveLengthString"/>
    </xsl:for-each>

    <xsl:if test="$reversedDimensions and $reversedDimensions!=''">
      <xsl:attribute name="arrayDimensions">
        <xsl:value-of select="$reversedDimensions"/>
      </xsl:attribute>
    </xsl:if>

    <xsl:if test="$sequenceMaxLength and $sequenceMaxLength!=''">
      <xsl:attribute name="sequenceMaxLength">
        <xsl:choose>      
          <xsl:when test="$sequenceMaxLength!='unbounded'">
            <xsl:value-of select="$sequenceMaxLength"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="'-1'"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </xsl:if>

    <xsl:if test="$type and $type!=''">
      <xsl:attribute name="type">
        <xsl:value-of select="$type"/>
      </xsl:attribute>
    </xsl:if>
  </xsl:template>


  <!-- solveLengths template -->
  <xsl:template name="solveLengths">
    <xsl:variable name="stringMaxLength">
      <xsl:call-template name="getLengthString"/>
    </xsl:variable>
    <xsl:variable name="sequenceMaxLength">
      <xsl:value-of select="xsd:sequence/xsd:element/@maxOccurs"/>
    </xsl:variable>

    <xsl:if test="$stringMaxLength and $stringMaxLength!=''">
      <xsl:attribute name="stringMaxLength">
        <xsl:value-of select="$stringMaxLength"/>
      </xsl:attribute> 
    </xsl:if>

    <xsl:if test="$sequenceMaxLength and $sequenceMaxLength!=''">
      <xsl:attribute name="sequenceMaxLength">
        <xsl:choose>      
          <xsl:when test="$sequenceMaxLength!='unbounded'">
            <xsl:value-of select="$sequenceMaxLength"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="'-1'"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </xsl:if>
  </xsl:template>


  <!-- solveLengthString template -->
  <xsl:template name="solveLengthString">
    <xsl:variable name="stringMaxLength">
      <xsl:call-template name="getLengthString"/>
    </xsl:variable>
    <xsl:if test="$stringMaxLength and $stringMaxLength!=''">
      <xsl:attribute name="stringMaxLength">
        <xsl:value-of select="$stringMaxLength"/>
      </xsl:attribute>
    </xsl:if>
  </xsl:template>


  <!-- getLengthString template -->
  <xsl:template name="getLengthString">
    <xsl:variable name="maxLength">
      <xsl:choose>
        <xsl:when test="xsd:simpleType/xsd:restriction|xsd:restriction|xsd:sequence/xsd:element/xsd:simpleType/xsd:restriction">
          <xsl:value-of select=".//xsd:restriction/xsd:maxLength/@value"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:value-of select="$maxLength"/>
  </xsl:template>


  <!-- getType template -->
  <xsl:template name="getType">

    <xsl:variable name="type">
      <xsl:choose>
        <xsl:when test="xsd:simpleType/xsd:restriction|xsd:restriction">
          <xsl:value-of select=".//xsd:restriction/@base"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@type"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="ns">
      <xsl:if test="contains(name(.),':')">
        <xsl:value-of select="concat(substring-before(name(.),':'),':')"/>
      </xsl:if>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$type=concat($ns,'string')">
        <xsl:choose>
          <xsl:when test=".//xsd:restriction/xsd:length/@value='1'">
            <xsl:value-of select="'char'"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="'string'"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$type=concat($ns,'short')">
        <xsl:value-of select="'short'"/>
      </xsl:when>
      <xsl:when test="$type=concat($ns,'int')">
        <xsl:value-of select="'long'"/>
      </xsl:when>
      <xsl:when test="$type=concat($ns,'long')">
        <xsl:value-of select="'longLong'"/>
      </xsl:when>
      <xsl:when test="$type=concat($ns,'float')">
        <xsl:value-of select="'float'"/>
      </xsl:when>
      <xsl:when test="$type=concat($ns,'unsignedShort')">
        <xsl:value-of select="'unsignedShort'"/>
      </xsl:when>
      <xsl:when test="$type=concat($ns,'unsignedInt')">
        <xsl:value-of select="'unsignedLong'"/>
      </xsl:when>
      <xsl:when test="$type=concat($ns,'double')">
        <xsl:value-of select="'double'"/>
      </xsl:when>
      <xsl:when test="$type=concat($ns,'boolean')">
        <xsl:value-of select="'boolean'"/>
      </xsl:when>
      <xsl:when test="$type=concat($ns,'unsignedByte')">
        <xsl:value-of select="'octet'"/>
      </xsl:when>
      <xsl:when test="$type='dds:wchar'">
        <xsl:value-of select="'wchar'"/>
      </xsl:when>
      <xsl:when test="$type='dds:char'">
        <xsl:value-of select="'char'"/>
      </xsl:when>
      <xsl:when test="$type=concat($ns,'unsignedLong')">
        <xsl:value-of select="'unsignedLongLong'"/>
      </xsl:when>
      <xsl:when test="$type='dds:longDouble'">
        <xsl:value-of select="'longDouble'"/>
      </xsl:when>
      <xsl:when test="$type='dds:wstring'">
        <xsl:value-of select="'wstring'"/>
      </xsl:when>
      <xsl:otherwise> 
        <xsl:choose>
          <xsl:when test="contains($type,':')">
            <xsl:value-of select="substring-after($type,':')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$type"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- solveNonBasicType template -->
  <xsl:template name="solveNonBasicType">
    <xsl:param name="nonBasicTypeName"/>

    <xsl:attribute name="type">nonBasic</xsl:attribute>
    <xsl:attribute name="nonBasicTypeName">
      <xsl:call-template name="changeDotsForColon">
        <xsl:with-param name="nameToResolve">
          <xsl:choose>
            <xsl:when test="contains($nonBasicTypeName,':')">
              <xsl:value-of select="substring-after($nonBasicTypeName,':')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$nonBasicTypeName"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:attribute>
  </xsl:template>


  <!-- solveType template -->
  <xsl:template name="solveType">
    
    <xsl:variable name="type">
      <xsl:call-template name="getType"/>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$type='short' or $type='double' or $type='boolean' or $type='float'  or $type='long' or $type='unsignedShort' or $type='unsignedLong' or $type='octet'  or $type='longLong' or $type='unsignedLongLong' or $type='wchar' or $type='longDouble' or $type='char' or $type='string'  or $type='wstring'">
        <xsl:attribute name="type">
          <xsl:value-of select="$type"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="solveNonBasicType">
          <xsl:with-param name="nonBasicTypeName" select="$type"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- solveUnionCases template -->
  <xsl:template name="solveUnionCases">
    <xsl:param name="str"/>
    <xsl:param name="ind"/>
    <xsl:choose>
      <xsl:when test="contains($str,',')">
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind"/>
        </xsl:call-template>
        <caseDiscriminator>
          <xsl:attribute name="value">
            <xsl:value-of select="substring-before($str,',')"/>
          </xsl:attribute>
        </caseDiscriminator>
        <xsl:call-template name="solveUnionCases">
          <xsl:with-param name="ind" select="$ind"/>
          <xsl:with-param name="str" select="substring-after($str,',')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="printBR">
          <xsl:with-param name="ind" select="$ind"/>
        </xsl:call-template>
        <caseDiscriminator>
          <xsl:attribute name="value">
            <xsl:value-of select="$str"/>
          </xsl:attribute>
        </caseDiscriminator>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- printIndent template 
	This template indentates the IDL code, according to the depth
	-->
  <xsl:template name="printIndent">
    <xsl:param name="ind"/>
    <xsl:text>  </xsl:text>
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
