<?xml version="1.0"?>

<!-- 
/* $Id: typePublisher.ads.xsl,v 1.3 2012/04/23 16:44:18 fernando Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2005.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
Modification history:
- - - - - - - - - - -
10o,17jun08,fcs Group types into modules
10o,29nov07,fcs 11/29/07 Merge changes
10o,13nov07,fcs Changed gpr file name
10o,09jul07,fcs Removed main.adb
10o,09jul07,fcs Created
-->

<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
<!ENTITY namespaceSeperator "_">    <!-- namespace separator -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:xalan = "http://xml.apache.org/xalan">

<xsl:include href="typeCommon.ada.xsl"/>

<xsl:output method="xml"/>

<xsl:template match="/">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="struct">
    <xsl:param name="containerNamespace"/>

    <xsl:variable name="newContainerNamespace">
        <xsl:if test="name(..) = 'specification'">
            <xsl:value-of select="concat($idlFileBaseName,'_IDL_File')"/>
        </xsl:if>
        <xsl:if test="name(..) = 'module'">
            <xsl:value-of select="$containerNamespace"/>
        </xsl:if>
    </xsl:variable>

    <xsl:variable name="typePackageName">
        <xsl:value-of select="$newContainerNamespace"/>
    </xsl:variable>

    <xsl:variable name="fullyQualifiedAdaTypeName" select="concat($typePackageName,'.',@name)"/>

    <xsl:variable name="idlFileBaseNameLowerCase">
        <xsl:call-template name="lower-case">
            <xsl:with-param name="text" select="$idlFileBaseName"/>
        </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="subscriberFile">
        <xsl:call-template name="obtainSourceFileName">
            <xsl:with-param name="directory"
                            select="''"/>
            <xsl:with-param name="containerNamespace"
                            select="$newContainerNamespace"/>
            <xsl:with-param name="typeName" select="concat(@name,'_subscriber')"/>
            <xsl:with-param name="fileExt" select="'adb'"/>
        </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="publisherFile">
        <xsl:call-template name="obtainSourceFileName">
            <xsl:with-param name="directory"
                            select="''"/>
            <xsl:with-param name="containerNamespace"
                            select="$newContainerNamespace"/>
            <xsl:with-param name="typeName" select="concat(@name,'_publisher')"/>
            <xsl:with-param name="fileExt" select="'adb'"/>
        </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="replacementMap">
        <map typePackageName="{$typePackageName}" fullQualifiednativeType="{$fullyQualifiedAdaTypeName}" 
             nativeType="{@name}"
             publisherFile="{$publisherFile}" subscriberFile="{$subscriberFile}"
             IDLFileBaseName="{$idlFileBaseName}" archName="{$archName}" 
             IDLFileBaseNameLowerCase="{$idlFileBaseNameLowerCase}"
             modifyPubData="{$modifyPubData}"/>
    </xsl:variable>
    
    <xsl:variable name="lastTopLevel">
        <xsl:call-template name="isLastLessDeepTopLevelType">
            <xsl:with-param name="typeNode" select="."/>
        </xsl:call-template>        
    </xsl:variable>

    <xsl:if test="$lastTopLevel = 'yes'">
        <xsl:variable name="adsFile">
            <xsl:call-template name="obtainSourceFileName">
                <xsl:with-param name="directory"
                                select="'./samples'"/>
                <xsl:with-param name="containerNamespace"
                                select="$newContainerNamespace"/>
                <xsl:with-param name="typeName" select="concat(@name,'_publisher')"/>
                <xsl:with-param name="fileExt" select="'ads'"/>
            </xsl:call-template>
        </xsl:variable>

        <file name="{$adsFile}">
            <xsl:text>procedure </xsl:text>
            <xsl:value-of select="$fullyQualifiedAdaTypeName"/>
            <xsl:text>_Publisher;&nl;</xsl:text>
        </file>

        <xsl:variable name="sampleGprFile">
            <xsl:call-template name="obtainSourceFileName">
                <xsl:with-param name="directory"
                                select="'./samples'"/>
                <xsl:with-param name="containerNamespace"
                                select="''"/>
                <xsl:with-param name="typeName" select="concat($idlFileBaseName,'-samples')"/>
                <xsl:with-param name="fileExt" select="'gpr'"/>
            </xsl:call-template>
        </xsl:variable>

        <file name="{$sampleGprFile}">
            <xsl:call-template name="replace-string-from-map">
                <xsl:with-param name="search" select="'%%nativeType%%'"/>
                <xsl:with-param name="replacementParamsMap" select="xalan:nodeset($replacementMap)/node()"/>
                <xsl:with-param name="inputString">
<xsl:text><![CDATA[
with "../%%IDLFileBaseNameLowerCase%%.gpr";
with "../%%IDLFileBaseNameLowerCase%%_c.gpr";
Project %%IDLFileBaseName%%.Samples is
   for languages use ("Ada");
   for Source_Dirs use (".");
   for Main use ("%%publisherFile%%",
                 "%%subscriberFile%%");

   for Object_Dir use %%IDLFileBaseName%%'Object_Dir;
   for Exec_Dir use %%IDLFileBaseName%%'Exec_Dir;


   package Binder is
      for Default_Switches ("ada") use
        %%IDLFileBaseName%%.Binder'Default_Switches ("ada");
   end Binder;

   package Compiler is
      for Default_Switches ("ada") use
        %%IDLFileBaseName%%.Compiler'Default_Switches ("ada");
      for Default_Switches ("C") use
        %%IDLFileBaseName%%.Compiler'Default_Switches ("C");
   end Compiler;

   package Builder is
      for Default_Switches ("ada") use
        %%IDLFileBaseName%%.Builder'Default_Switches ("ada");
   end Builder;

   package Linker is
      for Default_Switches ("ada") use
        %%IDLFileBaseName%%.Linker'Default_Switches ("ada");
   end Linker;
   
end %%IDLFileBaseName%%.Samples;
]]>&nl;</xsl:text>
                </xsl:with-param>
            </xsl:call-template>
        </file>

        <xsl:variable name="gprFile">
            <xsl:call-template name="obtainSourceFileName">
                <xsl:with-param name="directory"
                                select="'.'"/>
                <xsl:with-param name="containerNamespace"
                                select="''"/>
                <xsl:with-param name="typeName" select="$idlFileBaseName"/>
                <xsl:with-param name="fileExt" select="'gpr'"/>
            </xsl:call-template>
        </xsl:variable>

        <file name="{$gprFile}">
            <xsl:call-template name="replace-string-from-map">
                <xsl:with-param name="search" select="'%%nativeType%%'"/>
                <xsl:with-param name="replacementParamsMap" select="xalan:nodeset($replacementMap)/node()"/>
                <xsl:with-param name="inputString">
<xsl:text><![CDATA[
with "dds.gpr";
with "dds-libnddsada.gpr";
with "dds-libnddsc.gpr";

project %%IDLFileBaseName%% is

   for Source_Dirs use (".");
   for Object_Dir use ".obj";
   for Exec_Dir use "bin";
   type Build_Type is
      ("release", "debug");
   Ndds_Build : Build_Type := external ("NDDS_BUILD");
   type Library_Kind_Type is
      ("static", "relocatable");
   Library_Type : Library_Kind_Type := external ("LIBRARY_TYPE");
   type Os_Type is
      ("Linux", "Windows_NT");
   Os : Os_Type := external ("OS");
   for languages use ("Ada");

   package Binder is
      case Ndds_Build is
         when "release" =>
            for Default_Switches ("ada") use ("-E");

         when "debug" =>
            case Library_Type is
               when "static" =>
                  for Default_Switches ("ada") use ("-E", "-g");
               when "relocatable" =>
                  for Default_Switches ("ada") use ("-E");
            end case;
      end case;
   end Binder;

   package Compiler is
      for Driver ("idl") use "";

      case Ndds_Build is
         when "release" =>
            case Library_Type is
               when "static" =>
                  for Default_Switches ("ada") use Dds.Compiler'Default_Switches ("ada");
                  for Default_Switches ("c") use Dds.Compiler'Default_Switches ("C");

               when "relocatable" =>
                  for Default_Switches ("ada") use Dds.Compiler'Default_Switches ("ada") & "-ldl";
                  for Default_Switches ("c") use Dds.Compiler'Default_Switches ("C");
            end case;

         when "debug" =>
            case Library_Type is
               when "static" =>
                  for Default_Switches ("ada") use Dds.Compiler'Default_Switches ("ada") & "-g";
                  for Default_Switches ("c") use Dds.Compiler'Default_Switches ("C") & "-g";

               when "relocatable" =>
                  for Default_Switches ("ada") use Dds.Compiler'Default_Switches ("ada") & "-ldl -g";
                  for Default_Switches ("c") use Dds.Compiler'Default_Switches ("C") & "-g";
            end case;
      end case;
   end Compiler;

   package Builder is
      case Ndds_Build is
         when "release" =>
            case Library_Type is
               when "static" =>
                  for Default_Switches ("ada") use Dds.Builder'Default_Switches ("ada");

               when "relocatable" =>
                  for Default_Switches ("ada") use Dds.Builder'Default_Switches ("ada") & "-ldl";
            end case;

         when "debug" =>
            case Library_Type is
               when "static" =>
                  for Default_Switches ("ada") use Dds.Builder'Default_Switches ("ada") & "-g";

               when "relocatable" =>
                  for Default_Switches ("ada") use Dds.Builder'Default_Switches ("ada") & "-ldl -g";
            end case;
      end case;
   end Builder;

   package Linker is
      case Ndds_Build is
         when "release" =>
            case Library_Type is
               when "static" =>

               when "relocatable" =>
                  for Default_Switches ("ada") use ("-ldl");
            end case;

         when "debug" =>
            case Library_Type is
               when "static" =>
                  for Default_Switches ("c") use ("-g");
                  for Default_Switches ("ada") use ("-g");

               when "relocatable" =>
                  for Default_Switches ("c") use ("-g");
                  for Default_Switches ("ada") use ("-ldl", "-g");
            end case;
      end case;
   end Linker;

   package Naming is
      for Specification_Suffix ("idl") use ".idl";
   end Naming;

end %%IDLFileBaseName%%;
]]>&nl;</xsl:text>
                </xsl:with-param>
            </xsl:call-template>
        </file>

        <xsl:variable name="gprFileC">
            <xsl:call-template name="obtainSourceFileName">
                <xsl:with-param name="directory"
                                select="'.'"/>
                <xsl:with-param name="containerNamespace"
                                select="''"/>
                <xsl:with-param name="typeName" select="concat($idlFileBaseName,'_c')"/>
                <xsl:with-param name="fileExt" select="'gpr'"/>
            </xsl:call-template>
        </xsl:variable>

        <file name="{$gprFileC}">
            <xsl:call-template name="replace-string-from-map">
                <xsl:with-param name="search" select="'%%nativeType%%'"/>
                <xsl:with-param name="replacementParamsMap" select="xalan:nodeset($replacementMap)/node()"/>
                <xsl:with-param name="inputString">
<xsl:text><![CDATA[
with "dds.gpr";
with "dds-libnddsada.gpr";
with "dds-libnddsc.gpr";

project %%IDLFileBaseName%%_c is

   for Source_Dirs use (".");
   for Object_Dir use ".obj/C";
   for Exec_Dir use "bin";
   type Build_Type is
      ("release", "debug");
   Ndds_Build : Build_Type := external ("NDDS_BUILD");
   type Library_Kind_Type is
      ("static", "relocatable");
   Library_Type : Library_Kind_Type := external ("LIBRARY_TYPE");
   type Os_Type is
      ("Linux", "Windows_NT");
   Os : Os_Type := external ("OS");
   for languages use ("C");

   package Binder is
      case Ndds_Build is
         when "release" =>
            for Default_Switches ("ada") use ("-E");

         when "debug" =>
            case Library_Type is
               when "static" =>
                  for Default_Switches ("ada") use ("-E", "-g");
               when "relocatable" =>
                  for Default_Switches ("ada") use ("-E");
            end case;
      end case;
   end Binder;

   package Compiler is
      for Driver ("idl") use "";

      case Ndds_Build is
         when "release" =>
            case Library_Type is
               when "static" =>
                  for Default_Switches ("ada") use Dds.Compiler'Default_Switches ("ada");
                  for Default_Switches ("c") use Dds.Compiler'Default_Switches ("C");

               when "relocatable" =>
                  for Default_Switches ("ada") use Dds.Compiler'Default_Switches ("ada") & "-ldl";
                  for Default_Switches ("c") use Dds.Compiler'Default_Switches ("C");
            end case;

         when "debug" =>
            case Library_Type is
               when "static" =>
                  for Default_Switches ("ada") use Dds.Compiler'Default_Switches ("ada") & "-g";
                  for Default_Switches ("c") use Dds.Compiler'Default_Switches ("C") & "-g";

               when "relocatable" =>
                  for Default_Switches ("ada") use Dds.Compiler'Default_Switches ("ada") & "-ldl -g";
                  for Default_Switches ("c") use Dds.Compiler'Default_Switches ("C") & "-g";
            end case;
      end case;
   end Compiler;

   package Builder is
      case Ndds_Build is
         when "release" =>
            case Library_Type is
               when "static" =>
                  for Default_Switches ("ada") use Dds.Builder'Default_Switches ("ada");

               when "relocatable" =>
                  for Default_Switches ("ada") use Dds.Builder'Default_Switches ("ada") & "-ldl";
            end case;

         when "debug" =>
            case Library_Type is
               when "static" =>
                  for Default_Switches ("ada") use Dds.Builder'Default_Switches ("ada") & "-g";

               when "relocatable" =>
                  for Default_Switches ("ada") use Dds.Builder'Default_Switches ("ada") & "-ldl -g";
            end case;
      end case;
   end Builder;

   package Linker is
      case Ndds_Build is
         when "release" =>
            case Library_Type is
               when "static" =>

               when "relocatable" =>
                  for Default_Switches ("ada") use ("-ldl");
            end case;

         when "debug" =>
            case Library_Type is
               when "static" =>
                  for Default_Switches ("c") use ("-g");
                  for Default_Switches ("ada") use ("-g");

               when "relocatable" =>
                  for Default_Switches ("c") use ("-g");
                  for Default_Switches ("ada") use ("-ldl", "-g");
            end case;
      end case;
   end Linker;

   package Naming is
      for Specification_Suffix ("idl") use ".idl";
   end Naming;

end %%IDLFileBaseName%%_c;
]]>&nl;</xsl:text>
                </xsl:with-param>
            </xsl:call-template>
        </file>

    </xsl:if>    
</xsl:template>

<!--
Process directives
We ignore the copy directives for the example code
-->
<xsl:template match="directive[@kind = 'copy' or @kind = 'copy-ada']">
</xsl:template>

<xsl:template match="directive[@kind = 'copy' or @kind = 'copy-ada']"
              mode="code-generation">
</xsl:template>

</xsl:stylesheet>
