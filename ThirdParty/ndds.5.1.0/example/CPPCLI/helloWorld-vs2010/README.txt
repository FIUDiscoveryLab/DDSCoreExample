===========================
C++/CLI Hello World Example
===========================

An example publication and subscription pair to send and receive simple strings.

Purpose
=======

This example shows how to perform basic publish-subscribe communication.

For convenience, complete source code and a sample makefile for the 
i86Win32dotnet4.0 architecture are provided. 

How to Compile
==============

1. Make sure the environment variable NDDSHOME is defined before compiling
   the example.

2. Use rtiddsgen to generate the solution/project files for Visual Studio
   by entering the following at a command prompt: 

   rtiddsgen -language C++/CLI -example i86Win32dotnet4.0 HelloWorld.idl

   You should see the following message, which is normal output:
   rtinddsgenXXX.cc

3. Open the solution file, HelloWorld-dotnet2.0.sln, with Visual Studio 
   (.NET) 2010. 

4. Select the Win32 release configuration in the standard toolbar in 
   Visual Studio (.NET) 2010. 

5. From the Build menu, select Build Solution. This will build the 
   HelloWorld_publisher and HelloWorld_subscriber projects.

How to Run
==========

1. Make sure you have the RTI Data Distribution Service 'lib' directory for 
   i86Win32dotnet4.0 in your Path (%NDDSHOME%\lib\i86Win32dotnet4.0).

2. After compiling, you will find the application executables in 
   the 'Release' directory created by rtiddsgen. 

3. Open two command prompt windows in the 'Release' directory.

4. Run the subscriber by typing the following at a command prompt:

   HelloWorld_subscriber <Domain_ID> <Number_of_Samples>

   (The two optional arguments are explained below.)

5. Run the publisher by typing the following at the other command prompt:

   HelloWorld_publisher <Domain_ID> <Number_of_Samples>


Both applications accept two optional arguments:

<Domain_ID>: In order for the two applications to communicate, 
             they have to use the same domain ID number. By default, 
             both Hello World applications use domain ID 0. 

             If you want to use a specific domain ID, enter it as the first 
             argument (valid IDs are >=0). If you are sharing a machine with 
             others, you may want to use separate domain IDs.

<Number_of_Samples>: In the publishing application, the second parameter is 
                     the number of samples to publish before terminating. 
                     
                     In the subscribing application, the second parameter is 
                     the number of 4-second intervals for which it will 
                     sleep/awake before terminating.
Optional
========

You can specify the list of nodes that you want to talk to in an environment 
variable or a file called NDDS_DISCOVERY_PEERS. If your platform does not 
support multicast, or has multicast disabled by default, you must set this
list.

Please consult the Platform Notes and online documentation for details.
