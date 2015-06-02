<?xml version="1.0"?>
<!--
   $Id: typeSupport.h.cli.xsl,v 1.5 2013/09/17 00:46:56 alejandro Exp $

   (c) Copyright 2007, Real-Time Innovations, Inc.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.

Modification history
 - - - - - - - - - -
510,13sep13,acr REQREPLY-2 Added get_type_name_untyped override to 
                allow getting a type name polymorphically
1.5e,14jan12,asn CORE-5239: Made TypeSupport::get_instance() public 
10x,04feb09,fcs Fixed bug 12711
10x,16jul08,tk  Removed utils.xsl
10x,20jun08,rbw Removed non-CLS-compliant declarations from API
10x,18jun08,rbw Removed TypeSupport::initialize/finalize API: they were
                no-ops and only caused confusion (e.g. at Marshall Wace).
                Added additional method documentation.
10x,12may08,rbw Removed IUserObjectLifecycle interface: unnecessary
10v,10apr08,rbw Moved "using" from header to source
10v,09apr08,rbw Type plug-in API is now managed
10v,23mar08,rbw Reader, writer, and TypeSupport are now generic:
                removed most generated code
10v,21mar08,rbw Removed FooTypeSupport::finalize(): obsolete operation
10v,20mar08,rbw Improved consistency of read/take method prototypes
10v,17mar08,rbw Managed readers and writers don't require explicit
                disposal
10v,13mar08,rbw Fixed namespaces
10a,11mar08,rbw Fixed managed pointer syntax
10s,07mar08,rbw Fixed pointers
10s,04mar08,rbw Made FooTypeSupport a singleton
10s,04mar08,rbw Fixed lots of compile errors
10s,03mar08,rbw Updated method signatures; refactored implementation
                to dds_dotnet
10s,01mar08,rbw Rewrote to no longer depend on unmanaged code
10s,27feb08,rbw Improved API encapsulation
10s,21feb08,rbw Filled in correct content
10s,13feb08,rbw Created
-->


<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

<xsl:include href="typeCommon.cppcli.xsl"/>

<xsl:output method="text"/>

<xsl:variable name="sourcePreamble"
              select="$generationInfo/sourcePreamble[@kind = 'support-header']"/>


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

    <xsl:text>#pragma once&nl;&nl;</xsl:text>

    <xsl:text>#include "</xsl:text>
    <xsl:value-of select="$idlFileBaseName"/>
    <xsl:text>.h"&nl;&nl;</xsl:text>

    <xsl:value-of select="$sourcePreamble"/>

	<xsl:apply-templates/>

</xsl:template>


<!-- ===================================================================== -->
<!-- Struct Declarations                                                   -->
<!-- ===================================================================== -->

<xsl:template match="struct">
    <xsl:variable name="topLevel">
        <xsl:call-template name="isTopLevelType">
            <xsl:with-param name="typeNode" select="."/>
        </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="fullyQualifiedStructNameCPP">
        <xsl:for-each select="./ancestor::module">
            <xsl:value-of select="@name"/>
            <xsl:text>::</xsl:text>                
        </xsl:for-each>
        <xsl:value-of select="@name"/>
    </xsl:variable>    

    <xsl:if test="$topLevel='yes'">
        <xsl:apply-templates mode="error-checking"/>
// ---------------------------------------------------------------------------
// <xsl:value-of select="@name"/>TypeSupport
// ---------------------------------------------------------------------------

ref class <xsl:value-of select="@name"/>Plugin;

/* A collection of useful methods for dealing with objects of type
 * <xsl:value-of select="@name"/>.
 */
public ref class <xsl:value-of select="@name"/>TypeSupport
        : public DDS::TypedTypeSupport&lt;<xsl:value-of select="@name"/>^&gt; {
    // --- Type name: --------------------------------------------------------
  public:
    static System::String^ TYPENAME = "<xsl:text/>
    <xsl:value-of select="$fullyQualifiedStructNameCPP"/>
    <xsl:text>";&nl;</xsl:text>

    // --- Public Methods: ---------------------------------------------------
  public:
    /* Get the default name of this type.
     *
     * An application can choose to register a type under any name, so
     * calling this method is strictly optional.
     */
    static System::String^ get_type_name();

    /* Register this type with the given participant under the given logical
     * name. This type must be registered before a Topic can be created that
     * uses it.
     */
    static void register_type(
            DDS::DomainParticipant^ participant,
            System::String^ type_name);

    /* Unregister this type from the given participant, where it was
     * previously registered under the given name. No further Topic creation
     * using this type will be possible.
     *
     * Unregistration allows some middleware resources to be reclaimed.
     */
    static void unregister_type(
            DDS::DomainParticipant^ participant,
            System::String^ type_name);

    /* Create an instance of the <xsl:value-of select="@name"/> type.
     */
    static <xsl:value-of select="@name"/>^ create_data();

    /* If instances of the <xsl:value-of select="@name"/> type require any
     * explicit finalization, perform it now on the given sample.
     */
    static void delete_data(<xsl:value-of select="@name"/>^ data);

    /* Write the contents of the data sample to standard out.
     */
    static void print_data(<xsl:value-of select="@name"/>^ a_data);

    /* Perform a deep copy of the contents of one data sample over those of
     * another, overwriting it.
     */
    static void copy_data(
        <xsl:value-of select="@name"/>^ dst_data,
        <xsl:value-of select="@name"/>^ src_data);


    // --- Implementation: ---------------------------------------------------
    /* The following code is for the use of the middleware infrastructure.
     * Applications are not expected to call it directly.
     */
public:
    virtual DDS::DataReader^ create_datareaderI(
        System::IntPtr impl) override;
    virtual DDS::DataWriter^ create_datawriterI(
        System::IntPtr impl) override;
        
    virtual <xsl:value-of select="@name"/>^ create_data_untyped() override;
    
    virtual System::String^ get_type_name_untyped() override;
        

public:
    static <xsl:value-of select="@name"/>TypeSupport^ get_instance();

    <xsl:value-of select="@name"/>TypeSupport();

private:
    static <xsl:value-of select="@name"/>TypeSupport^ _singleton;
    <xsl:value-of select="@name"/>Plugin^ _type_plugin;
};


// ---------------------------------------------------------------------------
// <xsl:value-of select="@name"/>DataReader
// ---------------------------------------------------------------------------

/**
 * A reader for the <xsl:value-of select="@name"/> type.
 */
public ref class <xsl:value-of select="@name"/>DataReader :
        public DDS::TypedDataReader&lt;<xsl:value-of select="@name"/>^&gt; {
    /* The following code is for the use of the middleware infrastructure.
     * Applications are not expected to call it directly.
     */
  internal:
    <xsl:value-of select="@name"/>DataReader(System::IntPtr impl);
};


// ---------------------------------------------------------------------------
// <xsl:value-of select="@name"/>DataWriter
// ---------------------------------------------------------------------------

/**
 * A writer for the <xsl:value-of select="@name"/> user type.
 */
public ref class <xsl:value-of select="@name"/>DataWriter :
        public DDS::TypedDataWriter&lt;<xsl:value-of select="@name"/>^&gt; {
    /* The following code is for the use of the middleware infrastructure.
     * Applications are not expected to call it directly.
     */
  internal:
    <xsl:value-of select="@name"/>DataWriter(System::IntPtr impl);
};
</xsl:if> <!-- if topLevel -->
</xsl:template>

</xsl:stylesheet>
