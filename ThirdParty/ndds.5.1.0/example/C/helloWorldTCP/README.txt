========================================
C Hello World Example with TCP Transport
========================================

This example is a modified version of the helloWorld example that can
be generated using rtiddsgen with the -example command-line option.
The original example was modified to use the TCP transport instead of
the built-in transports (UDPv4 and shared memory).

This example uses the DDS properties to configure the application to 
use the TCP Transport. For an example of how to statically link the
TCP transport into your application and use the RTI Connext
(formerly, RTI Data Distribution Service) transport API to configure 
the application, see the example, Hello_builtin_tcp.


Purpose
=======

This example shows how to create an instance of the TCP transport 
plugin and tell Connext to use it as the only communication mechanism 
between peers.

For convenience, complete source code and a sample makefile for an
architecture have been provided. Generate your own makefile or 
project file with rtiddsgen if you want to run the example
on other architectures.


How to Compile
==============

Make sure the environment variable NDDSHOME is defined before compiling
the example.

UNIX-based Systems
------------------

Use rtiddsgen to generate a makefile for your machine's architecture and
compiler. For example, if both the publisher and the subscriber application
will run on sparcSol2.10 machines and you want to compile with the gcc3.4.2
compiler, run rtiddsgen for the sparcSol2.10gcc3.4.2 architecture:

${NDDSHOME}/scripts/rtiddsgen -language C -example sparcSol2.10gcc3.4.2 HelloWorld.idl

You may get messages saying that some files already exist and will
not be replaced. You can safely ignore those messages, since all the
source files for this example are already provided.

Before compiling, make sure that the desired version of compiler and linker
are in your PATH environment variable.

Then compile by typing:

gmake -f makefile_HelloWorld_sparcSol2.10gcc3.4.2


Windows Systems
---------------

Use rtiddsgen to generate the workspace/project files for your
version of Visual Studio. For example, if both the publisher and the
subscriber application will be compiled with Visual C++ 2005,
run rtiddsgen for the i86Win32VS2005 architecture:

%NDDSHOME\scripts\rtiddsgen -language C -example i86Win32VS2005 HelloWorld.idl

Open the solution file HelloWorld.sln with Visual C++ 2005. Build the
two projects, HelloWorld_publisher and HelloWorld_subscriber, with the 
Win32 Release setting (or Win32 Debug settings if you prefer).

How to Run
==========

1.  In your library search path, you MUST have the location of 
    the transport plugin shared library, because the applications
    will load the shared object dynamically when they start.

    For UNIX-based systems, you need to add the directory:
            $NDDSHOME/lib/<architecture>
    to your LD_LIBRARY_PATH.

    For Windows systems, you need to add the the directory:
            %NDDSHOME%\lib\<architecture>
    to your PATH environment variable.

2. To test a WAN scenario, you need to know the public IP address
   of each peer and have the firewall correctly configured. 
   Refer to the Connext User's Manual for more details.

   For a LAN scenario or to run the publisher and subscriber on the
   same machine, see next section.

3. On one machine, run the publisher:

   UNIX-based Systems:

   export NDDS_DISCOVERY_PEERS=tcpv4_wan://<subscriber_public_ip:port>
   ./objs/<arch>/HelloWorld_publisher -a <public_ip:port> -p <bind_port>

   Windows Systems:

   set NDDS_DISCOVERY_PEERS=tcpv4_wan://<subscriber_public_ip:port>
   objs\<arch>\HelloWorld_publisher -a <public_ip:port> -p <bind_port>

   Replace <subscriber_public_ip:port> with the public IP and port of
   the remote peer that will run the subscriber.
   Replace <public_ip:port> with your public IP and port that are
   exposed to the outside network.
   Replace <bind_port> with the port number on your local machine
   to listen for incoming connections.
   See the example below for a real scenario.

   You can add the command-line option '-d <domain>' to specify a
   domain ID (if unset, domain ID 0 is used).

4. On another machine, run the subscriber:

   UNIX-based Systems:

   export NDDS_DISCOVERY_PEERS=tcpv4_wan://<publisher_public_ip:port>
   ./objs/<arch>/HelloWorld_subscriber -a <public_ip:port> -p <bind_port>

   Windows Systems:

   set NDDS_DISCOVERY_PEERS=tcpv4_wan://<publisher_public_ip:port>
   objs\<arch>\HelloWorld_subscriber -a <public_ip:port> -p <bind_port>

   Similarly, <publisher_public_ip:port> is the public IP and port of
   the publisher.


As an example, consider the following configuration:

PUBLISHER:
                       +-------------+
    +-----+            | Router &    |
    | pub |------------| Firewall    |
    +-----+            |             | public ip: 99.88.77.66
   192.168.1.10:7400   +-------------+ fwd port: 5555

   - The publisher application is running on the machine 
     at 192.168.1.10
   - The publisher application is using as bind port: 7400
   - The router has port forwarding configured as:
        src port: 5555, destination: 192.168.1.10:7400
   - The public IP of this network is 99.88.77.66

SUBSCRIBER:
                       +-------------+
    +-----+            | Router &    |
    | sub |------------| Firewall    |
    +-----+            |             | public ip: 11.22.33.44
   192.168.5.20:7400   +-------------+ fwd port: 4444

   - The subscriber application is running on the machine 
     at 192.168.5.20
   - The subscriber application is using as bind port: 7400
   - The router has port forwarding configured as:
        src port: 4444, destination: 192.168.5.20:7400
   - The public IP of this network is 11.22.33.44

In this case, use the following commands to start the example:

PUBLISHER:
  UNIX-based Systems:

    export NDDS_DISCOVERY_PEERS=tcpv4_wan://11.22.33.44:4444
    ./objs/<arch>/HelloWorld_publisher -a 99.88.77.66:5555 -p 7400

  Windows Systems:

    set NDDS_DISCOVERY_PEERS=tcpv4_wan://11.22.33.44:4444
    objs\<arch>\HelloWorld_publisher -a 99.88.77.66:5555 -p 7400

SUBSCRIBER:
  UNIX-based Systems:

    export NDDS_DISCOVERY_PEERS=tcpv4_wan://99.88.77.66:5555
    ./objs/<arch>/HelloWorld_subscriber -a 11.22.33.44:4444 -p 7400

  Windows Systems:

    set NDDS_DISCOVERY_PEERS=tcpv4_wan://99.88.77.66:5555
    objs\<arch>\HelloWorld_subscriber -a 11.22.33.44:4444 -p 7400

Notes: 
    You do not need to set the environment variable 
    NDDS_DISCOVERY_PEERS on both the publisher and subscriber; the
    discovery protocol will take care of propagating the public location
    to the other node as soon as communication is established,but keep 
    in mind that it may take a longer time for discovery to complete
    this way.

    You CAN use a symbolic name instead of a numeric IP address 
    when you specify the NDDS_DISCOVERY_PEERS value, but you MUST
    use a numeric IP address when you specify the public IP address of
    the network (the '-a' command-line option).

Running within a LAN
====================

When running within a LAN, you do not need to 
specify the '-a' parameter, because the transport will automatically 
use all the available network interface for communication.

Also remember that the WAN and LAN have two different transport IDs, 
so when you specify the locators, you need to use 'tcpv4_lan' 
instead of 'tcpv4_wan.'

Even if the machines are within the same LAN, you can still use the
WAN transport ID, but you will need to specify the '-a' parameter.


Running on the same machine
===========================

When running on the same host, make sure you use different <bind_port> 
for your publisher and subscriber applications.

For example, to run the publisher and subscriber on the same machine
using the LAN transport ID:

Publisher:
 UNIX-based Systems:
   export NDDS_DISCOVERY_PEERS=tcpv4_lan://localhost:7401
   ./objs/<arch>/HelloWorld_publisher -p 7400

 Windows Systems:
   set NDDS_DISCOVERY_PEERS=tcpv4_lan://localhost:7401
   objs\<arch>\HelloWorld_publisher -p 7400

Subscriber:
 UNIX-based Systems:
   export NDDS_DISCOVERY_PEERS=tcpv4_lan://localhost:7400
   ./objs/<arch>/HelloWorld_subscriber -p 7401

 Windows Systems:
   set NDDS_DISCOVERY_PEERS=tcpv4_lan://localhost:7400
   objs\<arch>\HelloWorld_subscriber -p 7401


Running with TLS enabled
========================

In order to use TCP transport with secure communication in Connext, 
you will need to install the optional packages, RTI TLS
support, and the OpenSSL library.

In its simplest form, only two properties are required to enable TLS secure
communication between different peers:
    tls.verify.ca_file - the certificate file
    tls.identity.certificate_chain_file - the certificate chain file

The two parameters are both required to enable TLS.
In this example, you can set the two above parameters with the following two
command-line arguments:
    --tls-cert <ca_cert>
    --tls-chain <cert_chain>

When the two parameters are specified to valid files, the transport will
run using TLS enabled.

Example certificates for two peers are included in this example.

The internal behavior of the transport plugin will be exactly the same
as the case with security disabled, except that all the sockets used rely on
openssl for encryption.

IMPORTANT NOTES:
1. If you use TLS, you must set the transport's class ID to one of the following
   constants in your user application:
        NDDS_TRANSPORT_CLASSID_TLSV4_WAN
        NDDS_TRANSPORT_CLASSID_TLSV4_LAN

   This example application automatically sets this class ID for you
   based on the command line arguments.

2. Remember also that you MUST use the prefix 'tlsv4_lan://', or 'tlsv4_wan://' 
   instead of 'tcpv4_lan://' and 'tcpv4_wan://' when you define your initial
   peer host. 

   ALSO NOTE THAT TCP AND TLS ARE NOT INTEROPERABLE!
   One peer implementing secure connection can never talk with another peer that
   uses the un-encrypted TCP connection.

3. In order to break the dependency between the TCP transport library and the 
   OpenSSL library, when TLS security is enabled, the transport will 
   dynamically 

   load the following library:
        Unix:   libnddstls.so (release version)
                libnddstlsd.so (debug version)
        Windows:nddstls.dll (release version)
                ndstlsd.dll (debug version)
   
   The NDDSTLS Library will then dynamically load the OpenSSL during its
   initialization.

   In conclusion, ONLY WHEN TLS IS ENABLED:
        - TCP transport library will dynamically load the NDDS TLS library
        - NDDS TLS library will dynamically load the OpenSSL library

   YOU MUST ENSURE THAT THE ABOVE LIBRARIES ARE PRESENT IN YOUR SEARCH PATH 
   BEFORE STARTING YOUR APPLICATION (if your application enables TLS!).
   This requirement is not needed if your application does not use TLS.

4. In symmetric communication scenarios, any Connext
   application can initiate TCP connections with other applications.

   In asymmetric communication scenarios, TCP connections can be
   initiated only by one Connext instance. For
   security reasons, any incoming connection from the other instance is
   not allowed.

   By running the example as stated above with TLS enabled, it is runing in
   symmetric mode.

   To run in asymmetric mode, leave the NDDS_DISCOVERY_PEERS unset on
   the server side, and not provide the "-a" and "-p" command line
   arguments on the client side (because the client side has no publicly
   reachable address:port).