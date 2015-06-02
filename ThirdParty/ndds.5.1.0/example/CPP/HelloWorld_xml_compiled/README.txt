========================================
CPP Hello World Example with XML Configuration
========================================

This example is a modified version of the helloWorld example that can
be generated using rtiddsgen with the -example command-line option.
The original example was modified to use XML configuration capabilities.


How to Compile
==============

Before compiling make sure the environment variable NDDSHOME is defined and it refers to your
RTI Connext installation directory. 


UNIX-based Systems
------------------

Use rtiddsgen to generate a makefile for your machine's architecture and
compiler. For example, if both the publisher and the subscriber application
will run on sparcSol2.10 machines and you want to compile with the gcc3.4.2
compiler, run rtiddsgen for the sparcSol2.10gcc3.4.2 architecture:

${NDDSHOME}/scripts/rtiddsgen -language C++ -example sparcSol2.10gcc3.4.2 HelloWorld.idl

NOTE: You may get messages saying that some files already exist and will
not be replaced. You can safely ignore those messages, since all the
source files for this example are already provided.

Before compiling, make sure that the desired version of compiler and linker
are in your PATH environment variable.

Then compile by typing:

gmake -f makefile_HelloWorld_sparcSol2.10gcc3.4.2


Windows Systems
---------------

Use rtiddsgen to generate the workspace/project files for your
version of Visual Studio. For example, if both the publisher and the
subscriber application will be compiled with Visual C++ 2005,
run rtiddsgen for the i86Win32VS2005 architecture:

%NDDSHOME\scripts\rtiddsgen -language C++ -example i86Win32VS2005 HelloWorld.idl

Open the solution file HelloWorld.sln with Visual C++ 2005. Build the
two projects, HelloWorld_publisher and HelloWorld_subscriber, with the 
Win32 Release setting (or Win32 Debug settings if you prefer).

How to Run
==========

1.  In your library search path, you MUST have the location of 
    the RTI Connext DDS shared libraries, because the applications
    will load the shared object dynamically when they start.

    For UNIX-based systems, you need to add the directory:
            $NDDSHOME/lib/<architecture>
    to your LD_LIBRARY_PATH.

    For Windows systems, you need to add the the directory:
            %NDDSHOME%\lib\<architecture>
    to your PATH environment variable.

2. On one machine, run the publisher:

   The executable may receive one argument:
   - Number of samples to send
   
   UNIX-based Systems:

   ./objs/<arch>/HelloWorld_publisher 

   Windows Systems:

   objs\<arch>\HelloWorld_publisher 


4. On another machine or terminal, run the subscriber:

   The executable may receive one argument:
   - Number of samples to receive

   UNIX-based Systems:

   ./objs/<arch>/HelloWorld_subscriber

   Windows Systems:

   objs\<arch>\HelloWorld_subscriber
