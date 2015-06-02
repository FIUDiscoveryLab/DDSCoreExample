=====================================================
RTI Connext (formerly, RTI Data Distribution Service)
Hello_simple Example Application
=====================================================

Welcome to Connext.


Compiling this Example
----------------------

Generate the HelloWorld type by running:

  > rtiddsgen -language Java -example <jdk_architecture>
              -package com.rti.hello.idl HelloWorld.idl

To build this example, type the following in a command
shell:

  > gmake -f makefile_HelloWorld_<jdk_architecture>


Running this Example
--------------------
To run this example, type the following in two
different command shells, either on the same machine or on different machines:

  > gmake -f makefile_HelloWorld_<jdk_architecture> HelloWorldSubscriber
  > gmake -f makefile_HelloWorld_<jdk_architecture> HelloWorldPublisher

For more information, please consult your "Getting Started Guide."
