<?xml version="1.0"?>
<!--
/* $Id: typeCode.java.xsl,v 1.7 2013/09/12 14:22:27 fernando Exp $

   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.

The following XSLT sheet generates Java Type Codes for the IDL types.
For each structure,union, enum or typedef NDDSGEN will generate a TypeCode class with a 
static member called VALUE to access the type code information.

public class <Type Name>TypeCode{
    public static TypeCode VALUE = getTypeCode();    
    private static TypeCode getTypeCode() {
        ...
    }    
}
 
Modification history:
- - - - - - - - - - -
5.0.1,13jun13,fcs Fixed CODEGEN-28: Incorrect type code name when using -package
5.0.1,18apr13,fcs Fixed CODEGEN-576: Generate TypeCodes with optional members (Java)
5.0.1,04nov12,fcs Fixed CODEGEN-525
5.0.0,09sep12,fcs memberId support
1.0ac,30may12,fcs XTypes support (CXTYPES-173)
1.0ac,07mar12,fcs Fixed RTI-358
1.0ac,18apr11,fcs Added generateCTypecode support
1.0ac,13apr11,fcs Fixed 13866
1.0ac,22dec10,fcs Fixed bug 12550
1.0ac,08dec10,fcs Added copy-java-begin and copy-java-declaration-begin
10m,16jul08,tk  Removed utils.xsl
10m,18oct06,fcs We don't generate type code when -notypecode option is used
10m,14aug06,fcs Fixed enums in CORBA
10m,11aug06,fcs Fixed enums
10m,23jul06,fcs JDK 1.5 support
10m,26jun06,fcs Fixed bug 11171
10m,01jun06,fcs Fixed ENUM type code for CORBA
10l,11mar06,fcs Added value type and keys support
10f,21jul05,fcs Modified processGlobalElements template call to include element parameter                
10f,20jul05,fcs Removed source preamble variable
10f,20jul05,fcs Changed the place where the template processGlobalElements is called
10f,24jun05,fcs Created
-->


<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
<!ENTITY namespaceSeperator ".">    <!-- namespace separator -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:param name="corbaHeader"/>
    <xsl:param name="typecode"/>
    <xsl:param name="addPackageToTypecode"/>
    
    <!-- Include -->
    <xsl:include href="typeCommon.java.xsl"/>

    <!-- Output -->
    <xsl:output method="xml"/>

    <!-- Type prefix -->
    <xsl:variable name="typePrefix">
        <xsl:if test="$packagePrefix and $addPackageToTypecode = 'yes'">
            <xsl:call-template name="replace-string">
	        <xsl:with-param name="text" select="$packagePrefix"/>
                <xsl:with-param name="search" select="'.'"/>
                <xsl:with-param name="replace" select="'::'"/>
            </xsl:call-template>
            <xsl:text>::</xsl:text>
        </xsl:if>
    </xsl:variable>
            
    <!--
        Template that generates the <TypeName>TypeCode class to get information about a type code.
    -->
    <xsl:template match="struct|typedef|enum">
        <xsl:param name="containerNamespace"/>
                
        <xsl:variable name="sourceFile">
            <xsl:call-template name="obtainSourceFileName">
                <xsl:with-param name="containerNamespace" select="$containerNamespace"/>
                <xsl:with-param name="typeName" select="concat(@name, 'TypeCode')"/>
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:variable name="fullyQualifiedName" select="concat($containerNamespace, @name)"/>            
        
        <xsl:if test="$typecode='yes'">
            <file name="{$sourceFile}">
                        
                <xsl:call-template name="printPackageStatement">
                    <xsl:with-param name="containerNamespace" select="$containerNamespace"/>
                </xsl:call-template>
                
                <xsl:text>&nl;import com.rti.dds.typecode.*;&nl;</xsl:text>

                <xsl:apply-templates select="./preceding-sibling::node()[@kind = 'copy-java-begin']" 
                                     mode="code-generation-begin">
                    <xsl:with-param name="associatedType" select="."/>
                </xsl:apply-templates>
    	            
                <xsl:call-template name="processGlobalElements">
                    <xsl:with-param name="element" select="."/>
                </xsl:call-template>
                
                <xsl:text>&nl;&nl;</xsl:text>
                
                <xsl:text>public class </xsl:text><xsl:value-of select="@name"/>
                <xsl:text>TypeCode {&nl;</xsl:text>
                
                <xsl:text>    public static final TypeCode VALUE = getTypeCode();&nl;&nl;</xsl:text>
                            
                <xsl:call-template name="generateGetTypeCode">
                    <xsl:with-param name="fullyQualifiedName" select="$fullyQualifiedName"/>
                    <xsl:with-param name="type" select="."/>
                    <xsl:with-param name="indent" select="'    '"/>
                </xsl:call-template>
                
                <xsl:text>}&nl;</xsl:text>
                
            </file>
        </xsl:if>
        
    </xsl:template>
    
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
            <xsl:when test="$memberKind='string'">
                <xsl:text>new TypeCode(TCKind.TK_STRING,</xsl:text>                
                <xsl:value-of select="$member/@maxLengthString"/>
                <xsl:text>)</xsl:text>
            </xsl:when>
            <xsl:when test="$memberKind='wstring'">                
                <xsl:text>new TypeCode(TCKind.TK_WSTRING,</xsl:text>                
                <xsl:value-of select="$member/@maxLengthString"/>
                <xsl:text>)</xsl:text>                
            </xsl:when>
            <xsl:when test="$memberKind='scalar'  and $typeKind='user'">
                <xsl:value-of select="$member/@type"/><xsl:text>TypeCode.VALUE</xsl:text>                
            </xsl:when>
            <xsl:when test="$memberKind='scalar' and $typeKind='builtin'">
                <xsl:value-of select="$typeCodeVar"/>
            </xsl:when>
            <xsl:when test="$memberKind='bitfield'">
                <xsl:if test="$typeCodeVar!=''">
                    <xsl:value-of select="$typeCodeVar"/>
                </xsl:if>
                <xsl:if test="$typeCodeVar=''">
                    <xsl:value-of select="$member/@type"/><xsl:text>TypeCode.VALUE</xsl:text>                        
                </xsl:if>                
            </xsl:when>        
            <xsl:when test="$memberKind='sequence'">             
                <xsl:text>new TypeCode(</xsl:text>
                <xsl:value-of select="$member/@maxLengthSequence"/><xsl:text>,</xsl:text>
                
                <xsl:call-template name="getTypeCodeReference">
                    <xsl:with-param name="fullyQualifiedName" select="$fullyQualifiedName"/>
                    <xsl:with-param name="member" select="$member"/>
                    <xsl:with-param name="indent" select="''"/>
                    <xsl:with-param name="container" select="'sequence'"/>                        
                </xsl:call-template>
                
                <xsl:text>)</xsl:text>
            </xsl:when>            
            <xsl:when test="$memberKind='array' or $memberKind='arraySequence'">                
                <xsl:text>new TypeCode(new int[] {</xsl:text>
                        
                <xsl:for-each select="$member/cardinality/dimension">                        
                    <xsl:value-of select="./@size"/>
                    <xsl:if test="position() != last()">
                        <xsl:text>,</xsl:text>
                    </xsl:if>
                </xsl:for-each>
                
                <xsl:text>},</xsl:text>
                
                <xsl:call-template name="getTypeCodeReference">
                    <xsl:with-param name="fullyQualifiedName" select="$fullyQualifiedName"/>
                    <xsl:with-param name="member" select="$member"/>
                    <xsl:with-param name="indent" select="''"/>
                    <xsl:with-param name="container" select="$memberKind"/>                        
                </xsl:call-template>
                
                <xsl:text>)</xsl:text>
            </xsl:when>   
            <xsl:otherwise>
                <xsl:text>null</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
    <!--
    -->
    <xsl:template name="getLabelAsInt">        
        <xsl:param name="discriminator"/>
        <xsl:param name="value"/>                

        <xsl:variable name="isEnum">
            <xsl:call-template name="isBaseEnum">
                <xsl:with-param name="member" select="$discriminator"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="baseType">                
            <xsl:if test="$discriminator/member">
                <xsl:value-of select="$discriminator/member/@type"/> 
            </xsl:if>
            <xsl:if test="not($discriminator/member)">
                <xsl:value-of select="$discriminator/@type"/> 
            </xsl:if>
        </xsl:variable>
        
        <xsl:choose>
            <xsl:when test="$baseType='boolean'">                
                <xsl:text>((</xsl:text><xsl:value-of select="@value"/>
                <xsl:text>)==true)?1:0</xsl:text>
            </xsl:when>
            <xsl:when test="$isEnum='yes'">
                <xsl:value-of select="@value"/>
                <xsl:if test="$corbaHeader = 'none'">
                    <xsl:text>.ordinal()</xsl:text>
                </xsl:if>
                <xsl:if test="$corbaHeader != 'none'">
                    <xsl:text>.value()</xsl:text>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>(int)(</xsl:text><xsl:value-of select="@value"/>
                <xsl:text>)</xsl:text>
            </xsl:otherwise>
        </xsl:choose>        
    </xsl:template>
    
    <!--
    -->
    <xsl:template name="generateGetTypeCode">
        <xsl:param name="fullyQualifiedName"/>
        <xsl:param name="type"/>
        <xsl:param name="indent"/>
        
        <xsl:variable name="membersCount" select="count(./member)"/>
        <xsl:variable name="enumerationCount" select="count(./enumerator)"/>

        <xsl:variable name="xType">
            <xsl:call-template name="getExtensibilityKind">
                <xsl:with-param name="structName" select="$type/@name"/>
                <xsl:with-param name="node" select="$type"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:value-of select="$indent"/>
        <xsl:text>private static TypeCode getTypeCode() {&nl;</xsl:text>    
        <xsl:value-of select="concat($indent,'&indent;')"/>    
        <xsl:text>TypeCode tc = null;&nl;</xsl:text>
            
        <xsl:value-of select="concat($indent,'&indent;')"/>

        <xsl:variable name="typeNameCPP">
            <xsl:value-of select="$typePrefix"/>
            <xsl:for-each select="$type/ancestor::module">
                <xsl:value-of select="@name"/>
                <xsl:text>::</xsl:text>                
            </xsl:for-each>
            <xsl:value-of select="$type/@name"/>
        </xsl:variable>
        
        <xsl:variable name="extensibility">
            <xsl:choose>
                <xsl:when test="$xType='FINAL_EXTENSIBILITY'">
                    <xsl:text>ExtensibilityKind.FINAL_EXTENSIBILITY</xsl:text>
                </xsl:when>
                <xsl:when test="$xType='MUTABLE_EXTENSIBILITY'">
                    <xsl:text>ExtensibilityKind.MUTABLE_EXTENSIBILITY</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>ExtensibilityKind.EXTENSIBLE_EXTENSIBILITY</xsl:text>            
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:choose>

            <xsl:when test="name($type) = 'typedef'"> <!-- TYPEDEF -->                
                <xsl:variable name="pointer">
                    <xsl:choose>
                        <xsl:when test="./member[1]/@pointer = 'yes'">true</xsl:when>            
                        <xsl:otherwise>false</xsl:otherwise>
                    </xsl:choose>                                
                </xsl:variable>

                <xsl:text>tc = TypeCodeFactory.TheTypeCodeFactory.create_alias_tc("</xsl:text>
                <xsl:value-of select="$typeNameCPP"/>
                <xsl:text>",</xsl:text>
                        
                <xsl:call-template name="getTypeCodeReference">
                    <xsl:with-param name="fullyQualifiedName" select="$fullyQualifiedName"/>
                    <xsl:with-param name="member" select="$type/member[1]"/>
                    <xsl:with-param name="indent" select="''"/>
                    <xsl:with-param name="container" select="''"/>
                </xsl:call-template>
                        
                <xsl:text>,</xsl:text><xsl:value-of select="$pointer"/>
                <xsl:text>);&nl;</xsl:text>
            </xsl:when>

            <xsl:when test="$type/@kind = 'union'">  <!-- UNION -->                
                <xsl:text>int i=0;&nl;</xsl:text>
                <xsl:value-of select="concat($indent,'&indent;')"/>                
                <xsl:text>UnionMember um[] = new UnionMember[</xsl:text>
                <xsl:value-of select="$membersCount"/>
                <xsl:text>];&nl;&nl;</xsl:text>
                
                <xsl:variable name="discriminator" select="$type/discriminator"/>                
                                
                <xsl:for-each select="./member">                        
                    
                    <xsl:variable name="pointer">
                        <xsl:choose>
                            <xsl:when test="./@pointer = 'yes'">true</xsl:when>            
                            <xsl:otherwise>false</xsl:otherwise>
                        </xsl:choose>                                
                    </xsl:variable>

                    <xsl:value-of select="concat($indent,'&indent;')"/>
                    <xsl:text>um[i]=new UnionMember(</xsl:text>          
                    <xsl:text>"</xsl:text><xsl:value-of select="@name"/><xsl:text>",</xsl:text>                                  
                    <xsl:value-of select="$pointer"/><xsl:text>,</xsl:text>
                    <xsl:text>new int[] {</xsl:text>
                    
                    <xsl:for-each select="./cases/case">
                        <xsl:if test="@value='default'">
                            <xsl:value-of select="'0x40000001'"/>
                        </xsl:if>
                        <xsl:if test="@value!='default'">                                
                            <xsl:call-template name="getLabelAsInt">
                                <xsl:with-param name="discriminator" select="$discriminator"/>                                
                                <xsl:with-param name="value" select="@value"/>                                
                            </xsl:call-template>
                        </xsl:if>                        
                        <xsl:if test="position()!=last()">
                            <xsl:text>,</xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                                        
                    <xsl:text>}, (TypeCode)</xsl:text>
                    
                    <xsl:call-template name="getTypeCodeReference">
                        <xsl:with-param name="fullyQualifiedName" select="$fullyQualifiedName"/>
                        <xsl:with-param name="member" select="."/>
                        <xsl:with-param name="indent" select="''"/>
                        <xsl:with-param name="container" select="''"/>
                    </xsl:call-template>
                    
                    <xsl:if test="./@memberId">
                        <xsl:text>,</xsl:text>
                        <xsl:value-of select="./@memberId"/>
                    </xsl:if>
                    
                    <xsl:text>); i++;&nl;</xsl:text>
                                                            
                </xsl:for-each>
                
                <xsl:text>&nl;</xsl:text>                
                
                <xsl:variable name="defaultIndex">
                    <xsl:choose>
                        <xsl:when test="./member/cases/case[@value='default']">                                
                            <xsl:for-each select="./member/cases">
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
                
                <xsl:variable name="discriminatorRef">
                    <xsl:call-template name="getTypeCodeReference">
                        <xsl:with-param name="fullyQualifiedName" select="$fullyQualifiedName"/>
                        <xsl:with-param name="member" select="./discriminator"/>
                        <xsl:with-param name="indent" select="''"/>
                        <xsl:with-param name="container" select="''"/>
                    </xsl:call-template>
                </xsl:variable>
                                                                
                <xsl:value-of select="concat($indent,'&indent;')"/>
                <xsl:text>tc = TypeCodeFactory.TheTypeCodeFactory.create_union_tc("</xsl:text>
                <xsl:value-of select="$typeNameCPP"/><xsl:text>",</xsl:text>
                <xsl:value-of select="$extensibility"/><xsl:text>,</xsl:text>
                <xsl:value-of select="$discriminatorRef"/><xsl:text>,</xsl:text>
                <xsl:value-of select="$defaultIndex"/>
                <xsl:text>,um);&nl;</xsl:text>
                                                                    
            </xsl:when>

            <xsl:when test="$type/@kind = 'valuetype' or (name($type) = 'struct' and ./@baseClass != '')">
                <xsl:text>int i=0;&nl;</xsl:text>
                <xsl:value-of select="concat($indent,'&indent;')"/>                
                <xsl:text>ValueMember sm[] = new ValueMember[</xsl:text>
                <xsl:value-of select="$membersCount"/>
                <xsl:text>];&nl;&nl;</xsl:text>
                                
                <xsl:for-each select="./member">
                    
                    <xsl:variable name="pointer">
                        <xsl:choose>
                            <xsl:when test="./@pointer = 'yes'">true</xsl:when>            
                            <xsl:otherwise>false</xsl:otherwise>
                        </xsl:choose>                                
                    </xsl:variable>

                    <xsl:variable name="key">
                        <xsl:choose>
                            <xsl:when test="./following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'key']">
                                <xsl:text>true</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>false</xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>

                    <xsl:variable name="visibility">
                        <xsl:choose>
            		        <xsl:when test="./@visibility = 'public'">
                	            <xsl:text>PUBLIC_MEMBER.VALUE</xsl:text>
            		        </xsl:when>
            		        <xsl:when test="./@visibility = 'private'">
                	            <xsl:text>PRIVATE_MEMBER.VALUE</xsl:text>
            		        </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>PUBLIC_MEMBER.VALUE</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    
                    <xsl:variable name="bits">
                        <xsl:choose>
                            <xsl:when test="./@bitField">(short)(<xsl:value-of select="./@bitField"/>)</xsl:when>            
                            <xsl:otherwise>(short)-1</xsl:otherwise>
                        </xsl:choose>                                
                    </xsl:variable>
                        
                    <xsl:value-of select="concat($indent,'&indent;')"/>
                    <xsl:text>sm[i]=new ValueMember(</xsl:text>          
                    <xsl:text>"</xsl:text><xsl:value-of select="@name"/><xsl:text>",</xsl:text>                                  
                    <xsl:value-of select="$pointer"/><xsl:text>,</xsl:text>
                    <xsl:value-of select="$bits"/><xsl:text>,</xsl:text>
                    <xsl:value-of select="$key"/><xsl:text>,</xsl:text>
                    <xsl:value-of select="$visibility"/><xsl:text>,(TypeCode)</xsl:text>
                    
                    <xsl:call-template name="getTypeCodeReference">
                        <xsl:with-param name="fullyQualifiedName" select="$fullyQualifiedName"/>
                        <xsl:with-param name="member" select="."/>
                        <xsl:with-param name="indent" select="''"/>
                        <xsl:with-param name="container" select="''"/>
                    </xsl:call-template>
                    
                    <xsl:if test="./@memberId">
                        <xsl:text>,</xsl:text>
                        <xsl:value-of select="./@memberId"/>
                    </xsl:if>

                    <xsl:text>,</xsl:text>
                    
                    <xsl:choose>
                        <xsl:when test="./@optional and ./@optional='true'">
                            <xsl:text>true</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>false</xsl:text>                        
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    <xsl:text>); i++;&nl;</xsl:text>
                                                            
                </xsl:for-each>
		
                <xsl:variable name="typeModifier">
                    <xsl:choose>
                        <xsl:when test="./@typeModifier = 'abstract'">
                            <xsl:text>VM_ABSTRACT.VALUE</xsl:text>
                        </xsl:when>
                        <xsl:when test="./@typeModifier = 'custom'">
                            <xsl:text>VM_CUSTOM.VALUE</xsl:text>
                        </xsl:when>
                        <xsl:when test="./@typeModifier = 'truncatable'">
                            <xsl:text>VM_TRUNCATABLE.VALUE</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>VM_NONE.VALUE</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
	        </xsl:variable>

                <xsl:variable name="baseClass">
                    <xsl:if test="./@baseClass != ''">
                        <xsl:value-of select="./@baseClass"/><xsl:text>TypeCode.VALUE</xsl:text>
                    </xsl:if>
                    <xsl:if test="./@baseClass = ''">
                        <xsl:text>TypeCode.TC_NULL</xsl:text>
                    </xsl:if>
                </xsl:variable>

                <xsl:text>&nl;</xsl:text>                                                                
                <xsl:value-of select="concat($indent,'&indent;')"/>
                <xsl:text>tc = TypeCodeFactory.TheTypeCodeFactory.create_value_tc("</xsl:text>
                <xsl:value-of select="$typeNameCPP"/><xsl:text>",</xsl:text>
                <xsl:value-of select="$extensibility"/><xsl:text>,</xsl:text>
                <xsl:value-of select="$typeModifier"/><xsl:text>,</xsl:text>
                <xsl:value-of select="$baseClass"/><xsl:text>,</xsl:text>
                <xsl:text>sm</xsl:text>
                <xsl:text>);&nl;</xsl:text>
            </xsl:when>

            <xsl:when test="name($type) = 'struct'"> <!-- STRUCT -->

                <xsl:text>int i=0;&nl;</xsl:text>
                <xsl:value-of select="concat($indent,'&indent;')"/>                
                <xsl:text>StructMember sm[] = new StructMember[</xsl:text>
                <xsl:value-of select="$membersCount"/>
                <xsl:text>];&nl;&nl;</xsl:text>
                                
                <xsl:for-each select="./member">                        
                    
                    <xsl:variable name="pointer">
                        <xsl:choose>
                            <xsl:when test="./@pointer = 'yes'">true</xsl:when>            
                            <xsl:otherwise>false</xsl:otherwise>
                        </xsl:choose>                                
                    </xsl:variable>

                    <xsl:variable name="key">
                        <xsl:choose>
                            <xsl:when test="./following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'key']">
                                <xsl:text>true</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>false</xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    
                    <xsl:variable name="bits">
                        <xsl:choose>
                            <xsl:when test="./@bitField">(short)(<xsl:value-of select="./@bitField"/>)</xsl:when>            
                            <xsl:otherwise>(short)-1</xsl:otherwise>
                        </xsl:choose>                                
                    </xsl:variable>

                    <xsl:value-of select="concat($indent,'&indent;')"/>
                    <xsl:text>sm[i]=new StructMember(</xsl:text>          
                    <xsl:text>"</xsl:text><xsl:value-of select="@name"/><xsl:text>",</xsl:text>                                  
                    <xsl:value-of select="$pointer"/><xsl:text>,</xsl:text>
                    <xsl:value-of select="$bits"/><xsl:text>,</xsl:text>
		            <xsl:value-of select="$key"/><xsl:text>,(TypeCode)</xsl:text>
                    
                    <xsl:call-template name="getTypeCodeReference">
                        <xsl:with-param name="fullyQualifiedName" select="$fullyQualifiedName"/>
                        <xsl:with-param name="member" select="."/>
                        <xsl:with-param name="indent" select="''"/>
                        <xsl:with-param name="container" select="''"/>
                    </xsl:call-template>
                    
                    <xsl:if test="./@memberId">
                       <xsl:text>,</xsl:text>
                       <xsl:value-of select="./@memberId"/>
                    </xsl:if>

                    <xsl:text>,</xsl:text>

                    <xsl:choose>
                        <xsl:when test="./@optional and ./@optional='true'">
                            <xsl:text>true</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>false</xsl:text>                        
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    <xsl:text>); i++;&nl;</xsl:text>
                                                            
                </xsl:for-each>
                
                <xsl:text>&nl;</xsl:text>                                                                
                <xsl:value-of select="concat($indent,'&indent;')"/>
                <xsl:text>tc = TypeCodeFactory.TheTypeCodeFactory.create_struct_tc("</xsl:text>
                <xsl:value-of select="$typeNameCPP"/><xsl:text>",</xsl:text>
                <xsl:value-of select="$extensibility"/><xsl:text>,sm);&nl;</xsl:text>
            </xsl:when>

            <xsl:otherwise> <!-- ENUM -->
                
                <xsl:text>int i=0;&nl;</xsl:text>
                <xsl:value-of select="concat($indent,'&indent;')"/>                
                <xsl:text>EnumMember em[] = new EnumMember[</xsl:text>
                <xsl:value-of select="$enumerationCount"/>
                <xsl:text>];&nl;&nl;</xsl:text>

                <xsl:if test="$corbaHeader = 'none'">
                    <xsl:value-of select="concat($indent,'&indent;')"/>                
                    <xsl:text>int[] ordinals = </xsl:text><xsl:value-of select="@name"/><xsl:text>.getOrdinals();&nl;</xsl:text>
                    
                    <xsl:value-of select="concat($indent,'&indent;')"/>                
                    <xsl:text>for (i=0;i&lt;</xsl:text><xsl:value-of select="$enumerationCount"/><xsl:text>;i++) {&nl;</xsl:text>
                    
                    <xsl:value-of select="concat($indent,'&indent;&indent;')"/>
                    <xsl:text>em[i]=new EnumMember(</xsl:text>
                    <xsl:value-of select="@name"/>
                    <xsl:text>.valueOf(ordinals[i]).toString(),</xsl:text>
                    <xsl:text>ordinals[i]);&nl;</xsl:text>            
                    <xsl:value-of select="concat($indent,'&indent;')"/>                
                    <xsl:text>}&nl;</xsl:text>
                </xsl:if>                

                <xsl:if test="$corbaHeader != 'none'">
                    <xsl:for-each select="./enumerator">                        
                        <xsl:value-of select="concat($indent,'&indent;')"/>
                        <xsl:text>em[i]=new EnumMember(</xsl:text>          
                        <xsl:text>"</xsl:text><xsl:value-of select="@name"/><xsl:text>",</xsl:text>                        
    
                        <xsl:if test="$corbaHeader != 'none'">
                            <xsl:value-of select="../@name"/><xsl:text>.</xsl:text><xsl:value-of select="@name"/>
                            <xsl:text>.value()); i++;&nl;</xsl:text>                    
                        </xsl:if>
    
                        <xsl:if test="$corbaHeader = 'none'">
                            <xsl:value-of select="../@name"/><xsl:text>.</xsl:text><xsl:value-of select="@name"/>
                            <xsl:text>.ordinal()); i++;&nl;</xsl:text>                    
                        </xsl:if>
    
                    </xsl:for-each>
                </xsl:if>
                
                <xsl:text>&nl;</xsl:text>                                               
                <xsl:value-of select="concat($indent,'&indent;')"/>
                <xsl:text>tc = TypeCodeFactory.TheTypeCodeFactory.create_enum_tc("</xsl:text>
                <xsl:value-of select="$typeNameCPP"/><xsl:text>",</xsl:text>
                <xsl:value-of select="$extensibility"/><xsl:text>,em);&nl;</xsl:text>
                                                
            </xsl:otherwise>
        </xsl:choose>
    
        <xsl:value-of select="concat($indent,'&indent;')"/>    
        <xsl:text>return tc;&nl;</xsl:text>            
        <xsl:value-of select="$indent"/>    
        <xsl:text>}&nl;</xsl:text>            
    </xsl:template>
                       
</xsl:stylesheet>
