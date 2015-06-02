=====================================================
RTI Connext (formerly, RTI Data Distribution Service)
HelloWorld_dynamic Example Application
=====================================================

How to Compile
==============

Before compiling make sure the environment variable NDDSHOME is defined and it refers to your
RTI Connext installation directory. 


Compiling this Example
======================

Set NDDSHOME to your RTI Connext installation directory.

* Windows Systems

To build this example on Windows, open the appropriate solution file for your
version of Microsoft Visual Studio located in the win directory.

* UNIX-based Systems

Type the following in a command where <architecture> is replaced with the string that identifies 
the machine's architecture and compiler. For example, i86Linux2.6gcc4.4.3 identifies a 
Linux 2.6 OS platform that has the 4.4.3 version of the GNU GCC compiler:

  > make -f make/Makefile.<architecture>
  For example:
  make -f make/Makefile.i86Linux2.6gcc4.4.3

Note that in some systems  the command 'make' is called 'gmake'.
You can see a complete list of the architectures you have available by listing the directory:
$NDDSHOME/lib


How to Run
==========

1.  If you compiled dynamically, you need to specify the location
    of the RTI Connext DDS shared libraries.

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

   ./objs/<architecture>/HelloWorld_publisher 

   Windows Systems:

   objs\<architecture>\HelloWorld_publisher 


4. On another machine or terminal, run the subscriber:

   The executable may receive one argument:
   - Number of samples to receive

   UNIX-based Systems:

   ./objs/<architecture>/HelloWorld_subscriber

   Windows Systems:

   objs\<architecture>\HelloWorld_subscriber

