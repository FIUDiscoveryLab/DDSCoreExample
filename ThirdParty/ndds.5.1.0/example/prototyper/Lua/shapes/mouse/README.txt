In this example we assume a linux system.

1) build the provided 'mouse.c' file by simply typing

    make

This step will generate 'mouse.so'

NOTE: Be sure you have lua installed on your machine. In RedHat-like
machines you can install by
	# yum install lua lua-devel
Also, you want to be sure to use lua version 5.2

2) run rtiddsprototyper

	$NDDSHOME/scripts/rtiddsprototyper -cfgFile ../../USER_QOS_PROFILES.xml
		-cfgName MyParticipantLibrary::ShapePublisher
        -luaFile MouseInputAdaptor.lua

3) Run RTI ShapesDemo and subscribe to Square topic

   you should see a square moving on the screen when the mouse is moved

NOTE: to change the device, edit the define MOUSEFILE into the mouse.c file


