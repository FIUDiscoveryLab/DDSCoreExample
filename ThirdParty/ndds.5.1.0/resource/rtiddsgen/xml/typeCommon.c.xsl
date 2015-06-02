<?xml version="1.0"?>
<!-- 
/* $Id: typeCommon.c.xsl,v 1.16 2013/09/12 14:22:27 fernando Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
Modification history:
- - - - - - - - - - -
5.0.1,18jul13,fcs Fixed compilation warnings
5.0.1,12jul13,fcs CODEGEN-574 Fixed finalize_optional_members generation
5.0.1,04jul13,fcs CODEGEN-601: Generate initial_w_params and finalize_w_params
5.0.1,22may13,fcs CODEGEN-594: Added suffix to DLL_EXPORT_MACRO
5.0.1,30apr13,acr CODEGEN-574 Support for optional members in non-mutable types.
                  Fixed code generation for optional strings and string aliases
5.0.1,30apr13,acr CODEGEN-574 Added getTemplateStringOptionalMembers to reuse
                  existing templates in order to generate code for optional members
5.0.1,24apr13,acr CODEGEN-574 Initial support for optional members
5.0.0,25nov12,fcs Fixed CODEGEN-527
5.0.0,13jul12,fcs Added deserialized size methods (cont'd)
5.0.0,13jul12,fcs Added deserialized size methods
5.0.0,10jul12,fcs Mutable union support
10ae,31jan12,vtg RTI-110 Add support to rtiddsgen to produce dll importable code on windows
10af, 01jun11,ai  XTYpes: added support for PID_LIST_END memberId
10af, 02may11,ai XTypes: added support for "mutable" nested types
10af, 04apr11,ai  Xtypes: updated templates to support type extensibility and mutability
10ae,10apr10,fcs Metp validation
10ae,27feb10,fcs Added executionId parameter
10ac,29aug09,fcs Double pointer indirection and dropSample
                 in deserialize function
1.0ac,10aug09,fcs get_serialized_sample_size support
10s,19jul08,fcs Fixed baseEnum comparison in getMemberDescription
10s,18jul08,fcs Support for ignoreAlignment and optimizeAlignment
10s,16jul08,tk  Added utils.xsl
10s,29feb08,fcs Support for get_min_size_serialized
10s,28feb08,rbw Allow stylesheets to detect managed vs. unmanaged generation
10s,18feb08,fcs MD5 KeyHash generation support
10s,15feb08,fcs Skip support
10s,21jan08,jpm Input XML changes
10p,11jul07,eh  Refactor data encapsulation to support previous nddsgen-generated plugins;
                use existing (de)serialize() prototype when add data encapsulation header
10o,03jul07,rbw Refactored unrecognized directive warnings to typeCommon.xsl
10m,23jul06,fcs JDK 1.5 support
10l,19apr06,fcs Fixed error messages format
10l,22mar06,fcs Added database param
10h,15dec05,fcs 4.0g compatibility (Code generated with nddsgen 4.0g can be 
                compiled in 4.1)        
10h,08dec05,fcs Added C++ namespace support        
10h,06dec05,fcs Added language variable
10g,05oct05,eys Added modifyPubData
10f,17aug05,fcs Removed X in Type Plugin calls
10f,21jul05,fcs Added three new process directives:
                copy-declaration, copy-c-declaration, copy-java-declaration
10f,21jul05,fcs Added Process directives code to fix bug 10496
10f,21jul05,fcs Added global parameter typecode
10f,05jun05,fcs Added NULL check for members that are pointers (print and copy functions)
10f,03jun05,fcs Added NULL check for members that are pointers
10f,20may05,fcs Pointers support
10e,29mar05,eys seuqence buffer may not be contigous. See bug 10260
10e,02apr05,fcs The condition "name(.)='typedef' and $optLevel='2'" that is necessary 
                to not generate code is moved to the template isNecessaryGenerateCode.
10e,01apr05,fcs * Change the sampleAccess attribute to (*sample) for typedefs types 
                * Changed isEnum calls for isBaseEnum (that use an attribute 
                  for the types called enum)
                * Removed  <xsl:variable name="enumType"> declaration from
                  obtainMemberParameters template
                * Moved isEnum template to typeCommon.xsl
10e,29mar05,rw  Bug #10270: use copy method from type itself, not type plug-in
10e,25mar05,rw  Bug #10270: use initialize/finalize methods from type itself,
                not type plug-in
10d,16mar05,fcs Modified for being compatible with the new simplified XML document.
10d,15nov04,eys Type plugin refactoring
10d,27jul04,rw  Moved default processing rules to typeCommon.xsl
10d,23jul04,rw  Updated method names to match DDS conventions
10d,29jun04,eys Fixed output indentation.
10c,26may04,rrl Fixed #8866 by calling assert on each member type
                and replaced tabs by 4 spaces to make output prettier
10c,24may04,rrl Moved out error checking to typeCommon.xsl
10c,18may04,rrl First steps to refactor common code between typeCommon.c.xsl
                and typeCommon.java.xsl
10c,11may04,rrl Fixed union's computation for maxSizeSerialized.
10c,05may04,eys Added getSharedInstance() and copy() method.
40b,11feb04,rrl Support @copy directive
40b,03feb04,rrl Support typedef
40b,26jan04,rrl Modified union declaration to use _u nested element 
                following the IDL spec. Separate out generation for
                union and struct members; it was getting difficult to
                understand.
40b,14jan04,rrl Support unions
40a,20oct03,eys Refactored sequence.
40a,24sep03,eys Added initArrayMethod into typeInfoMap
40a,07sep03,rrl Support finalizeInstance() method.
40a,04sep03,rrl Added error-handling for checking unbounded string and 
                unbounded sequence members.
40a,04sep03,rrl Added missing variables for string and sequences
40a,04sep03,rrl Support bounded strings
40a,28aug03,rrl Refactored out of typePlugin.c.xsl
-->
<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
<!ENTITY namespaceSeperator "_">    <!-- namespace separator -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:xalan = "http://xml.apache.org/xalan">

<xsl:variable name="idlFileBaseName" select="/specification/@idlFileName"/>
<xsl:variable name="generationInfo" select="document('generation-info.c.xml')/generationInfo"/>
<xsl:variable name="typeInfoMap" select="$generationInfo/typeInfoMap"/>
<xsl:variable name="methodInfoMap" select="$generationInfo/methodInfoMap"/>

<xsl:param name="archName"/>
<xsl:param name="languageOption"/>
<xsl:param name="optLevel"/>
<xsl:param name="typecode"/>
<xsl:param name="modifyPubData"/>
<xsl:param name="namespace"/>
<xsl:param name="database"/>
<xsl:param name="ignoreAlignment"/>
<xsl:param name="optimizeAlignment"/>
<xsl:param name="executionId"/>
<xsl:param name="dllImportableCode"/>
<xsl:param name="dllExportMacroSuffix"/>
<xsl:param name="metp"/>
<!-- This parameter indicates whether or not we have to generate code for 
     get_deserialized_sample_size,
     assign_pointers_to_contiguous_buffer,
     deserialize_to_contiguous_buffer  -->
<xsl:param name="desSampleCode"/>
<xsl:param name="useUnion"/>

<xsl:variable name="dllExportMacroFinalSuffix">
    <xsl:choose>
        <xsl:when test="$dllImportableCode='yes'">
            <xsl:value-of select="concat('_',$idlFileBaseName)"/>
        </xsl:when>
        <xsl:when test="$dllExportMacroSuffix != ''">
            <xsl:value-of select="concat('_',$dllExportMacroSuffix)"/>
        </xsl:when>
        <xsl:otherwise/>
    </xsl:choose>
</xsl:variable>
        
<xsl:variable name="language">        
    <xsl:choose>
        <xsl:when test="$languageOption = 'C' or $languageOption = 'c'">                
            <xsl:text>C</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>C++</xsl:text>                
        </xsl:otherwise>
    </xsl:choose>                        
</xsl:variable>                
<xsl:variable name="isManaged" select="$languageOption = 'C++/CLI'"/>   

        
<xsl:include href="utils.xsl"/>
<xsl:include href="typeCommon.xsl"/>

<!-- Module declarations.
     The purpose of processing module is to build up the string that represents
     the current namespace, that contains concatenated module names separated
     by "_"s. We pass on the namespace accumulated so far to the next nested elements
     though use of xsl:with-param.
-->
<xsl:template match="module">
    <xsl:param name="containerNamespace"/>

    <xsl:if test="$language = 'C++' and $namespace='yes'">
        <xsl:text>&nl;</xsl:text>
        <xsl:text>namespace </xsl:text>                        
        <xsl:value-of select="@name"/>
        <xsl:text>{&nl;</xsl:text>
    </xsl:if>
        
    <xsl:variable name="newNamespace">
        <xsl:if test="$language='C' or $namespace='no'">
            <xsl:value-of select="concat($containerNamespace, @name, '&namespaceSeperator;')"/>                    
        </xsl:if>
    </xsl:variable>
                       
    <xsl:apply-templates>
        <xsl:with-param name="containerNamespace" select="$newNamespace"/>
    </xsl:apply-templates>
                
    <xsl:if test="$language = 'C++' and $namespace='yes'">
        <xsl:text>&nl;</xsl:text>                
        <xsl:text>} /* namespace </xsl:text><xsl:value-of select="@name"/><xsl:text> */&nl;</xsl:text>
    </xsl:if>        
</xsl:template>
        
<!-- -->
<xsl:template name="getTemplateString">
    <xsl:param name="generationMode"/>
    <xsl:param name="memberKind"/>
    <xsl:param name="bitKind"/>        
    <xsl:param name="typeKind"/>
    <xsl:param name="type"/>
    <xsl:param name="pointer"/>
    <xsl:param name="alignFast"/>

    <xsl:variable name="matchedMethodNode" 
                  select="$methodInfoMap/method[@kind = $generationMode]"/>
                  
    <xsl:choose>
        <!-- Pointers -->
        <xsl:when test="$matchedMethodNode/template[@pointer=$pointer and @kind = $memberKind and @typeKind = $typeKind and @type = $type]">
            <xsl:value-of select="$matchedMethodNode/template[@pointer='yes' and @kind = $memberKind and @typeKind = $typeKind and @type= $type]"/>            
        </xsl:when>        
        <xsl:when test="$matchedMethodNode/template[@pointer=$pointer and @kind = $memberKind and (@typeKind = $typeKind or @bitKind= $bitKind) and not(@type )]">
            <xsl:value-of select="$matchedMethodNode/template[@pointer='yes' and @kind = $memberKind and (@typeKind = $typeKind or @bitKind= $bitKind) and not(@type )]"/>            
        </xsl:when>                
        <xsl:when test="$matchedMethodNode/template[@pointer=$pointer and @kind = $memberKind and (not(@typeKind) and not(@bitKind)) and not(@type)]">
            <xsl:value-of select="$matchedMethodNode/template[@pointer='yes' and @kind = $memberKind and (not(@typeKind) and not(@bitKind)) and not(@type)]"/>                            
        </xsl:when>
        <!-- Non-pointer types -->
        <xsl:when test="$matchedMethodNode/template[@kind = $memberKind and @typeKind = $typeKind and @type = $type]">
            <xsl:value-of select="$matchedMethodNode/template[@kind = $memberKind and @typeKind = $typeKind and @type= $type]"/>            
        </xsl:when>        
        <xsl:when test="$matchedMethodNode/template[@kind = $memberKind and @typeKind = $typeKind and @fastSerialization]">
            <xsl:value-of select="$matchedMethodNode/template[@kind = $memberKind and @typeKind = $typeKind and @fastSerialization= $alignFast]"/>
        </xsl:when>        
        <xsl:when test="$matchedMethodNode/template[@kind = $memberKind and (@typeKind = $typeKind or @bitKind= $bitKind) and not(@type)]">
            <xsl:value-of select="$matchedMethodNode/template[@kind = $memberKind and (@typeKind = $typeKind or @bitKind= $bitKind) and not(@type)]"/>            
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$matchedMethodNode/template[@kind = $memberKind and (not(@typeKind) and not(@bitKind)) and not(@type)]"/>                            
        </xsl:otherwise>   
    </xsl:choose>
</xsl:template>


<!--
 Generates the code to process an optional member in a given method identified 
 by 'generationMode'.
 
 It reuses existing templates (possibly more than one for some generationModes)
 for non-optional members and it insert small extra pieces of code that are not 
 in any template from generation-info.c.xml.
 -->
<xsl:template name="getTemplateStringOptionalMember">
    <xsl:param name="origGenerationMode"/>
    <xsl:param name="generationMode"/>
    <xsl:param name="memberKind"/>
    <xsl:param name="bitKind"/>        
    <xsl:param name="typeKind"/>
    <xsl:param name="type"/>
    <xsl:param name="pointer"/>
    <xsl:param name="alignFast"/>

    <xsl:variable name="isString">
        <xsl:choose>
            <xsl:when test="$pointer!='yes' and ($memberKind = 'string' 
                                                 or $memberKind = 'wstring')">
                <xsl:text>yes</xsl:text>
            </xsl:when>
            <xsl:otherwise><xsl:text>no</xsl:text></xsl:otherwise>
        </xsl:choose>    
    </xsl:variable>     
                
    <xsl:variable name="actualPointer">
        <xsl:choose>
            <xsl:when test="$isString='yes'">
                <xsl:value-of select="$pointer"/>
            </xsl:when>
            <xsl:otherwise><xsl:text>yes</xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
                
    <!-- Add code to handle memory allocation for optional member (if the 
         method kind calls for it) -->
    <xsl:choose>
        <xsl:when test="$generationMode = 'finalize'">
            <xsl:if test="$origGenerationMode != 'finalize_optional'">
                <xsl:text>    if (deallocParams->delete_optional_members) {&nl;</xsl:text>
            </xsl:if>
            <!-- Get finalize template for a pointer type -->
            <xsl:call-template name="getTemplateString">
                <xsl:with-param name="generationMode" select="$generationMode"/>
                <xsl:with-param name="memberKind" select="$memberKind"/>
                <xsl:with-param name="bitKind" select="$bitKind"/>                    
                <xsl:with-param name="typeKind" select="$typeKind"/>                    
                <xsl:with-param name="type" select="$type"/>
                <xsl:with-param name="pointer" select="$actualPointer"/>
                <xsl:with-param name="alignFast" select="$alignFast"/>
            </xsl:call-template>
            <xsl:if test="$origGenerationMode != 'finalize_optional'">
                <xsl:text>    }&nl;</xsl:text>
            </xsl:if>
        </xsl:when>
        <xsl:when test="$generationMode = 'deserialize'">
            <!-- Call allocate and then deserialize -->
            <xsl:call-template name="getTemplateString">
                <xsl:with-param name="generationMode" select="'allocate'"/>
                <xsl:with-param name="memberKind" select="$memberKind"/>
                <xsl:with-param name="bitKind" select="$bitKind"/>                    
                <xsl:with-param name="typeKind" select="$typeKind"/>                    
                <xsl:with-param name="type" select="$type"/>
                <xsl:with-param name="pointer" select="$pointer"/>
                <xsl:with-param name="alignFast" select="$alignFast"/>
            </xsl:call-template>
            <xsl:call-template name="getTemplateString">
                <xsl:with-param name="generationMode" select="$generationMode"/>
                <xsl:with-param name="memberKind" select="$memberKind"/>
                <xsl:with-param name="bitKind" select="$bitKind"/>                    
                <xsl:with-param name="typeKind" select="$typeKind"/>                    
                <xsl:with-param name="type" select="$type"/>
                <xsl:with-param name="pointer" select="$pointer"/>
                <xsl:with-param name="alignFast" select="$alignFast"/>
            </xsl:call-template>            
        </xsl:when>
        <xsl:when test="$generationMode = 'copy'">
            <!-- Call allocate and copy if the source is non-null or
                 finalize otherwise -->
            <xsl:choose>
                <xsl:when test="$isString='yes'">
                <xsl:text>    if (%%srcAccess%%%%name%%!=NULL) {&nl;</xsl:text>
                <xsl:text>      if (%%dstAccess%%%%name%%==NULL) {</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                <xsl:text>    if (%%srcAccessPointer%%%%name%%!=NULL) {&nl;</xsl:text>
                <xsl:text>      if (%%dstAccessPointer%%%%name%%==NULL) {</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            
            <xsl:call-template name="getTemplateString">
                <xsl:with-param name="generationMode" select="'allocate'"/>
                <xsl:with-param name="memberKind" select="$memberKind"/>
                <xsl:with-param name="bitKind" select="$bitKind"/>                    
                <xsl:with-param name="typeKind" select="$typeKind"/>                    
                <xsl:with-param name="type" select="$type"/>
                <xsl:with-param name="pointer" select="$pointer"/>
                <xsl:with-param name="alignFast" select="$alignFast"/>
            </xsl:call-template>
            <xsl:text>&nl;      }</xsl:text>
            <xsl:call-template name="getTemplateString">
                <xsl:with-param name="generationMode" select="$generationMode"/>
                <xsl:with-param name="memberKind" select="$memberKind"/>
                <xsl:with-param name="bitKind" select="$bitKind"/>                    
                <xsl:with-param name="typeKind" select="$typeKind"/>                    
                <xsl:with-param name="type" select="$type"/>
                <xsl:with-param name="pointer" select="$actualPointer"/>
                <xsl:with-param name="alignFast" select="$alignFast"/>
            </xsl:call-template>
            <xsl:text>&nl;    } else {</xsl:text>
            <xsl:call-template name="getTemplateString">
                <xsl:with-param name="generationMode" select="'finalize'"/>
                <xsl:with-param name="memberKind" select="$memberKind"/>
                <xsl:with-param name="bitKind" select="$bitKind"/>                    
                <xsl:with-param name="typeKind" select="$typeKind"/>                    
                <xsl:with-param name="type" select="$type"/>
                <xsl:with-param name="pointer" select="$actualPointer"/>
                <xsl:with-param name="alignFast" select="$alignFast"/>
            </xsl:call-template>
            <xsl:text>&nl;    }&nl;</xsl:text>
        </xsl:when>
        <xsl:when test="$generationMode = 'initialize' and $isString='yes'">
            <!-- Simply assign NULL. We don't use any template -->
            <xsl:text>    if (!allocParams-&gt;allocate_optional_members) {&nl;</xsl:text>
            <xsl:text>        %%sampleAccess%%%%name%%=NULL;&nl;</xsl:text>
            <xsl:text>    } else {&nl;</xsl:text>
                <xsl:call-template name="getTemplateString">
                    <xsl:with-param name="generationMode" select="$generationMode"/>
                    <xsl:with-param name="memberKind" select="$memberKind"/>
                    <xsl:with-param name="bitKind" select="$bitKind"/>                    
                    <xsl:with-param name="typeKind" select="$typeKind"/>                    
                    <xsl:with-param name="type" select="$type"/>
                    <xsl:with-param name="pointer" select="$actualPointer"/>
                    <xsl:with-param name="alignFast" select="$alignFast"/>
                </xsl:call-template>        
            <xsl:text>&nl;    }&nl;</xsl:text>
        </xsl:when>
        <xsl:when test="$generationMode = 'initialize'">
            <xsl:text>    if (!allocParams-&gt;allocate_optional_members) {&nl;</xsl:text>
            <!-- Simply assign NULL. We don't use any template -->
            <xsl:text>        %%sampleAccessPointer%%%%name%%=NULL;&nl;</xsl:text>
            <xsl:text>    } else {&nl;</xsl:text>
                <xsl:call-template name="getTemplateString">
                    <xsl:with-param name="generationMode" select="$generationMode"/>
                    <xsl:with-param name="memberKind" select="$memberKind"/>
                    <xsl:with-param name="bitKind" select="$bitKind"/>                    
                    <xsl:with-param name="typeKind" select="$typeKind"/>                    
                    <xsl:with-param name="type" select="$type"/>
                    <xsl:with-param name="pointer" select="$actualPointer"/>
                    <xsl:with-param name="alignFast" select="$alignFast"/>
                </xsl:call-template>        
            <xsl:text>&nl;    }&nl;</xsl:text>
        </xsl:when>        
        <xsl:otherwise>
            <!-- The rest of methods don't need a special treatment: call 
                 template as-is -->
            <xsl:call-template name="getTemplateString">
                <xsl:with-param name="generationMode" select="$generationMode"/>
                <xsl:with-param name="memberKind" select="$memberKind"/>
                <xsl:with-param name="bitKind" select="$bitKind"/>                    
                <xsl:with-param name="typeKind" select="$typeKind"/>                    
                <xsl:with-param name="type" select="$type"/>
                <xsl:with-param name="pointer" select="$pointer"/>
                <xsl:with-param name="alignFast" select="$alignFast"/>
            </xsl:call-template>        
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>


<xsl:template name="selectTemplate">
    <xsl:param name="generationMode" />
    <xsl:param name="memberKind" />
    <xsl:param name="bitKind" />
    <xsl:param name="typeKind" />
    <xsl:param name="type" />
    <xsl:param name="pointer" />
    <xsl:param name="alignFast" />
    <xsl:param name="isOptional" />

    <xsl:variable name="actualGenerationMode">
        <xsl:choose>
            <xsl:when test="$generationMode = 'finalize_optional' and $isOptional='yes'">
                <xsl:text>finalize</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$generationMode"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:choose>
        <xsl:when test="$isOptional = 'yes'">
            <xsl:call-template name="getTemplateStringOptionalMember">
                <xsl:with-param name="origGenerationMode" select="$generationMode" />            
                <xsl:with-param name="generationMode" select="$actualGenerationMode" />
                <xsl:with-param name="memberKind" select="$memberKind" />
                <xsl:with-param name="bitKind" select="$bitKind" />
                <xsl:with-param name="typeKind" select="$typeKind" />
                <xsl:with-param name="type" select="$type" />
                <xsl:with-param name="pointer" select="$pointer" />
                <xsl:with-param name="alignFast" select="$alignFast" />
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:call-template name="getTemplateString">
                <xsl:with-param name="generationMode" select="$actualGenerationMode" />
                <xsl:with-param name="memberKind" select="$memberKind" />
                <xsl:with-param name="bitKind" select="$bitKind" />
                <xsl:with-param name="typeKind" select="$typeKind" />
                <xsl:with-param name="type" select="$type" />
                <xsl:with-param name="pointer" select="$pointer" />
                <xsl:with-param name="alignFast" select="$alignFast" />
            </xsl:call-template>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>


<!-- 
Note: This template returns true if it's necessary to generate plugin code for the given type
-->
<xsl:template name="isNecessaryGenerateCode">
    <xsl:param name="typedefNode"/>

    <xsl:variable name="baseType">
        <xsl:call-template name="getBaseType">
            <xsl:with-param name="member" select="$typedefNode/member"/>        
        </xsl:call-template>        
    </xsl:variable>
                
    <xsl:variable name="baseTypeKind">
        <xsl:call-template name="obtainBaseTypeKind">
            <xsl:with-param name="member" select="$typedefNode/member"/>
        </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="baseMemberKind">
        <xsl:call-template name="obtainBaseMemberKind">
            <xsl:with-param name="member" select="$typedefNode/member"/>
        </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="baseEnum">    
        <xsl:call-template name="isBaseEnum">
            <xsl:with-param name="member" select="$typedefNode/member"/>
        </xsl:call-template>        
    </xsl:variable>
    
    <xsl:choose>
        <xsl:when test="($baseType='string' or $baseType='wstring' or $baseTypeKind='builtin' or $baseEnum='yes') 
                        and ($baseMemberKind != 'sequence' and $baseMemberKind != 'array' and 
                        $baseMemberKind != 'arraySequence') and $optLevel = '2' 
                        and name($typedefNode)='typedef'">no</xsl:when>                                       
        <xsl:otherwise>yes</xsl:otherwise>                        
    </xsl:choose>
                
</xsl:template>

<!-- -->
<xsl:template name="getTypeAlignment">
    <xsl:param name="type"/>        
    <xsl:choose>
        <xsl:when test="$type = 'longdouble' or 
                        $type = 'unsignedlonglong' or
                        $type = 'longlong' or
                        $type = 'double'">
            <xsl:text>8</xsl:text>
        </xsl:when>
        <xsl:when test="$type = 'long' or 
                        $type = 'unsignedlong' or
                        $type = 'wchar' or
                        $type = 'float'">
            <xsl:text>4</xsl:text>
        </xsl:when>
        <xsl:when test="$type = 'short' or 
                        $type = 'unsignedshort'">
            <xsl:text>2</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>1</xsl:text>
        </xsl:otherwise>
    </xsl:choose>                                            
</xsl:template>

<!-- 
Note: 
If we change this function it's necessary to review the criterion to declare variables at the beginning
of each Plugin function        
It's necessary also to change the code of the template isNecessarygenerateCode
-->
<xsl:template name="getMemberDescription">
    <xsl:param name="member"/>

    <xsl:variable name="baseType">
        <xsl:call-template name="getBaseType">
            <xsl:with-param name="member" select="$member"/>        
        </xsl:call-template>        
    </xsl:variable>
                
    <xsl:variable name="baseTypeKind">
        <xsl:call-template name="obtainBaseTypeKind">
            <xsl:with-param name="member" select="$member"/>
        </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="baseMemberKind">
        <xsl:call-template name="obtainBaseMemberKind">
            <xsl:with-param name="member" select="$member"/>
        </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="baseBitKind">
        <xsl:call-template name="obtainBaseBitKind">
            <xsl:with-param name="member" select="$member"/>
        </xsl:call-template>
    </xsl:variable>    
        
    <xsl:variable name="memberKind">
        <xsl:call-template name="obtainMemberKind">
            <xsl:with-param name="member" select="$member"/>
        </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="typeKind">
        <xsl:call-template name="obtainTypeKind">
            <xsl:with-param name="member" select="$member"/>
        </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="bitKind">
        <xsl:call-template name="obtainBaseBitKind">
            <xsl:with-param name="member" select="$member"/>
        </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="childMemberKind">
        <xsl:if test="$member/member">
            <xsl:call-template name="obtainMemberKind">
                <xsl:with-param name="member" select="$member/member"/>
            </xsl:call-template>                
        </xsl:if>
        <xsl:if test="not($member/member)">
            <xsl:call-template name="obtainMemberKind">
                <xsl:with-param name="member" select="$member"/>
            </xsl:call-template>                
        </xsl:if>        
    </xsl:variable>
    
    <xsl:variable name="baseEnum">    
        <xsl:call-template name="isBaseEnum">
            <xsl:with-param name="member" select="$member"/>
        </xsl:call-template>        
    </xsl:variable>
    
    <xsl:variable name="basePointer">
        <xsl:choose>
            <xsl:when test="$member/member/@pointer = 'yes'">
                <xsl:value-of select="'yes'"/>                            
            </xsl:when>
            <xsl:when test="$member/@pointer = 'yes'">
                <xsl:value-of select="'yes'"/>                            
            </xsl:when>            
            <xsl:otherwise>
                <xsl:value-of select="'no'"/>                            
            </xsl:otherwise>
        </xsl:choose>                                
    </xsl:variable>
    
    <xsl:variable name="pointer">
        <xsl:choose>
            <xsl:when test="$member/@pointer = 'yes'">
                <xsl:value-of select="'yes'"/>                            
            </xsl:when>            
            <xsl:otherwise>
                <xsl:value-of select="'no'"/>                            
            </xsl:otherwise>
        </xsl:choose>                                
    </xsl:variable>
    
    <xsl:variable name="optional">
        <xsl:choose>
            <xsl:when test="$member/@optional='true'">
                <xsl:text>yes</xsl:text>                 
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>no</xsl:text>                            
            </xsl:otherwise>
        </xsl:choose>                                
    </xsl:variable>

    <xsl:variable name="alignFast">
        <xsl:if test="$ignoreAlignment = 'yes'">
            <xsl:text>yes</xsl:text>
        </xsl:if>

        <xsl:if test="$ignoreAlignment = 'no'">
            <xsl:choose>
                <xsl:when test="$optimizeAlignment = 'yes' and 
                                ($member/preceding-sibling::member or $member/preceding-sibling::discriminator)">
                    <xsl:variable name="baseTypeAlignment">
                        <xsl:choose>
                            <xsl:when test="$baseEnum='yes'">4</xsl:when>
                            <xsl:otherwise>
                                <xsl:variable name="basicAlign">
                                    <xsl:call-template name="getTypeAlignment">
                                        <xsl:with-param name="type" select="$baseType"/>
                                    </xsl:call-template>
                                </xsl:variable>

                                <xsl:choose>
                                    <xsl:when test="($baseMemberKind = 'sequence' or $baseMemberKind = 'arraySequence') and
                                                     $basicAlign &lt; 4">
                                        <xsl:text>4</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="$basicAlign"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
    
                    <xsl:choose>
                        <xsl:when test="$baseTypeKind = 'builtin' or $baseEnum = 'yes'">
                            <!-- Previous sibling data -->
                            <xsl:variable name="siblingBaseTypeKind">
                                <xsl:choose>
                                    <xsl:when test="$member/preceding-sibling::discriminator">
                                        <xsl:call-template name="obtainBaseTypeKind">
                                            <xsl:with-param name="member" select="$member/preceding-sibling::discriminator"/>
                                        </xsl:call-template>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:call-template name="obtainBaseTypeKind">
                                            <xsl:with-param name="member" select="$member/preceding-sibling::member[position()=1]"/>
                                        </xsl:call-template>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>
    
                            <xsl:variable name="siblingBaseMemberKind">
                                <xsl:choose>
                                    <xsl:when test="$member/preceding-sibling::discriminator">
                                        <xsl:call-template name="obtainBaseMemberKind">
                                            <xsl:with-param name="member" select="$member/preceding-sibling::discriminator"/>
                                        </xsl:call-template>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:call-template name="obtainBaseMemberKind">
                                            <xsl:with-param name="member" select="$member/preceding-sibling::member[position()=1]"/>
                                        </xsl:call-template>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>
    
                            <xsl:variable name="siblingBaseEnum">
                                <xsl:choose>
                                    <xsl:when test="$member/preceding-sibling::discriminator">
                                        <xsl:call-template name="isBaseEnum">
                                            <xsl:with-param name="member" select="$member/preceding-sibling::discriminator"/>
                                        </xsl:call-template>        
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:call-template name="isBaseEnum">
                                            <xsl:with-param name="member" select="$member/preceding-sibling::member[position()=1]"/>
                                        </xsl:call-template>        
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>
    
                            <xsl:variable name="siblingBaseType">
                                <xsl:choose>
                                    <xsl:when test="$member/preceding-sibling::discriminator">
                                        <xsl:call-template name="getBaseType">
                                            <xsl:with-param name="member" select="$member/preceding-sibling::discriminator"/>
                                        </xsl:call-template>        
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:call-template name="getBaseType">
                                            <xsl:with-param name="member" select="$member/preceding-sibling::member[position()=1]"/>        
                                        </xsl:call-template>        
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>
    
                            <xsl:variable name="siblingBaseTypeAlignment">
                                <xsl:if test="$siblingBaseEnum='yes'">4</xsl:if>
                                <xsl:if test="$siblingBaseEnum!='yes'">
                                    <xsl:call-template name="getTypeAlignment">
                                        <xsl:with-param name="type" select="$siblingBaseType"/>
                                    </xsl:call-template>
                                </xsl:if>
                            </xsl:variable>

                            <xsl:choose>
                                <xsl:when test="$siblingBaseTypeKind = 'builtin' and 
                                                ($siblingBaseMemberKind = 'sequence' or $siblingBaseMemberKind = 'arraySequence')">
                                    <xsl:choose>
                                        <xsl:when test="$baseTypeAlignment &lt;= 4 and $baseTypeAlignment &lt;= $siblingBaseTypeAlignment">
                                            <!-- we compare with 4 because of the sequence length -->
                                            <xsl:text>yes</xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>no</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>                                   
                                <xsl:when test="$siblingBaseTypeKind = 'builtin'">
                                    <!-- array or primitive -->
                                    <xsl:choose>
                                        <xsl:when test="$baseTypeAlignment &lt;= $siblingBaseTypeAlignment">
                                            <xsl:text>yes</xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>no</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:when test="$siblingBaseEnum = 'yes'">
                                    <xsl:choose>
                                        <xsl:when test="$baseTypeAlignment &lt;= 4">
                                            <xsl:text>yes</xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>no</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:otherwise>no</xsl:otherwise>    
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>no</xsl:otherwise>
                    </xsl:choose>
                </xsl:when> <!-- $optimizeAlignment = 'yes' -->
                <xsl:otherwise>
                    <xsl:text>no</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if> <!-- $ignoreAlignment = 'no' -->
    </xsl:variable>
        
    <xsl:choose>
        <xsl:when test="(($baseType='string' or $baseType='wstring' or $baseTypeKind='builtin' or $baseEnum='yes') 
                        and ($childMemberKind != 'sequence' and $childMemberKind != 'array' and $childMemberKind != 'arraySequence' and $pointer='no')
                        and $optLevel != '0') or ($optional='yes' and ($baseMemberKind = 'string' or $baseMemberKind='wstring'))">                
            <description>
                <xsl:attribute name="type"><xsl:value-of select="$baseType"/></xsl:attribute>
                <xsl:attribute name="memberKind"><xsl:value-of select="$baseMemberKind"/></xsl:attribute>                    
                <xsl:attribute name="typeKind"><xsl:value-of select="$baseTypeKind"/></xsl:attribute>                                        
                <xsl:attribute name="bitKind"><xsl:value-of select="$baseBitKind"/></xsl:attribute>                                                            
                <xsl:attribute name="pointer"><xsl:value-of select="$basePointer"/></xsl:attribute>
                <xsl:attribute name="optional"><xsl:value-of select="$optional"/></xsl:attribute>                                                            
                <xsl:choose>
                    <xsl:when test="$member/@bitField">
                        <xsl:attribute name="bitField"><xsl:value-of select="$member/@bitField"/></xsl:attribute>                                                                                                                                   
                    </xsl:when>
                    <xsl:when test="$member/member/@bitField">
                        <xsl:attribute name="bitField"><xsl:value-of select="$member/member/@bitField"/></xsl:attribute>                                                                                                                                   
                    </xsl:when>                        
                    <xsl:otherwise>
                        <xsl:attribute name="bitField"><xsl:value-of select="''"/></xsl:attribute>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:attribute name="alignFast"><xsl:value-of select="$alignFast"/></xsl:attribute>
            </description>
        </xsl:when>
        <xsl:otherwise>                
            <description>
                <xsl:attribute name="type"><xsl:value-of select="$member/@type"/></xsl:attribute>
                <xsl:attribute name="memberKind"><xsl:value-of select="$memberKind"/></xsl:attribute>
                <xsl:attribute name="typeKind"><xsl:value-of select="$typeKind"/></xsl:attribute>                                        
                <xsl:attribute name="bitKind"><xsl:value-of select="$bitKind"/></xsl:attribute>                        
                <xsl:attribute name="bitField"><xsl:value-of select="''"/></xsl:attribute>                    
                <xsl:attribute name="pointer"><xsl:value-of select="$pointer"/></xsl:attribute>
                <xsl:attribute name="optional"><xsl:value-of select="$optional"/></xsl:attribute>                                                                      
                <xsl:if test="$member/@bitField">
                    <xsl:attribute name="bitField"><xsl:value-of select="$member/@bitField"/></xsl:attribute>                                                                                                   
                </xsl:if>
                <xsl:attribute name="alignFast"><xsl:value-of select="$alignFast"/></xsl:attribute>
            </description>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>    

                
<!-- 
A common template shared code generator template for struct member
This tempalte expect a template string passed in parameter 
"templateSting". Each paramter is tempalte must be bracketed using
%% as the bracket string. A typical way to invoke this tempalte is
as follows:
<xsl:template match="member[<any-other-selector>]> ...>
    <xsl:apply-templates select="." mode="replace-params">
         <xsl:with-param name="templateString">%%name%% ...</xsl:with-param>
    </xsl:apply-templates>
</xsl:template>
-->
<xsl:template name="replace-params">
    <xsl:param name="generationMode"/>
    <xsl:param name="member"/>
    <xsl:param name="templateString"/>
    <xsl:param name="type"/>
    <xsl:param name="typeKind"/>                
    <xsl:param name="memberKind"/>                                
    <xsl:param name="bitField"/>
    <xsl:param name="pointer"/>
    <xsl:param name="optional"/>
    <xsl:param name="discContainer"/>
    <xsl:param name="xType"/>
    <xsl:param name="structKind"/>
                          
    <!-- Get the replacement map. The called template retruns a node with 
         attributes set to the template parameters and values set to the
         replacement values.
    -->
    <xsl:variable name="memberReplacementParams">
        <xsl:call-template name="obtainMemberParameters">
            <xsl:with-param name="structMember" select="$member"/>
            <xsl:with-param name="generationMode" select="$generationMode"/>
            <xsl:with-param name="type" select="$type"/>
            <xsl:with-param name="typeKind" select="$typeKind"/>                
            <xsl:with-param name="memberKind" select="$memberKind"/>                                
            <xsl:with-param name="bitField" select="$bitField"/>                        
            <xsl:with-param name="pointer" select="$pointer"/>
            <xsl:with-param name="optional" select="$optional"/>                        
            <xsl:with-param name="discContainer" select="$discContainer"/>
            <xsl:with-param name="xType" select="$xType"/>
            <xsl:with-param name="structKind" select="$structKind"/>
        </xsl:call-template>
    </xsl:variable>

    <!-- Replace all occurances of template parameter with their value from
         the map just obtained -->
    <xsl:call-template name="replace-string-from-map">
            <xsl:with-param name="inputString" select="$templateString"/>
            <xsl:with-param name="replacementParamsMap" select="xalan:nodeset($memberReplacementParams)/node()"/>
    </xsl:call-template>
</xsl:template>

<xsl:template match="getMemberPosition">
        <xsl:variable name="memberPosition" select="position()" />
</xsl:template>

<!-- Template to generate code for a given member.

     This is the template that should be called from the main
     stylesheet with correct parameter to generate code for
     each member.
     
     @param generationMode mode that should match one of those
                           in generation-info.xml (//methodInfoMap/method[@kind])
-->     
<xsl:template match="struct[not(@kind = 'union')]/member" mode="code-generation">
     <xsl:param name="generationMode"/>
     <xsl:param name="discContainer"/>
     <xsl:call-template name="generateMemberCode">
         <xsl:with-param name="generationMode" select="$generationMode"/>
         <xsl:with-param name="member" select="."/>
     </xsl:call-template>
</xsl:template>

<!-- -->
<xsl:template match="enum/enumerator" mode="code-generation">
    <xsl:param name="generationMode"/>
    <xsl:param name="xType"/>
    <xsl:param name="isBitSet"/>
    <xsl:if test="$generationMode='deserialize' and $isBitSet='no' and ($xType='MUTABLE_EXTENSIBILITY' or $xType='EXTENSIBLE_EXTENSIBILITY')">
        <xsl:call-template name="generateEnumeratorCode">
        </xsl:call-template>
    </xsl:if>
</xsl:template>

<xsl:template name="generateEnumeratorCode"> 
    <xsl:text>
            case </xsl:text><xsl:value-of select="./@name"/><xsl:text>:</xsl:text>
            <xsl:text>
                *sample=</xsl:text><xsl:value-of select="./@name"/><xsl:text>;
                break;</xsl:text>
</xsl:template>

<!-- -->
<xsl:template match="typedef/member" mode="code-generation">
    <xsl:param name="generationMode"/>
    <xsl:param name="discContainer"/>
                    
    <xsl:call-template name="generateMemberCode">
        <xsl:with-param name="generationMode" select="$generationMode"/>
        <xsl:with-param name="member" select="."/>
    </xsl:call-template>    
</xsl:template>

<!-- -->
<xsl:template match="struct[@kind = 'union']/member" mode="code-generation">    
    <xsl:param name="generationMode"/>
    <xsl:param name="unionVariableName" select="'sample'"/>
    <xsl:param name="discContainer"/>
    
    <xsl:variable name="xType">
        <xsl:call-template name="getExtensibilityKind">
            <xsl:with-param name="structName" select="../@name"/>
            <xsl:with-param name="node" select=".."/>
        </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="needSwitch"
        select="not($generationMode = 'structMember' or 
                    $generationMode = 'get_max_size_serialized' or $generationMode = 'get_min_size_serialized' or
                    $generationMode = 'get_min_size_deserialized' or
                    $generationMode = 'initialize_des_buffer' or
                    $generationMode = 'new' or 
                    $generationMode ='initialize' or ($generationMode='finalize' and $useUnion='no') or
                    ($xType='MUTABLE_EXTENSIBILITY' and 
                        ($generationMode='deserialize' or $generationMode='skip' or 
                        $generationMode='skip_and_get_deserialized_length' or
                        $generationMode='union_skip_and_get_deserialized_length' or
                        $generationMode ='initialize_des_buffer_from_stream' or
                        $generationMode = 'union_initialize_des_buffer_from_stream')))" />
                          
    <xsl:if test="$needSwitch">
      <xsl:if test="position() = 2">    
          <xsl:if test="$discContainer = ''">
    switch(<xsl:value-of select="$unionVariableName"/>->_d) {
          </xsl:if>
          <xsl:if test="$discContainer != ''">
    switch(<xsl:value-of select="$discContainer"/>) {
          </xsl:if>
      </xsl:if>
      <xsl:for-each select="cases/case">
        <xsl:if test="not(@value = 'default')">case </xsl:if><xsl:value-of select="@value"/>:
        <xsl:if test="position()=last()">{                                    
        </xsl:if>
      </xsl:for-each>
    </xsl:if>    

    <xsl:call-template name="generateMemberCode">
        <xsl:with-param name="generationMode" select="$generationMode"/>
        <xsl:with-param name="member" select="."/>
    </xsl:call-template>          

    <xsl:if test="$needSwitch">
      <xsl:if test="not(cases/case[position() = last()]/@value = 'default')">
        } break;
      </xsl:if>
      <xsl:if test="cases/case[position() = last()]/@value = 'default'">
        };
      </xsl:if>      
      <xsl:if test="position() = last()">        
    }
      </xsl:if>
    </xsl:if>        
</xsl:template>

<!-- Template for generating Members code -->
<xsl:template name="generateMemberCode">
    <xsl:param name="generationMode"/>
    <!-- indicates the variable where the member will be deserialized -->
    <xsl:param name="discContainer" select="''"/> 
    <xsl:param name="member"/>
    <xsl:call-template name="validateMetpMember">
        <xsl:with-param name="member" select="$member"/>
    </xsl:call-template>

    <xsl:variable name="xType">
        <xsl:call-template name="getExtensibilityKind">
            <xsl:with-param name="structName" select="$member/../@name"/>
            <xsl:with-param name="node" select="$member/.."/>
        </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="description">
        <xsl:call-template name="getMemberDescription">
            <xsl:with-param name="member" select="$member"/>
        </xsl:call-template>
    </xsl:variable>   
    <xsl:variable name="descriptionNode" select="xalan:nodeset($description)/node()"/>    
    
    <!-- have to check the generationMode in case it is for keys -->
    <xsl:variable name="tmpGenerationMode">
        <xsl:choose>
            <xsl:when test="$generationMode='serialize_key'">serialize</xsl:when>
            <xsl:when test="$generationMode='deserialize_key'">deserialize</xsl:when>
            <xsl:when test="$generationMode='get_max_size_serialized_key'">get_max_size_serialized</xsl:when>
            <xsl:when test="$generationMode='serialized_sample_to_key'">deserialize</xsl:when>
            <xsl:otherwise> <xsl:value-of select="$generationMode"/></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <!-- If the member is a pointer we check that its value is not NULL-->    
    <xsl:variable name="unionModifier">
        <xsl:if test="$member/../@kind = 'union'">_u.</xsl:if>
    </xsl:variable>

    <xsl:variable name="structKind">
        <xsl:value-of select="$member/../@kind"/>
    </xsl:variable>
    
    <!-- The checking for arrays is done in CDR. For the rest of the elements
         the checking is done in the following lines  -->
    <xsl:if test="$descriptionNode/@pointer = 'yes' and
                  $descriptionNode/@optional = 'no' and
                  $descriptionNode/@memberKind != 'array' and
                  $descriptionNode/@memberKind != 'arraySequence'"> 
        <xsl:choose>
            <xsl:when test="$generationMode='serialize' and not($member/@name)"> <!-- Typedef -->
    if (*sample == NULL) {
        return RTI_FALSE;
    }
            </xsl:when>        
            <xsl:when test="($generationMode='serialize' or $generationMode='serialize_key') 
                            and $member/@name"> <!-- Struct or union -->
    if (sample-><xsl:value-of select="concat($unionModifier,$member/@name)"/> == NULL) {
        return RTI_FALSE;
    }
            </xsl:when>                
            <xsl:when test="$generationMode='copy' and not($member/@name)">
    if (*src == NULL || *dst==NULL) {
        return RTI_FALSE;
    }
            </xsl:when>        
            <xsl:when test="$generationMode='copy' and $member/@name">
    if (src-><xsl:value-of select="concat($unionModifier,$member/@name)"/> == NULL ||
        dst-><xsl:value-of select="concat($unionModifier,$member/@name)"/> == NULL) {
        return RTI_FALSE;
    }
            </xsl:when>                           
            <xsl:otherwise>                
            </xsl:otherwise>
        </xsl:choose>    
    </xsl:if>
                                                     
    <!-- Select template string. -->                         
    <xsl:variable name="templateString">
        <xsl:call-template name="selectTemplate">
            <xsl:with-param name="generationMode" select="$tmpGenerationMode"/>
            <xsl:with-param name="memberKind" select="$descriptionNode/@memberKind"/>
            <xsl:with-param name="bitKind" select="$descriptionNode/@bitKind"/>                    
            <xsl:with-param name="typeKind" select="$descriptionNode/@typeKind"/>                    
            <xsl:with-param name="type" select="$descriptionNode/@type"/>
            <xsl:with-param name="pointer" select="$descriptionNode/@pointer"/>
            <xsl:with-param name="alignFast" select="$descriptionNode/@alignFast"/>
            <xsl:with-param name="isOptional" select="$descriptionNode/@optional"/>
        </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="needExtendedParameterId">
        <xsl:call-template name="needExtendedParameterId">
            <xsl:with-param name="member" select="$member"/>
            <xsl:with-param name="baseMemberKind" select="$descriptionNode/@memberKind"/>
            <xsl:with-param name="baseTypeKind" select="$descriptionNode/@typeKind"/>
        </xsl:call-template>
    </xsl:variable>

    <xsl:if test="$generationMode='serialize' or $generationMode='serialize_key'">
        <!-- This code goes before serializing a member from a mutable type of 
             an optional member from a type of any extensibility kind -->
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY' or $descriptionNode/@optional='yes'">
            <!-- If the member is optional we won't serialize it. If the type is mutable
                 we won't even serialize the header; otherwise we do need to serialize
                 a header indicating zero length (see ahead) -->
            <xsl:if test="$descriptionNode/@optional='yes' and $xType='MUTABLE_EXTENSIBILITY'">
                <xsl:text>    if (sample-></xsl:text><xsl:value-of select="$member/@name"/><xsl:text>!=NULL) {&nl;</xsl:text>  
            </xsl:if>
            <xsl:text>        memberId = </xsl:text> <xsl:value-of select="$member/@memberId" /><xsl:text>;&nl;</xsl:text>
            <xsl:choose>
                <xsl:when test="$needExtendedParameterId = 'no'">
                    <xsl:text>        extended = RTI_FALSE;&nl;</xsl:text>
                </xsl:when>
                <xsl:when test="$needExtendedParameterId = 'yes'">
                    <xsl:text>        extended = RTI_TRUE;&nl;</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>        extended = stream->_xTypesState.useExtendedId;&nl;</xsl:text>
                </xsl:otherwise>
             </xsl:choose>
            <xsl:text>        memberLengthPosition = RTICdrStream_serializeParameterHeader(&nl;</xsl:text>
            <xsl:text>                                   stream, &amp;state, extended, memberId, RTI_FALSE);</xsl:text>
            <!-- (See comment at the beginning of this xsl:if tag) -->
            <xsl:if test="$descriptionNode/@optional='yes' and $xType!='MUTABLE_EXTENSIBILITY'">
                <xsl:text>&nl;</xsl:text>
                <xsl:text>    if (sample-></xsl:text><xsl:value-of select="$member/@name"/><xsl:text>!=NULL) {&nl;</xsl:text>  
            </xsl:if>
            
        </xsl:if>
    </xsl:if>

    <xsl:variable name="memberName" select="$member/@name"/>
    <xsl:variable name="currentMemberId" select="$member/@memberId" />

    <xsl:if test="$generationMode='deserialize' or $generationMode='skip' or $generationMode='skip_and_get_deserialized_length' or
                  $generationMode='union_skip_and_get_deserialized_length' 
                  or $generationMode='deserialize_key' or $generationMode='serialized_sample_to_key' or
                  $generationMode = 'initialize_des_buffer_from_stream' or $generationMode = 'union_initialize_des_buffer_from_stream'">
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> 
            <xsl:for-each  select="$member/../node()[name()='member' or name()='discriminator']">
                <xsl:if test="@memberId = $currentMemberId and @name != $memberName">
                    <xsl:message terminate="yes"> Error! <xsl:value-of select="@name" /> member does not have a unique Id</xsl:message>
                </xsl:if>
                <xsl:if test="@name = $memberName">
                <xsl:text>
                case </xsl:text><xsl:value-of select="./@memberId"></xsl:value-of><xsl:text>:</xsl:text>
                </xsl:if>
            </xsl:for-each>
       </xsl:if>
    </xsl:if>

    <xsl:if test="($xType='MUTABLE_EXTENSIBILITY' or $descriptionNode/@optional='yes')
                  and ($member/../@kind != 'union' or name($member)='discriminator')"> 
        <xsl:if test="$generationMode='get_max_size_serialized' or
                      $generationMode='get_max_size_serialized_key'">
            <xsl:text>    current_alignment += RTICdrStream_getExtendedParameterHeaderMaxSizeSerialized(current_alignment);&nl;</xsl:text>    
        </xsl:if>
    
        <xsl:if test="$generationMode='get_min_size_serialized' or 
                      $generationMode='get_serialized_sample_size'">
            <!-- If a member is optional we need to check if it's NULL, in which
                 case we won't count it toward the actual sample serialized size.
                 If it is not mutable, we still need to account for the header
                 which we cannot ommit. 
              -->
            <xsl:if test="$generationMode='get_serialized_sample_size' 
                          and $descriptionNode/@optional='yes' 
                          and $xType='MUTABLE_EXTENSIBILITY'">
                <xsl:text>    if (sample-></xsl:text><xsl:value-of select="$member/@name"/><xsl:text>!=NULL) {&nl;</xsl:text>  
            </xsl:if>
            <!-- Add the size of the parameter header in any of these cases:
               a) We're calculating the actual sample size
               b) The member is mutable and non-optional
               c) The member is non-mutable and optional (optional members in extensible and final types 
                  still need to serialize at least the header)
             -->
            <xsl:if test="$generationMode='get_serialized_sample_size'
                          or $descriptionNode/@optional='no'
                          or $xType!='MUTABLE_EXTENSIBILITY'">
                <xsl:if test="$needExtendedParameterId = 'yes' or $needExtendedParameterId = 'maybe'">
                    <xsl:text>    current_alignment += RTICdrStream_getExtendedParameterHeaderMaxSizeSerialized(current_alignment);&nl;</xsl:text>
                </xsl:if>
                <xsl:if test="$needExtendedParameterId = 'no'">
                    <xsl:text>    current_alignment += RTICdrStream_getParameterHeaderMaxSizeSerialized(current_alignment);&nl;</xsl:text>
                </xsl:if>
            </xsl:if>
            <!-- (See previous comment) -->
            <xsl:if test="$generationMode='get_serialized_sample_size' 
                          and $descriptionNode/@optional='yes' 
                          and $xType!='MUTABLE_EXTENSIBILITY'">
                <xsl:text>    if (sample-></xsl:text><xsl:value-of select="$member/@name"/><xsl:text>!=NULL) {&nl;</xsl:text>  
            </xsl:if>             
        </xsl:if>
    </xsl:if>
    
    <xsl:if test="$generationMode='deserialize' or $generationMode='skip'">
        <xsl:if test="$xType!='MUTABLE_EXTENSIBILITY' and $descriptionNode/@optional='yes'">
        <xsl:text>
            if (!RTICdrStream_deserializeParameterHeader(
                     stream,
                     &amp;state,
                     &amp;memberId,
                     &amp;length,
                     &amp;extended,
                     &amp;mustUnderstand)) {
        </xsl:text>                     
              <xsl:if test="$xType='EXTENSIBLE_EXTENSIBILITY'">
                <xsl:text>goto fin;</xsl:text>
              </xsl:if>
              <xsl:if test="$xType!='EXTENSIBLE_EXTENSIBILITY'">
                <xsl:text>return RTI_FALSE;</xsl:text>
              </xsl:if>
        <xsl:text>              
            }
            if (length > 0) {
        </xsl:text>
        </xsl:if>
    </xsl:if>

    <!-- =================== -->
    <!-- Add the member code -->
    <!-- =================== -->
    <xsl:if test="$generationMode!='get_min_size_serialized' or 
                  $descriptionNode/@optional='no'">
        <!-- We're skipping the code to get the min serialized size of optional
             members. Since they can be ommitted, their min size is zero -->
        <xsl:call-template name="replace-params">
            <xsl:with-param name="generationMode" select="$generationMode"/>            
            <xsl:with-param name="member" select="$member"/>            
            <xsl:with-param name="templateString" select="$templateString"/>        
            <xsl:with-param name="type" select="$descriptionNode/@type"/>
            <xsl:with-param name="typeKind" select="$descriptionNode/@typeKind"/>                
            <xsl:with-param name="memberKind" select="$descriptionNode/@memberKind"/>                                
            <xsl:with-param name="bitField" select="$descriptionNode/@bitField"/>
            <xsl:with-param name="pointer" select="$descriptionNode/@pointer"/>
            <xsl:with-param name="optional" select="$descriptionNode/@optional"/>
            <xsl:with-param name="discContainer" select="$discContainer"/>
            <xsl:with-param name="xType" select="$xType"/>
            <xsl:with-param name="structKind" select="$structKind"/>
        </xsl:call-template>
    </xsl:if>

    <xsl:text>&nl;</xsl:text>
    <xsl:if test="$generationMode='deserialize' or $generationMode='skip'">
        <xsl:if test="$xType!='MUTABLE_EXTENSIBILITY' and $descriptionNode/@optional='yes'">
                <xsl:text>}&nl;</xsl:text>
                <xsl:text>RTICdrStream_moveToNextParameterHeader(stream, &amp;state, length);&nl;</xsl:text>
        </xsl:if>
    </xsl:if>    

    <xsl:if test="$xType='MUTABLE_EXTENSIBILITY' and $member/../@kind = 'union' and name($member)='discriminator'"> 
        <xsl:if test="$generationMode='get_max_size_serialized' or
                      $generationMode='get_max_size_serialized_key'">
            <xsl:text>    current_alignment += RTICdrStream_getExtendedParameterHeaderMaxSizeSerialized(current_alignment);&nl;</xsl:text>    
        </xsl:if> 
    
        <xsl:if test="$generationMode='get_min_size_serialized' or 
                      $generationMode='get_serialized_sample_size'">
            <xsl:choose>
                <xsl:when test="$needExtendedParameterId = 'yes' or $needExtendedParameterId = 'maybe' or name($member)='discriminator'">
                    <xsl:text>    current_alignment += RTICdrStream_getExtendedParameterHeaderMaxSizeSerialized(current_alignment);&nl;</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>    current_alignment += RTICdrStream_getParameterHeaderMaxSizeSerialized(current_alignment);&nl;</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:if>

    <xsl:if test="$generationMode='serialize' or $generationMode='serialize_key'">
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY' or $descriptionNode/@optional='yes'"> 
        <xsl:if test="$xType!='MUTABLE_EXTENSIBILITY'">
            <!-- Close 'if' block started before under this same condition -->
            <xsl:text>    }&nl;</xsl:text>  
        </xsl:if>        
        <xsl:text>        if (!RTICdrStream_serializeParameterLength(&nl;</xsl:text>
        <xsl:text>                 stream, &amp;state, extended, memberLengthPosition)) {&nl;</xsl:text>
        <xsl:text>            return RTI_FALSE;&nl;</xsl:text>
        <xsl:text>        }&nl;</xsl:text>
        <xsl:if test="$descriptionNode/@optional='yes' and $xType='MUTABLE_EXTENSIBILITY'">
            <!-- Close 'if' block started before under this same condition -->
            <xsl:text>    }&nl;</xsl:text>  
        </xsl:if>
        </xsl:if>
    </xsl:if>
    
    
   <xsl:if test="$generationMode='get_serialized_sample_size' 
                 and $descriptionNode/@optional='yes'">
       <!-- Close previous 'if' block started under this condition  -->
       <xsl:text>    }&nl;</xsl:text>   
   </xsl:if>         
    
   <xsl:if test="$generationMode='deserialize' or $generationMode='skip' or $generationMode = 'skip_and_get_deserialized_length' or
                 $generationMode = 'union_skip_and_get_deserialized_length'
                 or $generationMode='deserialize_key' or $generationMode='serialized_sample_to_key' or
                 $generationMode = 'initialize_des_buffer_from_stream' or $generationMode = 'union_initialize_des_buffer_from_stream'">
       <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> 
       <xsl:text>
               break;</xsl:text>
       </xsl:if>
   </xsl:if>
</xsl:template>


<!-- Obtain array dimenstion
     @param cardinality a <cardinality> element with dimension as child. See schema in simplifyIDLXML.xsl
     @return a string of form [dim1][dim2]
-->
<xsl:template name="obtainArrayDimensions">
        <xsl:param name="cardinality"/>
        <xsl:for-each select="$cardinality/dimension">[<xsl:value-of select="@size"/>]</xsl:for-each>
</xsl:template>

<!-- Obtain total size of an array
     @param cardinality a <cardinality> element with dimension as child. See schema in simplifyIDLXML.xsl
     @return a string of form dim1*dim2
-->
<xsl:template name="obtainTotalSize">
        <xsl:param name="cardinality"/>
        <xsl:for-each select="$cardinality/dimension">(<xsl:value-of select="@size"/>)<xsl:if test="position() != last()">*</xsl:if>
        </xsl:for-each>
</xsl:template>

<!-- 
Obtain parameters for a struct member (to substitute parameters in templatized outout string)
@param structMember a <member> element. See schema in simplifyIDLXML.xsl
@return element with <member-param> as the root and arrtibue-value pairs with each each attribute
        name set to the parameter to be replaced and value to the replacement value.
-->
<xsl:template name="obtainMemberParameters">
    <xsl:param name="structMember"/>
    <xsl:param name="generationMode"/>        
    <xsl:param name="type"/>
    <xsl:param name="typeKind"/>                
    <xsl:param name="memberKind"/>                                
    <xsl:param name="bitField"/>                                                
    <xsl:param name="pointer"/>
    <xsl:param name="optional"/>
    <xsl:param name="discContainer"/>
    <xsl:param name="xType"/>
    <xsl:param name="structKind"/>
                                               
    <xsl:variable name="matchedTypeNode" select="$typeInfoMap/type[@idlType=$type]"/>        

    <xsl:variable name="baseType">
        <xsl:call-template name="getBaseType">
            <xsl:with-param name="member" select="$structMember"/>
        </xsl:call-template>                     
    </xsl:variable>

    <xsl:variable name="baseMemberKind">
        <xsl:call-template name="obtainBaseMemberKind">
            <xsl:with-param name="member" select="$structMember"/>
        </xsl:call-template>
    </xsl:variable>
                    
                                                    
    <member-param name="{$structMember/@name}" rawName="{$structMember/@name}" 
                  pointer="" idlType="$type"
                  sampleAccess="sample->" sampleAccessPointer="&amp;sample->" 
                  srcAccess="src->" srcAccessPointer="&amp;src->" 
                  dstAccess="dst->" dstAccessPointer="&amp;dst->">
        <xsl:choose>
            <xsl:when test ="$xType='MUTABLE_EXTENSIBILITY' and $generationMode != 'skip_and_get_deserialized_length' and 
                             $generationMode != 'union_skip_and_get_deserialized_length'">  
                <xsl:attribute name="currentAlignment"><xsl:value-of select="'0'"/></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>                
                <xsl:attribute name="currentAlignment"><xsl:value-of select="'current_alignment'"/></xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:attribute name="maxSerializeLeading"><xsl:value-of select="'current_alignment += '"/></xsl:attribute>
        <xsl:attribute name="maxDeserializeLeading"><xsl:value-of select="'current_alignment += '"/></xsl:attribute>
        <xsl:attribute name="minDeserializeLeading"><xsl:value-of select="'current_alignment += '"/></xsl:attribute>
        <xsl:attribute name="minSerializeLeading"><xsl:value-of select="'current_alignment += '"/></xsl:attribute>
        <xsl:attribute name="maxSerializeTrailing"><xsl:value-of select="''"/></xsl:attribute>  
        <xsl:attribute name="minSerializeTrailing"><xsl:value-of select="''"/></xsl:attribute>  
        <xsl:attribute name="maxDeserializeTrailing"><xsl:value-of select="''"/></xsl:attribute>
        <xsl:attribute name="minDeserializeTrailing"><xsl:value-of select="''"/></xsl:attribute>
       
       <xsl:choose>
           <xsl:when test ="($structKind='struct' or $structKind='valuetype') and $xType='EXTENSIBLE_EXTENSIBILITY' and 
                            ($generationMode='deserialize' or $generationMode='skip') and $metp='no'">
                <xsl:attribute name="deserializationErrorHandling">goto fin</xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="deserializationErrorHandling">return RTI_FALSE</xsl:attribute>
            </xsl:otherwise>
       </xsl:choose>

        <!-- Member is a pointer if declared as such or if it's optional and
             not a string or a typedef'd string (already a pointer), or an
             array (not valid in C; typedef is OK) -->
        <xsl:if test="$pointer='yes' 
                      or ($optional='yes' and $baseMemberKind!='string' 
                          and $baseMemberKind!='wstring')">                        
            <xsl:attribute name="pointer">*</xsl:attribute>
            <xsl:choose>
                <xsl:when test="$optional='yes' and $generationMode='copy'">
                    <xsl:attribute name="sampleAccessPointer">dst-></xsl:attribute>                          
                    <xsl:attribute name="sampleAccess">*dst-></xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="sampleAccessPointer">sample-></xsl:attribute>                          
                    <xsl:attribute name="sampleAccess">*sample-></xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>                                  
            <xsl:attribute name="srcAccessPointer">src-></xsl:attribute>                          
            <xsl:attribute name="srcAccess">*src-></xsl:attribute>                                                                  
            <xsl:attribute name="dstAccessPointer">dst-></xsl:attribute>                          
            <xsl:attribute name="dstAccess">*dst-></xsl:attribute>
        </xsl:if>
        
        <xsl:if test="$optional='yes' and $pointer='no'
                and ($baseMemberKind='string' or $baseMemberKind='wstring')
                and $generationMode='copy'">
            <xsl:attribute name="sampleAccessPointer">&amp;dst-></xsl:attribute>                          
            <xsl:attribute name="sampleAccess">dst-></xsl:attribute>                
        </xsl:if>
                        
        <!-- For unions -->                                
        <xsl:if test="$structMember/../@kind = 'union'">                                                                                                                        
            <xsl:if test="$structMember/@uniondisc">
                <xsl:if test="$discContainer = ''">
                    <xsl:attribute name="name">_d</xsl:attribute>                                                                                
                </xsl:if>
                <xsl:if test="$discContainer != ''">
                    <xsl:attribute name="sampleAccessPointer">
                        <xsl:text>&amp;</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="sampleAccess"/>                    
                    <xsl:attribute name="name">
                        <xsl:value-of select="$discContainer"/>
                    </xsl:attribute> 
                </xsl:if>
            </xsl:if>
            <xsl:if test="not($structMember/@uniondisc)">
                <xsl:attribute name="name">_u.<xsl:value-of select="$structMember/@name"/></xsl:attribute>                                                        
            </xsl:if>                                                                                                
        </xsl:if>
                
        <xsl:if test="$structMember/../@kind = 'union' and not($structMember/@uniondisc)">                        
            <xsl:attribute name="maxSerializeLeading"><xsl:value-of select="'union_max_size_serialized = RTIOsapiUtility_max('"/></xsl:attribute>
            <xsl:attribute name="maxSerializeTrailing"><xsl:value-of select="', union_max_size_serialized)'"/></xsl:attribute>              
            <xsl:attribute name="maxDeserializeLeading"><xsl:value-of select="'union_max_size_deserialized = RTIOsapiUtility_max('"/></xsl:attribute>
            <xsl:attribute name="maxDeserializeTrailing"><xsl:value-of select="', union_max_size_deserialized)'"/></xsl:attribute>              
            <xsl:attribute name="minSerializeLeading"><xsl:value-of select="'union_min_size_serialized = RTIOsapiUtility_min('"/></xsl:attribute>
            <xsl:attribute name="minSerializeTrailing"><xsl:value-of select="', union_min_size_serialized)'"/></xsl:attribute>              
        </xsl:if>
                
        <!-- For typedefs -->                  
        <xsl:if test="name($structMember/..) = 'typedef'">
            <xsl:attribute name="sampleAccess">(*sample)</xsl:attribute>
            <xsl:attribute name="sampleAccessPointer">sample</xsl:attribute> 
            <xsl:attribute name="srcAccess">(*src)</xsl:attribute>
            <xsl:attribute name="srcAccessPointer">src</xsl:attribute>
            <xsl:attribute name="dstAccess">(*dst)</xsl:attribute>
            <xsl:attribute name="dstAccessPointer">dst</xsl:attribute>                                                                                                                                                                
            
            <xsl:if test="$pointer='yes'">                        
                <xsl:attribute name="sampleAccessPointer">(*sample)</xsl:attribute>                          
                <xsl:attribute name="sampleAccess">(**sample)</xsl:attribute>                                              
                <xsl:attribute name="srcAccessPointer">(*src)</xsl:attribute>                          
                <xsl:attribute name="srcAccess">(**src)</xsl:attribute>                                                                  
                <xsl:attribute name="dstAccessPointer">(*dst)</xsl:attribute>                          
                <xsl:attribute name="dstAccess">(**dst)</xsl:attribute>                                                                                      
           </xsl:if>            
        </xsl:if>               
                
        <xsl:choose>
            <xsl:when test="$matchedTypeNode">
                <!-- For builtin types, just copy over all the attributes of the matchedTypeNode,
                     since the attribute name in that map (must) match the template parameter strings -->
                <xsl:copy-of select="$matchedTypeNode/@*"/>                             
                <xsl:if test="$pointer='yes'">
                    <xsl:attribute name="arraySerializeMethod">RTICdrStream_serializePrimitivePointerArray</xsl:attribute>                                                            
                    <xsl:attribute name="arrayDeserializeMethod">RTICdrStream_deserializePrimitivePointerArray</xsl:attribute>
                    <xsl:attribute name="arraySkipMethod">RTICdrStream_skipPrimitivePointerArray</xsl:attribute>
                </xsl:if>                                        
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$pointer='yes' and $generationMode='structMember'">
                        <xsl:variable name="forward_dcl">
                            <xsl:if
                                test="$structMember/../preceding-sibling::node()[contains($type,@name) and name()='forward_dcl']">
                                <xsl:variable name="forwardKind"
                                    select="$structMember/../preceding-sibling::node()[contains($type,@name) and name()='forward_dcl']/@kind" />
                                <xsl:choose>
                                    <xsl:when test="@kind = 'enum'">
                                        <xsl:text>enum </xsl:text>
                                    </xsl:when>
                                    <xsl:when test="@kind = 'union' or $language='C'">
                                        <xsl:text>struct </xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>class </xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:variable>
                        <xsl:attribute name="nativeType"><xsl:value-of select="concat($forward_dcl,' ',$type)"/></xsl:attribute>                            
                    </xsl:when>
                    <xsl:otherwise>                        
                        <xsl:attribute name="nativeType"><xsl:value-of select="$type"/></xsl:attribute>
                    </xsl:otherwise>
                </xsl:choose>                
                
                <xsl:attribute name="nativeTypeSeq"><xsl:value-of select="$type"/>Seq</xsl:attribute>
		<xsl:attribute name="elementSerializeMethod">
		    <xsl:choose>
			<xsl:when test="$generationMode='serialize_key'"><xsl:value-of select="$type"/>Plugin_serialize_key</xsl:when>
			<xsl:otherwise><xsl:value-of select="$type"/>Plugin_serialize</xsl:otherwise>
		    </xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="elementDeserializeMethod">
		    <xsl:choose>
                        <xsl:when test="$generationMode='serialized_sample_to_key'"><xsl:value-of select="$type"/>Plugin_serialized_sample_to_key</xsl:when>
			<xsl:when test="$generationMode='deserialize_key'"><xsl:value-of select="$type"/>Plugin_deserialize_key_sample</xsl:when>
			<xsl:otherwise><xsl:value-of select="$type"/>Plugin_deserialize_sample</xsl:otherwise>
		    </xsl:choose>
		</xsl:attribute>
                <xsl:attribute name="elementSkipMethod"><xsl:value-of select="$type"/>Plugin_skip</xsl:attribute>
                <xsl:attribute name="sequenceSerializeMethod">RTICdrStream_serializeNonPrimitiveSequence</xsl:attribute>
                <xsl:attribute name="sequenceDeserializeMethod">RTICdrStream_deserializeNonPrimitiveSequence</xsl:attribute>
                <xsl:attribute name="sequenceSkipMethod">RTICdrStream_skipNonPrimitiveSequence</xsl:attribute>
                <xsl:attribute name="pointerSequenceSerializeMethod">RTICdrStream_serializeNonPrimitivePointerSequence</xsl:attribute>                                
                <xsl:attribute name="pointerSequenceDeserializeMethod">RTICdrStream_deserializeNonPrimitivePointerSequence</xsl:attribute>
    		<xsl:if test="$pointer='yes'">
                    <xsl:attribute name="arraySerializeMethod">RTICdrStream_serializeNonPrimitivePointerArray</xsl:attribute>                                    
                    <xsl:attribute name="arrayDeserializeMethod">RTICdrStream_deserializeNonPrimitivePointerArray</xsl:attribute>
                    <xsl:attribute name="arraySkipMethod">RTICdrStream_skipNonPrimitiveArray</xsl:attribute>
                </xsl:if>
                <xsl:if test="$pointer='no'">
                    <xsl:attribute name="arraySerializeMethod">RTICdrStream_serializeNonPrimitiveArray</xsl:attribute>                                    
                    <xsl:attribute name="arrayDeserializeMethod">RTICdrStream_deserializeNonPrimitiveArray</xsl:attribute>
                </xsl:if>                                
                <xsl:attribute name="arraySkipMethod">RTICdrStream_skipNonPrimitiveArray</xsl:attribute>
                <xsl:attribute name="elementPrintMethod"><xsl:value-of select="$type"/>PluginSupport_print_data</xsl:attribute>
                
                <xsl:choose>
                    <xsl:when test="$generationMode='initialize'">
                        <xsl:attribute name="elementInitMethod"><xsl:value-of select="$type"/>_initialize_w_params</xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="elementInitMethod"><xsl:value-of select="$type"/>_initialize_ex</xsl:attribute>
                    </xsl:otherwise>
                </xsl:choose>
                
                <xsl:attribute name="elementCopyMethod"><xsl:value-of select="$type"/>_copy</xsl:attribute>
                <xsl:attribute name="elementFinalizeMethod">
                    <xsl:choose>
                        <xsl:when test="$generationMode='finalize_optional' 
                                         and $optional='no' 
                                         and $structMember/@enum != 'yes'">
                            <!-- When finalizing a type's optional members we call 
                                 recursively on non-optional members. Enums don't
                                 have a finalize_optional_members function -->
                            <xsl:value-of select="$type"/>_finalize_optional_members</xsl:when>
                        <xsl:otherwise>
                            <!-- If we're in the normal finalize mode or in finalize_optional
                                 and dealing with an optional member we call the regular
                                 finalize function -->
                            <xsl:value-of select="$type"/>_finalize_w_params</xsl:otherwise> 
                    </xsl:choose>
                </xsl:attribute>
                <xsl:attribute name="elementSize">sizeof(<xsl:value-of select="$type"/>)</xsl:attribute>
		<xsl:attribute name="elementSizeMethod">
		    <xsl:choose>
                        <xsl:when test="$generationMode='get_min_size_serialized'"><xsl:value-of select="$type"/>Plugin_get_serialized_sample_min_size</xsl:when>
			<xsl:when test="$generationMode='get_max_size_serialized_key'"><xsl:value-of select="$type"/>Plugin_get_serialized_key_max_size</xsl:when>
                        <xsl:when test="$generationMode='get_serialized_sample_size'"><xsl:value-of select="$type"/>Plugin_get_serialized_sample_size</xsl:when>
                        <xsl:when test="$generationMode='get_min_size_deserialized'"><xsl:value-of select="$type"/>Plugin_get_deserialized_sample_min_size</xsl:when>                        
			<xsl:otherwise><xsl:value-of select="$type"/>Plugin_get_serialized_sample_max_size</xsl:otherwise>
		    </xsl:choose>
		</xsl:attribute>
                <xsl:attribute name="elementGetDeserializedLengthMethod"><xsl:value-of select="$type"/>Plugin_get_deserialized_sample_size</xsl:attribute>                                                        
                <xsl:attribute name="elementInitDesBufferFromStreamMethod"><xsl:value-of select="$type"/>Plugin_initialize_deserialization_buffer_pointers_from_stream</xsl:attribute>
                <xsl:attribute name="elementInitDesBufferFromSampleMethod"><xsl:value-of select="$type"/>Plugin_initialize_deserialization_buffer_pointers_from_sample</xsl:attribute>
                <xsl:attribute name="elementInitDesBufferMethod"><xsl:value-of select="$type"/>Plugin_initialize_deserialization_buffer_pointers</xsl:attribute>
                <xsl:attribute name="arraySizeMethod">
                    <xsl:choose>
                        <xsl:when test="$generationMode='get_serialized_sample_size'">RTICdrType_getNonPrimitiveArraySerializedSize</xsl:when>
                        <xsl:otherwise>RTICdrType_getNonPrimitiveArrayMaxSizeSerialized</xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <xsl:attribute name="sequenceSizeMethod">RTICdrType_getNonPrimitiveSequenceMaxSizeSerialized</xsl:attribute>                            
                <xsl:attribute name="elementPrintBitsMethod">RTICdrType_printBits</xsl:attribute>
                <xsl:if test="$baseType">
                    <xsl:attribute name="elementPrintBitsMethod">RTICdrType_printUnsignedBits</xsl:attribute>
                </xsl:if>  
            </xsl:otherwise>
        </xsl:choose>

            <!-- Now set parameter common to builtin/user type: array dimension, array sizes, bit fields, sequence and string lengths -->
            <xsl:attribute name="cardinality">                    
                <xsl:if test="cardinality">
                    <xsl:call-template name="obtainArrayDimensions"><xsl:with-param name="cardinality" select="cardinality"/></xsl:call-template>                        
                </xsl:if>
                <xsl:if test="not(cardinality)">
                    <xsl:call-template name="obtainArrayDimensions"><xsl:with-param name="cardinality" select="member/cardinality"/></xsl:call-template>                        
                </xsl:if>                    
            </xsl:attribute>
            <xsl:attribute name="multiDimensionalArraySize">
                <xsl:if test="cardinality">
                    <xsl:call-template name="obtainTotalSize"><xsl:with-param name="cardinality" select="cardinality"/></xsl:call-template>
                </xsl:if>
                <xsl:if test="not(cardinality)">
                    <xsl:call-template name="obtainTotalSize"><xsl:with-param name="cardinality" select="member/cardinality"/></xsl:call-template>                        
                </xsl:if>
            </xsl:attribute>
                           
            <xsl:if test="$bitField != ''">
                <xsl:attribute name ="bits"><xsl:value-of select="$bitField"/></xsl:attribute>
            </xsl:if>

            <xsl:if test="$type = 'string' or $type = 'wstring'">
                <xsl:if test="$structMember/@maxLengthString">
                    <xsl:attribute name="stringMaxLength">(<xsl:value-of select="$structMember/@maxLengthString"/>)</xsl:attribute>                        
                </xsl:if>
                <xsl:if test="not($structMember/@maxLengthString)">
                    <xsl:attribute name="stringMaxLength">(<xsl:value-of select="$structMember/member/@maxLengthString"/>)</xsl:attribute>                        
                </xsl:if>                
            </xsl:if>

            <xsl:if test="$memberKind = 'sequence' or $memberKind = 'arraySequence'">
                <xsl:if test="$structMember/@maxLengthSequence">
                    <xsl:attribute name="sequenceMaxLength">(<xsl:value-of select="$structMember/@maxLengthSequence"/>)</xsl:attribute>                    
                </xsl:if>
                <xsl:if test="not($structMember/@maxLengthSequence)">
                    <xsl:attribute name="sequenceMaxLength">(<xsl:value-of select="$structMember/member/@maxLengthSequence"/>)</xsl:attribute>                        
                </xsl:if>                
            </xsl:if>
            
            <xsl:attribute name="elementDeletePointersCondition">
                <xsl:choose>
                    <xsl:when test="$optional='yes'">
                        <!-- The finalize function always deletes optional members, hence
                             there's no condition to check -->
                        <xsl:text></xsl:text></xsl:when>
                    <xsl:otherwise>
                        <!-- In the regular case we prepend the deleteOptional
                             boolean parameter to the finalize function -->
                        <xsl:text>deallocParams-&gt;delete_pointers &amp;&amp; </xsl:text></xsl:otherwise> 
                </xsl:choose>                    
            </xsl:attribute>
            
            <xsl:attribute name="elementDeletePointersArgument">
                <xsl:choose>
                    <xsl:when test="$generationMode='finalize_optional' 
                                     and $optional='no' 
                                     and $structMember/@enum != 'yes'">
                        <!-- The finalize function always deletes optional members, hence
                             there's no condition to check -->
                        <xsl:text></xsl:text>, deallocParams-&gt;delete_pointers</xsl:when>
                    <xsl:otherwise>
                        <!-- In the regular case we prepend the deleteOptional
                             boolean parameter to the finalize function -->
                        <xsl:text>, deallocParams</xsl:text></xsl:otherwise> 
                </xsl:choose>                    
            </xsl:attribute>                     
                            
            <xsl:choose>
                    <xsl:when test="$language = 'C'">
                            <xsl:attribute name="cStruct">struct</xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                            <xsl:attribute name="cStruct"></xsl:attribute>
                    </xsl:otherwise>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="$optional!='yes'">
                    <xsl:attribute name="allocatePointers">allocParams-&gt;allocate_pointers</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="allocatePointers">1</xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>                
        </member-param>
</xsl:template>

<!--
Process directives (next 4 <xsl:template> rules)

If "kind" attribute is "copy", then copy the text inside the <directive> element.
Otherwise issue a warning message, and ignore the directive.
-->
<xsl:template match="directive[@kind = 'copy' or @kind = 'copy-c']">
<xsl:text>&nl;</xsl:text><xsl:value-of select="text()"/><xsl:text>&nl;</xsl:text>
</xsl:template>

<xsl:template match="directive[@kind = 'copy' or @kind = 'copy-c']"
              mode="code-generation">
<xsl:text>&nl;</xsl:text><xsl:value-of select="text()"/><xsl:text>&nl;</xsl:text>
</xsl:template>

</xsl:stylesheet>
