<?xml version="1.0"?>
<!-- 
/* $Id: typeDatabaseDataType.java.xsl,v 1.2 2012/04/23 16:44:18 fernando Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
Modification history:
- - - - - - - - - - -
10p,31dec07,vtg Made consistent with new type plugin API [First pass]
10m,23jul06,fcs JDK 1.5 support
10l,25apr06,fcs Fixed bug 11009
10l,31mar06,fcs Improved generated code efficiency
10l,22mar06,fcs Created from the version with the tag BRANCH2_SKYBOARD30D
-->

<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;"> <!-- New line -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:xalan = "http://xml.apache.org/xalan">
    <!-- TO DO:
            - See if <xsl:param name="containerNamespace"/> is necessary 
    -->
    <!-- ===================================================================== -->
    <!-- Required Database Code Generator                                      -->
    <!-- ===================================================================== -->
        
    <!-- 
         The following template generates the database code common to all the IDL
         types (top-level or not).
            
         The code generated include the following functions:
         - Plugin_getCreateTableFieldDcl
     -->            
        
    <xsl:template name="generateRequiredDatabaseCode">
        <xsl:param name="containerNamespace"/>
        <xsl:param name="typeNode"/>
                        
<xsl:text><![CDATA[
    // --- Internal database methods: -------------------------------------------
                
]]></xsl:text>
                        
<!-- 
================================================================================
get_create_table_field_dcl 
================================================================================
-->
            
<xsl:text><![CDATA[
    /**
     * @brief Stores in 'sql' the fields delaration that that will be included
     *        in the create table statement.
     * @param connection_kind Database connection kind.
     * @param name_prefix Prefix that will be added to a field name.
     * @param sql Sql statement
     * @param allow_null Indicates if the type fields can conntain null.
     */

]]></xsl:text>
                   
<xsl:text>    public void get_create_table_field_dcl(
        DatabaseConnectionKind connection_kind,String name_prefix,StringBuffer sql,boolean allow_null) {
    </xsl:text>
    <xsl:choose>
        <xsl:when test="name($typeNode) = 'enum'">                
<xsl:text><![CDATA[
        String delimiter = "";
        String nullString = "NOT NULL";

        if (allow_null) {
            nullString = "NULL";
        }

]]></xsl:text>                                        
            <xsl:call-template name="declareField">
                <xsl:with-param name="indent" select="'        '"/>
                <xsl:with-param name="member" select="$typeNode"/>
            </xsl:call-template>                
        </xsl:when>
        <xsl:otherwise>
<xsl:text><![CDATA[
        String newNamePrefix = null;
        String sql_wchar = null;
        String sql_char = "CHAR";
        String sql_wstring = null;
        String sql_string = "VARCHAR";
        String sql_wchar_attribute = null;
        String sql_char_attribute = null;
        String nullString = "NOT NULL";
]]></xsl:text>                        
            <xsl:if test="name($typeNode) = 'typedef'">
<xsl:text><![CDATA[
        String delimiter = "";    

        if (allow_null) {
            nullString = "NULL";
        }
]]></xsl:text>                                                  
            </xsl:if>                                 
            <xsl:if test="name($typeNode) != 'typedef'">
<xsl:text><![CDATA[
        String delimiter = ".";    

        if (name_prefix.equals("")) {
            delimiter = "";
        }

        if (allow_null) {
            nullString = "NULL";
        }
]]></xsl:text>                    
            </xsl:if>
<xsl:text><![CDATA[    
        if (connection_kind == DatabaseConnectionKind.MYSQL_CONNECTION) {
            sql_wchar = "CHAR";
            sql_wstring = "VARCHAR";
            sql_wchar_attribute = "CHARACTER SET ucs2";
            sql_char_attribute = "CHARACTER SET latin1";
        } else {
            sql_wchar = "NCHAR";
            sql_wstring = "NVARCHAR";
            sql_wchar_attribute = "";
            sql_char_attribute = "";
        }

]]></xsl:text>
            <xsl:if test="$typeNode/@kind = 'union'">
                <xsl:if test="$typeNode/discriminator/@name and $typeNode/discriminator/@name != ''">
                    <xsl:text>        /* discriminator */&nl;</xsl:text>                        
                </xsl:if>                    
                <xsl:call-template name="declareField">
                    <xsl:with-param name="indent" select="'        '"/>
                    <xsl:with-param name="member" select="$typeNode/discriminator"/>
                </xsl:call-template>                    
                <xsl:text>    allow_null = true;&nl;</xsl:text>                    
                <xsl:text>    nullString = "NULL";&nl;</xsl:text>
            </xsl:if>
                                                                
            <xsl:for-each select="$typeNode/member">
                <xsl:if test="./@name and ./@name != ''">
                    <xsl:text>        /* </xsl:text><xsl:value-of select="./@name"/>                    
                    <xsl:text> */&nl;</xsl:text>                        
                </xsl:if>
                
                <xsl:variable name="caseStr"> 
                    <xsl:call-template name="generateCaseStr">
                        <xsl:with-param name="member" select="."/>
                    </xsl:call-template>
                </xsl:variable>                        
                                                            
                <xsl:call-template name="declareField">
                    <xsl:with-param name="indent" select="'        '"/>
                    <xsl:with-param name="member" select="."/>
                    <xsl:with-param name="caseStr" select="$caseStr"/>
                </xsl:call-template>
            </xsl:for-each>                        
        </xsl:otherwise>            
    </xsl:choose>
<xsl:text><![CDATA[        
    }

]]></xsl:text>
            
<!-- 
================================================================================
get_insert_field_names
================================================================================
-->

<xsl:text><![CDATA[
    /**
     * @brief The following method stores in 'sql' the name of the fields associated
     *        to the IDL type. 
     *
     * These names are separated with comma and they will be used in the insert SQL 
     * statement.
     *
     * @param name_prefix Prefix that will be added to a field name.
     * @param sql Sql statement
     */

]]></xsl:text>
                                       
<xsl:text>    public void get_insert_field_names(String name_prefix,StringBuffer sql)
    {</xsl:text>
    <xsl:choose>            
        <xsl:when test="name($typeNode) = 'enum'">                
<xsl:text><![CDATA[
        String delimiter = "";

]]></xsl:text>                                                    
            <xsl:call-template name="getFieldNames">                
                <xsl:with-param name="indent" select="'        '"/>
                <xsl:with-param name="member" select="$typeNode"/>
                <xsl:with-param name="separator" select="','"/>
                <xsl:with-param name="function" select="'get_insert_field_names'"/>
            </xsl:call-template>                
        </xsl:when>
        <xsl:otherwise>                
<xsl:text><![CDATA[
        String newNamePrefix = null;
        String delimiter = "";    
]]></xsl:text>                                    
            <xsl:if test="name($typeNode) != 'typedef'">
<xsl:text><![CDATA[
        if (!name_prefix.equals("")) {
            delimiter = ".";
        }

]]></xsl:text>                    
            </xsl:if>
                
            <xsl:if test="$typeNode/@kind = 'union'">
                <xsl:if test="$typeNode/discriminator/@name and $typeNode/discriminator/@name != ''">
                    <xsl:text>        /* discriminator */&nl;</xsl:text>                        
                </xsl:if>                    
                <xsl:call-template name="getFieldNames">
                    <xsl:with-param name="indent" select="'        '"/>
                    <xsl:with-param name="member" select="$typeNode/discriminator"/>
                    <xsl:with-param name="separator" select="','"/>
                    <xsl:with-param name="function" select="'get_insert_field_names'"/>                        
                </xsl:call-template>                    
            </xsl:if>
                
            <xsl:for-each select="$typeNode/member">
                <xsl:if test="./@name and ./@name != ''">
                    <xsl:text>        /* </xsl:text><xsl:value-of select="./@name"/>                    
                    <xsl:text> */&nl;</xsl:text>                        
                </xsl:if>                    
                    
                <xsl:variable name="caseStr"> 
                    <xsl:call-template name="generateCaseStr">
                        <xsl:with-param name="member" select="."/>
                    </xsl:call-template>
                </xsl:variable>                        
                                        
                <xsl:call-template name="getFieldNames">                
                    <xsl:with-param name="indent" select="'        '"/>
                    <xsl:with-param name="member" select="."/>
                    <xsl:with-param name="separator" select="','"/>
                    <xsl:with-param name="function" select="'get_insert_field_names'"/>
                    <xsl:with-param name="caseStr" select="$caseStr"/>
                </xsl:call-template>
            </xsl:for-each>                        
        </xsl:otherwise>
    </xsl:choose>                        
<xsl:text><![CDATA[
    }

]]></xsl:text>
            
<!-- 
================================================================================
get_insert_parameters
================================================================================
-->
                        
<xsl:text><![CDATA[
    /**
     * @brief Stores in 'sql' a list of '?' symbols where each symbol represents
     *        a SQL parameter.
     *
     * @param sql Sql statement
     */

]]></xsl:text>
                       
<xsl:text>    public void get_insert_parameters(StringBuffer sql) {&nl;</xsl:text>
                        
    <xsl:choose>                        
        <xsl:when test="name($typeNode) = 'enum'">                
            <xsl:call-template name="getFieldNames">                
                <xsl:with-param name="indent" select="'        '"/>
                <xsl:with-param name="member" select="$typeNode"/>
                <xsl:with-param name="parameters" select="1"/>                
                <xsl:with-param name="separator" select="'?,'"/>
                <xsl:with-param name="function" select="'get_insert_parameters'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>                
            <xsl:if test="$typeNode/@kind = 'union'">
                <xsl:if test="$typeNode/discriminator/@name and $typeNode/discriminator/@name != ''">
                    <xsl:text>        /* discriminator */&nl;</xsl:text>                        
                </xsl:if>                    
                <xsl:call-template name="getFieldNames">
                    <xsl:with-param name="indent" select="'    '"/>
                    <xsl:with-param name="member" select="$typeNode/discriminator"/>
                    <xsl:with-param name="parameters" select="1"/>                                        
                    <xsl:with-param name="separator" select="'?,'"/>
                    <xsl:with-param name="function" select="'get_insert_parameters'"/>
                </xsl:call-template>                    
            </xsl:if>
                
            <xsl:for-each select="$typeNode/member">
                <xsl:if test="./@name and ./@name != ''">
                    <xsl:text>        /* </xsl:text><xsl:value-of select="./@name"/>                    
                    <xsl:text> */&nl;</xsl:text>                        
                </xsl:if>
                    
                <xsl:variable name="caseStr"> 
                    <xsl:call-template name="generateCaseStr">
                        <xsl:with-param name="member" select="."/>
                    </xsl:call-template>
                </xsl:variable>                        
                                        
                <xsl:call-template name="getFieldNames">                
                    <xsl:with-param name="indent" select="'        '"/>
                    <xsl:with-param name="member" select="."/>
                    <xsl:with-param name="parameters" select="1"/>                
                    <xsl:with-param name="separator" select="'?,'"/>
                    <xsl:with-param name="function" select="'get_insert_parameters'"/>
                    <xsl:with-param name="caseStr" select="$caseStr"/>
                </xsl:call-template>
            </xsl:for-each>                        
        </xsl:otherwise>
    </xsl:choose>
<xsl:text><![CDATA[
    }

]]></xsl:text>            
             
<!-- 
================================================================================
get_update_field_names
================================================================================
-->
            
<xsl:text><![CDATA[
    /**
     * @brief Stores in 'sql' the name of the fields associated to the IDL type 
     *        with the following format:
     *        <field name 1>=?,<field name 2>=?,...
     *
     * @param name_prefix Prefix that will be added to a field name.
     * @param sql Sql statement.
     * @fields_mask Mask to select the input set of fields.
     */

]]></xsl:text>

<xsl:text>    public void get_update_field_names(String name_prefix,StringBuffer sql,int fields_mask) {&nl;</xsl:text>
            
    <xsl:if test="name($typeNode) = 'enum'">
<xsl:text><![CDATA[
        String newNamePrefix ="";
        String delimiter = "";

]]></xsl:text>                                                    
        <xsl:call-template name="getFieldNames">
            <xsl:with-param name="indent" select="'        '"/>
            <xsl:with-param name="member" select="$typeNode"/>
            <xsl:with-param name="separator" select="'=?,'"/>
            <xsl:with-param name="function" select="'get_update_field_names'"/>                
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
        String delimiter = "";    
        String newNamePrefix ="";
]]></xsl:text>                                                                      
                <xsl:if test="name($typeNode) != 'typedef'">
<xsl:text><![CDATA[
        if (!name_prefix.equals("")) {
            delimiter = ".";
        }

]]></xsl:text>                    
                </xsl:if>
                    
                <xsl:if test="$typeNode/@kind = 'union'">
                    <xsl:if test="$typeNode/discriminator/@name and $typeNode/discriminator/@name != ''">
                        <xsl:text>        /* discriminator */&nl;</xsl:text>                        
                    </xsl:if>                    
                    <xsl:call-template name="getFieldNames">
                        <xsl:with-param name="indent" select="'        '"/>
                        <xsl:with-param name="member" select="$typeNode/discriminator"/>
                        <xsl:with-param name="isKey" select="0"/>                            
                        <xsl:with-param name="separator" select="'=?,'"/>
                        <xsl:with-param name="function" select="'get_update_field_names'"/>                
                    </xsl:call-template>                    
                </xsl:if>
                    
            </xsl:if>
                
            <xsl:variable name="caseStr"> 
                <xsl:call-template name="generateCaseStr">
                    <xsl:with-param name="member" select="."/>
                </xsl:call-template>
            </xsl:variable>                        
                                    
            <xsl:if test="./@name and ./@name != ''">
                <xsl:text>        /* </xsl:text><xsl:value-of select="./@name"/>                    
                <xsl:text> */&nl;</xsl:text>                        
            </xsl:if>                                    
            <xsl:call-template name="getFieldNames">
                <xsl:with-param name="indent" select="'        '"/>
                <xsl:with-param name="member" select="."/>
                <xsl:with-param name="isKey" select="$isKey"/>                
                <xsl:with-param name="separator" select="'=?,'"/>
                <xsl:with-param name="function" select="'get_update_field_names'"/>                
                <xsl:with-param name="caseStr" select="$caseStr"/>
            </xsl:call-template>
        </xsl:for-each>        
    </xsl:if>            
            
<xsl:text><![CDATA[
    }

]]></xsl:text>
                                    
<!-- 
================================================================================
bind_parameters
================================================================================
-->

<xsl:text><![CDATA[
    /**
     * @brief Binds the sample fields to the parameter markers in an SQL statement.
     *
     * @param stmt JDBC Statement.
     * @param index Index of the next parameter to bind.
     * @param sample DDS sample.
     * @param fields_mask Bit mask used to indicate the fields we want to bind.
     * @param assign_null Indicates if the database fields will be initialized
     *  with NULL or not.
     *
     * @returns index of the next parameter.
     *
     * @throws SQLException if there is a JDBC error.
     */

]]></xsl:text>
                           
<xsl:text>    public int bind_parameters(PreparedStatement stmt,int index,</xsl:text>
<xsl:value-of select="$typeNode/@name"/>
<xsl:text> sample,int fields_mask,boolean assign_null) throws SQLException {&nl;&nl;</xsl:text>

    <xsl:if test="$typeNode/@kind = 'union'">
        <xsl:text>        boolean isDefault = true;&nl;</xsl:text>        
        <xsl:text>        boolean oldAssignNull = assign_null;&nl;&nl;</xsl:text>
    </xsl:if>
            
    <xsl:if test="name($typeNode) = 'enum'">
        <xsl:call-template name="bindParameters">
            <xsl:with-param name="indent" select="'        '"/>
            <xsl:with-param name="member" select="$typeNode"/>
        </xsl:call-template>            
    </xsl:if>

    <xsl:if test="name($typeNode) != 'enum'">
            
        <xsl:if test="$typeNode/@kind = 'union'">
            <xsl:if test="$typeNode/discriminator/@name and $typeNode/discriminator/@name != ''">
                <xsl:text>        /* discriminator */&nl;</xsl:text>                        
            </xsl:if>                    
            <xsl:call-template name="bindParameters">
                <xsl:with-param name="indent" select="'        '"/>
                <xsl:with-param name="member" select="$typeNode/discriminator"/>
                <xsl:with-param name="isKey" select="0"/>                            
            </xsl:call-template>
            <xsl:text>        assign_null = true;&nl;&nl;</xsl:text>    
        </xsl:if>
            
        <xsl:for-each select="$typeNode/member">
            <xsl:variable name="isKey">
                <xsl:call-template name="isKey">
                    <xsl:with-param name="member" select="."/>        
                </xsl:call-template>
            </xsl:variable>
                                
            <xsl:if test="./@name and ./@name != ''">
                <xsl:text>        /* </xsl:text><xsl:value-of select="./@name"/>                    
                <xsl:text> */&nl;</xsl:text>                        
            </xsl:if>                                                    
            <xsl:call-template name="bindParameters">
                <xsl:with-param name="indent" select="'        '"/>
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
         - Plugin_connectToDatabase
         - Plugin_disconnectFromDatabase
         - Plugin_createTable
         - Plugin_setReaderDBQos
         - Plugin_setWriterDBQos
         - Plugin_updateDatabase                     
     -->            

    <xsl:template name="generateTopLevelDatabaseCode">
        <xsl:param name="containerNamespace"/>
        <xsl:param name="typeNode"/>
        <xsl:variable name="keyFields" select="$typeNode/member
                                                   [following-sibling::node()
                                                       [position() = 1 and name() = 'directive' and @kind = 'key']]"/>
            
<!-- 
================================================================================
create_database_table
================================================================================
-->

<xsl:text><![CDATA[
    /**
     * @brief The following method creates the table associated to the database
     *        connection if it doesn't exist.
     *
     * @param connection Database connection (not null).
     * @param sqlHelper Type independent SQL code generator.
     *
     * @throws RETCODE_DBMS_ERROR if there is a JDBC error.
     * @throws DDS Standard Return Codes.
     */

]]></xsl:text>
                                                
<xsl:text>    public void create_database_table(DatabaseConnection connection,SQLHelper sqlHelper)</xsl:text>
<xsl:text><![CDATA[
    {
        DatabaseQos dbQos = null;
        StringBuffer sql = new StringBuffer(SQLHelper.SQL_STATEMENT_MAX_LENGTH + 1);
        StringBuffer fieldsDeclaration = new StringBuffer(SQLHelper.SQL_STATEMENT_MAX_LENGTH + 1); 
        Statement stmt = null;
        String historyField = null;
        String historyKey = null;
        Connection jdbcCx = null;
        boolean committed = false;
        DatabaseConnectionKind cxKind = null;

        if (connection == null) {
            throw new RETCODE_BAD_PARAMETER("null argument");
        }

        try {
            jdbcCx = connection.get_jdbc_connection();

            if (jdbcCx == null) {
                throw new RETCODE_DBMS_ERROR("There is no opened JDBC connection");   
            }

            dbQos = connection.get_qos();
            cxKind = connection.get_connection_kind();
          
            if (dbQos.history.history_depth != 0) {
                historyField = "ndds_history_slot INTEGER NOT NULL, ndds_history_order INTEGER NOT NULL, ";
                historyKey = "ndds_history_slot,";
            }else{
                historyField = "";
                historyKey = "";
            }

            stmt = jdbcCx.createStatement();

            get_create_table_field_dcl(cxKind,"",fieldsDeclaration,false);
]]></xsl:text>

<xsl:text><![CDATA[    
            if (cxKind == DatabaseConnectionKind.MYSQL_CONNECTION) {
]]></xsl:text>

            <xsl:call-template name="getCreateTableSqlStatement">
                <xsl:with-param name="indent" select="'                     '"/>
                <xsl:with-param name="typeNode" select="$typeNode"/>
                <xsl:with-param name="dbms" select="'MySQL'"/>
            </xsl:call-template>

<xsl:text>            } else {&nl;</xsl:text>

            <xsl:call-template name="getCreateTableSqlStatement">
                 <xsl:with-param name="indent" select="'                '"/>
                 <xsl:with-param name="typeNode" select="$typeNode"/>
                 <xsl:with-param name="dbms" select="'TT'"/>
            </xsl:call-template>
            
<xsl:text>            }&nl;</xsl:text>
                                                                
<xsl:text><![CDATA[            

            try {
                stmt.executeUpdate(sql.toString());
            } catch (SQLException e) {
                if (cxKind == DatabaseConnectionKind.TIMESTEN_CONNECTION && 
                    e.getErrorCode() != 2207 /* Table exists */) {
                    throw e;
                } else if (cxKind == DatabaseConnectionKind.MYSQL_CONNECTION) {
                    throw e;
                }
            }
            
            if (dbQos.table_topic_mapping.publish_table_changes == true) {

                try {
                    stmt.executeUpdate(sqlHelper.get_ndds_publications_create_table_stmtI());   
                } catch (SQLException e) {
                    if (cxKind == DatabaseConnectionKind.TIMESTEN_CONNECTION && 
                        e.getErrorCode() != 2207 /* Table exists */) {
                        throw e;
                    } else if (cxKind == DatabaseConnectionKind.MYSQL_CONNECTION) {
                        throw e;
                    }
                }
        
                try {
                    /* Insert a new entry in the table ndds_publications */
                    stmt.executeUpdate(sqlHelper.get_ndds_publications_insert_stmtI());   
                } catch (Exception e) {
                }

                /* Commit the transaction */
                if (cxKind != DatabaseConnectionKind.SKYBOARD_CONNECTION) {
                    jdbcCx.commit();
                }
                committed = true;
                
            }

        } catch (SQLException e) {
            throw new RETCODE_DBMS_ERROR(e.getMessage());
        } catch (RETCODE_ERROR e) {
            throw e;
        } catch (Exception e) {
            throw new RETCODE_ERROR(e.getMessage());
        } finally {
            if (jdbcCx != null &&
                cxKind != DatabaseConnectionKind.SKYBOARD_CONNECTION) {
                try {                           
                    if (!committed) jdbcCx.rollback();
                } catch (Exception e) {}
            }
        }

    }        
]]></xsl:text>
            
<!-- 
================================================================================
store_sample_in_database_w_history
================================================================================
-->

<xsl:text><![CDATA[
    /**
     * @brief The following method is used to store the input sample into a
     *        database. It must be used with connections where history storage 
     *        is enabled.
     *
     * @param domainId of the entity that is writing into the database.
     * @param connection Database connection (not null).
     * @param sample Input sample.
     *
     * @throws RETCODE_DBMS_ERROR if there is a JDBC error.
     * @throws DDS Standard Return Codes.
     */

]]></xsl:text>
                                                                                                
<xsl:text>    public void store_sample_in_database_w_history(int domainId,</xsl:text>
<xsl:text>    DatabaseConnection connection,</xsl:text>
<xsl:value-of select="$typeNode/@name"/><xsl:text> sample) {&nl;</xsl:text>            
<xsl:text><![CDATA[
        PreparedStatement preparedStmt = null;
        DatabaseQos dbQos = null;
        Connection jdbcCx = null;
        StringBuffer sql = new StringBuffer(SQLHelper.SQL_STATEMENT_MAX_LENGTH + 1);
        StringBuffer fieldNames = new StringBuffer(SQLHelper.SQL_STATEMENT_MAX_LENGTH + 1);
        StringBuffer parameters = new StringBuffer(SQLHelper.SQL_STATEMENT_MAX_LENGTH + 1);
        int ndds_remote;
        int index;
        ResultSet rs = null;
        boolean committed = false;
        boolean isNull = false;
        int nextOrder = -1;
        int numberOfSamples = 0;
        int historySlot = 0;
        DatabaseConnectionKind cxKind = null;

        if (connection == null || sample == null) {
            throw new RETCODE_BAD_PARAMETER("null argument");
        }

        try {           
            jdbcCx = connection.get_jdbc_connection();            
            dbQos = connection.get_qos();

            if (dbQos.history.history_depth == 0) {
                throw new RETCODE_PRECONDITION_NOT_MET("Database history storage disabled");
            }

            if (jdbcCx == null) {
                throw new RETCODE_DBMS_ERROR("There is no opened JDBC connection");   
            }

            cxKind = connection.get_connection_kind();

            if (connection.preparedStmtSelect == null) {
            
]]></xsl:text>
            
                <xsl:call-template name="getRecordExistsSqlStatement">
                    <xsl:with-param name="indent" select="'                '"/>
                    <xsl:with-param name="typeNode" select="$typeNode"/>
                    <xsl:with-param name="history" select="1"/>
                </xsl:call-template>           

<xsl:text><![CDATA[
                connection.preparedStmtSelect = jdbcCx.prepareStatement(sql.toString());
            }

            bind_parameters(connection.preparedStmtSelect,1,sample,FieldsKind.KEY_FIELDS,false);
            rs = connection.preparedStmtSelect.executeQuery();

            while (rs.next()) {                 
                rs.getInt(1);	                  
                isNull = rs.wasNull();                
                if (nextOrder == -1) {
                    nextOrder = rs.getInt(2) + 1;
                }
                historySlot = rs.getInt(3);
                numberOfSamples ++;
            }

            rs.close();
            sql.setLength(0);
              
            if ((numberOfSamples < dbQos.history.history_depth) || 
                dbQos.history.history_depth == DatabaseHistoryQosPolicy.INFINITE_HISTORY) {            

                if (nextOrder == -1) {
                    nextOrder =0;
                }

                if (connection.preparedStmtInsert == null) {
                    /* Insert a new record */
                    get_insert_field_names("",fieldNames);
                    get_insert_parameters(parameters);                                
]]></xsl:text>

                    <xsl:call-template name="getInsertSqlStatement">
                        <xsl:with-param name="indent" select="'                    '"/>
                        <xsl:with-param name="typeNode" select="$typeNode"/>
                        <xsl:with-param name="history" select="1"/>        
                    </xsl:call-template>

<xsl:text><![CDATA[                                
                    connection.preparedStmtInsert = jdbcCx.prepareStatement(sql.toString());
                }

                index = bind_parameters(connection.preparedStmtInsert,1,sample,FieldsKind.KEY_FIELDS|FieldsKind.NO_KEY_FIELDS,false);
                connection.preparedStmtInsert.setInt(index,nextOrder);
                index ++;
                connection.preparedStmtInsert.setInt(index,numberOfSamples);
                connection.preparedStmtInsert.executeUpdate();

            } else {
                if (!isNull) {
                    preparedStmt = connection.preparedStmtUpdate1;
                } else {
                    preparedStmt = connection.preparedStmtUpdate2;
                }

                if (preparedStmt == null) {

                    get_update_field_names("",fieldNames,FieldsKind.NO_KEY_FIELDS);

                    if (isNull) {
]]></xsl:text>
            
                        <xsl:call-template name="getUpdateSqlStatement">
                            <xsl:with-param name="indent" select="'                        '"/>
                            <xsl:with-param name="typeNode" select="$typeNode"/>
                            <xsl:with-param name="isNull" select="1"/>        
                            <xsl:with-param name="history" select="1"/>        
                        </xsl:call-template>

<xsl:text><![CDATA[     
                        connection.preparedStmtUpdate2 = jdbcCx.prepareStatement(sql.toString());                              
                        preparedStmt = connection.preparedStmtUpdate2;
                    } else {
]]></xsl:text>
            
                        <xsl:call-template name="getUpdateSqlStatement">
                            <xsl:with-param name="indent" select="'                        '"/>
                            <xsl:with-param name="typeNode" select="$typeNode"/>
                            <xsl:with-param name="isNull" select="0"/>        
                            <xsl:with-param name="history" select="1"/>                                    
                        </xsl:call-template>            
                        
<xsl:text><![CDATA[ 
                        connection.preparedStmtUpdate1 = jdbcCx.prepareStatement(sql.toString());           
                        preparedStmt = connection.preparedStmtUpdate1;
                    }


                }

                index = bind_parameters(preparedStmt,1,sample,FieldsKind.NO_KEY_FIELDS,false);
                preparedStmt.setInt(index,nextOrder);
                index ++;
                preparedStmt.setInt(index,historySlot);
                index ++;
                bind_parameters(preparedStmt,index,sample,FieldsKind.KEY_FIELDS,false);
                preparedStmt.executeUpdate();
            }
           
            /* Commit the transaction */
            if (cxKind != DatabaseConnectionKind.SKYBOARD_CONNECTION) {
                jdbcCx.commit();
            }
            committed = true;

        } catch (SQLException e) {
            throw new RETCODE_DBMS_ERROR(e.getMessage());
        } catch (RETCODE_ERROR e) {
            throw e;
        } catch (Exception e) {
            throw new RETCODE_ERROR(e.getMessage());
        } finally {
            if (jdbcCx != null &&
                cxKind != DatabaseConnectionKind.SKYBOARD_CONNECTION) {
                try {                           
                    if (!committed) {
                        jdbcCx.rollback();
                        connection.close_prepared_statements();
                    }
                } catch (Exception e) {}
            }
        }

    }    
]]></xsl:text>
                                                            
<!-- 
================================================================================
store_sample_in_database
================================================================================
-->

<xsl:text><![CDATA[
    /**
     * @brief The following method stores the input sample into a database.
     *        It must be used with connections where history storage is disabled.
     *
     * @param domainId of the entity that is writing into the database.
     * @param connection Database connection (not null).
     * @param sample Input sample.
     *
     * @throws RETCODE_PRECONDITION_NOT_MET if the connection has history storage
     * enabled.
     * @throws RETCODE_DBMS_ERROR if there is a database error.
     * @throws DDS Standard Return Codes.
     */

]]></xsl:text>
                                                                                                
<xsl:text>    public void store_sample_in_database(int domainId,</xsl:text>
<xsl:text>DatabaseConnection connection,</xsl:text>
<xsl:value-of select="$typeNode/@name"/><xsl:text> sample) {&nl;</xsl:text>
<xsl:text><![CDATA[
        PreparedStatement preparedStmt = null;
        DatabaseQos dbQos = null;
        Connection jdbcCx = null;
        StringBuffer sql = new StringBuffer(SQLHelper.SQL_STATEMENT_MAX_LENGTH + 1);
        StringBuffer fieldNames = new StringBuffer(SQLHelper.SQL_STATEMENT_MAX_LENGTH + 1);
        StringBuffer parameters = new StringBuffer(SQLHelper.SQL_STATEMENT_MAX_LENGTH + 1);
        int ndds_remote;
        int index;
        ResultSet rs = null;
        boolean committed = false;
        boolean insert = true;
        boolean isNull = false;
        DatabaseConnectionKind cxKind = null;

        if (connection == null || sample == null) {
            throw new RETCODE_BAD_PARAMETER("null argument");
        }

        try {           
            jdbcCx = connection.get_jdbc_connection();
            dbQos = connection.get_qos();

            if (dbQos.history.history_depth != 0) {
                throw new RETCODE_PRECONDITION_NOT_MET("Database history storage enabled");
            }

            if (jdbcCx == null) {
                throw new RETCODE_DBMS_ERROR("There is no opened JDBC connection");   
            }

            cxKind = connection.get_connection_kind();

            if (connection.preparedStmtSelect == null) {

]]></xsl:text>

            <xsl:call-template name="getRecordExistsSqlStatement">
                <xsl:with-param name="indent" select="'                '"/>
                <xsl:with-param name="typeNode" select="$typeNode"/>
            </xsl:call-template>           

<xsl:text><![CDATA[            
                connection.preparedStmtSelect = jdbcCx.prepareStatement(sql.toString());

            }

            bind_parameters(connection.preparedStmtSelect,1,sample,FieldsKind.KEY_FIELDS,false);
            rs = connection.preparedStmtSelect.executeQuery();

            if (rs.next()) {                 
                insert = false;
                rs.getInt(1);
                isNull = rs.wasNull();           
            }

            rs.close();
            sql.setLength(0);

            if (insert) { /* We insert a new record */

                if (connection.preparedStmtInsert == null) {
                    get_insert_field_names("",fieldNames);
                    get_insert_parameters(parameters);
]]></xsl:text>

                    <xsl:call-template name="getInsertSqlStatement">
                        <xsl:with-param name="indent" select="'                    '"/>
                        <xsl:with-param name="typeNode" select="$typeNode"/>
                        <xsl:with-param name="history" select="0"/>        
                    </xsl:call-template>
                        
<xsl:text><![CDATA[            
                    connection.preparedStmtInsert = jdbcCx.prepareStatement(sql.toString());
                }

                bind_parameters(connection.preparedStmtInsert,1,sample,FieldsKind.KEY_FIELDS|FieldsKind.NO_KEY_FIELDS,false);
                connection.preparedStmtInsert.executeUpdate();
            } else {

                if (!isNull) {
                    preparedStmt = connection.preparedStmtUpdate1;
                } else {
                    preparedStmt = connection.preparedStmtUpdate2;
                }

                if (preparedStmt == null) {
                    get_update_field_names("",fieldNames,FieldsKind.NO_KEY_FIELDS);

                    if (isNull) {
]]></xsl:text>
            
                        <xsl:call-template name="getUpdateSqlStatement">
                            <xsl:with-param name="indent" select="'                        '"/>
                            <xsl:with-param name="typeNode" select="$typeNode"/>
                            <xsl:with-param name="isNull" select="1"/>        
                        </xsl:call-template>
            
<xsl:text><![CDATA[
                        connection.preparedStmtUpdate2 = jdbcCx.prepareStatement(sql.toString());                              
                        preparedStmt = connection.preparedStmtUpdate2;

                    } else {
]]></xsl:text>
            
                        <xsl:call-template name="getUpdateSqlStatement">
                            <xsl:with-param name="indent" select="'                        '"/>
                            <xsl:with-param name="typeNode" select="$typeNode"/>
                            <xsl:with-param name="isNull" select="0"/>        
                        </xsl:call-template>            

<xsl:text><![CDATA[
                        connection.preparedStmtUpdate1 = jdbcCx.prepareStatement(sql.toString());                              
                        preparedStmt = connection.preparedStmtUpdate1;

                    }
                }

                index = bind_parameters(preparedStmt,1,sample,FieldsKind.NO_KEY_FIELDS,false);
                bind_parameters(preparedStmt,index,sample,FieldsKind.KEY_FIELDS,false);
                preparedStmt.executeUpdate();
            }

           
            /* Commit the transaction */
            if (cxKind != DatabaseConnectionKind.SKYBOARD_CONNECTION) {
                jdbcCx.commit();
            }
            committed = true;

        } catch (SQLException e) {
            throw new RETCODE_DBMS_ERROR(e.getMessage());
        } catch (RETCODE_ERROR e) {
            throw e;
        } catch (Exception e) {
            throw new RETCODE_ERROR(e.getMessage());
        } finally {
            if (jdbcCx != null &&
                cxKind != DatabaseConnectionKind.SKYBOARD_CONNECTION) {
                try {                           
                    if (!committed) {
                        jdbcCx.rollback();
                        connection.close_prepared_statements();
                    }
                } catch (Exception e) {}
            }
        }

    }    
]]></xsl:text>

    </xsl:template>
                
    <!-- ===================================================================== -->
    <!-- Database Helper Templates                                             -->
    <!-- ===================================================================== -->

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
        <xsl:text>sql.append("UPDATE \"" + dbQos.access.table_name +"\" SET " +&nl;</xsl:text>
        <xsl:value-of select="$indent"/>
        <xsl:value-of select="'           '"/>                        
        <xsl:text>fieldNames + &nl;</xsl:text>
        <xsl:value-of select="$indent"/>
        <xsl:value-of select="'           '"/>                               
        <xsl:text>"ndds_domain_id = " + domainId + ", " +&nl;</xsl:text>
        <xsl:value-of select="$indent"/>
        <xsl:value-of select="'           '"/>                   
        <xsl:if test="$isNull = 1">                
            <xsl:text>"ndds_remote= 123"</xsl:text>
        </xsl:if>
        <xsl:if test="$isNull = 0">
            <xsl:text>"ndds_remote= ndds_remote + 1"</xsl:text>                
        </xsl:if>
            
        <xsl:if test="$history = 1">
            <xsl:text>+ ",ndds_history_order = ?"</xsl:text>
        </xsl:if>
        
        <xsl:text>+ " Where " +&nl;</xsl:text>
            
        <xsl:value-of select="$indent"/>
        <xsl:value-of select="'           '"/>       
            
        <xsl:if test="$history = 1">
            <xsl:text>" ndds_history_slot = ? and " + </xsl:text>                
        </xsl:if>

        <xsl:if test="$hasKeys != 0">
            <xsl:for-each select="$keyFields[position() != last()]">
                <xsl:value-of select="concat('&quot;\&quot;',./@name,'\&quot;=? and &quot; + ')"/>
            </xsl:for-each>        
            <xsl:for-each select="$keyFields[position() = last()]">
                <xsl:value-of select="concat('&quot;\&quot;',./@name,'\&quot;=?&quot;')"/>
            </xsl:for-each>
        </xsl:if>                            
            
        <xsl:if test="$hasKeys = 0">
            <xsl:text>"ndds_key = 0"</xsl:text>                
        </xsl:if>
            
        <xsl:text>);&nl;</xsl:text>            
                                                
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
            
        <xsl:if test="$history = 1">                
            <xsl:text>sql.append("Select ndds_remote,ndds_history_order,ndds_history_slot</xsl:text>                
        </xsl:if>

        <xsl:if test="$history = 0">                
            <xsl:text>sql.append("Select ndds_remote</xsl:text>            
        </xsl:if>
            
        <xsl:text> From \"" + dbQos.access.table_name + "\" Where " + </xsl:text>
                        
        <xsl:if test="$hasKeys!=0">
            <xsl:for-each select="$keyFields[position() != last()]">
                <xsl:text>"\"</xsl:text><xsl:value-of select="./@name"/><xsl:text>\"=? and " + </xsl:text>
            </xsl:for-each>                        
            <xsl:for-each select="$keyFields[position() = last()]">
                <xsl:text>"\"</xsl:text><xsl:value-of select="./@name"/><xsl:text>\"=?"</xsl:text>
            </xsl:for-each>
        </xsl:if>

        <xsl:if test="$hasKeys=0">
            <xsl:text>"ndds_key = 0"</xsl:text>                
        </xsl:if>
            
        <xsl:if test="$history = 1">
            <xsl:text>+ " order by ndds_history_order desc"</xsl:text>                                                
        </xsl:if>
            
        <xsl:text>);&nl;</xsl:text>
                        
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
        <xsl:text>sql.append("Insert INTO \"" + dbQos.access.table_name + "\"" + &nl;</xsl:text>
        <xsl:value-of select="$indent"/>
        <xsl:text>           " (" + fieldNames.toString() + </xsl:text>

        <xsl:if test="$hasKeys = 0">
            <xsl:text>"ndds_key," + </xsl:text>
        </xsl:if>
                        
        <xsl:if test="$history = 1">
            <xsl:text>"ndds_history_slot,ndds_history_order," + </xsl:text>
        </xsl:if>
                                                                
        <xsl:text>"ndds_domain_id,ndds_remote) Values " + &nl;</xsl:text>
                        
        <xsl:value-of select="$indent"/>
        <xsl:text>           "(" + parameters + </xsl:text>
            
        <xsl:if test="$hasKeys = 0">
            <xsl:text>"0," +</xsl:text>
        </xsl:if>
            
        <xsl:if test="$history = 1">
            <xsl:text>"?,?," +</xsl:text>
        </xsl:if>
                        
        <xsl:text>domainId + ",1)");</xsl:text>                        

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
        <xsl:variable name="indent2" select="concat($indent,'           ')"/>

        <xsl:value-of select="$indent"/>
        <xsl:text>sql.append("Create Table "</xsl:text>

        <xsl:if test="$dbms = 'MySQL'">
            <xsl:text> + "IF NOT EXISTS "</xsl:text>
        </xsl:if>
            
        <xsl:text> + "\"" + dbQos.access.table_name + "\"" +&nl;</xsl:text>
                                            
        <xsl:value-of select="$indent2"/>
        <xsl:text>" (" + &nl;</xsl:text>
        <xsl:value-of select="$indent2"/>                
        <xsl:text>fieldsDeclaration + &nl;</xsl:text>
        <xsl:value-of select="$indent2"/>                        
            
        <xsl:if test="$hasKeys = 0">
            <xsl:text>"ndds_key INTEGER NOT NULL," + </xsl:text>                
        </xsl:if>                
            
        <xsl:text>historyField + </xsl:text> <!-- History -->
        <xsl:text>"ndds_domain_id INTEGER," + </xsl:text>
                        
        <xsl:if test="$dbms = 'MySQL'">
            <xsl:text>"ndds_remote INTEGER NOT NULL DEFAULT 0," +&nl;</xsl:text>
        </xsl:if>

        <xsl:if test="$dbms = 'TT'">
            <xsl:text>"ndds_remote INTEGER," +&nl;</xsl:text>
        </xsl:if>

        <xsl:value-of select="$indent2"/>
                    
        <xsl:if test="$hasKeys = 0">
            <xsl:text>"PRIMARY KEY (" + historyKey + "ndds_key" + </xsl:text>    
        </xsl:if>                
                
        <xsl:if test="$hasKeys != 0">
            <xsl:text>"PRIMARY KEY (" + historyKey + </xsl:text>    

            <xsl:for-each select="$keyFields[position() != last()]">
                <xsl:value-of select="concat('&quot;\&quot;',./@name,'\&quot;&quot; + &quot;,&quot; + ')"/>
            </xsl:for-each>

            <xsl:for-each select="$keyFields[position() = last()]">
                <xsl:value-of select="concat('&quot;\&quot;',./@name,'\&quot;&quot; + ')"/>
            </xsl:for-each>                
        </xsl:if>                                      
                
        <xsl:text>"))"&nl;</xsl:text>
        <xsl:value-of select="$indent2"/>
        <xsl:text>);&nl;</xsl:text>
                                
    </xsl:template>

    <!-- getPrimitiveFieldNames -->
    <xsl:template name="getPrimitiveFieldNames">
        <xsl:param name="indent"/>
        <xsl:param name="member"/>
        <xsl:param name="descNode"/>                                                
        <xsl:param name="separator"/>
        <xsl:param name="parameters"/>                        
        <xsl:param name="indexStr"/>            
        <xsl:param name="caseStr"/>
        <xsl:param name="function"/>                   

        <xsl:variable name="bfStr">
            <xsl:if test="$descNode/@bitField != ''">
                <xsl:text> + ":"</xsl:text>
                <xsl:if test="$descNode/@bitKind ='lastBitField'">
                    <xsl:text> + "!"</xsl:text>
                </xsl:if>
                <xsl:text> + (</xsl:text>
                <xsl:value-of select="$descNode/@bitField"/>
                <xsl:text>)</xsl:text>
            </xsl:if>
            <xsl:text></xsl:text>
        </xsl:variable>
                                               
        <xsl:variable name="newSeparator">
            <xsl:if test = "$function != 'get_insert_parameters'">
                <xsl:text> + </xsl:text>
            </xsl:if>
            <xsl:text>"</xsl:text>
            <xsl:value-of select="$separator"/>                                                
            <xsl:text>"</xsl:text>
        </xsl:variable>
                                                                                                                
        <xsl:value-of select="$indent"/>    
        <xsl:text>sql.append(</xsl:text> 
                                                        
        <xsl:if test="$parameters = 1">
            <xsl:value-of select="$newSeparator"/>                
        </xsl:if>                    
            
        <xsl:if test="$parameters = 0">                               
            <xsl:text>"\"" + name_prefix + delimiter </xsl:text>
            <xsl:value-of select="$caseStr"/>
            <xsl:if test="name($member) != 'enum'">
                <xsl:text> +</xsl:text>
                <xsl:if test="not(contains($member/@name,'&quot;'))"> 
                    <xsl:text> "</xsl:text>
                </xsl:if>                    
                <xsl:value-of select="$member/@name"/>
                <xsl:if test="not(contains($member/@name,'&quot;'))"> 
                    <xsl:text>"</xsl:text>
                </xsl:if>                    
            </xsl:if>
            <xsl:value-of select="$bfStr"/>                
            <xsl:value-of select="$indexStr"/>                
            <xsl:text>+ "\"" </xsl:text>
            <xsl:value-of select="$newSeparator"/>                                
        </xsl:if>                    
            
        <xsl:text>);&nl;</xsl:text>                                      

    </xsl:template>
                
    <!-- getFieldNames -->
    <xsl:template name="getFieldNames">
        <xsl:param name="indent"/>
        <xsl:param name="member"/>
        <xsl:param name="isKey" select="-1"/> <!-- -1: No check the type of field -->
        <xsl:param name="parameters" select="0"/>     
        <xsl:param name="separator"/>
        <xsl:param name="function"/>
        <xsl:param name="previousMemberKind" select="''"/>            
        <xsl:param name="indexStr" select="''"/>            
        <xsl:param name="caseStr" select="''"/>            
                                   
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
            <xsl:text>if ((fields_mask &amp; FieldsKind.KEY_FIELDS) != 0) {&nl;</xsl:text>
        </xsl:if>            
        <xsl:if test="$isKey = 0">
            <xsl:value-of select="$indent"/>                
            <xsl:text>if ((fields_mask &amp; FieldsKind.NO_KEY_FIELDS) != 0) {&nl;</xsl:text>                                
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

                <xsl:if test="$function != 'get_insert_parameters' and $member/@name != ''">
                    <xsl:call-template name="addStringToPrefix">
                        <xsl:with-param name="indent" select="$indent"/>
                        <xsl:with-param name="string" select="$member/@name"/>
                        <xsl:with-param name="indexStr" select="$indexStr"/>
                        <xsl:with-param name="caseStr" select="$caseStr"/>
                    </xsl:call-template>
                </xsl:if>
                                                            
                <xsl:value-of select="$newIndent"/>                                                        
                <xsl:value-of select="$descNode/@type"/>
                <xsl:text>TypeSupport.get_instance().</xsl:text>
                <xsl:value-of select="$function"/>
                <xsl:text>(</xsl:text>                    
                                        
                <xsl:choose>
                    <xsl:when test="$function = 'get_insert_parameters'">
                        <xsl:text>sql);&nl;</xsl:text>                                                        
                    </xsl:when>
                    <xsl:when test="$function = 'get_insert_field_names'">
                        <xsl:text>newNamePrefix,sql);&nl;</xsl:text>                            
                    </xsl:when>                        
                    <xsl:otherwise>                        
                        <xsl:text>newNamePrefix,sql,FieldsKind.NO_KEY_FIELDS|FieldsKind.KEY_FIELDS);&nl;</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                                                                                                                                                                                    
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
                                                                                                                        
                <xsl:value-of select="$indent"/>
                <xsl:text>{&nl;</xsl:text>
                <xsl:value-of select="$indent"/>
                <xsl:text>    int indexArr[] = new int[</xsl:text>
                <xsl:value-of select="count($cardinalityNode/dimension)"/>
                <xsl:text>];&nl;</xsl:text>       
                                                                         
                <xsl:call-template name="generateArrayLoopForGetFieldNames">
                    <xsl:with-param name="indent" select="concat($indent,'    ')"/>                        
                    <xsl:with-param name="cardinalityNode" select="$cardinalityNode"/>            
                    <xsl:with-param name="member" select="$member"/>     
                    <xsl:with-param name="memberKind" select="$memberKind"/>                        
                    <xsl:with-param name="indexStr" select="$arrIndexStr"/>
                    <xsl:with-param name="parameters" select="$parameters"/>     
                    <xsl:with-param name="separator" select="$separator"/>
                    <xsl:with-param name="function" select="$function"/>                                                
                    <xsl:with-param name="caseStr" select="$caseStr"/>
                </xsl:call-template>                        
                                                        
                <xsl:value-of select="$indent"/>                                        
                <xsl:text>}&nl;</xsl:text> 
                                                                                            
            </xsl:when>
                                
            <xsl:when test="$memberKind = 'sequence'">
                <xsl:variable name="length">
                    <xsl:call-template name="getBaseSequenceLength">
                        <xsl:with-param name="member" select="$member"/>        
                    </xsl:call-template>                                                    
                </xsl:variable>                    
                    
                <xsl:variable name="lengthElement">
                    <xsl:call-template name="createSeqLengthElement">
                        <xsl:with-param name="name" select="concat('&quot;',
                                                                   $member/@name,'&quot;',$indexStr)"/>
                    </xsl:call-template>
                </xsl:variable>  
                                        
                <xsl:variable name="lengthNode" select="xalan:nodeset($lengthElement)/node()"/>
                                                            
                <xsl:variable name="seqIndexStr">
                    <xsl:value-of select="$indexStr"/>                        
                    <xsl:call-template name="generateIndexStr">
                        <xsl:with-param name="memberKind" select="$memberKind"/>
                    </xsl:call-template>                                                                            
                </xsl:variable>
                                                            
                <xsl:value-of select="$newIndent"/>
                <xsl:text>{&nl;</xsl:text>
                <xsl:value-of select="$newIndent"/>
                <xsl:text>    int i;&nl;</xsl:text>                    
                                                                                
                <xsl:call-template name="getFieldNames">
                    <xsl:with-param name="indent" select="concat($newIndent,'    ')"/>
                    <xsl:with-param name="member" select="$lengthNode"/>
                    <xsl:with-param name="isKey" select="-1"/>
                    <xsl:with-param name="parameters" select="$parameters"/>     
                    <xsl:with-param name="separator" select="$separator"/>
                    <xsl:with-param name="function" select="$function"/>                        
                    <xsl:with-param name="caseStr" select="$caseStr"/>
                </xsl:call-template>                      
                    
                <xsl:value-of select="$newIndent"/>                 
                <xsl:text>    for (i=0;i&lt;</xsl:text><xsl:value-of select="$length"/>                                        
                <xsl:text>;i++) {&nl;&nl;</xsl:text>
                                                            
                <xsl:call-template name="getFieldNames">
                    <xsl:with-param name="indent" select="concat($newIndent,'        ')"/>
                    <xsl:with-param name="member" select="$member"/>
                    <xsl:with-param name="isKey" select="-1"/>
                    <xsl:with-param name="parameters" select="$parameters"/>     
                    <xsl:with-param name="separator" select="$separator"/>
                    <xsl:with-param name="function" select="$function"/>
                    <xsl:with-param name="previousMemberKind" select="$memberKind"/>                         
                    <xsl:with-param name="indexStr" select="$seqIndexStr"/>                        
                    <xsl:with-param name="caseStr" select="$caseStr"/>
                </xsl:call-template>                      
                
                <xsl:value-of select="$newIndent"/>                                                                            
                <xsl:text>    }&nl;</xsl:text>  
                                                                                
                <xsl:value-of select="$newIndent"/>                                        
                <xsl:text>}&nl;</xsl:text>
                                        
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
                            <xsl:with-param name="caseStr" select="$caseStr"/>
                            <xsl:with-param name="function" select="$function"/>                        
                        </xsl:call-template>                        
                </xsl:if>
            </xsl:otherwise>
                
        </xsl:choose>

        <xsl:if test="$isKey = 1 or $isKey = 0">                        
            <xsl:value-of select="$indent"/>                
            <xsl:text>}&nl;</xsl:text>        
        </xsl:if>                
            
        <xsl:text>&nl;</xsl:text>
                                                                                
    </xsl:template>
        
    <!-- declarePrimitiveField -->
    <xsl:template name="declarePrimitiveField">
        <xsl:param name="indent"/>
        <xsl:param name="member"/>
        <xsl:param name="descNode"/>
        <xsl:param name="memberKind"/>
        <xsl:param name="indexStr"/>                        
        <xsl:param name="caseStr"/>                        
                                                                                                                  
        <xsl:text>sql.append("\"" + name_prefix + delimiter </xsl:text> 
                                                
        <xsl:variable name="bfStr">
            <xsl:if test="$descNode/@bitField != ''">
                <xsl:text> + ":"</xsl:text>
                <xsl:if test="$descNode/@bitKind ='lastBitField'">
                    <xsl:text> + "!"</xsl:text>
                </xsl:if>
                <xsl:text> + (</xsl:text>
                <xsl:value-of select="$descNode/@bitField"/>
                <xsl:text>)</xsl:text>
            </xsl:if>
            <xsl:text></xsl:text>
        </xsl:variable>

        <xsl:value-of select="$caseStr"/>                                            
            
        <xsl:if test = "name($member) != 'enum'">                
            <xsl:text> +</xsl:text>
            <!-- The sequence length field is not a literal. We shouldn't include "-->            
            <xsl:if test="not(contains($member/@name,'&quot;'))"> 
                <xsl:text> "</xsl:text>
            </xsl:if>
            <xsl:value-of select="$member/@name"/>                        
            <xsl:if test="not(contains($member/@name,'&quot;'))">                
                <xsl:text>"</xsl:text>                
            </xsl:if>
        </xsl:if>
            
        <xsl:value-of select="$bfStr"/>                        
        <xsl:value-of select="$indexStr"/>                                                                        
        <xsl:text> + "\" " + </xsl:text>
                                                                                                            
        <xsl:choose>             
            <xsl:when test="name($member) = 'enum' or $memberKind = 'bitfield'">
                <xsl:text>"INTEGER"</xsl:text>                    
            </xsl:when>
            <xsl:when test="$memberKind = 'string' or $memberKind = 'wstring'">                        
                    
                <xsl:variable name="stringLength">
                    <xsl:call-template name="getBaseStringLength">
                        <xsl:with-param name="member" select="$member"/>    
                    </xsl:call-template>            
                </xsl:variable>        
                 
                <xsl:if test = "$memberKind = 'string'">
                    <xsl:text>sql_string + "(" + </xsl:text>
                    <xsl:value-of select="$stringLength"/>
                    <xsl:text> + ") " + sql_char_attribute</xsl:text>                        
                </xsl:if>
                    
                <xsl:if test = "$memberKind = 'wstring'">
                    <xsl:text>sql_wstring + "(" + </xsl:text>
                    <xsl:value-of select="$stringLength"/>
                    <xsl:text> + ") " + sql_wchar_attribute</xsl:text>                              
                </xsl:if>
                                        
            </xsl:when>
            <xsl:when test="$descNode/@type = 'short' or $descNode/@type = 'unsignedshort'">
                <xsl:text>"SMALLINT"</xsl:text>
            </xsl:when>
            <xsl:when test="$descNode/@type = 'long' or $descNode/@type = 'unsignedlong'">
                <xsl:text>"INTEGER"</xsl:text>                        
            </xsl:when>                    
            <xsl:when test="$descNode/@type = 'char'">
                <xsl:text>sql_char + "(1) " + sql_char_attribute</xsl:text>
            </xsl:when>                                        
            <xsl:when test="$descNode/@type = 'wchar'">
                <xsl:text>sql_wchar + "(1) " + sql_wchar_attribute</xsl:text>
            </xsl:when>                                                            
            <xsl:when test="$descNode/@type = 'octet'">
                <xsl:text>"BINARY(1)"</xsl:text>                        
            </xsl:when>                                                                                                    
            <xsl:when test="$descNode/@type = 'boolean'">
                <xsl:text>"TINYINT"</xsl:text>                                                
            </xsl:when>                   
            <xsl:when test="$descNode/@type = 'double'">
                <xsl:text>"DOUBLE"</xsl:text>                                                
            </xsl:when>
            <xsl:when test="$descNode/@type = 'float'">
                <xsl:text>"REAL"</xsl:text>                                                
            </xsl:when>                    
            <xsl:when test="$descNode/@type = 'longlong' or $descNode/@type = 'unsignedlonglong'">
                <xsl:text>"BIGINT"</xsl:text>                                                
            </xsl:when>
            <xsl:when test="$descNode/@type = 'longdouble'">
                <xsl:text>"BINARY(16)"</xsl:text>                                                
            </xsl:when>
            <xsl:otherwise>                        
            </xsl:otherwise>
        </xsl:choose> 
            
        <xsl:text> + " " + nullString + ", ");&nl;&nl;</xsl:text>
                                                                                                            
    </xsl:template>            
                     
    <!-- declareField -->
    <xsl:template name="declareField">
        <xsl:param name="indent"/>
        <xsl:param name="member"/>
        <xsl:param name="previousMemberKind" select="''"/>
        <xsl:param name="indexStr" select="''"/>
        <xsl:param name="caseStr" select="''"/>  <!-- For unions members -->
                                                                                        
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
                        <xsl:with-param name="caseStr" select="$caseStr"/>
                    </xsl:call-template>
                </xsl:if>                      
                    
                <xsl:value-of select="$indent"/>
                                        
                <xsl:value-of select="$descNode/@type"/>
                <xsl:text>TypeSupport.get_instance().get_create_table_field_dcl(connection_kind,</xsl:text>                    
                <xsl:text>newNamePrefix,sql,allow_null);&nl;&nl;</xsl:text>
                                                            
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
                                                                                                                        
                <xsl:value-of select="$indent"/>
                <xsl:text>{&nl;</xsl:text>
                <xsl:value-of select="$indent"/>
                <xsl:text>    int indexArr[] = new int[</xsl:text>
                <xsl:value-of select="count($cardinalityNode/dimension)"/>
                <xsl:text>];&nl;</xsl:text>                    
                    
                <xsl:call-template name="generateArrayLoopForDeclareField">
                    <xsl:with-param name="indent" select="concat($indent,'    ')"/>                        
                    <xsl:with-param name="cardinalityNode" select="$cardinalityNode"/>            
                    <xsl:with-param name="member" select="$member"/>     
                    <xsl:with-param name="memberKind" select="$memberKind"/>                        
                    <xsl:with-param name="indexStr" select="$arrIndexStr"/>                        
                    <xsl:with-param name="caseStr" select="$caseStr"/>
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
                                                                                                    
                <xsl:value-of select="$indent"/>
                <xsl:text>{&nl;</xsl:text>
                <xsl:value-of select="$indent"/>
                <xsl:text>    int i;&nl;</xsl:text>                    
                <xsl:value-of select="$indent"/>                    
                <xsl:text>    boolean oldAllowNull;&nl;</xsl:text>                                        
                  
                <xsl:variable name="lengthElement">
                    <xsl:call-template name="createSeqLengthElement">
                        <xsl:with-param name="name" select="concat('&quot;',$member/@name,'&quot;',$indexStr)"/>
                        <xsl:with-param name="caseStr" select="$caseStr"/>
                    </xsl:call-template>
                </xsl:variable>  
                    
                <xsl:variable name="lengthNode" select="xalan:nodeset($lengthElement)/node()"/>
                    
                <xsl:call-template name="declareField">
                    <xsl:with-param name="indent" select="concat($indent,'    ')"/>
                    <xsl:with-param name="member" select="$lengthNode"/>
                    <xsl:with-param name="indexStr" select="''"/>
                    <xsl:with-param name="caseStr" select="$caseStr"/>
                </xsl:call-template>                        
                    
                <xsl:value-of select="$indent"/>                                                     
                <xsl:text>    oldAllowNull = allow_null;&nl;</xsl:text>                    
                <xsl:value-of select="$indent"/>                    
                <xsl:text>    allow_null = true;&nl;</xsl:text>                                        
                <xsl:value-of select="$indent"/>                    
                <xsl:text>    nullString = "NULL";&nl;</xsl:text>
                                                                                                                        
                <xsl:value-of select="$indent"/>                 
                <xsl:text>    for (i=0;i&lt;</xsl:text><xsl:value-of select="$length"/>
                <xsl:text>;i++) {&nl;&nl;</xsl:text>
                                                                                                                                        
                <xsl:call-template name="declareField">
                    <xsl:with-param name="indent" select="concat($indent,'        ')"/>
                    <xsl:with-param name="member" select="$member"/>
                    <xsl:with-param name="previousMemberKind" select="$memberKind"/>
                    <xsl:with-param name="indexStr" select="$seqIndexStr"/>
                    <xsl:with-param name="caseStr" select="$caseStr"/>
                </xsl:call-template>

                <xsl:value-of select="$indent"/>                                                                            
                <xsl:text>    }&nl;</xsl:text>  
                <xsl:value-of select="$indent"/>
                <xsl:text>    allow_null = oldAllowNull;&nl;</xsl:text>
                <xsl:value-of select="$indent"/>
                <xsl:text>    if (allow_null == false) {&nl;</xsl:text>                    
                <xsl:value-of select="$indent"/>
                <xsl:text>        nullString = "NOT NULL";&nl;</xsl:text>                    
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
                        <xsl:with-param name="caseStr" select="$caseStr"/>
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
                                
        <xsl:if test="name($member) = 'enum'">            
            <xsl:call-template name="bindParameter">
                <xsl:with-param name="indent" select="$indent"/>
                <xsl:with-param name="function" select="'setInt'"/>
                <xsl:with-param name="sqlType" select="'java.sql.Types.INTEGER'"/>            
                <xsl:with-param name="memberPointer" select="concat($memberPointer,'.ordinal()')"/>
            </xsl:call-template>                    
        </xsl:if>            
            
        <xsl:if test="$memberKind = 'bitfield'">
            <xsl:call-template name="bindParameter">
                <xsl:with-param name="indent" select="$indent"/>
                <xsl:with-param name="function" select="'setInt'"/>
                <xsl:with-param name="sqlType" select="'java.sql.Types.INTEGER'"/>            
                <xsl:with-param name="memberPointer" select="concat('(int)(',$memberPointer,')')"/>
            </xsl:call-template>
        </xsl:if>                
                                                            
        <xsl:if test="$memberKind = 'scalar'">
            <xsl:choose>
                <xsl:when test="$descNode/@type = 'short' or $descNode/@type = 'unsignedshort'">
                    <xsl:call-template name="bindParameter">
                        <xsl:with-param name="indent" select="$indent"/>
                        <xsl:with-param name="function" select="'setShort'"/>
                        <xsl:with-param name="sqlType" select="'java.sql.Types.SMALLINT'"/>            
                        <xsl:with-param name="memberPointer" select="$memberPointer"/>
                    </xsl:call-template>                    
                </xsl:when>
                <xsl:when test="$descNode/@type = 'long' or $descNode/@type = 'unsignedlong'">
                    <xsl:call-template name="bindParameter">
                        <xsl:with-param name="indent" select="$indent"/>
                        <xsl:with-param name="function" select="'setInt'"/>
                        <xsl:with-param name="sqlType" select="'java.sql.Types.INTEGER'"/>            
                        <xsl:with-param name="memberPointer" select="$memberPointer"/>
                    </xsl:call-template>                    
                </xsl:when>
                <xsl:when test="$descNode/@type = 'char' or $descNode/@type = 'wchar'">                        
                    <xsl:call-template name="bindParameter">
                        <xsl:with-param name="indent" select="$indent"/>
                        <xsl:with-param name="function" select="'setString'"/>
                        <xsl:with-param name="sqlType" select="'java.sql.Types.CHAR'"/>            
                        <xsl:with-param name="memberPointer" select="$memberPointer"/>
                        <xsl:with-param name="type" select="$descNode/@type"/>                            
                    </xsl:call-template>                    
                </xsl:when>
                <xsl:when test="$descNode/@type = 'octet'">
                    <xsl:call-template name="bindParameter">
                        <xsl:with-param name="indent" select="$indent"/>
                        <xsl:with-param name="function" select="'setBytes'"/>
                        <xsl:with-param name="sqlType" select="'java.sql.Types.BINARY'"/>            
                        <xsl:with-param name="memberPointer" select="$memberPointer"/>
                        <xsl:with-param name="type" select="$descNode/@type"/>                            
                    </xsl:call-template>                                            
                </xsl:when>                                                                                                    
                <xsl:when test="$descNode/@type = 'boolean'">
                    <xsl:call-template name="bindParameter">
                        <xsl:with-param name="indent" select="$indent"/>
                        <xsl:with-param name="function" select="'setByte'"/>
                        <xsl:with-param name="sqlType" select="'java.sql.Types.TINYINT'"/>            
                        <xsl:with-param name="memberPointer" select="$memberPointer"/>
                        <xsl:with-param name="type" select="$descNode/@type"/>                            
                    </xsl:call-template>
                </xsl:when>                    
                <xsl:when test="$descNode/@type = 'double'">
                    <xsl:call-template name="bindParameter">
                        <xsl:with-param name="indent" select="$indent"/>
                        <xsl:with-param name="function" select="'setDouble'"/>
                        <xsl:with-param name="sqlType" select="'java.sql.Types.DOUBLE'"/>            
                        <xsl:with-param name="memberPointer" select="$memberPointer"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="$descNode/@type = 'float'">
                    <xsl:call-template name="bindParameter">
                        <xsl:with-param name="indent" select="$indent"/>
                        <xsl:with-param name="function" select="'setFloat'"/>
                        <xsl:with-param name="sqlType" select="'java.sql.Types.FLOAT'"/>            
                        <xsl:with-param name="memberPointer" select="$memberPointer"/>
                    </xsl:call-template>
                </xsl:when>                    
                <xsl:when test="$descNode/@type = 'longlong' or $descNode/@type = 'unsignedlonglong'">
                    <xsl:call-template name="bindParameter">
                        <xsl:with-param name="indent" select="$indent"/>
                        <xsl:with-param name="function" select="'setDouble'"/>
                        <xsl:with-param name="sqlType" select="'java.sql.Types.BIGINT'"/>            
                        <xsl:with-param name="memberPointer" select="$memberPointer"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="$descNode/@type = 'longdouble'">
                    <xsl:call-template name="bindParameter">
                        <xsl:with-param name="indent" select="$indent"/>
                        <xsl:with-param name="function" select="'setBytes'"/>
                        <xsl:with-param name="sqlType" select="'java.sql.Types.BINARY'"/>            
                        <xsl:with-param name="memberPointer" select="$memberPointer"/>
                        <xsl:with-param name="type" select="$descNode/@type"/>
                    </xsl:call-template>                        
                </xsl:when>                                                        
                <xsl:otherwise>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
            
        <xsl:if test="$memberKind = 'string' or $memberKind = 'wstring'">
            <xsl:call-template name="bindParameter">
                <xsl:with-param name="indent" select="$indent"/>
                <xsl:with-param name="function" select="'setString'"/>
                <xsl:with-param name="sqlType" select="'java.sql.Types.CHAR'"/>            
                <xsl:with-param name="memberPointer" select="$memberPointer"/>
                <xsl:with-param name="type" select="$descNode/@type"/>
            </xsl:call-template>                        
        </xsl:if>
                                                                                    
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
            <xsl:text>if ((fields_mask &amp; FieldsKind.KEY_FIELDS) != 0) {&nl;</xsl:text>                                
        </xsl:if>            
        <xsl:if test="$isKey = 0">
            <xsl:value-of select="$indent"/>                          
            <xsl:text>if ((fields_mask &amp; FieldsKind.NO_KEY_FIELDS) != 0) {&nl;</xsl:text>                                
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
            <xsl:text>if (oldAssignNull != true &amp;&amp; (</xsl:text>                                                            
           
            <xsl:choose>
                <xsl:when test="not($member/cases/case[@value='default'])">                        
                    <xsl:for-each select="$member/cases/case">
                        <xsl:value-of select="'sample._d'"/>
                        <xsl:text>== (</xsl:text>
                        <xsl:value-of select="./@value"/>
                        <xsl:text>)</xsl:text>
            
                        <xsl:if test="position()!=last()">
                            <xsl:text> || </xsl:text>
                        </xsl:if>
                    </xsl:for-each>                
                               
                    <xsl:text>)) {&nl;</xsl:text>                                    

                    <xsl:value-of select="$newIndent"/>                                                        
                    <xsl:text>    assign_null = false;&nl;</xsl:text>    
                    <xsl:value-of select="$newIndent"/>                                                            
                    <xsl:text>    isDefault = false;&nl;</xsl:text>                
                
                </xsl:when>
                <xsl:otherwise> <!-- default case for unions -->
                    <xsl:text>isDefault == true)) {&nl;</xsl:text>                        
                    <xsl:value-of select="$newIndent"/>                                                        
                    <xsl:text>    assign_null = false;&nl;</xsl:text>    
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
                        <xsl:with-param name="typeKind" select="$descNode/@typeKind"/>
                        <xsl:with-param name="type" select="$descNode/@type"/>                                        
                        <xsl:with-param name="defaultMemberPointer" select="$defaultMemberPointer"/>                        
                    </xsl:call-template>                    
                </xsl:variable>                                
                    
                <xsl:value-of select="$newIndent"/>                    
                <xsl:text>index = </xsl:text><xsl:value-of select="$descNode/@type"/>
                <xsl:text>TypeSupport.get_instance().bind_parameters(stmt,index,(</xsl:text>
                <xsl:value-of select="$descNode/@type"/>
                <xsl:text>)(</xsl:text>
                <xsl:value-of select="$memberPointer"/>
                <xsl:text>),FieldsKind.KEY_FIELDS|FieldsKind.NO_KEY_FIELDS,assign_null);&nl;</xsl:text>
                    
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
                <xsl:text>    int[] indexArr = new int[</xsl:text>
                <xsl:value-of select="count($cardinalityNode/dimension)"/>
                <xsl:text>];&nl;</xsl:text>
                    
                <xsl:variable name="memberPointer">
                    <xsl:call-template name="generateMemberPtr">
                        <xsl:with-param name="member" select="$member"/>
                        <xsl:with-param name="memberKind" select="$memberKind"/>
                        <xsl:with-param name="typeKind" select="$descNode/@typeKind"/>                            
                        <xsl:with-param name="type" select="$descNode/@type"/>                            
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
                <xsl:text>    int i,length;&nl;</xsl:text>                    
                <xsl:value-of select="$newIndent"/>                                            
                <xsl:text>    boolean seqOldAssignNull;&nl;</xsl:text>                    
                <xsl:value-of select="$newIndent"/>                    
                <xsl:text>    seqOldAssignNull = assign_null;&nl;&nl;</xsl:text>                                        
                    
                <xsl:variable name="memberPointer1">
                    <xsl:call-template name="generateMemberPtr">
                        <xsl:with-param name="member" select="$member"/>
                        <xsl:with-param name="memberKind" select="'scalar'"/>
                        <xsl:with-param name="typeKind" select="'builtin'"/>                            
                        <xsl:with-param name="type" select="'int'"/>                            
                        <xsl:with-param name="defaultMemberPointer" select="$defaultMemberPointer"/>                        
                    </xsl:call-template>                    
                    <xsl:if test="name($member/..) = 'typedef'">                        
                        <xsl:text>.userData</xsl:text>
                    </xsl:if>                        
                </xsl:variable>                                
                    
                <xsl:value-of select="$newIndent"/>                                                            
                <xsl:text>    length = </xsl:text>
                    
                <xsl:value-of select="concat('(',$memberPointer1,').size()')"/>
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
                    <xsl:with-param name="defaultMemberPointer" select="concat('(',$memberPointer1,').size()')"/>
                </xsl:call-template>                        
                    
                <xsl:value-of select="$newIndent"/>                 
                <xsl:text>    for (i=0;i&lt;</xsl:text><xsl:value-of select="$length"/>
                <xsl:text>;i++) {&nl;&nl;</xsl:text>
                    
                <xsl:variable name="memberPointer2">
                    <xsl:call-template name="generateMemberPtr">
                        <xsl:with-param name="member" select="$member"/>
                        <xsl:with-param name="memberKind" select="$memberKind"/>
                        <xsl:with-param name="typeKind" select="$descNode/@typeKind"/>                            
                        <xsl:with-param name="type" select="$descNode/@type"/>                            
                        <xsl:with-param name="defaultMemberPointer" select="$defaultMemberPointer"/>                        
                    </xsl:call-template>                    
                </xsl:variable>                                
                                        
                <xsl:value-of select="$newIndent"/>
                <xsl:text>        if (i >= length) {&nl;</xsl:text>
                <xsl:value-of select="$newIndent"/>
                <xsl:text>            assign_null = true;&nl;</xsl:text>
                
                <xsl:if test="$descNode/@typeKind != 'builtin'">

                    <xsl:value-of select="$newIndent"/>                        
                    <xsl:text>            </xsl:text>

                    <xsl:choose>
                        <xsl:when test="$descNode/@type = 'string'">                                                            
                            <xsl:text>String element = "";&nl;</xsl:text>                                                         
                        </xsl:when>
                        <xsl:otherwise>                 
                            <xsl:value-of select="$descNode/@type"/>
                            <xsl:text> element = (</xsl:text>        
                            <xsl:value-of select="$descNode/@type"/>                                                 
                            <xsl:text>) </xsl:text>
                            <xsl:value-of select="$descNode/@type"/>                        
                            <xsl:text>.create</xsl:text>
                            <xsl:text>();&nl;</xsl:text>                                               
                        </xsl:otherwise>
                    </xsl:choose>                    
                        
                    <xsl:call-template name="bindParameters">
                        <xsl:with-param name="indent" select="concat($newIndent,'            ')"/>            
                        <xsl:with-param name="member" select="$member"/>        
                        <xsl:with-param name="isKey" select="-1"/>            
                        <xsl:with-param name="defaultMemberPointer" select="'element'"/>
                        <xsl:with-param name="previousMemberKind" select="$memberKind"/>                        
                    </xsl:call-template>                        
                                    
                    <xsl:value-of select="$newIndent"/>
                    <xsl:text>        } else {&nl;</xsl:text>
                                                                                                                            
                    <xsl:call-template name="bindParameters">
                        <xsl:with-param name="indent" select="concat($newIndent,'            ')"/>            
                        <xsl:with-param name="member" select="$member"/>        
                        <xsl:with-param name="isKey" select="-1"/>            
                        <xsl:with-param name="defaultMemberPointer" select="$memberPointer2"/>
                        <xsl:with-param name="previousMemberKind" select="$memberKind"/>                        
                    </xsl:call-template>                        

                    <xsl:value-of select="$newIndent"/>                                        
                    <xsl:text>        }&nl;</xsl:text>
                        
                </xsl:if>                            
                    
                <xsl:if test="$descNode/@typeKind = 'builtin'">                        
                        
                    <xsl:value-of select="$newIndent"/>
                    <xsl:text>        }&nl;</xsl:text>
                        
                    <xsl:call-template name="bindParameters">
                        <xsl:with-param name="indent" select="concat($newIndent,'        ')"/>            
                        <xsl:with-param name="member" select="$member"/>        
                        <xsl:with-param name="isKey" select="-1"/>            
                        <xsl:with-param name="defaultMemberPointer" select="$memberPointer2"/>
                        <xsl:with-param name="previousMemberKind" select="$memberKind"/>                        
                    </xsl:call-template>                        
                                                
                </xsl:if>
                                                                                                                                                                
                <xsl:value-of select="$newIndent"/>                                                                            
                <xsl:text>    }&nl;&nl;</xsl:text>  
                    
                <xsl:value-of select="$newIndent"/>                    
                <xsl:text>    assign_null = seqOldAssignNull;&nl;</xsl:text>
                                                                                                                                                                                                       
                <xsl:value-of select="$newIndent"/>                                        
                <xsl:text>}&nl;&nl;</xsl:text>
                                                                                
            </xsl:when>
                
            <xsl:otherwise>
                <xsl:variable name="memberPointer">
                    <xsl:call-template name="generateMemberPtr">
                        <xsl:with-param name="member" select="$member"/>
                        <xsl:with-param name="memberKind" select="$memberKind"/>
                        <xsl:with-param name="typeKind" select="$descNode/@typeKind"/>                            
                        <xsl:with-param name="type" select="$descNode/@type"/>                            
                        <xsl:with-param name="defaultMemberPointer" select="$defaultMemberPointer"/>                        
                    </xsl:call-template>                    
                </xsl:variable>                                

                <!-- bitfields without names are not stored -->                    
                <xsl:if test="not($descNode/@bitField != '' and $descNode/@bitKind = 'ignore')"> 
                                                                                
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
            <xsl:text>assign_null = true;&nl;</xsl:text>    
        </xsl:if>
                        
        <xsl:if test="$isKey = 1 or $isKey = 0">
            <xsl:value-of select="$indent"/>                
            <xsl:text>}&nl;&nl;</xsl:text>
        </xsl:if>                
                        
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
        <xsl:param name="caseStr"/>
                                            
        <xsl:value-of select="$indent"/>
            
        <xsl:text>newNamePrefix = name_prefix + delimiter </xsl:text>
        <xsl:value-of select="$caseStr"/>            
        <xsl:text> + "</xsl:text>                                    
        <xsl:value-of select="$string"/>
        <xsl:text>" </xsl:text>                        
        <xsl:value-of select="$indexStr"/>
        <xsl:text>;&nl;</xsl:text>                                
                        
    </xsl:template>

    <!-- createSeqLengthElement -->        
    <xsl:template name="createSeqLengthElement">
        <xsl:param name="name"/>
        <member enum="no" type="long" name="{concat($name,'+ &quot;#length&quot;')}"/>                    
    </xsl:template>
        
    <!-- generateArrayLoopForGetFieldNames -->                               
    <xsl:template name="generateArrayLoopForGetFieldNames">
        <xsl:param name="indent"/>                        
        <xsl:param name="cardinalityNode"/>            
        <xsl:param name="level" select="1"/>            
        <xsl:param name="member"/>     
        <xsl:param name="memberKind"/>                        
        <xsl:param name="indexStr"/>                        
        <xsl:param name="parameters"/>     
        <xsl:param name="separator"/>
        <xsl:param name="function"/>
        <xsl:param name="caseStr"/>
                        
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
                    <xsl:with-param name="parameters" select="$parameters"/>     
                    <xsl:with-param name="separator" select="$separator"/>
                    <xsl:with-param name="function" select="$function"/>
                    <xsl:with-param name="caseStr" select="$caseStr"/>
                </xsl:call-template>                                                        
            </xsl:when>                
            <xsl:otherwise>                    
                <xsl:call-template name="getFieldNames">
                    <xsl:with-param name="indent" select="concat($indent,'    ')"/>
                    <xsl:with-param name="member" select="$member"/>
                    <xsl:with-param name="previousMemberKind" select="$memberKind"/> 
                    <xsl:with-param name="indexStr" select="$indexStr"/>
                    <xsl:with-param name="parameters" select="$parameters"/>     
                    <xsl:with-param name="separator" select="$separator"/>
                    <xsl:with-param name="function" select="$function"/>                        
                    <xsl:with-param name="caseStr" select="$caseStr"/>
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
        <xsl:param name="caseStr"/>
                                                
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
                    <xsl:with-param name="caseStr" select="$caseStr"/>
                </xsl:call-template>                                    
            </xsl:when>                
            <xsl:otherwise>                    
                <xsl:call-template name="declareField">
                    <xsl:with-param name="indent" select="concat($indent,'    ')"/>
                    <xsl:with-param name="member" select="$member"/>
                    <xsl:with-param name="previousMemberKind" select="$memberKind"/> 
                    <xsl:with-param name="indexStr" select="$indexStr"/>                                                    
                    <xsl:with-param name="caseStr" select="$caseStr"/>
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
                <xsl:value-of select="'sample._d'"/>
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
        <xsl:param name="typeKind"/>            
        <xsl:param name="type"/>            
        <xsl:param name="cardinalityNode"/>
        <xsl:param name="defaultMemberPointer" select="''"/>

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
                        <xsl:value-of select="'sample.'"/>
                        <xsl:value-of select="$member/@name"/>
                    </xsl:if>                                                
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="'sample'"/>                                                                                
                    <xsl:if test="$memberKind = 'sequence'">                            
                        <xsl:text>.userData</xsl:text>
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>                
                                
        <xsl:choose>
             <xsl:when test = "$defaultMemberPointer = 'null'">       
                 <xsl:value-of select="$memberPointer"/>                     
             </xsl:when>
                
             <xsl:when test="$memberKind = 'arraySequence' or $memberKind = 'array'">
                 <xsl:value-of select="$memberPointer"/>                              
                 <xsl:for-each select="$cardinalityNode/dimension">
                     <xsl:text>[indexArr[</xsl:text><xsl:value-of select="position()-1"/>
                     <xsl:text>]]</xsl:text>
                 </xsl:for-each>                 
             </xsl:when>                
                
             <xsl:when test="$memberKind = 'sequence'">
                 <xsl:choose>
                     <xsl:when test="$typeKind = 'builtin'">                         
                         <xsl:text>((</xsl:text>
                         <xsl:value-of select="$typeInfoMap/type[@idlType=$type]/@nativeType"/>
                         <xsl:text>[])(</xsl:text>
                         <xsl:value-of select="$memberPointer"/>
                         <xsl:text>).getPrimitiveArray())[i]</xsl:text>
                     </xsl:when>
                     <xsl:when test="$type = 'string' or $type = 'wstring'">                         
                         <xsl:text>((String[])(</xsl:text>                     
                         <xsl:value-of select="$memberPointer"/>
                         <xsl:text>).toArray())[i]</xsl:text>
                     </xsl:when>                     
                     <xsl:otherwise>
                         <xsl:value-of select="concat('(',$memberPointer,').toArray()[i]')"/>                                                     
                     </xsl:otherwise>                                                      
                 </xsl:choose>                         
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
                     <xsl:text> + "[" + </xsl:text>
                     <xsl:value-of select="concat('indexArr[',position() - 1 ,']')"/>
                     <xsl:text> + "]"</xsl:text>                                                  
                 </xsl:for-each>                 
             </xsl:when>                                
             <xsl:when test="$memberKind = 'sequence'">
                 <xsl:text>+ "[" + i + "]"</xsl:text>
             </xsl:when>                            
             <xsl:otherwise>                
             </xsl:otherwise>                            
        </xsl:choose>                
    </xsl:template>
                
    <!-- generateCaseStr -->                                    
    <xsl:template name="generateCaseStr">
        <xsl:param name="member"/>                    
                            
        <xsl:if test="$member/cases/case">                                    
            <xsl:text>+ "c(" </xsl:text>
            <xsl:for-each select="$member/cases/case">
                <xsl:if test="@value!='default'">
                    <xsl:text> + </xsl:text>
                    <xsl:choose>
                        <xsl:when test="@value = 'true'">                                
                            <xsl:text>1</xsl:text>
                        </xsl:when>
                        <xsl:when test="@value = 'false'">                                
                            <xsl:text>0</xsl:text>
                        </xsl:when>                    
                        <xsl:otherwise>                                
                            <xsl:value-of select="@value"/>                                
                        </xsl:otherwise>                                    
                    </xsl:choose>
                        
                    <xsl:if test="position() != last()">
                        <xsl:text> + "," </xsl:text>
                    </xsl:if>
                </xsl:if>                      
                <xsl:if test="@value='default'">
                    <xsl:text>+ "def" </xsl:text>
                        
                    <xsl:if test="position() != last()">
                        <xsl:text> + "," </xsl:text>
                    </xsl:if>                        
                </xsl:if>                                        
            </xsl:for-each>                                                                                    
            <xsl:text> + ")."</xsl:text>
        </xsl:if>
            
        <xsl:if test="not($member/cases/case)">
            <xsl:text></xsl:text>                
        </xsl:if>
                                                                                                                        
    </xsl:template>
        
    <!-- bindParameter -->
    <xsl:template name="bindParameter">
        <xsl:param name="indent"/>
        <xsl:param name="function"/>
        <xsl:param name="sqlType"/>            
        <xsl:param name="memberPointer"/>
        <xsl:param name="type" select="''"/>            

        <xsl:value-of select="$indent"/>            
        <xsl:text>if (assign_null == true) {&nl;</xsl:text>            
            
        <xsl:value-of select="concat($indent,'    ')"/>                        
        <xsl:text>stmt.setNull(index,</xsl:text>
        <xsl:value-of select="$sqlType"/>
        <xsl:text>);&nl;</xsl:text>
                        
        <xsl:value-of select="$indent"/>                        
        <xsl:text>} else {&nl;</xsl:text>            

        <xsl:if test="$type = 'char'">
            <xsl:value-of select="$indent"/>                                        
            <xsl:text>    String str = new Character((char)(</xsl:text>
            <xsl:value-of select="$memberPointer"/>                            
            <xsl:text>)).toString();&nl;</xsl:text>                                
        </xsl:if>            
            
        <xsl:if test="$type = 'wchar'">
            <xsl:value-of select="$indent"/>                                        
            <xsl:text>    String str = new Character(</xsl:text>
            <xsl:value-of select="$memberPointer"/>                            
            <xsl:text>).toString();&nl;</xsl:text>                
        </xsl:if>            
                                    
        <xsl:if test="$type = 'octet'">
            <xsl:value-of select="$indent"/>                                        
            <xsl:text>    byte octet[] = new byte[1];&nl;</xsl:text>
            <xsl:value-of select="$indent"/>                                                        
            <xsl:text>    octet[0] = </xsl:text>
            <xsl:value-of select="$memberPointer"/>                            
            <xsl:text>;&nl;</xsl:text>                
        </xsl:if>            
            
        <xsl:if test="$type = 'boolean'">
            <xsl:value-of select="$indent"/>                                        
            <xsl:text>    byte octet;&nl;</xsl:text>
            <xsl:value-of select="$indent"/>                                                        
            <xsl:text>    octet = (</xsl:text>
            <xsl:value-of select="$memberPointer"/>
            <xsl:text> == true)?((byte)1):((byte)0);&nl;</xsl:text>                
        </xsl:if>            
            
        <xsl:if test="$type = 'longdouble'">
            <xsl:value-of select="$indent"/>                                        
            <xsl:text>    byte octets[] = new byte[16];&nl;</xsl:text>
        </xsl:if>            
                                   
        <xsl:value-of select="concat($indent,'    ','stmt.')"/>                        
        <xsl:value-of select="$function"/>            
        <xsl:text>(index,</xsl:text>
        
        <xsl:choose>
            <xsl:when test="$type = 'char' or $type = 'wchar'">                    
                <xsl:value-of select="'str'"/>                    
            </xsl:when>                
            <xsl:when test="$type = 'octet'">    
                <xsl:value-of select="'octet'"/>                
            </xsl:when>
            <xsl:when test="$type = 'boolean'">               
                <xsl:value-of select="'octet'"/>                         
            </xsl:when>
            <xsl:when test="$type = 'longdouble'">               
                <xsl:value-of select="'octets'"/>                         
            </xsl:when>                
            <xsl:otherwise>                    
                <xsl:value-of select="$memberPointer"/>                
            </xsl:otherwise>                
        </xsl:choose>            
                
        <xsl:text>);&nl;</xsl:text>
            
        <xsl:value-of select="$indent"/>                        
        <xsl:text>}&nl;</xsl:text>            
                        
    </xsl:template>            
                                                                                                                                                                                           
</xsl:stylesheet>
