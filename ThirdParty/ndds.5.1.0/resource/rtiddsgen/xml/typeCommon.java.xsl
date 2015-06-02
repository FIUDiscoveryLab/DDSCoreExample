<?xml version="1.0"?>
<!-- 
/* $Id: typeCommon.java.xsl,v 1.9 2013/09/12 14:22:28 fernando Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
Modification history:
- - - - - - - - - - -
5.0.1,10jun13,fcs CODEGEN-596: TypePlugin code generation for optional members in Java
5.0.1,16may13,fcs CODEGEN-588: Union mutability support in Java
1.0ac,05may13,fcs CODEGEN-584: Added clear method
5.0.1,04may13,fcs CODEGEN-560: XTypes mutability support in Java
1.0ac,08dec10,fcs Added copy-java-begin and copy-java-declaration-begin
10ae,22nov10,fcs Added dataReaderSuffix and dataWriterSuffix
10ae,26feb10,fcs Sequence suffix support
10ac,29aug09,fcs Double pointer indirection and dropSample
                 in deserialize function
1.0ac,10aug09,fcs get_serialized_sample_size support
10u,16jul08,tk  Added utils.xsl
10u,26mar08,vtg Renamed copy_sample to copy_data
10s,04mar08,fcs Support for serialized_sample_to_key generation mode
10s,29feb08,fcs Support for get_min_size_serialized
10s,18feb08,fcs MD5 KeyHash generation support
10p,18feb08,fcs Skip support
10p,31dec07,vtg Made consistent with new type plugin API [First pass]
10p,11jul07,eh  Refactor data encapsulation to support previous nddsgen-generated plugins;
                use existing (de)serialize() prototype when add data encapsulation header
10o,03jul07,rbw Refactored unrecognized directive warnings to typeCommon.xsl
10m,06apr07,fcs Fixed multidimensional array copy
10l,08dec06,fcs Added printText parameter to printPackage statement 
10l,14aug06,krb Added support for copy functionality (filed as bug 11000).
10m,11aug06,fcs Fixed enums in case stmts
10m,23jul06,fcs JDK 1.5 support
10m,12jul06,fcs Reverted Ken changes to fix the Java compilation
10m,11jul06,krb Updates to allow get_max_serialized to work properly for CORBA unions.
10l,22mar06,fcs Added database parameter
10h,08dec05,fcs Defined language variable        
10g,05oct05,eys Added modifyPubData
10f,21jul05,fcs Modified processGlobalElements template to take into account module scope.
10f,21jul05,fcs Added three new process directives:
                copy-declaration, copy-c-declaration, copy-java-declaration
10e,09apr05,fcs Allowed top-level directive. 
10e,07apr05,fcs Change the condition for getting types with getMemberDescription template
                The new rule is:
                "If we have a type that is not a sequence or an array we can unwound to its original
                type. Otherwise, we should use the wrapper classes"
10e,02apr05,fcs Replaced init with initialize
10e,31mar05,fcs Allowed resolve-name directive. 
                This directive is used to indicate to nddsgen if it should resolve the scope.
                When this directive is not present nddsgen resolves the scope.
10e,18mar05,fcs Replaced typeCommon.base.java.xsl with typeCommon.xsl
                Refactored for being compatible with the new simplified XML document
                and support:
                - Bitfields
                - Sequences and Arrays of strings
                - Long Double with a CDR representation of 128 bits
                - Unions with Enum discriminator
                - Modules and qualified names
                - ...                
10e,16mar05,fcs Included typeCommon.base.java.xsl instead typeCommon.xsl
10d,25aug04,rw  Moved some copy directive templates here from type.java.xsl;
                added support for copy-java directive;
                added processGlobalElements
10d,23aug04,rw  Generate header comment
10d,30jul04,rw  Fixed incorrect generationMode
10d,27jul04,rw  Moved default processing rules to typeCommon.xsl
10c,15jun04,eys Added archName parameter.
10c,26may04,rrl Replaced tabs with 4 spaces to make output look prettier
10c,24may04,rrl Moved out error checking to typeCommon.xsl
10c,18may04,rrl Fixed #8869
10c,18may04,rrl Refactored obtainNativeType to typeCommon.xsl 
10c,11may04,rrl Fixed union's computation for maxSizeSerialized.
40b,05may05,rrl Added template to map idlType to nativeType
40b,03may04,rrl Support package prefix
40b,08mar04,rrl Created
-->
<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
<!ENTITY namespaceSeperator ".">    <!-- namespace separator -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:xalan = "http://xml.apache.org/xalan">

<xsl:variable name="idlFileBaseName" select="substring-before(/specification/@idlFileName, '.idl')"/>
<xsl:variable name="generationInfo" select="document('generation-info.java.xml')/generationInfo"/>
<xsl:variable name="typeInfoMap" select="$generationInfo/typeInfoMap"/>
<xsl:variable name="methodInfoMap" select="$generationInfo/methodInfoMap"/>

<xsl:param name="packagePrefix"/>
<xsl:param name="archName"/>
<xsl:param name="optLevel"/>
<xsl:param name="modifyPubData"/>
<xsl:param name="database"/>
<xsl:param name="useCopyable"/>
<xsl:param name="typeSeqSuffix"/>
<xsl:param name="dataReaderSuffix"/>
<xsl:param name="dataWriterSuffix"/>
        
<xsl:variable name="language" select="'JAVA'"/>

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
    <xsl:variable name="newNamespace" select="concat($containerNamespace, @name, '&namespaceSeperator;')"/>
    <xsl:apply-templates>
        <xsl:with-param name="containerNamespace" select="$newNamespace"/>
    </xsl:apply-templates>
</xsl:template>

<!-- -->
<xsl:template name="getTemplateString">
    <xsl:param name="generationMode"/>
    <xsl:param name="memberKind"/>
    <xsl:param name="bitKind"/>        
    <xsl:param name="typeKind"/>
    <xsl:param name="type"/>
    <xsl:param name="enum"/>
    <xsl:param name="optional"/>  
    
    <xsl:variable name="matchedMethodNode" select="$methodInfoMap/method[@kind = $generationMode]"/>
    
    <xsl:choose> 
        <xsl:when test="$matchedMethodNode/template[not(@kind) and not(@typeKind) and not(@bitKind) and not(@type) and not(@enum) and @optional=$optional]">
            <xsl:value-of select="$matchedMethodNode/template[not(@kind) and not(@typeKind) and not(@bitKind) and not(@type) and not(@enum) and @optional=$optional]"/>            
        </xsl:when>     
        <xsl:when test="$matchedMethodNode/template[@kind = $memberKind and @typeKind = $typeKind and @type = $type and not(@enum) and @optional=$optional]">
            <xsl:value-of select="$matchedMethodNode/template[@kind = $memberKind and @typeKind = $typeKind and @type= $type and not(@enum) and @optional=$optional]"/>            
        </xsl:when>        
        <xsl:when test="$matchedMethodNode/template[@kind = $memberKind and @typeKind = $typeKind and @enum = $enum and not(@type) and @optional=$optional]">
            <xsl:value-of select="$matchedMethodNode/template[@kind = $memberKind and @typeKind = $typeKind and @enum= $enum and not(@type) and @optional=$optional]"/>            
        </xsl:when>
        <xsl:when test="$matchedMethodNode/template[@kind = $memberKind and (@typeKind = $typeKind or @bitKind= $bitKind) and not(@type) and not(@enum) and @optional=$optional]">
            <xsl:value-of select="$matchedMethodNode/template[@kind = $memberKind and (@typeKind = $typeKind or @bitKind= $bitKind) and not(@type) and not(@enum) and @optional=$optional]"/>            
        </xsl:when>   
        <xsl:when test="$matchedMethodNode/template[@kind = $memberKind and not(@typeKind) and not(@bitKind) and not(@type) and not(@enum) and @optional=$optional]">
            <xsl:value-of select="$matchedMethodNode/template[@kind = $memberKind and not(@typeKind) and not(@bitKind) and not(@type) and not(@enum) and @optional=$optional]"/>                            
        </xsl:when>   
        <xsl:when test="$matchedMethodNode/template[@kind = $memberKind and @typeKind = $typeKind and @type = $type and not(@enum) and not(@optional)]">
            <xsl:value-of select="$matchedMethodNode/template[@kind = $memberKind and @typeKind = $typeKind and @type= $type and not(@enum) and not(@optional)]"/>            
        </xsl:when>        
        <xsl:when test="$matchedMethodNode/template[@kind = $memberKind and @typeKind = $typeKind and @enum = $enum and not(@type) and not(@optional)]">
            <xsl:value-of select="$matchedMethodNode/template[@kind = $memberKind and @typeKind = $typeKind and @enum= $enum and not(@type) and not(@optional)]"/>            
        </xsl:when>
        <xsl:when test="$matchedMethodNode/template[@kind = $memberKind and (@typeKind = $typeKind or @bitKind= $bitKind) and not(@type) and not(@enum) and not(@optional)]">
            <xsl:value-of select="$matchedMethodNode/template[@kind = $memberKind and (@typeKind = $typeKind or @bitKind= $bitKind) and not(@type) and not(@enum) and not(@optional)]"/>            
        </xsl:when>        
        <xsl:otherwise>
            <xsl:value-of select="$matchedMethodNode/template[@kind = $memberKind and not(@typeKind) and not(@bitKind) and not(@type) and not(@enum) and not(@optional)]"/>                            
        </xsl:otherwise>   
    </xsl:choose>        
</xsl:template>

<!-- Obtain native type given the IDL type.
     @param idlType type name in IDL
     @return native type name
-->
<xsl:template name="obtainNativeClass">
    <xsl:param name="idlType"/>         
    <xsl:variable name="typeNode" select="$typeInfoMap/class[@idlType=$idlType]"/>
    
    <xsl:choose>
        <xsl:when test="$typeNode">
        <xsl:message>Pepilloooo</xsl:message>
        <xsl:value-of select="$typeNode/@class"/></xsl:when>
        <xsl:when test="$idlType='string' or $idlType='wstring'">
            <xsl:text>String</xsl:text>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="$idlType"/></xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- 
Note: 
If we change this function it's necessary to review the criterion to declare variables at the beginning
of each Plugin function        
-->
<xsl:template name="getMemberDescription">
    <xsl:param name="member"/>
            
    <xsl:variable name="memberKind">
        <xsl:call-template name="obtainMemberKind">
            <xsl:with-param name="member" select="$member"/>
        </xsl:call-template>
    </xsl:variable>

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

    <xsl:variable name="baseEnum">
        <xsl:call-template name="isBaseEnum">
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
    </xsl:variable>
        
    <xsl:choose>
        <xsl:when test="$childMemberKind != 'sequence' and 
                        $childMemberKind != 'array' and 
                        $childMemberKind != 'arraySequence'">                
            <xsl:variable name="nativeType">
                <xsl:call-template name="obtainNativeType">
                    <xsl:with-param name="idlType" select="$baseType"/>
                </xsl:call-template>
            </xsl:variable>

            <description>
                <xsl:attribute name="type"><xsl:value-of select="$baseType"/></xsl:attribute>
                <xsl:attribute name="nativeType"><xsl:value-of select="$nativeType"/></xsl:attribute>
                <xsl:attribute name="memberKind"><xsl:value-of select="$baseMemberKind"/></xsl:attribute>                    
                <xsl:attribute name="typeKind"><xsl:value-of select="$baseTypeKind"/></xsl:attribute>                                        
                <xsl:attribute name="bitKind"><xsl:value-of select="$baseBitKind"/></xsl:attribute>
                <xsl:attribute name="isEnum"><xsl:value-of select="$baseEnum"/></xsl:attribute>
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
            </description>
        </xsl:when>
        <xsl:otherwise>                
            <xsl:variable name="nativeType">
                <xsl:call-template name="obtainNativeType">
                    <xsl:with-param name="idlType" select="$member/@type"/>
                </xsl:call-template>
            </xsl:variable>

            <description>
                <xsl:attribute name="type"><xsl:value-of select="$member/@type"/></xsl:attribute>
                <xsl:attribute name="nativeType"><xsl:value-of select="$nativeType"/></xsl:attribute>
                <xsl:attribute name="memberKind"><xsl:value-of select="$memberKind"/></xsl:attribute>
                <xsl:attribute name="typeKind"><xsl:value-of select="$typeKind"/></xsl:attribute>                                        
                <xsl:attribute name="bitKind"><xsl:value-of select="$bitKind"/></xsl:attribute>                        
                <xsl:attribute name="bitField"><xsl:value-of select="''"/></xsl:attribute>   
                <xsl:if test="$member/@enum='yes'">
                <xsl:attribute name="isEnum">yes</xsl:attribute>
                </xsl:if>
                <xsl:if test="not($member/@enum) or $member/@enum='no'">
                <xsl:attribute name="isEnum">no</xsl:attribute>
                </xsl:if>


                <xsl:if test="$member/@bitField">
                    <xsl:attribute name="bitField"><xsl:value-of select="$member/@bitField"/></xsl:attribute>                                                                                                   
                </xsl:if>                
            </description>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>    

<!-- Next template was introduced with xTypes feature.
       It's meant to retrieve the exensibility kind associated to the data type (extensible [default], mutable, final)

       MOVED TO typeCommon.xsl
-->
<!--<xsl:template name="getExtensibilityKind">                                                                                                                    -->
<!--    <xsl:param name="structName"/>                                                                                                                            -->
<!--    <xsl:param name="node"/>                                                                                                                                  -->
<!--    <xsl:param name="typeKind" select="'struct'"/>                                                                                                            -->
<!--                                                                                                                                                              -->
<!--   <xsl:choose>                                                                                                                                               -->
<!--       <xsl:when test="$typeKind='enum'">                                                                                                                     -->
<!--           <xsl:choose>                                                                                                                                       -->
<!--               <xsl:when test="$node/following-sibling::directive[@kind='Extensibility' and ./preceding-sibling::enum[@name=$structName and position()=1]]">  -->
<!--                   <xsl:value-of select="$node/following-sibling::directive[@kind='Extensibility'][1]"/>                                                      -->
<!--               </xsl:when>                                                                                                                                    -->
<!--               <xsl:otherwise>                                                                                                                                -->
<!--                   <xsl:value-of select="'EXTENSIBLE_EXTENSIBILITY'"/>                                                                                        -->
<!--               </xsl:otherwise>                                                                                                                               -->
<!--           </xsl:choose>                                                                                                                                      -->
<!--       </xsl:when>                                                                                                                                            -->
<!--       <xsl:otherwise>                                                                                                                                        -->
<!--           <xsl:choose>                                                                                                                                       -->
<!--               <xsl:when test="$node/following-sibling::directive[@kind='Extensibility' and ./preceding-sibling::struct[@name=$structName and position()=1]]">-->
<!--                   <xsl:value-of select="$node/following-sibling::directive[@kind='Extensibility'][1]"/>                                                      -->
<!--               </xsl:when>                                                                                                                                    -->
<!--               <xsl:otherwise>                                                                                                                                -->
<!--                   <xsl:value-of select="'EXTENSIBLE_EXTENSIBILITY'"/>                                                                                        -->
<!--               </xsl:otherwise>                                                                                                                               -->
<!--           </xsl:choose>                                                                                                                                      -->
<!--       </xsl:otherwise>                                                                                                                                       -->
<!--   </xsl:choose>                                                                                                                                              -->
<!--</xsl:template>                                                                                                                                               -->

<!-- 
A common template shared code generator template for struct member
This tempalte expect a template string passed in parameter 
"templateSting". Each paramter is tempalte must be bracketed using
%% as the bracket string.
-->
<xsl:template name="replace-params">
    <xsl:param name="generationMode"/>
    <xsl:param name="member"/>
    <xsl:param name="templateString"/>
    <xsl:param name="type"/>
    <xsl:param name="typeKind"/>                
    <xsl:param name="memberKind"/>                                
    <xsl:param name="bitField"/>
    <xsl:param name="discContainer"/>
    <xsl:param name="xType"/>
                          
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
            <xsl:with-param name="discContainer" select="$discContainer"/>
            <xsl:with-param name="xType" select="$xType"/>
        </xsl:call-template>
    </xsl:variable>

    <!-- Replace all occurances of template parameter with their value from
         the map just obtained -->
    <xsl:call-template name="replace-string-from-map">
        <xsl:with-param name="inputString" select="$templateString"/>
        <xsl:with-param name="replacementParamsMap" select="xalan:nodeset($memberReplacementParams)/node()"/>
    </xsl:call-template>
</xsl:template>

<!-- Template to generated code for a given member.

     This is the template that should be callied from the main
     stylesheet with correct parameter to generate code for
     each member.
     
     @param generationMode mode that should match one of those
                           in generation-info.xml (//methodInfoMap/method[@kind])
-->     
<xsl:template match="struct[not(@kind = 'union')]/member" mode="code-generation">
    <xsl:param name="generationMode"/>

    <xsl:call-template name="generateMemberCode">
        <xsl:with-param name="generationMode" select="$generationMode"/>
        <xsl:with-param name="member" select="."/>
    </xsl:call-template>
</xsl:template>

<xsl:template match="typedef/member" mode="code-generation">
    <xsl:param name="generationMode"/>

    <xsl:call-template name="generateMemberCode">
        <xsl:with-param name="generationMode" select="$generationMode"/>
        <xsl:with-param name="member" select="."/>
    </xsl:call-template>
</xsl:template>

<xsl:template match="struct[@kind = 'union']/member" mode="code-generation">
    <xsl:param name="generationMode"/>
    
    <xsl:variable name="member" select="."></xsl:variable>
    
    <xsl:variable name="discBaseType">
        <xsl:call-template name="getBaseType">
            <xsl:with-param name="member" select="../discriminator"/>        
        </xsl:call-template>        
    </xsl:variable>

    <xsl:variable name="discBaseEnum">    
        <xsl:call-template name="isBaseEnum">
            <xsl:with-param name="member" select="../discriminator"/>
        </xsl:call-template>        
    </xsl:variable>
    
    <xsl:variable name="xType">
        <xsl:call-template name="getExtensibilityKind">
            <xsl:with-param name="structName" select="../@name"/>
            <xsl:with-param name="node" select="./.."/>
        </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="needSwitch"
        select="not(($generationMode = 'structMember' or $generationMode='initialize' or 
                    $generationMode = 'get_max_size_serialized' or $generationMode = 'get_min_size_serialized') or 
                    ($xType='MUTABLE_EXTENSIBILITY' and ($generationMode='deserialize' or $generationMode='skip')))"/>   
                        
    <xsl:if test="$needSwitch">
        <!-- we use 'if' instead 'switch' because the mapping for constant and enums in Java (classes)
             is not valid where a constant expression is required -->
        <xsl:variable name="memberPosition" select="position()"/>

        <xsl:for-each select="cases/case">
            <xsl:variable name="prefix">
                <xsl:if test="$memberPosition &gt; 2 or position() &gt; 1">} else</xsl:if>                
            </xsl:variable>
            
            <xsl:choose>
                    <xsl:when test="@value='default'">
        <xsl:value-of select="$prefix"/><xsl:text> {</xsl:text>
                    </xsl:when>
                    <xsl:when test="$generationMode = 'serialize' or $generationMode = 'get_serialized_sample_size'">
        <xsl:value-of select="$prefix"/> if (typedSrc._d == (<xsl:value-of select="@value"/>)){
                    </xsl:when>
		    <xsl:when test="$generationMode = 'skip'">
        <xsl:value-of select="$prefix"/> if (disc == (<xsl:value-of select="@value"/><xsl:text>)){</xsl:text>
                    </xsl:when>
                    <xsl:when test="$generationMode = 'deserialize'">
        <xsl:value-of select="$prefix"/> if (typedDst._d == (<xsl:value-of select="@value"/>)){
                    </xsl:when>
                    <xsl:when test="$generationMode = 'equals'">
        <xsl:value-of select="$prefix"/> if (otherObj._d == (<xsl:value-of select="@value"/>)){                                
                    </xsl:when>
                    <xsl:when test="$generationMode = 'hashCode'">
        <xsl:value-of select="$prefix"/> if (_d == (<xsl:value-of select="@value"/>)){
                    </xsl:when>
                    <xsl:otherwise>
        <xsl:value-of select="$prefix"/> if (_d == (<xsl:value-of select="@value"/>)){                                
                    </xsl:otherwise>
            </xsl:choose>
            <xsl:call-template name="generateMemberCode">
                <xsl:with-param name="generationMode" select="$generationMode"/>
                <xsl:with-param name="member" select="$member"/>
            </xsl:call-template>            
        </xsl:for-each>
        <xsl:if test="position()=last()">                                                        
            <xsl:text>}</xsl:text>
        </xsl:if>                        
    </xsl:if>
    <xsl:if test="not($needSwitch)">
        <xsl:call-template name="generateMemberCode">
            <xsl:with-param name="generationMode" select="$generationMode"/>
            <xsl:with-param name="member" select="$member"/>
        </xsl:call-template>                    
    </xsl:if>
                
</xsl:template>

<!-- Template for generating Members code -->
<xsl:template name="generateMemberCode">
    <xsl:param name="generationMode"/>
    <xsl:param name="member"/>
    <xsl:param name="discContainer" select="''"/>
    
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
        
    <xsl:variable name="tmpGenerationMode">
        <xsl:choose>
    	    <xsl:when test="$generationMode='serialize_key'">serialize</xsl:when>
    	    <xsl:when test="$generationMode='deserialize_key'">deserialize</xsl:when>
    	    <xsl:when test="$generationMode='get_max_size_serialized_key'">get_max_size_serialized</xsl:when>
    	    <xsl:when test="$generationMode='serialized_sample_to_key'">deserialize</xsl:when>
    	    <xsl:otherwise> <xsl:value-of select="$generationMode"/></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="memberOptionalAndNonUnion">
        <xsl:choose>
            <xsl:when test="$member/@optional='true' and $member/../@kind != 'union'">true</xsl:when>
            <xsl:otherwise>false</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>    

    <!-- we don't generate code for bitfield fields without name -->
    <xsl:if test="not ($descriptionNode/@memberKind='bitfield' and $member/@name = '')">        
        
    <!-- Select template string. -->                         
    <xsl:variable name="templateString">                
        <xsl:call-template name="getTemplateString">
            <xsl:with-param name="generationMode" select="$tmpGenerationMode"/>
            <xsl:with-param name="memberKind" select="$descriptionNode/@memberKind"/>
            <xsl:with-param name="bitKind" select="$descriptionNode/@bitKind"/>                    
            <xsl:with-param name="typeKind" select="$descriptionNode/@typeKind"/>                    
            <xsl:with-param name="type" select="$descriptionNode/@type"/>
            <xsl:with-param name="enum" select="$descriptionNode/@isEnum"/>
            <xsl:with-param name="optional" select="$member/@optional"/>            
        </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="needExtendedParameterId">
        <xsl:call-template name="needExtendedParameterId">
            <xsl:with-param name="member" select="$member"/>
            <xsl:with-param name="baseMemberKind" select="$descriptionNode/@memberKind"/>
            <xsl:with-param name="baseTypeKind" select="$descriptionNode/@typeKind"/>
        </xsl:call-template>
    </xsl:variable>
    
    <xsl:if test="$memberOptionalAndNonUnion = 'true'">
        <xsl:if test="$generationMode='hashCode' or $generationMode='print'">
            <xsl:text>        if (</xsl:text> 
            <xsl:value-of select="$member/@name"/>
            <xsl:text> != null) {&nl;</xsl:text>
        </xsl:if>
        <xsl:if test="$generationMode='equals'">
            <xsl:text>        if ((</xsl:text> 
            <xsl:value-of select="$member/@name"/>
            <xsl:text> == null &amp;&amp; otherObj.</xsl:text>
            <xsl:value-of select="$member/@name"/>
            <xsl:text> != null) ||&nl;</xsl:text>
            <xsl:text>                (</xsl:text>
            <xsl:value-of select="$member/@name"/>
            <xsl:text> != null &amp;&amp; otherObj.</xsl:text>
            <xsl:value-of select="$member/@name"/>
            <xsl:text> == null)) {&nl;</xsl:text>
            <xsl:text>            return false;&nl;</xsl:text>
            <xsl:text>        }&nl;</xsl:text>
            <xsl:text>        if (</xsl:text> 
            <xsl:value-of select="$member/@name"/>
            <xsl:text> != null) {&nl;</xsl:text>
        </xsl:if>
    </xsl:if>
    
    <xsl:if test="$generationMode='serialize' or $generationMode='serialize_key'">
        <xsl:if test="$memberOptionalAndNonUnion = 'true' and $xType='MUTABLE_EXTENSIBILITY'">
            <xsl:text>            if (typedSrc.</xsl:text>
            <xsl:value-of select="$member/@name"/>
            <xsl:text> != null) {&nl;</xsl:text>
        </xsl:if>

        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY' or $memberOptionalAndNonUnion = 'true'">
            <xsl:text>            memberId = </xsl:text>
            <xsl:value-of select="$member/@memberId" />
            <xsl:text>;&nl;</xsl:text> 
            <xsl:choose>
                <xsl:when test="$needExtendedParameterId = 'yes'">
                    <xsl:text>            </xsl:text>
                    <xsl:text>memberLengthPosition = dst.writeMemberId((int)memberId);&nl;</xsl:text>
                </xsl:when>
                <xsl:when test="$needExtendedParameterId = 'no'">
                    <xsl:text>            </xsl:text>
                    <xsl:text>memberLengthPosition = dst.writeMemberId((short)memberId);&nl;</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>            </xsl:text>
                    <xsl:text>if (dst.useExtendedMemberId == true) {&nl;</xsl:text>
                    <xsl:text>            </xsl:text>
                    <xsl:text>memberLengthPosition = dst.writeMemberId((int)memberId);&nl;</xsl:text>
                    <xsl:text>            </xsl:text>
                    <xsl:text>} else {&nl;</xsl:text>
                    <xsl:text>            </xsl:text>
                    <xsl:text>memberLengthPosition = dst.writeMemberId((short)memberId);&nl;</xsl:text>
                    <xsl:text>            </xsl:text>
                    <xsl:text>}&nl;</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        
        <xsl:if test="$memberOptionalAndNonUnion = 'true' and $xType!='MUTABLE_EXTENSIBILITY'">
            <xsl:text>            if (typedSrc.</xsl:text>
            <xsl:value-of select="$member/@name"/>
            <xsl:text> != null) {&nl;</xsl:text>
        </xsl:if>
    </xsl:if>  

    <xsl:variable name="memberName" select="$member/@name"/>
    <xsl:variable name="currentMemberId" select="$member/@memberId" />

    <xsl:if test="$generationMode='deserialize' or $generationMode='skip' or $generationMode='deserialize_key' or $generationMode='serialized_sample_to_key'">
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
           <xsl:for-each select="$member/../node()[name()='member' or name()='discriminator']">
               <xsl:if test="@memberId = $currentMemberId and @name != $memberName">
                   <xsl:message terminate="yes"> Error! <xsl:value-of select="@name" /> member does not have a unique Id
                   </xsl:message>
               </xsl:if>
               <xsl:if test="@name = $memberName">
                   <xsl:text>
                case </xsl:text><xsl:value-of select="./@memberId" /><xsl:text>:</xsl:text>
               </xsl:if>
           </xsl:for-each>
       </xsl:if>
    </xsl:if>
    
    <xsl:if test="$generationMode='deserialize' or $generationMode='skip'">
        <xsl:if test="$xType!='MUTABLE_EXTENSIBILITY' and $memberOptionalAndNonUnion = 'true'">
            <xsl:text>
            memberInfo = src.readMemberInfo();
            tmpPosition = src.getBuffer().currentPosition();
            tmpSize = src.getBuffer().getSize();
            tmpLength = memberInfo.length;
            src.getBuffer().setDesBufferSize((int)(tmpPosition + memberInfo.length));

            if (tmpLength > 0) {
            </xsl:text>
        </xsl:if>
    </xsl:if>

    <xsl:if test="$xType='MUTABLE_EXTENSIBILITY' or $memberOptionalAndNonUnion = 'true'"> 
        <xsl:if test="$generationMode='get_max_size_serialized' or
                      $generationMode='get_max_size_serialized_key'">
            <xsl:text>    currentAlignment += (CdrPrimitiveType.getPadSize(currentAlignment, 4) + 12);&nl;</xsl:text>
        </xsl:if>
        
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY' and 
                      $memberOptionalAndNonUnion = 'true' and 
                      $generationMode='get_serialized_sample_size'">
            <xsl:text>        if (typedSrc.</xsl:text>
            <xsl:value-of select="$member/@name"/>
            <xsl:text> != null) {&nl;</xsl:text>
        </xsl:if>
    
        <xsl:if test="$generationMode='get_min_size_serialized' or 
                      $generationMode='get_serialized_sample_size'">
            <xsl:if test="$generationMode!='get_min_size_serialized' or
                          not($xType='MUTABLE_EXTENSIBILITY' and $memberOptionalAndNonUnion = 'true')">
                <xsl:if test="$needExtendedParameterId = 'yes' or $needExtendedParameterId = 'maybe'">
                    <xsl:text>    currentAlignment += (CdrPrimitiveType.getPadSize(currentAlignment, 4) + 12);&nl;</xsl:text>
                </xsl:if>
                <xsl:if test="$needExtendedParameterId = 'no'">
                    <xsl:text>    currentAlignment += (CdrPrimitiveType.getPadSize(currentAlignment, 4) + 4);&nl;</xsl:text>
                </xsl:if>
            </xsl:if>
        </xsl:if>

        <xsl:if test="$xType!='MUTABLE_EXTENSIBILITY' and 
                      $memberOptionalAndNonUnion = 'true' and 
                      $generationMode='get_serialized_sample_size'">
            <xsl:text>        if (typedSrc.</xsl:text>
            <xsl:value-of select="$member/@name"/>
            <xsl:text> != null) {&nl;</xsl:text>
        </xsl:if>
    </xsl:if>
         
    <xsl:if test="($generationMode!='get_min_size_serialized' or
                  not($memberOptionalAndNonUnion = 'true')) and
                  not($generationMode='initialize' and $memberOptionalAndNonUnion = 'true')">
            <xsl:call-template name="replace-params">
                <xsl:with-param name="generationMode" select="$generationMode"/>            
                <xsl:with-param name="member" select="$member"/>            
                <xsl:with-param name="templateString" select="$templateString"/>        
                <xsl:with-param name="type" select="$descriptionNode/@type"/>
                <xsl:with-param name="typeKind" select="$descriptionNode/@typeKind"/>                
                <xsl:with-param name="memberKind" select="$descriptionNode/@memberKind"/>                                
                <xsl:with-param name="bitField" select="$descriptionNode/@bitField"/>
                <xsl:with-param name="discContainer" select="$discContainer"/>
                <xsl:with-param name="xType" select="$xType"/>
            </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$memberOptionalAndNonUnion = 'true' and 
                  $generationMode='get_serialized_sample_size'">
        <xsl:text>&nl;}&nl;</xsl:text>
    </xsl:if>
    
    <xsl:if test="$generationMode='deserialize' or $generationMode='skip'">
        <xsl:if test="$xType!='MUTABLE_EXTENSIBILITY' and $memberOptionalAndNonUnion='true'">
            <xsl:text>
            }</xsl:text> 
            <xsl:if test="$generationMode='deserialize'">
            <xsl:text>
            else {
                typedDst.</xsl:text><xsl:value-of select="$member/@name"/><xsl:text> = null;
            }
            </xsl:text>
            </xsl:if>
            <xsl:text>            
            src.getBuffer().setDesBufferSize(tmpSize);
            src.getBuffer().setCurrentPosition((int)(tmpPosition + tmpLength));
            </xsl:text>
        </xsl:if>
    </xsl:if>
    
    <xsl:if test="$generationMode='serialize' or $generationMode='serialize_key'">
        <xsl:if test="$memberOptionalAndNonUnion='true' and $xType!='MUTABLE_EXTENSIBILITY'">
            <xsl:text>&nl;</xsl:text>
            <xsl:text>            </xsl:text>
            <xsl:text>}&nl;</xsl:text>
        </xsl:if>         
    
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY' or
                      ($xType!='MUTABLE_EXTENSIBILITY' and $memberOptionalAndNonUnion='true')">
            <xsl:text>            </xsl:text>
            <xsl:choose>
                <xsl:when test="$needExtendedParameterId = 'yes'">
                    <xsl:text>dst.writeMemberLength(memberLengthPosition, true);&nl;</xsl:text>
                </xsl:when>
                <xsl:when test="$needExtendedParameterId = 'no'">
                    <xsl:text>dst.writeMemberLength(memberLengthPosition, false);&nl;</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>if (dst.useExtendedMemberId == true) {&nl;</xsl:text>
                    <xsl:text>            </xsl:text>
                    <xsl:text>    dst.writeMemberLength(memberLengthPosition, true);&nl;</xsl:text>
                    <xsl:text>            </xsl:text>
                    <xsl:text>} else {&nl;</xsl:text>
                    <xsl:text>            </xsl:text>
                    <xsl:text>    dst.writeMemberLength(memberLengthPosition, false);&nl;</xsl:text>
                    <xsl:text>            </xsl:text>
                    <xsl:text>}&nl;</xsl:text>
                </xsl:otherwise>
             </xsl:choose>
         </xsl:if>
         <xsl:if test="$memberOptionalAndNonUnion='true' and $xType='MUTABLE_EXTENSIBILITY'">
             <xsl:text>&nl;</xsl:text>
             <xsl:text>            </xsl:text>
             <xsl:text>}&nl;</xsl:text>
         </xsl:if>         
    </xsl:if>

    <xsl:if test="$generationMode='deserialize' or $generationMode='skip'  or $generationMode='deserialize_key' or $generationMode='serialized_sample_to_key'">
            <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> 
            <xsl:text>break;</xsl:text>
            </xsl:if>
         </xsl:if>

    <xsl:if test="$memberOptionalAndNonUnion='true'">
        <xsl:text>&nl;</xsl:text>
        <xsl:if test="$generationMode='hashCode' or $generationMode='equals'">
            <xsl:text>        }&nl;</xsl:text> 
        </xsl:if> 
        <xsl:if test="$generationMode='print'">
            <xsl:text>        } else {&nl;</xsl:text>
            <xsl:text>            </xsl:text>
            <xsl:text>CdrHelper.printIndent(strBuffer, indent+1);&nl;</xsl:text>
            <xsl:text>            </xsl:text>
            <xsl:text>strBuffer.append("</xsl:text>
            <xsl:value-of select="$member/@name"/>
            <xsl:text>: null\n");&nl;</xsl:text>
            <xsl:text>        }&nl;</xsl:text>            
        </xsl:if>
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

<!-- Obtain array dimenstion declaraiton to use in declaring array. For example, for two dimensional array,
     this will return "[][]".
     @param cardinality a <cardinality> element with dimension as child. See schema in simplifyIDLXML.xsl
     @return a string of form [][]
-->
<xsl:template name="obtainArrayDimensionsDeclaration">
    <xsl:param name="cardinality"/>
    <xsl:for-each select="$cardinality/dimension">[]</xsl:for-each>
</xsl:template>

<!-- Obtain "for" loop (pre-part) to serialize/deserialize/print array elements
     @param cardinality a <cardinality> element with dimension as child. See schema in simplifyIDLXML.xsl
     @return a string of form for(int i1__ = 0; i1__ < <dim>; ++i1__) {
                              for(int i2__ = 0; i2__ < <dim>; ++i2__) {
                              ...
-->
<xsl:template name="obtainArrayForLoopPre">
    <xsl:param name="cardinality"/>
    <xsl:param name="includeLastDimension" select="1"/>
    <xsl:for-each select="$cardinality/dimension">
        <xsl:if test="($includeLastDimension = 1) or (position() != last())">
            <xsl:variable name="loopVar">i<xsl:value-of select="position()"/>__</xsl:variable>
        for(int <xsl:value-of select="$loopVar"/> = 0; <xsl:value-of select="$loopVar"/> &lt; <xsl:value-of select="@size"/>; ++<xsl:value-of select="$loopVar"/>) {
        </xsl:if>
    </xsl:for-each>
</xsl:template>

<!-- Obtain "for" loop (post-part) to serialize/deserialize/print array elements
     @param cardinality a <cardinality> element with dimension as child. See schema in simplifyIDLXML.xsl
     @return a string of form }
                              }
                              ...
-->
<xsl:template name="obtainArrayForLoopPost">
    <xsl:param name="cardinality"/>
    <xsl:param name="includeLastDimension" select="1"/>
    <xsl:for-each select="$cardinality/dimension">
        <xsl:if test="($includeLastDimension = 1) or (position() != last())">
        }
        </xsl:if>
    </xsl:for-each>
</xsl:template>


<!-- Obtain string to point to the current array element (see "obtainArrayForLoopPre" template)

     @param cardinality a <cardinality> element with dimension as child. See schema in simplifyIDLXML.xsl
     @return a string of form [i1__][i2__]...
-->
<xsl:template name="obtainArrayCurrentElement">
    <xsl:param name="cardinality"/>
    <xsl:param name="includeLastDimension" select="1"/>
    <xsl:for-each select="$cardinality/dimension">
        <xsl:if test="position()!=last() or $includeLastDimension=1">
            <xsl:text>[i</xsl:text><xsl:value-of select="position()"/><xsl:text>__]</xsl:text>
        </xsl:if>
    </xsl:for-each>
</xsl:template>

<!-- -->
<xsl:template name="obtainArrayCurrentElementToPrint">
    <xsl:param name="cardinality"/>
    <xsl:for-each select="$cardinality/dimension">
        <xsl:if test="position()!=last()">"["+Integer.toString(i<xsl:value-of select="position()"/>__)+"]"+</xsl:if>
        <xsl:if test="position()=last()">"["+Integer.toString(i<xsl:value-of select="position()"/>__)+"]"</xsl:if>    
    </xsl:for-each>        
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

<!-- Obtain the copy method. This template is only intended for use under the
     following conditions, kind=scalar|array and typeKind=user. It exists since
     these conditions cannot be directly accounted for in generation-info.java.xml.
     The basic difference to be accounted for is whether or not the <code>Copyable</code>
     interface is used.
     @param member The member which this copy method will be generated.
     @param cardinalityCurrentElement The cardinality for the current elemnent (used for arrays).
     @param type The type of member (scalar or array)
     @return The copy method as a string.
-->
<xsl:template name="obtainCopyMethod">
    <xsl:param name="member"/>
    <xsl:param name="cardinalityCurrentElement"/>
    <xsl:param name="type"/>
        
    <xsl:variable name="name">
        <xsl:choose>
            <xsl:when test="name($member/..) = 'typedef'">
                <xsl:text>userData</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$member/@name"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="kind">
        <xsl:call-template name="obtainMemberKind">
            <xsl:with-param name="member" select="$member"/>
        </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="copyMethod">
        <xsl:choose>
            <xsl:when test="$useCopyable = 'true'">
                <xsl:text>typedDst.</xsl:text><xsl:value-of select="$name"/>
                <xsl:choose>
                    <xsl:when test="$kind = 'array'">
                        <xsl:value-of select="$cardinalityCurrentElement"/>
                        <xsl:text>.copy_from(typedSrc.</xsl:text>
                        <xsl:value-of select="$name"/><xsl:value-of select="$cardinalityCurrentElement"/>
                        <xsl:text>)</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>.copy_from(typedSrc.</xsl:text>
                        <xsl:value-of select="$name"/><xsl:text>)</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$type"/><xsl:text>TypeSupport.get_instance()</xsl:text>
                <xsl:choose>
                    <xsl:when test="$kind = 'array'">
                        <xsl:text>.copy_data(typedDst.</xsl:text>
                        <xsl:value-of select="$name"/><xsl:value-of select="$cardinalityCurrentElement"/>
                        <xsl:text>,</xsl:text>
                        <xsl:text>typedSrc.</xsl:text><xsl:value-of select="$name"/><xsl:value-of select="$cardinalityCurrentElement"/>
                        <xsl:text>)</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>.copy_data(typedDst.</xsl:text>
                        <xsl:value-of select="$name"/>
                        <xsl:text>, typedSrc.</xsl:text>
                        <xsl:value-of select="$name"/>
                        <xsl:text>)</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <!-- the result of the template is stored in a variable for easy debugging -->
    <xsl:value-of select="$copyMethod"/>
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
    <xsl:param name="discContainer"/>
    <xsl:param name="xType"/>
    
    <xsl:variable name="matchedTypeNode" select="$typeInfoMap/type[@idlType=$type]"/>
    
    <xsl:variable name="baseType">
        <xsl:call-template name="getBaseType">
            <xsl:with-param name="member" select="$structMember"/>
        </xsl:call-template>                     
    </xsl:variable>

    <member-param name="{$structMember/@name}" rawName="{$structMember/@name}" 
                  idlType="{$type}"
                  userDataAccess="typedDst.">
        
        <xsl:choose>
            <xsl:when test="$xType='MUTABLE_EXTENSIBILITY' or 
                            ($structMember/@optional='true' and $structMember/../@kind != 'union')">
                <xsl:attribute name="currentAlignment"><xsl:value-of select="'0'"/></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="currentAlignment"><xsl:value-of select="'currentAlignment'"/></xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:attribute name="maxSerializeLeading"><xsl:value-of select="'currentAlignment += '"/></xsl:attribute>
        <xsl:attribute name="maxSerializeTrailing"><xsl:value-of select="''"/></xsl:attribute>    
        <xsl:attribute name="minSerializeLeading"><xsl:value-of select="'currentAlignment += '"/></xsl:attribute>
        <xsl:attribute name="minSerializeTrailing"><xsl:value-of select="''"/></xsl:attribute>    

        <!-- For unions, override some of the attributes as follows:
             Leading and trailing string for getMaxSizeSerialize method's template is changed to allow 
               calculating maximum size amond union fields.
        -->
        <xsl:if test="$structMember/../@kind = 'union' and not($structMember/@uniondisc)">
            <xsl:attribute name="maxSerializeLeading"><xsl:value-of select="'maxSerialized = Math.max('"/></xsl:attribute>
            <xsl:attribute name="maxSerializeTrailing"><xsl:value-of select="', maxSerialized)'"/></xsl:attribute>        
            <xsl:attribute name="minSerializeLeading"><xsl:value-of select="'minSerialized = Math.min('"/></xsl:attribute>
            <xsl:attribute name="minSerializeTrailing"><xsl:value-of select="', minSerialized)'"/></xsl:attribute>        
        </xsl:if>
        
        <xsl:if test="$structMember/../@kind = 'union'">                                                                                                                        
            <xsl:if test="$structMember/@uniondisc">
                <xsl:if test="$discContainer = ''">
                    <xsl:attribute name="name">_d</xsl:attribute>                                                                                
                </xsl:if>
                <xsl:if test="$discContainer != ''">
                    <xsl:attribute name="userDataAccess"/>
                    <xsl:attribute name="name">
                        <xsl:value-of select="$discContainer"/>
                    </xsl:attribute>                          
                </xsl:if>
            </xsl:if>
        </xsl:if>
                
        <!-- For typedefs, override the userDataAccess attribute so that the virtual
             member of a typedef points to the self. i.e. when generatting code to
             delegate each plugin method parameter passed to delegatee method
             should point to the delegator itself. This will lead to generate code
             such as:
             serializeTypedefedType(TypedefedType* userData,....) {
                 serializeOrignalType(userData,...
             }
             
             As opposed to code for structures which would look like:
             serializeStructType(TypedefedType* userData,....) {
                 serializeMemberType(userData->member1,...
             }
        -->             
        <xsl:if test="name($structMember/..) = 'typedef'">
            <xsl:attribute name="rawName">userData</xsl:attribute>            
            <xsl:attribute name="name">userData</xsl:attribute>                        
        </xsl:if>        
        
        <xsl:choose>
            <xsl:when test="$matchedTypeNode">
                <!-- For builtin types, just copy over all the attributes of the matchedTypeNode,
                     since the attribute name in that map (must) match the template parameter strings -->
                <xsl:copy-of select="$matchedTypeNode/@*"/>                
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="nativeType"><xsl:value-of select="$type"/></xsl:attribute>
                <xsl:attribute name="class"><xsl:value-of select="$type"/></xsl:attribute>
                <xsl:attribute name="nativeTypeSeq"><xsl:value-of select="$type"/>Seq</xsl:attribute>
                <xsl:attribute name="elementSerializeMethod">
		    <xsl:choose>
			<xsl:when test="$generationMode='serialize_key'">serialize_key</xsl:when>
			<xsl:otherwise>serialize</xsl:otherwise>
		    </xsl:choose>
		</xsl:attribute>
                <xsl:attribute name="arraySerializeMethod">RTICdrStream_serializeNonPrimitiveArray</xsl:attribute>
                <xsl:attribute name="sequenceSerializeMethod">RTICdrStream_serializeNonPrimitiveSequence</xsl:attribute>                
                <xsl:attribute name="elementDeserializeMethod">
		    <xsl:choose>
                        <xsl:when test="$generationMode='serialized_sample_to_key'">serialized_sample_to_key</xsl:when>
			<xsl:when test="$generationMode='deserialize_key'">deserialize_key_sample</xsl:when>
			<xsl:otherwise>deserialize_sample</xsl:otherwise>
		    </xsl:choose>
		</xsl:attribute>
                <xsl:attribute name="arrayDeserializeMethod">RTICdrStream_deserializeNonPrimitiveArray</xsl:attribute>
                <xsl:attribute name="sequenceDeserializeMethod">RTICdrStream_deserializeNonPrimitiveSequence</xsl:attribute>                                
                <xsl:attribute name="elementPrintMethod"><xsl:value-of select="$type"/>Plugin_print</xsl:attribute>
                <xsl:attribute name="elementInitMethod"><xsl:value-of select="$type"/>Plugin_initInstance</xsl:attribute>
                <xsl:attribute name="arrayInitMethod"><xsl:value-of select="$type"/>Plugin_initInstanceArray</xsl:attribute>
                <xsl:attribute name="elementFinalizeMethod"><xsl:value-of select="$type"/>Plugin_finalizeInstance</xsl:attribute>
                <xsl:attribute name="arrayFinalizeMethod"><xsl:value-of select="$type"/>Plugin_finalizeInstanceArray</xsl:attribute>                
                <xsl:attribute name="elementSize"><xsl:value-of select="$type"/>Plugin_size</xsl:attribute>
                <xsl:attribute name="elementSizeMethod">				    
		    <xsl:choose>
                        <xsl:when test="$generationMode='get_min_size_serialized'">get_serialized_sample_min_size</xsl:when>
			<xsl:when test="$generationMode='get_max_size_serialized_key'">get_serialized_key_max_size</xsl:when>
			<xsl:otherwise>get_serialized_sample_max_size</xsl:otherwise>
		    </xsl:choose>
		</xsl:attribute>                
                <xsl:attribute name="arraySizeMethod">RTICdrType_getNonPrimitiveArrayMaxSizeSerialized</xsl:attribute>                
                <xsl:attribute name="sequenceSizeMethod">RTICdrType_getNonPrimitiveSequenceMaxSizeSerialized</xsl:attribute>                
            </xsl:otherwise>
        </xsl:choose>

        <!-- Now set parameter common to builtin/user type: array dimension, array sizes, sequence and string lengths -->
        <xsl:variable name="cardinality">
            <xsl:call-template name="getBaseCardinality">
                <xsl:with-param name="member" select="$structMember"/>        
            </xsl:call-template>                
        </xsl:variable>
        
        <xsl:variable name="cardinalityNode" select="xalan:nodeset($cardinality)/node()"/>        
        
        <xsl:attribute name="cardinality">
            <xsl:call-template name="obtainArrayDimensions"><xsl:with-param name="cardinality" select="$cardinalityNode"/></xsl:call-template>
        </xsl:attribute>

        <xsl:attribute name="cardinalityDeclaration">
            <xsl:call-template name="obtainArrayDimensionsDeclaration"><xsl:with-param name="cardinality" select="$cardinalityNode"/></xsl:call-template>            
        </xsl:attribute>

        <xsl:attribute name="cardinalityArrayForLoopPre">
            <xsl:call-template name="obtainArrayForLoopPre"><xsl:with-param name="cardinality" select="$cardinalityNode"/></xsl:call-template>            
        </xsl:attribute>

        <xsl:attribute name="cardinalityArrayForLoopMinus1Pre">
            <xsl:call-template name="obtainArrayForLoopPre">
                <xsl:with-param name="cardinality" select="$cardinalityNode"/>
                <xsl:with-param name="includeLastDimension" select="0"/>
            </xsl:call-template>            
        </xsl:attribute>

        <xsl:attribute name="cardinalityArrayForLoopPost">
            <xsl:call-template name="obtainArrayForLoopPost"><xsl:with-param name="cardinality" select="$cardinalityNode"/></xsl:call-template>            
        </xsl:attribute>

        <xsl:attribute name="cardinalityArrayForLoopMinus1Post">
            <xsl:call-template name="obtainArrayForLoopPost">
                <xsl:with-param name="cardinality" select="$cardinalityNode"/>
                <xsl:with-param name="includeLastDimension" select="0"/>
            </xsl:call-template>            
        </xsl:attribute>
        
        <!-- keeping a variable for this since it is used later in this template -->
        <xsl:variable name="cardinalityCurrentElement">
            <xsl:call-template name="obtainArrayCurrentElement"><xsl:with-param name="cardinality" select="$cardinalityNode"/></xsl:call-template>                    
        </xsl:variable>

        <xsl:variable name="cardinalityCurrentElementMinus1">
            <xsl:call-template name="obtainArrayCurrentElement">
                <xsl:with-param name="cardinality" select="$cardinalityNode"/>
                <xsl:with-param name="includeLastDimension" select="0"/>
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:attribute name="cardinalityCurrentElement">
            <xsl:value-of select="$cardinalityCurrentElement"/>
        </xsl:attribute>        

        <xsl:attribute name="cardinalityCurrentElementMinus1">
            <xsl:value-of select="$cardinalityCurrentElementMinus1"/>
        </xsl:attribute>        
        
        <xsl:attribute name="cardinalityCurrentElementToPrint"> <!-- Used for the print templates for arrays -->
            <xsl:call-template name="obtainArrayCurrentElementToPrint"><xsl:with-param name="cardinality" select="$cardinalityNode"/></xsl:call-template>                    
        </xsl:attribute>        
                
        <xsl:attribute name="multiDimensionalArraySize">
            <xsl:call-template name="obtainTotalSize"><xsl:with-param name="cardinality" select="$cardinalityNode"/></xsl:call-template>
        </xsl:attribute>
        
        <xsl:attribute name="copyMethod">
            <xsl:call-template name="obtainCopyMethod">
                <xsl:with-param name="member" select="$structMember"/>
                <xsl:with-param name="cardinalityCurrentElement" select="$cardinalityCurrentElement"/>
                <xsl:with-param name="type" select="$type"/>
            </xsl:call-template>
        </xsl:attribute>
        
        <xsl:if test="$bitField != ''">
            <xsl:attribute name ="bits"><xsl:value-of select="$bitField"/></xsl:attribute>
        </xsl:if>

        <xsl:if test="$type = 'string' or $type = 'wstring'">            
            <xsl:variable name="stringLength">
                <xsl:call-template name="getBaseStringLength">
                    <xsl:with-param name="member" select="$structMember"/>    
                </xsl:call-template>                                        
            </xsl:variable>
            <xsl:attribute name="stringMaxLength">(<xsl:value-of select="$stringLength"/>)</xsl:attribute>                        
        </xsl:if>

        <xsl:if test="$memberKind = 'sequence' or $memberKind = 'arraySequence'">
            <xsl:variable name="sequenceLength">
                <xsl:call-template name="getBaseSequenceLength">
                    <xsl:with-param name="member" select="$structMember"/>
                </xsl:call-template>                                        
            </xsl:variable>
            <xsl:attribute name="sequenceMaxLength">(<xsl:value-of select="$sequenceLength"/>)</xsl:attribute>                        
        </xsl:if>
        
    </member-param>
</xsl:template>

<!-- -->
<xsl:template name="printPackageStatement">
    <xsl:param name="containerNamespace"/>
    <xsl:param name="printText" select="1"/>
    <xsl:if test="$printText=1">
/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from <xsl:value-of select="$idlFileBaseName"/>.idl using "rtiddsgen".
  The rtiddsgen tool is part of the <xsl:value-of select="$coreProduct"/> distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the <xsl:value-of select="$coreProduct"/> manual.
*/
    </xsl:if>
    <xsl:variable name="package" 
                  select="substring($containerNamespace, 0, string-length($containerNamespace))"/>
    
    <xsl:choose>
        <xsl:when test="$packagePrefix">
package <xsl:value-of select="$packagePrefix"/><xsl:if test="$package">.<xsl:value-of select="$package"/></xsl:if>;
        </xsl:when>
        <xsl:when test="$package">
package <xsl:if test="$packagePrefix"><xsl:value-of select="$packagePrefix"/>.</xsl:if><xsl:value-of select="$package"/>;
        </xsl:when>
    </xsl:choose>
</xsl:template>


<!-- The generated Java code is split into several files delimited with
     <file> elements. Any stylesheet-generated content not contained within
     a <file> element will be lost. File delimiters are generated for types
     (and other IDL elements like global constants that are represented as
     Java types); the purpose of this template is to force the code generated
     from top-level IDL elements that are not types to be pulled into the
     file(s) generated for types.

     Because this template is invoked by all templates generating <file>
     elements, the effect will be to include all "global" generated code in
     every file generated from the same IDL file. -->
<xsl:template name="processGlobalElements">
    <xsl:param name="element"/> <!-- specification, module, enum, typedef, struct, const and module -->
    <xsl:param name="following" select="'no'"/> 

    <xsl:variable name="fileElements" select="'enum, typedef, struct, const, module'"/>
            
    <xsl:choose>
        <xsl:when test="name($element/..) = 'specification'">                
            <xsl:if test="$following='no'">
                <xsl:apply-templates select="$element/preceding-sibling::node()[not(contains($fileElements, name()))]"/>
            </xsl:if>
            <xsl:if test="$following='yes'">                
                <xsl:apply-templates select="$element/following-sibling::node()[not(contains($fileElements, name()))]"/>
            </xsl:if>          
        </xsl:when>
        <xsl:otherwise>                
            <xsl:if test="$following='no'">
                <xsl:call-template name="processGlobalElements">
                    <xsl:with-param name="element" select="$element/.."/>
                </xsl:call-template>                                
                <xsl:apply-templates select="$element/preceding-sibling::node()[not(contains($fileElements, name()))]"/>
            </xsl:if>
            <xsl:if test="$following='yes'">
                <xsl:apply-templates select="$element/following-sibling::node()[not(contains($fileElements, name()))]"/>
                <xsl:call-template name="processGlobalElements">
                    <xsl:with-param name="element" select="$element/.."/>
                    <xsl:with-param name="following" select="$following"/>
                </xsl:call-template>                                                
            </xsl:if>            
        </xsl:otherwise>
    </xsl:choose>   
</xsl:template>


<xsl:template name="obtainSourceFileName">
    <xsl:param name="containerNamespace"/>
    <xsl:param name="typeName"/>

    <xsl:variable name="packageDir" select="translate($containerNamespace, '.', '/')"/>
    
    <xsl:variable name="dir">
        <xsl:choose>
            <xsl:when test="$packagePrefix">
            <xsl:variable name="packagePrefixDir" select="translate($packagePrefix, '.', '/')"/>
                <xsl:value-of select="concat($packagePrefixDir, '/', $packageDir)"/>            
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$packageDir"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:value-of select="concat($dir, $typeName, '.java')"/>

</xsl:template>

<!--
Process directives (next 2 <xsl:template> rules)

Only the templates with no specified mode are common to all generated files.
The "code-generation" mode is specific to the <type>.java file, so templates
for that mode can be found in type.java.xsl.
-->
<xsl:template match="directive[@kind = 'copy' or @kind = 'copy-java']">
<xsl:text>&nl;</xsl:text><xsl:value-of select="text()"/>
</xsl:template>

<xsl:template match="directive[@kind = 'copy' or @kind = 'copy-java']" mode="code-generation">
<xsl:text>&nl;</xsl:text><xsl:value-of select="text()"/>
</xsl:template>

<xsl:template match="directive[@kind = 'copy-java-begin']" mode="code-generation-begin">
    <xsl:param name="associatedType"/>

    <xsl:if test="(./following-sibling::node()[name(.) != 'directive'])[1]/@name = $associatedType/@name">
<xsl:text>&nl;</xsl:text><xsl:value-of select="text()"/>
    </xsl:if>
</xsl:template>

</xsl:stylesheet>

