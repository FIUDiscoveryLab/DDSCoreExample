#!/bin/sh
###############################################################################
##         (c) Copyright, Real-Time Innovations, All rights reserved.        ##
##                                                                           ##
##         Permission to modify and use for internal purposes granted.       ##
## This software is provided "as is", without warranty, express or implied.  ##
##                                                                           ##
###############################################################################

# You can override the following settings with the correct location of Java
if [ -z "$RTIJDKHOME" ]; then
    JAVAC=`which javac`
else
    JAVAC="$RTIJDKHOME/bin/javac"
fi

# Make sure JAVAC and NDDSHOME are set correctly
test -z "$JAVAC" && echo "javac not found" && exit 1
test -z "$NDDSHOME" && echo "NDDSHOME environment variable not set" && exit 1

# Ensure this script is invoked from the root directory of the project
test ! -d src && echo "You must run this script from the example root directory" && exit 1

if [ ! -f src/com/rti/hello/idl/HelloWorld.java ]; then
    # Re-generate the type support code from the IDL file
    echo "Remaking the type-support code..."
    cd src
#    mkdir -p com/rti/hello/idl
    $NDDSHOME/scripts/rtiddsgen -package com.rti.hello.idl -language Java -replace HelloWorld.idl
    cd ..
fi

ALL_SRC=`find src/com/rti/hello -name \*.java`
mkdir -p objs

# Builds all files from 'src' to 'objs'
echo "Building all the sources in 'src' into 'objs' directory..."
$JAVAC -d objs -classpath "$NDDSHOME/class/nddsjava.jar":"$NDDSHOME/class/distlog.jar":"$NDDSHOME/class/log4j-1.2.16.jar" $ALL_SRC

