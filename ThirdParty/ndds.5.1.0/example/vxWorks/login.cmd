# Description:
#
# This file is an example script for running RTI Connext on
# a VxWorks target.
#
# Copyright (c) 2011 by Real-Time Innovations. All rights reserved.

# The VxWorks function sethostname sets the name of your target.
#sethostname "lab1",4

# Specify the IP addresses of all of the hosts you wish
# to communicate with. These are the names of the machines in the 
# NDDS_DISCOVERY_PEERS environment variable
hostAdd "peck", "10.10.100.14"
hostAdd "emperor", "10.10.1.233"

# Specify the peers this node will interact with.
# The line below specifies that there is at most one participant on peck,
# and there are at most two on emperor. All participants will be discovered
# through the built-in UDPv4 plugin
putenv "NDDS_DISCOVERY_PEERS=udpv4://peck,1@udpv4://emperor,"

# Load RTI Connext libraries.
# The CPP library is unnecessary if you use only the C API
# Your kernel must be configured to include the zbuf module and the 
# timestamp module. The loader will print error messages if one of these 
# modules is missing.
# * Without the timestamp module, you will not be able to use the NDDS high
# resolution clock, which is OK for normal operation of
# RTI Connext.
# * Without the zbuf module, you must change the built-in UDPv4 transport
# to opt out of using zero copy sockets.
cd "C:/rti/waveworks/ndds.4.2/lib/pentiumVx5.5gcc"
ld 1 < libnddscore.so
ld 1 < libnddsc.so
ld 1 < libnddscpp.so

# Run your RTI Connext application
# Note that the stack size of the shell your are running this script in may
# be too small to run your RTI Connext application.
# In this case, use taskSpawn 
# instead of calling the entry point of the program directly.
cd "C:/rti/waveworks/ndds.4.1/example/CPP/helloWorld/objs/pentiumVx5.5gcc"
ld 1 < HelloWorld_subscriber.so
subscriber_main(0)
