<?xml version="1.0"?>
<!-- 
/* $Id: typeCode.c.xsl,v 1.6 2013/09/12 14:22:28 fernando Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
Modification history:
- - - - - - - - - - -
5.0.1,11apr13,acr CODEGEN-573: generate member flags for key, optional and
                  non-key, non-optional members
5.0.1,04nov12,fcs Fixed CODEGEN-525
5.0.0,10oct12,fcs memberId support in EXT types
5.0.0,09sep12,fcs memberId support in MUTABLE types
10ac,12jun11,fcs Bitset support
10ac,11may11,ai  XTypes: added support for extensibility and struct inheritance
10ab,31mar09,rbw Bug #12852: Fixed type code generation bug in C++/CLI
1.0x,08may08,rbw Added C++/CLI union support
1.0v,11mar08,rbw Added C++/CLI enum support
1.0u,27feb08,as  Reorganize RTICdrTypeCodeMember struct for param types
1.0n,02jan07,fcs Struct/Union type codes with 0 members are allowed
1.0m,26jun06,fcs Fixed bug 11171
1.0m,31may06,fcs Created
-->

<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
        xmlns:xalan = "http://xml.apache.org/xalan">

    <xsl:variable name="typeCodeTypeName">
        <xsl:choose>
            <xsl:when test="$languageOption = 'C' or $languageOption = 'c'">                
                <xsl:text>DDS_TypeCode</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>DDS_TypeCode</xsl:text>                
            </xsl:otherwise>
        </xsl:choose>                
    </xsl:variable>
    
    <xsl:variable name="openBracket">        
        <xsl:choose>
            <xsl:when test="$languageOption = 'C' or $languageOption = 'c'">
                <xsl:text>{</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>{</xsl:text>
            </xsl:otherwise>
        </xsl:choose>                
    </xsl:variable>
    
    <xsl:variable name="closeBracket">        
        <xsl:choose>
            <xsl:when test="$languageOption = 'C' or $languageOption = 'c'">
                <xsl:text>}</xsl:text>                
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>}</xsl:text>
            </xsl:otherwise>
        </xsl:choose>                
    </xsl:variable>
    
    <xsl:variable name="dataName">
        <xsl:choose>
            <xsl:when test="$languageOption = 'C' or $languageOption = 'c'">
                <xsl:text>._data</xsl:text>                
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>._data</xsl:text>
            </xsl:otherwise>
        </xsl:choose>                
    </xsl:variable>

    <!-- Enum Type Code -->
    <xsl:template name="generateEnumTypeCode">
        <xsl:param name="containerNamespace"/>
        <xsl:param name="enumNode"/>
        <xsl:param name="xType"/>
        
        <xsl:variable name="members" select="$enumNode/enumerator"/>
        <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace,$enumNode/@name)"/>

        <xsl:variable name="fullyQualifiedStructNameCPP">
            <xsl:for-each select="$enumNode/ancestor::module">
                <xsl:value-of select="@name"/>
                <xsl:text>::</xsl:text>                
            </xsl:for-each>
            <xsl:value-of select="$enumNode/@name"/>
        </xsl:variable>
        
        <!-- begin get_typecode function -->
        <xsl:text>&nl;</xsl:text>
        <xsl:value-of select="$typeCodeTypeName"/><xsl:text>* </xsl:text>
        <xsl:value-of select="$fullyQualifiedStructName"/>
        <xsl:text>_get_typecode()&nl;{&nl;</xsl:text>
        <xsl:text>    static RTIBool is_initialized = RTI_FALSE;&nl;&nl;</xsl:text>

        <!-- Type code members (enumerations) for the enum type-->
        <xsl:value-of select="concat('    static DDS_TypeCode_Member ',$fullyQualifiedStructName,'_g_tc_members[')"/>                
        <xsl:value-of select="count($members)"/><xsl:text>] =&nl;</xsl:text>
        <xsl:text>    {&nl;</xsl:text>

        <xsl:for-each select="$members">
            <xsl:variable name="indent" select="'        '"/>
            <xsl:call-template name="getMemberCode">
                <xsl:with-param name="fullyQualifiedStructureName" select="$fullyQualifiedStructName"/>
                <xsl:with-param name="member" select="."/>
                <xsl:with-param name="indent" select="$indent"/>
            </xsl:call-template>        
            <xsl:if test="not(position()=last())">
                <xsl:text>,&nl;</xsl:text>
            </xsl:if>
        </xsl:for-each>
    
        <xsl:text>&nl;    };&nl;&nl;</xsl:text>
    
        <!-- Type code -->    
        <xsl:value-of select="concat('    static ',$typeCodeTypeName,' ',$fullyQualifiedStructName,'_g_tc = ')"/>
        <xsl:text>&nl;    {</xsl:text><xsl:value-of select="$openBracket"/><xsl:text>&nl;</xsl:text>        
        <xsl:text>        DDS_TK_ENUM</xsl:text>

        <xsl:choose>
            <xsl:when test="$xType='FINAL_EXTENSIBILITY'">
                <xsl:text> | DDS_TK_FINAL_EXTENSIBILITY, /* Kind */&nl;</xsl:text>
            </xsl:when>
            <xsl:when test="$xType='MUTABLE_EXTENSIBILITY'">
                <xsl:text> | DDS_TK_MUTABLE_EXTENSIBILITY, /* Kind */&nl;</xsl:text>
            </xsl:when>
            <xsl:otherwise><xsl:text>, /* Kind */&nl;</xsl:text></xsl:otherwise>
        </xsl:choose>

        <xsl:text>        DDS_BOOLEAN_FALSE, /* Ignored */&nl;</xsl:text>
        <xsl:text>        -1, /* Ignored */&nl;</xsl:text>
        <xsl:text>        (char *)"</xsl:text><xsl:value-of select="$fullyQualifiedStructNameCPP"/>
        <xsl:text>", /* Name */&nl;</xsl:text>
        <xsl:text>        NULL, /* Ignored */&nl;</xsl:text>
        <xsl:text>        0, /* Ignored */&nl;</xsl:text>
        <xsl:text>        0, /* Ignored */&nl;</xsl:text>
        <xsl:text>        NULL, /* Ignored */&nl;</xsl:text>
        <xsl:text>        </xsl:text><xsl:value-of select="count($members)"/><xsl:text>, /* Number of enumerators */&nl;</xsl:text>
        <xsl:text>        </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/>
        <xsl:text>_g_tc_members, /* Enumerators */&nl;</xsl:text>
        <xsl:text>        DDS_VM_NONE /* Ignored */&nl;</xsl:text>
        <xsl:value-of select="$closeBracket"/><xsl:text>    };&nl;&nl;</xsl:text>

        <!-- check if type code is initialized -->
        <xsl:text>    if (is_initialized) {&nl;</xsl:text>
        <xsl:text>        return &amp;</xsl:text>
        <xsl:value-of select="$fullyQualifiedStructName"/>
        <xsl:text>_g_tc;&nl;    }&nl;</xsl:text>

        <!-- end get_typecode function -->
        <xsl:text>&nl;</xsl:text>
        <xsl:text>    is_initialized = RTI_TRUE;&nl;</xsl:text>
        <xsl:text>    return &amp;</xsl:text>
        <xsl:value-of select="$fullyQualifiedStructName"/>
        <xsl:text>_g_tc;&nl;}&nl;</xsl:text>

    </xsl:template>

    <!-- Struct Type Code -->
    <xsl:template name="generateStructTypeCode">
        <xsl:param name="containerNamespace"/>
        <xsl:param name="structNode"/>
        <xsl:param name="xType"/>

        <xsl:variable name="members" select="$structNode/member"/>           
        <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace,$structNode/@name)"/>

        <xsl:variable name="fullyQualifiedStructNameCPP">
            <xsl:for-each select="$structNode/ancestor::module">
                <xsl:value-of select="@name"/>
                <xsl:text>::</xsl:text>                
            </xsl:for-each>
            <xsl:value-of select="$structNode/@name"/>
        </xsl:variable>

        <!-- begin get_typecode function -->
        <xsl:text>&nl;</xsl:text>
        <xsl:value-of select="$typeCodeTypeName"/><xsl:text>* </xsl:text>
        <xsl:value-of select="$fullyQualifiedStructName"/>
        <xsl:text>_get_typecode()&nl;{&nl;</xsl:text>
        <xsl:text>    static RTIBool is_initialized = RTI_FALSE;&nl;&nl;</xsl:text>
                
        <!-- Case labels vectors -->
        <xsl:for-each select="$members">
            <xsl:variable name="memberName" select="@name"/>
            <xsl:variable name="casesCount" select="count(./cases/case)"/>
        
            <xsl:if test="$casesCount > 1">
                <xsl:for-each select="./cases/case">
                    <xsl:variable name="value">
                        <xsl:if test="@value = 'default'">RTI_CDR_TYPE_CODE_UNION_DEFAULT_LABEL</xsl:if>
                        <xsl:if test="@value != 'default'">(DDS_Long)<xsl:value-of select="@value"/></xsl:if>
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="position()=1">                        
                            <xsl:text>    static DDS_Long </xsl:text>
                            <xsl:value-of select="$fullyQualifiedStructName"/>
                            <xsl:value-of select="concat('_g_tc_',$memberName,'_labels[',$casesCount,'] = {',$value,',')"/>
                        </xsl:when>
                        <xsl:when test="position()=last()">                        
                            <xsl:value-of select="$value"/>
                            <xsl:text>};&nl;</xsl:text>                        
                        </xsl:when>                    
                        <xsl:otherwise>                        
                            <xsl:value-of select="$value"/>
                            <xsl:text>,</xsl:text>                                                
                        </xsl:otherwise>
                    </xsl:choose>                                        
                </xsl:for-each>
            </xsl:if>        
        </xsl:for-each>

        <!-- Array dimensions vectors -->
        <xsl:for-each select="$members">
            <xsl:call-template name="getArrayDimensions">
                <xsl:with-param name="fullyQualifiedName" select="$fullyQualifiedStructName"/>
                <xsl:with-param name="member" select="."/>                        
                <xsl:with-param name="indent" select="'    '"/>
            </xsl:call-template>            
        </xsl:for-each>
                
        <!-- Declaration of members type code (only when necessary) -->
        <xsl:for-each select="$members">
            <xsl:call-template name="getTypeCodeDeclaration">
                <xsl:with-param name="fullyQualifiedName" select="$fullyQualifiedStructName"/>
                <xsl:with-param name="member" select="."/>        
                <xsl:with-param name="indent" select="'    '"/>                
            </xsl:call-template>
        </xsl:for-each>
        
        <xsl:text>&nl;</xsl:text>

        <!-- Members vector -->
        <xsl:if test="count($members) &gt; 0">
            <xsl:text>    static DDS_TypeCode_Member </xsl:text>
            <xsl:value-of select="$fullyQualifiedStructName"/>
            <xsl:text>_g_tc_members[</xsl:text>
            <xsl:value-of select="count($members)"/>
            <xsl:text>]=&nl;    {&nl;</xsl:text>
    
            <xsl:for-each select="$members">
                <xsl:variable name="indent" select="'        '"/>
                <xsl:call-template name="getMemberCode">
                    <xsl:with-param name="fullyQualifiedStructureName" select="$fullyQualifiedStructName"/>
                    <xsl:with-param name="member" select="."/>
                    <xsl:with-param name="indent" select="$indent"/>
                    <xsl:with-param name="xType" select="$xType"/>
                </xsl:call-template>        
                <xsl:if test="not(position()=last())">
                    <xsl:text>,&nl;</xsl:text>
                </xsl:if>
            </xsl:for-each>
    
            <xsl:text>&nl;    };&nl;&nl;</xsl:text>
        </xsl:if>

        <xsl:variable name="defaultIndex">
            <xsl:choose>
                <xsl:when test="$structNode/member/cases/case[@value='default']">                                
                    <xsl:for-each select="$structNode/member/cases">
                        <xsl:if test="./case[@value='default']">
                            <xsl:value-of select="position()-1"/>                                
                        </xsl:if>
                    </xsl:for-each>                               
                </xsl:when>                                                                                 
                <xsl:otherwise>
                    <xsl:text>-1</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
                
        <!-- TypeCode -->
        <xsl:variable name="indentTypeCode" select="'    '"/>
        <xsl:value-of select="concat($indentTypeCode,'static ')"/>
        <xsl:value-of select="$typeCodeTypeName"/><xsl:text> </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/>
        <xsl:text>_g_tc =&nl;</xsl:text>
        <xsl:value-of select="concat($indentTypeCode,'{')"/>
        <xsl:value-of select="$openBracket"/><xsl:text>&nl;</xsl:text>
        
        <xsl:if test="($structNode/@baseClass!='')">
                <xsl:value-of select="concat($indentTypeCode,'    ')"/><xsl:text>DDS_TK_VALUE</xsl:text>
        </xsl:if>
        <xsl:if test="not($structNode/@baseClass) or  $structNode/@baseClass=''">
            <xsl:choose>
                <xsl:when test="$structNode/@kind = 'union'">
                    <xsl:value-of select="concat($indentTypeCode,'    ')"/><xsl:text>DDS_TK_UNION</xsl:text>
                </xsl:when>
                <xsl:when test="$structNode/@kind = 'valuetype'">
                    <xsl:value-of select="concat($indentTypeCode,'    ')"/><xsl:text>DDS_TK_VALUE</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat($indentTypeCode,'    ')"/><xsl:text>DDS_TK_STRUCT</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>

        <xsl:choose>
            <xsl:when test="$xType='FINAL_EXTENSIBILITY'">
                <xsl:text> | DDS_TK_FINAL_EXTENSIBILITY,</xsl:text>
            </xsl:when>
            <xsl:when test="$xType='MUTABLE_EXTENSIBILITY'">
                <xsl:text> | DDS_TK_MUTABLE_EXTENSIBILITY,</xsl:text>
            </xsl:when>
            <xsl:otherwise><xsl:text>,</xsl:text></xsl:otherwise>
        </xsl:choose>

        <xsl:text>/* Kind */&nl;</xsl:text>
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>
        <xsl:text>DDS_BOOLEAN_FALSE, /* Ignored */&nl;</xsl:text>
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>
        <xsl:value-of select="$defaultIndex"/>

        <xsl:choose>
            <xsl:when test="$structNode/@kind = 'union'">
                <xsl:text>,/* Default index */&nl;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>,/* Ignored */&nl;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>
        <xsl:text>(char *)"</xsl:text><xsl:value-of select="$fullyQualifiedStructNameCPP"/>
        <xsl:text>", /* Name */&nl;</xsl:text>
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>
        
        <xsl:choose>
            <xsl:when test="$structNode/@kind = 'union'">
                <xsl:text>NULL, /* Discriminator type code is assigned later */&nl;</xsl:text>
            </xsl:when>
            <xsl:when test="$structNode/@kind = 'valuetype' or ($structNode/@kind = 'struct' and  $structNode/@baseClass!='')">
                <xsl:text>NULL, /* Base class type code is assigned later */&nl;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>NULL, /* Ignored */&nl;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>

        <xsl:value-of select="concat($indentTypeCode,'    ')"/>
        <xsl:text>0, /* Ignored */&nl;</xsl:text>
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>        
        <xsl:text>0, /* Ignored */&nl;</xsl:text>
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>        
        <xsl:text>NULL, /* Ignored */&nl;</xsl:text>
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>        
        <xsl:value-of select="count($members)"/>
        <xsl:text>, /* Number of members */&nl;</xsl:text>
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>

        <xsl:choose>
            <xsl:when test="count($members) &gt; 0">
                <xsl:value-of select="$fullyQualifiedStructName"/>
                <xsl:text>_g_tc_members, /* Members */&nl;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>NULL, /* Members */&nl;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>

        <xsl:value-of select="concat($indentTypeCode,'    ')"/>
        
        <xsl:choose>
            <xsl:when test="$structNode/@kind = 'valuetype'">
                <xsl:choose>
                    <xsl:when test="$structNode/@typeModifier = 'custom'">
                        <xsl:text>DDS_VM_CUSTOM</xsl:text>
                    </xsl:when>
                    <xsl:when test="$structNode/@typeModifier = 'truncatable'">
                        <xsl:text>DDS_VM_TRUNCATABLE</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>DDS_VM_NONE</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text> /* Type Modifier */&nl;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>DDS_VM_NONE /* Ignored */&nl;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>

        <xsl:value-of select="$indentTypeCode"/>
        <xsl:value-of select="$closeBracket"/>
        <xsl:text>}; /* Type code for </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/> 
        <xsl:text>*/&nl;</xsl:text>

        <!-- check if type code is initialized -->
        <xsl:text>&nl;    if (is_initialized) {&nl;</xsl:text>
        <xsl:text>        return &amp;</xsl:text>
        <xsl:value-of select="$fullyQualifiedStructName"/>
        <xsl:text>_g_tc;&nl;    }&nl;</xsl:text>

        <!-- initialize declaration of members type code (only when necessary) -->
        <xsl:text>&nl;</xsl:text>
        <xsl:for-each select="$members">
            <xsl:call-template name="initializeTypeCodeDeclaration">
                <xsl:with-param name="fullyQualifiedName" select="$fullyQualifiedStructName"/>
                <xsl:with-param name="member" select="."/>        
                <xsl:with-param name="indent" select="'    '"/>
            </xsl:call-template>
        </xsl:for-each>

        <!-- initialize type code in member vector -->
        <xsl:text>&nl;</xsl:text>
        <xsl:for-each select="$members">
            <xsl:variable name="indent" select="'    '"/>
            <xsl:call-template name="initializeMemberCode">
                <xsl:with-param name="fullyQualifiedStructureName" select="$fullyQualifiedStructName"/>
                <xsl:with-param name="member" select="."/>
                <xsl:with-param name="memberIndex" select="position()-1"/>
                <xsl:with-param name="indent" select="$indent"/>
            </xsl:call-template>        
        </xsl:for-each>

        <!-- initialize type code for union kind -->
        <xsl:if test="$structNode/@kind = 'union'">
            <xsl:text>&nl;    </xsl:text>
            <xsl:value-of select="$fullyQualifiedStructName"/>
            <xsl:text>_g_tc</xsl:text>
            <xsl:value-of select="$dataName"/>
            <xsl:text>._typeCode = </xsl:text>
            <xsl:call-template name="getTypeCodeReference">
                <xsl:with-param name="fullyQualifiedName" select="$fullyQualifiedStructName"/>
                <xsl:with-param name="member" select="$structNode/discriminator"/>
                <xsl:with-param name="indent" select="''"/>
            </xsl:call-template>
            <xsl:text>; /* Discriminator type code */&nl;</xsl:text>
        </xsl:if>

        <!-- initialize base class for value type, or inheriting struct  -->
        <xsl:if test="$structNode/@kind = 'valuetype' or ($structNode/@kind = 'struct' and $structNode/@baseClass!='')"> 
            <xsl:text>&nl;    </xsl:text>           
            <xsl:value-of select="$fullyQualifiedStructName"/>
            <xsl:text>_g_tc</xsl:text>
            <xsl:value-of select="$dataName"/>
            <xsl:text>._typeCode = (RTICdrTypeCode *)</xsl:text>
            <xsl:if test="$structNode/@baseClass != ''">
                <xsl:value-of select="$structNode/@baseClass"/><xsl:text>_get_typecode()</xsl:text>
            </xsl:if>
            <xsl:if test="$structNode/@baseClass = ''">
                <xsl:text>&amp;DDS_g_tc_null</xsl:text>
            </xsl:if>
            <xsl:text>; /* Base class */&nl;</xsl:text>
        </xsl:if>

        <!-- end get_typecode function -->
        <xsl:text>&nl;    is_initialized = RTI_TRUE;&nl;</xsl:text>
        <xsl:text>&nl;    return &amp;</xsl:text>
        <xsl:value-of select="$fullyQualifiedStructName"/>
        <xsl:text>_g_tc;&nl;}&nl;</xsl:text>
        
    </xsl:template>


    <!-- Typedef typecode -->
    <xsl:template name="generateTypedefTypeCode">
        <xsl:param name="containerNamespace"/>
        <xsl:param name="typedefNode"/>

        <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace,$typedefNode/@name)"/>

        <xsl:variable name="fullyQualifiedStructNameCPP">
            <xsl:for-each select="$typedefNode/ancestor::module">
                <xsl:value-of select="@name"/>
                <xsl:text>::</xsl:text>                
            </xsl:for-each>
            <xsl:value-of select="$typedefNode/@name"/>
        </xsl:variable>
        
        <xsl:variable name="pointer">
            <xsl:choose>
                <xsl:when test="$typedefNode/member/@pointer = 'yes'">DDS_BOOLEAN_TRUE</xsl:when>            
                <xsl:otherwise>DDS_BOOLEAN_FALSE</xsl:otherwise>
            </xsl:choose>                                
        </xsl:variable>

        <!-- begin get_typecode function -->
        <xsl:text>&nl;</xsl:text>
        <xsl:value-of select="$typeCodeTypeName"/><xsl:text>* </xsl:text>
        <xsl:value-of select="$fullyQualifiedStructName"/>
        <xsl:text>_get_typecode()&nl;{&nl;</xsl:text>
        <xsl:text>    static RTIBool is_initialized = RTI_FALSE;&nl;&nl;</xsl:text>
        
        <!-- Array dimensions -->
        <xsl:call-template name="getArrayDimensions">
            <xsl:with-param name="fullyQualifiedName" select="$fullyQualifiedStructName"/>
            <xsl:with-param name="member" select="$typedefNode/member"/>                        
            <xsl:with-param name="indent" select="'    '"/>            
        </xsl:call-template>        
                        
        <!-- declaration of aliased type code (only if necessary)-->
        <xsl:call-template name="getTypeCodeDeclaration">
            <xsl:with-param name="fullyQualifiedName" select="$fullyQualifiedStructName"/>
            <xsl:with-param name="member" select="$typedefNode/member"/>        
            <xsl:with-param name="indent" select="'    '"/>            
        </xsl:call-template>
        
        <xsl:text>&nl;</xsl:text>
                
        <!-- Type Code -->
        <xsl:variable name="indentTypeCode" select="'    '"/>
        <xsl:value-of select="concat($indentTypeCode,'static ')"/>
        <xsl:value-of select="$typeCodeTypeName"/><xsl:text> </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/>
        <xsl:text>_g_tc =&nl;</xsl:text>
        <xsl:value-of select="concat($indentTypeCode,'{')"/>        
        <xsl:value-of select="$openBracket"/><xsl:text>&nl;</xsl:text>
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>
        <xsl:text>DDS_TK_ALIAS, /* Kind*/&nl;</xsl:text>            
        <xsl:value-of select="concat($indentTypeCode,'    ',$pointer)"/>
        <xsl:text>, /* Is a pointer? */&nl;</xsl:text>
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>        
        <xsl:text>-1, /* Ignored */&nl;</xsl:text>
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>        
        <xsl:text>(char *)"</xsl:text><xsl:value-of select="$fullyQualifiedStructNameCPP"/><xsl:text>", /* Name */&nl;</xsl:text>
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>
        <xsl:text>NULL, /* Content type code is assigned later */&nl;</xsl:text>
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>        
        <xsl:text>0, /* Ignored */&nl;</xsl:text>
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>        
        <xsl:text>0, /* Ignored */&nl;</xsl:text>    
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>        
        <xsl:text>NULL, /* Ignored */&nl;</xsl:text> 
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>        
        <xsl:text>0, /* Ignored */&nl;</xsl:text>    
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>        
        <xsl:text>NULL, /* Ignored */&nl;</xsl:text>             
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>        
        <xsl:text>DDS_VM_NONE /* Ignored */&nl;</xsl:text>
        <xsl:value-of select="$indentTypeCode"/>             
        <xsl:value-of select="$closeBracket"/>
        <xsl:text>}; /* Type code for </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/><xsl:text> */&nl;</xsl:text>

        <!-- check if type code is initialized -->
        <xsl:text>&nl;    if (is_initialized) {&nl;</xsl:text>
        <xsl:text>        return &amp;</xsl:text>
        <xsl:value-of select="$fullyQualifiedStructName"/>
        <xsl:text>_g_tc;&nl;    }&nl;</xsl:text>

        <!-- initialize declaration of aliased type code (only if necessary)-->
        <xsl:text>&nl;</xsl:text>
        <xsl:call-template name="initializeTypeCodeDeclaration">
            <xsl:with-param name="fullyQualifiedName" select="$fullyQualifiedStructName"/>
            <xsl:with-param name="member" select="$typedefNode/member"/>        
            <xsl:with-param name="indent" select="'    '"/>
        </xsl:call-template>

        <!-- Initialize type Code -->
        <xsl:text>    </xsl:text>
        <xsl:value-of select="$fullyQualifiedStructName"/>
        <xsl:text>_g_tc</xsl:text>
        <xsl:value-of select="$dataName"/>
        <xsl:text>._typeCode = </xsl:text>
        <xsl:call-template name="getTypeCodeReference">
            <xsl:with-param name="fullyQualifiedName" select="$fullyQualifiedStructName"/>
            <xsl:with-param name="member" select="$typedefNode/member"/>
            <xsl:with-param name="indent" select="''"/>
        </xsl:call-template><xsl:text>; /* Content type code */&nl;</xsl:text>

        <!-- end get_typecode function -->
        <xsl:text>&nl;    is_initialized = RTI_TRUE;&nl;</xsl:text>
        <xsl:text>&nl;    return &amp;</xsl:text>
        <xsl:value-of select="$fullyQualifiedStructName"/>
        <xsl:text>_g_tc;&nl;}&nl;</xsl:text>

    </xsl:template>

    <!-- Bitset typecode -->
    <xsl:template name="generateBitsetTypeCode">
        <xsl:param name="containerNamespace"/>
        <xsl:param name="bitsetNode"/>

        <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace,$bitsetNode/@name)"/>

        <xsl:variable name="fullyQualifiedStructNameCPP">
            <xsl:for-each select="$bitsetNode/ancestor::module">
                <xsl:value-of select="@name"/>
                <xsl:text>::</xsl:text>                
            </xsl:for-each>
            <xsl:value-of select="$bitsetNode/@name"/>
        </xsl:variable>

        <!-- begin get_typecode function -->
        <xsl:text>&nl;</xsl:text>
        <xsl:value-of select="$typeCodeTypeName"/><xsl:text>* </xsl:text>
        <xsl:value-of select="$fullyQualifiedStructName"/>
        <xsl:text>_get_typecode()&nl;{&nl;</xsl:text>
        <xsl:text>    static RTIBool is_initialized = RTI_FALSE;&nl;&nl;</xsl:text>

        <!-- Type Code -->
        <xsl:variable name="indentTypeCode" select="'    '"/>
        <xsl:value-of select="concat($indentTypeCode,'static ')"/>
        <xsl:value-of select="$typeCodeTypeName"/><xsl:text> </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/>
        <xsl:text>_g_tc =&nl;</xsl:text>
        <xsl:value-of select="concat($indentTypeCode,'{')"/>        
        <xsl:value-of select="$openBracket"/><xsl:text>&nl;</xsl:text>
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>
        <xsl:text>DDS_TK_ALIAS, /* Kind*/&nl;</xsl:text>       
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>     
        <xsl:text>DDS_BOOLEAN_FALSE, /* Is a pointer? */&nl;</xsl:text>
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>        
        <xsl:text>-1, /* Ignored */&nl;</xsl:text>
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>        
        <xsl:text>(char *)"</xsl:text><xsl:value-of select="$fullyQualifiedStructNameCPP"/><xsl:text>", /* Name */&nl;</xsl:text>
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>
        <xsl:text>NULL, /* Content type code is assigned later */&nl;</xsl:text>
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>        
        <xsl:text>0, /* Ignored */&nl;</xsl:text>
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>        
        <xsl:text>0, /* Ignored */&nl;</xsl:text>    
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>        
        <xsl:text>NULL, /* Ignored */&nl;</xsl:text> 
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>        
        <xsl:text>0, /* Ignored */&nl;</xsl:text>    
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>        
        <xsl:text>NULL, /* Ignored */&nl;</xsl:text>             
        <xsl:value-of select="concat($indentTypeCode,'    ')"/>        
        <xsl:text>DDS_VM_NONE /* Ignored */&nl;</xsl:text>
        <xsl:value-of select="$indentTypeCode"/>             
        <xsl:value-of select="$closeBracket"/>
        <xsl:text>}; /* Type code for </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/><xsl:text> */&nl;</xsl:text>

        <!-- check if type code is initialized -->
        <xsl:text>&nl;    if (is_initialized) {&nl;</xsl:text>
        <xsl:text>        return &amp;</xsl:text>
        <xsl:value-of select="$fullyQualifiedStructName"/>
        <xsl:text>_g_tc;&nl;    }&nl;</xsl:text>

        <!-- initialize declaration of aliased type code (only if necessary)-->
        <xsl:text>&nl;</xsl:text>

        <!-- Initialize type Code -->
        <xsl:text>    </xsl:text>
        <xsl:value-of select="$fullyQualifiedStructName"/>
        <xsl:text>_g_tc</xsl:text>
        <xsl:value-of select="$dataName"/>
        <xsl:text>._typeCode = (RTICdrTypeCode *)&amp;</xsl:text>

        <xsl:variable name="bitsetIntType">
            <xsl:choose>
                <xsl:when test="($bitsetNode/@bitBound &gt; 0) and ($bitsetNode/@bitBound &lt; 9)">
                    <xsl:text>octet</xsl:text>
                </xsl:when>
                <xsl:when test="($bitsetNode/@bitBound &gt; 8) and ($bitsetNode/@bitBound &lt; 17)">
                    <xsl:text>unsignedshort</xsl:text>
                </xsl:when>
                <xsl:when test="($bitsetNode/@bitBound &gt; 16) and ($bitsetNode/@bitBound &lt; 33)">
                    <xsl:text>unsignedlong</xsl:text>
                </xsl:when>
                <xsl:when test="($bitsetNode/@bitBound &gt; 32) and ($bitsetNode/@bitBound &lt; 65)">
                    <xsl:text>unsignedlonglong</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:message terminate="yes"> <!-- unaccebtable  value-->
Error. Invalid value for "bitBound" directive associated to <xsl:value-of select="$fullyQualifiedStructName"/> enum.
Valid range is 1-64.
                    </xsl:message>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:call-template name="obtainTypeCodeVar">
            <xsl:with-param name="idlType" select="$bitsetIntType"/>
        </xsl:call-template>
        <xsl:text>; /* Content type code */&nl;</xsl:text>

        <!-- end get_typecode function -->
        <xsl:text>&nl;    is_initialized = RTI_TRUE;&nl;</xsl:text>
        <xsl:text>&nl;    return &amp;</xsl:text>
        <xsl:value-of select="$fullyQualifiedStructName"/>
        <xsl:text>_g_tc;&nl;}&nl;</xsl:text>

    </xsl:template>

    <!-- 
    **************************************************************************************
      Type Code templates
    **************************************************************************************
    -->
    
    <!--
    -->
    <xsl:template name="obtainTypeCodeVar">
        <xsl:param name="idlType"/>        	
        <xsl:variable name="typeNode" select="$typeInfoMap/type[@idlType=$idlType]"/>
        <xsl:value-of select="$typeNode/@typeCode"/>
    </xsl:template>
    
    <!--
    -->
    <xsl:template name="getFilteredMemberKind">        
        <xsl:param name="member"/>
        <xsl:param name="filter" select="''"/>
        
        <xsl:choose>
            <xsl:when test="$member[cardinality] and $member[@kind = 'sequence'] and 
                            $filter!='arraySequence' and $filter!='array' and $filter!='sequence'">arraySequence</xsl:when>
            <xsl:when test="$member[cardinality] and $filter!='arraySequence' and $filter!='array' and
                            $filter!='sequence'">array</xsl:when>
            <xsl:when test="$member[@kind = 'sequence' and $filter!='sequence']">sequence</xsl:when>        
            <xsl:when test="$member[@type='string']">string</xsl:when>
            <xsl:when test="$member[@type='wstring']">wstring</xsl:when>    
            <xsl:when test="$member[@bitField]">bitfield</xsl:when>            
            <xsl:otherwise>scalar</xsl:otherwise>
        </xsl:choose>
    </xsl:template>
        
    <!--
    -->
    <xsl:template name="getArrayDimensions">
        <xsl:param name="fullyQualifiedName"/>
        <xsl:param name="member"/>            
        <xsl:param name="indent"/>            
                                   
        <xsl:variable name="dimensions" select="count($member/cardinality/dimension)"/>
        
        <xsl:variable name="name">
            <xsl:if test="$member/@name">
                <xsl:text>_</xsl:text><xsl:value-of select="$member/@name"/>
            </xsl:if>
        </xsl:variable> 
            
        <xsl:if test="$dimensions > 1">
            <xsl:for-each select="$member/cardinality/dimension">
                <xsl:choose>
                    <xsl:when test="position()=1">                        
                        <xsl:value-of select="$indent"/>
                        <xsl:text>static DDS_UnsignedLong </xsl:text>
                        <xsl:value-of select="$fullyQualifiedName"/>
                        <xsl:value-of select="concat('_g_tc',$name,'_dimensions[',$dimensions,'] = {',./@size,',')"/>
                    </xsl:when>
                    <xsl:when test="position()=last()">                        
                        <xsl:value-of select="./@size"/>
                        <xsl:text>};&nl;</xsl:text>                        
                    </xsl:when>                    
                    <xsl:otherwise>                        
                        <xsl:value-of select="./@size"/>
                        <xsl:text>,</xsl:text>                                                
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>          
        </xsl:if>                            
    </xsl:template>

    <!--
        @brief The following template declare a type code when the member is:
               string,wstring, array or sequence
    -->
    <xsl:template name="getTypeCodeDeclaration">
        <xsl:param name="fullyQualifiedName"/>
        <xsl:param name="member"/>
        <xsl:param name="indent"/>    
        <xsl:param name="container" select="''"/>
            
        <xsl:variable name="memberKind">
            <xsl:call-template name="getFilteredMemberKind">
                <xsl:with-param name="member" select="$member"/>
                <xsl:with-param name="filter" select="$container"/>
            </xsl:call-template>
        </xsl:variable>        
        
        <xsl:variable name="tcName">
            <xsl:value-of select="$indent"/>
            <xsl:text>static </xsl:text>
            <xsl:value-of select="$typeCodeTypeName"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="$fullyQualifiedName"/>
            <xsl:text>_g_tc_</xsl:text>
            
            <xsl:if test="$member/@name">
                <xsl:value-of select="concat($member/@name,'_')"/>                
            </xsl:if>
    
            <xsl:if test="$memberKind='array' or $memberKind='arraySequence'">array</xsl:if>
            <xsl:if test="$memberKind='sequence'">sequence</xsl:if>                                    
            <xsl:if test="$memberKind='string' or $memberKind='wstring'">string</xsl:if>                                                                        
        </xsl:variable>
            
        <xsl:choose>
            <xsl:when test="$memberKind='string' or $memberKind='wstring'">
                <xsl:value-of select="$tcName"/>
                
                <xsl:if test="$member/@type='string'">
                    <xsl:text> = </xsl:text>
                    <xsl:text>DDS_INITIALIZE_STRING_TYPECODE(</xsl:text>
                </xsl:if>
                <xsl:if test="$member/@type='wstring'">
                    <xsl:text> = </xsl:text>
                    <xsl:text>DDS_INITIALIZE_WSTRING_TYPECODE(</xsl:text>
                </xsl:if>
                <xsl:value-of select="$member/@maxLengthString"/>
                <xsl:text>)</xsl:text><xsl:text>;&nl;</xsl:text>
            </xsl:when>
            <xsl:when test="$memberKind='sequence' or $memberKind='array' or $memberKind='arraySequence'">
    
                <xsl:if test="$memberKind='sequence' or $memberKind='array'">
                    <xsl:if test="$member/@type='string' or $member/@type='wstring'">                
                        <xsl:call-template name="getTypeCodeDeclaration">
                            <xsl:with-param name="fullyQualifiedName" select="$fullyQualifiedName"/>
                            <xsl:with-param name="member" select="$member"/>
                            <xsl:with-param name="indent" select="$indent"/>
                            <xsl:with-param name="container" select="$memberKind"/>
                        </xsl:call-template>                
                    </xsl:if>                
                </xsl:if>
    
                <xsl:if test="$memberKind='arraySequence'">
                    <xsl:call-template name="getTypeCodeDeclaration">
                        <xsl:with-param name="fullyQualifiedName" select="$fullyQualifiedName"/>
                        <xsl:with-param name="member" select="$member"/>
                        <xsl:with-param name="indent" select="$indent"/>                    
                        <xsl:with-param name="container" select="$memberKind"/>
                    </xsl:call-template>                                
                </xsl:if>
                            
                <xsl:value-of select="$tcName"/>
    
                <xsl:if test="$memberKind='array' or $memberKind='arraySequence'">
                    <xsl:variable name="dimensionsCount">
                        <xsl:value-of select="count($member/cardinality/dimension)"/>       
                    </xsl:variable>
                    
                    <xsl:variable name="name">
                        <xsl:if test="$member/@name">
                            <xsl:text>_</xsl:text><xsl:value-of select="$member/@name"/>
                        </xsl:if>
                    </xsl:variable> 
                    
                    <xsl:text> = </xsl:text>
                    <xsl:text>DDS_INITIALIZE_ARRAY_TYPECODE(</xsl:text>            
                    <xsl:value-of select="$dimensionsCount"/>
                    <xsl:text>,</xsl:text>            
                    <xsl:value-of select="$member/cardinality/dimension[1]/@size"/>
                    <xsl:text>,</xsl:text>            
                    
                    <xsl:if test="$dimensionsCount > 1">
                        <xsl:value-of select="$fullyQualifiedName"/>
                        <xsl:value-of select="concat('_g_tc',$name,'_dimensions,')"/>                                            
                    </xsl:if>                
                    <xsl:if test="$dimensionsCount = 1">NULL,</xsl:if>
    
                    <!-- type code is assigned later with getTypeCodeReference -->
                    <xsl:text>NULL</xsl:text>
                </xsl:if>
                
                <xsl:if test="$memberKind='sequence'">                
                    <xsl:text> = </xsl:text>
                    <xsl:text>DDS_INITIALIZE_SEQUENCE_TYPECODE(</xsl:text>            
                    <xsl:value-of select="$member/@maxLengthSequence"/>
                    <xsl:text>,</xsl:text>            
                
                    <!-- type code is assigned later with getTypeCodeReference -->
                    <xsl:text>NULL</xsl:text>
                </xsl:if>
                
                <xsl:text>)</xsl:text><xsl:text>;&nl;</xsl:text>                                                
        
            </xsl:when>
            <xsl:otherwise></xsl:otherwise>
        </xsl:choose>                        
    </xsl:template>

    <!--
    -->
    <xsl:template name="initializeTypeCodeDeclaration">
        <xsl:param name="fullyQualifiedName"/>
        <xsl:param name="member"/>
        <xsl:param name="indent"/>
        <xsl:param name="container" select="''"/>
    
        <xsl:variable name="memberKind">
            <xsl:call-template name="getFilteredMemberKind">
                <xsl:with-param name="member" select="$member"/>
                <xsl:with-param name="filter" select="$container"/>
            </xsl:call-template>
        </xsl:variable>
    
        <xsl:variable name="tcName">
            <xsl:value-of select="$fullyQualifiedName"/>
            <xsl:text>_g_tc_</xsl:text>
            
            <xsl:if test="$member/@name">
                <xsl:value-of select="concat($member/@name,'_')"/>                
            </xsl:if>
    
            <xsl:if test="$memberKind='array' or $memberKind='arraySequence'">array</xsl:if>
            <xsl:if test="$memberKind='sequence'">sequence</xsl:if>                                    
            <xsl:if test="$memberKind='string' or $memberKind='wstring'">string</xsl:if>                                                                        
        </xsl:variable>
    
        <xsl:choose>
            <xsl:when test="$memberKind='sequence' or $memberKind='array' or $memberKind='arraySequence'">
    
                <xsl:if test="$memberKind='sequence' or $memberKind='array'">
                    <xsl:if test="$member/@type='string' or $member/@type='wstring'">                
                        <xsl:call-template name="initializeTypeCodeDeclaration">
                            <xsl:with-param name="fullyQualifiedName" select="$fullyQualifiedName"/>
                            <xsl:with-param name="member" select="$member"/>
                            <xsl:with-param name="indent" select="$indent"/>
                            <xsl:with-param name="container" select="$memberKind"/>
                        </xsl:call-template>                
                    </xsl:if>                
                </xsl:if>
                
                <xsl:if test="$memberKind='arraySequence'">
                    <xsl:call-template name="initializeTypeCodeDeclaration">
                        <xsl:with-param name="fullyQualifiedName" select="$fullyQualifiedName"/>
                        <xsl:with-param name="member" select="$member"/>
                        <xsl:with-param name="indent" select="$indent"/>
                        <xsl:with-param name="container" select="$memberKind"/>
                    </xsl:call-template>                                
                </xsl:if>
    
                <!-- output starts here -->
                <xsl:value-of select="$indent"/>
                <xsl:value-of select="$tcName"/>
                <xsl:value-of select="$dataName"/>
                <xsl:text>._typeCode = </xsl:text>
                <xsl:call-template name="getTypeCodeReference">
                    <xsl:with-param name="fullyQualifiedName" select="$fullyQualifiedName"/>
                        <xsl:with-param name="member" select="$member"/>
                        <xsl:with-param name="indent" select="''"/>
                        <xsl:with-param name="container" select="$memberKind"/>
                    </xsl:call-template>
                <xsl:text>;&nl;</xsl:text>
                
            </xsl:when>
            <xsl:otherwise></xsl:otherwise>
        </xsl:choose>                        
    
    </xsl:template>

    <!--
    -->
    <xsl:template name="getTypeCodeReference">
        <xsl:param name="fullyQualifiedName"/>
        <xsl:param name="member"/>
        <xsl:param name="indent"/>
        <xsl:param name="container" select="''"/>
        
        <xsl:variable name="memberKind">
            <xsl:call-template name="getFilteredMemberKind">
                <xsl:with-param name="member" select="$member"/>
                <xsl:with-param name="filter" select="$container"/>
            </xsl:call-template>
        </xsl:variable>        
        
        <xsl:variable name="typeKind">
            <xsl:call-template name="obtainTypeKind">
                <xsl:with-param name="member" select="$member"/>
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:variable name="typeCodeVar">
            <xsl:call-template name="obtainTypeCodeVar">
                <xsl:with-param name="idlType" select="$member/@type"/>
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:value-of select="$indent"/>
        
        <xsl:choose>
            <xsl:when test="$memberKind='string' or $memberKind='wstring'">
                <xsl:text>(RTICdrTypeCode *)&amp;</xsl:text>                    
                <xsl:if test="$member/@name">
                    <xsl:value-of select="concat($fullyQualifiedName,'_g_tc_',$member/@name,'_string')"/>                            
                </xsl:if>                            
                <xsl:if test="not($member/@name)"> <!-- typedef -->
                    <xsl:value-of select="concat($fullyQualifiedName,'_g_tc_string')"/>                            
                </xsl:if>                                        
            </xsl:when>
            <xsl:when test="$memberKind='scalar'  and $typeKind='user'">
                <xsl:text>(RTICdrTypeCode *)</xsl:text>
                <xsl:value-of select="concat($member/@type, '_get_typecode()')"/>
            </xsl:when>
            <xsl:when test="$memberKind='scalar' and $typeKind='builtin'">
                <xsl:text>(RTICdrTypeCode *)&amp;</xsl:text>                    
                <xsl:value-of select="$typeCodeVar"/>
            </xsl:when>
            <xsl:when test="$memberKind='bitfield'">
                <xsl:text>(RTICdrTypeCode *)</xsl:text>                    
                <xsl:if test="$typeCodeVar != ''">
                    <xsl:text>&amp;</xsl:text>    
                    <xsl:value-of select="$typeCodeVar"/>
                </xsl:if>
                <xsl:if test="$typeCodeVar = ''">    
                    <xsl:value-of select="concat($member/@type,'_get_typecode()')"/>
                </xsl:if>            
            </xsl:when>        
            <xsl:when test="$memberKind='sequence' or $memberKind='array'">
                <xsl:text>(RTICdrTypeCode *)&amp;</xsl:text>                                
                <xsl:if test="$member/@name">
                    <xsl:value-of select="concat($fullyQualifiedName,'_g_tc_',$member/@name,'_',$memberKind)"/>                            
                </xsl:if>                            
                <xsl:if test="not($member/@name)"> <!-- typedef -->
                    <xsl:value-of select="concat($fullyQualifiedName,'_g_tc_',$memberKind)"/>                            
                </xsl:if>                                        
            </xsl:when>   
            <xsl:when test="$memberKind='arraySequence'">            
                <xsl:text>(RTICdrTypeCode *)&amp;</xsl:text>                                
                <xsl:if test="$member/@name">
                    <xsl:value-of select="concat($fullyQualifiedName,'_g_tc_',$member/@name,'_array')"/>                            
                </xsl:if>                            
                <xsl:if test="not($member/@name)"> <!-- typedef -->
                    <xsl:value-of select="concat($fullyQualifiedName,'_g_tc_array')"/>                            
                </xsl:if>                                        
            </xsl:when>                        
            <xsl:otherwise>
                <xsl:text>NULL</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!--
    -->
    <xsl:template name="getMemberCode">
        <xsl:param name="fullyQualifiedStructureName"/>
        <xsl:param name="member"/>
        <xsl:param name="indent"/>
        <xsl:param name="xType"/>
        
        <xsl:variable name="cases" select="$member/cases/case"/>
        
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
        
        <xsl:variable name="typeCodeVar">
            <xsl:call-template name="obtainTypeCodeVar">
                <xsl:with-param name="idlType" select="$member/@type"/>
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:variable name="pointer">
            <xsl:choose>
                <xsl:when test="$member/@pointer = 'yes'">DDS_BOOLEAN_TRUE</xsl:when>            
                <xsl:otherwise>DDS_BOOLEAN_FALSE</xsl:otherwise>
            </xsl:choose>                                
        </xsl:variable>
    
        <xsl:variable name="key">
            <xsl:choose>
                <xsl:when test="./following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'key']">
                    <xsl:text>DDS_BOOLEAN_TRUE</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>DDS_BOOLEAN_FALSE</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
                                
        <xsl:value-of select="$indent"/>
        <xsl:text>{&nl;</xsl:text>
    
        <!-- name -->
        <xsl:value-of select="concat($indent,'&indent;')"/>
        <xsl:text>(char *)"</xsl:text><xsl:value-of select="@name"/>
        <xsl:text>",/* Member name */&nl;</xsl:text>
                    
        <xsl:if test="name($member/..)!='enum'">
            <!-- representation -->
            <xsl:value-of select="concat($indent,'&indent;')"/>
            <xsl:text>{&nl;</xsl:text>

            <!-- pid -->
            <xsl:value-of select="concat($indent,'&indent;&indent;')"/>
            
            <xsl:if test="not($member/@memberId)">
                <xsl:text>0</xsl:text>
            </xsl:if>
            <xsl:if test="$member/@memberId">
                <xsl:value-of select="$member/@memberId"/>
            </xsl:if>
            <xsl:text>,/* Representation ID */&nl;</xsl:text>
            
            <!-- isPointer -->
            <xsl:value-of select="concat($indent,'&indent;&indent;',$pointer,',')"/>
            <xsl:text>/* Is a pointer? */&nl;</xsl:text>        
            <!-- bitfields bits -->
            <xsl:value-of select="concat($indent,'&indent;&indent;')"/>
            <xsl:if test="$memberKind='bitfield'">                
                <xsl:value-of select="$member/@bitField"/><xsl:text>, /* Bitfield bits */&nl;</xsl:text>                            
            </xsl:if>
            <xsl:if test="$memberKind!='bitfield'">                
                <xsl:text>-1, /* Bitfield bits */&nl;</xsl:text>                            
            </xsl:if>        
            <!-- type code -->
            <xsl:value-of select="concat($indent,'&indent;&indent;')"/>
            <xsl:text>NULL/* Member type code is assigned later */&nl;</xsl:text>

            <!-- end representation -->
            <xsl:value-of select="concat($indent,'&indent;')"/>
            <xsl:text>},&nl;</xsl:text>

            <!-- ordinal -->
            <xsl:value-of select="concat($indent,'&indent;')"/>
            <xsl:text>0, /* Ignored */&nl;</xsl:text>
        </xsl:if>
        
        <xsl:if test="name($member/..)='enum'">  
            <!-- representation -->
            <xsl:value-of select="concat($indent,'&indent;')"/>
            <xsl:text>{&nl;</xsl:text>

            <!-- pid -->
            <xsl:value-of select="concat($indent,'&indent;&indent;')"/>
            <xsl:text>0,/* Ignored */&nl;</xsl:text>
            <!-- isPointer -->
            <xsl:value-of select="concat($indent,'&indent;&indent;')"/>
            <xsl:text>DDS_BOOLEAN_FALSE, /* Ignored */&nl;</xsl:text>
            <!-- bitfields bits -->
            <xsl:value-of select="concat($indent,'&indent;&indent;')"/>
            <xsl:text>-1, /* Ignored */&nl;</xsl:text>                        
            <!-- type code -->      
            <xsl:value-of select="concat($indent,'&indent;&indent;')"/>
            <xsl:text>NULL /* Ignored */&nl;</xsl:text>

            <!-- end representation -->
            <xsl:value-of select="concat($indent,'&indent;')"/>
            <xsl:text>},&nl;</xsl:text>

            <!-- ordinal -->
            <xsl:value-of select="concat($indent,'&indent;')"/>
            <xsl:if test="$language='C++/CLI'">
                <!--
                C++/CLI requires enumerated constants to be prefixed with the
                name of their type. It also requires the enum-to-integer
                conversion to be explicit.
                -->
                <xsl:text>(RTICdrLong) </xsl:text>
                <xsl:value-of select="$member/../@name"/>
                <xsl:text>::</xsl:text>
            </xsl:if>
            <xsl:value-of select="$member/@name"/><xsl:text>, /* Enumerator ordinal */&nl;</xsl:text>            
        </xsl:if>
                                
        <xsl:choose>
            <xsl:when test="$member/../@kind='union'">
                <!-- labels count -->
                <xsl:value-of select="concat($indent,'&indent;')"/>
                <xsl:value-of select="count($cases)"/>
                <xsl:text>, /* Number of labels */&nl;</xsl:text>
                <!-- first label -->
                <xsl:value-of select="concat($indent,'&indent;')"/>            
                <xsl:if test="$cases[1]/@value='default'">
                    <xsl:value-of select="'RTI_CDR_TYPE_CODE_UNION_DEFAULT_LABEL'"/>
                </xsl:if>
                <xsl:if test="not($cases[1]/@value='default')">
                    <xsl:if test="$language='C++/CLI'">
                        <!--
                        C++/CLI requires the enum-to-integer conversion to be
                        explicit.
                        -->
                        <xsl:text>static_cast&lt;RTICdrLong&gt;(</xsl:text>
                    </xsl:if>
                    <xsl:value-of select="$cases[1]/@value"/>
                    <xsl:if test="$language='C++/CLI'">
                        <xsl:text>)</xsl:text>
                    </xsl:if>
                </xsl:if>
                <xsl:text>, /* First label */&nl;</xsl:text>
                <!-- labels -->
                <xsl:value-of select="concat($indent,'&indent;')"/>                
                <xsl:if test="count($cases) > 1">
                    <xsl:value-of select="concat($fullyQualifiedStructureName,'_g_tc_',$member/@name,'_labels')"/>
                    <xsl:text>, /* Labels (it is NULL when there is only one label)*/&nl;</xsl:text>
                </xsl:if>
                <xsl:if test="count($cases) &lt; 2">
                    <xsl:text>NULL, /* Labels (it is NULL when there is only one label)*/&nl;</xsl:text>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <!-- labels count -->
                <xsl:value-of select="concat($indent,'&indent;')"/>
                <xsl:text>0, /* Ignored */&nl;</xsl:text>
                <!-- first label -->
                <xsl:value-of select="concat($indent,'&indent;')"/>            
                <xsl:text>0, /* Ignored */&nl;</xsl:text>            
                <!-- labels -->
                <xsl:value-of select="concat($indent,'&indent;')"/>
                <xsl:text>NULL, /* Ignored */&nl;</xsl:text>                    
            </xsl:otherwise>                
        </xsl:choose>
    
        <xsl:value-of select="concat($indent,'&indent;')"/>
        <xsl:choose>
            <xsl:when test="$key='DDS_BOOLEAN_TRUE'">
                <xsl:text>RTI_CDR_KEY_MEMBER</xsl:text>
            </xsl:when>
            <xsl:when test="$member/@optional='true'">
                <xsl:text>RTI_CDR_NONKEY_MEMBER</xsl:text>
            </xsl:when>
            <xsl:when test="$member/../@kind='union'">
                <xsl:text>RTI_CDR_NONKEY_MEMBER</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>RTI_CDR_REQUIRED_MEMBER</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="name($member/..)!='enum'">        
            <xsl:text>, /* Member flags */&nl;</xsl:text>
        </xsl:if>
        <xsl:if test="name($member/..)='enum'">
            <xsl:text>, /* Ignored */&nl;</xsl:text>
        </xsl:if>
    
        <xsl:value-of select="concat($indent,'&indent;')"/>
        <xsl:choose>
            <xsl:when test="$member/../@kind = 'valuetype'">
                <xsl:if test="$member/@visibility = 'public'">
                    <xsl:text>DDS_PUBLIC_MEMBER</xsl:text>
                </xsl:if>
                <xsl:if test="$member/@visibility = 'private'">
                    <xsl:text>DDS_PRIVATE_MEMBER</xsl:text>
                </xsl:if>
                <xsl:text>,/* Member visibility */&nl;</xsl:text>
            </xsl:when>
            <xsl:when test="$member/../@kind = 'struct' and $member/../@baseClass!=''">
                <xsl:text>DDS_PUBLIC_MEMBER</xsl:text><xsl:text>,/* Member visibility */&nl;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>DDS_PRIVATE_MEMBER,/* Ignored */&nl;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>

        <!-- representation count -->
        <xsl:value-of select="concat($indent,'&indent;')"/>
        <xsl:text>1,&nl;</xsl:text>
        <!-- representations -->
        <xsl:value-of select="concat($indent,'&indent;')"/>
        <xsl:text>NULL/* Ignored */&nl;</xsl:text>

        <xsl:value-of select="$indent"/>
        <xsl:text>}</xsl:text>
            
    </xsl:template>

    <!--
        Valid for struct and union members
    -->
    <xsl:template name="initializeMemberCode">
        <xsl:param name="fullyQualifiedStructureName"/>
        <xsl:param name="member"/>
        <xsl:param name="memberIndex"/>
        <xsl:param name="indent"/>
    
        <xsl:value-of select="$indent"/>
        <xsl:value-of select="$fullyQualifiedStructureName"/>
        <xsl:text>_g_tc_members[</xsl:text>
        <xsl:value-of select="$memberIndex"/>
        <xsl:text>]._representation._typeCode = </xsl:text>
    
        <xsl:call-template name="getTypeCodeReference">
            <xsl:with-param name="fullyQualifiedName" select="$fullyQualifiedStructureName"/>
            <xsl:with-param name="member" select="$member"/>
            <xsl:with-param name="indent" select="''"/>
        </xsl:call-template>
    
        <xsl:text>;&nl;</xsl:text>
    
    </xsl:template>

</xsl:stylesheet>
