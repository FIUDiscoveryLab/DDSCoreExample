<?xml version="1.0"?>
<!-- 
/* $Id: typeDatabasePlugin.h.xsl,v 1.2 2012/04/23 16:44:18 fernando Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
Modification history:
- - - - - - - - - - -
10l,22mar06,fcs Created from the version with the tag BRANCH2_SKYBOARD30D
-->

<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:xalan = "http://xml.apache.org/xalan">

    <!-- ===================================================================== -->
    <!-- Required Database Declarations                                        -->
    <!-- ===================================================================== -->
        
    <!-- 
         The following template generates the declaration for the database 
         functions associated to all the IDL types (typedef,struct,union,
         enum).

         Declared functions:
         - Plugin_getCreateTableFieldDcl
     -->            
        
    <xsl:template name="generateRequiredDatabaseDeclarations">
        <xsl:param name="containerNamespace"/>
        <xsl:param name="typeNode"/>
        <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace,$typeNode/@name)"/>
                        
<xsl:text>extern char * </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/><xsl:text>Plugin_getCreateTableFieldDcl(
    DDSQL_DatabaseConnectionKind connection_kind,
    char * name_prefix,int max_name_prefix_length,
    char * sql,int max_sql_length,
    DDS_Boolean allow_null);
                                   
</xsl:text>
            
<xsl:text>char * </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/>
<xsl:text>Plugin_get_insert_field_names(
    char * name_prefix,int max_name_prefix_length,
    char * sql,int max_sql_length);            

</xsl:text> 
            
<xsl:text>char * </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/><xsl:text>Plugin_getInsertParameters(
</xsl:text>
<xsl:text>    </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/><xsl:text> * sample,
    char * sql,int max_sql_length);
            
</xsl:text> 
                                    
<xsl:text>char * </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/><xsl:text>Plugin_getUpdateFieldNames(
</xsl:text>
<xsl:text>    </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/><xsl:text> * sample,            
    char * name_prefix,int max_name_prefix_length,
    char * sql,int max_sql_length,
    DDSQL_FieldsMask fields_mask);
            
</xsl:text>             
            
<xsl:text>DDS_Long </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/><xsl:text>Plugin_bindParameters(
    SQLHSTMT hStmt,int index,</xsl:text>
    <xsl:value-of select="$fullyQualifiedStructName"/>
    <xsl:text> * sample,DDSQL_FieldsMask fields_mask,DDS_Boolean assign_null);
                        
</xsl:text> 
                                                            
    </xsl:template>
                                
    <!-- ===================================================================== -->
    <!-- Top Level Database Declarations                                       -->
    <!-- ===================================================================== -->

    <!-- 
         The following template generates the declaration for the database functions            
         associated to the top-levels types (types that can be associated to an DDS 
         topic).
         
         Declared functions:
         - Plugin_connectToDatabase
         - Plugin_disconnectFromDatabase
         - Plugin_createTable
         - Plugin_setReaderDBQos
         - Plugin_setWriterDBQos
         - Plugin_updateDatabase                     
     -->            

    <xsl:template name="generateTopLevelDatabaseDeclarations">
        <xsl:param name="containerNamespace"/>
        <xsl:param name="typeNode"/>
        <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace,$typeNode/@name)"/>

<xsl:text>extern DDSQL_ReturnCode_t </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/>
<xsl:text>Plugin_create_database_table(DDSQL_DatabaseConnection * connection,DDSQL_SQLHelper * sql_helper);
            
</xsl:text>            

<xsl:text>extern DDSQL_ReturnCode_t </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/>
<xsl:text>Plugin_store_sample_in_database_w_history(
    DDS_DomainId_t domainId,DDSQL_DatabaseConnection * connection,</xsl:text>
    <xsl:value-of select="$fullyQualifiedStructName"/><xsl:text> *sample);
            
</xsl:text>            
            
<xsl:text>extern DDSQL_ReturnCode_t </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/><xsl:text>Plugin_store_sample_in_database(
    DDS_DomainId_t domainId,DDSQL_DatabaseConnection * connection,</xsl:text>
    <xsl:value-of select="$fullyQualifiedStructName"/><xsl:text> *sample);
            
</xsl:text>            
                            
    </xsl:template>
                    
</xsl:stylesheet>
