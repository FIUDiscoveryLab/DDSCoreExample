======================================
RTI Distributed Logger
Hello_file_logger Example Application
======================================

Welcome to RTI Distributed Logger.

Set Up the Environment
----------------------

There are a few things to take care of before you start 
working with the example code. 

1) Set the NDDSHOME environment variable

   Set the environment variable NDDSHOME to the RTI Connext 
   installation directory. For more information, see the RTI  
   Connext Core Libraries and Utilities Getting Started Guide.

2) Set the RTI_EXAMPLE_ARCH environment variable

   Set the environment variable RTI_EXAMPLE_ARCH to your system 
   architecture. Architectures are listed in both the RTI Connext 
   Core Libraries and Utilities Release Notes and Platform Notes 
   PDF documents.
   
   Example: RTI_EXAMPLE_ARCH=i86Win32jdk

3) Ensure that both javac and java are available on your PATH.

Compiling this Example
----------------------

To build this example on a Windows system, type the following 
in a command shell:

  > build

To build this example on a UNIX-based system, type the following 
in a command shell:

  > ./build.sh


To build this example for the Jamaica JVM on VxWorks:

* Ensure the environment for Vxworks and Jamaica is setup:

  * The JAMAICA environment variable should point to your Jamaica installation

example for Vxworks 6.7 kernel-mode:

export JAMAICA=/var/jamaica-6.2-1_vxworks-ppc6xx-be-dkm-6.7

  * The TARGETPLATFORM environment variable should point to a directory
    that exists under $JAMAICA/target/

example for VxWorks 6.7 kernel-mode:

export TARGETPLATFORM=vxworks-ppc6xx-be

  * Ensure that the RTI_EXAMPLE_ARCH environment variable is set

example for Vxworks 6.7 kernel-mode:

export RTI_EXAMPLE_ARCH=ppc604Vx6.7gcc4.1.2jdk


* run the following command from the host that will cross-compile:

./jamaica_build.sh

* To run the subscriber on the target:

  -> cd "/NDDSHOME/lib/<architecture>"
  -> ld 1< libnddscore.so
  -> ld 1< libnddsc.so
  -> cd "/NDDSHOME/example/JAVA/Distributed_Logger/Hello_file_logger"
  -> ld 1< com.rti.dl.example.FileLogger
  -> taskSpawn "DL_Test",255, 0x8, 150000, jvm_com_rti_dl_example_FileLogger

Note1: do ensure that the vxworks target has write permissions into the directory
from which the application is run, otherwise, the log_messages.txt file won't
get created.

About this Example
------------------

This example application shows how to subscribe to log messages 
generated from RTI Distributed Logger. The example writes the log 
messages to a file. The source of the log messages can be any number 
of applications running in the system. It will therefore create a 
'central' log file containing all of the messages from the system. 
This can be very useful for locating errors in the system. For example, 
the code can be modified to only log warning level or worse log 
messages. Then simply checking the size of the file would reveal if 
the system is having any trouble. This functionality can also be added 
to an existing logging system, producing a simple distributed 
debugging/status monitoring component.

Running this example by itself is not enough to generate the log file. 
You need to run at least one application that generates log messages.
This example will listen for those messages. 


Running this Example
--------------------

To run this example on a Windows system, type the following command:

  > run

To run this example on a UNIX-based system, type the following command:

  > ./run.sh



Command Line Options
--------------------

By default, this example will join domain 0 to listen for log messages. 
It will store the log messages in a file named 'log_messages.txt'. 
You can specify a filename on the command line, as well as the domain(s) 
that should be joined. There is no specific order that must be followed 
for these options. 

For example, to join domains 0, 1, and 2 and store the results in a 
file named 'system.log':

On a Windows system:
  > run 0 1 system.log 2

On a UNIX-based system:
  > ./run.sh 0 1 system.log 2


Notes
-----
RTI Distributed Logger uses type names that are specified in its IDL file. 
These are not, however, the 'standard' ones supplied from the code 
generator in the support classes. If you want to subscribe to the log 
messages in your own application, please use this example as a reference.
