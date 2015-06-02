======================================
RTI Distributed Logger
Hello_direct_usage Example Application
======================================

Welcome to RTI Distributed Logger.

Set Up the Environment
----------------------

There are a few things to take care of before you start 
working with the example code. 

1) Set the NDDSHOME environment variable.

   Set the environment variable NDDSHOME to the RTI Connext 
   installation directory. For more information, see the RTI  
   Connext Core Libraries and Utilities Getting Started Guide.

2) Set the RTI_EXAMPLE_ARCH environment variable.

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

To build this example on a UNIX-based system, type the 
following in a command shell:

  > ./build.sh



To build this example for the Jamaica JVM on VxWorks:

* Ensure the environment for Vxworks and Jamaica is setup

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

* To run on the target:

  -> cd "/NDDSHOME/lib/<architecture>"
  -> ld 1< libnddscore.so
  -> ld 1< libnddsc.so
  -> cd "/NDDSHOME/example/JAVA/Distributed_Logger/Hello_direct_usage"
  -> ld 1< com.rti.dl.example.DirectUsageExample
  -> taskSpawn "DL_Test",255,0x8,150000,jvm_com_rti_dl_example_DirectUsageExample


About this Example
------------------

This example application shows how to use the Distributed Logger 
API directly. The example creates the Distributed Logger with 
options to name it and place it into domain 0. If you want to see 
the output of this application, start RTI Monitor and join 
domain 0. RTI Monitor can also control various Distributed Logger 
operational settings at run time.

The application logic simply logs messages at various levels for 
illustrative purposes. To see an example in which Distributed 
Logger is integrated into a logging system, see the 
Hello_log4j_logging or Hello_java_util_logging examples.


Running this Example
--------------------
To run this example on a Windows system, type the following 
command:

  > run

To run this example on a UNIX-based system, type the following 
command:

  > ./run.sh
