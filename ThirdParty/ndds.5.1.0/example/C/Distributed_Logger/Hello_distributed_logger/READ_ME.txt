=============================
RTI Distributed Logger
Hello_distributed_logger Example Application
=============================


Set Up the Environment
----------------------

There are a few things to take care of before you start 
working with the example code. Make sure you know your 
architecture string and use it in place of 
<architecture> in the instructions below. Architecture 
strings are listed in both the RTI Connext Core Libraries
and Utilities Release Notes and Platform Notes PDF documents.

1) Set the NDDSHOME environment variable.

   Set the environment variable NDDSHOME to the RTI Connext
   installation directory. For more information, see the RTI  
   Connext Core Libraries and Utilities Getting Started Guide.

2) Make sure the dynamic libraries are available.

   If you link the example statically, you can skip 
   this step.


[Windows Systems]

Add the directory %NDDSHOME%/lib/<architecture> to your 
Path environment variable. 

[UNIX-Based Systems]

Add the directory $NDDSHOME/lib/<architecture> to your 
LD_LIBRARY_PATH environment variable.

[Mac OS Systems]

Add the directory $NDDSHOME/lib/<architecture> to your 
DYLD_LIBRARY_PATH environment variable.

[VxWorks Systems]

By default, this example will build with static libraries. However,
if you will be using shared libraries, you need to load the 
RTI Connext libraries before you load the compiled example.
 
Libraries would need to be loaded in the proper order. If you are only
using the C API's, there's no need to load the CPP libraries. For example:

 cd "C:/rti/waveworks/ndds.5.0.0/lib/ppce500v2Vx6.9gcc4.3.3"
 ld 1 < libnddscore.so
 ld 1 < libnddsc.so
 ld 1 < librtidlc.so



Compiling this Example
----------------------

[Windows Systems]

To build this example on a Windows system, open the appropriate 
solution file for your version of Microsoft Visual Studio in the 
win32/ directory.

The solution Configuration combo box in the toolbar indicates 
whether you are building debug or release executables and whether 
you are linking statically or dynamically.

[UNIX-Based Systems]

To build this example on a UNIX-based system, type the following 
in a command shell:

  > gmake -f make/Makefile.<architecture>

To select between Release and Debug compilation, use the 
variable DEBUG. 

To select between dynamic and static linking, use the variable 
SHAREDLIB.



Running this Example
--------------------

[Windows Systems]

To run this example on a Windows system, type the following in 
a command shell:

  > objs\<architecture>\Hello.exe 


[UNIX-Based Systems]

To run this example on a UNIX-based system, type the following 
in a command shell:

  > objs/<architecture>/Hello

 
[VxWorks Systems]

The stack size of the thread in which you are running needs to be 
big enough to run your RTI Connext application. 

To run this example on a VxWorks system in kernel mode, type the
following command within a telnet session or a hostShell C-interpreter
session. In this case, use taskSpawn instead of calling the entry point
of the program directly, for instance:

  -> cd "objs\<architecture>"
  -> ld 1 < Hello.so
  -> taskSpawn "DL_Test",255, 0x8, 150000, hello_main, 0

To run this example on a VxWorks system in RTP mode from the C interpreter,
you can use the rtpSpawn command, as this will let you control the stackSize.
For instance:

  -> cd "objs\<architecture>"
  -> rtpSpawn "Hello.vxe", 0, 0, 100, 0x150000, 0, 0

For more information, please see the RTI Connext Core Libraries
and Utilities Getting Started Guide.
