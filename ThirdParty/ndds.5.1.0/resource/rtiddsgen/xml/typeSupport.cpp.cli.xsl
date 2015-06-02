<?xml version="1.0"?>
<!--
   $Id: typeSupport.cpp.cli.xsl,v 1.4 2013/09/17 00:46:55 alejandro Exp $

   (c) Copyright 2007, Real-Time Innovations, Inc.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.

Modification history
 - - - - - - - - - -
510,13sep13,acr REQREPLY-2 Added get_type_name_untyped override to 
                allow getting a type name polymorphically
10x,16jul08,tk  Removed utils.xsl
10x,20jun08,rbw Removed non-CLS-compliant declarations from API
10x,18jun08,rbw Removed TypeSupport::initialize/finalize API: they were
                no-ops and only caused confusion (e.g. at Marshall Wace).
                Added additional method documentation.
10x,12may08,rbw Removed IUserObjectLifecycle interface: unnecessary
10v,09apr08,rbw Type plug-in API is now managed
10v,23mar08,rbw Reader, writer, and TypeSupport are now generic:
                removed most generated code
10v,21mar08,rbw Removed FooTypeSupport::finalize(): obsolete operation
10v,20mar08,rbw Improved consistency of read/take method prototypes
10v,17mar08,rbw Managed readers and writers don't require explicit
                disposal
10v,17mar08,rbw Removed explicit destructors/finalizers: unnecessary
10a,11mar08,rbw Fixed managed pointer syntax
10s,07mar08,rbw Fixed calls to superclasses; fixed pointers
10s,04mar08,rbw Made FooTypeSupport a singleton
10s,04mar08,rbw Fixed lots of compile errors
10s,03mar08,rbw Refactored most implementation into dds_dotnet
10s,01mar08,rbw Rewrote to no longer depend on unmanaged code
10s,27feb08,rbw Translate managed <-> unmanaged objects
10s,21feb08,rbw Filled in correct content
10s,13feb08,rbw Created
-->


<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:xalan="http://xml.apache.org/xalan"
                version="1.0">

<xsl:include href="typeCommon.cppcli.xsl"/>

<xsl:output method="text"/>

<xsl:variable name="sourcePreamble"
              select="$generationInfo/sourcePreamble[@kind = 'support-source']"/>


<!-- ===================================================================== -->
<!-- Document Root                                                         -->
<!-- ===================================================================== -->

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
*/<xsl:text>&nl;&nl;</xsl:text>

    <xsl:text>#include "</xsl:text>
    <xsl:value-of select="$idlFileBaseName"/>
    <xsl:text>Support.h"&nl;</xsl:text>
    <xsl:text>#include "</xsl:text>
    <xsl:value-of select="$idlFileBaseName"/>
    <xsl:text>Plugin.h"&nl;&nl;</xsl:text>

    <xsl:value-of select="$sourcePreamble"/>

    <xsl:apply-templates/>

</xsl:template>


<!-- ===================================================================== -->
<!-- Struct Declarations                                                   -->
<!-- ===================================================================== -->

<xsl:template match="struct">
    <xsl:variable name="fullyQualifiedStructName">
        <xsl:for-each select="./ancestor::module">
            <xsl:value-of select="@name"/>
            <xsl:text>::</xsl:text>
        </xsl:for-each>
        <xsl:value-of select="@name"/>
    </xsl:variable>

    <xsl:variable name="replacementMap">
        <map structName="{@name}" fullyQualifiedStructName="{@name}"/>
    </xsl:variable>

    <xsl:variable name="topLevel">
        <xsl:call-template name="isTopLevelType">
            <xsl:with-param name="typeNode" select="."/>
        </xsl:call-template>
    </xsl:variable>
       
    <xsl:if test="$topLevel='yes'">
        <xsl:apply-templates mode="error-checking"/>
/* ========================================================================= */

// ---------------------------------------------------------------------------
// <xsl:value-of select="@name"/>DataWriter
// ---------------------------------------------------------------------------

<xsl:value-of select="@name"/>DataWriter::<xsl:value-of select="@name"/>DataWriter(
        System::IntPtr impl) : DDS::TypedDataWriter&lt;<xsl:value-of select="@name"/>^&gt;(impl) {
    // empty
}


// ---------------------------------------------------------------------------
// <xsl:value-of select="@name"/>DataReader
// ---------------------------------------------------------------------------

<xsl:value-of select="@name"/>DataReader::<xsl:value-of select="@name"/>DataReader(
        System::IntPtr impl) : DDS::TypedDataReader&lt;<xsl:value-of select="@name"/>^&gt;(impl) {
    // empty
}


// ---------------------------------------------------------------------------
// <xsl:value-of select="@name"/>TypeSupport
// ---------------------------------------------------------------------------

<xsl:value-of select="@name"/>TypeSupport::<xsl:value-of select="@name"/>TypeSupport()
        : DDS::TypedTypeSupport&lt;<xsl:value-of select="@name"/>^&gt;(
            <xsl:value-of select="@name"/>Plugin::get_instance()) {

    _type_plugin = <xsl:value-of select="@name"/>Plugin::get_instance();
}

void <xsl:value-of select="@name"/>TypeSupport::register_type(
        DDS::DomainParticipant^ participant,
        System::String^ type_name) {

    get_instance()->register_type_untyped(participant, type_name);
}

void <xsl:value-of select="@name"/>TypeSupport::unregister_type(
        DDS::DomainParticipant^ participant,
        System::String^ type_name) {

    get_instance()->unregister_type_untyped(participant, type_name);
}

<xsl:value-of select="@name"/>^ <xsl:value-of select="@name"/>TypeSupport::create_data() {
    return gcnew <xsl:value-of select="@name"/>();
}

<xsl:value-of select="@name"/>^ <xsl:value-of select="@name"/>TypeSupport::create_data_untyped() {
    return create_data();
}

void <xsl:value-of select="@name"/>TypeSupport::delete_data(
        <xsl:value-of select="@name"/>^ a_data) {
    /* If the generated type does not implement IDisposable (the default),
     * the following will no a no-op.
     */
    delete a_data;
}

void <xsl:value-of select="@name"/>TypeSupport::print_data(<xsl:value-of select="@name"/>^ a_data) {
     get_instance()->_type_plugin->print_data(a_data, nullptr, 0);
}

void <xsl:value-of select="@name"/>TypeSupport::copy_data(
        <xsl:value-of select="@name"/>^ dst, <xsl:value-of select="@name"/>^ src) {

    get_instance()->copy_data_untyped(dst, src);
}

System::String^ <xsl:value-of select="@name"/>TypeSupport::get_type_name() {
    return TYPENAME;
}

System::String^ <xsl:value-of select="@name"/>TypeSupport::get_type_name_untyped() {
    return TYPENAME;
}

DDS::DataReader^ <xsl:value-of select="@name"/>TypeSupport::create_datareaderI(
        System::IntPtr impl) {

    return gcnew <xsl:value-of select="@name"/>DataReader(impl);
}

DDS::DataWriter^ <xsl:value-of select="@name"/>TypeSupport::create_datawriterI(
        System::IntPtr impl) {

    return gcnew <xsl:value-of select="@name"/>DataWriter(impl);
}

<xsl:value-of select="@name"/>TypeSupport^
<xsl:value-of select="@name"/>TypeSupport::get_instance() {
    if (_singleton == nullptr) {
        _singleton = gcnew <xsl:value-of select="@name"/>TypeSupport();
    }
    return _singleton;
}
    </xsl:if> <!-- if topLevel -->
</xsl:template>

</xsl:stylesheet>
