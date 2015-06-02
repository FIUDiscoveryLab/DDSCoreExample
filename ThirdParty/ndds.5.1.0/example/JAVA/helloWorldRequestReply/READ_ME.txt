=====================================================
RTI Connext Messaging
Request-Reply Example Application
=====================================================

Welcome to Connext.


Compiling this Example
----------------------
Set NDDSHOME to your RTI Connext installation directory. 

On Windows, if your NDDSHOME path has spaces in it, 
make sure you do NOT surround it with quotes.

e.g: SET NDDSHOME=C:\Program Files\RTI\ndds.5.1.0

To build this example on Windows, type the following in a command shell:

  > build

To build this example on a UNIX-based system, type the following in a command
shell:

  > ./build.sh

To remove all the generated files (.class files), just delete the 'objs'
directory. 

On Unix:
  > rm -Rf objs

On Windows
  > RD /S /Q OBJS


Running this Example
--------------------
This example is composed of two applications: a requester and a replier.

To run this example on Windows, type the following in two different command
shells, either on the same machine or on different machines:

  > run_replier [<domain_id>]
  > run_requester <n> [<primes_per_reply> [<domain_id>]]

To run this example on a UNIX-based system, type the following in two
different command shells, either on the same machine or on different machines:

  > ./run_replier.sh [<domain_id>]
  > ./run_requester.sh <n> [<primes_per_reply> [<domain_id>]]


For more information on using Requesters and Repliers, please consult the 
RTI Core Libraries and Utilities Getting Started Guide and User's Manual.

