<?xml version="1.0"?>
<!-- 
/* $Id: typeDataWriter.java.xsl,v 1.3 2011/12/04 01:50:15 fernando Exp $
 
   (c) Copyright, Real-Time Innovations, Inc. 2001.  All rights reserved.
   No duplications, whole or partial, manual or electronic, may be made
   without prior written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
 
Modification history:
- - - - - - - - - - -
1.0ac,08dec10,fcs Added copy-java-begin and copy-java-declaration-begin
10ae,22nov10,fcs Added dataWriterSuffix
10ab,25sep09,eh  Added XX_w_params
10u,16jul08,tk  Removed utils.xsl
10u,01jul08,rbw RFE #243: Refactored to expose statically un-type-safe
                writer APIs
10p,31dec07,vtg Made consistent with new type plugin API [First pass]
10l,22apr06,fcs Fixed bug 11070
10l,19apr06,fcs Removed final from the DataWriter class declaration
10j,22mar06,fcs DDSQL support
10f,26jul05,kaj Added API for typeDataWriter lookup_instance.
10f,21jul05,fcs Modified processGlobalElements template call to include element parameter                
10d,15jul05,kaj Renamed (un)register... to (un)register_instance... per spec
10d,13jul05,kaj Moved InstanceHandle_t from topic to infrastructure
10d,09apr05,fcs Generated DataWriter code only if the structure/union is a top-level type
10d,08apr05,fcs DataWriter code for enumeration types is not generated anymore
10d,25aug04,rw  Call processGlobalElements
10d,23aug04,rw  Removed unneeded comments
10c,11may04,rrl Changed DataType suffix to TypeSupport.
40b,06may04,rrl Fixed #8739 by adding the needed method implementation.
40b,26apr04,rrl Modifications to support new deserialize_objectX() API and enum support
                as well as API changes in DataTypeImpl from *I() to *X()
40c,05apr04,rrl Created
-->

<!DOCTYPE xsl:stylesheet [
<!ENTITY nl "&#xa;">                <!--   new line  -->
<!ENTITY indent "    ">             <!-- indentation -->
<!ENTITY namespaceSeperator ".">    <!-- namespace separator -->
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xalan="http://xml.apache.org/xalan"
    version="1.0">

<xsl:include href="typeCommon.java.xsl"/>

<xsl:output method="xml"/>

<xsl:template match="struct">
	<xsl:param name="containerNamespace"/>
        
    <xsl:variable name="topLevel">
        <xsl:call-template name="isTopLevelType">
            <xsl:with-param name="typeNode" select="."/>
        </xsl:call-template>
    </xsl:variable>
       
<xsl:if test="$topLevel='yes'">
        
	<xsl:variable name="fullyQualifiedStructName" select="concat($containerNamespace, @name)"/>
<xsl:variable name="sourceFile">
	<xsl:call-template name="obtainSourceFileName">
		<xsl:with-param name="containerNamespace" select="$containerNamespace"/>
		<xsl:with-param name="typeName" select="concat(@name, $dataWriterSuffix)"/>
	</xsl:call-template>
</xsl:variable>	

    <xsl:apply-templates mode="error-checking"/>

<file name="{$sourceFile}">
<xsl:call-template name="printPackageStatement">
	<xsl:with-param name="containerNamespace" select="$containerNamespace"/>
</xsl:call-template>

<xsl:call-template name="replace-string">
    <xsl:with-param name="search" select="'%%nativeType%%'"/>
    <xsl:with-param name="replace" select="@name"/>
    <xsl:with-param name="text">
<xsl:text><![CDATA[
import com.rti.dds.infrastructure.Time_t;
import com.rti.dds.infrastructure.WriteParams_t;
import com.rti.dds.infrastructure.InstanceHandle_t;
import com.rti.dds.publication.DataWriterImpl;
import com.rti.dds.publication.DataWriterListener;
import com.rti.dds.topic.TypeSupportImpl;
]]></xsl:text>
        <xsl:if test="$database = 'yes'">
<xsl:text>import com.rti.dds.publication.DataWriterQos;
import com.rti.dds.topic.TopicDescription;                
import com.rti.dds.infrastructure.HistoryQosPolicyKind;        
import com.rti.dds.infrastructure.RETCODE_ERROR;                        
import com.rti.ddsql.*;
</xsl:text>                                
        </xsl:if>        
    </xsl:with-param>
</xsl:call-template>

<xsl:apply-templates select="./preceding-sibling::node()[@kind = 'copy-java-begin']" 
                     mode="code-generation-begin">
    <xsl:with-param name="associatedType" select="."/>
</xsl:apply-templates>

<xsl:call-template name="processGlobalElements">
    <xsl:with-param name="element" select="."/>
</xsl:call-template>

<xsl:variable name="replacementMap">
    <map nativeType="{@name}" dataWriterSuffix="{$dataWriterSuffix}"/>
</xsl:variable>

<xsl:call-template name="replace-string-from-map">
    <xsl:with-param name="replacementParamsMap" select="xalan:nodeset($replacementMap)/node()"/>
    <xsl:with-param name="inputString">
<xsl:if test="$database = 'no'">
<xsl:text><![CDATA[

// ===========================================================================

/**
 * A writer for the %%nativeType%% user type.
 */
public class %%nativeType%%%%dataWriterSuffix%% extends DataWriterImpl {
    // -----------------------------------------------------------------------
    // Public Methods
    // -----------------------------------------------------------------------

    public InstanceHandle_t register_instance(%%nativeType%% instance_data) {
        return register_instance_untyped(instance_data);
    }
    
    
    public InstanceHandle_t register_instance_w_timestamp(%%nativeType%% instance_data,
                                                 Time_t source_timestamp) {
        return register_instance_w_timestamp_untyped(
            instance_data, source_timestamp);
    }


    public InstanceHandle_t register_instance_w_params(%%nativeType%% instance_data,
                                                 WriteParams_t params) {
        return register_instance_w_params_untyped(
            instance_data, params);
    }
    

    public void unregister_instance(%%nativeType%% instance_data,
                                     InstanceHandle_t handle) {
        unregister_instance_untyped(instance_data, handle);
    }
    
    
    public void unregister_instance_w_timestamp(%%nativeType%% instance_data,
            InstanceHandle_t handle, Time_t source_timestamp) {
        
        unregister_instance_w_timestamp_untyped(
            instance_data, handle, source_timestamp);
    }


    public void unregister_instance_w_params(%%nativeType%% instance_data,
                                             WriteParams_t params) {
        
        unregister_instance_w_params_untyped(
            instance_data, params);
    }
    
    
    public void write(%%nativeType%% instance_data, InstanceHandle_t handle) {
        write_untyped(instance_data, handle);
    }
    
    
    public void write_w_timestamp(%%nativeType%% instance_data,
            InstanceHandle_t handle, Time_t source_timestamp) {

        write_w_timestamp_untyped(instance_data, handle, source_timestamp);
    }


    public void write_w_params(%%nativeType%% instance_data,
                               WriteParams_t params) {

        write_w_params_untyped(instance_data, params);
    }
    
    
    public void dispose(%%nativeType%% instance_data, InstanceHandle_t instance_handle){
        dispose_untyped(instance_data, instance_handle);
    }
    
    
    public void dispose_w_timestamp(%%nativeType%% instance_data,
            InstanceHandle_t instance_handle, Time_t source_timestamp) {

        dispose_w_timestamp_untyped(
            instance_data, instance_handle, source_timestamp);
    }

    
    public void dispose_w_params(%%nativeType%% instance_data,
                                 WriteParams_t params) {

        dispose_w_params_untyped(instance_data, params);
    }

       
    public void get_key_value(%%nativeType%% key_holder, InstanceHandle_t handle) {
        get_key_value_untyped(key_holder, handle);
    }
    

    public InstanceHandle_t lookup_instance(%%nativeType%% key_holder) {
        return lookup_instance_untyped(key_holder);
    }

    // -----------------------------------------------------------------------
    // Package Methods
    // -----------------------------------------------------------------------

    // --- Constructors: -----------------------------------------------------
    
    /*package*/ %%nativeType%%%%dataWriterSuffix%%(long native_writer, DataWriterListener listener,
                              int mask, TypeSupportImpl type) {
        super(native_writer, listener, mask, type);
    }
}
]]></xsl:text>
</xsl:if>

<xsl:if test="$database = 'yes'">
<xsl:text><![CDATA[

// ===========================================================================

/**
 * A writer for the %%nativeType%% user type.
 */
public class %%nativeType%%%%dataWriterSuffix%% extends DataWriterImpl {
    private DatabaseConnection _dbConnection = null;
    private SQLHelper _sqlHelper = null;
    private int domainId;

    // -----------------------------------------------------------------------
    // Public Methods
    // -----------------------------------------------------------------------

    public InstanceHandle_t register_instance(%%nativeType%% instance_data) {
        return register_instance_untyped(instance_data);
    }
    
    
    public InstanceHandle_t register_instance_w_timestamp(%%nativeType%% instance_data,
                                                 Time_t source_timestamp) {
        return register_instance_w_timestamp_untyped(
            instance_data, source_timestamp);
    }

    
    public void unregister_instance(%%nativeType%% instance_data,
                                     InstanceHandle_t handle) {
        unregister_instance_untyped(instance_data, handle);
    }
    
    
    public void unregister_instance_w_timestamp(%%nativeType%% instance_data,
            InstanceHandle_t handle, Time_t source_timestamp) {
        
        unregister_instance_w_timestamp_untyped(
            instance_data, handle, source_timestamp);
    }
    
    
    public void write(%%nativeType%% instance_data, InstanceHandle_t handle) {
        write_untyped(instance_data, handle);
        store_in_databaseI(instance_data);
    }
    
    
    public void write_w_timestamp(%%nativeType%% instance_data,
            InstanceHandle_t handle, Time_t source_timestamp) {

        write_w_timestamp_untyped(instance_data, handle, source_timestamp);
        store_in_databaseI(instance_data);
    }
    
    
    public void dispose(%%nativeType%% instance_data, InstanceHandle_t instance_handle){
        dispose_untyped(instance_data, instance_handle);
    }
    
    
    public void dispose_w_timestamp(%%nativeType%% instance_data,
            InstanceHandle_t instance_handle, Time_t source_timestamp) {

        dispose_w_timestamp_untyped(
            instance_data, instance_handle, source_timestamp);
    }
    
    
    public void get_key_value(%%nativeType%% key_holder, InstanceHandle_t handle) {
        get_key_value_untyped(key_holder, handle);
    }
    

    public InstanceHandle_t lookup_instance(%%nativeType%% key_holder) {
        return lookup_instance_untyped(key_holder);
    }

    // -----------------------------------------------------------------------
    // Private Methods
    // -----------------------------------------------------------------------

    /**
     * @throws DDS Standard Return Codes.
     */
     
    private void store_in_databaseI(%%nativeType%% instance_data) {
        try {
            if (_dbConnection != null) {         
                if (_dbConnection.get_jdbc_connection() == null) {
                    _dbConnection.open();
                    %%nativeType%%TypeSupport.get_instance().create_database_table(_dbConnection,_sqlHelper);
                }

                try {
                    if (_dbConnection.get_qos().history.history_depth == 0) {
                        /* No History */
                        %%nativeType%%TypeSupport.get_instance().store_sample_in_database(domainId,
                            _dbConnection,instance_data);
                    } else {
                        %%nativeType%%TypeSupport.get_instance().store_sample_in_database_w_history(domainId,
                            _dbConnection,instance_data);
                    }
                } catch (RETCODE_DBMS_ERROR e) {
                    %%nativeType%%TypeSupport.get_instance().create_database_table(_dbConnection,_sqlHelper);

                    if (_dbConnection.get_qos().history.history_depth == 0) {
                        /* No History */
                        %%nativeType%%TypeSupport.get_instance().store_sample_in_database(domainId,
                            _dbConnection,instance_data);
                    } else {
                        %%nativeType%%TypeSupport.get_instance().store_sample_in_database_w_history(domainId,
                            _dbConnection,instance_data);
                    }

                }

             }
        } catch (RETCODE_DBMS_ERROR e) {
             throw new RETCODE_ERROR(e.getMessage());
        }
    }

    // -----------------------------------------------------------------------
    // Package Methods
    // -----------------------------------------------------------------------

    // --- Constructors: -----------------------------------------------------
    
    /*package*/ %%nativeType%%%%dataWriterSuffix%%(long native_writer, DataWriterListener listener,
                              int mask, TypeSupportImpl type) {
        super(native_writer, listener, mask, type);
        DatabaseQos dbQos = null;
        TopicDescription topic;
        DataWriterQos dwQos = new DataWriterQos();

        try {
            get_qos(dwQos);

            _dbConnection = DatabaseConfiguratorImpl.get_database_connection_from_user_dataI(
                                dwQos.user_data.value);
            
            if (_dbConnection != null) {
                dbQos = _dbConnection.get_qos();
                topic = get_topic();
                domainId = get_publisher().get_participant().get_domain_id();

                DatabaseConfiguratorImpl.resolve_database_qosI(
                    domainId,
                    topic.get_name(),
                    topic.get_type_name(),
                    dwQos.history,
                    dbQos);

                _sqlHelper = SQLHelper.create_datawriter_sql_helperI(this);               

                /* Release the global reference to the database connection */
                DatabaseConfiguratorImpl.release_database_connection_global_referenceI(
                    dwQos.user_data.value);
            }

        } catch (Exception e) {
            _dbConnection = null;
            throw new RETCODE_ERROR("Error getting the database connection");
        }
    }
}
]]></xsl:text>
</xsl:if>

</xsl:with-param>
    </xsl:call-template>
</file>

</xsl:if> <!-- if topLevel -->

</xsl:template>

</xsl:stylesheet>
