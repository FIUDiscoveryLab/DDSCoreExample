@ECHO OFF
SETLOCAL
REM ###########################################################################
REM #        (c) Copyright, Real-Time Innovations, All rights reserved.       #
REM #                                                                         #
REM #        Permission to modify and use for internal purposes granted.      #
REM # This software is provided "as is", without warranty, express or implied #
REM #                                                                         #
REM ###########################################################################


REM Make sure NDDSHOME is set correctly
IF NOT DEFINED NDDSHOME (
    ECHO NDDSHOME environment variable is not set
    GOTO ENDSCRIPT
)
SET NDDSHOME_NQ=%NDDSHOME:"=%

IF DEFINED JAVAC (
    GOTO SKIP_JAVAC_CHECK
)
SET JAVAC=javac.exe
REM Make sure javac.exe is in the search path
SET PATH_NQ=%PATH:"=%
FOR %%F IN (javac.exe) DO IF NOT EXIST %%~$PATH_NQ:F (
    ECHO Error: javac.exe not found in current search path.
    ECHO Make sure that Java SDK is correctly installed and you have the
    ECHO compiler in the search path.
    GOTO ENDSCRIPT
)
:SKIP_JAVAC_CHECK

REM Ensure this script is invoked from the root directory of the project
IF NOT EXIST SRC (
    ECHO You must run this script from the example root directory
    GOTO ENDSCRIPT
)

REM Re-generate the type code from the IDL
IF NOT EXIST SRC\COM\RTI\HELLO\IDL\HelloWorld.java (
    ECHO Generating type-support code from IDL file
    CD SRC
    CALL "%NDDSHOME_NQ%\scripts\rtiddsgen.bat" -package com.rti.hello.idl -language Java -ppDisable -replace HelloWorld.idl
    CD ..
)    

REM Ensure the 'objs' directory exists
IF NOT EXIST objs (
    MD objs
)

ECHO Building all the sources in 'src' into 'objs' directory...
FOR /R SRC %%F IN (*.java) DO %JAVAC% -d objs -sourcepath src -classpath "%NDDSHOME_NQ%\class\nddsjava.jar";"%NDDSHOME_NQ%\class\distlog.jar";"%NDDSHOME_NQ%\class\log4j-1.2.16.jar" "%%F"

GOTO ENDSCRIPT

:ENDSCRIPT:
