<?xml version="1.0"?>
<!-- 
$Id: typePlugin.cpp.cli.xsl,v 1.26 2013/10/29 05:09:30 fernando Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
Modification history:
- - - - - - - - - - -
5.1.0,16may13,fcs CODEGEN-561: Union mutability support in .NET
5.1.0,25oct13,fcs CODEGEN-584: Received samples for an Extensible type may contain 
                  invalid values for fields not present on the wire
5.1.0,09oct13,fcs Improved maintainability for mutable codegen
5.1.0,07oct13,fcs Refactored bound check in sequence deserialization
5.1.0,29sep13,fcs Fixed CODEGEN-567: Fixed alignment for members in mutable types
5.1.0,25sep13,fcs Fixed CODEGEN-622: When an enum is the last field in a type, 
                  a deserialize error is not generated if the value is outside of 
                  valid enumerations.
5.0.0,12dec12,fcs Fixed CODEGEN-528: Deserialization error on a Java/.NET 
                  DataReader subscribing to an extended type and receiving 
                  samples from a base type
5.0.0,08dec12,fcs Fixed bug CODEGEN-530: A DataReader may fail to deserialize 
                  samples if the underlying type is an extended type where the 
                  type of the last member requires 8-byte alignment
1.0ac,07aug12,yy  Fixed CORE-5303: disable_inline_keyhash
10ac,14aug11,fcs Fixed bug 14079
1.0ae,12jul10,jim Fixed 13514
1.0ae,27jun10,fcs Fixed 13495
1.0ac,18apr10,fcs Fixed bug 13415
1.0ac,29aug09,fcs Double pointer indirection and dropSample
                  in deserialize function
10ac,20aug09,fcs Added encapsulation error detection &
                 Removed CDR_NATIVE usage
1.0ac,18aug09,fcs Fixed get_serialized_sample_size declaration
1.0ac,10aug09,fcs get_serialized_sample_size support
10y,09jul09,fcs Fixed bug 13033
10y,10feb08,fcs Fixed bugs 12740 and 12741
10y,17sep08,jlv Fixed include. Now files with more than one dot in the name 
                (or with an extension different to 'idl') are allowed.
10x,16jul08,tk  Removed utils.xsl
10x,09may08,rbw Removed obsolete warning suppression
10x,08may08,rbw Added union support
10x,08may08,rbw Added bit field support
10v,11apr08,rbw Wrapped mix/max size serialized in managed code
10v,10apr08,rbw Replaced unmanaged primitives w/ managed equivalents
10v,09apr08,rbw Type plug-in API is now managed
10v,22mar08,rbw New primitive deserialization can cause warning; suppress it
10v,19mar08,rbw Set plug-in languageKind to let CFT work properly
10v,19mar08,rbw Fixed enum (de)serialization bugs; fixed alignment
10v,18mar08,rbw Restored -rtidds42e option: supporting it after all
10v,17mar08,rbw Removed unsupported -rtidds42e option: caused compile errors
10v,17mar08,fcs Fixed compilation
10v,17mar08,fcs Fixed key management
10v,17mar08,rbw Removed explicit destructors/finalizers: unnecessary
10v,13mar08,rbw Fixed (de)serialization of keys and valuetypes
10v,12mar08,rbw Made method names more consistent
10v,12mar08,rbw Merged in keyhash support
10v,11mar08,rbw Fixes for enums; aligned with C plug-in
10s,06mar08,rbw Fixed array and sequence generation
10s,04mar08,rbw Fixed lots of compile errors
10s,03mar08,rbw ReplacedUnmanagedWrapper with explicit GCHandle
10s,01mar08,rbw Created
-->


<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
<!ENTITY namespaceSeperator "_">    <!-- namespace separator -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0"
                xmlns:xalan = "http://xml.apache.org/xalan">

<xsl:include href="typeCommon.cppcli.xsl"/>

<xsl:param name="rtidds42e"/>

<xsl:output method="text"/>


<!-- ===================================================================== -->
<!-- Document Root                                                         -->
<!-- ===================================================================== -->

<xsl:variable name="sourcePreamble"
              select="$generationInfo/sourcePreamble[@kind = 'type-plugin-source']"/>

<!-- When the root of document is matched, print the source preamble specified in
     the generation-info.c.xml file. The source preamble contains the standard blurb 
     as well as #include for the needed header file. -->
<xsl:template match="/">
<xsl:text/>/*
  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

  This file was generated from <xsl:value-of select="$idlFileBaseName"/>.idl using "rtiddsgen".
  The rtiddsgen tool is part of the <xsl:value-of select="$coreProduct"/> distribution.
  For more information, type 'rtiddsgen -help' at a command shell
  or consult the <xsl:value-of select="$coreProduct"/> manual.
*/

#include "<xsl:value-of select="$idlFileBaseName"/>Plugin.h"

<xsl:value-of select="$sourcePreamble"/>

<xsl:apply-templates/>
</xsl:template>


<!-- ===================================================================== -->
<!-- Enum Types                                                            -->
<!-- ===================================================================== -->
<!-- Output form:
     
    Boolean <name>_serialize_sample(...) {
         [serialize value]
    }
    
    ... same for deserialization, print, init ...     
-->

<xsl:template match="enum">
  <xsl:variable name="xType">
    <xsl:call-template name="getExtensibilityKind">
      <xsl:with-param name="structName" select="./@name"/>
      <xsl:with-param name="node" select="."/>
    </xsl:call-template>
  </xsl:variable>

/* ------------------------------------------------------------------------
  Enum Type: <xsl:value-of select="@name"/>
 * ------------------------------------------------------------------------ */

/* ------------------------------------------------------------------------
 * (De)Serialization Methods
 * ------------------------------------------------------------------------ */

<!-- serializeX method -->
Boolean
<xsl:value-of select="@name"/>Plugin::serialize(
    TypePluginEndpointData^ endpoint_data,
    <xsl:value-of select="@name"/> sample,
    CdrStream% stream, 
    Boolean serialize_encapsulation,
    UInt16 encapsulation_id,
    Boolean serialize_sample,
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    if (serialize_encapsulation) {
        if (!stream.serialize_and_set_cdr_encapsulation(encapsulation_id)) {
            return false;
        }
<xsl:if test="$rtidds42e='no'">
        position = stream.reset_alignment();
</xsl:if>
    }

    if (serialize_sample) {
<xsl:if test="$rtidds42e='yes'">
        Boolean top_level = !stream.dirty;
        stream.dirty = true;
        if (!serialize_encapsulation &amp;&amp; top_level) {
            position = stream.reset_alignment_w_offset(4);
        }
</xsl:if>
        if (!stream.serialize_enum(sample)) {
            return false;
        }
<xsl:if test="$rtidds42e='yes'">
        if (!serialize_encapsulation &amp;&amp; top_level) {
            stream.restore_alignment(position);
        }
</xsl:if>
    }

<xsl:if test="$rtidds42e='no'">
    if (serialize_encapsulation) {
        stream.restore_alignment(position);

    }
</xsl:if>
    return true;
}

<!-- deserialize method -->
Boolean 
<xsl:value-of select="@name"/>Plugin::deserialize_sample(
    TypePluginEndpointData^ endpoint_data,
    <xsl:value-of select="@name"/>% sample,
    CdrStream% stream, 
    Boolean deserialize_encapsulation,  
    Boolean deserialize_data, 
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    if (deserialize_encapsulation) {
        if (!stream.deserialize_and_set_cdr_encapsulation()) {
            return false;
        }

<xsl:if test="$rtidds42e='no'">
        position = stream.reset_alignment();
</xsl:if>
    }

    if (deserialize_data) {
<xsl:if test="$rtidds42e='yes'">
        Boolean top_level = !stream.dirty;
        stream.dirty = true;
        if (!deserialize_encapsulation &amp;&amp; top_level) {
            position = stream.reset_alignment_w_offset(4);
        }
</xsl:if>

        sample = stream.deserialize_enum&lt;<xsl:value-of select="@name"/>&gt;();
<xsl:if test="($xType='MUTABLE_EXTENSIBILITY' or $xType='EXTENSIBLE_EXTENSIBILITY')">
        switch (sample) {
<xsl:for-each select="./enumerator">
            case <xsl:value-of select="../@name"/>::<xsl:value-of select="./@name"/>:
</xsl:for-each>
            {
            } break;
            default:
            {
                throw gcnew Unassignable("invalid enumerator " + sample.ToString());
            } break;
        }
</xsl:if> 
   
<xsl:if test="$rtidds42e='yes'">
        if (!deserialize_encapsulation &amp;&amp; top_level) {
            stream.restore_alignment(position);
        }
</xsl:if>
    }
<xsl:if test="$rtidds42e='no'">
    if(deserialize_encapsulation) {
        stream.restore_alignment(position);
    }
</xsl:if>

    return true;
}

<!-- skip method -->
Boolean
<xsl:value-of select="@name"/>Plugin::skip(
    TypePluginEndpointData^ endpoint_data,
    CdrStream% stream, 
    Boolean skip_encapsulation,  
    Boolean skip_sample, 
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    if (skip_encapsulation) {
        if (!stream.skip_encapsulation()) {
            return false;
        }
<xsl:if test="$rtidds42e='no'">
        position = stream.reset_alignment();
</xsl:if>
    }
    if (skip_sample) {
<xsl:if test="$rtidds42e='yes'">
        Boolean top_level = !stream.dirty;
        stream.dirty = true;

        if (!skip_encapsulation &amp;&amp; top_level) {
            position = stream.reset_alignment_w_offset(4);
        }
</xsl:if>
        if (!stream.skip_enum()) {
            return false;
        }
<xsl:if test="$rtidds42e='yes'">
        if (!skip_encapsulation &amp;&amp; top_level) {
            stream.restore_alignment(position);
        }
</xsl:if>

    }

<xsl:if test="$rtidds42e='no'">
    if(skip_encapsulation) {
        stream.restore_alignment(position);
    }
</xsl:if>

    return true;
}

<!-- get_max_size_serialized method -->
UInt32
<xsl:value-of select="@name"/>Plugin::get_serialized_sample_max_size(
    TypePluginEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment)
{
    UInt32 initial_alignment = current_alignment;
<xsl:if test="$rtidds42e='no'">
    UInt32 encapsulation_size = current_alignment;
</xsl:if>

    if (include_encapsulation) {
        if (!CdrStream::valid_encapsulation_id(encapsulation_id)) {
            return 1;
        }

<xsl:if test="$rtidds42e='no'">
        encapsulation_size = CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
        current_alignment = 0;
        initial_alignment = 0;
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
        current_alignment += CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
</xsl:if>
    }

    current_alignment += RTICdrType_getEnumMaxSizeSerialized(current_alignment);

<xsl:if test="$rtidds42e='no'">
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }
</xsl:if>

    return current_alignment - initial_alignment;
}

<!-- get_min_size_serialized method -->
UInt32
<xsl:value-of select="@name"/>Plugin::get_serialized_sample_min_size(
    TypePluginEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment)
{
    UInt32 initial_alignment = current_alignment;
<xsl:if test="$rtidds42e='no'">
    UInt32 encapsulation_size = current_alignment;
</xsl:if>

    if (include_encapsulation) {
        if (!CdrStream::valid_encapsulation_id(encapsulation_id)) {
            return 1;
        }

<xsl:if test="$rtidds42e='no'">
        encapsulation_size = CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
        current_alignment = 0;
        initial_alignment = 0;
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
        current_alignment += CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
</xsl:if>
    }

    current_alignment += RTICdrType_getEnumMaxSizeSerialized(current_alignment);

<xsl:if test="$rtidds42e='no'">
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }
</xsl:if>

    return current_alignment - initial_alignment;
}

<!-- get_serialized_sample_size method -->
UInt32
<xsl:value-of select="@name"/>Plugin::get_serialized_sample_size(
    TypePluginEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment,
    <xsl:value-of select="@name"/> sample) 
{
    UInt32 initial_alignment = current_alignment;
<xsl:if test="$rtidds42e='no'">
    UInt32 encapsulation_size = current_alignment;
</xsl:if>

    if (include_encapsulation) {
        if (!CdrStream::valid_encapsulation_id(encapsulation_id)) {
            return 1;
        }

<xsl:if test="$rtidds42e='no'">
        encapsulation_size = CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
        current_alignment = 0;
        initial_alignment = 0;
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
        current_alignment += CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
</xsl:if>
    }

    current_alignment += RTICdrType_getEnumMaxSizeSerialized(current_alignment);

<xsl:if test="$rtidds42e='no'">
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }
</xsl:if>

    return current_alignment - initial_alignment;
}

/* ------------------------------------------------------------------------
    Key Management functions:
 * ------------------------------------------------------------------------ */

<!-- serialize_key method -->
Boolean
<xsl:value-of select="@name"/>Plugin::serialize_key(
    TypePluginEndpointData^ endpoint_data,
    <xsl:value-of select="@name"/> sample,
    CdrStream% stream,
    Boolean serialize_encapsulation,
    UInt16 encapsulation_id,
    Boolean serialize_key,
    Object^ endpoint_plugin_qos)
{
    return serialize(
            endpoint_data, sample, stream, serialize_encapsulation, 
            encapsulation_id, 
            serialize_key, endpoint_plugin_qos);
}

<!-- deserialize_key method -->
Boolean
<xsl:value-of select="@name"/>Plugin::deserialize_key_sample(
    TypePluginEndpointData^ endpoint_data,
    <xsl:value-of select="@name"/>% sample,
    CdrStream% stream,
    Boolean deserialize_encapsulation,
    Boolean deserialize_key,
    Object^ endpoint_plugin_qos)
{
    return deserialize_sample(
            endpoint_data, sample, stream, deserialize_encapsulation, 
            deserialize_key, endpoint_plugin_qos);
}

<!-- serialized_key_max_size method -->
UInt32
<xsl:value-of select="@name"/>Plugin::get_serialized_key_max_size(
    TypePluginEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment)
{
    UInt32 initial_alignment = current_alignment;

    current_alignment += get_serialized_sample_max_size(
        endpoint_data,include_encapsulation,
        encapsulation_id,current_alignment);

    return current_alignment - initial_alignment;
}

<!-- serialized_sample_to_key -->
Boolean
<xsl:value-of select="@name"/>Plugin::serialized_sample_to_key(
    TypePluginEndpointData^ endpoint_data,
    <xsl:value-of select="@name"/>% sample,
    CdrStream% stream, 
    Boolean deserialize_encapsulation,  
    Boolean deserialize_key, 
    Object^ endpoint_plugin_qos)
{    
    return deserialize_sample(
            endpoint_data,
            sample,
            stream,
            deserialize_encapsulation, 
            deserialize_key,
            endpoint_plugin_qos);
}


/* ------------------------------------------------------------------------
   Support functions:
 * ------------------------------------------------------------------------ */

<!-- print method -->
void
<xsl:value-of select="@name"/>Plugin::print_data(
    <xsl:value-of select="@name"/> sample,
    String^ description,
    UInt32 indent_level)
{
    if (description != nullptr) {
        for (UInt32 i = 0; i &lt; indent_level; ++i) { Console::Write("   "); }
        Console::WriteLine("{0}:", description);
    }

    RTICdrType_printEnum((RTICdrEnum*) &amp;sample,
                         "<xsl:value-of select="@name"/>", indent_level + 1);
}


/* ------------------------------------------------------------------------
 * Plug-in Lifecycle Methods
 * ------------------------------------------------------------------------ */

<xsl:value-of select="@name"/>Plugin^
<xsl:value-of select="@name"/>Plugin::get_instance() {
    if (_singleton == nullptr) {
        _singleton = gcnew <xsl:value-of select="@name"/>Plugin();
    }
    return _singleton;
}


void
<xsl:value-of select="@name"/>Plugin::dispose() {
    delete _singleton;
    _singleton = nullptr;
}

</xsl:template>


<!-- ===================================================================== -->
<!-- Structures and Typedefs                                               -->
<!-- ===================================================================== -->

<xsl:template match="struct|typedef">
    <xsl:variable name="sequenceFields" select="member[@kind='sequence']"/>
    <!-- It's not necessary to look the base types -->
    <xsl:variable name="sequenceArrayFields"
                  select="member[@kind='sequence' and ./cardinality]"/>
    <xsl:variable name="keyFields"
        select="member[following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'key']]"/>
    <xsl:variable name="isKeyed">
        <xsl:choose>
            <xsl:when
                test="directive[@kind='key'] or
                      (@keyedBaseClass and @keyedBaseClass='yes')">yes</xsl:when>
            <xsl:otherwise>no</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="xType">
        <xsl:call-template name="getExtensibilityKind">
            <xsl:with-param name="structName" select="./@name"/>
            <xsl:with-param name="node" select="."/>
        </xsl:call-template>
    </xsl:variable>
  
    <xsl:variable name="mutableTypeStartDesBlock">
      <xsl:text>
        while (end != true &amp;&amp; stream.get_remainder() > 0) {
            DDS::CdrMemberInfo memberInfo = stream.deserialize_member_info();
            char* tmpPosition = stream.get_current_position().toChar();
            UInt32 tmpSize = stream.get_buffer_length();
            UInt32 tmpLength = memberInfo.length;
            stream.set_buffer_length((UInt32)((UInt64)tmpPosition - (UInt64)stream.get_buffer_begin()) + memberInfo.length);

            switch (memberInfo.memberId) {
                case RTI_CDR_PID_IGNORE:
                    break;
                case RTI_CDR_PID_LIST_END:
                    end = true;
                    break;</xsl:text>
    </xsl:variable>
  
    <xsl:variable name="mutableTypeEndDesBlock">
                default:
            <xsl:if test="@kind!='union'">
                    if (memberInfo.flagMustUnderstand) {
            </xsl:if>
                        throw gcnew Unassignable("Unknown member ID: "+ memberInfo.memberId);
            <xsl:if test="@kind!='union'">
                    }
            </xsl:if>
            }
            
            stream.set_buffer_length(tmpSize);
            stream.set_current_position((char *)(tmpPosition + tmpLength));
        }
    </xsl:variable>

    <xsl:apply-templates mode="error-checking"/>

<xsl:variable name="generateCode">
    <xsl:call-template name="isNecessaryGenerateCode">
        <xsl:with-param name="typedefNode" select="."/>
    </xsl:call-template>                                
</xsl:variable>

<xsl:if test="$generateCode='yes'">
/* ------------------------------------------------------------------------
 *  Type <xsl:value-of select="@name"/>
 * ------------------------------------------------------------------------ */

/* ------------------------------------------------------------------------
    Support functions:
 * ------------------------------------------------------------------------ */

void 
<xsl:value-of select="@name"/>Plugin::print_data(
        <xsl:value-of select="@name"/>^ sample,
        String^ desc,
        UInt32 indent_level) {

    for (UInt32 i = 0; i &lt; indent_level; ++i) { Console::Write("   "); }

    if (desc != nullptr) {
        Console::WriteLine("{0}:", desc);
    } else {
        Console::WriteLine();
    }

    if (sample == nullptr) {
        Console::WriteLine("null");
        return;
    }

<xsl:if test="(@kind = 'valuetype' or @kind = 'struct') and @baseClass != ''">
  <xsl:text>    </xsl:text>
  <xsl:value-of select="@baseClass"/>
  <xsl:text>Plugin::get_instance()->print_data(</xsl:text>
  <xsl:text>sample, "", indent_level);&nl;</xsl:text>        
</xsl:if>

<xsl:if test="@kind = 'union'">
<!-- Don't generate any code for unions, since using pointer fields in union is dangerous -->
  <xsl:call-template name="generateMemberCode">
    <xsl:with-param name="generationMode" select="'print'"/>
    <xsl:with-param name="member" select="./discriminator"/>
  </xsl:call-template>
</xsl:if>

<xsl:apply-templates mode="code-generation">
  <xsl:with-param name="generationMode" select="'print'"/>
</xsl:apply-templates>
}


/* ------------------------------------------------------------------------
    (De)Serialize functions:
 * ------------------------------------------------------------------------ */

Boolean 
<xsl:value-of select="@name"/>Plugin::serialize(
    TypePluginDefaultEndpointData^ endpoint_data,
    <xsl:value-of select="@name"/>^ sample,
    CdrStream% stream,    
    Boolean serialize_encapsulation,
    UInt16 encapsulation_id,
    Boolean serialize_sample, 
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> 
    UInt32 memberId = 0;
    CdrStreamPosition memberLengthPosition;
    Boolean skipListEndId_tmp = false;
    UInt32 maxLength = 0;
    </xsl:if>

    <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> 
    if (!stream.dirty) {
        stream.dirty = true;

        maxLength = get_serialized_sample_max_size(endpoint_data, false, encapsulation_id,0);

        if (maxLength > 65535) {
            stream.useExtendedMemberId = true;
        } else {
            stream.useExtendedMemberId = false;
        }
    }

    //reset the skipListEndId flag
    skipListEndId_tmp =  stream.skipListEndId;
    stream.skipListEndId = false;
    </xsl:if>

    if (serialize_encapsulation) {
        /* Encapsulate sample */
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> 
            if (encapsulation_id == DDS::CdrEncapsulation::CDR_ENCAPSULATION_ID_CDR_BE) {
                encapsulation_id = DDS::CdrEncapsulation::CDR_ENCAPSULATION_ID_PL_CDR_BE;
            } else if (encapsulation_id == DDS::CdrEncapsulation::CDR_ENCAPSULATION_ID_CDR_LE) {
                encapsulation_id = DDS::CdrEncapsulation::CDR_ENCAPSULATION_ID_PL_CDR_LE;
            }
        </xsl:if>
        if (!stream.serialize_and_set_cdr_encapsulation(encapsulation_id)) {
            return false;
        }

<xsl:if test="$rtidds42e='no'">
        position = stream.reset_alignment();
</xsl:if>
    }

    if (serialize_sample) {
<xsl:if test="$rtidds42e='yes'">
        Boolean top_level = !stream.dirty;
        stream.dirty = true;

        if (!serialize_encapsulation &amp;&amp; top_level) {
            position = stream.reset_alignment_w_offset(4);
        }
</xsl:if>

  <xsl:if test="(@kind = 'valuetype' or @kind = 'struct') and @baseClass != ''">
      <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        stream.skipListEndId = true;
       </xsl:if>
      <xsl:text>    if (!</xsl:text>
      <xsl:value-of select="@baseClass"/>
      <xsl:text>Plugin::get_instance()->serialize(endpoint_data,</xsl:text>
      <xsl:text>sample, stream, false, encapsulation_id, true, endpoint_plugin_qos)) {&nl;</xsl:text>        
      <xsl:text>        return false;&nl;</xsl:text>
      <xsl:text>    }</xsl:text>
      <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
       stream.skipListEndId = false;
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
            memberLengthPosition = stream.serialize_member_id(
                (UInt16)DDS::CdrEncapsulation::CDR_ENCAPSULATION_MEMBER_ID_LIST_END);
            stream.serialize_member_length(memberLengthPosition, false);
        }
        stream.skipListEndId = skipListEndId_tmp;
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
        if (!serialize_encapsulation &amp;&amp; top_level) {
            stream.restore_alignment(position);
        }
</xsl:if>
    }

<xsl:if test="$rtidds42e='no'">
    if(serialize_encapsulation) {
        stream.restore_alignment(position);
    }
</xsl:if>

    return true;
}


Boolean 
<xsl:value-of select="@name"/>Plugin::deserialize_sample(
    TypePluginDefaultEndpointData^ endpoint_data,
    <xsl:value-of select="@name"/>^ sample,
    CdrStream% stream,   
    Boolean deserialize_encapsulation,
    Boolean deserialize_data, 
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    UInt32 memberId = 0;
    UInt32 length = 0;
    Boolean end = false;
</xsl:if>
    if(deserialize_encapsulation) {
        /* Deserialize encapsulation */
        if (!stream.deserialize_and_set_cdr_encapsulation()) {
            return false;
        }

<xsl:if test="$rtidds42e='no'">
        position = stream.reset_alignment();
</xsl:if>
    }

    if (deserialize_data) {
<xsl:if test="$rtidds42e='yes'">
        Boolean top_level = !stream.dirty;
        stream.dirty = true;

        if (!deserialize_encapsulation &amp;&amp; top_level) {
            position = stream.reset_alignment_w_offset(4);
        }
</xsl:if>

<xsl:if test="($xType='MUTABLE_EXTENSIBILITY' or $xType='EXTENSIBLE_EXTENSIBILITY') and not(@kind = 'union')">
    <xsl:text>        sample-&gt;clear();&nl;</xsl:text>
</xsl:if>

  <xsl:if test="(@kind = 'valuetype' or @kind = 'struct') and @baseClass != ''">
      <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        {
            CdrStreamPosition begin = stream.get_current_position();
    </xsl:if>
      <xsl:text>        if (!</xsl:text>
      <xsl:value-of select="@baseClass"/>
      <xsl:text>Plugin::get_instance()->deserialize_sample(endpoint_data,</xsl:text>
      <xsl:text>sample, stream, false, true, endpoint_plugin_qos)) {&nl;</xsl:text>        
      <xsl:text>            return false;&nl;</xsl:text>
      <xsl:text>        }</xsl:text>
      <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
                stream.set_current_position(begin);
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
<xsl:if test="(@kind='struct' or @kind='valuetype') and $xType='EXTENSIBLE_EXTENSIBILITY'">
    } catch (System::ApplicationException^  e) {
        if (stream.get_remainder() >= RTI_CDR_PARAMETER_HEADER_ALIGNMENT) {
            throw gcnew System::ApplicationException("Error deserializing sample! Remainder: " + stream.get_remainder() + "\n" +
                                                              "Exception caused by: " + e->Message);
        }
    }
</xsl:if>
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    <xsl:value-of select="$mutableTypeEndDesBlock"/>
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
        if (!deserialize_encapsulation &amp;&amp; top_level) {
            stream.restore_alignment(position);
        }
</xsl:if>
    }

<xsl:if test="$rtidds42e='no'">
    if(deserialize_encapsulation) {
        stream.restore_alignment(position);
    }
</xsl:if>

    return true;
}

<!-- skip method -->
Boolean
<xsl:value-of select="@name"/>Plugin::skip(
    TypePluginDefaultEndpointData^ endpoint_data,
    CdrStream% stream,   
    Boolean skip_encapsulation,
    Boolean skip_sample, 
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        UInt32 memberId = 0;
        UInt32 length = 0;
        Boolean end = false;
</xsl:if>
<xsl:if test="member[@kind = 'sequence']">
    UInt32 sequence_length = 0;
</xsl:if>

    if (skip_encapsulation) {
        if (!stream.skip_encapsulation()) {
            return false;
        }
<xsl:if test="$rtidds42e='no'">
        position = stream.reset_alignment();
</xsl:if>
    }

    if (skip_sample) {
<xsl:if test="$rtidds42e='yes'">
        if (!skip_encapsulation) {
            position = stream.reset_alignment_w_offset(4);
        }
</xsl:if>
        <xsl:if test="(@kind = 'valuetype' or @kind = 'struct') and @baseClass != ''">
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        {
            CdrStreamPosition begin = stream.get_current_position();
      </xsl:if>
            <xsl:text>    if (!</xsl:text>
            <xsl:value-of select="@baseClass"/>
            <xsl:text>Plugin::get_instance()->skip(</xsl:text>
            <xsl:text>endpoint_data, stream,</xsl:text>
            <xsl:text>false, true, endpoint_plugin_qos)) {&nl;</xsl:text>        
            <xsl:text>        return false;&nl;</xsl:text>
            <xsl:text>    }</xsl:text>
            <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
            stream.set_current_position(begin);
         }
            </xsl:if>
        </xsl:if>
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
            <xsl:value-of select="$mutableTypeStartDesBlock"/>
        </xsl:if>            
        <xsl:if test="@kind = 'union'">
            <xsl:text>&indent;&indent;</xsl:text>
            <xsl:call-template name="obtainNativeType">
                <xsl:with-param name="idlType">
                    <xsl:call-template name="getBaseType">
                        <xsl:with-param name="member" select="./discriminator"/>
                    </xsl:call-template>
                </xsl:with-param>            
            </xsl:call-template>
            <xsl:text> disc;&nl;</xsl:text>

            <!-- For unions, create a member named _d (the union discriminator) and generate code for it -->
            <xsl:call-template name="generateMemberCode">
                <xsl:with-param name="generationMode" select="'deserialize'"/>
                <xsl:with-param name="discContainer" select="'disc'"/>
                <xsl:with-param name="member" select="./discriminator"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:apply-templates mode="code-generation">
            <xsl:with-param name="generationMode" select="'skip'"/>
            <xsl:with-param name="discContainer" select="'disc'"/>
        </xsl:apply-templates>
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
          <xsl:value-of select="$mutableTypeEndDesBlock"/>
        </xsl:if>
<xsl:if test="$rtidds42e='yes'">
        if (!skip_encapsulation) {
            stream.restore_alignment(position);
        }
</xsl:if>
    }

<xsl:if test="$rtidds42e='no'">
    if(skip_encapsulation) {
        stream.restore_alignment(position);
    }
</xsl:if>

    return true;
}

/*
  size is the offset from the point where we have do a logical reset
  Return difference in size, not the final offset.
*/
UInt32 
<xsl:value-of select="@name"/>Plugin::get_serialized_sample_max_size(
    TypePluginDefaultEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment)
{
<xsl:if test="@kind='union'">
    UInt32 union_max_size_serialized = 0;
</xsl:if>            
<xsl:if test="member[@bitField]">
    UInt32 current_bits = 0;
</xsl:if>
    UInt32 initial_alignment = current_alignment;
<xsl:if test="$rtidds42e='no'">
    UInt32 encapsulation_size = current_alignment;
</xsl:if>

    if (include_encapsulation) {
        if (!CdrStream::valid_encapsulation_id(encapsulation_id)) {
            return 1;
        }

<xsl:if test="$rtidds42e='no'">
        encapsulation_size = CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
        encapsulation_size -= current_alignment;
        current_alignment = 0;
        initial_alignment = 0;
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
        current_alignment += CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
</xsl:if>
    }

<xsl:if test="@kind = 'union'">
    <!-- For unions, create a member named _d (the union discriminator) and generate code for it -->

    <xsl:call-template name="generateMemberCode">
        <xsl:with-param name="generationMode" select="'get_max_size_serialized'"/>
        <xsl:with-param name="member" select="./discriminator"/>
    </xsl:call-template>

</xsl:if>
<xsl:if test="(@kind = 'valuetype' or @kind = 'struct') and @baseClass != ''">
    <xsl:text>    current_alignment += </xsl:text>
    <xsl:value-of select="@baseClass"/>
    <xsl:text>Plugin::get_instance()->get_serialized_sample_max_size(endpoint_data,false,encapsulation_id,current_alignment);&nl;</xsl:text>        
</xsl:if>
 
<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'get_max_size_serialized'"/>
</xsl:apply-templates>

<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    <xsl:choose>
        <xsl:when test="not(@kind = 'union')">
    current_alignment += RTICdrStream_getExtendedParameterHeaderMaxSizeSerialized(current_alignment);
        </xsl:when>
        <xsl:otherwise>
    union_max_size_serialized += RTICdrStream_getExtendedParameterHeaderMaxSizeSerialized(union_max_size_serialized);
        </xsl:otherwise>
    </xsl:choose>
</xsl:if>

<xsl:if test="$rtidds42e='no'">
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }
</xsl:if>
<xsl:choose>
<xsl:when test="not(@kind = 'union')">
    return current_alignment - initial_alignment;</xsl:when>
<xsl:otherwise>
    return union_max_size_serialized + current_alignment - initial_alignment;</xsl:otherwise>
</xsl:choose>
}

<!-- get_serialized_sample_min_size method -->
UInt32
<xsl:value-of select="@name"/>Plugin::get_serialized_sample_min_size(
    TypePluginDefaultEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment)
{
<xsl:if test="@kind='union'">
    UInt32 union_min_size_serialized = 0xffffffff;
</xsl:if>            
<xsl:if test="member[@bitField]">
    UInt32 current_bits = 0;
</xsl:if>
    UInt32 initial_alignment = current_alignment;
<xsl:if test="$rtidds42e='no'">
    UInt32 encapsulation_size = current_alignment;
</xsl:if>

    if (include_encapsulation) {
        if (!CdrStream::valid_encapsulation_id(encapsulation_id)) {
            return 1;
        }

<xsl:if test="$rtidds42e='no'">
        encapsulation_size = CdrSizes::ENCAPSULATION->serialized_size(
            encapsulation_size);
        current_alignment = 0;
        initial_alignment = 0;
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
        current_alignment += CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
</xsl:if>
    }

<xsl:if test="@kind = 'union'">
    <!-- For unions, create a member named _d (the union discriminator) and generate code for it -->

    <xsl:call-template name="generateMemberCode">
        <xsl:with-param name="generationMode" select="'get_min_size_serialized'"/>
        <xsl:with-param name="member" select="./discriminator"/>
    </xsl:call-template>

</xsl:if>
<xsl:if test="(@kind = 'valuetype' or @kind = 'struct') and @baseClass != ''">
    <xsl:text>    current_alignment += </xsl:text>
    <xsl:value-of select="@baseClass"/>
    <xsl:text>Plugin::get_instance()->get_serialized_sample_min_size(endpoint_data,false,encapsulation_id,current_alignment);&nl;</xsl:text>        
</xsl:if>
 
<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'get_min_size_serialized'"/>
</xsl:apply-templates>

<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    <xsl:choose>
        <xsl:when test="not(@kind = 'union')">
    current_alignment += RTICdrStream_getParameterHeaderMaxSizeSerialized(current_alignment);
        </xsl:when>
        <xsl:otherwise>
    union_min_size_serialized += RTICdrStream_getParameterHeaderMaxSizeSerialized(union_min_size_serialized);
        </xsl:otherwise>
    </xsl:choose>
</xsl:if>

<xsl:if test="$rtidds42e='no'">
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }
</xsl:if>
<xsl:choose>
    <xsl:when test="not(@kind = 'union')">
    return current_alignment - initial_alignment;</xsl:when>
    <xsl:otherwise>
    return union_min_size_serialized + current_alignment - initial_alignment;</xsl:otherwise>
</xsl:choose>
}

<!-- get_serialized_sample_size -->
UInt32 
<xsl:value-of select="@name"/>Plugin::get_serialized_sample_size(
    TypePluginDefaultEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment,
    <xsl:value-of select="@name"/>^ sample)
{
<xsl:if test="member[@bitField]">
    UInt32 current_bits = 0;
</xsl:if>
    UInt32 initial_alignment = current_alignment;
<xsl:if test="$rtidds42e='no'">
    UInt32 encapsulation_size = current_alignment;
</xsl:if>

    if (include_encapsulation) {
        if (!CdrStream::valid_encapsulation_id(encapsulation_id)) {
            return 1;
        }

<xsl:if test="$rtidds42e='no'">
        encapsulation_size = CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
        encapsulation_size -= current_alignment;
        current_alignment = 0;
        initial_alignment = 0;
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
        current_alignment += CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
</xsl:if>
    }

<xsl:if test="@kind = 'union'">
    <xsl:call-template name="generateMemberCode">
        <xsl:with-param name="generationMode" select="'get_serialized_sample_size'"/>
        <xsl:with-param name="member" select="./discriminator"/>
    </xsl:call-template>
</xsl:if>
<xsl:if test="(@kind = 'valuetype' or @kind = 'struct') and @baseClass != ''">
    <xsl:text>    current_alignment += </xsl:text>
    <xsl:value-of select="@baseClass"/>
    <xsl:text>Plugin::get_instance()->get_serialized_sample_size(endpoint_data,false,encapsulation_id,current_alignment,sample);&nl;</xsl:text>
</xsl:if>
 
<xsl:apply-templates mode="code-generation">
    <xsl:with-param name="generationMode" select="'get_serialized_sample_size'"/>
</xsl:apply-templates>
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    current_alignment += RTICdrStream_getParameterHeaderMaxSizeSerialized(current_alignment);
</xsl:if>
<xsl:if test="$rtidds42e='no'">
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }
</xsl:if>
    return current_alignment - initial_alignment;
}

<!-- get_serialized_key_max_size method -->
UInt32
<xsl:value-of select="@name"/>Plugin::get_serialized_key_max_size(
    TypePluginDefaultEndpointData^ endpoint_data,
    Boolean include_encapsulation,
    UInt16 encapsulation_id,
    UInt32 current_alignment)
{
<xsl:if test="$keyFields[@bitField]">
    UInt32 current_bits = 0;
</xsl:if>
<xsl:if test="$rtidds42e='no'">
    UInt32 encapsulation_size = current_alignment;
</xsl:if>

    UInt32 initial_alignment = current_alignment;

    if (include_encapsulation) {
        if (!CdrStream::valid_encapsulation_id(encapsulation_id)) {
            return 1;
        }

<xsl:if test="$rtidds42e='no'">
        encapsulation_size = CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
        current_alignment = 0;
        initial_alignment = 0;
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
        current_alignment += CdrSizes::ENCAPSULATION->serialized_size(
            current_alignment);
</xsl:if>
    }
        
<xsl:if test="(@kind = 'valuetype' or @kind = 'struct') and @baseClass != '' and @keyedBaseClass='yes'">
    <xsl:text>    current_alignment += </xsl:text>
    <xsl:value-of select="@baseClass"/>Plugin::get_instance()->get_serialized_key_max_size(
        endpoint_data,
        false, encapsulation_id, 
        current_alignment);
</xsl:if>
        
<xsl:choose>
    <xsl:when test="name(.) = 'typedef'">
        <xsl:apply-templates select="./member"
                             mode="code-generation">
            <xsl:with-param name="generationMode" select="'get_max_size_serialized_key'"/>
        </xsl:apply-templates>
    </xsl:when>
    <xsl:when test="not($keyFields) and (not(@keyedBaseClass) or @keyedBaseClass='no')">
    current_alignment += get_serialized_sample_max_size(
        endpoint_data,false,encapsulation_id,current_alignment);
    </xsl:when>
    <xsl:otherwise>
    <xsl:apply-templates select="member[following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'key']]"
                     mode="code-generation">
        <xsl:with-param name="generationMode" select="'get_max_size_serialized_key'"/>
    </xsl:apply-templates>
   </xsl:otherwise>
</xsl:choose>
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    current_alignment += RTICdrStream_getExtendedParameterHeaderMaxSizeSerialized(current_alignment);
</xsl:if>

<xsl:if test="$rtidds42e='no'">
    if (include_encapsulation) {
        current_alignment += encapsulation_size;
    }
</xsl:if>
    return current_alignment - initial_alignment;
}

/* ------------------------------------------------------------------------
    Key Management functions:
 * ------------------------------------------------------------------------ */

Boolean 
<xsl:value-of select="@name"/>Plugin::serialize_key(
    TypePluginDefaultEndpointData^ endpoint_data,
    <xsl:value-of select="@name"/>^ sample,
    CdrStream% stream,    
    Boolean serialize_encapsulation,
    UInt16 encapsulation_id,
    Boolean serialize_key,
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> 
    UInt32 maxLength = 0;
    Boolean skipListEndId_tmp = false;
</xsl:if>
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> 
    if (!stream.dirty) {
        // Top level
        stream.dirty = true;

        maxLength = get_serialized_sample_max_size(endpoint_data, false, encapsulation_id,0);

        if (maxLength > 65535) {
            stream.useExtendedMemberId = true;
        } else {
            stream.useExtendedMemberId = false;
        }
    }

    //reset the skipListEndId flag
    skipListEndId_tmp =  stream.skipListEndId;
    stream.skipListEndId = false;        
</xsl:if>
    if (serialize_encapsulation) {
        /* Encapsulate sample */
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> 
        if (encapsulation_id == DDS::CdrEncapsulation::CDR_ENCAPSULATION_ID_CDR_BE) {
            encapsulation_id = DDS::CdrEncapsulation::CDR_ENCAPSULATION_ID_PL_CDR_BE;
        } else if (encapsulation_id == DDS::CdrEncapsulation::CDR_ENCAPSULATION_ID_CDR_LE) {
            encapsulation_id = DDS::CdrEncapsulation::CDR_ENCAPSULATION_ID_PL_CDR_LE;
        }
</xsl:if>
        if (!stream.serialize_and_set_cdr_encapsulation(encapsulation_id)) {
            return false;
        }

<xsl:if test="$rtidds42e='no'">
        position = stream.reset_alignment();
</xsl:if>
    }

    if (serialize_key) {
<xsl:if test="$rtidds42e='yes'">
        Boolean top_level = !stream.dirty;
        stream.dirty = true;

        if (!serialize_encapsulation &amp;&amp; top_level) {
            position = stream.reset_alignment_w_offset(4);
        }
</xsl:if>

<xsl:if test="(@kind = 'valuetype' or @kind = 'struct') and @baseClass != '' and @keyedBaseClass='yes'">
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        stream.skipListEndId = true;
        </xsl:if>
    <xsl:text>        if (!</xsl:text>
    <xsl:value-of select="@baseClass"/>
    <xsl:text>Plugin::get_instance()->serialize_key(&nl;</xsl:text>
    <xsl:text>&indent;&indent;&indent;endpoint_data,</xsl:text>
    <xsl:text>sample, stream, false, encapsulation_id, true, endpoint_plugin_qos)) {&nl;</xsl:text>
    <xsl:text>            return false;&nl;</xsl:text>
    <xsl:text>        }</xsl:text>
         <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        stream.skipListEndId = false;
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
        if (!serialize(
                endpoint_data,
                sample,
                stream,
                serialize_encapsulation,
                encapsulation_id, 
                serialize_key,
                endpoint_plugin_qos)) {
            return false;
        }
    </xsl:when>
    <xsl:otherwise>
    <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'"> 
        {
            UInt32 memberId = 0;
            UInt32 memberLength = 0;
            CdrStreamPosition memberLengthPosition;
            UInt32 position_tmp = 0;
    </xsl:if>  
	<xsl:apply-templates select="member[following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'key']]"
			     mode="code-generation">
	    <xsl:with-param name="generationMode" select="'serialize_key'"/>
	</xsl:apply-templates>
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
            if (!(skipListEndId_tmp)) {
                memberLengthPosition = stream.serialize_member_id(
                    (UInt16)DDS::CdrEncapsulation::CDR_ENCAPSULATION_MEMBER_ID_LIST_END);
                stream.serialize_member_length(memberLengthPosition, false);
            }
            stream.skipListEndId = skipListEndId_tmp;
          }
        </xsl:if>
   </xsl:otherwise>
</xsl:choose>

    <xsl:if test="$rtidds42e='yes'">
        if (!serialize_encapsulation &amp;&amp; top_level) {
            stream.restore_alignment(position);
        }
    </xsl:if>
    }

<xsl:if test="$rtidds42e='no'">
    if(serialize_encapsulation) {
        stream.restore_alignment(position);
    }
</xsl:if>

    return true;
}

<!-- deserialize key method -->
Boolean <xsl:value-of select="@name"/>Plugin::deserialize_key_sample(
    TypePluginDefaultEndpointData^ endpoint_data,
    <xsl:value-of select="@name"/>^ sample,
    CdrStream% stream, 
    Boolean deserialize_encapsulation,
    Boolean deserialize_key,
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;

    if (deserialize_encapsulation) {
        /* Deserialize encapsulation */
        if (!stream.deserialize_and_set_cdr_encapsulation()) {
            return false;  
        }

<xsl:if test="$rtidds42e='no'">
        position = stream.reset_alignment();
</xsl:if>
    }

    if (deserialize_key) {
<xsl:if test="$rtidds42e='yes'">
        Boolean top_level = !stream.dirty;
        stream.dirty = true;

        if (!deserialize_encapsulation &amp;&amp; top_level) {
            position = stream.reset_alignment_w_offset(4);
        }
</xsl:if>

<xsl:if test="(@kind = 'valuetype' or @kind = 'struct') and @baseClass != '' and @keyedBaseClass='yes'">
    <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        {
            CdrStreamPosition begin = stream.get_current_position();
      </xsl:if>
        if (!<xsl:value-of select="@baseClass"/>Plugin::get_instance()->deserialize_key_sample(
                endpoint_data, sample, stream, deserialize_encapsulation, deserialize_key, endpoint_plugin_qos)) {
            return false;
        }
       <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
                stream.set_current_position(begin);
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
        if (!deserialize_sample(
                endpoint_data, sample, stream,
                deserialize_encapsulation,
                deserialize_key,
                endpoint_plugin_qos)) {
            return false;
        }
    </xsl:when>
    <xsl:otherwise>
        <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
        {
            UInt32 memberId = 0;
            UInt32 length = 0;
            Boolean end = false;

            <xsl:value-of select="$mutableTypeStartDesBlock"/>
        </xsl:if>
    <xsl:apply-templates select="member[following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'key']]"
    		     mode="code-generation">
        <xsl:with-param name="generationMode" select="'deserialize_key'"/>
    </xsl:apply-templates>
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
            <xsl:value-of select="$mutableTypeEndDesBlock"/>
        }
</xsl:if>
   </xsl:otherwise>
</xsl:choose>

    <xsl:if test="$rtidds42e='yes'">
        if (!deserialize_encapsulation &amp;&amp; top_level) {
            stream.restore_alignment(position);
        }
    </xsl:if>
    }

<xsl:if test="$rtidds42e='no'">
    if(deserialize_encapsulation) {
        stream.restore_alignment(position);
    }
</xsl:if>

    return true;
}

<!-- serialized_sample_to_key method -->
Boolean
<xsl:value-of select="@name"/>Plugin::serialized_sample_to_key(
    TypePluginDefaultEndpointData^ endpoint_data,
    <xsl:value-of select="@name"/>^ sample,
    CdrStream% stream, 
    Boolean deserialize_encapsulation,  
    Boolean deserialize_key, 
    Object^ endpoint_plugin_qos)
{
    CdrStreamPosition position;
<xsl:if test="($isKeyed='yes' or name(.) = 'typedef') and ($xType='MUTABLE_EXTENSIBILITY')">
    UInt32 memberId = 0;
    UInt32 length = 0;
    Boolean end = false;
</xsl:if>
    if(deserialize_encapsulation) {
        if (!stream.deserialize_and_set_cdr_encapsulation()) {
            return false;
        }
<xsl:if test="$rtidds42e='no'">
        position = stream.reset_alignment();
</xsl:if>
    }

    if (deserialize_key) {
<xsl:if test="$rtidds42e='yes'">
        Boolean top_level = !stream.dirty;
        stream.dirty = true;

        if (!deserialize_encapsulation &amp;&amp; top_level) {
            position = stream.reset_alignment_w_offset(4);
        }
</xsl:if>

<xsl:if test="$isKeyed='no' and name(.) != 'typedef'">
        if (!deserialize_sample(
                endpoint_data,
                sample,
                stream,
                deserialize_encapsulation,
                deserialize_key,
                endpoint_plugin_qos)) {
            return false;
        }
</xsl:if>

<xsl:if test="$isKeyed='yes' or name(.) = 'typedef'">
    <xsl:if test="(@kind = 'valuetype' or @kind = 'struct')">
        <xsl:choose>
            <xsl:when test="@baseClass != '' and @keyedBaseClass='yes'">
                <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
                {
                    CdrStreamPosition begin = stream.get_current_position();
                </xsl:if>
                <xsl:text>    if (!</xsl:text>
                <xsl:value-of select="@baseClass"/>
                <xsl:text>Plugin::get_instance()->serialized_sample_to_key(
                        endpoint_data,
                        sample,
                        stream,
                        false, 
                        true,
                        endpoint_plugin_qos)) {
                    return false;&nl;</xsl:text>
                }
                <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
                    stream.set_current_position(begin);
                }
                </xsl:if>
            </xsl:when>
            <xsl:when test="@baseClass != ''">
                <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
                {
                    CdrStreamPosition begin = stream.get_current_position();
                </xsl:if>
                <xsl:text>    if (!</xsl:text>
                <xsl:value-of select="@baseClass"/>
                <xsl:text>Plugin::get_instance()->skip(endpoint_data, stream,&nl;</xsl:text>
                <xsl:text>            false, true,&nl;</xsl:text>
                <xsl:text>            endpoint_plugin_qos)) {&nl;</xsl:text>
                <xsl:text>        return false;&nl;</xsl:text>
                <xsl:text>    }&nl;</xsl:text>
                <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
                    stream.set_current_position(begin);
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
        if (!deserialize_encapsulation &amp;&amp; top_level) {
            stream.restore_alignment(position);
        }
    </xsl:if>
    }

<xsl:if test="$rtidds42e='no'">
    if(deserialize_encapsulation) {
        stream.restore_alignment(position);
    }
</xsl:if>

    return true;
}

<xsl:if test="$isKeyed='yes'">

Boolean 
<xsl:value-of select="@name"/>Plugin::instance_to_key(
    TypePluginDefaultEndpointData^ endpoint_data,
    <xsl:value-of select="@name"/>^ dst, 
    <xsl:value-of select="@name"/>^ src)
{
<xsl:if test="(@kind = 'valuetype' or @kind = 'struct') and @baseClass != '' and @keyedBaseClass='yes'">
    <xsl:text>    if (!</xsl:text>
    <xsl:value-of select="@baseClass"/>
    <xsl:text>Plugin::get_instance()->instance_to_key(endpoint_data,</xsl:text>
    <xsl:text>dst,</xsl:text>
    <xsl:text>src)) {&nl;</xsl:text>        
    <xsl:text>        return false;&nl;</xsl:text>
    <xsl:text>    }</xsl:text>
</xsl:if>
                
<xsl:apply-templates select="member[following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'key']]"
                     mode="code-generation">
    <xsl:with-param name="generationMode" select="'copy'"/>
</xsl:apply-templates>
    return true;
}

Boolean 
<xsl:value-of select="@name"/>Plugin::key_to_instance(
    TypePluginDefaultEndpointData^ endpoint_data,
    <xsl:value-of select="@name"/>^ dst,
    <xsl:value-of select="@name"/>^ src)
{
<xsl:if test="(@kind = 'valuetype' or @kind = 'struct') and @baseClass != '' and @keyedBaseClass='yes'">
    <xsl:text>    if (!</xsl:text>
    <xsl:value-of select="@baseClass"/>
    <xsl:text>Plugin::get_instance()->key_to_instance(endpoint_data,</xsl:text>
    <xsl:text>dst,</xsl:text>
    <xsl:text>src)) {&nl;</xsl:text>        
    <xsl:text>        return false;&nl;</xsl:text>
    <xsl:text>    }</xsl:text>
</xsl:if>

<xsl:apply-templates select="member[following-sibling::node()[position() = 1 and name() = 'directive' and @kind = 'key']]"
                     mode="code-generation">
    <xsl:with-param name="generationMode" select="'copy'"/>
</xsl:apply-templates>
    return true;
}


Boolean 
<xsl:value-of select="@name"/>Plugin::serialized_sample_to_key_hash(
    TypePluginDefaultEndpointData^ endpoint_data,
    CdrStream% stream, 
    KeyHash_t% key_hash,
    Boolean deserialize_encapsulation,
    Object^ endpoint_plugin_qos) 
{   
    CdrStreamPosition position;
<xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
    UInt32 memberId = 0;
    UInt32 length = 0;
    Boolean end = false;
</xsl:if>

<xsl:if test="$rtidds42e='yes'">
    Boolean top_level = !stream.dirty;
    stream.dirty = true;
</xsl:if>

    if(deserialize_encapsulation) {
        if (!stream.deserialize_and_set_cdr_encapsulation()) {
            return false;
        }
<xsl:if test="$rtidds42e='no'">
        position = stream.reset_alignment();
    }
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
    } else if (top_level) {
        position = stream.reset_alignment_w_offset(4);
    }
</xsl:if>

    <xsl:text>&nl;    </xsl:text>
    GCHandle sample_handle = GCHandle::FromIntPtr(IntPtr(const_cast&lt;void*&gt;(endpoint_data->get_temp_sample())));
    <xsl:value-of select="@name"/>^ sample = static_cast&lt;<xsl:value-of select="@name"/>^&gt;(sample_handle.Target);
    if (sample == nullptr) {
        return false;
    }

<xsl:if test="(@kind = 'valuetype' or @kind = 'struct')">
    <xsl:choose>
        <xsl:when test="@baseClass != '' and @keyedBaseClass='yes'">
            <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
             {
                CdrStreamPosition begin = stream.get_current_position();
            </xsl:if>
    if (!<xsl:value-of select="@baseClass"/>Plugin::get_instance()->serialized_sample_to_key(
            endpoint_data, sample, stream, false, true, endpoint_plugin_qos)) {
        return false;
    }&nl;<xsl:text/>
         <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
                    stream.set_current_position(begin);
                }
            </xsl:if>        
        </xsl:when>
        <xsl:when test="@baseClass != ''">
            <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
             {
                CdrStreamPosition begin = stream.get_current_position();
            </xsl:if>
    if (!<xsl:value-of select="@baseClass"/>Plugin::get_instance()->skip(
            endpoint_data, stream, false, true, endpoint_plugin_qos)) {
        return false;
    }&nl;<xsl:text/>
         <xsl:if test="$xType='MUTABLE_EXTENSIBILITY'">
                stream.set_current_position(begin);
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
    if(deserialize_encapsulation) {
        stream.restore_alignment(position);
    }
</xsl:if>
<xsl:if test="$rtidds42e='yes'">
    if (!deserialize_encapsulation &amp;&amp; top_level) {
        stream.restore_alignment(position);
    }
</xsl:if>

    if (!instance_to_key_hash(
            endpoint_data, key_hash, sample)) {
        return false;
    }

    return true;
}
</xsl:if>


/* ------------------------------------------------------------------------
 * Plug-in Lifecycle Methods
 * ------------------------------------------------------------------------ */

<xsl:value-of select="@name"/>Plugin^
<xsl:value-of select="@name"/>Plugin::get_instance() {
    if (_singleton == nullptr) {
        _singleton = gcnew <xsl:value-of select="@name"/>Plugin();
    }
    return _singleton;
}


void
<xsl:value-of select="@name"/>Plugin::dispose() {
    delete _singleton;
    _singleton = nullptr;
}
</xsl:if> <!-- Generate Code -->
</xsl:template>

</xsl:stylesheet>

<!-- $Id: typePlugin.cpp.cli.xsl,v 1.26 2013/10/29 05:09:30 fernando Exp $ -->
