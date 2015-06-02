<?xml version="1.0"?>
<!--
/* $Id: type.java.xsl,v 1.7 2013/09/12 14:22:28 fernando Exp $

   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.

Modification history:
- - - - - - - - - - -
1.0ac,05may13,fcs CODEGEN-584: Added clear method
1.0ac,08dec10,fcs Added copy-java-begin and copy-java-declaration-begin
1.0ac,06dec10,fcs Fixed bug 13780
10ac,28may10,fcs Fixed 13450
10ac,26feb10,rbw Fixed generated Copyable documentation
10ac,23aug09,fcs Added readResolve method to enums
10ac,23aug09,fcs Implements serializable interface
1.0o,16jul08,tk  Removed utils.xsl
1.0o,24apr08,fcs Implemented hashCode
1.0o,02oct07,eh Fix 11950: conform Enum closer to OMG IDL-Java mapping
1.0o,17jul07,la Added null checks to equals methods (bug 11840).
1.0o,16jul07,la Changed enum type to include 'final' keyword (bug 11841).
10l,13sep06,jml Modified union template to extend from com.rti.dds.util.Union 	
10l,08sep06,fcs Added copy constructor
10l,17aug06,fcs The __default methods are not generated when the case values cover 
                the possible values of the discriminant
10l,17aug06,krb Refactored Enum to implement Copyable, removed Copyable code
                from generated classes.
10l,16aug06,krb Added documenation and reworked the copy_from() for enums.
10l,14aug06,krb Added copy functionality (filed as bug 11000).
10l,12aug06,fcs Fixed __default method for unions with boolean as discriminator
10l,10aug06,fcs OMG Union support
10l,25jul06,fcs Fixed bug 11213
10l,18jul06,fcs Constant support inside value types
10l,01may06,fcs Merged from BRANCH_NDDSGEN_JAVA_CORBA
10l,19apr06,fcs Fixed bug 11008 -value types don't call parent equals() method-
10h,31jan06,fcs Added create nethod to unions
10h,13dec05,fcs The static method create is changed to return an Object
                for struct/value types
10h,12dec05,fcs Added value type support
10f,21jul05,fcs Modified processGlobalElements template call to include element parameter
10f,21jul05,fcs Added templates to manage the directives:
                copy-declaration and copy-java-declaration
10f,23jun05,fcs Fixed a naming bug that didn't allow the use of unions or 
                enums inside IDL modules.
10e,09apr05,fcs Allowed top-level directive. 
10e,31mar05,fcs Allowed resolve-name directive. 
                   This directive is used to indicate to nddsgen if it should resolve the scope.
                   When this directive is not present nddsgen resolves the scope.
                Added constructor to unions
                Added "import com.rti.dds.infrastructure.*;" for unions
                Added code to print the type (toString method)
                Generated code for typedefs
10e,28mar05,rw  Fixed mis-named method template
10d,18oct04,rw  Updated to reflect change in com.rti.dds.util.Enum API
10d,25aug04,rw  Moved some copy directive templates to typeCommon.java.xsl;
                call processGlobalElements
10d,24aug04,rw  Replaced tabs with spaces to improve readability of generated
                code; removed useless templates
40b,04may04,rrl Added create() method (to correctly support enums).
40b,03may04,rrl Added equals()
40b,26apr04,rrl Support enums
40b,21apr04,rrl Support sequences
40b,08mar04,rrl Created (by from type.java.xsl)
-->

<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
<!ENTITY namespaceSeperator ".">    <!-- namespace separator -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:xalan = "http://xml.apache.org/xalan">

<xsl:include href="typeCommon.java.xsl"/>

<xsl:output method="xml"/>

<xsl:variable name="sourcePreamble" select="$generationInfo/sourcePreamble[@kind = 'type-java']"/>

<!-- Constant declarations
     Output in the form: #define name value
-->
<xsl:template match="const">
    <xsl:param name="containerNamespace"/>
    <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace, @name)"/>
    <xsl:variable name="sourceFile">
        <xsl:call-template name="obtainSourceFileName">
            <xsl:with-param name="containerNamespace" select="$containerNamespace"/>
            <xsl:with-param name="typeName" select="@name"/>
        </xsl:call-template>

    </xsl:variable>
<file name="{$sourceFile}">
<xsl:call-template name="printPackageStatement">
    <xsl:with-param name="containerNamespace" select="$containerNamespace"/>
</xsl:call-template>

<xsl:apply-templates select="./preceding-sibling::node()[@kind = 'copy-java-begin']|
                             ./preceding-sibling::node()[@kind = 'copy-java-declaration-begin']" 
                     mode="code-generation-begin">
    <xsl:with-param name="associatedType" select="."/>
</xsl:apply-templates>

<xsl:call-template name="processGlobalElements">
    <xsl:with-param name="element" select="."/>
</xsl:call-template>

public class <xsl:value-of select="@name"/> {    
    <xsl:variable name="theType">

        <xsl:variable name="baseType">
            <xsl:call-template name="getBaseType">
                <xsl:with-param name="member" select="."/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:call-template name="obtainNativeType">
            <xsl:with-param name="idlType" select="$baseType"/>
        </xsl:call-template>

    </xsl:variable>
    public static final <xsl:value-of select="$theType"/> VALUE = <xsl:if test="@type='float' or @type='octet'">(<xsl:value-of select="$theType"/>)</xsl:if> <xsl:value-of select="@value"/>;
}

<xsl:call-template name="processGlobalElements">
    <xsl:with-param name="element" select="."/>
    <xsl:with-param name="following" select="'yes'"/>
</xsl:call-template>

</file>
</xsl:template>

<!--
TODO: #include is not yet supported in Java!
<xsl:template match="include">
//TODO: #include "<xsl:value-of select="concat(substring-before(@file, '.idl'), '.h')"/>"
</xsl:template>
-->

<!--
TODO: typedef is not yet supported in Java!
<xsl:template match="typedef">
<xsl:variable name="aliasDefinition">
    <xsl:value-of select="@name"/><xsl:call-template name="obtainArrayDimensions"><xsl:with-param name="cardinality" select="member/cardinality"/></xsl:call-template>
</xsl:variable>
//TODO: typedef <xsl:value-of select="member/@type"/><xsl:text> </xsl:text><xsl:value-of select="$aliasDefinition"/>;
</xsl:template>
-->

<!-- Enum declarations
-->
<xsl:template match="enum">
    <xsl:param name="containerNamespace"/>
    <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace, @name)"/>
<xsl:variable name="sourceFile">
    <xsl:call-template name="obtainSourceFileName">
        <xsl:with-param name="containerNamespace" select="$containerNamespace"/>

        <xsl:with-param name="typeName" select="@name"/>
    </xsl:call-template>
</xsl:variable>

<file name="{$sourceFile}">
<xsl:call-template name="printPackageStatement">
    <xsl:with-param name="containerNamespace" select="$containerNamespace"/>
</xsl:call-template>

import com.rti.dds.util.Enum;
import com.rti.dds.cdr.CdrHelper;
import java.util.Arrays;
import java.io.ObjectStreamException;

<xsl:apply-templates select="./preceding-sibling::node()[@kind = 'copy-java-begin']|
                             ./preceding-sibling::node()[@kind = 'copy-java-declaration-begin']" 
                     mode="code-generation-begin">
    <xsl:with-param name="associatedType" select="."/>
</xsl:apply-templates>

<xsl:call-template name="processGlobalElements">
    <xsl:with-param name="element" select="."/>
</xsl:call-template>

public class <xsl:value-of select="@name"/> extends Enum
{<xsl:apply-templates/><xsl:text>&nl;</xsl:text>
    <xsl:for-each select="enumerator">
        <xsl:variable name="enumValue">
            <xsl:choose>
                <xsl:when test="@value"><xsl:value-of select="@value"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="position()-1"/></xsl:otherwise>
            </xsl:choose>

        </xsl:variable>
    public static final <xsl:value-of select="../@name"/><xsl:text> </xsl:text><xsl:value-of select="@name"/> = new <xsl:value-of select="../@name"/>("<xsl:value-of select="@name"/>", <xsl:value-of select="$enumValue"/>);
    public static final int _<xsl:value-of select="@name"/> = <xsl:value-of select="$enumValue"/>;
    </xsl:for-each>


    public static <xsl:value-of select="@name"/> valueOf(int ordinal) {
        switch(ordinal) {
            <xsl:for-each select="enumerator">

                <xsl:variable name="enumValue">
                    <xsl:choose>
                        <xsl:when test="@value"><xsl:value-of select="@value"/></xsl:when>
                        <xsl:otherwise><xsl:value-of select="position()-1"/></xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
              case <xsl:value-of select="$enumValue"/>: return <xsl:value-of select="../@name"/>.<xsl:value-of select="@name"/>;
            </xsl:for-each>

        }
        return null;
    }

    public static <xsl:value-of select="@name"/> from_int(int __value) {
        return valueOf(__value);
    }

    public static int[] getOrdinals() {
        int i = 0;
        int[] values = new int[<xsl:value-of select="count(./enumerator)"/>];
        
        <xsl:for-each select="enumerator">
        values[i] = <xsl:value-of select="./@name"/>.ordinal();
        i++;
        </xsl:for-each>

        Arrays.sort(values);
        return values;
    }

    public int value() {
        return super.ordinal();
    }

    /**
     * Create a default instance
     */  
    public static <xsl:value-of select="@name"/> create() {
        <xsl:variable name="firstEnumValue">
            <xsl:choose>
                <xsl:when test="enumerator[1]/@value"><xsl:value-of select="enumerator[1]/@value"/></xsl:when>
                <xsl:otherwise>0</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        return valueOf(<xsl:value-of select="$firstEnumValue"/>);
    }
    
    /**
     * Print Method
     */     
    public String toString(String desc, int indent) {
        StringBuffer strBuffer = new StringBuffer();

        CdrHelper.printIndent(strBuffer, indent);
            
        if (desc != null) {
            strBuffer.append(desc).append(": ");
        }
        
        strBuffer.append(this);
        strBuffer.append("\n");              
        return strBuffer.toString();
    }

    private Object readResolve() throws ObjectStreamException {
        return valueOf(ordinal());
    }

    private <xsl:value-of select="@name"/>(String name, int ordinal) {
        super(name, ordinal);
    }
}

<xsl:call-template name="processGlobalElements">
    <xsl:with-param name="element" select="."/>
    <xsl:with-param name="following" select="'yes'"/>
</xsl:call-template>

</file>
</xsl:template>

<!-- Struct declarations

    Output form:
    struct <fullyQualifiedName> {
         [Members] <processed by another template>
    }
-->
<xsl:template match="struct|typedef">
    <xsl:param name="containerNamespace"/>

    <xsl:variable name="generate">
        <xsl:if test="name(.)='typedef'">
            <xsl:variable name="baseMemberKind">
                <xsl:call-template name="obtainBaseMemberKind">
                    <xsl:with-param name="member" select="member"/>
                </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="baseTypeKind">
                <xsl:call-template name="obtainBaseTypeKind">
                    <xsl:with-param name="member" select="member"/>
                </xsl:call-template>
            </xsl:variable>
            
            <xsl:choose>
                <xsl:when test="$baseMemberKind='sequence' or
                                $baseMemberKind='array' or
                                $baseMemberKind='arraySequence'">yes</xsl:when>
                <xsl:when test="$baseTypeKind='user'">yes</xsl:when>
                <xsl:otherwise>no</xsl:otherwise>
            </xsl:choose>                
        </xsl:if>
        <xsl:if test="not(name(.)='typedef')">yes</xsl:if>        
    </xsl:variable>

<xsl:if test="$generate='yes'">
    <xsl:variable name="xType">
        <xsl:call-template name="getExtensibilityKind">
            <xsl:with-param name="structName" select="./@name"/>
            <xsl:with-param name="node" select="."/>
        </xsl:call-template>
     </xsl:variable>

    <xsl:apply-templates mode="error-checking"/>

<xsl:variable name="sourceFile">
    <xsl:call-template name="obtainSourceFileName">
        <xsl:with-param name="containerNamespace" select="$containerNamespace"/>
        <xsl:with-param name="typeName" select="@name"/>
    </xsl:call-template>
</xsl:variable>

<file name="{$sourceFile}">
<!-- struct definitions -->
<xsl:call-template name="printPackageStatement">
    <xsl:with-param name="containerNamespace" select="$containerNamespace"/>

</xsl:call-template>

<xsl:value-of select="$sourcePreamble"/>

import com.rti.dds.infrastructure.*;
<xsl:if test="$useCopyable = 'true'">import com.rti.dds.infrastructure.Copyable;&nl;</xsl:if>
import java.io.Serializable;
import com.rti.dds.cdr.CdrHelper;

<xsl:apply-templates select="./preceding-sibling::node()[@kind = 'copy-java-begin']|
                             ./preceding-sibling::node()[@kind = 'copy-java-declaration-begin']" 
                     mode="code-generation-begin">
    <xsl:with-param name="associatedType" select="."/>
</xsl:apply-templates>

<xsl:call-template name="processGlobalElements">
    <xsl:with-param name="element" select="."/>
</xsl:call-template>

    <xsl:choose>
        <xsl:when test="(@kind='valuetype' or @kind='struct') and @baseClass!=''">             
public class <xsl:value-of select="@name"/> extends <xsl:value-of select="@baseClass"/>
        </xsl:when>            
        <xsl:otherwise>
public class <xsl:value-of select="@name"/>
        </xsl:otherwise>
    </xsl:choose>        
    <xsl:choose>
        <xsl:when test="$useCopyable = 'true'">                
            <xsl:text> implements Copyable, Serializable&nl;</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text> implements Serializable&nl;</xsl:text>
        </xsl:otherwise>
    </xsl:choose>{
<xsl:for-each select="const">
    public class <xsl:value-of select="@name"/> {    
<xsl:variable name="theType">
    <xsl:call-template name="obtainNativeType">
        <xsl:with-param name="idlType" select="@type"/>
    </xsl:call-template>
</xsl:variable>
        public static final <xsl:value-of select="$theType"/> VALUE = <xsl:if test="@type='float' or @type='octet'">(<xsl:value-of select="$theType"/>)</xsl:if> <xsl:value-of select="@value"/>;
    }

</xsl:for-each>
<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'structMember'"/>
</xsl:apply-templates><xsl:text>&nl;</xsl:text>

    public <xsl:value-of select="@name"/><xsl:text>() {&nl;</xsl:text>
    <xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass!=''">
        <xsl:text>        super();&nl;</xsl:text>
    </xsl:if>                        

<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'initialize'"/>
</xsl:apply-templates>
    }

<xsl:if test="$useCopyable = 'true'">
    public <xsl:value-of select="@name"/><xsl:text>(</xsl:text>
    <xsl:value-of select="@name"/><xsl:text> other) {&nl;</xsl:text>
        this();
        copy_from(other);
    }

</xsl:if>

    public static Object create() {
        <xsl:value-of select="@name"/> self;
        self = new <xsl:value-of select="@name"/>();
        <xsl:if test="$xType!='FINAL_EXTENSIBILITY'"> 
        self.clear();
        </xsl:if>
        return self;
    }

    public void clear() {
        <xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass!=''">
        super.clear();
        </xsl:if>
        <xsl:apply-templates mode="code-generation">
            <xsl:with-param name="generationMode" select="'clear'"/>
        </xsl:apply-templates>
    }

    public boolean equals(Object o) {
        <xsl:if test="member[@bitField]">
        long bits,bitsOther;
        </xsl:if>        
        if (o == null) {
            return false;
        }        
        
<xsl:if test="(@kind = 'valuetype' or @kind = 'struct') and @baseClass!=''">
        <xsl:text>        </xsl:text>
        if (!super.equals(o)) {
            return false;
        }
</xsl:if>        

        if(getClass() != o.getClass()) {
            return false;
        }

        <xsl:value-of select="@name"/> otherObj = (<xsl:value-of select="@name"/>)o;


<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'equals'"/>
</xsl:apply-templates>
        return true;
    }

    public int hashCode() {
        int __result = 0;
<xsl:if test="(@kind = 'valuetype' or @kind = 'struct') and @baseClass!=''">
        __result = super.hashCode();
</xsl:if>
<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'hashCode'"/>
</xsl:apply-templates>
        return __result;
    }
    
<xsl:if test="$useCopyable = 'true'">
    /**
     * This is the implementation of the &lt;code&gt;Copyable&lt;/code&gt; interface.
     * This method will perform a deep copy of &lt;code&gt;src&lt;/code&gt;
     * This method could be placed into &lt;code&gt;<xsl:value-of select="@name"/>TypeSupport&lt;/code&gt;
     * rather than here by using the &lt;code&gt;-noCopyable&lt;/code&gt; option
     * to rtiddsgen.
     * 
     * @param src The Object which contains the data to be copied.
     * @return Returns &lt;code&gt;this&lt;/code&gt;.
     * @exception NullPointerException If &lt;code&gt;src&lt;/code&gt; is null.
     * @exception ClassCastException If &lt;code&gt;src&lt;/code&gt; is not the 
     * same type as &lt;code&gt;this&lt;/code&gt;.
     * @see com.rti.dds.infrastructure.Copyable#copy_from(java.lang.Object)
     */
    public Object copy_from(Object src) {
        <!-- using typedSrc and typedDst, we can keep the templates the same
             when using Copyable or when putting the copy method in the
             TypeSupport class. -->

        <xsl:value-of select="@name"/> typedSrc = (<xsl:value-of select="@name"/>) src;
        <xsl:value-of select="@name"/> typedDst = this;
<xsl:if test="(@kind='valuetype' or @kind = 'struct') and @baseClass!=''">
        <xsl:text>        super.copy_from(typedSrc);</xsl:text>
</xsl:if>        
<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'copy'"/>
</xsl:apply-templates>
        return this;
    }

</xsl:if>
    
    public String toString(){
        return toString("", 0);
    }
        
    <!-- print method -->
    public String toString(String desc, int indent) {
        StringBuffer strBuffer = new StringBuffer();        
        <xsl:if test="member[@bitField]">
        long bits;
        </xsl:if>                
        
        if (desc != null) {
            CdrHelper.printIndent(strBuffer, indent);
            strBuffer.append(desc).append(":\n");
        }
        
        <xsl:if test="(@kind='valuetype' or @kind = 'struct') and @baseClass!=''">
        strBuffer.append(super.toString("",indent));
        </xsl:if>        
                
<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'print'"/>

</xsl:apply-templates>
        return strBuffer.toString();
    }
    
}

<xsl:call-template name="processGlobalElements">
    <xsl:with-param name="element" select="."/>
    <xsl:with-param name="following" select="'yes'"/>
</xsl:call-template>

</file>
</xsl:if> <!-- end generate -->

</xsl:template>

<!-- 
    This template is used to generate the verify statement for the union members 
-->

<xsl:template name="getVerifyStmt">
    <xsl:param name="caseList"/>
    <xsl:param name="default"/>

    <xsl:for-each select="$caseList">
        <xsl:choose>
            <xsl:when test="position() =1">
                <xsl:if test="$default = 1">
                    <xsl:text>        if (!(discriminator != </xsl:text>

                    <xsl:value-of select="@value"/>
                </xsl:if>
                <xsl:if test="$default = 0">
                    <xsl:text>        if (discriminator != </xsl:text>
                    <xsl:value-of select="@value"/>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>

                <xsl:text>            discriminator != </xsl:text>
                <xsl:value-of select="@value"/>
            </xsl:otherwise>
        </xsl:choose>

        <xsl:if test="position() != last()">
        <xsl:text> &amp;&amp; &nl;</xsl:text>

        </xsl:if>

        <xsl:if test="position() = last() and $default =0">
            <xsl:text>) {&nl;</xsl:text>
            <xsl:text>            throw new RETCODE_ILLEGAL_OPERATION();&nl;</xsl:text>
            <xsl:text>        }&nl;</xsl:text>
        </xsl:if>

        <xsl:if test="position() = last() and $default =1">
            <xsl:text>)) {&nl;</xsl:text>
            <xsl:text>            throw new RETCODE_ILLEGAL_OPERATION();&nl;</xsl:text>
            <xsl:text>        }&nl;</xsl:text>
        </xsl:if>

    </xsl:for-each>
</xsl:template>

<!-- 
    This template is used to generate the default modfier body
-->
<xsl:template name="getDefaultModifierBody">
    <xsl:param name="discBaseType"/>
    <xsl:param name="discNativeBaseType"/>
    <xsl:param name="discBaseEnum"/>
    <xsl:param name="caseList"/>
 <!--  XTYPES changes -->   
  <!--
<xsl:if test="not($caseList[@value='default'])">
        // explicit default value was not defined. Descriminator is assigned to the case with the lowest ordinal.
        int index =0;
        <xsl:value-of select="$discNativeBaseType"/> tmp = <xsl:value-of select="$caseList[position() = 1]/@value"/>;
        for (index = 0; index &lt; <xsl:value-of select="count($caseList)"/>; ++index) {
        <xsl:for-each select="$caseList">
            if (tmp &gt; <xsl:value-of select="./@value"/>) tmp = <xsl:value-of select="./@value"/>;
        </xsl:for-each>
        }
        return tmp;
</xsl:if>    
<xsl:if test="$caseList[@value='default']">
-->
    <xsl:choose>
        <!--  if discriminator is a boolean -->
        <xsl:when test="$discBaseType='boolean'">
            <xsl:choose>
                <xsl:when test="$caseList[@value = 'true']">
                    <xsl:text>        return false</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>        return true</xsl:text>

                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>;&nl;</xsl:text>
        </xsl:when>
        <!-- end boolean  -->

        <!--  if discriminator is an enum -->
        <xsl:when test="$discBaseEnum = 'yes'">
            <xsl:if test="not($caseList[@value='default'])">
                // explicit default value was not defined. Descriminator is assigned to the case with the lowest ordinal.
                int index = 0;
                <xsl:value-of select="$discNativeBaseType"/> tmp = <xsl:value-of select="$caseList[position() = 1]/@value"/>;
                for (index = 0; index &lt; <xsl:value-of select="count($caseList)"/>; ++index) {
                <xsl:for-each select="$caseList">
                    if (tmp.ordinal() &gt; <xsl:value-of select="./@value"/>.ordinal()) tmp = <xsl:value-of select="./@value"/>;
                </xsl:for-each>
                }
                return tmp;
            </xsl:if>
            <xsl:if test="$caseList[@value='default']">
                <xsl:text>        int[] enumOrdinals = </xsl:text>
                <xsl:value-of select="$discNativeBaseType"/>
                <xsl:text>.getOrdinals();&nl;</xsl:text>
                <xsl:text>        int[] caseOrdinals = </xsl:text>
                <xsl:text>new int[enumOrdinals.length];&nl;</xsl:text>
                <xsl:text>        int i = 0, j;&nl;;</xsl:text>
                <xsl:text>        </xsl:text><xsl:value-of select="$discNativeBaseType"/> <xsl:text> tmp = &nl;</xsl:text>
                <xsl:text>            </xsl:text><xsl:value-of select="$discNativeBaseType"/><xsl:text>.valueOf(enumOrdinals[0]);&nl;&nl;</xsl:text>
    
                <xsl:for-each select="$caseList[@value != 'default']">
                    <xsl:text>        caseOrdinals[i] = </xsl:text>
                    <xsl:value-of select="@value"/>
                    <xsl:text>.ordinal();&nl;</xsl:text>
                    <xsl:text>        i++;&nl;</xsl:text>
                </xsl:for-each>
    
                <xsl:text>&nl;</xsl:text>
    
                <xsl:text>        for (i=0; i&lt;enumOrdinals.length; i++) {&nl;</xsl:text>
                <xsl:text>            for (j=0; j&lt;</xsl:text>
                <xsl:value-of select="count($caseList[@value != 'default'])"/>
                <xsl:text> ;j++) {&nl;</xsl:text>
                <xsl:text>                if (enumOrdinals[i] == caseOrdinals[j])  {&nl;</xsl:text>
                <xsl:text>                    if (tmp.ordinal() > enumOrdinals[i]) {&nl;</xsl:text>
                <xsl:text>                        tmp = </xsl:text><xsl:value-of select="$discNativeBaseType"/><xsl:text>.valueOf(enumOrdinals[i]);&nl;</xsl:text>
                <xsl:text>                    }&nl;</xsl:text>
                <xsl:text>                    break;&nl;</xsl:text>                                  
                <xsl:text>                }&nl;</xsl:text>
                <xsl:text>            }&nl;</xsl:text>
                <xsl:text>            if (j == </xsl:text>
                <xsl:value-of select="count($caseList[@value != 'default'])"/>
                <xsl:text>) {&nl;</xsl:text>
                <xsl:text>                return </xsl:text><xsl:value-of select="$discNativeBaseType"/><xsl:text>.valueOf(enumOrdinals[i]);&nl;</xsl:text>
                <xsl:text>            }&nl;</xsl:text>
                <xsl:text>        }&nl;</xsl:text>
                <xsl:text>        return tmp;&nl;</xsl:text>
            </xsl:if>
        </xsl:when>
        <!-- end enum -->

         <!--  if discriminator is a long -->
        <xsl:otherwise>
            <xsl:if test="not($caseList[@value='default'])">
                // explicit default value was not defined. Descriminator is assigned to the case with the lowest number.
                <xsl:value-of select="$discNativeBaseType"/> tmp = <xsl:value-of select="$caseList[position() = 1]/@value"/>;
                <xsl:for-each select="$caseList">
                if (tmp &gt; <xsl:value-of select="./@value"/>) tmp = <xsl:value-of select="./@value"/>;
                </xsl:for-each>
                return tmp;
            </xsl:if>
            <xsl:if test="$caseList[@value='default']">
                <xsl:text>        </xsl:text>
                <xsl:value-of select="$discNativeBaseType"/>
                <xsl:text> i;&nl;</xsl:text>
    
                <xsl:text>        for (</xsl:text>
                <xsl:text> i = 0; i &lt; </xsl:text>
                <xsl:value-of select="$typeInfoMap/type[@idlType = $discBaseType]/@class"/>
                <xsl:text>.MAX_VALUE; i++) {&nl;</xsl:text>
                <xsl:for-each select="$caseList[@value != 'default']">
                    <xsl:text>            if ((</xsl:text>
    
                    <xsl:value-of select="@value"/>
                    <xsl:text>)== i) continue;&nl;</xsl:text>
                </xsl:for-each>
                <xsl:text>            break;&nl;</xsl:text>
                <xsl:text>        }&nl;</xsl:text>
                <xsl:text>        return i;&nl;</xsl:text>
            </xsl:if>
        </xsl:otherwise>
    </xsl:choose>

    

<!--  end XTYPES changes -->

    <!-- If the branch corresponds to the default case label, then the simple
         modifier for that branch sets the discriminant to the first available
         default value starting from a 0 index of the discriminant type -->
    
    <xsl:choose>
        <xsl:when test="$discBaseType='boolean'">
        <!--    <xsl:choose>
                <xsl:when test="$caseList[@value = 'true']">
                    <xsl:text>        return false</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>        return true</xsl:text>

                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>;&nl;</xsl:text>-->
        </xsl:when>
        <xsl:when test="$discBaseEnum = 'yes'">
            <!--<xsl:text>        int[] enumOrdinals = </xsl:text>
            <xsl:value-of select="$discNativeBaseType"/>
            <xsl:text>.getOrdinals();&nl;</xsl:text>
            <xsl:text>        int[] caseOrdinals = </xsl:text>
            <xsl:text>new int[enumOrdinals.length];&nl;</xsl:text>
            <xsl:text>        int i = 0, j;&nl;&nl;</xsl:text>

            <xsl:for-each select="$caseList[@value != 'default']">
                <xsl:text>        caseOrdinals[i] = </xsl:text>
                <xsl:value-of select="@value"/>
                <xsl:text>.ordinal();&nl;</xsl:text>
                <xsl:text>        i++;&nl;</xsl:text>
            </xsl:for-each>

            <xsl:text>&nl;</xsl:text>

            <xsl:text>        for (i=0; i&lt;enumOrdinals.length; i++) {&nl;</xsl:text>
            <xsl:text>            for (j=0; j&lt;</xsl:text>
            <xsl:value-of select="count($caseList[@value != 'default'])"/>
            <xsl:text> ;j++) {&nl;</xsl:text>
            <xsl:text>                if (enumOrdinals[i] == caseOrdinals[j]) break;&nl;</xsl:text>                                  
            <xsl:text>            }&nl;</xsl:text>
            <xsl:text>            if (j == </xsl:text>
            <xsl:value-of select="count($caseList[@value != 'default'])"/>
            <xsl:text>) break;&nl;</xsl:text>
            <xsl:text>        }&nl;&nl;</xsl:text>

            <xsl:text>        if (i == enumOrdinals.length) i - -;&nl;&nl;</xsl:text>

            <xsl:text>        return </xsl:text>
            <xsl:value-of select="$discNativeBaseType"/>
            <xsl:text>.valueOf(enumOrdinals[i]);&nl;</xsl:text>-->
        </xsl:when>
        <xsl:otherwise>
        <!--    <xsl:text>        </xsl:text>
            <xsl:value-of select="$discNativeBaseType"/>
            <xsl:text> i;&nl;</xsl:text>

            <xsl:text>        for (</xsl:text>
            <xsl:text> i = 0; i &lt; </xsl:text>
            <xsl:value-of select="$typeInfoMap/type[@idlType = $discBaseType]/@class"/>
            <xsl:text>.MAX_VALUE; i++) {&nl;</xsl:text>
            <xsl:for-each select="$caseList[@value != 'default']">
                <xsl:text>            if ((</xsl:text>

                <xsl:value-of select="@value"/>
                <xsl:text>)== i) continue;&nl;</xsl:text>
            </xsl:for-each>
            <xsl:text>            break;&nl;</xsl:text>
            <xsl:text>        }&nl;</xsl:text>
            <xsl:text>        return i;&nl;</xsl:text>
        -->
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- 
    The following template is used to get a default value for an integer
    discriminant in a union
-->
<!--
<xsl:template name="getDefaultLabelForInt">
    <xsl:param name="caseNodes"/>
    <xsl:param name="i" select="0"/>

    <xsl:choose>
        <xsl:when test="not($caseNodes[@value = $i])">
            <xsl:value-of select="$i"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:call-template name="getDefaultLabelForInt">
                <xsl:with-param name="caseNodes" select="$caseNodes"/>
                <xsl:with-param name="i" select="$i + 1"/>
            </xsl:call-template>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>
-->

<!--
-->

<xsl:template name="generateDefaultForEnum">
    <xsl:param name="module" select="/specification"/>
    <xsl:param name="caseList"/>
    <xsl:param name="firstEnumeratorValue"/>

    <xsl:variable name="beforeStr" select="substring-before($firstEnumeratorValue,'.')"/>
    <xsl:variable name="afterStr" select="substring-after($firstEnumeratorValue,'.')"/>
        
    <xsl:choose>
        <xsl:when test="contains($beforeStr,'(')">
            <xsl:call-template name="generateDefaultForEnum">
                <xsl:with-param name="module" select="$module"/>
                <xsl:with-param name="caseList" select="$caseList"/>
                <xsl:with-param name="firstEnumeratorValue" select="substring-after($firstEnumeratorValue,'(')"/>

            </xsl:call-template>
        </xsl:when>
        <xsl:when test="substring-before($afterStr,'.') != ''">
            <xsl:call-template name="generateDefaultForEnum">
                <xsl:with-param name="module" select="$module/module[./@name = $beforeStr]"/>
                <xsl:with-param name="caseList" select="$caseList"/>
                <xsl:with-param name="firstEnumeratorValue" select="$afterStr"/>
            </xsl:call-template>
        </xsl:when>

        <xsl:otherwise>
            <xsl:variable name="enumNode" select="$module/enum[./@name = $beforeStr]"/>

            <xsl:for-each select="$enumNode/enumerator">
                <xsl:variable name="enumaratorName" select="./@name"/>

                <xsl:if test="not($caseList[contains(./@value,$enumaratorName)])">
                    <xsl:text>yes</xsl:text>
                </xsl:if>

            </xsl:for-each>
        </xsl:otherwise>
    </xsl:choose>

</xsl:template>

<!--
-->

<xsl:template name="generateDefault">
    <xsl:param name="unionNode"/>
    <xsl:param name="discBaseEnum"/>
    <xsl:param name="discBaseType"/>

    <xsl:choose>
        <xsl:when test="$unionNode//cases/case[@value = 'default']">
            <xsl:text>yes</xsl:text>
        </xsl:when>
        <xsl:when test="$discBaseType='boolean' and $unionNode//cases/case[@value = 'true'] and 
                        $unionNode//cases/case[@value = 'false']">
            <!-- Do not generate default methods -->
            <xsl:text>no</xsl:text>

        </xsl:when>
        <xsl:when test="$discBaseEnum='yes'">
            <xsl:variable name="firstEnumeratorValue">
                <xsl:if test="$packagePrefix != ''">
                    <xsl:variable name="tmp" select="substring-after($unionNode//cases/case[1]/@value,
                                                                     $packagePrefix)"/>
                    <xsl:value-of select="substring-before(substring-after($tmp,'.'),')')"/>
                </xsl:if>
                <xsl:if test="$packagePrefix = ''">
                    <xsl:value-of select="substring-before(
                                             $unionNode//cases/case[1]/@value,
                                             ')')"/>

                </xsl:if>
            </xsl:variable>

            <xsl:variable name="genEnumDef">
                <xsl:call-template name="generateDefaultForEnum">
                    <xsl:with-param name="caseList" select="$unionNode//cases/case"/>
                    <xsl:with-param name="firstEnumeratorValue" select="$firstEnumeratorValue"/>
                </xsl:call-template>
            </xsl:variable>

            <xsl:if test="contains($genEnumDef,'yes')">
                <xsl:text>yes</xsl:text>
            </xsl:if>

            <xsl:if test="not(contains($genEnumDef,'yes'))">
                <xsl:text>no</xsl:text>
            </xsl:if>

        </xsl:when>
        <xsl:otherwise>
            <xsl:text>yes</xsl:text>
        </xsl:otherwise>
    </xsl:choose>

</xsl:template>

<!-- Union declarations

    Output form:
    struct <fullyQualifiedName> {
        <discriminator_type> _d;
        union {
           [Members] <processed by another template>
        } _u;
    }
-->
<xsl:template match="struct[@kind='union']">
    <xsl:param name="containerNamespace"/>

    <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace, @name)"/>
    <xsl:apply-templates mode="error-checking"/>

<!-- struct definitions -->
<xsl:variable name="sourceFile">
    <xsl:call-template name="obtainSourceFileName">
        <xsl:with-param name="containerNamespace" select="$containerNamespace"/>
        <xsl:with-param name="typeName" select="@name"/>
    </xsl:call-template>
</xsl:variable>

<!-- discriminator information -->
<xsl:variable name="discBaseType">
    <xsl:call-template name="getBaseType">
        <xsl:with-param name="member" select="./discriminator"/>
    </xsl:call-template>
</xsl:variable>

<xsl:variable name="discNativeBaseType">
    <xsl:call-template name="obtainNativeType">
        <xsl:with-param name="idlType" select="$discBaseType"/>
     </xsl:call-template>

</xsl:variable>

<xsl:variable name="discBaseEnum">
    <xsl:call-template name="isBaseEnum">
        <xsl:with-param name="member" select="./discriminator"/>
    </xsl:call-template>
</xsl:variable>

<!-- generate default -->
<xsl:variable name="generateDef">
    <xsl:call-template name="generateDefault">
        <xsl:with-param name="unionNode" select="."/>

        <xsl:with-param name="discBaseEnum" select="$discBaseEnum"/>
        <xsl:with-param name="discBaseType" select="$discBaseType"/>
    </xsl:call-template>
</xsl:variable>

<file name="{$sourceFile}">
<xsl:call-template name="printPackageStatement">
    <xsl:with-param name="containerNamespace" select="$containerNamespace"/>
</xsl:call-template>

import com.rti.dds.infrastructure.*;
<xsl:if test="$useCopyable = 'true'">import com.rti.dds.infrastructure.Copyable;&nl;</xsl:if>
import java.io.Serializable;
import com.rti.dds.cdr.CdrHelper;
import com.rti.dds.util.Union;

<xsl:apply-templates select="./preceding-sibling::node()[@kind = 'copy-java-begin']|
                             ./preceding-sibling::node()[@kind = 'copy-java-declaration-begin']" 
                     mode="code-generation-begin">
    <xsl:with-param name="associatedType" select="."/>
</xsl:apply-templates>

<xsl:call-template name="processGlobalElements">
    <xsl:with-param name="element" select="."/>
</xsl:call-template>

<xsl:variable name="xType">
    <xsl:call-template name="getExtensibilityKind">
        <xsl:with-param name="structName" select="./@name"/>
        <xsl:with-param name="node" select="."/>
    </xsl:call-template>
</xsl:variable>

public class <xsl:value-of select="@name"/> extends Union
<xsl:choose>
    <xsl:when test="$useCopyable = 'true'">                
        <xsl:text> implements Copyable, Serializable&nl;</xsl:text>
    </xsl:when>
    <xsl:otherwise>
        <xsl:text> implements Serializable&nl;</xsl:text>
    </xsl:otherwise>
</xsl:choose>{
    <!--<xsl:if test="$generateDef = 'yes'">  default should always be generated -->
    private static final <xsl:value-of select="$discNativeBaseType"/> _default = getDefaultDiscriminator();
    <!--</xsl:if> -->

    public <xsl:value-of select="$discNativeBaseType"/> _d <xsl:text> </xsl:text>
    <xsl:if test="$discBaseEnum='yes'">
        <xsl:text>= </xsl:text><xsl:value-of select="$discBaseType"/><xsl:text>.create()</xsl:text>
    </xsl:if>
    <xsl:text>;&nl;</xsl:text>

    <xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'structMember'"/>
</xsl:apply-templates><xsl:text>&nl;</xsl:text>

    public <xsl:value-of select="@name"/>() {
<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'initialize'"/>
</xsl:apply-templates>
        <xsl:if test=".//cases/case[1]/@value != 'default'">
            <xsl:text>        _d = getDefaultDiscriminator(); </xsl:text>
        </xsl:if>
    }

<xsl:if test="$useCopyable = 'true'">
    public <xsl:value-of select="@name"/><xsl:text>(</xsl:text>
    <xsl:value-of select="@name"/><xsl:text> other) {&nl;</xsl:text>

        this();
        copy_from(other);
    }
</xsl:if>

    public static Object create() {
            <xsl:value-of select="@name"/> self;
        self = new <xsl:value-of select="@name"/>();
        <xsl:if test="$xType!='FINAL_EXTENSIBILITY'"> 
        self.clear();
        </xsl:if>
        return self;
    }

    <!-- <xsl:if test="$generateDef = 'yes'">  Default should always be generated -->
    <xsl:text>    public static </xsl:text>
    <xsl:value-of select="$discNativeBaseType"/>

    <xsl:text> getDefaultDiscriminator() {&nl;</xsl:text>
        <xsl:call-template name="getDefaultModifierBody">
            <xsl:with-param name="discBaseType" select="$discBaseType"/>
            <xsl:with-param name="discNativeBaseType" select="$discNativeBaseType"/>
            <xsl:with-param name="discBaseEnum" select="$discBaseEnum"/>
            <xsl:with-param name="caseList" select=".//cases/case"/>
        </xsl:call-template>
    <xsl:text>    }&nl;</xsl:text>

    <!--</xsl:if> -->

    public void clear() {
        _d = getDefaultDiscriminator();
        
        <xsl:apply-templates mode="code-generation">
            <xsl:with-param name="generationMode" select="'clear'"/>
        </xsl:apply-templates>
    }

    public <xsl:value-of select="$discNativeBaseType"/> discriminator() {
        return _d;
    }<xsl:text>&nl;&nl;</xsl:text>

<xsl:for-each select="./member">

    <xsl:variable name="description">
        <xsl:call-template name="getMemberDescription">
            <xsl:with-param name="member" select="."/>

        </xsl:call-template>
    </xsl:variable>   

    <xsl:variable name="descriptionNode" select="xalan:nodeset($description)/node()"/>    

    <xsl:variable name="verifyStatement">
        <xsl:choose>
            <xsl:when test="cases/case[@value = 'default']">
                <xsl:call-template name="getVerifyStmt">
                    <xsl:with-param name="caseList" select="..//cases/case[@value != 'default']"/>
                    <xsl:with-param name="default" select="1"/>
                </xsl:call-template>

            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="getVerifyStmt">
                    <xsl:with-param name="caseList" select="cases/case"/>
                    <xsl:with-param name="default" select="0"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:text>    private void verify</xsl:text><xsl:value-of select="@name"/>
    <xsl:text>(</xsl:text>
    <xsl:value-of select="$discNativeBaseType"/><xsl:text> discriminator) {&nl;</xsl:text>
        <xsl:value-of select="$verifyStatement"/>
    <xsl:text>    }&nl;&nl;</xsl:text>

    <xsl:variable name="nativeType">
        <xsl:call-template name="generateMemberCode">
            <xsl:with-param name="generationMode" select="'nativeType'"/>
            <xsl:with-param name="member" select="."/>
        </xsl:call-template>
    </xsl:variable>

    <xsl:text>    </xsl:text>public <xsl:value-of select="concat($nativeType,' ',@name)"/>() {
        verify<xsl:value-of select="@name"/>(_d);
        return <xsl:value-of select="@name"/>;
    }<xsl:text>&nl;&nl;</xsl:text>

    <xsl:if test="count(cases/case) &gt; 1 or cases/case[@value = 'default']">

    <xsl:text>    public void </xsl:text>
    <xsl:value-of select="@name"/><xsl:text>(</xsl:text>
    <xsl:value-of select="$discNativeBaseType"/><xsl:text> discriminator,</xsl:text>
    <xsl:value-of select="$nativeType"/> __value) {
        verify<xsl:value-of select="@name"/>(discriminator);
        _d = discriminator;
        <xsl:value-of select="@name"/> = __value;
    }<xsl:text>&nl;&nl;</xsl:text>

    </xsl:if>

    <xsl:text>    public void </xsl:text>
    <xsl:value-of select="@name"/><xsl:text>(</xsl:text>    
    <xsl:value-of select="$nativeType"/> __value) {<xsl:text>&nl;</xsl:text>
        <xsl:choose>
            <xsl:when test="cases/case[@value = 'default']">

                <xsl:choose>
                    <xsl:when test="$discBaseType='boolean'">
                        <xsl:choose>
                            <xsl:when test="..//cases/case[@value = 'true'] and 
                                            ..//cases/case[@value = 'false']">
                                <xsl:text>        throw new RETCODE_ILLEGAL_OPERATION();&nl;</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>        _d = _default;&nl;</xsl:text>

                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="$discBaseEnum = 'yes'">
                        <xsl:text>        if (_default == null)</xsl:text>                        
                        <xsl:text> throw new RETCODE_ILLEGAL_OPERATION();&nl;</xsl:text>
                        <xsl:text>        _d = _default;&nl;</xsl:text>

                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>        if (_default ==</xsl:text>
                        <xsl:value-of select="$typeInfoMap/type[@idlType = $discBaseType]/@class"/>
                        <xsl:text>.MAX_VALUE) throw new RETCODE_ILLEGAL_OPERATION();&nl;</xsl:text>
                        <xsl:text>        _d = _default;&nl;</xsl:text>

                    </xsl:otherwise>
                </xsl:choose>                
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>        _d = </xsl:text>
                <xsl:value-of select="cases/case[1]/@value"/>
                <xsl:text>;&nl;</xsl:text>
            </xsl:otherwise>

        </xsl:choose>

        <xsl:text>        </xsl:text>
        <xsl:value-of select="@name"/> = __value;
    }<xsl:text>&nl;</xsl:text>

    <xsl:text>&nl;</xsl:text>
</xsl:for-each>

<!-- <xsl:if test="$generateDef = 'yes'"> Default should always be generated -->

    <!-- verifyDefault -->
    <xsl:text>    private void verifyDefault(</xsl:text>
    <xsl:value-of select="$discNativeBaseType"/><xsl:text> discriminator) {&nl;</xsl:text>
        <xsl:call-template name="getVerifyStmt">
            <xsl:with-param name="caseList" select=".//cases/case[@value != 'default']"/>
            <xsl:with-param name="default" select="1"/>
        </xsl:call-template>

    <xsl:text>    }&nl;&nl;</xsl:text>

    <!-- __default(discriminator,value) -->
    <xsl:text>    public void __default(</xsl:text>
    <xsl:value-of select="$discNativeBaseType"/><xsl:text> discriminator) {&nl;</xsl:text>    
    <xsl:text>        verifyDefault(discriminator);&nl;</xsl:text>

    <xsl:text>        _d = discriminator;&nl;</xsl:text>
    <xsl:text>    }&nl;&nl;</xsl:text>

    <!-- __default(value) -->
    <xsl:text>    public void __default() {&nl;</xsl:text>    
    <xsl:choose>
        <xsl:when test="$discBaseType='boolean'">

            <xsl:choose>
                <xsl:when test=".//cases/case[@value = 'true'] and 
                                .//cases/case[@value = 'false']">
                    <xsl:text>        throw new RETCODE_ILLEGAL_OPERATION();&nl;</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>        _d = _default;&nl;</xsl:text>
                </xsl:otherwise>

            </xsl:choose>
        </xsl:when>
        <xsl:when test="$discBaseEnum = 'yes'">
            <xsl:text>        if (_default ==</xsl:text>
            <xsl:text> null) throw new RETCODE_ILLEGAL_OPERATION();&nl;</xsl:text>
            <xsl:text>        _d = _default;&nl;</xsl:text>

        </xsl:when>
        <xsl:otherwise>
            <xsl:text>        if (_default ==</xsl:text>
            <xsl:value-of select="$typeInfoMap/type[@idlType = $discBaseType]/@class"/>
            <xsl:text>.MAX_VALUE) throw new RETCODE_ILLEGAL_OPERATION();&nl;</xsl:text>
            <xsl:text>        _d = _default;&nl;</xsl:text>

        </xsl:otherwise>
    </xsl:choose>                
    <xsl:text>    }&nl;</xsl:text>

<!-- </xsl:if> -->
        
    public boolean equals(Object o) {
        if (o == null) {
            return false;
        }
    
        if(getClass() != o.getClass()) {
            return false;
        }

        <xsl:value-of select="@name"/> otherObj = (<xsl:value-of select="@name"/>)o;

        if(_d != otherObj._d) {
            return false;
        }
<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'equals'"/>

</xsl:apply-templates>
        return true;
    }

    public int hashCode() {
        int __result = 0;
<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'hashCode'"/>
</xsl:apply-templates>
        return __result;
    }
    
<xsl:if test="$useCopyable = 'true'">
    /**
     * This is the implementation of the &lt;code&gt;Copyable&lt;/code&gt; interface.
     * This method will perform a deep copy of &lt;code&gt;src&lt;/code&gt;
     * This method could be placed into &lt;code&gt;<xsl:value-of select="@name"/>TypeSupport&lt;/code&gt;
     * rather than here by using the &lt;code&gt;-noCopyable&lt;/code&gt; option
     * to rtiddsgen.
     * 
     * @param src The Object which contains the data to be copied.
     * @return Generally, return &lt;code&gt;this&lt;/code&gt; but special
     *         cases (such as &lt;code&gt;Enum&lt;/code&gt;) exist.
     * @exception NullPointerException If &lt;code&gt;src&lt;/code&gt; is null.
     * @exception ClassCastException If &lt;code&gt;src&lt;/code&gt; is not the 
     * same type as &lt;code&gt;this&lt;/code&gt;.
     * @see com.rti.dds.infrastructure.Copyable#copy_from(java.lang.Object)
     */
    public Object copy_from(Object other) {
        <!-- using typedSrc and typedDst, we can keep the templates the same
             when using Copyable or when putting the copy method in the
             TypeSupport class. -->

        <xsl:value-of select="@name"/> typedSrc = (<xsl:value-of select="@name"/>)other;
        <xsl:value-of select="@name"/> typedDst = this;
    <!-- generate code to copy the discriminator. -->
    <xsl:call-template name="generateMemberCode">
        <xsl:with-param name="generationMode" select="'copy'"/>
        <xsl:with-param name="member" select="./discriminator"/>
    </xsl:call-template>

<xsl:apply-templates mode="code-generation">

    <xsl:with-param name="generationMode" select="'copy'"/>
</xsl:apply-templates>
        return this;
    }
</xsl:if>
    
    public String toString(){
        return toString("", 0);
    }
    
    <!-- print method -->
    public String toString(String desc, int indent) {
        <xsl:if test="member[@bitField]">
        long bits;
        </xsl:if>        

        StringBuffer strBuffer = new StringBuffer();

        if (desc != null) {
            CdrHelper.printIndent(strBuffer, indent);
            strBuffer.append(desc).append(":\n");
        }

<xsl:call-template name="generateMemberCode">

    <xsl:with-param name="generationMode" select="'print'"/>
    <xsl:with-param name="member" select="./discriminator"/>
</xsl:call-template>

<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'print'"/>
</xsl:apply-templates>
        return strBuffer.toString();
    }
    
}

<xsl:call-template name="processGlobalElements">
    <xsl:with-param name="element" select="."/>
    <xsl:with-param name="following" select="'yes'"/>

</xsl:call-template>

</file>
</xsl:template>

<!--
Process directives
-->

<xsl:template match="directive[@kind = 'copy-declaration' or @kind = 'copy-java-declaration']">
<xsl:text>&nl;</xsl:text><xsl:value-of select="text()"/>
</xsl:template>

<xsl:template match="directive[@kind = 'copy-declaration' or @kind = 'copy-java-declaration']"
              mode="code-generation">
    <xsl:param name="generationMode"/>              

    <xsl:if test="$generationMode = 'structMember'">
        <xsl:text>&nl;</xsl:text><xsl:value-of select="text()"/>

    </xsl:if>
</xsl:template>

<xsl:template match="directive[@kind = 'copy-java-declaration-begin']" mode="code-generation-begin">
    <xsl:param name="associatedType"/>

    <xsl:if test="(./following-sibling::node()[name(.) != 'directive'])[1]/@name = $associatedType/@name">
<xsl:text>&nl;</xsl:text><xsl:value-of select="text()"/>
    </xsl:if>
</xsl:template>


</xsl:stylesheet>

