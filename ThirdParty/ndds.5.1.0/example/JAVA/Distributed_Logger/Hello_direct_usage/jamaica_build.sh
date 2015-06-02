#!/bin/sh
###############################################################################
##         (c) Copyright, Real-Time Innovations, All rights reserved.        ##
##                                                                           ##
##         Permission to modify and use for internal purposes granted.       ##
## This software is provided "as is", without warranty, express or implied.  ##
##                                                                           ##
###############################################################################

# You can override the following settings with the correct location of Jamaica
if [ -z "$JAMAICA" ]; then
    JAMAICAC=`which jamaicac`
    JAMAICABUILDER=`which jamaicabuilder`
else
    JAMAICAC="$JAMAICA/bin/jamaicac"
    JAMAICABUILDER=$JAMAICA/bin/jamaicabuilder
fi

# Make sure JAMAICAC, JAMAICABUILDER and NDDSHOME are set correctly
test -z "$JAMAICAC" && echo "jamaicac not found" && exit 1
test -z "$JAMAICABUILDER" && echo "jamaicabuilder not found" && exit 1
test -z "$NDDSHOME" && echo "NDDSHOME environment variable not set" && exit 1
test -z "$TARGETPLATFORM" && echo "TARGETPLATFORM environment variable not set" && exit 1
test -z "$RTI_EXAMPLE_ARCH" && echo "RTI_EXAMPLE_ARCH environment variable not set" && exit 1

# Ensure this script is invoked from the root directory of the project
test ! -d src && echo "You must run this script from the example root directory" && exit 1

ALL_SRC=`find src/com/rti/dl/example -name \*.java`
mkdir -p objs

# Builds all files from 'src' to 'objs'
echo "Building all the sources in 'src' into 'objs' directory..."
$JAMAICAC -useTarget $TARGETPLATFORM -d objs -classpath "$NDDSHOME/class/nddsjava.jar":"$NDDSHOME/class/distlog.jar" $ALL_SRC

echo "Generating code for Jamaica target $TARGETPLATFORM and RTI target $RTI_EXAMPLE_ARCH ..."
$JAMAICABUILDER -classpath objs:"$NDDSHOME"/class/nddsjava.jar:"$NDDSHOME"/class/distlog.jar -includeJar="$NDDSHOME"/class/nddsjava.jar:"$NDDSHOME"/class/distlog.jar -XlibraryPaths="$NDDSHOME"/lib/${RTI_EXAMPLE_ARCH} -XstaticLibraries="nddsjavaz" -setGraphics=none -interpret -target=$TARGETPLATFORM -destination=com.rti.dl.example.DirectUsageExample com.rti.dl.example.DirectUsageExample
