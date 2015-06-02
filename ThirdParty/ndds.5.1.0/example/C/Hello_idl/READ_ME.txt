=====================================================
RTI Connext (formerly, RTI Data Distribution Service)
Hello_idl Example Application
=====================================================

Welcome to Connext.


Compiling this Example
----------------------
To build this example on Windows, open the appropriate solution file for your
version of Microsoft Visual Studio in the win32/ directory.

To build this example on a UNIX-based system, type the following in a command
shell:

  > gmake -f make/Makefile.<architecture>


Running this Example
--------------------
This example application is configured by the file USER_QOS_PROFILES.xml
located in this directory. You can modify this file to change the example's
behavior, or you can replace it entirely with the contents of one of the
example files in the example/QoS/ directory.

To run this example on Windows, type the following in two different command
shells, either on the same machine or on different machines:

  > objs\<architecture>\Hello.exe sub
  > objs\<architecture>\Hello.exe pub

To run this example on a UNIX-based system, type the following in two
different command shells, either on the same machine or on different machines:

  > objs/<architecture>/Hello sub
  > objs/<architecture>/Hello pub

For more information, please consult your "Getting Started Guide."
