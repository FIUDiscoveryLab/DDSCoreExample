=============================
RTI Data Distribution Service
Hello_log4j_logging Example Application
=============================

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
  -> cd "/NDDSHOME/example/JAVA/Distributed_Logger/Hello_log4j_logging"
  -> ld 1< com.rti.hello.Hello
  -> taskSpawn "DL_Test",255, 0x8, 150000, jvm_com_rti_hello_Hello, "sub"


About this Example
------------------

This example application shows how to use the Distributed Logger as an 
integrated component of a logging system. In this example, Distributed
Logger is integrated with Log4j, a popular open-source logging library. 
The integration is done through the configuration file log4j.properties. 
This file configures the Distributed Logger and attaches it as a log 
message appender.

It is important to note that there are very few application code changes 
needed to do this integration. There's a call to DistLogger.delete() when 
the application is prepared to do a proper shutdown. That's the only change.

Please note that the Distributed Logger configuration specifies a QoS 
library and profile to be used. This is done because the example changes 
RTI's default QoS and this new QoS is not compatible with the QoS used 
by our other products out of the box. The specified configuration 
addresses this situation for Distributed Logger's DDS entities.

Also note that while the Distributed Logger overrides the 'close()'
method in the Appender interface, this method does not appear to be 
called when the application is terminated through a Control-C. As such, 
Distributed Logger cannot do a proper shutdown of its DDS entities. So 
the DomainParticipant and process will appear even after termination as 
they will be awaiting their timeout.


Running this Example
--------------------

This example application is configured by the file USER_QOS_PROFILES.xml 
in this directory. You can modify this file to change the example's
behavior, or you can replace it entirely with the contents of one of the
example files in the example/QoS/ directory.

To run this example on a Windows system, type the following in two 
different command shells, either on the same machine or different machines:

  > run sub
  > run pub

To run this example on a UNIX-based system, type the following in two
different command shells, either on the same machine or different machines:

  > ./run.sh sub
  > ./run.sh pub
