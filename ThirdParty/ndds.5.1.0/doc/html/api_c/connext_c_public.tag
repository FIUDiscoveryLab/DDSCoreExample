<?xml version='1.0' encoding='UTF-8' standalone='yes' ?>
<tagfile>
  <compound kind="group">
    <name>NDDSClockSelectionModule</name>
    <title>Clock Selection</title>
    <filename>group__NDDSClockSelectionModule.html</filename>
    <docanchor file="group__NDDSClockSelectionModule">NDDSClockSelectionAvailable</docanchor>
    <docanchor file="group__NDDSClockSelectionModule">NDDSClockSelectionStrategy</docanchor>
    <docanchor file="group__NDDSClockSelectionModule">NDDSClockSelectionConfiguration</docanchor>
  </compound>
  <compound kind="group">
    <name>DDSDomainModule</name>
    <title>Domain Module</title>
    <filename>group__DDSDomainModule.html</filename>
    <subgroup>DDSDomainParticipantFactoryModule</subgroup>
    <subgroup>DDSDomainParticipantModule</subgroup>
    <subgroup>DDSBuiltInTopicModule</subgroup>
  </compound>
  <compound kind="group">
    <name>DDSDomainParticipantFactoryModule</name>
    <title>DomainParticipantFactory</title>
    <filename>group__DDSDomainParticipantFactoryModule.html</filename>
    <subgroup>DDSDomainParticipantConfigParamsModule</subgroup>
    <class kind="struct">DDS_DomainParticipantFactoryQos</class>
    <member kind="define">
      <type>#define</type>
      <name>DDS_DomainParticipantFactoryQos_INITIALIZER</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>gaa14b6c67c9c50b0ae9ed46911e0ef0e8</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_TheParticipantFactory</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga07c3de23fd7f25cf9c02c0efaaaa5526</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_DomainParticipantFactoryImpl</type>
      <name>DDS_DomainParticipantFactory</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga206e77e6b4c2b0db6cefa6ed8d85128d</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>DDS_ReturnCode_t(*</type>
      <name>DDS_DomainParticipantFactory_RegisterTypeFunction</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga4f7640cf80739a3e1a8b32136e414015</anchor>
      <arglist>)(DDS_DomainParticipant *participant, const char *type_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_DomainParticipantFactoryQos_equals</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga9152a4b01655bbe1b330defd4f6d0ef1</anchor>
      <arglist>(const struct DDS_DomainParticipantFactoryQos *self, const struct DDS_DomainParticipantFactoryQos *other)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactoryQos_initialize</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga53c7ec8a16dcfff806d864c05c23e187</anchor>
      <arglist>(struct DDS_DomainParticipantFactoryQos *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactoryQos_copy</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga15bfcf9aa43e01057ea0bbf00c525b0b</anchor>
      <arglist>(struct DDS_DomainParticipantFactoryQos *self, const struct DDS_DomainParticipantFactoryQos *source)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactoryQos_finalize</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga6e1eab99dbf5070ddd3c9ff55aa20b75</anchor>
      <arglist>(struct DDS_DomainParticipantFactoryQos *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DomainParticipantFactory *</type>
      <name>DDS_DomainParticipantFactory_get_instance</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga9e3530e68217e932a95a93db6f8da2e6</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactory_finalize_instance</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>gae06876c2f46093fed7e5a727dcc84343</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactory_set_default_participant_qos</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga6e9a92fcd758aae31bdeabbbf5f1b56e</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, const struct DDS_DomainParticipantQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactory_set_default_participant_qos_with_profile</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga095d8f86ff732622d0a1f62aaf89a0b6</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, const char *library_name, const char *profile_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactory_get_default_participant_qos</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>gaf85e5146fe9f1bd10e11fdf871f66c24</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, struct DDS_DomainParticipantQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DomainParticipant *</type>
      <name>DDS_DomainParticipantFactory_create_participant</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga325cf8f97a2752b6f486b7b1c3faf5b8</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, DDS_DomainId_t domainId, const struct DDS_DomainParticipantQos *qos, const struct DDS_DomainParticipantListener *listener, DDS_StatusMask mask)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DomainParticipant *</type>
      <name>DDS_DomainParticipantFactory_create_participant_with_profile</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>gaccf76843ecbd588aea706cdf6aa6aa83</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, DDS_DomainId_t domainId, const char *library_name, const char *profile_name, const struct DDS_DomainParticipantListener *listener, DDS_StatusMask mask)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactory_delete_participant</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga51725e06d6cd390928ccc2b64dafc1f8</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, DDS_DomainParticipant *a_participant)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DomainParticipant *</type>
      <name>DDS_DomainParticipantFactory_lookup_participant</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>gad9daca2f43fef23bb5d6539741b58874</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, DDS_DomainId_t domainId)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactory_get_qos</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>gacd908ae7d4885fd0c064f8ef5ed4f75f</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, struct DDS_DomainParticipantFactoryQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactory_set_qos</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga20742ba32637a069e5e328eb1cd5c48f</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, const struct DDS_DomainParticipantFactoryQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactory_load_profiles</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga19d2ec55194e083a800fd26d9caf6a18</anchor>
      <arglist>(DDS_DomainParticipantFactory *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactory_reload_profiles</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga91db7cfb575cdea210061ebdc34c3c68</anchor>
      <arglist>(DDS_DomainParticipantFactory *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactory_unload_profiles</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga81ac5a5742065ef0a95d10b81e6e3131</anchor>
      <arglist>(DDS_DomainParticipantFactory *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactory_set_default_library</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga2a70b7eaa93317125a194777316e2112</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, const char *library_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactory_set_default_profile</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga2469b8025f924d620d9f0907a608c9c0</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, const char *library_name, const char *profile_name)</arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>DDS_DomainParticipantFactory_get_default_library</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga644bd1816e5ec2f8743e37b96d1ed415</anchor>
      <arglist>(DDS_DomainParticipantFactory *self)</arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>DDS_DomainParticipantFactory_get_default_profile</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga97dd8e9271e6ee91a1750984b12818a4</anchor>
      <arglist>(DDS_DomainParticipantFactory *self)</arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>DDS_DomainParticipantFactory_get_default_profile_library</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>gacc6223ca63cf5fa6948dde5b8e8ae98d</anchor>
      <arglist>(DDS_DomainParticipantFactory *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactory_get_participant_factory_qos_from_profile</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga5c991bef385fb536698056602014e5d5</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, struct DDS_DomainParticipantFactoryQos *qos, const char *library_name, const char *profile_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactory_get_participant_qos_from_profile</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>gaace4f05be5e0c36905c80fa31ac2bdc5</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, struct DDS_DomainParticipantQos *qos, const char *library_name, const char *profile_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactory_get_publisher_qos_from_profile</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>gaa0bfd6eaf16b998becacf4de0d23f359</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, struct DDS_PublisherQos *qos, const char *library_name, const char *profile_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactory_get_subscriber_qos_from_profile</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga4b2b4cad98b02504ef6f9ccb64e1c63b</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, struct DDS_SubscriberQos *qos, const char *library_name, const char *profile_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactory_get_datareader_qos_from_profile</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga318d8077fb710d3102ff4e94d496cce3</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, struct DDS_DataReaderQos *qos, const char *library_name, const char *profile_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactory_get_datareader_qos_from_profile_w_topic_name</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>gafa7908b83e9314569eb6baff82b77925</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, struct DDS_DataReaderQos *qos, const char *library_name, const char *profile_name, const char *topic_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactory_get_datawriter_qos_from_profile</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>gae7217f1fcc6192bae0ca12aff92b73f8</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, struct DDS_DataWriterQos *qos, const char *library_name, const char *profile_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactory_get_datawriter_qos_from_profile_w_topic_name</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga20714d9c7047676c4193c6a24f9ff108</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, struct DDS_DataWriterQos *qos, const char *library_name, const char *profile_name, const char *topic_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactory_get_topic_qos_from_profile</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga91ccc0a0b8362648895ccda8b6cca958</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, struct DDS_TopicQos *qos, const char *library_name, const char *profile_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactory_get_topic_qos_from_profile_w_topic_name</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>gadde3d143f580c24b03ddd8bf7fdac88a</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, struct DDS_TopicQos *qos, const char *library_name, const char *profile_name, const char *topic_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactory_get_qos_profile_libraries</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>gae9adb6f4d86f8f13cdbb2e7285501972</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, struct DDS_StringSeq *library_names)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactory_get_qos_profiles</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>gab29cf56f56d39c96a2cb2591445c922b</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, struct DDS_StringSeq *profile_names, const char *library_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactory_unregister_thread</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>gaeeeadd3707f00dc17e438decd06a11ee</anchor>
      <arglist>(DDS_DomainParticipantFactory *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DomainParticipant *</type>
      <name>DDS_DomainParticipantFactory_create_participant_from_config</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>gaf8d2a45bdef93eb8bed6d59597987688</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, const char *configuration_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DomainParticipant *</type>
      <name>DDS_DomainParticipantFactory_create_participant_from_config_w_params</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>gab806b5576fdb2e2b22c8c9df6d7c55a0</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, const char *configuration_name, const struct DDS_DomainParticipantConfigParams_t *params)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DomainParticipant *</type>
      <name>DDS_DomainParticipantFactory_lookup_participant_by_name</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga57c3ec076012e0af9b7cd3710ef1fa1c</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, const char *participant_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantFactory_register_type_support</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga42a9930952a22f7499e6fcebfc7ed429</anchor>
      <arglist>(DDS_DomainParticipantFactory *self, DDS_DomainParticipantFactory_RegisterTypeFunction register_type_fcn, const char *type_name)</arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DomainParticipantQos</type>
      <name>DDS_PARTICIPANT_QOS_DEFAULT</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>ga150dd7f8725206d7b6d8dbf0020eb5d7</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DomainParticipantConfigParams_t</type>
      <name>DDS_PARTICIPANT_CONFIG_PARAMS_DEFAULT</name>
      <anchorfile>group__DDSDomainParticipantFactoryModule.html</anchorfile>
      <anchor>gac68dcdab3ec88efd430c4f6805da51d8</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSDomainParticipantModule</name>
    <title>DomainParticipants</title>
    <filename>group__DDSDomainParticipantModule.html</filename>
    <class kind="struct">DDS_DomainParticipantListener</class>
    <class kind="struct">DDS_DomainParticipantQos</class>
    <member kind="define">
      <type>#define</type>
      <name>DDS_DomainParticipantListener_INITIALIZER</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga2ab13af4a34f7650048064e067c6e6e7</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_DomainParticipantQos_INITIALIZER</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga25048f6f39d60da8b6da0179f5004a43</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>DDS_DOMAINID_TYPE_NATIVE</type>
      <name>DDS_DomainId_t</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga060e392b8334a6dbc289ec0f363df67a</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_DomainParticipantImpl</type>
      <name>DDS_DomainParticipant</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga1964274885335d5bcea6855f66b0bfe1</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_DomainParticipantQos_equals</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gae86535dafc4ab22aa16406440cd6d6fd</anchor>
      <arglist>(const struct DDS_DomainParticipantQos *self, const struct DDS_DomainParticipantQos *other)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantQos_initialize</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga913d3a4811e1c8f414000cb4c14647f2</anchor>
      <arglist>(struct DDS_DomainParticipantQos *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantQos_copy</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga85acc47ec3923fdee16c4c2fd2cafbb4</anchor>
      <arglist>(struct DDS_DomainParticipantQos *self, const struct DDS_DomainParticipantQos *source)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipantQos_finalize</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga792d26b63c41512c1a51d4c1f09b4017</anchor>
      <arglist>(struct DDS_DomainParticipantQos *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Entity *</type>
      <name>DDS_DomainParticipant_as_entity</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga5d61c8b273045b475a11f7b01232adca</anchor>
      <arglist>(DDS_DomainParticipant *domain)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_get_default_topic_qos</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga9e0d05fbc8afd5dff04e5cb4c32af830</anchor>
      <arglist>(DDS_DomainParticipant *self, struct DDS_TopicQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_set_default_topic_qos</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga0d5ecb1c4fa700c76e7b45c1950ae09a</anchor>
      <arglist>(DDS_DomainParticipant *self, const struct DDS_TopicQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_set_default_topic_qos_with_profile</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gafd7c2e4d4c376913287ecb62755fd848</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *library_name, const char *profile_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_get_default_publisher_qos</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga5617e21edf7fadbf70c325e19a7a8f76</anchor>
      <arglist>(DDS_DomainParticipant *self, struct DDS_PublisherQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_set_default_publisher_qos</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga06610145e75c514dbd69013fba689355</anchor>
      <arglist>(DDS_DomainParticipant *self, const struct DDS_PublisherQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_set_default_publisher_qos_with_profile</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga2df60dfa1eda7cee4208cdf2816feec2</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *library_name, const char *profile_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_get_default_datawriter_qos</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gaa1b19cd07f9b06ee94fe880143179c35</anchor>
      <arglist>(DDS_DomainParticipant *self, struct DDS_DataWriterQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_set_default_datawriter_qos</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga967124584b2cbb8ca5b9f39278f1cb3d</anchor>
      <arglist>(DDS_DomainParticipant *self, const struct DDS_DataWriterQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_set_default_datawriter_qos_with_profile</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga4c830942939e6753e27260b819c1f78c</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *library_name, const char *profile_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_get_default_subscriber_qos</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga3ac60963418f18e36df5cd0ed70f6089</anchor>
      <arglist>(DDS_DomainParticipant *self, struct DDS_SubscriberQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_set_default_subscriber_qos</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga3abb9f26d2debf1b4627b1b69e30171c</anchor>
      <arglist>(DDS_DomainParticipant *self, const struct DDS_SubscriberQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_set_default_subscriber_qos_with_profile</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga910ee72efebd04cce2a80741af7dd2f9</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *library_name, const char *profile_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_get_default_datareader_qos</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga2dbde1ddb44183864f3834db374ba6d3</anchor>
      <arglist>(DDS_DomainParticipant *self, struct DDS_DataReaderQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_set_default_datareader_qos</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga3fe29c25071b9898f2d9b33a68211460</anchor>
      <arglist>(DDS_DomainParticipant *self, const struct DDS_DataReaderQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_set_default_datareader_qos_with_profile</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gae9f52c5b06e266363f2c42400de858f7</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *library_name, const char *profile_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_get_default_flowcontroller_property</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga95abed8f7878e29ca91d6834839f5c1f</anchor>
      <arglist>(DDS_DomainParticipant *self, struct DDS_FlowControllerProperty_t *prop)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_set_default_flowcontroller_property</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gac07a885bf7ce76e904cd5a636a60fc83</anchor>
      <arglist>(DDS_DomainParticipant *self, const struct DDS_FlowControllerProperty_t *prop)</arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>DDS_DomainParticipant_get_default_library</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga7b5265b28df8f5811be56eadca573d53</anchor>
      <arglist>(DDS_DomainParticipant *self)</arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>DDS_DomainParticipant_get_default_profile</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga56ce986abe03b9f0ef207e24c7470eaf</anchor>
      <arglist>(DDS_DomainParticipant *self)</arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>DDS_DomainParticipant_get_default_profile_library</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga23d4194eae3849597a4c78245ab923bd</anchor>
      <arglist>(DDS_DomainParticipant *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_set_default_library</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga8e4611c8b81a44765a93f5973d8c263a</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *library_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_set_default_profile</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gafd57bfb8bd70158c2dd4f3bcc2144e7b</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *library_name, const char *profile_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Publisher *</type>
      <name>DDS_DomainParticipant_create_publisher</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga59c1e6c22bb71b5b7d294ca1b669ce63</anchor>
      <arglist>(DDS_DomainParticipant *self, const struct DDS_PublisherQos *qos, const struct DDS_PublisherListener *listener, DDS_StatusMask mask)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Publisher *</type>
      <name>DDS_DomainParticipant_create_publisher_with_profile</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga7beab01667b874de5efad06b9d24ebb4</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *library_name, const char *profile_name, const struct DDS_PublisherListener *listener, DDS_StatusMask mask)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_delete_publisher</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga53e3cb8272b97abad174f41390809e58</anchor>
      <arglist>(DDS_DomainParticipant *self, DDS_Publisher *p)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Subscriber *</type>
      <name>DDS_DomainParticipant_create_subscriber</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga2f7e89f72d034184c7c02371525da360</anchor>
      <arglist>(DDS_DomainParticipant *self, const struct DDS_SubscriberQos *qos, const struct DDS_SubscriberListener *listener, DDS_StatusMask mask)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Subscriber *</type>
      <name>DDS_DomainParticipant_create_subscriber_with_profile</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga4631ca351631935ebae16474a5278f80</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *library_name, const char *profile_name, const struct DDS_SubscriberListener *listener, DDS_StatusMask mask)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_delete_subscriber</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga6792b9c4564a2342216994fc90cca793</anchor>
      <arglist>(DDS_DomainParticipant *self, DDS_Subscriber *s)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DataWriter *</type>
      <name>DDS_DomainParticipant_create_datawriter</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga73e8347920fc523c03458bb3e9bfe1a6</anchor>
      <arglist>(DDS_DomainParticipant *self, DDS_Topic *topic, const struct DDS_DataWriterQos *qos, const struct DDS_DataWriterListener *listener, DDS_StatusMask mask)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DataWriter *</type>
      <name>DDS_DomainParticipant_create_datawriter_with_profile</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga2b01ada831c74f3eb763a3ffb322e46a</anchor>
      <arglist>(DDS_DomainParticipant *self, DDS_Topic *topic, const char *library_name, const char *profile_name, const struct DDS_DataWriterListener *listener, DDS_StatusMask mask)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_delete_datawriter</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga878df9d49edbd2430ad9757db1d68d91</anchor>
      <arglist>(DDS_DomainParticipant *self, DDS_DataWriter *a_datawriter)</arglist>
      <docanchor file="group__DDSDomainParticipantModule">ParticipantDeleteDataWriter_warning</docanchor>
    </member>
    <member kind="function">
      <type>DDS_DataReader *</type>
      <name>DDS_DomainParticipant_create_datareader</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga33e5507940fbe7fe83a9e224008cca58</anchor>
      <arglist>(DDS_DomainParticipant *self, DDS_TopicDescription *topic, const struct DDS_DataReaderQos *qos, const struct DDS_DataReaderListener *listener, DDS_StatusMask mask)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DataReader *</type>
      <name>DDS_DomainParticipant_create_datareader_with_profile</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gaf132f90a1b68fc8b6af18bd94619e8c6</anchor>
      <arglist>(DDS_DomainParticipant *self, DDS_TopicDescription *topic, const char *library_name, const char *profile_name, const struct DDS_DataReaderListener *listener, DDS_StatusMask mask)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_delete_datareader</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga3f107c8d80da5c3aa1e2f51291df58d6</anchor>
      <arglist>(DDS_DomainParticipant *self, DDS_DataReader *a_datareader)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Topic *</type>
      <name>DDS_DomainParticipant_create_topic</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga1b785962ec5a94098875b2268d1655c3</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *topic_name, const char *type_name, const struct DDS_TopicQos *qos, const struct DDS_TopicListener *listener, DDS_StatusMask mask)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Topic *</type>
      <name>DDS_DomainParticipant_create_topic_with_profile</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga13b0b0ae499eac9de90277272922807a</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *topic_name, const char *type_name, const char *library_name, const char *profile_name, const struct DDS_TopicListener *listener, DDS_StatusMask mask)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_delete_topic</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga024006f63f750771cddd5f6524ce6034</anchor>
      <arglist>(DDS_DomainParticipant *self, DDS_Topic *topic)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ContentFilteredTopic *</type>
      <name>DDS_DomainParticipant_create_contentfilteredtopic</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gac46e0a01c706f02b5f8b929e9ea397ad</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *name, DDS_Topic *related_topic, const char *filter_expression, const struct DDS_StringSeq *expression_parameters)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ContentFilteredTopic *</type>
      <name>DDS_DomainParticipant_create_contentfilteredtopic_with_filter</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga2be2a4b5ea1a4eaf338ab7717e102a25</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *name, const DDS_Topic *related_topic, const char *filter_expression, const struct DDS_StringSeq *expression_parameters, const char *filter_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_delete_contentfilteredtopic</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gabecb192ce1fcbf05ddbba4394e7bac65</anchor>
      <arglist>(DDS_DomainParticipant *self, DDS_ContentFilteredTopic *a_contentfilteredtopic)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_register_contentfilter</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gaa4862c16fbd3eae67f66745ae6274e49</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *filter_name, const struct DDS_ContentFilter *contentfilter)</arglist>
    </member>
    <member kind="function">
      <type>void *</type>
      <name>DDS_DomainParticipant_lookup_contentfilter</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga516fc266b3f38ba1ef889caebea62398</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *filter_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_unregister_contentfilter</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga62c4192bb94aa896dc46cad342fe7ee9</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *filter_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_MultiTopic *</type>
      <name>DDS_DomainParticipant_create_multitopic</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga9d026a1555e9ddc0552e09dcb74012cb</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *name, const char *type_name, const char *subscription_expression, const struct DDS_StringSeq *expression_parameters)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_delete_multitopic</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gaf7b19c44601ae66917f368159ab094cb</anchor>
      <arglist>(DDS_DomainParticipant *self, DDS_MultiTopic *a_multitopic)</arglist>
    </member>
    <member kind="function">
      <type>DDS_FlowController *</type>
      <name>DDS_DomainParticipant_create_flowcontroller</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gacefc77e7fa66a9024857a3c8d074e36f</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *name, const struct DDS_FlowControllerProperty_t *prop)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_delete_flowcontroller</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gad7bbb64c7d2e384a813fb0bfb8457429</anchor>
      <arglist>(DDS_DomainParticipant *self, DDS_FlowController *fc)</arglist>
    </member>
    <member kind="function">
      <type>const DDS_TypeCode *</type>
      <name>DDS_DomainParticipant_get_typecode</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga7426cda1e01e1c96884f42f9c1b8391b</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *type_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Topic *</type>
      <name>DDS_DomainParticipant_find_topic</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga5d03738356707f3375ffddc7d1669161</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *topic_name, const struct DDS_Duration_t *timeout)</arglist>
    </member>
    <member kind="function">
      <type>DDS_TopicDescription *</type>
      <name>DDS_DomainParticipant_lookup_topicdescription</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gacfb32ec0b02338bc5fce4c110326bc88</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *topic_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_FlowController *</type>
      <name>DDS_DomainParticipant_lookup_flowcontroller</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga03f47048061cead5b1df6330f4860c13</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Subscriber *</type>
      <name>DDS_DomainParticipant_get_builtin_subscriber</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gaa30960c84bd94a5e17c5d6192ddb616e</anchor>
      <arglist>(DDS_DomainParticipant *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Publisher *</type>
      <name>DDS_DomainParticipant_get_implicit_publisher</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gaa56e69531d5a5084123b2dfbdacbe5a4</anchor>
      <arglist>(DDS_DomainParticipant *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Subscriber *</type>
      <name>DDS_DomainParticipant_get_implicit_subscriber</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga3f8e6e8ffed4a17ba73a40a4fb3421bd</anchor>
      <arglist>(DDS_DomainParticipant *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_ignore_participant</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga54a55ac8569d1d1899c90f8239d3b498</anchor>
      <arglist>(DDS_DomainParticipant *self, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_ignore_topic</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga87b7f435f0016691a0ecd3abe8bed08c</anchor>
      <arglist>(DDS_DomainParticipant *self, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_ignore_publication</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga2d462ae7c5b07d83ab170e551e05874c</anchor>
      <arglist>(DDS_DomainParticipant *self, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_ignore_subscription</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gab7987be213e29b7a6a56a4c3a81ab20a</anchor>
      <arglist>(DDS_DomainParticipant *self, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DomainId_t</type>
      <name>DDS_DomainParticipant_get_domain_id</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga404d8719f4c05615ca3bb5e916ee66ef</anchor>
      <arglist>(DDS_DomainParticipant *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_delete_contained_entities</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gaf407436063900d40a86e359f7e0f6212</anchor>
      <arglist>(DDS_DomainParticipant *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_assert_liveliness</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gad50f1cf7876a5980046100e529539014</anchor>
      <arglist>(DDS_DomainParticipant *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_get_publishers</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga0015707630e524d509da982230386ba1</anchor>
      <arglist>(DDS_DomainParticipant *self, struct DDS_PublisherSeq *publishers)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_get_subscribers</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gade4664da867edfbee4f561485784abc0</anchor>
      <arglist>(DDS_DomainParticipant *self, struct DDS_SubscriberSeq *subscribers)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_get_current_time</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gaa3548df8c191e1f4b0039f5397860085</anchor>
      <arglist>(DDS_DomainParticipant *self, struct DDS_Time_t *current_time)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_DomainParticipant_contains_entity</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga38da5595a4547b9e255e5a08a26844e2</anchor>
      <arglist>(DDS_DomainParticipant *self, const DDS_InstanceHandle_t *a_handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_register_durable_subscription</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga018d407c59ce2d9b5724a5ccd9ecc09d</anchor>
      <arglist>(DDS_DomainParticipant *self, struct DDS_EndpointGroup_t *group, const char *topic_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_delete_durable_subscription</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga74284c93348019d9ba73b054430bf9a9</anchor>
      <arglist>(DDS_DomainParticipant *self, struct DDS_EndpointGroup_t *group)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_get_discovered_participants</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga4b786a9ebdd6cebd31ab1014b2a1fc10</anchor>
      <arglist>(DDS_DomainParticipant *self, struct DDS_InstanceHandleSeq *participant_handles)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_get_discovered_participant_data</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga56b95bd8813b15be6e631a05053d5989</anchor>
      <arglist>(DDS_DomainParticipant *self, struct DDS_ParticipantBuiltinTopicData *participant_data, const DDS_InstanceHandle_t *participant_handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_get_discovered_topics</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga6acf7f4ecedce95276a6e539de6cc964</anchor>
      <arglist>(DDS_DomainParticipant *self, struct DDS_InstanceHandleSeq *topic_handles)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_get_discovered_topic_data</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga03b59ca6c4cc295feefb081ffcdf42e6</anchor>
      <arglist>(DDS_DomainParticipant *self, struct DDS_TopicBuiltinTopicData *topic_data, const DDS_InstanceHandle_t *topic_handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_add_peer</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gade5698fd60413b60257f38d4cbcf49d4</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *peer_desc_string)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_remove_peer</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gae1086ed278a047dc360169adab4cebd1</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *peer_desc_string)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_set_qos</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga46312aa273ae79617d01865a082b1743</anchor>
      <arglist>(DDS_DomainParticipant *self, const struct DDS_DomainParticipantQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_set_qos_with_profile</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gac5c482d5ca3b0ceee32643899ca2b300</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *library_name, const char *profile_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_get_qos</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gae48fff278a309718814c734f3a3a0207</anchor>
      <arglist>(DDS_DomainParticipant *self, struct DDS_DomainParticipantQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_set_listener</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga68a562c8609750614dbe0e0ca492ecff</anchor>
      <arglist>(DDS_DomainParticipant *self, const struct DDS_DomainParticipantListener *l, DDS_StatusMask mask)</arglist>
    </member>
    <member kind="function">
      <type>struct DDS_DomainParticipantListener</type>
      <name>DDS_DomainParticipant_get_listener</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga4fe67f226631ee084a572eb8b28d0bea</anchor>
      <arglist>(DDS_DomainParticipant *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DomainParticipant_get_listenerX</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gab72afdda06a4277d2983ea7e262d01f1</anchor>
      <arglist>(DDS_DomainParticipant *self, struct DDS_DomainParticipantListener *listener)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Publisher *</type>
      <name>DDS_DomainParticipant_lookup_publisher_by_name</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga2d7e851872591bac16bd1748afbf499c</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *publisher_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Subscriber *</type>
      <name>DDS_DomainParticipant_lookup_subscriber_by_name</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gac7385eb43a280bc7ef8aaec1217e8830</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *subscriber_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DataWriter *</type>
      <name>DDS_DomainParticipant_lookup_datawriter_by_name</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga20e616812b61b4787bba60ee85c27986</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *datawriter_full_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DataReader *</type>
      <name>DDS_DomainParticipant_lookup_datareader_by_name</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga678f10d6201047e9267ded021d4e04c2</anchor>
      <arglist>(DDS_DomainParticipant *self, const char *datareader_full_name)</arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_TopicQos</type>
      <name>DDS_TOPIC_QOS_DEFAULT</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gaebaddf684707e6c117824f22b6c128f1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_PublisherQos</type>
      <name>DDS_PUBLISHER_QOS_DEFAULT</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga4bc7cfcd5ec7d2bcd17a966684769451</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SubscriberQos</type>
      <name>DDS_SUBSCRIBER_QOS_DEFAULT</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gad29644804bcb673862abb4317015df1d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_FlowControllerProperty_t</type>
      <name>DDS_FLOW_CONTROLLER_PROPERTY_DEFAULT</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>ga7a0ea35ac257b6f70c782daa06eff9d2</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_SQLFILTER_NAME</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gae9c70c42d8aab39f94a651deb0d087d8</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_STRINGMATCHFILTER_NAME</name>
      <anchorfile>group__DDSDomainParticipantModule.html</anchorfile>
      <anchor>gab19c89c4d7b648153707a3fdf91eca75</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSBuiltInTopicModule</name>
    <title>Built-in Topics</title>
    <filename>group__DDSBuiltInTopicModule.html</filename>
    <subgroup>DDSParticipantBuiltInTopicModule</subgroup>
    <subgroup>DDSTopicBuiltInTopicModule</subgroup>
    <subgroup>DDSPublicationBuiltInTopicModule</subgroup>
    <subgroup>DDSSubscriptionBuiltInTopicModule</subgroup>
    <subgroup>DDSBuiltInTopicCommonModule</subgroup>
  </compound>
  <compound kind="group">
    <name>DDSTopicModule</name>
    <title>Topic Module</title>
    <filename>group__DDSTopicModule.html</filename>
    <subgroup>DDSTopicEntityModule</subgroup>
    <subgroup>DDSUserDataModule</subgroup>
    <subgroup>DDSTypeCodeModule</subgroup>
    <subgroup>DDSBuiltInTypesModule</subgroup>
    <subgroup>DDSDynamicDataModule</subgroup>
    <subgroup>DDSCdrTypesModule</subgroup>
  </compound>
  <compound kind="group">
    <name>DDSTopicEntityModule</name>
    <title>Topics</title>
    <filename>group__DDSTopicEntityModule.html</filename>
    <class kind="struct">DDS_InconsistentTopicStatus</class>
    <class kind="struct">DDS_TopicQos</class>
    <class kind="struct">DDS_TopicListener</class>
    <class kind="struct">DDS_ContentFilter</class>
    <class kind="struct">DDS_ExpressionProperty</class>
    <class kind="struct">DDS_FilterSampleInfo</class>
    <member kind="define">
      <type>#define</type>
      <name>DDS_InconsistentTopicStatus_INITIALIZER</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga44def6de058e7644df3f5f82255da950</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_TopicQos_INITIALIZER</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga263b762c25d2867b713a405c4455cebb</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_TopicListener_INITIALIZER</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>gae8450842d1ab62db7fb3bad67b27a071</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_ContentFilter_INITIALIZER</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga5284f3a21ed7851e620d236c914e3f82</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_TopicDescriptionImpl</type>
      <name>DDS_TopicDescription</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga89cd495d744b91edd5d6af4b276322c4</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_TopicWrapperI</type>
      <name>DDS_Topic</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga7f615cc63381c78f535904e370cf1356</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>void(*</type>
      <name>DDS_TopicListener_InconsistentTopicCallback</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>gaff952f74a0a1d4e8c1d32588dbf8a6dc</anchor>
      <arglist>)(void *listener_data, DDS_Topic *topic, const struct DDS_InconsistentTopicStatus *status)</arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_ContentFilteredTopicWrapperI</type>
      <name>DDS_ContentFilteredTopic</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga84a9ecf9064ecc6b3fb4d8dcc5bda0a6</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>DDS_ReturnCode_t(*</type>
      <name>DDS_ContentFilterCompileFunction</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga598a986b920ea72ff82d2b2642823a67</anchor>
      <arglist>)(void *filter_data, void **new_compile_data, const char *expression, const struct DDS_StringSeq *parameters, const struct DDS_TypeCode *type_code, const char *type_class_name, void *old_compile_data)</arglist>
    </member>
    <member kind="typedef">
      <type>DDS_Boolean(*</type>
      <name>DDS_ContentFilterEvaluateFunction</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga1ce75a847ca19b1d4f8f66c9a0bb28a5</anchor>
      <arglist>)(void *filter_data, void *compile_data, const void *sample, const struct DDS_FilterSampleInfo *meta_data)</arglist>
    </member>
    <member kind="typedef">
      <type>void(*</type>
      <name>DDS_ContentFilterFinalizeFunction</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga0ba5c1591e1bf327fc2306b603791b24</anchor>
      <arglist>)(void *filter_data, void *compile_data)</arglist>
    </member>
    <member kind="typedef">
      <type>void(*</type>
      <name>DDS_ContentFilterWriterFinalizeFunction</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga84329229b975617f853ef6e8d1332bde</anchor>
      <arglist>)(void *filter_data, void *writer_filter_data, const struct DDS_Cookie_t *cookie)</arglist>
    </member>
    <member kind="typedef">
      <type>DDS_ReturnCode_t(*</type>
      <name>DDS_ContentFilterWriterAttachFunction</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga8d0b03af88ae48143db32e3b761efe3a</anchor>
      <arglist>)(void *filter_data, void **writer_filter_data, void *reserved)</arglist>
    </member>
    <member kind="typedef">
      <type>void(*</type>
      <name>DDS_ContentFilterWriterDetachFunction</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga1d26f61f8d51465c1aa22e6cfe0214b9</anchor>
      <arglist>)(void *filter_data, void *writer_filter_data)</arglist>
    </member>
    <member kind="typedef">
      <type>DDS_ReturnCode_t(*</type>
      <name>DDS_ContentFilterWriterCompileFunction</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga2c2e7c297aca84ffa8cb16dd91772ff4</anchor>
      <arglist>)(void *filter_data, void *writer_filter_data, struct DDS_ExpressionProperty *prop, const char *expression, const struct DDS_StringSeq *parameters, const struct DDS_TypeCode *type_code, const char *type_class_name, const struct DDS_Cookie_t *cookie)</arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_CookieSeq *(*</type>
      <name>DDS_ContentFilterWriterEvaluateFunction</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>gae4ae321869e4674f53e71fa85f36eb51</anchor>
      <arglist>)(void *filter_data, void *writer_filter_data, const void *sample, const struct DDS_FilterSampleInfo *meta_data)</arglist>
    </member>
    <member kind="typedef">
      <type>void(*</type>
      <name>DDS_ContentFilterWriterReturnLoanFunction</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>gac5016292302e726df194ee24323bb378</anchor>
      <arglist>)(void *filter_data, void *writer_filter_data, struct DDS_CookieSeq *cookies)</arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_MultiTopicImpl</type>
      <name>DDS_MultiTopic</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga6b0bc43fd1b002f8c3e6d94efa708c98</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_InconsistentTopicStatus_initialize</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga08d6e95d34a17a36e6573883cca68b8f</anchor>
      <arglist>(struct DDS_InconsistentTopicStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_InconsistentTopicStatus_copy</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga58b0c2bac67ee85b299097eee7c7b5e2</anchor>
      <arglist>(struct DDS_InconsistentTopicStatus *self, const struct DDS_InconsistentTopicStatus *source)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_InconsistentTopicStatus_finalize</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>gac3a243ae5a2f2909cf44f9eb7c7b54e0</anchor>
      <arglist>(struct DDS_InconsistentTopicStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_TopicQos_equals</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga7deefeddc457cff8c59c0bc62cc40745</anchor>
      <arglist>(const struct DDS_TopicQos *self, const struct DDS_TopicQos *other)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_TopicQos_initialize</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>gaf896fbe25a98cf834dc06db235a0835b</anchor>
      <arglist>(struct DDS_TopicQos *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_TopicQos_copy</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>gad4ede7f7b1a70dd63bf46307926f0921</anchor>
      <arglist>(struct DDS_TopicQos *self, const struct DDS_TopicQos *source)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_TopicQos_finalize</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga2fe4f40cd93bea3d0418a31d9e5d7517</anchor>
      <arglist>(struct DDS_TopicQos *self)</arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>DDS_TopicDescription_get_type_name</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>gae53d99762988756f848072eb1038b2c0</anchor>
      <arglist>(DDS_TopicDescription *self)</arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>DDS_TopicDescription_get_name</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>gab18b1b01812fdb9fec69f87ee627a392</anchor>
      <arglist>(DDS_TopicDescription *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DomainParticipant *</type>
      <name>DDS_TopicDescription_get_participant</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga370b2149c35d0ea2ed7f36da5c4254ef</anchor>
      <arglist>(DDS_TopicDescription *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Entity *</type>
      <name>DDS_Topic_as_entity</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga3e2176588b5f884a0fb802675b172026</anchor>
      <arglist>(DDS_Topic *topic)</arglist>
    </member>
    <member kind="function">
      <type>DDS_TopicDescription *</type>
      <name>DDS_Topic_as_topicdescription</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>gae83f3363c17bf6c38039173e506a3fe6</anchor>
      <arglist>(DDS_Topic *topic)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Topic *</type>
      <name>DDS_Topic_narrow</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>gaf7359913f7f52285dab65868918fd249</anchor>
      <arglist>(DDS_TopicDescription *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Topic *</type>
      <name>DDS_Topic_narrow_from_entity</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga4e50ec4239cd13facb96eb1b1512ab49</anchor>
      <arglist>(DDS_Entity *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Topic_get_inconsistent_topic_status</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>gafb25282d5c15c61ad09fd84f63a69342</anchor>
      <arglist>(DDS_Topic *self, struct DDS_InconsistentTopicStatus *status)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Topic_set_qos</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga4dd65c95696bfdf17890913f77801c64</anchor>
      <arglist>(DDS_Topic *self, const struct DDS_TopicQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Topic_set_qos_with_profile</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga8b3f569c9344984ae603e211eb8f49fe</anchor>
      <arglist>(DDS_Topic *self, const char *library_name, const char *profile_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Topic_get_qos</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>gaeb19db8b699652761063876ef0f17994</anchor>
      <arglist>(DDS_Topic *self, struct DDS_TopicQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Topic_set_listener</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>gad27d2512cf75a38c1d70d06cf282830f</anchor>
      <arglist>(DDS_Topic *self, const struct DDS_TopicListener *l, DDS_StatusMask mask)</arglist>
    </member>
    <member kind="function">
      <type>struct DDS_TopicListener</type>
      <name>DDS_Topic_get_listener</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>gae29d1e62908b55902ff71944d5192615</anchor>
      <arglist>(DDS_Topic *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Topic_get_listenerX</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>gaf8ee5fa5605b95ab93334e2da34c4717</anchor>
      <arglist>(DDS_Topic *self, struct DDS_TopicListener *listener)</arglist>
    </member>
    <member kind="function">
      <type>DDS_TopicDescription *</type>
      <name>DDS_ContentFilteredTopic_as_topicdescription</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga773dc630b6efac7682b99ac5878e6db5</anchor>
      <arglist>(DDS_ContentFilteredTopic *contentFilteredTopic)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ContentFilteredTopic *</type>
      <name>DDS_ContentFilteredTopic_narrow</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga1b908a260cb3da6741d29d710dada09a</anchor>
      <arglist>(DDS_TopicDescription *self)</arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>DDS_ContentFilteredTopic_get_filter_expression</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>gaf96e06ccfa921c61ee08d3b280ebed10</anchor>
      <arglist>(DDS_ContentFilteredTopic *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_ContentFilteredTopic_get_expression_parameters</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga6aa1e6d43c3316f9c4c18088ec3bd86d</anchor>
      <arglist>(DDS_ContentFilteredTopic *self, struct DDS_StringSeq *parameters)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_ContentFilteredTopic_set_expression_parameters</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga5b784263451a8b22520f7ead80687169</anchor>
      <arglist>(DDS_ContentFilteredTopic *self, const struct DDS_StringSeq *parameters)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_ContentFilteredTopic_set_expression</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga5ee3353b3ca7acef8e11433c237bf8b4</anchor>
      <arglist>(DDS_ContentFilteredTopic *self, const char *expression, const struct DDS_StringSeq *parameters)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_ContentFilteredTopic_append_to_expression_parameter</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga425603399edb9e809a91c538419257c0</anchor>
      <arglist>(DDS_ContentFilteredTopic *self, const DDS_Long index, const char *val)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_ContentFilteredTopic_remove_from_expression_parameter</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>gad6eae847682127990c3f92549833cff4</anchor>
      <arglist>(DDS_ContentFilteredTopic *self, const DDS_Long index, const char *val)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Topic *</type>
      <name>DDS_ContentFilteredTopic_get_related_topic</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>gaccade4e891d9e161e391f0d121951bcf</anchor>
      <arglist>(DDS_ContentFilteredTopic *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_TopicDescription *</type>
      <name>DDS_MultiTopic_as_topicdescription</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>gad608d8b3eeea4216b2e4a1ac09eb78b3</anchor>
      <arglist>(DDS_MultiTopic *multiTopic)</arglist>
    </member>
    <member kind="function">
      <type>DDS_MultiTopic *</type>
      <name>DDS_MultiTopic_narrow</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga06f0a96d709b00fab4de1e7e0502c524</anchor>
      <arglist>(DDS_TopicDescription *self)</arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>DDS_MultiTopic_get_subscription_expression</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga56c34a410c1bd376dbae7fd031f1ad62</anchor>
      <arglist>(DDS_MultiTopic *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_MultiTopic_get_expression_parameters</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga808a5c26937f134873de14c17b4ab7ab</anchor>
      <arglist>(DDS_MultiTopic *self, struct DDS_StringSeq *parameters)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_MultiTopic_set_expression_parameters</name>
      <anchorfile>group__DDSTopicEntityModule.html</anchorfile>
      <anchor>ga4cd004b64d3e621a19801daf72760144</anchor>
      <arglist>(DDS_MultiTopic *self, const struct DDS_StringSeq *parameters)</arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSUserDataModule</name>
    <title>User Data Type Support</title>
    <filename>group__DDSUserDataModule.html</filename>
    <class kind="struct">DDS_TypeAllocationParams_t</class>
    <class kind="struct">DDS_TypeDeallocationParams_t</class>
    <class kind="struct">Foo</class>
    <class kind="struct">FooTypeSupport</class>
    <class kind="struct">DDS_InstanceHandleSeq</class>
    <member kind="define">
      <type>#define</type>
      <name>DDS_TYPESUPPORT_C</name>
      <anchorfile>group__DDSUserDataModule.html</anchorfile>
      <anchor>ga642b9b91cb50bbffcb705279d6edfa53</anchor>
      <arglist>(TTypeSupport, TData)</arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_DATAWRITER_C</name>
      <anchorfile>group__DDSUserDataModule.html</anchorfile>
      <anchor>gaf8d9a7b1d1b9b7caa9dd87ea4d598c89</anchor>
      <arglist>(TDataWriter, TData)</arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_DATAREADER_C</name>
      <anchorfile>group__DDSUserDataModule.html</anchorfile>
      <anchor>ga1b316c90d47cde0cdf3559d567b59492</anchor>
      <arglist>(TDataReader, TDataSeq, TData)</arglist>
    </member>
    <member kind="typedef">
      <type>DDS_HANDLE_TYPE_NATIVE</type>
      <name>DDS_InstanceHandle_t</name>
      <anchorfile>group__DDSUserDataModule.html</anchorfile>
      <anchor>ga2cd7a0bbf330870ab93f94e05c92318b</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_TypeSupportImpl</type>
      <name>DDS_TypeSupport</name>
      <anchorfile>group__DDSUserDataModule.html</anchorfile>
      <anchor>gabec465192e0829df4dcfd9e0b1701ca7</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>Foo *</type>
      <name>FooTypeSupport_create_data</name>
      <anchorfile>group__DDSUserDataModule.html</anchorfile>
      <anchor>ga1a7ae5e829f247058bad43dbdb6a6d70</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>Foo *</type>
      <name>FooTypeSupport_create_data_ex</name>
      <anchorfile>group__DDSUserDataModule.html</anchorfile>
      <anchor>ga89e9063ba599c8202bb9cb5d1ee6dc2b</anchor>
      <arglist>(DDS_Boolean allocatePointers)</arglist>
    </member>
    <member kind="function">
      <type>Foo *</type>
      <name>FooTypeSupport_create_data_w_params</name>
      <anchorfile>group__DDSUserDataModule.html</anchorfile>
      <anchor>ga8bc7a2db7d9026b4b1a47a5063d0c816</anchor>
      <arglist>(const struct DDS_TypeAllocationParams_t *alloc_params)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooTypeSupport_copy_data</name>
      <anchorfile>group__DDSUserDataModule.html</anchorfile>
      <anchor>ga30cf7f9f7cfcf17071126383c9ba2123</anchor>
      <arglist>(Foo *dst_data, const Foo *src_data)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooTypeSupport_delete_data</name>
      <anchorfile>group__DDSUserDataModule.html</anchorfile>
      <anchor>gaac457bf6abbcca8bebcbcf13cff2e58a</anchor>
      <arglist>(Foo *a_data)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooTypeSupport_delete_data_ex</name>
      <anchorfile>group__DDSUserDataModule.html</anchorfile>
      <anchor>gadf7f241fa5f81941f2ad840973eb9aec</anchor>
      <arglist>(Foo *a_data, DDS_Boolean deletePointers)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooTypeSupport_delete_data_w_params</name>
      <anchorfile>group__DDSUserDataModule.html</anchorfile>
      <anchor>gad45130c96e2062eadc16f267c7220adc</anchor>
      <arglist>(Foo *a_data, const struct DDS_TypeDeallocationParams_t *dealloc_params)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooTypeSupport_initialize_data</name>
      <anchorfile>group__DDSUserDataModule.html</anchorfile>
      <anchor>ga4ac973144c98aba5a35aaf75d880a629</anchor>
      <arglist>(Foo *a_data)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooTypeSupport_initialize_data_ex</name>
      <anchorfile>group__DDSUserDataModule.html</anchorfile>
      <anchor>ga50f6ceb4d51265c2adb0237d83fd149f</anchor>
      <arglist>(Foo *a_data, DDS_Boolean allocatePointers)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooTypeSupport_finalize_data</name>
      <anchorfile>group__DDSUserDataModule.html</anchorfile>
      <anchor>gad422c7fd7a345a3428daee4cb0eb5509</anchor>
      <arglist>(Foo *a_data)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooTypeSupport_finalize_data_ex</name>
      <anchorfile>group__DDSUserDataModule.html</anchorfile>
      <anchor>gaa5e6f3c7a7af682a6c5d8ac9faf9c8ca</anchor>
      <arglist>(Foo *a_data, DDS_Boolean deletePointers)</arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>FooTypeSupport_get_type_name</name>
      <anchorfile>group__DDSUserDataModule.html</anchorfile>
      <anchor>ga4f42c519f8ecda2f4f7d17ecd8ef5e67</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooTypeSupport_register_type</name>
      <anchorfile>group__DDSUserDataModule.html</anchorfile>
      <anchor>ga4b7c129a674867608a15e5ff8cdc7824</anchor>
      <arglist>(DDS_DomainParticipant *participant, const char *type_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooTypeSupport_unregister_type</name>
      <anchorfile>group__DDSUserDataModule.html</anchorfile>
      <anchor>ga5b7060438e11206be5d0fb913a7d9caf</anchor>
      <arglist>(DDS_DomainParticipant *participant, const char *type_name)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>FooTypeSupport_print_data</name>
      <anchorfile>group__DDSUserDataModule.html</anchorfile>
      <anchor>ga0115e875df135d32e46aaca719c84ac2</anchor>
      <arglist>(Foo *a_data)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_InstanceHandle_equals</name>
      <anchorfile>group__DDSUserDataModule.html</anchorfile>
      <anchor>gab70b6b7536555f269633de15de81420e</anchor>
      <arglist>(const DDS_InstanceHandle_t *self, const DDS_InstanceHandle_t *other)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_InstanceHandle_is_nil</name>
      <anchorfile>group__DDSUserDataModule.html</anchorfile>
      <anchor>ga9a73360264c8f15c5ac2ba22376c415f</anchor>
      <arglist>(const DDS_InstanceHandle_t *self)</arglist>
    </member>
    <member kind="variable">
      <type>const DDS_InstanceHandle_t</type>
      <name>DDS_HANDLE_NIL</name>
      <anchorfile>group__DDSUserDataModule.html</anchorfile>
      <anchor>ga7974338d80c6817f16f77899d908a60e</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSTypeCodeModule</name>
    <title>Type Code Support</title>
    <filename>group__DDSTypeCodeModule.html</filename>
    <class kind="struct">DDS_TypeCode</class>
    <class kind="struct">DDS_StructMember</class>
    <class kind="struct">DDS_StructMemberSeq</class>
    <class kind="struct">DDS_UnionMember</class>
    <class kind="struct">DDS_UnionMemberSeq</class>
    <class kind="struct">DDS_EnumMember</class>
    <class kind="struct">DDS_EnumMemberSeq</class>
    <class kind="struct">DDS_ValueMember</class>
    <class kind="struct">DDS_ValueMemberSeq</class>
    <class kind="struct">DDS_TypeCodeFactory</class>
    <member kind="define">
      <type>#define</type>
      <name>DDS_TYPECODE_MEMBER_ID_INVALID</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gaf70993eadac68522bbce18f0142075b5</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_TYPECODE_INDEX_INVALID</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga74985232cedf98ceba49de3f8e701b66</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_TYPECODE_NOT_BITFIELD</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga8b7db590ebaf6c20584ef2c053eefe34</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_VM_NONE</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga851c5b24289ca4cf08ab97f0b80c490f</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_VM_CUSTOM</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gac68a26ac1e345b39991c307f051afd3c</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_VM_ABSTRACT</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gae0b39e5ec09ae23206f8588d3fa5b826</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_VM_TRUNCATABLE</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga012d5822d7d9fed0709544dd691ba9be</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_PRIVATE_MEMBER</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gada6dc35851aa1d2dcf050963094bc8e4</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_PUBLIC_MEMBER</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gabbaeef6040ae4648b136a7b2ae179c8e</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_TYPECODE_NONKEY_MEMBER</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gafe35a475056615636abb1ee8822ff2df</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_TYPECODE_KEY_MEMBER</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga9491b1304f24f81d9f1417e535d40092</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_TYPECODE_NONKEY_REQUIRED_MEMBER</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gac51953e0fd042e5d89b849030656b1f1</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>short</type>
      <name>DDS_ValueModifier</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gae4905c1cc6926c3f24e6a5563ff88548</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>short</type>
      <name>DDS_Visibility</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga59e86085f27abb59bc4e6480b02fc0dd</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumeration">
      <name>DDS_TCKind</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga0e3f0b2c88d331a730fe35e5ef75f670</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TK_NULL</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gga0e3f0b2c88d331a730fe35e5ef75f670af68849df8bef31b03c434a5bf9433a7c</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TK_SHORT</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gga0e3f0b2c88d331a730fe35e5ef75f670aab8c0d9d0147a566ebbe095c1e3c03dc</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TK_LONG</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gga0e3f0b2c88d331a730fe35e5ef75f670afe386a00477f1e19ec5bb37c559dd769</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TK_USHORT</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gga0e3f0b2c88d331a730fe35e5ef75f670ace96544b0695a1997a8469b096245446</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TK_ULONG</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gga0e3f0b2c88d331a730fe35e5ef75f670a898a390f515fcf856f4688a73f5930c1</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TK_FLOAT</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gga0e3f0b2c88d331a730fe35e5ef75f670accfa6e5bf2621961802447ab4844ad35</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TK_DOUBLE</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gga0e3f0b2c88d331a730fe35e5ef75f670ad74cf39962072335c3c9715abe434b9a</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TK_BOOLEAN</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gga0e3f0b2c88d331a730fe35e5ef75f670a8011c8e26f5812518aa643ac74462a36</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TK_CHAR</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gga0e3f0b2c88d331a730fe35e5ef75f670a3f748ca053347749870891792831e2cf</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TK_OCTET</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gga0e3f0b2c88d331a730fe35e5ef75f670a8428a3112da309a6570393623f0a2ead</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TK_STRUCT</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gga0e3f0b2c88d331a730fe35e5ef75f670a478972a4dc985d452851b7b805f36ead</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TK_UNION</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gga0e3f0b2c88d331a730fe35e5ef75f670a0f572294926dc8eddb404ebf40a0c1a7</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TK_ENUM</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gga0e3f0b2c88d331a730fe35e5ef75f670ab04a8633ed2ab1479ce177b4ce6c1724</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TK_STRING</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gga0e3f0b2c88d331a730fe35e5ef75f670a97974ac68cd8dd09d0c069c6bebe9fc4</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TK_SEQUENCE</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gga0e3f0b2c88d331a730fe35e5ef75f670a0154584609fbfa7afc7c47bcb8ae8456</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TK_ARRAY</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gga0e3f0b2c88d331a730fe35e5ef75f670abd444cd6524362c5d54ff5589b83ba6a</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TK_ALIAS</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gga0e3f0b2c88d331a730fe35e5ef75f670a90f0c24460fac3c88a3902bd684a45dc</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TK_LONGLONG</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gga0e3f0b2c88d331a730fe35e5ef75f670af594c86292a0ac089062593aa862f794</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TK_ULONGLONG</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gga0e3f0b2c88d331a730fe35e5ef75f670aefb1461735bbc59aac444f7748445b6d</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TK_LONGDOUBLE</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gga0e3f0b2c88d331a730fe35e5ef75f670a08bc728c2384224e3279f96af63a1d1a</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TK_WCHAR</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gga0e3f0b2c88d331a730fe35e5ef75f670a5b3d32ae654bd39e5553aa5bddde4487</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TK_WSTRING</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gga0e3f0b2c88d331a730fe35e5ef75f670a343ca3321a75834b4a57bef522c3e103</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TK_VALUE</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gga0e3f0b2c88d331a730fe35e5ef75f670a729d31d0ec89aff050f46311ba4038c6</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TK_SPARSE</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gga0e3f0b2c88d331a730fe35e5ef75f670a73ee71c70b5a17d470491a406e5a9d4d</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumeration">
      <name>DDS_ExtensibilityKind</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gaf4c55c1197e5c07c4a409c77c2a3d34b</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_FINAL_EXTENSIBILITY</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ggaf4c55c1197e5c07c4a409c77c2a3d34bacb872bffe15144b74085d07b1403ab12</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_EXTENSIBLE_EXTENSIBILITY</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ggaf4c55c1197e5c07c4a409c77c2a3d34ba809f4596bbfc2e932e18adfac2f80f6b</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_MUTABLE_EXTENSIBILITY</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ggaf4c55c1197e5c07c4a409c77c2a3d34ba598f9d55cbb352d032431236ef7fa468</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>DDS_TCKind</type>
      <name>DDS_TypeCode_kind</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gae8d5c140943addf73fa9e97d08c0b812</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ExtensibilityKind</type>
      <name>DDS_TypeCode_extensibility_kind</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga1e9eb7b49cb025b929d136f1294326a4</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_TypeCode_equal</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga6e2fe2e4d4f5e92262bde11ca10866ee</anchor>
      <arglist>(const DDS_TypeCode *self, const DDS_TypeCode *tc, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>DDS_TypeCode_name</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga695b37fa7d6e4d12bf29f99b1e4089af</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_UnsignedLong</type>
      <name>DDS_TypeCode_member_count</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga016837c106655d957b819570fe02c9f0</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>DDS_TypeCode_member_name</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga66f9bdbc32e38b7942f2348b3d526140</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_UnsignedLong index, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_UnsignedLong</type>
      <name>DDS_TypeCode_find_member_by_name</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga21689d746db6a401924b09831b4a5230</anchor>
      <arglist>(const DDS_TypeCode *self, const char *name, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_TypeCode *</type>
      <name>DDS_TypeCode_member_type</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gabc2f0f4a2957eaa96ac2e957ba651c50</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_UnsignedLong index, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_UnsignedLong</type>
      <name>DDS_TypeCode_member_label_count</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gaeb4bde399e0ed08d52835f900866427a</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_UnsignedLong index, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Long</type>
      <name>DDS_TypeCode_member_label</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga5b2d383ef85f48a47aac3692cc3fa133</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_UnsignedLong member_index, DDS_UnsignedLong label_index, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Long</type>
      <name>DDS_TypeCode_member_ordinal</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga8c6839eaeb21bdb80520710e2249e85c</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_UnsignedLong index, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_TypeCode_is_member_key</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga717ba30721cb7240ede330e89735f488</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_UnsignedLong index, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_TypeCode_is_member_required</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gac968db32bebfd25654781fd8865f934d</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_UnsignedLong index, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_TypeCode_is_member_pointer</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga75c41231d14dd2a1bc4e44b3af1fd158</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_UnsignedLong index, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_TypeCode_is_member_bitfield</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gae92c084e20e34d3f95fcffcf6c1bcaf1</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_UnsignedLong index, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Short</type>
      <name>DDS_TypeCode_member_bitfield_bits</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga80ec29f7afee8373d3fa193bb765f06c</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_UnsignedLong index, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Visibility</type>
      <name>DDS_TypeCode_member_visibility</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga47a0dffac9cb7e659aa925c260e2a132</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_UnsignedLong index, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_TypeCode *</type>
      <name>DDS_TypeCode_discriminator_type</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gabd7a1a60fe5d924299afe64d69e636bf</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_UnsignedLong</type>
      <name>DDS_TypeCode_length</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga1e8e5b60bb7d0cf6ae5275672e385034</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_UnsignedLong</type>
      <name>DDS_TypeCode_array_dimension_count</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gaef457c9b02513b3c58804458162e08e7</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_UnsignedLong</type>
      <name>DDS_TypeCode_array_dimension</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga204fd4f09746811313d693a320ff548b</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_UnsignedLong index, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_UnsignedLong</type>
      <name>DDS_TypeCode_element_count</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga3eb9a9a5a53531b8411fa939b5cc5af3</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_TypeCode *</type>
      <name>DDS_TypeCode_content_type</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga79f6823153a616e8447b9036a99d2545</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_TypeCode_is_alias_pointer</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gaf60278b137bfbdd28dc015649b451e1f</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Long</type>
      <name>DDS_TypeCode_default_index</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga4c267a35fc7d7f7d245cc096b4712d19</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_TypeCode *</type>
      <name>DDS_TypeCode_concrete_base_type</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga8b0b580247ccab808f6cfe620b07eb4b</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ValueModifier</type>
      <name>DDS_TypeCode_type_modifier</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gaf0adca6685c48f9a136c67ab58160b3b</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_UnsignedLong</type>
      <name>DDS_TypeCode_find_member_by_id</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gab2286bde288e1ee3c7e2837ea1aaabb7</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_Long id, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Long</type>
      <name>DDS_TypeCode_member_id</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gae8d4ca5417ee5602482465283e570ab3</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_UnsignedLong index, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_UnsignedLong</type>
      <name>DDS_TypeCode_add_member_to_enum</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gad3b4198bde82473bf12dc613ea0d8a8a</anchor>
      <arglist>(DDS_TypeCode *self, const char *name, DDS_Long ordinal, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_UnsignedLong</type>
      <name>DDS_TypeCode_add_member_to_union</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gaf74bb43fd023d0057c881630f7a30c0a</anchor>
      <arglist>(DDS_TypeCode *self, const char *name, DDS_Long id, const struct DDS_LongSeq *labels, const DDS_TypeCode *tc, DDS_Boolean is_pointer, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_UnsignedLong</type>
      <name>DDS_TypeCode_add_member</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga30a864f59190b4cfeeba6155e35c78ea</anchor>
      <arglist>(DDS_TypeCode *self, const char *name, DDS_Long id, const DDS_TypeCode *tc, DDS_Octet member_flags, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_UnsignedLong</type>
      <name>DDS_TypeCode_add_member_ex</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga34543fe70aee8443465145c517ac702c</anchor>
      <arglist>(DDS_TypeCode *self, const char *name, DDS_Long id, const DDS_TypeCode *tc, DDS_Octet member_flags, DDS_Visibility visibility, DDS_Boolean is_pointer, DDS_Short bits, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>DDS_TypeCode_print_IDL</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga13adaf37889112722f14809c2814ac96</anchor>
      <arglist>(const DDS_TypeCode *self, DDS_UnsignedLong indent, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_TypeCodeFactory *</type>
      <name>DDS_TypeCodeFactory_get_instance</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gae54a0ed20ac7859496c0298c80d1314d</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>DDS_TypeCode *</type>
      <name>DDS_TypeCodeFactory_clone_tc</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga4f41faa4d1fc81c112bf7b29b7827ad3</anchor>
      <arglist>(DDS_TypeCodeFactory *self, const DDS_TypeCode *tc, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>DDS_TypeCodeFactory_delete_tc</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gae4f8ea4349621faf8c6b7029f6d8c33d</anchor>
      <arglist>(DDS_TypeCodeFactory *self, DDS_TypeCode *tc, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>const DDS_TypeCode *</type>
      <name>DDS_TypeCodeFactory_get_primitive_tc</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga93221520f7811a6c8efd89ed2b0d7292</anchor>
      <arglist>(DDS_TypeCodeFactory *self, DDS_TCKind tc_kind)</arglist>
    </member>
    <member kind="function">
      <type>DDS_TypeCode *</type>
      <name>DDS_TypeCodeFactory_create_struct_tc</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga1f5af7b9f88b4c578c0d455b6f89ac02</anchor>
      <arglist>(DDS_TypeCodeFactory *self, const char *name, const struct DDS_StructMemberSeq *members, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_TypeCode *</type>
      <name>DDS_TypeCodeFactory_create_struct_tc_ex</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gad3befe5a86b129676948609fddfdd566</anchor>
      <arglist>(DDS_TypeCodeFactory *self, const char *name, DDS_ExtensibilityKind extensibility_kind, const struct DDS_StructMemberSeq *members, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_TypeCode *</type>
      <name>DDS_TypeCodeFactory_create_value_tc</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga3f73508491df129aaf289002878c2bf0</anchor>
      <arglist>(DDS_TypeCodeFactory *self, const char *name, DDS_ValueModifier type_modifier, const DDS_TypeCode *concrete_base, const struct DDS_ValueMemberSeq *members, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_TypeCode *</type>
      <name>DDS_TypeCodeFactory_create_value_tc_ex</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gadf363986b31aed3efcb3c56d300d70ca</anchor>
      <arglist>(DDS_TypeCodeFactory *self, const char *name, DDS_ExtensibilityKind extensibility_kind, DDS_ValueModifier type_modifier, const DDS_TypeCode *concrete_base, const struct DDS_ValueMemberSeq *members, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_TypeCode *</type>
      <name>DDS_TypeCodeFactory_create_union_tc</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga5c4cb72c1fc83b094c1a65d8158fece4</anchor>
      <arglist>(DDS_TypeCodeFactory *self, const char *name, const DDS_TypeCode *discriminator_type, DDS_Long default_index, const struct DDS_UnionMemberSeq *members, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_TypeCode *</type>
      <name>DDS_TypeCodeFactory_create_union_tc_ex</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gaa4b4af8d53437ee3fe2a1ed8908fa52d</anchor>
      <arglist>(DDS_TypeCodeFactory *self, const char *name, DDS_ExtensibilityKind extensibility_kind, const DDS_TypeCode *discriminator_type, DDS_Long default_index, const struct DDS_UnionMemberSeq *members, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_TypeCode *</type>
      <name>DDS_TypeCodeFactory_create_enum_tc</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gaf6d3595044589e140d872e2a9e7baaf5</anchor>
      <arglist>(DDS_TypeCodeFactory *self, const char *name, const struct DDS_EnumMemberSeq *members, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_TypeCode *</type>
      <name>DDS_TypeCodeFactory_create_enum_tc_ex</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga5c02d5872fdf2a6ffd25eec0e818fc12</anchor>
      <arglist>(DDS_TypeCodeFactory *self, const char *name, DDS_ExtensibilityKind extensibility_kind, const struct DDS_EnumMemberSeq *members, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_TypeCode *</type>
      <name>DDS_TypeCodeFactory_create_alias_tc</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gac709f346af45de756739c46c072c6beb</anchor>
      <arglist>(DDS_TypeCodeFactory *self, const char *name, const DDS_TypeCode *original_type, DDS_Boolean is_pointer, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_TypeCode *</type>
      <name>DDS_TypeCodeFactory_create_string_tc</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga3dec5ae9b1a96105eae67c085aed1365</anchor>
      <arglist>(DDS_TypeCodeFactory *self, DDS_UnsignedLong bound, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_TypeCode *</type>
      <name>DDS_TypeCodeFactory_create_wstring_tc</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gadcc71bc52648f4d29fbf6192a5724665</anchor>
      <arglist>(DDS_TypeCodeFactory *self, DDS_UnsignedLong bound, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_TypeCode *</type>
      <name>DDS_TypeCodeFactory_create_sequence_tc</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gaa9ab47ea2879daea153cd4861980d6f7</anchor>
      <arglist>(DDS_TypeCodeFactory *self, DDS_UnsignedLong bound, const DDS_TypeCode *element_type, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_TypeCode *</type>
      <name>DDS_TypeCodeFactory_create_array_tc</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga2cda3a815c05750b3b9ffec79377d9b6</anchor>
      <arglist>(DDS_TypeCodeFactory *self, const struct DDS_UnsignedLongSeq *dimensions, const DDS_TypeCode *element_type, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="function">
      <type>DDS_TypeCode *</type>
      <name>DDS_TypeCodeFactory_create_sparse_tc</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gaa2da01712795789b27c442c1888e86b9</anchor>
      <arglist>(DDS_TypeCodeFactory *self, const char *name, DDS_ValueModifier type_modifier, const DDS_TypeCode *concrete_base, DDS_ExceptionCode_t *ex)</arglist>
    </member>
    <member kind="variable">
      <type>DDS_TypeCode</type>
      <name>DDS_g_tc_null</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga0a8f383e6d7d48af31917b1e03a95f6b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_TypeCode</type>
      <name>DDS_g_tc_short</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gae46fe7c417e9e8b1eb559198e8643ad4</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_TypeCode</type>
      <name>DDS_g_tc_long</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga3490e03c9ca84888c02ec8c9d66133b3</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_TypeCode</type>
      <name>DDS_g_tc_ushort</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga43296a809ea3b9eafe8168da6f37e442</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_TypeCode</type>
      <name>DDS_g_tc_ulong</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gaeee3b5a5849b87cc3750ebca10c76bda</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_TypeCode</type>
      <name>DDS_g_tc_float</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga2ce3085f05b415b384bafda87b594293</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_TypeCode</type>
      <name>DDS_g_tc_double</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gaa525492c7980d4f81e038b4e15e3c06a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_TypeCode</type>
      <name>DDS_g_tc_boolean</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga2192736eec847a49f36b3b3a1713571a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_TypeCode</type>
      <name>DDS_g_tc_char</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga82d044f68c0efa489b0a97fe4a7b7d55</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_TypeCode</type>
      <name>DDS_g_tc_octet</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga6feab367f76a43adeb86ac07c7373d77</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_TypeCode</type>
      <name>DDS_g_tc_longlong</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>gabcb6764b54fcdba160795cd699766b54</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_TypeCode</type>
      <name>DDS_g_tc_ulonglong</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga8fca5c9d3e4d2538770c6820616cbedf</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_TypeCode</type>
      <name>DDS_g_tc_longdouble</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga77069061fd96065b8964ec16f95772f9</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_TypeCode</type>
      <name>DDS_g_tc_wchar</name>
      <anchorfile>group__DDSTypeCodeModule.html</anchorfile>
      <anchor>ga8522381f53c455d7c6677b496316f8d4</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="group__DDSTypeCodeModule">DDSTypeCodeModule_access</docanchor>
    <docanchor file="group__DDSTypeCodeModule">DDSTypeCodeModule_discovery</docanchor>
  </compound>
  <compound kind="group">
    <name>DDSBuiltInTypesModule</name>
    <title>Built-in Types</title>
    <filename>group__DDSBuiltInTypesModule.html</filename>
    <subgroup>DDSStringBuiltInTypeModule</subgroup>
    <subgroup>DDSKeyedStringBuiltInTypeModule</subgroup>
    <subgroup>DDSOctetsBuiltInTypeModule</subgroup>
    <subgroup>DDSKeyedOctetsBuiltInTypeModule</subgroup>
    <docanchor file="group__DDSBuiltInTypesModule">BuiltinTypeMemoryManagement</docanchor>
    <docanchor file="group__DDSBuiltInTypesModule">BuiltinTypeTypeCode</docanchor>
  </compound>
  <compound kind="group">
    <name>DDSDynamicDataModule</name>
    <title>Dynamic Data</title>
    <filename>group__DDSDynamicDataModule.html</filename>
    <class kind="struct">DDS_DynamicDataProperty_t</class>
    <class kind="struct">DDS_DynamicDataTypeSerializationProperty_t</class>
    <class kind="struct">DDS_DynamicDataInfo</class>
    <class kind="struct">DDS_DynamicDataMemberInfo</class>
    <class kind="struct">DDS_DynamicData</class>
    <class kind="struct">DDS_DynamicDataSeq</class>
    <class kind="struct">DDS_DynamicDataTypeProperty_t</class>
    <member kind="define">
      <type>#define</type>
      <name>DDS_DynamicDataProperty_t_INITIALIZER</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga3ce290d0ee546ade4766ccd646e58efd</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_DYNAMIC_DATA_MEMBER_ID_UNSPECIFIED</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gad578e6281d8a36c96dbd8785f43e57cc</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_DynamicDataTypeProperty_t_INITIALIZER</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga665275a31ae2036e76152f16ab4e9ce0</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>DDS_Long</type>
      <name>DDS_DynamicDataMemberId</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga5e4e3afcded97e793075f48a15c057c7</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_DynamicDataWriter</type>
      <name>DDS_DynamicDataWriter</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga483055c524acebe881f1679023e1748b</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_DynamicDataReader</type>
      <name>DDS_DynamicDataReader</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gac07ed32e8f1b28b599c48f2ffca3401a</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_DynamicDataTypeSupport</type>
      <name>DDS_DynamicDataTypeSupport</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga4f0e3af4d6f3fc02de9944e5f702ee5d</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_DynamicData_initialize</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gaccab70150bdae7af70cc61e7fffecdc8</anchor>
      <arglist>(DDS_DynamicData *self, const DDS_TypeCode *type, const struct DDS_DynamicDataProperty_t *property)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DynamicData *</type>
      <name>DDS_DynamicData_new</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gae3353e02e21ef7cf244323c08899734c</anchor>
      <arglist>(const DDS_TypeCode *type, const struct DDS_DynamicDataProperty_t *property)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>DDS_DynamicData_finalize</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga7117d55e08766eef3a1dd909fe308420</anchor>
      <arglist>(DDS_DynamicData *self)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>DDS_DynamicData_delete</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga09824845f60b73034539f5ec23580cc3</anchor>
      <arglist>(DDS_DynamicData *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_copy</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga12fa8e85432ee2d561bc0f2892ff2300</anchor>
      <arglist>(DDS_DynamicData *self, const DDS_DynamicData *src)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_DynamicData_equal</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga8e78bf77f4910bb3a44fd279a7dba945</anchor>
      <arglist>(const DDS_DynamicData *self, const DDS_DynamicData *other)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_clear_all_members</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gafe06aab5c86f491de350195bc6daa725</anchor>
      <arglist>(DDS_DynamicData *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_clear_nonkey_members</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gac6d022eaa0dff40fa08e8e1aa58af56f</anchor>
      <arglist>(DDS_DynamicData *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_clear_optional_member</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga88c9d9fab710d641d45ac1d5c0cb6e0c</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_clear_member</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga8976a4b9a26b8f47a2ee0f722a0ff0b8</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_buffer</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga533aadba8a540673d61b518a9fbcef1c</anchor>
      <arglist>(DDS_DynamicData *self, DDS_Octet *storage, DDS_Long size)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_estimated_max_buffer_size</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gafe52a86197b9291c9af35526474ed50b</anchor>
      <arglist>(DDS_DynamicData *self, DDS_Long *size)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_print</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga92cad3f76afc0336f6d4b8c1694bf3aa</anchor>
      <arglist>(const DDS_DynamicData *self, FILE *fp, int indent)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>DDS_DynamicData_get_info</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga5429299792bc55432538757752091f3d</anchor>
      <arglist>(const DDS_DynamicData *self, struct DDS_DynamicDataInfo *info_out)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_bind_type</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gaf060f3686b215a2ebd9c9e23863556d9</anchor>
      <arglist>(DDS_DynamicData *self, const DDS_TypeCode *type)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_unbind_type</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga81fc4f0bb90f71647fa41475f0883ff9</anchor>
      <arglist>(DDS_DynamicData *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_bind_complex_member</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gad911b0b15d8c2e49cb82a62f278d73ce</anchor>
      <arglist>(DDS_DynamicData *self, DDS_DynamicData *value_out, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_unbind_complex_member</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga7220c98be24abb0522f4f070d9e42dc8</anchor>
      <arglist>(DDS_DynamicData *self, DDS_DynamicData *value)</arglist>
    </member>
    <member kind="function">
      <type>const DDS_TypeCode *</type>
      <name>DDS_DynamicData_get_type</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gab74362fb3b861c081392279fc35359d1</anchor>
      <arglist>(const DDS_DynamicData *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_TCKind</type>
      <name>DDS_DynamicData_get_type_kind</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga6cd4a10fa7e058bf546d958ce2f1c467</anchor>
      <arglist>(const DDS_DynamicData *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_UnsignedLong</type>
      <name>DDS_DynamicData_get_member_count</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga045baa5f29b9b5f6beb27d2b0e3efead</anchor>
      <arglist>(const DDS_DynamicData *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_DynamicData_member_exists</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga4bd01fc2f199858dc93cf157b27340c1</anchor>
      <arglist>(const DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_DynamicData_member_exists_in_type</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga6c4aa6de93613a6ad85f19547dab7b79</anchor>
      <arglist>(const DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_member_info</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gaed0441b7d9e0dce81398e456ade9d3d4</anchor>
      <arglist>(const DDS_DynamicData *self, struct DDS_DynamicDataMemberInfo *info, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_member_info_by_index</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga2ec130df528ac0d499bc15cfc7e4f324</anchor>
      <arglist>(const DDS_DynamicData *self, struct DDS_DynamicDataMemberInfo *info, DDS_UnsignedLong index)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_member_type</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga2c14e23551b0abad5ab1c94cd8cc9482</anchor>
      <arglist>(const DDS_DynamicData *self, const DDS_TypeCode **type_out, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_is_member_key</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga902e5c66a8cc17006ced0e6bb81bc146</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_Boolean *is_key_out, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_long</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gad10066573ba2f00b6c1e24ed69997491</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_Long *value_out, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_short</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga0d317e2823d263f37bf21b1b6ab49f3c</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_Short *value_out, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_ulong</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga3f093e2d13189125ee09e11b6bfeadc5</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_UnsignedLong *value_out, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_ushort</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga2922f24d66beeb2527e86b1fede86633</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_UnsignedShort *value_out, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_float</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gaa6e05fd64c0ab5e25a8b6530cc99c980</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_Float *value_out, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_double</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gab324b6167e8c454e4e7ad312163fad0f</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_Double *value_out, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_boolean</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga531790d1ea3813d7206a71a089c92336</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_Boolean *value_out, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_char</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga8f5565652028795ca5754dfe93080684</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_Char *value_out, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_octet</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gaddc06887c861267e5af274b6704906e3</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_Octet *value_out, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_longlong</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga91fb1fe451a869dfdc110c78f0034892</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_LongLong *value_out, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_ulonglong</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gab2e33e9131af2283869bc4047f6a67ae</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_UnsignedLongLong *value_out, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_longdouble</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gae18aeaa08d82f9f11a2b465b340f6308</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_LongDouble *value_out, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_wchar</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gaf97d6a467cd2b7fc202007c97a38714d</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_Wchar *value_out, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_string</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga5b358cc107a65742604f9f091747aad1</anchor>
      <arglist>(const DDS_DynamicData *self, char **value, DDS_UnsignedLong *size, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_wstring</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga581d3747384f472f260cc96757392400</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_Wchar **value, DDS_UnsignedLong *size, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_complex_member</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gab59c2b3517004b2a49c2fc6a201553ba</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_DynamicData *value_out, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_long_array</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga9267e9715ea234bf2364c74a204b769d</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_Long *array, DDS_UnsignedLong *length, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_short_array</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga948ff3f49d2da1fde797562cac2cdac4</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_Short *array, DDS_UnsignedLong *length, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_ulong_array</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga0c4edcc57725febd6dd732ec858b96fd</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_UnsignedLong *array, DDS_UnsignedLong *length, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_ushort_array</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga2b4d736bb3429d489e524b68746781f0</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_UnsignedShort *array, DDS_UnsignedLong *length, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_float_array</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga363fac8baa09ebeecef8f3fba8b63e65</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_Float *array, DDS_UnsignedLong *length, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_double_array</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga0dd1d6f8d74245bbbcbec728ed3fbbbd</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_Double *array, DDS_UnsignedLong *length, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_boolean_array</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga10bdb99d1966582539a80cc88e5311d6</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_Boolean *array, DDS_UnsignedLong *length, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_char_array</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga39a5917ee25f39bf3445958f4c9aa6fa</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_Char *array, DDS_UnsignedLong *length, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_octet_array</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga3b9eaea00c2afdeb8c824b3393652875</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_Octet *array, DDS_UnsignedLong *length, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_longlong_array</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga0078ffee805ad574290c0472743d0ce4</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_LongLong *array, DDS_UnsignedLong *length, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_ulonglong_array</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga6995a42fd91396d0125cd81c42ece30a</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_UnsignedLongLong *array, DDS_UnsignedLong *length, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_longdouble_array</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga48e734082a8292f0308210c45063eb1f</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_LongDouble *array, DDS_UnsignedLong *length, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_wchar_array</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga07c53e94494ba61b37a9f930d40b4ab1</anchor>
      <arglist>(const DDS_DynamicData *self, DDS_Wchar *array, DDS_UnsignedLong *length, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_long_seq</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga8dd734f63a0672c974ccaf54000c87a0</anchor>
      <arglist>(const DDS_DynamicData *self, struct DDS_LongSeq *seq, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_short_seq</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga43b93e8ee5aa9e0a7fda9b6f9f086ef4</anchor>
      <arglist>(const DDS_DynamicData *self, struct DDS_ShortSeq *seq, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_ulong_seq</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gac963f6b9e4d46f5ecbfe4658dc4ab9b2</anchor>
      <arglist>(const DDS_DynamicData *self, struct DDS_UnsignedLongSeq *seq, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_ushort_seq</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gaeaf05b9ec7cdab1b3cdbfcacc8ec8f5b</anchor>
      <arglist>(const DDS_DynamicData *self, struct DDS_UnsignedShortSeq *seq, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_float_seq</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gad2873434178fb3993c99044dd581b51a</anchor>
      <arglist>(const DDS_DynamicData *self, struct DDS_FloatSeq *seq, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_double_seq</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gae208ae1fb30ab8638a48a4a577adfcca</anchor>
      <arglist>(const DDS_DynamicData *self, struct DDS_DoubleSeq *seq, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_boolean_seq</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga904dc368a1cde9d4314191882d332d7a</anchor>
      <arglist>(const DDS_DynamicData *self, struct DDS_BooleanSeq *seq, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_char_seq</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gac5a419624c31db82ca19b94ccfe37405</anchor>
      <arglist>(const DDS_DynamicData *self, struct DDS_CharSeq *seq, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_octet_seq</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga61c687e995f68d8e519c25271787a136</anchor>
      <arglist>(const DDS_DynamicData *self, struct DDS_OctetSeq *seq, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_longlong_seq</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gabc725f094884d6d2c50dcd2177e27102</anchor>
      <arglist>(const DDS_DynamicData *self, struct DDS_LongLongSeq *seq, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_ulonglong_seq</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gaa21618a7c341abbe47523318e28d2805</anchor>
      <arglist>(const DDS_DynamicData *self, struct DDS_UnsignedLongLongSeq *seq, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_longdouble_seq</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gaa54a57b48f7250273ebbf9a00fdc783a</anchor>
      <arglist>(const DDS_DynamicData *self, struct DDS_LongDoubleSeq *seq, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_get_wchar_seq</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga40b454bfb814b8a21f543614916ad6ea</anchor>
      <arglist>(const DDS_DynamicData *self, struct DDS_WcharSeq *seq, const char *member_name, DDS_DynamicDataMemberId member_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_long</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gaa96968abdfdd52ece660109c2f7bdd57</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, DDS_Long value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_short</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga686e71dae1437eb355fd51374ea44779</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, DDS_Short value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_ulong</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga106338c4ad88f682976466407bc1845c</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, DDS_UnsignedLong value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_ushort</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga55c6985793d1321bf458128f9b7f67bd</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, DDS_UnsignedShort value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_float</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gabdb6615d95f89162aeb5c91372b8d6e5</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, DDS_Float value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_double</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga66d74e0187f6a85c4c89ddeb1b5ff3a6</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, DDS_Double value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_boolean</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga0f29d7a70c45c0be2846bcfdaae2f068</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, DDS_Boolean value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_char</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga2c9b9353a53840559e2e8ab28e74388d</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, DDS_Char value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_octet</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga566666b90cdd419ba275d5557a7b6cb2</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, DDS_Octet value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_longlong</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga26ac6128c064d6578cf5aaf78369d68f</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, DDS_LongLong value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_ulonglong</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gae1d762124631a9d5976e016c20fcb84d</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, DDS_UnsignedLongLong value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_longdouble</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga0aaac55015d9a6f2dd5cb70f451d368a</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, DDS_LongDouble value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_wchar</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga455e4fee0b70ec1ba017536d87cde511</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, DDS_Wchar value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_string</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga2da6131215c6ff6e9b4cdcf08f613408</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, const char *value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_wstring</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gacc79ab295b61fbac9dd1c14cd61d960a</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, const DDS_Wchar *value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_complex_member</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga60f86f6f82292ef4d0f2b05ef9cb186b</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, const DDS_DynamicData *value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_long_array</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gad14e92275ff553032828392585bbb603</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, DDS_UnsignedLong length, const DDS_Long *array)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_short_array</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga8de805339463fd127461b427163f81b3</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, DDS_UnsignedLong length, const DDS_Short *array)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_ulong_array</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga40c09220be87ff77ea07d887ece80ea7</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, DDS_UnsignedLong length, const DDS_UnsignedLong *array)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_ushort_array</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga5dc8719a6f9c54ba58ae2746a1ec37d1</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, DDS_UnsignedLong length, const DDS_UnsignedShort *array)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_float_array</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga93a62fa9e7a25198bbe245ffe298c161</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, DDS_UnsignedLong length, const DDS_Float *array)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_double_array</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga0b83351b6c49ca3dcd7d4ef696d8a733</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, DDS_UnsignedLong length, const DDS_Double *array)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_boolean_array</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gaec7dd368f39c2d8d7e84f011660ffc41</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, DDS_UnsignedLong length, const DDS_Boolean *array)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_char_array</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga36e952f9de18477ffbd8d94b9bb694dc</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, DDS_UnsignedLong length, const DDS_Char *array)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_octet_array</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gaea0411d52fff07a6cb0a312a673909d4</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, DDS_UnsignedLong length, const DDS_Octet *array)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_longlong_array</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gaa67e455fa5d7002909792259e7d8906d</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, DDS_UnsignedLong length, const DDS_LongLong *array)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_ulonglong_array</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga9895ee810409a8e7711925cef96a4f1b</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, DDS_UnsignedLong length, const DDS_UnsignedLongLong *array)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_longdouble_array</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga1144881437870014d7f306b5ce5c8917</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, DDS_UnsignedLong length, const DDS_LongDouble *array)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_wchar_array</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga37f718dd33664675624541582adbbdd7</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, DDS_UnsignedLong length, const DDS_Wchar *array)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_long_seq</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga2fc626c1012bf1994f389a45611de8c6</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, const struct DDS_LongSeq *value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_short_seq</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga48546e08a34434e564da2dcb15b4b00e</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, const struct DDS_ShortSeq *value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_ulong_seq</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga9e6de1e7099c30e86f3886dca89653e8</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, const struct DDS_UnsignedLongSeq *value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_ushort_seq</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gaf5c0f97a5f6ce9806f77a1680cd6eb38</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, const struct DDS_UnsignedShortSeq *value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_float_seq</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gaa49beeb6afe7cb0329a0cb0b4737e465</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, const struct DDS_FloatSeq *value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_double_seq</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga139ed7e7712be2b9adc31227947ca07a</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, const struct DDS_DoubleSeq *value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_boolean_seq</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gaea1a1daa5f4dc232f4277e0e6f50df93</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, const struct DDS_BooleanSeq *value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_char_seq</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga9bb0f4a215f4e1fd74e93db3e496d38c</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, const struct DDS_CharSeq *value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_octet_seq</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gae402fdbaaf4b7351719c3bcf4df15e82</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, const struct DDS_OctetSeq *value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_longlong_seq</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga1560fec6dfc183bfa90e379eb0fb9c7e</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, const struct DDS_LongLongSeq *value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_ulonglong_seq</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga31190a33e6dc6fac4259822258511488</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, const struct DDS_UnsignedLongLongSeq *value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_longdouble_seq</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga3e0266b258903ecd495d671ee484c55e</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, const struct DDS_LongDoubleSeq *value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicData_set_wchar_seq</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gada1117c417893724f11566657c6f3883</anchor>
      <arglist>(DDS_DynamicData *self, const char *member_name, DDS_DynamicDataMemberId member_id, const struct DDS_WcharSeq *value)</arglist>
    </member>
    <member kind="function">
      <type>struct DDS_DynamicDataTypeSupport *</type>
      <name>DDS_DynamicDataTypeSupport_new</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gafc7b66b712353340eaf29e2cffa17a33</anchor>
      <arglist>(DDS_TypeCode *type, const struct DDS_DynamicDataTypeProperty_t *props)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>DDS_DynamicDataTypeSupport_delete</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga1b31f4310f500feb2d8da56a12cefb03</anchor>
      <arglist>(struct DDS_DynamicDataTypeSupport *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicDataTypeSupport_register_type</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga2889dbb7ea2145487c64dfc0f0924822</anchor>
      <arglist>(struct DDS_DynamicDataTypeSupport *self, DDS_DomainParticipant *participant, const char *type_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicDataTypeSupport_unregister_type</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga6f697e0677b9a29fc7db6c837545bc98</anchor>
      <arglist>(struct DDS_DynamicDataTypeSupport *self, DDS_DomainParticipant *participant, const char *type_name)</arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>DDS_DynamicDataTypeSupport_get_type_name</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga91d7208fbee95322838623d46bd9737e</anchor>
      <arglist>(const struct DDS_DynamicDataTypeSupport *self)</arglist>
    </member>
    <member kind="function">
      <type>struct DDS_TypeCode *</type>
      <name>DDS_DynamicDataTypeSupport_get_data_type</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga1608f3d09ad0ece5e68b915b89722d6c</anchor>
      <arglist>(const struct DDS_DynamicDataTypeSupport *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DynamicData *</type>
      <name>DDS_DynamicDataTypeSupport_create_data</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga4d7163da89ba15a665b1170df17ae028</anchor>
      <arglist>(struct DDS_DynamicDataTypeSupport *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicDataTypeSupport_delete_data</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga4645c1055891143b3d938bece47b261c</anchor>
      <arglist>(struct DDS_DynamicDataTypeSupport *self, DDS_DynamicData *a_data)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>DDS_DynamicDataTypeSupport_print_data</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gafa5aa5965719c5b17330d09650ac3cf5</anchor>
      <arglist>(const struct DDS_DynamicDataTypeSupport *self, const DDS_DynamicData *a_data)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicDataTypeSupport_copy_data</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga0fdc662356fef88dd54bbdce417211c3</anchor>
      <arglist>(const struct DDS_DynamicDataTypeSupport *self, DDS_DynamicData *dest, const DDS_DynamicData *source)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicDataTypeSupport_initialize_data</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga751158002824f392ad30fbe12c3680c3</anchor>
      <arglist>(const struct DDS_DynamicDataTypeSupport *self, DDS_DynamicData *a_data)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DynamicDataTypeSupport_finalize_data</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gad4b9aef8b937e8d5e88ff26cb79f689c</anchor>
      <arglist>(const struct DDS_DynamicDataTypeSupport *self, DDS_DynamicData *a_data)</arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DynamicDataProperty_t</type>
      <name>DDS_DYNAMIC_DATA_PROPERTY_DEFAULT</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>gacc0edf6a079d8759af2b2071037de43b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DynamicDataTypeProperty_t</type>
      <name>DDS_DYNAMIC_DATA_TYPE_PROPERTY_DEFAULT</name>
      <anchorfile>group__DDSDynamicDataModule.html</anchorfile>
      <anchor>ga0805b6ec289f54f5f6e1906a41b1a1a3</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSPublicationModule</name>
    <title>Publication Module</title>
    <filename>group__DDSPublicationModule.html</filename>
    <subgroup>DDSPublisherModule</subgroup>
    <subgroup>DDSWriterModule</subgroup>
    <subgroup>DDSFlowControllerModule</subgroup>
    <subgroup>NDDSMultichannelConfigurationModule</subgroup>
  </compound>
  <compound kind="group">
    <name>DDSPublisherModule</name>
    <title>Publishers</title>
    <filename>group__DDSPublisherModule.html</filename>
    <class kind="struct">DDS_PublisherSeq</class>
    <class kind="struct">DDS_PublisherQos</class>
    <class kind="struct">DDS_PublisherListener</class>
    <member kind="define">
      <type>#define</type>
      <name>DDS_PublisherQos_INITIALIZER</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga1f75496be2446615a8cb28306817976d</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_PublisherListener_INITIALIZER</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga0ab90311311a6c4281f6b2b98271c26c</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_PublisherImpl</type>
      <name>DDS_Publisher</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga3ecc0192bac0cba03781b70cec3099c9</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_PublisherQos_equals</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga7770890228ff6d56d063821a75d7de46</anchor>
      <arglist>(const struct DDS_PublisherQos *self, const struct DDS_PublisherQos *other)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_PublisherQos_initialize</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga2757b80d41ee0b538ba4daacc6b7cc07</anchor>
      <arglist>(struct DDS_PublisherQos *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_PublisherQos_copy</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>gadebc480012b0397c81b2f417dbdd2089</anchor>
      <arglist>(struct DDS_PublisherQos *self, const struct DDS_PublisherQos *source)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_PublisherQos_finalize</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga2a85447cffb31d26513ae7d8ca43b4cf</anchor>
      <arglist>(struct DDS_PublisherQos *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Entity *</type>
      <name>DDS_Publisher_as_entity</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga418eed5ece51e249bceb6aeecd4cc19a</anchor>
      <arglist>(DDS_Publisher *publisher)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Publisher_get_default_datawriter_qos</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga777a869f4f8d435be23dea15f949f4bf</anchor>
      <arglist>(DDS_Publisher *self, struct DDS_DataWriterQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Publisher_set_default_datawriter_qos</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga2e9edb04b08d1aeedf1cc306107be267</anchor>
      <arglist>(DDS_Publisher *self, const struct DDS_DataWriterQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Publisher_set_default_datawriter_qos_with_profile</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga70dc898821807ce69efd37fa95132264</anchor>
      <arglist>(DDS_Publisher *self, const char *library_name, const char *profile_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Publisher_set_default_profile</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga255432e9b892d7095f3d2793c4bdbec4</anchor>
      <arglist>(DDS_Publisher *self, const char *library_name, const char *profile_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Publisher_set_default_library</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>gaafdda7aa1ed1d3b239f0ccb5ff25b3db</anchor>
      <arglist>(DDS_Publisher *self, const char *library_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DataWriter *</type>
      <name>DDS_Publisher_create_datawriter</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga772b272e1851120ced5e738549cb44a3</anchor>
      <arglist>(DDS_Publisher *self, DDS_Topic *topic, const struct DDS_DataWriterQos *qos, const struct DDS_DataWriterListener *listener, DDS_StatusMask mask)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DataWriter *</type>
      <name>DDS_Publisher_create_datawriter_with_profile</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga63ea168ae47a3e2a88ac2574ba011a55</anchor>
      <arglist>(DDS_Publisher *self, DDS_Topic *topic, const char *library_name, const char *profile_name, const struct DDS_DataWriterListener *listener, DDS_StatusMask mask)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Publisher_delete_datawriter</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>gaa2d341cdc5442fc4aa1fc27f1edd5707</anchor>
      <arglist>(DDS_Publisher *self, DDS_DataWriter *a_datawriter)</arglist>
      <docanchor file="group__DDSPublisherModule">PublisherDeleteDataWriter_warning</docanchor>
    </member>
    <member kind="function">
      <type>DDS_DataWriter *</type>
      <name>DDS_Publisher_lookup_datawriter</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>gaf512bd097754ed30beb445571e3ce996</anchor>
      <arglist>(DDS_Publisher *self, const char *topic_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Publisher_suspend_publications</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga8090bb6684e281c106fa510a1fc44410</anchor>
      <arglist>(DDS_Publisher *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Publisher_resume_publications</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>gaf4395a61060b7ed2354541a663eeaa76</anchor>
      <arglist>(DDS_Publisher *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Publisher_begin_coherent_changes</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga1c4904558a85a6c1d138ce8602d09e5e</anchor>
      <arglist>(DDS_Publisher *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Publisher_end_coherent_changes</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga82659674adbc0a574237d80b3ac5bdb0</anchor>
      <arglist>(DDS_Publisher *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Publisher_get_all_datawriters</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga8b01ba8055283ed3661d88a119b33cb1</anchor>
      <arglist>(DDS_Publisher *self, struct DDS_DataWriterSeq *writers)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DomainParticipant *</type>
      <name>DDS_Publisher_get_participant</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga893c432b5822f778572a07f16d3895c2</anchor>
      <arglist>(DDS_Publisher *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Publisher_delete_contained_entities</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>gaa4845fff7f12821fd653daaf6f19cdcf</anchor>
      <arglist>(DDS_Publisher *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Publisher_copy_from_topic_qos</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga87771504867da2489705b2d29324ddc0</anchor>
      <arglist>(DDS_Publisher *self, struct DDS_DataWriterQos *a_datawriter_qos, const struct DDS_TopicQos *a_topic_qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Publisher_set_qos</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga1e4b13add92130193fbeaa948f641dff</anchor>
      <arglist>(DDS_Publisher *self, const struct DDS_PublisherQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Publisher_set_qos_with_profile</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>gae9f4cfa89735e84b75bf750990a50fea</anchor>
      <arglist>(DDS_Publisher *self, const char *library_name, const char *profile_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Publisher_get_qos</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga8e26f1a5261f56bef166f94526c3fb57</anchor>
      <arglist>(DDS_Publisher *self, struct DDS_PublisherQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>DDS_Publisher_get_default_library</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>gae1c1e0fead7ee6994439f566f60fe15c</anchor>
      <arglist>(DDS_Publisher *self)</arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>DDS_Publisher_get_default_profile</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga694482bb74b6e7b1629e52872489333b</anchor>
      <arglist>(DDS_Publisher *self)</arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>DDS_Publisher_get_default_profile_library</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>gacfd86a21d9bb1dc5f994cfe79ca281da</anchor>
      <arglist>(DDS_Publisher *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Publisher_set_listener</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga2104a394c9c6c8f6e1f1eecd33558b04</anchor>
      <arglist>(DDS_Publisher *self, const struct DDS_PublisherListener *l, DDS_StatusMask mask)</arglist>
    </member>
    <member kind="function">
      <type>struct DDS_PublisherListener</type>
      <name>DDS_Publisher_get_listener</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga37b7a05b6685487b63e783e2499d09b5</anchor>
      <arglist>(DDS_Publisher *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Publisher_get_listenerX</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga95a883298ba35bb7c3cc26dd375ed7cb</anchor>
      <arglist>(DDS_Publisher *self, struct DDS_PublisherListener *listener)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Publisher_wait_for_acknowledgments</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga6fa2d5aa4519930af9841a77c90a8c5b</anchor>
      <arglist>(DDS_Publisher *self, const struct DDS_Duration_t *max_wait)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Publisher_wait_for_asynchronous_publishing</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>gac4fb02421fee49facd15efe3f291a706</anchor>
      <arglist>(DDS_Publisher *self, const struct DDS_Duration_t *max_wait)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DataWriter *</type>
      <name>DDS_Publisher_lookup_datawriter_by_name</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga02824a7ee61db017dfe7580308079756</anchor>
      <arglist>(DDS_Publisher *self, const char *datawriter_name)</arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DataWriterQos</type>
      <name>DDS_DATAWRITER_QOS_DEFAULT</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga5e41d11f0205acbdd546ce7f59bf3cdc</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DataWriterQos</type>
      <name>DDS_DATAWRITER_QOS_USE_TOPIC_QOS</name>
      <anchorfile>group__DDSPublisherModule.html</anchorfile>
      <anchor>ga6980addcda7212b399443df3a2df4acb</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSWriterModule</name>
    <title>Data Writers</title>
    <filename>group__DDSWriterModule.html</filename>
    <class kind="struct">FooDataWriter</class>
    <class kind="struct">DDS_OfferedDeadlineMissedStatus</class>
    <class kind="struct">DDS_LivelinessLostStatus</class>
    <class kind="struct">DDS_OfferedIncompatibleQosStatus</class>
    <class kind="struct">DDS_PublicationMatchedStatus</class>
    <class kind="struct">DDS_ReliableWriterCacheEventCount</class>
    <class kind="struct">DDS_ReliableWriterCacheChangedStatus</class>
    <class kind="struct">DDS_ReliableReaderActivityChangedStatus</class>
    <class kind="struct">DDS_DataWriterCacheStatus</class>
    <class kind="struct">DDS_DataWriterProtocolStatus</class>
    <class kind="struct">DDS_DataWriterQos</class>
    <class kind="struct">DDS_DataWriterListener</class>
    <member kind="define">
      <type>#define</type>
      <name>DDS_OfferedDeadlineMissedStatus_INITIALIZER</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gad4e1131a66b69fd723a05633ea75864d</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_LivelinessLostStatus_INITIALIZER</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga45669b437a85a70478cacf02b5e40dce</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_OfferedIncompatibleQosStatus_INITIALIZER</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga0fe633a81f23bfce04dcf82045fff365</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_PublicationMatchedStatus_INITIALIZER</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga484541d617c3c17e5d4c106c36e515c2</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_ReliableWriterCacheChangedStatus_INITIALIZER</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga4c82d0254e8c492bee079ce0dafecf3e</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_ReliableReaderActivityChangedStatus_INITIALIZER</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga09a2b4e70fbd97c661f012b6300e313c</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_DataWriterCacheStatus_INITIALIZER</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gaf656c76cb94c0aeb9406206e5e8405d3</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_DataWriterProtocolStatus_INITIALIZER</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gab60006a8be583b90a8ab172ec5d58c90</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_DataWriterQos_INITIALIZER</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gaf81741222815d4aaa9ae87c1493828d9</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_DataWriterListener_INITIALIZER</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gae07a1f149c86ccb7dc85688fb22eb386</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_DataWriterImpl</type>
      <name>DDS_DataWriter</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gafb74fa54675abe1bfb2090265bf4d116</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>void(*</type>
      <name>DDS_DataWriterListener_OfferedDeadlineMissedCallback</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gaed19f7487e507cd968eac2f92e9968b2</anchor>
      <arglist>)(void *listener_data, DDS_DataWriter *writer, const struct DDS_OfferedDeadlineMissedStatus *status)</arglist>
    </member>
    <member kind="typedef">
      <type>void(*</type>
      <name>DDS_DataWriterListener_LivelinessLostCallback</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga23c12b146b7499c97fbab1069ad4ff3c</anchor>
      <arglist>)(void *listener_data, DDS_DataWriter *writer, const struct DDS_LivelinessLostStatus *status)</arglist>
    </member>
    <member kind="typedef">
      <type>void(*</type>
      <name>DDS_DataWriterListener_OfferedIncompatibleQosCallback</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gabe93a914863956c7978ba645329aa988</anchor>
      <arglist>)(void *listener_data, DDS_DataWriter *writer, const struct DDS_OfferedIncompatibleQosStatus *status)</arglist>
    </member>
    <member kind="typedef">
      <type>void(*</type>
      <name>DDS_DataWriterListener_PublicationMatchedCallback</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga57db1ea471bcc7e5ff55d266f250a688</anchor>
      <arglist>)(void *listener_data, DDS_DataWriter *writer, const struct DDS_PublicationMatchedStatus *status)</arglist>
    </member>
    <member kind="typedef">
      <type>void(*</type>
      <name>DDS_DataWriterListener_ReliableWriterCacheChangedCallback</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga106a65e5d3ec28d2fdf26bbf05524932</anchor>
      <arglist>)(void *listener_data, DDS_DataWriter *writer, const struct DDS_ReliableWriterCacheChangedStatus *status)</arglist>
    </member>
    <member kind="typedef">
      <type>void(*</type>
      <name>DDS_DataWriterListener_ReliableReaderActivityChangedCallback</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga162beac99ab44dedc1be2b94c171c6f2</anchor>
      <arglist>)(void *listener_data, DDS_DataWriter *writer, const struct DDS_ReliableReaderActivityChangedStatus *status)</arglist>
    </member>
    <member kind="typedef">
      <type>void(*</type>
      <name>DDS_DataWriterListener_InstanceReplacedCallback</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gab0b15cca419d22b4ea2869bdd55b6790</anchor>
      <arglist>)(void *listener_data, DDS_DataWriter *writer, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>FooDataWriter *</type>
      <name>FooDataWriter_narrow</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga44eea8960da2ef05721fc3ee3adaed0a</anchor>
      <arglist>(DDS_DataWriter *writer)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DataWriter *</type>
      <name>FooDataWriter_as_datawriter</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga6d2507cb2bdec4454eea1d88aaa96802</anchor>
      <arglist>(FooDataWriter *writer)</arglist>
    </member>
    <member kind="function">
      <type>DDS_InstanceHandle_t</type>
      <name>FooDataWriter_register_instance</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gaf743b8408452bd9d1e41bc42e2bd981e</anchor>
      <arglist>(FooDataWriter *self, const Foo *instance_data)</arglist>
    </member>
    <member kind="function">
      <type>DDS_InstanceHandle_t</type>
      <name>FooDataWriter_register_instance_w_timestamp</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga0fd9f769a7f7373ebd611e3c4f1ac0b0</anchor>
      <arglist>(FooDataWriter *self, const Foo *instance_data, const struct DDS_Time_t *source_timestamp)</arglist>
    </member>
    <member kind="function">
      <type>DDS_InstanceHandle_t</type>
      <name>FooDataWriter_register_instance_w_params</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga3f4a89dfd1253ef7e0ba2513bb3434cf</anchor>
      <arglist>(FooDataWriter *self, const Foo *instance_data, struct DDS_WriteParams_t *params)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooDataWriter_unregister_instance</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gaa6f4d83a43fd8e2f76aa23022f5874b4</anchor>
      <arglist>(FooDataWriter *self, const Foo *instance_data, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooDataWriter_unregister_instance_w_timestamp</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga6eecab8ebe14cde0bc233930fcce325b</anchor>
      <arglist>(FooDataWriter *self, const Foo *instance_data, const DDS_InstanceHandle_t *handle, const struct DDS_Time_t *source_timestamp)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooDataWriter_unregister_instance_w_params</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gae425838e93abc3ac5ae7ddb52f54118d</anchor>
      <arglist>(FooDataWriter *self, const Foo *instance_data, struct DDS_WriteParams_t *params)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooDataWriter_write</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga5326afcc07471f9589cc6f6c5c6c59b2</anchor>
      <arglist>(FooDataWriter *self, const Foo *instance_data, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooDataWriter_write_w_timestamp</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga3694f0748773a7aa2cfaf39cd0e0b185</anchor>
      <arglist>(FooDataWriter *self, const Foo *instance_data, const DDS_InstanceHandle_t *handle, const struct DDS_Time_t *source_timestamp)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooDataWriter_write_w_params</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gaabf2b2a53628198e07933089f972f122</anchor>
      <arglist>(FooDataWriter *self, const Foo *instance_data, struct DDS_WriteParams_t *params)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooDataWriter_dispose</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga1c34f0e5965f384268a9fef8cc017300</anchor>
      <arglist>(FooDataWriter *self, const Foo *instance_data, const DDS_InstanceHandle_t *instance_handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooDataWriter_dispose_w_timestamp</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga4fcd79bfe25117fae010dcc235298797</anchor>
      <arglist>(FooDataWriter *self, const Foo *instance_data, const DDS_InstanceHandle_t *instance_handle, const struct DDS_Time_t *source_timestamp)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooDataWriter_dispose_w_params</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gad7a8fee146411663f20e67a52de8ec3d</anchor>
      <arglist>(FooDataWriter *self, const Foo *instance_data, struct DDS_WriteParams_t *params)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooDataWriter_get_key_value</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga19894c4f981ba46f999ab297b5211cf9</anchor>
      <arglist>(FooDataWriter *self, Foo *key_holder, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_InstanceHandle_t</type>
      <name>FooDataWriter_lookup_instance</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga94f6794ca575ee783357ee776af18de1</anchor>
      <arglist>(FooDataWriter *self, const Foo *key_holder)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_OfferedDeadlineMissedStatus_initialize</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gaa31f5ff09f30ec8725c3026a307aa828</anchor>
      <arglist>(struct DDS_OfferedDeadlineMissedStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_OfferedDeadlineMissedStatus_copy</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gaf3c5706dc3efeec7e8070ef2c9fde96b</anchor>
      <arglist>(struct DDS_OfferedDeadlineMissedStatus *self, const struct DDS_OfferedDeadlineMissedStatus *source)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_OfferedDeadlineMissedStatus_finalize</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga06ab315ad128169f50d548bb5fd3bcf1</anchor>
      <arglist>(struct DDS_OfferedDeadlineMissedStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_LivelinessLostStatus_initialize</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gaebc1403c8087b2c6a97f6c9c6ccae08b</anchor>
      <arglist>(struct DDS_LivelinessLostStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_LivelinessLostStatus_copy</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gaa5b4a9382be72fcdbb7916c493c98c10</anchor>
      <arglist>(struct DDS_LivelinessLostStatus *self, const struct DDS_LivelinessLostStatus *source)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_LivelinessLostStatus_finalize</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga5ebf856c96dd2486f5e7ecab6237336f</anchor>
      <arglist>(struct DDS_LivelinessLostStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_OfferedIncompatibleQosStatus_initialize</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga04370856fc32d953f6c6f6cca2b5fb0b</anchor>
      <arglist>(struct DDS_OfferedIncompatibleQosStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_OfferedIncompatibleQosStatus_copy</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga0cd69ab2dab7f41792388840fbbb3176</anchor>
      <arglist>(struct DDS_OfferedIncompatibleQosStatus *self, const struct DDS_OfferedIncompatibleQosStatus *source)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_OfferedIncompatibleQosStatus_finalize</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gac572d48b196b49048a7ca30994482b9b</anchor>
      <arglist>(struct DDS_OfferedIncompatibleQosStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_PublicationMatchedStatus_initialize</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga08d2380f3f67a098660b1c25193fd896</anchor>
      <arglist>(struct DDS_PublicationMatchedStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_PublicationMatchedStatus_copy</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga2d48ae914978c89c816a6acf1e27fecc</anchor>
      <arglist>(struct DDS_PublicationMatchedStatus *self, const struct DDS_PublicationMatchedStatus *source)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_PublicationMatchedStatus_finalize</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga6232d6f670d107fe088f68d8e86f1c00</anchor>
      <arglist>(struct DDS_PublicationMatchedStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_ReliableWriterCacheChangedStatus_initialize</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gad42c772c1792582e2dda4a80c53f58e7</anchor>
      <arglist>(struct DDS_ReliableWriterCacheChangedStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_ReliableWriterCacheChangedStatus_copy</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga1a0b6d56b2f80f2f901a94327cf7909c</anchor>
      <arglist>(struct DDS_ReliableWriterCacheChangedStatus *self, const struct DDS_ReliableWriterCacheChangedStatus *source)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_ReliableWriterCacheChangedStatus_finalize</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga0defe0f7d3244deefa1f999216cff189</anchor>
      <arglist>(struct DDS_ReliableWriterCacheChangedStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_ReliableReaderActivityChangedStatus_initialize</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gadbdf631139dc85b7fc57127db396ca7b</anchor>
      <arglist>(struct DDS_ReliableReaderActivityChangedStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_ReliableReaderActivityChangedStatus_copy</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gad8806548079b0b508c931bcd0f96d620</anchor>
      <arglist>(struct DDS_ReliableReaderActivityChangedStatus *self, const struct DDS_ReliableReaderActivityChangedStatus *source)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_ReliableReaderActivityChangedStatus_finalize</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gaf722b11e6cadc4419e12aeb69d61db7f</anchor>
      <arglist>(struct DDS_ReliableReaderActivityChangedStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriterCacheStatus_initialize</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga60bdf4c7f080ae4cb9248e47293f8bbc</anchor>
      <arglist>(struct DDS_DataWriterCacheStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriterCacheStatus_copy</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga7d361332e92496d47bb79ff007a2dcd2</anchor>
      <arglist>(struct DDS_DataWriterCacheStatus *self, const struct DDS_DataWriterCacheStatus *source)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriterCacheStatus_finalize</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga374c588f0abd59a2d81a2c6a83327b91</anchor>
      <arglist>(struct DDS_DataWriterCacheStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriterProtocolStatus_initialize</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga6aec6a4ad5e7b4d9ac6a160044a288e6</anchor>
      <arglist>(struct DDS_DataWriterProtocolStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriterProtocolStatus_copy</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga05b8b3371bd852bd3773c853f657cbe9</anchor>
      <arglist>(struct DDS_DataWriterProtocolStatus *self, const struct DDS_DataWriterProtocolStatus *source)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriterProtocolStatus_finalize</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga2232ed8feb454c685517e2b082beb30b</anchor>
      <arglist>(struct DDS_DataWriterProtocolStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriterQos_initialize</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga4f6e0b64a46f98abbc9cfb84869999c5</anchor>
      <arglist>(struct DDS_DataWriterQos *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriterQos_copy</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gaffc1d9cd9deae824b4018f3fd5762976</anchor>
      <arglist>(struct DDS_DataWriterQos *self, const struct DDS_DataWriterQos *source)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriterQos_finalize</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga8d9ef66267938a5c9413aa1f2c844781</anchor>
      <arglist>(struct DDS_DataWriterQos *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Entity *</type>
      <name>DDS_DataWriter_as_entity</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga2dfe7828d957f9b394c318eea1a29f63</anchor>
      <arglist>(DDS_DataWriter *dataWriter)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriter_assert_liveliness</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga57aafc43ea2c1cc347e8c9357e70fa68</anchor>
      <arglist>(DDS_DataWriter *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriter_get_matched_subscription_locators</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga612da8dfb4efb3810f9a9e6d75ddc933</anchor>
      <arglist>(DDS_DataWriter *self, struct DDS_LocatorSeq *locators)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriter_get_matched_subscriptions</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gacfee88d945dd5940cdef6778d45e554d</anchor>
      <arglist>(DDS_DataWriter *self, struct DDS_InstanceHandleSeq *subscription_handles)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriter_get_matched_subscription_data</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga023e6a5753b14dac23731f4e64f56b89</anchor>
      <arglist>(DDS_DataWriter *self, struct DDS_SubscriptionBuiltinTopicData *subscription_data, const DDS_InstanceHandle_t *subscription_handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriter_get_matched_subscription_participant_data</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gab3679a5da755071b6d60da072e45b670</anchor>
      <arglist>(DDS_DataWriter *self, struct DDS_ParticipantBuiltinTopicData *participant_data, const DDS_InstanceHandle_t *subscription_handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Topic *</type>
      <name>DDS_DataWriter_get_topic</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gae73ef16dff3c09223938454dd5cf406c</anchor>
      <arglist>(DDS_DataWriter *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Publisher *</type>
      <name>DDS_DataWriter_get_publisher</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga868d81aec743e92dcfa9b3a3bd73bc0e</anchor>
      <arglist>(DDS_DataWriter *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriter_wait_for_acknowledgments</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga21678bb4a7d749856968d5375a746e89</anchor>
      <arglist>(DDS_DataWriter *self, const struct DDS_Duration_t *max_wait)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriter_wait_for_asynchronous_publishing</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gace16a203b70fd62e24eb20ea8f441490</anchor>
      <arglist>(DDS_DataWriter *self, const struct DDS_Duration_t *max_wait)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriter_get_liveliness_lost_status</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga3d9373c380f858ecfa508f783a9aacc7</anchor>
      <arglist>(DDS_DataWriter *self, struct DDS_LivelinessLostStatus *status)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriter_get_offered_deadline_missed_status</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga4ff13802e4ffedb058b778f83086ce70</anchor>
      <arglist>(DDS_DataWriter *self, struct DDS_OfferedDeadlineMissedStatus *status)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriter_get_offered_incompatible_qos_status</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gaa6af71811d2cae756bbebc3b9170d827</anchor>
      <arglist>(DDS_DataWriter *self, struct DDS_OfferedIncompatibleQosStatus *status)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriter_get_publication_matched_status</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga8babcbfbdf6d813c81b6dacdc3416f5a</anchor>
      <arglist>(DDS_DataWriter *self, struct DDS_PublicationMatchedStatus *status)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriter_get_reliable_writer_cache_changed_status</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga787500c5ea8883fcba09406fc2fa6bc9</anchor>
      <arglist>(DDS_DataWriter *self, struct DDS_ReliableWriterCacheChangedStatus *status)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriter_get_reliable_reader_activity_changed_status</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga5ddd064eb89fa810f41b0cf6fdd0fb92</anchor>
      <arglist>(DDS_DataWriter *self, struct DDS_ReliableReaderActivityChangedStatus *status)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriter_get_datawriter_cache_status</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga465b0ed608a0633b840930f2824e7eff</anchor>
      <arglist>(DDS_DataWriter *self, struct DDS_DataWriterCacheStatus *status)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriter_get_datawriter_protocol_status</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gac095d028778ada59e66c9d4bf926cfc0</anchor>
      <arglist>(DDS_DataWriter *self, struct DDS_DataWriterProtocolStatus *status)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriter_get_matched_subscription_datawriter_protocol_status</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gaa02225caae91cfc76078400d9e41ee4c</anchor>
      <arglist>(DDS_DataWriter *self, struct DDS_DataWriterProtocolStatus *status, const DDS_InstanceHandle_t *subscription_handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriter_get_matched_subscription_datawriter_protocol_status_by_locator</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga6d85603fb62c9355a93dc8da0b490f13</anchor>
      <arglist>(DDS_DataWriter *self, struct DDS_DataWriterProtocolStatus *status, const struct DDS_Locator_t *locator)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriter_set_qos</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gabf90c071462a19cde215c4f8f1ff4fae</anchor>
      <arglist>(DDS_DataWriter *self, const struct DDS_DataWriterQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriter_set_qos_with_profile</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga8d567e6b34b3c34848bf41dfb750414b</anchor>
      <arglist>(DDS_DataWriter *self, const char *library_name, const char *profile_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriter_get_qos</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gacd5d551c8f92da6a5edb761ab7a9e2ac</anchor>
      <arglist>(DDS_DataWriter *self, struct DDS_DataWriterQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriter_set_listener</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>gaba1530a579da000a7924567b928d121c</anchor>
      <arglist>(DDS_DataWriter *self, const struct DDS_DataWriterListener *l, DDS_StatusMask mask)</arglist>
    </member>
    <member kind="function">
      <type>struct DDS_DataWriterListener</type>
      <name>DDS_DataWriter_get_listener</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga739bb96b1857c79ca216bb52a9d36898</anchor>
      <arglist>(DDS_DataWriter *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriter_get_listenerX</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga489637c6bd6f304be5077ab6acfcbd59</anchor>
      <arglist>(DDS_DataWriter *self, struct DDS_DataWriterListener *listener)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataWriter_flush</name>
      <anchorfile>group__DDSWriterModule.html</anchorfile>
      <anchor>ga40891e5c86df206f01967a090cbfb238</anchor>
      <arglist>(DDS_DataWriter *self)</arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSFlowControllerModule</name>
    <title>Flow Controllers</title>
    <filename>group__DDSFlowControllerModule.html</filename>
    <class kind="struct">DDS_FlowControllerTokenBucketProperty_t</class>
    <class kind="struct">DDS_FlowControllerProperty_t</class>
    <member kind="define">
      <type>#define</type>
      <name>DDS_FlowControllerProperty_t_INITIALIZER</name>
      <anchorfile>group__DDSFlowControllerModule.html</anchorfile>
      <anchor>ga6a5a671aa9343bd987fb5ff9edb804dc</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_FlowControllerImpl</type>
      <name>DDS_FlowController</name>
      <anchorfile>group__DDSFlowControllerModule.html</anchorfile>
      <anchor>ga83cea6d99ed74b73ced263ba4dc9c23a</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumeration">
      <name>DDS_FlowControllerSchedulingPolicy</name>
      <anchorfile>group__DDSFlowControllerModule.html</anchorfile>
      <anchor>gacdd2356baadedf00457c9ce32f5ca115</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_RR_FLOW_CONTROLLER_SCHED_POLICY</name>
      <anchorfile>group__DDSFlowControllerModule.html</anchorfile>
      <anchor>ggacdd2356baadedf00457c9ce32f5ca115a22b0cb68305116cc3a5978084685c1cd</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_EDF_FLOW_CONTROLLER_SCHED_POLICY</name>
      <anchorfile>group__DDSFlowControllerModule.html</anchorfile>
      <anchor>ggacdd2356baadedf00457c9ce32f5ca115afb77daa170cc951b2387ca9e24003a38</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_HPF_FLOW_CONTROLLER_SCHED_POLICY</name>
      <anchorfile>group__DDSFlowControllerModule.html</anchorfile>
      <anchor>ggacdd2356baadedf00457c9ce32f5ca115abcc07438223e2fe71c0bff710b3ef020</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>DDS_FlowController_get_name</name>
      <anchorfile>group__DDSFlowControllerModule.html</anchorfile>
      <anchor>ga5345f6e0446ca2f74f3a825e107254d6</anchor>
      <arglist>(DDS_FlowController *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DomainParticipant *</type>
      <name>DDS_FlowController_get_participant</name>
      <anchorfile>group__DDSFlowControllerModule.html</anchorfile>
      <anchor>gaaecc72b685e2e84d23d4fdee295e4e34</anchor>
      <arglist>(DDS_FlowController *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_FlowController_set_property</name>
      <anchorfile>group__DDSFlowControllerModule.html</anchorfile>
      <anchor>gaad9a60ccca2828e32c4a72c779802566</anchor>
      <arglist>(DDS_FlowController *self, const struct DDS_FlowControllerProperty_t *prop)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_FlowController_get_property</name>
      <anchorfile>group__DDSFlowControllerModule.html</anchorfile>
      <anchor>gad5d147faabe8d9c42b6c99ac5d61b7aa</anchor>
      <arglist>(DDS_FlowController *self, struct DDS_FlowControllerProperty_t *prop)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_FlowController_trigger_flow</name>
      <anchorfile>group__DDSFlowControllerModule.html</anchorfile>
      <anchor>ga104af1cfa8ca7a03dbabc053fd754e92</anchor>
      <arglist>(DDS_FlowController *self)</arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>DDS_DEFAULT_FLOW_CONTROLLER_NAME</name>
      <anchorfile>group__DDSFlowControllerModule.html</anchorfile>
      <anchor>gaba76b62e6ff238c95585031f4dd1a322</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>DDS_FIXED_RATE_FLOW_CONTROLLER_NAME</name>
      <anchorfile>group__DDSFlowControllerModule.html</anchorfile>
      <anchor>ga095dcf1a86a1b6677c20e9e3d8cf37ae</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>DDS_ON_DEMAND_FLOW_CONTROLLER_NAME</name>
      <anchorfile>group__DDSFlowControllerModule.html</anchorfile>
      <anchor>gad64af801f2fc8d27df12b23e1a4af73b</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSSubscriptionModule</name>
    <title>Subscription Module</title>
    <filename>group__DDSSubscriptionModule.html</filename>
    <subgroup>DDSSubscriberModule</subgroup>
    <subgroup>DDSReaderModule</subgroup>
    <subgroup>DDSDataSampleModule</subgroup>
    <docanchor file="group__DDSSubscriptionModule">Subscription_access_samples</docanchor>
    <docanchor file="group__DDSSubscriptionModule">Data_access_patterns</docanchor>
  </compound>
  <compound kind="group">
    <name>DDSSubscriberModule</name>
    <title>Subscribers</title>
    <filename>group__DDSSubscriberModule.html</filename>
    <class kind="struct">DDS_SubscriberSeq</class>
    <class kind="struct">DDS_SubscriberQos</class>
    <class kind="struct">DDS_SubscriberListener</class>
    <member kind="define">
      <type>#define</type>
      <name>DDS_SubscriberQos_INITIALIZER</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga626f3b3eb095e2d08bd0d8aeb12ca23a</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_SubscriberListener_INITIALIZER</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga7104922af0f636331544424d12ff14d3</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_SubscriberImpl</type>
      <name>DDS_Subscriber</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga2755712602505786a23baef5a42d6782</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>void(*</type>
      <name>DDS_SubscriberListener_DataOnReadersCallback</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>gab31891ae277f456abc2108d29e75abfe</anchor>
      <arglist>)(void *listener_data, DDS_Subscriber *sub)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_SubscriberQos_equals</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga01b88b6959e687c3a7109991478e4b38</anchor>
      <arglist>(const struct DDS_SubscriberQos *self, const struct DDS_SubscriberQos *other)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_SubscriberQos_initialize</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga976d77dadbc7ab4a2f5fcbb514b76944</anchor>
      <arglist>(struct DDS_SubscriberQos *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_SubscriberQos_copy</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga5bf3f615431954880b8f040206cff82c</anchor>
      <arglist>(struct DDS_SubscriberQos *self, const struct DDS_SubscriberQos *source)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_SubscriberQos_finalize</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>gaf73f46e839f07ac899dad325fdb3e4ff</anchor>
      <arglist>(struct DDS_SubscriberQos *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Entity *</type>
      <name>DDS_Subscriber_as_entity</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga207cb0115b3b799067aaeab7ec5db67b</anchor>
      <arglist>(DDS_Subscriber *subscriber)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Subscriber_get_default_datareader_qos</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>gab34681872803713ab97a63be91794fbd</anchor>
      <arglist>(DDS_Subscriber *self, struct DDS_DataReaderQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Subscriber_set_default_datareader_qos</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>gaf61b05f9f17c20efc4da6dcdb60b3bea</anchor>
      <arglist>(DDS_Subscriber *self, const struct DDS_DataReaderQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Subscriber_set_default_datareader_qos_with_profile</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga770a1590987400674ff7f4c02274448d</anchor>
      <arglist>(DDS_Subscriber *self, const char *library_name, const char *profile_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DataReader *</type>
      <name>DDS_Subscriber_create_datareader</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>gac02a61ced642fe9d9f7466f7ba67010e</anchor>
      <arglist>(DDS_Subscriber *self, DDS_TopicDescription *topic, const struct DDS_DataReaderQos *qos, const struct DDS_DataReaderListener *listener, DDS_StatusMask mask)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DataReader *</type>
      <name>DDS_Subscriber_create_datareader_with_profile</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga421a3a216bac48114659411e9ec56133</anchor>
      <arglist>(DDS_Subscriber *self, DDS_TopicDescription *topic, const char *library_name, const char *profile_name, const struct DDS_DataReaderListener *listener, DDS_StatusMask mask)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Subscriber_delete_datareader</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>gaf47ced9dededcc0b95b9cdb5365b2384</anchor>
      <arglist>(DDS_Subscriber *self, DDS_DataReader *a_datareader)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Subscriber_delete_contained_entities</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga09aa47773904fbfa844b442388482915</anchor>
      <arglist>(DDS_Subscriber *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DataReader *</type>
      <name>DDS_Subscriber_lookup_datareader</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga0d7ce22519164e8974ea9d74cbe502f7</anchor>
      <arglist>(DDS_Subscriber *self, const char *topic_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Subscriber_begin_access</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga0ad1e6a4e43dcbf08f9807019bb5588a</anchor>
      <arglist>(DDS_Subscriber *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Subscriber_end_access</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga36fb2549e1334a004e339dd0fc35d3e2</anchor>
      <arglist>(DDS_Subscriber *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Subscriber_get_datareaders</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga8837681e166266f7c473737554da8b43</anchor>
      <arglist>(DDS_Subscriber *self, struct DDS_DataReaderSeq *readers, DDS_SampleStateMask sample_states, DDS_ViewStateMask view_states, DDS_InstanceStateMask instance_states)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Subscriber_get_all_datareaders</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>gae8b405be9eeeea508cdafbc0e970f5a4</anchor>
      <arglist>(DDS_Subscriber *self, struct DDS_DataReaderSeq *readers)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Subscriber_notify_datareaders</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga36fbd413c93f6be65ebe643ca7a08823</anchor>
      <arglist>(DDS_Subscriber *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DomainParticipant *</type>
      <name>DDS_Subscriber_get_participant</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga3de7203c9928f04866c7f791efd97078</anchor>
      <arglist>(DDS_Subscriber *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Subscriber_copy_from_topic_qos</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga2d63daff4b7825dd2777192e2ae9a27a</anchor>
      <arglist>(DDS_Subscriber *self, struct DDS_DataReaderQos *datareader_qos, const struct DDS_TopicQos *topic_qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Subscriber_set_qos</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga778c3825ec844378693938e7baa8cb57</anchor>
      <arglist>(DDS_Subscriber *self, const struct DDS_SubscriberQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Subscriber_set_qos_with_profile</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>gad86fca5ad8ca6e8e8dbb4331df691e18</anchor>
      <arglist>(DDS_Subscriber *self, const char *library_name, const char *profile_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Subscriber_get_qos</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga70668785e176106ae34994d1488f1f4d</anchor>
      <arglist>(DDS_Subscriber *self, struct DDS_SubscriberQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Subscriber_set_default_profile</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga7407d3352e9621c7b2ead6009c59d568</anchor>
      <arglist>(DDS_Subscriber *self, const char *library_name, const char *profile_name)</arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>DDS_Subscriber_get_default_profile</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga3e2cf938923819340559ebe08666c8d5</anchor>
      <arglist>(DDS_Subscriber *self)</arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>DDS_Subscriber_get_default_profile_library</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga0ed93a8baf7370e68c8a2e0bbfe80c17</anchor>
      <arglist>(DDS_Subscriber *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Subscriber_set_default_library</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga789331ac5388bbf0d3f3e997bccef2dc</anchor>
      <arglist>(DDS_Subscriber *self, const char *library_name)</arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>DDS_Subscriber_get_default_library</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga20373daf780d07137e99d9ae9139b52e</anchor>
      <arglist>(DDS_Subscriber *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Subscriber_set_listener</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga7e95234828ad2052f48c704ea58a4f0d</anchor>
      <arglist>(DDS_Subscriber *self, const struct DDS_SubscriberListener *l, DDS_StatusMask mask)</arglist>
    </member>
    <member kind="function">
      <type>struct DDS_SubscriberListener</type>
      <name>DDS_Subscriber_get_listener</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga885643c7409fc4a03a03d63a9fa615f0</anchor>
      <arglist>(DDS_Subscriber *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Subscriber_get_listenerX</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga798ccf05d49f141fc59064e5545d4e24</anchor>
      <arglist>(DDS_Subscriber *self, struct DDS_SubscriberListener *listener)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DataReader *</type>
      <name>DDS_Subscriber_lookup_datareader_by_name</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga36f486448aab22fe40d29ea5225432d8</anchor>
      <arglist>(DDS_Subscriber *self, const char *datareader_name)</arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DataReaderQos</type>
      <name>DDS_DATAREADER_QOS_DEFAULT</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>gabf8d3b7aa9e72443354af9aa5bc02f81</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DataReaderQos</type>
      <name>DDS_DATAREADER_QOS_USE_TOPIC_QOS</name>
      <anchorfile>group__DDSSubscriberModule.html</anchorfile>
      <anchor>ga3aa2b2c70744b7437555af2384ef0ec9</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSReaderModule</name>
    <title>DataReaders</title>
    <filename>group__DDSReaderModule.html</filename>
    <subgroup>DDSReadConditionModule</subgroup>
    <subgroup>DDSQueryConditionModule</subgroup>
    <class kind="struct">FooDataReader</class>
    <class kind="struct">DDS_RequestedDeadlineMissedStatus</class>
    <class kind="struct">DDS_LivelinessChangedStatus</class>
    <class kind="struct">DDS_RequestedIncompatibleQosStatus</class>
    <class kind="struct">DDS_SampleLostStatus</class>
    <class kind="struct">DDS_SampleRejectedStatus</class>
    <class kind="struct">DDS_SubscriptionMatchedStatus</class>
    <class kind="struct">DDS_DataReaderCacheStatus</class>
    <class kind="struct">DDS_DataReaderProtocolStatus</class>
    <class kind="struct">DDS_DataReaderQos</class>
    <class kind="struct">DDS_DataReaderSeq</class>
    <class kind="struct">DDS_DataReaderListener</class>
    <member kind="define">
      <type>#define</type>
      <name>DDS_RequestedDeadlineMissedStatus_INITIALIZER</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga63dd5dce539e1fbfeef6aa103fe5a5c6</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_LivelinessChangedStatus_INITIALIZER</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga2782ef600172b7568bbb2b63bba06579</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_RequestedIncompatibleQosStatus_INITIALIZER</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga921a6add7754ae8c670109f4755fd84b</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_SampleLostStatus_INITIALIZER</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gaf4c1f7a879707692562cd6508d5966aa</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_SampleRejectedStatus_INITIALIZER</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga0a4b42a43cd74020e6315ab9fec1895d</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_SubscriptionMatchedStatus_INITIALIZER</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga6c5c0e445a7d0e968129792ee3ad9403</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_DataReaderCacheStatus_INITIALIZER</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga901cbe00ad4ca398bbb2d768d2e3e856</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_DataReaderProtocolStatus_INITIALIZER</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gafaab1c73ce936c2664bf5c5055f32ae9</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_DataReaderQos_INITIALIZER</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga9b7aa62b41bef09a48fc43ea26d2e645</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_DataReaderListener_INITIALIZER</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga73c951eb6afc00d3fccdfca2536bce2b</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_DataReaderImpl</type>
      <name>DDS_DataReader</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga49ce0cab2c1b60ddee4784a1432577a4</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>void(*</type>
      <name>DDS_DataReaderListener_RequestedDeadlineMissedCallback</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga954dd80bd1a0d5b86f0613462454adef</anchor>
      <arglist>)(void *listener_data, DDS_DataReader *reader, const struct DDS_RequestedDeadlineMissedStatus *status)</arglist>
    </member>
    <member kind="typedef">
      <type>void(*</type>
      <name>DDS_DataReaderListener_LivelinessChangedCallback</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga3d749ce83353232c9c4a914acc4afce1</anchor>
      <arglist>)(void *listener_data, DDS_DataReader *reader, const struct DDS_LivelinessChangedStatus *status)</arglist>
    </member>
    <member kind="typedef">
      <type>void(*</type>
      <name>DDS_DataReaderListener_RequestedIncompatibleQosCallback</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gadce87ecc8231a21ba76f0beb752314d2</anchor>
      <arglist>)(void *listener_data, DDS_DataReader *reader, const struct DDS_RequestedIncompatibleQosStatus *status)</arglist>
    </member>
    <member kind="typedef">
      <type>void(*</type>
      <name>DDS_DataReaderListener_SampleRejectedCallback</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga6c033dbc972b3d0c4adac66170251e1a</anchor>
      <arglist>)(void *listener_data, DDS_DataReader *reader, const struct DDS_SampleRejectedStatus *status)</arglist>
    </member>
    <member kind="typedef">
      <type>void(*</type>
      <name>DDS_DataReaderListener_DataAvailableCallback</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga7fa5b4a74f27c608ec02108ff2b248f1</anchor>
      <arglist>)(void *listener_data, DDS_DataReader *reader)</arglist>
    </member>
    <member kind="typedef">
      <type>void(*</type>
      <name>DDS_DataReaderListener_SubscriptionMatchedCallback</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga25cb1e83a698d3c5b2dd53572b33b376</anchor>
      <arglist>)(void *listener_data, DDS_DataReader *reader, const struct DDS_SubscriptionMatchedStatus *status)</arglist>
    </member>
    <member kind="typedef">
      <type>void(*</type>
      <name>DDS_DataReaderListener_SampleLostCallback</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga07f2384e3cc57a3f53dffb2b48efbab1</anchor>
      <arglist>)(void *listener_data, DDS_DataReader *reader, const struct DDS_SampleLostStatus *status)</arglist>
    </member>
    <member kind="enumeration">
      <name>DDS_SampleLostStatusKind</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gad50b30818f1c22476283f3dd114a1834</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_NOT_LOST</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ggad50b30818f1c22476283f3dd114a1834a88a29dec42ddfe8b5346325eac2432e4</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_LOST_BY_WRITER</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ggad50b30818f1c22476283f3dd114a1834a2764ab3932dd5f738b64d6b79208dd15</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_LOST_BY_INSTANCES_LIMIT</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ggad50b30818f1c22476283f3dd114a1834a95ee9a6704748fcce62715ba272f360e</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_LOST_BY_REMOTE_WRITERS_PER_INSTANCE_LIMIT</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ggad50b30818f1c22476283f3dd114a1834a301989c14fc416e42d5e1327e4eacdc0</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_LOST_BY_INCOMPLETE_COHERENT_SET</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ggad50b30818f1c22476283f3dd114a1834aaa89fc62dc45b57fef0794a9140b5034</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_LOST_BY_LARGE_COHERENT_SET</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ggad50b30818f1c22476283f3dd114a1834a55aefe07aa3d87f04d25f13e35d6389f</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_LOST_BY_SAMPLES_PER_REMOTE_WRITER_LIMIT</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ggad50b30818f1c22476283f3dd114a1834a14822d440742f69e4b386006bf97717f</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_LOST_BY_VIRTUAL_WRITERS_LIMIT</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ggad50b30818f1c22476283f3dd114a1834a7c2e169e733580e9b0952677ec5ed804</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_LOST_BY_REMOTE_WRITERS_PER_SAMPLE_LIMIT</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ggad50b30818f1c22476283f3dd114a1834a9d1aeffb37364cf20ffcae72f9a28dd6</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_LOST_BY_AVAILABILITY_WAITING_TIME</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ggad50b30818f1c22476283f3dd114a1834aa44d2f74c38e1e9b5636609bc7c7944f</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_LOST_BY_REMOTE_WRITER_SAMPLES_PER_VIRTUAL_QUEUE_LIMIT</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ggad50b30818f1c22476283f3dd114a1834a7bfdbf1173b8b6b67aa2f2d51fed6091</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_LOST_BY_OUT_OF_MEMORY</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ggad50b30818f1c22476283f3dd114a1834a0c3528b082cd0e44375323ae11500abe</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumeration">
      <name>DDS_SampleRejectedStatusKind</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga08df559babd09ceefcd351b2cb6876f1</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_NOT_REJECTED</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gga08df559babd09ceefcd351b2cb6876f1ae371624e8cee89be655a853a3107fb35</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_REJECTED_BY_INSTANCES_LIMIT</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gga08df559babd09ceefcd351b2cb6876f1a0dab8798e087551400c60a82a42ce02a</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_REJECTED_BY_SAMPLES_LIMIT</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gga08df559babd09ceefcd351b2cb6876f1ad17f50fcc59ea3b9decd493227f6d1ca</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_REJECTED_BY_SAMPLES_PER_INSTANCE_LIMIT</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gga08df559babd09ceefcd351b2cb6876f1aab6c983268ca4dd0520e6705156197b7</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_REJECTED_BY_REMOTE_WRITERS_LIMIT</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gga08df559babd09ceefcd351b2cb6876f1ac318063c4701ef9d3f77becafd075c6f</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_REJECTED_BY_REMOTE_WRITERS_PER_INSTANCE_LIMIT</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gga08df559babd09ceefcd351b2cb6876f1a3da6690a19e97fa66a68e5c2edb4c85e</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_REJECTED_BY_SAMPLES_PER_REMOTE_WRITER_LIMIT</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gga08df559babd09ceefcd351b2cb6876f1a98f2efea03af4d0aecfa356b01e91789</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_REJECTED_BY_VIRTUAL_WRITERS_LIMIT</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gga08df559babd09ceefcd351b2cb6876f1a01aac2f41faf7a44e24e0d6354f8bd68</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_REJECTED_BY_REMOTE_WRITERS_PER_SAMPLE_LIMIT</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gga08df559babd09ceefcd351b2cb6876f1a285dc1adf73ff5a401d66a684ded45f2</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_REJECTED_BY_REMOTE_WRITER_SAMPLES_PER_VIRTUAL_QUEUE_LIMIT</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gga08df559babd09ceefcd351b2cb6876f1a6f37ba9431ba961c48483d935d9e77c4</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>FooDataReader *</type>
      <name>FooDataReader_narrow</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga0436d021ed263221d64cc4d072cf3b70</anchor>
      <arglist>(DDS_DataReader *reader)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DataReader *</type>
      <name>FooDataReader_as_datareader</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga1e8fa1f655eb6653b53a48e743aa6a86</anchor>
      <arglist>(FooDataReader *reader)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooDataReader_read</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga84f8ad6ee21fb024234034bbcce6d812</anchor>
      <arglist>(FooDataReader *self, struct FooSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, DDS_SampleStateMask sample_states, DDS_ViewStateMask view_states, DDS_InstanceStateMask instance_states)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooDataReader_take</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gafa56233023b6c95f89a9df48d16a4659</anchor>
      <arglist>(FooDataReader *self, struct FooSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, DDS_SampleStateMask sample_states, DDS_ViewStateMask view_states, DDS_InstanceStateMask instance_states)</arglist>
      <docanchor file="group__DDSReaderModule">Data_and_sampleinfo_sequence</docanchor>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooDataReader_read_w_condition</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gab3aa397b246f0c8e5b62940597dfa280</anchor>
      <arglist>(FooDataReader *self, struct FooSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, DDS_ReadCondition *condition)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooDataReader_take_w_condition</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga5340c4c0e6b32c31d36688636c064657</anchor>
      <arglist>(FooDataReader *self, FooSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, DDS_ReadCondition *condition)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooDataReader_read_next_sample</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gacf50e7b4ea6b82cf688bd96df1dd5ab4</anchor>
      <arglist>(FooDataReader *self, struct Foo *received_data, struct DDS_SampleInfo *sample_info)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooDataReader_take_next_sample</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gac5f37ece5465c3e64077e8191c328d87</anchor>
      <arglist>(FooDataReader *self, struct Foo *received_data, struct DDS_SampleInfo *sample_info)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooDataReader_read_instance</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga0c41d6ff208c71f13ff7593d32c50a56</anchor>
      <arglist>(FooDataReader *self, struct FooSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, const DDS_InstanceHandle_t *a_handle, DDS_SampleStateMask sample_states, DDS_ViewStateMask view_states, DDS_InstanceStateMask instance_states)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooDataReader_take_instance</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gaab2b14c7a98d1cabdc446b543161668c</anchor>
      <arglist>(FooDataReader *self, struct FooSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, const DDS_InstanceHandle_t *a_handle, DDS_SampleStateMask sample_states, DDS_ViewStateMask view_states, DDS_InstanceStateMask instance_states)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooDataReader_read_instance_w_condition</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga404ce36a7c67a75702d92a29a44039b1</anchor>
      <arglist>(FooDataReader *self, struct FooSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, const DDS_InstanceHandle_t *a_handle, DDS_ReadCondition *condition)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooDataReader_take_instance_w_condition</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gad16b635d874f45e81db59325b280c6fb</anchor>
      <arglist>(FooDataReader *self, struct FooSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, const DDS_InstanceHandle_t *a_handle, DDS_ReadCondition *condition)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooDataReader_read_next_instance</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga010154c1c20c87500b6068d65c16cdd9</anchor>
      <arglist>(FooDataReader *self, struct FooSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, const DDS_InstanceHandle_t *previous_handle, DDS_SampleStateMask sample_states, DDS_ViewStateMask view_states, DDS_InstanceStateMask instance_states)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooDataReader_take_next_instance</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga08724909c0ad0d49f60956f358134adf</anchor>
      <arglist>(FooDataReader *self, struct FooSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, const DDS_InstanceHandle_t *previous_handle, DDS_SampleStateMask sample_states, DDS_ViewStateMask view_states, DDS_InstanceStateMask instance_states)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooDataReader_read_next_instance_w_condition</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga55910a020e513e170ec432db8eda4899</anchor>
      <arglist>(FooDataReader *self, struct FooSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, const DDS_InstanceHandle_t *previous_handle, DDS_ReadCondition *condition)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooDataReader_take_next_instance_w_condition</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gab7d499fba202bd3613c705d53c034a1c</anchor>
      <arglist>(FooDataReader *self, struct FooSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, const DDS_InstanceHandle_t *previous_handle, DDS_ReadCondition *condition)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooDataReader_return_loan</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gadf2188ce7cd1b7bed39451833b91f1f6</anchor>
      <arglist>(FooDataReader *self, FooSeq *received_data, struct DDS_SampleInfoSeq *info_seq)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooDataReader_get_key_value</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga434a5530ff95ee21227e5643273a85d4</anchor>
      <arglist>(FooDataReader *self, Foo *key_holder, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_InstanceHandle_t</type>
      <name>FooDataReader_lookup_instance</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga2fd320620045206555b1205574e20424</anchor>
      <arglist>(FooDataReader *self, const Foo *key_holder)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_RequestedDeadlineMissedStatus_initialize</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gae42864b6d0bba9133c02edb8499bebc7</anchor>
      <arglist>(struct DDS_RequestedDeadlineMissedStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_RequestedDeadlineMissedStatus_copy</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga24e09cac0e2af80edb94b57272196619</anchor>
      <arglist>(struct DDS_RequestedDeadlineMissedStatus *self, const struct DDS_RequestedDeadlineMissedStatus *source)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_RequestedDeadlineMissedStatus_finalize</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gab3fba000e337f5b1b3a7aa3eebb0e01d</anchor>
      <arglist>(struct DDS_RequestedDeadlineMissedStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_LivelinessChangedStatus_initialize</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga5271a563774a9f2a72809b3735405cd8</anchor>
      <arglist>(struct DDS_LivelinessChangedStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_LivelinessChangedStatus_copy</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gaf2e560fe3c0dc385b8f051e39a3b8369</anchor>
      <arglist>(struct DDS_LivelinessChangedStatus *self, const struct DDS_LivelinessChangedStatus *source)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_LivelinessChangedStatus_finalize</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gaab27cc8ce42069622afae27f49b373e0</anchor>
      <arglist>(struct DDS_LivelinessChangedStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_RequestedIncompatibleQosStatus_initialize</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga420c632bdc10f20b21a9c9ba9ae3b0e8</anchor>
      <arglist>(struct DDS_RequestedIncompatibleQosStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_RequestedIncompatibleQosStatus_copy</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga683ac618feceb34ab55fe7893c1cc18d</anchor>
      <arglist>(struct DDS_RequestedIncompatibleQosStatus *self, const struct DDS_RequestedIncompatibleQosStatus *source)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_RequestedIncompatibleQosStatus_finalize</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gaab52ada6e4480cd8d1b296baa2c64ad9</anchor>
      <arglist>(struct DDS_RequestedIncompatibleQosStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_SampleLostStatus_initialize</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gaad9f77fd4d243ffa3c459aa8c436b8ff</anchor>
      <arglist>(struct DDS_SampleLostStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_SampleLostStatus_copy</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gaaeb526d90fdc6fe5dd3e2d7c20868a2a</anchor>
      <arglist>(struct DDS_SampleLostStatus *self, const struct DDS_SampleLostStatus *source)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_SampleLostStatus_finalize</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga757dc31c9b9344362cd483f6b3790384</anchor>
      <arglist>(struct DDS_SampleLostStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_SampleRejectedStatus_initialize</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gaa8b8755d6dc935138cc715d5b975202d</anchor>
      <arglist>(struct DDS_SampleRejectedStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_SampleRejectedStatus_copy</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga43f3b0fd14443908d67fda7b45d8ea5e</anchor>
      <arglist>(struct DDS_SampleRejectedStatus *self, const struct DDS_SampleRejectedStatus *source)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_SampleRejectedStatus_finalize</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga8f324b1b1b20b914cb0c8422e1003ae9</anchor>
      <arglist>(struct DDS_SampleRejectedStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_SubscriptionMatchedStatus_initialize</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga54fc534d7b91199b73430c2d43ac1755</anchor>
      <arglist>(struct DDS_SubscriptionMatchedStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_SubscriptionMatchedStatus_copy</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga107f1a93f438655b3a01196a8359a21f</anchor>
      <arglist>(struct DDS_SubscriptionMatchedStatus *self, const struct DDS_SubscriptionMatchedStatus *source)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_SubscriptionMatchedStatus_finalize</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gae97dae72e3d6f58afd3f6a058bb73b66</anchor>
      <arglist>(struct DDS_SubscriptionMatchedStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReaderCacheStatus_initialize</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gad9c14b59e151d9dbdbf940cdc7804bee</anchor>
      <arglist>(struct DDS_DataReaderCacheStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReaderCacheStatus_copy</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gab70f6bd2a67e9eee11643bfad487ed52</anchor>
      <arglist>(struct DDS_DataReaderCacheStatus *self, const struct DDS_DataReaderCacheStatus *source)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReaderCacheStatus_finalize</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga45a17706bc1673a4d90a7b190301bd9c</anchor>
      <arglist>(struct DDS_DataReaderCacheStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReaderProtocolStatus_initialize</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gad81b4ada2f2c61fb2a6130951b400400</anchor>
      <arglist>(struct DDS_DataReaderProtocolStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReaderProtocolStatus_copy</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gac510a168ae4aa5b0dda50839f4506b53</anchor>
      <arglist>(struct DDS_DataReaderProtocolStatus *self, const struct DDS_DataReaderProtocolStatus *source)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReaderProtocolStatus_finalize</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga418d64947735d8dfd8000d9bcaa7b982</anchor>
      <arglist>(struct DDS_DataReaderProtocolStatus *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_DataReaderQos_equals</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gab31248e90a8e3e031540a62dc991f424</anchor>
      <arglist>(const struct DDS_DataReaderQos *self, const struct DDS_DataReaderQos *other)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReaderQos_initialize</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga45e821e20642157dc567e18dc7a63346</anchor>
      <arglist>(struct DDS_DataReaderQos *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReaderQos_copy</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gaca08c0dd978d76072b4bbfab89299f83</anchor>
      <arglist>(struct DDS_DataReaderQos *self, const struct DDS_DataReaderQos *source)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReaderQos_finalize</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga09dfd320506e72b6236c939caba93887</anchor>
      <arglist>(struct DDS_DataReaderQos *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Entity *</type>
      <name>DDS_DataReader_as_entity</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga6f5ee779d32b78d5255ca41ae3b521ec</anchor>
      <arglist>(DDS_DataReader *dataReader)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReadCondition *</type>
      <name>DDS_DataReader_create_readcondition</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gab6e48531c43261208a355211da9395e0</anchor>
      <arglist>(DDS_DataReader *self, DDS_SampleStateMask sample_states, DDS_ViewStateMask view_states, DDS_InstanceStateMask instance_states)</arglist>
    </member>
    <member kind="function">
      <type>DDS_QueryCondition *</type>
      <name>DDS_DataReader_create_querycondition</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gadc22d119a497a8e2359f6cb2ebcfd0fd</anchor>
      <arglist>(DDS_DataReader *self, DDS_SampleStateMask sample_states, DDS_ViewStateMask view_states, DDS_InstanceStateMask instance_states, const char *query_expression, const struct DDS_StringSeq *query_parameters)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReader_delete_readcondition</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga47b1ae37d4e2eb9070f8df5b5aa1446b</anchor>
      <arglist>(DDS_DataReader *self, DDS_ReadCondition *condition)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReader_delete_contained_entities</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga605cd53958cf2919c345c76259123650</anchor>
      <arglist>(DDS_DataReader *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReader_wait_for_historical_data</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gab116e48bb072f448fbf531bf9fd98cc8</anchor>
      <arglist>(DDS_DataReader *self, const struct DDS_Duration_t *max_wait)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReader_acknowledge_sample_w_response</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gae2117c288ee652696be268cad4931b4b</anchor>
      <arglist>(DDS_DataReader *self, const struct DDS_SampleInfo *sample_info, const struct DDS_AckResponseData_t *response_data)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReader_acknowledge_all_w_response</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga5ce922a98455ffb9dd25a95ed29f1f8f</anchor>
      <arglist>(DDS_DataReader *self, const struct DDS_AckResponseData_t *response_data)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReader_acknowledge_sample</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga0b7f1b1f22a95d3292c85ea3babfeb62</anchor>
      <arglist>(DDS_DataReader *self, const struct DDS_SampleInfo *sample_info)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReader_acknowledge_all</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga5e92cfc011f888dd4c03c0a6883a0de7</anchor>
      <arglist>(DDS_DataReader *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReader_get_matched_publications</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gac2b1864f15a7ffa34859e6eff826c499</anchor>
      <arglist>(DDS_DataReader *self, struct DDS_InstanceHandleSeq *publication_handles)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReader_get_matched_publication_data</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga7403be049e90ede89f8a8c1b3a5f4e06</anchor>
      <arglist>(DDS_DataReader *self, struct DDS_PublicationBuiltinTopicData *publication_data, const DDS_InstanceHandle_t *publication_handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReader_get_matched_publication_participant_data</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga2c2a5ee697d6c73a68196a566708abeb</anchor>
      <arglist>(DDS_DataReader *self, struct DDS_ParticipantBuiltinTopicData *participant_data, const DDS_InstanceHandle_t *publication_handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_TopicDescription *</type>
      <name>DDS_DataReader_get_topicdescription</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga098faba88f06eb848d0229a37cc608e9</anchor>
      <arglist>(DDS_DataReader *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Subscriber *</type>
      <name>DDS_DataReader_get_subscriber</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga87dc984879b87f0271016e826b26ee31</anchor>
      <arglist>(DDS_DataReader *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReader_get_sample_rejected_status</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gac1a7bcba6875d06440998cf577e8aec4</anchor>
      <arglist>(DDS_DataReader *self, struct DDS_SampleRejectedStatus *status)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReader_get_liveliness_changed_status</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gaceda17acaead9acca331d3902f8da17c</anchor>
      <arglist>(DDS_DataReader *self, struct DDS_LivelinessChangedStatus *status)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReader_get_requested_deadline_missed_status</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gad02eeca6be023a820a682dd1f93b9d3d</anchor>
      <arglist>(DDS_DataReader *self, struct DDS_RequestedDeadlineMissedStatus *status)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReader_get_requested_incompatible_qos_status</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga590d7b383341749ed2b819252c89c945</anchor>
      <arglist>(DDS_DataReader *self, struct DDS_RequestedIncompatibleQosStatus *status)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReader_get_subscription_matched_status</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gab74b4f6cabb251f17587cd57a42139e3</anchor>
      <arglist>(DDS_DataReader *self, struct DDS_SubscriptionMatchedStatus *status)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReader_get_sample_lost_status</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gaef247058f61fe47bcb621fd33bf98d83</anchor>
      <arglist>(DDS_DataReader *self, struct DDS_SampleLostStatus *status)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReader_get_datareader_cache_status</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga93a94e1fd1aafc39f3c7e806d1d10f0f</anchor>
      <arglist>(DDS_DataReader *self, struct DDS_DataReaderCacheStatus *status)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReader_get_datareader_protocol_status</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gac7a347d2add85ece49739512970972c8</anchor>
      <arglist>(DDS_DataReader *self, struct DDS_DataReaderProtocolStatus *status)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReader_get_matched_publication_datareader_protocol_status</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga91424a08c0885e7e82802b8f0f59d552</anchor>
      <arglist>(DDS_DataReader *self, struct DDS_DataReaderProtocolStatus *status, const DDS_InstanceHandle_t *publication_handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReader_set_qos</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gac6edf6c1cb03f06c3647ee838b279de8</anchor>
      <arglist>(DDS_DataReader *self, const struct DDS_DataReaderQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReader_set_qos_with_profile</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga82d9dd690919ee72be4c26d59e66a567</anchor>
      <arglist>(DDS_DataReader *self, const char *library_name, const char *profile_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReader_get_qos</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gae5b1cfff484564089701bc91eb3edafe</anchor>
      <arglist>(DDS_DataReader *self, struct DDS_DataReaderQos *qos)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReader_set_listener</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga6af5ac237d6c16988546befcbbc53a27</anchor>
      <arglist>(DDS_DataReader *self, const struct DDS_DataReaderListener *l, DDS_StatusMask mask)</arglist>
    </member>
    <member kind="function">
      <type>struct DDS_DataReaderListener</type>
      <name>DDS_DataReader_get_listener</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>gade4c138c7861e56d4fd03372031c9ae3</anchor>
      <arglist>(DDS_DataReader *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_DataReader_get_listenerX</name>
      <anchorfile>group__DDSReaderModule.html</anchorfile>
      <anchor>ga39c40a4095755948fc68b0cb906dd5dd</anchor>
      <arglist>(DDS_DataReader *self, struct DDS_DataReaderListener *listener)</arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSReadConditionModule</name>
    <title>Read Conditions</title>
    <filename>group__DDSReadConditionModule.html</filename>
    <member kind="typedef">
      <type>struct DDS_ReadConditionImpl</type>
      <name>DDS_ReadCondition</name>
      <anchorfile>group__DDSReadConditionModule.html</anchorfile>
      <anchor>ga5386f18823c58c65c1293b0ac89dd9ba</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>DDS_Condition *</type>
      <name>DDS_ReadCondition_as_condition</name>
      <anchorfile>group__DDSReadConditionModule.html</anchorfile>
      <anchor>gaea2e4461bc6d20134b429a8f18d8fa54</anchor>
      <arglist>(DDS_ReadCondition *read_condition)</arglist>
    </member>
    <member kind="function">
      <type>DDS_SampleStateMask</type>
      <name>DDS_ReadCondition_get_sample_state_mask</name>
      <anchorfile>group__DDSReadConditionModule.html</anchorfile>
      <anchor>gaf3bda3fe20d6235e66f3544a5bd4f074</anchor>
      <arglist>(DDS_ReadCondition *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ViewStateMask</type>
      <name>DDS_ReadCondition_get_view_state_mask</name>
      <anchorfile>group__DDSReadConditionModule.html</anchorfile>
      <anchor>ga2635f7f0a49c27d085ff7748ae5766b4</anchor>
      <arglist>(DDS_ReadCondition *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_InstanceStateMask</type>
      <name>DDS_ReadCondition_get_instance_state_mask</name>
      <anchorfile>group__DDSReadConditionModule.html</anchorfile>
      <anchor>gab40a5de723afd7a5b9b26ca0245ac1f8</anchor>
      <arglist>(DDS_ReadCondition *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DataReader *</type>
      <name>DDS_ReadCondition_get_datareader</name>
      <anchorfile>group__DDSReadConditionModule.html</anchorfile>
      <anchor>ga1fe233205526615959eef6e54b3f1133</anchor>
      <arglist>(DDS_ReadCondition *self)</arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSQueryConditionModule</name>
    <title>Query Conditions</title>
    <filename>group__DDSQueryConditionModule.html</filename>
    <member kind="typedef">
      <type>struct DDS_QueryConditionImpl</type>
      <name>DDS_QueryCondition</name>
      <anchorfile>group__DDSQueryConditionModule.html</anchorfile>
      <anchor>ga51ec811e0c2d583015ac7d5a4cd4d843</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>DDS_ReadCondition *</type>
      <name>DDS_QueryCondition_as_readcondition</name>
      <anchorfile>group__DDSQueryConditionModule.html</anchorfile>
      <anchor>ga2a6b33138d54e0328ff060caca5d2c78</anchor>
      <arglist>(DDS_QueryCondition *query_condition)</arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>DDS_QueryCondition_get_query_expression</name>
      <anchorfile>group__DDSQueryConditionModule.html</anchorfile>
      <anchor>ga40bdde058440ce5ef067c1487240a667</anchor>
      <arglist>(DDS_QueryCondition *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_QueryCondition_get_query_parameters</name>
      <anchorfile>group__DDSQueryConditionModule.html</anchorfile>
      <anchor>gac6b1cfc267ac58b34fd4161ee42e4d10</anchor>
      <arglist>(DDS_QueryCondition *self, struct DDS_StringSeq *query_parameters)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_QueryCondition_set_query_parameters</name>
      <anchorfile>group__DDSQueryConditionModule.html</anchorfile>
      <anchor>ga68063df18ddf6c89968f01c195cd763c</anchor>
      <arglist>(DDS_QueryCondition *self, const struct DDS_StringSeq *query_parameters)</arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSDataSampleModule</name>
    <title>Data Samples</title>
    <filename>group__DDSDataSampleModule.html</filename>
    <subgroup>DDSSampleStateModule</subgroup>
    <subgroup>DDSViewStateModule</subgroup>
    <subgroup>DDSInstanceStateModule</subgroup>
    <class kind="struct">DDS_SampleInfo</class>
    <class kind="struct">DDS_SampleInfoSeq</class>
    <member kind="function">
      <type>void</type>
      <name>DDS_SampleInfo_get_sample_identity</name>
      <anchorfile>group__DDSDataSampleModule.html</anchorfile>
      <anchor>ga40ea3fb738ce1484de028939511df773</anchor>
      <arglist>(const struct DDS_SampleInfo *self, struct DDS_SampleIdentity_t *identity)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>DDS_SampleInfo_get_related_sample_identity</name>
      <anchorfile>group__DDSDataSampleModule.html</anchorfile>
      <anchor>gaace467875b6161c56c5e511f35a4ae16</anchor>
      <arglist>(const struct DDS_SampleInfo *self, struct DDS_SampleIdentity_t *related_identity)</arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSSampleStateModule</name>
    <title>Sample States</title>
    <filename>group__DDSSampleStateModule.html</filename>
    <member kind="typedef">
      <type>DDS_UnsignedLong</type>
      <name>DDS_SampleStateMask</name>
      <anchorfile>group__DDSSampleStateModule.html</anchorfile>
      <anchor>ga00cf17a2dec95fc16ffd02c57ef356f5</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumeration">
      <name>DDS_SampleStateKind</name>
      <anchorfile>group__DDSSampleStateModule.html</anchorfile>
      <anchor>gadb6d36e7c796da27519b6bf7f8f187e5</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_READ_SAMPLE_STATE</name>
      <anchorfile>group__DDSSampleStateModule.html</anchorfile>
      <anchor>ggadb6d36e7c796da27519b6bf7f8f187e5a4435d5fd0a36806ebd1c67210345a70b</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_NOT_READ_SAMPLE_STATE</name>
      <anchorfile>group__DDSSampleStateModule.html</anchorfile>
      <anchor>ggadb6d36e7c796da27519b6bf7f8f187e5a2a3ec923ec261c0c5e50141223f20ee0</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const DDS_SampleStateMask</type>
      <name>DDS_ANY_SAMPLE_STATE</name>
      <anchorfile>group__DDSSampleStateModule.html</anchorfile>
      <anchor>ga11d38d04270435d289d164f223e12ae8</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSViewStateModule</name>
    <title>View States</title>
    <filename>group__DDSViewStateModule.html</filename>
    <member kind="typedef">
      <type>DDS_UnsignedLong</type>
      <name>DDS_ViewStateMask</name>
      <anchorfile>group__DDSViewStateModule.html</anchorfile>
      <anchor>gac6c18247f611af71486839446604e18c</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumeration">
      <name>DDS_ViewStateKind</name>
      <anchorfile>group__DDSViewStateModule.html</anchorfile>
      <anchor>gab7a8a4ae44a2c00f411a4461135b45f1</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_NEW_VIEW_STATE</name>
      <anchorfile>group__DDSViewStateModule.html</anchorfile>
      <anchor>ggab7a8a4ae44a2c00f411a4461135b45f1aa16318472ac7f2368d08c969c0e6efef</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_NOT_NEW_VIEW_STATE</name>
      <anchorfile>group__DDSViewStateModule.html</anchorfile>
      <anchor>ggab7a8a4ae44a2c00f411a4461135b45f1ad0a3502068e5e66e20a873a0aaa881be</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const DDS_ViewStateMask</type>
      <name>DDS_ANY_VIEW_STATE</name>
      <anchorfile>group__DDSViewStateModule.html</anchorfile>
      <anchor>ga5b8ea06fe00397fcbd7b7e1e48631bfb</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSInstanceStateModule</name>
    <title>Instance States</title>
    <filename>group__DDSInstanceStateModule.html</filename>
    <member kind="typedef">
      <type>DDS_UnsignedLong</type>
      <name>DDS_InstanceStateMask</name>
      <anchorfile>group__DDSInstanceStateModule.html</anchorfile>
      <anchor>ga4ded4022b3281636f4fbee19aab2844f</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumeration">
      <name>DDS_InstanceStateKind</name>
      <anchorfile>group__DDSInstanceStateModule.html</anchorfile>
      <anchor>gaf2264cae1aa8cd66490debfdc5e0c360</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_ALIVE_INSTANCE_STATE</name>
      <anchorfile>group__DDSInstanceStateModule.html</anchorfile>
      <anchor>ggaf2264cae1aa8cd66490debfdc5e0c360a093477a56893c9f6e94fb620a52e06c3</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_NOT_ALIVE_DISPOSED_INSTANCE_STATE</name>
      <anchorfile>group__DDSInstanceStateModule.html</anchorfile>
      <anchor>ggaf2264cae1aa8cd66490debfdc5e0c360a51e7b0651e135e656327002e41787dbf</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_NOT_ALIVE_NO_WRITERS_INSTANCE_STATE</name>
      <anchorfile>group__DDSInstanceStateModule.html</anchorfile>
      <anchor>ggaf2264cae1aa8cd66490debfdc5e0c360a72ebdc6f53c9a7588458b48e3ea66507</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const DDS_InstanceStateMask</type>
      <name>DDS_ANY_INSTANCE_STATE</name>
      <anchorfile>group__DDSInstanceStateModule.html</anchorfile>
      <anchor>gac3192dece9f811c8660bc108cb392642</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const DDS_InstanceStateMask</type>
      <name>DDS_NOT_ALIVE_INSTANCE_STATE</name>
      <anchorfile>group__DDSInstanceStateModule.html</anchorfile>
      <anchor>gacd85e2aea1217b1037c221f917902827</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSInfrastructureModule</name>
    <title>Infrastructure Module</title>
    <filename>group__DDSInfrastructureModule.html</filename>
    <subgroup>NDDSClockSelectionModule</subgroup>
    <subgroup>DDSTimeSupportModule</subgroup>
    <subgroup>DDSGUIDSupportModule</subgroup>
    <subgroup>DDSSequenceNumberSupportModule</subgroup>
    <subgroup>DDSExceptionTypesModule</subgroup>
    <subgroup>DDSReturnTypesModule</subgroup>
    <subgroup>DDSStatusTypesModule</subgroup>
    <subgroup>DDSQosTypesModule</subgroup>
    <subgroup>DDSEntityModule</subgroup>
    <subgroup>DDSConditionsModule</subgroup>
    <subgroup>DDSCookieModule</subgroup>
    <subgroup>DDSWriteParamsModule</subgroup>
    <subgroup>DDSHeapClass</subgroup>
    <subgroup>DDSBuiltinQosProfilesModule</subgroup>
    <subgroup>DDSOctetBufferClass</subgroup>
    <subgroup>DDSSequenceModule</subgroup>
    <subgroup>DDSStringClass</subgroup>
  </compound>
  <compound kind="group">
    <name>DDSBuiltinSequenceModule</name>
    <title>Built-in Sequences</title>
    <filename>group__DDSBuiltinSequenceModule.html</filename>
    <class kind="struct">DDS_CharSeq</class>
    <class kind="struct">DDS_WcharSeq</class>
    <class kind="struct">DDS_OctetSeq</class>
    <class kind="struct">DDS_ShortSeq</class>
    <class kind="struct">DDS_UnsignedShortSeq</class>
    <class kind="struct">DDS_LongSeq</class>
    <class kind="struct">DDS_UnsignedLongSeq</class>
    <class kind="struct">DDS_LongLongSeq</class>
    <class kind="struct">DDS_UnsignedLongLongSeq</class>
    <class kind="struct">DDS_FloatSeq</class>
    <class kind="struct">DDS_DoubleSeq</class>
    <class kind="struct">DDS_LongDoubleSeq</class>
    <class kind="struct">DDS_BooleanSeq</class>
    <class kind="struct">DDS_StringSeq</class>
    <class kind="struct">DDS_WstringSeq</class>
  </compound>
  <compound kind="group">
    <name>NDDSMultichannelConfigurationModule</name>
    <title>Multi-channel DataWriters</title>
    <filename>group__NDDSMultichannelConfigurationModule.html</filename>
    <docanchor file="group__NDDSMultichannelConfigurationModule">MultiChannelDataWriter</docanchor>
    <docanchor file="group__NDDSMultichannelConfigurationModule">MultiChannelDataWriterWriterConfiguration</docanchor>
    <docanchor file="group__NDDSMultichannelConfigurationModule">MultiChannelDataWriterReaderConfiguration</docanchor>
    <docanchor file="group__NDDSMultichannelConfigurationModule">MultiChannelDataWriterReliability</docanchor>
    <docanchor file="group__NDDSMultichannelConfigurationModule">MultiChannelDataWriterReliableDelivery</docanchor>
    <docanchor file="group__NDDSMultichannelConfigurationModule">MultiChannelDataWriterReliableProtocol</docanchor>
  </compound>
  <compound kind="group">
    <name>NDDSTransportModule</name>
    <title>Pluggable Transports</title>
    <filename>group__NDDSTransportModule.html</filename>
    <subgroup>NDDSTransportUserModule</subgroup>
    <subgroup>NDDS_TransportBuiltinsComponent</subgroup>
    <subgroup>NDDS_Transport_ClassId_t</subgroup>
    <subgroup>NDDS_Transport_Address_t</subgroup>
    <subgroup>NDDS_Transport_Property_t</subgroup>
    <docanchor file="group__NDDSTransportModule">NDDSTransportModule_overview</docanchor>
    <docanchor file="group__NDDSTransportModule">NDDSTransportModule_aliases</docanchor>
    <docanchor file="group__NDDSTransportModule">NDDSTransportModule_lifecycle</docanchor>
    <docanchor file="group__NDDSTransportModule">NDDSTransportModule_class_attributes</docanchor>
    <docanchor file="group__NDDSTransportModule">NDDSTransportModule_instance_attributes</docanchor>
    <docanchor file="group__NDDSTransportModule">NDDSTransportModule_net_address</docanchor>
    <docanchor file="group__NDDSTransportModule">NDDSTransportModule_send_route</docanchor>
    <docanchor file="group__NDDSTransportModule">NDDSTransportModule_send_route_table</docanchor>
    <docanchor file="group__NDDSTransportModule">NDDSTransportModule_recv_route</docanchor>
    <docanchor file="group__NDDSTransportModule">NDDSTransportModule_receive_route_table</docanchor>
  </compound>
  <compound kind="group">
    <name>NDDSTransportUserModule</name>
    <title>Using Transport Plugins</title>
    <filename>group__NDDSTransportUserModule.html</filename>
    <class kind="struct">NDDS_Transport_Support</class>
    <member kind="typedef">
      <type>NDDS_TRANSPORT_HANDLE_TYPE_NATIVE</type>
      <name>NDDS_Transport_Handle_t</name>
      <anchorfile>group__NDDSTransportUserModule.html</anchorfile>
      <anchor>ga813e01b7907c1a1a89a46f2c422c513c</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>NDDS_Transport_Plugin *(*</type>
      <name>NDDS_Transport_create_plugin</name>
      <anchorfile>group__NDDSTransportUserModule.html</anchorfile>
      <anchor>gadc104003409a3caf403b254f58a04dc4</anchor>
      <arglist>)(NDDS_Transport_Address_t *default_network_address_out, const struct DDS_PropertyQosPolicy *property_in)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>NDDS_Transport_Handle_is_nil</name>
      <anchorfile>group__NDDSTransportUserModule.html</anchorfile>
      <anchor>ga20f6bc00d0424e6a52a13fc038879d96</anchor>
      <arglist>(const NDDS_Transport_Handle_t *self)</arglist>
    </member>
    <member kind="function">
      <type>*NDDS_Transport_Handle_t</type>
      <name>NDDS_Transport_Support_register_transport</name>
      <anchorfile>group__NDDSTransportUserModule.html</anchorfile>
      <anchor>gada514240ebbfb86d8c612fbc9c42fea8</anchor>
      <arglist>(DDS_DomainParticipant *participant_in, NDDS_Transport_Plugin *transport_in, const struct DDS_StringSeq *aliases_in, const NDDS_Transport_Address_t *network_address_in)</arglist>
    </member>
    <member kind="function">
      <type>NDDS_Transport_Handle_t</type>
      <name>NDDS_Transport_Support_lookup_transport</name>
      <anchorfile>group__NDDSTransportUserModule.html</anchorfile>
      <anchor>ga63a6dafdd20f94444313b24b847f4b39</anchor>
      <arglist>(DDS_DomainParticipant *participant_in, struct DDS_StringSeq *aliases_out, NDDS_Transport_Address_t *network_address_out, const NDDS_Transport_Plugin *transport_in)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>NDDS_Transport_Support_add_send_route</name>
      <anchorfile>group__NDDSTransportUserModule.html</anchorfile>
      <anchor>ga101fb07e561b700c075a1bc9bf343864</anchor>
      <arglist>(const NDDS_Transport_Handle_t *transport_handle_in, const NDDS_Transport_Address_t *address_range_in, DDS_Long address_range_bit_count_in)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>NDDS_Transport_Support_add_receive_route</name>
      <anchorfile>group__NDDSTransportUserModule.html</anchorfile>
      <anchor>gab627229924428724773b6fa2137fe031</anchor>
      <arglist>(const NDDS_Transport_Handle_t *transport_handle_in, const NDDS_Transport_Address_t *address_range_in, DDS_Long address_range_bit_count_in)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>NDDS_Transport_Support_get_builtin_transport_property</name>
      <anchorfile>group__NDDSTransportUserModule.html</anchorfile>
      <anchor>ga36fd3016cc42b12b6e611707273c13dc</anchor>
      <arglist>(DDS_DomainParticipant *participant_in, DDS_TransportBuiltinKind builtin_transport_kind_in, struct NDDS_Transport_Property_t *builtin_transport_property_inout)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>NDDS_Transport_Support_set_builtin_transport_property</name>
      <anchorfile>group__NDDSTransportUserModule.html</anchorfile>
      <anchor>ga7222b3167a2992001dacdc63bf2624ef</anchor>
      <arglist>(DDS_DomainParticipant *participant_in, DDS_TransportBuiltinKind builtin_transport_kind_in, const struct NDDS_Transport_Property_t *builtin_transport_property_in)</arglist>
    </member>
    <member kind="function">
      <type>NDDS_Transport_Plugin *</type>
      <name>NDDS_Transport_Support_get_transport_plugin</name>
      <anchorfile>group__NDDSTransportUserModule.html</anchorfile>
      <anchor>gabf37e996f30e08a9ebfb6dc87589ac85</anchor>
      <arglist>(DDS_DomainParticipant *participant_in, const char *alias_in)</arglist>
    </member>
    <member kind="variable">
      <type>const NDDS_Transport_Handle_t</type>
      <name>NDDS_TRANSPORT_HANDLE_NIL</name>
      <anchorfile>group__NDDSTransportUserModule.html</anchorfile>
      <anchor>ga5974d95978594b2aa24a893e03d2aa98</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="group__NDDSTransportUserModule">NDDSTransportLoadPluginModule</docanchor>
  </compound>
  <compound kind="group">
    <name>NDDS_TransportBuiltinsComponent</name>
    <title>Built-in Transport Plugins</title>
    <filename>group__NDDS__TransportBuiltinsComponent.html</filename>
    <subgroup>NDDS_Transport_Shmem_Plugin</subgroup>
    <subgroup>NDDS_Transport_UDPv4_Plugin</subgroup>
    <subgroup>NDDS_Transport_UDPv6_Plugin</subgroup>
  </compound>
  <compound kind="group">
    <name>DDSQueryAndFilterSyntaxModule</name>
    <title>Queries and Filters Syntax</title>
    <filename>group__DDSQueryAndFilterSyntaxModule.html</filename>
    <docanchor file="group__DDSQueryAndFilterSyntaxModule">query_and_filter_syntax</docanchor>
    <docanchor file="group__DDSQueryAndFilterSyntaxModule">sql_grammar_in_BNF</docanchor>
    <docanchor file="group__DDSQueryAndFilterSyntaxModule">token_expression</docanchor>
    <docanchor file="group__DDSQueryAndFilterSyntaxModule">string_parameters</docanchor>
    <docanchor file="group__DDSQueryAndFilterSyntaxModule">type_compatibility</docanchor>
    <docanchor file="group__DDSQueryAndFilterSyntaxModule">sql_extension</docanchor>
    <docanchor file="group__DDSQueryAndFilterSyntaxModule">query_and_filter_example</docanchor>
  </compound>
  <compound kind="group">
    <name>NDDSConfigModule</name>
    <title>Configuration Utilities</title>
    <filename>group__NDDSConfigModule.html</filename>
    <class kind="struct">NDDS_Config_LibraryVersion_t</class>
    <class kind="struct">NDDS_Config_Version_t</class>
    <class kind="struct">NDDS_Config_Logger</class>
    <class kind="struct">NDDS_Config_LogMessage</class>
    <class kind="struct">NDDS_Config_LoggerDevice</class>
    <member kind="typedef">
      <type>void(*</type>
      <name>NDDS_Config_LoggerDeviceWriteFnc</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>ga3fe154daafd28c79f03c14ee2fdf3d8d</anchor>
      <arglist>)(struct NDDS_Config_LoggerDevice *device, const struct NDDS_Config_LogMessage *message)</arglist>
    </member>
    <member kind="typedef">
      <type>void(*</type>
      <name>NDDS_Config_LoggerDeviceCloseFnc</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>ga847a5fb17450ddf3691c71300b280660</anchor>
      <arglist>)(struct NDDS_Config_LoggerDevice *device)</arglist>
    </member>
    <member kind="enumeration">
      <name>NDDS_Config_LogVerbosity</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>gab65f708dd2c1ed3c91a0a65f56a5519e</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>NDDS_CONFIG_LOG_VERBOSITY_SILENT</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>ggab65f708dd2c1ed3c91a0a65f56a5519eabb9aecd88fd517578288a43d8bfaee57</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>NDDS_CONFIG_LOG_VERBOSITY_ERROR</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>ggab65f708dd2c1ed3c91a0a65f56a5519eacd514c7f202a952b6e151a4115a6cccc</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>NDDS_CONFIG_LOG_VERBOSITY_WARNING</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>ggab65f708dd2c1ed3c91a0a65f56a5519ea63593b54ce38e6f8f32cd90e4c1f15ed</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>NDDS_CONFIG_LOG_VERBOSITY_STATUS_LOCAL</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>ggab65f708dd2c1ed3c91a0a65f56a5519ea4dbc4858512a642c6539510d4c1d1bcf</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>NDDS_CONFIG_LOG_VERBOSITY_STATUS_REMOTE</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>ggab65f708dd2c1ed3c91a0a65f56a5519ea34da00c0129930d5ae537047d3bc481c</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>NDDS_CONFIG_LOG_VERBOSITY_STATUS_ALL</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>ggab65f708dd2c1ed3c91a0a65f56a5519eaf5422b9910c7186c0f80bd2825a03b1a</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumeration">
      <name>NDDS_Config_LogLevel</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>ga0e1442a7921930bb66ba4781d5c14b8c</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>NDDS_CONFIG_LOG_LEVEL_ERROR</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>gga0e1442a7921930bb66ba4781d5c14b8cafd8590876039c1a17b1750bb7957b903</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>NDDS_CONFIG_LOG_LEVEL_WARNING</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>gga0e1442a7921930bb66ba4781d5c14b8ca5f43fca49117000dabf9f453af5df9ab</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>NDDS_CONFIG_LOG_LEVEL_STATUS_LOCAL</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>gga0e1442a7921930bb66ba4781d5c14b8cacdf19fc8e70a7294315e1ea810a8893e</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>NDDS_CONFIG_LOG_LEVEL_STATUS_REMOTE</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>gga0e1442a7921930bb66ba4781d5c14b8ca4bd6a71002ca87d4da7262d9c5599749</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>NDDS_CONFIG_LOG_LEVEL_DEBUG</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>gga0e1442a7921930bb66ba4781d5c14b8ca55c36c1d9cb4b85eba290165354d82be</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumeration">
      <name>NDDS_Config_LogCategory</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>ga0dc7a2e7732c84c86007758cc098f092</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>NDDS_CONFIG_LOG_CATEGORY_PLATFORM</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>gga0dc7a2e7732c84c86007758cc098f092a6bd61c22787d582f41b9f5ea8b93052e</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>NDDS_CONFIG_LOG_CATEGORY_COMMUNICATION</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>gga0dc7a2e7732c84c86007758cc098f092a60267c3774c038bae82502d01b177614</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>NDDS_CONFIG_LOG_CATEGORY_DATABASE</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>gga0dc7a2e7732c84c86007758cc098f092a4f8e07568702e7b7046fcad68cf820eb</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>NDDS_CONFIG_LOG_CATEGORY_ENTITIES</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>gga0dc7a2e7732c84c86007758cc098f092a9bf1375102ba65eb8bd25f7b8ad9d2fc</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>NDDS_CONFIG_LOG_CATEGORY_API</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>gga0dc7a2e7732c84c86007758cc098f092a7e071c90e86cbf28a61ab935f37f5364</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumeration">
      <name>NDDS_Config_LogPrintFormat</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>ga064329f9436dae5346b9af17c8dde1c2</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>NDDS_CONFIG_LOG_PRINT_FORMAT_DEFAULT</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>gga064329f9436dae5346b9af17c8dde1c2ac5c16a987c545e3b25f783dadb37de0a</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>NDDS_CONFIG_LOG_PRINT_FORMAT_TIMESTAMPED</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>gga064329f9436dae5346b9af17c8dde1c2a52c1aa5f777f01dc55238f42c30b4e21</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>NDDS_CONFIG_LOG_PRINT_FORMAT_VERBOSE</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>gga064329f9436dae5346b9af17c8dde1c2a550b13ac1000ca850969d3a8d79c7a7f</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>NDDS_CONFIG_LOG_PRINT_FORMAT_VERBOSE_TIMESTAMPED</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>gga064329f9436dae5346b9af17c8dde1c2a99caa67be6ae4885883be5753befcd5d</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>NDDS_CONFIG_LOG_PRINT_FORMAT_DEBUG</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>gga064329f9436dae5346b9af17c8dde1c2a8c4fb1d73d0059b64826fa77f39c5d66</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>NDDS_CONFIG_LOG_PRINT_FORMAT_MINIMAL</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>gga064329f9436dae5346b9af17c8dde1c2a23e6c263d416955a60597f29eac5a233</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>NDDS_CONFIG_LOG_PRINT_FORMAT_MAXIMAL</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>gga064329f9436dae5346b9af17c8dde1c2a24515c5ba769b2c01706a3fc7466919c</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>struct DDS_ProductVersion_t *</type>
      <name>NDDS_Config_Version_get_product_version</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>ga4368476d750d1a9d954b979ba53fd8d1</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>struct NDDS_Config_LibraryVersion_t *</type>
      <name>NDDS_Config_Version_get_api_version</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>gad988097c1875dbf0deeb86c44e07e1e5</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>struct NDDS_Config_LibraryVersion_t *</type>
      <name>NDDS_Config_Version_get_core_version</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>ga46cf91462d0030ca83815923a5641354</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>NDDS_Config_Version_to_string</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>gad54386fe3c3203f2607b3c00c6dd09ce</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>NDDS_Config_Logger *</type>
      <name>NDDS_Config_Logger_get_instance</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>ga6eb386b9eb14d20ec10bc45c631fadfe</anchor>
      <arglist>(void)</arglist>
    </member>
    <member kind="function">
      <type>NDDS_Config_LogVerbosity</type>
      <name>NDDS_Config_Logger_get_verbosity</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>ga414ce66330a90299d545e0918ed32f96</anchor>
      <arglist>(const NDDS_Config_Logger *self)</arglist>
    </member>
    <member kind="function">
      <type>NDDS_Config_LogVerbosity</type>
      <name>NDDS_Config_Logger_get_verbosity_by_category</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>ga2c7dda4992b6e4c2da1a82878fb40d3e</anchor>
      <arglist>(const NDDS_Config_Logger *self, NDDS_Config_LogCategory category)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>NDDS_Config_Logger_set_verbosity</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>gaad9e120cc80ece95087292a3c29e9663</anchor>
      <arglist>(NDDS_Config_Logger *self, NDDS_Config_LogVerbosity verbosity)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>NDDS_Config_Logger_set_verbosity_by_category</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>ga4cca8830e9980e1d8debc493cae9fb1f</anchor>
      <arglist>(NDDS_Config_Logger *self, NDDS_Config_LogCategory category, NDDS_Config_LogVerbosity verbosity)</arglist>
    </member>
    <member kind="function">
      <type>FILE *</type>
      <name>NDDS_Config_Logger_get_output_file</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>ga6b4e54ddf5bb89edbdd22be66d927b85</anchor>
      <arglist>(NDDS_Config_Logger *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>NDDS_Config_Logger_set_output_file</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>gad75bda75af9bffdc946bd52d6b2e7128</anchor>
      <arglist>(NDDS_Config_Logger *self, FILE *out)</arglist>
    </member>
    <member kind="function">
      <type>NDDS_Config_LogPrintFormat</type>
      <name>NDDS_Config_Logger_get_print_format</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>ga5a3fda174de907dbec272fefee7aa22f</anchor>
      <arglist>(const NDDS_Config_Logger *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>NDDS_Config_Logger_set_print_format</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>ga10e8404356097ba8708417b17dea04a8</anchor>
      <arglist>(NDDS_Config_Logger *self, NDDS_Config_LogPrintFormat print_format)</arglist>
    </member>
    <member kind="function">
      <type>struct NDDS_Config_LoggerDevice *</type>
      <name>NDDS_Config_Logger_get_output_device</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>ga8b43781701da33f98b958b2b19ac3486</anchor>
      <arglist>(NDDS_Config_Logger *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>NDDS_Config_Logger_set_output_device</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>gab191974dff723d6ea25328ac12f0ca78</anchor>
      <arglist>(NDDS_Config_Logger *self, struct NDDS_Config_LoggerDevice *device)</arglist>
    </member>
    <member kind="variable">
      <type>NDDS_Config_LoggerDeviceWriteFnc</type>
      <name>write</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>gaf49e0a5c4d4bf2f01e7ae10d7d5033a2</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>NDDS_Config_LoggerDeviceCloseFnc</type>
      <name>close</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>ga74cd7f4f28f7ccc511152bcd4c0ecca9</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>NDDSUtilityModule</name>
    <title>Unsupported Utilities</title>
    <filename>group__NDDSUtilityModule.html</filename>
    <class kind="struct">NDDS_Utility</class>
    <member kind="function">
      <type>void</type>
      <name>NDDS_Utility_sleep</name>
      <anchorfile>group__NDDSUtilityModule.html</anchorfile>
      <anchor>ga0e6331a60c841725b0403843ba178482</anchor>
      <arglist>(const struct DDS_Duration_t *durationIn)</arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>RequestReplyModule</name>
    <title>Request-Reply Pattern</title>
    <filename>group__RequestReplyModule.html</filename>
    <subgroup>RequesterModule</subgroup>
    <subgroup>ReplierModule</subgroup>
  </compound>
  <compound kind="group">
    <name>RequesterModule</name>
    <title>Requester</title>
    <filename>group__RequesterModule.html</filename>
    <class kind="struct">RTI_Connext_Requester</class>
    <class kind="struct">RTI_Connext_RequesterParams</class>
    <class kind="struct">FooBarRequester</class>
    <member kind="define">
      <type>#define</type>
      <name>RTI_CONNEXT_REQUESTER_DECL</name>
      <anchorfile>group__RequesterModule.html</anchorfile>
      <anchor>ga07ce33bb2586d9c28f49cb2f5a1bc782</anchor>
      <arglist>(TReq, TRep, TRequester)</arglist>
    </member>
    <member kind="typedef">
      <type>struct RTI_Connext_RequesterParams</type>
      <name>RTI_Connext_RequesterParams</name>
      <anchorfile>group__RequesterModule.html</anchorfile>
      <anchor>ga5e892c023ab49de2d010b197a7bd2bf4</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct FooBarRequester</type>
      <name>FooBarRequester</name>
      <anchorfile>group__RequesterModule.html</anchorfile>
      <anchor>ga4b913b5ea836e0d7f659f3e491f08ee3</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>RTI_Connext_Requester_delete</name>
      <anchorfile>group__RequesterModule.html</anchorfile>
      <anchor>ga7189caef80a03e273d011bb4e505a976</anchor>
      <arglist>(RTI_Connext_Requester *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>RTI_Connext_Requester_wait_for_replies</name>
      <anchorfile>group__RequesterModule.html</anchorfile>
      <anchor>gab93c952d09913e578e69f94b5fffa4fd</anchor>
      <arglist>(RTI_Connext_Requester *self, DDS_Long min_count, const struct DDS_Duration_t *max_wait)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>RTI_Connext_Requester_wait_for_replies_for_related_request</name>
      <anchorfile>group__RequesterModule.html</anchorfile>
      <anchor>gacf48e1eaa044b5f38e7625ca166821a5</anchor>
      <arglist>(RTI_Connext_Requester *self, DDS_Long min_count, const struct DDS_Duration_t *max_wait, const struct DDS_SampleIdentity_t *related_request_id)</arglist>
    </member>
    <member kind="function">
      <type>FooBarRequester *</type>
      <name>FooBarRequester_create</name>
      <anchorfile>group__RequesterModule.html</anchorfile>
      <anchor>ga5197ec637cdbfa07595a50b109ec9af6</anchor>
      <arglist>(DDS_DomainParticipant *participant, const char *service_name)</arglist>
    </member>
    <member kind="function">
      <type>FooBarRequester *</type>
      <name>FooBarRequester_create_w_params</name>
      <anchorfile>group__RequesterModule.html</anchorfile>
      <anchor>ga05a551eb0e03edf91c1a472c5b9c6543</anchor>
      <arglist>(const RTI_Connext_RequesterParams *params)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooBarRequester_send_request</name>
      <anchorfile>group__RequesterModule.html</anchorfile>
      <anchor>ga84c4ac11bc314aff5fde3ee5d50f4c73</anchor>
      <arglist>(FooBarRequester *self, const Foo *request)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooBarRequester_send_request_w_params</name>
      <anchorfile>group__RequesterModule.html</anchorfile>
      <anchor>gaf52963ee07584dae287fd65ec13d314e</anchor>
      <arglist>(FooBarRequester *self, const Foo *request, struct DDS_WriteParams_t *request_info)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooBarRequester_receive_reply</name>
      <anchorfile>group__RequesterModule.html</anchorfile>
      <anchor>ga1b80d3520e6ed211c175a9152c17a010</anchor>
      <arglist>(FooBarRequester *self, Bar *reply, struct DDS_SampleInfo *sample_info, const struct DDS_Duration_t *max_wait)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooBarRequester_receive_replies</name>
      <anchorfile>group__RequesterModule.html</anchorfile>
      <anchor>ga45508b987a08eee5cfa201b210e21592</anchor>
      <arglist>(FooBarRequester *self, struct BarSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long min_count, DDS_Long max_count, const struct DDS_Duration_t *max_wait)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooBarRequester_take_reply</name>
      <anchorfile>group__RequesterModule.html</anchorfile>
      <anchor>ga2c584e08e13ea211ac5a0a3d577b854e</anchor>
      <arglist>(FooBarRequester *self, Bar *reply, struct DDS_SampleInfo *sample_info)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooBarRequester_take_replies</name>
      <anchorfile>group__RequesterModule.html</anchorfile>
      <anchor>ga0113762d064866262bc33b83c6623dc9</anchor>
      <arglist>(FooBarRequester *self, struct BarSeq *reply_seq, struct DDS_SampleInfoSeq *sample_info_seq, DDS_Long max_count)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooBarRequester_take_reply_for_related_request</name>
      <anchorfile>group__RequesterModule.html</anchorfile>
      <anchor>ga5b3e86170978cf7596c771b575232733</anchor>
      <arglist>(FooBarRequester *self, Bar *reply, struct DDS_SampleInfo *sample_info, const struct DDS_SampleIdentity_t *related_request_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooBarRequester_take_replies_for_related_request</name>
      <anchorfile>group__RequesterModule.html</anchorfile>
      <anchor>ga8b6741dc9b74d71990a73161265261b9</anchor>
      <arglist>(FooBarRequester *self, struct BarSeq *reply_seq, struct DDS_SampleInfoSeq *sample_info_seq, DDS_Long max_count, const struct DDS_SampleIdentity_t *related_request_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooBarRequester_read_reply</name>
      <anchorfile>group__RequesterModule.html</anchorfile>
      <anchor>ga98c612c8f79ac3c80a6360ef5a4b1092</anchor>
      <arglist>(FooBarRequester *self, Bar *reply, struct DDS_SampleInfo *sample_info)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooBarRequester_read_replies</name>
      <anchorfile>group__RequesterModule.html</anchorfile>
      <anchor>gab153527e96538d2c4d65c5c244d13726</anchor>
      <arglist>(FooBarRequester *self, struct BarSeq *reply_seq, struct DDS_SampleInfoSeq *sample_info_seq, DDS_Long max_count)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooBarRequester_read_reply_for_related_request</name>
      <anchorfile>group__RequesterModule.html</anchorfile>
      <anchor>gae15dee663fa04c3d58a4532d23817017</anchor>
      <arglist>(FooBarRequester *self, Bar *reply, struct DDS_SampleInfo *sample_info, const struct DDS_SampleIdentity_t *related_request_id)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooBarRequester_read_replies_for_related_request</name>
      <anchorfile>group__RequesterModule.html</anchorfile>
      <anchor>gaa4d7cd66170eaaae53eeb5668360526f</anchor>
      <arglist>(FooBarRequester *self, struct BarSeq *reply_seq, struct DDS_SampleInfoSeq *sample_info_seq, DDS_Long max_count, const struct DDS_SampleIdentity_t *related_request_id)</arglist>
    </member>
    <member kind="function">
      <type>FooDataWriter *</type>
      <name>FooBarRequester_get_request_datawriter</name>
      <anchorfile>group__RequesterModule.html</anchorfile>
      <anchor>ga063c23cffd2e791d304d48a783f05346</anchor>
      <arglist>(FooBarRequester *self)</arglist>
    </member>
    <member kind="function">
      <type>BarDataReader *</type>
      <name>FooBarRequester_get_reply_datareader</name>
      <anchorfile>group__RequesterModule.html</anchorfile>
      <anchor>ga9b24851a98fa2b910067135a43de1a9a</anchor>
      <arglist>(FooBarRequester *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooBarRequester_return_loan</name>
      <anchorfile>group__RequesterModule.html</anchorfile>
      <anchor>ga73f21c985d46ad5a8d3439a9b59e0150</anchor>
      <arglist>(FooBarRequester *self, struct BarSeq *received_data, struct DDS_SampleInfoSeq *info_seq)</arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>ReplierModule</name>
    <title>Replier</title>
    <filename>group__ReplierModule.html</filename>
    <class kind="struct">RTI_Connext_ReplierListener</class>
    <class kind="struct">RTI_Connext_SimpleReplierListener</class>
    <class kind="struct">RTI_Connext_Replier</class>
    <class kind="struct">RTI_Connext_ReplierParams</class>
    <class kind="struct">FooBarReplier</class>
    <class kind="struct">RTI_Connext_SimpleReplierParams</class>
    <class kind="struct">FooBarSimpleReplier</class>
    <member kind="define">
      <type>#define</type>
      <name>RTI_Connext_ReplierListener_INITIALIZER</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>ga2997b77372cadbcdbc5dd5f5ca81dc36</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>RTI_Connext_ReplierParams_INITIALIZER</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>ga60193126f3a77ea90acd5f5fb0788ebb</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>RTI_CONNEXT_REPLIER_DECL</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>gaf5e23b87624200a972faa66ff6f71217</anchor>
      <arglist>(TReq, TRep, TReplier)</arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>RTI_Connext_RequesterParams_INITIALIZER</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>ga3ea2d9842a93a8776f9bec9490e1bf9a</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>RTI_Connext_SimpleReplierParams_INITIALIZER</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>gab0707ebf53eacc689faf3bb95c012d0b</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>RTI_CONNEXT_SIMPLEREPLIER_DECL</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>gae840ec2d6f7a251b51d178158fb04267</anchor>
      <arglist>(TReq, TRep, TSimpleReplier)</arglist>
    </member>
    <member kind="typedef">
      <type>void(*</type>
      <name>RTI_Connext_ReplierListener_OnRequestAvailableCallback</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>ga7a07cbb067aa3783257ac507df580ef6</anchor>
      <arglist>)(struct RTI_Connext_ReplierListener *self, RTI_Connext_Replier *replier)</arglist>
    </member>
    <member kind="typedef">
      <type>void *(*</type>
      <name>RTI_Connext_SimpleReplierListener_OnRequestAvailableCallback</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>ga0b344e1da6ac32505d6a7aa8725f16a0</anchor>
      <arglist>)(RTI_Connext_SimpleReplierListener *self, const void *request, const struct DDS_SampleInfo *info)</arglist>
    </member>
    <member kind="typedef">
      <type>void(*</type>
      <name>RTI_Connext_SimpleReplierListener_OnReturnLoanCallback</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>ga506169a20df098375ecbc3814783fd1d</anchor>
      <arglist>)(RTI_Connext_SimpleReplierListener *self, void *reply)</arglist>
    </member>
    <member kind="typedef">
      <type>struct RTI_Connext_ReplierParams</type>
      <name>RTI_Connext_ReplierParams</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>ga851ea557e546c641e462c55f12826df3</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct FooBarReplier</type>
      <name>FooBarReplier</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>ga0e63f81892c6fec65b6ae7744d4203c2</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct RTI_Connext_SimpleReplierParams</type>
      <name>RTI_Connext_SimpleReplierParams</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>ga9fb9ce799ca32b8815bf2b904132b051</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct FooBarSimpleReplier</type>
      <name>FooBarSimpleReplier</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>ga07b14df744d2d9c0a2a544e87efec1e1</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>RTI_Connext_Replier_delete</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>gabb6e5a019ed54873ee0b2337e7a84b11</anchor>
      <arglist>(RTI_Connext_Replier *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>RTI_Connext_Replier_wait_for_requests</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>ga2f59d6464be817391d20389e76038a5b</anchor>
      <arglist>(RTI_Connext_Replier *self, int min_count, const struct DDS_Duration_t *max_wait)</arglist>
    </member>
    <member kind="function">
      <type>FooBarReplier *</type>
      <name>FooBarReplier_create</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>gac5c26623a6afa6f1d7bb176e6e007e5b</anchor>
      <arglist>(DDS_DomainParticipant *participant, char *service_name)</arglist>
    </member>
    <member kind="function">
      <type>FooBarReplier *</type>
      <name>FooBarReplier_create_w_params</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>ga76f6df8f4a1e150a29daa7bfc9c57b8b</anchor>
      <arglist>(const RTI_Connext_ReplierParams *params)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooBarReplier_receive_request</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>gaafb38ce9bee5b09aab20bacab7d55896</anchor>
      <arglist>(FooBarReplier *self, Foo *request, struct DDS_SampleInfo *sample_info, const struct DDS_Duration_t *max_wait)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooBarReplier_receive_requests</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>ga67e640df48e8fe99809c62e444bf1666</anchor>
      <arglist>(FooBarReplier *self, struct FooSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long min_reply_count, DDS_Long max_reply_count, const struct DDS_Duration_t *max_wait)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooBarReplier_take_request</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>gae37b245c8ebf34b5573fcc4094c1d85e</anchor>
      <arglist>(FooBarReplier *self, Foo *request, struct DDS_SampleInfo *sample_info)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooBarReplier_take_requests</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>gac4aaa076f4e7c2b680c781fbca89e114</anchor>
      <arglist>(FooBarReplier *self, struct FooSeq *request_seq, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_count)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooBarReplier_read_request</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>ga9537b124ef2aaaa2cf3b987ead68cd15</anchor>
      <arglist>(FooBarReplier *self, Foo *request, struct DDS_SampleInfo *sample_info)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooBarReplier_read_requests</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>ga38b6e2600c50593143db6327c4b0a9ee</anchor>
      <arglist>(FooBarReplier *self, struct FooSeq *request_seq, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_count)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooBarReplier_send_reply</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>ga4fbc35dbbedd526548dfdccdeb315f14</anchor>
      <arglist>(FooBarReplier *self, Bar *reply, const struct DDS_SampleIdentity_t *related_request_id)</arglist>
    </member>
    <member kind="function">
      <type>FooDataReader *</type>
      <name>FooBarReplier_get_request_datareader</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>ga65279f95c2b60e6afe7ec751ed16ff6f</anchor>
      <arglist>(FooBarReplier *self)</arglist>
    </member>
    <member kind="function">
      <type>BarDataWriter *</type>
      <name>FooBarReplier_get_reply_datawriter</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>ga44856b2d9a69827c28aac1437cca64f7</anchor>
      <arglist>(FooBarReplier *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooBarReplier_return_loan</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>gaa6f282bf4335f2e2359f7cd5ee287ee7</anchor>
      <arglist>(FooBarReplier *self, struct FooSeq *replies, struct DDS_SampleInfoSeq *info_seq)</arglist>
    </member>
    <member kind="function">
      <type>FooBarSimpleReplier *</type>
      <name>FooBarSimpleReplier_create</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>gaf637f8de00d659c51e906ad20ef05414</anchor>
      <arglist>(DDS_DomainParticipant *participant, char *service_name, RTI_Connext_SimpleReplierListener *listener)</arglist>
    </member>
    <member kind="function">
      <type>FooBarSimpleReplier *</type>
      <name>FooBarSimpleReplier_create_w_params</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>ga3d9cf08ec662b1f33500364e6f17c80c</anchor>
      <arglist>(RTI_Connext_SimpleReplierParams *params)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>FooBarSimpleReplier_delete</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>ga730c857ae27b0951bf30e11fd7c7af3d</anchor>
      <arglist>(FooBarSimpleReplier *self)</arglist>
    </member>
    <member kind="variable">
      <type>RTI_Connext_ReplierListener_OnRequestAvailableCallback</type>
      <name>on_request_available</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>ga1337016b6779eaa66a522b19274a420f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_Connext_SimpleReplierListener_OnRequestAvailableCallback</type>
      <name>on_request_available</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>gaeb2dda9701734c7777ca14935e6c1fdf</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_Connext_SimpleReplierListener_OnReturnLoanCallback</type>
      <name>return_loan</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>ga995246a733334af7cdfaccd1026f4e80</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>NDDSDurabilityAndPersistenceModule</name>
    <title>Durability and Persistence</title>
    <filename>group__NDDSDurabilityAndPersistenceModule.html</filename>
    <docanchor file="group__NDDSDurabilityAndPersistenceModule">NDDSDurableWriterHistory</docanchor>
    <docanchor file="group__NDDSDurabilityAndPersistenceModule">NDDSDurableReaderState</docanchor>
    <docanchor file="group__NDDSDurabilityAndPersistenceModule">NDDSDataDurability</docanchor>
    <docanchor file="group__NDDSDurabilityAndPersistenceModule">NDDSVirtualGuid</docanchor>
    <docanchor file="group__NDDSDurabilityAndPersistenceModule">NDDSDurableWriterConfiguration</docanchor>
    <docanchor file="group__NDDSDurabilityAndPersistenceModule">NDDSDurableReaderConfiguration</docanchor>
    <docanchor file="group__NDDSDurabilityAndPersistenceModule">NDDSDataDurabilityConfiguration</docanchor>
  </compound>
  <compound kind="group">
    <name>NDDSSystemPropertiesModule</name>
    <title>System Properties</title>
    <filename>group__NDDSSystemPropertiesModule.html</filename>
    <docanchor file="group__NDDSSystemPropertiesModule">NDDSSystemPropertiesList</docanchor>
    <docanchor file="group__NDDSSystemPropertiesModule">NDDSSystemPropertiesResources</docanchor>
  </compound>
  <compound kind="group">
    <name>NDDSXmlConfigurationModule</name>
    <title>Configuring QoS Profiles with XML</title>
    <filename>group__NDDSXmlConfigurationModule.html</filename>
    <docanchor file="group__NDDSXmlConfigurationModule">XMLResourceConfiguration</docanchor>
    <docanchor file="group__NDDSXmlConfigurationModule">XMLUrl</docanchor>
    <docanchor file="group__NDDSXmlConfigurationModule">XMLUrlGroups</docanchor>
    <docanchor file="group__NDDSXmlConfigurationModule">XMLEnvironmentVariable</docanchor>
    <docanchor file="group__NDDSXmlConfigurationModule">BuiltinQoSProfiles</docanchor>
  </compound>
  <compound kind="group">
    <name>DDSProducerExampleModule</name>
    <title>Publication Example</title>
    <filename>group__DDSProducerExampleModule.html</filename>
    <docanchor file="group__DDSProducerExampleModule">DDSProducerExampleModule_publication</docanchor>
  </compound>
  <compound kind="group">
    <name>DDSConsumerExampleModule</name>
    <title>Subscription Example</title>
    <filename>group__DDSConsumerExampleModule.html</filename>
    <docanchor file="group__DDSConsumerExampleModule">DDSConsumerExampleModule_subscription</docanchor>
  </compound>
  <compound kind="group">
    <name>DDSParticipantExampleModule</name>
    <title>Participant Use Cases</title>
    <filename>group__DDSParticipantExampleModule.html</filename>
    <docanchor file="group__DDSParticipantExampleModule">DDSParticipantExampleModule_no_autoenable</docanchor>
    <docanchor file="group__DDSParticipantExampleModule">DDSParticipantExampleModule_factory</docanchor>
    <docanchor file="group__DDSParticipantExampleModule">DDSParticipantExampleModule_setup</docanchor>
    <docanchor file="group__DDSParticipantExampleModule">DDSParticipantExampleModule_teardown</docanchor>
  </compound>
  <compound kind="group">
    <name>DDSTopicExampleModule</name>
    <title>Topic Use Cases</title>
    <filename>group__DDSTopicExampleModule.html</filename>
    <docanchor file="group__DDSTopicExampleModule">DDSTopicExampleModule_registertype</docanchor>
    <docanchor file="group__DDSTopicExampleModule">DDSTopicExampleModule_setup</docanchor>
    <docanchor file="group__DDSTopicExampleModule">DDSTopicExampleModule_teardown</docanchor>
  </compound>
  <compound kind="group">
    <name>DDSFlowControllerExampleModule</name>
    <title>FlowController Use Cases</title>
    <filename>group__DDSFlowControllerExampleModule.html</filename>
    <docanchor file="group__DDSFlowControllerExampleModule">DDSFlowControllerExampleModule_setup</docanchor>
    <docanchor file="group__DDSFlowControllerExampleModule">DDSFlowControllerExampleModule_using</docanchor>
    <docanchor file="group__DDSFlowControllerExampleModule">DDSFlowControllerExampleModule_builtin</docanchor>
    <docanchor file="group__DDSFlowControllerExampleModule">DDSFlowControllerExampleModule_trafficing</docanchor>
    <docanchor file="group__DDSFlowControllerExampleModule">DDSFlowControllerExampleModule_coalescing</docanchor>
  </compound>
  <compound kind="group">
    <name>DDSPublisherExampleModule</name>
    <title>Publisher Use Cases</title>
    <filename>group__DDSPublisherExampleModule.html</filename>
    <docanchor file="group__DDSPublisherExampleModule">DDSPublisherExampleModule_publisher_setup</docanchor>
    <docanchor file="group__DDSPublisherExampleModule">DDSPublisherExampleModule_publisher_teardown</docanchor>
  </compound>
  <compound kind="group">
    <name>DDSWriterExampleModule</name>
    <title>DataWriter Use Cases</title>
    <filename>group__DDSWriterExampleModule.html</filename>
    <docanchor file="group__DDSWriterExampleModule">DDSWriterExampleModule_writer_setup</docanchor>
    <docanchor file="group__DDSWriterExampleModule">DDSWriterExampleModule_writer_instances</docanchor>
    <docanchor file="group__DDSWriterExampleModule">DDSWriterExampleModule_send</docanchor>
    <docanchor file="group__DDSWriterExampleModule">DDSWriterExampleModule_writer_teardown</docanchor>
  </compound>
  <compound kind="group">
    <name>DDSSubscriberExampleModule</name>
    <title>Subscriber Use Cases</title>
    <filename>group__DDSSubscriberExampleModule.html</filename>
    <docanchor file="group__DDSSubscriberExampleModule">DDSSubscriberExampleModule_subscriber_setup</docanchor>
    <docanchor file="group__DDSSubscriberExampleModule">DDSSubscriberExampleModule_receive_setup</docanchor>
    <docanchor file="group__DDSSubscriberExampleModule">DDSSubscriberExampleModule_receive</docanchor>
    <docanchor file="group__DDSSubscriberExampleModule">DDSSubscriberExampleModule_receive_ordered</docanchor>
    <docanchor file="group__DDSSubscriberExampleModule">DDSSubscriberExampleModule_subscriber_teardown</docanchor>
  </compound>
  <compound kind="group">
    <name>DDSReaderExampleModule</name>
    <title>DataReader Use Cases</title>
    <filename>group__DDSReaderExampleModule.html</filename>
    <docanchor file="group__DDSReaderExampleModule">DDSReaderExampleModule_reader_setup</docanchor>
    <docanchor file="group__DDSReaderExampleModule">DDSReaderExampleModule_reader_instances</docanchor>
    <docanchor file="group__DDSReaderExampleModule">DDSReaderExampleModule_receive_setup</docanchor>
    <docanchor file="group__DDSReaderExampleModule">DDSReaderExampleModule_receive</docanchor>
    <docanchor file="group__DDSReaderExampleModule">DDSReaderExampleModule_reader_take</docanchor>
    <docanchor file="group__DDSReaderExampleModule">DDSReaderExampleModule_reader_read</docanchor>
    <docanchor file="group__DDSReaderExampleModule">DDSReaderExampleModule_reader_teardown</docanchor>
  </compound>
  <compound kind="group">
    <name>DDSEntityExampleModule</name>
    <title>Entity Use Cases</title>
    <filename>group__DDSEntityExampleModule.html</filename>
    <docanchor file="group__DDSEntityExampleModule">DDSEntityExampleModule_enable</docanchor>
    <docanchor file="group__DDSEntityExampleModule">DDSEntityExampleModule_status_changes</docanchor>
    <docanchor file="group__DDSEntityExampleModule">DDSEntityExampleModule_qos</docanchor>
    <docanchor file="group__DDSEntityExampleModule">DDSEntityExampleModule_listener</docanchor>
    <docanchor file="group__DDSEntityExampleModule">DDSEntityExampleModule_statuscondition</docanchor>
  </compound>
  <compound kind="group">
    <name>DDSWaitsetExampleModule</name>
    <title>Waitset Use Cases</title>
    <filename>group__DDSWaitsetExampleModule.html</filename>
    <docanchor file="group__DDSWaitsetExampleModule">DDSWaitsetExampleModule_setup</docanchor>
    <docanchor file="group__DDSWaitsetExampleModule">DDSWaitsetExampleModule_trigger</docanchor>
    <docanchor file="group__DDSWaitsetExampleModule">DDSWaitsetExampleModule_teradown</docanchor>
  </compound>
  <compound kind="group">
    <name>NDDSTransportExampleModule</name>
    <title>Transport Use Cases</title>
    <filename>group__NDDSTransportExampleModule.html</filename>
    <docanchor file="group__NDDSTransportExampleModule">NDDSTransportExampleModule_change_builtin</docanchor>
    <docanchor file="group__NDDSTransportExampleModule">NDDSTransportExampleModule_change_builtin_properties</docanchor>
    <docanchor file="group__NDDSTransportExampleModule">NDDSTransportExampleModule_create_transport</docanchor>
    <docanchor file="group__NDDSTransportExampleModule">NDDSTransportExampleModule_delete_transport</docanchor>
    <docanchor file="group__NDDSTransportExampleModule">NDDSTransportExampleModule_setup</docanchor>
    <docanchor file="group__NDDSTransportExampleModule">NDDSTransportExampleModule_recv_route</docanchor>
    <docanchor file="group__NDDSTransportExampleModule">NDDSTransportExampleModule_send_route</docanchor>
  </compound>
  <compound kind="group">
    <name>NDDSFilterExampleModule</name>
    <title>Filter Use Cases</title>
    <filename>group__NDDSFilterExampleModule.html</filename>
    <docanchor file="group__NDDSFilterExampleModule">NDDSFilterExampleModule_intro</docanchor>
    <docanchor file="group__NDDSFilterExampleModule">NDDSFilterExampleModule_CFT_overview</docanchor>
    <docanchor file="group__NDDSFilterExampleModule">NDDSFilterExampleModule_QC_overview</docanchor>
    <docanchor file="group__NDDSFilterExampleModule">NDDSFilterExampleModule_content_filtered_topic</docanchor>
    <docanchor file="group__NDDSFilterExampleModule">NDDSFilterExampleModule_query_conditions</docanchor>
    <docanchor file="group__NDDSFilterExampleModule">NDDSFilterExampleModule_performance</docanchor>
  </compound>
  <compound kind="group">
    <name>NDDSCustomFilterExampleModule</name>
    <title>Creating Custom Content Filters</title>
    <filename>group__NDDSCustomFilterExampleModule.html</filename>
    <docanchor file="group__NDDSCustomFilterExampleModule">NDDSCustomFilterExampleModule_intro</docanchor>
    <docanchor file="group__NDDSCustomFilterExampleModule">NDDSCustomFilterExampleModule_anatomy</docanchor>
    <docanchor file="group__NDDSCustomFilterExampleModule">NDDSCustomFilterExampleModule_compile</docanchor>
    <docanchor file="group__NDDSCustomFilterExampleModule">NDDSCustomFilterExampleModule_evaluate</docanchor>
    <docanchor file="group__NDDSCustomFilterExampleModule">NDDSCustomFilterExampleModule_finalize</docanchor>
    <docanchor file="group__NDDSCustomFilterExampleModule">NDDSCustomFilterExampleModule_using_c_format</docanchor>
    <docanchor file="group__NDDSCustomFilterExampleModule">NDDSCustomFilterExampleModule_using_c_format_compile</docanchor>
    <docanchor file="group__NDDSCustomFilterExampleModule">NDDSCustomFilterExampleModule_using_c_format_evaluate</docanchor>
    <docanchor file="group__NDDSCustomFilterExampleModule">NDDSCustomFilterExampleModule_using_c_format_finalize</docanchor>
    <docanchor file="group__NDDSCustomFilterExampleModule">NDDSCustomFilterExampleModule_using_c_format_register</docanchor>
    <docanchor file="group__NDDSCustomFilterExampleModule">NDDSCustomFilterExampleModule_using_c_format_unregister</docanchor>
  </compound>
  <compound kind="group">
    <name>LargeDataExampleModule</name>
    <title>Large Data Use Cases</title>
    <filename>group__LargeDataExampleModule.html</filename>
    <docanchor file="group__LargeDataExampleModule">LargeDataExampleModule_intro</docanchor>
    <docanchor file="group__LargeDataExampleModule">LargeDataExampleModule_writing_large_data</docanchor>
    <docanchor file="group__LargeDataExampleModule">LargeDataExampleModule_receiving_large_data</docanchor>
  </compound>
  <compound kind="group">
    <name>RequestReplyExampleModule</name>
    <title>Request-Reply Examples</title>
    <filename>group__RequestReplyExampleModule.html</filename>
    <docanchor file="group__RequestReplyExampleModule">RequestReplyExampleModule_requestreply</docanchor>
    <docanchor file="group__RequestReplyExampleModule">RequestReplyExampleModule_requester_create</docanchor>
    <docanchor file="group__RequestReplyExampleModule">RequestReplyExampleModule_requester_create_w_params</docanchor>
    <docanchor file="group__RequestReplyExampleModule">RequestReplyExampleModule_requester_basic</docanchor>
    <docanchor file="group__RequestReplyExampleModule">RequestReplyExampleModule_get_loaned_samples</docanchor>
    <docanchor file="group__RequestReplyExampleModule">RequestReplyExampleModule_correlation</docanchor>
    <docanchor file="group__RequestReplyExampleModule">RequestReplyExampleModule_replier_create</docanchor>
    <docanchor file="group__RequestReplyExampleModule">RequestReplyExampleModule_replier_basic</docanchor>
    <docanchor file="group__RequestReplyExampleModule">RequestReplyExampleModule_simple_replier</docanchor>
    <docanchor file="group__RequestReplyExampleModule">RequestReplyExampleModule_qos_profile</docanchor>
  </compound>
  <compound kind="group">
    <name>DDSUserGuideModule</name>
    <title>Documentation Roadmap</title>
    <filename>group__DDSUserGuideModule.html</filename>
  </compound>
  <compound kind="group">
    <name>DDSDocGuideModule</name>
    <title>Conventions</title>
    <filename>group__DDSDocGuideModule.html</filename>
    <docanchor file="group__DDSDocGuideModule">doc_guide_support</docanchor>
    <docanchor file="group__DDSDocGuideModule">doc_guide_naming</docanchor>
    <docanchor file="group__DDSDocGuideModule">doc_guide_naming_structs</docanchor>
    <docanchor file="group__DDSDocGuideModule">doc_guide_doxygen</docanchor>
    <docanchor file="group__DDSDocGuideModule">doc_guide_stereotypes</docanchor>
    <docanchor file="group__DDSDocGuideModule">doc_guide_stereotypes_Extensions</docanchor>
    <docanchor file="group__DDSDocGuideModule">a_st_ext</docanchor>
    <docanchor file="group__DDSDocGuideModule">doc_guide_stereotypes_Experimental</docanchor>
    <docanchor file="group__DDSDocGuideModule">a_st_exp</docanchor>
    <docanchor file="group__DDSDocGuideModule">doc_guide_stereotypes_Types</docanchor>
    <docanchor file="group__DDSDocGuideModule">a_st_interface</docanchor>
    <docanchor file="group__DDSDocGuideModule">a_st_generic</docanchor>
    <docanchor file="group__DDSDocGuideModule">a_st_singleton</docanchor>
    <docanchor file="group__DDSDocGuideModule">doc_guide_stereotypes_methods</docanchor>
    <docanchor file="group__DDSDocGuideModule">a_st_in</docanchor>
    <docanchor file="group__DDSDocGuideModule">a_st_out</docanchor>
    <docanchor file="group__DDSDocGuideModule">a_st_inout</docanchor>
  </compound>
  <compound kind="group">
    <name>DDSDcpsModule</name>
    <title>RTI Connext DDS API Reference</title>
    <filename>group__DDSDcpsModule.html</filename>
    <subgroup>DDSDomainModule</subgroup>
    <subgroup>DDSTopicModule</subgroup>
    <subgroup>DDSPublicationModule</subgroup>
    <subgroup>DDSSubscriptionModule</subgroup>
    <subgroup>DDSInfrastructureModule</subgroup>
    <subgroup>NDDSTransportModule</subgroup>
    <subgroup>DDSQueryAndFilterSyntaxModule</subgroup>
    <subgroup>NDDSConfigModule</subgroup>
    <subgroup>NDDSUtilityModule</subgroup>
    <subgroup>NDDSDurabilityAndPersistenceModule</subgroup>
    <subgroup>NDDSSystemPropertiesModule</subgroup>
    <subgroup>NDDSXmlConfigurationModule</subgroup>
    <subgroup>PatternsApiModule</subgroup>
    <docanchor file="group__DDSDcpsModule">DDSDcps_overview</docanchor>
    <docanchor file="group__DDSDcpsModule">DDSDcps_model</docanchor>
    <docanchor file="group__DDSDcpsModule">DDSDcps_packages</docanchor>
  </compound>
  <compound kind="group">
    <name>PatternsApiModule</name>
    <title>RTI Connext Request-Reply API Reference</title>
    <filename>group__PatternsApiModule.html</filename>
    <subgroup>RequestReplyModule</subgroup>
  </compound>
  <compound kind="group">
    <name>DDSHowToModule</name>
    <title>Programming How-To&apos;s</title>
    <filename>group__DDSHowToModule.html</filename>
    <subgroup>DDSProducerExampleModule</subgroup>
    <subgroup>DDSConsumerExampleModule</subgroup>
    <subgroup>DDSParticipantExampleModule</subgroup>
    <subgroup>DDSTopicExampleModule</subgroup>
    <subgroup>DDSFlowControllerExampleModule</subgroup>
    <subgroup>DDSPublisherExampleModule</subgroup>
    <subgroup>DDSWriterExampleModule</subgroup>
    <subgroup>DDSSubscriberExampleModule</subgroup>
    <subgroup>DDSReaderExampleModule</subgroup>
    <subgroup>DDSEntityExampleModule</subgroup>
    <subgroup>DDSWaitsetExampleModule</subgroup>
    <subgroup>NDDSTransportExampleModule</subgroup>
    <subgroup>NDDSFilterExampleModule</subgroup>
    <subgroup>NDDSCustomFilterExampleModule</subgroup>
    <subgroup>LargeDataExampleModule</subgroup>
    <subgroup>RequestReplyExampleModule</subgroup>
  </compound>
  <compound kind="group">
    <name>DDSToolModule</name>
    <title>Programming Tools</title>
    <filename>group__DDSToolModule.html</filename>
    <subgroup>DDSNddsgenModule</subgroup>
    <subgroup>DDSNddspingModule</subgroup>
    <subgroup>DDSNddsspyModule</subgroup>
  </compound>
  <compound kind="group">
    <name>DDSNddsgenModule</name>
    <title>rtiddsgen</title>
    <filename>group__DDSNddsgenModule.html</filename>
    <docanchor file="group__DDSNddsgenModule">Usage</docanchor>
    <docanchor file="group__DDSNddsgenModule">Description</docanchor>
    <docanchor file="group__DDSNddsgenModule">CPPExample</docanchor>
    <docanchor file="group__DDSNddsgenModule">IDLLanguage</docanchor>
    <docanchor file="group__DDSNddsgenModule">XMLLanguage</docanchor>
    <docanchor file="group__DDSNddsgenModule">XSDLanguage</docanchor>
    <docanchor file="group__DDSNddsgenModule">WSDLLanguage</docanchor>
    <docanchor file="group__DDSNddsgenModule">Standalone</docanchor>
  </compound>
  <compound kind="group">
    <name>DDSNddspingModule</name>
    <title>rtiddsping</title>
    <filename>group__DDSNddspingModule.html</filename>
  </compound>
  <compound kind="group">
    <name>DDSNddsspyModule</name>
    <title>rtiddsspy</title>
    <filename>group__DDSNddsspyModule.html</filename>
  </compound>
  <compound kind="group">
    <name>NDDS_Transport_ClassId_t</name>
    <title>Class Id</title>
    <filename>group__NDDS__Transport__ClassId__t.html</filename>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_CLASSID_INVALID</name>
      <anchorfile>group__NDDS__Transport__ClassId__t.html</anchorfile>
      <anchor>ga8efd354afca81cfb0316b26bd5a3b0dc</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_CLASSID_DTLS</name>
      <anchorfile>group__NDDS__Transport__ClassId__t.html</anchorfile>
      <anchor>gaa9475cd64622efaa6cab5d61ec1aa71e</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_CLASSID_WAN</name>
      <anchorfile>group__NDDS__Transport__ClassId__t.html</anchorfile>
      <anchor>gaf85fdd5e31279ee00a25f83901c43472</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_CLASSID_TCPV4_LAN</name>
      <anchorfile>group__NDDS__Transport__ClassId__t.html</anchorfile>
      <anchor>ga7dad1954eb64c8c234f85d298ed21965</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_CLASSID_TCPV4_WAN</name>
      <anchorfile>group__NDDS__Transport__ClassId__t.html</anchorfile>
      <anchor>gaa5adf7348c32089e3080b0a8faa4a58a</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_CLASSNAME_TCPV4_WAN</name>
      <anchorfile>group__NDDS__Transport__ClassId__t.html</anchorfile>
      <anchor>gada4dfd5428c5d7b864e507679d892a08</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_CLASSID_TLSV4_LAN</name>
      <anchorfile>group__NDDS__Transport__ClassId__t.html</anchorfile>
      <anchor>ga7e8dfdb798b6de440c5afa28ee0a2d72</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_CLASSID_TLSV4_WAN</name>
      <anchorfile>group__NDDS__Transport__ClassId__t.html</anchorfile>
      <anchor>ga5f7601d31b7d72528a2754407ce170c6</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_CLASSID_PCIE</name>
      <anchorfile>group__NDDS__Transport__ClassId__t.html</anchorfile>
      <anchor>gaf073d9a74e0b09099bca4e306ef6639f</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_CLASSID_ITP</name>
      <anchorfile>group__NDDS__Transport__ClassId__t.html</anchorfile>
      <anchor>ga98960ae0b5c7536b493794e730dd3a5e</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_CLASSID_RESERVED_RANGE</name>
      <anchorfile>group__NDDS__Transport__ClassId__t.html</anchorfile>
      <anchor>ga8ee9872476ea317426a43836ea847bdd</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>RTI_INT32</type>
      <name>NDDS_Transport_ClassId_t</name>
      <anchorfile>group__NDDS__Transport__ClassId__t.html</anchorfile>
      <anchor>gae693c14746a142d41452bf4911fd923a</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>NDDS_Transport_Address_t</name>
    <title>Address</title>
    <filename>group__NDDS__Transport__Address__t.html</filename>
    <class kind="struct">NDDS_Transport_Address_t</class>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_ADDRESS_INVALID</name>
      <anchorfile>group__NDDS__Transport__Address__t.html</anchorfile>
      <anchor>ga1dc33ff13f6cc78ccd6425bc4f5d90f8</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_ADDRESS_STRING_BUFFER_SIZE</name>
      <anchorfile>group__NDDS__Transport__Address__t.html</anchorfile>
      <anchor>ga0a4aa417eadb52b891ebc3f9b7cf5321</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>RTI_INT32</type>
      <name>NDDS_Transport_Address_to_string</name>
      <anchorfile>group__NDDS__Transport__Address__t.html</anchorfile>
      <anchor>gaa1d7b053383690a4871581d7674a7c91</anchor>
      <arglist>(const NDDS_Transport_Address_t *self, char *buffer_inout, RTI_INT32 buffer_length_in)</arglist>
    </member>
    <member kind="function">
      <type>RTI_INT32</type>
      <name>NDDS_Transport_Address_from_string</name>
      <anchorfile>group__NDDS__Transport__Address__t.html</anchorfile>
      <anchor>ga6570d1fc049815b44016961024894cbc</anchor>
      <arglist>(NDDS_Transport_Address_t *address_out, const char *address_in)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>NDDS_Transport_Address_print</name>
      <anchorfile>group__NDDS__Transport__Address__t.html</anchorfile>
      <anchor>gab99006a5001f216c1e83e8012fb470b8</anchor>
      <arglist>(const NDDS_Transport_Address_t *address_in, const char *desc_in, RTI_INT32 indent_in)</arglist>
    </member>
    <member kind="function">
      <type>RTI_INT32</type>
      <name>NDDS_Transport_Address_is_ipv4</name>
      <anchorfile>group__NDDS__Transport__Address__t.html</anchorfile>
      <anchor>ga6221ab12bfe74d8a3e47415725cd414d</anchor>
      <arglist>(const NDDS_Transport_Address_t *address_in)</arglist>
    </member>
    <member kind="function">
      <type>RTI_INT32</type>
      <name>NDDS_Transport_Address_is_multicast</name>
      <anchorfile>group__NDDS__Transport__Address__t.html</anchorfile>
      <anchor>gaa3c4206d0aa1669b08e84fdff0a41768</anchor>
      <arglist>(const NDDS_Transport_Address_t *address_in)</arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>NDDS_Transport_Property_t</name>
    <title>Attributes</title>
    <filename>group__NDDS__Transport__Property__t.html</filename>
    <class kind="struct">NDDS_Transport_Property_t</class>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_PROPERTY_BIT_BUFFER_ALWAYS_LOANED</name>
      <anchorfile>group__NDDS__Transport__Property__t.html</anchorfile>
      <anchor>ga099cc5d8911cbf822b2885df441a7d1f</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_PROPERTY_GATHER_SEND_BUFFER_COUNT_MIN</name>
      <anchorfile>group__NDDS__Transport__Property__t.html</anchorfile>
      <anchor>gac31e17a163368b00672a7fa8670304e5</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>NDDS_Transport_Shmem_Plugin</name>
    <title>Shared Memory Transport</title>
    <filename>group__NDDS__Transport__Shmem__Plugin.html</filename>
    <class kind="struct">NDDS_Transport_Shmem_Property_t</class>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_CLASSID_SHMEM</name>
      <anchorfile>group__NDDS__Transport__Shmem__Plugin.html</anchorfile>
      <anchor>ga919ce9101d78fe359c03f813be2c6369</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_SHMEM_ADDRESS_BIT_COUNT</name>
      <anchorfile>group__NDDS__Transport__Shmem__Plugin.html</anchorfile>
      <anchor>ga35cfedd492afcf0252b31c8b98151278</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_SHMEM_PROPERTIES_BITMAP_DEFAULT</name>
      <anchorfile>group__NDDS__Transport__Shmem__Plugin.html</anchorfile>
      <anchor>gae18a8a8166ece7b6e6370051acdcd987</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_SHMEM_GATHER_SEND_BUFFER_COUNT_MAX_DEFAULT</name>
      <anchorfile>group__NDDS__Transport__Shmem__Plugin.html</anchorfile>
      <anchor>gaf251fea27c4351dfb13f46c19a23f922</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_SHMEM_MESSAGE_SIZE_MAX_DEFAULT</name>
      <anchorfile>group__NDDS__Transport__Shmem__Plugin.html</anchorfile>
      <anchor>gaf4b9589b7eb1e891a925af3f59eee51d</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_SHMEM_RECEIVED_MESSAGE_COUNT_MAX_DEFAULT</name>
      <anchorfile>group__NDDS__Transport__Shmem__Plugin.html</anchorfile>
      <anchor>gac5d6855abc3bcacebe67b0c221830d59</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_SHMEM_RECEIVE_BUFFER_SIZE_DEFAULT</name>
      <anchorfile>group__NDDS__Transport__Shmem__Plugin.html</anchorfile>
      <anchor>gaf1826abf2f3c8fe2b16ebda60bdea22c</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_SHMEM_PROPERTY_DEFAULT</name>
      <anchorfile>group__NDDS__Transport__Shmem__Plugin.html</anchorfile>
      <anchor>ga65efdcaf595c921c233ac1b4febec582</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>NDDS_Transport_Plugin *</type>
      <name>NDDS_Transport_Shmem_new</name>
      <anchorfile>group__NDDS__Transport__Shmem__Plugin.html</anchorfile>
      <anchor>ga56bbb55e11d7fa68003cf3a5d9cc0c43</anchor>
      <arglist>(const struct NDDS_Transport_Shmem_Property_t *property_in)</arglist>
    </member>
    <member kind="function">
      <type>NDDS_Transport_Plugin *</type>
      <name>NDDS_Transport_Shmem_create</name>
      <anchorfile>group__NDDS__Transport__Shmem__Plugin.html</anchorfile>
      <anchor>ga648b5f684c9fd09d9462935a8a0431f9</anchor>
      <arglist>(NDDS_Transport_Address_t *default_network_address_out, const struct DDS_PropertyQosPolicy *property_in)</arglist>
    </member>
    <docanchor file="group__NDDS__Transport__Shmem__Plugin">ShmemTransport_compatibility</docanchor>
    <docanchor file="group__NDDS__Transport__Shmem__Plugin">ShmemTransport_crash</docanchor>
    <docanchor file="group__NDDS__Transport__Shmem__Plugin">ShmemTransport_keys</docanchor>
    <docanchor file="group__NDDS__Transport__Shmem__Plugin">ShmemTransport_register</docanchor>
    <docanchor file="group__NDDS__Transport__Shmem__Plugin">TransportSHMEMPropertyNameModule</docanchor>
  </compound>
  <compound kind="group">
    <name>NDDS_Transport_UDPv4_Plugin</name>
    <title>UDPv4 Transport</title>
    <filename>group__NDDS__Transport__UDPv4__Plugin.html</filename>
    <class kind="struct">NDDS_Transport_UDPv4_Property_t</class>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_CLASSID_UDPv4</name>
      <anchorfile>group__NDDS__Transport__UDPv4__Plugin.html</anchorfile>
      <anchor>ga7afaa46b01e74c8c5c726440d6efa056</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_UDPV4_ADDRESS_BIT_COUNT</name>
      <anchorfile>group__NDDS__Transport__UDPv4__Plugin.html</anchorfile>
      <anchor>gac5e6793b609612a5a839d3f05b354b0d</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_UDPV4_PROPERTIES_BITMAP_DEFAULT</name>
      <anchorfile>group__NDDS__Transport__UDPv4__Plugin.html</anchorfile>
      <anchor>ga328d5f718791a81b0a4bcdac28f77ab2</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_UDPV4_GATHER_SEND_BUFFER_COUNT_MAX_DEFAULT</name>
      <anchorfile>group__NDDS__Transport__UDPv4__Plugin.html</anchorfile>
      <anchor>ga65b9ad9f4f683066a0ea97befc085f6e</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_UDPV4_SOCKET_BUFFER_SIZE_OS_DEFAULT</name>
      <anchorfile>group__NDDS__Transport__UDPv4__Plugin.html</anchorfile>
      <anchor>gaeec49238b766ba44d3eec5a1c13359b6</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_UDPV4_SEND_SOCKET_BUFFER_SIZE_DEFAULT</name>
      <anchorfile>group__NDDS__Transport__UDPv4__Plugin.html</anchorfile>
      <anchor>ga516e6bd8029f30ea3ca2012901dc218f</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_UDPV4_RECV_SOCKET_BUFFER_SIZE_DEFAULT</name>
      <anchorfile>group__NDDS__Transport__UDPv4__Plugin.html</anchorfile>
      <anchor>ga73e7bbacb030a7ac1d0b36041adaa5fe</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_UDPV4_PAYLOAD_SIZE_MAX</name>
      <anchorfile>group__NDDS__Transport__UDPv4__Plugin.html</anchorfile>
      <anchor>ga0ebd7c6f96784bec4b53e09dbc2bfbdf</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_UDPV4_MESSAGE_SIZE_MAX_DEFAULT</name>
      <anchorfile>group__NDDS__Transport__UDPv4__Plugin.html</anchorfile>
      <anchor>ga6dee1bddde300ccc3d5afb8f8f4f1551</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_UDPV4_MULTICAST_TTL_DEFAULT</name>
      <anchorfile>group__NDDS__Transport__UDPv4__Plugin.html</anchorfile>
      <anchor>ga8cf6485247268838cf7a32a90878087d</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_UDPV4_BLOCKING_NEVER</name>
      <anchorfile>group__NDDS__Transport__UDPv4__Plugin.html</anchorfile>
      <anchor>ga63a6dad194cdf511cf38a6fabc12328d</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_UDPV4_BLOCKING_ALWAYS</name>
      <anchorfile>group__NDDS__Transport__UDPv4__Plugin.html</anchorfile>
      <anchor>ga6a45b6ed6e90d2b535d988dda5a3282b</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_UDPV4_BLOCKING_DEFAULT</name>
      <anchorfile>group__NDDS__Transport__UDPv4__Plugin.html</anchorfile>
      <anchor>ga4ba5719417a579c9158e66e7fc4ce32b</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_UDPV4_PROPERTY_DEFAULT</name>
      <anchorfile>group__NDDS__Transport__UDPv4__Plugin.html</anchorfile>
      <anchor>ga95428077c0c9307a8ca3f942e837666f</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>NDDS_Transport_Plugin *</type>
      <name>NDDS_Transport_UDPv4_new</name>
      <anchorfile>group__NDDS__Transport__UDPv4__Plugin.html</anchorfile>
      <anchor>ga43415754deca794f2970631f6b0f21fb</anchor>
      <arglist>(const struct NDDS_Transport_UDPv4_Property_t *property_in)</arglist>
    </member>
    <member kind="function">
      <type>RTI_INT32</type>
      <name>NDDS_Transport_UDPv4_string_to_address_cEA</name>
      <anchorfile>group__NDDS__Transport__UDPv4__Plugin.html</anchorfile>
      <anchor>ga81ae856667bd6e9e4ee452fdae951b6b</anchor>
      <arglist>(NDDS_Transport_Plugin *self, NDDS_Transport_Address_t *address_out, const char *address_in)</arglist>
    </member>
    <member kind="function">
      <type>RTI_INT32</type>
      <name>NDDS_Transport_UDPv4_get_receive_interfaces_cEA</name>
      <anchorfile>group__NDDS__Transport__UDPv4__Plugin.html</anchorfile>
      <anchor>ga8dbb284faa9502d7ac25156cb5122809</anchor>
      <arglist>(NDDS_Transport_Plugin *self, RTI_INT32 *found_more_than_provided_for_out, RTI_INT32 *interface_reported_count_out, NDDS_Transport_Interface_t interface_array_inout[], RTI_INT32 interface_array_size_in)</arglist>
    </member>
    <member kind="function">
      <type>NDDS_Transport_Plugin *</type>
      <name>NDDS_Transport_UDPv4_create</name>
      <anchorfile>group__NDDS__Transport__UDPv4__Plugin.html</anchorfile>
      <anchor>ga3443eeacfd14ef3e225eadc2d41c24d7</anchor>
      <arglist>(NDDS_Transport_Address_t *default_network_address_out, const struct DDS_PropertyQosPolicy *property_in)</arglist>
    </member>
    <docanchor file="group__NDDS__Transport__UDPv4__Plugin">TransportUDPv4PropertyNameModule</docanchor>
  </compound>
  <compound kind="group">
    <name>NDDS_Transport_UDPv6_Plugin</name>
    <title>UDPv6 Transport</title>
    <filename>group__NDDS__Transport__UDPv6__Plugin.html</filename>
    <class kind="struct">NDDS_Transport_UDPv6_Property_t</class>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_CLASSID_UDPv6</name>
      <anchorfile>group__NDDS__Transport__UDPv6__Plugin.html</anchorfile>
      <anchor>ga004554cf2b01c232a1ef3c1bb098a6c4</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_UDPV6_ADDRESS_BIT_COUNT</name>
      <anchorfile>group__NDDS__Transport__UDPv6__Plugin.html</anchorfile>
      <anchor>gaa859beb339ce51eecad562e710cc1a50</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_UDPV6_PROPERTIES_BITMAP_DEFAULT</name>
      <anchorfile>group__NDDS__Transport__UDPv6__Plugin.html</anchorfile>
      <anchor>gaac585139e9495a77605c986caad1735d</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_UDPV6_GATHER_SEND_BUFFER_COUNT_MAX_DEFAULT</name>
      <anchorfile>group__NDDS__Transport__UDPv6__Plugin.html</anchorfile>
      <anchor>gaf6621d4d965eea3c429690c1a6d82b14</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_UDPV6_SOCKET_BUFFER_SIZE_OS_DEFAULT</name>
      <anchorfile>group__NDDS__Transport__UDPv6__Plugin.html</anchorfile>
      <anchor>gada1885fcf4b44be38f5e2ebf553f24f0</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_UDPV6_SEND_SOCKET_BUFFER_SIZE_DEFAULT</name>
      <anchorfile>group__NDDS__Transport__UDPv6__Plugin.html</anchorfile>
      <anchor>gaedff34929be9f611877e133c74238d68</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_UDPV6_RECV_SOCKET_BUFFER_SIZE_DEFAULT</name>
      <anchorfile>group__NDDS__Transport__UDPv6__Plugin.html</anchorfile>
      <anchor>ga8c9f6a74336af5885ff34fc72701d469</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_UDPV6_MESSAGE_SIZE_MAX_DEFAULT</name>
      <anchorfile>group__NDDS__Transport__UDPv6__Plugin.html</anchorfile>
      <anchor>gab06690762fd722e0885e7d3f1151a837</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_UDPV6_MULTICAST_TTL_DEFAULT</name>
      <anchorfile>group__NDDS__Transport__UDPv6__Plugin.html</anchorfile>
      <anchor>gaddbf125ade0e33e5c60e0b953452d591</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_UDPV6_BLOCKING_NEVER</name>
      <anchorfile>group__NDDS__Transport__UDPv6__Plugin.html</anchorfile>
      <anchor>gab601035adf6fa11b207897f88afe4119</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_UDPV6_BLOCKING_ALWAYS</name>
      <anchorfile>group__NDDS__Transport__UDPv6__Plugin.html</anchorfile>
      <anchor>gabb5064864b34809c954a44b4a277c2e9</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>NDDS_TRANSPORT_UDPV6_PROPERTY_DEFAULT</name>
      <anchorfile>group__NDDS__Transport__UDPv6__Plugin.html</anchorfile>
      <anchor>gad8528636a325708010826a4cdd532bda</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>NDDS_Transport_Plugin *</type>
      <name>NDDS_Transport_UDPv6_new</name>
      <anchorfile>group__NDDS__Transport__UDPv6__Plugin.html</anchorfile>
      <anchor>gad2a0af107bfda142d1b03f6f97b2c482</anchor>
      <arglist>(const struct NDDS_Transport_UDPv6_Property_t *property_in)</arglist>
    </member>
    <member kind="function">
      <type>RTI_INT32</type>
      <name>NDDS_Transport_UDPv6_string_to_address_cEA</name>
      <anchorfile>group__NDDS__Transport__UDPv6__Plugin.html</anchorfile>
      <anchor>ga4b8dbba12b59f3c7e73e57de7f0e9f43</anchor>
      <arglist>(NDDS_Transport_Plugin *self, NDDS_Transport_Address_t *address_out, const char *address_in)</arglist>
    </member>
    <member kind="function">
      <type>RTI_INT32</type>
      <name>NDDS_Transport_UDPv6_get_receive_interfaces_cEA</name>
      <anchorfile>group__NDDS__Transport__UDPv6__Plugin.html</anchorfile>
      <anchor>gae7ded9461bec0b980ee7b76438e9fc75</anchor>
      <arglist>(NDDS_Transport_Plugin *self, RTI_INT32 *found_more_than_provided_for_out, RTI_INT32 *interface_reported_count_out, NDDS_Transport_Interface_t interface_array_inout[], RTI_INT32 interface_array_size_in)</arglist>
    </member>
    <member kind="function">
      <type>NDDS_Transport_Plugin *</type>
      <name>NDDS_Transport_UDPv6_create</name>
      <anchorfile>group__NDDS__Transport__UDPv6__Plugin.html</anchorfile>
      <anchor>ga9184ab6998417410b61f1a29298542ab</anchor>
      <arglist>(NDDS_Transport_Address_t *default_network_address_out, const struct DDS_PropertyQosPolicy *property_in)</arglist>
    </member>
    <docanchor file="group__NDDS__Transport__UDPv6__Plugin">TransportUDPv6PropertyNameModule</docanchor>
  </compound>
  <compound kind="group">
    <name>DDSParticipantBuiltInTopicModule</name>
    <title>Participant Built-in Topics</title>
    <filename>group__DDSParticipantBuiltInTopicModule.html</filename>
    <class kind="struct">DDS_ParticipantBuiltinTopicData</class>
    <class kind="struct">DDS_ParticipantBuiltinTopicDataSeq</class>
    <class kind="struct">DDS_ParticipantBuiltinTopicDataTypeSupport</class>
    <member kind="typedef">
      <type>struct DDS_ParticipantBuiltinTopicData</type>
      <name>DDS_ParticipantBuiltinTopicData</name>
      <anchorfile>group__DDSParticipantBuiltInTopicModule.html</anchorfile>
      <anchor>gad7c660418cc7b9da08d3b9c7a8945586</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_ParticipantBuiltinTopicDataDataReader</type>
      <name>DDS_ParticipantBuiltinTopicDataDataReader</name>
      <anchorfile>group__DDSParticipantBuiltInTopicModule.html</anchorfile>
      <anchor>gadae5281c856838ce1f829e01d2fde7ad</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type></type>
      <name>DDSC_VARIABLE_LENGTH_VALUE_TYPE_SUPPORT</name>
      <anchorfile>group__DDSParticipantBuiltInTopicModule.html</anchorfile>
      <anchor>ga8c479ea10e7d241498aa3c38f313fcaa</anchor>
      <arglist>(DDS_TransportInfo_t)</arglist>
    </member>
    <member kind="variable">
      <type>const char *</type>
      <name>DDS_PARTICIPANT_TOPIC_NAME</name>
      <anchorfile>group__DDSParticipantBuiltInTopicModule.html</anchorfile>
      <anchor>ga1741e87698c2dcee241f04fdd533c978</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSTopicBuiltInTopicModule</name>
    <title>Topic Built-in Topics</title>
    <filename>group__DDSTopicBuiltInTopicModule.html</filename>
    <class kind="struct">DDS_TopicBuiltinTopicData</class>
    <class kind="struct">DDS_TopicBuiltinTopicDataSeq</class>
    <class kind="struct">DDS_TopicBuiltinTopicDataTypeSupport</class>
    <member kind="typedef">
      <type>struct DDS_TopicBuiltinTopicData</type>
      <name>DDS_TopicBuiltinTopicData</name>
      <anchorfile>group__DDSTopicBuiltInTopicModule.html</anchorfile>
      <anchor>gae88f6d53bc68fd9c5581042353c72345</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_TopicBuiltinTopicDataDataReader</type>
      <name>DDS_TopicBuiltinTopicDataDataReader</name>
      <anchorfile>group__DDSTopicBuiltInTopicModule.html</anchorfile>
      <anchor>ga993be4ff155f3dbb282f730e914fb82f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *</type>
      <name>DDS_TOPIC_TOPIC_NAME</name>
      <anchorfile>group__DDSTopicBuiltInTopicModule.html</anchorfile>
      <anchor>ga32d9fc78543cfa0e28760f7444f5d02a</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSPublicationBuiltInTopicModule</name>
    <title>Publication Built-in Topics</title>
    <filename>group__DDSPublicationBuiltInTopicModule.html</filename>
    <class kind="struct">DDS_PublicationBuiltinTopicData</class>
    <class kind="struct">DDS_PublicationBuiltinTopicDataSeq</class>
    <class kind="struct">DDS_PublicationBuiltinTopicDataTypeSupport</class>
    <member kind="typedef">
      <type>struct DDS_PublicationBuiltinTopicData</type>
      <name>DDS_PublicationBuiltinTopicData</name>
      <anchorfile>group__DDSPublicationBuiltInTopicModule.html</anchorfile>
      <anchor>ga9bc2f651d54519f65846b8c9cbc0d7a0</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_PublicationBuiltinTopicDataDataReader</type>
      <name>DDS_PublicationBuiltinTopicDataDataReader</name>
      <anchorfile>group__DDSPublicationBuiltInTopicModule.html</anchorfile>
      <anchor>gab8f22ec9bdcd4385f2737f3008164ca3</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *</type>
      <name>DDS_PUBLICATION_TOPIC_NAME</name>
      <anchorfile>group__DDSPublicationBuiltInTopicModule.html</anchorfile>
      <anchor>gaaaf3b75757885897768615bc8dc98586</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSSubscriptionBuiltInTopicModule</name>
    <title>Subscription Built-in Topics</title>
    <filename>group__DDSSubscriptionBuiltInTopicModule.html</filename>
    <class kind="struct">DDS_SubscriptionBuiltinTopicData</class>
    <class kind="struct">DDS_SubscriptionBuiltinTopicDataSeq</class>
    <class kind="struct">DDS_SubscriptionBuiltinTopicDataTypeSupport</class>
    <member kind="typedef">
      <type>struct DDS_SubscriptionBuiltinTopicData</type>
      <name>DDS_SubscriptionBuiltinTopicData</name>
      <anchorfile>group__DDSSubscriptionBuiltInTopicModule.html</anchorfile>
      <anchor>ga9054b25f3a0af2ec4aeae176ef8d5922</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_SubscriptionBuiltinTopicDataDataReader</type>
      <name>DDS_SubscriptionBuiltinTopicDataDataReader</name>
      <anchorfile>group__DDSSubscriptionBuiltInTopicModule.html</anchorfile>
      <anchor>gadb4eef41b7404297465c85882b85081b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *</type>
      <name>DDS_SUBSCRIPTION_TOPIC_NAME</name>
      <anchorfile>group__DDSSubscriptionBuiltInTopicModule.html</anchorfile>
      <anchor>ga440d1b5d846dd5d490b8c25bc9d52bc7</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSBuiltInTopicCommonModule</name>
    <title>Common types and functions</title>
    <filename>group__DDSBuiltInTopicCommonModule.html</filename>
    <class kind="struct">DDS_Locator_t</class>
    <class kind="struct">DDS_LocatorSeq</class>
    <class kind="struct">DDS_ProtocolVersion_t</class>
    <class kind="struct">DDS_VendorId_t</class>
    <class kind="struct">DDS_ProductVersion_t</class>
    <class kind="struct">DDS_TransportInfo_t</class>
    <class kind="struct">DDS_TransportInfoSeq</class>
    <class kind="struct">DDS_BuiltinTopicKey_t</class>
    <class kind="struct">DDS_ContentFilterProperty_t</class>
    <member kind="define">
      <type>#define</type>
      <name>DDS_LOCATOR_ADDRESS_LENGTH_MAX</name>
      <anchorfile>group__DDSBuiltInTopicCommonModule.html</anchorfile>
      <anchor>gacc90a478a9b903fbc8da7007fa141a83</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_PROTOCOLVERSION_1_0</name>
      <anchorfile>group__DDSBuiltInTopicCommonModule.html</anchorfile>
      <anchor>gacbef216882d62aa1f1bb94f324d55a1b</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_PROTOCOLVERSION_1_1</name>
      <anchorfile>group__DDSBuiltInTopicCommonModule.html</anchorfile>
      <anchor>ga3e9f93ef3df8154dd36543bfc320063b</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_PROTOCOLVERSION_1_2</name>
      <anchorfile>group__DDSBuiltInTopicCommonModule.html</anchorfile>
      <anchor>ga8c8123ba1bd9160bc2c2f9d93cba72b2</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_PROTOCOLVERSION_2_0</name>
      <anchorfile>group__DDSBuiltInTopicCommonModule.html</anchorfile>
      <anchor>ga6e7a5f8c90b537bdde2aa5e26e2f3fb7</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_PROTOCOLVERSION_2_1</name>
      <anchorfile>group__DDSBuiltInTopicCommonModule.html</anchorfile>
      <anchor>gaa3e111c80c7d00ef60b180539a6d0a33</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_PROTOCOLVERSION</name>
      <anchorfile>group__DDSBuiltInTopicCommonModule.html</anchorfile>
      <anchor>ga9f5946fa299dbe973778dda736164392</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_VENDOR_ID_LENGTH_MAX</name>
      <anchorfile>group__DDSBuiltInTopicCommonModule.html</anchorfile>
      <anchor>gad0091b6861c67e30da7ed27dc997faed</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_PRODUCTVERSION_UNKNOWN</name>
      <anchorfile>group__DDSBuiltInTopicCommonModule.html</anchorfile>
      <anchor>ga45ab780bea5de2b264ac5a53a43cff21</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_ProtocolVersion_t</type>
      <name>DDS_ProtocolVersion_t</name>
      <anchorfile>group__DDSBuiltInTopicCommonModule.html</anchorfile>
      <anchor>gafff36fa680db8c47fb3aa339ea236757</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_BuiltinTopicKey_t</type>
      <name>DDS_BuiltinTopicKey_t</name>
      <anchorfile>group__DDSBuiltInTopicCommonModule.html</anchorfile>
      <anchor>gaf7370712c8af0c68ec1816dfb0b3c9ee</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Locator_t</type>
      <name>DDS_LOCATOR_INVALID</name>
      <anchorfile>group__DDSBuiltInTopicCommonModule.html</anchorfile>
      <anchor>ga777c93413c81ebf9eb1966c1cee9080a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const DDS_Long</type>
      <name>DDS_LOCATOR_KIND_INVALID</name>
      <anchorfile>group__DDSBuiltInTopicCommonModule.html</anchorfile>
      <anchor>ga183f155560d36db21e64b32a57414f8e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const DDS_UnsignedLong</type>
      <name>DDS_LOCATOR_PORT_INVALID</name>
      <anchorfile>group__DDSBuiltInTopicCommonModule.html</anchorfile>
      <anchor>gabe68ae00f00a05ee919e9382a7d61c37</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const DDS_Octet</type>
      <name>DDS_LOCATOR_ADDRESS_INVALID</name>
      <anchorfile>group__DDSBuiltInTopicCommonModule.html</anchorfile>
      <anchor>gaeb6d923c716dfb521973a3e77fbe7692</anchor>
      <arglist>[DDS_LOCATOR_ADDRESS_LENGTH_MAX]</arglist>
    </member>
    <member kind="variable">
      <type>const DDS_Long</type>
      <name>DDS_LOCATOR_KIND_UDPv4</name>
      <anchorfile>group__DDSBuiltInTopicCommonModule.html</anchorfile>
      <anchor>ga2a6c499c97f7aa1d7567d446f7596a1e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const DDS_Long</type>
      <name>DDS_LOCATOR_KIND_SHMEM</name>
      <anchorfile>group__DDSBuiltInTopicCommonModule.html</anchorfile>
      <anchor>ga4895d4dd996be1201becf62aa4dc48e5</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const DDS_Long</type>
      <name>DDS_LOCATOR_KIND_UDPv6</name>
      <anchorfile>group__DDSBuiltInTopicCommonModule.html</anchorfile>
      <anchor>ga8f51f1b06735c2b8115494dbe8a49b21</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const DDS_Long</type>
      <name>DDS_LOCATOR_KIND_RESERVED</name>
      <anchorfile>group__DDSBuiltInTopicCommonModule.html</anchorfile>
      <anchor>ga2c22eb72466e1a706df0cf3bfc97b729</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSStringBuiltInTypeModule</name>
    <title>String Built-in Type</title>
    <filename>group__DDSStringBuiltInTypeModule.html</filename>
    <class kind="struct">DDS_StringTypeSupport</class>
    <member kind="typedef">
      <type>struct DDS_StringDataWriter</type>
      <name>DDS_StringDataWriter</name>
      <anchorfile>group__DDSStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga42e247da24b95bf923880476c3519aaa</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_StringDataReader</type>
      <name>DDS_StringDataReader</name>
      <anchorfile>group__DDSStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga0de4ad328f8a4fcf6e7e8a4f1b23f3db</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_StringTypeSupport_register_type</name>
      <anchorfile>group__DDSStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga272ccd2f02c0b84a2f8131cbf1854df1</anchor>
      <arglist>(DDS_DomainParticipant *participant, const char *type_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_StringTypeSupport_unregister_type</name>
      <anchorfile>group__DDSStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga6d729f24bbc0fea1757df0a83aed4de2</anchor>
      <arglist>(DDS_DomainParticipant *participant, const char *type_name)</arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>DDS_StringTypeSupport_get_type_name</name>
      <anchorfile>group__DDSStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga22c4d8fca1ad109b92f5b9a8411f1a82</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>DDS_StringTypeSupport_print_data</name>
      <anchorfile>group__DDSStringBuiltInTypeModule.html</anchorfile>
      <anchor>gadc6fd5de4dfb5fa7eb9c903801b61c50</anchor>
      <arglist>(const char *a_data)</arglist>
    </member>
    <member kind="function">
      <type>DDS_StringDataWriter *</type>
      <name>DDS_StringDataWriter_narrow</name>
      <anchorfile>group__DDSStringBuiltInTypeModule.html</anchorfile>
      <anchor>gadd2577ba63d35b78144602d08d07a1c3</anchor>
      <arglist>(DDS_DataWriter *writer)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DataWriter *</type>
      <name>DDS_StringDataWriter_as_datawriter</name>
      <anchorfile>group__DDSStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga5c2eb1214eed829d85ce986c93b6eb46</anchor>
      <arglist>(DDS_StringDataWriter *writer)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_StringDataWriter_write</name>
      <anchorfile>group__DDSStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga77d9c57a5ef32914e25068a06b678dd5</anchor>
      <arglist>(DDS_StringDataWriter *self, const char *instance_data, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_StringDataWriter_write_w_timestamp</name>
      <anchorfile>group__DDSStringBuiltInTypeModule.html</anchorfile>
      <anchor>gafd53fcd092969c16cf6b6c6677ad8e36</anchor>
      <arglist>(DDS_StringDataWriter *self, const char *instance_data, const DDS_InstanceHandle_t *handle, const struct DDS_Time_t *source_timestamp)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_StringDataWriter_write_w_params</name>
      <anchorfile>group__DDSStringBuiltInTypeModule.html</anchorfile>
      <anchor>gae28b333ef402c9a95744f9d6cb56bc21</anchor>
      <arglist>(DDS_StringDataWriter *self, const char *instance_data, struct DDS_WriteParams_t *params)</arglist>
    </member>
    <member kind="function">
      <type>DDS_StringDataReader *</type>
      <name>DDS_StringDataReader_narrow</name>
      <anchorfile>group__DDSStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga4d231cb6e7dd5e54c5fbe5505eed41f8</anchor>
      <arglist>(DDS_DataReader *reader)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DataReader *</type>
      <name>DDS_StringDataReader_as_datareader</name>
      <anchorfile>group__DDSStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga3d815ef1ff29016bf2c3af99b3d3174b</anchor>
      <arglist>(DDS_StringDataReader *reader)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_StringDataReader_read</name>
      <anchorfile>group__DDSStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga842a9294d216a521a0b3c5cb5a08653a</anchor>
      <arglist>(DDS_StringDataReader *self, struct DDS_StringSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, DDS_SampleStateMask sample_states, DDS_ViewStateMask view_states, DDS_InstanceStateMask instance_states)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_StringDataReader_take</name>
      <anchorfile>group__DDSStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga867f3856b15dbbb5e017ac3789a3645d</anchor>
      <arglist>(DDS_StringDataReader *self, struct DDS_StringSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, DDS_SampleStateMask sample_mask, DDS_ViewStateMask view_mask, DDS_InstanceStateMask instance_mask)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_StringDataReader_read_w_condition</name>
      <anchorfile>group__DDSStringBuiltInTypeModule.html</anchorfile>
      <anchor>gac755dc9331df51d10e9db87eea8ca9ce</anchor>
      <arglist>(DDS_StringDataReader *self, struct DDS_StringSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, DDS_ReadCondition *condition)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_StringDataReader_take_w_condition</name>
      <anchorfile>group__DDSStringBuiltInTypeModule.html</anchorfile>
      <anchor>gaf2f03cc6f7147463c98ac353d52dfdd1</anchor>
      <arglist>(DDS_StringDataReader *self, struct DDS_StringSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, DDS_ReadCondition *condition)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_StringDataReader_read_next_sample</name>
      <anchorfile>group__DDSStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga374273744c5ad5ef2361bd96653b3eed</anchor>
      <arglist>(DDS_StringDataReader *self, char *received_data, struct DDS_SampleInfo *sample_info)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_StringDataReader_take_next_sample</name>
      <anchorfile>group__DDSStringBuiltInTypeModule.html</anchorfile>
      <anchor>gad547628f1e9d44961bdee9762ca4e7fc</anchor>
      <arglist>(DDS_StringDataReader *self, char *received_data, struct DDS_SampleInfo *sample_info)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_StringDataReader_return_loan</name>
      <anchorfile>group__DDSStringBuiltInTypeModule.html</anchorfile>
      <anchor>gac22468e497d8eb70dc8efbc1f09aad8e</anchor>
      <arglist>(DDS_StringDataReader *self, struct DDS_StringSeq *received_data, struct DDS_SampleInfoSeq *info_seq)</arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSKeyedStringBuiltInTypeModule</name>
    <title>KeyedString Built-in Type</title>
    <filename>group__DDSKeyedStringBuiltInTypeModule.html</filename>
    <class kind="struct">DDS_KeyedString</class>
    <class kind="struct">DDS_KeyedStringSeq</class>
    <class kind="struct">DDS_KeyedStringTypeSupport</class>
    <member kind="typedef">
      <type>struct DDS_KeyedString</type>
      <name>DDS_KeyedString</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga1070c7b5d3ec6c078a1e50b3d17630ba</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_KeyedStringDataWriter</type>
      <name>DDS_KeyedStringDataWriter</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga6218b79dbc4292d7ddc3815cfe215858</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_KeyedStringDataReader</type>
      <name>DDS_KeyedStringDataReader</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga812d5351b8d6142ef1c47ad9da5852f2</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>DDS_KeyedString *</type>
      <name>DDS_KeyedString_new</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga608c76ebe132b5e3c1be7cc1950d5435</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>DDS_KeyedString *</type>
      <name>DDS_KeyedString_new_w_size</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>gac2e6e0416f55af85d793f32addd585f2</anchor>
      <arglist>(int key_size, int size)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>DDS_KeyedString_delete</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga5b03a909ace3e790b4a12116efaf94f5</anchor>
      <arglist>(DDS_KeyedString *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedSringTypeSupport_register_type</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>gabac051fc0f4cedc837b9be5899e13561</anchor>
      <arglist>(DDS_DomainParticipant *participant, const char *type_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedSringTypeSupport_unregister_type</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga643931a587061d81eff2889f58a03b90</anchor>
      <arglist>(DDS_DomainParticipant *participant, const char *type_name)</arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>DDS_KeyedSringTypeSupport_get_type_name</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga4b87f3b379fb9a29f95f6d4b57649e61</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>DDS_KeyedStringTypeSupport_print_data</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga42eddee79412d4f354f60c9de1512485</anchor>
      <arglist>(const DDS_KeyedString *a_data)</arglist>
    </member>
    <member kind="function">
      <type>DDS_KeyedStringDataWriter *</type>
      <name>DDS_KeyedStringDataWriter_narrow</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga6c398e8b0a0c90d7bb6ed7d5b1eee8cb</anchor>
      <arglist>(DDS_DataWriter *writer)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DataWriter *</type>
      <name>DDS_KeyedStringDataWriter_as_datawriter</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>gaeab640e651b40495ca6db2a383eaaf9f</anchor>
      <arglist>(DDS_KeyedStringDataWriter *writer)</arglist>
    </member>
    <member kind="function">
      <type>DDS_InstanceHandle_t</type>
      <name>DDS_KeyedStringDataWriter_register_instance</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>gaeb2945551af4fc5aee104797e1cc671f</anchor>
      <arglist>(DDS_KeyedStringDataWriter *self, const DDS_KeyedString *instance_data)</arglist>
    </member>
    <member kind="function">
      <type>DDS_InstanceHandle_t</type>
      <name>DDS_KeyedStringDataWriter_register_instance_w_key</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>gac7a2f559eabf4b52f8aa1b68a2385de2</anchor>
      <arglist>(DDS_KeyedStringDataWriter *self, const char *key)</arglist>
    </member>
    <member kind="function">
      <type>DDS_InstanceHandle_t</type>
      <name>DDS_KeyedStringDataWriter_register_instance_w_timestamp</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga269a64a6fdf4262ca1d6822c8e2adaa1</anchor>
      <arglist>(DDS_KeyedStringDataWriter *self, const DDS_KeyedString *instance_data, const struct DDS_Time_t *source_timestamp)</arglist>
    </member>
    <member kind="function">
      <type>DDS_InstanceHandle_t</type>
      <name>DDS_KeyedStringDataWriter_register_instance_w_key_w_timestamp</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>gaef64f6641f4006a92f979dd5af1c12aa</anchor>
      <arglist>(DDS_KeyedStringDataWriter *self, const char *key, const struct DDS_Time_t *source_timestamp)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataWriter_unregister_instance</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>gac5de38592a90706e276933bdfcd8a12a</anchor>
      <arglist>(DDS_KeyedStringDataWriter *self, const DDS_KeyedString *instance_data, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataWriter_unregister_instance_w_key</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>gaafb5c16c8a5d6d72252ad0ec8774d811</anchor>
      <arglist>(DDS_KeyedStringDataWriter *self, const char *key, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataWriter_unregister_instance_w_timestamp</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga2f2f67f37af325eb55f7ca36ece1ea70</anchor>
      <arglist>(DDS_KeyedStringDataWriter *self, const DDS_KeyedString *instance_data, const DDS_InstanceHandle_t *handle, const struct DDS_Time_t *source_timestamp)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataWriter_unregister_instance_w_key_w_timestamp</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga228d5e74edda222d2f9dcddc8ce4e62a</anchor>
      <arglist>(DDS_KeyedStringDataWriter *self, const char *key, const DDS_InstanceHandle_t *handle, const struct DDS_Time_t *source_timestamp)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataWriter_write</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>gaa9413ea591350ee035c18c348e2d8613</anchor>
      <arglist>(DDS_KeyedStringDataWriter *self, const DDS_KeyedString *instance_data, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataWriter_write_string_w_key</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga4c97cb926ef40be57985aa2d2dc3acb9</anchor>
      <arglist>(DDS_KeyedStringDataWriter *self, const char *key, const char *str, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataWriter_write_w_timestamp</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga0c55bdf224b8bb725bf26553ff5d1bf5</anchor>
      <arglist>(DDS_KeyedStringDataWriter *self, const DDS_KeyedString *instance_data, const DDS_InstanceHandle_t *handle, const struct DDS_Time_t *source_timestamp)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataWriter_write_string_w_key_w_timestamp</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga07c9fe1d7c5f60f308129ecc35708308</anchor>
      <arglist>(DDS_KeyedStringDataWriter *self, const char *key, const char *str, const DDS_InstanceHandle_t *handle, const struct DDS_Time_t *source_timestamp)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataWriter_write_w_params</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga7ab0cc8ad5fb9ed032ec303e896211d8</anchor>
      <arglist>(DDS_KeyedStringDataWriter *self, const DDS_KeyedString *instance_data, struct DDS_WriteParams_t *params)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataWriter_write_string_w_key_w_params</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>gae4d346855832fdf4111b9494ca74ed54</anchor>
      <arglist>(DDS_KeyedStringDataWriter *self, const char *key, const char *str, struct DDS_WriteParams_t *params)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataWriter_dispose</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>gaa7c23557a59dec631f9d6a0f2e7e2728</anchor>
      <arglist>(DDS_KeyedStringDataWriter *self, const DDS_KeyedString *instance_data, const DDS_InstanceHandle_t *instance_handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataWriter_dispose_w_key</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>gabbc1668084bf0fb461e1f676855b18f7</anchor>
      <arglist>(DDS_KeyedStringDataWriter *self, const char *key, const DDS_InstanceHandle_t *instance_handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataWriter_dispose_w_timestamp</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga57e49ad2cd534bfe80026b0612faf262</anchor>
      <arglist>(DDS_KeyedStringDataWriter *self, const DDS_KeyedString *instance_data, const DDS_InstanceHandle_t *instance_handle, const struct DDS_Time_t *source_timestamp)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataWriter_dispose_w_key_w_timestamp</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga9531363ef723d6279c0816bbfefe5b1f</anchor>
      <arglist>(DDS_KeyedStringDataWriter *self, const char *key, const DDS_InstanceHandle_t *instance_handle, const struct DDS_Time_t *source_timestamp)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataWriter_get_key_value</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>gab4f3422990380ac433c4834eacec464c</anchor>
      <arglist>(DDS_KeyedStringDataWriter *self, DDS_KeyedString *key_holder, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataWriter_get_key_value_w_key</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga4320396ba2222aabc51a6a1a05a1d35d</anchor>
      <arglist>(DDS_KeyedStringDataWriter *self, char *key, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_InstanceHandle_t</type>
      <name>DDS_KeyedStringDataWriter_lookup_instance</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>gad7289e6a876ba92a4630f683180fd774</anchor>
      <arglist>(DDS_KeyedStringDataWriter *self, const DDS_KeyedString *key_holder)</arglist>
    </member>
    <member kind="function">
      <type>DDS_InstanceHandle_t</type>
      <name>DDS_KeyedStringDataWriter_lookup_instance_w_key</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga2bea346b6914d6a7edb13bde774ac5ba</anchor>
      <arglist>(DDS_KeyedStringDataWriter *self, const char *key)</arglist>
    </member>
    <member kind="function">
      <type>DDS_KeyedStringDataReader *</type>
      <name>DDS_KeyedStringDataReader_narrow</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga583d1a18a9419a777c30e78d72a61f57</anchor>
      <arglist>(DDS_DataReader *reader)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DataReader *</type>
      <name>DDS_KeyedStringDataReader_as_datareader</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>gadeacd8b5a6aa3d5b3f375f6dd1cb16f6</anchor>
      <arglist>(DDS_KeyedStringDataReader *reader)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataReader_read</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga4838e99cf20ec12091fb9260e5cda79b</anchor>
      <arglist>(DDS_KeyedStringDataReader *self, struct DDS_KeyedStringSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, DDS_SampleStateMask sample_states, DDS_ViewStateMask view_states, DDS_InstanceStateMask instance_states)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataReader_take</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga54a8cc74decceddbfc8418a775ce75bc</anchor>
      <arglist>(DDS_KeyedStringDataReader *self, struct DDS_KeyedStringSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, DDS_SampleStateMask sample_mask, DDS_ViewStateMask view_mask, DDS_InstanceStateMask instance_mask)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataReader_read_w_condition</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>gadf522a9b3717bcf1b11666643fad177a</anchor>
      <arglist>(DDS_KeyedStringDataReader *self, struct DDS_KeyedStringSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, DDS_ReadCondition *condition)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataReader_take_w_condition</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>gafb3d11c19cd9462f4fd6886d5efd50f3</anchor>
      <arglist>(DDS_KeyedStringDataReader *self, struct DDS_KeyedStringSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, DDS_ReadCondition *condition)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataReader_read_next_sample</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>gaa78ca3646ec1ba5efca2044c24d3eefb</anchor>
      <arglist>(DDS_KeyedStringDataReader *self, DDS_KeyedString *received_data, struct DDS_SampleInfo *sample_info)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataReader_take_next_sample</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga19981930f32e59422fce2f9a4be694d1</anchor>
      <arglist>(DDS_KeyedStringDataReader *self, DDS_KeyedString *received_data, struct DDS_SampleInfo *sample_info)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataReader_read_instance</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga88767038c33fc07e0fcfd5c470389800</anchor>
      <arglist>(DDS_KeyedStringDataReader *self, struct DDS_KeyedStringSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, const DDS_InstanceHandle_t *a_handle, DDS_SampleStateMask sample_states, DDS_ViewStateMask view_states, DDS_InstanceStateMask instance_states)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataReader_take_instance</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga2f142525a9d497ad8547652ac3c8bac4</anchor>
      <arglist>(DDS_KeyedStringDataReader *self, struct DDS_KeyedStringSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, const DDS_InstanceHandle_t *a_handle, DDS_SampleStateMask sample_states, DDS_ViewStateMask view_states, DDS_InstanceStateMask instance_states)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataReader_read_instance_w_condition</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga5e40d66ce50a67e39c232838ae504e86</anchor>
      <arglist>(DDS_KeyedStringDataReader *self, struct DDS_KeyedStringSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, const DDS_InstanceHandle_t *a_handle, DDS_ReadCondition *condition)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataReader_take_instance_w_condition</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>gaecfc3a99e90d1d667b085be2f6e26c0d</anchor>
      <arglist>(DDS_KeyedStringDataReader *self, struct DDS_KeyedStringSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, const DDS_InstanceHandle_t *a_handle, DDS_ReadCondition *condition)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataReader_read_next_instance</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>gac2402f204769de0f0f94f175b6b408a4</anchor>
      <arglist>(DDS_KeyedStringDataReader *self, struct DDS_KeyedStringSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, const DDS_InstanceHandle_t *previous_handle, DDS_SampleStateMask sample_states, DDS_ViewStateMask view_states, DDS_InstanceStateMask instance_states)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataReader_take_next_instance</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga6806a561c1dd64944cd574f8b4b6e25f</anchor>
      <arglist>(DDS_KeyedStringDataReader *self, struct DDS_KeyedStringSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, const DDS_InstanceHandle_t *previous_handle, DDS_SampleStateMask sample_states, DDS_ViewStateMask view_states, DDS_InstanceStateMask instance_states)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataReader_read_next_instance_w_condition</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga3499f958d714fca95bacbf983d30598e</anchor>
      <arglist>(DDS_KeyedStringDataReader *self, struct DDS_KeyedStringSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, const DDS_InstanceHandle_t *previous_handle, DDS_ReadCondition *condition)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataReader_take_next_instance_w_condition</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>gad83df165f404f06c8cc85d1657fcbd02</anchor>
      <arglist>(DDS_KeyedStringDataReader *self, struct DDS_KeyedStringSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, const DDS_InstanceHandle_t *previous_handle, DDS_ReadCondition *condition)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataReader_return_loan</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga9fbe01452f538f2da472e35a6c247a15</anchor>
      <arglist>(DDS_KeyedStringDataReader *self, struct DDS_KeyedStringSeq *received_data, struct DDS_SampleInfoSeq *info_seq)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataReader_get_key_value</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>gabdeca11d7a29e8c2e915168ab14d0c78</anchor>
      <arglist>(DDS_KeyedStringDataReader *self, DDS_KeyedString *key_holder, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedStringDataReader_get_key_value_w_key</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga1abdbcbb6fe15844733c5610c6c6e56f</anchor>
      <arglist>(DDS_KeyedStringDataReader *self, char *key, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_InstanceHandle_t</type>
      <name>DDS_KeyedStringDataReader_lookup_instance</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga6d65dbaf36f596b0ff44d4cbe3bd4df2</anchor>
      <arglist>(DDS_KeyedStringDataReader *self, const DDS_KeyedString *key_holder)</arglist>
    </member>
    <member kind="function">
      <type>DDS_InstanceHandle_t</type>
      <name>DDS_KeyedStringDataReader_lookup_instance_w_key</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>gaec7413b956c5053c81f5b0c00e3eeac2</anchor>
      <arglist>(DDS_KeyedStringDataReader *self, const char *key)</arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>key</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga9778538b061fdaa0754773883fc5fe8f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>value</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga4c3046a4749745d072d5be067d718e1e</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSOctetsBuiltInTypeModule</name>
    <title>Octets Built-in Type</title>
    <filename>group__DDSOctetsBuiltInTypeModule.html</filename>
    <class kind="struct">DDS_Octets</class>
    <class kind="struct">DDS_OctetsSeq</class>
    <class kind="struct">DDS_OctetsTypeSupport</class>
    <member kind="typedef">
      <type>struct DDS_Octets</type>
      <name>DDS_Octets</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gab5725d9c97e69da5403bb22e85530142</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_OctetsDataWriter</type>
      <name>DDS_OctetsDataWriter</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gaabab93677ac18842fd8e71955c6683c4</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_OctetsDataReader</type>
      <name>DDS_OctetsDataReader</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga112765bd75d3ffb25b3a53b8f09f4072</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>DDS_Octets *</type>
      <name>DDS_Octets_new</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gaf2b235720d118e100911816456bf3589</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>DDS_Octets *</type>
      <name>DDS_Octets_new_w_size</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gaa209a88ecfb114d25338aff9f6c1a050</anchor>
      <arglist>(int size)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>DDS_Octets_delete</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gabb07f43a46f72df677c0c019dafd2505</anchor>
      <arglist>(DDS_Octets *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_OctetsTypeSupport_register_type</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga2051a8c6f8a639904d321e3983d5d7b4</anchor>
      <arglist>(DDS_DomainParticipant *participant, const char *type_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_OctetsTypeSupport_unregister_type</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gaa031fe6529790749583d5e173fb938c3</anchor>
      <arglist>(DDS_DomainParticipant *participant, const char *type_name)</arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>DDS_OctetsTypeSupport_get_type_name</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga25219166130b848c58ce3415d5c18880</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>DDS_OctetsTypeSupport_print_data</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga9616bcdc9e172d2810daa6c51f77936f</anchor>
      <arglist>(const DDS_Octets *a_data)</arglist>
    </member>
    <member kind="function">
      <type>DDS_OctetsDataWriter *</type>
      <name>DDS_OctetsDataWriter_narrow</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga67db8eef25e49bce99b73eade4c51e45</anchor>
      <arglist>(DDS_DataWriter *writer)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DataWriter *</type>
      <name>DDS_OctetsDataWriter_as_datawriter</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga9cab7fc51dfa9d9228558ce889306b94</anchor>
      <arglist>(DDS_OctetsDataWriter *writer)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_OctetsDataWriter_write</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga272e402d04f18a2900c7cc5d94d67503</anchor>
      <arglist>(DDS_OctetsDataWriter *self, const DDS_Octets *instance_data, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_OctetsDataWriter_write_octets</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga2480c6875c610610594e036855e90260</anchor>
      <arglist>(DDS_OctetsDataWriter *self, const unsigned char *octets, int length, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_OctetsDataWriter_write_octets_seq</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga9a2b2d9a499f87c797331eafa91c6c26</anchor>
      <arglist>(DDS_OctetsDataWriter *self, const struct DDS_OctetSeq *octets, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_OctetsDataWriter_write_w_timestamp</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gae595840f68ea1ee10389b871a0cae853</anchor>
      <arglist>(DDS_OctetsDataWriter *self, const DDS_Octets *instance_data, const DDS_InstanceHandle_t *handle, const struct DDS_Time_t *source_timestamp)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_OctetsDataWriter_write_octets_w_timestamp</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga0e72c82d0273230e03c473c822bbcbd9</anchor>
      <arglist>(DDS_OctetsDataWriter *self, const unsigned char *octets, int length, const DDS_InstanceHandle_t *handle, const struct DDS_Time_t *source_timestamp)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_OctetsDataWriter_write_octets_seq_w_timestamp</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga82c01787aa1d349a6a1cb7bf9d098a2c</anchor>
      <arglist>(DDS_OctetsDataWriter *self, const struct DDS_OctetSeq *octets, const DDS_InstanceHandle_t *handle, const struct DDS_Time_t *source_timestamp)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_OctetsDataWriter_write_w_params</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gac4cb7c28ff293f089c762740e75b8c53</anchor>
      <arglist>(DDS_OctetsDataWriter *self, const DDS_Octets *instance_data, struct DDS_WriteParams_t *params)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_OctetsDataWriter_write_octets_w_params</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga76f5ddce013de9ceff5fee09649eb37a</anchor>
      <arglist>(DDS_OctetsDataWriter *self, const unsigned char *octets, int length, struct DDS_WriteParams_t *params)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_OctetsDataWriter_write_octets_seq_w_params</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga7490453e427d752e5365b821b235dd4b</anchor>
      <arglist>(DDS_OctetsDataWriter *self, const struct DDS_OctetSeq *octets, struct DDS_WriteParams_t *params)</arglist>
    </member>
    <member kind="function">
      <type>DDS_OctetsDataReader *</type>
      <name>DDS_OctetsDataReader_narrow</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gae09cdfee4f475aee570ea907e7ee2271</anchor>
      <arglist>(DDS_DataReader *reader)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DataReader *</type>
      <name>DDS_OctetsDataReader_as_datareader</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga660f4da8f294fd28ac6a2b895874c4b1</anchor>
      <arglist>(DDS_OctetsDataReader *reader)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_OctetsDataReader_read</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga08f53d2bda92abbfb2ac79a4a2f4bbf0</anchor>
      <arglist>(DDS_OctetsDataReader *self, struct DDS_OctetsSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, DDS_SampleStateMask sample_states, DDS_ViewStateMask view_states, DDS_InstanceStateMask instance_states)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_OctetsDataReader_take</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga20dd2d589175c0fe17c1074a5b67591d</anchor>
      <arglist>(DDS_OctetsDataReader *self, struct DDS_OctetsSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, DDS_SampleStateMask sample_mask, DDS_ViewStateMask view_mask, DDS_InstanceStateMask instance_mask)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_OctetsDataReader_read_w_condition</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga9d5ef076e0f659a0a0be9a15b53a9491</anchor>
      <arglist>(DDS_OctetsDataReader *self, struct DDS_OctetsSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, DDS_ReadCondition *condition)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_OctetsDataReader_take_w_condition</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga217b9034466b8538a2be14fd638dfc25</anchor>
      <arglist>(DDS_OctetsDataReader *self, struct DDS_OctetsSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, DDS_ReadCondition *condition)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_OctetsDataReader_read_next_sample</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga16851a6ec2e5e9bdd4bb27d94d641146</anchor>
      <arglist>(DDS_OctetsDataReader *self, DDS_Octets *received_data, struct DDS_SampleInfo *sample_info)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_OctetsDataReader_take_next_sample</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga7519a83115c62d8b2dda2ceeac475137</anchor>
      <arglist>(DDS_OctetsDataReader *self, DDS_Octets *received_data, struct DDS_SampleInfo *sample_info)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_OctetsDataReader_return_loan</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga8f31d95f28c1f910f84dda44b1cfc611</anchor>
      <arglist>(DDS_OctetsDataReader *self, struct DDS_OctetsSeq *received_data, struct DDS_SampleInfoSeq *info_seq)</arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>length</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga67c79fe81ce668b1493fb9446df4c570</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>unsigned char *</type>
      <name>value</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gae289d9fba09f3386ba897fd02969df29</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSKeyedOctetsBuiltInTypeModule</name>
    <title>KeyedOctets Built-in Type</title>
    <filename>group__DDSKeyedOctetsBuiltInTypeModule.html</filename>
    <class kind="struct">DDS_KeyedOctets</class>
    <class kind="struct">DDS_KeyedOctetsSeq</class>
    <class kind="struct">DDS_KeyedOctetsTypeSupport</class>
    <member kind="typedef">
      <type>struct DDS_KeyedOctets</type>
      <name>DDS_KeyedOctets</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga3eb73e296c04f87f595ef7f3275d7f2d</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_KeyedOctetsDataWriter</type>
      <name>DDS_KeyedOctetsDataWriter</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga533c8533a573f4d9ae9138ddb1986a14</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_KeyedOctetsDataReader</type>
      <name>DDS_KeyedOctetsDataReader</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga6f5cd1fddceb3e00e4bd3c6ad8c0b9e1</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>DDS_KeyedOctets *</type>
      <name>DDS_KeyedOctets_new</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gaeb6475aecfadc222f202c1ccc4ca32b6</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>DDS_KeyedOctets *</type>
      <name>DDS_KeyedOctets_new_w_size</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga3b87b7e92dd27ca099ca7ec3edeef456</anchor>
      <arglist>(int key_size, int size)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>DDS_KeyedOctets_delete</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gaff67b9544580ee183501317d8b1cbb90</anchor>
      <arglist>(DDS_KeyedOctets *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsTypeSupport_register_type</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga76c763a6fb364ad34e5ba8129cfc5ec5</anchor>
      <arglist>(DDS_DomainParticipant *participant, const char *type_name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsTypeSupport_unregister_type</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga1568f700846355ad74a7a93db3779a83</anchor>
      <arglist>(DDS_DomainParticipant *participant, const char *type_name)</arglist>
    </member>
    <member kind="function">
      <type>const char *</type>
      <name>DDS_KeyedOctetsTypeSupport_get_type_name</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga0cff30822105a378dda1b78ff8d25ca4</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>DDS_KeyedOctetsTypeSupport_print_data</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gade2448666c6228d64782338b0d67bf3d</anchor>
      <arglist>(const DDS_KeyedOctets *a_data)</arglist>
    </member>
    <member kind="function">
      <type>DDS_KeyedOctetsDataWriter *</type>
      <name>DDS_KeyedOctetsDataWriter_narrow</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga6316b662a580e6658bd4aa2fff212f84</anchor>
      <arglist>(DDS_DataWriter *writer)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DataWriter *</type>
      <name>DDS_KeyedOctetsDataWriter_as_datawriter</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga9deebf5e67af2f7124555978fae684bd</anchor>
      <arglist>(DDS_KeyedOctetsDataWriter *writer)</arglist>
    </member>
    <member kind="function">
      <type>DDS_InstanceHandle_t</type>
      <name>DDS_KeyedOctetsDataWriter_register_instance</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga69dfe78c581bec946928a4ccfec5d74d</anchor>
      <arglist>(DDS_KeyedOctetsDataWriter *self, const DDS_KeyedOctets *instance_data)</arglist>
    </member>
    <member kind="function">
      <type>DDS_InstanceHandle_t</type>
      <name>DDS_KeyedOctetsDataWriter_register_instance_w_key</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga60b852a88bc55aaeff0cf1201fd58088</anchor>
      <arglist>(DDS_KeyedOctetsDataWriter *self, const char *key)</arglist>
    </member>
    <member kind="function">
      <type>DDS_InstanceHandle_t</type>
      <name>DDS_KeyedOctetsDataWriter_register_instance_w_timestamp</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga6f7e2f098da5a0b0c544f42ed61805e7</anchor>
      <arglist>(DDS_KeyedOctetsDataWriter *self, const DDS_KeyedOctets *instance_data, const struct DDS_Time_t *source_timestamp)</arglist>
    </member>
    <member kind="function">
      <type>DDS_InstanceHandle_t</type>
      <name>DDS_KeyedOctetsDataWriter_register_instance_w_key_w_timestamp</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga12b79ce2c4b0f38ee9f02a9c385f5d3a</anchor>
      <arglist>(DDS_KeyedOctetsDataWriter *self, const char *key, const struct DDS_Time_t *source_timestamp)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataWriter_unregister_instance</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gaf17fb1251b752eec926d4e00cda5e272</anchor>
      <arglist>(DDS_KeyedOctetsDataWriter *self, const DDS_KeyedOctets *instance_data, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataWriter_unregister_instance_w_key</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gaea81518937cfd62183f926bcdf4c731d</anchor>
      <arglist>(DDS_KeyedOctetsDataWriter *self, const char *key, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataWriter_unregister_instance_w_timestamp</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga729351dbce3a6d61b4783ef4e6476373</anchor>
      <arglist>(DDS_KeyedOctetsDataWriter *self, const DDS_KeyedOctets *instance_data, const DDS_InstanceHandle_t *handle, const struct DDS_Time_t *source_timestamp)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataWriter_unregister_instance_w_key_w_timestamp</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gab15c82eb1e728479df3bc41b797ac614</anchor>
      <arglist>(DDS_KeyedOctetsDataWriter *self, const char *key, const DDS_InstanceHandle_t *handle, const struct DDS_Time_t *source_timestamp)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataWriter_write</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga0fd49376cf05035c61d7ff1097d2d327</anchor>
      <arglist>(DDS_KeyedOctetsDataWriter *self, const DDS_KeyedOctets *instance_data, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataWriter_write_octets_w_key</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga7b56f2d9dfa879efd009e1a18662e95e</anchor>
      <arglist>(DDS_KeyedOctetsDataWriter *self, const char *key, const unsigned char *octets, int length, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataWriter_write_octets_seq_w_key</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gad58c09abb79f262ea66da70568be0787</anchor>
      <arglist>(DDS_KeyedOctetsDataWriter *self, const char *key, const struct DDS_OctetSeq *octets, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataWriter_write_w_timestamp</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gaad08f2d9d8825451a5beb4b44180da56</anchor>
      <arglist>(DDS_KeyedOctetsDataWriter *self, const DDS_KeyedOctets *instance_data, const DDS_InstanceHandle_t *handle, const struct DDS_Time_t *source_timestamp)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataWriter_write_octets_w_key_w_timestamp</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gaba63792afd2fcbf6b6cec6e24e88d26e</anchor>
      <arglist>(DDS_KeyedOctetsDataWriter *self, const char *key, const unsigned char *octets, int length, const DDS_InstanceHandle_t *handle, const struct DDS_Time_t *source_timestamp)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataWriter_write_octets_seq_w_key_w_timestamp</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga895fb357e69959a94007c0de86249a39</anchor>
      <arglist>(DDS_KeyedOctetsDataWriter *self, const char *key, const struct DDS_OctetSeq *octets, const DDS_InstanceHandle_t *handle, const struct DDS_Time_t *source_timestamp)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataWriter_write_w_params</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gaa36c5654decf2a26a68eb99fcff8ed5a</anchor>
      <arglist>(DDS_KeyedOctetsDataWriter *self, const DDS_KeyedOctets *instance_data, struct DDS_WriteParams_t *params)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataWriter_write_octets_w_key_w_params</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gaf66d17f3fff2629023726a0c200820ad</anchor>
      <arglist>(DDS_KeyedOctetsDataWriter *self, const char *key, const unsigned char *octets, int length, struct DDS_WriteParams_t *params)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataWriter_write_octets_seq_w_key_w_params</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga1bce4e0186496e48ab86913a8d23533f</anchor>
      <arglist>(DDS_KeyedOctetsDataWriter *self, const char *key, const struct DDS_OctetSeq *octets, struct DDS_WriteParams_t *params)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataWriter_dispose</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga8ad4b47b0b7e1dc905dbdea4dab38d35</anchor>
      <arglist>(DDS_KeyedOctetsDataWriter *self, const DDS_KeyedOctets *instance_data, const DDS_InstanceHandle_t *instance_handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataWriter_dispose_w_key</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga83ef43cb41adf29267fcd8854ba504bc</anchor>
      <arglist>(DDS_KeyedOctetsDataWriter *self, const char *key, const DDS_InstanceHandle_t *instance_handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataWriter_dispose_w_timestamp</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gac8e76efd730e4d2ec30c0ee59c02af26</anchor>
      <arglist>(DDS_KeyedOctetsDataWriter *self, const DDS_KeyedOctets *instance_data, const DDS_InstanceHandle_t *instance_handle, const struct DDS_Time_t *source_timestamp)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataWriter_dispose_w_key_w_timestamp</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga0904534edcc79e075614d63895eca749</anchor>
      <arglist>(DDS_KeyedOctetsDataWriter *self, const char *key, const DDS_InstanceHandle_t *instance_handle, const struct DDS_Time_t *source_timestamp)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataWriter_get_key_value</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gae4e1ab2f8c6f60cb3f8503c8d105c5f1</anchor>
      <arglist>(DDS_KeyedOctetsDataWriter *self, DDS_KeyedOctets *key_holder, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataWriter_get_key_value_w_key</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gadfb3dd49d14e3798556d83515e7bc017</anchor>
      <arglist>(DDS_KeyedOctetsDataWriter *self, char *key, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_InstanceHandle_t</type>
      <name>DDS_KeyedOctetsDataWriter_lookup_instance</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gabb1e7aadda07364030a9bffca66d35cb</anchor>
      <arglist>(DDS_KeyedOctetsDataWriter *self, const DDS_KeyedOctets *key_holder)</arglist>
    </member>
    <member kind="function">
      <type>DDS_InstanceHandle_t</type>
      <name>DDS_KeyedOctetsDataWriter_lookup_instance_w_key</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga235b28d9d2bc21bde6303374af8145df</anchor>
      <arglist>(DDS_KeyedOctetsDataWriter *self, const char *key)</arglist>
    </member>
    <member kind="function">
      <type>DDS_KeyedOctetsDataReader *</type>
      <name>DDS_KeyedOctetsDataReader_narrow</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gac040d76628bb45a6f57888582b650f55</anchor>
      <arglist>(DDS_DataReader *reader)</arglist>
    </member>
    <member kind="function">
      <type>DDS_DataReader *</type>
      <name>DDS_KeyedOctetsDataReader_as_datareader</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gaf5b8af11ecfe961dcffb66bfdfc0f391</anchor>
      <arglist>(DDS_KeyedOctetsDataReader *reader)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataReader_read</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gaf475e022c07c10207c235d7c7759a024</anchor>
      <arglist>(DDS_KeyedOctetsDataReader *self, struct DDS_KeyedOctetsSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, DDS_SampleStateMask sample_states, DDS_ViewStateMask view_states, DDS_InstanceStateMask instance_states)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataReader_take</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga60e739c6b01409352e482ba35e96f3dc</anchor>
      <arglist>(DDS_KeyedOctetsDataReader *self, struct DDS_KeyedOctetsSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, DDS_SampleStateMask sample_mask, DDS_ViewStateMask view_mask, DDS_InstanceStateMask instance_mask)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataReader_read_w_condition</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gab8157484adb885b92fb0e4a62159f142</anchor>
      <arglist>(DDS_KeyedOctetsDataReader *self, struct DDS_KeyedOctetsSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, DDS_ReadCondition *condition)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataReader_take_w_condition</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga5e86be5b2cfec13fe95caba55d54cd1f</anchor>
      <arglist>(DDS_KeyedOctetsDataReader *self, struct DDS_KeyedOctetsSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, DDS_ReadCondition *condition)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataReader_read_next_sample</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga415413389e995c5e59393ac4a6777e33</anchor>
      <arglist>(DDS_KeyedOctetsDataReader *self, DDS_KeyedOctets *received_data, struct DDS_SampleInfo *sample_info)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataReader_take_next_sample</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga6d1f2ae3cf1b75b9b9d4ac701781a13b</anchor>
      <arglist>(DDS_KeyedOctetsDataReader *self, DDS_KeyedOctets *received_data, struct DDS_SampleInfo *sample_info)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataReader_read_instance</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga69abf7ab20412e0df355bd2c4e72087d</anchor>
      <arglist>(DDS_KeyedOctetsDataReader *self, struct DDS_KeyedOctetsSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, const DDS_InstanceHandle_t *a_handle, DDS_SampleStateMask sample_states, DDS_ViewStateMask view_states, DDS_InstanceStateMask instance_states)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataReader_take_instance</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga08e45903a54eddf3351fb155d8008ddb</anchor>
      <arglist>(DDS_KeyedOctetsDataReader *self, struct DDS_KeyedOctetsSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, const DDS_InstanceHandle_t *a_handle, DDS_SampleStateMask sample_states, DDS_ViewStateMask view_states, DDS_InstanceStateMask instance_states)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataReader_read_instance_w_condition</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gafd39dbd6ebe10f5333e6845ff67d74cd</anchor>
      <arglist>(DDS_KeyedOctetsDataReader *self, struct DDS_KeyedOctetsSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, const DDS_InstanceHandle_t *a_handle, DDS_ReadCondition *condition)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataReader_take_instance_w_condition</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gae13c8712c45503780b8ee1f841dfb513</anchor>
      <arglist>(DDS_KeyedOctetsDataReader *self, struct DDS_KeyedOctetsSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, const DDS_InstanceHandle_t *a_handle, DDS_ReadCondition *condition)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataReader_read_next_instance</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga3305b09b50e3b710af3f832dda210820</anchor>
      <arglist>(DDS_KeyedOctetsDataReader *self, struct DDS_KeyedOctetsSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, const DDS_InstanceHandle_t *previous_handle, DDS_SampleStateMask sample_states, DDS_ViewStateMask view_states, DDS_InstanceStateMask instance_states)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataReader_take_next_instance</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gaf2589e79f242d35fda5a74d31140683d</anchor>
      <arglist>(DDS_KeyedOctetsDataReader *self, struct DDS_KeyedOctetsSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, const DDS_InstanceHandle_t *previous_handle, DDS_SampleStateMask sample_states, DDS_ViewStateMask view_states, DDS_InstanceStateMask instance_states)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataReader_read_next_instance_w_condition</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga2e4a16b55aae878a52011f93e5e77cb8</anchor>
      <arglist>(DDS_KeyedOctetsDataReader *self, struct DDS_KeyedOctetsSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, const DDS_InstanceHandle_t *previous_handle, DDS_ReadCondition *condition)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataReader_take_next_instance_w_condition</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga0ea3b1face1991957104b2d4d6847f48</anchor>
      <arglist>(DDS_KeyedOctetsDataReader *self, struct DDS_KeyedOctetsSeq *received_data, struct DDS_SampleInfoSeq *info_seq, DDS_Long max_samples, const DDS_InstanceHandle_t *previous_handle, DDS_ReadCondition *condition)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataReader_return_loan</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gad6bb9c159ad667e35bf3ea8a360ac7fe</anchor>
      <arglist>(DDS_KeyedOctetsDataReader *self, struct DDS_KeyedOctetsSeq *received_data, struct DDS_SampleInfoSeq *info_seq)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataReader_get_key_value</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga37be2bcebc696f19d2051878f09939db</anchor>
      <arglist>(DDS_KeyedOctetsDataReader *self, DDS_KeyedOctets *key_holder, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_KeyedOctetsDataReader_get_key_value_w_key</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gaa764aba721e5d96b77e57bdf9298ed13</anchor>
      <arglist>(DDS_KeyedOctetsDataReader *self, char *key, const DDS_InstanceHandle_t *handle)</arglist>
    </member>
    <member kind="function">
      <type>DDS_InstanceHandle_t</type>
      <name>DDS_KeyedOctetsDataReader_lookup_instance</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga69c93ecfd2d56ae73591a78f0776bb68</anchor>
      <arglist>(DDS_KeyedOctetsDataReader *self, const DDS_KeyedOctets *key_holder)</arglist>
    </member>
    <member kind="function">
      <type>DDS_InstanceHandle_t</type>
      <name>DDS_KeyedOctetsDataReader_lookup_instance_w_key</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gaf5a9125c80c9e64af7c9b39fa5096f89</anchor>
      <arglist>(DDS_KeyedOctetsDataReader *self, const char *key)</arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>key</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga7551f6b447effb4c5777339742c5e87f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>length</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga9d871f7ab4c38162a1f90ced4c758721</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>unsigned char *</type>
      <name>value</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga05e97b4efdbf5dde0ed62107fa61a1b4</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSCdrTypesModule</name>
    <title>DDS-Specific Primitive Types</title>
    <filename>group__DDSCdrTypesModule.html</filename>
    <member kind="define">
      <type>#define</type>
      <name>DDS_BOOLEAN_TRUE</name>
      <anchorfile>group__DDSCdrTypesModule.html</anchorfile>
      <anchor>ga02f257a405ea7ff6774cdf4330a7eeb7</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_BOOLEAN_FALSE</name>
      <anchorfile>group__DDSCdrTypesModule.html</anchorfile>
      <anchor>ga727fba6a96485884ccd9438b560689f7</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>RTICdrChar</type>
      <name>DDS_Char</name>
      <anchorfile>group__DDSCdrTypesModule.html</anchorfile>
      <anchor>ga52b7c73f7d6651698b94c6f54e684eae</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>RTICdrWchar</type>
      <name>DDS_Wchar</name>
      <anchorfile>group__DDSCdrTypesModule.html</anchorfile>
      <anchor>gaa2228e76a7db79b579c627e8a490881b</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>RTICdrOctet</type>
      <name>DDS_Octet</name>
      <anchorfile>group__DDSCdrTypesModule.html</anchorfile>
      <anchor>gab9ec5daedfecddbf5a37220cd2504520</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>RTICdrShort</type>
      <name>DDS_Short</name>
      <anchorfile>group__DDSCdrTypesModule.html</anchorfile>
      <anchor>ga5c45604a5d9e8be405ea0dea959b0071</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>RTICdrUnsignedShort</type>
      <name>DDS_UnsignedShort</name>
      <anchorfile>group__DDSCdrTypesModule.html</anchorfile>
      <anchor>ga68374a805f8c104e6934d0a47cf54298</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>RTICdrLong</type>
      <name>DDS_Long</name>
      <anchorfile>group__DDSCdrTypesModule.html</anchorfile>
      <anchor>gadf1aad514e46148e661fc43b61845ed6</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>RTICdrUnsignedLong</type>
      <name>DDS_UnsignedLong</name>
      <anchorfile>group__DDSCdrTypesModule.html</anchorfile>
      <anchor>gadbd3ff0fba5330c85014a151f43b0fc8</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>RTICdrLongLong</type>
      <name>DDS_LongLong</name>
      <anchorfile>group__DDSCdrTypesModule.html</anchorfile>
      <anchor>ga1c8d04063125d4f5c0a42cd396fabd42</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>RTICdrUnsignedLongLong</type>
      <name>DDS_UnsignedLongLong</name>
      <anchorfile>group__DDSCdrTypesModule.html</anchorfile>
      <anchor>ga6f969d5cfd1dd4164621d446e83e56ec</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>RTICdrFloat</type>
      <name>DDS_Float</name>
      <anchorfile>group__DDSCdrTypesModule.html</anchorfile>
      <anchor>ga49b020b975c192a1304f36b72d9b3fd8</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>RTICdrDouble</type>
      <name>DDS_Double</name>
      <anchorfile>group__DDSCdrTypesModule.html</anchorfile>
      <anchor>ga52c57e877eb64b8fe422cf7ef500fed6</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>RTICdrLongDouble</type>
      <name>DDS_LongDouble</name>
      <anchorfile>group__DDSCdrTypesModule.html</anchorfile>
      <anchor>ga456ca82fcd389ec28b50dae7bdb7ec84</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>RTICdrBoolean</type>
      <name>DDS_Boolean</name>
      <anchorfile>group__DDSCdrTypesModule.html</anchorfile>
      <anchor>ga19b2e2f603cfff0021ec54dc57ceae7d</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>RTICdrEnum</type>
      <name>DDS_Enum</name>
      <anchorfile>group__DDSCdrTypesModule.html</anchorfile>
      <anchor>gaf515137876c32028d7851d7dcd73f552</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSTimeSupportModule</name>
    <title>Time Support</title>
    <filename>group__DDSTimeSupportModule.html</filename>
    <class kind="struct">DDS_Time_t</class>
    <class kind="struct">DDS_Duration_t</class>
    <member kind="define">
      <type>#define</type>
      <name>DDS_TIME_ZERO</name>
      <anchorfile>group__DDSTimeSupportModule.html</anchorfile>
      <anchor>gac99dcc849b77a82c132b902492fa7b03</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_Time_is_zero</name>
      <anchorfile>group__DDSTimeSupportModule.html</anchorfile>
      <anchor>gaaa55eb5d6329d461e1fb84f4b8701c42</anchor>
      <arglist>(const struct DDS_Time_t *time)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_Time_is_invalid</name>
      <anchorfile>group__DDSTimeSupportModule.html</anchorfile>
      <anchor>ga7d6dd742c3f5eca4c1e38e0c3f56e7ae</anchor>
      <arglist>(const struct DDS_Time_t *time)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_Duration_is_infinite</name>
      <anchorfile>group__DDSTimeSupportModule.html</anchorfile>
      <anchor>ga3b6a068ffcee1ecfbef4c6d9156eda3d</anchor>
      <arglist>(const struct DDS_Duration_t *duration)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_Duration_is_auto</name>
      <anchorfile>group__DDSTimeSupportModule.html</anchorfile>
      <anchor>gad0b544ea6534a8ce3878aac782c30352</anchor>
      <arglist>(const struct DDS_Duration_t *duration)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_Duration_is_zero</name>
      <anchorfile>group__DDSTimeSupportModule.html</anchorfile>
      <anchor>ga935ca8764d0160bff60c1305ff32c415</anchor>
      <arglist>(const struct DDS_Duration_t *duration)</arglist>
    </member>
    <member kind="variable">
      <type>const DDS_Long</type>
      <name>DDS_TIME_INVALID_SEC</name>
      <anchorfile>group__DDSTimeSupportModule.html</anchorfile>
      <anchor>ga67a6cc9d13b1e8274a1b32918d6951ad</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const DDS_UnsignedLong</type>
      <name>DDS_TIME_INVALID_NSEC</name>
      <anchorfile>group__DDSTimeSupportModule.html</anchorfile>
      <anchor>gabea181f484cb28290ee1a7436f98bb07</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Time_t</type>
      <name>DDS_TIME_INVALID</name>
      <anchorfile>group__DDSTimeSupportModule.html</anchorfile>
      <anchor>ga7e3abaab17ac016b71586123e624193b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const DDS_Long</type>
      <name>DDS_DURATION_INFINITE_SEC</name>
      <anchorfile>group__DDSTimeSupportModule.html</anchorfile>
      <anchor>ga9f7e73d8db27d58e44f1735580e29578</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const DDS_UnsignedLong</type>
      <name>DDS_DURATION_INFINITE_NSEC</name>
      <anchorfile>group__DDSTimeSupportModule.html</anchorfile>
      <anchor>ga8dc60e63a62ac0232e8d830e84e9220a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>DDS_DURATION_INFINITE</name>
      <anchorfile>group__DDSTimeSupportModule.html</anchorfile>
      <anchor>gaad536e140b50dc74884400421bcec2fe</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const DDS_Long</type>
      <name>DDS_DURATION_AUTO_SEC</name>
      <anchorfile>group__DDSTimeSupportModule.html</anchorfile>
      <anchor>ga97e85d071fefbe37091843f9af5cc3ec</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const DDS_UnsignedLong</type>
      <name>DDS_DURATION_AUTO_NSEC</name>
      <anchorfile>group__DDSTimeSupportModule.html</anchorfile>
      <anchor>gaae34514f805c4532d8d20ebcc33f0280</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>DDS_DURATION_AUTO</name>
      <anchorfile>group__DDSTimeSupportModule.html</anchorfile>
      <anchor>ga7c66db7425eb8ca43d76d724108b8c0d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const DDS_Long</type>
      <name>DDS_DURATION_ZERO_SEC</name>
      <anchorfile>group__DDSTimeSupportModule.html</anchorfile>
      <anchor>gac54dc87af159815b9dd2d334e41eb9ef</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const DDS_UnsignedLong</type>
      <name>DDS_DURATION_ZERO_NSEC</name>
      <anchorfile>group__DDSTimeSupportModule.html</anchorfile>
      <anchor>ga7f451f0b256690500901ac66246f48e9</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>DDS_DURATION_ZERO</name>
      <anchorfile>group__DDSTimeSupportModule.html</anchorfile>
      <anchor>gae2c3bec66d84edb921dde19eb6ee78a2</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSGUIDSupportModule</name>
    <title>GUID Support</title>
    <filename>group__DDSGUIDSupportModule.html</filename>
    <class kind="struct">DDS_GUID_t</class>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_GUID_equals</name>
      <anchorfile>group__DDSGUIDSupportModule.html</anchorfile>
      <anchor>ga336542a7794cf68ce44dccca1015b631</anchor>
      <arglist>(const struct DDS_GUID_t *self, const struct DDS_GUID_t *other)</arglist>
    </member>
    <member kind="function">
      <type>int</type>
      <name>DDS_GUID_compare</name>
      <anchorfile>group__DDSGUIDSupportModule.html</anchorfile>
      <anchor>ga1053302f994000b57a94b5646ae58dc3</anchor>
      <arglist>(const struct DDS_GUID_t *self, const struct DDS_GUID_t *other)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>DDS_GUID_copy</name>
      <anchorfile>group__DDSGUIDSupportModule.html</anchorfile>
      <anchor>ga4034bacd86900f70f61e40d91a89dc9b</anchor>
      <arglist>(struct DDS_GUID_t *self, const struct DDS_GUID_t *other)</arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_GUID_t</type>
      <name>DDS_GUID_AUTO</name>
      <anchorfile>group__DDSGUIDSupportModule.html</anchorfile>
      <anchor>gae004a83fd941aacd03dd95ad5a94e704</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_GUID_t</type>
      <name>DDS_GUID_UNKNOWN</name>
      <anchorfile>group__DDSGUIDSupportModule.html</anchorfile>
      <anchor>gaef698cd3597b7085cf261cd45595331d</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSSequenceNumberSupportModule</name>
    <title>Sequence Number Support</title>
    <filename>group__DDSSequenceNumberSupportModule.html</filename>
    <class kind="struct">DDS_SequenceNumber_t</class>
    <member kind="function">
      <type>void</type>
      <name>DDS_SequenceNumber_subtract</name>
      <anchorfile>group__DDSSequenceNumberSupportModule.html</anchorfile>
      <anchor>ga8038a32b33df218427231b55efc66251</anchor>
      <arglist>(struct DDS_SequenceNumber_t *answer, const struct DDS_SequenceNumber_t *sn1, const struct DDS_SequenceNumber_t *sn2)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>DDS_SequenceNumber_add</name>
      <anchorfile>group__DDSSequenceNumberSupportModule.html</anchorfile>
      <anchor>ga26d030c552823be6389844621db3b296</anchor>
      <arglist>(struct DDS_SequenceNumber_t *answer, const struct DDS_SequenceNumber_t *sn1, const struct DDS_SequenceNumber_t *sn2)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>DDS_SequenceNumber_plusplus</name>
      <anchorfile>group__DDSSequenceNumberSupportModule.html</anchorfile>
      <anchor>ga8bcd605010b762c478760538f39cc5a2</anchor>
      <arglist>(struct DDS_SequenceNumber_t *sn)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>DDS_SequenceNumber_minusminus</name>
      <anchorfile>group__DDSSequenceNumberSupportModule.html</anchorfile>
      <anchor>gab267b93439cc3aa586a5c4f7370643c0</anchor>
      <arglist>(struct DDS_SequenceNumber_t *sn)</arglist>
    </member>
    <member kind="function">
      <type>int</type>
      <name>DDS_SequenceNumber_compare</name>
      <anchorfile>group__DDSSequenceNumberSupportModule.html</anchorfile>
      <anchor>gab595533e452b57270f2ae65322b0e351</anchor>
      <arglist>(const struct DDS_SequenceNumber_t *sn1, const struct DDS_SequenceNumber_t *sn2)</arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SequenceNumber_t</type>
      <name>DDS_SEQUENCE_NUMBER_UNKNOWN</name>
      <anchorfile>group__DDSSequenceNumberSupportModule.html</anchorfile>
      <anchor>ga44a24fac6e5db38fd9eeecb5b95bdc23</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SequenceNumber_t</type>
      <name>DDS_SEQUENCE_NUMBER_ZERO</name>
      <anchorfile>group__DDSSequenceNumberSupportModule.html</anchorfile>
      <anchor>ga10ef377ef074f9eaca12be52fa6b2ae9</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SequenceNumber_t</type>
      <name>DDS_SEQUENCE_NUMBER_MAX</name>
      <anchorfile>group__DDSSequenceNumberSupportModule.html</anchorfile>
      <anchor>ga74b8006b2d1186cf353abd29e02b4249</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SequenceNumber_t</type>
      <name>DDS_AUTO_SEQUENCE_NUMBER</name>
      <anchorfile>group__DDSSequenceNumberSupportModule.html</anchorfile>
      <anchor>gaa20754976165174da544f09cff56120e</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSExceptionTypesModule</name>
    <title>Exception Codes</title>
    <filename>group__DDSExceptionTypesModule.html</filename>
    <member kind="enumeration">
      <name>DDS_ExceptionCode_t</name>
      <anchorfile>group__DDSExceptionTypesModule.html</anchorfile>
      <anchor>ga0a1b5bd9425158c7123ed123ff3e3a96</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_NO_EXCEPTION_CODE</name>
      <anchorfile>group__DDSExceptionTypesModule.html</anchorfile>
      <anchor>gga0a1b5bd9425158c7123ed123ff3e3a96a61935931545b83b9a2d5aedee1554ae5</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_USER_EXCEPTION_CODE</name>
      <anchorfile>group__DDSExceptionTypesModule.html</anchorfile>
      <anchor>gga0a1b5bd9425158c7123ed123ff3e3a96a84fd5eb8de1b0a9428ca015c2d288cd7</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_SYSTEM_EXCEPTION_CODE</name>
      <anchorfile>group__DDSExceptionTypesModule.html</anchorfile>
      <anchor>gga0a1b5bd9425158c7123ed123ff3e3a96a1797a0585b872d96d4d3f7ffda32e2b1</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_BAD_PARAM_SYSTEM_EXCEPTION_CODE</name>
      <anchorfile>group__DDSExceptionTypesModule.html</anchorfile>
      <anchor>gga0a1b5bd9425158c7123ed123ff3e3a96a36579fdcccec8e6c81b25393144a35df</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_NO_MEMORY_SYSTEM_EXCEPTION_CODE</name>
      <anchorfile>group__DDSExceptionTypesModule.html</anchorfile>
      <anchor>gga0a1b5bd9425158c7123ed123ff3e3a96ab8872c85c411c82fc1aa8736d4d1614a</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_BAD_TYPECODE_SYSTEM_EXCEPTION_CODE</name>
      <anchorfile>group__DDSExceptionTypesModule.html</anchorfile>
      <anchor>gga0a1b5bd9425158c7123ed123ff3e3a96a927a55acf9506dc69ba852420748686a</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_BADKIND_USER_EXCEPTION_CODE</name>
      <anchorfile>group__DDSExceptionTypesModule.html</anchorfile>
      <anchor>gga0a1b5bd9425158c7123ed123ff3e3a96ae2768ea8e37f0d25ab59ddb7bd9a07be</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_BOUNDS_USER_EXCEPTION_CODE</name>
      <anchorfile>group__DDSExceptionTypesModule.html</anchorfile>
      <anchor>gga0a1b5bd9425158c7123ed123ff3e3a96af1ed0ea4b5591716c35ee25fd30a7f2d</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_IMMUTABLE_TYPECODE_SYSTEM_EXCEPTION_CODE</name>
      <anchorfile>group__DDSExceptionTypesModule.html</anchorfile>
      <anchor>gga0a1b5bd9425158c7123ed123ff3e3a96a909badb423c846bd4d2f97fc98c5cae8</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_BAD_MEMBER_NAME_USER_EXCEPTION_CODE</name>
      <anchorfile>group__DDSExceptionTypesModule.html</anchorfile>
      <anchor>gga0a1b5bd9425158c7123ed123ff3e3a96a8e83e8b20cd2e3926e807ca1761aacf8</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_BAD_MEMBER_ID_USER_EXCEPTION_CODE</name>
      <anchorfile>group__DDSExceptionTypesModule.html</anchorfile>
      <anchor>gga0a1b5bd9425158c7123ed123ff3e3a96ae8e222e5983e391ff655fd89a0420bb3</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSReturnTypesModule</name>
    <title>Return Codes</title>
    <filename>group__DDSReturnTypesModule.html</filename>
    <member kind="enumeration">
      <name>DDS_ReturnCode_t</name>
      <anchorfile>group__DDSReturnTypesModule.html</anchorfile>
      <anchor>ga73f148aaf96b5f6f9fc630b7cfeb0c91</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_RETCODE_OK</name>
      <anchorfile>group__DDSReturnTypesModule.html</anchorfile>
      <anchor>gga73f148aaf96b5f6f9fc630b7cfeb0c91a4f3bc70d86031a38bba356c4b534979f</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_RETCODE_ERROR</name>
      <anchorfile>group__DDSReturnTypesModule.html</anchorfile>
      <anchor>gga73f148aaf96b5f6f9fc630b7cfeb0c91ac47a8e813f6e5d652f67dbc551b9f62e</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_RETCODE_UNSUPPORTED</name>
      <anchorfile>group__DDSReturnTypesModule.html</anchorfile>
      <anchor>gga73f148aaf96b5f6f9fc630b7cfeb0c91a9d40db847e4603f57ce3ff0abbd662e7</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_RETCODE_BAD_PARAMETER</name>
      <anchorfile>group__DDSReturnTypesModule.html</anchorfile>
      <anchor>gga73f148aaf96b5f6f9fc630b7cfeb0c91ad8661c51c31806806aaf10dca3c80f6c</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_RETCODE_PRECONDITION_NOT_MET</name>
      <anchorfile>group__DDSReturnTypesModule.html</anchorfile>
      <anchor>gga73f148aaf96b5f6f9fc630b7cfeb0c91a3a638871d5b4174c32c8d2880f1f6770</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_RETCODE_OUT_OF_RESOURCES</name>
      <anchorfile>group__DDSReturnTypesModule.html</anchorfile>
      <anchor>gga73f148aaf96b5f6f9fc630b7cfeb0c91a35b4c98bf40ced0114572156c7f41893</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_RETCODE_NOT_ENABLED</name>
      <anchorfile>group__DDSReturnTypesModule.html</anchorfile>
      <anchor>gga73f148aaf96b5f6f9fc630b7cfeb0c91a2e310a02f1ef7b8a7e5b5f5029b154f9</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_RETCODE_IMMUTABLE_POLICY</name>
      <anchorfile>group__DDSReturnTypesModule.html</anchorfile>
      <anchor>gga73f148aaf96b5f6f9fc630b7cfeb0c91a6e50f4433cf3e47737f4d317d0a4a707</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_RETCODE_INCONSISTENT_POLICY</name>
      <anchorfile>group__DDSReturnTypesModule.html</anchorfile>
      <anchor>gga73f148aaf96b5f6f9fc630b7cfeb0c91a5128152d6418ba270e44c5de487ce4c0</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_RETCODE_ALREADY_DELETED</name>
      <anchorfile>group__DDSReturnTypesModule.html</anchorfile>
      <anchor>gga73f148aaf96b5f6f9fc630b7cfeb0c91adaf7aa0f849422d3e4345bf1c0d98e59</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_RETCODE_TIMEOUT</name>
      <anchorfile>group__DDSReturnTypesModule.html</anchorfile>
      <anchor>gga73f148aaf96b5f6f9fc630b7cfeb0c91a9e9b16cc5337664c6c6bbd4a9ed01bcb</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_RETCODE_NO_DATA</name>
      <anchorfile>group__DDSReturnTypesModule.html</anchorfile>
      <anchor>gga73f148aaf96b5f6f9fc630b7cfeb0c91aa8e69444ae8a8efa65bde05556818669</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_RETCODE_ILLEGAL_OPERATION</name>
      <anchorfile>group__DDSReturnTypesModule.html</anchorfile>
      <anchor>gga73f148aaf96b5f6f9fc630b7cfeb0c91a9abc2fecf5d7348c77744f0b16bdfcf2</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="group__DDSReturnTypesModule">DDSReturnTypesModule_std_retcodes</docanchor>
  </compound>
  <compound kind="group">
    <name>DDSStatusTypesModule</name>
    <title>Status Kinds</title>
    <filename>group__DDSStatusTypesModule.html</filename>
    <member kind="define">
      <type>#define</type>
      <name>DDS_STATUS_MASK_NONE</name>
      <anchorfile>group__DDSStatusTypesModule.html</anchorfile>
      <anchor>ga125113479c894d4d62b9c27ceac4e03c</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_STATUS_MASK_ALL</name>
      <anchorfile>group__DDSStatusTypesModule.html</anchorfile>
      <anchor>gaa755e98b5e8484e8be881287b4b0165c</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>DDS_UnsignedLong</type>
      <name>DDS_StatusMask</name>
      <anchorfile>group__DDSStatusTypesModule.html</anchorfile>
      <anchor>ga4d99a5cbe5e3451400717c8358be6377</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumeration">
      <name>DDS_StatusKind</name>
      <anchorfile>group__DDSStatusTypesModule.html</anchorfile>
      <anchor>gaa99b5585ecdf8c5f93ac3108439ad26f</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_INCONSISTENT_TOPIC_STATUS</name>
      <anchorfile>group__DDSStatusTypesModule.html</anchorfile>
      <anchor>ggaa99b5585ecdf8c5f93ac3108439ad26fa1cdc1326d8bc09a1be3a8045f080fa88</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_OFFERED_DEADLINE_MISSED_STATUS</name>
      <anchorfile>group__DDSStatusTypesModule.html</anchorfile>
      <anchor>ggaa99b5585ecdf8c5f93ac3108439ad26fa84f12530ffc8d6e68906054b06972342</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_REQUESTED_DEADLINE_MISSED_STATUS</name>
      <anchorfile>group__DDSStatusTypesModule.html</anchorfile>
      <anchor>ggaa99b5585ecdf8c5f93ac3108439ad26fab4c627eaeae35f65790cc564208ca2e6</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_OFFERED_INCOMPATIBLE_QOS_STATUS</name>
      <anchorfile>group__DDSStatusTypesModule.html</anchorfile>
      <anchor>ggaa99b5585ecdf8c5f93ac3108439ad26fa1eb2a68f0c66c314784737a7728922b8</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_REQUESTED_INCOMPATIBLE_QOS_STATUS</name>
      <anchorfile>group__DDSStatusTypesModule.html</anchorfile>
      <anchor>ggaa99b5585ecdf8c5f93ac3108439ad26fa126ff1b38cdfc905353cb2dac57b6796</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_SAMPLE_LOST_STATUS</name>
      <anchorfile>group__DDSStatusTypesModule.html</anchorfile>
      <anchor>ggaa99b5585ecdf8c5f93ac3108439ad26fa0114c506e39a7fef5a42587556fc812f</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_SAMPLE_REJECTED_STATUS</name>
      <anchorfile>group__DDSStatusTypesModule.html</anchorfile>
      <anchor>ggaa99b5585ecdf8c5f93ac3108439ad26fa9e9d4b8dec6fa48c37aa32aa51ad2dd0</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_DATA_ON_READERS_STATUS</name>
      <anchorfile>group__DDSStatusTypesModule.html</anchorfile>
      <anchor>ggaa99b5585ecdf8c5f93ac3108439ad26fa7962fc85687ca40e2674e4f66811f670</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_DATA_AVAILABLE_STATUS</name>
      <anchorfile>group__DDSStatusTypesModule.html</anchorfile>
      <anchor>ggaa99b5585ecdf8c5f93ac3108439ad26fa9d2d926d515abd0ddd0b537efd42f03e</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_LIVELINESS_LOST_STATUS</name>
      <anchorfile>group__DDSStatusTypesModule.html</anchorfile>
      <anchor>ggaa99b5585ecdf8c5f93ac3108439ad26fabb958f0f7fe005d227e808949509961c</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_LIVELINESS_CHANGED_STATUS</name>
      <anchorfile>group__DDSStatusTypesModule.html</anchorfile>
      <anchor>ggaa99b5585ecdf8c5f93ac3108439ad26fa267a5ad100a1e87c372752b6900a9965</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_PUBLICATION_MATCHED_STATUS</name>
      <anchorfile>group__DDSStatusTypesModule.html</anchorfile>
      <anchor>ggaa99b5585ecdf8c5f93ac3108439ad26fa3052f04c67620660f92aa3b5da2455d2</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_SUBSCRIPTION_MATCHED_STATUS</name>
      <anchorfile>group__DDSStatusTypesModule.html</anchorfile>
      <anchor>ggaa99b5585ecdf8c5f93ac3108439ad26faceedf0fda6d695b4fabd8ac0af807bb1</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_DATA_WRITER_INSTANCE_REPLACED_STATUS</name>
      <anchorfile>group__DDSStatusTypesModule.html</anchorfile>
      <anchor>ggaa99b5585ecdf8c5f93ac3108439ad26fa3ba112e7d805a656ab788cd912d486e6</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_RELIABLE_WRITER_CACHE_CHANGED_STATUS</name>
      <anchorfile>group__DDSStatusTypesModule.html</anchorfile>
      <anchor>ggaa99b5585ecdf8c5f93ac3108439ad26fad694e745b154fb74c49c0bd0210acadc</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_RELIABLE_READER_ACTIVITY_CHANGED_STATUS</name>
      <anchorfile>group__DDSStatusTypesModule.html</anchorfile>
      <anchor>ggaa99b5585ecdf8c5f93ac3108439ad26fac97ef6e40fddefdbc516978e5681436c</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_DATA_WRITER_CACHE_STATUS</name>
      <anchorfile>group__DDSStatusTypesModule.html</anchorfile>
      <anchor>ggaa99b5585ecdf8c5f93ac3108439ad26faf7ddb3e013a36e1a3950231449a589ba</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_DATA_WRITER_PROTOCOL_STATUS</name>
      <anchorfile>group__DDSStatusTypesModule.html</anchorfile>
      <anchor>ggaa99b5585ecdf8c5f93ac3108439ad26fa2b24f623f0b0bd3351808e50cf450563</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_DATA_READER_CACHE_STATUS</name>
      <anchorfile>group__DDSStatusTypesModule.html</anchorfile>
      <anchor>ggaa99b5585ecdf8c5f93ac3108439ad26fab5cf5526977baa786d2976dcc17f412f</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_DATA_READER_PROTOCOL_STATUS</name>
      <anchorfile>group__DDSStatusTypesModule.html</anchorfile>
      <anchor>ggaa99b5585ecdf8c5f93ac3108439ad26fa391654263c7c0f8de22bd894eb6bb3bb</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="group__DDSStatusTypesModule">Status_changes</docanchor>
    <docanchor file="group__DDSStatusTypesModule">Status_changes_plain</docanchor>
    <docanchor file="group__DDSStatusTypesModule">Status_changes_read</docanchor>
  </compound>
  <compound kind="group">
    <name>DDSThreadSettingsModule</name>
    <title>Thread Settings</title>
    <filename>group__DDSThreadSettingsModule.html</filename>
    <class kind="struct">DDS_ThreadSettings_t</class>
    <member kind="define">
      <type>#define</type>
      <name>DDS_THREAD_SETTINGS_KIND_MASK_DEFAULT</name>
      <anchorfile>group__DDSThreadSettingsModule.html</anchorfile>
      <anchor>gad0c526878b387d391a31a9b31384f87e</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>DDS_UnsignedLong</type>
      <name>DDS_ThreadSettingsKindMask</name>
      <anchorfile>group__DDSThreadSettingsModule.html</anchorfile>
      <anchor>gae597ce52fefac87a730976cc7d8f1736</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumeration">
      <name>DDS_ThreadSettingsKind</name>
      <anchorfile>group__DDSThreadSettingsModule.html</anchorfile>
      <anchor>ga24870fcb323c654c277af8d292c0415e</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_THREAD_SETTINGS_FLOATING_POINT</name>
      <anchorfile>group__DDSThreadSettingsModule.html</anchorfile>
      <anchor>gga24870fcb323c654c277af8d292c0415eaa65c249ada6bb9fad86b11dd2a11abc9</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_THREAD_SETTINGS_STDIO</name>
      <anchorfile>group__DDSThreadSettingsModule.html</anchorfile>
      <anchor>gga24870fcb323c654c277af8d292c0415ea20db361583de95f2690631eb807f35e0</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_THREAD_SETTINGS_REALTIME_PRIORITY</name>
      <anchorfile>group__DDSThreadSettingsModule.html</anchorfile>
      <anchor>gga24870fcb323c654c277af8d292c0415ea114c76d04077555799d4cca17a6237e7</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_THREAD_SETTINGS_PRIORITY_ENFORCE</name>
      <anchorfile>group__DDSThreadSettingsModule.html</anchorfile>
      <anchor>gga24870fcb323c654c277af8d292c0415eac1b3ae86d0f004cc797e38fa74ac22d0</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_THREAD_SETTINGS_CANCEL_ASYNCHRONOUS</name>
      <anchorfile>group__DDSThreadSettingsModule.html</anchorfile>
      <anchor>gga24870fcb323c654c277af8d292c0415ea6fd86fa38d482071f20e349cf1f534dd</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumeration">
      <name>DDS_ThreadSettingsCpuRotationKind</name>
      <anchorfile>group__DDSThreadSettingsModule.html</anchorfile>
      <anchor>ga899fc336687e6e0633bbd6a9301951f9</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_THREAD_SETTINGS_CPU_NO_ROTATION</name>
      <anchorfile>group__DDSThreadSettingsModule.html</anchorfile>
      <anchor>gga899fc336687e6e0633bbd6a9301951f9a89f283032c5d7c7e13f4847b01eab428</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_THREAD_SETTINGS_CPU_RR_ROTATION</name>
      <anchorfile>group__DDSThreadSettingsModule.html</anchorfile>
      <anchor>gga899fc336687e6e0633bbd6a9301951f9ac92d305227d5eabe59602a196c702121</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSQosTypesModule</name>
    <title>QoS Policies</title>
    <filename>group__DDSQosTypesModule.html</filename>
    <subgroup>DDSAsynchronousPublisherQosModule</subgroup>
    <subgroup>DDSAvailabilityQosModule</subgroup>
    <subgroup>DDSBatchQosModule</subgroup>
    <subgroup>DDSDatabaseQosModule</subgroup>
    <subgroup>DDSDataReaderProtocolQosModule</subgroup>
    <subgroup>DDSDataReaderResourceLimitsQosModule</subgroup>
    <subgroup>DDSDataWriterProtocolQosModule</subgroup>
    <subgroup>DDSDataWriterResourceLimitsQosModule</subgroup>
    <subgroup>DDSDeadlineQosModule</subgroup>
    <subgroup>DDSDestinationOrderQosModule</subgroup>
    <subgroup>DDSDiscoveryQosModule</subgroup>
    <subgroup>DDSDiscoveryConfigQosModule</subgroup>
    <subgroup>DDSDomainParticipantResourceLimitsQosModule</subgroup>
    <subgroup>DDSDurabilityQosModule</subgroup>
    <subgroup>DDSDurabilityServiceQosModule</subgroup>
    <subgroup>DDSEntityFactoryQosModule</subgroup>
    <subgroup>DDSEntityNameQosModule</subgroup>
    <subgroup>DDSEventQosModule</subgroup>
    <subgroup>DDSExclusiveAreaQosModule</subgroup>
    <subgroup>DDSHistoryQosModule</subgroup>
    <subgroup>DDSGroupDataQosModule</subgroup>
    <subgroup>DDSLatencyBudgetQosModule</subgroup>
    <subgroup>DDSLifespanQosModule</subgroup>
    <subgroup>DDSLivelinessQosModule</subgroup>
    <subgroup>DDSLocatorFilterQosModule</subgroup>
    <subgroup>DDSLoggingQosModule</subgroup>
    <subgroup>DDSMultiChannelQosModule</subgroup>
    <subgroup>DDSOwnershipQosModule</subgroup>
    <subgroup>DDSOwnershipStrengthQosModule</subgroup>
    <subgroup>DDSPartitionQosModule</subgroup>
    <subgroup>DDSPresentationQosModule</subgroup>
    <subgroup>DDSProfileQosModule</subgroup>
    <subgroup>DDSPropertyQosModule</subgroup>
    <subgroup>DDSPublishModeQosModule</subgroup>
    <subgroup>DDSReaderDataLifecycleQosModule</subgroup>
    <subgroup>DDSReceiverPoolQosModule</subgroup>
    <subgroup>DDSReliabilityQosModule</subgroup>
    <subgroup>DDSResourceLimitsQosModule</subgroup>
    <subgroup>DDSSystemResourceLimitsQosModule</subgroup>
    <subgroup>DDSTimeBasedFilterQosModule</subgroup>
    <subgroup>DDSTopicDataQosModule</subgroup>
    <subgroup>DDSTransportBuiltinQosModule</subgroup>
    <subgroup>DDSTransportMulticastQosModule</subgroup>
    <subgroup>DDSTransportMulticastMappingQosModule</subgroup>
    <subgroup>DDSTransportPriorityQosModule</subgroup>
    <subgroup>DDSTransportSelectionQosModule</subgroup>
    <subgroup>DDSTransportUnicastQosModule</subgroup>
    <subgroup>DDSTypeConsistencyEnforcementQosModule</subgroup>
    <subgroup>DDSTypeSupportQosModule</subgroup>
    <subgroup>DDSUserDataQosModule</subgroup>
    <subgroup>DDSWriterDataLifecycleQosModule</subgroup>
    <subgroup>DDSWireProtocolQosModule</subgroup>
    <subgroup>DDSExtendedQosSupportModule</subgroup>
    <class kind="struct">DDS_QosPolicyCount</class>
    <class kind="struct">DDS_QosPolicyCountSeq</class>
    <member kind="define">
      <type>#define</type>
      <name>DDS_QOS_POLICY_COUNT</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>ga4cb75c6ac79e561fa04f267841277a9d</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumeration">
      <name>DDS_QosPolicyId_t</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>ga4b2c4d85475a58758fba7601082a40f8</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_INVALID_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a3b381d1bfefadadd7bdc4a6df94066ba</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_USERDATA_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8afd439068503642ba27ae03e82cd5dfc8</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_DURABILITY_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8abc6c3daf8f99df31ca60def2b953b800</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_PRESENTATION_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a9515752aa5a5e4580593a819446767ff</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_DEADLINE_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8abd77e173b457d7c9a4455c00f5a72d32</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_LATENCYBUDGET_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a4307e6cf33965ad1b332de72c7b0a3e6</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_OWNERSHIP_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8afd0f507c4cc38a933f5817d0ea873d03</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_OWNERSHIPSTRENGTH_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a766d1409fe6aa9ee6264f4efe69731c5</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_LIVELINESS_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8ad155c60f378087fa8fdbb0f3eddca268</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TIMEBASEDFILTER_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a5c24a0ad10b8b5557f608306acff7e50</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_PARTITION_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a2914476b818ff9a6c16a5a15cc4c9859</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_RELIABILITY_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a33cceb8ac73aa06ef39485b3d887c815</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_DESTINATIONORDER_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8abc7d529d3a26069586a80b7aac6763c4</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_HISTORY_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8ae84e1113bab59340942bfd52193ea428</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_RESOURCELIMITS_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8af6dc4ee596d5cbe34bf5c4cb67533c57</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_ENTITYFACTORY_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a02e9e33058e0cdbce813165a59c53438</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_WRITERDATALIFECYCLE_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8ac87a7459f45e7dfb8b4fe6d7948edb89</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_READERDATALIFECYCLE_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8aa62ade0f5a05654c5f959dd33bbeb07e</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TOPICDATA_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a12f9b3bb36fe960675fe077b11ea99ce</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_GROUPDATA_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8aac3715c5385e49e1b6a995f0f8fdec6f</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TRANSPORTPRIORITY_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8ab76060ee902af0589e55e15a7a213797</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_LIFESPAN_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a8e8deda6f1b1d576fcea58e66e1eb00b</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_DURABILITYSERVICE_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a6e16affba7e7d1abee18b0a8fb5ced47</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TYPE_CONSISTENCY_ENFORCEMENT_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a832635ecb9be4de866ea695b9072d74e</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_WIREPROTOCOL_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8abf611655055c57bdc63712d0b238d0f4</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_DISCOVERY_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a7418a50a4ec7eefc24257be29e421f82</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_DATAREADERRESOURCELIMITS_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8ae7ed6ac9ae8addeb58849c7d28271ea5</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_DATAWRITERRESOURCELIMITS_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8aad7e3fba38ff5a995b2e57b777ff1a10</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_DATAREADERPROTOCOL_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a54016a880ce7fe51051980ad79d63f0a</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_DATAWRITERPROTOCOL_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a14a9471836a7d9bcd37142cbe9cb3ca4</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_DOMAINPARTICIPANTRESOURCELIMITS_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a2e7398919a0d6eb5c072380cc4af3c9c</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_EVENT_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a2ae487430036c4d9d80e325d8685222c</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_DATABASE_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8acdf49c15755bf2717fba06a8a5c92cca</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_RECEIVERPOOL_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a55e6bb1330ae810b6cf9854241a76b19</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_DISCOVERYCONFIG_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8ade5040911724bc9981fc93fd49c9a76c</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_EXCLUSIVEAREA_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8aea86c05045e54ee7307726086f659916</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_SYSTEMRESOURCELIMITS_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a44311ea2889193574f78a0ea6119f22c</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TRANSPORTSELECTION_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a9fef1ef1728976261f347e5c27f1bee9</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TRANSPORTUNICAST_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a9024023754e229fb08f6d5807b8c7a8f</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TRANSPORTMULTICAST_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a8ee2e166731e33cf866dc69f577029b4</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TRANSPORTBUILTIN_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8ae2776e50079294c06b296c5e59f1d357</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TYPESUPPORT_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8aad57d171eb6c14c206ae3c75e24b649c</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_PROPERTY_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8ae9f95f958fc0a4616616e9a07ca4a8c4</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_PUBLISHMODE_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a7863e14b78165e392790b93910d8e8f2</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_ASYNCHRONOUSPUBLISHER_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a9f7ff48709f7692cc3f9d4a256f549a6</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_ENTITYNAME_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8ab02c7b6ecab65c8f183c89f2b4f21f8b</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_BATCH_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8ad28c701dea92f4c00a38d0563336704e</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_PROFILE_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a6fb2d00bf1ea2ffb0c44a0f6f5f332e1</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_LOCATORFILTER_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8ac030d3b80aba6f9af648b9c2d97f3c3b</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_MULTICHANNEL_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a507a2dc402ef72ab1290e3138fea1aeb</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_AVAILABILITY_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a73bbc7d03e226defc900a53349a5e6b6</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TRANSPORTMULTICASTMAPPING_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a68ec381365d37d7ab671d8d272f0f9d9</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_LOGGING_QOS_POLICY_ID</name>
      <anchorfile>group__DDSQosTypesModule.html</anchorfile>
      <anchor>gga4b2c4d85475a58758fba7601082a40f8a0e12937f8c131df79578a490c170b48e</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="group__DDSQosTypesModule">DDSQosTypesModule_usage</docanchor>
    <docanchor file="group__DDSQosTypesModule">DDSQosTypesModule_compatibility</docanchor>
    <docanchor file="group__DDSQosTypesModule">a_prop_rxo</docanchor>
    <docanchor file="group__DDSQosTypesModule">a_prop_changeable</docanchor>
    <docanchor file="group__DDSQosTypesModule">a_prop_changeable_no</docanchor>
    <docanchor file="group__DDSQosTypesModule">a_prop_changeable_until_enable</docanchor>
    <docanchor file="group__DDSQosTypesModule">a_prop_changeable_yes</docanchor>
  </compound>
  <compound kind="group">
    <name>DDSAsynchronousPublisherQosModule</name>
    <title>ASYNCHRONOUS_PUBLISHER</title>
    <filename>group__DDSAsynchronousPublisherQosModule.html</filename>
    <class kind="struct">DDS_AsynchronousPublisherQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_ASYNCHRONOUSPUBLISHER_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSAsynchronousPublisherQosModule.html</anchorfile>
      <anchor>ga47d54c8f3c78688601aefff28b621f7a</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSAvailabilityQosModule</name>
    <title>AVAILABILITY</title>
    <filename>group__DDSAvailabilityQosModule.html</filename>
    <class kind="struct">DDS_EndpointGroup_t</class>
    <class kind="struct">DDS_EndpointGroupSeq</class>
    <class kind="struct">DDS_AvailabilityQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_AVAILABILITY_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSAvailabilityQosModule.html</anchorfile>
      <anchor>ga169826b882da0fc27a5c091c951503cf</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSBatchQosModule</name>
    <title>BATCH</title>
    <filename>group__DDSBatchQosModule.html</filename>
    <class kind="struct">DDS_BatchQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_BATCH_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSBatchQosModule.html</anchorfile>
      <anchor>ga24582ca2c666739b3bf1de4ca81c944d</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSDatabaseQosModule</name>
    <title>DATABASE</title>
    <filename>group__DDSDatabaseQosModule.html</filename>
    <class kind="struct">DDS_DatabaseQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_DATABASE_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSDatabaseQosModule.html</anchorfile>
      <anchor>ga7071604c8ed072c891bb83c3fa2ccf1c</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSDataReaderProtocolQosModule</name>
    <title>DATA_READER_PROTOCOL</title>
    <filename>group__DDSDataReaderProtocolQosModule.html</filename>
    <class kind="struct">DDS_DataReaderProtocolQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_DATAREADERPROTOCOL_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSDataReaderProtocolQosModule.html</anchorfile>
      <anchor>ga0c3a1424cb3984a4438eae5bb92972c6</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSDataReaderResourceLimitsQosModule</name>
    <title>DATA_READER_RESOURCE_LIMITS</title>
    <filename>group__DDSDataReaderResourceLimitsQosModule.html</filename>
    <class kind="struct">DDS_DataReaderResourceLimitsQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_DATAREADERRESOURCELIMITS_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSDataReaderResourceLimitsQosModule.html</anchorfile>
      <anchor>ga4aa3763bd497404514504d6b59426cf8</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const DDS_Long</type>
      <name>DDS_AUTO_MAX_TOTAL_INSTANCES</name>
      <anchorfile>group__DDSDataReaderResourceLimitsQosModule.html</anchorfile>
      <anchor>gabd19381203208406d882abeeb9e53d3f</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSDataWriterProtocolQosModule</name>
    <title>DATA_WRITER_PROTOCOL</title>
    <filename>group__DDSDataWriterProtocolQosModule.html</filename>
    <class kind="struct">DDS_DataWriterProtocolQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_DATAWRITERPROTOCOL_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSDataWriterProtocolQosModule.html</anchorfile>
      <anchor>gaec8323b8d2c61caf7b635c22da0979da</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSDataWriterResourceLimitsQosModule</name>
    <title>DATA_WRITER_RESOURCE_LIMITS</title>
    <filename>group__DDSDataWriterResourceLimitsQosModule.html</filename>
    <class kind="struct">DDS_DataWriterResourceLimitsQosPolicy</class>
    <member kind="enumeration">
      <name>DDS_DataWriterResourceLimitsInstanceReplacementKind</name>
      <anchorfile>group__DDSDataWriterResourceLimitsQosModule.html</anchorfile>
      <anchor>ga4e1d22822e791111c475586408e5af88</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_UNREGISTERED_INSTANCE_REPLACEMENT</name>
      <anchorfile>group__DDSDataWriterResourceLimitsQosModule.html</anchorfile>
      <anchor>gga4e1d22822e791111c475586408e5af88a3b91cc2e153df3da80e7f4b34e2b6f1b</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_ALIVE_INSTANCE_REPLACEMENT</name>
      <anchorfile>group__DDSDataWriterResourceLimitsQosModule.html</anchorfile>
      <anchor>gga4e1d22822e791111c475586408e5af88a3bd754f39231c8997cb372d31a83b4d1</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_DISPOSED_INSTANCE_REPLACEMENT</name>
      <anchorfile>group__DDSDataWriterResourceLimitsQosModule.html</anchorfile>
      <anchor>gga4e1d22822e791111c475586408e5af88a30271662385c3265b54df551c7ee08c1</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_ALIVE_THEN_DISPOSED_INSTANCE_REPLACEMENT</name>
      <anchorfile>group__DDSDataWriterResourceLimitsQosModule.html</anchorfile>
      <anchor>gga4e1d22822e791111c475586408e5af88ac0cd646be98852eacf8bb217ea9a6fd8</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_DISPOSED_THEN_ALIVE_INSTANCE_REPLACEMENT</name>
      <anchorfile>group__DDSDataWriterResourceLimitsQosModule.html</anchorfile>
      <anchor>gga4e1d22822e791111c475586408e5af88a3ee1048f6f6b01ea79b19ac8213762db</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_ALIVE_OR_DISPOSED_INSTANCE_REPLACEMENT</name>
      <anchorfile>group__DDSDataWriterResourceLimitsQosModule.html</anchorfile>
      <anchor>gga4e1d22822e791111c475586408e5af88a6cc7f716a9606e4ae9ba3547d666297f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_DATAWRITERRESOURCELIMITS_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSDataWriterResourceLimitsQosModule.html</anchorfile>
      <anchor>ga62baa4cc829ae82a5d240231c2fd9d80</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSDeadlineQosModule</name>
    <title>DEADLINE</title>
    <filename>group__DDSDeadlineQosModule.html</filename>
    <class kind="struct">DDS_DeadlineQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_DEADLINE_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSDeadlineQosModule.html</anchorfile>
      <anchor>gad8e101b521a1a1af7086f659d07bf055</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSDestinationOrderQosModule</name>
    <title>DESTINATION_ORDER</title>
    <filename>group__DDSDestinationOrderQosModule.html</filename>
    <class kind="struct">DDS_DestinationOrderQosPolicy</class>
    <member kind="enumeration">
      <name>DDS_DestinationOrderQosPolicyKind</name>
      <anchorfile>group__DDSDestinationOrderQosModule.html</anchorfile>
      <anchor>ga8f1c0c2b179c6281aa9e92d5ea88cbfe</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_BY_RECEPTION_TIMESTAMP_DESTINATIONORDER_QOS</name>
      <anchorfile>group__DDSDestinationOrderQosModule.html</anchorfile>
      <anchor>gga8f1c0c2b179c6281aa9e92d5ea88cbfeaa718dc1f974fc792af552d293986bb26</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_BY_SOURCE_TIMESTAMP_DESTINATIONORDER_QOS</name>
      <anchorfile>group__DDSDestinationOrderQosModule.html</anchorfile>
      <anchor>gga8f1c0c2b179c6281aa9e92d5ea88cbfeac7a65745504a7d4ccbc41299154fe67b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_DESTINATIONORDER_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSDestinationOrderQosModule.html</anchorfile>
      <anchor>ga601b86edc58e98535e313f9c7c30a89f</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSDiscoveryQosModule</name>
    <title>DISCOVERY</title>
    <filename>group__DDSDiscoveryQosModule.html</filename>
    <subgroup>NDDS_DISCOVERY_PEERS</subgroup>
    <class kind="struct">DDS_DiscoveryQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_DISCOVERY_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSDiscoveryQosModule.html</anchorfile>
      <anchor>ga03a15389b03cb0a805b1d36d2e4fe8a2</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSDiscoveryConfigQosModule</name>
    <title>DISCOVERY_CONFIG</title>
    <filename>group__DDSDiscoveryConfigQosModule.html</filename>
    <class kind="struct">DDS_BuiltinTopicReaderResourceLimits_t</class>
    <class kind="struct">DDS_DiscoveryConfigQosPolicy</class>
    <member kind="define">
      <type>#define</type>
      <name>DDS_DISCOVERYCONFIG_BUILTIN_PLUGIN_MASK_ALL</name>
      <anchorfile>group__DDSDiscoveryConfigQosModule.html</anchorfile>
      <anchor>ga75f8db9a3deb5d5803827c0e49d7540f</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_DISCOVERYCONFIG_BUILTIN_PLUGIN_MASK_NONE</name>
      <anchorfile>group__DDSDiscoveryConfigQosModule.html</anchorfile>
      <anchor>ga274eaefb5741ea64654b264324ce7848</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_DISCOVERYCONFIG_BUILTIN_PLUGIN_MASK_DEFAULT</name>
      <anchorfile>group__DDSDiscoveryConfigQosModule.html</anchorfile>
      <anchor>ga2e8abf1cf6174b7ad2e57a6daa409a07</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>DDS_Long</type>
      <name>DDS_DiscoveryConfigBuiltinPluginKindMask</name>
      <anchorfile>group__DDSDiscoveryConfigQosModule.html</anchorfile>
      <anchor>ga39e570e403891ed478fe9a0b8296b02b</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumeration">
      <name>DDS_DiscoveryConfigBuiltinPluginKind</name>
      <anchorfile>group__DDSDiscoveryConfigQosModule.html</anchorfile>
      <anchor>ga356965829eadc834769365098e84fe38</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_DISCOVERYCONFIG_BUILTIN_SDP</name>
      <anchorfile>group__DDSDiscoveryConfigQosModule.html</anchorfile>
      <anchor>gga356965829eadc834769365098e84fe38ac55aacdca28c8b42b982ceccd8461dc1</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumeration">
      <name>DDS_RemoteParticipantPurgeKind</name>
      <anchorfile>group__DDSDiscoveryConfigQosModule.html</anchorfile>
      <anchor>ga875fd04a10a836a93f2bc9ce0005ce50</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_LIVELINESS_BASED_REMOTE_PARTICIPANT_PURGE</name>
      <anchorfile>group__DDSDiscoveryConfigQosModule.html</anchorfile>
      <anchor>gga875fd04a10a836a93f2bc9ce0005ce50a93db8a06b817d5765eff47212d6dcf01</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_NO_REMOTE_PARTICIPANT_PURGE</name>
      <anchorfile>group__DDSDiscoveryConfigQosModule.html</anchorfile>
      <anchor>gga875fd04a10a836a93f2bc9ce0005ce50af2f216cc3f29a1ef38aeee6396b750ca</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_DISCOVERYCONFIG_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSDiscoveryConfigQosModule.html</anchorfile>
      <anchor>ga9433f294bd4d4e64ea0cacd1df60b800</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSDomainParticipantResourceLimitsQosModule</name>
    <title>DOMAIN_PARTICIPANT_RESOURCE_LIMITS</title>
    <filename>group__DDSDomainParticipantResourceLimitsQosModule.html</filename>
    <class kind="struct">DDS_AllocationSettings_t</class>
    <class kind="struct">DDS_DomainParticipantResourceLimitsQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_DOMAINPARTICIPANTRESOURCELIMITS_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSDomainParticipantResourceLimitsQosModule.html</anchorfile>
      <anchor>gaa668a948c296ca4a63c784630006293e</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSDurabilityQosModule</name>
    <title>DURABILITY</title>
    <filename>group__DDSDurabilityQosModule.html</filename>
    <class kind="struct">DDS_DurabilityQosPolicy</class>
    <member kind="enumeration">
      <name>DDS_DurabilityQosPolicyKind</name>
      <anchorfile>group__DDSDurabilityQosModule.html</anchorfile>
      <anchor>ga4bc6b72c72928cb9ed6432e3e6a83e2e</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_VOLATILE_DURABILITY_QOS</name>
      <anchorfile>group__DDSDurabilityQosModule.html</anchorfile>
      <anchor>gga4bc6b72c72928cb9ed6432e3e6a83e2eab81cc94a7a319b48b17e177d217a09d4</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TRANSIENT_LOCAL_DURABILITY_QOS</name>
      <anchorfile>group__DDSDurabilityQosModule.html</anchorfile>
      <anchor>gga4bc6b72c72928cb9ed6432e3e6a83e2ea82f8bcc308fa4721d8d8525c383e7d25</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TRANSIENT_DURABILITY_QOS</name>
      <anchorfile>group__DDSDurabilityQosModule.html</anchorfile>
      <anchor>gga4bc6b72c72928cb9ed6432e3e6a83e2ea81786bd134fe8ca8cf5525715004c39e</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_PERSISTENT_DURABILITY_QOS</name>
      <anchorfile>group__DDSDurabilityQosModule.html</anchorfile>
      <anchor>gga4bc6b72c72928cb9ed6432e3e6a83e2eacbd6b266c74543d92befcec26ccf38c2</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_DURABILITY_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSDurabilityQosModule.html</anchorfile>
      <anchor>ga1b3a5465ffbb746429f36352bab84e78</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSDurabilityServiceQosModule</name>
    <title>DURABILITY_SERVICE</title>
    <filename>group__DDSDurabilityServiceQosModule.html</filename>
    <class kind="struct">DDS_DurabilityServiceQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_DURABILITYSERVICE_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSDurabilityServiceQosModule.html</anchorfile>
      <anchor>ga7935c959c60877e9dac540c0c1efbaf4</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSEntityFactoryQosModule</name>
    <title>ENTITY_FACTORY</title>
    <filename>group__DDSEntityFactoryQosModule.html</filename>
    <class kind="struct">DDS_EntityFactoryQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_ENTITYFACTORY_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSEntityFactoryQosModule.html</anchorfile>
      <anchor>gaa43f922824b3121a6e126eb8571881ef</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSEntityNameQosModule</name>
    <title>ENTITY_NAME</title>
    <filename>group__DDSEntityNameQosModule.html</filename>
    <class kind="struct">DDS_EntityNameQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_ENTITYNAME_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSEntityNameQosModule.html</anchorfile>
      <anchor>ga669a7300faad4d8538cc57496e3d995d</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSEventQosModule</name>
    <title>EVENT</title>
    <filename>group__DDSEventQosModule.html</filename>
    <class kind="struct">DDS_EventQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_EVENT_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSEventQosModule.html</anchorfile>
      <anchor>ga4655fc24915abc52d7eb1edf4ace022e</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSExclusiveAreaQosModule</name>
    <title>EXCLUSIVE_AREA</title>
    <filename>group__DDSExclusiveAreaQosModule.html</filename>
    <class kind="struct">DDS_ExclusiveAreaQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_EXCLUSIVEAREA_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSExclusiveAreaQosModule.html</anchorfile>
      <anchor>ga25f07083d7e5d859fbe5e8b58e9ed547</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSHistoryQosModule</name>
    <title>HISTORY</title>
    <filename>group__DDSHistoryQosModule.html</filename>
    <class kind="struct">DDS_HistoryQosPolicy</class>
    <member kind="enumeration">
      <name>DDS_HistoryQosPolicyKind</name>
      <anchorfile>group__DDSHistoryQosModule.html</anchorfile>
      <anchor>ga96c54dadb2beb87b23776e766e282185</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_KEEP_LAST_HISTORY_QOS</name>
      <anchorfile>group__DDSHistoryQosModule.html</anchorfile>
      <anchor>gga96c54dadb2beb87b23776e766e282185a993d3120b7bbb347ce11e0e6f68b29ff</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_KEEP_ALL_HISTORY_QOS</name>
      <anchorfile>group__DDSHistoryQosModule.html</anchorfile>
      <anchor>gga96c54dadb2beb87b23776e766e282185a9e526d876dae232aa083125c72135f5b</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumeration">
      <name>DDS_RefilterQosPolicyKind</name>
      <anchorfile>group__DDSHistoryQosModule.html</anchorfile>
      <anchor>ga2eec16ce240664606523f2f3fe15afaf</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_NONE_REFILTER_QOS</name>
      <anchorfile>group__DDSHistoryQosModule.html</anchorfile>
      <anchor>gga2eec16ce240664606523f2f3fe15afafa15094145b5c80aa0a20e4c737cde450d</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_ALL_REFILTER_QOS</name>
      <anchorfile>group__DDSHistoryQosModule.html</anchorfile>
      <anchor>gga2eec16ce240664606523f2f3fe15afafa4e27405a911349d1ea74e08254fe48c8</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_ON_DEMAND_REFILTER_QOS</name>
      <anchorfile>group__DDSHistoryQosModule.html</anchorfile>
      <anchor>gga2eec16ce240664606523f2f3fe15afafaf380823256d466dbbc35b1e19d0ae10c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_HISTORY_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSHistoryQosModule.html</anchorfile>
      <anchor>ga2e73ca5ab5c1c6dae089887675579999</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSGroupDataQosModule</name>
    <title>GROUP_DATA</title>
    <filename>group__DDSGroupDataQosModule.html</filename>
    <class kind="struct">DDS_GroupDataQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_GROUPDATA_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSGroupDataQosModule.html</anchorfile>
      <anchor>gab94ea0755d9e2f2c956f7b48399dcef6</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSLatencyBudgetQosModule</name>
    <title>LATENCY_BUDGET</title>
    <filename>group__DDSLatencyBudgetQosModule.html</filename>
    <class kind="struct">DDS_LatencyBudgetQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_LATENCYBUDGET_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSLatencyBudgetQosModule.html</anchorfile>
      <anchor>ga10745fee13dae2bf0d513aa2295ca3d3</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSLifespanQosModule</name>
    <title>LIFESPAN</title>
    <filename>group__DDSLifespanQosModule.html</filename>
    <class kind="struct">DDS_LifespanQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_LIFESPAN_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSLifespanQosModule.html</anchorfile>
      <anchor>ga17656b39e101b3f174892552789f9ad9</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSLivelinessQosModule</name>
    <title>LIVELINESS</title>
    <filename>group__DDSLivelinessQosModule.html</filename>
    <class kind="struct">DDS_LivelinessQosPolicy</class>
    <member kind="enumeration">
      <name>DDS_LivelinessQosPolicyKind</name>
      <anchorfile>group__DDSLivelinessQosModule.html</anchorfile>
      <anchor>ga3ea638553fd66356c38071040de062e5</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_AUTOMATIC_LIVELINESS_QOS</name>
      <anchorfile>group__DDSLivelinessQosModule.html</anchorfile>
      <anchor>gga3ea638553fd66356c38071040de062e5ad9cee7b01dd754152a13b6999b57911b</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_MANUAL_BY_PARTICIPANT_LIVELINESS_QOS</name>
      <anchorfile>group__DDSLivelinessQosModule.html</anchorfile>
      <anchor>gga3ea638553fd66356c38071040de062e5a5519eb00b713987173ff0858e7e3c1f0</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_MANUAL_BY_TOPIC_LIVELINESS_QOS</name>
      <anchorfile>group__DDSLivelinessQosModule.html</anchorfile>
      <anchor>gga3ea638553fd66356c38071040de062e5a6ea670a089709fe482e1c92f5ad1c255</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_LIVELINESS_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSLivelinessQosModule.html</anchorfile>
      <anchor>ga2ba9dfae3f10f49d0a24d84b916ed559</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSLocatorFilterQosModule</name>
    <title>LOCATORFILTER</title>
    <filename>group__DDSLocatorFilterQosModule.html</filename>
    <class kind="struct">DDS_LocatorFilter_t</class>
    <class kind="struct">DDS_LocatorFilterSeq</class>
    <class kind="struct">DDS_LocatorFilterQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_LOCATORFILTER_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSLocatorFilterQosModule.html</anchorfile>
      <anchor>ga754ade9a53fefb3e3a3792f7990a3817</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSLoggingQosModule</name>
    <title>LOGGING</title>
    <filename>group__DDSLoggingQosModule.html</filename>
    <class kind="struct">DDS_LoggingQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_LOGGING_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSLoggingQosModule.html</anchorfile>
      <anchor>ga451782a9276b13fcd4f18e2d5f014b0c</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSMultiChannelQosModule</name>
    <title>MULTICHANNEL</title>
    <filename>group__DDSMultiChannelQosModule.html</filename>
    <class kind="struct">DDS_ChannelSettings_t</class>
    <class kind="struct">DDS_ChannelSettingsSeq</class>
    <class kind="struct">DDS_MultiChannelQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_MULTICHANNEL_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSMultiChannelQosModule.html</anchorfile>
      <anchor>ga9c7da23e6a182bc0d3b641715364e121</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSOwnershipQosModule</name>
    <title>OWNERSHIP</title>
    <filename>group__DDSOwnershipQosModule.html</filename>
    <class kind="struct">DDS_OwnershipQosPolicy</class>
    <member kind="enumeration">
      <name>DDS_OwnershipQosPolicyKind</name>
      <anchorfile>group__DDSOwnershipQosModule.html</anchorfile>
      <anchor>gaa88100c64a26cc036cb2eb2d631c3f43</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_SHARED_OWNERSHIP_QOS</name>
      <anchorfile>group__DDSOwnershipQosModule.html</anchorfile>
      <anchor>ggaa88100c64a26cc036cb2eb2d631c3f43a262c9859d5c214495c02cd39366a335f</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_EXCLUSIVE_OWNERSHIP_QOS</name>
      <anchorfile>group__DDSOwnershipQosModule.html</anchorfile>
      <anchor>ggaa88100c64a26cc036cb2eb2d631c3f43a6f223289a81f87d7929408a84a27f316</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_OWNERSHIP_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSOwnershipQosModule.html</anchorfile>
      <anchor>ga01b90088464ff341702d0c9d65614723</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSOwnershipStrengthQosModule</name>
    <title>OWNERSHIP_STRENGTH</title>
    <filename>group__DDSOwnershipStrengthQosModule.html</filename>
    <class kind="struct">DDS_OwnershipStrengthQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_OWNERSHIPSTRENGTH_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSOwnershipStrengthQosModule.html</anchorfile>
      <anchor>ga6ef729ad8937496eae51bb1b521f7cbb</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSPartitionQosModule</name>
    <title>PARTITION</title>
    <filename>group__DDSPartitionQosModule.html</filename>
    <class kind="struct">DDS_PartitionQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PARTITION_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSPartitionQosModule.html</anchorfile>
      <anchor>ga342e224dc462b1a921645abc9f40193b</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSPresentationQosModule</name>
    <title>PRESENTATION</title>
    <filename>group__DDSPresentationQosModule.html</filename>
    <class kind="struct">DDS_PresentationQosPolicy</class>
    <member kind="enumeration">
      <name>DDS_PresentationQosPolicyAccessScopeKind</name>
      <anchorfile>group__DDSPresentationQosModule.html</anchorfile>
      <anchor>ga123d979f855f637f32eb525b778175b2</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_INSTANCE_PRESENTATION_QOS</name>
      <anchorfile>group__DDSPresentationQosModule.html</anchorfile>
      <anchor>gga123d979f855f637f32eb525b778175b2ab7e8c01f13b9c46013094fdee7d6af36</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TOPIC_PRESENTATION_QOS</name>
      <anchorfile>group__DDSPresentationQosModule.html</anchorfile>
      <anchor>gga123d979f855f637f32eb525b778175b2a6d21a371adc6e10a62c2739171f5c22f</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_GROUP_PRESENTATION_QOS</name>
      <anchorfile>group__DDSPresentationQosModule.html</anchorfile>
      <anchor>gga123d979f855f637f32eb525b778175b2ae0591a04e045da1d86f25fa8bec39937</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_HIGHEST_OFFERED_PRESENTATION_QOS</name>
      <anchorfile>group__DDSPresentationQosModule.html</anchorfile>
      <anchor>gga123d979f855f637f32eb525b778175b2a197081ad5ba206346c667d9cecd7ad12</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PRESENTATION_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSPresentationQosModule.html</anchorfile>
      <anchor>ga900dc2e47524317be59bb2c565f93167</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSProfileQosModule</name>
    <title>PROFILE</title>
    <filename>group__DDSProfileQosModule.html</filename>
    <class kind="struct">DDS_ProfileQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSProfileQosModule.html</anchorfile>
      <anchor>ga8fba065e74868faf649cb8b9a84e225a</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSPropertyQosModule</name>
    <title>PROPERTY</title>
    <filename>group__DDSPropertyQosModule.html</filename>
    <class kind="struct">DDS_Property_t</class>
    <class kind="struct">DDS_PropertySeq</class>
    <class kind="struct">DDS_PropertyQosPolicy</class>
    <member kind="function">
      <type>DDS_Long</type>
      <name>DDS_PropertyQosPolicyHelper_get_number_of_properties</name>
      <anchorfile>group__DDSPropertyQosModule.html</anchorfile>
      <anchor>gade3dd4ad82dc4965aa3685bc9b41cbc7</anchor>
      <arglist>(const struct DDS_PropertyQosPolicy *policy)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_PropertyQosPolicyHelper_assert_property</name>
      <anchorfile>group__DDSPropertyQosModule.html</anchorfile>
      <anchor>gad428b85db4ce914a9a8552ce70bb7ee7</anchor>
      <arglist>(struct DDS_PropertyQosPolicy *policy, const char *name, const char *value, DDS_Boolean propagate)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_PropertyQosPolicyHelper_add_property</name>
      <anchorfile>group__DDSPropertyQosModule.html</anchorfile>
      <anchor>gaaa0b36adc5b0feafa6c2bb2e56bb3491</anchor>
      <arglist>(struct DDS_PropertyQosPolicy *policy, const char *name, const char *value, DDS_Boolean propagate)</arglist>
    </member>
    <member kind="function">
      <type>struct DDS_Property_t *</type>
      <name>DDS_PropertyQosPolicyHelper_lookup_property</name>
      <anchorfile>group__DDSPropertyQosModule.html</anchorfile>
      <anchor>ga742c94e57ef5edf670c6f6cc8c59c1ef</anchor>
      <arglist>(struct DDS_PropertyQosPolicy *policy, const char *name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_PropertyQosPolicyHelper_remove_property</name>
      <anchorfile>group__DDSPropertyQosModule.html</anchorfile>
      <anchor>gaebf417a0734d74b6244653cae5f3ad52</anchor>
      <arglist>(struct DDS_PropertyQosPolicy *policy, const char *name)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_PropertyQosPolicyHelper_get_properties</name>
      <anchorfile>group__DDSPropertyQosModule.html</anchorfile>
      <anchor>ga8222ac2d6c739188f77bd246afef2a53</anchor>
      <arglist>(struct DDS_PropertyQosPolicy *policy, struct DDS_PropertySeq *properties, const char *name_prefix)</arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROPERTY_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSPropertyQosModule.html</anchorfile>
      <anchor>ga944fb93c287fe289c504636c8440f09c</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSPublishModeQosModule</name>
    <title>PUBLISH_MODE</title>
    <filename>group__DDSPublishModeQosModule.html</filename>
    <class kind="struct">DDS_PublishModeQosPolicy</class>
    <member kind="define">
      <type>#define</type>
      <name>DDS_PUBLICATION_PRIORITY_UNDEFINED</name>
      <anchorfile>group__DDSPublishModeQosModule.html</anchorfile>
      <anchor>ga7f54323acc81cece560738a363ba1d8a</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_PUBLICATION_PRIORITY_AUTOMATIC</name>
      <anchorfile>group__DDSPublishModeQosModule.html</anchorfile>
      <anchor>ga0a64ad713b96e67908a0abe008cd938a</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumeration">
      <name>DDS_PublishModeQosPolicyKind</name>
      <anchorfile>group__DDSPublishModeQosModule.html</anchorfile>
      <anchor>ga7c71d1e8aba7e852f23c9fcce4b80b42</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_SYNCHRONOUS_PUBLISH_MODE_QOS</name>
      <anchorfile>group__DDSPublishModeQosModule.html</anchorfile>
      <anchor>gga7c71d1e8aba7e852f23c9fcce4b80b42ac767f78a22d81ac1988d6b94d2908a3b</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_ASYNCHRONOUS_PUBLISH_MODE_QOS</name>
      <anchorfile>group__DDSPublishModeQosModule.html</anchorfile>
      <anchor>gga7c71d1e8aba7e852f23c9fcce4b80b42a4ca8021581a2541bb90d19d64fb0ac1e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PUBLISHMODE_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSPublishModeQosModule.html</anchorfile>
      <anchor>gaa607e829eab258e89dad196ee9fcc44e</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSReaderDataLifecycleQosModule</name>
    <title>READER_DATA_LIFECYCLE</title>
    <filename>group__DDSReaderDataLifecycleQosModule.html</filename>
    <class kind="struct">DDS_ReaderDataLifecycleQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_READERDATALIFECYCLE_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSReaderDataLifecycleQosModule.html</anchorfile>
      <anchor>gaa9fba25045c5b10b5893f47e01e596dd</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSReceiverPoolQosModule</name>
    <title>RECEIVER_POOL</title>
    <filename>group__DDSReceiverPoolQosModule.html</filename>
    <class kind="struct">DDS_ReceiverPoolQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_RECEIVERPOOL_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSReceiverPoolQosModule.html</anchorfile>
      <anchor>gae46437082166dad2d34bed8540db692c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const DDS_Long</type>
      <name>DDS_LENGTH_AUTO</name>
      <anchorfile>group__DDSReceiverPoolQosModule.html</anchorfile>
      <anchor>ga6933fba9f01758e62c667ddde633fdd1</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSReliabilityQosModule</name>
    <title>RELIABILITY</title>
    <filename>group__DDSReliabilityQosModule.html</filename>
    <class kind="struct">DDS_ReliabilityQosPolicy</class>
    <member kind="enumeration">
      <name>DDS_ReliabilityQosPolicyKind</name>
      <anchorfile>group__DDSReliabilityQosModule.html</anchorfile>
      <anchor>gaf09e82d431c2328186c7fb4b3fa9ad91</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_BEST_EFFORT_RELIABILITY_QOS</name>
      <anchorfile>group__DDSReliabilityQosModule.html</anchorfile>
      <anchor>ggaf09e82d431c2328186c7fb4b3fa9ad91aae82431f2015239328733f3cb41d780d</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_RELIABLE_RELIABILITY_QOS</name>
      <anchorfile>group__DDSReliabilityQosModule.html</anchorfile>
      <anchor>ggaf09e82d431c2328186c7fb4b3fa9ad91ae5d04022c6405f9db6406489956d1923</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumeration">
      <name>DDS_ReliabilityQosPolicyAcknowledgmentModeKind</name>
      <anchorfile>group__DDSReliabilityQosModule.html</anchorfile>
      <anchor>ga288de7529d06055c9edd3900a73f3dca</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_PROTOCOL_ACKNOWLEDGMENT_MODE</name>
      <anchorfile>group__DDSReliabilityQosModule.html</anchorfile>
      <anchor>gga288de7529d06055c9edd3900a73f3dcaaeffb3d742ceb0c5f9f0e6faa9b2be363</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_APPLICATION_AUTO_ACKNOWLEDGMENT_MODE</name>
      <anchorfile>group__DDSReliabilityQosModule.html</anchorfile>
      <anchor>gga288de7529d06055c9edd3900a73f3dcaa03b205febaff413c71b700c4979d8c8f</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_APPLICATION_EXPLICIT_ACKNOWLEDGMENT_MODE</name>
      <anchorfile>group__DDSReliabilityQosModule.html</anchorfile>
      <anchor>gga288de7529d06055c9edd3900a73f3dcaa48e6db746c88202c67f9801d15ba1477</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_RELIABILITY_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSReliabilityQosModule.html</anchorfile>
      <anchor>gaa2ea1a3a781a45f219367f7692b22d88</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSResourceLimitsQosModule</name>
    <title>RESOURCE_LIMITS</title>
    <filename>group__DDSResourceLimitsQosModule.html</filename>
    <class kind="struct">DDS_ResourceLimitsQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_RESOURCELIMITS_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSResourceLimitsQosModule.html</anchorfile>
      <anchor>ga23a54790589cda39a3386d8b125e1d3a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const DDS_Long</type>
      <name>DDS_LENGTH_UNLIMITED</name>
      <anchorfile>group__DDSResourceLimitsQosModule.html</anchorfile>
      <anchor>ga58912505c0b73a5f1d3677eaf9ce9e6d</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSSystemResourceLimitsQosModule</name>
    <title>SYSTEM_RESOURCE_LIMITS</title>
    <filename>group__DDSSystemResourceLimitsQosModule.html</filename>
    <class kind="struct">DDS_SystemResourceLimitsQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_SYSTEMRESOURCELIMITS_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSSystemResourceLimitsQosModule.html</anchorfile>
      <anchor>gaf4619064d506b3035184602c6fbca48f</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSTimeBasedFilterQosModule</name>
    <title>TIME_BASED_FILTER</title>
    <filename>group__DDSTimeBasedFilterQosModule.html</filename>
    <class kind="struct">DDS_TimeBasedFilterQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_TIMEBASEDFILTER_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSTimeBasedFilterQosModule.html</anchorfile>
      <anchor>gadf9bb98444c0e81442be12f7d4cf1255</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSTopicDataQosModule</name>
    <title>TOPIC_DATA</title>
    <filename>group__DDSTopicDataQosModule.html</filename>
    <class kind="struct">DDS_TopicDataQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_TOPICDATA_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSTopicDataQosModule.html</anchorfile>
      <anchor>ga69cc17a9cadbd428ad6eaea256a76325</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSTransportBuiltinQosModule</name>
    <title>TRANSPORT_BUILTIN</title>
    <filename>group__DDSTransportBuiltinQosModule.html</filename>
    <class kind="struct">DDS_TransportBuiltinQosPolicy</class>
    <member kind="define">
      <type>#define</type>
      <name>DDS_TRANSPORTBUILTIN_MASK_NONE</name>
      <anchorfile>group__DDSTransportBuiltinQosModule.html</anchorfile>
      <anchor>ga6ca4849d4fd1acc45ab078eb6a7369c3</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_TRANSPORTBUILTIN_MASK_DEFAULT</name>
      <anchorfile>group__DDSTransportBuiltinQosModule.html</anchorfile>
      <anchor>gab0aa337e14820376edb24366dd8796ec</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_TRANSPORTBUILTIN_MASK_ALL</name>
      <anchorfile>group__DDSTransportBuiltinQosModule.html</anchorfile>
      <anchor>gad3cb1d021917fba305653d540686e8ff</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>DDS_Long</type>
      <name>DDS_TransportBuiltinKindMask</name>
      <anchorfile>group__DDSTransportBuiltinQosModule.html</anchorfile>
      <anchor>ga6e1f304ca96188f87b8b35f6c872ef33</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumeration">
      <name>DDS_TransportBuiltinKind</name>
      <anchorfile>group__DDSTransportBuiltinQosModule.html</anchorfile>
      <anchor>ga7e413d72243d5e455e53b6c253945f2f</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TRANSPORTBUILTIN_UDPv4</name>
      <anchorfile>group__DDSTransportBuiltinQosModule.html</anchorfile>
      <anchor>gga7e413d72243d5e455e53b6c253945f2fab541d85f88d888f2f1eaff0c5eaebd3b</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TRANSPORTBUILTIN_SHMEM</name>
      <anchorfile>group__DDSTransportBuiltinQosModule.html</anchorfile>
      <anchor>gga7e413d72243d5e455e53b6c253945f2faf52465922ef11f74c7fa91d36bf3b8d6</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_TRANSPORTBUILTIN_UDPv6</name>
      <anchorfile>group__DDSTransportBuiltinQosModule.html</anchorfile>
      <anchor>gga7e413d72243d5e455e53b6c253945f2fa1fdd0161e262303b4bf32133be1c10de</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_TRANSPORTBUILTIN_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSTransportBuiltinQosModule.html</anchorfile>
      <anchor>ga0b318caf36a4b9f537e00998b83359ab</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_TRANSPORTBUILTIN_SHMEM_ALIAS</name>
      <anchorfile>group__DDSTransportBuiltinQosModule.html</anchorfile>
      <anchor>gaef8fc55a836215119b2805d8c01b1680</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_TRANSPORTBUILTIN_UDPv4_ALIAS</name>
      <anchorfile>group__DDSTransportBuiltinQosModule.html</anchorfile>
      <anchor>gaadda867090751859c8c9a3263cae17b2</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_TRANSPORTBUILTIN_UDPv6_ALIAS</name>
      <anchorfile>group__DDSTransportBuiltinQosModule.html</anchorfile>
      <anchor>ga6f0968f238d76555e8a40de446c4ec2e</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSTransportMulticastQosModule</name>
    <title>TRANSPORT_MULTICAST</title>
    <filename>group__DDSTransportMulticastQosModule.html</filename>
    <subgroup>DDSTransportMulticastSettingsModule</subgroup>
    <subgroup>DDSTransportMulticastMappingModule</subgroup>
    <class kind="struct">DDS_TransportMulticastQosPolicy</class>
    <member kind="enumeration">
      <name>DDS_TransportMulticastQosPolicyKind</name>
      <anchorfile>group__DDSTransportMulticastQosModule.html</anchorfile>
      <anchor>ga3fffb4774defdccc38faaea64c40e209</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_AUTOMATIC_TRANSPORT_MULTICAST_QOS</name>
      <anchorfile>group__DDSTransportMulticastQosModule.html</anchorfile>
      <anchor>gga3fffb4774defdccc38faaea64c40e209a4cb9aec4ac33f07a23630b1522463ee5</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_UNICAST_ONLY_TRANSPORT_MULTICAST_QOS</name>
      <anchorfile>group__DDSTransportMulticastQosModule.html</anchorfile>
      <anchor>gga3fffb4774defdccc38faaea64c40e209aeeb63b90bdca09a992c76a742b453c3b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_TRANSPORTMULTICAST_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSTransportMulticastQosModule.html</anchorfile>
      <anchor>ga9565e886335b23f5401673438e5d9e8c</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSTransportMulticastMappingQosModule</name>
    <title>TRANSPORT_MULTICAST_MAPPING</title>
    <filename>group__DDSTransportMulticastMappingQosModule.html</filename>
    <class kind="struct">DDS_TransportMulticastMappingQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_TRANSPORTMULTICASTMAPPING_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSTransportMulticastMappingQosModule.html</anchorfile>
      <anchor>ga830714052e5df0248b3771ff2b2fd875</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSTransportPriorityQosModule</name>
    <title>TRANSPORT_PRIORITY</title>
    <filename>group__DDSTransportPriorityQosModule.html</filename>
    <class kind="struct">DDS_TransportPriorityQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_TRANSPORTPRIORITY_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSTransportPriorityQosModule.html</anchorfile>
      <anchor>gaa22a1344ef745f814ee88652d83e18bf</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSTransportSelectionQosModule</name>
    <title>TRANSPORT_SELECTION</title>
    <filename>group__DDSTransportSelectionQosModule.html</filename>
    <class kind="struct">DDS_TransportSelectionQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_TRANSPORTSELECTION_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSTransportSelectionQosModule.html</anchorfile>
      <anchor>ga78b8c9ca7cf6520457012bf15fa8ffb7</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSTransportUnicastQosModule</name>
    <title>TRANSPORT_UNICAST</title>
    <filename>group__DDSTransportUnicastQosModule.html</filename>
    <subgroup>DDSTransportUnicastSettingsModule</subgroup>
    <class kind="struct">DDS_TransportUnicastQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_TRANSPORTUNICAST_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSTransportUnicastQosModule.html</anchorfile>
      <anchor>ga94b06f9b11ccb85650a8fb51c7afcd54</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSTypeConsistencyEnforcementQosModule</name>
    <title>TYPE_CONSISTENCY_ENFORCEMENT</title>
    <filename>group__DDSTypeConsistencyEnforcementQosModule.html</filename>
    <class kind="struct">DDS_TypeConsistencyEnforcementQosPolicy</class>
    <member kind="enumeration">
      <name>DDS_TypeConsistencyKind</name>
      <anchorfile>group__DDSTypeConsistencyEnforcementQosModule.html</anchorfile>
      <anchor>ga2f14b750ee0af86a09a0663a9c2c08f2</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_DISALLOW_TYPE_COERCION</name>
      <anchorfile>group__DDSTypeConsistencyEnforcementQosModule.html</anchorfile>
      <anchor>gga2f14b750ee0af86a09a0663a9c2c08f2a81457fae2aea099cb0374e4cba506750</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_ALLOW_TYPE_COERCION</name>
      <anchorfile>group__DDSTypeConsistencyEnforcementQosModule.html</anchorfile>
      <anchor>gga2f14b750ee0af86a09a0663a9c2c08f2afb435413e3805242703990f8a4032942</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_TYPE_CONSISTENCY_ENFORCEMENT_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSTypeConsistencyEnforcementQosModule.html</anchorfile>
      <anchor>gab8a98ab4c76a8414b632796ec4685d1a</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSTypeSupportQosModule</name>
    <title>TYPESUPPORT</title>
    <filename>group__DDSTypeSupportQosModule.html</filename>
    <class kind="struct">DDS_TypeSupportQosPolicy</class>
    <member kind="enumeration">
      <name>DDS_CdrPaddingKind</name>
      <anchorfile>group__DDSTypeSupportQosModule.html</anchorfile>
      <anchor>ga563e7c4a35aeb2022a2889e37688c620</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_ZERO_CDR_PADDING</name>
      <anchorfile>group__DDSTypeSupportQosModule.html</anchorfile>
      <anchor>gga563e7c4a35aeb2022a2889e37688c620af21f6145af2844d0f2ca1cae0ab371b5</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_NOT_SET_CDR_PADDING</name>
      <anchorfile>group__DDSTypeSupportQosModule.html</anchorfile>
      <anchor>gga563e7c4a35aeb2022a2889e37688c620a064ef575d62dcca00ce28d76e77eb544</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_AUTO_CDR_PADDING</name>
      <anchorfile>group__DDSTypeSupportQosModule.html</anchorfile>
      <anchor>gga563e7c4a35aeb2022a2889e37688c620aa350d0bd37a5031ae95f22b31c8ce2d8</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_TYPESUPPORT_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSTypeSupportQosModule.html</anchorfile>
      <anchor>gaef3412a0fe193f8a5ddd95ed195bcb3a</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSUserDataQosModule</name>
    <title>USER_DATA</title>
    <filename>group__DDSUserDataQosModule.html</filename>
    <class kind="struct">DDS_UserDataQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_USERDATA_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSUserDataQosModule.html</anchorfile>
      <anchor>ga3938bf7c85a8422a06c97fa3011a51bb</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSWriterDataLifecycleQosModule</name>
    <title>WRITER_DATA_LIFECYCLE</title>
    <filename>group__DDSWriterDataLifecycleQosModule.html</filename>
    <class kind="struct">DDS_WriterDataLifecycleQosPolicy</class>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_WRITERDATALIFECYCLE_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSWriterDataLifecycleQosModule.html</anchorfile>
      <anchor>ga4747197d5debb5fcac8e1771b7d8f444</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSWireProtocolQosModule</name>
    <title>WIRE_PROTOCOL</title>
    <filename>group__DDSWireProtocolQosModule.html</filename>
    <class kind="struct">DDS_RtpsWellKnownPorts_t</class>
    <class kind="struct">DDS_WireProtocolQosPolicy</class>
    <member kind="define">
      <type>#define</type>
      <name>DDS_RTPS_RESERVED_PORT_MASK_DEFAULT</name>
      <anchorfile>group__DDSWireProtocolQosModule.html</anchorfile>
      <anchor>ga1b5419759ed8988eeb702d44081eb7ba</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_RTPS_RESERVED_PORT_MASK_NONE</name>
      <anchorfile>group__DDSWireProtocolQosModule.html</anchorfile>
      <anchor>ga9c310ac062861f4c8f7387296e75789a</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>DDS_RTPS_RESERVED_PORT_MASK_ALL</name>
      <anchorfile>group__DDSWireProtocolQosModule.html</anchorfile>
      <anchor>ga8da9de511f05101aac031e5df5389c16</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>DDS_Long</type>
      <name>DDS_RtpsReservedPortKindMask</name>
      <anchorfile>group__DDSWireProtocolQosModule.html</anchorfile>
      <anchor>gac88fa6d7bf97f0b0f8aa680b5a4c9bc3</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumeration">
      <name>DDS_RtpsReservedPortKind</name>
      <anchorfile>group__DDSWireProtocolQosModule.html</anchorfile>
      <anchor>ga71e7dce068b419c11d05392cebd3add0</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_RTPS_RESERVED_PORT_BUILTIN_UNICAST</name>
      <anchorfile>group__DDSWireProtocolQosModule.html</anchorfile>
      <anchor>gga71e7dce068b419c11d05392cebd3add0a02ff0d28093a0ce1d0baf6f0e03f54cb</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_RTPS_RESERVED_PORT_BUILTIN_MULTICAST</name>
      <anchorfile>group__DDSWireProtocolQosModule.html</anchorfile>
      <anchor>gga71e7dce068b419c11d05392cebd3add0a51db8ff1b6a5acc4da7b67e911c294a7</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_RTPS_RESERVED_PORT_USER_UNICAST</name>
      <anchorfile>group__DDSWireProtocolQosModule.html</anchorfile>
      <anchor>gga71e7dce068b419c11d05392cebd3add0aae428873a02ac16fa661a26e1ce98643</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_RTPS_RESERVED_PORT_USER_MULTICAST</name>
      <anchorfile>group__DDSWireProtocolQosModule.html</anchorfile>
      <anchor>gga71e7dce068b419c11d05392cebd3add0a8206ad89b7774789a016bfe62c018c3f</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumeration">
      <name>DDS_WireProtocolQosPolicyAutoKind</name>
      <anchorfile>group__DDSWireProtocolQosModule.html</anchorfile>
      <anchor>ga77715b85c8ddc488532ee25b44ae2298</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_RTPS_AUTO_ID_FROM_IP</name>
      <anchorfile>group__DDSWireProtocolQosModule.html</anchorfile>
      <anchor>gga77715b85c8ddc488532ee25b44ae2298a59784ece459057d0de87f7eff4b21c17</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>DDS_RTPS_AUTO_ID_FROM_MAC</name>
      <anchorfile>group__DDSWireProtocolQosModule.html</anchorfile>
      <anchor>gga77715b85c8ddc488532ee25b44ae2298ac53f702493967e2f2ee469241c4a5dda</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_RtpsWellKnownPorts_t</type>
      <name>DDS_RTI_BACKWARDS_COMPATIBLE_RTPS_WELL_KNOWN_PORTS</name>
      <anchorfile>group__DDSWireProtocolQosModule.html</anchorfile>
      <anchor>ga5502ae29160f5e3387097e02e4f034d4</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_RtpsWellKnownPorts_t</type>
      <name>DDS_INTEROPERABLE_RTPS_WELL_KNOWN_PORTS</name>
      <anchorfile>group__DDSWireProtocolQosModule.html</anchorfile>
      <anchor>ga8e1c02e92ccc930c8b89cafeeaf95045</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_WIREPROTOCOL_QOS_POLICY_NAME</name>
      <anchorfile>group__DDSWireProtocolQosModule.html</anchorfile>
      <anchor>gabedf25cb9836887985c6a0c5b08fbfda</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSExtendedQosSupportModule</name>
    <title>Extended Qos Support</title>
    <filename>group__DDSExtendedQosSupportModule.html</filename>
    <subgroup>DDSThreadSettingsModule</subgroup>
    <class kind="struct">DDS_RtpsReliableReaderProtocol_t</class>
    <class kind="struct">DDS_RtpsReliableWriterProtocol_t</class>
  </compound>
  <compound kind="group">
    <name>DDSTransportUnicastSettingsModule</name>
    <title>Unicast Settings</title>
    <filename>group__DDSTransportUnicastSettingsModule.html</filename>
    <class kind="struct">DDS_TransportUnicastSettings_t</class>
    <class kind="struct">DDS_TransportUnicastSettingsSeq</class>
  </compound>
  <compound kind="group">
    <name>DDSTransportMulticastSettingsModule</name>
    <title>Multicast Settings</title>
    <filename>group__DDSTransportMulticastSettingsModule.html</filename>
    <class kind="struct">DDS_TransportMulticastSettings_t</class>
    <class kind="struct">DDS_TransportMulticastSettingsSeq</class>
  </compound>
  <compound kind="group">
    <name>DDSTransportMulticastMappingModule</name>
    <title>Multicast Mapping</title>
    <filename>group__DDSTransportMulticastMappingModule.html</filename>
    <class kind="struct">DDS_TransportMulticastMappingFunction_t</class>
    <class kind="struct">DDS_TransportMulticastMapping_t</class>
    <class kind="struct">DDS_TransportMulticastMappingSeq</class>
  </compound>
  <compound kind="group">
    <name>NDDS_DISCOVERY_PEERS</name>
    <title>NDDS_DISCOVERY_PEERS</title>
    <filename>group__NDDS__DISCOVERY__PEERS.html</filename>
    <docanchor file="group__NDDS__DISCOVERY__PEERS">NDDS_DISCOVERY_PEERS_format</docanchor>
    <docanchor file="group__NDDS__DISCOVERY__PEERS">NDDS_DISCOVERY_PEERS_locator_format</docanchor>
    <docanchor file="group__NDDS__DISCOVERY__PEERS">NDDS_DISCOVERY_PEERS_address_format</docanchor>
    <docanchor file="group__NDDS__DISCOVERY__PEERS">NDDS_DISCOVERY_PEERS_env_format</docanchor>
    <docanchor file="group__NDDS__DISCOVERY__PEERS">NDDS_DISCOVERY_PEERS_file_format</docanchor>
    <docanchor file="group__NDDS__DISCOVERY__PEERS">NDDS_DISCOVERY_PEERS_precedence</docanchor>
    <docanchor file="group__NDDS__DISCOVERY__PEERS">NDDS_DISCOVERY_PEERS_default</docanchor>
    <docanchor file="group__NDDS__DISCOVERY__PEERS">NDDS_DISCOVERY_PEERS_builtin_transport_class_names</docanchor>
    <docanchor file="group__NDDS__DISCOVERY__PEERS">DDS_DISCOVERY_PEERS_localhost_communication</docanchor>
  </compound>
  <compound kind="group">
    <name>DDSEntityModule</name>
    <title>Entity Support</title>
    <filename>group__DDSEntityModule.html</filename>
    <class kind="struct">DDS_Listener</class>
    <member kind="define">
      <type>#define</type>
      <name>DDS_Listener_INITIALIZER</name>
      <anchorfile>group__DDSEntityModule.html</anchorfile>
      <anchor>ga0bdd4b3e8bc6992fa826639ca6aee7fc</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_EntityImpl</type>
      <name>DDS_Entity</name>
      <anchorfile>group__DDSEntityModule.html</anchorfile>
      <anchor>ga928b59d917d674720975f0581149b905</anchor>
      <arglist></arglist>
      <docanchor file="group__DDSEntityModule">Entity_abstract</docanchor>
      <docanchor file="group__DDSEntityModule">Entity_set_qos</docanchor>
      <docanchor file="group__DDSEntityModule">Entity_get_qos</docanchor>
      <docanchor file="group__DDSEntityModule">Entity_set_listener</docanchor>
      <docanchor file="group__DDSEntityModule">Entity_get_listener</docanchor>
    </member>
    <member kind="typedef">
      <type>struct DDS_DomainEntityImpl</type>
      <name>DDS_DomainEntity</name>
      <anchorfile>group__DDSEntityModule.html</anchorfile>
      <anchor>ga0cd8d7d61066e2a434918419e1514bfc</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_Entity_enable</name>
      <anchorfile>group__DDSEntityModule.html</anchorfile>
      <anchor>ga892fed8d9375b7c3c5f1f610f87e18da</anchor>
      <arglist>(DDS_Entity *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_StatusCondition *</type>
      <name>DDS_Entity_get_statuscondition</name>
      <anchorfile>group__DDSEntityModule.html</anchorfile>
      <anchor>ga6b87d4852f75de23efabe17207d42bfd</anchor>
      <arglist>(DDS_Entity *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_StatusMask</type>
      <name>DDS_Entity_get_status_changes</name>
      <anchorfile>group__DDSEntityModule.html</anchorfile>
      <anchor>ga5fc8d3d98ea83e405673e1797521ccca</anchor>
      <arglist>(DDS_Entity *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_InstanceHandle_t</type>
      <name>DDS_Entity_get_instance_handle</name>
      <anchorfile>group__DDSEntityModule.html</anchorfile>
      <anchor>gae13fc73dbd88ff0c6aa11e1a73706bb9</anchor>
      <arglist>(DDS_Entity *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_EntityKind_t</type>
      <name>DDS_Entity_get_entity_kind</name>
      <anchorfile>group__DDSEntityModule.html</anchorfile>
      <anchor>ga3971ad57bf4785b7acd465f9c047742f</anchor>
      <arglist>(DDS_Entity *self)</arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSConditionsModule</name>
    <title>Conditions and WaitSets</title>
    <filename>group__DDSConditionsModule.html</filename>
    <class kind="struct">DDS_ConditionSeq</class>
    <class kind="struct">DDS_WaitSetProperty_t</class>
    <member kind="define">
      <type>#define</type>
      <name>DDS_WaitSetProperty_t_INITIALIZER</name>
      <anchorfile>group__DDSConditionsModule.html</anchorfile>
      <anchor>gaa14c636175387f759974fcf5fcb158f5</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_ConditionImpl</type>
      <name>DDS_Condition</name>
      <anchorfile>group__DDSConditionsModule.html</anchorfile>
      <anchor>ga1c45ab3d5584bb3332e98266dc3f7d3d</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_GuardConditionImpl</type>
      <name>DDS_GuardCondition</name>
      <anchorfile>group__DDSConditionsModule.html</anchorfile>
      <anchor>gaf554f2c5553ffb66e26cee169e409cb3</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_StatusConditionImpl</type>
      <name>DDS_StatusCondition</name>
      <anchorfile>group__DDSConditionsModule.html</anchorfile>
      <anchor>gab365a205f11e5da37e380ef825c74ecd</anchor>
      <arglist></arglist>
    </member>
    <member kind="typedef">
      <type>struct DDS_WaitSetImpl</type>
      <name>DDS_WaitSet</name>
      <anchorfile>group__DDSConditionsModule.html</anchorfile>
      <anchor>gaffdc85b9ca97eb432a2c17c52bc00f82</anchor>
      <arglist></arglist>
      <docanchor file="group__DDSConditionsModule">WaitSet_usage</docanchor>
      <docanchor file="group__DDSConditionsModule">WaitSet_trigger_status</docanchor>
      <docanchor file="group__DDSConditionsModule">WaitSet_trigger_read</docanchor>
      <docanchor file="group__DDSConditionsModule">WaitSet_trigger_guard</docanchor>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_Condition_get_trigger_value</name>
      <anchorfile>group__DDSConditionsModule.html</anchorfile>
      <anchor>ga6009c136455cccd248f76517c914c71f</anchor>
      <arglist>(DDS_Condition *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Condition *</type>
      <name>DDS_GuardCondition_as_condition</name>
      <anchorfile>group__DDSConditionsModule.html</anchorfile>
      <anchor>ga7fb0711ce2966803e0e162021a59fb77</anchor>
      <arglist>(DDS_GuardCondition *guardCondition)</arglist>
    </member>
    <member kind="function">
      <type>DDS_GuardCondition *</type>
      <name>DDS_GuardCondition_new</name>
      <anchorfile>group__DDSConditionsModule.html</anchorfile>
      <anchor>ga67cc59d61074a591aa6396c67999fa87</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_GuardCondition_delete</name>
      <anchorfile>group__DDSConditionsModule.html</anchorfile>
      <anchor>ga06bf93bc3887f0f5b92ddcfa4f5bfa18</anchor>
      <arglist>(DDS_GuardCondition *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_GuardCondition_set_trigger_value</name>
      <anchorfile>group__DDSConditionsModule.html</anchorfile>
      <anchor>ga30d0856ec0b6695a386ef5e04cd3800a</anchor>
      <arglist>(DDS_GuardCondition *self, DDS_Boolean value)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Condition *</type>
      <name>DDS_StatusCondition_as_condition</name>
      <anchorfile>group__DDSConditionsModule.html</anchorfile>
      <anchor>ga719d9f240ff21dc8abb2626b8495beba</anchor>
      <arglist>(DDS_StatusCondition *statusCondition)</arglist>
    </member>
    <member kind="function">
      <type>DDS_StatusMask</type>
      <name>DDS_StatusCondition_get_enabled_statuses</name>
      <anchorfile>group__DDSConditionsModule.html</anchorfile>
      <anchor>ga6822bc88ab1314fd27325ab26cc5a547</anchor>
      <arglist>(DDS_StatusCondition *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_StatusCondition_set_enabled_statuses</name>
      <anchorfile>group__DDSConditionsModule.html</anchorfile>
      <anchor>ga27a961e2a0e97d5968dd1ce8f20d4010</anchor>
      <arglist>(DDS_StatusCondition *self, DDS_StatusMask mask)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Entity *</type>
      <name>DDS_StatusCondition_get_entity</name>
      <anchorfile>group__DDSConditionsModule.html</anchorfile>
      <anchor>ga85bd90a7af86c9e9e0c9402aab90a511</anchor>
      <arglist>(DDS_StatusCondition *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_WaitSet *</type>
      <name>DDS_WaitSet_new</name>
      <anchorfile>group__DDSConditionsModule.html</anchorfile>
      <anchor>gad2beb9390be39c5360b94ac106f20efd</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>DDS_WaitSet *</type>
      <name>DDS_WaitSet_new_ex</name>
      <anchorfile>group__DDSConditionsModule.html</anchorfile>
      <anchor>gae4aecad1242082842e408aaaece75fd8</anchor>
      <arglist>(const struct DDS_WaitSetProperty_t *prop)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_WaitSet_delete</name>
      <anchorfile>group__DDSConditionsModule.html</anchorfile>
      <anchor>ga3e6d5bcfc06936eecb589749391383f3</anchor>
      <arglist>(DDS_WaitSet *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_WaitSet_set_property</name>
      <anchorfile>group__DDSConditionsModule.html</anchorfile>
      <anchor>ga30b1ef891a3a0940ff527946466d3ede</anchor>
      <arglist>(DDS_WaitSet *self, const struct DDS_WaitSetProperty_t *prop)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_WaitSet_get_property</name>
      <anchorfile>group__DDSConditionsModule.html</anchorfile>
      <anchor>ga2456f529bc4c9baa12649c5f9992c419</anchor>
      <arglist>(DDS_WaitSet *self, struct DDS_WaitSetProperty_t *prop)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_WaitSet_wait</name>
      <anchorfile>group__DDSConditionsModule.html</anchorfile>
      <anchor>ga42860967e1dc1c5c7ee3ffd03d7eb54e</anchor>
      <arglist>(DDS_WaitSet *self, struct DDS_ConditionSeq *active_conditions, const struct DDS_Duration_t *timeout)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_WaitSet_attach_condition</name>
      <anchorfile>group__DDSConditionsModule.html</anchorfile>
      <anchor>ga8b0227e23a0d795cbaf0aee9d20ce0d0</anchor>
      <arglist>(DDS_WaitSet *self, DDS_Condition *cond)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_WaitSet_detach_condition</name>
      <anchorfile>group__DDSConditionsModule.html</anchorfile>
      <anchor>gab6888a6fdcc8ff13f5618d4b835a1dab</anchor>
      <arglist>(DDS_WaitSet *self, DDS_Condition *cond)</arglist>
    </member>
    <member kind="function">
      <type>DDS_ReturnCode_t</type>
      <name>DDS_WaitSet_get_conditions</name>
      <anchorfile>group__DDSConditionsModule.html</anchorfile>
      <anchor>ga4138069fa07abe2ce1a4a00b134dbdb3</anchor>
      <arglist>(DDS_WaitSet *self, struct DDS_ConditionSeq *attached_conditions)</arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSCookieModule</name>
    <title>Cookie</title>
    <filename>group__DDSCookieModule.html</filename>
    <class kind="struct">DDS_Cookie_t</class>
  </compound>
  <compound kind="group">
    <name>DDSWriteParamsModule</name>
    <title>WriteParams</title>
    <filename>group__DDSWriteParamsModule.html</filename>
    <class kind="struct">DDS_SampleIdentity_t</class>
    <class kind="struct">DDS_WriteParams_t</class>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>DDS_SampleIdentity_equals</name>
      <anchorfile>group__DDSWriteParamsModule.html</anchorfile>
      <anchor>gae78cca512205dc5db2a1e097868f980e</anchor>
      <arglist>(const struct DDS_SampleIdentity_t *self, const struct DDS_SampleIdentity_t *other)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>DDS_WriteParams_reset</name>
      <anchorfile>group__DDSWriteParamsModule.html</anchorfile>
      <anchor>ga62f0f1b1ee4503c9fedbf340148dca0c</anchor>
      <arglist>(struct DDS_WriteParams_t *self)</arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_GUID_t</type>
      <name>writer_guid</name>
      <anchorfile>group__DDSWriteParamsModule.html</anchorfile>
      <anchor>ga541fc431fa4eb3472e1d5ed3588691ff</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SequenceNumber_t</type>
      <name>sequence_number</name>
      <anchorfile>group__DDSWriteParamsModule.html</anchorfile>
      <anchor>gab784a7f40efde9c165e60d94c49309a8</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SampleIdentity_t</type>
      <name>DDS_AUTO_SAMPLE_IDENTITY</name>
      <anchorfile>group__DDSWriteParamsModule.html</anchorfile>
      <anchor>ga589116c64f4216eafecedaa8b5649661</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SampleIdentity_t</type>
      <name>DDS_UNKNOWN_SAMPLE_IDENTITY</name>
      <anchorfile>group__DDSWriteParamsModule.html</anchorfile>
      <anchor>gae844d8a490343dfaa9facac7566784a9</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_WriteParams_t</type>
      <name>DDS_WRITEPARAMS_DEFAULT</name>
      <anchorfile>group__DDSWriteParamsModule.html</anchorfile>
      <anchor>ga7bf52a0658663c171854c10a92a7be2c</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSHeapClass</name>
    <title>Heap Support</title>
    <filename>group__DDSHeapClass.html</filename>
    <member kind="function">
      <type>void *</type>
      <name>DDS_Heap_calloc</name>
      <anchorfile>group__DDSHeapClass.html</anchorfile>
      <anchor>ga3bdadf75592e3c34edb59f120c604f6b</anchor>
      <arglist>(size_t numElem, size_t size)</arglist>
    </member>
    <member kind="function">
      <type>void *</type>
      <name>DDS_Heap_malloc</name>
      <anchorfile>group__DDSHeapClass.html</anchorfile>
      <anchor>ga42637c69d72a9e43c3272931f1d2461b</anchor>
      <arglist>(size_t size)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>DDS_Heap_free</name>
      <anchorfile>group__DDSHeapClass.html</anchorfile>
      <anchor>gae00d96cd7a293a2d9b59cf8ea42d96ab</anchor>
      <arglist>(void *ptr)</arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSBuiltinQosProfilesModule</name>
    <title>Builtin Qos Profiles</title>
    <filename>group__DDSBuiltinQosProfilesModule.html</filename>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_BUILTIN_QOS_LIB</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>gac8ddbed4a6ebeb4c96d291cfd1cfa1fa</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_BASELINE_ROOT</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>gaf6158aa692ca313c020ddeb62e65b8bd</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_BASELINE</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>gaa23a84af58e2418ae4a06c0ac3f6aacd</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_BASELINE_5_0_0</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>gaf8e3aaf19175bacdddeb0e88b0c28e31</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_BASELINE_5_1_0</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>ga27aa003a09cb1fa24529a405688c3e6e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_GENERIC_COMMON</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>ga9c6603e2737ef49c0190ab7e04ae8b65</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_GENERIC_MONITORING_COMMON</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>ga59b3f97fbb536c84c4cee613394ccf56</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_GENERIC_CONNEXT_MICRO_COMPATIBILITY</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>gadf2e38d6ed5fccd22baecd2ec0235420</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_BUILTIN_QOS_LIB_EXP</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>gaea14dcc7c1bd95e3eac99cb75bbca3ef</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_GENERIC_STRICT_RELIABLE</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>ga014a42b61b8211eb3ed756cea9270b14</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_GENERIC_KEEP_LAST_RELIABLE</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>ga8fc9b078df9e3b885c91e59304dcf435</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_GENERIC_BEST_EFFORT</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>gae9705c7f3a077ba7d30bfe2e4d6bfb7c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_GENERIC_STRICT_RELIABLE_HIGH_THROUGHPUT</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>ga9db89b51347cff70b4c8cbaddfdaa39e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_GENERIC_STRICT_RELIABLE_LOW_LATENCY</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>ga010887ad6f46434b76ebf40e2741b50f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_GENERIC_PARTICIPANT_LARGE_DATA</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>gabde2971009c250f458aac6428ec134fb</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_GENERIC_PARTICIPANT_LARGE_DATA_MONITORING</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>gab9ceb5e33cb0edfe8b459b40a7284bf6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_GENERIC_STRICT_RELIABLE_LARGE_DATA</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>ga69065c6ff0d56645b47032c54f914929</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_GENERIC_KEEP_LAST_RELIABLE_LARGE_DATA</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>ga9752106250f452cfaf6946b7abe4b960</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_GENERIC_STRICT_RELIABLE_LARGE_DATA_FAST_FLOW</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>ga47ca43f019b90f203bd944241f9fa95c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_GENERIC_STRICT_RELIABLE_LARGE_DATA_MEDIUM_FLOW</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>ga100d67ae1d7da873b89e3fbcbf8bfc11</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_GENERIC_STRICT_RELIABLE_LARGE_DATA_SLOW_FLOW</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>gae4d5d170efa479d47175c9ea50b0673d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_GENERIC_KEEP_LAST_RELIABLE_LARGE_DATA_FAST_FLOW</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>ga7cff15b662bd27da31fd507b091a8218</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_GENERIC_KEEP_LAST_RELIABLE_LARGE_DATA_MEDIUM_FLOW</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>ga1c6cb2f0b154ec81e5e4a92e035437d5</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_GENERIC_KEEP_LAST_RELIABLE_LARGE_DATA_SLOW_FLOW</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>ga0500bc5a6c666c78c0ec27753097387a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_GENERIC_KEEP_LAST_RELIABLE_TRANSIENT_LOCAL</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>ga0017c88750a3e4aace84916db6a10058</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_GENERIC_KEEP_LAST_RELIABLE_TRANSIENT</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>ga13f5e5704d458cc7dbfb2f7b57cef752</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_GENERIC_KEEP_LAST_RELIABLE_PERSISTENT</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>ga4be205a4ac503d4b1ae5e6d02f62ef79</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_GENERIC_AUTO_TUNING</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>ga60ab19025d183e7c8317710b7d4cb629</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_PATTERN_PERIODIC_DATA</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>ga15c50c48c70ff7b75ba687b121f9c793</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_PATTERN_STREAMING</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>gaa616086aecf4c78606dc27ba053b51e5</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_PATTERN_RELIABLE_STREAMING</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>gadaff173faa04eb6a5f915dbddab5cf1c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_PATTERN_EVENT</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>gab4a7dbc71bba7c2bf5cf38e4b689dde6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_PATTERN_ALARM_EVENT</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>gacee4ac182195f8d7a3a4d2e5a09a4dfd</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_PATTERN_STATUS</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>gae3e95eb9b1c3b9dc06061cb45773ade2</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_PATTERN_ALARM_STATUS</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>ga4d84c111a06810dd9a3fa676240f1e19</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *const</type>
      <name>DDS_PROFILE_PATTERN_LAST_VALUE_CACHE</name>
      <anchorfile>group__DDSBuiltinQosProfilesModule.html</anchorfile>
      <anchor>gaa312ac8dc83f7b90102ff648a4f3a4cc</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSDomainParticipantConfigParamsModule</name>
    <title>DomainParticipantConfigParams</title>
    <filename>group__DDSDomainParticipantConfigParamsModule.html</filename>
    <class kind="struct">DDS_DomainParticipantConfigParams_t</class>
    <member kind="define">
      <type>#define</type>
      <name>DDS_DomainParticipantConfigParams_t_INITIALIZER</name>
      <anchorfile>group__DDSDomainParticipantConfigParamsModule.html</anchorfile>
      <anchor>ga58ad4f1541ea459a3b486242c0784a22</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const int</type>
      <name>DDS_DOMAIN_ID_USE_XML_CONFIG</name>
      <anchorfile>group__DDSDomainParticipantConfigParamsModule.html</anchorfile>
      <anchor>ga9c8c18a119504163c8544e719153529e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *</type>
      <name>DDS_ENTITY_NAME_USE_XML_CONFIG</name>
      <anchorfile>group__DDSDomainParticipantConfigParamsModule.html</anchorfile>
      <anchor>gabb05a486517015ddb5f4e272d4e6348d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *</type>
      <name>DDS_QOS_ELEMENT_NAME_USE_XML_CONFIG</name>
      <anchorfile>group__DDSDomainParticipantConfigParamsModule.html</anchorfile>
      <anchor>ga4c6600a6ce41ed0f6ebaa05efba39e7a</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSOctetBufferClass</name>
    <title>Octet Buffer Support</title>
    <filename>group__DDSOctetBufferClass.html</filename>
    <member kind="function">
      <type>unsigned char *</type>
      <name>DDS_OctetBuffer_alloc</name>
      <anchorfile>group__DDSOctetBufferClass.html</anchorfile>
      <anchor>ga6874aeb6ea85085d8ee231acb03046f7</anchor>
      <arglist>(unsigned int size)</arglist>
    </member>
    <member kind="function">
      <type>unsigned char *</type>
      <name>DDS_OctetBuffer_dup</name>
      <anchorfile>group__DDSOctetBufferClass.html</anchorfile>
      <anchor>ga4044b653a659395927fd737d4f4ddc21</anchor>
      <arglist>(const unsigned char *buffer, unsigned int size)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>DDS_OctetBuffer_free</name>
      <anchorfile>group__DDSOctetBufferClass.html</anchorfile>
      <anchor>gab1544366d61e59aa40086de42ce0829d</anchor>
      <arglist>(unsigned char *buffer)</arglist>
    </member>
    <docanchor file="group__DDSOctetBufferClass">DDSOctetBufferClass_conventions</docanchor>
    <docanchor file="group__DDSOctetBufferClass">DDSOctetBufferClass_usage</docanchor>
  </compound>
  <compound kind="group">
    <name>DDSSequenceModule</name>
    <title>Sequence Support</title>
    <filename>group__DDSSequenceModule.html</filename>
    <subgroup>DDSBuiltinSequenceModule</subgroup>
    <class kind="struct">FooSeq</class>
    <member kind="define">
      <type>#define</type>
      <name>DDS_SEQUENCE_INITIALIZER</name>
      <anchorfile>group__DDSSequenceModule.html</anchorfile>
      <anchor>ga521eb819a3b85277debce55d61b08f82</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>FooSeq_initialize</name>
      <anchorfile>group__DDSSequenceModule.html</anchorfile>
      <anchor>ga247367cb6c2a478370327b3628b6ef81</anchor>
      <arglist>(struct FooSeq *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Long</type>
      <name>FooSeq_get_maximum</name>
      <anchorfile>group__DDSSequenceModule.html</anchorfile>
      <anchor>gab3765cd5c745da088f3772a1a8578cef</anchor>
      <arglist>(const struct FooSeq *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>FooSeq_set_maximum</name>
      <anchorfile>group__DDSSequenceModule.html</anchorfile>
      <anchor>gadf5b537079d3997b4acddc9a4af11c63</anchor>
      <arglist>(struct FooSeq *self, DDS_Long new_max)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Long</type>
      <name>FooSeq_get_length</name>
      <anchorfile>group__DDSSequenceModule.html</anchorfile>
      <anchor>gaf7a45e00319eeb1ddf5c84ac68657adb</anchor>
      <arglist>(const struct FooSeq *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>FooSeq_set_length</name>
      <anchorfile>group__DDSSequenceModule.html</anchorfile>
      <anchor>gaa6f7cf4be9012fee3ca476c69f821bc6</anchor>
      <arglist>(struct FooSeq *self, DDS_Long new_length)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>FooSeq_ensure_length</name>
      <anchorfile>group__DDSSequenceModule.html</anchorfile>
      <anchor>ga85c3c42ee1154be119266c8e6fff3659</anchor>
      <arglist>(struct FooSeq *self, DDS_Long length, DDS_Long max)</arglist>
    </member>
    <member kind="function">
      <type>Foo</type>
      <name>FooSeq_get</name>
      <anchorfile>group__DDSSequenceModule.html</anchorfile>
      <anchor>ga1eb9a7dd63886579379aa2ac9d786c05</anchor>
      <arglist>(const struct FooSeq *self, DDS_Long i)</arglist>
    </member>
    <member kind="function">
      <type>Foo *</type>
      <name>FooSeq_get_reference</name>
      <anchorfile>group__DDSSequenceModule.html</anchorfile>
      <anchor>gae45e554a45615fedbb75398a3e3f9fea</anchor>
      <arglist>(const struct FooSeq *self, DDS_Long i)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>FooSeq_copy_no_alloc</name>
      <anchorfile>group__DDSSequenceModule.html</anchorfile>
      <anchor>ga145a30d7e8f1a6d5c0c3c80e4b6b4e1e</anchor>
      <arglist>(struct FooSeq *self, const struct FooSeq *src_seq)</arglist>
    </member>
    <member kind="function">
      <type>FooSeq *</type>
      <name>FooSeq_copy</name>
      <anchorfile>group__DDSSequenceModule.html</anchorfile>
      <anchor>gab1eeab81b351a4fbb79c11a85ceb485b</anchor>
      <arglist>(struct FooSeq *self, const struct FooSeq *src_seq)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>FooSeq_from_array</name>
      <anchorfile>group__DDSSequenceModule.html</anchorfile>
      <anchor>ga11413fcc7cc13ccfeb7d5048648ce1e7</anchor>
      <arglist>(struct FooSeq *self, const Foo array[], DDS_Long length)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>FooSeq_to_array</name>
      <anchorfile>group__DDSSequenceModule.html</anchorfile>
      <anchor>ga2efcc1d05bcbf4ff3054b0f0395d0922</anchor>
      <arglist>(struct FooSeq *self, Foo array[], DDS_Long length)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>FooSeq_loan_contiguous</name>
      <anchorfile>group__DDSSequenceModule.html</anchorfile>
      <anchor>ga10d6e06dcf1653244945b0a6e73c7f53</anchor>
      <arglist>(struct FooSeq *self, Foo *buffer, DDS_Long new_length, DDS_Long new_max)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>FooSeq_loan_discontiguous</name>
      <anchorfile>group__DDSSequenceModule.html</anchorfile>
      <anchor>ga71018e377836517dedb9b243bf10df05</anchor>
      <arglist>(struct FooSeq *self, Foo **buffer, DDS_Long new_length, DDS_Long new_max)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>FooSeq_unloan</name>
      <anchorfile>group__DDSSequenceModule.html</anchorfile>
      <anchor>gaba7a2c4cf49f72627f9b445b697b2364</anchor>
      <arglist>(struct FooSeq *self)</arglist>
    </member>
    <member kind="function">
      <type>Foo *</type>
      <name>FooSeq_get_contiguous_buffer</name>
      <anchorfile>group__DDSSequenceModule.html</anchorfile>
      <anchor>ga5535ba97da0e77b45489a772759f2e83</anchor>
      <arglist>(const struct FooSeq *self)</arglist>
    </member>
    <member kind="function">
      <type>Foo **</type>
      <name>FooSeq_get_discontiguous_buffer</name>
      <anchorfile>group__DDSSequenceModule.html</anchorfile>
      <anchor>gabf21100a0446978244dd3f80fa5bf922</anchor>
      <arglist>(const struct FooSeq *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>FooSeq_has_ownership</name>
      <anchorfile>group__DDSSequenceModule.html</anchorfile>
      <anchor>gaca64a79c4b5c96bb230cf3d5075f35aa</anchor>
      <arglist>(const struct FooSeq *self)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Boolean</type>
      <name>FooSeq_finalize</name>
      <anchorfile>group__DDSSequenceModule.html</anchorfile>
      <anchor>gae1a415ca306572994f50eb07476b5299</anchor>
      <arglist>(struct FooSeq *self)</arglist>
    </member>
  </compound>
  <compound kind="group">
    <name>DDSStringClass</name>
    <title>String Support</title>
    <filename>group__DDSStringClass.html</filename>
    <member kind="function">
      <type>char *</type>
      <name>DDS_String_alloc</name>
      <anchorfile>group__DDSStringClass.html</anchorfile>
      <anchor>gac243227428eb05799e9f1ab30aeefa85</anchor>
      <arglist>(size_t length)</arglist>
    </member>
    <member kind="function">
      <type>char *</type>
      <name>DDS_String_dup</name>
      <anchorfile>group__DDSStringClass.html</anchorfile>
      <anchor>gaaadc788c3850b5625c6d78794943db7d</anchor>
      <arglist>(const char *str)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>DDS_String_free</name>
      <anchorfile>group__DDSStringClass.html</anchorfile>
      <anchor>ga13074f0132f743923a4a36ee533997fe</anchor>
      <arglist>(char *str)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Wchar *</type>
      <name>DDS_Wstring_alloc</name>
      <anchorfile>group__DDSStringClass.html</anchorfile>
      <anchor>ga9aa1d876248a07849dde1d80ad7ddabd</anchor>
      <arglist>(DDS_UnsignedLong length)</arglist>
    </member>
    <member kind="function">
      <type>DDS_UnsignedLong</type>
      <name>DDS_Wstring_length</name>
      <anchorfile>group__DDSStringClass.html</anchorfile>
      <anchor>ga22288be0eacf2af3953451235b09f46c</anchor>
      <arglist>(const DDS_Wchar *str)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Wchar *</type>
      <name>DDS_Wstring_copy</name>
      <anchorfile>group__DDSStringClass.html</anchorfile>
      <anchor>ga3bd687c1bb2d175f2c60a97dff412302</anchor>
      <arglist>(DDS_Wchar *dst, const DDS_Wchar *src)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Wchar *</type>
      <name>DDS_Wstring_copy_and_widen</name>
      <anchorfile>group__DDSStringClass.html</anchorfile>
      <anchor>ga37130e3833ec894270cd5218a614709a</anchor>
      <arglist>(DDS_Wchar *dst, const char *src)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Wchar *</type>
      <name>DDS_Wstring_dup</name>
      <anchorfile>group__DDSStringClass.html</anchorfile>
      <anchor>ga9918181ab2531231c49f74bc8adbf66a</anchor>
      <arglist>(const DDS_Wchar *str)</arglist>
    </member>
    <member kind="function">
      <type>DDS_Wchar *</type>
      <name>DDS_Wstring_dup_and_widen</name>
      <anchorfile>group__DDSStringClass.html</anchorfile>
      <anchor>ga075cf1127c65bbea736e06a1c79c5118</anchor>
      <arglist>(const char *str)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>DDS_Wstring_free</name>
      <anchorfile>group__DDSStringClass.html</anchorfile>
      <anchor>ga778f647e401f39a32e67c15dca5bdbff</anchor>
      <arglist>(DDS_Wchar *str)</arglist>
    </member>
    <docanchor file="group__DDSStringClass">DDSStringClass_conventions</docanchor>
    <docanchor file="group__DDSStringClass">DDSStringClass_usage</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_AllocationSettings_t</name>
    <filename>structDDS__AllocationSettings__t.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>initial_count</name>
      <anchorfile>structDDS__AllocationSettings__t.html</anchorfile>
      <anchor>aa0c1f475fa840bc72d011e9a63cbceab</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_count</name>
      <anchorfile>structDDS__AllocationSettings__t.html</anchorfile>
      <anchor>a073162ffde191269a0e7128bd129fefd</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>incremental_count</name>
      <anchorfile>structDDS__AllocationSettings__t.html</anchorfile>
      <anchor>a41743e8af9c73c45825aa17dd70fc957</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_AsynchronousPublisherQosPolicy</name>
    <filename>structDDS__AsynchronousPublisherQosPolicy.html</filename>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>disable_asynchronous_write</name>
      <anchorfile>structDDS__AsynchronousPublisherQosPolicy.html</anchorfile>
      <anchor>a7808fc463de942d9129f048791dd769c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_ThreadSettings_t</type>
      <name>thread</name>
      <anchorfile>structDDS__AsynchronousPublisherQosPolicy.html</anchorfile>
      <anchor>a63bf9dde43035317f22c78a324e44f2e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>disable_asynchronous_batch</name>
      <anchorfile>structDDS__AsynchronousPublisherQosPolicy.html</anchorfile>
      <anchor>a4194b5ed17b811ac0bcfc29caf44b919</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_ThreadSettings_t</type>
      <name>asynchronous_batch_thread</name>
      <anchorfile>structDDS__AsynchronousPublisherQosPolicy.html</anchorfile>
      <anchor>ad79a48844bf0a6afea2d239603b109c0</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__AsynchronousPublisherQosPolicy">DDSAsynchronousPublisherQosModule_usage</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_AvailabilityQosPolicy</name>
    <filename>structDDS__AvailabilityQosPolicy.html</filename>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>enable_required_subscriptions</name>
      <anchorfile>structDDS__AvailabilityQosPolicy.html</anchorfile>
      <anchor>a79bb96c3fe8c072c6910e351db6ad7c5</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>max_data_availability_waiting_time</name>
      <anchorfile>structDDS__AvailabilityQosPolicy.html</anchorfile>
      <anchor>a58852863451f739852b39a13c6b8dcb6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>max_endpoint_availability_waiting_time</name>
      <anchorfile>structDDS__AvailabilityQosPolicy.html</anchorfile>
      <anchor>aa48f79008c6b5e8c19d99597185784d7</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_EndpointGroupSeq</type>
      <name>required_matched_endpoint_groups</name>
      <anchorfile>structDDS__AvailabilityQosPolicy.html</anchorfile>
      <anchor>a0005bf94381fe61423e9e776c65a9426</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__AvailabilityQosPolicy">DDSAvailabilityQosModule_usage</docanchor>
    <docanchor file="structDDS__AvailabilityQosPolicy">DDSAvailabilityQosModule_consistency</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_BatchQosPolicy</name>
    <filename>structDDS__BatchQosPolicy.html</filename>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>enable</name>
      <anchorfile>structDDS__BatchQosPolicy.html</anchorfile>
      <anchor>a8324371a1eb1c03c8781a783a34da35a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_data_bytes</name>
      <anchorfile>structDDS__BatchQosPolicy.html</anchorfile>
      <anchor>a1a58dd062eb3b1c8c0b0f3d30d4bdfe5</anchor>
      <arglist></arglist>
      <docanchor file="structDDS__BatchQosPolicy">DDSBatchQosModule_max_data_bytes_consistency</docanchor>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_samples</name>
      <anchorfile>structDDS__BatchQosPolicy.html</anchorfile>
      <anchor>a8b334ad9988fcb016b48fd42cc5881ec</anchor>
      <arglist></arglist>
      <docanchor file="structDDS__BatchQosPolicy">DDSBatchQosModule_max_samples_consistency</docanchor>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>max_flush_delay</name>
      <anchorfile>structDDS__BatchQosPolicy.html</anchorfile>
      <anchor>a72851aa141c9963e808ce1777ac48aea</anchor>
      <arglist></arglist>
      <docanchor file="structDDS__BatchQosPolicy">DDSBatchQosModule_max_flush_delay_consistency</docanchor>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>source_timestamp_resolution</name>
      <anchorfile>structDDS__BatchQosPolicy.html</anchorfile>
      <anchor>a534aacc612c437ec164945c3cb0713ac</anchor>
      <arglist></arglist>
      <docanchor file="structDDS__BatchQosPolicy">DDSBatchQosModule_source_timestamp_resolution_consistency</docanchor>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>thread_safe_write</name>
      <anchorfile>structDDS__BatchQosPolicy.html</anchorfile>
      <anchor>a965f3534dd8633a75b8c908468223c15</anchor>
      <arglist></arglist>
      <docanchor file="structDDS__BatchQosPolicy">DDSBatchQosModule_thread_safe_write_consistency</docanchor>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_BooleanSeq</name>
    <filename>structDDS__BooleanSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_BuiltinTopicKey_t</name>
    <filename>structDDS__BuiltinTopicKey__t.html</filename>
    <member kind="variable">
      <type>DDS_BUILTIN_TOPIC_KEY_TYPE_NATIVE</type>
      <name>value</name>
      <anchorfile>structDDS__BuiltinTopicKey__t.html</anchorfile>
      <anchor>ae1ed8823d7cea0ee8786cd8b3b125556</anchor>
      <arglist>[DDS_BUILTIN_TOPIC_KEY_TYPE_NATIVE_LENGTH]</arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_BuiltinTopicReaderResourceLimits_t</name>
    <filename>structDDS__BuiltinTopicReaderResourceLimits__t.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>initial_samples</name>
      <anchorfile>structDDS__BuiltinTopicReaderResourceLimits__t.html</anchorfile>
      <anchor>ab5ab5ff0c2303fab9ff06d0cc64f8504</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_samples</name>
      <anchorfile>structDDS__BuiltinTopicReaderResourceLimits__t.html</anchorfile>
      <anchor>a9ea867d2b1f210e505105efa9762cf14</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>initial_infos</name>
      <anchorfile>structDDS__BuiltinTopicReaderResourceLimits__t.html</anchorfile>
      <anchor>a8e1546b305a9bf1b431b0ec91d8bc0b9</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_infos</name>
      <anchorfile>structDDS__BuiltinTopicReaderResourceLimits__t.html</anchorfile>
      <anchor>afb6d88881a363af5fe373430e575810f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>initial_outstanding_reads</name>
      <anchorfile>structDDS__BuiltinTopicReaderResourceLimits__t.html</anchorfile>
      <anchor>a2aa4fd171b1071062bb4dba84534a605</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_outstanding_reads</name>
      <anchorfile>structDDS__BuiltinTopicReaderResourceLimits__t.html</anchorfile>
      <anchor>af0ca796138941181ba89785e85640f92</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_samples_per_read</name>
      <anchorfile>structDDS__BuiltinTopicReaderResourceLimits__t.html</anchorfile>
      <anchor>a8d4fabf63677ce74dd9fdea54ab20ebc</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>disable_fragmentation_support</name>
      <anchorfile>structDDS__BuiltinTopicReaderResourceLimits__t.html</anchorfile>
      <anchor>a5cba4e12015f1b2b98d020b40a70fae6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_fragmented_samples</name>
      <anchorfile>structDDS__BuiltinTopicReaderResourceLimits__t.html</anchorfile>
      <anchor>a308718d47a8c484715abdf8f9e82a242</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>initial_fragmented_samples</name>
      <anchorfile>structDDS__BuiltinTopicReaderResourceLimits__t.html</anchorfile>
      <anchor>ae4b2d2d67108aeca90a47194824a3121</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_fragmented_samples_per_remote_writer</name>
      <anchorfile>structDDS__BuiltinTopicReaderResourceLimits__t.html</anchorfile>
      <anchor>ac04d8487854cfc1e3fc1d1671108c841</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_fragments_per_sample</name>
      <anchorfile>structDDS__BuiltinTopicReaderResourceLimits__t.html</anchorfile>
      <anchor>aea252713d7fc7c51054d93d7e118e97d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>dynamically_allocate_fragmented_samples</name>
      <anchorfile>structDDS__BuiltinTopicReaderResourceLimits__t.html</anchorfile>
      <anchor>a5624940b36f32ed34cdbc6f3630fac04</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_ChannelSettings_t</name>
    <filename>structDDS__ChannelSettings__t.html</filename>
    <member kind="variable">
      <type>struct DDS_TransportMulticastSettingsSeq</type>
      <name>multicast_settings</name>
      <anchorfile>structDDS__ChannelSettings__t.html</anchorfile>
      <anchor>abf11a7af0e36554fe0f0b7c8ba6e1d49</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>filter_expression</name>
      <anchorfile>structDDS__ChannelSettings__t.html</anchorfile>
      <anchor>a35746740ca9dddd7a38e3bd971c7fc10</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>priority</name>
      <anchorfile>structDDS__ChannelSettings__t.html</anchorfile>
      <anchor>a0da9c5019b87eb8151052977437cfbcc</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_ChannelSettingsSeq</name>
    <filename>structDDS__ChannelSettingsSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_CharSeq</name>
    <filename>structDDS__CharSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_ConditionSeq</name>
    <filename>structDDS__ConditionSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_ContentFilter</name>
    <filename>structDDS__ContentFilter.html</filename>
    <member kind="variable">
      <type>DDS_ContentFilterCompileFunction</type>
      <name>compile</name>
      <anchorfile>structDDS__ContentFilter.html</anchorfile>
      <anchor>ab60855fd715fa55b62798a423c905a1a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_ContentFilterWriterCompileFunction</type>
      <name>writer_compile</name>
      <anchorfile>structDDS__ContentFilter.html</anchorfile>
      <anchor>a76f1ef82c6d9668e3513e14911a3014c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_ContentFilterEvaluateFunction</type>
      <name>evaluate</name>
      <anchorfile>structDDS__ContentFilter.html</anchorfile>
      <anchor>a659bd643a4f8e658e445af8b3be54474</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_ContentFilterWriterEvaluateFunction</type>
      <name>writer_evaluate</name>
      <anchorfile>structDDS__ContentFilter.html</anchorfile>
      <anchor>a11711f5eded3cadba5f13233df864b4e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_ContentFilterFinalizeFunction</type>
      <name>finalize</name>
      <anchorfile>structDDS__ContentFilter.html</anchorfile>
      <anchor>ae783dfdfd716d764c991368343ce44bb</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_ContentFilterWriterFinalizeFunction</type>
      <name>writer_finalize</name>
      <anchorfile>structDDS__ContentFilter.html</anchorfile>
      <anchor>af18e909b4f249a7ff322f0fc01dc8891</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_ContentFilterWriterAttachFunction</type>
      <name>writer_attach</name>
      <anchorfile>structDDS__ContentFilter.html</anchorfile>
      <anchor>a7f15f13af6da70fe97bb6a9ccf039340</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_ContentFilterWriterDetachFunction</type>
      <name>writer_detach</name>
      <anchorfile>structDDS__ContentFilter.html</anchorfile>
      <anchor>ae48031ee2c114ee3a6da24d053a11223</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_ContentFilterWriterReturnLoanFunction</type>
      <name>writer_return_loan</name>
      <anchorfile>structDDS__ContentFilter.html</anchorfile>
      <anchor>a1b644c6803ed01b5ad4a5b2a6233e20d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>void *</type>
      <name>filter_data</name>
      <anchorfile>structDDS__ContentFilter.html</anchorfile>
      <anchor>af730c559f5d00dc32dce79111bed8c70</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_ContentFilterProperty_t</name>
    <filename>structDDS__ContentFilterProperty__t.html</filename>
    <member kind="variable">
      <type>char *</type>
      <name>content_filter_topic_name</name>
      <anchorfile>structDDS__ContentFilterProperty__t.html</anchorfile>
      <anchor>af174a0668858490a0680d6449a7fa941</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>related_topic_name</name>
      <anchorfile>structDDS__ContentFilterProperty__t.html</anchorfile>
      <anchor>aa649949c779496a688847d1cd4680d77</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>filter_class_name</name>
      <anchorfile>structDDS__ContentFilterProperty__t.html</anchorfile>
      <anchor>ac91f62b0adb8f41cd5a6a630a81c48e0</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>filter_expression</name>
      <anchorfile>structDDS__ContentFilterProperty__t.html</anchorfile>
      <anchor>aac3b491b2c8fb3f17bbdc6bc5158b81c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_StringSeq</type>
      <name>expression_parameters</name>
      <anchorfile>structDDS__ContentFilterProperty__t.html</anchorfile>
      <anchor>aa0cc70b50cf80d776969b2a8594f5a7a</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_Cookie_t</name>
    <filename>structDDS__Cookie__t.html</filename>
    <member kind="variable">
      <type>struct DDS_OctetSeq</type>
      <name>value</name>
      <anchorfile>structDDS__Cookie__t.html</anchorfile>
      <anchor>aeb01120181ecb1cd661a41894d69f3f6</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_DatabaseQosPolicy</name>
    <filename>structDDS__DatabaseQosPolicy.html</filename>
    <member kind="variable">
      <type>struct DDS_ThreadSettings_t</type>
      <name>thread</name>
      <anchorfile>structDDS__DatabaseQosPolicy.html</anchorfile>
      <anchor>abe59b18ab33b6abbbcbd869dedfa93bc</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>shutdown_timeout</name>
      <anchorfile>structDDS__DatabaseQosPolicy.html</anchorfile>
      <anchor>afcf4a476f5b2930c52fa0b46707977b2</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>cleanup_period</name>
      <anchorfile>structDDS__DatabaseQosPolicy.html</anchorfile>
      <anchor>a58ee0babaa65dbb435aa788dd649f172</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>shutdown_cleanup_period</name>
      <anchorfile>structDDS__DatabaseQosPolicy.html</anchorfile>
      <anchor>a17dc46e4dd757576e6cc68487379f6fa</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>initial_records</name>
      <anchorfile>structDDS__DatabaseQosPolicy.html</anchorfile>
      <anchor>a852c16fa2f43abda220a89fd45865cc2</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_skiplist_level</name>
      <anchorfile>structDDS__DatabaseQosPolicy.html</anchorfile>
      <anchor>a2dcee72a51e6a9efcf09d7d7ffa7be2b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_weak_references</name>
      <anchorfile>structDDS__DatabaseQosPolicy.html</anchorfile>
      <anchor>a883add16220593c018b2e8255a6413fb</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>initial_weak_references</name>
      <anchorfile>structDDS__DatabaseQosPolicy.html</anchorfile>
      <anchor>a7eb2d88b6aff37ea157edecee67201c8</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_DataReaderCacheStatus</name>
    <filename>structDDS__DataReaderCacheStatus.html</filename>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>sample_count_peak</name>
      <anchorfile>structDDS__DataReaderCacheStatus.html</anchorfile>
      <anchor>af18f29c855f554132e005bbaf16a4e2a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>sample_count</name>
      <anchorfile>structDDS__DataReaderCacheStatus.html</anchorfile>
      <anchor>a367964c71438881a176851f2e22cedbc</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_DataReaderListener</name>
    <filename>structDDS__DataReaderListener.html</filename>
    <member kind="variable">
      <type>struct DDS_Listener</type>
      <name>as_listener</name>
      <anchorfile>structDDS__DataReaderListener.html</anchorfile>
      <anchor>a29ca27751ee856b6177dd3271abe3499</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_DataReaderListener_RequestedDeadlineMissedCallback</type>
      <name>on_requested_deadline_missed</name>
      <anchorfile>structDDS__DataReaderListener.html</anchorfile>
      <anchor>af6f0e32b9b392af875da17ee7580ee42</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_DataReaderListener_RequestedIncompatibleQosCallback</type>
      <name>on_requested_incompatible_qos</name>
      <anchorfile>structDDS__DataReaderListener.html</anchorfile>
      <anchor>a20e5ab14f39f3d234faf137076cca07a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_DataReaderListener_SampleRejectedCallback</type>
      <name>on_sample_rejected</name>
      <anchorfile>structDDS__DataReaderListener.html</anchorfile>
      <anchor>a282293015a7d918c2ca699212bb3648c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_DataReaderListener_LivelinessChangedCallback</type>
      <name>on_liveliness_changed</name>
      <anchorfile>structDDS__DataReaderListener.html</anchorfile>
      <anchor>a9e3ed22a2ee506e2114e041cb761e0e2</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_DataReaderListener_DataAvailableCallback</type>
      <name>on_data_available</name>
      <anchorfile>structDDS__DataReaderListener.html</anchorfile>
      <anchor>a81faf1e28859a849c45ea7931179a786</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_DataReaderListener_SubscriptionMatchedCallback</type>
      <name>on_subscription_matched</name>
      <anchorfile>structDDS__DataReaderListener.html</anchorfile>
      <anchor>ac8505e0539c8a57173b89673f2a7e542</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_DataReaderListener_SampleLostCallback</type>
      <name>on_sample_lost</name>
      <anchorfile>structDDS__DataReaderListener.html</anchorfile>
      <anchor>a63fa5e7e9b8b256064d6eededc3eb9a0</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_DataReaderProtocolQosPolicy</name>
    <filename>structDDS__DataReaderProtocolQosPolicy.html</filename>
    <member kind="variable">
      <type>struct DDS_GUID_t</type>
      <name>virtual_guid</name>
      <anchorfile>structDDS__DataReaderProtocolQosPolicy.html</anchorfile>
      <anchor>aa0a668d93724b44b2f548160cf67ef0a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_UnsignedLong</type>
      <name>rtps_object_id</name>
      <anchorfile>structDDS__DataReaderProtocolQosPolicy.html</anchorfile>
      <anchor>a5e88dab82a659401efbfed7ae2dd7ce2</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>expects_inline_qos</name>
      <anchorfile>structDDS__DataReaderProtocolQosPolicy.html</anchorfile>
      <anchor>adf4d61ee211ccb5d86f847e9632bc5e7</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>disable_positive_acks</name>
      <anchorfile>structDDS__DataReaderProtocolQosPolicy.html</anchorfile>
      <anchor>af57b5cff82b583c119730bfe614ee628</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>propagate_dispose_of_unregistered_instances</name>
      <anchorfile>structDDS__DataReaderProtocolQosPolicy.html</anchorfile>
      <anchor>a6e29a7af72fac32b0567da59c800b558</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_RtpsReliableReaderProtocol_t</type>
      <name>rtps_reliable_reader</name>
      <anchorfile>structDDS__DataReaderProtocolQosPolicy.html</anchorfile>
      <anchor>ac962c1b10fbf15c0a68d975f9e95d995</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_DataReaderProtocolStatus</name>
    <filename>structDDS__DataReaderProtocolStatus.html</filename>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>received_sample_count</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>a6450c822d25c25f45d7983aed50053e3</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>received_sample_count_change</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>ab78c5a36118e560908bf98d9a6fc6e78</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>received_sample_bytes</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>aff143f3b0a66398e51772489b72fbe14</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>received_sample_bytes_change</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>a378a36842f1d4a07bae362a187bb9722</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>duplicate_sample_count</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>a9823a3908aef514b94a8974229d444da</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>duplicate_sample_count_change</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>aa17367b4e30b00ff3cc7b53e4275af20</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>duplicate_sample_bytes</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>ab73ec6267290a50373076a94b1cad62f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>duplicate_sample_bytes_change</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>abb946e1760220f2b59a0e2aac0067c9f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>filtered_sample_count</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>a0314b65de985e64e554be6dd7c0e433e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>filtered_sample_count_change</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>a8b3090165de26cafbaf5c96eedf5377c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>filtered_sample_bytes</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>a699c9b3c7a8d24bb0e38197c0e0cc6bf</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>filtered_sample_bytes_change</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>afdcc9056aee1942975e05ce6c7fa4eab</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>received_heartbeat_count</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>a438aa50234e75b1bfc6b5218eeff67a2</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>received_heartbeat_count_change</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>ae038741ffb2a13a389e833bebf194323</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>received_heartbeat_bytes</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>afde6e80305f8e65befe4444308129d99</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>received_heartbeat_bytes_change</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>ab1936c9237b0f84f1e8c293292f61fd4</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>sent_ack_count</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>af4f6e0c5fffad76ad6cf9ce133766656</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>sent_ack_count_change</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>a325c162e548a123f3760cbbe22f3e60b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>sent_ack_bytes</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>aee08837a58fdb2524930694a524aec65</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>sent_ack_bytes_change</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>ac15e4e640380b70c5c9374c9e062a6dd</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>sent_nack_count</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>a267cfcb222f600f2ccd01a76c52581f4</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>sent_nack_count_change</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>a3a94e2e33a967ae8a212968bc51362f7</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>sent_nack_bytes</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>a52570022bf134a13768da1f9b5352164</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>sent_nack_bytes_change</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>aaf39b497efc7f81db168b2740c814027</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>received_gap_count</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>a0bab39ca047913b7b873a260079efc25</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>received_gap_count_change</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>a71b2f9ba7e875d86f43a1bdd31e1e8d1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>received_gap_bytes</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>afc7e4f4c736ee36f7c34b17d8836261d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>received_gap_bytes_change</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>a38340ed75be0d97564657e455c3b8b70</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>rejected_sample_count</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>a36de0ca445f1fdc3fcce390c7e5d75d1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>rejected_sample_count_change</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>a34710beb763a2089664d439272fe5b17</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SequenceNumber_t</type>
      <name>first_available_sample_sequence_number</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>aca350c9759e0d5552bf2ecffb6fd49f5</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SequenceNumber_t</type>
      <name>last_available_sample_sequence_number</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>ac30430e8d7538e29bc664d102b6ca88a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SequenceNumber_t</type>
      <name>last_committed_sample_sequence_number</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>a1ae028a318d3925477886eb3537d82bc</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>uncommitted_sample_count</name>
      <anchorfile>structDDS__DataReaderProtocolStatus.html</anchorfile>
      <anchor>a01cb8f2645ced9c99fdbc4c82dca1943</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_DataReaderQos</name>
    <filename>structDDS__DataReaderQos.html</filename>
    <member kind="variable">
      <type>struct DDS_DurabilityQosPolicy</type>
      <name>durability</name>
      <anchorfile>structDDS__DataReaderQos.html</anchorfile>
      <anchor>a773c37cf8218a8fc52ed862f61a9ffb8</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DeadlineQosPolicy</type>
      <name>deadline</name>
      <anchorfile>structDDS__DataReaderQos.html</anchorfile>
      <anchor>a490674322e9365f8fa7c1240d84371e8</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_LatencyBudgetQosPolicy</type>
      <name>latency_budget</name>
      <anchorfile>structDDS__DataReaderQos.html</anchorfile>
      <anchor>a9dcd621be2055fbaf344782537385c1e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_LivelinessQosPolicy</type>
      <name>liveliness</name>
      <anchorfile>structDDS__DataReaderQos.html</anchorfile>
      <anchor>a8aeff400ce1755fc2ee1c110c9f94d8b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_ReliabilityQosPolicy</type>
      <name>reliability</name>
      <anchorfile>structDDS__DataReaderQos.html</anchorfile>
      <anchor>a4bf8f25113b843eb1dd45326d01b2341</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DestinationOrderQosPolicy</type>
      <name>destination_order</name>
      <anchorfile>structDDS__DataReaderQos.html</anchorfile>
      <anchor>a5e6b5a0bb4a1c5c03c0509e3ef80b2e4</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_HistoryQosPolicy</type>
      <name>history</name>
      <anchorfile>structDDS__DataReaderQos.html</anchorfile>
      <anchor>a03484335737f91b92a89cb0ebbe18655</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_ResourceLimitsQosPolicy</type>
      <name>resource_limits</name>
      <anchorfile>structDDS__DataReaderQos.html</anchorfile>
      <anchor>a27f550c1f22be54dfe3b69e007fabad2</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_UserDataQosPolicy</type>
      <name>user_data</name>
      <anchorfile>structDDS__DataReaderQos.html</anchorfile>
      <anchor>a24dfd6a672faaa0d65047747f21d91ad</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_OwnershipQosPolicy</type>
      <name>ownership</name>
      <anchorfile>structDDS__DataReaderQos.html</anchorfile>
      <anchor>aa5360151520cbee3661f720525f16f5c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_TimeBasedFilterQosPolicy</type>
      <name>time_based_filter</name>
      <anchorfile>structDDS__DataReaderQos.html</anchorfile>
      <anchor>aa0a89101de5b9d0028f04877139262cf</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_ReaderDataLifecycleQosPolicy</type>
      <name>reader_data_lifecycle</name>
      <anchorfile>structDDS__DataReaderQos.html</anchorfile>
      <anchor>a97c41d195de10ea5645cb8e34d938c8b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_TypeConsistencyEnforcementQosPolicy</type>
      <name>type_consistency</name>
      <anchorfile>structDDS__DataReaderQos.html</anchorfile>
      <anchor>a6b7f33ee133e8dc419625f2564752020</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DataReaderResourceLimitsQosPolicy</type>
      <name>reader_resource_limits</name>
      <anchorfile>structDDS__DataReaderQos.html</anchorfile>
      <anchor>ac6f4f6e01f59c4d53490717db313bd43</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DataReaderProtocolQosPolicy</type>
      <name>protocol</name>
      <anchorfile>structDDS__DataReaderQos.html</anchorfile>
      <anchor>a3f75d761d08de6457f9e81d81fa2174d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_TransportSelectionQosPolicy</type>
      <name>transport_selection</name>
      <anchorfile>structDDS__DataReaderQos.html</anchorfile>
      <anchor>ae41f3b2e31385cb93647e430d87ae343</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_TransportUnicastQosPolicy</type>
      <name>unicast</name>
      <anchorfile>structDDS__DataReaderQos.html</anchorfile>
      <anchor>a25a95b0fa7c430d30431284132f808ae</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_TransportMulticastQosPolicy</type>
      <name>multicast</name>
      <anchorfile>structDDS__DataReaderQos.html</anchorfile>
      <anchor>a88be8296924413045ef04f93e097d6ca</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_PropertyQosPolicy</type>
      <name>property</name>
      <anchorfile>structDDS__DataReaderQos.html</anchorfile>
      <anchor>a9999e4ac4149fad62a7011e01c13481e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_AvailabilityQosPolicy</type>
      <name>availability</name>
      <anchorfile>structDDS__DataReaderQos.html</anchorfile>
      <anchor>a1b96d6554ff66fe8b983affb5a02d29e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_EntityNameQosPolicy</type>
      <name>subscription_name</name>
      <anchorfile>structDDS__DataReaderQos.html</anchorfile>
      <anchor>a5e49f4b0b3fda24a86ab70e05be5ae08</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_TypeSupportQosPolicy</type>
      <name>type_support</name>
      <anchorfile>structDDS__DataReaderQos.html</anchorfile>
      <anchor>a55132672f1023daa0855d23b32e981ec</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_DataReaderResourceLimitsQosPolicy</name>
    <filename>structDDS__DataReaderResourceLimitsQosPolicy.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_remote_writers</name>
      <anchorfile>structDDS__DataReaderResourceLimitsQosPolicy.html</anchorfile>
      <anchor>ae89be540f623745dab6b0d6379037da1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_remote_writers_per_instance</name>
      <anchorfile>structDDS__DataReaderResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a79ab710ce28f1718df9a42cd10a46b5d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_samples_per_remote_writer</name>
      <anchorfile>structDDS__DataReaderResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a7210d8354ee1db9a55fc18ed56105d6a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_infos</name>
      <anchorfile>structDDS__DataReaderResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a6f871521d0791014ee54ec70ee57cbc0</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>initial_remote_writers</name>
      <anchorfile>structDDS__DataReaderResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a82f44e7655fa6535a464b09f7e447743</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>initial_remote_writers_per_instance</name>
      <anchorfile>structDDS__DataReaderResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a9e822ed635a2ba4dc26668df7306a2ff</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>initial_infos</name>
      <anchorfile>structDDS__DataReaderResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a7d00e4c0128edfbd6d501e2094162c48</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>initial_outstanding_reads</name>
      <anchorfile>structDDS__DataReaderResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a0e3217a96e2ec0d7a3803adfe7c3b5cf</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_outstanding_reads</name>
      <anchorfile>structDDS__DataReaderResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a82873fd35e4159bce6c23cc0de5fcca9</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_samples_per_read</name>
      <anchorfile>structDDS__DataReaderResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a3672d889d158f8da9c2465e5ec3046c5</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>disable_fragmentation_support</name>
      <anchorfile>structDDS__DataReaderResourceLimitsQosPolicy.html</anchorfile>
      <anchor>ae6b5f1ff7b6954e38b8693eefc7e781f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_fragmented_samples</name>
      <anchorfile>structDDS__DataReaderResourceLimitsQosPolicy.html</anchorfile>
      <anchor>ab829f0f900a4eb50dd796040f70afb26</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>initial_fragmented_samples</name>
      <anchorfile>structDDS__DataReaderResourceLimitsQosPolicy.html</anchorfile>
      <anchor>af997416e8a8dab3f2e309a68ed48bb04</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_fragmented_samples_per_remote_writer</name>
      <anchorfile>structDDS__DataReaderResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a1f4afc77231d262ce0e1a320b5e6f964</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_fragments_per_sample</name>
      <anchorfile>structDDS__DataReaderResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a67642418056ab77f7102eb1e735a5bef</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>dynamically_allocate_fragmented_samples</name>
      <anchorfile>structDDS__DataReaderResourceLimitsQosPolicy.html</anchorfile>
      <anchor>abd03f44d9c89ebe7dd0cd8026c671129</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_total_instances</name>
      <anchorfile>structDDS__DataReaderResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a90e66c63b7fdafccd4090792c47ec79c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_remote_virtual_writers</name>
      <anchorfile>structDDS__DataReaderResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a1334473402f0fcd847ed0c1949a511b4</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>initial_remote_virtual_writers</name>
      <anchorfile>structDDS__DataReaderResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a0dfb9b5fb92024e4e56ab5fe56e87140</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_remote_virtual_writers_per_instance</name>
      <anchorfile>structDDS__DataReaderResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a162eee845adbe96f8f40a9966a066a51</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>initial_remote_virtual_writers_per_instance</name>
      <anchorfile>structDDS__DataReaderResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a354bb399a209e710ecc7093e77de2c95</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_remote_writers_per_sample</name>
      <anchorfile>structDDS__DataReaderResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a004638f76e0cbbdd8018cedca107a34c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_query_condition_filters</name>
      <anchorfile>structDDS__DataReaderResourceLimitsQosPolicy.html</anchorfile>
      <anchor>abd0bbad5b44d11f09cd7c4d2a738765b</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_DataReaderSeq</name>
    <filename>structDDS__DataReaderSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_DataWriterCacheStatus</name>
    <filename>structDDS__DataWriterCacheStatus.html</filename>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>sample_count_peak</name>
      <anchorfile>structDDS__DataWriterCacheStatus.html</anchorfile>
      <anchor>adf72fbaccb17884308d466a69c758996</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>sample_count</name>
      <anchorfile>structDDS__DataWriterCacheStatus.html</anchorfile>
      <anchor>aae687743d9bfc042138403cea816d991</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_DataWriterListener</name>
    <filename>structDDS__DataWriterListener.html</filename>
    <member kind="variable">
      <type>struct DDS_Listener</type>
      <name>as_listener</name>
      <anchorfile>structDDS__DataWriterListener.html</anchorfile>
      <anchor>a0de48a9a929f60eae67e9bb305506b97</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_DataWriterListener_OfferedDeadlineMissedCallback</type>
      <name>on_offered_deadline_missed</name>
      <anchorfile>structDDS__DataWriterListener.html</anchorfile>
      <anchor>a0d61f3c1cb02adcd4783a275239e9a87</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_DataWriterListener_OfferedIncompatibleQosCallback</type>
      <name>on_offered_incompatible_qos</name>
      <anchorfile>structDDS__DataWriterListener.html</anchorfile>
      <anchor>a3bf70d5622457c5d51b07e4543b286b1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_DataWriterListener_LivelinessLostCallback</type>
      <name>on_liveliness_lost</name>
      <anchorfile>structDDS__DataWriterListener.html</anchorfile>
      <anchor>a13bf9aabdfd42e5c838d426e0cdf15c6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_DataWriterListener_PublicationMatchedCallback</type>
      <name>on_publication_matched</name>
      <anchorfile>structDDS__DataWriterListener.html</anchorfile>
      <anchor>ad809e9bdc4b53d67cbc21143fed56592</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_DataWriterListener_ReliableWriterCacheChangedCallback</type>
      <name>on_reliable_writer_cache_changed</name>
      <anchorfile>structDDS__DataWriterListener.html</anchorfile>
      <anchor>a27d275b8baa8c57462cd52fb6f80efce</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_DataWriterListener_ReliableReaderActivityChangedCallback</type>
      <name>on_reliable_reader_activity_changed</name>
      <anchorfile>structDDS__DataWriterListener.html</anchorfile>
      <anchor>a80d2027b63abad47993806248b10b01e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_DataWriterListener_InstanceReplacedCallback</type>
      <name>on_instance_replaced</name>
      <anchorfile>structDDS__DataWriterListener.html</anchorfile>
      <anchor>a340fad296fb7794f4acd5b03f9ce31e5</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_DataWriterProtocolQosPolicy</name>
    <filename>structDDS__DataWriterProtocolQosPolicy.html</filename>
    <member kind="variable">
      <type>struct DDS_GUID_t</type>
      <name>virtual_guid</name>
      <anchorfile>structDDS__DataWriterProtocolQosPolicy.html</anchorfile>
      <anchor>a8a2a9cfa7948d4a20bc07dd0b1a73651</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_UnsignedLong</type>
      <name>rtps_object_id</name>
      <anchorfile>structDDS__DataWriterProtocolQosPolicy.html</anchorfile>
      <anchor>a7cf2b8d79c78ecd65f8a98921dcf1f15</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>push_on_write</name>
      <anchorfile>structDDS__DataWriterProtocolQosPolicy.html</anchorfile>
      <anchor>a1a6869d778673c72e269dfb5ebd5ff7f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>disable_positive_acks</name>
      <anchorfile>structDDS__DataWriterProtocolQosPolicy.html</anchorfile>
      <anchor>a24c907704252724906cc913a9445ec27</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>disable_inline_keyhash</name>
      <anchorfile>structDDS__DataWriterProtocolQosPolicy.html</anchorfile>
      <anchor>a528d881bd67054fab2b5b9ebbb3949d9</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>serialize_key_with_dispose</name>
      <anchorfile>structDDS__DataWriterProtocolQosPolicy.html</anchorfile>
      <anchor>a7d8c1e77cbcf49d4b993d2e567c6468a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_RtpsReliableWriterProtocol_t</type>
      <name>rtps_reliable_writer</name>
      <anchorfile>structDDS__DataWriterProtocolQosPolicy.html</anchorfile>
      <anchor>a073f347f5d06730a44c411e5ce25fe6a</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_DataWriterProtocolStatus</name>
    <filename>structDDS__DataWriterProtocolStatus.html</filename>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>pushed_sample_count</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>a12495956577f9d5a6d7d430aaf3c0e68</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>pushed_sample_count_change</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>af720cc676bef0fd04bb1efab932f1a8a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>pushed_sample_bytes</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>a3be8d26ae24a432593bcab682540438c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>pushed_sample_bytes_change</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>ab755efadda917c13dee7bd960131ef45</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>filtered_sample_count</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>a4957c243bc4783ea18cddb9d1795a9b3</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>filtered_sample_count_change</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>adecdd6d0e3b7dd18184635f4ac7c7d6d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>filtered_sample_bytes</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>ab8292b2e90e85cc16ccbb4c2981cce0d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>filtered_sample_bytes_change</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>a1e4dc7dd1cb90f502f9ef8230e664108</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>sent_heartbeat_count</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>aee963da84a6f4a02efffcbd4c5114f0c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>sent_heartbeat_count_change</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>a64740ace028dda9acc52b1108ded43b2</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>sent_heartbeat_bytes</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>a1bd8e0e8deb7d4209b8b86dcd852df41</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>sent_heartbeat_bytes_change</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>a83828daa69602fc3965fa2ecbe766811</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>pulled_sample_count</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>a4b3f91d3a5f84e1feef8ee99d0625257</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>pulled_sample_count_change</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>af6164472c3a6c9ede1fa31d3d2c9a3d5</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>pulled_sample_bytes</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>a3225d3541e1811991916510d36d2f0dd</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>pulled_sample_bytes_change</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>a1e93f40c9e9b4a01d0e9b14487ceed9d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>received_ack_count</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>a8eeae22651a527f3ce1d3042cdeaa748</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>received_ack_count_change</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>acefa8381589129f63436a24fa587140f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>received_ack_bytes</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>afa6a686ae681e8bbdc0276ee52bb170f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>received_ack_bytes_change</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>a200513a4d64eed54c0e9559c7004837e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>received_nack_count</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>af8a03adc942d3ab524b7b6bdc63fe166</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>received_nack_count_change</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>a980ea558af5d6cf543b19fca28623ac8</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>received_nack_bytes</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>a42520671719215763f9257dfff72ecbe</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>received_nack_bytes_change</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>aef4906b7b695b9fceddcaac783094136</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>sent_gap_count</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>a8a91673c4503f164def38df566dd7c59</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>sent_gap_count_change</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>a8a9c8fb0e4a8bf097518aaa62f0e297d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>sent_gap_bytes</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>a5d64d5fe40cd0ef3f4cd636b6ff5ed8d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>sent_gap_bytes_change</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>a94b4c5ec7e8d85a25560ed6281cbb4b0</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>rejected_sample_count</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>a50ad36a491831b66e402afed7aa558e9</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_LongLong</type>
      <name>rejected_sample_count_change</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>ae8d27d9504a292a5acc4d37dde207964</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>send_window_size</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>a8a6c2876c488b14e4d7d13cd73a7280b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SequenceNumber_t</type>
      <name>first_available_sample_sequence_number</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>a40c3b2a0db1643c5cdc9eb93c1cca24e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SequenceNumber_t</type>
      <name>last_available_sample_sequence_number</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>ad9c7c625a927c813c0db8e40d2dd7018</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SequenceNumber_t</type>
      <name>first_unacknowledged_sample_sequence_number</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>a9ca72a81a757aeafbc1336ccb4b1c650</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SequenceNumber_t</type>
      <name>first_available_sample_virtual_sequence_number</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>a928dc4d953e23dce3238c37bab5154a2</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SequenceNumber_t</type>
      <name>last_available_sample_virtual_sequence_number</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>a6df6be36620391e6d46f8764cf141713</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SequenceNumber_t</type>
      <name>first_unacknowledged_sample_virtual_sequence_number</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>add2bcaa03eff746c1229fc5c4d20aa75</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_InstanceHandle_t</type>
      <name>first_unacknowledged_sample_subscription_handle</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>a0d9a4348d9ba372472006582eaecdb21</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SequenceNumber_t</type>
      <name>first_unelapsed_keep_duration_sample_sequence_number</name>
      <anchorfile>structDDS__DataWriterProtocolStatus.html</anchorfile>
      <anchor>aa0f7a7a2af42c9c687613a7ae6f3a916</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_DataWriterQos</name>
    <filename>structDDS__DataWriterQos.html</filename>
    <member kind="variable">
      <type>struct DDS_DurabilityQosPolicy</type>
      <name>durability</name>
      <anchorfile>structDDS__DataWriterQos.html</anchorfile>
      <anchor>a37fa03c7f1bd7b0a584afd382defd324</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DurabilityServiceQosPolicy</type>
      <name>durability_service</name>
      <anchorfile>structDDS__DataWriterQos.html</anchorfile>
      <anchor>a23ab4f34abe53514b8797cb05978034f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DeadlineQosPolicy</type>
      <name>deadline</name>
      <anchorfile>structDDS__DataWriterQos.html</anchorfile>
      <anchor>a9eaeedfdde65d28d210563e2039bd123</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_LatencyBudgetQosPolicy</type>
      <name>latency_budget</name>
      <anchorfile>structDDS__DataWriterQos.html</anchorfile>
      <anchor>ae5e6c5367a4ffc9ce990c1937e5485e9</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_LivelinessQosPolicy</type>
      <name>liveliness</name>
      <anchorfile>structDDS__DataWriterQos.html</anchorfile>
      <anchor>abca7765eae18d4d06835ddb6166d7f8b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_ReliabilityQosPolicy</type>
      <name>reliability</name>
      <anchorfile>structDDS__DataWriterQos.html</anchorfile>
      <anchor>a5268bd83b058755ce8c475da3ba47320</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DestinationOrderQosPolicy</type>
      <name>destination_order</name>
      <anchorfile>structDDS__DataWriterQos.html</anchorfile>
      <anchor>ae345e3c13aeca8972d7a75378cfa65b0</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_HistoryQosPolicy</type>
      <name>history</name>
      <anchorfile>structDDS__DataWriterQos.html</anchorfile>
      <anchor>af9f94864a545fd0b7205f3b68209bc8c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_ResourceLimitsQosPolicy</type>
      <name>resource_limits</name>
      <anchorfile>structDDS__DataWriterQos.html</anchorfile>
      <anchor>acba41cd24991ce678ad133bcc276b55c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_TransportPriorityQosPolicy</type>
      <name>transport_priority</name>
      <anchorfile>structDDS__DataWriterQos.html</anchorfile>
      <anchor>a592dc4ca23e177da5f7d84df5f3f1c0d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_LifespanQosPolicy</type>
      <name>lifespan</name>
      <anchorfile>structDDS__DataWriterQos.html</anchorfile>
      <anchor>a8ae42428d66521e2f1898b484090c9d6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_UserDataQosPolicy</type>
      <name>user_data</name>
      <anchorfile>structDDS__DataWriterQos.html</anchorfile>
      <anchor>a3f145630b7f9627256c0c854de786f96</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_OwnershipQosPolicy</type>
      <name>ownership</name>
      <anchorfile>structDDS__DataWriterQos.html</anchorfile>
      <anchor>a70eb989bc9b61ba88d0d4ea7de5206a6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_OwnershipStrengthQosPolicy</type>
      <name>ownership_strength</name>
      <anchorfile>structDDS__DataWriterQos.html</anchorfile>
      <anchor>a2e629630ceb241efaa8699f728847f7b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_WriterDataLifecycleQosPolicy</type>
      <name>writer_data_lifecycle</name>
      <anchorfile>structDDS__DataWriterQos.html</anchorfile>
      <anchor>aab281f387079bf167d0f98f8944daaaf</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DataWriterResourceLimitsQosPolicy</type>
      <name>writer_resource_limits</name>
      <anchorfile>structDDS__DataWriterQos.html</anchorfile>
      <anchor>a14ef85955ab7c01c1b4eff56e2479149</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DataWriterProtocolQosPolicy</type>
      <name>protocol</name>
      <anchorfile>structDDS__DataWriterQos.html</anchorfile>
      <anchor>a7a31aa6f32bd67ba2609d75702a6ba1c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_TransportSelectionQosPolicy</type>
      <name>transport_selection</name>
      <anchorfile>structDDS__DataWriterQos.html</anchorfile>
      <anchor>a03b5325b63abf5f00f92fca0b431e7c9</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_TransportUnicastQosPolicy</type>
      <name>unicast</name>
      <anchorfile>structDDS__DataWriterQos.html</anchorfile>
      <anchor>ad6c6afd00b73cf2dc14785c7463f8ec6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_PublishModeQosPolicy</type>
      <name>publish_mode</name>
      <anchorfile>structDDS__DataWriterQos.html</anchorfile>
      <anchor>ac37f1fe53d755fc7d6b372b5159ce353</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_PropertyQosPolicy</type>
      <name>property</name>
      <anchorfile>structDDS__DataWriterQos.html</anchorfile>
      <anchor>a3bd43c56430260d3fa3947b362f903c0</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_BatchQosPolicy</type>
      <name>batch</name>
      <anchorfile>structDDS__DataWriterQos.html</anchorfile>
      <anchor>ac4436ea094d7e187b462e274d32dba98</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_MultiChannelQosPolicy</type>
      <name>multi_channel</name>
      <anchorfile>structDDS__DataWriterQos.html</anchorfile>
      <anchor>ae047013a468a8cf4945a60563cb68224</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_AvailabilityQosPolicy</type>
      <name>availability</name>
      <anchorfile>structDDS__DataWriterQos.html</anchorfile>
      <anchor>a153bb9a3c10c51c494148b20b1e59a36</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_EntityNameQosPolicy</type>
      <name>publication_name</name>
      <anchorfile>structDDS__DataWriterQos.html</anchorfile>
      <anchor>a2271bd1fa6ed7d53fba82b603b9b2836</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_TypeSupportQosPolicy</type>
      <name>type_support</name>
      <anchorfile>structDDS__DataWriterQos.html</anchorfile>
      <anchor>a40a65c5ab2e4e5eb549d973f9070734f</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_DataWriterResourceLimitsQosPolicy</name>
    <filename>structDDS__DataWriterResourceLimitsQosPolicy.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>initial_concurrent_blocking_threads</name>
      <anchorfile>structDDS__DataWriterResourceLimitsQosPolicy.html</anchorfile>
      <anchor>aa9301a0ac214a885aa7090df82cfe379</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_concurrent_blocking_threads</name>
      <anchorfile>structDDS__DataWriterResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a55a4971d099b159567805143262f5fe1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_remote_reader_filters</name>
      <anchorfile>structDDS__DataWriterResourceLimitsQosPolicy.html</anchorfile>
      <anchor>aa7a681cc4e445f5554947fd8fe7ea8d1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>initial_batches</name>
      <anchorfile>structDDS__DataWriterResourceLimitsQosPolicy.html</anchorfile>
      <anchor>aab6420cc36ff42174fe0b87ab37adb98</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_batches</name>
      <anchorfile>structDDS__DataWriterResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a51214037c1916adf948814915c95bbfb</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_DataWriterResourceLimitsInstanceReplacementKind</type>
      <name>instance_replacement</name>
      <anchorfile>structDDS__DataWriterResourceLimitsQosPolicy.html</anchorfile>
      <anchor>aa3096f84ff6ef88d24193839da252b95</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>replace_empty_instances</name>
      <anchorfile>structDDS__DataWriterResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a93a49c6de19f143e4832362ce530dca9</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>autoregister_instances</name>
      <anchorfile>structDDS__DataWriterResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a6845f18cc4d999f6db20fe25e9a1e5b6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>initial_virtual_writers</name>
      <anchorfile>structDDS__DataWriterResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a6115c592654801f1ac128db3a88a7a13</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_virtual_writers</name>
      <anchorfile>structDDS__DataWriterResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a270e412af06fcb0d68fce88b7585d175</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_remote_readers</name>
      <anchorfile>structDDS__DataWriterResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a6f64b3e30241cdb06ce4942641336025</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_app_ack_remote_readers</name>
      <anchorfile>structDDS__DataWriterResourceLimitsQosPolicy.html</anchorfile>
      <anchor>aef96d76fe9d30d660d15e23b6977f62b</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_DeadlineQosPolicy</name>
    <filename>structDDS__DeadlineQosPolicy.html</filename>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>period</name>
      <anchorfile>structDDS__DeadlineQosPolicy.html</anchorfile>
      <anchor>a3bc084edc8320df0e64d8ac2b857635d</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__DeadlineQosPolicy">DDSDeadlineQosModule_usage</docanchor>
    <docanchor file="structDDS__DeadlineQosPolicy">DDSDeadlineQosModule_compatibility</docanchor>
    <docanchor file="structDDS__DeadlineQosPolicy">DDSDeadlineQosModule_consistency</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_DestinationOrderQosPolicy</name>
    <filename>structDDS__DestinationOrderQosPolicy.html</filename>
    <member kind="variable">
      <type>DDS_DestinationOrderQosPolicyKind</type>
      <name>kind</name>
      <anchorfile>structDDS__DestinationOrderQosPolicy.html</anchorfile>
      <anchor>a6b16d4602f9b8dde684f8dd737958bd1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>source_timestamp_tolerance</name>
      <anchorfile>structDDS__DestinationOrderQosPolicy.html</anchorfile>
      <anchor>a692d1a1f1117dbb9eadb980a41f8a156</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__DestinationOrderQosPolicy">DDSDestinationOrderQosModule_usage</docanchor>
    <docanchor file="structDDS__DestinationOrderQosPolicy">DDSDestinationOrderQosModule_compatibility</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_DiscoveryConfigQosPolicy</name>
    <filename>structDDS__DiscoveryConfigQosPolicy.html</filename>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>participant_liveliness_lease_duration</name>
      <anchorfile>structDDS__DiscoveryConfigQosPolicy.html</anchorfile>
      <anchor>a78c4d3b8bda361a00e123f58ea496e4c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>participant_liveliness_assert_period</name>
      <anchorfile>structDDS__DiscoveryConfigQosPolicy.html</anchorfile>
      <anchor>a58d8005ad44ec8545eaaa019bc77524c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_RemoteParticipantPurgeKind</type>
      <name>remote_participant_purge_kind</name>
      <anchorfile>structDDS__DiscoveryConfigQosPolicy.html</anchorfile>
      <anchor>acfd0ee9f3d19feb198c234c7959bc56c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>max_liveliness_loss_detection_period</name>
      <anchorfile>structDDS__DiscoveryConfigQosPolicy.html</anchorfile>
      <anchor>ab60026edbf67766f2ca901337ca65463</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>initial_participant_announcements</name>
      <anchorfile>structDDS__DiscoveryConfigQosPolicy.html</anchorfile>
      <anchor>a2abc915422be346150d8cfc09d3345e1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>min_initial_participant_announcement_period</name>
      <anchorfile>structDDS__DiscoveryConfigQosPolicy.html</anchorfile>
      <anchor>a5b625b0ae085116b68955243308ad521</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>max_initial_participant_announcement_period</name>
      <anchorfile>structDDS__DiscoveryConfigQosPolicy.html</anchorfile>
      <anchor>aecd01b607e910c49c9e3dcb184e688c3</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_BuiltinTopicReaderResourceLimits_t</type>
      <name>participant_reader_resource_limits</name>
      <anchorfile>structDDS__DiscoveryConfigQosPolicy.html</anchorfile>
      <anchor>aa5549937794c08f395a725a22cb4c601</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_RtpsReliableReaderProtocol_t</type>
      <name>publication_reader</name>
      <anchorfile>structDDS__DiscoveryConfigQosPolicy.html</anchorfile>
      <anchor>a582ad216653b81cd3e6645684035d1b1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_BuiltinTopicReaderResourceLimits_t</type>
      <name>publication_reader_resource_limits</name>
      <anchorfile>structDDS__DiscoveryConfigQosPolicy.html</anchorfile>
      <anchor>a61292b4827f01f470c0d423605b9e703</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_RtpsReliableReaderProtocol_t</type>
      <name>subscription_reader</name>
      <anchorfile>structDDS__DiscoveryConfigQosPolicy.html</anchorfile>
      <anchor>ae9e22f94e06b6f2e8d14f1bef594f708</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_BuiltinTopicReaderResourceLimits_t</type>
      <name>subscription_reader_resource_limits</name>
      <anchorfile>structDDS__DiscoveryConfigQosPolicy.html</anchorfile>
      <anchor>ae1dff56a9e82a553bd0dfc65c68eabe6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_RtpsReliableWriterProtocol_t</type>
      <name>publication_writer</name>
      <anchorfile>structDDS__DiscoveryConfigQosPolicy.html</anchorfile>
      <anchor>a4dd350ea9eb8f9a2cae267bb5e019981</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_WriterDataLifecycleQosPolicy</type>
      <name>publication_writer_data_lifecycle</name>
      <anchorfile>structDDS__DiscoveryConfigQosPolicy.html</anchorfile>
      <anchor>af09ec8b56f9ca57ecf255448cdc597d3</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_RtpsReliableWriterProtocol_t</type>
      <name>subscription_writer</name>
      <anchorfile>structDDS__DiscoveryConfigQosPolicy.html</anchorfile>
      <anchor>a27ccb8e5002c6f48ab0ac5e1181398eb</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_WriterDataLifecycleQosPolicy</type>
      <name>subscription_writer_data_lifecycle</name>
      <anchorfile>structDDS__DiscoveryConfigQosPolicy.html</anchorfile>
      <anchor>ae392e79d8c02c84d7c0eaf2fef8d3383</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_DiscoveryConfigBuiltinPluginKindMask</type>
      <name>builtin_discovery_plugins</name>
      <anchorfile>structDDS__DiscoveryConfigQosPolicy.html</anchorfile>
      <anchor>a890fa00bfca67626fc0f083854f37092</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_RtpsReliableReaderProtocol_t</type>
      <name>participant_message_reader</name>
      <anchorfile>structDDS__DiscoveryConfigQosPolicy.html</anchorfile>
      <anchor>ab4ac91c7d91b09177f8616aacb6ddac7</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_RtpsReliableWriterProtocol_t</type>
      <name>participant_message_writer</name>
      <anchorfile>structDDS__DiscoveryConfigQosPolicy.html</anchorfile>
      <anchor>aee2a53191d51da9a648e09ff81bda1cd</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_PublishModeQosPolicy</type>
      <name>publication_writer_publish_mode</name>
      <anchorfile>structDDS__DiscoveryConfigQosPolicy.html</anchorfile>
      <anchor>a995552a14a096220b99fad1967866be0</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_PublishModeQosPolicy</type>
      <name>subscription_writer_publish_mode</name>
      <anchorfile>structDDS__DiscoveryConfigQosPolicy.html</anchorfile>
      <anchor>a355ef3cbf54ee8a2173607f58372c3c4</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_AsynchronousPublisherQosPolicy</type>
      <name>asynchronous_publisher</name>
      <anchorfile>structDDS__DiscoveryConfigQosPolicy.html</anchorfile>
      <anchor>ad0364fda2576f4329035e01878973c1e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>default_domain_announcement_period</name>
      <anchorfile>structDDS__DiscoveryConfigQosPolicy.html</anchorfile>
      <anchor>a2752eac191f6864b08436ca1064e8a01</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>ignore_default_domain_announcements</name>
      <anchorfile>structDDS__DiscoveryConfigQosPolicy.html</anchorfile>
      <anchor>ad5ebda7333ed1a9f5eca281dd564ecf4</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_DiscoveryQosPolicy</name>
    <filename>structDDS__DiscoveryQosPolicy.html</filename>
    <member kind="variable">
      <type>struct DDS_StringSeq</type>
      <name>enabled_transports</name>
      <anchorfile>structDDS__DiscoveryQosPolicy.html</anchorfile>
      <anchor>a9ee4ed308f6ef12bbc2299fe242f5f36</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_StringSeq</type>
      <name>initial_peers</name>
      <anchorfile>structDDS__DiscoveryQosPolicy.html</anchorfile>
      <anchor>a7f767e8bb620e6ae873479d9975accbf</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_StringSeq</type>
      <name>multicast_receive_addresses</name>
      <anchorfile>structDDS__DiscoveryQosPolicy.html</anchorfile>
      <anchor>a3b418c737004c65e39715e6bb56c1bc7</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>metatraffic_transport_priority</name>
      <anchorfile>structDDS__DiscoveryQosPolicy.html</anchorfile>
      <anchor>ab9e5fcdee48bc5f6955e56d386e776d5</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>accept_unknown_peers</name>
      <anchorfile>structDDS__DiscoveryQosPolicy.html</anchorfile>
      <anchor>a0b53178426ae877ea27b90c70cedaec7</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__DiscoveryQosPolicy">DDSDiscoveryQosModule_usage</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_DomainParticipantConfigParams_t</name>
    <filename>structDDS__DomainParticipantConfigParams__t.html</filename>
    <member kind="variable">
      <type>int</type>
      <name>domain_id</name>
      <anchorfile>structDDS__DomainParticipantConfigParams__t.html</anchorfile>
      <anchor>aa8c75b0ab49766ec907c7fbd08c37444</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>participant_name</name>
      <anchorfile>structDDS__DomainParticipantConfigParams__t.html</anchorfile>
      <anchor>adb97acfa4e940afe8d00a94e999b7641</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>participant_qos_library_name</name>
      <anchorfile>structDDS__DomainParticipantConfigParams__t.html</anchorfile>
      <anchor>a2c43c16d0c8604d7687cd425e9573064</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>participant_qos_profile_name</name>
      <anchorfile>structDDS__DomainParticipantConfigParams__t.html</anchorfile>
      <anchor>af8158c414de75ab5079683c266413923</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>domain_entity_qos_library_name</name>
      <anchorfile>structDDS__DomainParticipantConfigParams__t.html</anchorfile>
      <anchor>a506f2eea2a8876370da6c522d6f607b2</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>domain_entity_qos_profile_name</name>
      <anchorfile>structDDS__DomainParticipantConfigParams__t.html</anchorfile>
      <anchor>a60eca413d06388e20ac0f7f91e0db36c</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_DomainParticipantFactoryQos</name>
    <filename>structDDS__DomainParticipantFactoryQos.html</filename>
    <member kind="variable">
      <type>struct DDS_EntityFactoryQosPolicy</type>
      <name>entity_factory</name>
      <anchorfile>structDDS__DomainParticipantFactoryQos.html</anchorfile>
      <anchor>a02dc2ae2e347305a6f1735fbf1f51677</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SystemResourceLimitsQosPolicy</type>
      <name>resource_limits</name>
      <anchorfile>structDDS__DomainParticipantFactoryQos.html</anchorfile>
      <anchor>a1e06a547d236cbba768b708ed62337e1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_ProfileQosPolicy</type>
      <name>profile</name>
      <anchorfile>structDDS__DomainParticipantFactoryQos.html</anchorfile>
      <anchor>a4fd711ef77e1cf45a5ddeaf037c169d8</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_LoggingQosPolicy</type>
      <name>logging</name>
      <anchorfile>structDDS__DomainParticipantFactoryQos.html</anchorfile>
      <anchor>a3c2198e494e66919db3224262c3c2dab</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_DomainParticipantListener</name>
    <filename>structDDS__DomainParticipantListener.html</filename>
    <member kind="variable">
      <type>struct DDS_TopicListener</type>
      <name>as_topiclistener</name>
      <anchorfile>structDDS__DomainParticipantListener.html</anchorfile>
      <anchor>afdf454bf85a27626f010996268f654ef</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_PublisherListener</type>
      <name>as_publisherlistener</name>
      <anchorfile>structDDS__DomainParticipantListener.html</anchorfile>
      <anchor>a5c87435e1638a2331b9982fe3e806402</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SubscriberListener</type>
      <name>as_subscriberlistener</name>
      <anchorfile>structDDS__DomainParticipantListener.html</anchorfile>
      <anchor>a8cdad1a208a63822b7cc6f7a0157f966</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_DomainParticipantQos</name>
    <filename>structDDS__DomainParticipantQos.html</filename>
    <member kind="variable">
      <type>struct DDS_UserDataQosPolicy</type>
      <name>user_data</name>
      <anchorfile>structDDS__DomainParticipantQos.html</anchorfile>
      <anchor>ad25fbfa462bf8a35bc8f3f97078d9b5f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_EntityFactoryQosPolicy</type>
      <name>entity_factory</name>
      <anchorfile>structDDS__DomainParticipantQos.html</anchorfile>
      <anchor>a1fda50d3d2d8e95e07408a9bec2cd8ec</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_WireProtocolQosPolicy</type>
      <name>wire_protocol</name>
      <anchorfile>structDDS__DomainParticipantQos.html</anchorfile>
      <anchor>a1b49955a2e19cd71e131dc35c583f429</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_TransportBuiltinQosPolicy</type>
      <name>transport_builtin</name>
      <anchorfile>structDDS__DomainParticipantQos.html</anchorfile>
      <anchor>a3cb5ef6780f60c92c52ee86593b2de7b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_TransportUnicastQosPolicy</type>
      <name>default_unicast</name>
      <anchorfile>structDDS__DomainParticipantQos.html</anchorfile>
      <anchor>a9c456eb0fe8c34fffe3f17d32d69b2b1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DiscoveryQosPolicy</type>
      <name>discovery</name>
      <anchorfile>structDDS__DomainParticipantQos.html</anchorfile>
      <anchor>aed1ebb084373f4a46c9566bd6c392e95</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DomainParticipantResourceLimitsQosPolicy</type>
      <name>resource_limits</name>
      <anchorfile>structDDS__DomainParticipantQos.html</anchorfile>
      <anchor>ab52b04a5ddfb4bdf50534ef410a65fc2</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_EventQosPolicy</type>
      <name>event</name>
      <anchorfile>structDDS__DomainParticipantQos.html</anchorfile>
      <anchor>aba141910e59b298acc893ab545b36894</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_ReceiverPoolQosPolicy</type>
      <name>receiver_pool</name>
      <anchorfile>structDDS__DomainParticipantQos.html</anchorfile>
      <anchor>a19350d639073352cad0abafe44d003a6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DatabaseQosPolicy</type>
      <name>database</name>
      <anchorfile>structDDS__DomainParticipantQos.html</anchorfile>
      <anchor>a9d74f7ae55f1e2fe340b3494877055b1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DiscoveryConfigQosPolicy</type>
      <name>discovery_config</name>
      <anchorfile>structDDS__DomainParticipantQos.html</anchorfile>
      <anchor>a2b9b48fcc81e247656a8db38e6ed1778</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_PropertyQosPolicy</type>
      <name>property</name>
      <anchorfile>structDDS__DomainParticipantQos.html</anchorfile>
      <anchor>af292ae3a6358178b9170a123ac2ded1a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_EntityNameQosPolicy</type>
      <name>participant_name</name>
      <anchorfile>structDDS__DomainParticipantQos.html</anchorfile>
      <anchor>a8ebae4aadc6caa1958ad599606b329a1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_TransportMulticastMappingQosPolicy</type>
      <name>multicast_mapping</name>
      <anchorfile>structDDS__DomainParticipantQos.html</anchorfile>
      <anchor>a7ceb841932337c0b468d103cae76b9f6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_TypeSupportQosPolicy</type>
      <name>type_support</name>
      <anchorfile>structDDS__DomainParticipantQos.html</anchorfile>
      <anchor>a6e9b58cbc7f1e5288325f23b01aa1a51</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_DomainParticipantResourceLimitsQosPolicy</name>
    <filename>structDDS__DomainParticipantResourceLimitsQosPolicy.html</filename>
    <member kind="variable">
      <type>struct DDS_AllocationSettings_t</type>
      <name>local_writer_allocation</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a3347cc2a914c30acaa1ee4f9ba986e92</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_AllocationSettings_t</type>
      <name>local_reader_allocation</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a6fc288aa6006c1ff7cdc5b417dbc8ab6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_AllocationSettings_t</type>
      <name>local_publisher_allocation</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a2177c292404266bdc851ef61b23019a6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_AllocationSettings_t</type>
      <name>local_subscriber_allocation</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a1190a056417b90808ae15f2042758d23</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_AllocationSettings_t</type>
      <name>local_topic_allocation</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>abc22d569ddc1e74b6ab3a536991665d7</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_AllocationSettings_t</type>
      <name>remote_writer_allocation</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a1b52cdc700ecae67b18f3929d56d666d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_AllocationSettings_t</type>
      <name>remote_reader_allocation</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a1802796a5d26ebf34f931ce2128e07a9</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_AllocationSettings_t</type>
      <name>remote_participant_allocation</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>af916b1052155aa1daa45b590b5e00f1f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_AllocationSettings_t</type>
      <name>matching_writer_reader_pair_allocation</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a6f4f6a96d6251aadcafd05effcf9bead</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_AllocationSettings_t</type>
      <name>matching_reader_writer_pair_allocation</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a9f5816b097b60d37f1ba03f0394935bd</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_AllocationSettings_t</type>
      <name>ignored_entity_allocation</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>af531f580e108d445e6a97ce53fe6505f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_AllocationSettings_t</type>
      <name>content_filtered_topic_allocation</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a21202347ddf6bd47cd97664b6026fd04</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_AllocationSettings_t</type>
      <name>content_filter_allocation</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>af1f7ee3769bddca21a30fa62c9d6faa7</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_AllocationSettings_t</type>
      <name>read_condition_allocation</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a614d3e6cc89c4e134972f8ece718bf44</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_AllocationSettings_t</type>
      <name>query_condition_allocation</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>ae7b09c606bc332a347b27ade804b0e56</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_AllocationSettings_t</type>
      <name>outstanding_asynchronous_sample_allocation</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>ab89b2ba71e20bef97f1c34886d4445d4</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_AllocationSettings_t</type>
      <name>flow_controller_allocation</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>aaf4904b9b8fb9ed650b610a38eaca8a7</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>local_writer_hash_buckets</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a6ecc7c77c9344783bd304d31444d88ab</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>local_reader_hash_buckets</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>aad67df2020bd2ca5c08aa775c60e5561</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>local_publisher_hash_buckets</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a4abbcfe9a65d368ceb225eee9433112f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>local_subscriber_hash_buckets</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a6b794249513194e14edc1170f2a72699</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>local_topic_hash_buckets</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a84594c0ffa6879ee6ac845802465327c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>remote_writer_hash_buckets</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a2bd19c09c640f4b2beb36e230eacab3b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>remote_reader_hash_buckets</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>ae8acf3de382e4652d6f40fabd491f3a1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>remote_participant_hash_buckets</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a2995076b9e2e6d4d7d8de81d2a35bc4c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>matching_writer_reader_pair_hash_buckets</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>aa3a097f37752c378800099ef22fd93a0</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>matching_reader_writer_pair_hash_buckets</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a907f7752379b840636a367a40d36be2e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>ignored_entity_hash_buckets</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>aac1f2be6cb0a89b68b023b3e11ed3139</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>content_filtered_topic_hash_buckets</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a3c481b193f33e96624be3c19bccc854b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>content_filter_hash_buckets</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a08edfa879fe06d29c55dcc96b4270084</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>flow_controller_hash_buckets</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>ab4bf38e29a672dcca9fc58ed1bcf8a70</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_gather_destinations</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a7963dc712bf1b737c4c51e2f185c89cf</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>participant_user_data_max_length</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>ad614f99b6fdd36443f3873c2fc4372f6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>topic_data_max_length</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>aaaa9561fca4bc9ba78f795c95d998cf1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>publisher_group_data_max_length</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a68f0f4f2db374a517c036eb16e93c59b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>subscriber_group_data_max_length</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a50f86f3bdb0f394befd4abe1611efdf5</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>writer_user_data_max_length</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>aa11438e715e6704e18173815e3766a76</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>reader_user_data_max_length</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a093ce6b8f97fdaa3d6843071f05afe69</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_partitions</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a6b37b5d8e18a9a3bb40178b74436ec28</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_partition_cumulative_characters</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>adaae0663c2f786d8779e126abf8f0779</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>type_code_max_serialized_length</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a55d8561093c4ab21484613a4b8de2999</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>type_object_max_serialized_length</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>af7e993465ab759a9032c95bd19a44262</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>type_object_max_deserialized_length</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>ad29a2a0ac775b118bc3e80f290f879c2</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>deserialized_type_object_dynamic_allocation_threshold</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a5738288b7264799298b99e985cad86fa</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>contentfilter_property_max_length</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>aef1ff851202f5777d31528a52d528e4f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>channel_seq_max_length</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>ae0a143c080d8f9ce1939306ef6e6c749</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>channel_filter_expression_max_length</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a5b8f830c9eafaef35a4f3a5fe50fa70e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>participant_property_list_max_length</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a603f54cdee298b107e90b4984641854c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>participant_property_string_max_length</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>ae5d33afb9e6fb931d167754f1ebf641a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>writer_property_list_max_length</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>aa5b28c30aa6beda6a0568ba77aa23e2e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>writer_property_string_max_length</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a0a876affe67313f446c01512ff8ea7b4</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>reader_property_list_max_length</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a47ae2ed49d92fb045a78da6e15ac30d0</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>reader_property_string_max_length</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a329bfdf7c0e7ad6f780d5f0602346dd0</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_endpoint_groups</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a6ade5ac0d97d60b7af0c863777354bd0</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_endpoint_group_cumulative_characters</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a5d2d500aa2304bdb80571618ee9aca34</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>transport_info_list_max_length</name>
      <anchorfile>structDDS__DomainParticipantResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a8886a393ac7fc8a0f903a1e92c4f9fbb</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_DoubleSeq</name>
    <filename>structDDS__DoubleSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_DurabilityQosPolicy</name>
    <filename>structDDS__DurabilityQosPolicy.html</filename>
    <member kind="variable">
      <type>DDS_DurabilityQosPolicyKind</type>
      <name>kind</name>
      <anchorfile>structDDS__DurabilityQosPolicy.html</anchorfile>
      <anchor>a3a8d255d2a64010fc8a098290911fe03</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>direct_communication</name>
      <anchorfile>structDDS__DurabilityQosPolicy.html</anchorfile>
      <anchor>a61554f529a8935be25c0bc1e099b6672</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__DurabilityQosPolicy">DDSDurabilityQosModule_usage</docanchor>
    <docanchor file="structDDS__DurabilityQosPolicy">DDSDurabilityQosModule_usage_persistence</docanchor>
    <docanchor file="structDDS__DurabilityQosPolicy">DDSDurabilityQosModule_compatibility</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_DurabilityServiceQosPolicy</name>
    <filename>structDDS__DurabilityServiceQosPolicy.html</filename>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>service_cleanup_delay</name>
      <anchorfile>structDDS__DurabilityServiceQosPolicy.html</anchorfile>
      <anchor>ac7a8523eddd55ccc214144a5d39af775</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_HistoryQosPolicyKind</type>
      <name>history_kind</name>
      <anchorfile>structDDS__DurabilityServiceQosPolicy.html</anchorfile>
      <anchor>a0f20c5b7f96c3f1e8945cb094cd42b32</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>history_depth</name>
      <anchorfile>structDDS__DurabilityServiceQosPolicy.html</anchorfile>
      <anchor>aedd0604b30ea071c63e61b6dde0b2e9b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_samples</name>
      <anchorfile>structDDS__DurabilityServiceQosPolicy.html</anchorfile>
      <anchor>a060a03b3687c6f68e59be1fa6010fa92</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_instances</name>
      <anchorfile>structDDS__DurabilityServiceQosPolicy.html</anchorfile>
      <anchor>a375e00f042b67e01e2a97b7963401f94</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_samples_per_instance</name>
      <anchorfile>structDDS__DurabilityServiceQosPolicy.html</anchorfile>
      <anchor>af51c6d0f98637f8afa5db5e6b2bb0c47</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__DurabilityServiceQosPolicy">DDSDurabilityServiceQosModule_usage</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_Duration_t</name>
    <filename>structDDS__Duration__t.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>sec</name>
      <anchorfile>structDDS__Duration__t.html</anchorfile>
      <anchor>a657203cce563e66c0114daed408ccc3c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_UnsignedLong</type>
      <name>nanosec</name>
      <anchorfile>structDDS__Duration__t.html</anchorfile>
      <anchor>a3b0cc19e5e7ffff0d0c5ee8b679b50cb</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_DynamicData</name>
    <filename>structDDS__DynamicData.html</filename>
    <docanchor file="structDDS__DynamicData">DDSDynamicDataModule_member_name_id</docanchor>
    <docanchor file="structDDS__DynamicData">DDSDynamicDataModule_collections</docanchor>
    <docanchor file="structDDS__DynamicData">DDSDynamicDataModule_functionality</docanchor>
    <docanchor file="structDDS__DynamicData">DDSDynamicDataModule_functionality_lifecycle</docanchor>
    <docanchor file="structDDS__DynamicData">DDSDynamicDataModule_functionality_get_set</docanchor>
    <docanchor file="structDDS__DynamicData">DDSDynamicDataModule_functionality_query</docanchor>
    <docanchor file="structDDS__DynamicData">DDSDynamicDataModule_functionality_bind</docanchor>
    <docanchor file="structDDS__DynamicData">DDSDynamicDataModule_functionality_keys</docanchor>
    <docanchor file="structDDS__DynamicData">DDSDynamicDataModule_performance</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_DynamicDataInfo</name>
    <filename>structDDS__DynamicDataInfo.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>member_count</name>
      <anchorfile>structDDS__DynamicDataInfo.html</anchorfile>
      <anchor>af7bc0ed063328d63f3e30d56a506b4b8</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>stored_size</name>
      <anchorfile>structDDS__DynamicDataInfo.html</anchorfile>
      <anchor>a2a747bd02af0d2771310e238cecb4a00</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_DynamicDataMemberInfo</name>
    <filename>structDDS__DynamicDataMemberInfo.html</filename>
    <member kind="variable">
      <type>DDS_DynamicDataMemberId</type>
      <name>member_id</name>
      <anchorfile>structDDS__DynamicDataMemberInfo.html</anchorfile>
      <anchor>a2e9cd8299b52ab2034c1ffa8ad5f2f00</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const char *</type>
      <name>member_name</name>
      <anchorfile>structDDS__DynamicDataMemberInfo.html</anchorfile>
      <anchor>a2add5b362e0cab6eb56af7c7ccdc3f29</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>member_exists</name>
      <anchorfile>structDDS__DynamicDataMemberInfo.html</anchorfile>
      <anchor>afed92e27d4088c171490cf7891a22e39</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_TCKind</type>
      <name>member_kind</name>
      <anchorfile>structDDS__DynamicDataMemberInfo.html</anchorfile>
      <anchor>a353b8dfb418b929b5ea2768e81ad1d0e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_UnsignedLong</type>
      <name>element_count</name>
      <anchorfile>structDDS__DynamicDataMemberInfo.html</anchorfile>
      <anchor>aa6896e798c40c53d72cfd9f597badeb5</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_TCKind</type>
      <name>element_kind</name>
      <anchorfile>structDDS__DynamicDataMemberInfo.html</anchorfile>
      <anchor>a7b7a707314c8448b605c5cd7d51cd2f1</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_DynamicDataProperty_t</name>
    <filename>structDDS__DynamicDataProperty__t.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>buffer_initial_size</name>
      <anchorfile>structDDS__DynamicDataProperty__t.html</anchorfile>
      <anchor>ad751e09e1b5c2ec37330503073213d70</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>buffer_max_size</name>
      <anchorfile>structDDS__DynamicDataProperty__t.html</anchorfile>
      <anchor>ae82fa317174df880ee873fb73e7d887c</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_DynamicDataSeq</name>
    <filename>structDDS__DynamicDataSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_DynamicDataTypeProperty_t</name>
    <filename>structDDS__DynamicDataTypeProperty__t.html</filename>
    <member kind="variable">
      <type>struct DDS_DynamicDataProperty_t</type>
      <name>data</name>
      <anchorfile>structDDS__DynamicDataTypeProperty__t.html</anchorfile>
      <anchor>a257efb57536d0fdd00fddef00c3640e9</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DynamicDataTypeSerializationProperty_t</type>
      <name>serialization</name>
      <anchorfile>structDDS__DynamicDataTypeProperty__t.html</anchorfile>
      <anchor>ac7db9608a24ec4a8f9206463eecd4978</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_DynamicDataTypeSerializationProperty_t</name>
    <filename>structDDS__DynamicDataTypeSerializationProperty__t.html</filename>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>use_42e_compatible_alignment</name>
      <anchorfile>structDDS__DynamicDataTypeSerializationProperty__t.html</anchorfile>
      <anchor>a64d7dc6e6f032ce259c325076d4bbb7a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_UnsignedLong</type>
      <name>max_size_serialized</name>
      <anchorfile>structDDS__DynamicDataTypeSerializationProperty__t.html</anchorfile>
      <anchor>a294841697c9045f8c7d4cbfe1812a537</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_UnsignedLong</type>
      <name>min_size_serialized</name>
      <anchorfile>structDDS__DynamicDataTypeSerializationProperty__t.html</anchorfile>
      <anchor>ab03ac88e4b6d19097cd8cd0809a4de6a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>trim_to_size</name>
      <anchorfile>structDDS__DynamicDataTypeSerializationProperty__t.html</anchorfile>
      <anchor>ab1a66c950559f3925dec2c194179b762</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_EndpointGroup_t</name>
    <filename>structDDS__EndpointGroup__t.html</filename>
    <member kind="variable">
      <type>char *</type>
      <name>role_name</name>
      <anchorfile>structDDS__EndpointGroup__t.html</anchorfile>
      <anchor>a8691456e25943a517b4a7a96b5ef778d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>quorum_count</name>
      <anchorfile>structDDS__EndpointGroup__t.html</anchorfile>
      <anchor>ace628a44fe0ed3d39b21185afe4d5374</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_EndpointGroupSeq</name>
    <filename>structDDS__EndpointGroupSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_EntityFactoryQosPolicy</name>
    <filename>structDDS__EntityFactoryQosPolicy.html</filename>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>autoenable_created_entities</name>
      <anchorfile>structDDS__EntityFactoryQosPolicy.html</anchorfile>
      <anchor>a4b650acc47f1a51eefd90a072d6a70f6</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__EntityFactoryQosPolicy">DDSEntityFactoryQosModule_usage</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_EntityNameQosPolicy</name>
    <filename>structDDS__EntityNameQosPolicy.html</filename>
    <member kind="variable">
      <type>char *</type>
      <name>name</name>
      <anchorfile>structDDS__EntityNameQosPolicy.html</anchorfile>
      <anchor>a564868d7879c1db2da049ed3cc2c4ee6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>role_name</name>
      <anchorfile>structDDS__EntityNameQosPolicy.html</anchorfile>
      <anchor>ae9b3fcba53b00cbf75c0edbc785332c9</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__EntityNameQosPolicy">DDSEntityNameQosModule_usage</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_EnumMember</name>
    <filename>structDDS__EnumMember.html</filename>
    <member kind="variable">
      <type>char *</type>
      <name>name</name>
      <anchorfile>structDDS__EnumMember.html</anchorfile>
      <anchor>a3b475e4683ede010bcdb681b85eaada2</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>ordinal</name>
      <anchorfile>structDDS__EnumMember.html</anchorfile>
      <anchor>a1c981e305c6c00aaef0964d872eb5d0c</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_EnumMemberSeq</name>
    <filename>structDDS__EnumMemberSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_EventQosPolicy</name>
    <filename>structDDS__EventQosPolicy.html</filename>
    <member kind="variable">
      <type>struct DDS_ThreadSettings_t</type>
      <name>thread</name>
      <anchorfile>structDDS__EventQosPolicy.html</anchorfile>
      <anchor>acbbd094dc9b44add126e1efdf5433c75</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>initial_count</name>
      <anchorfile>structDDS__EventQosPolicy.html</anchorfile>
      <anchor>ab6df398735d3abcb5127d201c8441360</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_count</name>
      <anchorfile>structDDS__EventQosPolicy.html</anchorfile>
      <anchor>ae9ae6d11894f70c51a84ab3bff70cb4e</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_ExclusiveAreaQosPolicy</name>
    <filename>structDDS__ExclusiveAreaQosPolicy.html</filename>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>use_shared_exclusive_area</name>
      <anchorfile>structDDS__ExclusiveAreaQosPolicy.html</anchorfile>
      <anchor>a6f4a182c16cd91fc2250dd043450b9c1</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__ExclusiveAreaQosPolicy">DDSExclusiveAreaQosModule_usage</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_ExpressionProperty</name>
    <filename>structDDS__ExpressionProperty.html</filename>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>key_only_filter</name>
      <anchorfile>structDDS__ExpressionProperty.html</anchorfile>
      <anchor>ac2a4c794cdd4e22ce1cc8568f290f96d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>writer_side_filter_optimization</name>
      <anchorfile>structDDS__ExpressionProperty.html</anchorfile>
      <anchor>a921205af1e067d3d483c4835a5d216eb</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_FilterSampleInfo</name>
    <filename>structDDS__FilterSampleInfo.html</filename>
    <member kind="variable">
      <type>struct DDS_SampleIdentity_t</type>
      <name>related_sample_identity</name>
      <anchorfile>structDDS__FilterSampleInfo.html</anchorfile>
      <anchor>ab8d179c24eb14e7629a3a1353018bbc8</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_FloatSeq</name>
    <filename>structDDS__FloatSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_FlowControllerProperty_t</name>
    <filename>structDDS__FlowControllerProperty__t.html</filename>
    <member kind="variable">
      <type>DDS_FlowControllerSchedulingPolicy</type>
      <name>scheduling_policy</name>
      <anchorfile>structDDS__FlowControllerProperty__t.html</anchorfile>
      <anchor>a97ba75a849dfbdb62fedc501f72188d7</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_FlowControllerTokenBucketProperty_t</type>
      <name>token_bucket</name>
      <anchorfile>structDDS__FlowControllerProperty__t.html</anchorfile>
      <anchor>a8eb65d1b99a39daf5a1521bb31603f3e</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_FlowControllerTokenBucketProperty_t</name>
    <filename>structDDS__FlowControllerTokenBucketProperty__t.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_tokens</name>
      <anchorfile>structDDS__FlowControllerTokenBucketProperty__t.html</anchorfile>
      <anchor>a662f02e48691a39d0d3ab13d6e4efc66</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>tokens_added_per_period</name>
      <anchorfile>structDDS__FlowControllerTokenBucketProperty__t.html</anchorfile>
      <anchor>a721f7182e312c99deb1e152e849dc694</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>tokens_leaked_per_period</name>
      <anchorfile>structDDS__FlowControllerTokenBucketProperty__t.html</anchorfile>
      <anchor>af9e2f8fd04c1bfa059f85fe42b4f2df6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>period</name>
      <anchorfile>structDDS__FlowControllerTokenBucketProperty__t.html</anchorfile>
      <anchor>a6dc56f20c740970edbe778ece872824d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>bytes_per_token</name>
      <anchorfile>structDDS__FlowControllerTokenBucketProperty__t.html</anchorfile>
      <anchor>a9a648e9579c63f93c2bf17a78b713536</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_GroupDataQosPolicy</name>
    <filename>structDDS__GroupDataQosPolicy.html</filename>
    <member kind="variable">
      <type>struct DDS_OctetSeq</type>
      <name>value</name>
      <anchorfile>structDDS__GroupDataQosPolicy.html</anchorfile>
      <anchor>ab2a91d6c692556b213354d871f99b840</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__GroupDataQosPolicy">DDSGroupDataQosModule_usage</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_GUID_t</name>
    <filename>structDDS__GUID__t.html</filename>
    <member kind="variable">
      <type>DDS_Octet</type>
      <name>value</name>
      <anchorfile>structDDS__GUID__t.html</anchorfile>
      <anchor>a59075031ce8b08abfe195c6e18ec1e4a</anchor>
      <arglist>[16]</arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_HistoryQosPolicy</name>
    <filename>structDDS__HistoryQosPolicy.html</filename>
    <member kind="variable">
      <type>DDS_HistoryQosPolicyKind</type>
      <name>kind</name>
      <anchorfile>structDDS__HistoryQosPolicy.html</anchorfile>
      <anchor>a3cb2743cd13a81614bcc4f314cd640ab</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>depth</name>
      <anchorfile>structDDS__HistoryQosPolicy.html</anchorfile>
      <anchor>aef0fb3fd3579866be17d1a936f5e3729</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_RefilterQosPolicyKind</type>
      <name>refilter</name>
      <anchorfile>structDDS__HistoryQosPolicy.html</anchorfile>
      <anchor>a57fc2012e6696f112fed75bfbb9181c8</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__HistoryQosPolicy">DDSHistoryQosModule_usage</docanchor>
    <docanchor file="structDDS__HistoryQosPolicy">DDSHistoryQosModule_consistency</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_InconsistentTopicStatus</name>
    <filename>structDDS__InconsistentTopicStatus.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>total_count</name>
      <anchorfile>structDDS__InconsistentTopicStatus.html</anchorfile>
      <anchor>aa9a91b98bef93619270c7d946db09e4f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>total_count_change</name>
      <anchorfile>structDDS__InconsistentTopicStatus.html</anchorfile>
      <anchor>a9787c195c5350dde62dd77a6f4ad7f82</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_InstanceHandleSeq</name>
    <filename>structDDS__InstanceHandleSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_KeyedOctets</name>
    <filename>structDDS__KeyedOctets.html</filename>
    <member kind="variable">
      <type>char *</type>
      <name>key</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga7551f6b447effb4c5777339742c5e87f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>int</type>
      <name>length</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga9d871f7ab4c38162a1f90ced4c758721</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>unsigned char *</type>
      <name>value</name>
      <anchorfile>group__DDSKeyedOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga05e97b4efdbf5dde0ed62107fa61a1b4</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_KeyedOctetsSeq</name>
    <filename>structDDS__KeyedOctetsSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_KeyedOctetsTypeSupport</name>
    <filename>structDDS__KeyedOctetsTypeSupport.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_KeyedString</name>
    <filename>structDDS__KeyedString.html</filename>
    <member kind="variable">
      <type>char *</type>
      <name>key</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga9778538b061fdaa0754773883fc5fe8f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>value</name>
      <anchorfile>group__DDSKeyedStringBuiltInTypeModule.html</anchorfile>
      <anchor>ga4c3046a4749745d072d5be067d718e1e</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_KeyedStringSeq</name>
    <filename>structDDS__KeyedStringSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_KeyedStringTypeSupport</name>
    <filename>structDDS__KeyedStringTypeSupport.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_LatencyBudgetQosPolicy</name>
    <filename>structDDS__LatencyBudgetQosPolicy.html</filename>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>duration</name>
      <anchorfile>structDDS__LatencyBudgetQosPolicy.html</anchorfile>
      <anchor>a28d7a05d6a5559f3e174c5bebe0852b4</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__LatencyBudgetQosPolicy">DDSLatencyBudgetQosModule_usage</docanchor>
    <docanchor file="structDDS__LatencyBudgetQosPolicy">DDSLatencyBudgetQosModule_compatibility</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_LifespanQosPolicy</name>
    <filename>structDDS__LifespanQosPolicy.html</filename>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>duration</name>
      <anchorfile>structDDS__LifespanQosPolicy.html</anchorfile>
      <anchor>a5e6057fb4e4570e83d67616638bfe5e1</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__LifespanQosPolicy">DDSLifespanQosModule_usage</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_Listener</name>
    <filename>structDDS__Listener.html</filename>
    <member kind="variable">
      <type>void *</type>
      <name>listener_data</name>
      <anchorfile>structDDS__Listener.html</anchorfile>
      <anchor>a7bc1575f71cc162d98719ffbe8642478</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__Listener">Listener_plain</docanchor>
    <docanchor file="structDDS__Listener">Listener_read</docanchor>
    <docanchor file="structDDS__Listener">SharedEACallbackRules</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_LivelinessChangedStatus</name>
    <filename>structDDS__LivelinessChangedStatus.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>alive_count</name>
      <anchorfile>structDDS__LivelinessChangedStatus.html</anchorfile>
      <anchor>a80d936174c0ab0ec3f00c93d42cd5e8d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>not_alive_count</name>
      <anchorfile>structDDS__LivelinessChangedStatus.html</anchorfile>
      <anchor>a033deaf4050e1d8c8f449a8d8d23f42b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>alive_count_change</name>
      <anchorfile>structDDS__LivelinessChangedStatus.html</anchorfile>
      <anchor>a9f6482b97ab94cffa0151a14043970b8</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>not_alive_count_change</name>
      <anchorfile>structDDS__LivelinessChangedStatus.html</anchorfile>
      <anchor>a7538f6a9c8972ce3f715926666152458</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_InstanceHandle_t</type>
      <name>last_publication_handle</name>
      <anchorfile>structDDS__LivelinessChangedStatus.html</anchorfile>
      <anchor>a40f5066740fe151f0ab30596ad6141c3</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_LivelinessLostStatus</name>
    <filename>structDDS__LivelinessLostStatus.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>total_count</name>
      <anchorfile>structDDS__LivelinessLostStatus.html</anchorfile>
      <anchor>a6476fa4f784212625c98f08587b25c79</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>total_count_change</name>
      <anchorfile>structDDS__LivelinessLostStatus.html</anchorfile>
      <anchor>a84e853a0e6a2f5c403b65047b3a43d60</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_LivelinessQosPolicy</name>
    <filename>structDDS__LivelinessQosPolicy.html</filename>
    <member kind="variable">
      <type>DDS_LivelinessQosPolicyKind</type>
      <name>kind</name>
      <anchorfile>structDDS__LivelinessQosPolicy.html</anchorfile>
      <anchor>a03b38bf501032dec5e022778f8a9a4da</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>lease_duration</name>
      <anchorfile>structDDS__LivelinessQosPolicy.html</anchorfile>
      <anchor>a5ace30a25fd07e0392687cdb405171b0</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__LivelinessQosPolicy">DDSLivelinessQosModule_usage</docanchor>
    <docanchor file="structDDS__LivelinessQosPolicy">DDSLivelinessQosModule_compatibility</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_Locator_t</name>
    <filename>structDDS__Locator__t.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>kind</name>
      <anchorfile>structDDS__Locator__t.html</anchorfile>
      <anchor>a9edcd4e034b5e0da83908eb0015584ed</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_UnsignedLong</type>
      <name>port</name>
      <anchorfile>structDDS__Locator__t.html</anchorfile>
      <anchor>a3be09c0e74c71adf066926ead6cafad5</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Octet</type>
      <name>address</name>
      <anchorfile>structDDS__Locator__t.html</anchorfile>
      <anchor>a21501fa2cc5fc8f3eb08bc66b3c8f724</anchor>
      <arglist>[DDS_LOCATOR_ADDRESS_LENGTH_MAX]</arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_LocatorFilter_t</name>
    <filename>structDDS__LocatorFilter__t.html</filename>
    <member kind="variable">
      <type>struct DDS_LocatorSeq</type>
      <name>locators</name>
      <anchorfile>structDDS__LocatorFilter__t.html</anchorfile>
      <anchor>a0c96d1176b7c23d0719bbb7c81bf864f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>filter_expression</name>
      <anchorfile>structDDS__LocatorFilter__t.html</anchorfile>
      <anchor>aa115e4c5980cd83204e2873186f3eda7</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_LocatorFilterQosPolicy</name>
    <filename>structDDS__LocatorFilterQosPolicy.html</filename>
    <member kind="variable">
      <type>struct DDS_LocatorFilterSeq</type>
      <name>locator_filters</name>
      <anchorfile>structDDS__LocatorFilterQosPolicy.html</anchorfile>
      <anchor>a8b180a9c8e4542fbb2a321e583bb886e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>filter_name</name>
      <anchorfile>structDDS__LocatorFilterQosPolicy.html</anchorfile>
      <anchor>a7da2ccdaeeef09bd3519880c4e439b52</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_LocatorFilterSeq</name>
    <filename>structDDS__LocatorFilterSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_LocatorSeq</name>
    <filename>structDDS__LocatorSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_LoggingQosPolicy</name>
    <filename>structDDS__LoggingQosPolicy.html</filename>
    <member kind="variable">
      <type>NDDS_Config_LogVerbosity</type>
      <name>verbosity</name>
      <anchorfile>structDDS__LoggingQosPolicy.html</anchorfile>
      <anchor>aaf847ddec11017b976bbb0e93f918ebd</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>NDDS_Config_LogCategory</type>
      <name>category</name>
      <anchorfile>structDDS__LoggingQosPolicy.html</anchorfile>
      <anchor>abdfa0dc2c78ab53003e4d78cd5000cdc</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>NDDS_Config_LogPrintFormat</type>
      <name>print_format</name>
      <anchorfile>structDDS__LoggingQosPolicy.html</anchorfile>
      <anchor>a068e1abdb2e02a22f6062585bb3c3793</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>output_file</name>
      <anchorfile>structDDS__LoggingQosPolicy.html</anchorfile>
      <anchor>a7c262bbe4378b5e53d8c6024da42ebf4</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_LongDoubleSeq</name>
    <filename>structDDS__LongDoubleSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_LongLongSeq</name>
    <filename>structDDS__LongLongSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_LongSeq</name>
    <filename>structDDS__LongSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_MultiChannelQosPolicy</name>
    <filename>structDDS__MultiChannelQosPolicy.html</filename>
    <member kind="variable">
      <type>struct DDS_ChannelSettingsSeq</type>
      <name>channels</name>
      <anchorfile>structDDS__MultiChannelQosPolicy.html</anchorfile>
      <anchor>ad66a42cffccfb0ba3daf01aa1b65edf7</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>filter_name</name>
      <anchorfile>structDDS__MultiChannelQosPolicy.html</anchorfile>
      <anchor>abce9222676b24a8b348efe0fc0904a37</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__MultiChannelQosPolicy">DDSMultiChannelQosModule_usage</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_Octets</name>
    <filename>structDDS__Octets.html</filename>
    <member kind="variable">
      <type>int</type>
      <name>length</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>ga67c79fe81ce668b1493fb9446df4c570</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>unsigned char *</type>
      <name>value</name>
      <anchorfile>group__DDSOctetsBuiltInTypeModule.html</anchorfile>
      <anchor>gae289d9fba09f3386ba897fd02969df29</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_OctetSeq</name>
    <filename>structDDS__OctetSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_OctetsSeq</name>
    <filename>structDDS__OctetsSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_OctetsTypeSupport</name>
    <filename>structDDS__OctetsTypeSupport.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_OfferedDeadlineMissedStatus</name>
    <filename>structDDS__OfferedDeadlineMissedStatus.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>total_count</name>
      <anchorfile>structDDS__OfferedDeadlineMissedStatus.html</anchorfile>
      <anchor>a17262425aea25d6dfe4b6162d596c2b0</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>total_count_change</name>
      <anchorfile>structDDS__OfferedDeadlineMissedStatus.html</anchorfile>
      <anchor>a996c66a2e5072f20a0850fd94ecc433c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_InstanceHandle_t</type>
      <name>last_instance_handle</name>
      <anchorfile>structDDS__OfferedDeadlineMissedStatus.html</anchorfile>
      <anchor>acd00bafe297f4563cb55f1dda96bfa4d</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_OfferedIncompatibleQosStatus</name>
    <filename>structDDS__OfferedIncompatibleQosStatus.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>total_count</name>
      <anchorfile>structDDS__OfferedIncompatibleQosStatus.html</anchorfile>
      <anchor>aa90180c83fd132288ac14a05d090b117</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>total_count_change</name>
      <anchorfile>structDDS__OfferedIncompatibleQosStatus.html</anchorfile>
      <anchor>a68363b158df1f07e32d67249111958e3</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_QosPolicyId_t</type>
      <name>last_policy_id</name>
      <anchorfile>structDDS__OfferedIncompatibleQosStatus.html</anchorfile>
      <anchor>a58f04e98c5edac6e86ae360dbf243b21</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_QosPolicyCountSeq</type>
      <name>policies</name>
      <anchorfile>structDDS__OfferedIncompatibleQosStatus.html</anchorfile>
      <anchor>a28a38881ba616588ef588ee786668aa9</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_OwnershipQosPolicy</name>
    <filename>structDDS__OwnershipQosPolicy.html</filename>
    <member kind="variable">
      <type>DDS_OwnershipQosPolicyKind</type>
      <name>kind</name>
      <anchorfile>structDDS__OwnershipQosPolicy.html</anchorfile>
      <anchor>a27bb5132fe04e1d932300786f79654e6</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__OwnershipQosPolicy">DDSOwnershipQosModule_usage</docanchor>
    <docanchor file="structDDS__OwnershipQosPolicy">DDSOwnershipQosModule_usage_shared</docanchor>
    <docanchor file="structDDS__OwnershipQosPolicy">DDSOwnershipQosModule_usage_exclusive</docanchor>
    <docanchor file="structDDS__OwnershipQosPolicy">DDSOwnershipQosModule_compatibility</docanchor>
    <docanchor file="structDDS__OwnershipQosPolicy">Registration_liveliness_ownership</docanchor>
    <docanchor file="structDDS__OwnershipQosPolicy">Ownership_redundant_systems</docanchor>
    <docanchor file="structDDS__OwnershipQosPolicy">Ownership_data_periodic_update</docanchor>
    <docanchor file="structDDS__OwnershipQosPolicy">Ownership_data_not_periodic_update</docanchor>
    <docanchor file="structDDS__OwnershipQosPolicy">Ownership_loss_connectivity_detection</docanchor>
    <docanchor file="structDDS__OwnershipQosPolicy">Unregister_instance_and_dispose_difference</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_OwnershipStrengthQosPolicy</name>
    <filename>structDDS__OwnershipStrengthQosPolicy.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>value</name>
      <anchorfile>structDDS__OwnershipStrengthQosPolicy.html</anchorfile>
      <anchor>afda6a59cd3cfd9bc904c98efc68a61eb</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_ParticipantBuiltinTopicData</name>
    <filename>structDDS__ParticipantBuiltinTopicData.html</filename>
    <member kind="variable">
      <type>DDS_BuiltinTopicKey_t</type>
      <name>key</name>
      <anchorfile>structDDS__ParticipantBuiltinTopicData.html</anchorfile>
      <anchor>ac6f4069f09e74633f2a94d4fd3b5632a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_UserDataQosPolicy</type>
      <name>user_data</name>
      <anchorfile>structDDS__ParticipantBuiltinTopicData.html</anchorfile>
      <anchor>acd2e4123cf3baaf7aba20bb18d195574</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_PropertyQosPolicy</type>
      <name>property</name>
      <anchorfile>structDDS__ParticipantBuiltinTopicData.html</anchorfile>
      <anchor>a91f02a3edca55b3f7787301c18e0e287</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_ProtocolVersion_t</type>
      <name>rtps_protocol_version</name>
      <anchorfile>structDDS__ParticipantBuiltinTopicData.html</anchorfile>
      <anchor>aa43e56ac72a721046c9bee8882a0758e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_VendorId_t</type>
      <name>rtps_vendor_id</name>
      <anchorfile>structDDS__ParticipantBuiltinTopicData.html</anchorfile>
      <anchor>a2a7b8d4da99b0808dd6a61003f78b58a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_UnsignedLong</type>
      <name>dds_builtin_endpoints</name>
      <anchorfile>structDDS__ParticipantBuiltinTopicData.html</anchorfile>
      <anchor>a814c8143a49a130f9ea41b840738a6a8</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_LocatorSeq</type>
      <name>default_unicast_locators</name>
      <anchorfile>structDDS__ParticipantBuiltinTopicData.html</anchorfile>
      <anchor>a24e3aa57dc41e7756130cd4be176125b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_ProductVersion_t</type>
      <name>product_version</name>
      <anchorfile>structDDS__ParticipantBuiltinTopicData.html</anchorfile>
      <anchor>a37ff2c7f722e4b8831ad1d66cbac2578</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_EntityNameQosPolicy</type>
      <name>participant_name</name>
      <anchorfile>structDDS__ParticipantBuiltinTopicData.html</anchorfile>
      <anchor>a9a0ba3542ddd58b6f2f56f15d2e9ac4d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_DomainId_t</type>
      <name>domain_id</name>
      <anchorfile>structDDS__ParticipantBuiltinTopicData.html</anchorfile>
      <anchor>a315dce34051af7f830160db2bb117946</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_TransportInfoSeq</type>
      <name>transport_info</name>
      <anchorfile>structDDS__ParticipantBuiltinTopicData.html</anchorfile>
      <anchor>a6cbd511a56e8f9bc73625218129a1468</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_ParticipantBuiltinTopicDataSeq</name>
    <filename>structDDS__ParticipantBuiltinTopicDataSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_ParticipantBuiltinTopicDataTypeSupport</name>
    <filename>structDDS__ParticipantBuiltinTopicDataTypeSupport.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_PartitionQosPolicy</name>
    <filename>structDDS__PartitionQosPolicy.html</filename>
    <member kind="variable">
      <type>struct DDS_StringSeq</type>
      <name>name</name>
      <anchorfile>structDDS__PartitionQosPolicy.html</anchorfile>
      <anchor>a32d912c94f200b40110043c31a45e12d</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__PartitionQosPolicy">DDSPartitionQosModule_usage</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_PresentationQosPolicy</name>
    <filename>structDDS__PresentationQosPolicy.html</filename>
    <member kind="variable">
      <type>DDS_PresentationQosPolicyAccessScopeKind</type>
      <name>access_scope</name>
      <anchorfile>structDDS__PresentationQosPolicy.html</anchorfile>
      <anchor>a0d46a4e9fe04a65507153013ab542e64</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>coherent_access</name>
      <anchorfile>structDDS__PresentationQosPolicy.html</anchorfile>
      <anchor>a6882e12b1b9dc671540818bd6a8f3321</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>ordered_access</name>
      <anchorfile>structDDS__PresentationQosPolicy.html</anchorfile>
      <anchor>a7a534396ec3b27a902ef4b6fe95ae454</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__PresentationQosPolicy">DDSPresentationQosModule_usage</docanchor>
    <docanchor file="structDDS__PresentationQosPolicy">DDSPresentationQosModule_compatibility</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_ProductVersion_t</name>
    <filename>structDDS__ProductVersion__t.html</filename>
    <member kind="variable">
      <type>DDS_Char</type>
      <name>major</name>
      <anchorfile>structDDS__ProductVersion__t.html</anchorfile>
      <anchor>a8e70ba630c03cf1f8fe0d1bff88d8f64</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Char</type>
      <name>minor</name>
      <anchorfile>structDDS__ProductVersion__t.html</anchorfile>
      <anchor>a0b5fa5504fbbfbec86e1c50929eb0bbe</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Char</type>
      <name>release</name>
      <anchorfile>structDDS__ProductVersion__t.html</anchorfile>
      <anchor>a85f665c8befa4aff49aaa316318a8c8d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Char</type>
      <name>revision</name>
      <anchorfile>structDDS__ProductVersion__t.html</anchorfile>
      <anchor>aaef10e3cbed815ddde55a1a06622d115</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_ProfileQosPolicy</name>
    <filename>structDDS__ProfileQosPolicy.html</filename>
    <member kind="variable">
      <type>struct DDS_StringSeq</type>
      <name>string_profile</name>
      <anchorfile>structDDS__ProfileQosPolicy.html</anchorfile>
      <anchor>a2344597aa6c3425072f8de115762256f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_StringSeq</type>
      <name>url_profile</name>
      <anchorfile>structDDS__ProfileQosPolicy.html</anchorfile>
      <anchor>a0e2c1f3fdffb07c941ab3f81c8d0fc18</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>ignore_user_profile</name>
      <anchorfile>structDDS__ProfileQosPolicy.html</anchorfile>
      <anchor>a2a8368ab1d2c31891b84abec365e744b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>ignore_environment_profile</name>
      <anchorfile>structDDS__ProfileQosPolicy.html</anchorfile>
      <anchor>a491347b4e19c06ff31a1434174d11267</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>ignore_resource_profile</name>
      <anchorfile>structDDS__ProfileQosPolicy.html</anchorfile>
      <anchor>ab12aebc246d4b662dd0d2a9c2bfc44d4</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_Property_t</name>
    <filename>structDDS__Property__t.html</filename>
    <member kind="variable">
      <type>char *</type>
      <name>name</name>
      <anchorfile>structDDS__Property__t.html</anchorfile>
      <anchor>a3172a6b3ee8f5939542a5c984faabbea</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>value</name>
      <anchorfile>structDDS__Property__t.html</anchorfile>
      <anchor>a92e6de016959b77ae293833ded428dd0</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>propagate</name>
      <anchorfile>structDDS__Property__t.html</anchorfile>
      <anchor>a8b0c6a02a86a64c2828e6948ffa1b9c2</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_PropertyQosPolicy</name>
    <filename>structDDS__PropertyQosPolicy.html</filename>
    <member kind="variable">
      <type>struct DDS_PropertySeq</type>
      <name>value</name>
      <anchorfile>structDDS__PropertyQosPolicy.html</anchorfile>
      <anchor>a43fc72a57f79876aaf0383c5847a4b00</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__PropertyQosPolicy">DDSPropertyQosModule_usage</docanchor>
    <docanchor file="structDDS__PropertyQosPolicy">DDSPropertyQosModule_usage_reasons</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_PropertySeq</name>
    <filename>structDDS__PropertySeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_ProtocolVersion_t</name>
    <filename>structDDS__ProtocolVersion__t.html</filename>
    <member kind="variable">
      <type>DDS_Octet</type>
      <name>major</name>
      <anchorfile>structDDS__ProtocolVersion__t.html</anchorfile>
      <anchor>a9a9b9ba8dd4bced75c95850ad0d2ca72</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Octet</type>
      <name>minor</name>
      <anchorfile>structDDS__ProtocolVersion__t.html</anchorfile>
      <anchor>a6a2df56169f0b599190b6ecf9d3b84a1</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_PublicationBuiltinTopicData</name>
    <filename>structDDS__PublicationBuiltinTopicData.html</filename>
    <member kind="variable">
      <type>DDS_BuiltinTopicKey_t</type>
      <name>key</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>a4780175a7c9b523cd5d635256d6e0121</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_BuiltinTopicKey_t</type>
      <name>participant_key</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>ac1fecede53d648df3be9a1a7de342da4</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>topic_name</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>a7a839633fbafd0c1b65db9ef35313f28</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>type_name</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>a14c589ddb5213f67d184c87b2af85e69</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DurabilityQosPolicy</type>
      <name>durability</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>a5f864a1b922f7892f6bb70b2cea7c4ba</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DurabilityServiceQosPolicy</type>
      <name>durability_service</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>a3d8df7b64d9eaf1788f16449d3c6d75c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DeadlineQosPolicy</type>
      <name>deadline</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>a9bbe601cda488176a4a427988776efd4</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_LatencyBudgetQosPolicy</type>
      <name>latency_budget</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>a0ec22ddb9260ff9494edae435c3e6a87</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_LivelinessQosPolicy</type>
      <name>liveliness</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>ae2f1ae488666386637ba49fb91eb3a22</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_ReliabilityQosPolicy</type>
      <name>reliability</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>a627123139778dfda5790aa92ca71f548</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_LifespanQosPolicy</type>
      <name>lifespan</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>a84db5f4f222f2e4432a3d184439321c0</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_UserDataQosPolicy</type>
      <name>user_data</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>a32f5f098f4bb08d5887d682bfb449f13</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_OwnershipQosPolicy</type>
      <name>ownership</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>ab132b2e5d53fcf3666987665afa551f7</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_OwnershipStrengthQosPolicy</type>
      <name>ownership_strength</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>add22df16fbee44d1863778ae0709d155</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DestinationOrderQosPolicy</type>
      <name>destination_order</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>aa83ac973bffc3b57aa19deb1793d82e8</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_PresentationQosPolicy</type>
      <name>presentation</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>a1fe1b64f890d9df606bd8d589939a1a0</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_PartitionQosPolicy</type>
      <name>partition</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>ab590d198ae7e088ccd89e638acccc8da</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_TopicDataQosPolicy</type>
      <name>topic_data</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>a74918b1474f0182091a55460e1cb3402</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_GroupDataQosPolicy</type>
      <name>group_data</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>a8af1c832cffabb15c9cd07026060338a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_TypeCode *</type>
      <name>type_code</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>aa1f6f4832c3fee58fcaa9cb7789abbe1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_BuiltinTopicKey_t</type>
      <name>publisher_key</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>af86cc25f198095f819106518e0d62f0c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_PropertyQosPolicy</type>
      <name>property</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>a8b37e8b464591ab33b307791fff5fb01</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_LocatorSeq</type>
      <name>unicast_locators</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>ad7175317a2dbd73b660812465b21a061</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_GUID_t</type>
      <name>virtual_guid</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>a048a588f35d3b58f9a207fee5b2424cc</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_ProtocolVersion_t</type>
      <name>rtps_protocol_version</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>a52d67e43db2cb6f2688479b8526ce82f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_VendorId_t</type>
      <name>rtps_vendor_id</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>af522f7c7b9fb2d4b83ffd0df87cb38ff</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_ProductVersion_t</type>
      <name>product_version</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>ab1dfe9a65bee3db74bfcd9b8ba963524</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_LocatorFilterQosPolicy</type>
      <name>locator_filter</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>a7fcf118e8fba33daf622c55a11d75b52</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>disable_positive_acks</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>ac343476b84743f7b64d62b90ba66beea</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_EntityNameQosPolicy</type>
      <name>publication_name</name>
      <anchorfile>structDDS__PublicationBuiltinTopicData.html</anchorfile>
      <anchor>ac69a4e01d59426a9344155cd85090a67</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_PublicationBuiltinTopicDataSeq</name>
    <filename>structDDS__PublicationBuiltinTopicDataSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_PublicationBuiltinTopicDataTypeSupport</name>
    <filename>structDDS__PublicationBuiltinTopicDataTypeSupport.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_PublicationMatchedStatus</name>
    <filename>structDDS__PublicationMatchedStatus.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>total_count</name>
      <anchorfile>structDDS__PublicationMatchedStatus.html</anchorfile>
      <anchor>ad30400d098f3bcf74fd5be586f900960</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>total_count_change</name>
      <anchorfile>structDDS__PublicationMatchedStatus.html</anchorfile>
      <anchor>a15d13c8b8b914298f4d130ce7786beaf</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>current_count</name>
      <anchorfile>structDDS__PublicationMatchedStatus.html</anchorfile>
      <anchor>ada7d3ae5de5bc07ff1d7f61f0335ce46</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>current_count_peak</name>
      <anchorfile>structDDS__PublicationMatchedStatus.html</anchorfile>
      <anchor>a5bd11d41fcdb79661bf56da24f2d4859</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>current_count_change</name>
      <anchorfile>structDDS__PublicationMatchedStatus.html</anchorfile>
      <anchor>a9cb517dcb586536ece4872a9c84e3674</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_InstanceHandle_t</type>
      <name>last_subscription_handle</name>
      <anchorfile>structDDS__PublicationMatchedStatus.html</anchorfile>
      <anchor>acff73198c0b741358f392263631ee818</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_PublisherListener</name>
    <filename>structDDS__PublisherListener.html</filename>
    <member kind="variable">
      <type>struct DDS_DataWriterListener</type>
      <name>as_datawriterlistener</name>
      <anchorfile>structDDS__PublisherListener.html</anchorfile>
      <anchor>afc3c215ba806ece85056e34108e5d20e</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_PublisherQos</name>
    <filename>structDDS__PublisherQos.html</filename>
    <member kind="variable">
      <type>struct DDS_PresentationQosPolicy</type>
      <name>presentation</name>
      <anchorfile>structDDS__PublisherQos.html</anchorfile>
      <anchor>a02acb622fce449cd35c5cef79df93c4e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_PartitionQosPolicy</type>
      <name>partition</name>
      <anchorfile>structDDS__PublisherQos.html</anchorfile>
      <anchor>a96c903f30dd0794f4de01a85a1e002ec</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_GroupDataQosPolicy</type>
      <name>group_data</name>
      <anchorfile>structDDS__PublisherQos.html</anchorfile>
      <anchor>ad99c76a97a261687a9bbeaf29c7118c2</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_EntityFactoryQosPolicy</type>
      <name>entity_factory</name>
      <anchorfile>structDDS__PublisherQos.html</anchorfile>
      <anchor>a99f7bc6a130ab99727212a24174585c6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_AsynchronousPublisherQosPolicy</type>
      <name>asynchronous_publisher</name>
      <anchorfile>structDDS__PublisherQos.html</anchorfile>
      <anchor>aba8bd4e8009fd9a64b88a61e6f86d041</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_ExclusiveAreaQosPolicy</type>
      <name>exclusive_area</name>
      <anchorfile>structDDS__PublisherQos.html</anchorfile>
      <anchor>ad8dc72e5b1f10762717aa606e624ba4a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_EntityNameQosPolicy</type>
      <name>publisher_name</name>
      <anchorfile>structDDS__PublisherQos.html</anchorfile>
      <anchor>a93dfa4af1242c1cab54557b646b6664d</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_PublisherSeq</name>
    <filename>structDDS__PublisherSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_PublishModeQosPolicy</name>
    <filename>structDDS__PublishModeQosPolicy.html</filename>
    <member kind="variable">
      <type>DDS_PublishModeQosPolicyKind</type>
      <name>kind</name>
      <anchorfile>structDDS__PublishModeQosPolicy.html</anchorfile>
      <anchor>a49f7b6e81f30db4fbcb08d79addcf86c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>flow_controller_name</name>
      <anchorfile>structDDS__PublishModeQosPolicy.html</anchorfile>
      <anchor>a0752f4c8b5a13772ecdd9e82494d6f3e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>priority</name>
      <anchorfile>structDDS__PublishModeQosPolicy.html</anchorfile>
      <anchor>ad1e7c5d383bb088b62034f698e37a4e3</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__PublishModeQosPolicy">DDSPublishModeQosModule_usage</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_QosPolicyCount</name>
    <filename>structDDS__QosPolicyCount.html</filename>
    <member kind="variable">
      <type>DDS_QosPolicyId_t</type>
      <name>policy_id</name>
      <anchorfile>structDDS__QosPolicyCount.html</anchorfile>
      <anchor>a04945631c19b209d01fad0273f02d283</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>count</name>
      <anchorfile>structDDS__QosPolicyCount.html</anchorfile>
      <anchor>a7a4d2e476bb46e16b88f02c992e0b789</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_QosPolicyCountSeq</name>
    <filename>structDDS__QosPolicyCountSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_ReaderDataLifecycleQosPolicy</name>
    <filename>structDDS__ReaderDataLifecycleQosPolicy.html</filename>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>autopurge_nowriter_samples_delay</name>
      <anchorfile>structDDS__ReaderDataLifecycleQosPolicy.html</anchorfile>
      <anchor>ad4a9e2039f3a92097d3d61a42f6b20ef</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>autopurge_disposed_samples_delay</name>
      <anchorfile>structDDS__ReaderDataLifecycleQosPolicy.html</anchorfile>
      <anchor>ae1bc6422ef6e8f868064910ee2d2e252</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_ReceiverPoolQosPolicy</name>
    <filename>structDDS__ReceiverPoolQosPolicy.html</filename>
    <member kind="variable">
      <type>struct DDS_ThreadSettings_t</type>
      <name>thread</name>
      <anchorfile>structDDS__ReceiverPoolQosPolicy.html</anchorfile>
      <anchor>aeaf36614747ac8a779f9a2b1964a4cf4</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>buffer_size</name>
      <anchorfile>structDDS__ReceiverPoolQosPolicy.html</anchorfile>
      <anchor>a11be424886e2df39291539b9bb0fe5d4</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>buffer_alignment</name>
      <anchorfile>structDDS__ReceiverPoolQosPolicy.html</anchorfile>
      <anchor>aa820d4eebcce2da4dfd6cfd4746d64c2</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__ReceiverPoolQosPolicy">DDSReceiverPoolQosModule_usage</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_ReliabilityQosPolicy</name>
    <filename>structDDS__ReliabilityQosPolicy.html</filename>
    <member kind="variable">
      <type>DDS_ReliabilityQosPolicyKind</type>
      <name>kind</name>
      <anchorfile>structDDS__ReliabilityQosPolicy.html</anchorfile>
      <anchor>a94debccb5177400ff7c39a8cb0252c16</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>max_blocking_time</name>
      <anchorfile>structDDS__ReliabilityQosPolicy.html</anchorfile>
      <anchor>afb7c00e8e7734647152883fea621f7e9</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_ReliabilityQosPolicyAcknowledgmentModeKind</type>
      <name>acknowledgment_kind</name>
      <anchorfile>structDDS__ReliabilityQosPolicy.html</anchorfile>
      <anchor>aa56c90c279a6e4f0bcedcdedda9e125e</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__ReliabilityQosPolicy">DDSReliabilityQosModule_usage</docanchor>
    <docanchor file="structDDS__ReliabilityQosPolicy">DDSReliabilityQosModule_compatibility</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_ReliableReaderActivityChangedStatus</name>
    <filename>structDDS__ReliableReaderActivityChangedStatus.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>active_count</name>
      <anchorfile>structDDS__ReliableReaderActivityChangedStatus.html</anchorfile>
      <anchor>a6db43531b7fdb31abb2fd02cdb063a3f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>inactive_count</name>
      <anchorfile>structDDS__ReliableReaderActivityChangedStatus.html</anchorfile>
      <anchor>a90132e85cb704923631bb117a86c03e5</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>active_count_change</name>
      <anchorfile>structDDS__ReliableReaderActivityChangedStatus.html</anchorfile>
      <anchor>a6b834cb11736d3dd8b24fc797f45b9f9</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>inactive_count_change</name>
      <anchorfile>structDDS__ReliableReaderActivityChangedStatus.html</anchorfile>
      <anchor>a89eb6396278944ccf07cdbdf7a6fd631</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_InstanceHandle_t</type>
      <name>last_instance_handle</name>
      <anchorfile>structDDS__ReliableReaderActivityChangedStatus.html</anchorfile>
      <anchor>a79ba425c659abf712a231783cefeb972</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_ReliableWriterCacheChangedStatus</name>
    <filename>structDDS__ReliableWriterCacheChangedStatus.html</filename>
    <member kind="variable">
      <type>struct DDS_ReliableWriterCacheEventCount</type>
      <name>empty_reliable_writer_cache</name>
      <anchorfile>structDDS__ReliableWriterCacheChangedStatus.html</anchorfile>
      <anchor>a36ca38d1a00740be6917aee5524889ed</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_ReliableWriterCacheEventCount</type>
      <name>full_reliable_writer_cache</name>
      <anchorfile>structDDS__ReliableWriterCacheChangedStatus.html</anchorfile>
      <anchor>ac883b076cd3e5cbff2baa0cd9825df2a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_ReliableWriterCacheEventCount</type>
      <name>low_watermark_reliable_writer_cache</name>
      <anchorfile>structDDS__ReliableWriterCacheChangedStatus.html</anchorfile>
      <anchor>a385dbe2cca3d492961ff21c98f3ca524</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_ReliableWriterCacheEventCount</type>
      <name>high_watermark_reliable_writer_cache</name>
      <anchorfile>structDDS__ReliableWriterCacheChangedStatus.html</anchorfile>
      <anchor>ad2701f4274b52177d1ad35af46d21303</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>unacknowledged_sample_count</name>
      <anchorfile>structDDS__ReliableWriterCacheChangedStatus.html</anchorfile>
      <anchor>a738ffbe3d65704b4c6142b8d2b94f828</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>unacknowledged_sample_count_peak</name>
      <anchorfile>structDDS__ReliableWriterCacheChangedStatus.html</anchorfile>
      <anchor>a7222b8f4a5555d8dd6b3a2426e0e9ed0</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_ReliableWriterCacheEventCount</name>
    <filename>structDDS__ReliableWriterCacheEventCount.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>total_count</name>
      <anchorfile>structDDS__ReliableWriterCacheEventCount.html</anchorfile>
      <anchor>a1c45bcfa74814d9fc8117ab9028199e5</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>total_count_change</name>
      <anchorfile>structDDS__ReliableWriterCacheEventCount.html</anchorfile>
      <anchor>a6af3ea4563ae9607d5416bb7e6f0cc3d</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_RequestedDeadlineMissedStatus</name>
    <filename>structDDS__RequestedDeadlineMissedStatus.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>total_count</name>
      <anchorfile>structDDS__RequestedDeadlineMissedStatus.html</anchorfile>
      <anchor>a749931343147237be9c01189a02dece0</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>total_count_change</name>
      <anchorfile>structDDS__RequestedDeadlineMissedStatus.html</anchorfile>
      <anchor>a6dd5f25ade13513e38f4b6be5b21e4be</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_InstanceHandle_t</type>
      <name>last_instance_handle</name>
      <anchorfile>structDDS__RequestedDeadlineMissedStatus.html</anchorfile>
      <anchor>af489a82127383601c82754f9873be03b</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_RequestedIncompatibleQosStatus</name>
    <filename>structDDS__RequestedIncompatibleQosStatus.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>total_count</name>
      <anchorfile>structDDS__RequestedIncompatibleQosStatus.html</anchorfile>
      <anchor>a5e1381230973dff09604e4009114afbc</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>total_count_change</name>
      <anchorfile>structDDS__RequestedIncompatibleQosStatus.html</anchorfile>
      <anchor>a059fbc171075a56b41681385abeb8c31</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_QosPolicyId_t</type>
      <name>last_policy_id</name>
      <anchorfile>structDDS__RequestedIncompatibleQosStatus.html</anchorfile>
      <anchor>a728da2e553b4cc129dfbc401e1e96632</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_QosPolicyCountSeq</type>
      <name>policies</name>
      <anchorfile>structDDS__RequestedIncompatibleQosStatus.html</anchorfile>
      <anchor>a9ba7c07d85905e1c5265b6abdfcdb5a4</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_ResourceLimitsQosPolicy</name>
    <filename>structDDS__ResourceLimitsQosPolicy.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_samples</name>
      <anchorfile>structDDS__ResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a90db906a3958146c5e22557db648e7ff</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_instances</name>
      <anchorfile>structDDS__ResourceLimitsQosPolicy.html</anchorfile>
      <anchor>ab7339605f314f50c7cb658426ff64cdb</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_samples_per_instance</name>
      <anchorfile>structDDS__ResourceLimitsQosPolicy.html</anchorfile>
      <anchor>ae3d9339bebf4c7163cf6dff82882cbef</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>initial_samples</name>
      <anchorfile>structDDS__ResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a5eba0c723bc2aa90e35193570d7c893a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>initial_instances</name>
      <anchorfile>structDDS__ResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a2ac70a8bc7617cefcbfa2a855e1c51f3</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>instance_hash_buckets</name>
      <anchorfile>structDDS__ResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a34d65b3472d12b85c307134f9c1bf5d3</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__ResourceLimitsQosPolicy">DDSResourceLimitsQosModule_usage</docanchor>
    <docanchor file="structDDS__ResourceLimitsQosPolicy">DDSResourceLimitsQosModule_consistency</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_RtpsReliableReaderProtocol_t</name>
    <filename>structDDS__RtpsReliableReaderProtocol__t.html</filename>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>min_heartbeat_response_delay</name>
      <anchorfile>structDDS__RtpsReliableReaderProtocol__t.html</anchorfile>
      <anchor>ab4d96a016eefca4dcd8ce001e03f7a90</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>max_heartbeat_response_delay</name>
      <anchorfile>structDDS__RtpsReliableReaderProtocol__t.html</anchorfile>
      <anchor>aafc2e6ec3a3c039e88355c683a7a622e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>heartbeat_suppression_duration</name>
      <anchorfile>structDDS__RtpsReliableReaderProtocol__t.html</anchorfile>
      <anchor>a5fae078d8236e53962649d860087cd6b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>nack_period</name>
      <anchorfile>structDDS__RtpsReliableReaderProtocol__t.html</anchorfile>
      <anchor>a9c299ef4fe921b91a7bdedadcd38c2a8</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>receive_window_size</name>
      <anchorfile>structDDS__RtpsReliableReaderProtocol__t.html</anchorfile>
      <anchor>aa33820f31d05477329cade249b50c8d0</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>round_trip_time</name>
      <anchorfile>structDDS__RtpsReliableReaderProtocol__t.html</anchorfile>
      <anchor>a94e7f68d46c1f0fa2805fd21be8c505b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>app_ack_period</name>
      <anchorfile>structDDS__RtpsReliableReaderProtocol__t.html</anchorfile>
      <anchor>a9c87af40207de4455bdaddf7789b956b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>samples_per_app_ack</name>
      <anchorfile>structDDS__RtpsReliableReaderProtocol__t.html</anchorfile>
      <anchor>acd2d05d1562c1adf755fbb1eccb6b62b</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_RtpsReliableWriterProtocol_t</name>
    <filename>structDDS__RtpsReliableWriterProtocol__t.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>low_watermark</name>
      <anchorfile>structDDS__RtpsReliableWriterProtocol__t.html</anchorfile>
      <anchor>ab603712e435cc4369366afa770700b80</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>high_watermark</name>
      <anchorfile>structDDS__RtpsReliableWriterProtocol__t.html</anchorfile>
      <anchor>a7dc8a8bb8168a5acc3041f8970e95665</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>heartbeat_period</name>
      <anchorfile>structDDS__RtpsReliableWriterProtocol__t.html</anchorfile>
      <anchor>a47229dfbfde987f8bbebe67e789e0908</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>fast_heartbeat_period</name>
      <anchorfile>structDDS__RtpsReliableWriterProtocol__t.html</anchorfile>
      <anchor>a0a0198e6baba89dfa5231950814f2a8f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>late_joiner_heartbeat_period</name>
      <anchorfile>structDDS__RtpsReliableWriterProtocol__t.html</anchorfile>
      <anchor>a26a476a46b1b4f03171c12c0e4ef784d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>virtual_heartbeat_period</name>
      <anchorfile>structDDS__RtpsReliableWriterProtocol__t.html</anchorfile>
      <anchor>a86cca4ae688897f712260e830a9127ed</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>samples_per_virtual_heartbeat</name>
      <anchorfile>structDDS__RtpsReliableWriterProtocol__t.html</anchorfile>
      <anchor>a2692a857d018a3543ffc513631f219ba</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_heartbeat_retries</name>
      <anchorfile>structDDS__RtpsReliableWriterProtocol__t.html</anchorfile>
      <anchor>a5be67d978618b5995cb517b51231d39d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>inactivate_nonprogressing_readers</name>
      <anchorfile>structDDS__RtpsReliableWriterProtocol__t.html</anchorfile>
      <anchor>a0b7adb7146cac9e462b9ffe65dd557cc</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>heartbeats_per_max_samples</name>
      <anchorfile>structDDS__RtpsReliableWriterProtocol__t.html</anchorfile>
      <anchor>a9dd9360fe1f9c8a7f251576c8878a139</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>min_nack_response_delay</name>
      <anchorfile>structDDS__RtpsReliableWriterProtocol__t.html</anchorfile>
      <anchor>a7a95278d5204acf040ec49a6348ada46</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>max_nack_response_delay</name>
      <anchorfile>structDDS__RtpsReliableWriterProtocol__t.html</anchorfile>
      <anchor>afad848d4636d4c72de4e3b08deddce1e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>nack_suppression_duration</name>
      <anchorfile>structDDS__RtpsReliableWriterProtocol__t.html</anchorfile>
      <anchor>a57a6534419a7d0f53714dc88694f2b09</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_bytes_per_nack_response</name>
      <anchorfile>structDDS__RtpsReliableWriterProtocol__t.html</anchorfile>
      <anchor>a13a5686ae6a9b77271bacc39c4d8e80a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>disable_positive_acks_min_sample_keep_duration</name>
      <anchorfile>structDDS__RtpsReliableWriterProtocol__t.html</anchorfile>
      <anchor>ad659354923989e244b61fbb67461b578</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>disable_positive_acks_max_sample_keep_duration</name>
      <anchorfile>structDDS__RtpsReliableWriterProtocol__t.html</anchorfile>
      <anchor>ac14a89d1a5ac916982b0966b48fc38f9</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>disable_positive_acks_enable_adaptive_sample_keep_duration</name>
      <anchorfile>structDDS__RtpsReliableWriterProtocol__t.html</anchorfile>
      <anchor>a31c48f82088f918774d67d2b045629b0</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>disable_positive_acks_decrease_sample_keep_duration_factor</name>
      <anchorfile>structDDS__RtpsReliableWriterProtocol__t.html</anchorfile>
      <anchor>a2ebabf07c0eef5ecd3a24dfa177cf547</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>disable_positive_acks_increase_sample_keep_duration_factor</name>
      <anchorfile>structDDS__RtpsReliableWriterProtocol__t.html</anchorfile>
      <anchor>a3d73821b40894e0d511c29df94bc1443</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>min_send_window_size</name>
      <anchorfile>structDDS__RtpsReliableWriterProtocol__t.html</anchorfile>
      <anchor>a20be408ce0f25d4631d637e982213d02</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_send_window_size</name>
      <anchorfile>structDDS__RtpsReliableWriterProtocol__t.html</anchorfile>
      <anchor>a20f5ce40d2c1f5f9c1ab6673d911b0f4</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>send_window_update_period</name>
      <anchorfile>structDDS__RtpsReliableWriterProtocol__t.html</anchorfile>
      <anchor>a98e1f6a9e5da6b9c1ffc43a2925d8ffb</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>send_window_increase_factor</name>
      <anchorfile>structDDS__RtpsReliableWriterProtocol__t.html</anchorfile>
      <anchor>a62cd20d9f29e43c3c56f6411cce8b892</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>send_window_decrease_factor</name>
      <anchorfile>structDDS__RtpsReliableWriterProtocol__t.html</anchorfile>
      <anchor>a544f473d40ccf6bcb7735873c984876c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>enable_multicast_periodic_heartbeat</name>
      <anchorfile>structDDS__RtpsReliableWriterProtocol__t.html</anchorfile>
      <anchor>a44046033c98a930c6ab24e4e95af0fa9</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>multicast_resend_threshold</name>
      <anchorfile>structDDS__RtpsReliableWriterProtocol__t.html</anchorfile>
      <anchor>adc5f7500501c036f47c51775529fa3ba</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_RtpsWellKnownPorts_t</name>
    <filename>structDDS__RtpsWellKnownPorts__t.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>port_base</name>
      <anchorfile>structDDS__RtpsWellKnownPorts__t.html</anchorfile>
      <anchor>a3cdc6b5af83651bd7ceb85ba287245f6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>domain_id_gain</name>
      <anchorfile>structDDS__RtpsWellKnownPorts__t.html</anchorfile>
      <anchor>a4b30df9393d72e3a51b5ba8c477750ac</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>participant_id_gain</name>
      <anchorfile>structDDS__RtpsWellKnownPorts__t.html</anchorfile>
      <anchor>a526613772db4f73a8971fbc5325d05c6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>builtin_multicast_port_offset</name>
      <anchorfile>structDDS__RtpsWellKnownPorts__t.html</anchorfile>
      <anchor>a33eb1858a19e2c6e8b848ecdaef9846b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>builtin_unicast_port_offset</name>
      <anchorfile>structDDS__RtpsWellKnownPorts__t.html</anchorfile>
      <anchor>ac6500418371a10482458fac038e7f013</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>user_multicast_port_offset</name>
      <anchorfile>structDDS__RtpsWellKnownPorts__t.html</anchorfile>
      <anchor>a7413f09c3d396779f371462c597fca15</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>user_unicast_port_offset</name>
      <anchorfile>structDDS__RtpsWellKnownPorts__t.html</anchorfile>
      <anchor>a0c39f79bc838510fe0ebaf443b25091e</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_SampleIdentity_t</name>
    <filename>structDDS__SampleIdentity__t.html</filename>
    <member kind="variable">
      <type>struct DDS_GUID_t</type>
      <name>writer_guid</name>
      <anchorfile>group__DDSWriteParamsModule.html</anchorfile>
      <anchor>ga541fc431fa4eb3472e1d5ed3588691ff</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SequenceNumber_t</type>
      <name>sequence_number</name>
      <anchorfile>group__DDSWriteParamsModule.html</anchorfile>
      <anchor>gab784a7f40efde9c165e60d94c49309a8</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_SampleInfo</name>
    <filename>structDDS__SampleInfo.html</filename>
    <member kind="variable">
      <type>DDS_SampleStateKind</type>
      <name>sample_state</name>
      <anchorfile>structDDS__SampleInfo.html</anchorfile>
      <anchor>adfe9c2c74b14f914e5b7da022b07cb86</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_ViewStateKind</type>
      <name>view_state</name>
      <anchorfile>structDDS__SampleInfo.html</anchorfile>
      <anchor>a99c0b7558c3ebcc94ee9d2b5b7129243</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_InstanceStateKind</type>
      <name>instance_state</name>
      <anchorfile>structDDS__SampleInfo.html</anchorfile>
      <anchor>af09b886ca0145a110b58440d455b7eae</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Time_t</type>
      <name>source_timestamp</name>
      <anchorfile>structDDS__SampleInfo.html</anchorfile>
      <anchor>a70566edcc3c48c0d7ee42962ffb81150</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_InstanceHandle_t</type>
      <name>instance_handle</name>
      <anchorfile>structDDS__SampleInfo.html</anchorfile>
      <anchor>a38bca53647cd2be8c1dff9054126f360</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_InstanceHandle_t</type>
      <name>publication_handle</name>
      <anchorfile>structDDS__SampleInfo.html</anchorfile>
      <anchor>a596e409a28afd612c83f2b4964ac4e76</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>disposed_generation_count</name>
      <anchorfile>structDDS__SampleInfo.html</anchorfile>
      <anchor>a2f6c5cc3397d45930946b5b106eed5f6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>no_writers_generation_count</name>
      <anchorfile>structDDS__SampleInfo.html</anchorfile>
      <anchor>a6e57e6e1c9f6e9651f219b03d9c4738b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>sample_rank</name>
      <anchorfile>structDDS__SampleInfo.html</anchorfile>
      <anchor>a25fb02a443a66d8724867e361bd7ce0d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>generation_rank</name>
      <anchorfile>structDDS__SampleInfo.html</anchorfile>
      <anchor>aeef636d7b85d492aeea87c051d414c8e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>absolute_generation_rank</name>
      <anchorfile>structDDS__SampleInfo.html</anchorfile>
      <anchor>ab6e1f85729e3f21317860c98e04cb3bf</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>valid_data</name>
      <anchorfile>structDDS__SampleInfo.html</anchorfile>
      <anchor>aa0c5177864ed1aeeb85544fee45904da</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Time_t</type>
      <name>reception_timestamp</name>
      <anchorfile>structDDS__SampleInfo.html</anchorfile>
      <anchor>aae99d28717a46008a5bcb7d6319b771f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SequenceNumber_t</type>
      <name>publication_sequence_number</name>
      <anchorfile>structDDS__SampleInfo.html</anchorfile>
      <anchor>a81fffe4da7837199659ed3658bc4d937</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SequenceNumber_t</type>
      <name>reception_sequence_number</name>
      <anchorfile>structDDS__SampleInfo.html</anchorfile>
      <anchor>a13f3d471f52fd39d1b9952d3174be19f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_GUID_t</type>
      <name>original_publication_virtual_guid</name>
      <anchorfile>structDDS__SampleInfo.html</anchorfile>
      <anchor>a8e4c5fb97deba9c0f9a398d8df41e0fa</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SequenceNumber_t</type>
      <name>original_publication_virtual_sequence_number</name>
      <anchorfile>structDDS__SampleInfo.html</anchorfile>
      <anchor>a757e8ac8aad20e9535e443e6c236d3e1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_GUID_t</type>
      <name>related_original_publication_virtual_guid</name>
      <anchorfile>structDDS__SampleInfo.html</anchorfile>
      <anchor>a851c866c4e30762fef890654bc03113d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SequenceNumber_t</type>
      <name>related_original_publication_virtual_sequence_number</name>
      <anchorfile>structDDS__SampleInfo.html</anchorfile>
      <anchor>a5624cffcfd293588d59d6a76eceb9ad5</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__SampleInfo">Interpretation_SampleInfo</docanchor>
    <docanchor file="structDDS__SampleInfo">Interpretation_generation_count</docanchor>
    <docanchor file="structDDS__SampleInfo">Interpretation_rank</docanchor>
    <docanchor file="structDDS__SampleInfo">Interpretation_counters_ranks</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_SampleInfoSeq</name>
    <filename>structDDS__SampleInfoSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_SampleLostStatus</name>
    <filename>structDDS__SampleLostStatus.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>total_count</name>
      <anchorfile>structDDS__SampleLostStatus.html</anchorfile>
      <anchor>a43052fd273fe98fdc508b728469e822f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>total_count_change</name>
      <anchorfile>structDDS__SampleLostStatus.html</anchorfile>
      <anchor>af0737bd3744cb5e1021a431ec04b52f4</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_SampleLostStatusKind</type>
      <name>last_reason</name>
      <anchorfile>structDDS__SampleLostStatus.html</anchorfile>
      <anchor>ad21c353ebef7723adbf01e1d0fde890a</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_SampleRejectedStatus</name>
    <filename>structDDS__SampleRejectedStatus.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>total_count</name>
      <anchorfile>structDDS__SampleRejectedStatus.html</anchorfile>
      <anchor>a58bd6450fcdeb191ee38e2cf0b365ab4</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>total_count_change</name>
      <anchorfile>structDDS__SampleRejectedStatus.html</anchorfile>
      <anchor>a747f4af3354e62f0319a0fee1f9bf54f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_SampleRejectedStatusKind</type>
      <name>last_reason</name>
      <anchorfile>structDDS__SampleRejectedStatus.html</anchorfile>
      <anchor>a930005a07242fa12a57d4987d318340d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_InstanceHandle_t</type>
      <name>last_instance_handle</name>
      <anchorfile>structDDS__SampleRejectedStatus.html</anchorfile>
      <anchor>a3429f50361863c76cbf746c10808c016</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_SequenceNumber_t</name>
    <filename>structDDS__SequenceNumber__t.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>high</name>
      <anchorfile>structDDS__SequenceNumber__t.html</anchorfile>
      <anchor>a297641f04b0922146eb19a081699941d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_UnsignedLong</type>
      <name>low</name>
      <anchorfile>structDDS__SequenceNumber__t.html</anchorfile>
      <anchor>a5a5d03c1c000db23622583d2070e4b6d</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_ShortSeq</name>
    <filename>structDDS__ShortSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_StringSeq</name>
    <filename>structDDS__StringSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_StringTypeSupport</name>
    <filename>structDDS__StringTypeSupport.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_StructMember</name>
    <filename>structDDS__StructMember.html</filename>
    <member kind="variable">
      <type>char *</type>
      <name>name</name>
      <anchorfile>structDDS__StructMember.html</anchorfile>
      <anchor>a41be098fb181055b8823b79169a52e15</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const DDS_TypeCode *</type>
      <name>type</name>
      <anchorfile>structDDS__StructMember.html</anchorfile>
      <anchor>a694e5150f9adc88b81ae0385910a59f7</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>is_pointer</name>
      <anchorfile>structDDS__StructMember.html</anchorfile>
      <anchor>a587e0680067e02a10c0b3f1230022889</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Short</type>
      <name>bits</name>
      <anchorfile>structDDS__StructMember.html</anchorfile>
      <anchor>a3ac5d3bde358e53bc844f9cf8b6380d3</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>is_key</name>
      <anchorfile>structDDS__StructMember.html</anchorfile>
      <anchor>a243a40a0951f4e24cfdf35e7db129c33</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>id</name>
      <anchorfile>structDDS__StructMember.html</anchorfile>
      <anchor>acf2a241f2c43bbaa764ae2b4dda4c033</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>is_optional</name>
      <anchorfile>structDDS__StructMember.html</anchorfile>
      <anchor>a2da3cffca27bb6730ba31fc80878b5d9</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_StructMemberSeq</name>
    <filename>structDDS__StructMemberSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_SubscriberListener</name>
    <filename>structDDS__SubscriberListener.html</filename>
    <member kind="variable">
      <type>struct DDS_DataReaderListener</type>
      <name>as_datareaderlistener</name>
      <anchorfile>structDDS__SubscriberListener.html</anchorfile>
      <anchor>a91bcffc897f0ccbe142aae1db7763e32</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_SubscriberListener_DataOnReadersCallback</type>
      <name>on_data_on_readers</name>
      <anchorfile>structDDS__SubscriberListener.html</anchorfile>
      <anchor>aabe8a833072b1fa621295e35ec2151f4</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_SubscriberQos</name>
    <filename>structDDS__SubscriberQos.html</filename>
    <member kind="variable">
      <type>struct DDS_PresentationQosPolicy</type>
      <name>presentation</name>
      <anchorfile>structDDS__SubscriberQos.html</anchorfile>
      <anchor>ab282433860a1971397e4583941bd4812</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_PartitionQosPolicy</type>
      <name>partition</name>
      <anchorfile>structDDS__SubscriberQos.html</anchorfile>
      <anchor>a5aff8656c5f0ce9a114cb08eb9137d6e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_GroupDataQosPolicy</type>
      <name>group_data</name>
      <anchorfile>structDDS__SubscriberQos.html</anchorfile>
      <anchor>ae315947ac7e283c47db93359bce4209b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_EntityFactoryQosPolicy</type>
      <name>entity_factory</name>
      <anchorfile>structDDS__SubscriberQos.html</anchorfile>
      <anchor>a5b0e4b5eccb7b96354b2c61b1ea1fcdb</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_ExclusiveAreaQosPolicy</type>
      <name>exclusive_area</name>
      <anchorfile>structDDS__SubscriberQos.html</anchorfile>
      <anchor>ac1ddef02a55d6635bfb43d07318d7a55</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_EntityNameQosPolicy</type>
      <name>subscriber_name</name>
      <anchorfile>structDDS__SubscriberQos.html</anchorfile>
      <anchor>a1eed731765cd5e173a7188f6d42fc68b</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_SubscriberSeq</name>
    <filename>structDDS__SubscriberSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_SubscriptionBuiltinTopicData</name>
    <filename>structDDS__SubscriptionBuiltinTopicData.html</filename>
    <member kind="variable">
      <type>DDS_BuiltinTopicKey_t</type>
      <name>key</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>a829b79fa1e5e47f1674ed2f8f185b822</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_BuiltinTopicKey_t</type>
      <name>participant_key</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>a97024e2fde388e76064f675b27c37d1c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>topic_name</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>a0efa9df748625b49236c97b2a3d931a7</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>type_name</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>a55f18ae15068f9cd4a00d9b1d76f7280</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DurabilityQosPolicy</type>
      <name>durability</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>a54e08da9c9a243553008d6639840fb9d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DeadlineQosPolicy</type>
      <name>deadline</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>a596c3889d7832089acfc6bc993933294</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_LatencyBudgetQosPolicy</type>
      <name>latency_budget</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>a287fcbce93a86d3d4eab693fc0a62341</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_LivelinessQosPolicy</type>
      <name>liveliness</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>a713277aec1eed944de33226f92f24460</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_ReliabilityQosPolicy</type>
      <name>reliability</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>a84ad8f24bfc84563082e5708b15d5103</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_OwnershipQosPolicy</type>
      <name>ownership</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>a2474a9d4c4668abad2b408fea10e3fed</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DestinationOrderQosPolicy</type>
      <name>destination_order</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>a7e371141c97ca6dd30c4bec75263554f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_UserDataQosPolicy</type>
      <name>user_data</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>ad18ba165bfc8e733aaec2ff0c57d6d40</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_TimeBasedFilterQosPolicy</type>
      <name>time_based_filter</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>a73bdc0aed1c4d8c17793d199d6dcba06</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_PresentationQosPolicy</type>
      <name>presentation</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>aa088b37585057d548739d168989a06d4</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_PartitionQosPolicy</type>
      <name>partition</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>a424ff83753397bb5be1149947e9c9931</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_TopicDataQosPolicy</type>
      <name>topic_data</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>a61213decf9e41ddcbc853d7575f7d623</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_GroupDataQosPolicy</type>
      <name>group_data</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>ae9d9f7b777d8621b6f09354f47fb9f7d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_TypeConsistencyEnforcementQosPolicy</type>
      <name>type_consistency</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>ac975a385763c3635c4b264bc9aedec51</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_TypeCode *</type>
      <name>type_code</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>aca7583fbd453efdf223d9238d93df684</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_BuiltinTopicKey_t</type>
      <name>subscriber_key</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>ad86fd3da1c24c88c77f56586db060948</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_PropertyQosPolicy</type>
      <name>property</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>a4236a321a86446dcd6a0d23ca3ef6901</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_LocatorSeq</type>
      <name>unicast_locators</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>afedd7b4a3cbe5d3117dd185e59d45b11</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_LocatorSeq</type>
      <name>multicast_locators</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>a65447c6fc1d3221756620cd1014f3b8c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_ContentFilterProperty_t</type>
      <name>content_filter_property</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>a55110c4e020e450a3d050526d6bf9f49</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_GUID_t</type>
      <name>virtual_guid</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>a1f148fbebdb22c35c43714ebf1d310ee</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_ProtocolVersion_t</type>
      <name>rtps_protocol_version</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>a2028417d0c61bd7a6f3e83abeff7b786</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_VendorId_t</type>
      <name>rtps_vendor_id</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>a5fac724af6421da23b5f931894dce9a2</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_ProductVersion_t</type>
      <name>product_version</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>a0dc700468688583d8eff6490a35c43e6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>disable_positive_acks</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>a16ff35812effdfa1d235b70120205618</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_EntityNameQosPolicy</type>
      <name>subscription_name</name>
      <anchorfile>structDDS__SubscriptionBuiltinTopicData.html</anchorfile>
      <anchor>ad783802b0ede75a1cdb0c814e8f29d53</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_SubscriptionBuiltinTopicDataSeq</name>
    <filename>structDDS__SubscriptionBuiltinTopicDataSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_SubscriptionBuiltinTopicDataTypeSupport</name>
    <filename>structDDS__SubscriptionBuiltinTopicDataTypeSupport.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_SubscriptionMatchedStatus</name>
    <filename>structDDS__SubscriptionMatchedStatus.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>total_count</name>
      <anchorfile>structDDS__SubscriptionMatchedStatus.html</anchorfile>
      <anchor>a8e10280adf89dfe5bc7a68865a33463d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>total_count_change</name>
      <anchorfile>structDDS__SubscriptionMatchedStatus.html</anchorfile>
      <anchor>ada65f66c8299f83bf27e25b11e095f17</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>current_count</name>
      <anchorfile>structDDS__SubscriptionMatchedStatus.html</anchorfile>
      <anchor>a122d93087f163acf05228e72c7205a12</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>current_count_peak</name>
      <anchorfile>structDDS__SubscriptionMatchedStatus.html</anchorfile>
      <anchor>a146595d1d23043741215d67a5d1779bb</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>current_count_change</name>
      <anchorfile>structDDS__SubscriptionMatchedStatus.html</anchorfile>
      <anchor>a9e107e1857634eb3eafa4c7a5c1b98df</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_InstanceHandle_t</type>
      <name>last_publication_handle</name>
      <anchorfile>structDDS__SubscriptionMatchedStatus.html</anchorfile>
      <anchor>a86f6ab482b31e9404ac762dde237af68</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_SystemResourceLimitsQosPolicy</name>
    <filename>structDDS__SystemResourceLimitsQosPolicy.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>max_objects_per_thread</name>
      <anchorfile>structDDS__SystemResourceLimitsQosPolicy.html</anchorfile>
      <anchor>a8cc7def6d9695b336791b8da4977a945</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__SystemResourceLimitsQosPolicy">DDSSystemResourceLimitsQosModule_usage</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_ThreadSettings_t</name>
    <filename>structDDS__ThreadSettings__t.html</filename>
    <member kind="variable">
      <type>DDS_ThreadSettingsKindMask</type>
      <name>mask</name>
      <anchorfile>structDDS__ThreadSettings__t.html</anchorfile>
      <anchor>a483d77e2188ccb9a100201bd960842dc</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>priority</name>
      <anchorfile>structDDS__ThreadSettings__t.html</anchorfile>
      <anchor>a65ec707818aa40c06aaece6cade73f19</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>stack_size</name>
      <anchorfile>structDDS__ThreadSettings__t.html</anchorfile>
      <anchor>a5ca8243de9aac338350f77d3742ec438</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_LongSeq</type>
      <name>cpu_list</name>
      <anchorfile>structDDS__ThreadSettings__t.html</anchorfile>
      <anchor>a5cdd01d0622676a8f0dfa45fd763abd9</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_ThreadSettingsCpuRotationKind</type>
      <name>cpu_rotation</name>
      <anchorfile>structDDS__ThreadSettings__t.html</anchorfile>
      <anchor>aebad0d098ac0f0d571be0f81ae484f4c</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_Time_t</name>
    <filename>structDDS__Time__t.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>sec</name>
      <anchorfile>structDDS__Time__t.html</anchorfile>
      <anchor>a53f0f709937e87105dd88bcf124876c2</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_UnsignedLong</type>
      <name>nanosec</name>
      <anchorfile>structDDS__Time__t.html</anchorfile>
      <anchor>aeefbede0d9976cbcdce3c7499df4b548</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_TimeBasedFilterQosPolicy</name>
    <filename>structDDS__TimeBasedFilterQosPolicy.html</filename>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>minimum_separation</name>
      <anchorfile>structDDS__TimeBasedFilterQosPolicy.html</anchorfile>
      <anchor>a08ec0ede666c060913e4204434da6373</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__TimeBasedFilterQosPolicy">DDSTimeBasedFilterQosModule_usage</docanchor>
    <docanchor file="structDDS__TimeBasedFilterQosPolicy">DDSTimebasedFilterQosModule_consistency</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_TopicBuiltinTopicData</name>
    <filename>structDDS__TopicBuiltinTopicData.html</filename>
    <member kind="variable">
      <type>DDS_BuiltinTopicKey_t</type>
      <name>key</name>
      <anchorfile>structDDS__TopicBuiltinTopicData.html</anchorfile>
      <anchor>a5abde366f4086a89951ed0ad41ec3552</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>name</name>
      <anchorfile>structDDS__TopicBuiltinTopicData.html</anchorfile>
      <anchor>a74cf7cf7526cff0539496451fd54a659</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>type_name</name>
      <anchorfile>structDDS__TopicBuiltinTopicData.html</anchorfile>
      <anchor>a1e46c19727f4b7985b2ec65adcefe694</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DurabilityQosPolicy</type>
      <name>durability</name>
      <anchorfile>structDDS__TopicBuiltinTopicData.html</anchorfile>
      <anchor>a9590398b53a0e349184217225b80694b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DurabilityServiceQosPolicy</type>
      <name>durability_service</name>
      <anchorfile>structDDS__TopicBuiltinTopicData.html</anchorfile>
      <anchor>a3ea8e077741a733da8f6e199f8b6e263</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DeadlineQosPolicy</type>
      <name>deadline</name>
      <anchorfile>structDDS__TopicBuiltinTopicData.html</anchorfile>
      <anchor>ab3f3526b01c57be995cfaf801a6a56c2</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_LatencyBudgetQosPolicy</type>
      <name>latency_budget</name>
      <anchorfile>structDDS__TopicBuiltinTopicData.html</anchorfile>
      <anchor>aa174050d3fc177e6acf966c0e9b40046</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_LivelinessQosPolicy</type>
      <name>liveliness</name>
      <anchorfile>structDDS__TopicBuiltinTopicData.html</anchorfile>
      <anchor>a9adf8f9e9ded8660c2f3873db134579b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_ReliabilityQosPolicy</type>
      <name>reliability</name>
      <anchorfile>structDDS__TopicBuiltinTopicData.html</anchorfile>
      <anchor>a648d9a9811749df5c89f67dfa5a30acc</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_TransportPriorityQosPolicy</type>
      <name>transport_priority</name>
      <anchorfile>structDDS__TopicBuiltinTopicData.html</anchorfile>
      <anchor>a5ae66aea565c093cf83f039e687e22cf</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_LifespanQosPolicy</type>
      <name>lifespan</name>
      <anchorfile>structDDS__TopicBuiltinTopicData.html</anchorfile>
      <anchor>af7daf3aac91016a4535e603c063be9a8</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DestinationOrderQosPolicy</type>
      <name>destination_order</name>
      <anchorfile>structDDS__TopicBuiltinTopicData.html</anchorfile>
      <anchor>a1a7faa729c73863f14b900ae484e7575</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_HistoryQosPolicy</type>
      <name>history</name>
      <anchorfile>structDDS__TopicBuiltinTopicData.html</anchorfile>
      <anchor>a5dacfe3ecd42be8b3ed0976fa09a12d0</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_ResourceLimitsQosPolicy</type>
      <name>resource_limits</name>
      <anchorfile>structDDS__TopicBuiltinTopicData.html</anchorfile>
      <anchor>ae8ffb3a3aa03686dd2ae074c001fc149</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_OwnershipQosPolicy</type>
      <name>ownership</name>
      <anchorfile>structDDS__TopicBuiltinTopicData.html</anchorfile>
      <anchor>afa56dc550f8ccf285a06e41e4a60c377</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_TopicDataQosPolicy</type>
      <name>topic_data</name>
      <anchorfile>structDDS__TopicBuiltinTopicData.html</anchorfile>
      <anchor>ad3de82020310c1d0ee09a78aca7385d0</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_TopicBuiltinTopicDataSeq</name>
    <filename>structDDS__TopicBuiltinTopicDataSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_TopicBuiltinTopicDataTypeSupport</name>
    <filename>structDDS__TopicBuiltinTopicDataTypeSupport.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_TopicDataQosPolicy</name>
    <filename>structDDS__TopicDataQosPolicy.html</filename>
    <member kind="variable">
      <type>struct DDS_OctetSeq</type>
      <name>value</name>
      <anchorfile>structDDS__TopicDataQosPolicy.html</anchorfile>
      <anchor>a31a1702817a6e128bdeff3d08368e23f</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__TopicDataQosPolicy">DDSTopicDataQosModule_usage</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_TopicListener</name>
    <filename>structDDS__TopicListener.html</filename>
    <member kind="variable">
      <type>struct DDS_Listener</type>
      <name>as_listener</name>
      <anchorfile>structDDS__TopicListener.html</anchorfile>
      <anchor>a91c7df496e25c48bf39bd31f8ce3cbce</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_TopicListener_InconsistentTopicCallback</type>
      <name>on_inconsistent_topic</name>
      <anchorfile>structDDS__TopicListener.html</anchorfile>
      <anchor>a49929c5787daed35b1dfb05756c8e4af</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_TopicQos</name>
    <filename>structDDS__TopicQos.html</filename>
    <member kind="variable">
      <type>struct DDS_TopicDataQosPolicy</type>
      <name>topic_data</name>
      <anchorfile>structDDS__TopicQos.html</anchorfile>
      <anchor>ae96efe2b9e5f06e16b37c2b6b8b4df4e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DurabilityQosPolicy</type>
      <name>durability</name>
      <anchorfile>structDDS__TopicQos.html</anchorfile>
      <anchor>ad814f17ad9f08d3aa2318f2806b27cae</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DurabilityServiceQosPolicy</type>
      <name>durability_service</name>
      <anchorfile>structDDS__TopicQos.html</anchorfile>
      <anchor>ae5ff9cbf0353da6e6e2e9f72b0e9c001</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DeadlineQosPolicy</type>
      <name>deadline</name>
      <anchorfile>structDDS__TopicQos.html</anchorfile>
      <anchor>af8df396008572c1739ef6f6c7e92d03c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_LatencyBudgetQosPolicy</type>
      <name>latency_budget</name>
      <anchorfile>structDDS__TopicQos.html</anchorfile>
      <anchor>a6e3c7ef1901697d638edd2e85ee6397e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_LivelinessQosPolicy</type>
      <name>liveliness</name>
      <anchorfile>structDDS__TopicQos.html</anchorfile>
      <anchor>a02d082bc03756feb579e32cfa6a8efc5</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_ReliabilityQosPolicy</type>
      <name>reliability</name>
      <anchorfile>structDDS__TopicQos.html</anchorfile>
      <anchor>a0f0dffd5eb61bcfee7218ded1c51640c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DestinationOrderQosPolicy</type>
      <name>destination_order</name>
      <anchorfile>structDDS__TopicQos.html</anchorfile>
      <anchor>afd29d64f9705bad683f450195d31ba50</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_HistoryQosPolicy</type>
      <name>history</name>
      <anchorfile>structDDS__TopicQos.html</anchorfile>
      <anchor>a38517796c42c6d9dad32646e03588e9b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_ResourceLimitsQosPolicy</type>
      <name>resource_limits</name>
      <anchorfile>structDDS__TopicQos.html</anchorfile>
      <anchor>aee3b485f1e39518f6208cadcd9cbf4e5</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_TransportPriorityQosPolicy</type>
      <name>transport_priority</name>
      <anchorfile>structDDS__TopicQos.html</anchorfile>
      <anchor>a7188c1de5f77667af8a8f328e7b268ac</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_LifespanQosPolicy</type>
      <name>lifespan</name>
      <anchorfile>structDDS__TopicQos.html</anchorfile>
      <anchor>a5bece1370f2795cdebf46f764b5b5fc2</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_OwnershipQosPolicy</type>
      <name>ownership</name>
      <anchorfile>structDDS__TopicQos.html</anchorfile>
      <anchor>a4f7303da46443dc750ea755397731444</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_TransportBuiltinQosPolicy</name>
    <filename>structDDS__TransportBuiltinQosPolicy.html</filename>
    <member kind="variable">
      <type>DDS_TransportBuiltinKindMask</type>
      <name>mask</name>
      <anchorfile>structDDS__TransportBuiltinQosPolicy.html</anchorfile>
      <anchor>aa9c4ce4fb32311fd42ea80b07643d13c</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_TransportInfo_t</name>
    <filename>structDDS__TransportInfo__t.html</filename>
    <member kind="variable">
      <type>NDDS_Transport_ClassId_t</type>
      <name>class_id</name>
      <anchorfile>structDDS__TransportInfo__t.html</anchorfile>
      <anchor>aa30b46d08131cc45d869bde0ea1119a9</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>message_size_max</name>
      <anchorfile>structDDS__TransportInfo__t.html</anchorfile>
      <anchor>aa5d428fc3773cd8890828813a5c57eb7</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_TransportInfoSeq</name>
    <filename>structDDS__TransportInfoSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_TransportMulticastMapping_t</name>
    <filename>structDDS__TransportMulticastMapping__t.html</filename>
    <member kind="variable">
      <type>char *</type>
      <name>addresses</name>
      <anchorfile>structDDS__TransportMulticastMapping__t.html</anchorfile>
      <anchor>a2248773f1776fc59c72cd53ca4f8403d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>topic_expression</name>
      <anchorfile>structDDS__TransportMulticastMapping__t.html</anchorfile>
      <anchor>a15f1d05bf35b2ddc50f552ae8caf2519</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_TransportMulticastMappingFunction_t</type>
      <name>mapping_function</name>
      <anchorfile>structDDS__TransportMulticastMapping__t.html</anchorfile>
      <anchor>a1dfc43719d4ecb2a21633631a7ac576f</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_TransportMulticastMappingFunction_t</name>
    <filename>structDDS__TransportMulticastMappingFunction__t.html</filename>
    <member kind="variable">
      <type>char *</type>
      <name>dll</name>
      <anchorfile>structDDS__TransportMulticastMappingFunction__t.html</anchorfile>
      <anchor>a4fb7b404c6f915f110bfb7306e7231b7</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>function_name</name>
      <anchorfile>structDDS__TransportMulticastMappingFunction__t.html</anchorfile>
      <anchor>a7b99726a193bac1d84dfec4478194e83</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_TransportMulticastMappingQosPolicy</name>
    <filename>structDDS__TransportMulticastMappingQosPolicy.html</filename>
    <member kind="variable">
      <type>struct DDS_TransportMulticastMappingSeq</type>
      <name>value</name>
      <anchorfile>structDDS__TransportMulticastMappingQosPolicy.html</anchorfile>
      <anchor>ac1d75524c4e1e3d3c53a813bf37cc4ce</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_TransportMulticastMappingSeq</name>
    <filename>structDDS__TransportMulticastMappingSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_TransportMulticastQosPolicy</name>
    <filename>structDDS__TransportMulticastQosPolicy.html</filename>
    <member kind="variable">
      <type>struct DDS_TransportMulticastSettingsSeq</type>
      <name>value</name>
      <anchorfile>structDDS__TransportMulticastQosPolicy.html</anchorfile>
      <anchor>ac40270b582c36ae55a4c63e7ea5b1d9c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_TransportMulticastQosPolicyKind</type>
      <name>kind</name>
      <anchorfile>structDDS__TransportMulticastQosPolicy.html</anchorfile>
      <anchor>a4ff139c37cf791b837062e299ff9d932</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_TransportMulticastSettings_t</name>
    <filename>structDDS__TransportMulticastSettings__t.html</filename>
    <member kind="variable">
      <type>struct DDS_StringSeq</type>
      <name>transports</name>
      <anchorfile>structDDS__TransportMulticastSettings__t.html</anchorfile>
      <anchor>af0441a34b57f344b2ba25fd05568dc5a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>receive_address</name>
      <anchorfile>structDDS__TransportMulticastSettings__t.html</anchorfile>
      <anchor>a58f80ed4bc312aef71f86dda512425bb</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>receive_port</name>
      <anchorfile>structDDS__TransportMulticastSettings__t.html</anchorfile>
      <anchor>abb4f51ce026d2feccee38e7b2e80d6dc</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_TransportMulticastSettingsSeq</name>
    <filename>structDDS__TransportMulticastSettingsSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_TransportPriorityQosPolicy</name>
    <filename>structDDS__TransportPriorityQosPolicy.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>value</name>
      <anchorfile>structDDS__TransportPriorityQosPolicy.html</anchorfile>
      <anchor>a47435f55f48cd2c39c6a2229c38040df</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__TransportPriorityQosPolicy">DDSTransportPriorityQosModule_usage</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_TransportSelectionQosPolicy</name>
    <filename>structDDS__TransportSelectionQosPolicy.html</filename>
    <member kind="variable">
      <type>struct DDS_StringSeq</type>
      <name>enabled_transports</name>
      <anchorfile>structDDS__TransportSelectionQosPolicy.html</anchorfile>
      <anchor>ad43378cad73e806289a70bc86a28fe0f</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_TransportUnicastQosPolicy</name>
    <filename>structDDS__TransportUnicastQosPolicy.html</filename>
    <member kind="variable">
      <type>struct DDS_TransportUnicastSettingsSeq</type>
      <name>value</name>
      <anchorfile>structDDS__TransportUnicastQosPolicy.html</anchorfile>
      <anchor>aa900b5efc6c69e9fd0cfd42188f1c44d</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__TransportUnicastQosPolicy">DDSTransportUnicastQosModule_usage</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_TransportUnicastSettings_t</name>
    <filename>structDDS__TransportUnicastSettings__t.html</filename>
    <member kind="variable">
      <type>struct DDS_StringSeq</type>
      <name>transports</name>
      <anchorfile>structDDS__TransportUnicastSettings__t.html</anchorfile>
      <anchor>ad68884b4eb4d0e2f1c72e642d829280a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>receive_port</name>
      <anchorfile>structDDS__TransportUnicastSettings__t.html</anchorfile>
      <anchor>af44eba972ed8591e56da11c3f9d61164</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_TransportUnicastSettingsSeq</name>
    <filename>structDDS__TransportUnicastSettingsSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_TypeAllocationParams_t</name>
    <filename>structDDS__TypeAllocationParams__t.html</filename>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>allocate_pointers</name>
      <anchorfile>structDDS__TypeAllocationParams__t.html</anchorfile>
      <anchor>a6a771e49d66d177ca11690acade22abb</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>allocate_optional_members</name>
      <anchorfile>structDDS__TypeAllocationParams__t.html</anchorfile>
      <anchor>a03da0368c90f38209c63dc31c7e28896</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_TypeCode</name>
    <filename>structDDS__TypeCode.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_TypeCodeFactory</name>
    <filename>structDDS__TypeCodeFactory.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_TypeConsistencyEnforcementQosPolicy</name>
    <filename>structDDS__TypeConsistencyEnforcementQosPolicy.html</filename>
    <member kind="variable">
      <type>DDS_TypeConsistencyKind</type>
      <name>kind</name>
      <anchorfile>structDDS__TypeConsistencyEnforcementQosPolicy.html</anchorfile>
      <anchor>a366e358a9fc1095fa5ed89d4cc03d911</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_TypeDeallocationParams_t</name>
    <filename>structDDS__TypeDeallocationParams__t.html</filename>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>delete_pointers</name>
      <anchorfile>structDDS__TypeDeallocationParams__t.html</anchorfile>
      <anchor>a5bc8e5da998db179aaac32a0cd6db18f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>delete_optional_members</name>
      <anchorfile>structDDS__TypeDeallocationParams__t.html</anchorfile>
      <anchor>a6234eefb763e7250c88d03d61af8db4c</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_TypeSupportQosPolicy</name>
    <filename>structDDS__TypeSupportQosPolicy.html</filename>
    <member kind="variable">
      <type>void *</type>
      <name>plugin_data</name>
      <anchorfile>structDDS__TypeSupportQosPolicy.html</anchorfile>
      <anchor>a3ebe86ac341a637dff8a35839c404f06</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_CdrPaddingKind</type>
      <name>cdr_padding_kind</name>
      <anchorfile>structDDS__TypeSupportQosPolicy.html</anchorfile>
      <anchor>a0916d802f0bc4f2dc26147401d669258</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__TypeSupportQosPolicy">DDSTypeSupportQosModule_usage</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_UnionMember</name>
    <filename>structDDS__UnionMember.html</filename>
    <member kind="variable">
      <type>char *</type>
      <name>name</name>
      <anchorfile>structDDS__UnionMember.html</anchorfile>
      <anchor>a37c7fb6ee0f17ee3cfcc0ce816ff83fd</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>is_pointer</name>
      <anchorfile>structDDS__UnionMember.html</anchorfile>
      <anchor>ad934a158dded86f153545438cd51d234</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_LongSeq</type>
      <name>labels</name>
      <anchorfile>structDDS__UnionMember.html</anchorfile>
      <anchor>aa43e9a28a879aaf12d849733320b4dbc</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const DDS_TypeCode *</type>
      <name>type</name>
      <anchorfile>structDDS__UnionMember.html</anchorfile>
      <anchor>ac0c2ee7ae58eb28a10415b9db485bb0d</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_UnionMemberSeq</name>
    <filename>structDDS__UnionMemberSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_UnsignedLongLongSeq</name>
    <filename>structDDS__UnsignedLongLongSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_UnsignedLongSeq</name>
    <filename>structDDS__UnsignedLongSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_UnsignedShortSeq</name>
    <filename>structDDS__UnsignedShortSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_UserDataQosPolicy</name>
    <filename>structDDS__UserDataQosPolicy.html</filename>
    <member kind="variable">
      <type>struct DDS_OctetSeq</type>
      <name>value</name>
      <anchorfile>structDDS__UserDataQosPolicy.html</anchorfile>
      <anchor>a3f61b61c8f3fd5c92908ac6a8cdd97f2</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__UserDataQosPolicy">DDSUserDataQosModule_usage</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_ValueMember</name>
    <filename>structDDS__ValueMember.html</filename>
    <member kind="variable">
      <type>char *</type>
      <name>name</name>
      <anchorfile>structDDS__ValueMember.html</anchorfile>
      <anchor>a2efe43775afb553f666b42d41212cebd</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>const DDS_TypeCode *</type>
      <name>type</name>
      <anchorfile>structDDS__ValueMember.html</anchorfile>
      <anchor>ad3cb7e943f6568b84438e7cec3d49e46</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>is_pointer</name>
      <anchorfile>structDDS__ValueMember.html</anchorfile>
      <anchor>a16ccbeb94ebd073c689aada91996edbb</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Short</type>
      <name>bits</name>
      <anchorfile>structDDS__ValueMember.html</anchorfile>
      <anchor>a3eab1919b63ecc326402f88f87cc7496</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>is_key</name>
      <anchorfile>structDDS__ValueMember.html</anchorfile>
      <anchor>a2b9a5fc0d522b1a043dda5c177862379</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Visibility</type>
      <name>access</name>
      <anchorfile>structDDS__ValueMember.html</anchorfile>
      <anchor>a28c64e1b72da92a2dffcb9437aba90b6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>id</name>
      <anchorfile>structDDS__ValueMember.html</anchorfile>
      <anchor>a4e49dd84d94476fea1bfdf9bb75e0364</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>is_optional</name>
      <anchorfile>structDDS__ValueMember.html</anchorfile>
      <anchor>a95bb90b560ae9b0ed7070d7395de802b</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_ValueMemberSeq</name>
    <filename>structDDS__ValueMemberSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_VendorId_t</name>
    <filename>structDDS__VendorId__t.html</filename>
    <member kind="variable">
      <type>DDS_Octet</type>
      <name>vendorId</name>
      <anchorfile>structDDS__VendorId__t.html</anchorfile>
      <anchor>ab6628df71117d414d85118c5529f7b8a</anchor>
      <arglist>[DDS_VENDOR_ID_LENGTH_MAX]</arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_WaitSetProperty_t</name>
    <filename>structDDS__WaitSetProperty__t.html</filename>
    <member kind="variable">
      <type>long</type>
      <name>max_event_count</name>
      <anchorfile>structDDS__WaitSetProperty__t.html</anchorfile>
      <anchor>abd76a6d13b625ad0e8f252c585eca301</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>max_event_delay</name>
      <anchorfile>structDDS__WaitSetProperty__t.html</anchorfile>
      <anchor>a8204531ee7dcb0e92d18ac506a3bee63</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_WcharSeq</name>
    <filename>structDDS__WcharSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>DDS_WireProtocolQosPolicy</name>
    <filename>structDDS__WireProtocolQosPolicy.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>participant_id</name>
      <anchorfile>structDDS__WireProtocolQosPolicy.html</anchorfile>
      <anchor>af8282d78bd332c9b82d0112fab8c63d7</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_UnsignedLong</type>
      <name>rtps_host_id</name>
      <anchorfile>structDDS__WireProtocolQosPolicy.html</anchorfile>
      <anchor>a1ec4d6bea721b98a18f77a6f427071a0</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_UnsignedLong</type>
      <name>rtps_app_id</name>
      <anchorfile>structDDS__WireProtocolQosPolicy.html</anchorfile>
      <anchor>aef56b6377850104aa6d3bd6accb6021d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_UnsignedLong</type>
      <name>rtps_instance_id</name>
      <anchorfile>structDDS__WireProtocolQosPolicy.html</anchorfile>
      <anchor>a59b4f2ecc0b6f73803797c8126945926</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_RtpsWellKnownPorts_t</type>
      <name>rtps_well_known_ports</name>
      <anchorfile>structDDS__WireProtocolQosPolicy.html</anchorfile>
      <anchor>a61e692035278a96fd3a6c09328aeb442</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_RtpsReservedPortKindMask</type>
      <name>rtps_reserved_port_mask</name>
      <anchorfile>structDDS__WireProtocolQosPolicy.html</anchorfile>
      <anchor>af317c634a6c4d98f51791295128a405a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_WireProtocolQosPolicyAutoKind</type>
      <name>rtps_auto_id_kind</name>
      <anchorfile>structDDS__WireProtocolQosPolicy.html</anchorfile>
      <anchor>a7818ef96ca05c3f01d7b55fa18a5f6cb</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__WireProtocolQosPolicy">DDSWireProtocolQosModule_usage</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_WriteParams_t</name>
    <filename>structDDS__WriteParams__t.html</filename>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>replace_auto</name>
      <anchorfile>structDDS__WriteParams__t.html</anchorfile>
      <anchor>aa10fad0c0351fd46c462383939f4b05f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SampleIdentity_t</type>
      <name>identity</name>
      <anchorfile>structDDS__WriteParams__t.html</anchorfile>
      <anchor>a0b80053f2cf2e81f7e0278ca64029ba9</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_SampleIdentity_t</type>
      <name>related_sample_identity</name>
      <anchorfile>structDDS__WriteParams__t.html</anchorfile>
      <anchor>acc8b6ee944b03a6edb37e8a3e097ac4a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Time_t</type>
      <name>source_timestamp</name>
      <anchorfile>structDDS__WriteParams__t.html</anchorfile>
      <anchor>a2f79abac4bf7b21bf9d7c17765b689d0</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_InstanceHandle_t</type>
      <name>handle</name>
      <anchorfile>structDDS__WriteParams__t.html</anchorfile>
      <anchor>a516042f3270081bdb65a9b38f710d35f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>priority</name>
      <anchorfile>structDDS__WriteParams__t.html</anchorfile>
      <anchor>abcd40c21d64ccb446c12192bd4b9b3a0</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>DDS_WriterDataLifecycleQosPolicy</name>
    <filename>structDDS__WriterDataLifecycleQosPolicy.html</filename>
    <member kind="variable">
      <type>DDS_Boolean</type>
      <name>autodispose_unregistered_instances</name>
      <anchorfile>structDDS__WriterDataLifecycleQosPolicy.html</anchorfile>
      <anchor>a07278894e9636ebabd43b8188beb99e9</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_Duration_t</type>
      <name>autopurge_unregistered_instances_delay</name>
      <anchorfile>structDDS__WriterDataLifecycleQosPolicy.html</anchorfile>
      <anchor>a7342bd59afe8c033870b00bae0beddf1</anchor>
      <arglist></arglist>
    </member>
    <docanchor file="structDDS__WriterDataLifecycleQosPolicy">DDSWriterDataLifecycleQosModule_usage</docanchor>
  </compound>
  <compound kind="struct">
    <name>DDS_WstringSeq</name>
    <filename>structDDS__WstringSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>Foo</name>
    <filename>structFoo.html</filename>
  </compound>
  <compound kind="struct">
    <name>FooBarReplier</name>
    <filename>structFooBarReplier.html</filename>
  </compound>
  <compound kind="struct">
    <name>FooBarRequester</name>
    <filename>structFooBarRequester.html</filename>
  </compound>
  <compound kind="struct">
    <name>FooBarSimpleReplier</name>
    <filename>structFooBarSimpleReplier.html</filename>
  </compound>
  <compound kind="struct">
    <name>FooDataReader</name>
    <filename>structFooDataReader.html</filename>
  </compound>
  <compound kind="struct">
    <name>FooDataWriter</name>
    <filename>structFooDataWriter.html</filename>
  </compound>
  <compound kind="struct">
    <name>FooSeq</name>
    <filename>structFooSeq.html</filename>
  </compound>
  <compound kind="struct">
    <name>FooTypeSupport</name>
    <filename>structFooTypeSupport.html</filename>
  </compound>
  <compound kind="struct">
    <name>NDDS_Config_LibraryVersion_t</name>
    <filename>structNDDS__Config__LibraryVersion__t.html</filename>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>major</name>
      <anchorfile>structNDDS__Config__LibraryVersion__t.html</anchorfile>
      <anchor>abe7fc1a5ceaeaa8a1ad9077d0940b0a0</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>minor</name>
      <anchorfile>structNDDS__Config__LibraryVersion__t.html</anchorfile>
      <anchor>a6c1880eb584167302a16b352b38e6e39</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char</type>
      <name>release</name>
      <anchorfile>structNDDS__Config__LibraryVersion__t.html</anchorfile>
      <anchor>a510acf01b4a5e8c76ccf5ba8e98f2879</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Long</type>
      <name>build</name>
      <anchorfile>structNDDS__Config__LibraryVersion__t.html</anchorfile>
      <anchor>a828905b47079ccb66c78c1cecefb28e7</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>NDDS_Config_Logger</name>
    <filename>structNDDS__Config__Logger.html</filename>
  </compound>
  <compound kind="struct">
    <name>NDDS_Config_LoggerDevice</name>
    <filename>structNDDS__Config__LoggerDevice.html</filename>
    <member kind="variable">
      <type>NDDS_Config_LoggerDeviceWriteFnc</type>
      <name>write</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>gaf49e0a5c4d4bf2f01e7ae10d7d5033a2</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>NDDS_Config_LoggerDeviceCloseFnc</type>
      <name>close</name>
      <anchorfile>group__NDDSConfigModule.html</anchorfile>
      <anchor>ga74cd7f4f28f7ccc511152bcd4c0ecca9</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>NDDS_Config_LogMessage</name>
    <filename>structNDDS__Config__LogMessage.html</filename>
    <member kind="variable">
      <type>const char *</type>
      <name>text</name>
      <anchorfile>structNDDS__Config__LogMessage.html</anchorfile>
      <anchor>ac3a943860a6dc24213dfb9b7e6195328</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>NDDS_Config_LogLevel</type>
      <name>level</name>
      <anchorfile>structNDDS__Config__LogMessage.html</anchorfile>
      <anchor>a22054bbcb04f0463f16d280ace77bc48</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>NDDS_Config_Version_t</name>
    <filename>structNDDS__Config__Version__t.html</filename>
  </compound>
  <compound kind="struct">
    <name>NDDS_Transport_Address_t</name>
    <filename>structNDDS__Transport__Address__t.html</filename>
    <member kind="variable">
      <type>unsigned char</type>
      <name>network_ordered_value</name>
      <anchorfile>structNDDS__Transport__Address__t.html</anchorfile>
      <anchor>a9aae346aa5d7fd1a1fc2d11543149698</anchor>
      <arglist>[NDDS_TRANSPORT_ADDRESS_LENGTH]</arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>NDDS_Transport_Property_t</name>
    <filename>structNDDS__Transport__Property__t.html</filename>
    <member kind="variable">
      <type>NDDS_Transport_ClassId_t</type>
      <name>classid</name>
      <anchorfile>structNDDS__Transport__Property__t.html</anchorfile>
      <anchor>ad1801e5fd5ad7bb727c3c55cc4ee9096</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>address_bit_count</name>
      <anchorfile>structNDDS__Transport__Property__t.html</anchorfile>
      <anchor>a5a2ee05f550b32ac32a3c9b520216202</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>properties_bitmap</name>
      <anchorfile>structNDDS__Transport__Property__t.html</anchorfile>
      <anchor>a9aa8b4998b2dde4cc303b44a0c458b77</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>gather_send_buffer_count_max</name>
      <anchorfile>structNDDS__Transport__Property__t.html</anchorfile>
      <anchor>a3e830e6ff13c82dc46ef39e7d6169be2</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>message_size_max</name>
      <anchorfile>structNDDS__Transport__Property__t.html</anchorfile>
      <anchor>a4ab89765aee4395142e2dabc7849a46a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char **</type>
      <name>allow_interfaces_list</name>
      <anchorfile>structNDDS__Transport__Property__t.html</anchorfile>
      <anchor>a4fe78eb17d3113ab7b19666bdebc74b8</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>allow_interfaces_list_length</name>
      <anchorfile>structNDDS__Transport__Property__t.html</anchorfile>
      <anchor>aefb52fdb768c5dd345c6f80e59eaafd9</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char **</type>
      <name>deny_interfaces_list</name>
      <anchorfile>structNDDS__Transport__Property__t.html</anchorfile>
      <anchor>a5cdeaa8a2ef3a32cac477c487c0e2cf6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>deny_interfaces_list_length</name>
      <anchorfile>structNDDS__Transport__Property__t.html</anchorfile>
      <anchor>a3df8a19f01b332cdacc2972cfbc687fa</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char **</type>
      <name>allow_multicast_interfaces_list</name>
      <anchorfile>structNDDS__Transport__Property__t.html</anchorfile>
      <anchor>a53edf45a5ba7a827ccbbc7ac244305dc</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>allow_multicast_interfaces_list_length</name>
      <anchorfile>structNDDS__Transport__Property__t.html</anchorfile>
      <anchor>ad21b2883cbff15f6b9a1a76ced37d2bb</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char **</type>
      <name>deny_multicast_interfaces_list</name>
      <anchorfile>structNDDS__Transport__Property__t.html</anchorfile>
      <anchor>aee02ed299b471a0a09adf464ca467154</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>deny_multicast_interfaces_list_length</name>
      <anchorfile>structNDDS__Transport__Property__t.html</anchorfile>
      <anchor>a6a8978297019dd39fc8eea1de70e0bb8</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>NDDS_Transport_Shmem_Property_t</name>
    <filename>structNDDS__Transport__Shmem__Property__t.html</filename>
    <member kind="variable">
      <type>struct NDDS_Transport_Property_t</type>
      <name>parent</name>
      <anchorfile>structNDDS__Transport__Shmem__Property__t.html</anchorfile>
      <anchor>a853ea5a98b12128d51e220641328182a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>received_message_count_max</name>
      <anchorfile>structNDDS__Transport__Shmem__Property__t.html</anchorfile>
      <anchor>a240f1296a35c1edb35b40e6902cffbc6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>receive_buffer_size</name>
      <anchorfile>structNDDS__Transport__Shmem__Property__t.html</anchorfile>
      <anchor>a5e4bdc80e1538c2ea1315504435f22b7</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>NDDS_Transport_Support</name>
    <filename>structNDDS__Transport__Support.html</filename>
  </compound>
  <compound kind="struct">
    <name>NDDS_Transport_UDPv4_Property_t</name>
    <filename>structNDDS__Transport__UDPv4__Property__t.html</filename>
    <member kind="variable">
      <type>struct NDDS_Transport_Property_t</type>
      <name>parent</name>
      <anchorfile>structNDDS__Transport__UDPv4__Property__t.html</anchorfile>
      <anchor>a201b738f355a224f4adb1aa29481f748</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>send_socket_buffer_size</name>
      <anchorfile>structNDDS__Transport__UDPv4__Property__t.html</anchorfile>
      <anchor>a9d7af2209fbb1b7486e0161d57a47096</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>recv_socket_buffer_size</name>
      <anchorfile>structNDDS__Transport__UDPv4__Property__t.html</anchorfile>
      <anchor>acb818edb0468929186920af27a811a02</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>unicast_enabled</name>
      <anchorfile>structNDDS__Transport__UDPv4__Property__t.html</anchorfile>
      <anchor>adde305603e3b5ee7272355e57c6c8b10</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>multicast_enabled</name>
      <anchorfile>structNDDS__Transport__UDPv4__Property__t.html</anchorfile>
      <anchor>a4b51e81f4b886f1918ae41d62474fa81</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>multicast_ttl</name>
      <anchorfile>structNDDS__Transport__UDPv4__Property__t.html</anchorfile>
      <anchor>a3a361973cfdc08952376a23792fbbc8c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>multicast_loopback_disabled</name>
      <anchorfile>structNDDS__Transport__UDPv4__Property__t.html</anchorfile>
      <anchor>a6a63587ef07003924a3c5e97d642306b</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>ignore_loopback_interface</name>
      <anchorfile>structNDDS__Transport__UDPv4__Property__t.html</anchorfile>
      <anchor>a1788423f895ef8fa42d4dc21d0e85651</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>ignore_nonup_interfaces</name>
      <anchorfile>structNDDS__Transport__UDPv4__Property__t.html</anchorfile>
      <anchor>aad52040f31d2683e45d798fb9b226dc7</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>ignore_nonrunning_interfaces</name>
      <anchorfile>structNDDS__Transport__UDPv4__Property__t.html</anchorfile>
      <anchor>a838b2410350d165e2937a431e53a1b5d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>no_zero_copy</name>
      <anchorfile>structNDDS__Transport__UDPv4__Property__t.html</anchorfile>
      <anchor>a7b3dc6c7ab05e0273f55f6f0312a8a73</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>send_blocking</name>
      <anchorfile>structNDDS__Transport__UDPv4__Property__t.html</anchorfile>
      <anchor>a1f212bdbbb27abe3f53a6622c5dfad89</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_UINT32</type>
      <name>transport_priority_mask</name>
      <anchorfile>structNDDS__Transport__UDPv4__Property__t.html</anchorfile>
      <anchor>a06eff9f2baf5f72185750b93c82cefeb</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>transport_priority_mapping_low</name>
      <anchorfile>structNDDS__Transport__UDPv4__Property__t.html</anchorfile>
      <anchor>abae063f230c55683c852fa602b36b5a8</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>transport_priority_mapping_high</name>
      <anchorfile>structNDDS__Transport__UDPv4__Property__t.html</anchorfile>
      <anchor>a2184e43d4efffcaf17a3b087f57afec1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>send_ping</name>
      <anchorfile>structNDDS__Transport__UDPv4__Property__t.html</anchorfile>
      <anchor>a2599053c923aa49bc26d25a1b9d53fcb</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_UINT32</type>
      <name>interface_poll_period</name>
      <anchorfile>structNDDS__Transport__UDPv4__Property__t.html</anchorfile>
      <anchor>a826c7e862521167b334ad2e6ecdcd118</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>reuse_multicast_receive_resource</name>
      <anchorfile>structNDDS__Transport__UDPv4__Property__t.html</anchorfile>
      <anchor>aca0942bfc07fdf62a5b70e0ae6314685</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>protocol_overhead_max</name>
      <anchorfile>structNDDS__Transport__UDPv4__Property__t.html</anchorfile>
      <anchor>aa9988933834b3017f865ab26a8833130</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>public_address</name>
      <anchorfile>structNDDS__Transport__UDPv4__Property__t.html</anchorfile>
      <anchor>a4fda981516c74d50d31abe161d4f7381</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>NDDS_Transport_UDPv6_Property_t</name>
    <filename>structNDDS__Transport__UDPv6__Property__t.html</filename>
    <member kind="variable">
      <type>struct NDDS_Transport_Property_t</type>
      <name>parent</name>
      <anchorfile>structNDDS__Transport__UDPv6__Property__t.html</anchorfile>
      <anchor>a4d5b6c414c527410f1eb5790561823d6</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>send_socket_buffer_size</name>
      <anchorfile>structNDDS__Transport__UDPv6__Property__t.html</anchorfile>
      <anchor>a6357009ec696b2fafb93510964fd9e42</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>recv_socket_buffer_size</name>
      <anchorfile>structNDDS__Transport__UDPv6__Property__t.html</anchorfile>
      <anchor>a00da7fe0a40645d52864d91b1554c8a5</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>unicast_enabled</name>
      <anchorfile>structNDDS__Transport__UDPv6__Property__t.html</anchorfile>
      <anchor>a423d55dac2537c8cbdedcabd26d644d4</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>multicast_enabled</name>
      <anchorfile>structNDDS__Transport__UDPv6__Property__t.html</anchorfile>
      <anchor>a901962012774ff31a11a188ee402f50a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>multicast_ttl</name>
      <anchorfile>structNDDS__Transport__UDPv6__Property__t.html</anchorfile>
      <anchor>aab65f6ab0c21172ff233389b49fc5547</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>multicast_loopback_disabled</name>
      <anchorfile>structNDDS__Transport__UDPv6__Property__t.html</anchorfile>
      <anchor>a26f5565a333f6d61812cbb9a7279a376</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>ignore_loopback_interface</name>
      <anchorfile>structNDDS__Transport__UDPv6__Property__t.html</anchorfile>
      <anchor>a032b0e119dbb669056cca5e8f6858390</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>ignore_nonrunning_interfaces</name>
      <anchorfile>structNDDS__Transport__UDPv6__Property__t.html</anchorfile>
      <anchor>af34f95b839d60fbf10469c42200ea647</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>no_zero_copy</name>
      <anchorfile>structNDDS__Transport__UDPv6__Property__t.html</anchorfile>
      <anchor>aba60da079070e98b18036f44bf6689a4</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>send_blocking</name>
      <anchorfile>structNDDS__Transport__UDPv6__Property__t.html</anchorfile>
      <anchor>aa5164dd6782181ff7f63752c58c9d00d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>enable_v4mapped</name>
      <anchorfile>structNDDS__Transport__UDPv6__Property__t.html</anchorfile>
      <anchor>aa61d4ff6c732c9cbeb84b6f35e6f697a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_UINT32</type>
      <name>transport_priority_mask</name>
      <anchorfile>structNDDS__Transport__UDPv6__Property__t.html</anchorfile>
      <anchor>a300d65c0a3f8adfb9ad8416d49b2e006</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>transport_priority_mapping_low</name>
      <anchorfile>structNDDS__Transport__UDPv6__Property__t.html</anchorfile>
      <anchor>aa1bb5f930b7d612b9e1044f067a58102</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_INT32</type>
      <name>transport_priority_mapping_high</name>
      <anchorfile>structNDDS__Transport__UDPv6__Property__t.html</anchorfile>
      <anchor>a49f387a6f55a83cf9a3ff9ee1df34db0</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>NDDS_Utility</name>
    <filename>structNDDS__Utility.html</filename>
  </compound>
  <compound kind="struct">
    <name>RTI_Connext_Replier</name>
    <filename>structRTI__Connext__Replier.html</filename>
  </compound>
  <compound kind="struct">
    <name>RTI_Connext_ReplierListener</name>
    <filename>structRTI__Connext__ReplierListener.html</filename>
    <member kind="variable">
      <type>RTI_Connext_ReplierListener_OnRequestAvailableCallback</type>
      <name>on_request_available</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>ga1337016b6779eaa66a522b19274a420f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>void *</type>
      <name>user_data</name>
      <anchorfile>structRTI__Connext__ReplierListener.html</anchorfile>
      <anchor>a27a8b63f7b4908667c9877c42915f8ec</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>RTI_Connext_ReplierParams</name>
    <filename>structRTI__Connext__ReplierParams.html</filename>
    <member kind="variable">
      <type>DDS_DomainParticipant *</type>
      <name>participant</name>
      <anchorfile>structRTI__Connext__ReplierParams.html</anchorfile>
      <anchor>ad58e367d84f21366d0a69b683d0bc78c</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>service_name</name>
      <anchorfile>structRTI__Connext__ReplierParams.html</anchorfile>
      <anchor>a41567edfadc6f9c9965e07c0ca868704</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>request_topic_name</name>
      <anchorfile>structRTI__Connext__ReplierParams.html</anchorfile>
      <anchor>a4d68408e0e18249d5dfee463dae3500e</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>reply_topic_name</name>
      <anchorfile>structRTI__Connext__ReplierParams.html</anchorfile>
      <anchor>ada3536c7cc2a8afafac263bd152f3eef</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>qos_library_name</name>
      <anchorfile>structRTI__Connext__ReplierParams.html</anchorfile>
      <anchor>a5ee325bd70c439b8efa4fcf3820b8847</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>qos_profile_name</name>
      <anchorfile>structRTI__Connext__ReplierParams.html</anchorfile>
      <anchor>a77f0fd800234ca2f3967b58b09d9346d</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DataWriterQos *</type>
      <name>datawriter_qos</name>
      <anchorfile>structRTI__Connext__ReplierParams.html</anchorfile>
      <anchor>a3e24c96f468c4622cda3f65f108aeb0f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DataReaderQos *</type>
      <name>datareader_qos</name>
      <anchorfile>structRTI__Connext__ReplierParams.html</anchorfile>
      <anchor>a2b4f1928e79f5a19d73c32268d1cce61</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Publisher *</type>
      <name>publisher</name>
      <anchorfile>structRTI__Connext__ReplierParams.html</anchorfile>
      <anchor>a9a178f7c6aa738620fe4999f510cb7ad</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Subscriber *</type>
      <name>subscriber</name>
      <anchorfile>structRTI__Connext__ReplierParams.html</anchorfile>
      <anchor>a5dbf721d715b66ec152b16bcabe47162</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct RTI_Connext_ReplierListener *</type>
      <name>listener</name>
      <anchorfile>structRTI__Connext__ReplierParams.html</anchorfile>
      <anchor>a449358002f78ae7174fcbf449820a30d</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>RTI_Connext_Requester</name>
    <filename>structRTI__Connext__Requester.html</filename>
  </compound>
  <compound kind="struct">
    <name>RTI_Connext_RequesterParams</name>
    <filename>structRTI__Connext__RequesterParams.html</filename>
    <member kind="variable">
      <type>DDS_DomainParticipant *</type>
      <name>participant</name>
      <anchorfile>structRTI__Connext__RequesterParams.html</anchorfile>
      <anchor>a4f216c3636b92bbdf1085231d580feb7</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>service_name</name>
      <anchorfile>structRTI__Connext__RequesterParams.html</anchorfile>
      <anchor>a34953c15913d69430c212044383b8265</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>request_topic_name</name>
      <anchorfile>structRTI__Connext__RequesterParams.html</anchorfile>
      <anchor>a7f7ecbb7c5f597f323116b6438b6fada</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>reply_topic_name</name>
      <anchorfile>structRTI__Connext__RequesterParams.html</anchorfile>
      <anchor>a3c876fb2b46864bf1eafe2aa840758d8</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>qos_library_name</name>
      <anchorfile>structRTI__Connext__RequesterParams.html</anchorfile>
      <anchor>a7c27faa5034bb4412902611cca984acb</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>qos_profile_name</name>
      <anchorfile>structRTI__Connext__RequesterParams.html</anchorfile>
      <anchor>a2f8aa3f85a6c9b0094db81ebeb466795</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DataWriterQos *</type>
      <name>datawriter_qos</name>
      <anchorfile>structRTI__Connext__RequesterParams.html</anchorfile>
      <anchor>a0e275d5027694c69da3ab7341165b9ee</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DataReaderQos *</type>
      <name>datareader_qos</name>
      <anchorfile>structRTI__Connext__RequesterParams.html</anchorfile>
      <anchor>a6b55974fd17bbcf2b06b54be48f22295</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Publisher *</type>
      <name>publisher</name>
      <anchorfile>structRTI__Connext__RequesterParams.html</anchorfile>
      <anchor>a168c1190c19baf723fec247ef404e4cb</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Subscriber *</type>
      <name>subscriber</name>
      <anchorfile>structRTI__Connext__RequesterParams.html</anchorfile>
      <anchor>aa5f8628b5dcde2b428289e41572b0e16</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>RTI_Connext_SimpleReplierListener</name>
    <filename>structRTI__Connext__SimpleReplierListener.html</filename>
    <member kind="variable">
      <type>RTI_Connext_SimpleReplierListener_OnRequestAvailableCallback</type>
      <name>on_request_available</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>gaeb2dda9701734c7777ca14935e6c1fdf</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>RTI_Connext_SimpleReplierListener_OnReturnLoanCallback</type>
      <name>return_loan</name>
      <anchorfile>group__ReplierModule.html</anchorfile>
      <anchor>ga995246a733334af7cdfaccd1026f4e80</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>void *</type>
      <name>user_data</name>
      <anchorfile>structRTI__Connext__SimpleReplierListener.html</anchorfile>
      <anchor>a02b39c6dc23d9de46157de04684a5651</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>RTI_Connext_SimpleReplierParams</name>
    <filename>structRTI__Connext__SimpleReplierParams.html</filename>
    <member kind="variable">
      <type>DDS_DomainParticipant *</type>
      <name>participant</name>
      <anchorfile>structRTI__Connext__SimpleReplierParams.html</anchorfile>
      <anchor>ae71ec742a977f5cde1cfaff15eab60f2</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>service_name</name>
      <anchorfile>structRTI__Connext__SimpleReplierParams.html</anchorfile>
      <anchor>a40f9d21ad5ada84a5cf09a99c6a8d572</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>request_topic_name</name>
      <anchorfile>structRTI__Connext__SimpleReplierParams.html</anchorfile>
      <anchor>a8069d8d0b116f4c6781bd14bae2225f8</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>reply_topic_name</name>
      <anchorfile>structRTI__Connext__SimpleReplierParams.html</anchorfile>
      <anchor>a4e8d93c2c5cbad0b74dcb10782d344e1</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>qos_library_name</name>
      <anchorfile>structRTI__Connext__SimpleReplierParams.html</anchorfile>
      <anchor>a5d525eba8551ff26881318df95bc8cbf</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>char *</type>
      <name>qos_profile_name</name>
      <anchorfile>structRTI__Connext__SimpleReplierParams.html</anchorfile>
      <anchor>ab0e5fbc96e24fa20b6ec2d15b0e2f326</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DataWriterQos *</type>
      <name>datawriter_qos</name>
      <anchorfile>structRTI__Connext__SimpleReplierParams.html</anchorfile>
      <anchor>a6d79a12121b90ebb3e312a8916d6af62</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct DDS_DataReaderQos *</type>
      <name>datareader_qos</name>
      <anchorfile>structRTI__Connext__SimpleReplierParams.html</anchorfile>
      <anchor>a84e0c0b6865efde0a16c0a59b10822f5</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Publisher *</type>
      <name>publisher</name>
      <anchorfile>structRTI__Connext__SimpleReplierParams.html</anchorfile>
      <anchor>ae7e682d34bd817e194f82b88a554827a</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>DDS_Subscriber *</type>
      <name>subscriber</name>
      <anchorfile>structRTI__Connext__SimpleReplierParams.html</anchorfile>
      <anchor>a7f75805784df0fd41c018708da44715f</anchor>
      <arglist></arglist>
    </member>
    <member kind="variable">
      <type>struct RTI_Connext_SimpleReplierListener *</type>
      <name>simple_listener</name>
      <anchorfile>structRTI__Connext__SimpleReplierParams.html</anchorfile>
      <anchor>a667a4f1b36a48968461f932c9458e35d</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="struct">
    <name>TransportAllocationSettings_t</name>
    <filename>structTransportAllocationSettings__t.html</filename>
  </compound>
  <compound kind="dir">
    <name>apis</name>
    <path>/home/build/rti/waveworks/ndds510/dds_doc.1.0/srcDoc/apis/</path>
    <filename>dir_32db4894f279385bad0d8ad24eedd6ec.html</filename>
    <file>clock.dxx</file>
    <file>dcps.dxx</file>
    <file>main-apis.dxx</file>
    <file>memorymgmt.dxx</file>
    <file>multichannel.dxx</file>
    <file>ndds.dxx</file>
    <file>patterns.dxx</file>
    <file>persistence.dxx</file>
    <file>syntax.dxx</file>
    <file>system_properties.dxx</file>
    <file>xmlconfiguration.dxx</file>
  </compound>
  <compound kind="dir">
    <name>dds_c.1.0</name>
    <path>/home/build/rti/waveworks/ndds510/dds_c.1.0/</path>
    <filename>dir_aae62979363cdde1f999659e19f9333d.html</filename>
    <dir>interface</dir>
    <dir>srcDoc</dir>
  </compound>
  <compound kind="dir">
    <name>dds_doc.1.0</name>
    <path>/home/build/rti/waveworks/ndds510/dds_doc.1.0/</path>
    <filename>dir_e954e49d55b45caf687fa17d615ee39f.html</filename>
    <dir>srcDoc</dir>
  </compound>
  <compound kind="dir">
    <name>dependencies</name>
    <path>/home/build/rti/waveworks/ndds510/dds_doc.1.0/srcDoc/dependencies/</path>
    <filename>dir_f06682afd5e2a38909ce75dc0200c0a9.html</filename>
    <file>main-dependencies.dxx</file>
  </compound>
  <compound kind="dir">
    <name>examples</name>
    <path>/home/build/rti/waveworks/ndds510/xmq_c.1.0/srcDoc/examples/</path>
    <filename>dir_d109f07d595bb3ac50240886f89e2024.html</filename>
    <file>requestreply.dxx</file>
  </compound>
  <compound kind="dir">
    <name>examples</name>
    <path>/home/build/rti/waveworks/ndds510/dds_doc.1.0/srcDoc/examples/</path>
    <filename>dir_83bcbb5c4911326118ab241d477f6612.html</filename>
    <file>customfilter.dxx</file>
    <file>entity.dxx</file>
    <file>helloWorld.dxx</file>
    <file>largedata.dxx</file>
    <file>main-examples.dxx</file>
    <file>dds_doc.1.0/srcDoc/examples/participant.dxx</file>
    <file>patterns_requestreply.dxx</file>
    <file>publication.dxx</file>
    <file>subscription.dxx</file>
    <file>transport.dxx</file>
  </compound>
  <compound kind="dir">
    <name>examples</name>
    <path>/home/build/rti/waveworks/ndds510/dds_c.1.0/srcDoc/examples/</path>
    <filename>dir_dff60370e23a03dafe6142ca9c8cc177.html</filename>
    <file>controller.dxx</file>
    <file>filter.dxx</file>
    <file>dds_c.1.0/srcDoc/examples/participant.dxx</file>
    <file>publisher.dxx</file>
    <file>reader.dxx</file>
    <file>subscriber.dxx</file>
    <file>topic.dxx</file>
    <file>waitset.dxx</file>
    <file>writer.dxx</file>
  </compound>
  <compound kind="dir">
    <name>guides</name>
    <path>/home/build/rti/waveworks/ndds510/dds_doc.1.0/srcDoc/guides/</path>
    <filename>dir_d4876653470009c565d472a117d4acb1.html</filename>
    <file>dev-guide.dxx</file>
    <file>doc-guide.dxx</file>
    <file>dotnet-languages-guide.dxx</file>
    <file>main-guides.dxx</file>
    <file>namespace-guide.dxx</file>
    <file>user-guide.dxx</file>
  </compound>
  <compound kind="dir">
    <name>interface</name>
    <path>/home/build/rti/waveworks/ndds510/xmq_c.1.0/interface/</path>
    <filename>dir_f302eee2480a9c116b8f84cff608e098.html</filename>
    <file>xmq_c.1.0/interface/dll.ifc</file>
    <file>entity_params.ifc</file>
    <file>xmq_c.1.0/interface/log.ifc</file>
    <file>replier.ifc</file>
    <file>replier_impl.ifc</file>
    <file>requester.ifc</file>
    <file>requester_impl.ifc</file>
    <file>simple_replier.ifc</file>
    <file>untyped_impl.ifc</file>
  </compound>
  <compound kind="dir">
    <name>interface</name>
    <path>/home/build/rti/waveworks/ndds510/transport.1.0/interface/</path>
    <filename>dir_80953d8d966dc78cb336f4fabf67fdba.html</filename>
    <file>common_user.ifc</file>
    <file>interface_user.ifc</file>
    <file>shmem.ifc</file>
    <file>udpv4.ifc</file>
    <file>udpv6.ifc</file>
  </compound>
  <compound kind="dir">
    <name>interface</name>
    <path>/home/build/rti/waveworks/ndds510/dds_c.1.0/interface/</path>
    <filename>dir_31c4601162feba9c2d52e51c1335635a.html</filename>
    <file>builtin.ifc</file>
    <file>builtin_impl.ifc</file>
    <file>builtintypes.ifc</file>
    <file>builtintypes_impl.ifc</file>
    <file>common.ifc</file>
    <file>data.ifc</file>
    <file>dds_c.1.0/interface/dll.ifc</file>
    <file>domain.ifc</file>
    <file>domain_impl.ifc</file>
    <file>dynamicdata.ifc</file>
    <file>dynamicdata_impl.ifc</file>
    <file>dynamicdata_java_impl.ifc</file>
    <file>factory_plugin_impl.ifc</file>
    <file>flowcontroller.ifc</file>
    <file>infrastructure.ifc</file>
    <file>infrastructure_impl.ifc</file>
    <file>license.ifc</file>
    <file>dds_c.1.0/interface/log.ifc</file>
    <file>log_impl.ifc</file>
    <file>monitoring.ifc</file>
    <file>ndds_c.ifc</file>
    <file>ndds_config_c.ifc</file>
    <file>ndds_transport_c.ifc</file>
    <file>ndds_utility_c.ifc</file>
    <file>ndds_version.ifc</file>
    <file>ndds_version.template.ifc</file>
    <file>ndds_writerhistory_c.ifc</file>
    <file>octet_buffer.ifc</file>
    <file>prifilter.ifc</file>
    <file>publication.ifc</file>
    <file>publication_impl.ifc</file>
    <file>registry.ifc</file>
    <file>sequence.ifc</file>
    <file>sqlfilter.ifc</file>
    <file>string.ifc</file>
    <file>subscription.ifc</file>
    <file>subscription_impl.ifc</file>
    <file>test.ifc</file>
    <file>topic.ifc</file>
    <file>topic_impl.ifc</file>
    <file>typecode.ifc</file>
    <file>typecode_impl.ifc</file>
    <file>typeobject.ifc</file>
    <file>xml_impl.ifc</file>
  </compound>
  <compound kind="dir">
    <name>srcDoc</name>
    <path>/home/build/rti/waveworks/ndds510/xmq_c.1.0/srcDoc/</path>
    <filename>dir_523690f89736e907b87f2e2668a2ef66.html</filename>
    <dir>examples</dir>
  </compound>
  <compound kind="dir">
    <name>srcDoc</name>
    <path>/home/build/rti/waveworks/ndds510/dds_c.1.0/srcDoc/</path>
    <filename>dir_24826d773168c896343b90aaeb6a2f97.html</filename>
    <dir>examples</dir>
  </compound>
  <compound kind="dir">
    <name>srcDoc</name>
    <path>/home/build/rti/waveworks/ndds510/dds_doc.1.0/srcDoc/</path>
    <filename>dir_01c252e327248c53606dfbd3e42e56cd.html</filename>
    <dir>apis</dir>
    <dir>dependencies</dir>
    <dir>examples</dir>
    <dir>guides</dir>
    <dir>tools</dir>
    <file>main.dxx</file>
  </compound>
  <compound kind="dir">
    <name>tools</name>
    <path>/home/build/rti/waveworks/ndds510/dds_doc.1.0/srcDoc/tools/</path>
    <filename>dir_dd774955d666e4c3a0aaa19ca4e44e86.html</filename>
    <file>main-tools.dxx</file>
    <file>nddsgen.dxx</file>
    <file>nddsping.dxx</file>
    <file>nddsspy.dxx</file>
  </compound>
  <compound kind="dir">
    <name>transport.1.0</name>
    <path>/home/build/rti/waveworks/ndds510/transport.1.0/</path>
    <filename>dir_b556f4a4704a87b4d18181adde660ccb.html</filename>
    <dir>interface</dir>
  </compound>
  <compound kind="page">
    <name>index</name>
    <title>RTI Connext</title>
    <filename>index</filename>
    <docanchor file="index">main_support</docanchor>
    <docanchor file="index">main_toc</docanchor>
    <docanchor file="index">main_toc_pdfdocs</docanchor>
    <docanchor file="index">main_toc_htmldocs</docanchor>
  </compound>
</tagfile>
