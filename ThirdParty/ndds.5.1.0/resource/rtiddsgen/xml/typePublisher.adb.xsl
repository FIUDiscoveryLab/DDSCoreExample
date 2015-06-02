<?xml version="1.0"?>

<!--
/* $Id: typePublisher.adb.xsl,v 1.5 2012/04/23 16:44:18 fernando Exp $

   (c) Copyright, Real-Time Innovations, Inc. 2005.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.

Modification history:
- - - - - - - - - - -
10o,19jul10,eys Updated to work with 4.5c
10o,17jun08,fcs Group types into modules
10o,16jun08,fcs 06/16/08 Merge changes
10o,29nov07,fcs 11/29/07 Merge changes
10o,09nov07,fcs Mark changes 11/02/07
10o,14aug07,fcs Fixed write call
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

    <xsl:variable name="replacementMap">
	<map typePackageName="{$typePackageName}" fullQualifiednativeType="{$fullyQualifiedAdaTypeName}"
             nativeType="{@name}"
             IDLFileBaseName="{$idlFileBaseName}" archName="{$archName}"
             modifyPubData="{$modifyPubData}" coreProduct="{$coreProduct}"/>
    </xsl:variable>

    <xsl:variable name="lastTopLevel">
        <xsl:call-template name="isLastLessDeepTopLevelType">
            <xsl:with-param name="typeNode" select="."/>
        </xsl:call-template>
    </xsl:variable>

    <xsl:if test="$lastTopLevel = 'yes'">
        <xsl:variable name="adbFile">
            <xsl:call-template name="obtainSourceFileName">
                <xsl:with-param name="directory"
                                select="'./samples'"/>
                <xsl:with-param name="containerNamespace"
                                select="$newContainerNamespace"/>
                <xsl:with-param name="typeName" select="concat(@name,'_publisher')"/>
                <xsl:with-param name="fileExt" select="'adb'"/>
            </xsl:call-template>
        </xsl:variable>

        <file name="{$adbFile}">
            <xsl:call-template name="replace-string-from-map">
                <xsl:with-param name="search" select="'%%nativeType%%'"/>
                <xsl:with-param name="replacementParamsMap" select="xalan:nodeset($replacementMap)/node()"/>
                <xsl:with-param name="inputString">
<xsl:text><![CDATA[
--  ===========================================================================
with Ada.Command_Line; use Ada.Command_Line;
with Ada.Exceptions;
with Ada.Text_IO; use Ada.Text_IO;

with DDS; use DDS;
with DDS.DomainParticipant;
with DDS.DomainParticipantFactory;
with DDS.Publisher;
with DDS.Topic;

with GNAT.Traceback.Symbolic;

--   Uncomment this to turn on additional logging
--  with NDDS.Config.Logger;

--  ===========================================================================

with %%typePackageName%%;
with %%fullQualifiednativeType%%_DataWriter;
with %%fullQualifiednativeType%%_TypeSupport;

procedure %%fullQualifiednativeType%%_Publisher  is
   --  procedure DDS_Enable_All_Traces;
   --  pragma Import (C, DDS_Enable_All_Traces, "DDS_Enable_All_Traces");

   --  Delete all entities
   procedure  Publisher_Shutdown
     (L_Participant : in out Standard.DDS.DomainParticipant.Ref_Access) is

      Factory : constant Standard.DDS.DomainParticipantFactory.Ref_Access :=
         Standard.DDS.DomainParticipantFactory.Get_Instance;
   begin
      L_Participant.Delete_Contained_Entities;
      Factory.Delete_Participant (L_Participant);
      --  %%coreProduct%% provides finalize_instance() method for
      --  people who want to release memory used by the participant factory
      --  singleton. Uncomment the following block of code for clean destruction of
      --  the participant factory singleton.

      --  Factory.finalize_instance;

   end Publisher_Shutdown;



   procedure Publisher_Main (DomainId     : Standard.DDS.DomainId_T;
                            Sample_Count : Integer) is

      Factory           :  Standard.DDS.DomainParticipantFactory.Ref_Access;
      Participant       :  Standard.DDS.DomainParticipant.Ref_Access;
      Publisher         :  Standard.DDS.Publisher.Ref_Access;
      Topic             :  Standard.DDS.Topic.Ref_Access;

      %%nativeType%%_Writer : %%nativeType%%_DataWriter.Ref_Access;

      Instance          : %%nativeType%%_Access;
      Instance_Handle   : aliased Standard.DDS.InstanceHandle_T := Standard.DDS.HANDLE_NIL;
      Type_Name         : Standard.DDS.String;

      Send_Period       : constant Duration  := 0.5;


      Topic_Name : constant Standard.DDS.String := Standard.DDS.To_DDS_String ("Example %%nativeType%%");
   begin

      Factory := Standard.DDS.DomainParticipantFactory.Get_Instance;
      --  To customize participant QoS, use
      --  Factory.get_default_participant_qos instead
      Put ("Create_Participant:");
      Participant := Factory.Create_Participant
        (DomainId,
         Standard.DDS.DomainParticipantFactory.PARTICIPANT_QOS_DEFAULT,
         null,
         Standard.DDS.STATUS_MASK_NONE);

      --  To customize publisher QoS, use
      --  Standard.DDS.DomainParticipant.get_default_publisher_qos instead


      Put ("Create_Publisher:");
      Publisher := Participant.Create_Publisher
        (Standard.DDS.DomainParticipant.PUBLISHER_QOS_DEFAULT,
         null,
         Standard.DDS.STATUS_MASK_NONE);



      --  Register type before creating topic
      Type_Name.data := %%nativeType%%_TypeSupport.Get_Type_Name.data;
      Put ("Register_Type:");
      %%nativeType%%_TypeSupport.Register_Type (Participant, Type_Name);

      --  To customize topic QoS, use
      --  Standard.DDS.DomainParticipant.get_default_topic_qos instead
      Put ("Create_Topic:");
      Topic := Participant.Create_Topic
        (TOPIC_NAME,
         Type_Name,
         Standard.DDS.DomainParticipant.TOPIC_QOS_DEFAULT,
         null,
         Standard.DDS.STATUS_MASK_NONE);


      --  To customize data writer QoS, use
      --  Standard.DDS.Publisher.get_default_datawriter_qos instead.
      Put ("Create_DataWriter:");
      %%nativeType%%_Writer := %%nativeType%%_DataWriter.Ref_Access
        (Publisher.Create_DataWriter (Topic,
         Standard.DDS.Publisher.DATAWRITER_QOS_DEFAULT,
         null,
         Standard.DDS.STATUS_MASK_NONE));

      Instance := %%nativeType%%_TypeSupport.Create_Data (TRUE);

      --  For data type that has key, if the same instance is going to be
      --  written multiple times, initialize the key here
      --  and register the keyed instance prior to writing
      Instance_Handle := %%nativeType%%_Writer.Register_Instance (Instance);

      --  Main loop
      for Count in 0 .. Sample_Count loop

         Put_Line ("Writing %%nativeType%%, count " &  Count'Img);
         pragma Compile_Time_Warning (True, "Complete update of message.");
--           declare
--              Msg : Standard.DDS.String := Standard.DDS.To_DDS_String
--                ("Hello World! (" & Count'Img & ")");
--           begin
--              if Instance.message /= Standard.DDS.NULL_STRING then
--                 Finalize (Instance.message);
--              end if;
--
--              Instance.message.data := Msg.data;
--           end;
         %%nativeType%%_Writer.Write (Instance_Data => Instance,
                                   Handle        => Instance_Handle'Unchecked_Access);

         delay Send_Period;
      end loop;

--        if Instance.message /= Standard.DDS.NULL_STRING then
--           Finalize (Instance.message);
--        end if;

      %%nativeType%%_Writer.Unregister_Instance   (Instance, Instance_Handle);

      --   Delete data sample
      %%nativeType%%_TypeSupport.Delete_Data (Instance, True);

      Publisher_Shutdown (Participant);


   end Publisher_Main;


begin
   Put_Line ("-----------------------------------------------------");
   New_Line (4);
   declare
      DomainId     : Standard.DDS.DomainId_T := 0;
      Sample_Count : Integer := Integer'Last; -- almost infinite
   begin

      if Argument_Count >= 1 then
         begin
            DomainId := Standard.DDS.DomainId_T'Value (Argument (1));
         exception
            when others => null;
         end;
      end if;

      if Argument_Count >= 2 then
         begin
            Sample_Count := Integer'Value (Argument (2));
         exception
            when others => null;
         end;
      end if;

      --   Uncomment this to turn on additional logging
      --  Standard.NDDS.Config.Logger.Get_Instance.Set_Verbosity_By_Category
      --    (Standard.NDDS.CONFIG.API,
      --     Standard.NDDS.CONFIG.LOG_VERBOSITY_ALL);

      Publisher_Main (DomainId, Sample_Count);
   end;
exception
   when E : others =>
      Put_Line (Ada.Exceptions.Exception_Information (E));
      Put_Line (GNAT.Traceback.Symbolic.Symbolic_Traceback (E));
end %%fullQualifiednativeType%%_Publisher;
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
