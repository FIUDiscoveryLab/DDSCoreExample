================================================================================
CPP Hello World Example with RTI Persistence Service
================================================================================

Example publisher/subscriber applications are provided to send and receive 
simple integers. If RTI Persistence Service is running, the data is persisted.

Use the PsHelloWorld.xml file to persist the HelloWorld topic in domain 0.
Adjust this file if you want to use a different domain ID, then use the domain 
ID as a command-line argument with your HelloWorld_publisher and 
HelloWorld_subscriber programs.

Purpose
=======

This example shows how to perform basic publish-subscribe communication using 
DDS_PERSISTENT_DURABILITY_QOS.

For convenience, the complete source code and a sample makefile for an 
architecture have been provided. Generate your own makefile or project file 
with rtiddsgen if you want to run the example on other architectures.

How to Compile
==============

Make sure the environment variable NDDSHOME is defined before compiling the 
example.

UNIX-Based Systems
------------------

Use rtiddsgen to generate a makefile for your machine's architecture and 
compiler. For example, if both the publisher and the subscriber application 
will run on Red Hat Enterprise Linux 4 machines, you need to run rtiddsgen
for only that architecture:

    $NDDSHOME/scripts/rtiddsgen -language C++ -example i86Linux2.6gcc3.4.3 HelloWorld.idl

You may get messages saying that some files already exist and will not be 
replaced. You can safely ignore those messages, since all the source files for
this example are already provided.

Before compiling, make sure that the desired version of compiler and linker is
in your PATH environment variable.

Then compile by typing:

     gmake -f makefile_HelloWorld_i86Linux2.6gcc3.4.3

Windows Systems
---------------
Use rtiddsgen to generate the workspace/project files for your version of
Visual Studio. For example, if both the publisher and the subscriber 
application will be compiled with Visual Studio 2005, run rtiddsgen for the 
i86Win32VS2005 architecture:

    %NDDSHOME%/scripts/rtiddsgen -language C++ -example i86Win32VS2005 HelloWorld.idl

Open the solution file HelloWorld-vs2005.sln inside with Visual Studio 2005. 
Build the two projects, HelloWorld_publisher and HelloWorld_subscriber, with 
the Release configuration (or Debug settings if you prefer).

Persistent Storage Configuration
================================

RTI Persistence Service can be configured to operate in PERSISTENT or 
TRANSIENT mode. 

If the service operates in TRANSIENT mode (<persistent_storage> tag is not 
used), the received samples will be kept in memory and not in permanent storage. 
In this mode, samples published by a TRANSIENT DataWriter will survive the 
DataWriter's lifecycle but will not survive the lifecycle of RTI Persistence 
Service (unless the persistence service is duplicated).

If the service operates in PERSISTENT mode, the received samples will be stored
into:
    - a filesystem, or
    - a relational database

In this mode, samples published by a PERSISTENT DataWriter will survive the 
DataWriter's lifecycle, as well as a restart of RTI Persistence Service.

The HelloWorld example will run RTI Persistence Service in PERSISTENT mode and
it will show how to store the samples into files as well as into an external
relational database.

For external databases, the DSN of the database where the persistence service 
must persist the samples is specified using the tag
<external_database> in the XML configuration file provided with this example.

This HelloWorld example has been tested with these different databases:
    - MySQL 5.1.44

For file storage, the location of the files is specified using the tag 
<filesystem> in the XML configuration file provided with this example.

Within this tag you can specify the directory where the files will be located
using the tag <directory>. By default, files will be located in the current 
working directory.
      
MySQL Installation
------------------

** UNIX-Based Systems

   1) Verify that MySQL 5.1.44 or higher is installed and running on your 
      system. The installation of MySQL is beyond the scope of this readme.txt.       
      Please refer to the MySQL Reference Manual for the process to install and 
      configure MySQL.

      RTI Persistence Service requires the installation of the MySQL ODBC 5.1.6 
      driver. The driver is not bundled with the MySQL server and must be 
      installed separately.

      The ODBC connector can be downloaded from:
      http://dev.mysql.com/downloads/connector/odbc/5.1.html

      The MySQL ODBC driver requires an ODBC driver manager. We recommend using
      UnixODBC 2.2.12 (or higher), a complete, free/open ODBC solution for UNIX 
      and Linux systems. The driver manager can be downloaded from 
      http://www.unixodbc.org.

   2) Add the path to the UnixODBC libraries to the beginning of 
      LD_LIBRARY_PATH.
      By default, UnixODBC install the libraries under /usr/local/lib. For 
      example:

      > setenv LD_LIBRARY_PATH /usr/local/lib:$LD_LIBRARY_PATH

** Windows Systems

   1) Verify that MySQL 5.1.44 or higher is installed and running on your 
      system. The installation of MySQL is beyond the scope of this readme.txt. 
      Please refer to the MySQL Reference Manual for the process to install and 
      configure MySQL.

      RTI Persistence Service requires the installation of the MySQL ODBC 5.1.6
      driver. The driver is not bundled with the MySQL server and must be 
      installed separately.

      The ODBC connector can be downloaded from:
      http://dev.mysql.com/downloads/connector/odbc/5.1.html

Create a MySQL Account
----------------------

Before you run this HelloWorld example using MySQL, you must obtain a MySQL user 
account from your database administrator. If you are acting as your own database 
administrator, start mysql from the command prompt to connect to the MySQL 
server as the MySQL root user:

> mysql -uroot

If you have assigned a password to the root account, you will also need to 
provide a -p option.

Note: The file PsHelloWorld.xml contain the user name and password for the MySQL 
database. If you want to use a database with a name other than "test" you will 
need to edit these two files. 

To create a new MySQL account with a user name of "test" and a 
password of "test", enter the following:

> mysql -uroot
mysql> GRANT ALL PRIVILEGES ON *.* TO 'test'@'localhost' IDENTIFIED
BY 'test' WITH GRANT OPTION;
mysql> exit;

The remaining sections in this readme.txt assume that a MySQL user named "test"
with the password "test" has an account on the local host.

License File
============

If your RTI Persistence Service distribution requires a license file, you will 
receive one via email after you download the software.
Save the license file in any location of your choice. When 
RTI Persistence Service starts, it will look in these locations until it finds a 
valid license:

1. The file specified with the -licenseFile option when you start RTI 
Persistence Service from the command-line.
2. The file specified in the environment variable RTI_LICENSE_FILE, which you
may set to point to the full path of the license file, including the filename 
(for example, C:\RTI\my_rti_license.dat).
3. The file rti_license.dat in the current working directory.
4. The file rti_license.dat in the directory specified by the environment 
variable NDDSHOME.

How to Run
==========

UNIX-Based Systems
------------------

   You can skip steps 1 and 2 if you are using a filesystem to persist data.

   1) [Only for external databases] Customize the file ODBC INI file 
   HelloWorldOdbcIni:

      The HelloWorldOdbcIni distributed with this example contains one DSNs 
      (Data Source Names) for MySQL.

      Edit the file HelloWorldOdbcIni:

      - Change the DRIVER attribute of the DSNs to point to the desired ODBC 
        (MySQL) driver.

      - For MySQL, you may need to change the attribute SOCKET.

        In the mysql client, the default location of this socket file is 
        /tmp/mysql.sock. However, for a variety of reasons, many MySQL 
        installations place this socket file somewhere else like 
        /var/lib/mysql/mysql.sock. 
 
   2) [Only for external databases] Set ODBCINI:

      Set the ODBCINI environment variable to point to the HelloWorldOdbcIni
      file, or copy the file to .odbc.ini in your home directory.

      > setenv ODBCINI $NDDSHOME/example/CPP/helloWorldPersistence/HelloWorldOdbcIni

   3) If you want to run the publisher and subscriber in a domain ID other than 
      0, you have two choices:

      a) You can edit the configuration file PsHelloWorld.xml and replace the
      domain ID specified in the tag <domain_id>.
      b) You can use the command-line option -domainId 

      Note: During the next 2 steps, if you see error messages in the window 
      where you started RTI Persistence Service, please see the Troubleshooting
      section at the end of this file.

   4) Run RTI Persistence Service by typing:

      > ${NDDSHOME}/scripts/rtipersistenceservice -cfgFile PsHelloWorld.xml 
        -cfgName <HelloWorldTT|HelloWorldMySQL|HelloWorldFile> -restore 0

      On the screen, you will see:
      RTI Persistence Service started

      The value of cfgName depends on the persistent storage that you are using 
      to run the test:

      - Use HelloWorldMySQL to persist into MySQL
      - Use HelloWorldFile to persist into files

      With -restore 0, RTI Persistence Service will delete the data persisted in 
      previous executions so that you can start with a clean state.

   5) Run the publisher from the helloWorldPersistence directory
      (replace [domain_id] with the correct value, or omit it to use the default
      domain ID, 0):

      > objs/i86Linux2.6gcc3.4.3/HelloWorld_publisher [domain_id]

      On the screen, you will see:
      Writing HelloWorld, count 0
      Writing HelloWorld, count 1
      ...

   6) Run the subscriber from the helloWorldPersistence directory and verify 
      that it only receives one copy of the data
      (replace [domain_id] with the correct value, or omit it to use the default 
      domain ID, 0):

      > objs/i86Linux2.6gcc3.4.3/HelloWorld_subscriber [domain_id]

      The output will look something like this:
      HelloWorld subscriber sleeping for 4 sec...
         data: 0
         data: 1
         data: 2
         data: 3
      HelloWorld subscriber sleeping for 4 sec...
      ...

      The subscriber should not receive two data values with the same number.

   7) Stop the publisher by pressing CTRL-C.

   8) Start a new subscriber and verify that it receives samples from RTI 
      Persistence Service in the absence of the original publisher.

      > objs/i86Linux2.6gcc3.4.3/HelloWorld_subscriber [domain_id]

      The output will look something like this:
      HelloWorld subscriber sleeping for 4 sec...
         data: 0
         data: 1
         data: 2
         data: 3
         data: 4

   9) Stop RTI Persistence Service and the two subscribers by pressing CTRL-C.

  10) Restart RTI Persistence Service.

      > ${NDDSHOME}/scripts/rtipersistenceservice -cfgFile PsHelloWorld.xml 
        -cfgName <HelloWorldTT|HelloWorldMySQL|HelloWorldFile>
      RTI Persistence Service started

  11) Start a subscriber and verify that it receives the persisted samples from 
      RTI Persistence Service:

      > objs/i86Linux2.6gcc3.4.3/HelloWorld_subscriber [domain_id]

      The output will look something like this:
      HelloWorld subscriber sleeping for 4 sec...
         data: 0
         data: 1
         data: 2
         data: 3
         data: 4

  12) Stop the persistence service and the subscriber by pressing CTRL-C.


Windows Systems
---------------

   You can skip step 1 if you are using a file system to persist data.

   1) [Only for external databases] Create a DSN for the persistence service. To
      add a data source, follow these steps:

      a) Open the ODBC Data Source Administrator:

         Windows 2000 systems: 
             Select Start, Control Panel, Performance and Maintenance, 
             Administrative Tools, Data Sources (ODBC).

         Windows XP and Windows Server 2003 systems: 
             Select Start, Control Panel, Administrative Tools, Data Sources (ODBC).

         Windows Vista systems: 
             Select Start, Control Panel, System and Maintenance, Administrative Tools, 
             Data Sources (ODBC).

         Windows 7 and Windows Server 2008 R2: 
             Select Start, Control Panel, System and Security, Administrative Tools, 
             Data Sources (ODBC).

         Windows 8 and Windows Server 2012 R2:
             Select Start, Control Panel, System and Security, Administrative Tools, Data Source (ODBC).

      b) Select the User DSN tab.

      c) Click Add; the Create New Data Source dialog appears.

         For MySQL:
            - Select the MySQL driver from the list of drivers.
            - Click the Finish button; the MySQL ODBC Driver Configuration 
              dialog appears.
            - Fill out the fields in the dialog.
            - Enter "HelloWorldMySQL" as the Data Source Name (DSN);
            - Enter "test" as the User and "test" as the Password;
            - Select "test" as the Database;
            - All other fields can be left empty.
            - Click OK.

   2) If you want to run the publisher and subscriber in a domain ID other than 
      0, you have two choices:

      a) You can edit the configuration file PsHelloWorld.xml and replace the
      domain ID specified in the tag <domain_id>.
      b) You can use the command-line option -domainId 

      Note: During the next 2 steps, if you see error messages in the window 
      where you started RTI Persistence Service, please see the Troubleshooting 
      section at the end of this file.


   3) Run RTI Persistence Service by typing:

      > %NDDSHOME%\scripts\rtipersistenceservice.bat -cfgFile PsHelloWorld.xml 
      -cfgName <HelloWorldTTWindows|HelloWorldMySQL|HelloWorldFile> -restore 0

      On the screen, you will see:
      RTI Persistence Service started

      The value of cfgName depends on the persistent storage that you are using 
      to run the test:

      - Use HelloWorldMySQL to persist into MySQL
      - Use HelloWorldFile to persist into files

      Note: If you use HelloWorldFile, the files containing the samples will
      be located in the working directory by default. If you want to change
      the location you can use the tag <directory> under <filesystem>. 

      With -restore 0, RTI Persistence Service will delete the data persisted in 
      previous executions so that you can start with a clean state.

   4) Run the publisher from the helloWorldPersistence directory 
      (replace [domain_id] with the correct value, or omit it to use the 
      default domain ID, 0):

      > objs\i86Win32VS2005\HelloWorld_publisher [domain_id]

      On the screen, you will see:
      Writing HelloWorld, count 0
      Writing HelloWorld, count 1
      ...

   5) Run the subscriber from the helloWorldPersistence directory and verify 
      that it only receives one copy of the data (replace [domain_id] 
      with the correct value, or omit it to use the default domain ID, 0):

      > objs\i86Win32VS2005\HelloWorld_subscriber [domain_id]

      The output will look something like this:
      HelloWorld subscriber sleeping for 4 sec...
         data: 0
         data: 1
         data: 2
         data: 3
      HelloWorld subscriber sleeping for 4 sec...
      ...

      The subscriber should not receive two data values with the same number.

   6) Stop the publisher by pressing CTRL-C.

   7) Start a new subscriber and verify that it receives samples from 
      RTI Persistence Service in the absence of the original publisher:

      > objs\i86Win32VS2005\HelloWorld_subscriber [domain_id]

      The output will look something like this:
      HelloWorld subscriber sleeping for 4 sec...
         data: 0
         data: 1
         data: 2
         data: 3
         data: 4

   8) Stop RTI Persistence Service and the two subscribers by pressing CTRL-C.

   9) Restart RTI Persistence Service.

      > %NDDSHOME%\scripts\rtipersistenceservice.bat -cfgFile PsHelloWorld.xml 
        -cfgName <HelloWorldTTWindows|HelloWorldMySQL|HelloWorldFile>
      RTI Persistence Service started

  10) Start a subscriber a verify that it receives the persisted samples from 
      RTI Persistence Service:

      > objs\i86Win32VS2005\HelloWorld_subscriber [domain_id]

      The output will look something like this:
      HelloWorld subscriber sleeping for 4 sec...
         data: 0
         data: 1
         data: 2
         data: 3
         data: 4

  11) Stop RTI Persistence Service and the subscriber by pressing CTRL-C.


Optional Parameters
===================

The publisher and subscriber applications accept two optional arguments:

domain_id: 
For the two applications to communicate, they have to use the same domain ID. 
By default, both Hello World applications use domain ID 0. 
If you want to use a specific domain ID, enter it as the first argument 
(valid IDs are >=0). If you are sharing a machine with others, you may
want to use separate domain IDs.

number_of_samples: 
In the publishing application, the second parameter is used as the number of
samples to publish before terminating. 
In the subscribing application, the second parameter is used as the number of
4-second intervals for which it will sleep/awake before terminating.

For example, this uses domain ID 1 and sends 10 samples:
   > objs\i86Win32VS2005\HelloWorld_publisher 1 10


Please consult the RTI Connext (formerly, RTI Data Distribution Service) 
Platform Notes and online documentation for details.

Troubleshooting 
===============

---------------------------------------------------------
Can't connect to local MySQL server through socket (MySQL)
---------------------------------------------------------

When connecting to a MySQL server located on the local system, the mysql client 
connects through a local file called a socket instead of connecting to the 
localhost loopback address 127.0.0.1. For the mysql client,
the default location of this socket file is /tmp/mysql.sock. However, many
MySQL installations place this socket file somewhere else, such as /var/lib/
mysql/mysql.sock. You may see this error message when you start the
persistence service:

[unixODBC][MySQL][ODBC 5.1.6 Driver]Can't connect to local MySQL server through socket '/var/lib/mysql/mysql.sock'

To correct this error, specify the right socket file by changing the value of 
the attribute SOCKET in the DSN entry of the ODBCINI file (HelloWorldOdbcIni). 
For example: 

[HelloWorldMySQL]
DRIVER=/usr/lib/libmyodbc5.so
Database=test
SOCKET=/tmp/mysql.sock

