========================================
RTI Connext (formerly, RTI Data Distribution Service)
HelloWorld_xml_compiled Example Application
========================================

Welcome to Connext.

This example is a modified version of the helloWorld example that can
be generated using rtiddsgen with the -example command-line option.
The original example was modified to use XML configuration capabilities.


How to Compile
==============

Before compiling make sure the environment variable NDDSHOME is defined and it refers to your
RTI Connext installation directory. 

Windows Systems
---------------

Use rtiddsgen to generate the workspace/project files for your
version of Visual Studio. For example, if both the publisher and the
subscriber application will be compiled with Visual C++ 2005,
run rtiddsgen for the i86Win32dotnet2.0 architecture:

%NDDSHOME%\scripts\rtiddsgen -language C# -example i86Win32dotnet2.0 HelloWorld.idl

Open the solution file HelloWorld-csharp.sln and build the
two projects, HelloWorld_publisher and HelloWorld_subscriber, with the 
Win32 Release setting (or Win32 Debug settings if you prefer).

How to Run
==========

1.  In your library search path, you MUST have the location of 
    the RTI Connext DDS shared libraries, because the applications
    will load the shared object dynamically when they start.

    For Windows systems, you need to add the the directory:
            %NDDSHOME%\lib\<architecture>
    to your PATH environment variable.

2. On one machine, run the publisher:

   The executable may receive one arguments:
   - Number of samples to send

   Windows Systems:

   bin\<i86|x64>\<Debug|Release>-<VS2010|VS2012>\HelloWorld_publisher 


4. On another machine or terminal, run the subscriber:

   The executable may receive one argument:
   - Number of samples to receive

   Windows Systems:

   bin\<i86|x64>\<Debug|Release>-<VS2010|VS2012>\HelloWorld_subscriber
