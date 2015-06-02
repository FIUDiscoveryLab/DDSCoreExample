<?xml version="1.0"?>
<!--
   $Id: typeCommon.cppcli.xsl,v 1.11 2013/10/27 18:28:52 fernando Exp $

   (c) Copyright 2007, Real-Time Innovations, Inc.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.

Modification history
 - - - - - - - - - -
5.1.0,16may13,fcs CODEGEN-561: Union mutability support in .NET
5.1.0,25oct13,fcs CODEGEN-584: Received samples for an Extensible type may contain 
                  invalid values for fields not present on the wire
5.1.0,29sep13,fcs Fixed CODEGEN-567: Fixed alignment for members in mutable types
5.0.1,22may13,fcs CODEGEN-594: Added suffix to DLL_EXPORT_MACRO
10ae,31jan12,vtg RTI-110 Add support to rtiddsgen to produce dll importable code on windows
10ac,10feb11,fcs Fixed bug 13844
10ac,29aug09,fcs Double pointer indirection and dropSample
                 in deserialize function
10ac,10aug09,fcs get_serialized_sample_size support
10x,16jul08,tk  Added utils.xsl
10x,22may08,rbw Removed more pointer cruft. Fixed array template matching.
10x,09may08,rbw Added multi-dimensional array support
10x,08may08,rbw Added union support
10x,08may08,rbw Added bit field support
10x,07may08,rbw Added typedef support
10v,09apr08,rbw Type plug-in API is now managed
10v,17mar08,rbw Added missing skip methods
10v,17mar08,fcs Fixed compilation
10v,17mar08,fcs Fixed key management
10v,12mar08,rbw Made method names more consistent
10v,11mar08,rbw Added enum support
10s,06mar08,rbw Fixed bug related to string type name
10s,05mar08,rbw Added support for multi-dimensional arrays
10s,28feb08,rbw Fixed pointer syntax; removed unnecessary namespace rules
10s,13feb08,rbw Created
-->


<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0"
                xmlns:xalan = "http://xml.apache.org/xalan">

<xsl:variable name="idlFileBaseName" select="/specification/@idlFileName"/>
<xsl:variable name="generationInfo" select="document('generation-info.cppcli.xml')/generationInfo"/>
<xsl:variable name="typeInfoMap" select="$generationInfo/typeInfoMap"/>
<xsl:variable name="methodInfoMap" select="$generationInfo/methodInfoMap"/>

<xsl:param name="archName"/>
<xsl:param name="languageOption"/>
<xsl:param name="optLevel"/>
<xsl:param name="typecode"/>
<xsl:param name="modifyPubData"/>
<xsl:param name="namespace"/>
<xsl:param name="database"/>
<xsl:param name="dllImportableCode"/>
<xsl:param name="dllExportMacroSuffix"/>
        
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
    <xsl:text>C++/CLI</xsl:text>
</xsl:variable>                

<xsl:include href="utils.xsl"/>        
<xsl:include href="typeCommon.xsl"/>

                        
<!-- ===================================================================== -->
<!-- Module Declaration                                                    -->
<!-- ===================================================================== -->

<!-- Module declarations.
     The purpose of processing module is to build up the string that represents
     the current namespace, that contains concatenated module names separated
     by "_"s. We pass on the namespace accumulated so far to the next nested elements
     though use of xsl:with-param.
-->
<xsl:template match="module">
    <xsl:text>&nl;</xsl:text>
    <xsl:text>namespace </xsl:text>                        
    <xsl:value-of select="@name"/>
    <xsl:text>{&nl;</xsl:text>

    <xsl:apply-templates/>
                
    <xsl:text>&nl;</xsl:text>                
    <xsl:text>} /* namespace </xsl:text>
    <xsl:value-of select="@name"/>
    <xsl:text> */&nl;</xsl:text>
</xsl:template>


<!-- ===================================================================== -->
<!-- Struct Member Declaration                                             -->
<!-- ===================================================================== -->

<!-- Template to generate code for a given member.

     This is the template that should be called from the main
     stylesheet with correct parameter to generate code for
     each member.
     
     @param generationMode mode that should match one of those
                           in generation-info.xml (//methodInfoMap/method[@kind])
-->     
<xsl:template match="struct[not(@kind = 'union')]/member"
              mode="code-generation">
     <xsl:param name="generationMode"/>
     <xsl:param name="discContainer"/>

     <xsl:call-template name="generateMemberCode">
         <xsl:with-param name="generationMode" select="$generationMode"/>
         <xsl:with-param name="member" select="."/>
     </xsl:call-template>
</xsl:template>


<!-- ===================================================================== -->
<!-- Typedef Member Declaration                                            -->
<!-- ===================================================================== -->

<xsl:template match="typedef/member" mode="code-generation">
    <xsl:param name="generationMode"/>
    <xsl:param name="discContainer"/>

    <xsl:call-template name="generateMemberCode">
        <xsl:with-param name="generationMode" select="$generationMode"/>
        <xsl:with-param name="member" select="."/>
    </xsl:call-template>    
</xsl:template>


<!-- ===================================================================== -->
<!-- Union Member Declaration                                              -->
<!-- ===================================================================== -->

<xsl:template match="struct[@kind = 'union']/member" mode="code-generation">    
    <xsl:param name="generationMode"/>
    <xsl:param name="unionVariableName" select="'sample'"/>
    <xsl:param name="discContainer"/>

  <xsl:variable name="xType">
    <xsl:call-template name="getExtensibilityKind">
      <xsl:with-param name="structName" select="../@name"/>
      <xsl:with-param name="node" select="./.."/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="needSwitch"
                  select="not($generationMode = 'structMember' or
                              $generationMode = 'get_min_size_serialized' or
                              $generationMode = 'get_max_size_serialized' or
                              $generationMode = 'new' or
                              $generationMode = 'initialize' or
                              $generationMode = 'finalize' or
                              ($xType='MUTABLE_EXTENSIBILITY' and ($generationMode='deserialize' or $generationMode='skip')))"/>
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


<!-- ===================================================================== -->
<!-- Directives                                                            -->
<!-- ===================================================================== -->

<!--
Process directives (next 4 <xsl:template> rules)

If "kind" attribute is "copy", then copy the text inside the <directive> element.
Otherwise issue a warning message, and ignore the directive.
-->
<xsl:template match="directive[@kind = 'copy' or @kind = 'copy-cppcli']">
    <xsl:text>&nl;</xsl:text>
    <xsl:value-of select="text()"/>
    <xsl:text>&nl;</xsl:text>
</xsl:template>

<xsl:template match="directive[@kind = 'copy' or @kind = 'copy-cppcli']"
              mode="code-generation">
    <xsl:text>&nl;</xsl:text>
    <xsl:value-of select="text()"/>
    <xsl:text>&nl;</xsl:text>
</xsl:template>

        
<!-- ===================================================================== -->
<!-- Utility Templates                                                     -->
<!-- ===================================================================== -->

<xsl:template name="getTemplateString">
    <xsl:param name="generationMode"/>
    <xsl:param name="memberKind"/>
    <xsl:param name="baseMemberKind"/>
    <xsl:param name="bitKind"/>        
    <xsl:param name="typeKind"/>
    <xsl:param name="type"/>
    <xsl:param name="enum"/>
    <xsl:param name="multidim"/><!-- is multi-dimensional array? -->

    <xsl:variable name="matchedMethodNode" select="$methodInfoMap/method[@kind = $generationMode]"/>
    
    <xsl:choose>                    
        <xsl:when test="$matchedMethodNode/template[@kind=$memberKind and
                                                    @baseMemberKind=$baseMemberKind and
                                                    @typeKind=$typeKind]">
            <xsl:value-of
                select="$matchedMethodNode/template[@kind=$memberKind and
                                                    @baseMemberKind=$baseMemberKind and
                                                    @typeKind=$typeKind]"/>
        </xsl:when>
        <xsl:when test="$matchedMethodNode/template[@kind=$memberKind and
                                                    @typeKind=$typeKind and
                                                    @enum=$enum and
                                                    @type=$type and
                                                    @multidim=$multidim and
                                                    not(@baseMemberKind)]">
            <xsl:value-of
                select="$matchedMethodNode/template[@kind=$memberKind and
                                                    @typeKind=$typeKind and
                                                    @enum=$enum and
                                                    @type=$type and
                                                    @multidim=$multidim and
                                                    not(@baseMemberKind)]"/>
        </xsl:when>
        <xsl:when test="$matchedMethodNode/template[@kind=$memberKind and
                                                    @typeKind=$typeKind and
                                                    not(@enum) and
                                                    @type=$type and
                                                    @multidim=$multidim and
                                                    not(@baseMemberKind)]">
            <xsl:value-of
                select="$matchedMethodNode/template[@kind=$memberKind and
                                                    @typeKind=$typeKind and
                                                    not(@enum) and
                                                    @type=$type and
                                                    @multidim=$multidim and
                                                    not(@baseMemberKind)]"/>
        </xsl:when>
        <xsl:when test="$matchedMethodNode/template[@kind=$memberKind and
                                                    @typeKind=$typeKind and
                                                    @type=$type and
                                                    not(@baseMemberKind)]">
            <xsl:value-of
                select="$matchedMethodNode/template[@kind=$memberKind and
                                                    @typeKind=$typeKind and
                                                    @type=$type and
                                                    not(@baseMemberKind)]"/>            
        </xsl:when>        
        <xsl:when test="$matchedMethodNode/template[@kind=$memberKind and
                                                    @typeKind=$typeKind and
                                                    @enum=$enum and
                                                    not(@type) and
                                                    @multidim=$multidim and
                                                    not(@baseMemberKind)]">
            <xsl:value-of
                select="$matchedMethodNode/template[@kind=$memberKind and
                                                    @typeKind=$typeKind and
                                                    @enum=$enum and
                                                    not(@type) and
                                                    @multidim=$multidim and
                                                    not(@baseMemberKind)]"/>
        </xsl:when>
        <xsl:when test="$matchedMethodNode/template[@kind=$memberKind and
                                                    @typeKind=$typeKind and
                                                    @enum=$enum and
                                                    not(@type) and
                                                    not(@baseMemberKind)]">
            <xsl:value-of
                select="$matchedMethodNode/template[@kind=$memberKind and
                                                    @typeKind=$typeKind and
                                                    @enum=$enum and
                                                    not(@type) and
                                                    not(@baseMemberKind)]"/>
        </xsl:when>
        <xsl:when test="$matchedMethodNode/template[@kind=$memberKind and
                                                    @typeKind=$typeKind and
                                                    not(@enum) and
                                                    not(@type) and
                                                    @multidim=$multidim and
                                                    not(@baseMemberKind)]">
            <xsl:value-of
                select="$matchedMethodNode/template[@kind=$memberKind and
                                                    @typeKind=$typeKind and
                                                    not(@enum) and
                                                    not(@type) and
                                                    @multidim=$multidim and
                                                    not(@baseMemberKind)]"/>
        </xsl:when>
        <xsl:when test="$matchedMethodNode/template[@kind=$memberKind and 
                                                    (@typeKind=$typeKind or
                                                        @bitKind=$bitKind) and
                                                    not(@type) and
                                                    not(@enum) and
                                                    not(@multidim) and
                                                    not(@baseMemberKind)]">
            <xsl:value-of
                select="$matchedMethodNode/template[@kind=$memberKind and
                                                    (@typeKind=$typeKind or
                                                        @bitKind=$bitKind) and
                                                    not(@type) and
                                                    not(@enum) and
                                                    not(@multidim) and
                                                    not(@baseMemberKind)]"/>
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
        <xsl:when test="($baseType='string' or $baseType='wstring' or $baseTypeKind='builtin' or $baseEnum='yes') 
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
    
    <xsl:variable name="baseMultidimArray">
        <xsl:choose>
            <xsl:when test="count($member/cardinality/dimension) &gt; 1">yes</xsl:when>
            <xsl:otherwise>no</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:choose>
        <xsl:when test="($baseType='string' or $baseType='wstring' or $baseTypeKind='builtin' or $baseEnum) 
                        and ($childMemberKind != 'sequence' and $childMemberKind != 'array' and $childMemberKind != 'arraySequence')
                        and $optLevel != '0'">
            <description>
                <xsl:attribute name="type"><xsl:value-of select="$baseType"/></xsl:attribute>
                <xsl:attribute name="memberKind"><xsl:value-of select="$baseMemberKind"/></xsl:attribute>                    
                <xsl:attribute name="typeKind"><xsl:value-of select="$baseTypeKind"/></xsl:attribute>                                        
                <xsl:attribute name="bitKind"><xsl:value-of select="$baseBitKind"/></xsl:attribute>                                                            
                <xsl:attribute name="enum">
                    <xsl:value-of select="$baseEnum"/>
                </xsl:attribute>
                <xsl:attribute name="multidim">
                    <xsl:value-of select="$baseMultidimArray"/>
                </xsl:attribute>
                <xsl:attribute name="baseMemberKind">
                    <xsl:value-of select="$baseMemberKind"/>
                </xsl:attribute>
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
                <xsl:attribute name="enum">
                    <xsl:value-of select="$baseEnum"/>
                </xsl:attribute>
                <xsl:attribute name="multidim">
                    <xsl:value-of select="$baseMultidimArray"/>
                </xsl:attribute>
                <xsl:if test="$member/@bitField">
                    <xsl:attribute name="bitField"><xsl:value-of select="$member/@bitField"/></xsl:attribute>                                                                                                   
                </xsl:if>                
                <xsl:attribute name="baseMemberKind">
                    <xsl:value-of select="$baseMemberKind"/>
                </xsl:attribute>
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
    <xsl:param name="baseMemberKind"/>
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
            <xsl:with-param name="baseMemberKind" select="$baseMemberKind"/>                                
            <xsl:with-param name="bitField" select="$bitField"/>                        
            <xsl:with-param name="discContainer" select="$discContainer"/>
            <xsl:with-param name="xType" select="$xType"/>
        </xsl:call-template>
    </xsl:variable>

    <!-- Replace all occurances of template parameter with their value from
         the map just obtained -->
    <xsl:call-template name="replace-string-from-map">
        <xsl:with-param name="inputString" select="$templateString"/>
        <xsl:with-param name="replacementParamsMap"
                        select="xalan:nodeset($memberReplacementParams)/node()"/>
    </xsl:call-template>
</xsl:template>

<!-- Template for generating Members code -->
<xsl:template name="generateMemberCode">
    <xsl:param name="generationMode"/>
    <!-- indicates the variable where the member will be deserialized -->
    <xsl:param name="discContainer" select="''"/> 
    <xsl:param name="member"/>

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

    <!-- we don't generate code for bitfield fields without name -->
    <xsl:if test="not ($descriptionNode/@memberKind='bitfield' and $member/@name='')">

        <!-- have to check the generationMode in case it is for keys -->
        <xsl:variable name="tmpGenerationMode">
            <xsl:choose>
                <xsl:when test="$generationMode='serialize_key'">serialize</xsl:when>
                <xsl:when test="$generationMode='deserialize_key'">deserialize</xsl:when>
                <xsl:when test="$generationMode='get_max_size_serialized_key'">get_max_size_serialized</xsl:when>
                <xsl:when test="$generationMode='serialized_sample_to_key'">deserialize</xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$generationMode"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="unionModifier">
            <xsl:if test="$member/../@kind = 'union'">_u-&gt;</xsl:if>
        </xsl:variable>

        <!-- Select template string. -->
        <xsl:variable name="templateString">
            <xsl:call-template name="getTemplateString">
                <xsl:with-param name="generationMode"
                                select="$tmpGenerationMode"/>
                <xsl:with-param name="memberKind"
                                select="$descriptionNode/@memberKind"/>
                <xsl:with-param name="baseMemberKind"
                                select="$descriptionNode/@baseMemberKind"/>
                <xsl:with-param name="bitKind"
                                select="$descriptionNode/@bitKind"/>
                <xsl:with-param name="typeKind"
                                select="$descriptionNode/@typeKind"/>
                <xsl:with-param name="type" select="$descriptionNode/@type"/>
                <xsl:with-param name="enum" select="$descriptionNode/@enum"/>
                <xsl:with-param name="multidim"
                                select="$descriptionNode/@multidim"/>
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
            <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> 
                <xsl:text>
            // next member 
            memberId = </xsl:text> <xsl:value-of select="$member/@memberId" /><xsl:text>;&nl;</xsl:text> 
            <xsl:choose>
                <xsl:when test="$member/@memberId > 16128">
                    <xsl:text>    memberLengthPosition = stream.serialize_member_id((UInt32)memberId);&nl;</xsl:text>
                </xsl:when>
                <xsl:when test="$needExtendedParameterId = 'no'">
                    <xsl:text>    memberLengthPosition = stream.serialize_member_id((UInt16)memberId);&nl;</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>    if (stream.useExtendedMemberId == true) {&nl;</xsl:text>
                    <xsl:text>        memberLengthPosition = stream.serialize_member_id((UInt32)memberId);&nl;</xsl:text>
                    <xsl:text>    } else {&nl;</xsl:text>
                    <xsl:text>        memberLengthPosition = stream.serialize_member_id((UInt16)memberId);&nl;</xsl:text>
                    <xsl:text>    }&nl;</xsl:text>
                </xsl:otherwise>
             </xsl:choose>
            </xsl:if>
        </xsl:if>  

        <xsl:variable name="memberName" select="$member/@name"/>
        <xsl:variable name="currentMemberId" select="$member/@memberId" />

        <xsl:if test="$generationMode='deserialize' or $generationMode='skip' or $generationMode='deserialize_key' or $generationMode='serialized_sample_to_key'">
            <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> 
               <xsl:for-each  select="$member/../node()[name()='member' or name()='discriminator']">
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

        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
          <xsl:if test="$generationMode='get_max_size_serialized' or
                        $generationMode='get_max_size_serialized_key'">
            <xsl:text>&nl;    current_alignment += RTICdrStream_getExtendedParameterHeaderMaxSizeSerialized(current_alignment);&nl;</xsl:text>
          </xsl:if>

          <xsl:if test="$generationMode='get_min_size_serialized' or 
                        $generationMode='get_serialized_sample_size'">
            <xsl:if test="$needExtendedParameterId = 'yes' or $needExtendedParameterId = 'maybe'">
              <xsl:text>&nl;    current_alignment += RTICdrStream_getExtendedParameterHeaderMaxSizeSerialized(current_alignment);&nl;</xsl:text>
            </xsl:if>
            <xsl:if test="$needExtendedParameterId = 'no'">
              <xsl:text>&nl;    current_alignment += RTICdrStream_getParameterHeaderMaxSizeSerialized(current_alignment);&nl;</xsl:text>
            </xsl:if>
          </xsl:if>
        </xsl:if>

        <xsl:call-template name="replace-params">
            <xsl:with-param name="generationMode" select="$generationMode"/>
            <xsl:with-param name="member" select="$member"/>
            <xsl:with-param name="templateString" select="$templateString"/>
            <xsl:with-param name="type" select="$descriptionNode/@type"/>
            <xsl:with-param name="typeKind"
                            select="$descriptionNode/@typeKind"/>
            <xsl:with-param name="memberKind"
                            select="$descriptionNode/@memberKind"/>
            <xsl:with-param name="baseMemberKind"
                            select="$descriptionNode/@baseMemberKind"/>
            <xsl:with-param name="bitField"
                            select="$descriptionNode/@bitField"/>
            <xsl:with-param name="discContainer" select="$discContainer"/>
            <xsl:with-param name="xType" select="$xType"/>
        </xsl:call-template>

        <xsl:if test="$generationMode='serialize' or $generationMode='serialize_key'">
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> 
            <xsl:choose>
                <xsl:when test="$member/@memberId > 16128">
                    <!-- memberId greater than 16128. Long is needed -->
                    <xsl:text>    stream.serialize_member_length(memberLengthPosition, true);&nl;</xsl:text>
                </xsl:when>
                <xsl:when test="$needExtendedParameterId = 'no'">
                    <xsl:text>    stream.serialize_member_length(memberLengthPosition, false);&nl;</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>    if (stream.useExtendedMemberId == true) {&nl;</xsl:text>
                    <xsl:text>        stream.serialize_member_length(memberLengthPosition, true);&nl;</xsl:text>
                    <xsl:text>    } else {&nl;</xsl:text>
                    <xsl:text>        stream.serialize_member_length(memberLengthPosition, false);&nl;</xsl:text>
                    <xsl:text>    }&nl;</xsl:text>
                </xsl:otherwise>
             </xsl:choose>
        </xsl:if>
    </xsl:if>

    <xsl:if test="$generationMode='deserialize' or $generationMode='skip'  or $generationMode='deserialize_key' or $generationMode='serialized_sample_to_key'">
            <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> 
            <xsl:text>break;</xsl:text>
            </xsl:if>
         </xsl:if>

    </xsl:if><!-- test="not ($descriptionNode/@memberKind='bitfield' and $member/@name='')" -->
               
</xsl:template>


<!-- Obtain array dimenstion
     @param cardinality a <cardinality> element with dimension as child. See schema in simplifyIDLXML.xsl
     @return a string of form [dim1][dim2]
-->
<xsl:template name="obtainArrayDimensions">
    <xsl:param name="cardinality"/>

    <xsl:text>(</xsl:text>
    <xsl:for-each select="$cardinality/dimension">
        <xsl:value-of select="@size"/>
        <xsl:if test="position() != last()">, </xsl:if>
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

<!-- Obtain "for" loop (pre-part) to serialize/deserialize/print array elements
     @param cardinality a <cardinality> element with dimension as child. See schema in simplifyIDLXML.xsl
     @return a string of form for(int i1__ = 0; i1__ < <dim>; ++i1__) {
                              for(int i2__ = 0; i2__ < <dim>; ++i2__) {
                              ...
-->
<xsl:template name="obtainArrayForLoopPre">
  <xsl:param name="cardinality"/>
  <xsl:text>&nl;</xsl:text>
  <xsl:for-each select="$cardinality/dimension">
    <xsl:variable name="loopVar">i<xsl:value-of select="position()"/>__</xsl:variable>
    <xsl:text>    for(Int32 </xsl:text>
    <xsl:value-of select="$loopVar"/>
    <xsl:text> = 0; </xsl:text>
    <xsl:value-of select="$loopVar"/>
    <xsl:text> &lt; </xsl:text>
    <xsl:value-of select="@size"/>
    <xsl:text>; ++</xsl:text>
    <xsl:value-of select="$loopVar"/>
    <xsl:text>) {&nl;</xsl:text>
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
  <xsl:text>&nl;</xsl:text>
  <xsl:for-each select="$cardinality/dimension">
    <xsl:text>    }&nl;</xsl:text>
  </xsl:for-each>
</xsl:template>

<!-- Obtain string to point to the current array element (see "obtainArrayForLoopPre" template)
     @param cardinality a <cardinality> element with dimension as child. See schema in simplifyIDLXML.xsl
     @return a string of form [i1__,i2__]...
-->
<xsl:template name="obtainArrayCurrentElement">
  <xsl:param name="cardinality"/>

  <xsl:text>[</xsl:text>
  <xsl:for-each select="$cardinality/dimension">
    <xsl:text>i</xsl:text>
    <xsl:value-of select="position()"/>
    <xsl:text>__</xsl:text>
    <xsl:if test="position()!=last()">
      <xsl:text>,</xsl:text>
    </xsl:if>
  </xsl:for-each>
  <xsl:text>]</xsl:text>

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

        <xsl:variable name="baseEnum">
          <xsl:call-template name="isBaseEnum">
            <xsl:with-param name="member" select="$structMember"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="nativeType">
            <xsl:call-template name="obtainNativeType">
                <xsl:with-param name="idlType" select="$type"/>
            </xsl:call-template>                     
        </xsl:variable>
  
         <xsl:variable name="baseMemberKind">
            <xsl:call-template name="obtainBaseMemberKind">
                <xsl:with-param name="member" select="$structMember"/>
            </xsl:call-template>
        </xsl:variable>
                                                    
        <member-param name="{$structMember/@name}" rawName="{$structMember/@name}" 
                      idlType="$type"
                      sampleAccess="sample->" sampleAccessPointer="&amp;sample->" srcAccess="src->" srcAccessPointer="&amp;src->" dstAccess="dst->" dstAccessPointer="&amp;dst->">
        <xsl:choose>
            <xsl:when test ="$xType='MUTABLE_EXTENSIBILITY'">
                <xsl:attribute name="currentAlignment">
                    <xsl:value-of select="'0'"/>
                </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="currentAlignment">
                    <xsl:value-of select="'current_alignment'"/>
                </xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>

        <xsl:attribute name="maxSerializeLeading"><xsl:value-of select="'current_alignment += '"/></xsl:attribute>
        <xsl:attribute name="minSerializeLeading"><xsl:value-of select="'current_alignment += '"/></xsl:attribute>
        <xsl:attribute name="maxSerializeTrailing"><xsl:value-of select="''"/></xsl:attribute>  
        <xsl:attribute name="minSerializeTrailing"><xsl:value-of select="''"/></xsl:attribute>  
                        
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
                        <xsl:attribute name="name">
                            <xsl:text>_u-&gt;</xsl:text>
                            <xsl:value-of select="$structMember/@name"/>
                        </xsl:attribute>                                                        
                    </xsl:if>                                                                                                
                </xsl:if>
                
                <xsl:if test="$structMember/../@kind = 'union' and not($structMember/@uniondisc)">                        
                        <xsl:attribute name="maxSerializeLeading"><xsl:value-of select="'union_max_size_serialized = RTIOsapiUtility_max('"/></xsl:attribute>
                        <xsl:attribute name="maxSerializeTrailing"><xsl:value-of select="', union_max_size_serialized)'"/></xsl:attribute>              
                        <xsl:attribute name="minSerializeLeading"><xsl:value-of select="'union_min_size_serialized = RTIOsapiUtility_min('"/></xsl:attribute>
                        <xsl:attribute name="minSerializeTrailing"><xsl:value-of select="', union_min_size_serialized)'"/></xsl:attribute>              
                </xsl:if>
                
                <!-- For typedefs -->                  
                <xsl:if test="name($structMember/..) = 'typedef'">
                    <xsl:attribute name="rawName">Value</xsl:attribute>            
                    <xsl:attribute name="name">Value</xsl:attribute>                        
                </xsl:if>               
                
                <xsl:choose>
                        <xsl:when test="$matchedTypeNode">
                            <!-- For builtin types, just copy over all the attributes of the matchedTypeNode,
                                 since the attribute name in that map (must) match the template parameter strings -->
                <xsl:copy-of select="$matchedTypeNode/@*"/>                             
                        </xsl:when>
                        <xsl:otherwise>
                                <xsl:attribute name="nativeType">
                                    <xsl:call-template name="obtainNativeType">
                                        <xsl:with-param name="idlType" select="$type"/>
                                    </xsl:call-template>                     
                                </xsl:attribute>
                                <xsl:attribute name="nativeTypeSeq"><xsl:value-of select="$type"/>Seq</xsl:attribute>
                                <xsl:attribute name="elementSerializeMethod">
                                    <xsl:choose>
                                        <xsl:when test="$generationMode='serialize_key'">
                                            <xsl:value-of select="$type"/>
                                            <xsl:text>Plugin::get_instance()->serialize_key</xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="$type"/>
                                            <xsl:text>Plugin::get_instance()->serialize</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                                <xsl:attribute name="elementDeserializeMethod">
                                    <xsl:choose>
                                        <xsl:when test="$generationMode='serialized_sample_to_key'">
                                            <xsl:value-of select="$type"/>
                                            <xsl:text>Plugin::get_instance()->serialized_sample_to_key</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="$generationMode='deserialize_key'">
                                            <xsl:value-of select="$type"/>
                                            <xsl:text>Plugin::get_instance()->deserialize_key_sample</xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="$type"/>
                                            <xsl:text>Plugin::get_instance()->deserialize_sample</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                                <xsl:attribute name="elementSkipMethod">
                                    <xsl:value-of select="$type"/>
                                    <xsl:text>Plugin::get_instance()->skip</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="sequenceSerializeMethod">RTICdrStream_serializeNonPrimitiveSequence</xsl:attribute>
         						<xsl:attribute name="sequenceDeserializeMethod">RTICdrStream_deserializeNonPrimitiveSequence</xsl:attribute>
                                <xsl:attribute name="sequenceSkipMethod">
                                    <xsl:text>RTICdrStream_skipNonPrimitiveSequence</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="pointerSequenceSerializeMethod">RTICdrStream_serializeNonPrimitivePointerSequence</xsl:attribute>                                
                                <xsl:attribute name="pointerSequenceDeserializeMethod">RTICdrStream_deserializeNonPrimitivePointerSequence</xsl:attribute>
                                <xsl:attribute name="arraySerializeMethod">RTICdrStream_serializeNonPrimitiveArray</xsl:attribute>                                    
                                <xsl:attribute name="arrayDeserializeMethod">RTICdrStream_deserializeNonPrimitiveArray</xsl:attribute>
                                <xsl:attribute name="arraySkipMethod">
                                    <xsl:text>RTICdrStream_skipNonPrimitiveArray</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="elementPrintMethod">
                                    <xsl:value-of select="$type"/>
                                    <xsl:text>Plugin::get_instance()->print_data</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="elementInitMethod"><xsl:value-of select="$type"/>_initialize_ex</xsl:attribute>
                                <xsl:attribute name="elementCopyMethod"><xsl:value-of select="$type"/>_copy</xsl:attribute>
                                <xsl:attribute name="elementFinalizeMethod"><xsl:value-of select="$type"/>_finalize_ex</xsl:attribute>
                                <xsl:attribute name="elementSize">sizeof(<xsl:value-of select="$type"/>)</xsl:attribute>
		<xsl:attribute name="elementSizeMethod">
		    <xsl:choose>
                        <xsl:when test="$generationMode='get_min_size_serialized'">
                            <xsl:value-of select="$type"/>
                            <xsl:text>Plugin::get_instance()->get_serialized_sample_min_size</xsl:text>
                        </xsl:when>
                        <xsl:when test="$generationMode='get_max_size_serialized_key'">
                            <xsl:value-of select="$type"/>
                            <xsl:text>Plugin::get_instance()->get_serialized_key_max_size</xsl:text>
                        </xsl:when>
                        <xsl:when test="$generationMode='get_serialized_sample_size'">
                            <xsl:value-of select="$type"/>
                            <xsl:text>Plugin::get_instance()->get_serialized_sample_size</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$type"/>
                            <xsl:text>Plugin::get_instance()->get_serialized_sample_max_size</xsl:text>
                        </xsl:otherwise>
		    </xsl:choose>
		</xsl:attribute>
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
                        <xsl:call-template name="obtainArrayDimensions"><xsl:with-param name="cardinality" select="cardinality"/></xsl:call-template>                        
                    </xsl:if>
                    <xsl:if test="not(cardinality)">
                        <xsl:call-template name="obtainArrayDimensions"><xsl:with-param name="cardinality" select="member/cardinality"/></xsl:call-template>                        
                    </xsl:if>                    
                </xsl:attribute>
                <xsl:attribute name="arrayDimensionCount">
                    <xsl:value-of select="count(cardinality/dimension)"></xsl:value-of>
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
                                
                <xsl:choose>
                        <xsl:when test="$language = 'C'">
                                <xsl:attribute name="cStruct">struct</xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                                <xsl:attribute name="cStruct"></xsl:attribute>
                        </xsl:otherwise>
                </xsl:choose>

                <!-- Used for enums -->
                <xsl:if test="$baseEnum = 'yes'">
                    <xsl:attribute name="initialValue"><xsl:value-of select="$type"/>_get_default_value()</xsl:attribute>
                </xsl:if>
          
                <xsl:variable name="cardinality">
                    <xsl:call-template name="getBaseCardinality">
                        <xsl:with-param name="member" select="$structMember"/>        
                    </xsl:call-template>                
                </xsl:variable>
        
                <xsl:variable name="cardinalityNode" select="xalan:nodeset($cardinality)/node()"/>        

                <xsl:attribute name="cardinalityArrayForLoopPre">
                    <xsl:call-template name="obtainArrayForLoopPre"><xsl:with-param name="cardinality" select="$cardinalityNode"/></xsl:call-template>            
                </xsl:attribute>
         
                <xsl:attribute name="cardinalityArrayForLoopPost">
                    <xsl:call-template name="obtainArrayForLoopPost"><xsl:with-param name="cardinality" select="$cardinalityNode"/></xsl:call-template>            
                </xsl:attribute>
          
                <xsl:attribute name="cardinalityCurrentElement">
                    <xsl:call-template name="obtainArrayCurrentElement"><xsl:with-param name="cardinality" select="$cardinalityNode"/></xsl:call-template>                    
                </xsl:attribute>        
        </member-param>
</xsl:template>

</xsl:stylesheet>
