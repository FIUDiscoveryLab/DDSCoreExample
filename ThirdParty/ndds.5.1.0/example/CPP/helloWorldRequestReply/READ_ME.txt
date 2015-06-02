=====================================================
RTI Connext Messaging
Request-Reply Example Application
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
This example is composed of two applications: a requester and a replier.

To run this example on Windows, type the following in two different command
shells, either on the same machine or on different machines:

  > objs\<architecture>\PrimeNumberReplier [<domain_id>]
  > objs\<architecture>\PrimeNumberRequester <n> [<primes_per_reply> [<domain_id>]]

To run this example on a UNIX-based system, type the following in two
different command shells, either on the same machine or on different machines:

  > objs/<architecture>/PrimeNumberReplier [<domain_id>]
  > objs/<architecture>/PrimeNumberRequester <n> [<primes_per_reply> [<domain_id>]]

The Requester and the Replier are configured by the file USER_QOS_PROFILES.xml
located in this directory. You can modify this file to change the example's
behavior.

For more information on using Requesters and Repliers, please consult the 
RTI Core Libraries and Utilities Getting Started Guide and User's Manual.


