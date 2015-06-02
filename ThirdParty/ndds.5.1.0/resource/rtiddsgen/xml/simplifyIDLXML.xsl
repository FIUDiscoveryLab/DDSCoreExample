<?xml version="1.0"?>
<!-- 
/* $Id: simplifyIDLXML.xsl,v 1.24 2013/10/25 00:13:22 roshan Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
modification history:
- - - - - - - - - - 
5.1.0,24oct13,rk    Updated the algorithm to add L/LL suffix to only handle Java and C++.
5.1.0,07oct13,rk    Fixed CODEGEN-598: Generated C++ code does not compile without 
                           the LL suffix.
5.0.1,11apr13,acr CODEGEN-573: parse 'optional' directive
5.0.1,21apr13,fcs CODEGEN-507: Fixed directive rule
5.0.1,26mar13,fcs Fixed CODEGEN-507: RTIDDSGEN copies the directives of included 
                  files into the main file
5.0.0,10dec12,fcs Fixed CODEGEN-532: The XML files generated using the 
                  -convertXml option may not be compatible with previous 
                  releases
5.0.0,13oct12,fcs Fixed memberID annotation for valuetypes
5.0.0,10oct12,fcs Member ID support in ext types
5.0.0,10jul12,fcs Mutable union support
10af,29jun11,fcs Fixed memberID assign for seq and str
10af,28jun11,fcs Fixed memberID assignment with base structs
10af,12jun11,fcs Fixed calculation of auto values for bitsets
10af,09jun11,fcs CXTYPES-88: Generate XML and XSD code for new features in Phase 1
10af,10jun11,fcs Fixed getMemberId
10af,09jun11,fcs Fixed struct inheritance
10af,11may11,ai  XTypes: In the struct tempate, fixed issue with baseClassName 
                when defined inside a module.
10af,13apr11,ai  Added support for bitsets
10af,06apr11,ai  Xtypes: added templates for struct inheritance and mutable types 
10ae,29jan11,fcs Performance optimizations
10ae,21nov10,fcs Fixed bug 13783
10ae,21nov10,fcs Fixed bug 13719
10ae,24aug10,fcs Fixed enumerations for ADA
10ae,28jul10,fcs Fixed line_dcl with comments issue
10ae,14jul10,fcs Fixed bug 13496
10ae,07jul10,fcs Fixed bug 13472
10ae,28may10,fcs ADA support
10ae,10apr10,fcs Added validateMetp option
10ae,27feb10,fcs Fixed bug 13311
10ad,12jan10,fcs Fixed bug 13239
10ad,05jan09,fcs Changes to support include with angle brackets
10ad,21dec09,fcs verbosity support
10ad,21dec09,fcs IDL3+ support
10ac,23sep09,fcs Fixed 13130
10y,26mar09,fcs Added enumCount
10y,31oct08,jlv Added boundedStr attribute, to distinguise bounded and unbounded
                strings.
10y,24oct08,fcs Fixed bug 12560
10y,17sep08,jlv Fixed $idlFileName and specification template.
                Added changeFileExtension template. Now files with more than one
                dot in the name (or with an extension different to 'idl') are allowed.
10x,08may08,rbw Fixed C++/CLI booleal literal names
10v,09apr08,rbw Fixed typos in warning messages
10v,11mar08,rbw Added support for C++/CLI enums
10s,11feb08,fcs Fixed bug 12116
10s,05feb08,fcs Added keyedBaseClass attribute to value types
10s,25jan08,jpm Fixed $idlFileName when does not have extension
10s, 21jan08,jpm Input XML changes
10m,09aug07,fcs Fixed bug 11927
10m,09feb07,fcs Fixed bug 11743
10m,09feb07,fcs Fixed bug 11741
10m,16oct06,fcs Fixed bug 11514
10m,11aug06,fcs Fixed Java enums with prefix
10m,11aug06,fcs Fixed Java enums
10m,11aug06,fcs Fixed case label with parenthesis
10m,25jul06,fcs Fixed bug 11213
10m,18jul06,fcs Constant support inside value types
10m,01jul06,fcs Fixed forward declarations bug
10m,01jul06,fcs Detection of duplicates types
10m,27jun06,fcs Fixed bug 11173
10l,01may06,fcs Merged from BRANCH_NDDSGEN_JAVA_CORBA
10l,28apr06,fcs Simplified symbolDefined template
10l,20apr06,fcs Fixed bug 10929
10l,19apr06,fcs References to box value types and abstract value types are ignored
                without the -corba option
10l,19apr06,fcs References to interfaces are ignored without the -corba option
10l,13apr06,fcs Added warning for interfaces
10l,13apr06,fcs Changed value type search condition in isValueTypeOrInterface
                template
10l,13apr06,fcs Changed symbolDefined template to include interfaces
10l,13apr06,fcs Fixed a problem ignoring references to valuetypes in a
                typedef
10l,10apr06,fcs The references to value types/interfaces are ignored 
                with the -corba option
10l,12mar06,fcs Added visibility attribute to value type members
10l,12mar06,fcs Added typeModifier attribute to value types
10h,27feb06,fcs Value types are ignored with the -corba option
10h,28jan06,fcs Preprocessor support
10h,19jan06,fcs Added unbounded attribute to sequences members
                (This attribute will be used with the -corba option)
10h,13dec05,fcs Fixed base class bug for Java value types                
10h,08dec05,fcs Fixed constant bug when resolve-name is false        
10h,08dec05,fcs C++ namespace support        
10h,06dec05,fcs Added language variable        
10h,06dec05,fcs Value types support        
10h,02dec05,fcs Updated to be compatible with the CORBA 3.0.3 IDL Specification
40b,02aug05,fcs Added xml parameter to generate xml user output
40b,19may05,fcs Supported pointers with C Style
40b,14apr05,fcs Changed namespaceSeparator to '::' for CORBA
40b,09apr05,fcs Processed directives inside the modules                
40b,08apr05,fcs BUG 8047: If the IDL file contains declarations that include the types
                'int' or 'bool' we give an error message suggesting the proper
                replacement.
40b,06apr05,fcs * Constant expressions that include boolean values generate now a proper value
                For Java TRUE is mapped to true and FALSE is mapped to false
                For C/C++ TRUE is mapped to DDS_BOOLEAN_TRUE and FALSE is mapped to
                DDS_BOOLEAN_FALSE                
                
                * Added code to avoid redefinitions of types in typedef:
                
                  typedef struct MyStruct{
                  }MyStruct;
                  
40b,31mar05,fcs Allowed resolve-name directive. 
                This directive is used to indicate to nddsgen if it should resolve the scope.
                When this directive is not present nddsgen resolves the scope.
40b,23mar05,fcs a) Introduced the parameters languageOption and corbaHeader
                These parameter will be used to generate an intermediate file compatible
                with the output language
                For instance, the seprator for qualified names is different in Java,C and C++
                b) Declared "namespaceSeparator" variable to build the qualified names for each language
                c) Renamed symbolToCFormat to symbolToLanguageFormat (more generic)
                d) Refecatored Constant/Type resolution process                   
                e) Obtained qualified name for union discriminator
                f) Added isEnum
                g) Fixed bug in the function getMemberKind. 
                   To check for an array we need to check the element fixed_array_size (not cardinality) 
40b,16mar05,fcs a) Simplified XML document refactoring
                b) Support for multiple unions in the same IDL file
                There was a bug when parsing unions. The line:
                    <xsl:apply-templates select="//element_spec"/>
                has been changed to:
                    <xsl:apply-templates select=".//element_spec"/>                                    
40b,11feb04,rrl Support //@ directives
40b,03feb04,rrl Modify schema for typedef to align with struct member
                (to make code generation vastly easier).
40b,14jan04,rrl Support unions
40b,29dec03,rrl Support enums with values (typedef support in progress)
40a,24oct03,eys Added enum support
40a,06sep03,rrl Align schema documentation to the recent changes.
40a,04sep03,rrl Change "length" attribute to seqence type to "maxLength"
40a,04sep03,rrl Fix problem with string types with bounds specified.
40a,03sep03,rrl Support #include preprocessor directive.
40a,27aug03,rrl Added support for sequences, fixed length string, wstring type,
                expression for constants (used in array size, sequence lengths,
                string lengths)
40a,18aug02,rrl Added documentation.
-->

<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xalan = "http://xml.apache.org/xalan" version="1.0" 
        xmlns:mathParser="com.rti.ndds.nddsgen.transformation.MathParser"
               extension-element-prefixes="mathParser"
               exclude-result-prefixes="mathParser">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:variable name="node">
        <node></node>
    </xsl:variable>

    <xsl:include href="utils.xsl"/>

    <xsl:param name="verbosity"/>
    <xsl:param name="idlFileName"/>
    <xsl:param name="idlFilePath"/> <!-- Path to the idl file -->
    <xsl:param name="languageOption"/>    
    <xsl:param name="corbaHeader"/>        
    <xsl:param name="stringSize"/> <!-- default size for unbounded strings -->
    <xsl:param name="sequenceSize"/> <!-- default size for unbounded sequences --> 
    <xsl:param name="packagePrefix"/> <!-- This parameter is used only if the language is Java -->
    <xsl:param name="xml"/> <!-- This parameter is used to generate user XML output -->
    <xsl:param name="namespace"/> <!-- Parameter used to generate C++ namespaces -->
    <xsl:param name="preprocessor"/> <!-- Parameter that indicates if the preprocessor is run or not. Values are 0 or 1 -->
    <xsl:param name="doIncludes"/> <!-- Copy any includes in to the output -->

    <xsl:variable name="sourceFileName">
      <xsl:call-template name="changeFileExtension">
        <xsl:with-param name="fileName" select="$idlFileName"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="language">
        <xsl:choose>
            <xsl:when test="$languageOption='C' or $languageOption='c'">C</xsl:when>                        
            <xsl:when test="$languageOption='C++' or
                            $languageOption='c++' or
                            $languageOption='C++/CLI'">C++</xsl:when>                        
            <xsl:when test="$languageOption='Ada'">ADA</xsl:when>
            <xsl:otherwise>JAVA</xsl:otherwise>
        </xsl:choose>                
    </xsl:variable>        
    <xsl:variable name="isManagedCpp">
        <xsl:choose>
            <xsl:when test="$languageOption='C++/CLI'">yes</xsl:when>                        
            <xsl:otherwise>no</xsl:otherwise>
        </xsl:choose>                
    </xsl:variable>
            
    <xsl:variable name="infoFile">
        <xsl:choose>
            <xsl:when test="$language='C'">
                <xsl:value-of select="'generation-info.c.xml'"/>
            </xsl:when>
            <xsl:when test="$language='C++'">
                <xsl:choose>
                    <xsl:when test="$isManagedCpp='yes'">
                        <xsl:value-of select="'generation-info.cppcli.xml'"/>
                    </xsl:when>
                    <xsl:when test="$corbaHeader!='none'">
                        <xsl:value-of select="'generation-info.cxx.corba.xml'"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="'generation-info.c.xml'"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="$language='JAVA'">
                <xsl:choose>
                    <xsl:when test="$corbaHeader='none'">
                        <xsl:value-of select="'generation-info.java.xml'"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="'generation-info.java.corba.xml'"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="$language='ADA'">
                <xsl:value-of select="'generation-info.ada.xml'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="fail">
                	<xsl:with-param
                	    name="message"
                	    select="concat('Unrecognized language: ', $language)"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:template name="fail">
        <xsl:param name="message"></xsl:param>
        <xsl:message terminate="yes">
            <xsl:value-of select="$message"/>
        </xsl:message>
    </xsl:template>
    
    <xsl:variable name="namespaceSeparator">
        <xsl:choose>
            <xsl:when test="$xml = 'yes'">                
                <xsl:value-of select="'::'"/>
            </xsl:when>
            <xsl:when test="$language = 'C'">                
                <xsl:value-of select="'_'"/>
            </xsl:when>
            <xsl:when test="$language = 'C++'">  
                <xsl:if test="$namespace='yes'">
                    <xsl:value-of select="'::'"/>
                </xsl:if>
                <xsl:if test="$namespace='no'">
                    <xsl:if test="$corbaHeader='none'">
                        <xsl:value-of select="'_'"/>                
                    </xsl:if>
                    <!-- with CORBA we always use C++ namespaces -->                        
                    <xsl:if test="$corbaHeader!='none'"> 
                        <xsl:value-of select="'::'"/>                
                    </xsl:if>            
                </xsl:if>                        
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="'.'"/>                                        
            </xsl:otherwise>
        </xsl:choose>                     
    </xsl:variable>

    <xsl:variable name="generateValueTypeCode">
        <xsl:choose>
            <xsl:when test="not(($language = 'C++' or $language = 'JAVA') and $corbaHeader != 'none')">
                <xsl:value-of select="1"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="0"/>
            </xsl:otherwise>
        </xsl:choose>                
    </xsl:variable>
            
    <xsl:variable name="generationInfo" select="document($infoFile)/generationInfo"/>
    <xsl:variable name="typeInfoMap" select="$generationInfo/typeInfoMap"/>

    <xsl:variable name="ddsIdl">
        <xsl:choose>
            <xsl:when test="//interf">
                <xsl:value-of select="'no'"/>
            </xsl:when>
            <xsl:when test="//value_abs_dcl">
                <xsl:value-of select="'no'"/>
            </xsl:when>
            <xsl:when test="//value_box">
                <xsl:value-of select="'no'"/>
            </xsl:when>
            <xsl:when test="($language = 'C++' or $language = 'JAVA') and $corbaHeader != 'none'">
                <xsl:value-of select="'no'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="'yes'"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <!--
    =================================================================================================
    Default rule: This allows to apply pass-through filter for all elements that we aren't interested. 
    =================================================================================================
    -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <!--
    =============
    line_dcl
    =============
    -->
    <!-- 
    Some preprocessors (such as MinGW cpp) remove comments from the preprocessed file.
    In this case, we may end up with line_dcl within modules.
    The following template ignores these line_dcl
    -->
    <xsl:template match="line_dcl"/>

    <!--
    =============
    Definition
    =============
    -->
    <xsl:template match="definition">
        <xsl:choose>
            <xsl:when test="$doIncludes = 'yes'">
                <xsl:apply-templates/> 
            </xsl:when>
            <xsl:when test="../definition/line_dcl">
                <xsl:if test="contains((./preceding-sibling::definition/line_dcl)[position()=last()],
                                       concat('&quot;',$idlFilePath,'&quot;'))">
                    <xsl:if test="not(./line_dcl)">
                        <xsl:apply-templates/>
                    </xsl:if>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/> 
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- 
    ==================
    Module declaration
    ================== 
    Skip all child elements except descendant of definition/* (which are modules and structs)             
    -->
    
    <xsl:template match="module">     
        <module name="{identifier}">
            <xsl:apply-templates select="definition/*|directive"/>
        </module>
    </xsl:template>
    
    <!--
    =============
    Specification
    =============
    -->
    <xsl:template match="specification">
        <specification idlFileName="{$sourceFileName}">
            <xsl:apply-templates/>
        </specification>
    </xsl:template>

    <!-- 
    =====================
    Constant declarations
    ===================== 
    -->
    <xsl:template match="const_dcl">
        <xsl:call-template name="checkDuplicateType">
            <xsl:with-param name="typeNode" select="."/>
        </xsl:call-template>

        <xsl:variable name="resolveName">
            <xsl:call-template name="resolveName">
                <xsl:with-param name="node" select="."/> 
            </xsl:call-template>
        </xsl:variable>            

        <xsl:variable name="value">
            <xsl:call-template name="obtainConstExpr">
                <xsl:with-param name="expressionTree" select="const_exp"/>
            </xsl:call-template>
        </xsl:variable>                        

        <xsl:variable name="constType">
            <xsl:call-template name="obtainConstType">
                <xsl:with-param name="constTypeNode" select="./const_type"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="constTypeC">
            <xsl:call-template name="symbolToLanguageFormat">
                <xsl:with-param name="symbol" select="$constType"/>
                <xsl:with-param name="resolveName" select="$resolveName"/>                
            </xsl:call-template>
        </xsl:variable>
                
    	<const type="{$constTypeC}" name="{identifier}" value="{$value}">
            <xsl:call-template name="getEquivalentType">
                <xsl:with-param name="currentType" select="$constType"/>                        
                <xsl:with-param name="lastNode"    select="xalan:nodeset($node)/node()"/>
            </xsl:call-template>
        </const>
    </xsl:template>

    <!--
    ====================
    Typedef declarations 
    ====================
    -->	
            
    <xsl:template match="type_dcl[text() = 'typedef']">
        <xsl:variable name="type_declarator" select="./type_declarator"/>
        
        <xsl:variable name="constr_type_spec" select="./type_declarator/type_spec/constr_type_spec"/>

        <!-- This checking doesn't allow constructs like:
             typedef struct MyStruct{
             }MyStruct;
        -->
        <xsl:for-each select="./type_declarator/declarators/declarator">
            <xsl:if test="./identifier=$constr_type_spec/child::node()/identifier/text()=./identifier/text()">
                <xsl:message  terminate="yes">
Error: Redefinition of <xsl:value-of select="./identifier/text()"/>
                </xsl:message>                                                            
            </xsl:if>                                                   
        </xsl:for-each>               

        <xsl:if test="./type_declarator/type_spec/constr_type_spec"> <!-- Typedef of structures,unions or enums -->
            <xsl:apply-templates select="./type_declarator/type_spec/constr_type_spec/node()"/>                
            <xsl:apply-templates select="./../following-sibling::node()[position()=1 and name(.)='directive']"/>
        </xsl:if>
        
        <xsl:variable name="resolveName">
            <xsl:call-template name="resolveName">
                <xsl:with-param name="node" select="$type_declarator"/> 
            </xsl:call-template>
        </xsl:variable>            

        <xsl:variable name="type">
            <xsl:call-template name="obtainStructMemberType">
                <xsl:with-param name="typeSpecNode" select="$type_declarator/type_spec"/>
                <xsl:with-param name="resolveName" select="$resolveName"/>                
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="ignoreTypeReference">
            <xsl:call-template name="ignoreTypeReference">
                <xsl:with-param name="qualifiedType" select="$type"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:if test="$ignoreTypeReference = 'no'">
            <xsl:for-each select="./type_declarator/declarators/declarator">        
                <xsl:variable name="isPointer">
                    <xsl:if test="./pointer">yes</xsl:if>
                    <xsl:if test="not(./pointer)">no</xsl:if>
                </xsl:variable>
                <typedef name="{./identifier}">
          	    <xsl:apply-templates select="$type_declarator">
                        <xsl:with-param name="pointer" select="$isPointer"/>
          	    </xsl:apply-templates>
                </typedef>            
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="type_declarator">
        <xsl:param name="pointer" select="'no'"/>
        <xsl:variable name="resolveName">
            <xsl:call-template name="resolveName">
                <xsl:with-param name="node" select="."/> 
            </xsl:call-template>
        </xsl:variable>            

        <xsl:variable name="type">
    	    <xsl:call-template name="obtainStructMemberType">
    	        <xsl:with-param name="typeSpecNode" select="type_spec"/>
                <xsl:with-param name="resolveName" select="$resolveName"/>                
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:variable name="typeC">
    	    <xsl:call-template name="symbolToLanguageFormat">
    	        <xsl:with-param name="symbol" select="$type"/>
                <xsl:with-param name="resolveName" select="$resolveName"/>                
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:variable name="isEnum">
    	    <xsl:call-template name="isEnum">
                <xsl:with-param name="qualifiedType" select="$type"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="enumeratorCount">
            <xsl:call-template name="getEnumeratorCount">
                <xsl:with-param name="qualifiedType" select="$type"/>
            </xsl:call-template>
        </xsl:variable>

        <member type="{$typeC}" enum="{$isEnum}" pointer="{$pointer}">
            <xsl:if test="$isEnum = 'yes'">
                <xsl:attribute name="enumCount">
                    <xsl:value-of select="$enumeratorCount"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select=".//opt_fixed_array_size[.//fixed_array_size]"/>
            <xsl:call-template name="getEquivalentType">
                <xsl:with-param name="currentType" select="$type"/>                        
                <xsl:with-param name="lastNode"    select="xalan:nodeset($node)/node()"/>                        
            </xsl:call-template>                        
        </member>

    </xsl:template> 
    
    <xsl:template match="type_declarator[.//declarators[.//declarator[.//colon]]]">
        <xsl:variable name="resolveName">
            <xsl:call-template name="resolveName">
                <xsl:with-param name="node" select="."/> 
            </xsl:call-template>
        </xsl:variable>            

        <xsl:variable name="type">
    	    <xsl:call-template name="obtainStructMemberType">
    	        <xsl:with-param name="typeSpecNode" select="type_spec"/>
                <xsl:with-param name="resolveName" select="$resolveName"/>                                
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:variable name="typeC">
    	    <xsl:call-template name="symbolToLanguageFormat">
    	        <xsl:with-param name="symbol" select="$type"/>
                <xsl:with-param name="resolveName" select="$resolveName"/>                                
            </xsl:call-template>
        </xsl:variable>
        
    	<xsl:variable name = "bits">
    	    <xsl:call-template name="obtainConstExpr">
                <xsl:with-param name="expressionTree" select=".//const_exp"/>
            </xsl:call-template>
    	</xsl:variable>
        
        <xsl:variable name="isEnum">
    	    <xsl:call-template name="isEnum">
                <xsl:with-param name="qualifiedType" select="$type"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="enumeratorCount">
            <xsl:call-template name="getEnumeratorCount">
                <xsl:with-param name="qualifiedType" select="$type"/>
            </xsl:call-template>
        </xsl:variable>
                            	
        <member bitField="{$bits}" type="{$typeC}" enum="{$isEnum}">
            <xsl:if test="$isEnum = 'yes'">
                <xsl:attribute name="enumCount">
                    <xsl:value-of select="$enumeratorCount"/>
                </xsl:attribute>
            </xsl:if>
      	    <xsl:apply-templates select=".//opt_fixed_array_size[.//fixed_array_size]"/>
            <xsl:call-template name="getEquivalentType">
                <xsl:with-param name="currentType" select="$type"/>                        
                <xsl:with-param name="lastNode"    select="xalan:nodeset($node)/node()"/>                        
            </xsl:call-template>                           
        </member>    
    </xsl:template>
    
    <xsl:template match="type_declarator[.//sequence_type | type_spec//string_type |
		                                 type_spec//wide_string_type]">
        <xsl:param name="pointer" select="'no'"/>        
        <xsl:variable name="resolveName">
            <xsl:call-template name="resolveName">
                <xsl:with-param name="node" select="."/>
            </xsl:call-template>
        </xsl:variable>            

        <xsl:variable name="type">
    	    <xsl:call-template name="obtainStructMemberType">
    	        <xsl:with-param name="typeSpecNode" select="type_spec"/>
                <xsl:with-param name="resolveName" select="$resolveName"/>                                                
            </xsl:call-template>
        </xsl:variable>
                
        <xsl:variable name="typeC">
    	    <xsl:call-template name="symbolToLanguageFormat">
    	        <xsl:with-param name="symbol" select="$type"/>
                <xsl:with-param name="resolveName" select="$resolveName"/>                                                
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:variable name="isEnum">
    	    <xsl:call-template name="isEnum">
                <xsl:with-param name="qualifiedType" select="$type"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="enumeratorCount">
            <xsl:call-template name="getEnumeratorCount">
                <xsl:with-param name="qualifiedType" select="$type"/>
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:variable name="lengthSequence">
            <xsl:if test=".//sequence_type">                
                <xsl:call-template name="obtainConstExpr">
                    <xsl:with-param name="expressionTree" select=".//sequence_type/opt_pos_int//const_exp"/>
                </xsl:call-template>
            </xsl:if>
        </xsl:variable>                
        
        <xsl:variable name="lengthString">
            <xsl:call-template name="getStringLength">
                <xsl:with-param name="type_spec_node" select="type_spec"/>    
            </xsl:call-template>                                                                
        </xsl:variable>
                       
        <member type="{$typeC}" enum="{$isEnum}" pointer="{$pointer}">
            <xsl:if test="$isEnum = 'yes'">
                <xsl:attribute name="enumCount">
                    <xsl:value-of select="$enumeratorCount"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test=".//sequence_type">
                <xsl:attribute name="kind">sequence</xsl:attribute>
                <xsl:attribute name="maxLengthSequence">
                    <xsl:if test="$lengthSequence!=''">
                        <xsl:value-of select="$lengthSequence"/>
                    </xsl:if>
                    <xsl:if test="$lengthSequence=''">
                        <xsl:value-of select="$sequenceSize"/>
                    </xsl:if>                    
                </xsl:attribute>
                <xsl:attribute name="bounded">
                    <xsl:if test="$lengthSequence!=''">
                        <xsl:value-of select="'yes'"/>
                    </xsl:if>
                    <xsl:if test="$lengthSequence=''">
                        <xsl:value-of select="'no'"/>
                    </xsl:if>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="type_spec//string_type | type_spec//wide_string_type">
                <xsl:attribute name="maxLengthString">
                    <xsl:if test="$lengthString!=''">
                        <xsl:value-of select="$lengthString"/>
                    </xsl:if>
                    <xsl:if test="$lengthString=''">
                        <xsl:value-of select="$stringSize"/>
                    </xsl:if>                                            
                </xsl:attribute>
                <xsl:if test="$lengthString!=''">
                    <xsl:attribute name="boundedStr">yes</xsl:attribute>
                </xsl:if>
                <xsl:if test="$lengthString=''">
                    <xsl:attribute name="boundedStr">no</xsl:attribute>
                </xsl:if>
            </xsl:if>                                                                                       
	    <xsl:if test=".//declarators[.//declarator[.//colon]]">	    
                <xsl:attribute name="bitField">bits</xsl:attribute>
            </xsl:if>			                
            <xsl:apply-templates select=".//opt_fixed_array_size[.//fixed_array_size]"/>            
            <xsl:call-template name="getEquivalentType">
                <xsl:with-param name="currentType" select="$type"/>                        
                <xsl:with-param name="lastNode"    select="xalan:nodeset($node)/node()"/>                        
            </xsl:call-template>                        
	</member>                
    </xsl:template> 
    
    <!-- 
    ========
    Includes 
    ========
    -->
    
    <xsl:template match="include_dcl">
        <xsl:variable name="rawIncludeFile" select="include_file"/>
        <!-- Remove the quotes that we got from the raw XML input -->
    	<include file="{substring-before(substring-after($rawIncludeFile, '&quot;'), '&quot;')}"/>
    </xsl:template>

    <!-- 
    ==================
    Type declaration
    ================== 
    -->
   
    <xsl:template match="type_dcl[struct_type|enum_type|union_type]">
	<xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="type_dcl[constr_forward_decl]">
      <forward_dcl>
        <xsl:attribute name="kind">
          <xsl:value-of select="./constr_forward_decl/text()"/>
        </xsl:attribute>
        <xsl:attribute name="name">
          <xsl:value-of select="./constr_forward_decl/identifier/text()"/>
        </xsl:attribute>
      </forward_dcl>
    </xsl:template>
	

    <!-- 
    ===================
    Directives
    ===================
    --> 
   
    <xsl:template match="directive">
        <xsl:choose>
            <xsl:when test="$doIncludes = 'yes'">
                <xsl:copy>
                    <xsl:apply-templates select="@*|node()"/>
                </xsl:copy>
            </xsl:when>
            <xsl:when test="./definition/line_dcl">
                <xsl:if
                    test="contains((./preceding-sibling::definition/line_dcl)[position()=last()],
                                               concat('&quot;',$idlFilePath,'&quot;'))">
                <xsl:copy>
                    <xsl:apply-templates select="@*|node()" />
                </xsl:copy>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@*|node()"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="directive[./@kind ='key' or ./@kind='Key']">
        <directive>
            <xsl:attribute name="kind">
                <xsl:value-of select="'key'"/>
            </xsl:attribute>
        </directive>
    </xsl:template>

    <xsl:template match="directive[./@kind ='ID']">
        <!-- this template is meant to filter out the "ID" directives  -->
    </xsl:template>
    <xsl:template match="directive[./@kind='BitSet']">
        <!-- this template is meant to filter out the "BitSet" directives  -->
    </xsl:template>
    <xsl:template match="directive[./@kind='BitBound']">
        <!-- this template is meant to filter out the "BitBound" directives  -->
    </xsl:template>
    <xsl:template match="directive[./@kind ='Optional']">
        <!-- this template is meant to filter out the "ID" directives  -->
    </xsl:template>


    <!-- 
    ===================
    Enum Declaration
    ===================
    Enum declaration. After processing the current node, skip directly enum members -->

    <xsl:template match="enum_type">
        <xsl:call-template name="checkDuplicateType">
            <xsl:with-param name="typeNode" select="."/>
        </xsl:call-template>

        <xsl:variable name="enumName">
            <xsl:value-of select="./identifier"/>
        </xsl:variable>

        <xsl:variable name="isBitSet">
            <xsl:choose>
                <xsl:when test="../../following-sibling::directive[@kind='BitSet' and (./preceding-sibling::definition[position()=1]/type_dcl/enum_type/identifier = $enumName)]">
                    <xsl:text>yes</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>no</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="bitBound">
            <xsl:choose>
                <xsl:when test="not(../../following-sibling::directive[@kind='BitBound' and (./preceding-sibling::definition[position()=1]/type_dcl/enum_type/identifier = $enumName)])">
                    <xsl:text>32</xsl:text>  <!-- 32 is the default bitBound when not explicetly set -->
                </xsl:when>
                <xsl:otherwise>
                    <xsl:if test="../../following-sibling::directive[@kind='BitBound']=''">
                        <xsl:text>32</xsl:text>  <!-- 32 is the default bitBound when not explicitly set -->
                    </xsl:if>
                    <xsl:if test="../../following-sibling::directive[@kind='BitBound']!=''">
                        <xsl:value-of select="../../following-sibling::directive[@kind='BitBound']" />
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
       

    	<enum name="{identifier}" bitSet="{$isBitSet}">
            <xsl:if test="$xml = 'no' or $bitBound != 32">
                <xsl:attribute name="bitBound"><xsl:value-of select="$bitBound"/></xsl:attribute>
            </xsl:if>
        
            <xsl:apply-templates select="enumerator_list/enumerator">
                <xsl:with-param name="isBitSet" select="$isBitSet"/>
            </xsl:apply-templates>
    	</enum>
    </xsl:template>

    <!-- Enum member. -->
    <xsl:template match="enumerator">
        <xsl:param name="isBitSet" select="no"/>

        <enumerator name="{identifier}">
            <xsl:choose>
                <xsl:when test="$language='JAVA' or ($language='ADA' and ./ancestor::enum_type//integer_literal) or $isBitSet='yes'">
                    <xsl:attribute name="value">
                        <xsl:choose>
                            <xsl:when test="integer_literal">
                                <xsl:value-of select="integer_literal"/>
                            </xsl:when>
                            <xsl:when test="preceding-sibling::node()[./integer_literal]">
                                <xsl:variable name="baseOrdinal">
                                    <xsl:for-each select="preceding-sibling::node()[./integer_literal]">
                                        <xsl:if test="position()=last()">
                                            <xsl:value-of select="./integer_literal"/>
                                        </xsl:if>
                                    </xsl:for-each>
                                </xsl:variable>
                                <xsl:variable name="basePosition">
                                    <xsl:for-each select="preceding-sibling::node()[./integer_literal]">
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
                                <xsl:value-of select="position() - $basePosition + $baseOrdinal"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="position()-1"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:if test="integer_literal">
                        <xsl:attribute name="value"><xsl:value-of select="integer_literal"/></xsl:attribute>
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
        </enumerator>
    </xsl:template>

    <!--
    ====================
    Struct Declaration
    ====================
    Struct declaration. After processing the current node, skip directly to struct members -->

    <xsl:template match="struct_type">
        <xsl:call-template name="checkDuplicateType">
            <xsl:with-param name="typeNode" select="."/>
        </xsl:call-template>

        <xsl:variable name="resolveName">
            <xsl:call-template name="resolveName">
                <xsl:with-param name="node" select="."/>
            </xsl:call-template>
        </xsl:variable>           

        <xsl:variable name="type">
            <xsl:if test=".//struct_inheritance_spec/struct_name[1]">
                <!-- If there is base class -->
                <xsl:call-template name="resolveScopedName">
                    <xsl:with-param name="scopedNameNode" select=".//struct_inheritance_spec/struct_name[1]/scoped_name"/>
                    <xsl:with-param name="resolveName" select="$resolveName"/>                
                </xsl:call-template>
            </xsl:if>                                
        </xsl:variable>
        
        <xsl:variable name="keyedBaseClass">
            <xsl:choose>
                <xsl:when test=".//struct_inheritance_spec/struct_name[1]">
                    <!-- If there is base class -->
                    <xsl:call-template name="isKeyedStructType">
                        <xsl:with-param name="structTypeName" select="$type"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>no</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="typeLanguage">
            <xsl:if test="$type!=''">
                <!-- If there is base class -->
                <xsl:call-template name="symbolToLanguageFormat">
                    <xsl:with-param name="symbol" select="$type"/>
                    <xsl:with-param name="resolveName" select="$resolveName"/>                
                </xsl:call-template>
            </xsl:if>                            
        </xsl:variable>

        <xsl:variable name="typeLanguageC">
            <xsl:if test="$type!=''">
                <!-- If there is base class -->
                <xsl:call-template name="symbolToLanguageFormat">
                    <xsl:with-param name="symbol" select="$type"/>
                    <xsl:with-param name="resolveName" select="$resolveName"/> 
                    <xsl:with-param name="targetLanguage" select="'C'"/>
                    <xsl:with-param name="targetNamespaceSeparator" select="'_'"/>               
                </xsl:call-template>
            </xsl:if>                            
        </xsl:variable>

    	<struct name="{identifier}" baseClass="{$typeLanguage}" keyedBaseClass="{$keyedBaseClass}" kind="struct">
            <xsl:variable name="xType">
                <xsl:call-template name="getExtensibilityKind">
                    <xsl:with-param name="structName" select="./identifier"/>
                    <xsl:with-param name="structNode" select="."/>
                    <xsl:with-param name="checkValue" select="'true'"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:apply-templates select="member_list|directive">
                <xsl:with-param name="xType" select="$xType"/>
                <xsl:with-param name="baseClass" select="$typeLanguage"/>
            </xsl:apply-templates>
        </struct>
    </xsl:template>

    <xsl:template match="member_list">
        <xsl:param name="xType" select="'EXTENSIBLE_EXTENSIBILITY'"/>
        <xsl:param name="baseClass" select="''"/>

       	<xsl:apply-templates select="member|directive">
            <xsl:with-param name="xType" select="$xType"/>
            <xsl:with-param name="baseClass" select="$baseClass"/>
        </xsl:apply-templates>
    </xsl:template>

    <!-- Struct/Value type member. After processing the current node (to extract type and name),process dimension information -->
    <xsl:template match="member|state_member">
        <xsl:param name="xType" select="'EXTENSIBLE_EXTENSIBILITY'"/>
        <xsl:param name="baseClass" select="''"/>

        <xsl:variable name="resolveName">
            <xsl:call-template name="resolveName">
                <xsl:with-param name="node" select="."/>
            </xsl:call-template>
        </xsl:variable> 
       
        <xsl:variable name="member" select="."/>
                    
        <xsl:variable name="type">
    	    <xsl:call-template name="obtainStructMemberType">
    	        <xsl:with-param name="typeSpecNode" select="type_spec"/>
                <xsl:with-param name="resolveName" select="$resolveName"/>
            </xsl:call-template>            
        </xsl:variable>
                                                         
        <xsl:variable name="ignoreTypeReference">
            <xsl:call-template name="ignoreTypeReference">
                <xsl:with-param name="qualifiedType" select="$type"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:if test="$ignoreTypeReference = 'no'">
            <xsl:variable name="typeC">
                <xsl:call-template name="symbolToLanguageFormat">
                    <xsl:with-param name="symbol" select="$type"/>
                    <xsl:with-param name="resolveName" select="$resolveName"/>                
                </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="isEnum">
                <xsl:call-template name="isEnum">
                    <xsl:with-param name="qualifiedType" select="$type"/>
                </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="enumeratorCount">
                <xsl:call-template name="getEnumeratorCount">
                    <xsl:with-param name="qualifiedType" select="$type"/>
                </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="visibility">
                <xsl:if test="name() = 'state_member'">
                    <xsl:value-of select="./access_modifier"/>
                </xsl:if>
                <xsl:if test="name() = 'struct'">
                    <xsl:text>public</xsl:text>
                </xsl:if>
            </xsl:variable>

            <xsl:for-each select="declarators/declarator">
                <xsl:variable name="isPointer">
                    <xsl:if test="./pointer">yes</xsl:if>
                    <xsl:if test="not(./pointer)">no</xsl:if>
                </xsl:variable>
                <member name="{identifier}" type="{$typeC}" enum="{$isEnum}" pointer="{$isPointer}" visibility="{$visibility}">	    
                    <xsl:if test="$isEnum = 'yes'">
                        <xsl:attribute name="enumCount">
                            <xsl:value-of select="$enumeratorCount"/>
                        </xsl:attribute>
                    </xsl:if>
                    <!-- <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> -->
                        <xsl:attribute name="memberId">      
                            <xsl:if test="name($member)='state_member'">   
                                <xsl:call-template name="getValueMemberId">
                                    <xsl:with-param name="member" select="$member"/>
                                    <xsl:with-param name="name" select="./identifier/text()"/>
                                    <xsl:with-param name="baseClass" select="$baseClass"/>
                                </xsl:call-template>
                            </xsl:if>
                            <xsl:if test="name($member)='member'">                                               
                                <xsl:call-template name="getMemberId">
                                    <xsl:with-param name="member" select="$member"/>
                                    <xsl:with-param name="name" select="./identifier/text()"/>
                                    <xsl:with-param name="baseClass" select="$baseClass"/>
                                </xsl:call-template>
                            </xsl:if>
                        </xsl:attribute>
                    <!-- </xsl:if> -->
                    <xsl:attribute name="optional">
                        <xsl:if test="name($member)='state_member'">   
                            <xsl:call-template name="getValueTypeOptionalValue">
                                <xsl:with-param name="member" select="$member"/>
                                <xsl:with-param name="name" select="./identifier/text()"/>
                            </xsl:call-template>
                        </xsl:if>
                        <xsl:if test="name($member)='member'">   
                            <xsl:call-template name="getOptionalValue">
                                <xsl:with-param name="member" select="$member"/>
                                <xsl:with-param name="name" select="./identifier/text()"/>
                            </xsl:call-template>
                        </xsl:if>                        
                    </xsl:attribute>
                    <xsl:if test="name($member) = 'state_member'">
                        <xsl:attribute name="access">
                            <xsl:value-of select="$member/access_modifier"/>
                        </xsl:attribute>                                                                                
                    </xsl:if>
           	        <xsl:apply-templates select="$member//opt_fixed_array_size[.//fixed_array_size]"/>
                    <xsl:call-template name="getEquivalentType">
                        <xsl:with-param name="currentType" select="$type"/>                        
                        <xsl:with-param name="lastNode"    select="$member"/>                        
                    </xsl:call-template>           
                </member>
            </xsl:for-each>
        </xsl:if>

    </xsl:template>
    
    <!-- Struct/Value bit field member, use the colon to identify it as a bit field -->
    <xsl:template match="member[.//declarators[.//declarator[.//colon]]]|
                         state_member[.//declarators[.//declarator[.//colon]]]">
        <xsl:param name="xType" select="'EXTENSIBLE_EXTENSIBILITY'"/>
        <xsl:param name="baseClass" select="''"/>

        <xsl:variable name="resolveName">
            <xsl:call-template name="resolveName">
                <xsl:with-param name="node" select="."/>
            </xsl:call-template>
        </xsl:variable>            
            
        <xsl:variable name="member" select="."/>

        <xsl:variable name="visibility">
            <xsl:if test="name() = 'state_member'">
                <xsl:value-of select="./access_modifier"/>
            </xsl:if>
            <xsl:if test="name() = 'struct'">
                <xsl:text>public</xsl:text>
            </xsl:if>
        </xsl:variable>
            
        <xsl:variable name="type">
    	    <xsl:call-template name="obtainStructMemberType">
    	        <xsl:with-param name="typeSpecNode" select="type_spec"/>
                <xsl:with-param name="resolveName" select="$resolveName"/>                                
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="typeC">
    	    <xsl:call-template name="symbolToLanguageFormat">
    	        <xsl:with-param name="symbol" select="$type"/>
                <xsl:with-param name="resolveName" select="$resolveName"/>                
            </xsl:call-template>
        </xsl:variable>
        
    	<xsl:variable name = "bits">
    	    <xsl:call-template name="obtainConstExpr">
                <xsl:with-param name="expressionTree" select=".//const_exp"/>
            </xsl:call-template>
    	</xsl:variable>
        
        <xsl:variable name="isEnum">
    	    <xsl:call-template name="isEnum">
                <xsl:with-param name="qualifiedType" select="$type"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="enumeratorCount">
            <xsl:call-template name="getEnumeratorCount">
                <xsl:with-param name="qualifiedType" select="$type"/>
            </xsl:call-template>
        </xsl:variable>
    	
        <xsl:for-each select="declarators/declarator">                
            <member name="{identifier}" bitField="{$bits}"  type="{$typeC}" enum="{$isEnum}" visibility="{$visibility}">
                <xsl:attribute name="memberId">      
                    <xsl:if test="name($member)='state_member'">   
                        <xsl:call-template name="getValueMemberId">
                            <xsl:with-param name="member" select="$member"/>
                            <xsl:with-param name="name" select="./identifier/text()"/>
                            <xsl:with-param name="baseClass" select="$baseClass"/>
                        </xsl:call-template>
                    </xsl:if>
                    <xsl:if test="name($member)='member'">                                               
                        <xsl:call-template name="getMemberId">
                            <xsl:with-param name="member" select="$member"/>
                            <xsl:with-param name="name" select="./identifier/text()"/>
                            <xsl:with-param name="baseClass" select="$baseClass"/>
                        </xsl:call-template>
                    </xsl:if>
                </xsl:attribute>
                
                <xsl:attribute name="optional">
                    <xsl:if test="name($member)='state_member'">   
                        <xsl:call-template name="getValueTypeOptionalValue">
                            <xsl:with-param name="member" select="$member"/>
                            <xsl:with-param name="name" select="./identifier/text()"/>
                        </xsl:call-template>
                    </xsl:if>
                    <xsl:if test="name($member)='member'">   
                        <xsl:call-template name="getOptionalValue">
                            <xsl:with-param name="member" select="$member"/>
                            <xsl:with-param name="name" select="./identifier/text()"/>
                        </xsl:call-template>
                    </xsl:if>                        
                </xsl:attribute>                

                <xsl:if test="$isEnum = 'yes'">
                    <xsl:attribute name="enumCount">
                        <xsl:value-of select="$enumeratorCount"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="name($member) = 'state_member'">
                    <xsl:attribute name="access">
                        <xsl:value-of select="$member/access_modifier"/>
                    </xsl:attribute>                                                                                
                </xsl:if>                    
	        <!-- Process dimension only after ensuring that the struct member does have dimensions specified. -->
                <xsl:apply-templates select="$member//opt_fixed_array_size[$member//fixed_array_size]"/>
                <xsl:call-template name="getEquivalentType">
                    <xsl:with-param name="currentType" select="$type"/>                        
                    <xsl:with-param name="lastNode"    select="$member"/>                        
                </xsl:call-template>                        
            </member>    
        </xsl:for-each>        
    </xsl:template>

    <!-- Struct/Value type sequences/string members -->            
    <xsl:template match="member[.//sequence_type | type_spec//string_type |
                                type_spec//wide_string_type]|
                         state_member[.//sequence_type | type_spec//string_type |
                                type_spec//wide_string_type]">
        <xsl:param name="xType" select="'EXTENSIBLE_EXTENSIBILITY'"/>
        <xsl:param name="baseClass" select="''"/>

        <xsl:variable name="resolveName">
            <xsl:call-template name="resolveName">
                <xsl:with-param name="node" select="."/>
            </xsl:call-template>
        </xsl:variable>            
        
        <xsl:variable name="member" select="."/>
            
        <xsl:variable name="type">
    	    <xsl:call-template name="obtainStructMemberType">
    	        <xsl:with-param name="typeSpecNode" select="type_spec"/>
                <xsl:with-param name="resolveName" select="$resolveName"/>                
            </xsl:call-template>
        </xsl:variable>
                                                                        
        <xsl:variable name="ignoreTypeReference">
            <xsl:call-template name="ignoreTypeReference">
                <xsl:with-param name="qualifiedType" select="$type"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:if test="$ignoreTypeReference = 'no'">
            <xsl:variable name="lengthString">
                <xsl:call-template name="getStringLength">
                    <xsl:with-param name="type_spec_node" select="type_spec"/>    
                </xsl:call-template>                                                                
            </xsl:variable>

            <xsl:variable name="lengthSequence">
                <xsl:if test=".//sequence_type">                
                    <xsl:call-template name="obtainConstExpr">
                        <xsl:with-param name="expressionTree" select=".//sequence_type/opt_pos_int//const_exp"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:variable>                

            <xsl:variable name="typeC">
                <xsl:call-template name="symbolToLanguageFormat">
                    <xsl:with-param name="symbol" select="$type"/>
                    <xsl:with-param name="resolveName" select="$resolveName"/>                
                </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="isEnum">
                <xsl:call-template name="isEnum">
                    <xsl:with-param name="qualifiedType" select="$type"/>
                </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="enumeratorCount">
                <xsl:call-template name="getEnumeratorCount">
                    <xsl:with-param name="qualifiedType" select="$type"/>
                </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="visibility">
                <xsl:if test="name() = 'state_member'">
                    <xsl:value-of select="./access_modifier"/>
                </xsl:if>
                <xsl:if test="name() = 'struct'">
                    <xsl:text>public</xsl:text>
                </xsl:if>
            </xsl:variable>

            <xsl:for-each select="declarators/declarator">                
                <xsl:variable name="isPointer">
                    <xsl:if test="./pointer">yes</xsl:if>
                    <xsl:if test="not(./pointer)">no</xsl:if>
                </xsl:variable>                

                <member name="{identifier}" type="{$typeC}" enum="{$isEnum}" pointer="{$isPointer}" visibility="{$visibility}">
                    <!-- <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> -->
                    <xsl:attribute name="memberId">      
                        <xsl:if test="name($member)='state_member'">   
                            <xsl:call-template name="getValueMemberId">
                                <xsl:with-param name="member" select="$member"/>
                                <xsl:with-param name="name" select="./identifier/text()"/>
                                <xsl:with-param name="baseClass" select="$baseClass"/>
                            </xsl:call-template>
                        </xsl:if>
                        <xsl:if test="name($member)='member'">                                               
                            <xsl:call-template name="getMemberId">
                                <xsl:with-param name="member" select="$member"/>
                                <xsl:with-param name="name" select="./identifier/text()"/>
                                <xsl:with-param name="baseClass" select="$baseClass"/>
                            </xsl:call-template>
                        </xsl:if>
                    </xsl:attribute>
                    <!-- </xsl:if> -->
                    
                    <xsl:attribute name="optional">
                        <xsl:if test="name($member)='state_member'">   
                            <xsl:call-template name="getValueTypeOptionalValue">
                                <xsl:with-param name="member" select="$member"/>
                                <xsl:with-param name="name" select="./identifier/text()"/>
                            </xsl:call-template>
                        </xsl:if>
                        <xsl:if test="name($member)='member'">   
                            <xsl:call-template name="getOptionalValue">
                                <xsl:with-param name="member" select="$member"/>
                                <xsl:with-param name="name" select="./identifier/text()"/>
                            </xsl:call-template>
                        </xsl:if>                        
                    </xsl:attribute>
                                    
                    <xsl:if test="$isEnum = 'yes'">
                        <xsl:attribute name="enumCount">
                            <xsl:value-of select="$enumeratorCount"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="name($member) = 'state_member'">
                        <xsl:attribute name="access">
                            <xsl:value-of select="$member/access_modifier"/>
                        </xsl:attribute>                                                                                
                    </xsl:if>                
                    <xsl:if test="$member//sequence_type">
                        <xsl:attribute name="kind">sequence</xsl:attribute>
                        <xsl:attribute name="maxLengthSequence">
                            <xsl:if test="$lengthSequence!=''">
                                <xsl:value-of select="$lengthSequence"/>
                            </xsl:if>
                            <xsl:if test="$lengthSequence=''">
                                <xsl:value-of select="$sequenceSize"/>
                            </xsl:if>                                    
                        </xsl:attribute>
                        <xsl:attribute name="bounded">
                            <xsl:if test="$lengthSequence!=''">
                                <xsl:value-of select="'yes'"/>
                            </xsl:if>
                            <xsl:if test="$lengthSequence=''">
                                <xsl:value-of select="'no'"/>
                            </xsl:if>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="$member/type_spec//string_type | 
                                  $member/type_spec//wide_string_type">
                        <xsl:attribute name="maxLengthString">
                            <xsl:if test="$lengthString!=''">
                                <xsl:value-of select="$lengthString"/>
                            </xsl:if>
                            <xsl:if test="$lengthString=''">
                                <xsl:value-of select="$stringSize"/>
                            </xsl:if>                                                            
                        </xsl:attribute>
                        <xsl:if test="$lengthString!=''">
                          <xsl:attribute name="boundedStr">yes</xsl:attribute>
                        </xsl:if>
                        <xsl:if test="$lengthString=''">
                          <xsl:attribute name="boundedStr">no</xsl:attribute>
                        </xsl:if>
                    </xsl:if>                                                               
                            
                    <!-- bit field member, not allowed with a string, but parse here and catch in error checking later    --> 
                    <xsl:if test="$member//declarators[$member//declarator[.//colon]]">	    
                        <xsl:attribute name="bitField">bits</xsl:attribute>
                    </xsl:if>			          
                    <xsl:apply-templates select="$member//opt_fixed_array_size[.//fixed_array_size]"/>                  
                    <xsl:call-template name="getEquivalentType">
                        <xsl:with-param name="currentType" select="$type"/>                        
                        <xsl:with-param name="lastNode"    select="$member"/>                        
                    </xsl:call-template>                        
    	        </member>                
            </xsl:for-each>                
        </xsl:if>
    </xsl:template>

    <!-- Struct member dimension information. All <dimension> elements are put inside an <cardinality> element -->
    <xsl:template match="opt_fixed_array_size">
    	<xsl:if test=".//fixed_array_size">
       	<cardinality>
	    <xsl:for-each select=".//fixed_array_size">
                <xsl:variable name="value">
                    <xsl:call-template name="obtainConstExpr">
                        <xsl:with-param name="expressionTree" select="."/>
                    </xsl:call-template>
                </xsl:variable>	  
	        <dimension size="{$value}"/>
            </xsl:for-each>
	</cardinality>        
    	</xsl:if>		
    </xsl:template>

    <!--
    ====================
    Interface declaration
    ====================
    -->

    <xsl:template match="interf">
        <xsl:if test="$verbosity = 3">
            <xsl:message  terminate="no">
                <xsl:text> Info: </xsl:text>
                <xsl:value-of select="./identifier"/>
                <xsl:text> is an interface. Interfaces will be ignored. </xsl:text>
            </xsl:message>                
        </xsl:if>
    </xsl:template>

    <!--
    ====================
    porttype
    ====================
    -->

    <xsl:template match="porttype_dcl">
        <xsl:if test="$verbosity = 3">
            <xsl:message  terminate="no">
                <xsl:text> Info: </xsl:text>
                <xsl:value-of select="./identifier"/>
                <xsl:text> is an extended port. Extended ports will be ignored. </xsl:text>
            </xsl:message>
        </xsl:if>
    </xsl:template>

    <!--
    ====================
    component
    ====================
    -->

    <xsl:template match="component">
        <xsl:if test="$verbosity = 3">
            <xsl:message  terminate="no">
                <xsl:text> Info: </xsl:text>
                <xsl:value-of select="./identifier"/>
                <xsl:text> is a component. Components will be ignored. </xsl:text>
            </xsl:message>
        </xsl:if>
    </xsl:template>

    <!--
    ====================
    connector
    ====================
    -->

    <xsl:template match="connector">
        <xsl:if test="$verbosity = 3">
            <xsl:message  terminate="no">
                <xsl:text> Info: </xsl:text>
                <xsl:value-of select="./connector_header/identifier"/>
                <xsl:text> is a connector. Connectors will be ignored. </xsl:text>
            </xsl:message>
        </xsl:if>
    </xsl:template>

    <!--
    ====================
    template_module
    ====================
    -->

    <xsl:template match="template_module">
        <xsl:if test="$verbosity = 3">
            <xsl:message  terminate="no">
                <xsl:text> Info: </xsl:text>
                <xsl:value-of select="./identifier"/>
                <xsl:text> is a template module. Template modules and their content will be ignored. </xsl:text>
            </xsl:message>
        </xsl:if>
    </xsl:template>

    <xsl:template match="template_module_inst">
        <xsl:if test="$verbosity = 3">
            <xsl:message  terminate="no">
                <xsl:text> Info: </xsl:text>
                <xsl:value-of select="./identifier"/>
                <xsl:text> is a template module instatiation. Template module instatiations will be ignored. </xsl:text>
            </xsl:message>
        </xsl:if>
    </xsl:template>

    <!--
    ====================
    except_dcl
    ====================
    -->

    <xsl:template match="except_dcl">
        <xsl:if test="$verbosity = 3">
            <xsl:message  terminate="no">
                <xsl:text> Info: </xsl:text>
                <xsl:value-of select="./identifier"/>
                <xsl:text> is an exception. Exceptions will be ignored. </xsl:text>
            </xsl:message>
        </xsl:if>
    </xsl:template>

    <!--
    ====================
    event
    ====================
    -->

    <xsl:template match="event">
        <xsl:if test="$verbosity = 3">
            <xsl:message  terminate="no">
                <xsl:text> Info: </xsl:text>
                <xsl:value-of select=".//identifier[1]"/>
                <xsl:text> is an event. Events will be ignored. </xsl:text>
            </xsl:message>                
        </xsl:if>
    </xsl:template>

    <!--
    ====================
    Value type declaration
    ====================
    Value type declaration. -->

    <!-- -->    
    <xsl:template match="value">
        <xsl:apply-templates select="value_box_dcl|value_dcl|value_abs_dcl|value_forward_dcl"/>
    </xsl:template>

    <!-- -->        
    <xsl:template match="value_box_dcl">
        <xsl:if test="$verbosity = 3">
            <xsl:message  terminate="no">
                <xsl:text> Info: The type </xsl:text>
                <xsl:value-of select="./identifier"/>
                <xsl:text> is a value box type. Value box types will be ignored. </xsl:text>
            </xsl:message>
        </xsl:if>
    </xsl:template>

    <!-- -->                
    <xsl:template match="value_dcl">

        <xsl:if test="$generateValueTypeCode = 1">
            <xsl:choose>
                <xsl:when test="./value_header/value_inheritance_spec/supports">                                        
                    <xsl:if test="$verbosity = 3">
                        <xsl:message  terminate="no">
                            <xsl:text> Info: The type </xsl:text>
                            <xsl:value-of select="./value_header/identifier"/>
                            <xsl:text> is a value type inheriting from interfaces. This kind of value type will be ignored.</xsl:text>
                        </xsl:message>                
                    </xsl:if>
                </xsl:when>
                <xsl:when test="count(./value_header/value_inheritance_spec/value_name)>1">                                        
                    <xsl:if test="$verbosity = 3">
                        <xsl:message  terminate="no">
                            <xsl:text> Info: The type </xsl:text>
                            <xsl:value-of select="./value_header/identifier"/>
                            <xsl:text> is a value type inheriting from several value types. This kind of value type will be ignored.</xsl:text>
                        </xsl:message>                
                    </xsl:if>
                </xsl:when>                
                <xsl:otherwise>                    
                    <xsl:if test="starts-with(./value_header,'customvaluetype')">
                        <xsl:if test="$verbosity = 3">
                            <xsl:message  terminate="no">
                                <xsl:text> Info: The 'custom' keyword in the value type </xsl:text>
                                <xsl:value-of select="./value_header/identifier"/>                    
                                <xsl:text> will be ignored. </xsl:text>
                            </xsl:message>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="./value_header/value_inheritance_spec/truncatable">
                        <xsl:if test="$verbosity = 3">
                            <xsl:message  terminate="no">
                                <xsl:text> Info: The 'truncatable' keyword in the value type </xsl:text>
                                <xsl:value-of select="./value_header/identifier"/>
                                <xsl:text> will be ignored. </xsl:text>
                            </xsl:message>                
                        </xsl:if>
                    </xsl:if>                                            
    
                    <xsl:variable name="resolveName">
                        <xsl:call-template name="resolveName">
                            <xsl:with-param name="node" select="."/>
                        </xsl:call-template>
                    </xsl:variable>           
                        
                    <xsl:variable name="type">
                        <xsl:if test=".//value_inheritance_spec/value_name[1]">                            
                            <!-- If there is base class -->
        	            <xsl:call-template name="resolveScopedName">
        	                <xsl:with-param name="scopedNameNode" select=".//value_inheritance_spec/value_name[1]/scoped_name"/>
                                <xsl:with-param name="resolveName" select="$resolveName"/>                
                            </xsl:call-template>
                        </xsl:if>                                
                    </xsl:variable>

                    <xsl:variable name="keyedBaseClass">
                        <xsl:choose>
                            <xsl:when test=".//value_inheritance_spec/value_name[1]">
                                <!-- If there is base class -->
                                <xsl:call-template name="isKeyedValueType">
                                    <xsl:with-param name="valueTypeName" select="$type"/>
                                </xsl:call-template>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>no</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                        
                    <xsl:variable name="typeLanguage">
                        <xsl:if test="$type!=''">
                            <!-- If there is base class -->
        	            <xsl:call-template name="symbolToLanguageFormat">
        	                <xsl:with-param name="symbol" select="$type"/>
                                <xsl:with-param name="resolveName" select="$resolveName"/>                
                            </xsl:call-template>
                        </xsl:if>                            
                    </xsl:variable>
    
                    <xsl:variable name="typeModifier">
                        <xsl:choose>
                            <xsl:when test="starts-with(./value_header,'customvaluetype')">
                                <xsl:text>custom</xsl:text>
                            </xsl:when>
                            <xsl:when test="./value_header/value_inheritance_spec/truncatable">
                                <xsl:text>truncatable</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>none</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>

                    <xsl:call-template name="checkDuplicateType">
                        <xsl:with-param name="typeNode" select="./value_header"/>
                    </xsl:call-template>
                        
                    <struct kind="valuetype" 
                        name="{./value_header/identifier}" 
                        baseClass="{$typeLanguage}" 
                        typeModifier="{$typeModifier}" 
                        keyedBaseClass="{$keyedBaseClass}">
             	        <xsl:apply-templates select="./value_element|./directive">
                            <xsl:with-param name="identifier" select="./value_header/identifier"/> 
                            <xsl:with-param name="baseClass" select="$typeLanguage"/>
                        </xsl:apply-templates>
                    </struct>                    
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>

        <xsl:if test="$generateValueTypeCode = 0">
            <xsl:if test="$verbosity = 3">
                <xsl:message  terminate="no">
                    <xsl:text> Info: The type </xsl:text>
                    <xsl:value-of select="./value_header/identifier"/>
                    <xsl:text> is a value type. Value types are not supported. They will be ignored. </xsl:text>
                </xsl:message>
            </xsl:if>
        </xsl:if>

    </xsl:template>

    <!-- -->                
    <xsl:template match="value_forward_dcl">

        <xsl:if test="$generateValueTypeCode = 1">
            <xsl:if test="$language='C++'">
                <forward_dcl kind="valuetype" name="{identifier}"/>
            </xsl:if>                              
            <xsl:if test="$language='C'">
                <xsl:variable name="modulePath">
                    <xsl:call-template name="getModulePath">
                        <xsl:with-param name="moduleNode" select="../../.."/>  
                    </xsl:call-template>                 
                </xsl:variable>   
                    
                <xsl:variable name="type" select="concat($modulePath,./identifier)"/>
                    
                <xsl:variable name="typeLanguage">
                    <xsl:call-template name="symbolToLanguageFormat">
        	            <xsl:with-param name="symbol" select="$type"/>
                        <xsl:with-param name="resolveName" select="'true'"/>                
                    </xsl:call-template>
                </xsl:variable>
                                                                                                                                         
                <forward_dcl kind="valuetype" name="{$typeLanguage}"/>
            </xsl:if>
        </xsl:if>

        <xsl:if test="$generateValueTypeCode = 0">
            <xsl:if test="$verbosity = 3">
                <xsl:message  terminate="no">
                    <xsl:text> Info: The type </xsl:text>
                    <xsl:value-of select="./identifier"/>
                    <xsl:text> is a value type. Value types are not supported. They will be ignored. </xsl:text>
                </xsl:message>
            </xsl:if>
        </xsl:if>

    </xsl:template>

    <!-- -->                           
    <xsl:template match="value_abs_dcl">
        <xsl:if test="$verbosity = 3">
            <xsl:message  terminate="no">
                <xsl:text> Info: The type </xsl:text>
                <xsl:value-of select="./identifier"/>
                <xsl:text> is an abstract value type. Abstract value types will be ignored. </xsl:text>                
            </xsl:message>            
        </xsl:if>
    </xsl:template>

    <!-- -->                    
    <xsl:template match="value_element">
        <xsl:param name="identifier"/>
        <xsl:param name="baseClass"/>        

        <xsl:choose>
            <xsl:when test="./export/const_dcl and 
                            (($language='C++' and $namespace='yes') or 
                              $language='JAVA')">
                <xsl:apply-templates select="./export/const_dcl"/>
            </xsl:when>
            <xsl:when test="./export|./init_dcl">
                <xsl:if test="$verbosity = 3">
                    <xsl:message  terminate="no">
                        <xsl:text> Info: The type </xsl:text>
                        <xsl:value-of select="$identifier"/>
                        <xsl:text> is a value type that contains declarations. The declarations (operations, constant, types, ...) inside value types will be ignored. </xsl:text>                
                    </xsl:message>                
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
        </xsl:choose>
            
        <xsl:if test="./state_member/access_modifier[text()='private']">                
            <xsl:if test="$verbosity = 3">
                <xsl:message  terminate="no">
                    <xsl:text> Info: Value types cannot contain private state members. The private members of the type </xsl:text>
                    <xsl:value-of select="$identifier"/>
                    <xsl:text> will be made public. </xsl:text>                
                </xsl:message>                
            </xsl:if>
        </xsl:if>
            
        <xsl:apply-templates select="./state_member">
            <xsl:with-param name="baseClass" select="$baseClass"/>
        </xsl:apply-templates>
    </xsl:template>
                                                                            
    <!-- 
    =================
    Union declaration 
    =================
    After processing the current node, skip directly to struct members -->
    
    <xsl:template match="union_type">
        <xsl:call-template name="checkDuplicateType">
            <xsl:with-param name="typeNode" select="."/>
        </xsl:call-template>

    	<struct name="{identifier}" kind="union">
            <xsl:variable name="xType">
                <xsl:call-template name="getExtensibilityKind">
                    <xsl:with-param name="structName" select="./identifier"/>
                    <xsl:with-param name="structNode" select="."/>
                    <xsl:with-param name="checkValue" select="'true'"/>
                </xsl:call-template>
            </xsl:variable>
        
            <xsl:variable name="typeDisc">
    	        <xsl:call-template name="obtainUnionSwitchType">
    	            <xsl:with-param name="switchTypeSpecNode" select="switch_type_spec"/>
                </xsl:call-template>
            </xsl:variable>
            
            <xsl:variable name="typeDiscL">
                <xsl:call-template name="symbolToLanguageFormat">
                    <xsl:with-param name="symbol" select="$typeDisc"/>
                </xsl:call-template>
            </xsl:variable>
            
            <xsl:variable name="isEnum">
    	        <xsl:call-template name="isEnum">
                    <xsl:with-param name="qualifiedType" select="$typeDisc"/>
                </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="enumeratorCount">
                <xsl:call-template name="getEnumeratorCount">
                    <xsl:with-param name="qualifiedType" select="$typeDisc"/>
                </xsl:call-template>
            </xsl:variable>

            <discriminator name="_d" type="{$typeDiscL}" uniondisc="yes" enum="{$isEnum}">                
                <xsl:if test="$isEnum = 'yes'">
                    <xsl:attribute name="enumCount">
                        <xsl:value-of select="$enumeratorCount"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="$xml != 'yes'">
                    <xsl:attribute name="memberId">
                        <xsl:value-of select="0"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:call-template name="getEquivalentType">
                    <xsl:with-param name="currentType" select="$typeDisc"/>                        
                    <xsl:with-param name="lastNode"    select="."/>                        
                </xsl:call-template>                                        
            </discriminator>
            <xsl:apply-templates select=".//element_spec">
                <xsl:with-param name="xType" select="$xType"/>
            </xsl:apply-templates>
    	</struct>
    </xsl:template>
        
    <xsl:template match="element_spec"> 
        <xsl:param name="xType" select="'EXTENSIBLE_EXTENSIBILITY'"/>
               
        <xsl:variable name="resolveName">
            <xsl:call-template name="resolveName">
                <xsl:with-param name="node" select="."/>
            </xsl:call-template>
        </xsl:variable>            

        <xsl:variable name="type">
    	    <xsl:call-template name="obtainStructMemberType">
    	        <xsl:with-param name="typeSpecNode" select="type_spec"/>
                <xsl:with-param name="resolveName" select="$resolveName"/>                                
            </xsl:call-template>
        </xsl:variable>
                                    
        <xsl:variable name="ignoreTypeReference">
            <xsl:call-template name="ignoreTypeReference">
                <xsl:with-param name="qualifiedType" select="$type"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:if test="$ignoreTypeReference = 'no'">

            <xsl:variable name="typeC">
                <xsl:call-template name="symbolToLanguageFormat">
                    <xsl:with-param name="symbol" select="$type"/>
                    <xsl:with-param name="resolveName" select="$resolveName"/>                                
                </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="isEnum">
                <xsl:call-template name="isEnum">
                    <xsl:with-param name="qualifiedType" select="$type"/>
                </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="enumeratorCount">
                <xsl:call-template name="getEnumeratorCount">
                    <xsl:with-param name="qualifiedType" select="$type"/>
                </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="isPointer">
                <xsl:if test="./declarator/pointer">yes</xsl:if>
                <xsl:if test="not(./declarator/pointer)">no</xsl:if>
            </xsl:variable>

            <xsl:apply-templates select="../preceding-sibling::node()[position()=1 and name()='directive']"/>
            
            <xsl:variable name="lengthString">
               <xsl:call-template name="getStringLength">
                 <xsl:with-param name="type_spec_node" select="type_spec"/>
               </xsl:call-template>
            </xsl:variable>

           <!-- <member name="{declarator/identifier}" type="{$typeC}" enum="{$isEnum}" pointer="{$isPointer}">-->
            <xsl:element name="member">
                <!-- <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> -->
                    <xsl:attribute name="memberId">                            
                        <xsl:call-template name="getUnionMemberId">
                            <xsl:with-param name="case_stmt" select=".."/>
                            <xsl:with-param name="name" select="declarator/identifier"/>
                        </xsl:call-template>
                    </xsl:attribute>
                <!-- </xsl:if> -->
            
                <xsl:if test="$isEnum = 'yes'">
                    <xsl:attribute name="enumCount">
                        <xsl:value-of select="$enumeratorCount"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:attribute name="name"><xsl:value-of select="declarator/identifier"/></xsl:attribute>
                <xsl:attribute name="type"><xsl:value-of select="$typeC"/></xsl:attribute>
                <xsl:attribute name="enum"><xsl:value-of select="$isEnum"/></xsl:attribute>
                <xsl:attribute name="pointer"><xsl:value-of select="$isPointer"/></xsl:attribute>
                <xsl:if test="normalize-space($lengthString)!=''">
                  <xsl:attribute name="maxLengthString"><xsl:value-of select="$lengthString"/></xsl:attribute>
                </xsl:if>
                <!-- Process dimension only after ensuring that the struct member does have dimensions specified. -->
                <xsl:apply-templates select=".//opt_fixed_array_size[.//fixed_array_size]"/>
                <xsl:call-template name="getEquivalentType">
                    <xsl:with-param name="currentType" select="$type"/>                        
                    <xsl:with-param name="lastNode"    select="."/>                        
                </xsl:call-template>                        
      	        <xsl:apply-templates select="../case_label_list"/>
            </xsl:element>
          <!--  </member>    -->

        </xsl:if>
    </xsl:template>
    
    <xsl:template match="element_spec[.//sequence_type | type_spec//string_type |
                                      type_spec//wide_string_type]">
        <xsl:param name="xType" select="'EXTENSIBLE_EXTENSIBILITY'"/>

        <xsl:variable name="resolveName">
            <xsl:call-template name="resolveName">
                <xsl:with-param name="node" select="."/>
            </xsl:call-template>
        </xsl:variable>            

        <xsl:variable name="type">
    	    <xsl:call-template name="obtainStructMemberType">
    	        <xsl:with-param name="typeSpecNode" select="type_spec"/>
                <xsl:with-param name="resolveName" select="$resolveName"/>                                
            </xsl:call-template>
        </xsl:variable>
                                                        
        <xsl:variable name="ignoreTypeReference">
            <xsl:call-template name="ignoreTypeReference">
                <xsl:with-param name="qualifiedType" select="$type"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:if test="$ignoreTypeReference = 'no'">
            <xsl:variable name="typeC">
                <xsl:call-template name="symbolToLanguageFormat">
                    <xsl:with-param name="symbol" select="$type"/>
                    <xsl:with-param name="resolveName" select="$resolveName"/>                                
                </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="isEnum">
                <xsl:call-template name="isEnum">
                    <xsl:with-param name="qualifiedType" select="$type"/>
                </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="enumeratorCount">
                <xsl:call-template name="getEnumeratorCount">
                    <xsl:with-param name="qualifiedType" select="$type"/>
                </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="lengthSequence">
                <xsl:if test=".//sequence_type">                
                    <xsl:call-template name="obtainConstExpr">
                        <xsl:with-param name="expressionTree" select=".//sequence_type/opt_pos_int//const_exp"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:variable>                

            <xsl:variable name="lengthString">
                <xsl:call-template name="getStringLength">
                    <xsl:with-param name="type_spec_node" select="type_spec"/>    
                 </xsl:call-template>                                                                
            </xsl:variable>

            <xsl:variable name="isPointer">
                <xsl:if test="./declarator/pointer">yes</xsl:if>
                <xsl:if test="not(./declarator/pointer)">no</xsl:if>
            </xsl:variable>                

            <xsl:apply-templates select="../preceding-sibling::node()[position() = 1 and name()='directive']"/>

            <member name="{declarator/identifier}" type="{$typeC}" enum="{$isEnum}" pointer="{$isPointer}">
                <!-- <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> -->
                    <xsl:attribute name="memberId">                            
                        <xsl:call-template name="getUnionMemberId">
                            <xsl:with-param name="case_stmt" select=".."/>
                            <xsl:with-param name="name" select="declarator/identifier"/>
                        </xsl:call-template>
                    </xsl:attribute>
                <!-- </xsl:if> -->
            
                <xsl:if test="$isEnum = 'yes'">
                    <xsl:attribute name="enumCount">
                        <xsl:value-of select="$enumeratorCount"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test=".//sequence_type">
                    <xsl:attribute name="kind">sequence</xsl:attribute>
                    <xsl:attribute name="maxLengthSequence">
                        <xsl:if test="$lengthSequence!=''">
                            <xsl:value-of select="$lengthSequence"/>
                        </xsl:if>
                        <xsl:if test="$lengthSequence=''">
                            <xsl:value-of select="$sequenceSize"/>
                        </xsl:if>                                    
                    </xsl:attribute>
                    <xsl:attribute name="bounded">
                        <xsl:if test="$lengthSequence!=''">
                            <xsl:value-of select="'yes'"/>
                        </xsl:if>
                        <xsl:if test="$lengthSequence=''">
                            <xsl:value-of select="'no'"/>
                        </xsl:if>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="type_spec//string_type | type_spec//wide_string_type">
                    <xsl:attribute name="maxLengthString">
                        <xsl:if test="$lengthString!=''">
                            <xsl:value-of select="$lengthString"/>
                        </xsl:if>
                        <xsl:if test="$lengthString=''">
                            <xsl:value-of select="$stringSize"/>
                        </xsl:if>                                                            
                    </xsl:attribute>
                    <xsl:if test="$lengthString!=''">
                      <xsl:attribute name="boundedStr">yes</xsl:attribute>
                    </xsl:if>
                    <xsl:if test="$lengthString=''">
                        <xsl:attribute name="boundedStr">no</xsl:attribute>
                    </xsl:if>
                </xsl:if>                                                           
                <xsl:apply-templates select=".//opt_fixed_array_size[.//fixed_array_size]"/>                  
                <xsl:call-template name="getEquivalentType">
                    <xsl:with-param name="currentType" select="$type"/>                        
                    <xsl:with-param name="lastNode"    select="."/>                        
                </xsl:call-template>                
            	<xsl:apply-templates select="../case_label_list"/>			
            </member>                
        </xsl:if>

    </xsl:template>
    
    <xsl:template match="case_label_list">
    	<cases>
            <xsl:apply-templates select="case_label"/>	
    	</cases>
    </xsl:template>
    
    <xsl:template match="case_label_list/case_label">
        <xsl:variable name="case_value">
       	    <xsl:choose>
        	<xsl:when test=".//const_exp">
                    <xsl:call-template name="obtainConstExpr">
                        <xsl:with-param name="expressionTree" select="(.//const_exp)[1]"/>
        	    </xsl:call-template>
		</xsl:when>
		<xsl:otherwise>default</xsl:otherwise>
	    </xsl:choose>
        </xsl:variable>
	<case value="{$case_value}"/>
    </xsl:template>
    
    <!-- - - - - - - - - - - Utility templates - - - - - - - - - - -->

    <!-- Template to get the length of a string -->
    <xsl:template name="getStringLength">
        <xsl:param name="type_spec_node"/>    
        <xsl:if test="$type_spec_node//string_type">
            <xsl:call-template name="obtainConstExpr">
                <xsl:with-param name="expressionTree" select="$type_spec_node//string_type//const_exp"/>
            </xsl:call-template>                                                                                
        </xsl:if>
        <xsl:if test="$type_spec_node//wide_string_type">
            <xsl:call-template name="obtainConstExpr">
                <xsl:with-param name="expressionTree" select="$type_spec_node//wide_string_type//const_exp"/>
            </xsl:call-template>                                                                                
        </xsl:if>             
    </xsl:template>        
		
    <!-- Extract type name give a type_spec node of structure declaration 
         For String node, we use the presense of element "string_type" as
         a direct/indirect child as the test. For the rest, we use the value
         of direct/indirect "identifier" element as the type 
    -->

    <xsl:template name="checkForPrimitiveTypesNotAllowed">
        <xsl:param name="type"/>    
        <xsl:if test="$type='bool'">
            <xsl:message  terminate="yes">
Error: 'bool' is not a valid primitive type in IDL. You should use 'boolean' instead.
            </xsl:message>
        </xsl:if>
        <xsl:if test="$type='int'">
            <xsl:message  terminate="yes">
Error: 'int' is not a valid primitive type in IDL. You should use 'long' instead.
            </xsl:message>
        </xsl:if>
    </xsl:template>        
    

    <!-- The following template get the value for the directive resolve-name in the current node
         If the directive doesn't exist the template return 'true'
    -->
    <xsl:template name="resolveName">
        <xsl:param name="node"/>
<!--        <xsl:variable name="directiveNode"
            select="$node/following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'resolve-name']"/> -->
        <xsl:variable name="directiveNode"
            select="$node/ancestor-or-self::node()/following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'resolve-name']"/>
                        
        <xsl:if test="$directiveNode">
            <xsl:if test="$directiveNode/text()='false'">
                <xsl:value-of select="'false'"/>                                
            </xsl:if>
            <xsl:if test="not($directiveNode/text()='false')">
                <xsl:value-of select="'true'"/>                
            </xsl:if>
        </xsl:if>
        <xsl:if test="not($directiveNode)">
            <xsl:value-of select="'true'"/>
        </xsl:if>            
        
    </xsl:template>
    
    <xsl:template name="getValueMemberId">
        <xsl:param name="member"/>
        <xsl:param name="name"/>
        <xsl:param name="baseClass" select="''"/>

        <xsl:variable name="precExplicitMemberId" select="($member/../preceding-sibling::directive[@kind='ID'])[last()]"/>

        <xsl:variable name="precExplicitMemberIdPosition">
            <xsl:value-of select="count($precExplicitMemberId/preceding-sibling::value_element/state_member/declarators/declarator)"/>
        </xsl:variable>

        <xsl:variable name="baseClassModified">
                <xsl:call-template name="replace-string">
                    <xsl:with-param name="text" select="$baseClass"/>
                    <xsl:with-param name="search" select="'::'"/>
                    <xsl:with-param name="replace" select="'_'"/>
                </xsl:call-template>
        </xsl:variable>
        
        <xsl:choose>
            <xsl:when test="$member/../following-sibling::directive[@kind='ID' and ./preceding-sibling::value_element[position()=1 and ./state_member/declarators/declarator[last()]/identifier/text()=$name]]">
                <xsl:value-of  select="($member/../following-sibling::directive[@kind='ID'])[1]"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="$xml != 'yes'">
                    <xsl:variable name="declaratorPosition">
                        <xsl:value-of  select="count($member/../preceding-sibling::value_element/state_member/declarators/declarator) + 
                                               count($member/declarators/declarator[$name = ./identifier/text()]/preceding-sibling::declarator) + 1"/>
                    </xsl:variable>
                    
                    <xsl:choose>
                        <xsl:when test="not($precExplicitMemberId)">
                            <xsl:if test="$baseClass = ''">
                                <xsl:value-of  select="$declaratorPosition - 1" />
                            </xsl:if>
                            <xsl:if test="$baseClass != ''">
                                <xsl:choose>
                                    <xsl:when test="$xml != 'yes' and $language='JAVA'">
                                        <xsl:value-of  select="concat('(',$baseClass,'TypeSupport',$namespaceSeparator,'LAST_MEMBER_ID + ',$declaratorPosition,')')" />
                                    </xsl:when>
                                    <xsl:when test="$xml != 'yes' and $language='C++' and $namespace='yes'">
                                        <xsl:value-of  select="concat('(',$baseClassModified,'_','LAST_MEMBER_ID + ',$declaratorPosition,')')" />
                                    </xsl:when>
                                   <xsl:otherwise>
                                       <xsl:value-of  select="concat('(',$baseClass,$namespaceSeparator,'LAST_MEMBER_ID + ',$declaratorPosition,')')" />
                                   </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of  select="$precExplicitMemberId/text() + ($declaratorPosition - $precExplicitMemberIdPosition)" /> 
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="getMemberId">
        <xsl:param name="member"/>
        <xsl:param name="name"/>
        <xsl:param name="baseClass" select="''"/>

        <xsl:variable name="precExplicitMemberId" select="($member/preceding-sibling::directive[@kind='ID'])[last()]"/>

        <xsl:variable name="precExplicitMemberIdPosition">
            <xsl:value-of select="count($precExplicitMemberId/preceding-sibling::member/declarators/declarator)"/>
        </xsl:variable>

        <xsl:variable name="baseClassModified">
                <xsl:call-template name="replace-string">
                    <xsl:with-param name="text" select="$baseClass"/>
                    <xsl:with-param name="search" select="'::'"/>
                    <xsl:with-param name="replace" select="'_'"/>
                </xsl:call-template>
        </xsl:variable>
             

        <xsl:choose>
            <xsl:when test="$member/following-sibling::directive[@kind='ID' and ./preceding-sibling::member[position()=1 and ./declarators/declarator[last()]/identifier/text()=$name]]">
                <xsl:value-of  select="($member/following-sibling::directive[@kind='ID'])[1]"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="$xml != 'yes'">
                    <xsl:variable name="declaratorPosition">
                        <xsl:value-of  select="count($member/preceding-sibling::member/declarators/declarator) + 
                                               count($member/declarators/declarator[$name = ./identifier/text()]/preceding-sibling::declarator) + 1"/>
                    </xsl:variable>

                    <xsl:choose>
                        <xsl:when test="not($precExplicitMemberId)">
                            <xsl:if test="$baseClass = ''">
                                <xsl:value-of  select="$declaratorPosition - 1" />
                            </xsl:if>
                            <xsl:if test="$baseClass != ''">
                                <xsl:choose>
                                    <xsl:when test="$xml != 'yes' and $language='JAVA'">
                                        <xsl:value-of  select="concat('(',$baseClass,'TypeSupport',$namespaceSeparator,'LAST_MEMBER_ID + ',$declaratorPosition,')')" />
                                    </xsl:when>
                                    <xsl:when test="$xml != 'yes' and $language='C++' and $namespace='yes'">
                                        <xsl:value-of  select="concat('(',$baseClassModified,'_','LAST_MEMBER_ID + ',$declaratorPosition,')')" />
                                    </xsl:when>
                                   <xsl:otherwise>
                                       <xsl:value-of  select="concat('(',$baseClass,$namespaceSeparator,'LAST_MEMBER_ID + ',$declaratorPosition,')')" />
                                   </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of  select="$precExplicitMemberId/text() + ($declaratorPosition - $precExplicitMemberIdPosition)" /> 
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="getUnionMemberId">
        <xsl:param name="case_stmt"/>
        <xsl:param name="name"/>

        <xsl:variable name="precExplicitMemberId" select="($case_stmt/preceding-sibling::directive[@kind='ID'])[last()]"/>

        <xsl:variable name="precExplicitMemberIdPosition">
            <xsl:value-of select="count($precExplicitMemberId/preceding-sibling::case_stmt/element_spec/declarator)"/>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$case_stmt/following-sibling::directive[@kind='ID' and ./preceding-sibling::case_stmt[position()=1 and ./element_spec/declarator/identifier/text()=$name]]">
                <xsl:value-of  select="($case_stmt/following-sibling::directive[@kind='ID'])[1]"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="$xml != 'yes'">
                    <xsl:variable name="declaratorPosition">
                        <xsl:value-of  select="count($case_stmt/preceding-sibling::case_stmt/element_spec/declarator) + 1" />
                    </xsl:variable>

                    <xsl:choose>
                        <xsl:when test="not($precExplicitMemberId)">
                            <xsl:value-of  select="$declaratorPosition" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of  select="$precExplicitMemberId/text() + ($declaratorPosition - $precExplicitMemberIdPosition)" /> 
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- -->
    <xsl:template name="getScopedName">
        <xsl:param name="scopedNameNode"/>
        <xsl:value-of select="$scopedNameNode/opt_scope_op"/>
        <xsl:for-each select="$scopedNameNode/identifier">
            <xsl:choose>
                <xsl:when test="position()=last()">
                    <xsl:value-of select="."/>                                                                                                                
                </xsl:when>
                <xsl:otherwise>                                
                    <xsl:value-of select="concat(.,'::')"/>                                                                                
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>                
    </xsl:template>

    <!-- -->
    <xsl:template name="getValueTypeOptionalValue">
        <xsl:param name="member"/>
        <xsl:param name="name"/>
        
        <xsl:choose>
            <!-- Get the first 'Optional' directive that follows the current 
                 member but avoid those following a different member (which
                 are still sibling tags) -->
            <xsl:when test="$member/../following-sibling::directive[@kind='Optional' and ./preceding-sibling::value_element[position()=1 and ./state_member/declarators/declarator[last()]/identifier/text()=$name]]">
                <xsl:choose>
                    <xsl:when test="($member/../following-sibling::directive[@kind='Optional'])[1]='0'">
                        <!-- //@Optional 0 -->
                        <xsl:text>false</xsl:text>
                    </xsl:when>
                    <xsl:when test="($member/../following-sibling::directive[@kind='Optional'])[1]='false'">
                        <!-- //@Optional false -->
                        <xsl:text>false</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- //@Optional <anything>
                             or just:
                             //@Optional 
                         -->
                        <xsl:text>true</xsl:text>
                    </xsl:otherwise>                
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <!-- No //@Optional annotation -->
                <xsl:if test="$xml != 'yes'">
                    <xsl:text>false</xsl:text>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="getOptionalValue">
        <xsl:param name="member"/>
        <xsl:param name="name"/>
        
        <xsl:choose>
            <!-- Get the first 'Optional' directive that follows the current 
                 member but avoid those following a different member (which
                 are still sibling tags) -->
            <xsl:when test="$member/following-sibling::directive[@kind='Optional' and ./preceding-sibling::member[position()=1 and ./declarators/declarator[last()]/identifier/text()=$name]]">
                <xsl:choose>
                    <xsl:when test="($member/following-sibling::directive[@kind='Optional'])[1]='0'">
                        <!-- //@Optional 0 -->
                        <xsl:text>false</xsl:text>
                    </xsl:when>
                    <xsl:when test="($member/following-sibling::directive[@kind='Optional'])[1]='false'">
                        <!-- //@Optional false -->
                        <xsl:text>false</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- //@Optional <anything>
                             or just:
                             //@Optional 
                         -->
                        <xsl:text>true</xsl:text>
                    </xsl:otherwise>                
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <!-- No //@Optional annotation -->
                <xsl:if test="$xml != 'yes'">
                    <xsl:text>false</xsl:text>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!--  -->
    <xsl:template name="symbolToLanguageFormat">
        <xsl:param name="symbol"/>                
        <xsl:param name="symbolKind" select="'type'"/>
        <xsl:param name="resolveName" select="'true'"/>
        <xsl:param name="targetLanguage" select="$language"/>
        <xsl:param name="targetNamespaceSeparator" select="$namespaceSeparator"/>

        <xsl:if test="$symbol='any'">
            <xsl:message  terminate="yes">
                <xsl:text> Error: type 'any' is not supported</xsl:text>
            </xsl:message>
        </xsl:if>

        <xsl:variable name="prefix">
            <xsl:if test="$packagePrefix">
                <xsl:value-of
                    select="concat($packagePrefix, $targetNamespaceSeparator)"/>
            </xsl:if>

            <xsl:if test="$targetLanguage='ADA'">
                <!-- For ADA we have to add a prefix only when the type is not contained in a module -->
                <xsl:if test="substring-before($symbol,'::') = ''">
                    <xsl:value-of select="concat($sourceFileName,'_IDL_File.')"/>
                </xsl:if>
            </xsl:if>
        </xsl:variable>
        
        <xsl:variable name="result">
            <xsl:call-template name="symbolToLanguageFormatWithoutPrefix">
                <xsl:with-param name="symbol" select="$symbol"/>
                <xsl:with-param name="targetNamespaceSeparator" select="$targetNamespaceSeparator"/>
            </xsl:call-template >                                    
        </xsl:variable>
        
        <xsl:variable name="typeKind">
            <xsl:if test="$symbolKind='type' or $targetLanguage='JAVA'">
                <xsl:call-template name="obtainTypeKind">                
                    <xsl:with-param name="type" select="$symbol"/>                    
                </xsl:call-template>              
            </xsl:if>                                  
        </xsl:variable>
        
        <xsl:choose>
            <xsl:when test="$resolveName='false'">
                <xsl:value-of select="$result"/>                                                
            </xsl:when>
            <xsl:when test="$symbolKind='const' and contains($symbol,'.VALUE') and $corbaHeader='none'">                
                <xsl:value-of select="concat($prefix,$result)"/>                
            </xsl:when>
            <xsl:when test="$symbolKind='const' and contains($symbol,'.value') and $corbaHeader!='none'">                
                <xsl:value-of select="concat($prefix,$result)"/>                
            </xsl:when>
            <xsl:when test="$symbolKind='const' and contains($symbol,'.') and $targetLanguage='JAVA'">                
                <xsl:value-of select="concat($prefix,$result)"/>
            </xsl:when>
            <xsl:when test="$symbolKind='const' and
                            contains($symbol, '::') and
                            $targetLanguage='C++' and
                            $isManagedCpp='yes'">                
                <xsl:value-of select="concat($prefix, $result)"/>
            </xsl:when>
            <xsl:when test="$typeKind='user' and $symbol!='string' and $symbol!='wstring'">
                <xsl:value-of select="concat($prefix,$result)"/>
            </xsl:when>
            <xsl:otherwise>                
                <xsl:value-of select="$result"/>                                        
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="symbolToLanguageFormatWithoutPrefix">
        <xsl:param name="symbol"/>
        <xsl:param name="targetNamespaceSeparator" select="$namespaceSeparator"/>
            
        <xsl:if test="not(contains($symbol,'::'))">                
            <xsl:value-of select="$symbol"/>
        </xsl:if>
        <xsl:if test="contains($symbol,'::') and $targetNamespaceSeparator!= '::'">
            <xsl:value-of select="concat(substring-before($symbol,'::'),$targetNamespaceSeparator)"/>
            <xsl:call-template name="symbolToLanguageFormatWithoutPrefix">
                <xsl:with-param name="symbol" select="substring-after($symbol,'::')"/>
                <xsl:with-param name="targetNamespaceSeparator" select="$targetNamespaceSeparator"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:if test="contains($symbol,'::') and $targetNamespaceSeparator= '::'">
            <xsl:value-of select="$symbol"/>                
        </xsl:if>
    </xsl:template>

    <!-- 
    The following template gets the path (from the root) to the current module
    The output has the following form:
    <module>::...::<module>::
    -->
    <xsl:template name="getModulePath">
        <xsl:param name="moduleNode"/>  <!-- may be a module node or the specification node (root) --> 

        <xsl:choose>
            <xsl:when test="name($moduleNode)='module' or 
                            name($moduleNode)='value_abs_dcl' or
                            name($moduleNode)='interf'">
                <xsl:for-each select="$moduleNode/ancestor::module">
                    <xsl:value-of select="concat(./identifier,'::')"/>
                </xsl:for-each>
                <xsl:value-of select="concat($moduleNode/identifier,'::')"/>
            </xsl:when>
            <xsl:when test="name($moduleNode)='value_dcl'">
                <xsl:for-each select="$moduleNode/ancestor::module">
                    <xsl:value-of select="concat(./identifier,'::')"/>
                </xsl:for-each>
                <xsl:value-of select="concat($moduleNode/value_header/identifier,'::')"/>
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <!-- 
    The following template indicates if a symbol is defined in a module or not.
    This template takes into account that a module may be opened in several parts of the IDL file
    If the symbol is part of an enum type this template return the equivalent value
    -->
    <xsl:template name="symbolDefined">
        <xsl:param name="moduleNode"/>
        <xsl:param name="symbol"/>               
        <xsl:param name="kind" select='type'/>
        <xsl:param name="discriminatorType" select="''"/>
        
        <xsl:if test="$kind = 'type'">
            <xsl:if test="$moduleNode/definition/type_dcl//declarator/identifier[text()=$symbol] or
                          $moduleNode/definition/type_dcl/child::*/identifier[text()=$symbol] or
                          $moduleNode/definition/type_dcl//constr_type_spec/child::*/identifier[text()=$symbol] or
                          $moduleNode/definition/value/value_abs_dcl[./identifier=$symbol] or
                          $moduleNode/definition/value/value_box_dcl[./identifier=$symbol] or
                          $moduleNode/definition/value/value_dcl/value_header[./identifier=$symbol] or
                          $moduleNode/definition/value/value_forward_dcl[./identifier=$symbol] or
                          $moduleNode/definition/interf/identifier[text()=$symbol]">
                symbol_defined
            </xsl:if>
        </xsl:if>                   

        <!-- we check for const or enum definitios -->
        <xsl:if test="$kind = 'const'">
            <xsl:choose>
                <xsl:when test="$moduleNode/definition/const_dcl/identifier[text()=$symbol]">
                    symbol_defined
                </xsl:when>
                <xsl:when test="$moduleNode/export/const_dcl/identifier[text()=$symbol]">
                    <!-- Const inside an abstract value type -->
                    symbol_defined
                </xsl:when>
                <xsl:when test="$moduleNode/value_element/export/const_dcl/identifier[text()=$symbol]">
                    <!-- Const inside a concrete value type -->
                    symbol_defined
                </xsl:when>            
                <xsl:when test="$moduleNode/definition/type_dcl//enum_type[./identifier[text()=$discriminatorType]]//enumerator/identifier[text()=$symbol]">
                    symbol_enum_defined::<xsl:value-of select="$moduleNode/definition/type_dcl//enum_type[./identifier[text()=$discriminatorType] and .//enumerator/identifier[text()=$symbol]]/identifier"/>
                </xsl:when>
                <xsl:when test="$moduleNode/definition/type_dcl//enum_type//enumerator/identifier[text()=$symbol]">
                    symbol_enum_defined::<xsl:value-of select="$moduleNode/definition/type_dcl//enum_type[.//enumerator/identifier[text()=$symbol]]/identifier"/>
                </xsl:when>  
                <xsl:otherwise>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        
    </xsl:template>
    
    <!-- -->
    <xsl:template name="getFirstSymbolReference">
        <xsl:param name="symbolStr"/>

        <xsl:choose>

            <xsl:when test="contains($symbolStr,'|')">
                <xsl:variable name="beforeStr" select="substring-before($symbolStr,'|')"/>

                <xsl:if test="$beforeStr != ''">
                    <xsl:value-of select="$beforeStr"/>
                </xsl:if>

                <xsl:if test="$beforeStr = ''">
                    <xsl:call-template name="getFirstSymbolReference">
                        <xsl:with-param name="symbolStr" select="substring-after($symbolStr,'|')"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:when>

            <xsl:otherwise>
                <xsl:value-of select="$symbolStr"/>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>
    
    <!-- 
    This template resolve the name of a symbol (type or const or enum) in the scope of the module passed as a parameter
    If the symbol cannot be solved the template return the empty string    
    -->
    <xsl:template name="resolveSymbolInCurrentModule">
        <xsl:param name="moduleNode"/>  <!-- <module> or <specification> node --> 
        <xsl:param name="symbol"/>
        <xsl:param name="kind" select="'type'"/> <!-- The possible values are 'type' and 'const' -this last one includes enum -  -->
        <xsl:param name="discriminatorType" select="''"/>
                
        <xsl:variable name="modulePath">            
            <xsl:call-template name="getModulePath">
                <xsl:with-param name="moduleNode" select="$moduleNode"/>                
            </xsl:call-template>                            
        </xsl:variable>
                                
        <xsl:variable name="rootSymbol">
            <xsl:if test="starts-with($symbol,'::')">yes</xsl:if>        
            <xsl:if test="not(starts-with($symbol,'::'))">no</xsl:if>                    
        </xsl:variable>
                        
        <xsl:variable name="relativeSymbol">
            <xsl:if test="$rootSymbol='yes'">
                <xsl:value-of select="substring-after($symbol,'::')"/>
            </xsl:if>        
            <xsl:if test="$rootSymbol='no'">
                <xsl:value-of select="$symbol"/>
            </xsl:if>                    
        </xsl:variable>
        
        <xsl:variable name="symbolDefined">
            <xsl:if test="not(contains($relativeSymbol,'::'))">
                <xsl:call-template name="symbolDefined">
                    <xsl:with-param name="moduleNode" select="$moduleNode"/>
                    <xsl:with-param name="symbol" select="$relativeSymbol"/>
                    <xsl:with-param name="kind" select="$kind"/>                            
                    <xsl:with-param name="discriminatorType" select="$discriminatorType"/>
                </xsl:call-template>
            </xsl:if>
        </xsl:variable>

        <xsl:if test="$symbolDefined!=''">
            <xsl:choose>
                <xsl:when test="contains($symbolDefined,'symbol_defined') and
                                         $kind='const' and $language='JAVA'">                                
                    <xsl:choose>
                        <xsl:when test="$corbaHeader = 'none'">
                            <xsl:value-of select="concat($modulePath,$relativeSymbol,'.VALUE')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="concat($modulePath,$relativeSymbol,'.value')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="contains($symbolDefined,'symbol_enum_defined') and $xml='yes'">
                    <xsl:value-of select="concat($modulePath,$relativeSymbol)"/>
                </xsl:when>
                <xsl:when test="contains($symbolDefined,'symbol_defined') and $xml='yes' and
                                $kind='const'">
                    <xsl:value-of select="concat($modulePath,$relativeSymbol)"/>
                </xsl:when>
                <xsl:when test="contains($symbolDefined,'symbol_enum_defined') and
                                         $kind='const' and $language='JAVA'">                                                    
                    <xsl:value-of select="concat($modulePath,                                                                                                  
                                                 substring-after($symbolDefined,'symbol_enum_defined::'),'.',
                                                 $relativeSymbol)"/>
                </xsl:when>
                <xsl:when test="contains($symbolDefined,'symbol_defined') and
                                $kind='const' and
                                $language='C++' and
                                $isManagedCpp='yes'">
                    <xsl:value-of
                        select="concat($modulePath,$relativeSymbol,'::VALUE')"/>
                </xsl:when>
                <xsl:when test="contains($symbolDefined,'symbol_enum_defined') and
                                $kind='const' and
                                $language='C++' and
                                $isManagedCpp='yes'">
                    <xsl:value-of
                        select="concat($modulePath,
                                       substring-after($symbolDefined,'symbol_enum_defined::'),
                                       '::',
                                       $relativeSymbol)"/>
                </xsl:when>
                <xsl:when test="contains($symbolDefined,'symbol_enum_defined') and $language='C++' and $namespace='no'">
                    <xsl:value-of select="$relativeSymbol"/>
                </xsl:when>
                <xsl:when test="contains($symbolDefined,'symbol_enum_defined') and $language='C'">
                    <xsl:value-of select="$relativeSymbol"/>
                </xsl:when>
                <xsl:when test="contains($symbolDefined,'symbol_enum_defined')">
                    <xsl:value-of select="concat($modulePath,$relativeSymbol)"/>
                </xsl:when>
                <xsl:when test="contains($symbolDefined,'symbol_defined')">
                    <xsl:value-of select="concat($modulePath,$relativeSymbol)"/>  
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$symbolDefined"/> 
                </xsl:otherwise>                                                        
            </xsl:choose>                        
        </xsl:if>
        
        <xsl:if test="$symbolDefined='' and contains($relativeSymbol,'::')">
            <xsl:variable name="innerModule" select="substring-before($relativeSymbol,'::')"/>

            <xsl:variable name="symbolStr">
                <xsl:for-each select="$moduleNode/definition/module[./identifier/text()=$innerModule]">
                    <xsl:call-template name="resolveSymbolInCurrentModule">
                        <xsl:with-param name="moduleNode" select="."/>        
                        <xsl:with-param name="symbol" select="substring-after($relativeSymbol,'::')"/>
                        <xsl:with-param name="kind" select="$kind"/>     
                        <xsl:with-param name="discriminatorType" select="$discriminatorType"/>                                                       
                    </xsl:call-template>
                    <xsl:text>|</xsl:text>
                </xsl:for-each>

                <xsl:if test="$kind = 'const'">
                    <xsl:for-each select="$moduleNode/definition/value/value_dcl
                                            [./value_header/identifier=$innerModule] |
                                          $moduleNode/definition/value/value_abs_dcl
                                            [./identifier=$innerModule]">
                        <xsl:call-template name="resolveSymbolInCurrentModule">
                            <xsl:with-param name="moduleNode" select="."/>        
                            <xsl:with-param name="symbol" select="substring-after($relativeSymbol,'::')"/>
                            <xsl:with-param name="kind" select="$kind"/>     
                            <xsl:with-param name="discriminatorType" select="$discriminatorType"/>                                                       
                        </xsl:call-template>
                        <xsl:text>|</xsl:text>
                    </xsl:for-each>
                </xsl:if>
            </xsl:variable>

            <xsl:call-template name="getFirstSymbolReference">
                <xsl:with-param name="symbolStr" select="$symbolStr"/>
            </xsl:call-template>

        </xsl:if>
    </xsl:template>

    <!-- 
    This template resolve the name of a symbol (type or const or enum) going from the inner scope to the outer
    If the symbol cannot be solved the template return the empty string        
    -->
    <xsl:template name="resolveSymbol">
        <xsl:param name="moduleNode"/>        
        <xsl:param name="symbol"/>
        <xsl:param name="kind" select="'type'"/> <!-- The possible values are 'type' and 'const' -->
        <xsl:param name="discriminatorType" select="''"/>

        <xsl:variable name="result">
            <xsl:if test="name($moduleNode)='specification' or 
                          name($moduleNode)='value_dcl' or
                          name($moduleNode)='value_abs_dcl'">
                <xsl:call-template name="resolveSymbolInCurrentModule">
                    <xsl:with-param name="moduleNode" select="$moduleNode"/>        
                    <xsl:with-param name="symbol" select="$symbol"/>
                    <xsl:with-param name="kind" select="$kind"/>     
                    <xsl:with-param name="discriminatorType" select="$discriminatorType"/>           
                </xsl:call-template>        
            </xsl:if>

            <xsl:if test="name($moduleNode)='module'">
                <xsl:variable name="modulePath">            
                    <xsl:call-template name="getModulePath">
                        <xsl:with-param name="moduleNode" select="$moduleNode"/>                
                    </xsl:call-template>                            
                </xsl:variable>

                <xsl:for-each select="//module[./identifier = $moduleNode/identifier]">
                    <xsl:variable name="newModulePath">            
                        <xsl:call-template name="getModulePath">
                            <xsl:with-param name="moduleNode" select="."/>
                        </xsl:call-template>
                    </xsl:variable>
    
                    <xsl:if test="$newModulePath = $modulePath">
                        <xsl:variable name="symbolStr">
                            <xsl:call-template name="resolveSymbolInCurrentModule">
                                <xsl:with-param name="moduleNode" select="."/>        
                                <xsl:with-param name="symbol" select="$symbol"/>
                                <xsl:with-param name="kind" select="$kind"/>     
                                <xsl:with-param name="discriminatorType" select="$discriminatorType"/>           
                            </xsl:call-template>
                        </xsl:variable>

                        <xsl:value-of select="$symbolStr"/>

                        <xsl:if test="$symbolStr != ''">
                            <xsl:text>|</xsl:text>
                        </xsl:if>
                    </xsl:if>
                </xsl:for-each>
            </xsl:if>
        </xsl:variable>    
                                
        <xsl:choose>
            <xsl:when test="$result!=''">
                <!-- the string 'result' has the format <full qualified symbol>|<full qualified symbol>|...
                     A symbol could be defined several times if we use forward declaration.
                     In that case we need to take only the first definition
                -->
                <xsl:variable name="firstResult">
                    <xsl:call-template name="getFirstSymbolReference">
                        <xsl:with-param name="symbolStr" select="$result"/>
                    </xsl:call-template>
                </xsl:variable>

                <xsl:choose>
                    <xsl:when test="$kind!='const' and $language='ADA'">
                        <xsl:value-of select="$firstResult"/>
                        <!--
                        <xsl:text>.</xsl:text>
                        <xsl:call-template name="getLastSymbolComponent">
                            <xsl:with-param name="symbolStr" select="$firstResult"/>
                        </xsl:call-template>
                        -->
                    </xsl:when>
                    <xsl:otherwise>
                <xsl:value-of select="$firstResult"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="name($moduleNode)!='specification'">
                <xsl:if test="($moduleNode/ancestor::module)[last()]">
                    <xsl:call-template name="resolveSymbol">
                        <xsl:with-param name="moduleNode" select="($moduleNode/ancestor::module)[last()]"/>        
                        <xsl:with-param name="symbol" select="$symbol"/>
                        <xsl:with-param name="kind" select="$kind"/>                                    
                        <xsl:with-param name="discriminatorType" select="$discriminatorType"/>
                    </xsl:call-template>                                    
                </xsl:if>
                <xsl:if test="not(($moduleNode/ancestor::module)[last()])">            
                    <xsl:call-template name="resolveSymbol">
                        <xsl:with-param name="moduleNode" select="/specification"/>        
                        <xsl:with-param name="symbol" select="$symbol"/>
                        <xsl:with-param name="kind" select="$kind"/>                                    
                        <xsl:with-param name="discriminatorType" select="$discriminatorType"/>
                    </xsl:call-template>                                    
                </xsl:if>                
            </xsl:when>
            <xsl:otherwise>
                <!-- <xsl:message  terminate="no">
                    Warning: The symbol "<xsl:value-of select="$symbol"/>" cannot be solved in this IDL file. It would be necessary define this symbol to compile the generated code.
                </xsl:message> -->
                <xsl:choose>
                    <xsl:when test="$kind!='const' and $language='ADA'">
                        <xsl:value-of select="$symbol"/>
                        <!--
                        <xsl:text>.</xsl:text>
                        <xsl:call-template name="getLastSymbolComponent">
                            <xsl:with-param name="symbolStr" select="$symbol"/>
                        </xsl:call-template>
                        -->
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$symbol"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
                                
    </xsl:template>        
             
    <!-- -->
    <xsl:template name="obtainUnionSwitchType">
        <xsl:param name="switchTypeSpecNode"/>

        <xsl:choose>            
            <xsl:when test="$switchTypeSpecNode/scoped_name">                
                <xsl:variable name="relativeType">
                    <xsl:call-template name="getScopedName">
                        <xsl:with-param name="scopedNameNode" select="$switchTypeSpecNode/scoped_name"/>
                    </xsl:call-template>
                </xsl:variable>                
                <xsl:choose>
                    <xsl:when test="($switchTypeSpecNode/ancestor::module)[last()]">                                                    
                        <xsl:call-template name="resolveSymbol">
                            <xsl:with-param name="moduleNode" select="($switchTypeSpecNode/ancestor::module)[last()]"/>
                            <xsl:with-param name="symbol" select="$relativeType"/>
                            <xsl:with-param name="kind" select="'type'"/>                            
                        </xsl:call-template>                                                                        
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="resolveSymbol">
                            <xsl:with-param name="moduleNode" select="/specification"/>
                            <xsl:with-param name="symbol" select="$relativeType"/>
                            <xsl:with-param name="kind" select="'type'"/>                            
                        </xsl:call-template>                                                                        
                    </xsl:otherwise>
                </xsl:choose>               
            </xsl:when>                            
            <xsl:otherwise>
                <xsl:value-of select="$switchTypeSpecNode/*"/>
            </xsl:otherwise>                                                 
        </xsl:choose>
        
    </xsl:template>

    <!-- -->
    <xsl:template name="resolveScopedName">
        <xsl:param name="scopedNameNode"/>
        <xsl:param name="resolveName" select="'true'"/>
                                            
        <xsl:variable name="relativeType">
            <xsl:call-template name="getScopedName">
                <xsl:with-param name="scopedNameNode" select="$scopedNameNode"/>
            </xsl:call-template>
        </xsl:variable>
            
        <!-- Get the absolute type specification:
             1.- If the type start with :: we solve using the global scope
             2.- We try to solve using the module scope where the type it is used.
             3.- We try to solve using the scopes of the modules that contain the current one
        -->

        <xsl:choose>
            <xsl:when test="$resolveName='false'">                
                <xsl:value-of select="$relativeType"/>
            </xsl:when>
            <xsl:when test="($scopedNameNode/ancestor::module)[last()]">                                                    
                <xsl:call-template name="resolveSymbol">
                    <xsl:with-param name="moduleNode" select="($scopedNameNode/ancestor::module)[last()]"/>
                    <xsl:with-param name="symbol" select="$relativeType"/>
                    <xsl:with-param name="kind" select="'type'"/>                            
                </xsl:call-template>                                                                        
            </xsl:when>                        
            <xsl:otherwise>
                <xsl:call-template name="resolveSymbol">
                    <xsl:with-param name="moduleNode" select="/specification"/>
                    <xsl:with-param name="symbol" select="$relativeType"/>
                    <xsl:with-param name="kind" select="'type'"/>                            
                </xsl:call-template>                                                                        
            </xsl:otherwise>
        </xsl:choose>
                                                                                        
    </xsl:template>

    <!-- -->
    <xsl:template name="isKeyedStructType">
        <xsl:param name="structTypeModuleNode" select="/specification"/>
        <xsl:param name="structTypeName"/> <!-- Full qualified name -->

        <xsl:variable name="moduleName">
            <xsl:value-of select="substring-before($structTypeName,'::')"/>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$moduleName!=''">
                <xsl:variable name="isKeyed">
                    <!-- A module can be opened multiple times -->
                    <xsl:for-each select="$structTypeModuleNode/definition/module[./identifier/text()=$moduleName]">
                        <xsl:call-template name="isKeyedStructType">
                            <xsl:with-param name="structTypeModuleNode" select="."/>
                            <xsl:with-param name="structTypeName" select="substring-after($structTypeName,'::')"/>
                        </xsl:call-template>
                    </xsl:for-each>
                </xsl:variable>

                <xsl:choose>
                    <xsl:when test="contains($isKeyed,'yes')">
                        <xsl:text>yes</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>no</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="baseClassNode"
                    select="$structTypeModuleNode/definition/type_dcl/struct_type[./identifier/text() = $structTypeName]"/>
                <xsl:choose>
                    <xsl:when test="$baseClassNode">
                        <xsl:choose>
                            <xsl:when test="$baseClassNode//directive[@kind='key' or @kind='Key']">
                                <xsl:text>yes</xsl:text>
                            </xsl:when>
                            <xsl:when test="$baseClassNode//struct_inheritance_spec/struct_name[1]">
                                <!-- If there is another base class -->
                                <xsl:variable name="baseClassName">
                                    <xsl:call-template name="resolveScopedName">
                                       <xsl:with-param name="scopedNameNode" 
                                           select="$baseClassNode//struct_inheritance_spec/struct_name[1]/scoped_name"/>
                                    </xsl:call-template>
                                </xsl:variable>
                                <xsl:call-template name="isKeyedStructType">
                                    <xsl:with-param name="structTypeName" select="$baseClassName"/> <!-- Full qualified name -->
                                </xsl:call-template>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>no</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>no</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- -->
    <xsl:template name="isKeyedValueType">
        <xsl:param name="valueTypeModuleNode" select="/specification"/>
        <xsl:param name="valueTypeName"/> <!-- Full qualified name -->

        <xsl:variable name="moduleName">
            <xsl:value-of select="substring-before($valueTypeName,'::')"/>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$moduleName!=''">
                <xsl:variable name="isKeyed">
                    <!-- A module can be opened multiple times -->
                    <xsl:for-each select="$valueTypeModuleNode/definition/module[./identifier/text()=$moduleName]">
                        <xsl:call-template name="isKeyedValueType">
                            <xsl:with-param name="valueTypeModuleNode" select="."/>
                            <xsl:with-param name="valueTypeName" select="substring-after($valueTypeName,'::')"/>
                        </xsl:call-template>
                    </xsl:for-each>
                </xsl:variable>

                <xsl:choose>
                    <xsl:when test="contains($isKeyed,'yes')">
                        <xsl:text>yes</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>no</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="baseClassNode"
                    select="$valueTypeModuleNode/definition/value/value_dcl[./value_header/identifier/text() = $valueTypeName]"/>

                <xsl:choose>
                    <xsl:when test="$baseClassNode">
                        <xsl:choose>
                            <xsl:when test="$baseClassNode//directive[@kind='key'  or @kind='Key']">
                                <xsl:text>yes</xsl:text>
                            </xsl:when>
                            <xsl:when test="$baseClassNode//value_inheritance_spec/value_name[1]">
                                <!-- If there is another base class -->
                                <xsl:variable name="baseClassName">
                                    <xsl:call-template name="resolveScopedName">
                                       <xsl:with-param name="scopedNameNode" 
                                           select="$baseClassNode//value_inheritance_spec/value_name[1]/scoped_name"/>
                                    </xsl:call-template>
                                </xsl:variable>

                                <xsl:call-template name="isKeyedValueType">
                                    <xsl:with-param name="valueTypeName" select="$baseClassName"/> <!-- Full qualified name -->
                                </xsl:call-template>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>no</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>no</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- -->
    <xsl:template name="obtainConstType">
        <xsl:param name="constTypeNode"/>

        <xsl:choose>
            <xsl:when test="$constTypeNode/scoped_name">
                <xsl:variable name="relativeScopedName">
                    <xsl:call-template name="getScopedName">
                        <xsl:with-param name="scopedNameNode" select="$constTypeNode/scoped_name"/>
                    </xsl:call-template>
                </xsl:variable>

                <xsl:call-template name="checkForPrimitiveTypesNotAllowed">
                    <xsl:with-param name="type" select="$relativeScopedName"/>    
                </xsl:call-template>                

                <xsl:choose>
                    <xsl:when test="($constTypeNode/ancestor::module)[last()]">                                                    
                        <xsl:call-template name="resolveSymbol">
                            <xsl:with-param name="moduleNode" select="($constTypeNode/ancestor::module)[last()]"/>
                            <xsl:with-param name="symbol" select="$relativeScopedName"/>
                            <xsl:with-param name="kind" select="'type'"/>                            
                        </xsl:call-template>                                                                        
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="resolveSymbol">
                            <xsl:with-param name="moduleNode" select="/specification"/>
                            <xsl:with-param name="symbol" select="$relativeScopedName"/>
                            <xsl:with-param name="kind" select="'type'"/>                            
                        </xsl:call-template>                                                                        
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$constTypeNode//*"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <!-- -->
    <xsl:template name="obtainStructMemberType">
        <xsl:param name="typeSpecNode"/>
        <xsl:param name="resolveName" select="'true'"/>

        <xsl:variable name="scopedNameSequenceNode" 
                      select="$typeSpecNode/simple_type_spec/template_type_spec/sequence_type/simple_type_spec/scoped_name"/>
                                            
        <xsl:choose>
                                      
            <xsl:when test="$typeSpecNode/simple_type_spec/scoped_name or $scopedNameSequenceNode">                
                <xsl:variable name="relativeType">
                    <xsl:if test="$typeSpecNode/simple_type_spec/scoped_name">
                        <xsl:call-template name="getScopedName">
                            <xsl:with-param name="scopedNameNode" select="$typeSpecNode/simple_type_spec/scoped_name"/>
                        </xsl:call-template>
                    </xsl:if>
                    
                    <xsl:if test="$scopedNameSequenceNode">                                                        
                        <xsl:call-template name="getScopedName">
                            <xsl:with-param name="scopedNameNode" select="$scopedNameSequenceNode"/>
                        </xsl:call-template>
                    </xsl:if>                                                                
                </xsl:variable>

                <!-- Get the absolute type specification:
                     1.- If the type start with :: we solve using the global scope
                     2.- We try to solve using the module scope where the type it is used.
                     3.- We try to solve using the scopes of the modules that contain the current one
                -->

                <xsl:call-template name="checkForPrimitiveTypesNotAllowed">
                    <xsl:with-param name="type" select="$relativeType"/>    
                </xsl:call-template>                

                <xsl:choose>
                    <xsl:when test="$resolveName='false'">                
                        <xsl:value-of select="$relativeType"/>
                    </xsl:when>
                    <xsl:when test="($typeSpecNode/ancestor::module)[last()]">                                                    
                        <xsl:call-template name="resolveSymbol">
                            <xsl:with-param name="moduleNode" select="($typeSpecNode/ancestor::module)[last()]"/>
                            <xsl:with-param name="symbol" select="$relativeType"/>
                            <xsl:with-param name="kind" select="'type'"/>                            
                        </xsl:call-template>                                                                        
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="resolveSymbol">
                            <xsl:with-param name="moduleNode" select="/specification"/>
                            <xsl:with-param name="symbol" select="$relativeType"/>
                            <xsl:with-param name="kind" select="'type'"/>                            
                        </xsl:call-template>                                                                        
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
                                                        
            <xsl:when test="$typeSpecNode/constr_type_spec">
                <xsl:value-of select="$typeSpecNode/constr_type_spec/node()/identifier"/>
            </xsl:when>
                
            <xsl:when test="$typeSpecNode//base_type_spec">                
                <xsl:value-of select="$typeSpecNode//base_type_spec/*"/>
            </xsl:when>
                
            <!-- When a string/wstring member has its length specified
                 (for example, "string<20> string member;", grabbing value
                 of //string_type also grabs the length. Threfore we need
                 additional processing to determine the correct type -->
            <xsl:when test="$typeSpecNode//string_type">string</xsl:when>                
            <xsl:when test="$typeSpecNode//wide_string_type">wstring</xsl:when>
                                
            <xsl:otherwise>
                <xsl:value-of select="$typeSpecNode//identifier"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Obtain constant expression used in constant definiton, arrary and sequence sizes,
         string max sizes, etc. -->
    <xsl:template name="obtainConstExpr">
        <xsl:param name="expressionTree"/>
        <xsl:variable name="expression">
            <xsl:apply-templates select="$expressionTree"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$expressionTree//string_literal">
                <xsl:value-of select="$expression"/>
            </xsl:when>
            <xsl:when test="$expressionTree//character_literal">
                <xsl:value-of select="$expression"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="translate(normalize-space($expression),' ','')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Surround each const_exp by a pair of parantheses -->
    <xsl:template match="primary_expr/const_exp">
        <xsl:if test="not(starts-with(./text(),'('))">
          (
        </xsl:if>
        <xsl:apply-templates/>
        <xsl:if test="not(starts-with(./text(),'('))">
          )
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="primary_expr/scoped_name">
          (
        <xsl:variable name="relativeName">
            <xsl:call-template name="getScopedName">
                <xsl:with-param name="scopedNameNode" select="."/>
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:variable name="resolveName">
            <xsl:call-template name="resolveName">
                <xsl:with-param name="node" select="."/>
            </xsl:call-template>
        </xsl:variable>            
                
        <xsl:variable name="result">
            <xsl:choose>
                <xsl:when test="$resolveName='false'">
                    <!-- because we don't know about the type of this symbol
                         we cannot say wether it is a constant or an enum.
                         We're supposing the symbol correponds to a constant and 
                         we add the VALUE to it -->
                    <xsl:choose>
                        <xsl:when test="$language='JAVA'">
                            <xsl:choose>
                                <xsl:when test="$corbaHeader!='none'">
                                    <xsl:value-of select="concat($relativeName,'.value')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat($relativeName,'.VALUE')"/>
                                </xsl:otherwise>
                            </xsl:choose>                                
                        </xsl:when>
                        <xsl:when test="$language='C++' and
                                        $isManagedCpp='yes'">
                            <xsl:value-of
                                select="concat($relativeName,'::VALUE')"/>
                        </xsl:when>
                        <xsl:otherwise>                                
                            <xsl:value-of select="$relativeName"/>                                
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="./ancestor::value_abs_dcl">
                    <xsl:call-template name="resolveSymbol">
                        <xsl:with-param name="moduleNode" select="./ancestor::value_abs_dcl"/>
                        <xsl:with-param name="symbol" select="$relativeName"/>
                        <xsl:with-param name="kind" select="'const'"/>                    
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="./ancestor::value_dcl">
                    <xsl:call-template name="resolveSymbol">
                        <xsl:with-param name="moduleNode" select="./ancestor::value_dcl"/>
                        <xsl:with-param name="symbol" select="$relativeName"/>
                        <xsl:with-param name="kind" select="'const'"/>                    
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="(./ancestor::module)[last()]">
                    <xsl:variable name="discriminatorType">
                        <xsl:if test="./ancestor::union_type">
                            <xsl:value-of select="./ancestor::union_type/switch_type_spec//identifier[position()=last()]/text()"/>
                        </xsl:if>
                    </xsl:variable>

                    <xsl:call-template name="resolveSymbol">
                        <xsl:with-param name="moduleNode" select="(./ancestor::module)[last()]"/>
                        <xsl:with-param name="symbol" select="$relativeName"/>
                        <xsl:with-param name="kind" select="'const'"/>                    
                        <xsl:with-param name="discriminatorType" select="$discriminatorType"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="discriminatorType">
                        <xsl:if test="./ancestor::union_type">
                            <xsl:value-of select="./ancestor::union_type/switch_type_spec//identifier[position()=last()]/text()"/>
                        </xsl:if>
                    </xsl:variable>

                    <xsl:call-template name="resolveSymbol">
                        <xsl:with-param name="moduleNode" select="/specification"/>
                        <xsl:with-param name="symbol" select="$relativeName"/>
                        <xsl:with-param name="kind" select="'const'"/>      
                        <xsl:with-param name="discriminatorType" select="$discriminatorType"/>              
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose> 
        </xsl:variable> 

        <xsl:call-template name="symbolToLanguageFormat">
            <xsl:with-param name="symbol" select="$result"/>                
            <xsl:with-param name="symbolKind" select="'const'"/>
            <xsl:with-param name="resolveName" select="$resolveName"/>            
        </xsl:call-template>            
         ) 
    </xsl:template>
        
    <!-- -->
    <xsl:template match="primary_expr[identifier|literal]">
        <!-- Only one the following will be present in an element -->            
        <xsl:value-of select=".//identifier"/>
        <xsl:choose>
            <xsl:when test=".//literal/integer_literal">
                <xsl:value-of select=".//literal/*"/>
                    <xsl:choose>
                        <!-- The condition "name(..) = 'unary_expr' and ../text()='-' " is testing if the 
                        integer literal is a negative value. Additionally we are also testing if the 
                        language is Java or C++. The $isManagedCpp check is to exclude C++/CLI -->
                        <xsl:when test="name(..) = 'unary_expr' and ../text()='-' and 
                                        ($language ='JAVA' or ($language='C++' and $isManagedCpp='no'))">
                            <xsl:value-of select="mathParser:getTypeSuffix(.//literal/*,$language,1)"/>
                        </xsl:when>
                        <xsl:when test="not(name(..) = 'unary_expr' and ../text()='-') and 
                                        ($language ='JAVA' or ($language='C++' and $isManagedCpp='no'))">
                            <xsl:value-of select="mathParser:getTypeSuffix(.//literal/*,$language,0)"/>
                        </xsl:when>
                        <xsl:otherwise>
                        </xsl:otherwise>
                    </xsl:choose>
                            
                
            </xsl:when>
            <xsl:when test=".//literal/boolean_literal/text()='TRUE'">
                <xsl:choose>
                    <xsl:when test="$xml='yes'">
                        <xsl:value-of select="'true'"/>   
                    </xsl:when>
                    <xsl:when test="$language='JAVA' or
                                  ($language='C++' and $isManagedCpp='yes')">                        
                        <xsl:value-of select="'true'"/>
                    </xsl:when>
                    <xsl:when test="$language='C' or ($language='C++' and $isManagedCpp='no')">                        
                        <xsl:value-of select="'DDS_BOOLEAN_TRUE'"/>                        
                    </xsl:when>
                    <xsl:otherwise>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test=".//literal/boolean_literal/text()='FALSE'"> 
                <xsl:choose>
                    <xsl:when test="$xml='yes'">
                        <xsl:value-of select="'false'"/>   
                    </xsl:when>
                    <xsl:when test="$language='JAVA' or
                                  ($language='C++' and $isManagedCpp='yes')">                        
                        <xsl:value-of select="'false'"/>
                    </xsl:when>
                    <xsl:when test="$language='C' or ($language='C++' and $isManagedCpp='no')">                
                        <xsl:value-of select="'DDS_BOOLEAN_FALSE'"/>                                                        
                    </xsl:when>
                    <xsl:otherwise>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>            
            <xsl:otherwise>
                <xsl:value-of select=".//literal/*"/>
            </xsl:otherwise>
        </xsl:choose> 
    </xsl:template>
    
    <!--  
    -->
    <xsl:template name="obtainMemberKind">
        <xsl:param name="type_declarator"/>        
        <xsl:choose>
            <xsl:when test="$type_declarator//fixed_array_size">array</xsl:when>
            <xsl:when test="$type_declarator//sequence_type">sequence</xsl:when>        
            <xsl:when test="$type_declarator//string_type">string</xsl:when>
            <xsl:when test="$type_declarator//wide_string_type">string</xsl:when>
            <xsl:otherwise>scalar</xsl:otherwise>        
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="obtainTypeKind">
        <xsl:param name="type"/>    
        <xsl:choose>
            <xsl:when test="$typeInfoMap/type[@idlType=$type]">builtin</xsl:when>
            <xsl:otherwise>user</xsl:otherwise>        
        </xsl:choose>
    </xsl:template>
    
    <!-- -->
    <xsl:template name="isEnum">
        <xsl:param name="qualifiedType"/>
        <xsl:param name="scopeNode" select="/specification"/>
                        
        <xsl:variable name="newScopeNode" select="$scopeNode/definition/module[./identifier/text() = substring-before($qualifiedType,'::')]"/>        
        
        <xsl:if test="$newScopeNode">
            <xsl:call-template name="isEnum">
                <xsl:with-param name="qualifiedType" select="substring-after($qualifiedType,'::')"/>
                <xsl:with-param name="scopeNode" select="$newScopeNode"/>                
            </xsl:call-template>
        </xsl:if>
        
        <xsl:if test="not($newScopeNode)">
           <xsl:choose>
                <xsl:when test="$scopeNode/definition/type_dcl//enum_type[./identifier=$qualifiedType]">
                    <xsl:value-of select="'yes'"/>                        
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="'no'"/>                        
                </xsl:otherwise>
           </xsl:choose>
        </xsl:if>                
        
    </xsl:template>

    <!-- -->
    <xsl:template name="getEnumeratorCount">
        <xsl:param name="qualifiedType"/>
        <xsl:param name="scopeNode" select="/specification"/>

        <xsl:variable name="newScopeNode" select="$scopeNode/definition/module[./identifier/text() = substring-before($qualifiedType,'::')]"/>        

        <xsl:if test="$newScopeNode">
            <xsl:call-template name="getEnumeratorCount">
                <xsl:with-param name="qualifiedType" select="substring-after($qualifiedType,'::')"/>
                <xsl:with-param name="scopeNode" select="$newScopeNode"/>                
            </xsl:call-template>
        </xsl:if>

        <xsl:if test="not($newScopeNode)">
            <xsl:value-of select="count($scopeNode/definition/type_dcl//enum_type[./identifier=$qualifiedType]//enumerator)"/>
        </xsl:if>                

    </xsl:template>

    <!-- 
        The following template returns 'yes' if the input qualified type can be ignored
    -->
    <xsl:template name="ignoreTypeReference">
        <xsl:param name="qualifiedType"/>

        <xsl:choose>
            <xsl:when test="$ddsIdl = 'no'">
                <xsl:variable name="typeClass">
                    <xsl:call-template name="getTypeClass">
                        <xsl:with-param name="qualifiedType" select="$qualifiedType"/>
                        <xsl:with-param name="resolveTypedef" select="1"/>
                    </xsl:call-template>
                </xsl:variable>
        
                <xsl:choose>
                    <xsl:when test="$typeClass = 'interface'">
                        <xsl:value-of select="'yes'"/>
                    </xsl:when>
                    <xsl:when test="$typeClass = 'value_box'">
                        <xsl:value-of select="'yes'"/>
                    </xsl:when>
                    <xsl:when test="$typeClass = 'value_abs'">
                        <xsl:value-of select="'yes'"/>
                    </xsl:when>
                    <xsl:when test="$typeClass = 'value'">
                        <xsl:choose>
                            <xsl:when test="not(($language = 'C++' or $language = 'JAVA') and $corbaHeader != 'none')">
                                <xsl:value-of select="'no'"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="'yes'"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="'no'"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="'no'"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- The following template returns:
         'value_abs'
         'value_box'
         'value'
         'interface' 
         'other'                         
    -->
    <xsl:template name="getTypeClass">
        <xsl:param name="qualifiedType"/>
        <xsl:param name="scopeNode" select="/specification"/>
        <xsl:param name="resolveTypedef" select="0"/>

        <xsl:variable name="newScopeNodes" select="$scopeNode/definition/module[./identifier/text() = substring-before($qualifiedType,'::')]"/>

        <xsl:variable name="result">
            <xsl:for-each select="$newScopeNodes">
                <xsl:call-template name="getTypeClass">
                    <xsl:with-param name="qualifiedType" select="substring-after($qualifiedType,'::')"/>
                    <xsl:with-param name="scopeNode" select="."/>                
                    <xsl:with-param name="resolveTypedef" select="$resolveTypedef"/>
                </xsl:call-template>
            </xsl:for-each>
        </xsl:variable>


        <xsl:if test="$newScopeNodes">
            <xsl:choose>
                <xsl:when test="contains($result,'value_abs')">
                    <xsl:value-of select="'value_abs'"/>
                </xsl:when>
                <xsl:when test="contains($result,'value_box')">
                    <xsl:value-of select="'value_box'"/>
                </xsl:when>
                <xsl:when test="contains($result,'value')">
                    <xsl:value-of select="'value'"/>
                </xsl:when>
                <xsl:when test="contains($result,'interface')">
                    <xsl:value-of select="'interface'"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="'other'"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>

        <xsl:if test="not($newScopeNodes)">
           <xsl:choose>
                <xsl:when test="$scopeNode/definition/type_dcl[text() = 'typedef']/type_declarator/declarators//identifier[text() = $qualifiedType]">
                    <xsl:if test="$resolveTypedef = 1">                        
                        <xsl:variable name="typeDeclarator" 
                                      select="$scopeNode/definition/type_dcl[text() = 'typedef']/type_declarator[./declarators//identifier/text() = $qualifiedType]"/>

                        <xsl:variable name="resolveName">
                            <xsl:call-template name="resolveName">
                                <xsl:with-param name="node" select="$typeDeclarator"/>
                            </xsl:call-template>
                        </xsl:variable>            

                        <xsl:variable name="newQualifiedType">
                            <xsl:call-template name="obtainStructMemberType">
                                <xsl:with-param name="typeSpecNode" select="$typeDeclarator/type_spec"/>
                                <xsl:with-param name="resolveName" select="$resolveName"/>
                            </xsl:call-template>
                        </xsl:variable>
                        
                        <xsl:call-template name="getTypeClass">
                             <xsl:with-param name="qualifiedType" select="$newQualifiedType"/>
                             <xsl:with-param name="resolveTypedef" select="1"/>
                        </xsl:call-template>

                    </xsl:if>
                    <xsl:if test="$resolveTypedef = 0">
                        <xsl:value-of select="'other'"/>
                    </xsl:if>
                </xsl:when>
                <xsl:when test="$scopeNode/definition/value/value_abs_dcl[./identifier=$qualifiedType]">
                    <xsl:value-of select="'value_abs'"/>                        
                </xsl:when>
                <xsl:when test="$scopeNode/definition/value/value_box_dcl[./identifier=$qualifiedType]">
                    <xsl:value-of select="'value_box'"/>                        
                </xsl:when>
                <xsl:when test="$scopeNode/definition/value/value_dcl/value_header[./identifier=$qualifiedType]">
                    <xsl:value-of select="'value'"/>
                </xsl:when>
                <xsl:when test="$scopeNode/definition/value/value_forward_dcl[./identifier=$qualifiedType]">
                    <xsl:value-of select="'value'"/>
                </xsl:when>
                <xsl:when test="$scopeNode/definition/interf[./identifier=$qualifiedType]">
                    <xsl:value-of select="'interface'"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="'other'"/>
                </xsl:otherwise>
           </xsl:choose>
        </xsl:if>
    </xsl:template>

    <!--  -->
    <xsl:template name="getEquivalentType">        
        <xsl:param name="currentType"/>        
        <xsl:param name="lastNode"/>
        <xsl:param name="scopeNode" select="/specification"/>
        
        <!--<xsl:if test="$optLevel != '0'"> -->
        <xsl:if test="$xml != 'yes'">                

        <xsl:variable name="resolveName">
            <xsl:call-template name="resolveName">
                <xsl:with-param name="node" select="$lastNode"/>
            </xsl:call-template>
        </xsl:variable>            
        
        <xsl:if test="$resolveName='true'">
                                                        
        <xsl:variable name="newScopeNode" select="$scopeNode/definition/module[./identifier/text() = substring-before($currentType,'::')]"/>

        <xsl:if test="contains($currentType,'::')">                
            <xsl:if test="$newScopeNode">
                <xsl:call-template name="getEquivalentType">
                    <xsl:with-param name="currentType" select="substring-after($currentType,'::')"/>                                        
                    <xsl:with-param name="lastNode" select="$lastNode"/>                        
                    <xsl:with-param name="scopeNode" select="$newScopeNode"/>
                </xsl:call-template>
            </xsl:if>
        </xsl:if>
        
        <xsl:if test="not(contains($currentType,'::'))">
        <xsl:choose>
                   
        <xsl:when test="$scopeNode/definition/type_dcl[text() = 'typedef']//declarators/declarator/identifier[text() = $currentType]">
            <xsl:variable name="node" select="$scopeNode/definition/type_dcl[text() = 'typedef' and .//declarators/declarator/identifier[text() = $currentType]]/type_declarator/type_spec"/>                        
            <xsl:variable name="node2" select="$scopeNode/definition/type_dcl[text() = 'typedef' and .//declarators/declarator/identifier[text() = $currentType]]/type_declarator"/>                        

            <xsl:variable name="type">
                <xsl:call-template name="obtainStructMemberType">
                    <xsl:with-param name="typeSpecNode" select="$node"/>
                </xsl:call-template>
            </xsl:variable>
            
            <xsl:variable name="memberKind">
                <xsl:call-template name="obtainMemberKind">
                   <xsl:with-param name="type_declarator" select="$node2"/>
                </xsl:call-template>
            </xsl:variable>
            
            <xsl:variable name="typeKind">
                <xsl:call-template name="obtainTypeKind">
                   <xsl:with-param name="type" select="$type"/>
                </xsl:call-template>
            </xsl:variable>
                                                                     
            <xsl:choose>
                <xsl:when test="$memberKind='scalar' and $typeKind='user'">
                    <xsl:call-template name="getEquivalentType">
                        <xsl:with-param name="currentType" select="$type"/>        
                        <xsl:with-param name="lastNode" select="$node2"/>        
                    </xsl:call-template>                                                        
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="$node2"/>                                                        
                </xsl:otherwise>
            </xsl:choose> 
            
        </xsl:when>
        
        <xsl:otherwise>
            <xsl:if test="name($lastNode) = 'type_declarator'">
                <xsl:apply-templates select="$lastNode"/>            
            </xsl:if>
        </xsl:otherwise>    
    
        </xsl:choose>        
        </xsl:if>        
        
        </xsl:if> <!-- if resolveName -->
        
        <!-- </xsl:if> --> <!-- if optLevel -->
        
        </xsl:if>        
    </xsl:template>        

    <!-- -->
    <xsl:template name="getTypePath">
        <xsl:param name="typeNode"/>

        <xsl:choose>
            <xsl:when test="$typeNode/ancestor::value_dcl">
                <xsl:variable name="moduleNode" select="$typeNode/ancestor::value_dcl"/>

                <xsl:call-template name="getModulePath">
                    <xsl:with-param name="moduleNode" select="$moduleNode"/>
                </xsl:call-template>                            
            </xsl:when>

            <xsl:when test="$typeNode/ancestor::value_abs_dcl">
                <xsl:variable name="moduleNode" select="$typeNode/ancestor::value_abs_dcl"/>

                <xsl:call-template name="getModulePath">
                    <xsl:with-param name="moduleNode" select="$moduleNode"/>
                </xsl:call-template>                            
            </xsl:when>

            <xsl:when test="$typeNode/ancestor::interf">
                <xsl:variable name="moduleNode" select="$typeNode/ancestor::interf"/>

                <xsl:call-template name="getModulePath">
                    <xsl:with-param name="moduleNode" select="$moduleNode"/>
                </xsl:call-template>                            
            </xsl:when>

            <xsl:when test="$typeNode/ancestor::module">
                <xsl:variable name="moduleNode" select="($typeNode/ancestor::module)[last()]"/>

                <xsl:call-template name="getModulePath">
                    <xsl:with-param name="moduleNode" select="$moduleNode"/>
                </xsl:call-template>        
            </xsl:when>

            <xsl:otherwise>
                <xsl:call-template name="getModulePath">
                    <xsl:with-param name="moduleNode" select="/specification"/>
                </xsl:call-template>                            
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <!-- -->
    <xsl:template name="checkDuplicateType">
        <xsl:param name="typeNode"/>

        <xsl:variable name="duplicateString">
            <xsl:variable name="nodes" select="//struct_type[./identifier/text() = $typeNode/identifier/text()] |
                                               //enum_type[./identifier/text() = $typeNode/identifier/text()]   |
                                               //union_type[./identifier/text() = $typeNode/identifier/text()]  |
                                               //const_dcl[./identifier/text() = $typeNode/identifier/text()]   |
                                               //value_dcl[./value_header/identifier/text() = 
                                                           $typeNode/identifier/text()]"/>
            <xsl:if test="count($nodes) > 1">
                <xsl:variable name="typePath">
                    <xsl:call-template name="getTypePath">
                        <xsl:with-param name="typeNode" select="$typeNode"/>
                    </xsl:call-template>
                </xsl:variable>

                <xsl:for-each select="$nodes">
                    <xsl:variable name="currentTypePath">
                        <xsl:call-template name="getTypePath">
                            <xsl:with-param name="typeNode" select="."/>
                        </xsl:call-template>
                    </xsl:variable>

                    <xsl:if test="$currentTypePath = $typePath">
                        <xsl:text>1</xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </xsl:if>
        </xsl:variable>

        <xsl:if test="string-length($duplicateString) &gt; 1">
            <xsl:message  terminate="yes">
Error: Redefinition of <xsl:value-of select="$typeNode/identifier/text()"/>
            </xsl:message>
        </xsl:if>

    </xsl:template>

    <xsl:template name="getExtensibilityKind">
        <xsl:param name="structName"/>
        <xsl:param name="structNode"/>
        <xsl:param name="checkValue" select='false'/>
            <xsl:variable name="extensibilityKind" select="$structNode/../../following-sibling::directive[@kind='Extensibility'][1]"/>

            <xsl:choose>
                <xsl:when test="$structNode/../../following-sibling::directive[@kind='Extensibility' and 
                                ((./preceding-sibling::definition[position()=1]/type_dcl/struct_type/identifier = $structName) or
                                 (./preceding-sibling::definition[position()=1]/type_dcl/union_type/identifier = $structName))]">
                    <xsl:choose>
                        <xsl:when test="$checkValue='true' and 
                                                    (($extensibilityKind != 'FINAL_EXTENSIBILITY') and 
                                                    ($extensibilityKind != 'MUTABLE_EXTENSIBILITY') and  
                                                    ($extensibilityKind != 'EXTENSIBLE_EXTENSIBILITY'))">
                                <xsl:message terminate="yes">
<xsl:text> Error: '</xsl:text> <xsl:value-of select="$extensibilityKind" />
<xsl:text>' was applied to </xsl:text> <xsl:value-of select=" $structName"/><xsl:text> type but it is not a valid value for the 'extensibility' directive.</xsl:text>
                                </xsl:message>
                                <!--<xsl:value-of select="EXTENSIBLE_EXTENSIBILITY"/>-->
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$extensibilityKind" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="'EXTENSIBLE_EXTENSIBILITY'"/>
                </xsl:otherwise>
            </xsl:choose>

    </xsl:template>
        
</xsl:stylesheet>
