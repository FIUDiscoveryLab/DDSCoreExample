<?xml version="1.0"?>

<!-- 
/* $Id: typeSubscriber.adb.xsl,v 1.5 2012/04/23 16:44:18 fernando Exp $
 
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
                <xsl:with-param name="typeName" select="concat(@name,'_subscriber')"/>
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
with Ada.Command_Line; use Ada.Command_line;
with Ada.Exceptions;
with Ada.Text_IO; use Ada.Text_IO;

with DDS.DataReader;
with DDS.DomainParticipant;
with DDS.DomainParticipantFactory;
with DDS.Subscriber;
with DDS.Topic;

with GNAT.Traceback.Symbolic;
--  ===========================================================================


with %%fullQualifiednativeType%%_SubscriberListener;
with %%fullQualifiednativeType%%_TypeSupport;

procedure  %%fullQualifiednativeType%%_Subscriber is
   use Standard.DDS;

   procedure Subscriber_Shutdown
     (Participant : in out Standard.DDS.DomainParticipant.Ref_Access);

   procedure Main (Domain_Id : Standard.DDS.DomainId_T; Num_Loops : Integer);

   procedure Subscriber_Shutdown
     (Participant : in out Standard.DDS.DomainParticipant.Ref_Access) is
      Factory : constant Standard.DDS.DomainParticipantFactory.Ref_Access :=
         Standard.DDS.DomainParticipantFactory.Get_Instance;
   begin

      Participant.Delete_Contained_Entities;
      Factory.Delete_Participant (Participant);

      --  %%coreProduct%% provides finalize_instance() method for
      --  people who want to release memory used by the participant factory
      --  singleton. Uncomment the following block of code for clean destruction of
      --  the participant factory singleton.
      --  Factory.Finalize_Instance;

   end Subscriber_Shutdown;

   procedure Main (Domain_Id : Standard.DDS.DomainId_T; Num_Loops : Integer) is
      Factory           : Standard.DDS.DomainParticipantFactory.Ref_Access;
      Participant       : Standard.DDS.DomainParticipant.Ref_Access;
      Subscriber        : Standard.DDS.Subscriber.Ref_Access;
      Topic             : Standard.DDS.Topic.Ref_Access;
      Reader            : Standard.DDS.DataReader.Ref_Access;
      Reader_Listener   : aliased %%nativeType%%_SubscriberListener.My_Listener;
      Type_Name         : Standard.DDS.String;
      Poll_Period       : constant Duration := 4.0;

   begin

      Factory := Standard.DDS.DomainParticipantFactory.Get_Instance;
      --  To customize participant QoS, use
      --  Factory.get_default_participant_qos
      Put_Line ("Create_Participant:");
      Participant := Factory.Create_Participant
        (Domain_Id,
         Standard.DDS.DomainParticipantFactory.PARTICIPANT_QOS_DEFAULT,
         null,
         Standard.DDS.STATUS_MASK_NONE);


      --  To customize subscriber QoS, use
      --  Standard.DDS.DomainParticipant.get_default_subscriber_qos

      Put_Line ("Create_Subscriber:");
      Subscriber := Participant.Create_Subscriber
        (Standard.DDS.DomainParticipant.SUBSCRIBER_QOS_DEFAULT,
         null,
         Standard.DDS.STATUS_MASK_NONE);

      --  Register type before creating topic
      Type_Name.data := %%nativeType%%_TypeSupport.Get_Type_Name.data;
      Put_Line ("Register_Type:");
      %%nativeType%%_TypeSupport.Register_Type (Participant, Type_Name);

      --  To customize topic QoS, use
      --  Standard.DDS.DomainParticipant.get_default_topic_qos
      Put_Line ("Create_Topic:");
      Topic := Participant.Create_Topic
        (Standard.DDS.To_DDS_String ("Example %%nativeType%%"),
         Type_Name,
         Standard.DDS.DomainParticipant.TOPIC_QOS_DEFAULT,
         null,
         Standard.DDS.STATUS_MASK_NONE);

      --  To customize data reader QoS, use
      --  DDS_Subscriber_get_default_datareader_qos()
      Put ("Create_DataReader:");
      Reader := Subscriber.Create_DataReader
        (Topic.As_TopicDescription,
         Standard.DDS.Subscriber.DATAREADER_QOS_DEFAULT,
         Reader_Listener'Unchecked_Access,
         Standard.DDS.STATUS_MASK_ALL);


      --  Main loop
      for I in 0 .. Num_Loops loop
         Put_Line ("%%nativeType%% subscriber sleeping " & Poll_Period'Img & " sec.");
         delay Poll_Period;
      end loop;
      --  Cleanup and delete delete all entities
      Subscriber_Shutdown (Participant);
   exception
      when others =>
         --  Cleanup and delete delete all entities
         Subscriber_Shutdown (Participant);
         raise;
   end Main;

begin
   declare
      Num_Loops    : Integer := 1000;
      Domain_Id    : Standard.DDS.DomainId_T := 0;
   begin
      if Argument_Count >= 1 then
         begin
            Domain_Id := Standard.DDS.DomainId_T'Value (Argument (1));
         exception
            when others => null;
         end;
      end if;

      if Argument_Count >= 2 then
         begin
            Num_Loops := Integer'Value (Argument (2));
         exception
            when others => null;
         end;
      end if;

      Main (Domain_Id, Num_Loops);
   end;
exception
   when E : others =>
      Put_Line (Ada.Exceptions.Exception_Information (E));
      Put_Line (GNAT.Traceback.Symbolic.Symbolic_Traceback (E));
end %%fullQualifiednativeType%%_Subscriber;
]]>&nl;</xsl:text>
                </xsl:with-param>
            </xsl:call-template>
        </file>

        <xsl:variable name="listenerAdbFile">
            <xsl:call-template name="obtainSourceFileName">
                <xsl:with-param name="directory"
                                select="'./samples'"/>
                <xsl:with-param name="containerNamespace"
                                select="$newContainerNamespace"/>
                <xsl:with-param name="typeName" select="concat(@name,'_subscriberlistener')"/>
                <xsl:with-param name="fileExt" select="'adb'"/>
            </xsl:call-template>
        </xsl:variable>

        <file name="{$listenerAdbFile}">
            <xsl:call-template name="replace-string-from-map">
                <xsl:with-param name="search" select="'%%nativeType%%'"/>
                <xsl:with-param name="replacementParamsMap" select="xalan:nodeset($replacementMap)/node()"/>
                <xsl:with-param name="inputString">
<xsl:text><![CDATA[
with %%typePackageName%%; use %%typePackageName%%;
with %%fullQualifiednativeType%%_DataReader;
with %%fullQualifiednativeType%%_TypeSupport;

package body %%fullQualifiednativeType%%_SubscriberListener is
   use Standard.DDS;
   -----------------------
   -- On_Data_Available --
   -----------------------

   procedure On_Data_Available
     (Self       : not null access My_Listener;
      The_Reader : in out Standard.DDS.DataReader.Ref'Class) is
      pragma Unreferenced (Self);

      Reader   : %%fullQualifiednativeType%%_DataReader.Ref_Access;
      Data_Seq : aliased %%nativeType%%_Seq.Sequence;
      Info_Seq : aliased Standard.DDS.SampleInfo_Seq.Sequence;

   begin

      Reader :=  %%nativeType%%_DataReader.Ref (The_Reader)'Access;

      begin
         Reader.Take (Data_Seq'Access,
                      Info_Seq'Access,
                      Standard.DDS.LENGTH_UNLIMITED,
                      Standard.DDS.ANY_SAMPLE_STATE,
                      Standard.DDS.ANY_VIEW_STATE,
                      Standard.DDS.ANY_INSTANCE_STATE);
      exception
         when Standard.DDS.NO_DATA =>
            return;
      end;

      for I in 1 .. %%nativeType%%_Seq.Get_Length (Data_Seq'Access) loop
         if SampleInfo_Seq.Get_Reference (Info_Seq'Access, Standard.DDS.Natural (I)).Valid_Data then
            --  Ada.Text_IO.Put_Line (Standard.DDS.To_Standard_String (%%nativeType%%_Seq.Get_Reference (Data_Seq'Access, I).msg));
            pragma Compile_Time_Warning (True, "Complete handling of message.");
            %%fullQualifiednativeType%%_TypeSupport.Print_Data (%%nativeType%%_Seq.Get_Reference (Data_Seq'Access, I));
         end if;
      end loop;
      Reader.Return_Loan (Data_Seq'Access, Info_Seq'Access);

   end On_Data_Available;

end %%fullQualifiednativeType%%_SubscriberListener;
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
