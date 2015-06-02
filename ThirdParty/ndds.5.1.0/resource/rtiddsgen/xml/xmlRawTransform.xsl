<?xml version="1.0"?>
<!-- 
/* $Id: xmlRawTransform.xsl,v 1.8 2013/09/12 14:22:28 fernando Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
modification history:
- - - - - - - - - - -
5.0.1,15apr13,acr CODEGEN-573: convert Optional directive
5.0.0,09nov12,fcs Added extensibility and memberID support for valuetypes
5.0.0,08nov12,fcs Mutable valuetype support
5.0.0,10jul12,fcs Mutable union support
1.0ac,21jun11,fcs Union extensibility support
1.0ac,09jun11,fcs CXTYPES-88: Generate XML and XSD code for new features in Phase 1
1.0ac,09apr11,fcs Fixed bug 13915
1.0ac,08dec10,fcs Added copy-java-begin and copy-java-declaration-begin
10z,24jul10,fcs Fixed bug 13534
10z,08dec08,eh  Remove dds from exclude-result-prefixes
10y,21nov08,jlv Changed maxLengthSequence for sequenceMaxLength and maxLengthString for
                stringMaxLength in XML format.
10y,18nov08,jlv Changed the way unions are parsed in XML. Now members are children of cases.
10y,16nov08,jlv Removed sequence='true', now we use maxLengthSequence='-1' for unbounded sequences.
                Added maxLengthString='-1' case.
                Added nonBasic type and nonBasicTypeName attribute.
                Changed some types name. Solved new bug in longlong types.
10y,31oct08,jlv Changed kind='sequence' to sequence='true'
10y,30oct08,jlv Removed 'yes' and 'no' values. Changed ' ' to ',' in dimensions attribute.
                Changed the name of the directives. Added copyCppcli and
                copyCppcliDeclaration directives. Changed dimensions to arrayDimensions.
10y,30sep08,jlv Fixed included template, now preprocessor works fine also with nested
                included tags. 
10y,29sep08,jlv maxLength renamed to maxLengthString and maxLengthSequence. 
                Fixed forward_dcl template (this fix required a template 
                included in utils.xsl).
10y,20ago08,jlv Removed dds: label from tags
10y,19ago08,jlv Fixed included template, now preprocessor works fine
10u,16jul08,tk  Removed utils.xsl
                - Updated with-param statement to include select "."
10s,21jan08,jpm Created
-->
<xsl:transform 	version="1.0"              
		        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:java="http://xml.apache.org/xslt/java" 
                xmlns:xalan="http://xml.apache.org/xalan" 
                xmlns:helper="com.rti.ndds.nddsgen.transformation.TransformerHelper" 
                extension-element-prefixes="helper"
                exclude-result-prefixes="helper java" >

  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
  <xsl:strip-space elements="*"/>
  <xsl:include href="utils.xsl"/>
  <xsl:param name="inputfilePath"/>
  <xsl:param name="inputfile"/>
  <xsl:param name="ppfile"/>

  <xalan:component prefix="helper" functions="parseConstExpression">
    <xalan:script lang="javaclass" 
              src="xalan://com.rti.ndds.nddsgen.transformation.IDLTransformer"/>
  </xalan:component>


  <xsl:template match="/">
    <xsl:element name="specification">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="ppheader">
      <definition>
        <line_dcl><xsl:text># 1 </xsl:text>
        <xsl:value-of select="string(concat('&quot;',$ppfile,'&quot;'))"/>
        <xsl:text>
</xsl:text>
        </line_dcl>
      </definition>
      <definition>
        <line_dcl><xsl:text># 1 </xsl:text>
        <xsl:value-of select="string(concat('&quot;&lt;','built-in','&gt;&quot;'))"/><xsl:text>
</xsl:text>
        </line_dcl>
      </definition>
      <definition>
        <line_dcl><xsl:text># 1 </xsl:text>
        <xsl:value-of select="string(
                              concat(
                              '&quot;&lt;','command line','&gt;&quot;'))"/><xsl:text>
</xsl:text>
        </line_dcl>
      </definition>      
      <definition>
        <line_dcl><xsl:text># 1 </xsl:text>
        <xsl:value-of select="string(concat('&quot;',$ppfile,'&quot;'))"/><xsl:text>
</xsl:text>
        </line_dcl>
      </definition>
      <definition>
        <line_dcl><xsl:text># 1 </xsl:text>
        <xsl:value-of select="string(concat('&quot;',$inputfilePath,'&quot;'))"/><xsl:text>
</xsl:text>
        </line_dcl>
      </definition>
  </xsl:template>

  <xsl:template match="include">
    <xsl:element name="definition">
      <xsl:element name="include_dcl">
        <xsl:text>#include</xsl:text>
        <xsl:element name="include_file">
          <xsl:element name="string_literal">
            <xsl:text>"</xsl:text>
            <xsl:value-of select="@file"/>
            <xsl:text>"</xsl:text>
          </xsl:element>
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>


  <!-- Included files -->
  <xsl:template match="included">
    <xsl:element name="definition">
      <xsl:element name="line_dcl">
        <xsl:text># 1 "</xsl:text>
        <xsl:value-of select="@src"/>
        <xsl:text>" 1
</xsl:text>
      </xsl:element>
    </xsl:element>
    <xsl:apply-templates/>
     <xsl:element name="definition">
      <xsl:element name="line_dcl">
        <xsl:text># 2 "</xsl:text>
        <xsl:choose>
          <xsl:when test="local-name(parent::*)='types'">
            <xsl:value-of select="$inputfile"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="parent::included/@src"/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>" 2
</xsl:text>
      </xsl:element>
    </xsl:element>

    <xsl:if test="local-name(parent::*)='types'">
      <xsl:element name="definition">
        <xsl:element name="include_dcl">
          <xsl:text>?include</xsl:text>
          <xsl:element name="include_file">
            <xsl:element name="string_literal">
              <xsl:text>"</xsl:text>
              <xsl:value-of select="@src"/>
              <xsl:text>"</xsl:text>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:element>
    </xsl:if>
   
  </xsl:template>

  <!-- Directives -->
  <xsl:template match="directive">
      <directive>
        <!--<xsl:copy-of select="@*"/>-->
        <xsl:attribute name="kind">
          <xsl:choose>
            <xsl:when test="@kind='copyC'">
              <xsl:value-of select="'copy-c'"/>
            </xsl:when>
            <xsl:when test="@kind='copyJava'">
              <xsl:value-of select="'copy-java'"/>
            </xsl:when>
            <xsl:when test="@kind='copyJavaBegin'">
              <xsl:value-of select="'copy-java-begin'"/>
            </xsl:when>
            <xsl:when test="@kind='copyDeclaration'">
              <xsl:value-of select="'copy-declaration'"/>
            </xsl:when>
            <xsl:when test="@kind='copyJavaDeclaration'">
              <xsl:value-of select="'copy-java-declaration'"/>
            </xsl:when>
            <xsl:when test="@kind='copyJavaDeclarationBegin'">
              <xsl:value-of select="'copy-java-declaration-begin'"/>
            </xsl:when>
            <xsl:when test="@kind='copyCDeclaration'">
              <xsl:value-of select="'copy-c-declaration'"/>
            </xsl:when>
            <xsl:when test="@kind='copyCppcli'">
              <xsl:value-of select="'copy-cppcli'"/>
            </xsl:when>
            <xsl:when test="@kind='copyCppcliDeclaration'">
              <xsl:value-of select="'copy-cppcli-declaration'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="./@kind"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:value-of select="."/>
      </directive>
  </xsl:template>

  <!-- Modules -->
  <xsl:template match="module">
    <xsl:element name="definition">
      <xsl:element name="module">
        <xsl:text>module</xsl:text>
        <xsl:element name="identifier">
          <xsl:value-of select="./@name"/>
        </xsl:element>
        <xsl:apply-templates select="./*"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="forward_dcl[./@kind='valuetype']">
    <definition>
    <value>
      <value_forward_dcl> 
        valuetype
        <identifier>
          <xsl:if test="contains(./@name,'::')">
            <!--<xsl:value-of select="substring-after(./@name,'::')"/>-->
            <xsl:call-template name="substring-after-last">
              <xsl:with-param name="string" select="./@name"/>
              <xsl:with-param name="pattern" select="'::'"/>
            </xsl:call-template>
          </xsl:if>
          <xsl:if test="not(contains(./@name,'::'))">
            <xsl:value-of select="./@name"/>
          </xsl:if>
        </identifier>
      </value_forward_dcl>  
    </value>
    </definition>
  </xsl:template>

   <xsl:template match="forward_dcl[./@kind='union' or ./@kind='struct']">
    <definition>
      <type_dcl>
        <constr_forward_dcl> 
          <xsl:value-of select="./@kind"/>
          <identifier>
            <xsl:if test="contains(./@name,'::')">
              <!--<xsl:value-of select="substring-after(./@name,'::')"/>-->
              <xsl:call-template name="substring-after-last">
                <xsl:with-param name="string" select="./@name"/>
                <xsl:with-param name="pattern" select="'::'"/>
              </xsl:call-template>
            </xsl:if>
            <xsl:if test="not(contains(./@name,'::'))">
              <xsl:value-of select="./@name"/>
            </xsl:if>
          </identifier>
        </constr_forward_dcl>  
      </type_dcl>
    </definition>
  </xsl:template> 


  <!-- Struct -->
  <xsl:template match="struct">
    <xsl:element name="definition">
      <xsl:element name="type_dcl">
        <xsl:element name="struct_type">
          <xsl:text>struct</xsl:text>
          <xsl:element name="identifier">
            <xsl:value-of select="@name"/>
          </xsl:element>
          <xsl:element name="struct_inheritance_spec">
              <xsl:if test="./@baseType">
                  <xsl:element name="struct_name">
                    <xsl:copy-of select="helper:parseScopedName(./@baseType)"/>
                  </xsl:element>
              </xsl:if>
          </xsl:element>
          <xsl:element name="member_list">
            <xsl:apply-templates/>
          </xsl:element>
        </xsl:element>
      </xsl:element>
    </xsl:element>
    <xsl:if test="./@topLevel">
      <xsl:element name="directive">
        <xsl:attribute name="kind">top-level</xsl:attribute>
        <xsl:value-of select="./@topLevel"/>
      </xsl:element>
    </xsl:if>
    <xsl:if test="./@extensibility">
        <xsl:element name="directive">
          <xsl:attribute name="kind">Extensibility</xsl:attribute>
          <xsl:choose>
              <xsl:when test="./@extensibility = 'extensible'">
                 <xsl:text>EXTENSIBLE_EXTENSIBILITY</xsl:text>
              </xsl:when>
              <xsl:when test="./@extensibility = 'mutable'">
                 <xsl:text>MUTABLE_EXTENSIBILITY</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                 <xsl:text>FINAL_EXTENSIBILITY</xsl:text>
              </xsl:otherwise>
          </xsl:choose>
        </xsl:element>
    </xsl:if>
  </xsl:template>

  <!-- Valuetype -->
  <xsl:template match="valuetype">
    <xsl:element name="definition">
      <xsl:element name="value">
        <xsl:element name="value_dcl">
          <xsl:element name="value_header">
            <xsl:if test="@typeModifier!='none'">
              <xsl:value-of select="@typeModifier"/>
            </xsl:if><xsl:text>valuetype</xsl:text>
            <xsl:element name="identifier">
              <xsl:value-of select="./@name"/>
            </xsl:element>
            <xsl:element name="value_inheritance_spec">
              <xsl:if test="./@baseClass">
                <xsl:element name="value_name">
                  <xsl:copy-of select="helper:parseScopedName(./@baseClass)"/>
                </xsl:element>
              </xsl:if>	
            </xsl:element>	
          </xsl:element>
	      <xsl:apply-templates/>
        </xsl:element>
      </xsl:element>
    </xsl:element>
    <xsl:if test="./@topLevel">
      <xsl:element name="directive">
        <xsl:attribute name="kind">top-level</xsl:attribute>
        <xsl:value-of select="./@topLevel"/>
      </xsl:element>
    </xsl:if>
    <xsl:if test="./@extensibility">
        <xsl:element name="directive">
          <xsl:attribute name="kind">Extensibility</xsl:attribute>
          <xsl:choose>
              <xsl:when test="./@extensibility = 'extensible'">
                 <xsl:text>EXTENSIBLE_EXTENSIBILITY</xsl:text>
              </xsl:when>
              <xsl:when test="./@extensibility = 'mutable'">
                 <xsl:text>MUTABLE_EXTENSIBILITY</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                 <xsl:text>FINAL_EXTENSIBILITY</xsl:text>
              </xsl:otherwise>
          </xsl:choose>
        </xsl:element>
    </xsl:if>
  </xsl:template>

  <!-- Typedef -->
  <xsl:template match="typedef">
    <xsl:element name="definition">
    <xsl:element name="type_dcl">
      <xsl:text>typedef</xsl:text>
      <xsl:element name="type_declarator">
        <xsl:element name="type_spec">
          <xsl:call-template name="getType">
            <xsl:with-param name="member" select="."/>
          </xsl:call-template>
        </xsl:element>
        <xsl:element name="declarators">
          <xsl:call-template name="parseDeclarator">
            <xsl:with-param name="decl" select="."/>
            <xsl:with-param name="name" select="./@name"/>
          </xsl:call-template>
        </xsl:element>
      </xsl:element>
    </xsl:element>
    </xsl:element>
    <xsl:if test="./@topLevel">
      <xsl:element name="directive">
        <xsl:attribute name="kind">top-level</xsl:attribute>
        <xsl:value-of select="./@topLevel"/>
      </xsl:element>
    </xsl:if>
    <xsl:if test="./@resolveName">
      <xsl:element name="directive">
        <xsl:attribute name="kind">resolve-name</xsl:attribute>
        <xsl:value-of select="./@resolveName"/>
      </xsl:element>
    </xsl:if>
  </xsl:template>


  <xsl:template match="valuetype/member">
    <xsl:element name="value_element">
      <xsl:element name="state_member">
      	<xsl:element name="access_modifier">
      		<xsl:value-of select="./@visibility"/>
      	</xsl:element>
	<!-- Type Spec -->
    	<xsl:element name="type_spec">
          <xsl:call-template name="getType">
            <xsl:with-param name="member" select="."/>
          </xsl:call-template>
        </xsl:element>
	<!-- Declarators -->
	<!-- Declarator -->
      <xsl:element name="declarators">
        <xsl:call-template name="parseDeclarator">
          <xsl:with-param name="name" select="./@name"/>
          <xsl:with-param name="decl" select="."/>
        </xsl:call-template>
      </xsl:element>
     </xsl:element>
    </xsl:element>
    <xsl:if test="./@key and (./@key='1' or ./@key='true')">
      <xsl:element name="directive">
        <xsl:attribute name="kind">key</xsl:attribute>
      </xsl:element>
    </xsl:if>
    <xsl:if test="./@id">
      <xsl:element name="directive">
        <xsl:attribute name="kind">ID</xsl:attribute>
        <xsl:value-of select="./@id"/>
      </xsl:element>
    </xsl:if>
    <xsl:if test="./@optional">
      <xsl:element name="directive">
        <xsl:attribute name="kind">Optional</xsl:attribute>
        <xsl:value-of select="./@optional"/>
      </xsl:element>
    </xsl:if>    
    <xsl:if test="./@resolveName">
      <xsl:element name="directive">
        <xsl:attribute name="kind">resolve-name</xsl:attribute>
        <xsl:value-of select="./@resolveName"/>
      </xsl:element>
    </xsl:if>
  </xsl:template>


  <!-- Member of a struct -->
  <xsl:template match="struct/member">
    <xsl:element name="member"><!-- Check if it's coherent -->
      <xsl:call-template name="checkMember">
        <xsl:with-param name="member" select="."/>
      </xsl:call-template>
      <xsl:element name="type_spec">
        <xsl:call-template name="getType">
          <xsl:with-param name="member" select="."/>
        </xsl:call-template>
      </xsl:element>
      <xsl:element name="declarators">
        <xsl:call-template name="parseDeclarator">
          <xsl:with-param name="name" select="./@name"/>
          <xsl:with-param name="decl" select="."/>
        </xsl:call-template>
      </xsl:element>
    </xsl:element>
    <xsl:if test="./@key and (./@key='1' or ./@key='true')">
      <xsl:element name="directive">
        <xsl:attribute name="kind">key</xsl:attribute>
      </xsl:element>
    </xsl:if>
    <xsl:if test="./@id">
      <xsl:element name="directive">
        <xsl:attribute name="kind">ID</xsl:attribute>
        <xsl:value-of select="./@id"/>
      </xsl:element>
    </xsl:if>
    <xsl:if test="./@optional">
      <xsl:element name="directive">
        <xsl:attribute name="kind">Optional</xsl:attribute>
        <xsl:value-of select="./@optional"/>
      </xsl:element>
    </xsl:if>        
    <xsl:if test="./@resolveName">
      <xsl:element name="directive">
        <xsl:attribute name="kind">resolve-name</xsl:attribute>
        <xsl:value-of select="./@resolveName"/>
      </xsl:element>
    </xsl:if>
  </xsl:template>

  <!-- Const -->
  <xsl:template match="const">
    <xsl:element name="definition">
      <xsl:element name="const_dcl">
        <xsl:text>const</xsl:text>
	<!-- Parse Type -->
        <const_type>
        <xsl:call-template name="getConstType">
          <xsl:with-param name="const" select="."/>
        </xsl:call-template>
        </const_type>
        <xsl:element name="identifier">
          <xsl:value-of select="./@name"/>
        </xsl:element>
        <xsl:text>=</xsl:text>
        <xsl:variable name="constValue">
          <xsl:call-template name="replace-string">
              <xsl:with-param name="text">
                  <xsl:call-template name="replace-string">
                      <xsl:with-param name="text" select="./@value"/>
                      <xsl:with-param name="search" select="'true'"/>
                      <xsl:with-param name="replace" select="'TRUE'"/>
                  </xsl:call-template>
              </xsl:with-param>
              <xsl:with-param name="search" select="'false'"/>
              <xsl:with-param name="replace" select="'FALSE'"/>
          </xsl:call-template>
        </xsl:variable>
	<!-- Value -->
        <xsl:copy-of select="helper:parseConstExpression($constValue)"/>
      </xsl:element>
    </xsl:element>
    <xsl:if test="./@resolveName">
      <xsl:element name="directive">
        <xsl:attribute name="kind">resolve-name</xsl:attribute>
        <xsl:value-of select="./@resolveName"/>
      </xsl:element>
    </xsl:if>
  </xsl:template>

  <xsl:template match="enum|bitset">
    <xsl:element name="definition">
      <xsl:element name="type_dcl">
        <xsl:element name="enum_type">
          <xsl:text>enum</xsl:text>
          <xsl:element name="identifier">
            <xsl:value-of select="./@name"/>
          </xsl:element>
          <xsl:element name="enumerator_list">
            <xsl:apply-templates select="enumerator|flag"/>
          </xsl:element>
        </xsl:element>
      </xsl:element>
    </xsl:element>
    <xsl:if test="name(.) = 'enum'">
        <xsl:if test="./@extensibility">
            <xsl:element name="directive">
              <xsl:attribute name="kind">Extensibility</xsl:attribute>
              <xsl:choose>
                  <xsl:when test="./@extensibility = 'extensible'">
                     <xsl:text>EXTENSIBLE_EXTENSIBILITY</xsl:text>
                  </xsl:when>
                  <xsl:when test="./@extensibility = 'mutable'">
                     <xsl:text>MUTABLE_EXTENSIBILITY</xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:text>FINAL_EXTENSIBILITY</xsl:text>
                  </xsl:otherwise>
              </xsl:choose>
            </xsl:element>
        </xsl:if>
    </xsl:if>
    <xsl:if test="name() = 'bitset'">
        <xsl:element name="directive">
          <xsl:attribute name="kind">BitSet</xsl:attribute>
        </xsl:element>
    </xsl:if>
    <xsl:if test="./@bitBound">
        <xsl:element name="directive">
          <xsl:attribute name="kind">BitBound</xsl:attribute>
          <xsl:value-of select="./@bitBound"/>
        </xsl:element>
    </xsl:if>
  </xsl:template>

  <xsl:template match="enumerator|flag">
    <xsl:element name="enumerator">
      <xsl:element name="identifier">
        <xsl:value-of select="@name"/>
      </xsl:element>
      <xsl:if test="@value">
        <xsl:text>=</xsl:text>
        <xsl:element name="integer_literal">
          <xsl:value-of select="./@value"/>
        </xsl:element>
      </xsl:if>
    </xsl:element>
  </xsl:template>

  <xsl:template match="union">
    <xsl:element name="definition">
    <xsl:element name="type_dcl">
    <xsl:element name="union_type">
      <xsl:text>union</xsl:text>
      <xsl:element name="identifier">
        <xsl:value-of select="./@name"/>
      </xsl:element>
      <xsl:text>switch</xsl:text><!-- Type Spec -->
      <xsl:element name="switch_type_spec">
        <xsl:call-template name="parseSwitchType">
          <xsl:with-param name="switchtype">
            <xsl:choose>
              <xsl:when test="./discriminator/@type!='nonBasic'">
                <xsl:value-of select="./discriminator/@type"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="./discriminator/@nonBasicTypeName"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:element>
      <xsl:element name="switch_body">
        <xsl:element name="case_stmt_list">
          <xsl:for-each select="./case">
            <xsl:element name="case_stmt">              
              <xsl:element name="case_label_list">
                <xsl:for-each select="./caseDiscriminator">
                  <xsl:element name="case_label">
                    <xsl:if test="not(@value='default')">
                      <xsl:text>case</xsl:text>
                      <xsl:variable name="caseValue">
                        <xsl:call-template name="replace-string">
                            <xsl:with-param name="text">
                                <xsl:call-template name="replace-string">
                                    <xsl:with-param name="text" select="./@value"/>
                                    <xsl:with-param name="search" select="'true'"/>
                                    <xsl:with-param name="replace" select="'TRUE'"/>
                                </xsl:call-template>
                            </xsl:with-param>
                            <xsl:with-param name="search" select="'false'"/>
                            <xsl:with-param name="replace" select="'FALSE'"/>
                        </xsl:call-template>
                      </xsl:variable>
                      <xsl:copy-of select="helper:parseConstExpression($caseValue)"/>
                    </xsl:if>
                    <xsl:if test="./@value='default'">
                      <xsl:text>default</xsl:text>
                    </xsl:if>
                  </xsl:element>
                </xsl:for-each>
              </xsl:element>              
              <xsl:for-each select="./member">
                <xsl:element name="element_spec">
                  <xsl:element name="type_spec">
                    <xsl:call-template name="getType">
                      <xsl:with-param name="member" select="."/>
                    </xsl:call-template>
                  </xsl:element>
                  <xsl:call-template name="parseDeclarator">
                    <xsl:with-param name="name">
                      <xsl:value-of select="./@name"/>
                    </xsl:with-param>
                    <xsl:with-param name="decl" select="."/>
                  </xsl:call-template>
                </xsl:element>
              </xsl:for-each>
            </xsl:element>
            <xsl:if test="./member/@id">
              <xsl:element name="directive">
                <xsl:attribute name="kind">ID</xsl:attribute>
                <xsl:value-of select="./member/@id"/>
              </xsl:element>
            </xsl:if>            
            <xsl:if test="./member/@resolveName">
              <xsl:element name="directive">
                <xsl:attribute name="kind">resolve-name</xsl:attribute>
                <xsl:value-of select="./member/@resolveName"/>
              </xsl:element>
            </xsl:if>
          </xsl:for-each>
        </xsl:element>
      </xsl:element>
    </xsl:element>
    </xsl:element>
    </xsl:element>
    <xsl:if test="./@topLevel">
      <xsl:element name="directive">
        <xsl:attribute name="kind">top-level</xsl:attribute>
        <xsl:value-of select="./@topLevel"/>
      </xsl:element>
    </xsl:if>
    <xsl:if test="./@resolveName">
      <xsl:element name="directive">
        <xsl:attribute name="kind">resolve-name</xsl:attribute>
        <xsl:value-of select="./@resolveName"/>
      </xsl:element>
    </xsl:if>
    <xsl:if test="./@extensibility">
        <xsl:element name="directive">
          <xsl:attribute name="kind">Extensibility</xsl:attribute>
          <xsl:choose>
              <xsl:when test="./@extensibility = 'extensible'">
                 <xsl:text>EXTENSIBLE_EXTENSIBILITY</xsl:text>
              </xsl:when>
              <xsl:when test="./@extensibility = 'mutable'">
                 <xsl:text>MUTABLE_EXTENSIBILITY</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                 <xsl:text>FINAL_EXTENSIBILITY</xsl:text>
              </xsl:otherwise>
          </xsl:choose>
        </xsl:element>
    </xsl:if>
  </xsl:template>


  <!-- Construct the type tree in XMLRAW -->
  <xsl:template name="getType">
    <xsl:param name="member"/>
    <xsl:variable name="type">
      <xsl:value-of select="normalize-space($member/@type)"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$member/@sequenceMaxLength and $member/@sequenceMaxLength!=''">
      	<xsl:call-template name="parseSequence">
      	  <xsl:with-param name="type">
            <xsl:value-of select="$member/@type"/>
          </xsl:with-param>
      	  <xsl:with-param name="nonBasicType">
            <xsl:value-of select="$member/@nonBasicTypeName"/>
          </xsl:with-param>
          <xsl:with-param name="boundary">
            <xsl:choose>
              <xsl:when test="$member/@sequenceMaxLength!='-1'">
                <xsl:value-of select="$member/@sequenceMaxLength"/>
              </xsl:when>
<!--              <xsl:when test="$member/@maxLength">
                <xsl:value-of select="$member/@maxLength"/>
              </xsl:when>-->
            </xsl:choose>
          </xsl:with-param>
      	</xsl:call-template>
      </xsl:when>
      <xsl:when test="$type='boolean'">
        <xsl:element name="simple_type_spec">
          <xsl:element name="base_type_spec">
            <xsl:element name="boolean_type">
              <xsl:text>boolean</xsl:text>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:when>
      <xsl:when test="$type='octet'">
        <xsl:element name="simple_type_spec">
          <xsl:element name="base_type_spec">
            <xsl:element name="octet_type">
              <xsl:text>octet</xsl:text>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:when>
      <xsl:when test="$type='long' or $type='short'">
        <xsl:element name="simple_type_spec">
          <xsl:element name="base_type_spec">
            <xsl:element name="integer_type">
              <xsl:element name="signed_int">
            		<xsl:variable name="signedtype" 
                              select="concat('signed_',$type,'_int')"/>
            		<xsl:element name="{$signedtype}">
                  <xsl:value-of select="$type"/>
                </xsl:element>
      	      </xsl:element>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:when>

      <xsl:when test="$type='longLong'">
        <xsl:element name="simple_type_spec">
          <xsl:element name="base_type_spec">
            <xsl:element name="integer_type">
              <xsl:element name="signed_int">
                <xsl:element name="signed_longlong_int">longlong</xsl:element>
      	      </xsl:element>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:when>
      
      <xsl:when test="$type='unsignedLong' or 
                      $type='unsignedShort' or 
                      $type='unsignedLongLong'">
        <xsl:variable name="unsignedtype">
           <xsl:choose>
            <xsl:when test="$type='unsignedShort'">
              <xsl:value-of select="string('unsigned_short_int')"/>
            </xsl:when>
            <xsl:when test="$type='unsignedLong'">
              <xsl:value-of select="string('unsigned_long_int')"/>
            </xsl:when>
            <xsl:when test="$type='unsignedLongLong'">
              <xsl:value-of select="string('unsigned_longlong_int')"/>
            </xsl:when>
           </xsl:choose>
        </xsl:variable>
        <xsl:variable name="compressedtype">
           <xsl:choose>
            <xsl:when test="$type='unsignedShort'">
              <xsl:value-of select="string('unsignedshort')"/>
            </xsl:when>
            <xsl:when test="$type='unsignedLong'">
              <xsl:value-of select="string('unsignedlong')"/>
            </xsl:when>
            <xsl:when test="$type='unsignedLongLong'">
              <xsl:value-of select="string('unsignedlonglong')"/>
            </xsl:when>
           </xsl:choose>
        </xsl:variable>

        <xsl:element name="simple_type_spec">
          <xsl:element name="base_type_spec">
            <xsl:element name="integer_type">
              <xsl:element name="unsigned_int">
                <xsl:element name="{$unsignedtype}">
                  <xsl:value-of select="$compressedtype"/>
                </xsl:element>
      	      </xsl:element>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:when>

      <xsl:when test="$type='float' or $type='double'">
        <xsl:element name="simple_type_spec">
          <xsl:element name="base_type_spec">
            <xsl:element name="floating_pt_type">
                  <xsl:value-of select="$type"/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:when>

      <xsl:when test="$type='longDouble'">
        <xsl:element name="simple_type_spec">
          <xsl:element name="base_type_spec">
            <xsl:element name="floating_pt_type">
              <xsl:text>longdouble</xsl:text> 
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:when>

      <xsl:when test="$type='char'">
        <xsl:element name="simple_type_spec">
          <xsl:element name="base_type_spec">
            <xsl:element name="char_type">
              <xsl:text>char</xsl:text>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:when>
      <xsl:when test="$type='wchar'">
        <xsl:element name="simple_type_spec">
          <xsl:element name="base_type_spec">
            <xsl:element name="wide_char_type">
              <xsl:text>wchar</xsl:text>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:when>
      <xsl:when test="$type='string'">
        <xsl:call-template name="parseStringType">
          <xsl:with-param name="maxLength">
            <xsl:if test="$member/@stringMaxLength and $member/@stringMaxLength!='-1'">
              <xsl:value-of select="$member/@stringMaxLength"/>
            </xsl:if>
<!--            <xsl:if test="$member/@maxLength">
              <xsl:value-of select="$member/@maxLength"/>
            </xsl:if>-->
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$type='wstring'">
        <xsl:call-template name="parseWideStringType">
          <xsl:with-param name="maxLength">
            <xsl:if test="$member/@stringMaxLength and $member/@stringMaxLength!='-1'">
              <xsl:value-of select="$member/@stringMaxLength"/>
            </xsl:if>
 <!--           <xsl:if test="$member/@maxLength">
              <xsl:value-of select="$member/@maxLength"/>
            </xsl:if>-->
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$type='nonBasic'">
         <xsl:variable name="nonBasicType">
           <xsl:value-of select="normalize-space($member/@nonBasicTypeName)"/>
         </xsl:variable>
	     <xsl:copy-of select="helper:parseTypeSpec($nonBasicType)/type_spec/*"/> 
      </xsl:when>
      <xsl:otherwise>
	     <xsl:copy-of select="helper:parseTypeSpec($type)/type_spec/*"/> 
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="getConstType">
    <xsl:param name="const"/>
    <xsl:variable name="type">
      <xsl:value-of select="$const/@type"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$type='string'">
         <xsl:variable name="maxLength">
           <xsl:choose>
             <xsl:when test="$const/@stringMaxLength and $const/@stringMaxLength!='-1'">
               <xsl:value-of select="$const/@stringMaxLength"/>
             </xsl:when>
<!--             <xsl:otherwise>
               <xsl:value-of select="$const/@maxLength"/>
             </xsl:otherwise>-->
           </xsl:choose>
         </xsl:variable> 
         <xsl:element name="string_type">
          <xsl:text>string</xsl:text>
          <xsl:if test="not(string($maxLength)='')">
            <xsl:element name="positive_int_const">
              <xsl:copy-of select="helper:parseConstExpression($maxLength)"/>
            </xsl:element>
          </xsl:if>
         </xsl:element>

      </xsl:when>
      <xsl:when test="$type='wstring'">

         <xsl:variable name="maxLength">
           <xsl:choose>
             <xsl:when test="$const/@stringMaxLength and $const/@stringMaxLength!='-1'">
               <xsl:value-of select="$const/@stringMaxLength"/>
             </xsl:when>
<!--             <xsl:otherwise>
               <xsl:value-of select="$const/@maxLength"/>
             </xsl:otherwise>-->
           </xsl:choose>
         </xsl:variable> 
         
         <xsl:element name="wide_string_type">
          <xsl:text>wstring</xsl:text>
          <xsl:if test="not(string($maxLength)='')">
            <xsl:element name="positive_int_const">
              <xsl:copy-of select="helper:parseConstExpression($maxLength)"/>
            </xsl:element>
          </xsl:if>
         </xsl:element>

      </xsl:when>
      <xsl:when test="$type='boolean'">
        <xsl:element name="boolean_type">
          <xsl:text>boolean</xsl:text>
        </xsl:element>
      </xsl:when>
      <xsl:when test="$type='octet'">
        <xsl:element name="octet_type">
          <xsl:text>octet</xsl:text>
        </xsl:element>
      </xsl:when>
      <xsl:when test="$type='long' or $type='short'">
        <xsl:element name="integer_type">
         <xsl:element name="signed_int">
           <xsl:variable name="signedtype" 
                          select="concat('signed_',$type,'_int')"/>
             <xsl:element name="{$signedtype}">
           <xsl:value-of select="$type"/>
          </xsl:element>
         </xsl:element>
        </xsl:element>
      </xsl:when>
      <xsl:when test="$type='longLong'">
        <xsl:element name="integer_type">
         <xsl:element name="signed_int">
           <xsl:variable name="signedtype" 
                        select="concat('signed_',$type,'_int')"/>
             <xsl:element name="signed_longlong_int">
              <xsl:text>longlong</xsl:text>
          </xsl:element>
         </xsl:element>
        </xsl:element>
      </xsl:when>
      
      <xsl:when test="$type='unsignedLong' or 
                      $type='unsignedShort' or 
                      $type='unsignedLongLong'">
        <xsl:variable name="unsignedtype">
           <xsl:choose>
            <xsl:when test="$type='unsignedShort'">
              <xsl:value-of select="string('unsigned_short_int')"/>
            </xsl:when>
            <xsl:when test="$type='unsignedLong'">
              <xsl:value-of select="string('unsigned_long_int')"/>
            </xsl:when>
            <xsl:when test="$type='unsignedLongLong'">
              <xsl:value-of select="string('unsigned_longlong_int')"/>
            </xsl:when>
           </xsl:choose>
        </xsl:variable>
        <xsl:variable name="compressedtype">
          <xsl:choose>
            <xsl:when test="$type='unsignedShort'">
              <xsl:value-of select="string('unsignedshort')"/>
            </xsl:when>
            <xsl:when test="$type='unsignedLong'">
              <xsl:value-of select="string('unsignedlong')"/>
            </xsl:when>
            <xsl:when test="$type='unsignedLongLong'">
              <xsl:value-of select="string('unsignedlonglong')"/>
            </xsl:when>
          </xsl:choose>
        </xsl:variable>

        <xsl:element name="integer_type">
          <xsl:element name="unsigned_int">
            <xsl:element name="{$unsignedtype}">
              <xsl:value-of select="$compressedtype"/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
    </xsl:when>

      <xsl:when test="$type='float' or $type='double'">
        <xsl:element name="floating_pt_type">
          <xsl:value-of select="$type"/>
        </xsl:element>
      </xsl:when>

      <xsl:when test="$type='longDouble'">
        <xsl:element name="floating_pt_type">
          <xsl:text>longdouble</xsl:text>
        </xsl:element>
      </xsl:when>

      <xsl:when test="$type='char'">
        <xsl:element name="char_type">
          <xsl:text>char</xsl:text>
        </xsl:element>
      </xsl:when>
      <xsl:when test="$type='wchar'">
        <xsl:element name="wide_char_type">
          <xsl:text>wchar</xsl:text>
        </xsl:element>
      </xsl:when>
      <xsl:when test="$type='nonBasic'">
         <xsl:variable name="nonBasicType">
           <xsl:value-of select="$const/@nonBasicTypeName"/>
         </xsl:variable>
	     <xsl:copy-of select="helper:parseScopedName($nonBasicType)"/> 
      </xsl:when>
      <xsl:otherwise>
        <!--<xsl:call-template name="getType">
          <xsl:with-param name="member" select="$const"/>
        </xsl:call-template>-->
        <xsl:copy-of select="helper:parseScopedName($type)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template name="parseStringType">
    <xsl:param name="maxLength"/>
    <xsl:element name="simple_type_spec">
      <xsl:element name="template_type_spec">
        <xsl:element name="string_type">
          <xsl:text>string</xsl:text>
            <xsl:if test="not(string($maxLength)='')">
              <xsl:element name="positive_int_const">
                    <xsl:copy-of select="helper:parseConstExpression($maxLength)"/>
              </xsl:element>
            </xsl:if>
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>


  <xsl:template name="parseWideStringType">
    <xsl:param name="maxLength"/>
    <xsl:element name="simple_type_spec">
      <xsl:element name="template_type_spec">
        <xsl:element name="wide_string_type">
          <xsl:text>wstring</xsl:text>
          <xsl:if test="not(string($maxLength)='')">
            <xsl:element name="positive_int_const">
              <xsl:copy-of select="helper:parseConstExpression($maxLength)"/>
            </xsl:element>
          </xsl:if>
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>


  <xsl:template name="checkConstDecl">
    <xsl:if test="not(@type and @name and @value)">
 <xsl:message terminate="yes">The const type is not valid</xsl:message>
    </xsl:if>
  </xsl:template>


 <xsl:template name="checkMember">

   <xsl:param name="member"/>
    <xsl:if test="./@bitField and ./@arrayDimensions">
<xsl:message terminate="yes">
It's not possible to have bitfield and array declarator on the same declaration
</xsl:message>
    </xsl:if>

<!--    <xsl:if test="$member/@maxLength and ($member/@stringMaxLength or $member/@sequenceMaxLength)">
<xsl:message terminate="yes">
'maxLength' is incompatible with 'stringMaxLength' and 'sequenceMaxLength'
</xsl:message>
    </xsl:if>-->
  </xsl:template>

  <xsl:template name="parseSequence">
  <xsl:param name="type"/>
  <xsl:param name="nonBasicType"/>
  <xsl:param name="boundary"/>
    <xsl:element name="simple_type_spec">
      <xsl:element name="template_type_spec">
        <xsl:element name="sequence_type">
          <xsl:text>sequence</xsl:text>
          <xsl:call-template name="parseSimpleType">
            <xsl:with-param name="type">
              <xsl:value-of select="$type"/>
            </xsl:with-param>
            <xsl:with-param name="nonBasicType">
              <xsl:value-of select="$nonBasicType"/>
            </xsl:with-param>
          </xsl:call-template>
          <xsl:choose>
            <xsl:when test="$boundary!=''">
              <xsl:element name="opt_pos_int">
                <xsl:copy-of select="helper:parsePosInt($boundary)"/>
              </xsl:element>
            </xsl:when>
            <xsl:otherwise>
              <xsl:element name="opt_pos_int"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template name="parseDeclarator">
    <xsl:param name="name"/>
    <xsl:param name="decl"/>
    <xsl:element name="declarator">
      <xsl:if test="$decl/@pointer='true' or $decl/@pointer='1'">
      	<xsl:element name="pointer">
      	  <xsl:text>*</xsl:text>
      	</xsl:element>
      </xsl:if>
      <xsl:if test="not(string($name)='')">
        <xsl:element name="identifier">
          <xsl:value-of select="$name"/>
        </xsl:element>
      </xsl:if>
      <!-- Bitfield Operator : -->
      <xsl:if test="$decl/@bitField">
        <xsl:element name="colon"/>
        <xsl:copy-of select="helper:parseConstExpression($decl/@bitField)"/>
      </xsl:if><!-- Array operator [] -->
      <xsl:if test="not($decl/@bitField)">
        <xsl:element name="opt_fixed_array_size">
          <xsl:call-template name="processCardinality">
            <xsl:with-param name="dimensionValue" select="./@arrayDimensions"/>
          </xsl:call-template>
        </xsl:element>
      </xsl:if>
    </xsl:element>
  </xsl:template>


  <xsl:template name="processCardinality">
    <xsl:param name="dimensionValue"/>
    <xsl:variable name="arrayDimensions" select="normalize-space($dimensionValue)"/>
    <xsl:if test="contains($arrayDimensions,',')">
      <xsl:variable name="firstDimension" select="substring-before($arrayDimensions,',')"/>
      <xsl:element name="fixed_array_size">
        <xsl:element name="positive_int_const">
           <xsl:copy-of select="helper:parseConstExpression($firstDimension)"/>
        </xsl:element>        
      </xsl:element>
      <xsl:call-template name="processCardinality">
        <xsl:with-param name="dimensionValue" select="substring-after($arrayDimensions,',')"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="not(contains($arrayDimensions,',')) and not($arrayDimensions='')">
      <xsl:element name="fixed_array_size">
        <xsl:element name="positive_int_const">
           <xsl:copy-of select="helper:parseConstExpression($arrayDimensions)"/>
        </xsl:element>        
      </xsl:element>
    </xsl:if>
  </xsl:template>

  <xsl:template name="parseSimpleType">
  <xsl:param name="type"/>
  <xsl:param name="nonBasicType"/>
    <xsl:choose>
      <xsl:when test="$type='boolean'">
        <xsl:element name="simple_type_spec">
          <xsl:element name="base_type_spec">
            <xsl:element name="boolean_type">
              <xsl:text>boolean</xsl:text>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:when>
      <xsl:when test="$type='octet'">
        <xsl:element name="simple_type_spec">
          <xsl:element name="base_type_spec">
            <xsl:element name="octet_type">
              <xsl:text>octet</xsl:text>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:when>
      <xsl:when test="$type='long' or $type='short'">
        <xsl:element name="simple_type_spec">
          <xsl:element name="base_type_spec">
            <xsl:element name="integer_type">
              <xsl:element name="signed_int">
            		<xsl:variable name="signedtype" 
                              select="concat('signed_',$type,'_int')"/>
            		<xsl:element name="{$signedtype}">
                  <xsl:value-of select="$type"/>
                </xsl:element>
      	      </xsl:element>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:when>
 
      <xsl:when test="$type='longLong'">
        <xsl:element name="simple_type_spec">
          <xsl:element name="base_type_spec">
            <xsl:element name="integer_type">
              <xsl:element name="signed_int">
            		<xsl:element name="signed_longlong_int">
                  <xsl:text>longlong</xsl:text>
                </xsl:element>
      	      </xsl:element>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:when>     

      <xsl:when test="$type='unsignedLong' or 
                      $type='unsignedShort' or 
                      $type='unsignedLongLong'">
        <xsl:variable name="unsignedtype">
           <xsl:choose>
            <xsl:when test="$type='unsignedShort'">
              <xsl:value-of select="string('unsigned_short_int')"/>
            </xsl:when>
            <xsl:when test="$type='unsignedLong'">
              <xsl:value-of select="string('unsigned_long_int')"/>
            </xsl:when>
            <xsl:when test="$type='unsignedLongLong'">
              <xsl:value-of select="string('unsigned_longlong_int')"/>
            </xsl:when>
           </xsl:choose>
        </xsl:variable>
        <xsl:variable name="compressedtype">
           <xsl:choose>
            <xsl:when test="$type='unsignedShort'">
              <xsl:value-of select="string('unsignedshort')"/>
            </xsl:when>
            <xsl:when test="$type='unsignedLong'">
              <xsl:value-of select="string('unsignedlong')"/>
            </xsl:when>
            <xsl:when test="$type='unsignedLongLong'">
              <xsl:value-of select="string('unsignedlonglong')"/>
            </xsl:when>
           </xsl:choose>
        </xsl:variable>

        <xsl:element name="simple_type_spec">
          <xsl:element name="base_type_spec">
            <xsl:element name="integer_type">
              <xsl:element name="unsigned_int">
            		<xsl:element name="{$unsignedtype}">
                  <xsl:value-of select="$compressedtype"/>
                </xsl:element>
      	      </xsl:element>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:when>

      <xsl:when test="$type='float' or $type='double'">
        <xsl:element name="simple_type_spec">
          <xsl:element name="base_type_spec">
            <xsl:element name="floating_pt_type">
                  <xsl:value-of select="$type"/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:when>
      <xsl:when test="$type='longDouble'">
        <xsl:element name="simple_type_spec">
          <xsl:element name="base_type_spec">
            <xsl:element name="floating_pt_type">
              <xsl:text>longdouble</xsl:text>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:when>
      <xsl:when test="$type='char'">
        <xsl:element name="simple_type_spec">
          <xsl:element name="base_type_spec">
            <xsl:element name="char_type">
              <xsl:text>char</xsl:text>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:when>
      <xsl:when test="$type='wchar'">
        <xsl:element name="simple_type_spec">
          <xsl:element name="base_type_spec">
            <xsl:element name="wide_char_type">
              <xsl:text>wchar</xsl:text>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:when>
      <xsl:when test="$type='string'">
        <xsl:variable name="maxLength">
           <xsl:choose>
             <xsl:when test="./@stringMaxLength and ./@stringMaxLength!='-1'">
               <xsl:value-of select="./@stringMaxLength"/>
             </xsl:when>
<!--             <xsl:otherwise>
               <xsl:value-of select="./@maxLength"/>
             </xsl:otherwise>-->
          </xsl:choose>
        </xsl:variable>
        <xsl:call-template name="parseStringType">
          <xsl:with-param name="maxLength">
            <xsl:value-of select="$maxLength"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$type='wstring'">
        <xsl:variable name="maxLength">
           <xsl:choose>
             <xsl:when test="./@stringMaxLength and ./@stringMaxLength!='-1'">
               <xsl:value-of select="./@stringMaxLength"/>
             </xsl:when>
<!--             <xsl:otherwise>
               <xsl:value-of select="./@maxLength"/>
             </xsl:otherwise>-->
          </xsl:choose>
        </xsl:variable>

        <xsl:call-template name="parseWideStringType">
          <xsl:with-param name="maxLength">
            <xsl:value-of select="$maxLength"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="$type='nonBasic'">
        <simple_type_spec>
          <xsl:copy-of select="helper:parseScopedName($nonBasicType)"/>
        </simple_type_spec>
      </xsl:when>
      <xsl:otherwise>
        <simple_type_spec>
          <xsl:copy-of select="helper:parseScopedName($type)"/>
        </simple_type_spec>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- Switch type -->
  <!-- The parser has some problems when we only have
	one token to parse (it's expects more symbols)
	The solution is to capture the one element non-terminal symbols-->
  <xsl:template name="parseSwitchType">
    <xsl:param name="switchtype"/>
    <xsl:choose>
      <xsl:when test="$switchtype='long' or $switchtype='short'">
        <xsl:element name="integer_type">
          <xsl:element name="signed_int">
 	    <xsl:variable name="inttype" select="concat('signed_',$switchtype,'_int')"/>
            <xsl:element name="{$inttype}">
              <xsl:value-of select="$switchtype"/> 
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:when>
      <xsl:when test="starts-with($switchtype,'unsigned')">
        <xsl:element name="integer_type">
          <xsl:element name="unsigned_int">
 	          <xsl:variable name="inttype" 
                          select="concat('unsigned_',
                                  substring-after($switchtype,'unsigned'),
                                  '_int')"/>
            <xsl:element name="{$inttype}">
              <xsl:value-of select="$switchtype"/> 
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:when>
      <xsl:when test="$switchtype='char'">
        <xsl:element name="char_type">
      		<xsl:text>char</xsl:text>
        </xsl:element>
      </xsl:when>
      <xsl:when test="$switchtype='boolean'">
        <xsl:element name="boolean_type">
          <xsl:text>boolean</xsl:text>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise> <!-- parse -->
        <xsl:copy-of select="helper:parseSwitchType($switchtype)/switch_type_spec/*"/> 
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:transform>
