<?xml version="1.0"?>
<!-- 
/* $Id: typeDatabasePlugin.c.xsl,v 1.2 2012/04/23 16:44:18 fernando Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
Modification history:
- - - - - - - - - - -
10l,16aug96,kaj 64 bit: change parameters from long to DDS_Long for API
10l,23jul06,fcs JDK 1.5 support
10l,25apr06,fcs Fixed bug 11009
10l,31mar06,fcs Fixed single character binding bug
10l,31mar06,fcs Fixed problem in the store_history call
10l,30mar06,fcs Improved generated code efficiency
10l,22mar06,fcs Created from the version with the tag BRANCH2_SKYBOARD30D
-->

<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;"> <!-- New line -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:xalan = "http://xml.apache.org/xalan">

    <!-- ===================================================================== -->
    <!-- Required Database Code Generator                                      -->
    <!-- ===================================================================== -->
        
    <!-- 
         The following template generates the database code common to all the IDL
         types (top-level or not).
            
         The code generated include the following functions:
         - Plugin_get_create_table_field_dcl 
     -->            
        
    <xsl:template name="generateRequiredDatabaseCode">
        <xsl:param name="containerNamespace"/>
        <xsl:param name="typeNode"/>
        <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace,$typeNode/@name)"/>
                        
<xsl:text><![CDATA[
/* ------------------------------------------------------------------------
 * Required Database Methods
 * ------------------------------------------------------------------------ */
                
]]></xsl:text>
                        
<!-- 
================================================================================
Plugin_get_create_table_field_dcl 
================================================================================
-->

<xsl:text><![CDATA[            
/**
 * @brief The following function stores in 'sql' the fields delaration that
 *        will be included in the CREATE TABLE SQL statement for the IDL
 *        type.
 * 
 * @param name_prefix Prefix that will be added to the column names.
 * @param max_name_prefix_length Number of characters that can be written into the prefix
 *        string without including the NULL terminated character.
 * @param sql Pointer to the next available character in the sql string.
 * @param max_sql_length Number of characters that can be written into the sql string
 *        without including the NULL terminated character.                                      
 * @param allow_null Indicates if the fields can contain null. This behaviour is
 *        overwritten for sequences that always allow null value in their elements.
 *
 * @return Pointer to the next available character in the sql string. If there 
 *         is some error the function returns NULL.
 */

]]></xsl:text>                        
       
<xsl:text>char * </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/><xsl:text>Plugin_get_create_table_field_dcl(
    DDSQL_DatabaseConnectionKind connection_kind,
    char * name_prefix,int max_name_prefix_length,
    char * sql,int max_sql_length,
    DDS_Boolean allow_null)
{</xsl:text>
    <xsl:choose>
        <xsl:when test="name($typeNode) = 'enum'">                
<xsl:text><![CDATA[
    int nchar = -1;
    char delimiter[] ="";
    char nullString[] = "NOT NULL";

    if (allow_null) {
        strcpy(nullString,"NULL");
    }

]]></xsl:text>                                        
            <xsl:call-template name="declareField">
                <xsl:with-param name="indent" select="'    '"/>
                <xsl:with-param name="member" select="$typeNode"/>
            </xsl:call-template>                
        </xsl:when>
        <xsl:otherwise>
<xsl:text><![CDATA[
    int nchar;
    char sqlWChar[10];
    char sqlChar[10] = "CHAR";
    char sqlWString[10];
    char sqlString[10] = "VARCHAR";
    char sqlWCharAttribute[30],sqlCharAttribute[30];
    char * sqlNew;
    char * namePrefixEndPtr;    
    char nullString[] = "NOT NULL";
]]></xsl:text>                        
            <xsl:if test="name($typeNode) = 'typedef'">
<xsl:text><![CDATA[
    char delimiter[1];
    delimiter[0] = '\0';
    
    if (allow_null) {
        strcpy(nullString,"NULL");
    }
]]></xsl:text>                                                  
            </xsl:if>                                 
            <xsl:if test="name($typeNode) != 'typedef'">
<xsl:text><![CDATA[
    char delimiter[2];    
    strcpy(delimiter,".");

    if (!strcmp(name_prefix,"")) {
        strcpy(delimiter,"");
    }

    if (allow_null) {
        strcpy(nullString,"NULL");
    }
]]></xsl:text>                    
            </xsl:if>
<xsl:text><![CDATA[
    nchar = -1;
    sqlNew = NULL;
    namePrefixEndPtr = name_prefix + strlen(name_prefix);

    /* To avoid C++ warnings */
    sqlChar[0]=sqlChar[0]; /* To avoid C++ warnings */
    sqlString[0] = sqlString[0]; /* To avoid C++ warnings */
    
    if (connection_kind == DDSQL_MYSQL_CONNECTION) {
        strcpy(sqlWChar,"CHAR");
        strcpy(sqlWString,"VARCHAR");
        strcpy(sqlWCharAttribute,"CHARACTER SET ucs2");
        strcpy(sqlCharAttribute,"CHARACTER SET latin1");
    } else {
        strcpy(sqlWChar,"NCHAR");
        strcpy(sqlWString,"NVARCHAR");
        strcpy(sqlWCharAttribute,"");
        strcpy(sqlCharAttribute,"");
    }

]]></xsl:text>
            <xsl:if test="$typeNode/@kind = 'union'">
                <xsl:if test="./discriminator/@name and ./discriminator/@name != ''">
                    <xsl:text>    /* discriminator */&nl;</xsl:text>                        
                </xsl:if>                    
                <xsl:call-template name="declareField">
                    <xsl:with-param name="indent" select="'    '"/>
                    <xsl:with-param name="member" select="$typeNode/discriminator"/>
                </xsl:call-template>                    
                <xsl:text>    allow_null=DDS_BOOLEAN_TRUE;&nl;</xsl:text>                    
                <xsl:text>    strcpy(nullString,"NULL");&nl;</xsl:text>
            </xsl:if>
                                                                
            <xsl:for-each select="$typeNode/member">
                <xsl:if test="./@name and ./@name != ''">
                    <xsl:text>    /* </xsl:text><xsl:value-of select="./@name"/>                    
                    <xsl:text> */&nl;</xsl:text>                        
                </xsl:if>
                
                <xsl:variable name="caseStr"> 
                    <xsl:call-template name="generateCaseStr">
                        <xsl:with-param name="member" select="."/>
                    </xsl:call-template>
                </xsl:variable>                        
                    
                <xsl:variable name="caseVar"> 
                    <xsl:call-template name="generateCaseVar">
                        <xsl:with-param name="member" select="."/>
                    </xsl:call-template>
                </xsl:variable>                        
                                        
                <xsl:call-template name="declareField">
                    <xsl:with-param name="indent" select="'    '"/>
                    <xsl:with-param name="member" select="."/>
                    <xsl:with-param name="caseStr" select="$caseStr"/>
                    <xsl:with-param name="caseVar" select="$caseVar"/>                        
                </xsl:call-template>
            </xsl:for-each>                        
        </xsl:otherwise>            
    </xsl:choose>
<xsl:text><![CDATA[    return sql;            
}

]]></xsl:text>
            
<!-- 
================================================================================
Plugin_get_insert_field_names
================================================================================
-->

<xsl:text><![CDATA[
/**
 * @brief Stores in 'sql' the name of the fields associated to the IDL type. 
 *
 * These names are separated with comma and they will be used in the insert SQL 
 * statement.
 *
 * @param name_prefix Prefix that will be added to a field names.
 * @param max_name_prefix_length Number of characters that can be written into the 
 *        prefix string without including the NULL terminated character.
 * @param sql Pointer to the next available character in the sql string.
 * @param max_sql_length Number of characters that can be written into the sql string
 *        without including the NULL terminated character.                                      
 *
 * @return Pointer to the next available character in the sql string (NULL char).
 *         If there is some error the function returns NULL.
 *
 */

]]></xsl:text>
                   
<xsl:text>char * </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/><xsl:text>Plugin_get_insert_field_names(
    char * name_prefix,int max_name_prefix_length,char * sql,int max_sql_length)
{</xsl:text>
    <xsl:choose>            
        <xsl:when test="name($typeNode) = 'enum'">                
<xsl:text><![CDATA[
    int nchar;
    char delimiter[] ="";

    nchar = -1;
]]></xsl:text>                                                    
            <xsl:call-template name="getFieldNames">                
                <xsl:with-param name="indent" select="'    '"/>
                <xsl:with-param name="member" select="$typeNode"/>
                <xsl:with-param name="separator" select="','"/>
                <xsl:with-param name="function" select="'Plugin_get_insert_field_names'"/>
            </xsl:call-template>                
        </xsl:when>
        <xsl:otherwise>                
<xsl:text><![CDATA[
    int nchar;
    char * sqlNew;
    char * namePrefixEndPtr;
]]></xsl:text>                                    
            <xsl:if test="name($typeNode) = 'typedef'">
<xsl:text><![CDATA[
    char delimiter[1];
    delimiter[0] = '\0';

]]></xsl:text>                                                  
            </xsl:if>                                 
            <xsl:if test="name($typeNode) != 'typedef'">
<xsl:text><![CDATA[
    char delimiter[2];
    strcpy(delimiter,".");

    if (!strcmp(name_prefix,"")) {
        strcpy(delimiter,"");
    }

]]></xsl:text>                    
            </xsl:if>
<xsl:text><![CDATA[
    nchar = -1;
    sqlNew = NULL;
    namePrefixEndPtr = name_prefix + strlen(name_prefix);                
]]></xsl:text>                    
                
            <xsl:if test="$typeNode/@kind = 'union'">
                <xsl:if test="./discriminator/@name and ./discriminator/@name != ''">
                    <xsl:text>    /* discriminator */&nl;</xsl:text>                        
                </xsl:if>                    
                <xsl:call-template name="getFieldNames">
                    <xsl:with-param name="indent" select="'    '"/>
                    <xsl:with-param name="member" select="$typeNode/discriminator"/>
                    <xsl:with-param name="separator" select="','"/>
                    <xsl:with-param name="function" select="'Plugin_get_insert_field_names'"/>                        
                </xsl:call-template>                    
            </xsl:if>
                
            <xsl:for-each select="$typeNode/member">
                <xsl:if test="./@name and ./@name != ''">
                    <xsl:text>    /* </xsl:text><xsl:value-of select="./@name"/>                    
                    <xsl:text> */&nl;</xsl:text>                        
                </xsl:if>                    
                    
                <xsl:variable name="caseStr"> 
                    <xsl:call-template name="generateCaseStr">
                        <xsl:with-param name="member" select="."/>
                    </xsl:call-template>
                </xsl:variable>                        
                    
                <xsl:variable name="caseVar"> 
                    <xsl:call-template name="generateCaseVar">
                        <xsl:with-param name="member" select="."/>
                    </xsl:call-template>
                </xsl:variable>                        
                    
                <xsl:call-template name="getFieldNames">                
                    <xsl:with-param name="indent" select="'    '"/>
                    <xsl:with-param name="member" select="."/>
                    <xsl:with-param name="separator" select="','"/>
                    <xsl:with-param name="function" select="'Plugin_get_insert_field_names'"/>
                    <xsl:with-param name="caseStr" select="$caseStr"/>
                    <xsl:with-param name="caseVar" select="$caseVar"/>                        
                </xsl:call-template>
            </xsl:for-each>                        
        </xsl:otherwise>
    </xsl:choose>                        
<xsl:text><![CDATA[    return sql;            
}

]]></xsl:text>

<!-- 
================================================================================
Plugin_get_insert_parameters
================================================================================
-->

<xsl:text><![CDATA[
/**
 * @brief Stores in 'sql' a list of '?' symbols where each symbol represents
 *        a SQL parameter.
 *
 * @param sql Pointer to the next available character in the sql string.
 * @param max_sql_length Number of characters that can be written into the sql 
 *        string without including NULL terminated character.
 *
 * @return Pointer to the next available character in the sql string (NULL char).
 *         If there is some error the function returns NULL.
 */

]]></xsl:text>
                                           
<xsl:text>char * </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/><xsl:text>Plugin_get_insert_parameters(</xsl:text>
<xsl:value-of select="$fullyQualifiedStructName"/><xsl:text> * sample,char * sql,int max_sql_length)
{</xsl:text>
    <xsl:choose>                        
        <xsl:when test="name($typeNode) = 'enum'">                
<xsl:text><![CDATA[
    int nchar = -1;

]]></xsl:text>                                                    
            <xsl:call-template name="getFieldNames">                
                <xsl:with-param name="indent" select="'    '"/>
                <xsl:with-param name="member" select="$typeNode"/>
                <xsl:with-param name="parameters" select="1"/>                
                <xsl:with-param name="separator" select="'?,'"/>
                <xsl:with-param name="function" select="'Plugin_get_insert_parameters'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>                
<xsl:text><![CDATA[
    int nchar;
    char * sqlNew;

    nchar = -1;
    sqlNew = NULL;
]]></xsl:text>                                    
            <xsl:if test="$typeNode/@kind = 'union'">
                <xsl:if test="./discriminator/@name and ./discriminator/@name != ''">
                    <xsl:text>    /* discriminator */&nl;</xsl:text>                        
                </xsl:if>                    
                <xsl:call-template name="getFieldNames">
                    <xsl:with-param name="indent" select="'    '"/>
                    <xsl:with-param name="member" select="$typeNode/discriminator"/>
                    <xsl:with-param name="parameters" select="1"/>                                        
                    <xsl:with-param name="separator" select="'?,'"/>
                    <xsl:with-param name="function" select="'Plugin_get_insert_parameters'"/>
                </xsl:call-template>                    
            </xsl:if>
                
            <xsl:for-each select="$typeNode/member">
                <xsl:if test="./@name and ./@name != ''">
                    <xsl:text>    /* </xsl:text><xsl:value-of select="./@name"/>                    
                    <xsl:text> */&nl;</xsl:text>                        
                </xsl:if>
                    
                <xsl:variable name="caseStr"> 
                    <xsl:call-template name="generateCaseStr">
                        <xsl:with-param name="member" select="."/>
                    </xsl:call-template>
                </xsl:variable>                        
                    
                <xsl:variable name="caseVar"> 
                    <xsl:call-template name="generateCaseVar">
                        <xsl:with-param name="member" select="."/>
                    </xsl:call-template>
                </xsl:variable>                        
                    
                <xsl:call-template name="getFieldNames">                
                    <xsl:with-param name="indent" select="'    '"/>
                    <xsl:with-param name="member" select="."/>
                    <xsl:with-param name="parameters" select="1"/>                
                    <xsl:with-param name="separator" select="'?,'"/>
                    <xsl:with-param name="function" select="'Plugin_get_insert_parameters'"/>
                    <xsl:with-param name="caseStr" select="$caseStr"/>
                    <xsl:with-param name="caseVar" select="$caseVar"/>                                                
                </xsl:call-template>
            </xsl:for-each>                        
        </xsl:otherwise>
    </xsl:choose>
<xsl:text><![CDATA[    return sql;            
}

]]></xsl:text>
            
            
<!-- 
================================================================================
Plugin_get_update_field_names
================================================================================
-->

            
<xsl:text><![CDATA[
/**
 * @brief Stores in 'sql' the name of the fields associated to the IDL type 
 *        with the following format:
 *        <field name 1>=?,<field name 2>=?,...
 *
 * @param name_prefix Prefix that will be added to a field name.
 * @param max_name_prefix_length Number of characters that can be written into the 
 *        prefix string without including the NULL terminated character.
 * @param sql Pointer to the next available character in the sql string.
 * @param max_sql_length Number of characters that can be written into the sql 
 *        string without including NULL terminated character.                                      
 * @param fields_mask Mask to select the input set of fields.
 *
 * @return Pointer to the next available character in the sql string (NULL char).
 *         If there is some error the function returns NULL.
 */

]]></xsl:text>
                   
<xsl:text>char * </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/><xsl:text>Plugin_get_update_field_names(</xsl:text>
<xsl:value-of select="$fullyQualifiedStructName"/><xsl:text> * sample,
    char * name_prefix,int max_name_prefix_length,char * sql,int max_sql_length,DDSQL_FieldsMask fields_mask)
{&nl;</xsl:text>            
            
    <xsl:if test="name($typeNode) = 'enum'">
<xsl:text><![CDATA[
    int nchar;
    char delimiter[] ="";

    nchar = -1;
]]></xsl:text>                                                    
        <xsl:call-template name="getFieldNames">
            <xsl:with-param name="indent" select="'    '"/>
            <xsl:with-param name="member" select="$typeNode"/>
            <xsl:with-param name="separator" select="'=?,'"/>
            <xsl:with-param name="function" select="'Plugin_get_update_field_names'"/>                
        </xsl:call-template>            
    </xsl:if>
            
    <xsl:if test="name($typeNode) != 'enum'">
            
        <xsl:for-each select="$typeNode/member">
            <xsl:variable name="isKey">
                <xsl:call-template name="isKey">
                    <xsl:with-param name="member" select="."/>        
                </xsl:call-template>
            </xsl:variable>
            <xsl:if test="position() = 1">
<xsl:text><![CDATA[
    int nchar;
    char * sqlNew;
    char * namePrefixEndPtr;
]]></xsl:text>                                    
                <xsl:if test="name($typeNode) = 'typedef'">
<xsl:text><![CDATA[
    char delimiter[1];    
    delimiter[0] = '\0';
]]></xsl:text>                                                  
                </xsl:if>                                 
                <xsl:if test="name($typeNode) != 'typedef'">
<xsl:text><![CDATA[
    char delimiter[2];
    strcpy(delimiter,".");

    if (!strcmp(name_prefix,"")) {
        strcpy(delimiter,"");
    }

]]></xsl:text>                    
                </xsl:if>
<xsl:text><![CDATA[
    nchar = -1;
    sqlNew = NULL;
    namePrefixEndPtr = name_prefix + strlen(name_prefix);
]]></xsl:text>                    
                                        
                <xsl:if test="$typeNode/@kind = 'union'">
                    <xsl:if test="./discriminator/@name and ./discriminator/@name != ''">
                        <xsl:text>    /* discriminator */&nl;</xsl:text>                        
                    </xsl:if>                    
                    <xsl:call-template name="getFieldNames">
                        <xsl:with-param name="indent" select="'    '"/>
                        <xsl:with-param name="member" select="$typeNode/discriminator"/>
                        <xsl:with-param name="isKey" select="0"/>                            
                        <xsl:with-param name="separator" select="'=?,'"/>
                        <xsl:with-param name="function" select="'Plugin_get_update_field_names'"/>                
                    </xsl:call-template>                    
                </xsl:if>
                    
            </xsl:if>
                
            <xsl:variable name="caseStr"> 
                <xsl:call-template name="generateCaseStr">
                    <xsl:with-param name="member" select="."/>
                </xsl:call-template>
            </xsl:variable>                        
                    
            <xsl:variable name="caseVar"> 
                <xsl:call-template name="generateCaseVar">
                    <xsl:with-param name="member" select="."/>
                </xsl:call-template>
            </xsl:variable>                        
                
            <xsl:if test="./@name and ./@name != ''">
                <xsl:text>    /* </xsl:text><xsl:value-of select="./@name"/>                    
                <xsl:text> */&nl;</xsl:text>                        
            </xsl:if>                                    
            <xsl:call-template name="getFieldNames">
                <xsl:with-param name="indent" select="'    '"/>
                <xsl:with-param name="member" select="."/>
                <xsl:with-param name="isKey" select="$isKey"/>                
                <xsl:with-param name="separator" select="'=?,'"/>
                <xsl:with-param name="function" select="'Plugin_get_update_field_names'"/>                
                <xsl:with-param name="caseStr" select="$caseStr"/>
                <xsl:with-param name="caseVar" select="$caseVar"/>                    
            </xsl:call-template>
        </xsl:for-each>        
    </xsl:if>            
            
<xsl:text><![CDATA[    return sql;            
}

]]></xsl:text>
                        
<!-- 
================================================================================
Plugin_bind_parameters
================================================================================
-->

<xsl:text><![CDATA[
/**
 * @brief Binds the sample fields to the parameter markers in an SQL statement.
 *
 * @param hStmt ODBC Statement.
 * @param index Index of the next parameter to bind.
 * @param sample DDS sample.
 * @param fields_mask Bit mask used to indicate the fields we want to bind.
 * @param assign_null Indicates if the database fields will be initialized
 *        with NULL or not.
 *
 * @returns Index for the next parameter if sucess. Otherwise, -1.
 */

]]></xsl:text>
                   
<xsl:text>DDS_Long </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/><xsl:text>Plugin_bind_parameters(
    SQLHSTMT hStmt,int index,</xsl:text><xsl:value-of select="$fullyQualifiedStructName"/>
    <xsl:text> * sample,DDSQL_FieldsMask fields_mask,DDS_Boolean assign_null)
{</xsl:text>
<!-- The name StrLen_or_IndPtr comes from the parameter in the ODBC function SqlBindParameter -->
<xsl:if test="$typeNode/@kind = 'union'">
    <xsl:text>    DDS_Long isDefault = DDS_BOOLEAN_TRUE;&nl;</xsl:text>        
    <xsl:text>    DDS_Long oldAssignNull = assign_null;&nl;</xsl:text>                
</xsl:if>
            
<xsl:text><![CDATA[
    RETCODE returnCode;
    SQLINTEGER * StrLen_or_IndPtr = NULL;
    static SQLINTEGER sqlNullData = SQL_NULL_DATA;

    returnCode = SQL_SUCCESS;

    if (assign_null) {
        StrLen_or_IndPtr = &sqlNullData;   
    }

]]></xsl:text>    

    <xsl:if test="name($typeNode) = 'enum'">
        <xsl:call-template name="bindParameters">
            <xsl:with-param name="indent" select="'    '"/>
            <xsl:with-param name="member" select="$typeNode"/>
        </xsl:call-template>            
    </xsl:if>

    <xsl:if test="name($typeNode) != 'enum'">
            
        <xsl:if test="$typeNode/@kind = 'union'">
            <xsl:if test="./discriminator/@name and ./discriminator/@name != ''">
                <xsl:text>    /* discriminator */&nl;</xsl:text>                        
            </xsl:if>                    
            <xsl:call-template name="bindParameters">
                <xsl:with-param name="indent" select="'    '"/>
                <xsl:with-param name="member" select="$typeNode/discriminator"/>
                <xsl:with-param name="isKey" select="0"/>                            
            </xsl:call-template>
            <xsl:text>    assign_null = DDS_BOOLEAN_TRUE;&nl;</xsl:text>    
            <xsl:text>    StrLen_or_IndPtr = &amp;sqlNullData;&nl;&nl;</xsl:text>
        </xsl:if>
            
        <xsl:for-each select="$typeNode/member">
            <xsl:variable name="isKey">
                <xsl:call-template name="isKey">
                    <xsl:with-param name="member" select="."/>        
                </xsl:call-template>
            </xsl:variable>
                                
            <xsl:if test="./@name and ./@name != ''">
                <xsl:text>    /* </xsl:text><xsl:value-of select="./@name"/>                    
                <xsl:text> */&nl;</xsl:text>                        
            </xsl:if>                                                    
            <xsl:call-template name="bindParameters">
                <xsl:with-param name="indent" select="'    '"/>
                <xsl:with-param name="member" select="."/>
                <xsl:with-param name="isKey" select="$isKey"/>            
            </xsl:call-template>
        </xsl:for-each>
                                    
    </xsl:if>            
<xsl:text><![CDATA[
    return index;            
}

]]></xsl:text>
                                                            
    </xsl:template>
        
    <!-- ===================================================================== -->
    <!-- Top Level Database Code Generator                                     -->
    <!-- ===================================================================== -->

    <!-- 
         The following template generates the database code associated the top level 
         types (DDS topic types).
            
         The code generated include the following functions:
         - Plugin_create_database_table
         - Plugin_store_sample_in_database                    
     -->            

    <xsl:template name="generateTopLevelDatabaseCode">
        <xsl:param name="containerNamespace"/>
        <xsl:param name="typeNode"/>
        <xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace,$typeNode/@name)"/>
        <xsl:variable name="keyFields" select="$typeNode/member
                                                   [following-sibling::node()
                                                       [position() = 1 and name() = 'directive' and @kind = 'key']]"/>

        <xsl:variable name="typeNamespace">
            <xsl:choose>
                <xsl:when test="$language='C++' and $namespace = 'yes'">
                    <xsl:for-each select="$typeNode/ancestor::module">
                        <xsl:value-of select="@name"/>
                        <xsl:text>::</xsl:text>
                    </xsl:for-each>
                </xsl:when>              
                <xsl:otherwise>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
            
<xsl:text><![CDATA[
/* ------------------------------------------------------------------------
 * Top Level Database Methods
 * ------------------------------------------------------------------------ */
                
]]></xsl:text>

<!-- 
================================================================================
Plugin_create_database_table
================================================================================
-->

<xsl:text><![CDATA[
/**
 * @brief Creates the table associated to the database connection if it
 *        doesn't exist.
 *
 * @param connection Database connection (not null).
 * @param sqlHelper Type independent SQL code generator (not null).
 *
 * @return DDS Standard Return Codes or RETCODE_DBMS_ERROR if there is a 
 *         database error.
 */

]]></xsl:text>
                                    
<xsl:text>DDSQL_ReturnCode_t </xsl:text>
<xsl:value-of select="$fullyQualifiedStructName"/>
<xsl:text>Plugin_create_database_table(DDSQL_DatabaseConnection * connection,DDSQL_SQLHelper * sqlHelper)</xsl:text>
<xsl:text><![CDATA[
{
    DDSQL_ReturnCode_t ddsqlReturnCode = DDS_RETCODE_ERROR;
    RETCODE odbcReturnCode;
    struct DDSQL_DatabaseQos * dbQos;
    char sql[DDSQL_SQL_STATEMENT_MAX_LENGTH+1];
    char namePrefix[DDSQL_FIELD_NAME_MAX_LENGTH+1];
    char fieldsDeclaration[DDSQL_SQL_STATEMENT_MAX_LENGTH+1];
    SQLCHAR sqlState[6];
    SDWORD nativeError;
    SWORD length;
    SQLHSTMT hStmt=NULL;
    char historyField[100];
    char historyKey[100];
    int nchar;

    strcpy(connection->errorMessage,"");
    dbQos = &connection->databaseQos;

    odbcReturnCode=SQLAllocStmt(connection->hDbc,&hStmt);
    if (odbcReturnCode != SQL_SUCCESS){        
        goto end;
    }

    if (dbQos->history.history_depth != 0) {
        strcpy(historyField,
               "ndds_history_slot INTEGER NOT NULL, ndds_history_order INTEGER NOT NULL, ");
        strcpy(historyKey,"ndds_history_slot,");
    }else{
        strcpy(historyField,"");
        strcpy(historyKey,"");
    }

    namePrefix[0] = '\0';
    fieldsDeclaration[0] = '\0';

]]></xsl:text>

<xsl:text>    if (!</xsl:text><xsl:value-of select="$typeNamespace"/>
<xsl:value-of select="$fullyQualifiedStructName"/>
<xsl:text>Plugin_get_create_table_field_dcl (connection->connectionKind,namePrefix,DDSQL_FIELD_NAME_MAX_LENGTH,
                                    fieldsDeclaration,DDSQL_SQL_STATEMENT_MAX_LENGTH,DDS_BOOLEAN_FALSE)) {&nl;</xsl:text>
<xsl:text>        strcpy(connection->errorMessage,"SQL statement too long");&nl;</xsl:text>
<xsl:text>        ddsqlReturnCode = DDSQL_RETCODE_DBMS_ERROR;&nl;</xsl:text>            
<xsl:text>        goto end;&nl;</xsl:text>            
<xsl:text>    }&nl;</xsl:text>

<xsl:text><![CDATA[    
    if (connection->connectionKind==DDSQL_MYSQL_CONNECTION) {
]]></xsl:text>
                    
        <xsl:call-template name="getCreateTableSqlStatement">
            <xsl:with-param name="indent" select="'        '"/>
            <xsl:with-param name="typeNode" select="$typeNode"/>
            <xsl:with-param name="dbms" select="'MySQL'"/>
        </xsl:call-template>
                   
<xsl:text>    } else {&nl;</xsl:text>
            
        <xsl:call-template name="getCreateTableSqlStatement">
            <xsl:with-param name="indent" select="'        '"/>
            <xsl:with-param name="typeNode" select="$typeNode"/>
            <xsl:with-param name="dbms" select="'TT'"/>
        </xsl:call-template>
            
<xsl:text>    }&nl;</xsl:text>
            
<xsl:text><![CDATA[
    odbcReturnCode = SQLExecDirect(hStmt,(SQLCHAR *)sql,SQL_NTS);

    if (odbcReturnCode != SQL_SUCCESS) {
        SQLError(connection->hEnv, connection->hDbc,hStmt,sqlState,&nativeError,
                 (SQLCHAR *)connection->errorMessage, sizeof connection->errorMessage, &length);    

        if (connection->connectionKind == DDSQL_TIMESTEN_CONNECTION &&
            nativeError != 2207) { /* Table exists */
            goto end;
        }

        if (connection->connectionKind == DDSQL_MYSQL_CONNECTION) {
            goto end;
        }

        odbcReturnCode = SQL_SUCCESS;
    }
    
    /* ndds_publications table */    
    if (dbQos->table_topic_mapping.publish_table_changes == DDS_BOOLEAN_TRUE) {

        ddsqlReturnCode = DDSQL_SQLHelper_get_ndds_publications_create_table_stmtI(
            sqlHelper,sql,DDSQL_SQL_STATEMENT_MAX_LENGTH + 1);
         
        if (ddsqlReturnCode != DDS_RETCODE_OK) {
            ddsqlReturnCode = DDSQL_RETCODE_DBMS_ERROR;
            strcpy(connection->errorMessage,"SQL statement too long");
            goto end;
        }

        SQLExecDirect(hStmt,(SQLCHAR *)sql,SQL_NTS);                    

        ddsqlReturnCode = DDSQL_SQLHelper_get_ndds_publications_insert_stmtI(
            sqlHelper,sql,DDSQL_SQL_STATEMENT_MAX_LENGTH + 1);
         
        if (ddsqlReturnCode != DDS_RETCODE_OK) {
            ddsqlReturnCode = DDSQL_RETCODE_DBMS_ERROR;
            strcpy(connection->errorMessage,"SQL statement too long");
            goto end;
        }

        SQLExecDirect(hStmt,(SQLCHAR *)sql,SQL_NTS);                                                                                            
    }

    ddsqlReturnCode = DDS_RETCODE_OK;        

    if (connection->txnSupport == SQL_TC_ALL) {
        odbcReturnCode = SQLTransact(connection->hEnv,connection->hDbc,SQL_COMMIT);
    }

end:
    if (odbcReturnCode != SQL_SUCCESS) {
        if (!strcmp(connection->errorMessage,"")) {
            SQLError(connection->hEnv, connection->hDbc,hStmt,sqlState,&nativeError,
                     (SQLCHAR *)connection->errorMessage, sizeof connection->errorMessage, &length);   
        }
        ddsqlReturnCode = DDSQL_RETCODE_DBMS_ERROR;
    }

    if (ddsqlReturnCode != DDS_RETCODE_OK && connection->txnSupport == SQL_TC_ALL) {        
        SQLTransact(connection->hEnv,connection->hDbc,SQL_ROLLBACK);
    } 

    if (hStmt!=NULL){
        SQLFreeStmt(hStmt,SQL_DROP);    
    }

    return ddsqlReturnCode;    
}

]]></xsl:text>

<!-- 
================================================================================
Plugin_store_sample_in_database_w_history
================================================================================
-->

<xsl:text><![CDATA[
/**
 * @brief The following function is used to store the input sample into a
 *        database. It must be used with connections where history storage 
 *        is enabled.
 *
 * @param domainId Domain id associated to the entity that is storing information
 *                 into the database.
 * @param connection Database connection (not null).
 * @param sample Input sample.
 *
 * @return DDS Standard Return Codes, or DDS_RETCODE_PRECONDITION_NOT_MET 
 *         if the connection has history storage enabled, or 
 *         DDSQL_RETCODE_DBMS_ERROR if there is a database error.
 */

]]></xsl:text>
            
<xsl:text>DDSQL_ReturnCode_t </xsl:text>
<xsl:value-of select="$fullyQualifiedStructName"/>
<xsl:text>Plugin_store_sample_in_database_w_history(&nl;</xsl:text>
<xsl:text>    DDS_DomainId_t domainId,DDSQL_DatabaseConnection * connection,</xsl:text>
<xsl:value-of select="$fullyQualifiedStructName"/><xsl:text> *sample)</xsl:text>
<xsl:text><![CDATA[
{
    struct DDSQL_DatabaseQos * dbQos;
    char sql[DDSQL_SQL_STATEMENT_MAX_LENGTH+1];    
    char fieldNames[DDSQL_SQL_STATEMENT_MAX_LENGTH+1];
    char parameters[DDSQL_SQL_STATEMENT_MAX_LENGTH+1];
    char namePrefix[DDSQL_FIELD_NAME_MAX_LENGTH+1];
    RETCODE odbcReturnCode = SQL_SUCCESS;
    DDSQL_ReturnCode_t ddsqlReturnCode = DDS_RETCODE_OK;
    SQLCHAR sqlState[6];
    SDWORD nativeError;
    SWORD length;
    int ndds_remote;
    int index,nchar;
    int historySlot = 0;
    int numberOfSamples = 0;
    SQLINTEGER isNull,isNullNddsRemote;
    long nextOrder,maxNextOrder;
    SQLHSTMT * currentStmtPointer = NULL;

    strcpy(connection->errorMessage,"");
    dbQos = &connection->databaseQos;

    if (dbQos->history.history_depth == 0) {
        ddsqlReturnCode = DDS_RETCODE_PRECONDITION_NOT_MET;
        goto end;
    }

    if (connection->hStmtSelect == NULL) {
        odbcReturnCode=SQLAllocStmt(connection->hDbc,&connection->hStmtSelect);

        if (odbcReturnCode != SQL_SUCCESS){        
            goto end;
        }

        currentStmtPointer = &connection->hStmtSelect;
]]></xsl:text>

        <xsl:call-template name="getRecordExistsSqlStatement">
            <xsl:with-param name="indent" select="'        '"/>
            <xsl:with-param name="typeNode" select="$typeNode"/>
            <xsl:with-param name="history" select="1"/>
        </xsl:call-template>

<xsl:text><![CDATA[
        odbcReturnCode=SQLPrepare(connection->hStmtSelect,(SQLCHAR *)sql,SQL_NTS);
        if (odbcReturnCode != SQL_SUCCESS) {
            goto end;
        }
    } else {
        currentStmtPointer = &connection->hStmtSelect;
    }

]]></xsl:text>
                    
<xsl:text>    if (</xsl:text><xsl:value-of select="$fullyQualifiedStructName"/>
<xsl:text>Plugin_bind_parameters(connection->hStmtSelect,1,sample,DDSQL_KEY_FIELDS,DDS_BOOLEAN_FALSE) == -1) {&nl;</xsl:text>
<xsl:text>        odbcReturnCode = SQL_ERROR;&nl;</xsl:text>                        
<xsl:text>        goto end;&nl;</xsl:text>            
<xsl:text>    }&nl;&nl;</xsl:text>
<xsl:text><![CDATA[                    
    odbcReturnCode = SQLExecute(connection->hStmtSelect);
    if (odbcReturnCode!=SQL_SUCCESS){
        goto end;
    }

    odbcReturnCode = SQLBindCol(connection->hStmtSelect,1,SQL_C_SLONG,&ndds_remote,sizeof(int),&isNullNddsRemote);        

    if (odbcReturnCode != SQL_SUCCESS){        
        goto end;
    }
     
    odbcReturnCode = SQLBindCol(connection->hStmtSelect,2,SQL_C_SLONG,&nextOrder,sizeof(nextOrder),&isNull);

    if (odbcReturnCode != SQL_SUCCESS){        
        goto end;
    }

    odbcReturnCode = SQLBindCol(connection->hStmtSelect,3,SQL_C_SLONG,&historySlot,sizeof(historySlot),&isNull);

    if (odbcReturnCode != SQL_SUCCESS){        
        goto end;
    }

    odbcReturnCode=SQLFetch(connection->hStmtSelect);
           
    while (odbcReturnCode!=SQL_NO_DATA_FOUND) {
        if (odbcReturnCode!=SQL_SUCCESS &&
            odbcReturnCode!=SQL_NO_DATA_FOUND){
            goto end;
        }

        numberOfSamples++;
        
        if (numberOfSamples == 1) {
            maxNextOrder = nextOrder;
        }

        odbcReturnCode=SQLFetch(connection->hStmtSelect);
    }
    
    SQLFreeStmt(connection->hStmtSelect,SQL_CLOSE);
]]></xsl:text>

<xsl:text><![CDATA[                
    namePrefix[0] = '\0';
    fieldNames[0] = '\0';

    if (numberOfSamples == 0) {
        maxNextOrder = 0;
    } else {
        maxNextOrder = maxNextOrder + 1;
    }

    if ((numberOfSamples < dbQos->history.history_depth) || 
        dbQos->history.history_depth == DDSQL_INFINITE_HISTORY) {            

        if (connection->hStmtInsert == NULL) {

            odbcReturnCode=SQLAllocStmt(connection->hDbc,&connection->hStmtInsert);
            if (odbcReturnCode != SQL_SUCCESS){
                goto end;
            }

            currentStmtPointer = &connection->hStmtInsert;
                    
]]></xsl:text>
            
<xsl:text>            if (!</xsl:text><xsl:value-of select="$fullyQualifiedStructName"/>
<xsl:text>Plugin_get_insert_field_names(namePrefix,DDSQL_FIELD_NAME_MAX_LENGTH,
                                     fieldNames,DDSQL_SQL_STATEMENT_MAX_LENGTH)) {&nl;</xsl:text>
<xsl:text>                ddsqlReturnCode = DDSQL_RETCODE_DBMS_ERROR;&nl;</xsl:text>                        
<xsl:text>                strcpy(connection->errorMessage,"SQL statement too long");&nl;</xsl:text>
<xsl:text>                goto end;&nl;</xsl:text>            
<xsl:text>            }&nl;&nl;</xsl:text>
            
<xsl:text>            if (!</xsl:text><xsl:value-of select="$fullyQualifiedStructName"/>
<xsl:text>Plugin_get_insert_parameters(sample,parameters,DDSQL_SQL_STATEMENT_MAX_LENGTH)) {&nl;</xsl:text>
<xsl:text>                ddsqlReturnCode = DDSQL_RETCODE_DBMS_ERROR;&nl;</xsl:text>                        
<xsl:text>                strcpy(connection->errorMessage,"SQL statement too long");&nl;</xsl:text>
<xsl:text>                goto end;&nl;</xsl:text>            
<xsl:text>            }&nl;&nl;</xsl:text>
                        
            <xsl:call-template name="getInsertSqlStatement">
                <xsl:with-param name="indent" select="'            '"/>
                <xsl:with-param name="typeNode" select="$typeNode"/>
                <xsl:with-param name="history" select="1"/>        
            </xsl:call-template>

<xsl:text><![CDATA[
            odbcReturnCode=SQLPrepare(connection->hStmtInsert,(SQLCHAR *)sql,SQL_NTS);
            if (odbcReturnCode != SQL_SUCCESS) {
                goto end;
            }

        } else {
            currentStmtPointer = &connection->hStmtInsert;
        }

]]></xsl:text>
                            
<xsl:text>        if ((index = </xsl:text><xsl:value-of select="$fullyQualifiedStructName"/>
<xsl:text>Plugin_bind_parameters(connection->hStmtInsert,1,sample,DDSQL_KEY_FIELDS|DDSQL_NO_KEY_FIELDS,DDS_BOOLEAN_FALSE)) == -1) {&nl;</xsl:text>
<xsl:text>            odbcReturnCode = SQL_ERROR;&nl;</xsl:text>                                    
<xsl:text>            goto end;&nl;</xsl:text>            
<xsl:text>        }&nl;</xsl:text>
                                                            
<xsl:text><![CDATA[
        odbcReturnCode = SQLBindParameter(connection->hStmtInsert,(short)index,SQL_PARAM_INPUT,SQL_C_SLONG,SQL_INTEGER,
                                          sizeof(numberOfSamples),0,&numberOfSamples,sizeof(numberOfSamples),0);

        if (odbcReturnCode != SQL_SUCCESS) {
            goto end;
        }

        index ++;
        odbcReturnCode = SQLBindParameter(connection->hStmtInsert,(short)index,SQL_PARAM_INPUT,SQL_C_SLONG,SQL_INTEGER,
                                          sizeof(maxNextOrder),0,&maxNextOrder,sizeof(maxNextOrder),0);

        if (odbcReturnCode != SQL_SUCCESS) {
            goto end;
        }
                
        odbcReturnCode = SQLExecute(connection->hStmtInsert);
        if (odbcReturnCode != SQL_SUCCESS && odbcReturnCode != SQL_SUCCESS_WITH_INFO){
            goto end;
        }

    }else{

        if (isNullNddsRemote != SQL_NULL_DATA) {
            currentStmtPointer = &connection->hStmtUpdate1;
        } else {
            currentStmtPointer = &connection->hStmtUpdate2;
        }

        if (*currentStmtPointer == NULL) {
            odbcReturnCode=SQLAllocStmt(connection->hDbc,currentStmtPointer);
            if (odbcReturnCode != SQL_SUCCESS){
                goto end;
            }

]]></xsl:text>

<xsl:text>            if (!</xsl:text><xsl:value-of select="$fullyQualifiedStructName"/>
<xsl:text>Plugin_get_update_field_names(sample,namePrefix,DDSQL_FIELD_NAME_MAX_LENGTH,
                                     fieldNames,DDSQL_SQL_STATEMENT_MAX_LENGTH,DDSQL_NO_KEY_FIELDS)) {&nl;</xsl:text>
<xsl:text>                ddsqlReturnCode = DDSQL_RETCODE_DBMS_ERROR;&nl;</xsl:text>                        
<xsl:text>                strcpy(connection->errorMessage,"SQL statement too long");&nl;</xsl:text>
<xsl:text>                goto end;&nl;</xsl:text>            
<xsl:text>            }&nl;</xsl:text>

<xsl:text><![CDATA[
            if (isNullNddsRemote != SQL_NULL_DATA) {
]]></xsl:text>            
                <xsl:call-template name="getUpdateSqlStatement">
                    <xsl:with-param name="indent" select="'                '"/>
                    <xsl:with-param name="typeNode" select="$typeNode"/>
                    <xsl:with-param name="isNull" select="0"/>        
                    <xsl:with-param name="history" select="1"/>        
                </xsl:call-template>
<xsl:text><![CDATA[            
            } else {
]]></xsl:text>            
                <xsl:call-template name="getUpdateSqlStatement">
                    <xsl:with-param name="indent" select="'                '"/>
                    <xsl:with-param name="typeNode" select="$typeNode"/>
                    <xsl:with-param name="isNull" select="1"/>        
                    <xsl:with-param name="history" select="1"/>                    
                </xsl:call-template>            
<xsl:text><![CDATA[                        
            }

            odbcReturnCode=SQLPrepare(*currentStmtPointer,(SQLCHAR *)sql,SQL_NTS);
            if (odbcReturnCode != SQL_SUCCESS) {
                goto end;
            }

        }
                
]]></xsl:text>            
            
<xsl:text>        if ((index=</xsl:text><xsl:value-of select="$fullyQualifiedStructName"/>
<xsl:text>Plugin_bind_parameters(*currentStmtPointer,1,sample,DDSQL_NO_KEY_FIELDS,DDS_BOOLEAN_FALSE)) == -1) {&nl;</xsl:text>
<xsl:text>            odbcReturnCode = SQL_ERROR;&nl;</xsl:text>                                                
<xsl:text>            goto end;&nl;</xsl:text>            
<xsl:text>        }&nl;</xsl:text>

<xsl:text><![CDATA[                                                            
        /* Bind the ndds_history_order parameter */
        odbcReturnCode = SQLBindParameter(*currentStmtPointer,(short)index,SQL_PARAM_INPUT,SQL_C_SLONG,SQL_INTEGER,
                                          sizeof(maxNextOrder),0,&maxNextOrder,sizeof(maxNextOrder),0);
        index ++;

        if (odbcReturnCode != SQL_SUCCESS) {
            goto end;
        }

        /* Bind the ndds_history_slot parameter */
        odbcReturnCode = SQLBindParameter(*currentStmtPointer,(short)index,SQL_PARAM_INPUT,SQL_C_SLONG,SQL_INTEGER,
                                          sizeof(historySlot),0,&historySlot,sizeof(historySlot),0);
        index ++;

        if (odbcReturnCode != SQL_SUCCESS) {
            goto end;
        }
]]></xsl:text>
                        
<xsl:text>        if ((index=</xsl:text><xsl:value-of select="$fullyQualifiedStructName"/>
<xsl:text>Plugin_bind_parameters(*currentStmtPointer,index,sample,DDSQL_KEY_FIELDS,DDS_BOOLEAN_FALSE)) == -1) {&nl;</xsl:text>
<xsl:text>            odbcReturnCode = SQL_ERROR;&nl;</xsl:text>            
<xsl:text>            goto end;&nl;</xsl:text>            
<xsl:text>        }&nl;</xsl:text>
                                
<xsl:text><![CDATA[                                    
        odbcReturnCode = SQLExecute(*currentStmtPointer);
        if (odbcReturnCode != SQL_SUCCESS && odbcReturnCode != SQL_SUCCESS_WITH_INFO){
            goto end;
        }
    }

]]></xsl:text>
    <xsl:call-template name="getStoreEndCode"/>    
                                                                        
<!-- 
================================================================================
Plugin_store_sample_in_database
================================================================================
-->

<xsl:text><![CDATA[
/**
 * @brief Stores the input sample into a database.
 * 
 * It must be used with connections where history storage is disabled.
 *
 * @param domainId Domain id associated to the entity that is storing information
 *                 into the database.
 * @param connection Database connection (not null).
 * @param sample Input sample.
 *
 * @return DDS Standard Return Codes, or DDS_RETCODE_PRECONDITION_NOT_MET 
 *         if the connection has history storage enabled, or 
 *         DDSQL_RETCODE_DBMS_ERROR if there is a database error.
 */

]]></xsl:text>
                                                                        
<xsl:text>DDSQL_ReturnCode_t </xsl:text>
<xsl:value-of select="$fullyQualifiedStructName"/><xsl:text>Plugin_store_sample_in_database(&nl;</xsl:text>
<xsl:text>    DDS_DomainId_t domainId,DDSQL_DatabaseConnection * connection,</xsl:text>
<xsl:value-of select="$fullyQualifiedStructName"/><xsl:text> *sample)</xsl:text>
<xsl:text><![CDATA[
{
    struct DDSQL_DatabaseQos * dbQos;
    char sql[DDSQL_SQL_STATEMENT_MAX_LENGTH+1];    
    char fieldNames[DDSQL_SQL_STATEMENT_MAX_LENGTH+1];
    char parameters[DDSQL_SQL_STATEMENT_MAX_LENGTH+1];
    char namePrefix[DDSQL_FIELD_NAME_MAX_LENGTH+1];
    RETCODE odbcReturnCode = SQL_SUCCESS;
    DDSQL_ReturnCode_t ddsqlReturnCode = DDS_RETCODE_OK;
    SQLCHAR sqlState[6];
    SDWORD nativeError;
    SWORD length;
    int ndds_remote;
    SQLINTEGER isNull;
    int index,nchar;
    SQLHSTMT * currentStmtPointer = NULL;

    strcpy(connection->errorMessage,"");
    dbQos = &connection->databaseQos;

    if (dbQos->history.history_depth != 0) {
        ddsqlReturnCode = DDS_RETCODE_PRECONDITION_NOT_MET;
        goto end;
    }

    if (connection->hStmtSelect == NULL) {
        odbcReturnCode=SQLAllocStmt(connection->hDbc,&connection->hStmtSelect);

        if (odbcReturnCode != SQL_SUCCESS){        
            goto end;
        }

        currentStmtPointer = &connection->hStmtSelect;
]]></xsl:text>

       <xsl:call-template name="getRecordExistsSqlStatement">
           <xsl:with-param name="indent" select="'        '"/>
           <xsl:with-param name="typeNode" select="$typeNode"/>
       </xsl:call-template>

<xsl:text><![CDATA[
        odbcReturnCode=SQLPrepare(connection->hStmtSelect,(SQLCHAR *)sql,SQL_NTS);
        if (odbcReturnCode != SQL_SUCCESS) {
            goto end;
        }
    } else {
        currentStmtPointer = &connection->hStmtSelect;
    }

]]></xsl:text>

<xsl:text>    if (</xsl:text><xsl:value-of select="$fullyQualifiedStructName"/>
<xsl:text>Plugin_bind_parameters(connection->hStmtSelect,1,sample,DDSQL_KEY_FIELDS,DDS_BOOLEAN_FALSE) == -1) {&nl;</xsl:text>
<xsl:text>        odbcReturnCode = SQL_ERROR;&nl;</xsl:text>                        
<xsl:text>        goto end;&nl;</xsl:text>            
<xsl:text>    }&nl;&nl;</xsl:text>
            
<xsl:text><![CDATA[
    odbcReturnCode = SQLExecute(connection->hStmtSelect);
    if (odbcReturnCode!=SQL_SUCCESS){
        goto end;
    }

    SQLBindCol(connection->hStmtSelect,1,SQL_C_SLONG,&ndds_remote,sizeof(int),&isNull);        
    odbcReturnCode=SQLFetch(connection->hStmtSelect);
    if (odbcReturnCode!=SQL_SUCCESS &&
        odbcReturnCode!=SQL_NO_DATA_FOUND){
        goto end;
    }
    
    SQLFreeStmt(connection->hStmtSelect,SQL_CLOSE);
    currentStmtPointer = NULL;    
]]></xsl:text>

<xsl:text><![CDATA[                
    namePrefix[0] = '\0';
    fieldNames[0] = '\0';

    if (odbcReturnCode == SQL_NO_DATA_FOUND) {

        if (connection->hStmtInsert == NULL) {
            odbcReturnCode=SQLAllocStmt(connection->hDbc,&connection->hStmtInsert);
            if (odbcReturnCode != SQL_SUCCESS){
                goto end;
            }

            currentStmtPointer = &connection->hStmtInsert;
]]></xsl:text>
            
<xsl:text>            if (!</xsl:text><xsl:value-of select="$fullyQualifiedStructName"/>
<xsl:text>Plugin_get_insert_field_names(namePrefix,DDSQL_FIELD_NAME_MAX_LENGTH,
                                     fieldNames,DDSQL_SQL_STATEMENT_MAX_LENGTH)) {&nl;</xsl:text>
<xsl:text>                ddsqlReturnCode = DDSQL_RETCODE_DBMS_ERROR;&nl;</xsl:text>            
<xsl:text>                strcpy(connection->errorMessage,"SQL statement too long");&nl;</xsl:text>
<xsl:text>                goto end;&nl;</xsl:text>            
<xsl:text>            }&nl;</xsl:text>
            
<xsl:text>            if (!</xsl:text><xsl:value-of select="$fullyQualifiedStructName"/>
<xsl:text>Plugin_get_insert_parameters(sample,parameters,DDSQL_SQL_STATEMENT_MAX_LENGTH)) {&nl;</xsl:text>
<xsl:text>                ddsqlReturnCode = DDSQL_RETCODE_DBMS_ERROR;&nl;</xsl:text>                        
<xsl:text>                strcpy(connection->errorMessage,"SQL statement too long");&nl;</xsl:text>
<xsl:text>                goto end;&nl;</xsl:text>            
<xsl:text>            }&nl;</xsl:text>
                        
            <xsl:call-template name="getInsertSqlStatement">
                <xsl:with-param name="indent" select="'            '"/>
                <xsl:with-param name="typeNode" select="$typeNode"/>
                <xsl:with-param name="history" select="0"/>        
            </xsl:call-template>

<xsl:text><![CDATA[
            odbcReturnCode=SQLPrepare(connection->hStmtInsert,(SQLCHAR *)sql,SQL_NTS);
            if (odbcReturnCode != SQL_SUCCESS) {
                goto end;
            }

        } else {
            currentStmtPointer = &connection->hStmtInsert;
        }

]]></xsl:text>

                            
<xsl:text>        if (</xsl:text><xsl:value-of select="$fullyQualifiedStructName"/>
<xsl:text>Plugin_bind_parameters(connection->hStmtInsert,1,sample,DDSQL_KEY_FIELDS|DDSQL_NO_KEY_FIELDS,DDS_BOOLEAN_FALSE) == -1) {&nl;</xsl:text>
<xsl:text>            odbcReturnCode = SQL_ERROR;&nl;</xsl:text>                                    
<xsl:text>            goto end;&nl;</xsl:text>            
<xsl:text>        }&nl;</xsl:text>
                                    
<xsl:text><![CDATA[
        odbcReturnCode = SQLExecute(connection->hStmtInsert);
        if (odbcReturnCode != SQL_SUCCESS && odbcReturnCode != SQL_SUCCESS_WITH_INFO){
            goto end;
        }

    }else{

        if (isNull != SQL_NULL_DATA) {
            currentStmtPointer = &connection->hStmtUpdate1;
        } else {
            currentStmtPointer = &connection->hStmtUpdate2;
        }

        if (*currentStmtPointer == NULL) {
            odbcReturnCode=SQLAllocStmt(connection->hDbc,currentStmtPointer);
            if (odbcReturnCode != SQL_SUCCESS){
                goto end;
            }

]]></xsl:text>

<xsl:text>            if (!</xsl:text><xsl:value-of select="$fullyQualifiedStructName"/>
<xsl:text>Plugin_get_update_field_names(sample,namePrefix,DDSQL_FIELD_NAME_MAX_LENGTH,
                                     fieldNames,DDSQL_SQL_STATEMENT_MAX_LENGTH,DDSQL_NO_KEY_FIELDS)) {&nl;</xsl:text>
<xsl:text>                ddsqlReturnCode = DDSQL_RETCODE_DBMS_ERROR;&nl;</xsl:text>
<xsl:text>                strcpy(connection->errorMessage,"SQL statement too long");&nl;</xsl:text>
<xsl:text>                goto end;&nl;</xsl:text>            
<xsl:text>            }&nl;</xsl:text>

<xsl:text><![CDATA[            
            if (isNull != SQL_NULL_DATA) {
]]></xsl:text>            
                <xsl:call-template name="getUpdateSqlStatement">
                    <xsl:with-param name="indent" select="'                '"/>
                    <xsl:with-param name="typeNode" select="$typeNode"/>
                    <xsl:with-param name="isNull" select="0"/>        
                </xsl:call-template>
<xsl:text><![CDATA[            
            } else {
]]></xsl:text>            
                <xsl:call-template name="getUpdateSqlStatement">
                    <xsl:with-param name="indent" select="'                '"/>
                    <xsl:with-param name="typeNode" select="$typeNode"/>
                    <xsl:with-param name="isNull" select="1"/>        
                </xsl:call-template>            
<xsl:text><![CDATA[                        
            }

            odbcReturnCode=SQLPrepare(*currentStmtPointer,(SQLCHAR *)sql,SQL_NTS);
            if (odbcReturnCode != SQL_SUCCESS) {
                goto end;
            }

        }
        
]]></xsl:text>
            
<xsl:text>        if ((index=</xsl:text><xsl:value-of select="$fullyQualifiedStructName"/>
<xsl:text>Plugin_bind_parameters(*currentStmtPointer,1,sample,DDSQL_NO_KEY_FIELDS,DDS_BOOLEAN_FALSE)) == -1) {&nl;</xsl:text>
<xsl:text>            odbcReturnCode = SQL_ERROR;&nl;</xsl:text>                                                
<xsl:text>            goto end;&nl;</xsl:text>            
<xsl:text>        }&nl;</xsl:text>
            
<xsl:text>        if (</xsl:text><xsl:value-of select="$fullyQualifiedStructName"/>
<xsl:text>Plugin_bind_parameters(*currentStmtPointer,index,sample,DDSQL_KEY_FIELDS,DDS_BOOLEAN_FALSE) == -1) {&nl;</xsl:text>
<xsl:text>            odbcReturnCode = SQL_ERROR;&nl;</xsl:text>            
<xsl:text>            goto end;&nl;</xsl:text>            
<xsl:text>        }&nl;</xsl:text>
                                
<xsl:text><![CDATA[                                    
        odbcReturnCode = SQLExecute(*currentStmtPointer);
        if (odbcReturnCode != SQL_SUCCESS && odbcReturnCode != SQL_SUCCESS_WITH_INFO){
            goto end;
        }
    }
]]></xsl:text>

        <xsl:call-template name="getStoreEndCode"/>    
    </xsl:template>
                
    <!-- ===================================================================== -->
    <!-- Database Helper Templates                                             -->
    <!-- ===================================================================== -->

    <xsl:template name="getStoreEndCode">
<xsl:text><![CDATA[

    odbcReturnCode = SQL_SUCCESS;
    ddsqlReturnCode = DDS_RETCODE_OK;        

    if (connection->txnSupport == SQL_TC_ALL) {
        odbcReturnCode = SQLTransact(connection->hEnv,connection->hDbc,SQL_COMMIT);
    }
    currentStmtPointer = NULL;
end:
    if (odbcReturnCode != SQL_SUCCESS) {
        if (!strcmp(connection->errorMessage,"")) {
            SQLError(connection->hEnv, connection->hDbc,*currentStmtPointer,sqlState,&nativeError,
                     (SQLCHAR *)connection->errorMessage, sizeof connection->errorMessage, &length);    
        }
        ddsqlReturnCode = DDSQL_RETCODE_DBMS_ERROR;
    }

    if (ddsqlReturnCode != DDS_RETCODE_OK) {
        if (connection->txnSupport == SQL_TC_ALL) {
            SQLTransact(connection->hEnv,connection->hDbc,SQL_ROLLBACK);
        } 

        if (connection->hStmtSelect != NULL) {
            SQLFreeStmt(connection->hStmtSelect,SQL_DROP);
            connection->hStmtSelect = NULL;
        }

        if (connection->hStmtUpdate1 != NULL) {
            SQLFreeStmt(connection->hStmtUpdate1,SQL_DROP);
            connection->hStmtUpdate1 = NULL;
        }

        if (connection->hStmtUpdate2 != NULL) {
            SQLFreeStmt(connection->hStmtUpdate2,SQL_DROP);
            connection->hStmtUpdate2 = NULL;
        }

        if (connection->hStmtInsert != NULL) {
            SQLFreeStmt(connection->hStmtInsert,SQL_DROP);
            connection->hStmtInsert = NULL;
        }
    }

    return ddsqlReturnCode;
}
]]></xsl:text>
    </xsl:template>

    <!-- getUpdateSqlStatement -->
    <xsl:template name="getUpdateSqlStatement">
        <xsl:param name="indent"/>
        <xsl:param name="typeNode"/>
        <xsl:param name="isNull"/>   <!-- 1/0 -->
        <xsl:param name="history" select="0"/>   <!-- 1/0 -->                        

        <xsl:variable name="keyFields" select="$typeNode/member
                                                   [following-sibling::node()
                                                       [position() = 1 and name() = 'directive' and @kind = 'key']]"/>
        <xsl:variable name="hasKeys" select="count($keyFields)"/>
            
        <xsl:value-of select="$indent"/>
        <xsl:text>nchar = snprintf((char*)sql,DDSQL_SQL_STATEMENT_MAX_LENGTH+1,"UPDATE \"%s\" SET \&nl;</xsl:text>
        <xsl:value-of select="$indent"/>
        <xsl:value-of select="'             %s'"/>                               
        <xsl:text>\&nl;</xsl:text>
            
        <xsl:value-of select="$indent"/>
        <xsl:value-of select="'             '"/>            
        <xsl:text>ndds_domain_id = %d,\&nl;</xsl:text>

        <xsl:if test="$history = 1">
            <xsl:value-of select="$indent"/>
            <xsl:value-of select="'             '"/>       
            <xsl:text>ndds_history_order =?,\&nl;</xsl:text>
        </xsl:if>                
                        
        <xsl:value-of select="$indent"/>
        <xsl:value-of select="'             '"/>                   
        <xsl:if test="$isNull = 1">                
            <xsl:value-of select="'ndds_remote= 123 Where '"/>
        </xsl:if>
        <xsl:if test="$isNull = 0">
            <xsl:value-of select="'ndds_remote= ndds_remote + 1 Where '"/>
        </xsl:if>            
        <xsl:text>\&nl;</xsl:text>                  
            
        <xsl:if test="$history = 1">
            <xsl:value-of select="$indent"/>
            <xsl:value-of select="'             '"/>
            <xsl:text>ndds_history_slot = ? and\&nl;</xsl:text>                
        </xsl:if>
                        
        <xsl:value-of select="$indent"/>
        <xsl:value-of select="'             '"/>                   
        <xsl:if test="$hasKeys != 0">
            <xsl:for-each select="$keyFields[position() != last()]">
                <xsl:value-of select="concat('\&quot;',./@name,'\&quot;=? and ')"/>
            </xsl:for-each>        
            <xsl:for-each select="$keyFields[position() = last()]">
                <xsl:value-of select="concat('\&quot;',./@name,'\&quot;=?')"/>
            </xsl:for-each>
        </xsl:if>                            
            
        <xsl:if test="$hasKeys = 0">
            <xsl:text>ndds_key = 0</xsl:text>                
        </xsl:if>
            
        <xsl:text>",dbQos->access.table_name,fieldNames,(int)domainId</xsl:text>
                            
        <xsl:text>);&nl;&nl;</xsl:text>            
            
        <xsl:call-template name="checkSQLStatementLength">
            <xsl:with-param name="indent" select="$indent"/>
        </xsl:call-template>                
                                                            
    </xsl:template>
    
    <!-- getRecordExistsSqlStatement -->
    <xsl:template name="getRecordExistsSqlStatement">
        <xsl:param name="indent"/>
        <xsl:param name="typeNode"/>
        <xsl:param name="history" select="0"/>            
            
        <xsl:variable name="keyFields" select="$typeNode/member
                                                   [following-sibling::node()
                                                       [position() = 1 and name() = 'directive' and @kind = 'key']]"/>
        <xsl:variable name="hasKeys" select="count($keyFields)"/>
                                                
        <xsl:value-of select="$indent"/>
            
        <xsl:text>nchar = snprintf(sql,DDSQL_SQL_STATEMENT_MAX_LENGTH+1,"Select ndds_remote</xsl:text>           
            
        <xsl:if test="$history = 1">                
            <xsl:text>,ndds_history_order,ndds_history_slot</xsl:text>                
        </xsl:if>
            
        <xsl:text> From \"%s\" Where </xsl:text>
            
        <xsl:if test="$hasKeys!=0">
            <xsl:for-each select="$keyFields[position() != last()]">
                <xsl:text>\"</xsl:text><xsl:value-of select="./@name"/><xsl:text>\"=? and </xsl:text>
            </xsl:for-each>                        
            <xsl:for-each select="$keyFields[position() = last()]">
                <xsl:text>\"</xsl:text><xsl:value-of select="./@name"/><xsl:text>\"=?</xsl:text>
            </xsl:for-each>
        </xsl:if>

        <xsl:if test="$hasKeys=0">
            <xsl:text>ndds_key = 0</xsl:text>                
        </xsl:if>
            
        <xsl:if test="$history = 1">
            <xsl:text> order by ndds_history_order desc</xsl:text>                                                
        </xsl:if>
            
        <xsl:text>",dbQos->access.table_name);&nl;&nl;</xsl:text>
                        
        <xsl:call-template name="checkSQLStatementLength">
            <xsl:with-param name="indent" select="$indent"/>
        </xsl:call-template>                
                                    
    </xsl:template>
        
    <!-- getInsertSqlStatement -->
    <xsl:template name="getInsertSqlStatement">
        <xsl:param name="indent"/>
        <xsl:param name="typeNode"/>
        <xsl:param name="history"/>   <!-- 1/0 -->
            
        <xsl:variable name="keyFields" select="$typeNode/member
                                                   [following-sibling::node()
                                                       [position() = 1 and name() = 'directive' and @kind = 'key']]"/>
        <xsl:variable name="hasKeys" select="count($keyFields)"/>
            
        <xsl:value-of select="$indent"/>
        <xsl:text>nchar = snprintf(sql,DDSQL_SQL_STATEMENT_MAX_LENGTH+1,"Insert INTO \"%s\"\&nl;</xsl:text>
        <xsl:value-of select="$indent"/>
        <xsl:text>             (%s</xsl:text>

        <xsl:if test="$hasKeys = 0">
            <xsl:text>ndds_key,</xsl:text>
        </xsl:if>
                        
        <xsl:if test="$history = 1">
            <xsl:text>ndds_history_slot,ndds_history_order,</xsl:text>
        </xsl:if>
                                                                
        <xsl:text>ndds_domain_id,ndds_remote) Values \&nl;</xsl:text>
                        
        <xsl:value-of select="$indent"/>
        <xsl:text>             (%s</xsl:text>
            
        <xsl:if test="$hasKeys = 0">
            <xsl:text>0,</xsl:text>
        </xsl:if>
            
        <xsl:if test="$history = 1">
            <xsl:text>?,?,</xsl:text>
            <xsl:text>%d,1)",dbQos->access.table_name,fieldNames,parameters</xsl:text>                
        </xsl:if>
            
        <xsl:if test="$history = 0">
            <xsl:text>%d,1)",dbQos->access.table_name,fieldNames,parameters</xsl:text>                
        </xsl:if>
            
        <xsl:text>,(int)domainId);&nl;&nl;</xsl:text>
                                                
        <xsl:call-template name="checkSQLStatementLength">
            <xsl:with-param name="indent" select="$indent"/>
        </xsl:call-template>                
                                                    
    </xsl:template>
               
    <!-- getCreateTableSqlStatement -->
    <xsl:template name="getCreateTableSqlStatement">
        <xsl:param name="indent"/>
        <xsl:param name="typeNode"/>
        <xsl:param name="dbms"/> <!-- MySQL, TT -->

        <xsl:variable name="keyFields" select="$typeNode/member
                                                   [following-sibling::node()
                                                       [position() = 1 and name() = 'directive' and @kind = 'key']]"/>

        <xsl:variable name="hasKeys" select="count($keyFields)"/>
        <xsl:variable name="indent2" select="concat($indent,'             ')"/>

        <xsl:value-of select="$indent"/>
        <xsl:text>nchar = snprintf(sql,DDSQL_SQL_STATEMENT_MAX_LENGTH+1,"Create Table </xsl:text>

        <xsl:if test="$dbms = 'MySQL'">
            <xsl:text>IF NOT EXISTS </xsl:text>
        </xsl:if>
            
        <xsl:text>\"%s\" \&nl;</xsl:text>
                                            
        <xsl:value-of select="$indent"/>
        <xsl:text>             (\&nl;</xsl:text>
        <xsl:value-of select="$indent2"/>

        <xsl:text>%s\&nl;</xsl:text>

        <xsl:value-of select="$indent2"/>                        
            
        <xsl:if test="$hasKeys = 0">
            <xsl:text>ndds_key INTEGER NOT NULL,</xsl:text>                
        </xsl:if>                
            
        <xsl:text>%s</xsl:text> <!-- History -->
        <xsl:text>ndds_domain_id INTEGER,</xsl:text>
                        
        <xsl:if test="$dbms = 'MySQL'">
            <xsl:text>ndds_remote INTEGER NOT NULL DEFAULT 0,\&nl;</xsl:text>
        </xsl:if>

        <xsl:if test="$dbms = 'TT'">
            <xsl:text>ndds_remote INTEGER,\&nl;</xsl:text>
        </xsl:if>

        <xsl:value-of select="$indent2"/>
                    
        <xsl:if test="$hasKeys = 0">
            <xsl:text>PRIMARY KEY (%sndds_key</xsl:text>                
        </xsl:if>                
                
        <xsl:if test="$hasKeys != 0">
            <xsl:text>PRIMARY KEY (%s </xsl:text>

            <xsl:for-each select="$keyFields[position() != last()]">
                <xsl:value-of select="concat('\&quot;',./@name,'\&quot;,')"/>
            </xsl:for-each>

            <xsl:for-each select="$keyFields[position() = last()]">
                <xsl:value-of select="concat('\&quot;',./@name,'\&quot;')"/>
            </xsl:for-each>                
        </xsl:if>                                      
                
        <xsl:text>)\&nl;</xsl:text>
        <xsl:value-of select="$indent2"/>
        <xsl:text>)",dbQos->access.table_name,fieldsDeclaration,historyField,historyKey);&nl;&nl;</xsl:text>
            
        <xsl:call-template name="checkSQLStatementLength">
            <xsl:with-param name="indent" select="$indent"/>
        </xsl:call-template>                
                                            
    </xsl:template>

    <!-- getPrimitiveFieldNames -->
    <xsl:template name="getPrimitiveFieldNames">
        <xsl:param name="indent"/>
        <xsl:param name="member"/>
        <xsl:param name="descNode"/>                                                
        <xsl:param name="separator"/>
        <xsl:param name="parameters"/>                        
        <xsl:param name="indexStr"/>            
        <xsl:param name="indexVar"/>                        
        <xsl:param name="caseStr"/>
        <xsl:param name="caseVar"/>                                                                            
        <xsl:param name="function"/>                   
            
        <xsl:variable name="bfStr">
            <xsl:if test="$descNode/@bitField != ''">
                <xsl:text>:</xsl:text>
                <xsl:if test="$descNode/@bitKind ='lastBitField'">
                    <xsl:text>!</xsl:text>
                </xsl:if>
                <xsl:text>%d</xsl:text>
            </xsl:if>
            <xsl:text></xsl:text>
        </xsl:variable>
            
        <xsl:variable name="bfVar">
            <xsl:if test="$descNode/@bitField != ''">
                <xsl:text>,(int)(</xsl:text>
                <xsl:value-of select="$descNode/@bitField"/>
                <xsl:text>)</xsl:text>
            </xsl:if>
            <xsl:text></xsl:text>
        </xsl:variable>
            
        <xsl:variable name="newSeparator">
            <xsl:choose>
                <xsl:when test="$descNode/@bitField != '' and $function != 'Plugin_get_insert_field_names'">
                    <xsl:if test="$function = 'Plugin_get_insert_parameters'">
                        <xsl:text>%d,</xsl:text>
                    </xsl:if>
                    <xsl:if test="$function = 'Plugin_get_update_field_names'">
                        <xsl:text>=%d,</xsl:text>
                    </xsl:if>                        
                </xsl:when>
                <xsl:otherwise>                        
                    <xsl:value-of select="$separator"/>                                                
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
            
        <xsl:variable name="newSeparatorVar">
            <xsl:choose>
                <xsl:when test="$descNode/@bitField != '' and $function != 'Plugin_get_insert_field_names'">
                    <xsl:value-of select="',bf'"/>                                                                       
                </xsl:when>
                <xsl:otherwise>                        
                    <xsl:value-of select="''"/>                                                
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
                                    
        <xsl:if test="$descNode/@bitField != '' and $function != 'Plugin_get_insert_field_names' ">
            <xsl:value-of select="$indent"/>                    
            <xsl:text>{&nl;</xsl:text>                
            <xsl:value-of select="$indent"/>                    
            <xsl:text>    int bf = (int) sample-></xsl:text>
            <xsl:value-of select="$member/@name"/>
            <xsl:text>;&nl;</xsl:text>
        </xsl:if>
            
        <xsl:variable name="newIndent">
            <xsl:value-of select="$indent"/>
            <xsl:if test="$descNode/@bitField != '' and $function != 'Plugin_get_insert_field_names'">
                <xsl:value-of select="'    '"/>
            </xsl:if>
        </xsl:variable>                
                                                    
        <xsl:value-of select="$newIndent"/>    
        <xsl:text>nchar=snprintf(sql,max_sql_length+1,"</xsl:text> 
                                                        
        <xsl:if test="$parameters = 1">
            <xsl:value-of select="$newSeparator"/>                
            <xsl:text>"</xsl:text>
            <xsl:value-of select="$newSeparatorVar"/>                                
            <xsl:text>);&nl;</xsl:text>                                      
        </xsl:if>                    
            
        <xsl:if test="$parameters = 0">             
            <xsl:if test="name($member) != 'enum'">
                <xsl:value-of select="concat('\&quot;','%s%s',$caseStr,$member/@name,$bfStr,$indexStr)"/>
            </xsl:if>
            <xsl:if test="name($member) = 'enum'">
                <xsl:value-of select="concat('\&quot;','%s%s',$caseStr,$bfStr,$indexStr)"/>
            </xsl:if>
            <xsl:text>\"</xsl:text><xsl:value-of select="$newSeparator"/>                
            <xsl:text>",name_prefix,delimiter</xsl:text>
            <xsl:value-of select="$caseVar"/>          
            <xsl:value-of select="$bfVar"/>                  
            <xsl:value-of select="$indexVar"/>
            <xsl:value-of select="$newSeparatorVar"/>
            <xsl:text>);&nl;</xsl:text>                                                
        </xsl:if>                    
                                                                                                            
        <xsl:value-of select="$newIndent"/>
        <xsl:text>if (nchar >= (max_sql_length+1) || nchar &lt; 0) {&nl;</xsl:text>            
        <xsl:value-of select="$newIndent"/>            
        <xsl:text>    return NULL;&nl;</xsl:text>            
        <xsl:value-of select="$newIndent"/>                     
        <xsl:text>}&nl;</xsl:text>                           
        <xsl:value-of select="$newIndent"/>                                    
        <xsl:text>sql = sql + strlen(sql);&nl;</xsl:text>
        <xsl:value-of select="$newIndent"/>            
        <xsl:text>max_sql_length = max_sql_length - strlen(sql);&nl;&nl;</xsl:text>
            
        <xsl:if test="$descNode/@bitField != '' and $function != 'Plugin_get_insert_field_names'">
            <xsl:value-of select="$indent"/>                    
            <xsl:text>}&nl;&nl;</xsl:text>                
        </xsl:if>
                        
    </xsl:template>
                
    <!-- getFieldNames -->
    <xsl:template name="getFieldNames">
        <xsl:param name="indent"/>
        <xsl:param name="member"/>
        <xsl:param name="isKey" select="-1"/> <!-- -1: No check the type of field -->
        <xsl:param name="parameters" select="0"/>     
        <xsl:param name="separator"/>
        <xsl:param name="function"/>
        <xsl:param name="defaultMemberPointer" select="''"/>                        
        <xsl:param name="previousMemberKind" select="''"/>            
        <xsl:param name="indexStr" select="''"/>            
        <xsl:param name="indexVar" select="''"/>                        
        <xsl:param name="caseStr" select="''"/>            
        <xsl:param name="caseVar" select="''"/>                        
                                   
        <xsl:variable name="description">
            <xsl:call-template name="getMemberDescription">
                <xsl:with-param name="member" select="$member"/>
            </xsl:call-template>
        </xsl:variable>
                    
        <xsl:variable name="descNode" select="xalan:nodeset($description)/node()"/>                
            
        <xsl:variable name="memberKind">
            <xsl:call-template name="getFilteredMemberKind">
                <xsl:with-param name="descNode"   select="$descNode"/>
                <xsl:with-param name="memberKindToFilter" select="$previousMemberKind"/>
            </xsl:call-template>
        </xsl:variable>
                                                                                            
        <xsl:if test="$isKey = 1">
            <xsl:value-of select="$indent"/>                
            <xsl:text>if (fields_mask &amp; DDSQL_KEY_FIELDS) {&nl;</xsl:text>
        </xsl:if>            
        <xsl:if test="$isKey = 0">
            <xsl:value-of select="$indent"/>                
            <xsl:text>if (fields_mask &amp; DDSQL_NO_KEY_FIELDS) {&nl;</xsl:text>                                
        </xsl:if>                       
                        
        <xsl:variable name="newIndent">
            <xsl:value-of select="$indent"/>
            <xsl:if test="$isKey = 1 or $isKey=0">
                <xsl:value-of select="'    '"/>
            </xsl:if>
        </xsl:variable>                
                                                                              
        <xsl:choose>
            <xsl:when test="$memberKind = 'scalar' and $descNode/@typeKind = 'user' and
                            name($member) != 'enum'">                    

                <xsl:if test="$function != 'Plugin_get_insert_parameters' and $member/@name != ''">
                    <xsl:call-template name="addStringToPrefix">
                        <xsl:with-param name="indent" select="$indent"/>
                        <xsl:with-param name="string" select="$member/@name"/>
                        <xsl:with-param name="indexStr" select="$indexStr"/>
                        <xsl:with-param name="indexVar" select="$indexVar"/>                            
                        <xsl:with-param name="caseStr" select="$caseStr"/>
                        <xsl:with-param name="caseVar" select="$caseVar"/>                            
                    </xsl:call-template>
                </xsl:if>
                    
                <xsl:variable name="memberPointer">
                    <xsl:call-template name="generateMemberPtr">
                        <xsl:with-param name="member" select="$member"/>
                        <xsl:with-param name="memberKind" select="$memberKind"/>
                        <xsl:with-param name="defaultMemberPointer" select="$defaultMemberPointer"/>                        
                    </xsl:call-template>                    
                </xsl:variable>                                
                                        
                <xsl:value-of select="$newIndent"/>                                                        
                <xsl:text>sqlNew = </xsl:text><xsl:value-of select="$descNode/@type"/>
                <xsl:value-of select="$function"/>
                <xsl:text>(</xsl:text>                    
                                        
                <xsl:choose>
                    <xsl:when test="$function = 'Plugin_get_insert_parameters'">
                        <xsl:value-of select="$memberPointer"/>
                        <xsl:text>,sql,max_sql_length);&nl;</xsl:text>                                                        
                    </xsl:when>
                    <xsl:when test="$function = 'Plugin_get_insert_field_names'">
                        <xsl:text>name_prefix,max_name_prefix_length - strlen(namePrefixEndPtr),</xsl:text>                            
                        <xsl:text>sql,max_sql_length);&nl;</xsl:text>
                    </xsl:when>                        
                    <xsl:otherwise>                        
                        <xsl:value-of select="$memberPointer"/>                            
                        <xsl:text>,name_prefix,max_name_prefix_length - strlen(namePrefixEndPtr)</xsl:text>
                        <xsl:text>,sql,max_sql_length,DDSQL_NO_KEY_FIELDS|DDSQL_KEY_FIELDS);&nl;</xsl:text>                            
                    </xsl:otherwise>
                </xsl:choose>
                    
                <xsl:value-of select="$newIndent"/>                                         
                <xsl:text>if (sqlNew == NULL) {&nl;</xsl:text>
                <xsl:value-of select="$newIndent"/>            
                <xsl:text>    return NULL;&nl;</xsl:text>            
                <xsl:value-of select="$newIndent"/>                     
                <xsl:text>}&nl;</xsl:text>                    
                <xsl:value-of select="$newIndent"/>                                
                <xsl:text>max_sql_length -= (sqlNew - sql);&nl;</xsl:text>
                <xsl:value-of select="$newIndent"/>                                                    
                <xsl:text>sql = sqlNew;&nl;</xsl:text>                    
                 
                <xsl:if test="$function != 'Plugin_get_insert_parameters'">
                    <xsl:value-of select="$newIndent"/>                                            
                    <xsl:text>*namePrefixEndPtr = '\0';&nl;&nl;</xsl:text>
                </xsl:if>                        
                    
                <xsl:if test="$function = 'Plugin_get_insert_parameters'">
                    <xsl:text>&nl;</xsl:text>                                            
                </xsl:if>
                                                                                                                           
            </xsl:when>
                
            <xsl:when test="$memberKind = 'array' or 
                            $memberKind = 'arraySequence'">
                <xsl:variable name="cardinality">
                    <xsl:call-template name="getBaseCardinality">
                        <xsl:with-param name="member" select="$member"/>        
                    </xsl:call-template>                                                    
                </xsl:variable>                                        
                    
                <xsl:variable name="cardinalityNode" select="xalan:nodeset($cardinality)/node()"/>
                
                <xsl:variable name="arrIndexStr">
                    <xsl:call-template name="generateIndexStr">
                        <xsl:with-param name="memberKind" select="$memberKind"/>
                        <xsl:with-param name="cardinalityNode" select="$cardinalityNode"/>
                    </xsl:call-template>                                                                            
                </xsl:variable>
                    
                <xsl:variable name="arrIndexVar">
                    <xsl:call-template name="generateIndexVar">
                        <xsl:with-param name="memberKind" select="$memberKind"/>
                        <xsl:with-param name="cardinalityNode" select="$cardinalityNode"/>                            
                    </xsl:call-template>                                                                            
                </xsl:variable>
                                                                                                    
                <xsl:value-of select="$indent"/>
                <xsl:text>{&nl;</xsl:text>
                <xsl:value-of select="$indent"/>
                <xsl:text>    int indexArr[</xsl:text>
                <xsl:value-of select="count($cardinalityNode/dimension)"/>
                <xsl:text>];&nl;</xsl:text>       
                    
                <xsl:variable name="memberPointer">
                    <xsl:call-template name="generateMemberPtr">
                        <xsl:with-param name="member" select="$member"/>
                        <xsl:with-param name="memberKind" select="$memberKind"/>
                        <xsl:with-param name="cardinalityNode" select="$cardinalityNode"/>
                        <xsl:with-param name="defaultMemberPointer" select="$defaultMemberPointer"/>                        
                    </xsl:call-template>                    
                </xsl:variable>
                                                     
                <xsl:call-template name="generateArrayLoopForGetFieldNames">
                    <xsl:with-param name="indent" select="concat($indent,'    ')"/>                        
                    <xsl:with-param name="cardinalityNode" select="$cardinalityNode"/>            
                    <xsl:with-param name="member" select="$member"/>     
                    <xsl:with-param name="memberKind" select="$memberKind"/>                        
                    <xsl:with-param name="indexStr" select="$arrIndexStr"/>                        
                    <xsl:with-param name="indexVar" select="$arrIndexVar"/>
                    <xsl:with-param name="parameters" select="$parameters"/>     
                    <xsl:with-param name="separator" select="$separator"/>
                    <xsl:with-param name="function" select="$function"/>                                                
                    <xsl:with-param name="caseStr" select="$caseStr"/>
                    <xsl:with-param name="caseVar" select="$caseVar"/>                        
                    <xsl:with-param name="defaultMemberPointer" select="$memberPointer"/>                                                
                </xsl:call-template>                        
                                                        
                <xsl:value-of select="$indent"/>                                        
                <xsl:text>}&nl;&nl;</xsl:text> 
                                                                                            
            </xsl:when>
                                
            <xsl:when test="$memberKind = 'sequence'">
                <xsl:variable name="length">
                    <xsl:call-template name="getBaseSequenceLength">
                        <xsl:with-param name="member" select="$member"/>        
                    </xsl:call-template>                                                    
                </xsl:variable>                    
                    
                <xsl:variable name="lengthElement">
                    <xsl:call-template name="createSeqLengthElement">
                        <xsl:with-param name="name" select="concat($member/@name,$indexStr)"/>
                    </xsl:call-template>
                </xsl:variable>  
                                        
                <xsl:variable name="lengthNode" select="xalan:nodeset($lengthElement)/node()"/>
                                                            
                <xsl:variable name="seqIndexStr">
                    <xsl:value-of select="$indexStr"/>                        
                    <xsl:call-template name="generateIndexStr">
                        <xsl:with-param name="memberKind" select="$memberKind"/>
                    </xsl:call-template>                                                                            
                </xsl:variable>
                    
                <xsl:variable name="seqIndexVar">
                    <xsl:value-of select="$indexVar"/>
                    <xsl:call-template name="generateIndexVar">
                        <xsl:with-param name="memberKind" select="$memberKind"/>
                    </xsl:call-template>                                                                            
                </xsl:variable>
                                        
                <xsl:value-of select="$newIndent"/>
                <xsl:text>{&nl;</xsl:text>
                <xsl:value-of select="$newIndent"/>
                <xsl:text>    int i;&nl;</xsl:text>                    
                    
                <xsl:variable name="memberPointer1">
                    <xsl:call-template name="generateMemberPtr">
                        <xsl:with-param name="member" select="$member"/>
                        <xsl:with-param name="memberKind" select="'scalar'"/>
                        <xsl:with-param name="defaultMemberPointer" select="$defaultMemberPointer"/>                        
                    </xsl:call-template>                    
                </xsl:variable>                                
                                                            
                <xsl:call-template name="getFieldNames">
                    <xsl:with-param name="indent" select="concat($newIndent,'    ')"/>
                    <xsl:with-param name="member" select="$lengthNode"/>
                    <xsl:with-param name="isKey" select="-1"/>
                    <xsl:with-param name="parameters" select="$parameters"/>     
                    <xsl:with-param name="separator" select="$separator"/>
                    <xsl:with-param name="function" select="$function"/>                        
                    <xsl:with-param name="indexVar" select="$indexVar"/>                                                
                    <xsl:with-param name="caseStr" select="$caseStr"/>
                    <xsl:with-param name="caseVar" select="$caseVar"/> 
                    <xsl:with-param name="defaultMemberPointer" select="concat('&amp;(',$memberPointer1,')->_length')"/>
                </xsl:call-template>                      
                    
                <xsl:value-of select="$newIndent"/>                 
                <xsl:text>    for (i=0;i&lt;</xsl:text><xsl:value-of select="$length"/>
                <xsl:text>;i++) {&nl;&nl;</xsl:text>
                    
                <xsl:variable name="memberPointer2">
                    <xsl:call-template name="generateMemberPtr">
                        <xsl:with-param name="member" select="$member"/>
                        <xsl:with-param name="memberKind" select="$memberKind"/>
                        <xsl:with-param name="defaultMemberPointer" select="$defaultMemberPointer"/>                        
                    </xsl:call-template>                    
                </xsl:variable>                                
                                        
                <xsl:call-template name="getFieldNames">
                    <xsl:with-param name="indent" select="concat($newIndent,'        ')"/>
                    <xsl:with-param name="member" select="$member"/>
                    <xsl:with-param name="isKey" select="-1"/>
                    <xsl:with-param name="parameters" select="$parameters"/>     
                    <xsl:with-param name="separator" select="$separator"/>
                    <xsl:with-param name="function" select="$function"/>
                    <xsl:with-param name="previousMemberKind" select="$memberKind"/>                         
                    <xsl:with-param name="indexStr" select="$seqIndexStr"/>                        
                    <xsl:with-param name="indexVar" select="$seqIndexVar"/>                                                
                    <xsl:with-param name="caseStr" select="$caseStr"/>
                    <xsl:with-param name="caseVar" select="$caseVar"/>    
                    <xsl:with-param name="defaultMemberPointer" select="$memberPointer2"/>
                </xsl:call-template>                      
                                        
                <xsl:value-of select="$newIndent"/>                                                                            
                <xsl:text>    }&nl;</xsl:text>  
                                        
                <xsl:value-of select="$newIndent"/>                                        
                <xsl:text>}&nl;&nl;</xsl:text>
                                        
            </xsl:when>
                
            <xsl:otherwise>                    
                <!-- bitfields without names are not stored -->                    
                <xsl:if test="not($descNode/@bitField != '' and $descNode/@bitKind = 'ignore')"> 
                        <xsl:call-template name="getPrimitiveFieldNames">
                            <xsl:with-param name="indent" select="$newIndent"/>
                            <xsl:with-param name="member" select="$member"/>                                                
                            <xsl:with-param name="descNode" select="$descNode"/>                        
                            <xsl:with-param name="separator" select="$separator"/>
                            <xsl:with-param name="parameters" select="$parameters"/>
                            <xsl:with-param name="indexStr" select="$indexStr"/>                        
                            <xsl:with-param name="indexVar" select="$indexVar"/>                        
                            <xsl:with-param name="caseStr" select="$caseStr"/>
                            <xsl:with-param name="caseVar" select="$caseVar"/>                                                                            
                            <xsl:with-param name="function" select="$function"/>                        
                        </xsl:call-template>                        
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>

        <xsl:if test="$isKey = 1 or $isKey = 0">
                        
            <xsl:value-of select="$indent"/>                
            <xsl:text>}&nl;&nl;</xsl:text>
        
        </xsl:if>                
                                                                    
    </xsl:template>
        
    <!-- declarePrimitiveField -->
    <xsl:template name="declarePrimitiveField">
        <xsl:param name="indent"/>
        <xsl:param name="member"/>
        <xsl:param name="descNode"/>
        <xsl:param name="memberKind"/>
        <xsl:param name="indexStr"/>            
        <xsl:param name="indexVar"/>                        
        <xsl:param name="caseStr"/>
        <xsl:param name="caseVar"/>                        
                                                                                                                  
        <xsl:text>nchar=snprintf(sql,max_sql_length+1,"\"%s%s</xsl:text> 
                                    
        <xsl:if test="name($member) = 'enum'">
            <xsl:value-of select="concat($indexStr,'\&quot; INTEGER %s')"/> 
        </xsl:if>
            
        <xsl:variable name="bfStr">
            <xsl:if test="$descNode/@bitField != ''">
                <xsl:text>:</xsl:text>
                <xsl:if test="$descNode/@bitKind ='lastBitField'">
                    <xsl:text>!</xsl:text>
                </xsl:if>
                <xsl:text>%d</xsl:text>
            </xsl:if>
            <xsl:text></xsl:text>
        </xsl:variable>
            
        <xsl:variable name="bfVar">
            <xsl:if test="$descNode/@bitField != ''">
                <xsl:text>,(int)(</xsl:text>
                <xsl:value-of select="$descNode/@bitField"/>
                <xsl:text>)</xsl:text>
            </xsl:if>
            <xsl:text></xsl:text>
        </xsl:variable>
            
        <xsl:if test="$memberKind = 'bitfield'">
            <xsl:value-of select="concat($caseStr,$member/@name,$bfStr,$indexStr,'\&quot; INTEGER %s')"/>                
        </xsl:if>
                                                                    
        <xsl:if test="$memberKind = 'scalar'">
            <xsl:choose>
                <xsl:when test="$descNode/@type = 'short' or $descNode/@type = 'unsignedshort'">
                    <xsl:value-of select="concat($caseStr,$member/@name,$indexStr,'\&quot; SMALLINT %s')"/>
                </xsl:when>
                <xsl:when test="$descNode/@type = 'long' or $descNode/@type = 'unsignedlong'">
                    <xsl:value-of select="concat($caseStr,$member/@name,$indexStr,'\&quot; INTEGER %s')"/>
                </xsl:when>                    
                <xsl:when test="$descNode/@type = 'char' or $descNode/@type = 'wchar'">
                    <xsl:value-of select="concat($caseStr,$member/@name,$indexStr,'\&quot; %s(1) %s %s')"/>
                </xsl:when>                                        
                <xsl:when test="$descNode/@type = 'octet'">
                    <xsl:value-of select="concat($caseStr,$member/@name,$indexStr,'\&quot; BINARY(1) %s')"/>
                </xsl:when>                                                                                                    
                <xsl:when test="$descNode/@type = 'boolean'">
                    <xsl:value-of select="concat($caseStr,$member/@name,$indexStr,'\&quot; TINYINT %s')"/>
                </xsl:when>                    
                <xsl:when test="$descNode/@type = 'double'">
                    <xsl:value-of select="concat($caseStr,$member/@name,$indexStr,'\&quot; DOUBLE %s')"/>
                </xsl:when>
                <xsl:when test="$descNode/@type = 'float'">
                    <xsl:value-of select="concat($caseStr,$member/@name,$indexStr,'\&quot; REAL %s')"/>
                </xsl:when>                    
                <xsl:when test="$descNode/@type = 'longlong' or $descNode/@type = 'unsignedlonglong'">
                    <xsl:value-of select="concat($caseStr,$member/@name,$indexStr,'\&quot; BIGINT %s')"/>
                </xsl:when>
                <xsl:when test="$descNode/@type = 'longdouble'">
                    <xsl:value-of select="concat($caseStr,$member/@name,$indexStr,'\&quot; BINARY(16) %s')"/>
                </xsl:when>                                                            
                <xsl:otherwise>                        
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
            
        <xsl:if test="$memberKind = 'string' or $memberKind = 'wstring'">
            <xsl:value-of select="concat($caseStr,$member/@name,$indexStr,'\&quot; %s(%d) %s %s')"/>                    
        </xsl:if>

        <xsl:text>,",</xsl:text>
        <xsl:text>name_prefix,delimiter</xsl:text>
        <xsl:value-of select="$caseVar"/>            
        <xsl:value-of select="$bfVar"/>                                
        <xsl:value-of select="$indexVar"/>                    
                                                
        <xsl:choose>
            <xsl:when test="$descNode/@type = 'char' and $memberKind != 'bitfield'">
                <xsl:text>,sqlChar,sqlCharAttribute,nullString);&nl;</xsl:text>
            </xsl:when>
            <xsl:when test="$descNode/@type = 'wchar' and $memberKind != 'bitfield'">
                <xsl:text>,sqlWChar,sqlWCharAttribute,nullString);&nl;</xsl:text>
            </xsl:when>                
            <xsl:when test="$memberKind = 'string'">
                <xsl:variable name="stringLength">
                    <xsl:call-template name="getBaseStringLength">
                        <xsl:with-param name="member" select="$member"/>    
                    </xsl:call-template>            
                </xsl:variable>        
                    
                <xsl:text>,sqlString,</xsl:text>                             
                <xsl:value-of select="$stringLength"/>
                <xsl:text>,sqlCharAttribute,nullString);&nl;</xsl:text>
            </xsl:when>                
            <xsl:when test="$memberKind = 'wstring'">
                <xsl:variable name="stringLength">
                    <xsl:call-template name="getBaseStringLength">
                        <xsl:with-param name="member" select="$member"/>    
                    </xsl:call-template>            
                </xsl:variable>        
                    
                <xsl:text>,sqlWString,</xsl:text>                                                 
                <xsl:value-of select="$stringLength"/>
                <xsl:text>,sqlWCharAttribute,nullString);&nl;</xsl:text>
            </xsl:when>                                
            <xsl:otherwise>
                <xsl:text>,nullString);&nl;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
                        
        <xsl:value-of select="$indent"/>
        <xsl:text>if (nchar >= (max_sql_length+1) || nchar &lt; 0) {&nl;</xsl:text>            
        <xsl:value-of select="$indent"/>            
        <xsl:text>    return NULL;&nl;</xsl:text>            
        <xsl:value-of select="$indent"/>                     
        <xsl:text>}&nl;</xsl:text>                           
        <xsl:value-of select="$indent"/>                                    
        <xsl:text>sql = sql + strlen(sql);&nl;</xsl:text>
        <xsl:value-of select="$indent"/>            
        <xsl:text>max_sql_length = max_sql_length - strlen(sql);&nl;&nl;</xsl:text>
                        
    </xsl:template>            
                     
    <!-- declareField -->
    <xsl:template name="declareField">
        <xsl:param name="indent"/>
        <xsl:param name="member"/>
        <xsl:param name="previousMemberKind" select="''"/>
        <xsl:param name="indexStr" select="''"/>            
        <xsl:param name="indexVar" select="''"/>  
        <xsl:param name="caseStr" select="''"/>  <!-- For unions members -->
        <xsl:param name="caseVar" select="''"/>  <!-- For unions members -->                              
                                                                                        
        <xsl:variable name="description">
            <xsl:call-template name="getMemberDescription">
                <xsl:with-param name="member" select="$member"/>
            </xsl:call-template>
        </xsl:variable>
            
        <xsl:variable name="descNode" select="xalan:nodeset($description)/node()"/>
                        
        <xsl:variable name="memberKind">
            <xsl:call-template name="getFilteredMemberKind">
                <xsl:with-param name="descNode"   select="$descNode"/>
                <xsl:with-param name="memberKindToFilter" select="$previousMemberKind"/>
            </xsl:call-template>
        </xsl:variable>
                                                                                                                                                                    
        <xsl:choose>            
            <xsl:when test="$memberKind = 'scalar' and $descNode/@typeKind = 'user' and
                            name($member) != 'enum'">                    
                    
                <xsl:if test="$member/@name != ''">
                    <xsl:call-template name="addStringToPrefix">
                        <xsl:with-param name="indent" select="$indent"/>
                        <xsl:with-param name="string" select="$member/@name"/>
                        <xsl:with-param name="indexStr" select="$indexStr"/>
                        <xsl:with-param name="indexVar" select="$indexVar"/>                            
                        <xsl:with-param name="caseStr" select="$caseStr"/>
                        <xsl:with-param name="caseVar" select="$caseVar"/>                                                    
                    </xsl:call-template>
                </xsl:if>                      
                    
                <xsl:value-of select="$indent"/>
                                        
                <xsl:text>sqlNew = </xsl:text><xsl:value-of select="$descNode/@type"/>
                <xsl:text>Plugin_get_create_table_field_dcl (connection_kind,</xsl:text>                    
                <xsl:text>name_prefix,max_name_prefix_length - strlen(namePrefixEndPtr),</xsl:text>
                <xsl:text>sql,max_sql_length,allow_null);&nl;</xsl:text>
                <xsl:value-of select="$indent"/>                                         
                <xsl:text>if (sqlNew == NULL) {&nl;</xsl:text>
                <xsl:value-of select="$indent"/>            
                <xsl:text>    return NULL;&nl;</xsl:text>            
                <xsl:value-of select="$indent"/>                     
                <xsl:text>}&nl;</xsl:text>                    
                <xsl:value-of select="$indent"/>                    
                <xsl:text>max_sql_length -= (sqlNew - sql);&nl;</xsl:text>                    
                <xsl:value-of select="$indent"/>                                        
                <xsl:text>sql = sqlNew;&nl;</xsl:text>                                  
                <xsl:value-of select="$indent"/>                          
                <xsl:text>*namePrefixEndPtr = '\0';&nl;&nl;</xsl:text>
                                                            
            </xsl:when>
                
            <xsl:when test="$memberKind = 'array' or 
                            $memberKind = 'arraySequence'">
                <xsl:variable name="cardinality">
                    <xsl:call-template name="getBaseCardinality">
                        <xsl:with-param name="member" select="$member"/>        
                    </xsl:call-template>                                                    
                </xsl:variable>                                        
                    
                <xsl:variable name="cardinalityNode" select="xalan:nodeset($cardinality)/node()"/>
                
                <xsl:variable name="arrIndexStr">
                    <xsl:call-template name="generateIndexStr">
                        <xsl:with-param name="memberKind" select="$memberKind"/>
                        <xsl:with-param name="cardinalityNode" select="$cardinalityNode"/>
                    </xsl:call-template>                                                                            
                </xsl:variable>
                    
                <xsl:variable name="arrIndexVar">
                    <xsl:call-template name="generateIndexVar">
                        <xsl:with-param name="memberKind" select="$memberKind"/>
                        <xsl:with-param name="cardinalityNode" select="$cardinalityNode"/>                            
                    </xsl:call-template>                                                                            
                </xsl:variable>
                                                                                                    
                <xsl:value-of select="$indent"/>
                <xsl:text>{&nl;</xsl:text>
                <xsl:value-of select="$indent"/>
                <xsl:text>    int indexArr[</xsl:text>
                <xsl:value-of select="count($cardinalityNode/dimension)"/>
                <xsl:text>];&nl;</xsl:text>                    
                    
                <xsl:call-template name="generateArrayLoopForDeclareField">
                    <xsl:with-param name="indent" select="concat($indent,'    ')"/>                        
                    <xsl:with-param name="cardinalityNode" select="$cardinalityNode"/>            
                    <xsl:with-param name="member" select="$member"/>     
                    <xsl:with-param name="memberKind" select="$memberKind"/>                        
                    <xsl:with-param name="indexStr" select="$arrIndexStr"/>                        
                    <xsl:with-param name="indexVar" select="$arrIndexVar"/>
                    <xsl:with-param name="caseStr" select="$caseStr"/>
                    <xsl:with-param name="caseVar" select="$caseVar"/>                        
                </xsl:call-template>                        
                                                        
                <xsl:value-of select="$indent"/>                                        
                <xsl:text>}&nl;&nl;</xsl:text> 
                                                                                            
            </xsl:when>
                                
            <xsl:when test="$memberKind = 'sequence'">
                <xsl:variable name="length">
                    <xsl:call-template name="getBaseSequenceLength">
                        <xsl:with-param name="member" select="$member"/>        
                    </xsl:call-template>                                                    
                </xsl:variable>                    
                                        
                <xsl:variable name="seqIndexStr">
                    <xsl:value-of select="$indexStr"/>                        
                    <xsl:call-template name="generateIndexStr">
                        <xsl:with-param name="memberKind" select="$memberKind"/>
                    </xsl:call-template>                                                                            
                </xsl:variable>
                    
                <xsl:variable name="seqIndexVar">
                    <xsl:value-of select="$indexVar"/>
                    <xsl:call-template name="generateIndexVar">
                        <xsl:with-param name="memberKind" select="$memberKind"/>
                    </xsl:call-template>                                                                            
                </xsl:variable>
                                                                                
                <xsl:value-of select="$indent"/>
                <xsl:text>{&nl;</xsl:text>
                <xsl:value-of select="$indent"/>
                <xsl:text>    int i;&nl;</xsl:text>                    
                <xsl:value-of select="$indent"/>                    
                <xsl:text>    DDS_Boolean oldAllowNull;&nl;</xsl:text>                                        
                  
                <xsl:variable name="lengthElement">
                    <xsl:call-template name="createSeqLengthElement">
                        <xsl:with-param name="name" select="concat($member/@name,$indexStr)"/>
                        <xsl:with-param name="caseStr" select="$caseStr"/>
                        <xsl:with-param name="caseVar" select="$caseVar"/>                                                    
                    </xsl:call-template>
                </xsl:variable>  
                    
                <xsl:variable name="lengthNode" select="xalan:nodeset($lengthElement)/node()"/>
                    
                <xsl:call-template name="declareField">
                    <xsl:with-param name="indent" select="concat($indent,'    ')"/>
                    <xsl:with-param name="member" select="$lengthNode"/>
                    <xsl:with-param name="indexStr" select="''"/>
                    <xsl:with-param name="indexVar" select="$indexVar"/>                        
                    <xsl:with-param name="caseStr" select="$caseStr"/>
                    <xsl:with-param name="caseVar" select="$caseVar"/>                        
                </xsl:call-template>                        
                    
                <xsl:value-of select="$indent"/>                                                     
                <xsl:text>    oldAllowNull = allow_null;&nl;</xsl:text>                    
                <xsl:value-of select="$indent"/>                    
                <xsl:text>    allow_null = DDS_BOOLEAN_TRUE;&nl;</xsl:text>                                        
                <xsl:value-of select="$indent"/>                    
                <xsl:text>    strcpy(nullString,"NULL");&nl;</xsl:text>
                                                                                                                        
                <xsl:value-of select="$indent"/>                 
                <xsl:text>    for (i=0;i&lt;</xsl:text><xsl:value-of select="$length"/>
                <xsl:text>;i++) {&nl;&nl;</xsl:text>
                                                                                                                                        
                <xsl:call-template name="declareField">
                    <xsl:with-param name="indent" select="concat($indent,'        ')"/>
                    <xsl:with-param name="member" select="$member"/>
                    <xsl:with-param name="previousMemberKind" select="$memberKind"/>
                    <xsl:with-param name="indexStr" select="$seqIndexStr"/>
                    <xsl:with-param name="indexVar" select="$seqIndexVar"/>
                    <xsl:with-param name="caseStr" select="$caseStr"/>
                    <xsl:with-param name="caseVar" select="$caseVar"/>                        
                </xsl:call-template>

                <xsl:value-of select="$indent"/>                                                                            
                <xsl:text>    }&nl;</xsl:text>  
                <xsl:value-of select="$indent"/>
                <xsl:text>    allow_null = oldAllowNull;&nl;</xsl:text>
                <xsl:value-of select="$indent"/>
                <xsl:text>    if (allow_null == DDS_BOOLEAN_FALSE) {&nl;</xsl:text>                    
                <xsl:value-of select="$indent"/>
                <xsl:text>        strcpy(nullString,"NOT NULL");&nl;</xsl:text>                    
                <xsl:value-of select="$indent"/>
                <xsl:text>    }&nl;</xsl:text>                    
                <xsl:value-of select="$indent"/>                                        
                <xsl:text>}&nl;&nl;</xsl:text>
                    
            </xsl:when>
                
            <xsl:otherwise>                                        
                <!-- bitfields without names are not stored -->                    
                <xsl:if test="not($descNode/@bitField != '' and $descNode/@bitKind = 'ignore')">
                    <xsl:value-of select="$indent"/>                    
                    <xsl:call-template name="declarePrimitiveField">
                        <xsl:with-param name="indent" select="$indent"/>
                        <xsl:with-param name="member" select="$member"/>
                        <xsl:with-param name="descNode" select="$descNode"/>                    
                        <xsl:with-param name="memberKind" select="$memberKind"/>                        
                        <xsl:with-param name="indexStr" select="$indexStr"/>            
                        <xsl:with-param name="indexVar" select="$indexVar"/>                                                
                        <xsl:with-param name="caseStr" select="$caseStr"/>
                        <xsl:with-param name="caseVar" select="$caseVar"/>                        
                    </xsl:call-template>                        
                </xsl:if>                                            
            </xsl:otherwise>
                
        </xsl:choose>
                                                                                                                                                
    </xsl:template>

    <!-- bindPrimitiveParameters -->
    <xsl:template name="bindPrimitiveParameters">
        <xsl:param name="indent"/>            
        <xsl:param name="member"/>                                                
        <xsl:param name="memberKind"/>            
        <xsl:param name="descNode"/>
        <xsl:param name="memberPointer"/>            
                    
        <xsl:value-of select="$indent"/>
            
        <xsl:if test="name($member) = 'enum'">
            <xsl:text>returnCode=SQLBindParameter(hStmt,(short)index,SQL_PARAM_INPUT,SQL_C_SLONG,SQL_INTEGER,0,0,</xsl:text>
            <xsl:value-of select="$memberPointer"/><xsl:text>,0,StrLen_or_IndPtr);</xsl:text>                
        </xsl:if>            
                                                
        <xsl:if test="$memberKind = 'scalar'">
            <xsl:choose>
                <xsl:when test="$descNode/@type = 'short'">
                    <xsl:text>returnCode=SQLBindParameter(hStmt,(short)index,SQL_PARAM_INPUT,SQL_C_SSHORT,SQL_SMALLINT,0,0,</xsl:text>
                    <xsl:value-of select="$memberPointer"/><xsl:text>,0,StrLen_or_IndPtr);</xsl:text>
                </xsl:when>
                <xsl:when test="$descNode/@type = 'unsignedshort'">
                    <xsl:text>returnCode=SQLBindParameter(hStmt,(short)index,SQL_PARAM_INPUT,SQL_C_USHORT,SQL_SMALLINT,0,0,</xsl:text>
                    <xsl:value-of select="$memberPointer"/><xsl:text>,0,StrLen_or_IndPtr);</xsl:text>
                </xsl:when>                    
                <xsl:when test="$descNode/@type = 'long'">
                    <xsl:text>returnCode=SQLBindParameter(hStmt,(short)index,SQL_PARAM_INPUT,SQL_C_SLONG,SQL_INTEGER,0,0,</xsl:text>
                    <xsl:value-of select="$memberPointer"/><xsl:text>,0,StrLen_or_IndPtr);</xsl:text>                        
                </xsl:when>
                <xsl:when test="$descNode/@type = 'unsignedlong'">
                    <xsl:text>returnCode=SQLBindParameter(hStmt,(short)index,SQL_PARAM_INPUT,SQL_C_ULONG,SQL_INTEGER,0,0,</xsl:text>
                    <xsl:value-of select="$memberPointer"/><xsl:text>,0,StrLen_or_IndPtr);</xsl:text>                        
                </xsl:when>                                                            
                <xsl:when test="$descNode/@type = 'char'">                        
                    <xsl:text>returnCode=SQLBindParameter(hStmt,(short)index,SQL_PARAM_INPUT,SQL_C_CHAR,SQL_CHAR,sizeof(DDS_Char),0,</xsl:text>
                    <xsl:value-of select="$memberPointer"/><xsl:text>,sizeof(DDS_Char),StrLen_or_IndPtr);</xsl:text>                        
                </xsl:when>
                <xsl:when test="$descNode/@type = 'wchar'">
                    <xsl:text>{&nl;</xsl:text>
                    <xsl:value-of select="$indent"/>                        
                    <xsl:text>SQLWCHAR * wchar;&nl;&nl;</xsl:text>
                    <xsl:value-of select="$indent"/>
                    <xsl:text>DDSQL_GET_SQLWCHAR_POINTER(wchar,</xsl:text>
                    <xsl:value-of select="$memberPointer"/><xsl:text>);&nl;</xsl:text>
                    <xsl:value-of select="$indent"/>
                    <xsl:text>returnCode=SQLBindParameter(hStmt,(short)index,SQL_PARAM_INPUT,SQL_C_WCHAR,SQL_WCHAR,0,0,</xsl:text>
                    <xsl:text>wchar,sizeof(SQLWCHAR),StrLen_or_IndPtr);</xsl:text>
                    <xsl:value-of select="$indent"/>                        
                    <xsl:text>}</xsl:text>
                </xsl:when>                    
                <xsl:when test="$descNode/@type = 'octet'">
                    <xsl:text>returnCode=SQLBindParameter(hStmt,(short)index,SQL_PARAM_INPUT,SQL_C_BINARY,SQL_BINARY,sizeof(DDS_Octet),0,</xsl:text>
                    <xsl:value-of select="$memberPointer"/><xsl:text>,sizeof(DDS_Octet),StrLen_or_IndPtr);</xsl:text>                        
                </xsl:when>                                                                                                    
                <xsl:when test="$descNode/@type = 'boolean'">
                    <xsl:text>returnCode=SQLBindParameter(hStmt,(short)index,SQL_PARAM_INPUT,SQL_C_UTINYINT,SQL_TINYINT,0,0,</xsl:text>
                    <xsl:value-of select="$memberPointer"/><xsl:text>,0,StrLen_or_IndPtr);</xsl:text>                        
                </xsl:when>                    
                <xsl:when test="$descNode/@type = 'double'">
                    <xsl:text>returnCode=SQLBindParameter(hStmt,(short)index,SQL_PARAM_INPUT,SQL_C_DOUBLE,SQL_DOUBLE,0,0,</xsl:text>
                    <xsl:value-of select="$memberPointer"/><xsl:text>,0,StrLen_or_IndPtr);</xsl:text>                        
                </xsl:when>
                <xsl:when test="$descNode/@type = 'float'">
                    <xsl:text>returnCode=SQLBindParameter(hStmt,(short)index,SQL_PARAM_INPUT,SQL_C_FLOAT,SQL_REAL,0,0,</xsl:text>
                    <xsl:value-of select="$memberPointer"/><xsl:text>,0,StrLen_or_IndPtr);</xsl:text>                        
                </xsl:when>                    
                <xsl:when test="$descNode/@type = 'longlong'">
                    <xsl:text>returnCode=SQLBindParameter(hStmt,(short)index,SQL_PARAM_INPUT,SQL_C_SBIGINT,SQL_BIGINT,0,0,</xsl:text>
                    <xsl:value-of select="$memberPointer"/><xsl:text>,0,StrLen_or_IndPtr);</xsl:text>                        
                </xsl:when>
                <xsl:when test="$descNode/@type = 'unsignedlonglong'">
                    <xsl:text>returnCode=SQLBindParameter(hStmt,(short)index,SQL_PARAM_INPUT,SQL_C_SBIGINT,SQL_BIGINT,0,0,</xsl:text>
                    <xsl:value-of select="$memberPointer"/><xsl:text>,0,StrLen_or_IndPtr);</xsl:text>                        
                </xsl:when>                    
                <xsl:when test="$descNode/@type = 'longdouble'">
                    <xsl:text>returnCode=SQLBindParameter(hStmt,(short)index,SQL_PARAM_INPUT,SQL_C_BINARY,SQL_BINARY,0,0,</xsl:text>
                    <xsl:value-of select="$memberPointer"/><xsl:text>,128,StrLen_or_IndPtr);</xsl:text>
                </xsl:when>                                                        
                <xsl:otherwise>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
            
        <xsl:if test="$memberKind = 'string'">
            <xsl:text>{&nl;</xsl:text>
            <xsl:value-of select="$indent"/>                                    
            <xsl:text>    int length;&nl;</xsl:text>                
            <xsl:value-of select="$indent"/>
            <xsl:text>    length=strlen(*(</xsl:text><xsl:value-of select="$memberPointer"/><xsl:text>)) + 1;&nl;</xsl:text>
            <xsl:value-of select="$indent"/>
            <xsl:text>    returnCode=SQLBindParameter(hStmt,(short)index,SQL_PARAM_INPUT,SQL_C_CHAR,SQL_VARCHAR,0,0,</xsl:text>
            <xsl:text>*(</xsl:text><xsl:value-of select="$memberPointer"/>)<xsl:text>,length,StrLen_or_IndPtr);&nl;</xsl:text>
            <xsl:value-of select="$indent"/>                                
            <xsl:text>}</xsl:text>                
        </xsl:if>
                                                                                    
        <xsl:text>&nl;&nl;</xsl:text>
        <xsl:value-of select="$indent"/>
        <xsl:text>if (returnCode != SQL_SUCCESS){&nl;</xsl:text>
        <xsl:value-of select="$indent"/>
        <xsl:text>    return -1;&nl;</xsl:text>
        <xsl:value-of select="$indent"/>            
        <xsl:text>}&nl;&nl;</xsl:text>

        <xsl:value-of select="$indent"/>                        
        <xsl:text>index++;&nl;</xsl:text>
                                
    </xsl:template>

    <!-- bindParameter -->
    <xsl:template name="bindParameters">
        <xsl:param name="indent"/>            
        <xsl:param name="member"/>        
        <xsl:param name="isKey" select="-1"/>            
        <!-- overwrite the member pointer extracted from member -->            
        <xsl:param name="defaultMemberPointer" select="''"/>
        <xsl:param name="previousMemberKind" select="''"/>
                                                
        <xsl:variable name="description">
            <xsl:call-template name="getMemberDescription">
                <xsl:with-param name="member" select="$member"/>
            </xsl:call-template>
        </xsl:variable>
            
        <xsl:variable name="descNode" select="xalan:nodeset($description)/node()"/>

        <xsl:variable name="memberKind">
            <xsl:call-template name="getFilteredMemberKind">
                <xsl:with-param name="descNode"   select="$descNode"/>
                <xsl:with-param name="memberKindToFilter" select="$previousMemberKind"/>
            </xsl:call-template>
        </xsl:variable>
                                                                                                   
        <xsl:if test="$isKey = 1">
            <xsl:value-of select="$indent"/>                            
            <xsl:text>if (fields_mask &amp; DDSQL_KEY_FIELDS) {&nl;</xsl:text>                                
        </xsl:if>            
        <xsl:if test="$isKey = 0">
            <xsl:value-of select="$indent"/>                          
            <xsl:text>if (fields_mask &amp; DDSQL_NO_KEY_FIELDS) {&nl;</xsl:text>                                
        </xsl:if>                        
                                    
        <xsl:variable name="newIndent">
            <xsl:value-of select="$indent"/>
            <xsl:if test="$isKey = 1 or $isKey=0">
                <xsl:value-of select="'    '"/>
            </xsl:if>
        </xsl:variable>                
            
        <xsl:if test="$defaultMemberPointer = '' and name($member) != 'discriminator' and
                      $member/../@kind = 'union'">
            <xsl:value-of select="$newIndent"/>                            
            <xsl:text>if (oldAssignNull != DDS_BOOLEAN_TRUE &amp;&amp; (</xsl:text>                                                            
           
            <xsl:choose>
                <xsl:when test="not($member/cases/case[@value='default'])">                        
                    <xsl:for-each select="$member/cases/case">
                        <xsl:value-of select="'sample-&gt;_d'"/>
                        <xsl:text>== (int)(</xsl:text>
                        <xsl:value-of select="./@value"/>
                        <xsl:text>)</xsl:text>
            
                        <xsl:if test="position()!=last()">
                            <xsl:text> || </xsl:text>
                        </xsl:if>
                    </xsl:for-each>                
                               
                    <xsl:text>)) {&nl;</xsl:text>                                    

                    <xsl:value-of select="$newIndent"/>                                                        
                    <xsl:text>    assign_null = DDS_BOOLEAN_FALSE;&nl;</xsl:text>    
                    <xsl:value-of select="$newIndent"/>                                            
                    <xsl:text>    StrLen_or_IndPtr = NULL;&nl;</xsl:text>
                    <xsl:value-of select="$newIndent"/>                                                            
                    <xsl:text>    isDefault = DDS_BOOLEAN_FALSE;&nl;</xsl:text>                
                
                </xsl:when>
                <xsl:otherwise> <!-- default case for unions -->
                    <xsl:text>isDefault == DDS_BOOLEAN_TRUE)) {&nl;</xsl:text>                        
                    <xsl:value-of select="$newIndent"/>                                                        
                    <xsl:text>    assign_null = DDS_BOOLEAN_FALSE;&nl;</xsl:text>    
                    <xsl:value-of select="$newIndent"/>                                            
                    <xsl:text>    StrLen_or_IndPtr = NULL;&nl;</xsl:text>                        
                </xsl:otherwise>
                    
            </xsl:choose>
                
            <xsl:value-of select="$newIndent"/>                                                            
            <xsl:text>}&nl;</xsl:text>

        </xsl:if>
                                                                                                         
        <xsl:choose>
            <xsl:when test="$memberKind = 'scalar' and $descNode/@typeKind = 'user' and
                            name($member) != 'enum'">                    
                <xsl:variable name="memberPointer">
                    <xsl:call-template name="generateMemberPtr">
                        <xsl:with-param name="member" select="$member"/>
                        <xsl:with-param name="memberKind" select="$memberKind"/>
                        <xsl:with-param name="defaultMemberPointer" select="$defaultMemberPointer"/>                        
                    </xsl:call-template>                    
                </xsl:variable>                                
                    
                <xsl:value-of select="$newIndent"/>                    
                <xsl:text>index = </xsl:text><xsl:value-of select="$descNode/@type"/>
                <xsl:text>Plugin_bind_parameters(hStmt,index,</xsl:text>
                <xsl:value-of select="$memberPointer"/>
                <xsl:text>,DDSQL_KEY_FIELDS|DDSQL_NO_KEY_FIELDS,assign_null);&nl;</xsl:text>
                <xsl:value-of select="$newIndent"/>                                         
                <xsl:text>if (index == -1) {&nl;</xsl:text>
                <xsl:value-of select="$newIndent"/>            
                <xsl:text>    return -1;&nl;</xsl:text>            
                <xsl:value-of select="$newIndent"/>                     
                <xsl:text>}&nl;</xsl:text>                    
            </xsl:when>
                
            <xsl:when test="$memberKind = 'array' or 
                            $memberKind = 'arraySequence'">
                <xsl:variable name="cardinality">
                    <xsl:call-template name="getBaseCardinality">
                        <xsl:with-param name="member" select="$member"/>        
                    </xsl:call-template>                                                    
                </xsl:variable>                                        
                    
                <xsl:variable name="cardinalityNode" select="xalan:nodeset($cardinality)/node()"/>
                    
                <xsl:value-of select="$indent"/>
                <xsl:text>{&nl;</xsl:text>
                <xsl:value-of select="$indent"/>
                <xsl:text>    int indexArr[</xsl:text>
                <xsl:value-of select="count($cardinalityNode/dimension)"/>
                <xsl:text>];&nl;</xsl:text>
                    
                <xsl:variable name="memberPointer">
                    <xsl:call-template name="generateMemberPtr">
                        <xsl:with-param name="member" select="$member"/>
                        <xsl:with-param name="memberKind" select="$memberKind"/>
                        <xsl:with-param name="cardinalityNode" select="$cardinalityNode"/>
                        <xsl:with-param name="defaultMemberPointer" select="$defaultMemberPointer"/>                        
                    </xsl:call-template>                    
                </xsl:variable>
                                                                            
                <xsl:call-template name="generateArrayLoopForBindParameter">
                    <xsl:with-param name="indent" select="concat($indent,'    ')"/>                                           
                    <xsl:with-param name="cardinalityNode" select="$cardinalityNode"/>            
                    <xsl:with-param name="memberKind" select="$memberKind"/>
                    <xsl:with-param name="member" select="$member"/>            
                    <xsl:with-param name="defaultMemberPointer" select="$memberPointer"/>
                </xsl:call-template>
                    
                <xsl:value-of select="$indent"/>                                        
                <xsl:text>}&nl;&nl;</xsl:text> 
                                                                                                                
            </xsl:when>                
                
            <xsl:when test="$memberKind = 'sequence'">                    
                <xsl:variable name="length">
                    <xsl:call-template name="getBaseSequenceLength">
                        <xsl:with-param name="member" select="$member"/>        
                    </xsl:call-template>                                                    
                </xsl:variable>                    
                    
                <xsl:value-of select="$newIndent"/>
                <xsl:text>{&nl;</xsl:text>
                <xsl:value-of select="$newIndent"/>
                <xsl:text>    int i;&nl;</xsl:text>                    
                <xsl:value-of select="$newIndent"/>                    
                <xsl:text>    DDS_Long length;&nl;</xsl:text>                    
                <xsl:value-of select="$newIndent"/>                    
                <xsl:text>    DDS_Boolean oldAssignNull;&nl;</xsl:text>                    
                <xsl:value-of select="$newIndent"/>                    
                <xsl:text>    oldAssignNull = assign_null;&nl;&nl;</xsl:text>                                        
                    
                <xsl:variable name="memberPointer1">
                    <xsl:call-template name="generateMemberPtr">
                        <xsl:with-param name="member" select="$member"/>
                        <xsl:with-param name="memberKind" select="'scalar'"/>
                        <xsl:with-param name="defaultMemberPointer" select="$defaultMemberPointer"/>                        
                    </xsl:call-template>                    
                </xsl:variable>                                
                    
                <xsl:value-of select="$newIndent"/>                                                            
                <xsl:text>    length = </xsl:text>
                <xsl:value-of select="concat('(',$memberPointer1,')->_length')"/>
                <xsl:text>;&nl;</xsl:text>
                                      
                <xsl:variable name="lengthElement">
                    <xsl:call-template name="createSeqLengthElement">
                        <xsl:with-param name="name" select="$member/@name"/>
                    </xsl:call-template>
                </xsl:variable>
                                                            
                <xsl:variable name="lengthNode" select="xalan:nodeset($lengthElement)/node()"/>
                                                                                                                                            
                <xsl:call-template name="bindParameters">
                    <xsl:with-param name="indent" select="concat($newIndent,'    ')"/>            
                    <xsl:with-param name="member" select="$lengthNode"/>        
                    <xsl:with-param name="isKey" select="-1"/>            
                    <xsl:with-param name="defaultMemberPointer" select="concat('&amp;(',$memberPointer1,')->_length')"/>                        
                </xsl:call-template>                        
                    
                <xsl:value-of select="$newIndent"/>                 
                <xsl:text>    for (i=0;i&lt;</xsl:text><xsl:value-of select="$length"/>
                <xsl:text>;i++) {&nl;&nl;</xsl:text>
                    
                <xsl:value-of select="$newIndent"/>
                <xsl:text>        if (i >= length) {&nl;</xsl:text>
                <xsl:value-of select="$newIndent"/>
                <xsl:text>            assign_null = DDS_BOOLEAN_TRUE;&nl;</xsl:text>
                <xsl:value-of select="$newIndent"/>
                <xsl:text>            StrLen_or_IndPtr = &amp;sqlNullData;&nl;</xsl:text>                    
                <xsl:value-of select="$newIndent"/>
                <xsl:text>        }&nl;</xsl:text>
                    
                <xsl:variable name="memberPointer2">
                    <xsl:call-template name="generateMemberPtr">
                        <xsl:with-param name="member" select="$member"/>
                        <xsl:with-param name="memberKind" select="$memberKind"/>
                        <xsl:with-param name="defaultMemberPointer" select="$defaultMemberPointer"/>                        
                    </xsl:call-template>                    
                </xsl:variable>                                
                                                                                
                <xsl:call-template name="bindParameters">
                    <xsl:with-param name="indent" select="concat($newIndent,'        ')"/>            
                    <xsl:with-param name="member" select="$member"/>        
                    <xsl:with-param name="isKey" select="-1"/>            
                    <xsl:with-param name="defaultMemberPointer" select="$memberPointer2"/>
                    <xsl:with-param name="previousMemberKind" select="$memberKind"/>                        
                </xsl:call-template>                        
                                                                                
                <xsl:value-of select="$newIndent"/>                                                                            
                <xsl:text>    }&nl;&nl;</xsl:text>  
                    
                <xsl:value-of select="$newIndent"/>                    
                <xsl:text>    assign_null = oldAssignNull;&nl;</xsl:text>
                <xsl:value-of select="$newIndent"/>                    
                <xsl:text>    if (assign_null == DDS_BOOLEAN_FALSE) {&nl;</xsl:text>
                <xsl:value-of select="$newIndent"/>                    
                <xsl:text>        StrLen_or_IndPtr = NULL;&nl;</xsl:text>
                <xsl:value-of select="$newIndent"/>                    
                <xsl:text>    }&nl;</xsl:text>
                <xsl:value-of select="$newIndent"/>                                        
                <xsl:text>}&nl;&nl;</xsl:text>
                                                                                
            </xsl:when>
                
            <xsl:otherwise>
                <xsl:if test="$memberKind != 'bitfield'">
                    <xsl:variable name="memberPointer">
                        <xsl:call-template name="generateMemberPtr">
                            <xsl:with-param name="member" select="$member"/>
                            <xsl:with-param name="memberKind" select="$memberKind"/>
                            <xsl:with-param name="defaultMemberPointer" select="$defaultMemberPointer"/>                        
                        </xsl:call-template>                    
                    </xsl:variable>                                
                                                            
                    <xsl:call-template name="bindPrimitiveParameters">
                        <xsl:with-param name="indent" select="$newIndent"/>            
                        <xsl:with-param name="member" select="$member"/>                                    
                        <xsl:with-param name="memberKind" select="$memberKind"/>                                                            
                        <xsl:with-param name="descNode" select="$descNode"/>
                        <xsl:with-param name="memberPointer" select="$memberPointer"/>            
                    </xsl:call-template>                     
                </xsl:if>                                                       
            </xsl:otherwise>
        </xsl:choose>
            
        <xsl:if test="$defaultMemberPointer = '' and name($member) != 'discriminator' and
                      $member/../@kind = 'union'">
            <xsl:value-of select="$newIndent"/>                                                        
            <xsl:text>assign_null = DDS_BOOLEAN_TRUE;&nl;</xsl:text>    
            <xsl:value-of select="$newIndent"/>                                            
            <xsl:text>StrLen_or_IndPtr = &amp;sqlNullData;&nl;</xsl:text>
        </xsl:if>
                        
        <xsl:if test="$isKey = 1 or $isKey = 0">
            <xsl:value-of select="$indent"/>                
            <xsl:text>}&nl;&nl;</xsl:text>
        </xsl:if>                
                        
    </xsl:template>
        
    <!-- executeStatement -->        
    <xsl:template name="executeStatement">
        <xsl:param name="indent"/>
        <xsl:param name="prepare"/> <!-- 1/0 -->
        <xsl:param name="reportWarningAsError" select="1"/>

        <xsl:if test="$prepare = 1">

            <xsl:value-of select="$indent"/>                        
            <xsl:text>odbcReturnCode=SQLPrepare(hStmt,(SQLCHAR *)sql,SQL_NTS);&nl;</xsl:text>
            <xsl:value-of select="$indent"/>
            <xsl:text>if (odbcReturnCode != SQL_SUCCESS){&nl;</xsl:text>
            <xsl:value-of select="$indent"/>                
            <xsl:text>    goto end;&nl;</xsl:text>
            <xsl:value-of select="$indent"/>            
            <xsl:text>}&nl;&nl;</xsl:text>

        </xsl:if>

        <xsl:value-of select="$indent"/>            

        <xsl:if test="$prepare = 1">
            <xsl:text>odbcReturnCode=SQLExecute(hStmt);&nl;</xsl:text>
        </xsl:if>
        <xsl:if test="$prepare = 0">
            <xsl:text>odbcReturnCode=SQLExecDirect(hStmt,(SQLCHAR *)sql,SQL_NTS);&nl;</xsl:text>
        </xsl:if>

        <xsl:value-of select="$indent"/>            

        <xsl:if test="$reportWarningAsError = 1">
            <xsl:text>if (odbcReturnCode != SQL_SUCCESS){&nl;</xsl:text>
        </xsl:if>
        <xsl:if test="$reportWarningAsError = 0">
            <xsl:text>if (odbcReturnCode != SQL_SUCCESS &amp;&amp; odbcReturnCode != SQL_SUCCESS_WITH_INFO){&nl;</xsl:text>
        </xsl:if>

        <xsl:value-of select="$indent"/>                        
        <xsl:text>    goto end;&nl;</xsl:text>
        <xsl:value-of select="$indent"/>            
        <xsl:text>}&nl;</xsl:text>
    </xsl:template>

    <xsl:template name="checkSQLStatementLength">
        <xsl:param name="indent"/>                            
        <xsl:value-of select="$indent"/>
        <xsl:text>if (nchar >= (DDSQL_SQL_STATEMENT_MAX_LENGTH + 1) || nchar &lt; 0) {&nl;</xsl:text>
        <xsl:value-of select="$indent"/>
        <xsl:text>    ddsqlReturnCode = DDSQL_RETCODE_DBMS_ERROR;&nl;</xsl:text>            
        <xsl:value-of select="$indent"/>
        <xsl:text>    strcpy(connection->errorMessage,"SQL statement too long");&nl;</xsl:text>
        <xsl:value-of select="$indent"/>
        <xsl:text>    goto end;&nl;</xsl:text>
        <xsl:value-of select="$indent"/>                        
        <xsl:text>}&nl;&nl;</xsl:text>
    </xsl:template>            
                
    <!-- isKey -->
    <xsl:template name="isKey">
        <xsl:param name="member"/>            
        <xsl:choose>
            <xsl:when test="$member[following-sibling::node()
                           [position() = 1 and name() = 'directive' and @kind = 'key']]">
                <xsl:value-of select="1"/>                        
            </xsl:when>
            <xsl:otherwise>                        
                <xsl:value-of select="0"/>
            </xsl:otherwise>
        </xsl:choose>            
    </xsl:template>
        
    <!-- concatenatePrefix -->
    <xsl:template name="addStringToPrefix">
        <xsl:param name="indent"/>
        <xsl:param name="string"/>
        <xsl:param name="indexStr"/>
        <xsl:param name="indexVar"/>            
        <xsl:param name="caseStr"/>
        <xsl:param name="caseVar"/>            
                                            
        <xsl:value-of select="$indent"/>
            
        <xsl:text>nchar = snprintf(namePrefixEndPtr,max_name_prefix_length+1,"%s</xsl:text>
        <xsl:value-of select="$caseStr"/>
        <xsl:text>%s</xsl:text>
        <xsl:value-of select="$indexStr"/>
        <xsl:text>",</xsl:text>                                
                        
        <xsl:text>delimiter</xsl:text>
        <xsl:value-of select="$caseVar"/>            
        <xsl:text>,"</xsl:text>
        <xsl:value-of select="$string"/>
        <xsl:text>"</xsl:text>

        <xsl:value-of select="$indexVar"/>
                                    
        <xsl:text>);&nl;</xsl:text>
            
        <xsl:value-of select="$indent"/>
        <xsl:text>if (nchar >= (max_name_prefix_length+1) || nchar &lt; 0) {&nl;</xsl:text>            
        <xsl:value-of select="$indent"/>            
        <xsl:text>    return NULL;&nl;</xsl:text>            
        <xsl:value-of select="$indent"/>
        <xsl:text>}&nl;</xsl:text>                    
    </xsl:template>

    <!-- createSeqLengthElement -->        
    <xsl:template name="createSeqLengthElement">
        <xsl:param name="name"/>
        <member enum="no" type="long" name="{concat($name,'#length')}"/>                    
    </xsl:template>
        
    <!-- generateArrayLoopForGetFieldNames -->                               
    <xsl:template name="generateArrayLoopForGetFieldNames">
        <xsl:param name="indent"/>                        
        <xsl:param name="cardinalityNode"/>            
        <xsl:param name="level" select="1"/>            
        <xsl:param name="member"/>     
        <xsl:param name="memberKind"/>                        
        <xsl:param name="indexStr"/>                        
        <xsl:param name="indexVar"/>
        <xsl:param name="parameters"/>     
        <xsl:param name="separator"/>
        <xsl:param name="function"/>
        <xsl:param name="caseStr"/>
        <xsl:param name="caseVar"/>                        
        <xsl:param name="defaultMemberPointer"/>            
                        
        <xsl:variable name="index">
            <xsl:value-of select="concat('indexArr[',$level -1 ,']')"/>
        </xsl:variable>   
                     
        <xsl:value-of select="$indent"/>                 
        <xsl:text>for (</xsl:text>
        <xsl:value-of select="$index"/>
        <xsl:text>=0;</xsl:text>
        <xsl:value-of select="$index"/>            
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="$cardinalityNode/dimension[$level]/@size"/>
        <xsl:text>;</xsl:text>
        <xsl:value-of select="$index"/>                        
        <xsl:text>++) {&nl;</xsl:text>
        
        <xsl:choose>
            <xsl:when test="$level &lt; count($cardinalityNode/dimension)">
                <xsl:call-template name="generateArrayLoopForGetFieldNames">
                    <xsl:with-param name="indent" select="concat($indent,'    ')"/>                        
                    <xsl:with-param name="cardinalityNode" select="$cardinalityNode"/>            
                    <xsl:with-param name="level" select="$level + 1"/>
                    <xsl:with-param name="member" select="$member"/>                        
                    <xsl:with-param name="memberKind" select="$memberKind"/>                                                
                    <xsl:with-param name="indexStr" select="$indexStr"/>                                                    
                    <xsl:with-param name="indexVar" select="$indexVar"/>                          
                    <xsl:with-param name="parameters" select="$parameters"/>     
                    <xsl:with-param name="separator" select="$separator"/>
                    <xsl:with-param name="function" select="$function"/>
                    <xsl:with-param name="caseStr" select="$caseStr"/>
                    <xsl:with-param name="caseVar" select="$caseVar"/>                                                                        
                    <xsl:with-param name="defaultMemberPointer" select="$defaultMemberPointer"/>                        
                </xsl:call-template>                                                        
            </xsl:when>                
            <xsl:otherwise>                    
                <xsl:call-template name="getFieldNames">
                    <xsl:with-param name="indent" select="concat($indent,'    ')"/>
                    <xsl:with-param name="member" select="$member"/>
                    <xsl:with-param name="previousMemberKind" select="$memberKind"/> 
                    <xsl:with-param name="indexStr" select="$indexStr"/>                                                    
                    <xsl:with-param name="indexVar" select="$indexVar"/>                        
                    <xsl:with-param name="parameters" select="$parameters"/>     
                    <xsl:with-param name="separator" select="$separator"/>
                    <xsl:with-param name="function" select="$function"/>                        
                    <xsl:with-param name="caseStr" select="$caseStr"/>
                    <xsl:with-param name="caseVar" select="$caseVar"/>                                                
                    <xsl:with-param name="defaultMemberPointer" select="$defaultMemberPointer"/>                        
                </xsl:call-template>                            
            </xsl:otherwise>                            
        </xsl:choose>
                                                                
        <xsl:value-of select="$indent"/>                 
        <xsl:text>}&nl;</xsl:text>
                        
    </xsl:template>                        
                
    <!-- generateArrayLoopForDeclareField -->                
    <xsl:template name="generateArrayLoopForDeclareField">
        <xsl:param name="indent"/>                        
        <xsl:param name="cardinalityNode"/>            
        <xsl:param name="level" select="1"/>
        <xsl:param name="memberKind"/>
        <xsl:param name="member"/>
        <xsl:param name="indexStr"/>                        
        <xsl:param name="indexVar"/>                                                
        <xsl:param name="caseStr"/>
        <xsl:param name="caseVar"/>                        
                                                
        <xsl:variable name="index">
            <xsl:value-of select="concat('indexArr[',$level -1 ,']')"/>
        </xsl:variable>   
                     
        <xsl:value-of select="$indent"/>                 
        <xsl:text>for (</xsl:text>
        <xsl:value-of select="$index"/>
        <xsl:text>=0;</xsl:text>
        <xsl:value-of select="$index"/>            
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="$cardinalityNode/dimension[$level]/@size"/>
        <xsl:text>;</xsl:text>
        <xsl:value-of select="$index"/>                        
        <xsl:text>++) {&nl;</xsl:text>
        
        <xsl:choose>
            <xsl:when test="$level &lt; count($cardinalityNode/dimension)">
                <xsl:call-template name="generateArrayLoopForDeclareField">
                    <xsl:with-param name="indent" select="concat($indent,'    ')"/>                        
                    <xsl:with-param name="cardinalityNode" select="$cardinalityNode"/>            
                    <xsl:with-param name="level" select="$level + 1"/>
                    <xsl:with-param name="member" select="$member"/>                        
                    <xsl:with-param name="memberKind" select="$memberKind"/>                                                
                    <xsl:with-param name="indexStr" select="$indexStr"/>                                                    
                    <xsl:with-param name="indexVar" select="$indexVar"/>                          
                    <xsl:with-param name="caseStr" select="$caseStr"/>
                    <xsl:with-param name="caseVar" select="$caseVar"/>                        
                </xsl:call-template>                                    
            </xsl:when>                
            <xsl:otherwise>                    
                <xsl:call-template name="declareField">
                    <xsl:with-param name="indent" select="concat($indent,'    ')"/>
                    <xsl:with-param name="member" select="$member"/>
                    <xsl:with-param name="previousMemberKind" select="$memberKind"/> 
                    <xsl:with-param name="indexStr" select="$indexStr"/>                                                    
                    <xsl:with-param name="indexVar" select="$indexVar"/>                        
                    <xsl:with-param name="caseStr" select="$caseStr"/>
                    <xsl:with-param name="caseVar" select="$caseVar"/>                        
                </xsl:call-template>                            
            </xsl:otherwise>                            
        </xsl:choose>
                                                                
        <xsl:value-of select="$indent"/>                 
        <xsl:text>}&nl;</xsl:text>
                     
    </xsl:template>
        
    <!-- generateArrayLoopForBindParameter -->
    <xsl:template name="generateArrayLoopForBindParameter">
        <xsl:param name="indent"/>                        
        <xsl:param name="cardinalityNode"/>            
        <xsl:param name="level" select="1"/>
        <xsl:param name="memberKind"/>
        <xsl:param name="member"/>            
        <xsl:param name="defaultMemberPointer"/>
                                                                        
        <xsl:variable name="index">
            <xsl:value-of select="concat('indexArr[',$level -1 ,']')"/>
        </xsl:variable>   
                     
        <xsl:value-of select="$indent"/>                 
        <xsl:text>for (</xsl:text>
        <xsl:value-of select="$index"/>
        <xsl:text>=0;</xsl:text>
        <xsl:value-of select="$index"/>            
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="$cardinalityNode/dimension[$level]/@size"/>
        <xsl:text>;</xsl:text>
        <xsl:value-of select="$index"/>                        
        <xsl:text>++) {&nl;</xsl:text>
        
        <xsl:choose>
            <xsl:when test="$level &lt; count($cardinalityNode/dimension)">
                <xsl:call-template name="generateArrayLoopForBindParameter">
                    <xsl:with-param name="indent" select="concat($indent,'    ')"/>
                    <xsl:with-param name="cardinalityNode" select="$cardinalityNode"/>            
                    <xsl:with-param name="level" select="$level + 1"/>
                    <xsl:with-param name="member" select="$member"/>                        
                    <xsl:with-param name="memberKind" select="$memberKind"/>                                                
                    <xsl:with-param name="defaultMemberPointer" select="$defaultMemberPointer"/>                        
                </xsl:call-template>                                    
            </xsl:when>                
            <xsl:otherwise>                    
                <xsl:call-template name="bindParameters">
                    <xsl:with-param name="indent" select="concat($indent,'    ')"/>
                    <xsl:with-param name="member" select="$member"/>
                    <xsl:with-param name="previousMemberKind" select="$memberKind"/> 
                    <xsl:with-param name="defaultMemberPointer" select="$defaultMemberPointer"/>                        
                </xsl:call-template>                            
            </xsl:otherwise>                            
        </xsl:choose>
                                                                
        <xsl:value-of select="$indent"/>                 
        <xsl:text>}&nl;</xsl:text>
                     
    </xsl:template>
                            
    <!-- getFilteredMemberKind -->
    <xsl:template name="getFilteredMemberKind">        
        <xsl:param name="descNode"/>
        <xsl:param name="memberKindToFilter"/>            
            
        <xsl:choose>
            <xsl:when test="$memberKindToFilter = ''">
                <xsl:value-of select="$descNode/@memberKind"/>
            </xsl:when>
            <xsl:when test="$memberKindToFilter = 'arraySequence'">sequence</xsl:when>
            <xsl:when test="$descNode/@type = 'string'">string</xsl:when>
            <xsl:when test="$descNode/@type = 'wstring'">wstring</xsl:when>
            <xsl:when test="$descNode/@bitField != ''">bitfield</xsl:when>
            <xsl:otherwise>scalar</xsl:otherwise>                
        </xsl:choose>
            
    </xsl:template>

    <!-- generateDiscriminatorPtr -->        
    <xsl:template name="generateUnionCondition">            
        <xsl:param name="member"/>            
        <xsl:param name="indent"/>

        <xsl:if test="$member/cases/case/@key = 'default'">
            <xsl:value-of select="$indent"/>                            
            <xsl:text>if (</xsl:text>                                                            

            <xsl:for-each select="$member/cases/case">
                <xsl:value-of select="'&amp;sample-&gt;_d'"/>
                <xsl:text>== (int)(</xsl:text>
                <xsl:value-of select="./@value"/>
            
                <xsl:if test="position()!=last()">
                    <xsl:text> || </xsl:text>
                </xsl:if>
            </xsl:for-each>                
                               
            <xsl:text>) {&nl;</xsl:text>
        </xsl:if>
            
    </xsl:template>
                
    <!-- generateMemberPtr -->
    <xsl:template name="generateMemberPtr">
        <xsl:param name="member"/>
        <xsl:param name="memberKind"/>
        <xsl:param name="cardinalityNode"/>
        <xsl:param name="defaultMemberPointer" select="''"/>                        
            
        <xsl:variable name="union">
            <xsl:if test="$member/../@kind = 'union' and name($member) != 'discriminator'">
                <xsl:text>_u.</xsl:text>
            </xsl:if>
        </xsl:variable>

        <xsl:variable name="memberPointer">
            <xsl:choose>
                <xsl:when test="$defaultMemberPointer != ''">
                    <xsl:value-of select = "$defaultMemberPointer"/>                        
                </xsl:when>
                <xsl:when test="$member/@name">
                    <xsl:if test="name($member) = 'enum'">                        
                        <xsl:value-of select="'sample'"/>                            
                    </xsl:if>                    
                    <xsl:if test="name($member) != 'enum'">
                        <xsl:value-of select="'&amp;sample-&gt;'"/>
                        <xsl:value-of select="$union"/>
                        <xsl:value-of select="$member/@name"/>
                    </xsl:if>                                                
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="'sample'"/>                                                        
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>                
                                
        <xsl:choose>
             <xsl:when test="$memberKind = 'arraySequence' or $memberKind = 'array'">
                 <xsl:value-of select="$memberPointer"/>                              
                 <xsl:for-each select="$cardinalityNode/dimension">
                     <xsl:text>[indexArr[</xsl:text><xsl:value-of select="position()-1"/>
                     <xsl:text>]]</xsl:text>
                 </xsl:for-each>                 
             </xsl:when>                
                
             <xsl:when test="$memberKind = 'sequence'">
                 <xsl:value-of select="concat('&amp;(',$memberPointer,')->_contiguous_buffer[i]')"/>
             </xsl:when>            
                
             <xsl:otherwise>                
                 <xsl:value-of select="$memberPointer"/>                                                   
             </xsl:otherwise>                            
        </xsl:choose>                
    </xsl:template>
                            
    <!-- generateIndexStr -->
    <xsl:template name="generateIndexStr">
        <xsl:param name="memberKind"/>
        <xsl:param name="cardinalityNode"/>
                    
        <xsl:choose>
             <xsl:when test="$memberKind = 'arraySequence' or $memberKind = 'array'">                                          
                 <xsl:for-each select="$cardinalityNode/dimension">
                     <xsl:text>[%d]</xsl:text>
                 </xsl:for-each>                 
             </xsl:when>                                
             <xsl:when test="$memberKind = 'sequence'">
                 <xsl:text>[%d]</xsl:text>                     
             </xsl:when>                            
             <xsl:otherwise>                
             </xsl:otherwise>                            
        </xsl:choose>                
    </xsl:template>

    <!-- generateIndexVar -->                                    
    <xsl:template name="generateIndexVar">
        <xsl:param name="memberKind"/>                    
        <xsl:param name="cardinalityNode"/>
                                                                                    
        <xsl:choose>
             <xsl:when test="$memberKind = 'arraySequence' or $memberKind = 'array'">                                          
                 <xsl:for-each select="$cardinalityNode/dimension">
                     <xsl:value-of select="concat(',indexArr[',position() - 1 ,']')"/>
                 </xsl:for-each>                                                                        
             </xsl:when>                                                
             <xsl:when test="$memberKind = 'sequence'">                     
                 <xsl:text>,i</xsl:text>
             </xsl:when>                            
             <xsl:otherwise>                
             </xsl:otherwise>                            
        </xsl:choose>                            
    </xsl:template>
        
    <!-- generateCaseVar -->                                    
    <xsl:template name="generateCaseVar">
        <xsl:param name="member"/>                    
            
        <xsl:if test="$member/cases/case">                                    
            <xsl:for-each select="$member/cases/case">
                <xsl:if test="@value!='default'">                        
                    <xsl:value-of select="concat(',(int)(',@value,')')"/>                        
                </xsl:if>
            </xsl:for-each>                                                    
        </xsl:if>
            
        <xsl:if test="not($member/cases/case)">
            <xsl:text></xsl:text>                
        </xsl:if>
                                                                                                                        
    </xsl:template>
        
    <!-- generateCaseStr -->                                    
    <xsl:template name="generateCaseStr">
        <xsl:param name="member"/>                    
                            
        <xsl:if test="$member/cases/case">                                    
            <xsl:text>c(</xsl:text>
            <xsl:for-each select="$member/cases/case">
                <xsl:if test="@value!='default'">
                    <xsl:text>%d</xsl:text>
                </xsl:if>                      
                <xsl:if test="@value='default'">
                    <xsl:text>def</xsl:text>
                </xsl:if>                                          
                <xsl:if test="position()!=last()">
                    <xsl:text>,</xsl:text>
                </xsl:if>
            </xsl:for-each>                                                                                    
            <xsl:text>).</xsl:text>
        </xsl:if>
            
        <xsl:if test="not($member/cases/case)">
            <xsl:text></xsl:text>                
        </xsl:if>
                                                                                                                        
    </xsl:template>
        
                                                                                                                                                       
</xsl:stylesheet>
