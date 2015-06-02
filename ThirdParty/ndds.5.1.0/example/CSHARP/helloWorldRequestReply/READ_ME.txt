=====================================================
RTI Connext (formerly, RTI Data Distribution Service)
Hello_idl Example Application
=====================================================

Welcome to Connext.


Compiling this Example
----------------------
To build this, open the appropriate solution file for your version of
Microsoft Visual Studio in the win32, win64, win32-vs2010, win64-vs2010,
win32-vs2012, or win64-vs2012 directory.


Running this Example
--------------------

To run this example, type the following in two different command shells,
either on the same machine or on different machines:

  > <win32|win64|win32-vs2010|win64-vs2010|win32-vs2012|win64-vs2012>\obj\<Debug|Release>\PrimeNumberReplier.exe [<domain_id>]
  > <win32|win64|win32-vs2010|win64-vs2010|win32-vs2012|win64-vs2012>\obj\<Debug|Release>\PrimeNumberRequester.exe <n> [<primes_per_reply> [<domain_id>]]
  
The Requester and the Replier are configured by the file USER_QOS_PROFILES.xml
located in this directory. You can modify this file to change the example's
behavior.

For more information on using Requesters and Repliers, please consult the 
RTI Core Libraries and Utilities Getting Started Guide and User's Manual.

