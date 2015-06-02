<?xml version="1.0"?>
<!--
   $Id: typeCommon.ada.xsl,v 1.3 2012/04/23 16:44:18 fernando Exp $

   (c) Copyright 2007, Real-Time Innovations, Inc.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.

Modification history
 - - - - - - - - - -
10o,25aug10,eys Fixed array spacing
10o,25aug10,fcs Pointer support
10o,25aug10,fcs Multidimensional array support for strings
10o,24aug10,fcs Multidimensional array support
10o,24aug10,fcs Added begin directive
10o,20nov07,fcs Union support based on C layout
10o,29nov07,fcs 11/29/07 Merge changes
10o,12nov07,fcs Fixed obtainSourceFileName for files without typeName
10o,09jul07,fcs Second review changes
10o,07jul07,fcs obtainSourceFileName converts to lower case
10o,06jul07,rbw Fixed auto-generated warning
10o,05jul07,fcs Support for unions
10o,05jul07,fcs Continue ADA migration
10o,03jul07,fcs Fixed obtainSourceFileName template
10o,03jul07,rbw Added utilities to help generate code into multiple files
10o,03jul07,rbw Created based on C version
-->

<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!-- new line -->
<!ENTITY indent "   ">              <!-- indentation -->
<!ENTITY namespaceSeperator ".">    <!-- namespace separator -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:xalan = "http://xml.apache.org/xalan">

<xsl:include href="utils.xsl"/>

<xsl:variable name="idlFileBaseName" select="/specification/@idlFileName"/>
<xsl:variable name="generationInfo" select="document('generation-info.ada.xml')/generationInfo"/>
<xsl:variable name="typeInfoMap" select="$generationInfo/typeInfoMap"/>
<xsl:variable name="methodInfoMap" select="$generationInfo/methodInfoMap"/>

<xsl:param name="archName"/>
<xsl:param name="languageOption"/>
<xsl:param name="optLevel"/>
<xsl:param name="typecode"/>
<xsl:param name="modifyPubData"/>
<xsl:param name="namespace"/>
<xsl:param name="database"/>
<xsl:param name="coreProduct"/>

<xsl:variable name="language">
    <xsl:text>Ada</xsl:text>
</xsl:variable>

<xsl:include href="typeCommon.xsl"/>

<!-- Module declarations.
     The purpose of processing module is to build up the string that represents
     the current namespace, that contains concatenated module names separated
     by "."s. We pass on the namespace accumulated so far to the next nested
     elements though use of xsl:with-param.
-->
<xsl:template match="module">
    <xsl:param name="containerNamespace"/>

    <xsl:variable name="newNamespace">
        <xsl:choose>
            <xsl:when test="$containerNamespace != ''">
                <xsl:value-of select="concat($containerNamespace, '&namespaceSeperator;', @name)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="@name"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

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
    <xsl:param name="pointer"/>

    <xsl:variable name="matchedMethodNode" select="$methodInfoMap/method[@kind = $generationMode]"/>

    <xsl:variable name="newType">
        <xsl:choose>
            <xsl:when test="((count(./cardinality/dimension) &gt;= 2) or
                            (./cardinality and ./@maxLengthSequence)) and
                            $generationMode = 'structMember'">
                <xsl:value-of select="'dummy'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$type"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:choose>
        <xsl:when test="$matchedMethodNode/template[@pointer=$pointer and @kind = $memberKind and @typeKind = $typeKind and @type = $newType]">
            <xsl:value-of select="$matchedMethodNode/template[@pointer='yes' and @kind = $memberKind and @typeKind = $typeKind and @type= $newType]"/>
        </xsl:when>
        <xsl:when test="$matchedMethodNode/template[@pointer=$pointer and @kind = $memberKind and (@typeKind = $typeKind or @bitKind= $bitKind) and not(@type )]">
            <xsl:value-of select="$matchedMethodNode/template[@pointer='yes' and @kind = $memberKind and (@typeKind = $typeKind or @bitKind= $bitKind) and not(@type )]"/>
        </xsl:when>
        <xsl:when test="$matchedMethodNode/template[@pointer=$pointer and @kind = $memberKind and (not(@typeKind) and not(@bitKind)) and not(@type)]">
            <xsl:value-of select="$matchedMethodNode/template[@pointer='yes' and @kind = $memberKind and (not(@typeKind) and not(@bitKind)) and not(@type)]"/>
        </xsl:when>
        <xsl:when test="$matchedMethodNode/template[@kind = $memberKind and @typeKind = $typeKind and @type = $newType]">
            <xsl:value-of select="$matchedMethodNode/template[@kind = $memberKind and @typeKind = $typeKind and @type= $newType]"/>
        </xsl:when>
        <xsl:when test="$matchedMethodNode/template[@kind = $memberKind and (@typeKind = $typeKind or @bitKind= $bitKind) and not(@type )]">
            <xsl:value-of select="$matchedMethodNode/template[@kind = $memberKind and (@typeKind = $typeKind or @bitKind= $bitKind) and not(@type )]"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$matchedMethodNode/template[@kind = $memberKind and (not(@typeKind) and not(@bitKind)) and not(@type)]"/>
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
        <xsl:when test="($baseType='string' or $baseType='wstring' or $baseTypeKind='builtin' or $baseEnum)
                        and ($baseMemberKind != 'sequence' and $baseMemberKind != 'array' and
                        $baseMemberKind != 'arraySequence') and $optLevel = '2'
                        and name($typedefNode)='typedef'">no</xsl:when>
        <xsl:otherwise>yes</xsl:otherwise>
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

    <xsl:choose>
        <xsl:when test="($baseType='string' or $baseType='wstring' or $baseTypeKind='builtin' or $baseEnum)
                        and ($childMemberKind != 'sequence' and $childMemberKind != 'array' and $childMemberKind != 'arraySequence' and $pointer='no')
                        and $optLevel != '0'">
            <description>
                <xsl:attribute name="type"><xsl:value-of select="$baseType"/></xsl:attribute>
                <xsl:attribute name="memberKind"><xsl:value-of select="$baseMemberKind"/></xsl:attribute>
                <xsl:attribute name="typeKind"><xsl:value-of select="$baseTypeKind"/></xsl:attribute>
                <xsl:attribute name="bitKind"><xsl:value-of select="$baseBitKind"/></xsl:attribute>
                <xsl:attribute name="pointer"><xsl:value-of select="$basePointer"/></xsl:attribute>
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
            <description>
                <xsl:attribute name="type"><xsl:value-of select="$member/@type"/></xsl:attribute>
                <xsl:attribute name="memberKind"><xsl:value-of select="$memberKind"/></xsl:attribute>
                <xsl:attribute name="typeKind"><xsl:value-of select="$typeKind"/></xsl:attribute>
                <xsl:attribute name="bitKind"><xsl:value-of select="$bitKind"/></xsl:attribute>
                <xsl:attribute name="bitField"><xsl:value-of select="''"/></xsl:attribute>
                <xsl:attribute name="pointer"><xsl:value-of select="$pointer"/></xsl:attribute>
                <xsl:if test="$member/@bitField">
                    <xsl:attribute name="bitField"><xsl:value-of select="$member/@bitField"/></xsl:attribute>
                </xsl:if>
            </description>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!--
A common template shared code generator template for struct member
This template expect a template string passed in parameter
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
                </xsl:call-template>
        </xsl:variable>

    <!-- Replace all occurances of template parameter with their value from
         the map just obtained -->
        <xsl:call-template name="replace-string-from-map">
                <xsl:with-param name="inputString" select="$templateString"/>
                <xsl:with-param name="replacementParamsMap" select="xalan:nodeset($memberReplacementParams)/node()"/>
        </xsl:call-template>
</xsl:template>


<!-- Template to generate code for a given member.

     This is the template that should be called from the main
     stylesheet with correct parameter to generate code for
     each member.

     @param generationMode mode that should match one of those
                           in generation-info.xml (//methodInfoMap/method[@kind])
-->
<xsl:template match="struct/member" mode="code-generation">
     <xsl:param name="generationMode"/>
     <xsl:call-template name="generateMemberCode">
         <xsl:with-param name="generationMode" select="$generationMode"/>
         <xsl:with-param name="member" select="."/>
     </xsl:call-template>
</xsl:template>

<!-- -->
<xsl:template match="typedef/member" mode="code-generation">
    <xsl:param name="generationMode"/>

    <xsl:call-template name="generateMemberCode">
        <xsl:with-param name="generationMode" select="$generationMode"/>
        <xsl:with-param name="member" select="."/>
    </xsl:call-template>
</xsl:template>

<!-- Template for generating Members code -->
<xsl:template name="generateMemberCode">
    <xsl:param name="generationMode"/>
    <xsl:param name="member"/>

    <xsl:variable name="description">
        <xsl:call-template name="getMemberDescription">
            <xsl:with-param name="member" select="$member"/>
        </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="descriptionNode" select="xalan:nodeset($description)/node()"/>

    <!-- If the member is a pointer we check that its value is not NULL-->
    <xsl:variable name="unionModifier">
        <xsl:if test="$member/../@kind = 'union'">_u.</xsl:if>
    </xsl:variable>

    <!-- The checking for arrays is done in CDR. For the rest of the elements
         the checking is done in the following lines  -->
    <xsl:if test="$descriptionNode/@pointer = 'yes' and
                  $descriptionNode/@memberKind != 'array' and
                  $descriptionNode/@memberKind != 'arraySequence'">
        <xsl:choose>
            <xsl:when test="$generationMode='serialize' and not($member/@name)"> <!-- Typedef -->
    if (*sample == NULL) {
        return RTI_FALSE;
    }
            </xsl:when>
            <xsl:when test="$generationMode='serialize' and $member/@name"> <!-- Struct or union -->
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
        <xsl:call-template name="getTemplateString">
            <xsl:with-param name="generationMode" select="$generationMode"/>
            <xsl:with-param name="memberKind" select="$descriptionNode/@memberKind"/>
            <xsl:with-param name="bitKind" select="$descriptionNode/@bitKind"/>
            <xsl:with-param name="typeKind" select="$descriptionNode/@typeKind"/>
            <xsl:with-param name="type" select="$descriptionNode/@type"/>
            <xsl:with-param name="pointer" select="$descriptionNode/@pointer"/>
        </xsl:call-template>
    </xsl:variable>

    <xsl:if test="$member/@name != ''">
        <xsl:call-template name="replace-params">
            <xsl:with-param name="generationMode" select="$generationMode"/>
            <xsl:with-param name="member" select="$member"/>
            <xsl:with-param name="templateString" select="$templateString"/>
            <xsl:with-param name="type" select="$descriptionNode/@type"/>
            <xsl:with-param name="typeKind" select="$descriptionNode/@typeKind"/>
            <xsl:with-param name="memberKind" select="$descriptionNode/@memberKind"/>
            <xsl:with-param name="bitField" select="$descriptionNode/@bitField"/>
            <xsl:with-param name="pointer" select="$descriptionNode/@pointer"/>
        </xsl:call-template>
    </xsl:if>

</xsl:template>


<!-- Obtain array dimenstion
     @param cardinality a <cardinality> element with dimension as child. See schema in simplifyIDLXML.xsl
     @return a string of form [dim1][dim2]
-->
<xsl:template name="obtainArrayDimensions">
    <xsl:param name="cardinality"/>
    <xsl:text> (</xsl:text>
    <xsl:for-each select="$cardinality/dimension">
        <xsl:text>1 .. </xsl:text><xsl:value-of select="@size"/>
        <xsl:if test="position() != last()">
            <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:for-each>
    <xsl:text>)</xsl:text>
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


        <xsl:variable name="matchedTypeNode" select="$typeInfoMap/type[@idlType=$type]"/>

        <xsl:variable name="baseType">
            <xsl:call-template name="getBaseType">
                <xsl:with-param name="member" select="$structMember"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="nativeType">
            <xsl:call-template name="obtainNativeType">
                <xsl:with-param name="idlType" select="$type"/>
            </xsl:call-template>
        </xsl:variable>

        <member-param name="{$structMember/@name}" rawName="{$structMember/@name}"
                      pointer=""
                      aliased="aliased"
                      idlType="$type"
                      sampleAccess="sample->" sampleAccessPointer="&amp;sample->" srcAccess="src->" srcAccessPointer="&amp;src->" dstAccess="dst->" dstAccessPointer="&amp;dst->">
                <xsl:attribute name="currentAlignment"><xsl:value-of select="'current_alignment'"/></xsl:attribute>
                <xsl:attribute name="maxSerializeLeading"><xsl:value-of select="'current_alignment += '"/></xsl:attribute>
                <xsl:attribute name="maxSerializeTrailing"><xsl:value-of select="''"/></xsl:attribute>

                <xsl:if test="$pointer='yes'">
                    <xsl:attribute name="pointer">access</xsl:attribute>
                    <xsl:attribute name="sampleAccessPointer">sample-></xsl:attribute>
                    <xsl:attribute name="sampleAccess">*sample-></xsl:attribute>
                    <xsl:attribute name="srcAccessPointer">src-></xsl:attribute>
                    <xsl:attribute name="srcAccess">*src-></xsl:attribute>
                    <xsl:attribute name="dstAccessPointer">dst-></xsl:attribute>
                    <xsl:attribute name="dstAccess">*dst-></xsl:attribute>
                    <xsl:attribute name="aliased"/>
                </xsl:if>

                <!-- For unions -->
                <xsl:if test="$structMember/../@kind = 'union'">
                        <xsl:if test="$structMember/@uniondisc">
                            <xsl:attribute name="name">_d</xsl:attribute>
                        </xsl:if>
                        <xsl:if test="not($structMember/@uniondisc)">
                            <xsl:attribute name="name">_u.<xsl:value-of select="$structMember/@name"/></xsl:attribute>
                        </xsl:if>
                </xsl:if>

                <xsl:if test="$structMember/../@kind = 'union' and not($structMember/@uniondisc)">
                        <xsl:attribute name="maxSerializeLeading"><xsl:value-of select="'union_max_size_serialized = RTIOsapiUtility_max('"/></xsl:attribute>
                        <xsl:attribute name="maxSerializeTrailing"><xsl:value-of select="', union_max_size_serialized)'"/></xsl:attribute>
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
                        <xsl:when test="(count($structMember/cardinality/dimension) &gt;= 2) or
                                        ($structMember/cardinality and $structMember/@maxLengthSequence)">
                            <xsl:attribute name="nativeType"> 
                                <xsl:value-of select="$structMember/../@name"/>
                                <xsl:text>_</xsl:text>
                                <xsl:value-of select="$structMember/@name"/>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="$matchedTypeNode">
                            <!-- For builtin types, just copy over all the attributes of the matchedTypeNode,
                                 since the attribute name in that map (must) match the template parameter strings -->
                <xsl:copy-of select="$matchedTypeNode/@*"/>
                <xsl:if test="$pointer='yes'">
                    <xsl:attribute name="arraySerializeMethod">RTICdrStream_serializePrimitivePointerArray</xsl:attribute>
                    <xsl:attribute name="arrayDeserializeMethod">RTICdrStream_deserializePrimitivePointerArray</xsl:attribute>
                </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                                <xsl:attribute name="nativeType"><xsl:value-of select="$type"/></xsl:attribute>
                                <xsl:attribute name="nativeTypeSeq"><xsl:value-of select="$type"/>_Seq.Sequence</xsl:attribute>
                                <xsl:attribute name="elementSerializeMethod"><xsl:value-of select="$type"/>Plugin_serialize</xsl:attribute>
                                <xsl:attribute name="elementDeserializeMethod"><xsl:value-of select="$type"/>Plugin_deserialize</xsl:attribute>
                                <xsl:attribute name="sequenceSerializeMethod">RTICdrStream_serializeNonPrimitiveSequence</xsl:attribute>
         						<xsl:attribute name="sequenceDeserializeMethod">RTICdrStream_deserializeNonPrimitiveSequence</xsl:attribute>
                                <xsl:attribute name="pointerSequenceSerializeMethod">RTICdrStream_serializeNonPrimitivePointerSequence</xsl:attribute>
                                <xsl:attribute name="pointerSequenceDeserializeMethod">RTICdrStream_deserializeNonPrimitivePointerSequence</xsl:attribute>
								<xsl:if test="$pointer='yes'">
                                    <xsl:attribute name="arraySerializeMethod">RTICdrStream_serializeNonPrimitivePointerArray</xsl:attribute>
                                    <xsl:attribute name="arrayDeserializeMethod">RTICdrStream_deserializeNonPrimitivePointerArray</xsl:attribute>
                                </xsl:if>
                                <xsl:if test="$pointer='no'">
                                    <xsl:attribute name="arraySerializeMethod">RTICdrStream_serializeNonPrimitiveArray</xsl:attribute>
                                    <xsl:attribute name="arrayDeserializeMethod">RTICdrStream_deserializeNonPrimitiveArray</xsl:attribute>
                                </xsl:if>
                                <xsl:attribute name="elementPrintMethod"><xsl:value-of select="$type"/>Plugin_print</xsl:attribute>
                                <xsl:attribute name="elementInitMethod"><xsl:value-of select="$type"/>_initialize_ex</xsl:attribute>
                                <xsl:attribute name="elementCopyMethod"><xsl:value-of select="$type"/>_copy</xsl:attribute>
                                <xsl:attribute name="elementFinalizeMethod"><xsl:value-of select="$type"/>_finalize_ex</xsl:attribute>
                                <xsl:attribute name="elementSize">sizeof(<xsl:value-of select="$type"/>)</xsl:attribute>
                                <xsl:attribute name="elementSizeMethod"><xsl:value-of select="$type"/>Plugin_get_max_size_serialized</xsl:attribute>
                                <xsl:attribute name="arraySizeMethod">RTICdrType_getNonPrimitiveArrayMaxSizeSerialized</xsl:attribute>
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
                        <xsl:if test="count(cardinality/dimension) &lt; 2">
                            <xsl:call-template name="obtainArrayDimensions"><xsl:with-param name="cardinality" select="cardinality"/></xsl:call-template>
                        </xsl:if>
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

                <xsl:attribute name="cStruct"></xsl:attribute>

        </member-param>
</xsl:template>

<xsl:template name="obtainSourceFileName">
    <xsl:param name="directory" select="'.'"/>
    <xsl:param name="containerNamespace"/>
    <xsl:param name="typeName"/>
    <xsl:param name="fileExt"/>

    <xsl:variable name="package">
        <xsl:value-of select="translate($containerNamespace,'.','-')"/>
    </xsl:variable>

    <xsl:variable name="fileName">
        <xsl:if test="$directory != ''">
            <xsl:value-of select="concat($directory,'/')"/>
        </xsl:if>

        <xsl:choose>
            <xsl:when test="$package != '' and $typeName != ''">
                <xsl:value-of select="concat($package,'-',$typeName,'.',$fileExt)"/>
            </xsl:when>
            <xsl:when test="$package != '' and $typeName = ''">
                <xsl:value-of select="concat($package,'.',$fileExt)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat($typeName,'.',$fileExt)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:call-template name="lower-case">
        <xsl:with-param name="text" select="$fileName"/>
    </xsl:call-template>

</xsl:template>

<xsl:template name="printAutoGeneratedWarning">--  ============================================================================
--
--         WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.
--
--  This file was generated from <xsl:value-of select="$idlFileBaseName"/>.idl using "rtiddsgen".
--  The rtiddsgen tool is part of the <xsl:value-of select="$coreProduct"/> distribution.
--  For more information, type 'rtiddsgen -help' at a command shell
--  or consult the <xsl:value-of select="$coreProduct"/> manual.
--
--  ============================================================================

</xsl:template>

<!--
Process directives (next 4 <xsl:template> rules)

If "kind" attribute is "copy", then copy the text inside the <directive> element.
-->
<xsl:template match="directive[@kind = 'copy' or @kind = 'copy-ada' or @kind = 'copy-ada-begin']">
<xsl:text>&nl;</xsl:text><xsl:value-of select="text()"/><xsl:text>&nl;</xsl:text>
</xsl:template>

<xsl:template match="directive[@kind = 'copy' or @kind = 'copy-ada' or @kind = 'copy-ada-begin']"
              mode="code-generation">
<xsl:text>&nl;</xsl:text><xsl:value-of select="text()"/><xsl:text>&nl;</xsl:text>
</xsl:template>

</xsl:stylesheet>
