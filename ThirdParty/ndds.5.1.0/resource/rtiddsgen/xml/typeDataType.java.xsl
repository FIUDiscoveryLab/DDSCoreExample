<?xml version="1.0"?>
<!-- 
/* $Id: typeDataType.java.xsl,v 1.25 2013/10/29 05:09:30 fernando Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
Modification history:
- - - - - - - - - - -
5.1.0,27oct13,fcs CODEGEN-624: Missing useExtendedMemberId initialization in 
                  the serialize method for types with optional members
5.1.0,24sep13,fcs CODEGEN-622: When an enum is the last field in a type, a 
                  deserialize error is not generated if the value is outside of 
                  valid enumerations.
5.0.1,14jun13,fcs CODEGEN-578: Support CDR_ENCAPSULATION_MEMBER_ID_IGNORE
5.0.1,10jun13,fcs CODEGEN-596: TypePlugin code generation for optional members in Java
5.0.1,18may13,fcs Fixed serialization of LIST_END parameter
5.0.1,16may13,fcs CODEGEN-588: Union mutability support in Java
5.0.1,06may13,fcs CODEGEN-584: Received samples for an Extensible type may 
                  contain invalid values for fields not present on the wire
5.0.0,12dec12,fcs Fixed CODEGEN-528: Deserialization error on a Java/.NET 
                  DataReader subscribing to an extended type and receiving 
                  samples from a base type
5.0.0,08dec12,fcs Fixed bug CODEGEN-530: A DataReader may fail to deserialize 
                  samples if the underlying type is an extended type where the 
                  type of the last member requires 8-byte alignment
5.0x,25apr12,acr CODEGEN-492 Added get_type() to TypeSupport classes
1.0ac,08dec10,fcs Added copy-java-begin and copy-java-declaration-begin
10ae,05may10,fcs Fixed bug 13441
10ae,18apr10,fcs Fixed bug 13415
10ac,20jan10,fcs Fixed bug 12991
10ac,26oct09,fcs Changed return value of get serialize size functions to long
10ac,29aug09,fcs Double pointer indirection and dropSample
                 in deserialize function
10ac,20aug09,fcs Added encapsulation error detection &
                 Removed CDR_NATIVE usage
1.0ac,16aug09,fcs Fixed get_serialized_sample_size for enums
1.0ac,10aug09,fcs get_serialized_sample_size support
10u,21may09,fcs Fixed bug 12972
10u,06may09,fcs Fixed instance_to_keyhash
10u,16jul08,tk  Removed utils.xsl
10u,27mar08,eys Added getInstance() to support backward compatibility
10u,26mar08,vtg Renamed copy_sample to copy_data
10u,21mar08,vtg Renamed create/destroy_sample to create/destroy_data
10u,12mar08,fcs Compatibility mode for batch
10s,07mar08,fcs Fixed get_serialized_xxx_max(min)_size functions
10s,07mar08,jpl Refactored new type plug-in interface
10s,05mar08,fcs Added rtidds42e code generation
10s,04mar08,fcs Finalize support for MD5
10s,29feb08,fcs Support for get_min_size_serialized
10s,18feb08,fcs MD5 KeyHash generation support
10p,18feb08,fcs Skip support
10p,01feb08,fcs Fixed bug 12145
10p,13jan08,eys Fixed get_serialized_sample_max_size() for enum
10p,31dec07,vtg Made consistent with new type plugin API [First pass]
10q,25nov07,fcs Fixed (de)serialize_object_encapsulation for struct/typedef
10q,07sep07,fcs Added serialized_instance_data_to_id function to type plug-in API
10q,20sep07,jpl Added functions to (de)serialize encapsulation to type plug-in API
10q,12sep07,jpl Added serialized_instance_to_id to type plug-in API
10p,11jul07,eh  Refactor data encapsulation to support previous nddsgen-generated plugins;
                use existing (de)serialize() prototype when add data encapsulation header
10m,25mar07,kaj Add endpoint_plugin_qos for TypeSupportQosPolicy
10m,29may07,fcs Added serialize_option to serialize_key/deserialize_key
10m,05apr07,eh  Added encapsulated versions of serialize, deserialize, 
                get_max_size_serialized
10m,01mar07,fcs Support for key serialization
10m,07feb07,fcs Temporary fix for bug 11734 adding an alternative constructor
                to TypeSupport
10m,24oct06,jml Added TypeSupportType param to TypeSupport constructors.
10l,15aug06,eys Added instance_to_key and key_to_instance functionality
10l,16aug06,krb Added documenation and reworked the copy_from() for enums.
10l,14aug06,krb Added copy functionality (filed as bug 11000).
10l,21apr06,fcs Changed access scope of TypeSupport constructor to protected
10l,19apr06,fcs Removed final from the TypeSupport class declaration
10l,19apr06,fcs Fixed bug 10994
10l,22mar06,fcs DDSQL support
10h,02feb06,fcs Fixed bug 10899
10h,31jan05,fcs Fixed bug in <xsl:template match="struct|typedef">
10h,13dec05,fcs Added value type support        
10f,17aug05,fcs Removed X
10f,27jul05,fcs Included warnings messages in nddsgen when the generated key code 
                can introduce loss of key data
10f,26jul05,fcs Fixed bug 10523
10f,21jul05,fcs Modified processGlobalElements template call to include element parameter                
10f,19jul05,fcs Fixed bug in TypeSupport creation without type code
10f,18jul05,fcs Included type_code parameter in the TypeSupport constructor call.
10f,06may05,jml Bug #9333 Foo::type_name() renamed as Foo::get_type_name()
10c,09apr05,fcs The methods create_datawriterX and create_datareaderX return null if the 
                type is not a top level type
10c,08apr05,fcs The methods create_datawriterX and create_datareaderX for enums return null
                bacause no DataWriters or DataReaders are created for these types
10c,26mar05,fcs Generated code for typedefs
                Refactored keys code to accept typedef types
10c,25mar05,fcs The code to print a type is moved to type.java.h
10c,22mar05,fcs Added bitfields support
10d,18oct04,rw  Updated to reflect change in com.rti.dds.util.Enum API
10d,10sep04,rw  Fixed inconsistent variable name
10d,07sep04,rw  Updated key API's in response to review feedback
10d,31aug04,rw  Always generate key translation methods: if there's no key,
                just delegate to super
10d,30aug04,rw  Generate exceptions if there are more than three key fields
10d,27aug04,rw  Fixed string key translation bugs
10d,26aug04,rw  Fixed key translation for boolean, byte, char, enum, & short
10d,25aug04,rw  Call processGlobalElements
10d,20aug04,rw  Implemented generation of instance_to_topic_keyX();
                better support for enums
10d,18aug04,rw  Implemented generation of topic_key_to_instanceX() method
10d,16aug04,rw  Better comments here and in generated code; refactored
                array/sequence (de)serialization to non-generated base class
10d,30jul04,rw  Fixed incorrect generationMode
10c,26may04,rrl Replaced tabs with 4 spaces to make output look prettier
10c,13may04,rw  Fixed incorrect type reference in generated code
10c,11may04,rrl Changed DataType suffix to TypeSupport.
10c,11may04,rrl Fixed union's computation for maxSizeSerialized.
40b,04may04,rrl Fixed sequence serialization to use "int" for sizes (to match
                C/C++).        
40b,26apr04,rrl Modifications to support new deserialize_objectX() API and enum support
                as well as API changes in TypeSupportImpl from *I() to *X()
40b,21apr04,rrl Support sequences
40b,09mar04,rrl Created
-->

<!--
Purpose: To transform the simplified XML representation of an IDL file 
         (see simplyfyIDLXML.xsl) to corresponding 'java' type plug-in code. 

Overview: 
    Please see typePlugin.c.xsl for processing model and related information.
    
-->


<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
<!ENTITY namespaceSeperator "_">    <!-- namespace separator -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:xalan = "http://xml.apache.org/xalan">

<xsl:include href="typeCommon.java.xsl"/>
<xsl:include href="typeDatabaseDataType.java.xsl"/>

<xsl:param name="typecode"/>

<xsl:param name="rtidds42e"/>

<xsl:param name="javabufferpool"/>

<xsl:output method="xml"/>

<xsl:variable name="sourcePreamble">
    <xsl:value-of select="$generationInfo/sourcePreamble[@kind = 'type-datatype-source']"/>
import com.rti.dds.infrastructure.*;
import com.rti.dds.topic.TypeSupportParticipantInfo;
import com.rti.dds.topic.TypeSupportEndpointInfo;
import com.rti.dds.typecode.TypeCode;
import com.rti.dds.cdr.IllegalCdrStateException;

</xsl:variable>

<!-- ===================================================================== -->
<!-- Enum Types                                                            -->
<!-- ===================================================================== -->

<xsl:template match="enum">
    <xsl:param name="containerNamespace"/>
    <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace, @name)"/>

    <xsl:variable name="xType">
        <xsl:call-template name="getExtensibilityKind">
            <xsl:with-param name="structName" select="./@name"/>
            <xsl:with-param name="node" select="."/>
            <xsl:with-param name="typeKind" select="'enum'"/>
        </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="fullyQualifiedStructNameCPP">
        <xsl:for-each select="./ancestor::module">
            <xsl:value-of select="@name"/>
            <xsl:text>::</xsl:text>                
        </xsl:for-each>
        <xsl:value-of select="@name"/>
    </xsl:variable>

<xsl:variable name="sourceFile">
    <xsl:call-template name="obtainSourceFileName">
        <xsl:with-param name="containerNamespace" select="$containerNamespace"/>
        <xsl:with-param name="typeName" select="concat(@name, 'TypeSupport')"/>
    </xsl:call-template>
</xsl:variable>    
<file name="{$sourceFile}">
<xsl:call-template name="printPackageStatement">
    <xsl:with-param name="containerNamespace" select="$containerNamespace"/>
</xsl:call-template>

    <xsl:value-of select="$sourcePreamble"/>
<xsl:choose>
    <xsl:when test="$useCopyable = 'false'">
import com.rti.dds.util.Enum;
    </xsl:when>
    <xsl:otherwise>
import com.rti.dds.infrastructure.Copyable;
    </xsl:otherwise>
</xsl:choose>

<xsl:apply-templates select="./preceding-sibling::node()[@kind = 'copy-java-begin']" 
                     mode="code-generation-begin">
    <xsl:with-param name="associatedType" select="."/>
</xsl:apply-templates>

<xsl:call-template name="processGlobalElements">
    <xsl:with-param name="element" select="."/>
</xsl:call-template>

/**
 * A collection of useful methods for dealing with objects of type
 * <xsl:value-of select="@name"/>.
 */
public class <xsl:value-of select="@name"/>TypeSupport extends TypeSupportImpl {    
    // -----------------------------------------------------------------------
    // Private Fields
    // -----------------------------------------------------------------------

    private static final String TYPE_NAME = "<xsl:value-of select="$fullyQualifiedStructNameCPP"/>";

    private static final char[] PLUGIN_VERSION = {2, 0, 0, 0};

    private static final <xsl:value-of select="@name"/>TypeSupport _singleton
        = new <xsl:value-of select="@name"/>TypeSupport();    

    // -----------------------------------------------------------------------
    // Public Methods
    // -----------------------------------------------------------------------

    // --- External methods: -------------------------------------------------
    /* The methods in this section are for use by users of <xsl:value-of select="$coreProduct"/>
     */

    public static String get_type_name() {
        return _singleton.get_type_nameI();
    }

    // --- Internal methods: -------------------------------------------------
    /* The methods in this section are for use by <xsl:value-of select="$coreProduct"/>
     * itself and by the code generated by rtiddsgen for other types.
     * They should be used directly or modified only by advanced users and are
     * subject to change in future versions of <xsl:value-of select="$coreProduct"/>.
     */

    public static <xsl:value-of select="@name"/>TypeSupport get_instance() {
        return _singleton;
    }

    /* deprecated API */
    public static <xsl:value-of select="@name"/>TypeSupport getInstance() {
        return get_instance();
    }
    
    /* Doesn't make sense for an enum to create a instance without a value*/ 
    public Object create_data() {
        return null;
    }

    public void destroy_data(Object data) {
        return;
    }

    /* This is a concrete implementation of this method inherited from the base class.
     * While this implementation is not strictly a copy it can have the same effect. 
     * In order to use it properly, assign the result of the operation to the member 
     * that is the target of the copy.
     * So, for example:
     *    myEnumField = <xsl:value-of select="@name"/>TypeSupport.get_instance().copy_data(anotherInstanceOfEnum);
     * Since &lt;code&gt;Enum&lt;/code&gt;s are immutable there cannot be a true copy 
     * made but this method will return a reference to the same enumerate as 
     * &lt;code&gt;source&lt;/code&gt;.
     * @return returns &lt;code&gt;source&lt;/code&gt;
     */
    public Object copy_data(Object destination, Object source) {
        return source;
    }
    
    public Class get_type() {
        return <xsl:value-of select="@name"/>.class;
    }

    <!-- serialize data method -->
    public void serialize(Object endpoint_data,Object src, CdrOutputStream dst, boolean serialize_encapsulation, short encapsulation_id, boolean serialize_sample, Object endpoint_plugin_qos) {
        int position = 0;
<xsl:if test="$rtidds42e='yes'">
        boolean topLevel;
</xsl:if>

        <xsl:value-of select="@name"/> typedSrc = (<xsl:value-of select="@name"/>) src;   
        if(serialize_encapsulation) { 
          dst.serializeAndSetCdrEncapsulation(encapsulation_id);

<xsl:if test="$rtidds42e='no'">
          position = dst.resetAlignment();
</xsl:if>
        }
        if(serialize_sample) {
<xsl:if test="$rtidds42e='yes'">
          topLevel = !dst.isDirty();
          dst.setDirtyBit(true);

          if (!serialize_encapsulation &amp;&amp; topLevel) {
            position = dst.resetAlignmentWithOffset(4);
          }
</xsl:if>
          dst.writeInt(typedSrc.ordinal());
<xsl:if test="$rtidds42e='yes'">
          if (!serialize_encapsulation &amp;&amp; topLevel) {
            dst.restoreAlignment(position);
          }
</xsl:if>
        }

<xsl:if test="$rtidds42e='no'">
        if (serialize_encapsulation) {
          dst.restoreAlignment(position);
        }
</xsl:if>
    }
    
    <!-- deserialize datamethod -->
    public Object deserialize_sample(
        Object endpoint_data,Object dst, 
        CdrInputStream src, boolean deserialize_encapsulation, 
        boolean deserialize_sample,Object endpoint_plugin_qos) {
        int position = 0;
<xsl:if test="$rtidds42e='yes'">
        boolean topLevel;
</xsl:if>

        // ignore dst since we are dealing with an immutable object
        if(deserialize_encapsulation) {
          src.deserializeAndSetCdrEncapsulation();

<xsl:if test="$rtidds42e='no'">
          position = src.resetAlignment();
</xsl:if>
        }

        if(deserialize_sample) {
<xsl:if test="$rtidds42e='yes'">
            topLevel = !src.isDirty();
            src.setDirtyBit(true);

            if (!deserialize_encapsulation &amp;&amp; topLevel) {
                position = src.resetAlignmentWithOffset(4);
            }
</xsl:if>
            int ordinal = src.readInt();
            dst = <xsl:value-of select="@name"/>.valueOf(ordinal);
            
            if (dst == null) {
                throw new IllegalArgumentException(
                    "invalid enumerator " + ordinal);
            
            }
            
<xsl:if test="$rtidds42e='yes'">
            if (!deserialize_encapsulation &amp;&amp; topLevel) {
                src.restoreAlignment(position);
            }
</xsl:if>
        }

<xsl:if test="$rtidds42e='no'">
        if (deserialize_encapsulation) {
          src.restoreAlignment(position);
        }
</xsl:if>

        return dst;
    }

    <!-- skip method -->
    public void skip(Object endpoint_data, 
                     CdrInputStream src,
                     boolean skip_encapsulation, 
                     boolean skip_sample, 
                     Object endpoint_plugin_qos)
    {
        int position = 0;
<xsl:if test="$rtidds42e='yes'">
        boolean topLevel;
</xsl:if>

        if (skip_encapsulation) {
            src.skipEncapsulation();

<xsl:if test="$rtidds42e='no'">
            position = src.resetAlignment();
</xsl:if>
        }

        if (skip_sample) {
<xsl:if test="$rtidds42e='yes'">
            topLevel = !src.isDirty();
            src.setDirtyBit(true);

            if (!skip_encapsulation &amp;&amp; topLevel) {
                position = src.resetAlignmentWithOffset(4);
            }
</xsl:if>
            src.skipInt();
<xsl:if test="$rtidds42e='yes'">
            if (!skip_encapsulation &amp;&amp; topLevel) {
                src.restoreAlignment(position);
            }
</xsl:if>
        }

<xsl:if test="$rtidds42e='no'">
        if (skip_encapsulation) {
          src.restoreAlignment(position);
        }
</xsl:if>
    }

    <!-- get_max_size_serialized_encapsulatedX method -->
    public long get_serialized_sample_max_size(Object endpoint_data,boolean include_encapsulation,short encapsulation_id,long currentAlignment) {
<xsl:if test="$rtidds42e='no'">
        long encapsulation_size = currentAlignment;
</xsl:if> 
        long origAlignment = currentAlignment;

        if (include_encapsulation) {
            if (!CdrEncapsulation.isValidEncapsulationKind(encapsulation_id)) {
                throw new RETCODE_ERROR("Unsupported encapsulation");
            }

<xsl:if test="$rtidds42e='no'">
            encapsulation_size += CdrPrimitiveType.SHORT.getMaxSizeSerialized(encapsulation_size);
            encapsulation_size += CdrPrimitiveType.SHORT.getMaxSizeSerialized(encapsulation_size);
            encapsulation_size -= currentAlignment;
            currentAlignment = 0;
            origAlignment = 0;
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
            currentAlignment += CdrPrimitiveType.SHORT.getMaxSizeSerialized(currentAlignment);
            currentAlignment += CdrPrimitiveType.SHORT.getMaxSizeSerialized(currentAlignment);
</xsl:if>
        }

        currentAlignment += CdrPrimitiveType.INT.getMaxSizeSerialized(currentAlignment);

<xsl:if test="$rtidds42e='no'">
        if (include_encapsulation) {
            currentAlignment += encapsulation_size;
        }
</xsl:if>

        return currentAlignment - origAlignment;
    }

    <!-- get_serialized_sample_min_size method -->
    public long get_serialized_sample_min_size(Object endpoint_data,boolean include_encapsulation,short encapsulation_id,long currentAlignment) {
        return get_serialized_sample_max_size(endpoint_data,include_encapsulation,encapsulation_id,currentAlignment);
    }

    <!-- get_serialized_sample_size method -->
    public long get_serialized_sample_size(
	Object endpoint_data, boolean include_encapsulation, 
        short encapsulation_id, long current_alignment,
	Object sample) 
    {
        return get_serialized_sample_max_size(endpoint_data,include_encapsulation,encapsulation_id,current_alignment);
    }

    <!-- serialize method for keys -->
    public void serialize_key(
        Object endpoint_data,
        Object src,
        CdrOutputStream dst,
        boolean serialize_encapsulation,
        short encapsulation_id,
        boolean serialize_key,
        Object endpoint_plugin_qos) 
    {
        serialize(endpoint_data, src, dst, serialize_encapsulation, encapsulation_id, serialize_key, endpoint_plugin_qos);
    }
    
    <!-- deserialize method for keys -->
    public Object deserialize_key_sample(
        Object endpoint_data,
        Object dst,
        CdrInputStream src,
        boolean deserialize_encapsulation,
        boolean deserialize_key,
        Object endpoint_plugin_qos) 
    {
        return deserialize_sample(endpoint_data, dst, src, deserialize_encapsulation, deserialize_key, endpoint_plugin_qos);
    }
    
    <!-- get_max_size_serialized method for keys -->
    public long get_serialized_key_max_size(
        Object endpoint_data,
        boolean include_encapsulation,
        short encapsulation_id,
        long currentAlignment) 
    {
        return get_serialized_sample_max_size(endpoint_data,include_encapsulation,encapsulation_id,currentAlignment);
    }

    <!-- serialized_sample_to_key -->
    public Object serialized_sample_to_key(
        Object endpoint_data,
        Object sample,
        CdrInputStream src, 
        boolean deserialize_encapsulation,  
        boolean deserialize_key, 
        Object endpoint_plugin_qos) 
    {    
        return deserialize_sample(
            endpoint_data,sample,src,deserialize_encapsulation,deserialize_key,
            endpoint_plugin_qos);
    }

    // -----------------------------------------------------------------------
    // Protected Methods
    // -----------------------------------------------------------------------

    protected DataWriter create_datawriter(long native_writer,
                                           DataWriterListener listener,
                                           int mask) {
        return null;
    }

    protected DataReader create_datareader(long native_reader,
                                           DataReaderListener listener,
                                           int mask) {
        return null;
    }

    // -----------------------------------------------------------------------
    // Constructor
    // -----------------------------------------------------------------------

    protected <xsl:value-of select="@name"/>TypeSupport() {
        <xsl:if test="$typecode='yes'">
            super(TYPE_NAME, false /*no key*/,<xsl:value-of select="@name"/>TypeCode.VALUE,<xsl:value-of select="@name"/>.class,TypeSupportType.TST_ENUM, PLUGIN_VERSION);
        </xsl:if>
        <xsl:if test="$typecode='no'">
            super(TYPE_NAME, false /*no key*/,null,<xsl:value-of select="@name"/>.class,TypeSupportType.TST_ENUM, PLUGIN_VERSION);
        </xsl:if>        
    }
}
</file>
</xsl:template>

<!-- -->
<xsl:template match="struct|typedef">
    <xsl:param name="containerNamespace"/>
    
    <xsl:variable name="xType">
        <xsl:call-template name="getExtensibilityKind">
            <xsl:with-param name="structName" select="./@name"/>
            <xsl:with-param name="node" select="."/>
        </xsl:call-template>
     </xsl:variable>

    <xsl:variable name="keyFields"
                  select="member[following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'key']]"/>

    <xsl:variable name="isKeyed">
        <xsl:choose>
            <xsl:when test="directive[@kind='key'] or (@keyedBaseClass and @keyedBaseClass='yes')">yes</xsl:when>
            <xsl:otherwise>no</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="topLevel">
        <xsl:call-template name="isTopLevelType">
            <xsl:with-param name="typeNode" select="."/>
        </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="mutableTypeStartDesBlock">
        <xsl:text>
            while (end != true &amp;&amp; src.available() > 0) {
                memberInfo = src.readMemberInfo();
                tmpPosition = src.getBuffer().currentPosition();
                tmpSize = src.getBuffer().getSize();
                tmpLength = memberInfo.length;
                src.getBuffer().setDesBufferSize((int)(tmpPosition + memberInfo.length));

                switch (memberInfo.memberId) {
                    case CdrEncapsulation.CDR_ENCAPSULATION_MEMBER_ID_IGNORE:
                        break;                        
                    case CdrEncapsulation.CDR_ENCAPSULATION_MEMBER_ID_LIST_END: 
                        end = true;
                        break;</xsl:text>
    </xsl:variable>

    <xsl:variable name="mutableTypeEndDesBlock">
        <xsl:text>
                    default:</xsl:text>
            <xsl:if test="@kind!='union'">
        <xsl:text>
                        if (memberInfo.flagMustUnderstand) {</xsl:text>
            </xsl:if>
        <xsl:text>
                            throw new RETCODE_ERROR(
                                          "unknown member ID "+ 
                                          memberInfo.memberId);</xsl:text>
            <xsl:if test="@kind!='union'">
        <xsl:text>
                        } break;</xsl:text>
            </xsl:if>
        <xsl:text>
                }
            
                src.getBuffer().setDesBufferSize(tmpSize);
                src.getBuffer().setCurrentPosition((int)(tmpPosition + tmpLength));
            }</xsl:text>
    </xsl:variable>
    
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
            
    <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace, @name)"/>

    <xsl:variable name="fullyQualifiedStructNameCPP">
        <xsl:for-each select="./ancestor::module">
            <xsl:value-of select="@name"/>
            <xsl:text>::</xsl:text>                
        </xsl:for-each>
        <xsl:value-of select="@name"/>
    </xsl:variable>

    <xsl:variable name="pointerFields" select="member[@type='string' or @type='wstring' or @kind='sequence']"/>
<xsl:variable name="sourceFile">
    <xsl:call-template name="obtainSourceFileName">
        <xsl:with-param name="containerNamespace" select="$containerNamespace"/>
        <xsl:with-param name="typeName" select="concat(@name, 'TypeSupport')"/>
    </xsl:call-template>
</xsl:variable>    
<file name="{$sourceFile}">
<xsl:call-template name="printPackageStatement">
    <xsl:with-param name="containerNamespace" select="$containerNamespace"/>
</xsl:call-template>

<xsl:value-of select="$sourcePreamble"/>
<xsl:if test="$useCopyable = 'true'">
import com.rti.dds.infrastructure.Copyable;
</xsl:if>

<xsl:apply-templates select="./preceding-sibling::node()[@kind = 'copy-java-begin']" 
                     mode="code-generation-begin">
    <xsl:with-param name="associatedType" select="."/>
</xsl:apply-templates>
    
<xsl:call-template name="processGlobalElements">
    <xsl:with-param name="element" select="."/>
</xsl:call-template>

/**
 * A collection of useful methods for dealing with objects of type
 * <xsl:value-of select="@name"/>.
 */
public class <xsl:value-of select="@name"/>TypeSupport extends TypeSupportImpl {
    // -----------------------------------------------------------------------
    // Private Fields
    // -----------------------------------------------------------------------

    private static final String TYPE_NAME = "<xsl:value-of select="$fullyQualifiedStructNameCPP"/>";

    private static final char[] PLUGIN_VERSION = {2, 0, 0, 0};

    <xsl:if test="not(./member[last()]/@memberId)">
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
            
            <xsl:variable name="baseEnum">
                <xsl:call-template name="isBaseEnum">
                    <xsl:with-param name="member" select="member"/>
                </xsl:call-template>
            </xsl:variable>
            
            <xsl:if test="$baseEnum = 'no' and $baseMemberKind = 'scalar' and $baseTypeKind = 'user'">
       public static final int <xsl:value-of select="concat('LAST_MEMBER_ID = ', ./member/@type, 'TypeSupport.LAST_MEMBER_ID;')"/>
            </xsl:if>
        </xsl:if>

        <xsl:if test="name(.)!='typedef'">
    public static final int LAST_MEMBER_ID = 0;
        </xsl:if>
    </xsl:if>
    <xsl:if test="./member[last()]/@memberId">
    public static final int LAST_MEMBER_ID = 
        <xsl:value-of select="./member[last()]/@memberId"/>;
    </xsl:if>

    private static final <xsl:value-of select="@name"/>TypeSupport _singleton
        = new <xsl:value-of select="@name"/>TypeSupport();
    
    // -----------------------------------------------------------------------
    // Public Methods
    // -----------------------------------------------------------------------

    // --- External methods: -------------------------------------------------
    /* The methods in this section are for use by users of <xsl:value-of select="$coreProduct"/>
     */

    public static String get_type_name() {
        return _singleton.get_type_nameI();
    }

    public static void register_type(DomainParticipant participant,
                                     String type_name) {
        _singleton.register_typeI(participant, type_name);
    }

    public static void unregister_type(DomainParticipant participant,
                                       String type_name) {
        _singleton.unregister_typeI(participant, type_name);
    }

    <!-- Added in typeplugin 2.0-->
     /* The methods in this section are for use by <xsl:value-of select="$coreProduct"/>
     * itself and by the code generated by rtiddsgen for other types.
     * They should be used directly or modified only by advanced users and are
     * subject to change in future versions of <xsl:value-of select="$coreProduct"/>.
     */
    public static <xsl:value-of select="@name"/>TypeSupport get_instance() {
        return _singleton;
    }

    public static <xsl:value-of select="@name"/>TypeSupport getInstance() {
        return get_instance();
    }

    public Object create_data() {
        return <xsl:value-of select="@name"/>.create();
    }

    public void destroy_data(Object data) {
        return;
    }

    public Object create_key() {
        return new <xsl:value-of select="@name"/>();
    }

    public void destroy_key(Object key) {
        return;
    }

    public Class get_type() {
        return <xsl:value-of select="@name"/>.class;
    }
    
    /**
     * This is a concrete implementation of this method inherited from the base class.
     * This method will perform a deep copy of &lt;code&gt;source&lt;/code&gt; into
     * &lt;code&gt;destination&lt;/code&gt;.
     * 
     * @param src The Object which contains the data to be copied.
     * @return Returns &lt;code&gt;destination&lt;/code&gt;.
     * @exception NullPointerException If &lt;code&gt;destination&lt;/code&gt; or 
     * &lt;code&gt;source&lt;/code&gt; is null.
     * @exception ClassCastException If either &lt;code&gt;destination&lt;/code&gt; or
     * &lt;code&gt;this&lt;/code&gt; is not a &lt;code&gt;<xsl:value-of select="@name"/>&lt;/code&gt;
     * type.
     */
    public Object copy_data(Object destination, Object source) {
        <xsl:value-of select="@name"/> typedDst = (<xsl:value-of select="@name"/>) destination;
        <xsl:value-of select="@name"/> typedSrc = (<xsl:value-of select="@name"/>) source;
<xsl:choose>
    <xsl:when test="$useCopyable = 'false'">

        <xsl:if test="(@kind='valuetype' or @kind='struct') and @baseClass!=''">
        <xsl:value-of select="@baseClass"/>TypeSupport.get_instance().copy_data(destination, source);
        </xsl:if>
        <xsl:if test="@kind='union'">
            <!-- generate code to copy the discriminator. -->
            <xsl:call-template name="generateMemberCode">
                <xsl:with-param name="generationMode" select="'copy'"/>
                <xsl:with-param name="member" select="./discriminator"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:apply-templates mode="code-generation">
            <xsl:with-param name="generationMode" select="'copy'"/>
        </xsl:apply-templates>
        return typedDst;
    </xsl:when>
    <xsl:otherwise>
        return typedDst.copy_from(typedSrc);
    </xsl:otherwise>
</xsl:choose>
    }


    <!-- get_serialized_sample_max_size method -->
    public long get_serialized_sample_max_size(Object endpoint_data,boolean include_encapsulation,short encapsulation_id,long currentAlignment) {
        long origAlignment = currentAlignment;
<xsl:if test="$rtidds42e='no'">
        long encapsulation_size = currentAlignment;
</xsl:if>
<xsl:if test="member[@bitField]">
        int[] currentBitsCount=new int[1];                
</xsl:if>

        if(include_encapsulation) {
          if (!CdrEncapsulation.isValidEncapsulationKind(encapsulation_id)) {
              throw new RETCODE_ERROR("Unsupported encapsulation");
          }
<xsl:if test="$rtidds42e='no'">
          encapsulation_size += CdrPrimitiveType.SHORT.getMaxSizeSerialized(encapsulation_size);
          encapsulation_size += CdrPrimitiveType.SHORT.getMaxSizeSerialized(encapsulation_size);
          encapsulation_size -= currentAlignment;
          currentAlignment = 0;
          origAlignment = 0;
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
          currentAlignment += CdrPrimitiveType.SHORT.getMaxSizeSerialized(currentAlignment);
          currentAlignment += CdrPrimitiveType.SHORT.getMaxSizeSerialized(currentAlignment);
</xsl:if>
        }

 
<xsl:if test="(@kind = 'valuetype' or @kind = 'struct') and @baseClass!=''">
        currentAlignment += <xsl:value-of select="@baseClass"/>TypeSupport.get_instance().get_serialized_sample_max_size(endpoint_data,false,encapsulation_id,currentAlignment);
</xsl:if>        
<xsl:if test="@kind = 'union'">
    <!-- For unions, create a member named _d (the union discriminator) and generate code for it -->
        long maxSerialized = 0;    
    <xsl:call-template name="generateMemberCode">
        <xsl:with-param name="generationMode" select="'get_max_size_serialized'"/>
        <xsl:with-param name="member" select="./discriminator"/>
    </xsl:call-template>
</xsl:if>

<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'get_max_size_serialized'"/>
</xsl:apply-templates>
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> 
    // Sentinel
    currentAlignment += (CdrPrimitiveType.getPadSize(currentAlignment, 4) + 12);
</xsl:if>
<xsl:if test="$rtidds42e='no'">
        if (include_encapsulation) {
            currentAlignment += encapsulation_size;
        }
</xsl:if>
<xsl:choose>
    <xsl:when test="not(@kind = 'union')">    
        return currentAlignment - origAlignment;</xsl:when>
    <xsl:otherwise>
        return maxSerialized + currentAlignment - origAlignment;</xsl:otherwise>
</xsl:choose>
    }

    <!-- get_serialized_sample_min_size method -->
    public long get_serialized_sample_min_size(Object endpoint_data,boolean include_encapsulation,short encapsulation_id,long currentAlignment) {
        long origAlignment = currentAlignment;
<xsl:if test="$rtidds42e='no'">
        long encapsulation_size = currentAlignment;
</xsl:if>
<xsl:if test="member[@bitField]">
        int[] currentBitsCount=new int[1];                
</xsl:if>       
    
        if(include_encapsulation) {
            if (!CdrEncapsulation.isValidEncapsulationKind(encapsulation_id)) {
                throw new RETCODE_ERROR("Unsupported encapsulation");
            }
<xsl:if test="$rtidds42e='no'">
            encapsulation_size += CdrPrimitiveType.SHORT.getMaxSizeSerialized(encapsulation_size);
            encapsulation_size += CdrPrimitiveType.SHORT.getMaxSizeSerialized(encapsulation_size);
            encapsulation_size -= currentAlignment;
            currentAlignment = 0;
            origAlignment = 0;
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
            currentAlignment += CdrPrimitiveType.SHORT.getMaxSizeSerialized(currentAlignment);
            currentAlignment += CdrPrimitiveType.SHORT.getMaxSizeSerialized(currentAlignment);
</xsl:if>
        }
        
        <xsl:if test="(@kind = 'valuetype' or @kind = 'struct') and @baseClass!=''">
            currentAlignment += <xsl:value-of select="@baseClass"/>TypeSupport.get_instance().get_serialized_sample_min_size(endpoint_data,false,encapsulation_id,currentAlignment);
        </xsl:if>        
        <xsl:if test="@kind = 'union'">
        <!-- For unions, create a member named _d (the union discriminator) and generate code for it -->
        long minSerialized = Integer.MAX_VALUE;    
        <xsl:call-template name="generateMemberCode">
            <xsl:with-param name="generationMode" select="'get_min_size_serialized'"/>
            <xsl:with-param name="member" select="./discriminator"/>
        </xsl:call-template>
        </xsl:if>
        
        <xsl:apply-templates mode="code-generation">
        <xsl:with-param name="generationMode" select="'get_min_size_serialized'"/>
        </xsl:apply-templates>
         <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> 
        // Sentinel
        currentAlignment += (CdrPrimitiveType.getPadSize(currentAlignment, 4) + 4);
        </xsl:if>
<xsl:if test="$rtidds42e='no'">
        if (include_encapsulation) {
            currentAlignment += encapsulation_size;
        }
</xsl:if>
<xsl:choose>
    <xsl:when test="not(@kind = 'union')">    
        return currentAlignment - origAlignment;</xsl:when>
    <xsl:otherwise>
        return minSerialized + currentAlignment - origAlignment;</xsl:otherwise>
</xsl:choose>
    }

    <!-- get_serialized_sample_size method -->
    public long get_serialized_sample_size(
	Object endpoint_data, boolean include_encapsulation, 
        short encapsulation_id, long currentAlignment,
	Object sample) 
    {
        long origAlignment = currentAlignment;
<xsl:if test="$rtidds42e='no'">
        long encapsulation_size = currentAlignment;
</xsl:if>
<xsl:if test="member[@bitField]">
        int[] currentBitsCount=new int[1];                
</xsl:if>
<xsl:text>        </xsl:text><xsl:value-of select="@name"/> typedSrc = (<xsl:value-of select="@name"/>) sample;
    
        if(include_encapsulation) {
            if (!CdrEncapsulation.isValidEncapsulationKind(encapsulation_id)) {
                throw new RETCODE_ERROR("Unsupported encapsulation");
            }

<xsl:if test="$rtidds42e='no'">
            encapsulation_size += CdrPrimitiveType.SHORT.getMaxSizeSerialized(encapsulation_size);
            encapsulation_size += CdrPrimitiveType.SHORT.getMaxSizeSerialized(encapsulation_size);
            encapsulation_size -= currentAlignment;
            currentAlignment = 0;
            origAlignment = 0;
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
            currentAlignment += CdrPrimitiveType.SHORT.getMaxSizeSerialized(currentAlignment);
            currentAlignment += CdrPrimitiveType.SHORT.getMaxSizeSerialized(currentAlignment);
</xsl:if>
        }
        
<xsl:if test="(@kind = 'valuetype' or @kind = 'struct') and @baseClass!=''">
        currentAlignment += <xsl:value-of select="@baseClass"/>TypeSupport.get_instance().get_serialized_sample_size(
            endpoint_data,false,encapsulation_id,currentAlignment,sample);
</xsl:if>        
<xsl:if test="@kind = 'union'">
    <xsl:call-template name="generateMemberCode">
        <xsl:with-param name="generationMode" select="'get_serialized_sample_size'"/>
        <xsl:with-param name="member" select="./discriminator"/>
    </xsl:call-template>
</xsl:if>
    
    <xsl:apply-templates mode="code-generation">
        <xsl:with-param name="generationMode" select="'get_serialized_sample_size'"/>
    </xsl:apply-templates>
    <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> 
        // Sentinel
        currentAlignment += (CdrPrimitiveType.getPadSize(currentAlignment, 4) + 4);
    <!-- No need to take into account the extended encapsulation for the the sentinel, 
    since we never use that encapsulation -->
     
    </xsl:if>
<xsl:if test="$rtidds42e='no'">
        if (include_encapsulation) {
            currentAlignment += encapsulation_size;
        }
</xsl:if>
        return currentAlignment - origAlignment;
    }

    <!-- get_serialized_key_max_size method for keys -->
    public long get_serialized_key_max_size(
        Object endpoint_data,
        boolean include_encapsulation, 
        short encapsulation_id,
        long currentAlignment) 
    {
<xsl:if test="$rtidds42e='no'">
        long encapsulation_size = currentAlignment;
</xsl:if>
        long origAlignment = currentAlignment;
        <xsl:if test="$keyFields[@bitField]">
        int[] currentBitsCount=new int[1];                
        </xsl:if>        

        if(include_encapsulation) {
            if (!CdrEncapsulation.isValidEncapsulationKind(encapsulation_id)) {
                throw new RETCODE_ERROR("Unsupported encapsulation");
            }

<xsl:if test="$rtidds42e='no'">
            encapsulation_size += CdrPrimitiveType.SHORT.getMaxSizeSerialized(encapsulation_size);
            encapsulation_size += CdrPrimitiveType.SHORT.getMaxSizeSerialized(encapsulation_size);
            encapsulation_size -= currentAlignment;
            currentAlignment = 0;
            origAlignment = 0;
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
            currentAlignment += CdrPrimitiveType.SHORT.getMaxSizeSerialized(currentAlignment);
            currentAlignment += CdrPrimitiveType.SHORT.getMaxSizeSerialized(currentAlignment);
</xsl:if>
        }
<!-- If class has a base class, calls get_serialized_key_max_size on it -->
<xsl:if test="(@kind = 'valuetype' or @kind='struct') and @baseClass!='' and @keyedBaseClass='yes'">
        currentAlignment += <xsl:value-of select="@baseClass"/>TypeSupport.get_instance().get_serialized_key_max_size(
            endpoint_data,
            false,encapsulation_id,currentAlignment);
</xsl:if>        


<xsl:choose>
    <xsl:when test="name(.) = 'typedef'">
        <xsl:apply-templates select="./member"
                             mode="code-generation">
            <xsl:with-param name="generationMode" select="'get_max_size_serialized_key'"/>
        </xsl:apply-templates>
    </xsl:when>
    <xsl:when test="not($keyFields) and (not(@keyedBaseClass) or @keyedBaseClass='no')">
    currentAlignment += get_serialized_sample_max_size(
                            endpoint_data,false,encapsulation_id,currentAlignment);
    </xsl:when>
    <xsl:otherwise>
	<xsl:apply-templates select="member[following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'key']]"
                     mode="code-generation">
	    <xsl:with-param name="generationMode" select="'get_max_size_serialized_key'"/>
	</xsl:apply-templates>
   </xsl:otherwise>
</xsl:choose>
    <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    // Sentinel
    currentAlignment += (CdrPrimitiveType.getPadSize(currentAlignment, 4) +
                                       2*CdrPrimitiveType.SHORT.size +
                                       2*CdrPrimitiveType.INT.size);
    </xsl:if>     
<xsl:if test="$rtidds42e='no'">
        if (include_encapsulation) {
            currentAlignment += encapsulation_size;
        }
</xsl:if>
        return currentAlignment - origAlignment;
    }

    <!-- serialize datamethod -->
    public void serialize(Object endpoint_data,Object src, CdrOutputStream dst,boolean serialize_encapsulation,
                          short encapsulation_id, boolean serialize_sample, Object endpoint_plugin_qos) {
        int position = 0;
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY' or (@kind != 'union' and ./member[@optional='true'])"> 
        long memberId = 0;
        int memberLengthPosition = 0;
        boolean skipListEndId_tmp = false;
        long maxLength = 0;
        </xsl:if>

<xsl:if test="$rtidds42e='yes'">
        boolean topLevel;
</xsl:if>
        
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY' or (@kind != 'union' and ./member[@optional='true'])"> 
        if (!dst.isDirty()) {
            dst.setDirtyBit(true);

            maxLength = get_serialized_sample_max_size(endpoint_data, false, encapsulation_id,0);

            if (maxLength > 65535) {
                dst.useExtendedMemberId = true;
            } else {
                dst.useExtendedMemberId = false;
            }
        }

          <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        skipListEndId_tmp =  dst.skipListEndId;
        dst.skipListEndId = false;
          </xsl:if>
        </xsl:if>

        if(serialize_encapsulation) {
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY' or (@kind != 'union' and ./member[@optional='true'])"> 
            if (encapsulation_id == CdrEncapsulation.CDR_ENCAPSULATION_ID_CDR_BE) {
                encapsulation_id = CdrEncapsulation.CDR_ENCAPSULATION_ID_PL_CDR_BE;
            } else if (encapsulation_id == CdrEncapsulation.CDR_ENCAPSULATION_ID_CDR_LE) {
                encapsulation_id = CdrEncapsulation.CDR_ENCAPSULATION_ID_PL_CDR_LE;
            }
        </xsl:if>
            dst.serializeAndSetCdrEncapsulation(encapsulation_id);;

<xsl:if test="$rtidds42e='no'">
            position = dst.resetAlignment();
</xsl:if>
        }


        if(serialize_sample) {
<xsl:if test="$rtidds42e='yes'">
            topLevel = !dst.isDirty();
            dst.setDirtyBit(true);

            if (!serialize_encapsulation &amp;&amp; topLevel) {
                position = dst.resetAlignmentWithOffset(4);
            }       
</xsl:if>
        <xsl:value-of select="@name"/> typedSrc = (<xsl:value-of select="@name"/>) src;    
<xsl:if test="(@kind = 'valuetype' or @kind = 'struct') and @baseClass!=''">
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
          dst.skipListEndId = true;
        </xsl:if>
        <xsl:text>        </xsl:text>
        <xsl:value-of select="@baseClass"/>TypeSupport.get_instance().serialize(endpoint_data,src,dst,false,encapsulation_id,serialize_sample,endpoint_plugin_qos);
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
          dst.skipListEndId = false;
        </xsl:if>
</xsl:if>        
<xsl:if test="@kind = 'union'">
    <!-- For unions, create a member named _d (the union discriminator) and generate code for it -->
    <xsl:call-template name="generateMemberCode">
        <xsl:with-param name="generationMode" select="'serialize'"/>
        <xsl:with-param name="member" select="./discriminator"/>
    </xsl:call-template>
</xsl:if>

<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'serialize'"/>
</xsl:apply-templates>
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        if (!(skipListEndId_tmp)) {
            memberLengthPosition = 
                dst.writeMemberId(
                    (short)CdrEncapsulation.CDR_ENCAPSULATION_MEMBER_ID_LIST_END);
            dst.writeMemberLength(memberLengthPosition, false);
        }
        dst.skipListEndId = skipListEndId_tmp;
    </xsl:if>        
<xsl:if test="$rtidds42e='yes'">
            if (!serialize_encapsulation &amp;&amp; topLevel) {
                dst.restoreAlignment(position);
            }
</xsl:if>
        }

<xsl:if test="$rtidds42e='no'">
        if (serialize_encapsulation) {
          dst.restoreAlignment(position);
        }
</xsl:if>    
    }
 
    <!-- serialization method for keys -->
    public void serialize_key(
        Object endpoint_data,
        Object src,
        CdrOutputStream dst,
        boolean serialize_encapsulation,
        short encapsulation_id,
        boolean serialize_key,
        Object endpoint_plugin_qos) 
    {
        int position = 0;
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> 
        long maxLength = 0;
        boolean skipListEndId_tmp = false;
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
        boolean topLevel;
</xsl:if>
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> 
        if (!dst.isDirty()) {
            // Top level
            dst.setDirtyBit(true);

            maxLength = get_serialized_sample_max_size(endpoint_data, false, encapsulation_id,0);

            if (maxLength > 65535) {
                dst.useExtendedMemberId = true;
            } else {
                dst.useExtendedMemberId = false;
            }
        }

        skipListEndId_tmp = dst.skipListEndId;
        dst.skipListEndId = false;
</xsl:if>
        if (serialize_encapsulation) {
            <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> 
            if (encapsulation_id == CdrEncapsulation.CDR_ENCAPSULATION_ID_CDR_BE) {
                encapsulation_id = CdrEncapsulation.CDR_ENCAPSULATION_ID_PL_CDR_BE;
            } else if (encapsulation_id == CdrEncapsulation.CDR_ENCAPSULATION_ID_CDR_LE) {
                encapsulation_id = CdrEncapsulation.CDR_ENCAPSULATION_ID_PL_CDR_LE;
            }
            </xsl:if>
            dst.serializeAndSetCdrEncapsulation(encapsulation_id);

<xsl:if test="$rtidds42e='no'">
            position = dst.resetAlignment();
</xsl:if>
        }

        if (serialize_key) {
<xsl:if test="$rtidds42e='yes'">
            topLevel = !dst.isDirty();
            dst.setDirtyBit(true);

            if (!serialize_encapsulation &amp;&amp; topLevel) {
                position = dst.resetAlignmentWithOffset(4);
            }
</xsl:if>
            <xsl:value-of select="@name"/> typedSrc = (<xsl:value-of select="@name"/>) src;    
<xsl:if test="(@kind = 'valuetype' or @kind = 'struct') and @baseClass!='' and @keyedBaseClass='yes'">
            <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
            dst.skipListEndId = true;
            </xsl:if>
            <xsl:value-of select="@baseClass"/>TypeSupport.get_instance().serialize_key(
                endpoint_data, src, dst, false, encapsulation_id, true, endpoint_plugin_qos);
             <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
            dst.skipListEndId = false;
            </xsl:if>
</xsl:if>        

<xsl:choose>    
    <xsl:when test="name(.) = 'typedef'">
        <xsl:apply-templates select="./member"
                             mode="code-generation">
            <xsl:with-param name="generationMode" select="'serialize_key'"/>
        </xsl:apply-templates>
    </xsl:when>
    <xsl:when test="not($keyFields) and (not(@keyedBaseClass) or @keyedBaseClass='no')">
            serialize(endpoint_data, src, dst, false, CdrEncapsulation.CDR_ENCAPSULATION_ID_CDR_BE, true, endpoint_plugin_qos);
    </xsl:when>
    <xsl:otherwise>
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> 
            {
                int memberId = 0;
                long memberLength = 0;
                int memberLengthPosition = 0;
                int position_tmp = 0;
            </xsl:if>  
        <xsl:apply-templates select="member[following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'key']]"
                             mode="code-generation">
            <xsl:with-param name="generationMode" select="'serialize_key'"/>
        </xsl:apply-templates>
            <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
                if (!(skipListEndId_tmp)) {
                    memberLengthPosition = 
                    dst.writeMemberId(
                        (short)CdrEncapsulation.CDR_ENCAPSULATION_MEMBER_ID_LIST_END);
                    dst.writeMemberLength(memberLengthPosition, false);
                }
                dst.skipListEndId = skipListEndId_tmp;
              }
            </xsl:if>
    </xsl:otherwise>
</xsl:choose>
<xsl:if test="$rtidds42e='yes'">
            if (!serialize_encapsulation &amp;&amp; topLevel) {
                dst.restoreAlignment(position);
            }
</xsl:if>
        }

<xsl:if test="$rtidds42e='no'">
        if (serialize_encapsulation) {
            dst.restoreAlignment(position);
        }
</xsl:if>
    }

    <!-- deserialize data method -->
    public Object deserialize_sample(
        Object endpoint_data,
        Object dst, 
        CdrInputStream src, boolean deserialize_encapsulation,
        boolean deserialize_sample,
        Object endpoint_plugin_qos) 
    {
        int position = 0;
<xsl:if test="$rtidds42e='yes'">
        boolean topLevel;
</xsl:if>
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        int memberId = 0;
</xsl:if>
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY' or 
             ($xType!='MUTABLE_EXTENSIBILITY' and ./member[@optional='true'])">
        CdrMemberInfo memberInfo;
        long length = 0;
        boolean end = false;
        int tmpPosition, tmpSize;
        long tmpLength;
</xsl:if>        

        if(deserialize_encapsulation) {
            src.deserializeAndSetCdrEncapsulation();

<xsl:if test="$rtidds42e='no'">
            position = src.resetAlignment();
</xsl:if>
        }

        if(deserialize_sample) {
<xsl:if test="$rtidds42e='yes'">
            topLevel = !src.isDirty();
            src.setDirtyBit(true);

            if (!deserialize_encapsulation &amp;&amp; topLevel) {
                position = src.resetAlignmentWithOffset(4);
            }
</xsl:if>

        <xsl:value-of select="@name"/> typedDst = (<xsl:value-of select="@name"/>) dst;
        
<xsl:if test="($xType='MUTABLE_EXTENSIBILITY' or $xType='EXTENSIBLE_EXTENSIBILITY') and not(@kind = 'union')">
<xsl:text>            typedDst.clear();</xsl:text>
</xsl:if>
        
<xsl:if test="(@kind = 'valuetype' or @kind = 'struct') and @baseClass!=''">
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
            {
                int begin = src.getBuffer().currentPosition();
        </xsl:if>
        <xsl:text>        </xsl:text>
        <xsl:value-of select="@baseClass"/>TypeSupport.get_instance().deserialize_sample(endpoint_data,dst,src,false,deserialize_sample,endpoint_plugin_qos);
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
                src.getBuffer().setCurrentPosition(begin);
            }
        </xsl:if>
</xsl:if>
<xsl:if test="(@kind='struct' or @kind='valuetype') and $xType='EXTENSIBLE_EXTENSIBILITY'">
    try {
</xsl:if>
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    <xsl:value-of select="$mutableTypeStartDesBlock"/>
</xsl:if>
<xsl:if test="@kind = 'union'">
    <!-- For unions, create a member named _d (the union discriminator) and generate code for it -->
    <xsl:call-template name="generateMemberCode">
        <xsl:with-param name="generationMode" select="'deserialize'"/>
        <xsl:with-param name="member" select="./discriminator"/>
    </xsl:call-template>
</xsl:if>
<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'deserialize'"/>
</xsl:apply-templates>
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    <xsl:value-of select="$mutableTypeEndDesBlock"/>
</xsl:if>
<xsl:if test="(@kind='struct' or @kind='valuetype') and $xType='EXTENSIBLE_EXTENSIBILITY'">
    } catch (IllegalCdrStateException stateEx) {
        if (src.available() >= CdrEncapsulation.CDR_ENCAPSULATION_PARAMETER_ID_ALIGNMENT) {
            throw new RETCODE_ERROR("Error deserializing sample! Remainder: " + src.available() + "\n" +
                                    "Exception caused by: " + stateEx.getMessage());
        }
    } catch (Exception ex) {
        throw new RETCODE_ERROR(ex.getMessage());
    }
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
            if (!deserialize_encapsulation &amp;&amp; topLevel) {
                src.restoreAlignment(position);
            }
</xsl:if>
        }

<xsl:if test="$rtidds42e='no'">
        if (deserialize_encapsulation) {
            src.restoreAlignment(position);
        }
</xsl:if>

        return dst;
    }


    <!-- deserialization method for keys -->
    public Object deserialize_key_sample(
        Object endpoint_data,
        Object dst,
        CdrInputStream src,
        boolean deserialize_encapsulation,
        boolean deserialize_key,
        Object endpoint_plugin_qos) 
    {
        int position = 0;
<xsl:if test="$rtidds42e='yes'">
        boolean topLevel;
</xsl:if>
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        CdrMemberInfo memberInfo;
        int memberId = 0;
        long length = 0;
        boolean end = false;
        int tmpPosition, tmpSize;
        long tmpLength;
</xsl:if>        

        if(deserialize_encapsulation) {
            src.deserializeAndSetCdrEncapsulation();

<xsl:if test="$rtidds42e='no'">
            position = src.resetAlignment();
</xsl:if>
        }

        if(deserialize_key) {
<xsl:if test="$rtidds42e='yes'">
            topLevel = !src.isDirty();
            src.setDirtyBit(true);

            if (!deserialize_encapsulation &amp;&amp; topLevel) {
                position = src.resetAlignmentWithOffset(4);
            }
</xsl:if>
            <xsl:value-of select="@name"/> typedDst = (<xsl:value-of select="@name"/>) dst;

<xsl:if test="(@kind = 'valuetype' or @kind = 'struct') and @baseClass!='' and @keyedBaseClass='yes'">
    <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
            {
                int begin = src.getBuffer().currentPosition();
      </xsl:if>
            <xsl:value-of select="@baseClass"/>TypeSupport.get_instance().deserialize_key_sample(
                endpoint_data, dst, src, false, true, endpoint_plugin_qos);
       <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
                src.getBuffer().setCurrentPosition(begin);
             }
      </xsl:if>
</xsl:if>        

<xsl:choose>                
    <xsl:when test="name(.) = 'typedef'">
        <xsl:apply-templates select="./member"
                             mode="code-generation">
            <xsl:with-param name="generationMode" select="'deserialize_key'"/>
        </xsl:apply-templates>
    </xsl:when>
    <xsl:when test="not($keyFields) and (not(@keyedBaseClass) or @keyedBaseClass='no')">
        deserialize_sample(endpoint_data, dst, src, false, true, endpoint_plugin_qos);
    </xsl:when>
    <xsl:otherwise>
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
            <xsl:value-of select="$mutableTypeStartDesBlock"/>
        </xsl:if>
	    <xsl:apply-templates select="member[following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'key']]"
			     mode="code-generation">
	        <xsl:with-param name="generationMode" select="'deserialize_key'"/>
	    </xsl:apply-templates>
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
            <xsl:value-of select="$mutableTypeEndDesBlock"/>
        </xsl:if>
    </xsl:otherwise>
</xsl:choose>
<xsl:if test="$rtidds42e='yes'">
            if (!deserialize_encapsulation &amp;&amp; topLevel) {
                src.restoreAlignment(position);
            }
</xsl:if>
        }

<xsl:if test="$rtidds42e='no'">
        if (deserialize_encapsulation) {
            src.restoreAlignment(position);
        }
</xsl:if>

        return dst;
    }

    <!-- skip method -->
    public void skip(Object endpoint_data, 
                     CdrInputStream src,
                     boolean skip_encapsulation, 
                     boolean skip_sample, 
                     Object endpoint_plugin_qos)
    {
        int position = 0;
<xsl:if test="$rtidds42e='yes'">
        boolean topLevel;
</xsl:if>
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        int memberId = 0;
</xsl:if>
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY' or 
             ($xType!='MUTABLE_EXTENSIBILITY' and ./member[@optional='true'])">
        CdrMemberInfo memberInfo;
        long length = 0;
        boolean end = false;
        int tmpPosition, tmpSize;
        long tmpLength;
</xsl:if>        

        if (skip_encapsulation) {
            src.skipEncapsulation();

<xsl:if test="$rtidds42e='no'">
            position = src.resetAlignment();
</xsl:if>
        }

        if (skip_sample) {
<xsl:if test="$rtidds42e='yes'">
            topLevel = !src.isDirty();
            src.setDirtyBit(true);

            if (!skip_encapsulation &amp;&amp; topLevel) {
                position = src.resetAlignmentWithOffset(4);
            }
</xsl:if>
<xsl:if test="@kind = 'union'">
            <xsl:variable name="isEnum">
                <xsl:call-template name="isBaseEnum">
                    <xsl:with-param name="member" select="./discriminator"/>
                </xsl:call-template>
            </xsl:variable>

            <xsl:variable name="baseType">
                <xsl:call-template name="getBaseType">
                    <xsl:with-param name="member" select="./discriminator"/>
                </xsl:call-template>
            </xsl:variable>

            <xsl:text>            </xsl:text>
            <xsl:if test="$isEnum='yes'">
                <xsl:value-of select="$baseType"/>
                <xsl:text> disc = null;&nl;</xsl:text>
            </xsl:if>
            <xsl:if test="$isEnum='no'">
                <xsl:call-template name="obtainNativeType">
                    <xsl:with-param name="idlType" select="$baseType"/>        	
                </xsl:call-template>
                <xsl:text> disc;&nl;</xsl:text>
            </xsl:if>            
</xsl:if>

<xsl:if test="(@kind = 'valuetype' or @kind = 'struct') and @baseClass!=''">
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
      {
            int begin = src.getBuffer().currentPosition();
      </xsl:if>
            <xsl:value-of select="@baseClass"/>TypeSupport.get_instance().skip(endpoint_data, src, false, true, endpoint_plugin_qos);
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
            src.getBuffer().setCurrentPosition(begin);
         }
      </xsl:if>
</xsl:if>

<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    <xsl:value-of select="$mutableTypeStartDesBlock"/>
</xsl:if>
<xsl:if test="@kind = 'union'">        
            <xsl:call-template name="generateMemberCode">
                <xsl:with-param name="generationMode" select="'deserialize'"/>
                <xsl:with-param name="member" select="./discriminator"/>
                <xsl:with-param name="discContainer" select="'disc'"/>
            </xsl:call-template>
            <xsl:text>&nl;           </xsl:text>
</xsl:if> 
            <xsl:apply-templates mode="code-generation">
                <xsl:with-param name="generationMode" select="'skip'"/>
            </xsl:apply-templates>
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    <xsl:value-of select="$mutableTypeEndDesBlock"/>
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
            if (!skip_encapsulation &amp;&amp; topLevel) {
                src.restoreAlignment(position);
            }
</xsl:if>
        }

<xsl:if test="$rtidds42e='no'">
        if (skip_encapsulation) {
            src.restoreAlignment(position);
        }
</xsl:if>
    }

    public Object serialized_sample_to_key(
        Object endpoint_data,
        Object sample,
        CdrInputStream src, 
        boolean deserialize_encapsulation,  
        boolean deserialize_key, 
        Object endpoint_plugin_qos) 
    {
        int position = 0;
<xsl:if test="$rtidds42e='yes'">
        boolean topLevel;
</xsl:if>
<xsl:if test="($isKeyed='yes' or name(.) = 'typedef') and $xType='MUTABLE_EXTENSIBILITY'">
        int memberId = 0;
</xsl:if> 
<xsl:if test="($isKeyed='yes' or name(.) = 'typedef') and 
               ($xType='MUTABLE_EXTENSIBILITY' or 
                ($xType!='MUTABLE_EXTENSIBILITY' and ./member[@optional='true']))">
        CdrMemberInfo memberInfo;
        long length = 0;
        boolean end = false;
        int tmpPosition, tmpSize;
        long tmpLength;
</xsl:if> 
       
        if(deserialize_encapsulation) {
            src.deserializeAndSetCdrEncapsulation();
<xsl:if test="$rtidds42e='no'">
            position = src.resetAlignment();
</xsl:if>
        }

        if (deserialize_key) {
<xsl:if test="$rtidds42e='yes'">
            topLevel = !src.isDirty();
            src.setDirtyBit(true);

            if (!deserialize_encapsulation &amp;&amp; topLevel) {
                position = src.resetAlignmentWithOffset(4);
            }
</xsl:if>
            <xsl:value-of select="@name"/> typedDst = (<xsl:value-of select="@name"/>) sample;

<xsl:if test="$isKeyed='no' and name(.) != 'typedef'">
            deserialize_sample(
                endpoint_data, sample, src, false, 
                true, endpoint_plugin_qos);
</xsl:if>

<xsl:if test="$isKeyed='yes' or name(.) = 'typedef'">
    <xsl:if test="(@kind = 'valuetype' or @kind = 'struct')">
        <xsl:choose>
            <xsl:when test="@baseClass != '' and @keyedBaseClass='yes'">
                <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
                {
                    int begin = src.getBuffer().currentPosition();
                </xsl:if>
                <xsl:text>        </xsl:text>
                <xsl:value-of select="@baseClass"/><xsl:text>TypeSupport.get_instance().</xsl:text>
                <xsl:text>serialized_sample_to_key(endpoint_data,sample,&nl;</xsl:text>
                <xsl:text>                                 src,false, true,&nl;</xsl:text>
                <xsl:text>                                 endpoint_plugin_qos);&nl;</xsl:text>
                <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
                    src.getBuffer().setCurrentPosition(begin);
                }
                </xsl:if>
            </xsl:when>
            <xsl:when test="@baseClass != ''">
                <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
                {
                    int begin = src.getBuffer().currentPosition();
                </xsl:if>
                <xsl:text>        </xsl:text>
                <xsl:value-of select="@baseClass"/><xsl:text>TypeSupport.get_instance().</xsl:text>
                <xsl:text>skip(endpoint_data, src,&nl;</xsl:text>
                <xsl:text>             false, true,&nl;</xsl:text>
                <xsl:text>             endpoint_plugin_qos);&nl;</xsl:text>
                <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
                    src.getBuffer().setCurrentPosition(begin);
                }
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:if>
    <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        <xsl:value-of select="$mutableTypeStartDesBlock"/>
    </xsl:if>
    <xsl:for-each select="./member">
        <xsl:choose>
            <xsl:when test="name(..) = 'typedef'">
                <xsl:apply-templates select="."
                                     mode="code-generation">
                    <xsl:with-param name="generationMode" select="'serialized_sample_to_key'"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="not(following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'key'])">
                <xsl:apply-templates select="."
        			     mode="code-generation">
        	    <xsl:with-param name="generationMode" select="'skip'"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="."
        			     mode="code-generation">
        	    <xsl:with-param name="generationMode" select="'serialized_sample_to_key'"/>
                </xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:for-each> 
    <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        <xsl:value-of select="$mutableTypeEndDesBlock"/>
    </xsl:if>
</xsl:if>

<xsl:if test="$rtidds42e='yes'">
            if (!deserialize_encapsulation &amp;&amp; topLevel) {
                src.restoreAlignment(position);
            }
</xsl:if>
        }

<xsl:if test="$rtidds42e='no'">
        if (deserialize_encapsulation) {
            src.restoreAlignment(position);
        }
</xsl:if>

        return sample;
    }

<xsl:if test="$isKeyed='yes'">
    /* Fill in the key fields of the given instance sample based on the key.
     */
    public void key_to_instance(Object endpoint_data,
                                Object instance,
                                Object key) {
        <xsl:value-of select="@name"/> typedDst
            = (<xsl:value-of select="@name"/>)<xsl:text> instance;&nl;</xsl:text>
        <xsl:text>        </xsl:text>
        <xsl:value-of select="@name"/> typedSrc
            = (<xsl:value-of select="@name"/>)<xsl:text> key;&nl;</xsl:text>
        <xsl:if test="(@kind = 'valuetype' or @kind = 'struct') and @baseClass != '' and @keyedBaseClass='yes'">
            <xsl:text>        </xsl:text>                
            <xsl:value-of select="@baseClass"/>
            <xsl:text>TypeSupport.get_instance().key_to_instance(endpoint_data,instance,key);&nl;</xsl:text>
        </xsl:if>

<xsl:apply-templates select="member[following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'key']]"
                     mode="code-generation">
    <xsl:with-param name="generationMode" select="'copy'"/>
</xsl:apply-templates>
    }

    /* Fill in the given key based on the key fields of the given instance
     * sample.
     */
    public void instance_to_key(Object endpoint_data,
                                Object key,
                                Object instance) {
        <xsl:value-of select="@name"/> typedDst
            = (<xsl:value-of select="@name"/>)<xsl:text>key;&nl;</xsl:text>
        <xsl:text>        </xsl:text>
        <xsl:value-of select="@name"/> typedSrc
            = (<xsl:value-of select="@name"/>)<xsl:text> instance;&nl;</xsl:text>
        <xsl:if test="(@kind = 'valuetype' or @kind = 'struct') and @baseClass != '' and @keyedBaseClass='yes'">
            <xsl:text>        </xsl:text>                
            <xsl:value-of select="@baseClass"/>
            <xsl:text>TypeSupport.get_instance().instance_to_key(endpoint_data,key,instance);&nl;</xsl:text>
        </xsl:if>
                
<xsl:apply-templates select="member[following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'key']]"
                     mode="code-generation">
    <xsl:with-param name="generationMode" select="'copy'"/>
</xsl:apply-templates>
    }

    /* Fill in the fields of the given KeyHash based on the key field(s)
     * of the given instance sample.
     * Important: The fields of the instance ID cannot all be set to zero!
     */
    public void instance_to_keyhash(Object endpoint_data,
                                    KeyHash_t keyhash,
                                    Object instance) {
        DefaultEndpointData endpointData = (DefaultEndpointData) endpoint_data;
        CdrOutputStream md5Stream = endpointData.get_stream();
        CdrBuffer buffer = null;

        if (md5Stream == null) {
              throw new RETCODE_ERROR("Missing MD5 stream");
        }

        buffer = md5Stream.getBuffer();
        buffer.resetBufferToZero();

        md5Stream.resetAndSetDirtyBit(true);

        serialize_key(endpoint_data,instance,md5Stream,false,CdrEncapsulation.CDR_ENCAPSULATION_ID_CDR_BE,true,null);

        if (endpointData.get_serialized_key_max_size() &gt; KeyHash_t.KEY_HASH_MAX_LENGTH) {
            md5Stream.computeMD5(keyhash.value);
        } else {
            System.arraycopy(buffer.getBuffer(), 0, 
                             keyhash.value, 0,
                             buffer.currentPosition());
            System.arraycopy(KeyHash_t.ZERO_KEYHASH.value,buffer.currentPosition(),
                             keyhash.value,buffer.currentPosition(),
                             KeyHash_t.KEY_HASH_MAX_LENGTH - buffer.currentPosition());
        }

        keyhash.length = KeyHash_t.KEY_HASH_MAX_LENGTH;
    }

    public void serialized_sample_to_keyhash(
        Object endpoint_data,
        CdrInputStream src,
        KeyHash_t keyhash,
        boolean include_encapsulation,
        Object endpoint_plugin_qos)
    {
        int position = 0;
<xsl:if test="$rtidds42e='yes'">
        boolean topLevel;
</xsl:if>
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        int memberId = 0;
</xsl:if>
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY' or 
             ($xType!='MUTABLE_EXTENSIBILITY' and ./member[@optional='true'])">
        CdrMemberInfo memberInfo;
        long length = 0;
        boolean end = false;
        int tmpPosition, tmpSize;
        long tmpLength;
</xsl:if>        

        DefaultEndpointData endpointData = (DefaultEndpointData) endpoint_data;
        Object sample = null;

        sample = endpointData.get_sample();

        if (sample == null) {
            throw new RETCODE_ERROR("Missing intermediate sample");
        }

        <xsl:value-of select="@name"/> typedDst = (<xsl:value-of select="@name"/>) sample;

<xsl:if test="$rtidds42e='yes'">
        topLevel = !src.isDirty();
        src.setDirtyBit(true);
</xsl:if>

        if (include_encapsulation) {
            src.deserializeAndSetCdrEncapsulation();

<xsl:if test="$rtidds42e='no'">
            position = src.resetAlignment();
        }
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
        } else if (topLevel) {
            position = src.resetAlignmentWithOffset(4);
        }
</xsl:if>


<xsl:if test="(@kind = 'valuetype' or @kind = 'struct')">
    <xsl:choose>
        <xsl:when test="@baseClass != '' and @keyedBaseClass='yes'">
            <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
             {
                int begin = src.getBuffer().currentPosition();
            </xsl:if>
                <xsl:text>        </xsl:text>
                <xsl:value-of select="@baseClass"/><xsl:text>TypeSupport.get_instance().</xsl:text>
                <xsl:text>serialized_sample_to_key(endpoint_data,sample,&nl;</xsl:text>
                <xsl:text>                             src, false, true,&nl;</xsl:text>
                <xsl:text>                             endpoint_plugin_qos);&nl;</xsl:text>
            <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
                    src.getBuffer().setCurrentPosition(begin);
                }
            </xsl:if>
        </xsl:when>
        <xsl:when test="@baseClass != ''">
            <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
             {
                int begin = src.getBuffer().currentPosition();
            </xsl:if>
            <xsl:text>        </xsl:text>
            <xsl:value-of select="@baseClass"/><xsl:text>TypeSupport.get_instance().</xsl:text>
            <xsl:text>skip(endpoint_data, src,&nl;</xsl:text>
            <xsl:text>         false, true,&nl;</xsl:text>
            <xsl:text>         endpoint_plugin_qos);&nl;</xsl:text>
            <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
                    src.getBuffer().setCurrentPosition(begin);
                }
            </xsl:if>
        </xsl:when>
        <xsl:otherwise>
        </xsl:otherwise>
    </xsl:choose>
</xsl:if>
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    <xsl:value-of select="$mutableTypeStartDesBlock"/>
</xsl:if>
<xsl:for-each select="./member[following-sibling::node()[name() = 'directive' and @kind = 'key']]">
    <xsl:choose>
        <xsl:when test="not(following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'key'])">
            <xsl:apply-templates select="."
    			     mode="code-generation">
    	    <xsl:with-param name="generationMode" select="'skip'"/>
            </xsl:apply-templates>
        </xsl:when>
        <xsl:otherwise>
            <xsl:apply-templates select="."
    			     mode="code-generation">
    	    <xsl:with-param name="generationMode" select="'serialized_sample_to_key'"/>
            </xsl:apply-templates>
        </xsl:otherwise>
    </xsl:choose>
</xsl:for-each>  
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    <xsl:value-of select="$mutableTypeEndDesBlock"/>
</xsl:if>

<xsl:if test="$rtidds42e='no'">
        if (include_encapsulation) {
            src.restoreAlignment(position);
        }
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
        if (!include_encapsulation &amp;&amp; topLevel) {
            src.restoreAlignment(position);
        }
</xsl:if>

        instance_to_keyhash(endpoint_data, keyhash, sample);
    }
</xsl:if> <!-- $isKeyed='yes' -->

<!-- buffer pool is not supported in java yet -->
<xsl:if test="$javabufferpool='yes'">
/*
    //NOTE: The Memory Management functions and Callbacks should be uncommented
    //      and implemented if you want to manage the memory yourself. In that
    //      case, all the Memory Management functions and Callbacks need to be
    //      implemented
    // -----------------------------------------------------------------------
    // Memory Management functions
    // -----------------------------------------------------------------------

    public Object get_sample(Object endpoint_data, ObjectHolder handle) {
        return create_data();
    }

    public void return_sample(Object endpoint_data, Object sample, Object handle) {
        destroy_data(sample);
    }

    public Object get_key(Object endpoint_data, ObjectHolder handle) {
        return create_key();
    }

    public void return_key(Object endpoint_data, Object key, Object handle) {
        destroy_key(key);
    }
*/
</xsl:if>

    // -----------------------------------------------------------------------
    // Callbacks
    // -----------------------------------------------------------------------

    public Object on_participant_attached(Object registration_data,
                                          TypeSupportParticipantInfo participant_info,
                                          boolean top_level_registration,
                                          Object container_plugin_context,
                                          TypeCode type_code) {
        return super.on_participant_attached(
            registration_data, participant_info, top_level_registration,
            container_plugin_context, type_code);
    }

    public void on_participant_detached(Object participant_data) {
        super.on_participant_detached(participant_data);
    }

    public Object on_endpoint_attached(Object participantData,
                                       TypeSupportEndpointInfo endpoint_info,
                                       boolean top_level_registration,
                                       Object container_plugin_context) {
        return super.on_endpoint_attached(
              participantData,  endpoint_info,  
              top_level_registration, container_plugin_context);        
    }

    public void on_endpoint_detached(Object endpoint_data) {
        super.on_endpoint_detached(endpoint_data);
    }

    // -----------------------------------------------------------------------
    // Protected Methods
    // -----------------------------------------------------------------------

    protected DataWriter create_datawriter(long native_writer,
                                           DataWriterListener listener,
                                           int mask) {
        <xsl:if test="name(.)='typedef'">
        return null;
        </xsl:if>
        <xsl:if test="not(name(.)='typedef')">
            <xsl:if test="$topLevel='no'">
        return null;                
            </xsl:if>
            <xsl:if test="$topLevel='yes'">
        return new <xsl:value-of select="@name"/>DataWriter(native_writer, listener, mask, this);                
            </xsl:if>            
        </xsl:if>
    }

    protected DataReader create_datareader(long native_reader,
                                           DataReaderListener listener,
                                           int mask) {
        <xsl:if test="name(.)='typedef'">
        return null;                                
        </xsl:if>
        <xsl:if test="not(name(.)='typedef')">
            <xsl:if test="$topLevel='no'">
        return null;                
            </xsl:if>
            <xsl:if test="$topLevel='yes'">
        return new <xsl:value-of select="@name"/>DataReader(native_reader, listener, mask, this);                
            </xsl:if>            
        </xsl:if>
    }

    // -----------------------------------------------------------------------
    // Constructor
    // -----------------------------------------------------------------------

    protected <xsl:value-of select="@name"/>TypeSupport() {
        <xsl:variable name="typeCodeMember">
            <xsl:if test="$typecode='yes'"><xsl:value-of select="@name"/>TypeCode.VALUE</xsl:if>
            <xsl:if test="$typecode='no'">null</xsl:if>
        </xsl:variable>
        <xsl:variable name="typeSupportType">
            <xsl:choose>
		<xsl:when test="@kind = 'union'">TypeSupportType.TST_UNION</xsl:when>
		<xsl:otherwise>TypeSupportType.TST_STRUCT</xsl:otherwise>
	    </xsl:choose>
        </xsl:variable>
        /* If the user data type supports keys, then the second argument
        to the constructor below should be true.  Otherwise it should
        be false. */        
<xsl:choose>
    <!-- If this type contains at least one 'directive' child with a 'kind'
         attribute of 'key', consider it a keyed type. Otherwise, consider
         it unkeyed. -->
    <xsl:when test="$isKeyed = 'yes'">
        super(TYPE_NAME, true,<xsl:value-of select="$typeCodeMember"/>,<xsl:value-of select="@name"/>.class,<xsl:value-of select="$typeSupportType"/>, PLUGIN_VERSION);
    </xsl:when>
    <xsl:otherwise>
        super(TYPE_NAME, false,<xsl:value-of select="$typeCodeMember"/>,<xsl:value-of select="@name"/>.class,<xsl:value-of select="$typeSupportType"/>, PLUGIN_VERSION);
    </xsl:otherwise>
</xsl:choose>
    }

    protected <xsl:value-of select="@name"/>TypeSupport(boolean enableKeySupport) {
    <xsl:variable name="typeCodeMember">
        <xsl:if test="$typecode='yes'"><xsl:value-of select="@name"/>TypeCode.VALUE</xsl:if>
        <xsl:if test="$typecode='no'">null</xsl:if>
    </xsl:variable>
    <xsl:variable name="typeSupportType">
        <xsl:choose>
            <xsl:when test="@kind = 'union'">TypeSupportType.TST_UNION</xsl:when>
            <xsl:otherwise>TypeSupportType.TST_STRUCT</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
        super(TYPE_NAME, enableKeySupport,<xsl:value-of select="$typeCodeMember"/>,<xsl:value-of select="@name"/>.class,<xsl:value-of select="$typeSupportType"/>, PLUGIN_VERSION);
    }
}
</file>
</xsl:if> <!-- if generate -->
</xsl:template>

</xsl:stylesheet>
