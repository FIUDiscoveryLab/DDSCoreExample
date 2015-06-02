<?xml version="1.0"?>
<!--
/* $Id: typeSeq.java.xsl,v 1.5 2012/04/23 16:44:18 fernando Exp $

   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.

Modification history:
- - - - - - - - - - -
1.0ac,08dec10,fcs Added copy-java-begin and copy-java-declaration-begin
10ae,26feb10,fcs Sequence suffix support
10ac,23aug09,fcs Serializable support
10u,04aug08,ao  typos
10u,16jul08,tk  Removed utils.xsl
10u,21mar08,vtg Renamed create/destroy_sample to create/destroy_data
10p,31dec07,vtg Made consistent with new type plugin API [First pass]
10l,08sep06,krb Fixed a bug in the FooSeq.equals() method when generated with 
                the -corba option.
10m,07sep06,rbw Updated for LoanableSequence support
10l,16aug06,krb Added documenation and reworked the copy_from() method.
10l,14aug06,krb Added copy functionality (filed as bug 11000).
                Also refactored equals() method to the base class.
10l,01may06,fcs Merged from BRANCH_NDDSGEN_JAVA_CORBA
10f,21jul05,fcs Modified processGlobalElements template call to include element parameter                
10d,26mar05,fcs Generated code for typedefs
10d,25aug04,rw  Call processGlobalElements
10d,24aug04,rw  Replaced tabs with spaces to improve readability of generated
                code
10d,23aug04,rw  Fixed line endings
10c,03may04,rrl Fixed a bug in equals()
10c,26apr04,rrl Modifications to support new deserialize_objectX() API and enum support
                as well as API changes in DataTypeImpl from *I() to *X()
10c,06apr04,rrl Created (from type.java.xsl)
-->

<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
<!ENTITY namespaceSeperator ".">    <!-- namespace separator -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xalan="http://xml.apache.org/xalan"
    version="1.0">

<xsl:include href="typeCommon.java.xsl"/>

<xsl:output method="xml"/>

<xsl:param name="corbaHeader"/>

<xsl:template match="struct|enum|typedef">        
    <xsl:param name="containerNamespace"/>

    <!-- check to see if we are processing files with the -corba option and that the
         current type is a typedef. In this case, we don't want to generate files. -->
    <xsl:variable name="isCorbaAndTypedef">
        <xsl:choose>
            <xsl:when test="$corbaHeader!='none' and name(.)='typedef'">true</xsl:when>
            <xsl:otherwise>false</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="className">
        <xsl:if test="name(.)='typedef'">
            <xsl:variable name="baseMemberKind">
                <xsl:call-template name="obtainBaseMemberKind">
                    <xsl:with-param name="member" select="member"/>
                </xsl:call-template>
            </xsl:variable>
            
            <xsl:choose>
                <xsl:when test="$baseMemberKind='sequence' or 
                                $baseMemberKind='array' or
                                $baseMemberKind='arraySequence'"><xsl:value-of select="@name"/>.class</xsl:when>
                <xsl:otherwise>No generate</xsl:otherwise>
            </xsl:choose>                
        </xsl:if>
        <xsl:if test="not(name(.)='typedef')"><xsl:value-of select="@name"/>.class</xsl:if>        
    </xsl:variable>

<xsl:if test="contains($className,'class') and $isCorbaAndTypedef='false'">
        
<xsl:variable name="sourceFile">
    <xsl:call-template name="obtainSourceFileName">
        <xsl:with-param name="containerNamespace" select="$containerNamespace"/>
        <xsl:with-param name="typeName" select="concat(@name, $typeSeqSuffix)"/>
    </xsl:call-template>
</xsl:variable>
<file name="{$sourceFile}">
<xsl:call-template name="printPackageStatement">
    <xsl:with-param name="containerNamespace" select="$containerNamespace"/>
</xsl:call-template>

import java.util.Collection;

import com.rti.dds.infrastructure.Copyable;
import com.rti.dds.util.Enum;
import com.rti.dds.util.Sequence;
import com.rti.dds.util.LoanableSequence;

<xsl:apply-templates select="./preceding-sibling::node()[@kind = 'copy-java-begin']" 
                     mode="code-generation-begin">
    <xsl:with-param name="associatedType" select="."/>
</xsl:apply-templates>

<xsl:call-template name="processGlobalElements">
    <xsl:with-param name="element" select="."/>
</xsl:call-template>

/**
 * A sequence of <xsl:value-of select="@name"/> instances.
 */
public final class <xsl:value-of select="concat(@name,$typeSeqSuffix)"/> extends LoanableSequence implements Copyable {
    // -----------------------------------------------------------------------
    // Package Fields
    // -----------------------------------------------------------------------

    /**
     * When a memory loan has been taken out in the lower layers of 
     * <xsl:value-of select="$coreProduct"/>, store a pointer to the native sequence here. 
     * That way, when we call finish(), we can give the memory back.
     */
    /*package*/ transient Sequence _loanedInfoSequence = null;

    // -----------------------------------------------------------------------
    // Public Fields
    // -----------------------------------------------------------------------

    // --- Constructors: -----------------------------------------------------

    public <xsl:value-of select="concat(@name,$typeSeqSuffix)"/>() {
        super(<xsl:value-of select="$className"/>);
    }


    public <xsl:value-of select="concat(@name,$typeSeqSuffix)"/>(int initialMaximum) {
        super(<xsl:value-of select="$className"/>, initialMaximum);
    }


    public <xsl:value-of select="concat(@name,$typeSeqSuffix)"/>(Collection elements) {
        super(<xsl:value-of select="$className"/>, elements);
    }
    
<xsl:if test="$corbaHeader!='none'">
    /**
     * This method is overridden from the base class because in the base class,
     * the &lt;code&gt;equals()&lt;code&gt; method is used to compare each of
     * the instances. When code is generated with the -corba flag, some CORBA
     * code generators do not generate an &lt;code&gt;equals()&lt;code&gt;
     * method which actually compares instances.
     * @see java.lang.Object#equals(java.lang.Object)
     */
    public boolean equals(Object o){
        if (o == null){
            return false;
        }
        
        if(getClass() != o.getClass()) {
            return false;
        }

        <xsl:value-of select="concat(@name,$typeSeqSuffix)"/> otherObj = (<xsl:value-of select="concat(@name,$typeSeqSuffix)"/>) o;
        if (size() != otherObj.size()) {
            return false;
        }
        
        for(int i = 0; i &lt; size(); ++i) {
            <xsl:value-of select="@name"/> left = (<xsl:value-of select="@name"/>) get(i);
            <xsl:value-of select="@name"/> right = (<xsl:value-of select="@name"/>) otherObj.get(i);
            if ( ! (left == null ? 
                        right == null : // if both are null, then they are equal
                        (right != null &amp;&amp; 
                           <xsl:value-of select="@name"/>TypeSupport.get_instance().are_samples_equal(left, right)))){
                return false;
            }
        }
        return true;
    }
</xsl:if>
    // --- From Copyable: ----------------------------------------------------
    
    /**
     * Copy data into &lt;code&gt;this&lt;/code&gt; object from another.
     * The result of this method is that both &lt;code&gt;this&lt;/code&gt;
     * and &lt;code&gt;src&lt;/code&gt; will be the same size and contain the
     * same data.
     * 
     * @param src The Object which contains the data to be copied
     * @return &lt;code&gt;this&lt;/code&gt;
     * @exception NullPointerException If &lt;code&gt;src&lt;/code&gt; is null.
     * @exception ClassCastException If &lt;code&gt;src&lt;/code&gt; is not a 
     * &lt;code&gt;Sequence&lt;/code&gt; OR if one of the objects contained in
     * the &lt;code&gt;Sequence&lt;/code&gt; is not of the expected type.
     * @see com.rti.dds.infrastructure.Copyable#copy_from(java.lang.Object)
     */
    public Object copy_from(Object src) {
        Sequence typedSrc = (Sequence) src;
        final int srcSize = typedSrc.size();
        final int origSize = size();
        
        // if this object's size is less than the source, ensure we have
        // enough room to store all of the objects
        if (getMaximum() &lt; srcSize) {
            setMaximum(srcSize);
        }
        
        // trying to avoid clear() method here since it allocates memory
        // (an Iterator)
        // if the source object has fewer items than the current object,
        // remove from the end until the sizes are equal
        if (srcSize &lt; origSize){
            removeRange(srcSize, origSize);
        }
        
        // copy the data from source into this (into positions that already
        // existed)
        for(int i = 0; (i &lt; origSize) &amp;&amp; (i &lt; srcSize); i++){
            if (typedSrc.get(i) == null){
                set(i, null);
            } else {
                // check to see if our entry is null, if it is, a new instance has to be allocated
                if (get(i) == null){ 
        <xsl:choose>
            <xsl:when test="$useCopyable = 'true' and $corbaHeader='none'">
                <xsl:text>            set(i, </xsl:text>
                <xsl:value-of select="@name"/><xsl:text>.create());</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>            set(i, </xsl:text>
                <xsl:value-of select="@name"/><xsl:text>TypeSupport.get_instance().create_data());</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
                }
                set(i, ((Copyable) get(i)).copy_from(typedSrc.get(i)));
            }
        }
        
        // copy 'new' <xsl:value-of select="@name"/> objects (beyond the original size of this object)
        for(int i = origSize; i &lt; srcSize; i++){
            if (typedSrc.get(i) == null) {
                add(null);
            } else {
                // NOTE: we need to create a new object here to hold the copy
        <xsl:choose>
            <xsl:when test="$useCopyable = 'true' and $corbaHeader='none'">
                <xsl:text>        add(</xsl:text><xsl:value-of select="@name"/><xsl:text>.create());</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>        add(</xsl:text><xsl:value-of select="@name"/><xsl:text>TypeSupport.get_instance().create_data());</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
                // we need to do a set here since enums aren't truely Copyable
                set(i, ((Copyable) get(i)).copy_from(typedSrc.get(i)));
            }
        }
        
        return this;
    }

}
</file>
</xsl:if> <!-- end if class -->
</xsl:template>
</xsl:stylesheet>
