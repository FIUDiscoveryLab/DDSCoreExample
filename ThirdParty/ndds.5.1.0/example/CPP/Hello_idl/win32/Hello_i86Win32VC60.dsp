# Microsoft Developer Studio Project File - Name="Hello" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=Hello - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "Hello_i86Win32VC60.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "Hello_i86Win32VC60.mak" CFG="Hello - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "Hello - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "Hello - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE "Hello - Win32 Release DLL" (based on "Win32 (x86) Console Application")
!MESSAGE "Hello - Win32 Debug DLL" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "Hello - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "../objs/i86Win32VC60"
# PROP Intermediate_Dir "../objs/i86Win32VC60"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /MT /W3 /GX /O2 /I "$(NDDSHOME)/include" /I "$(NDDSHOME)/include/ndds" /I "..\src\idl" /I "..\src" /D "WIN32" /D "RTI_WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /FD /c
# SUBTRACT CPP /YX /Yc /Yu
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib netapi32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib gdi32.lib winspool.lib comdlg32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 nddscppz.lib nddscz.lib nddscorez.lib WS2_32.lib  kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386 /out:"../objs/i86Win32VC60/Hello.exe" /libpath:"c:/Program Files/Microsoft Platform SDK for Windows Server 2003 R2/lib" /libpath:"$(NDDSHOME)/lib/i86Win32VC60"

!ELSEIF  "$(CFG)" == "Hello - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "../objs/i86Win32VC60"
# PROP Intermediate_Dir "../objs/i86Win32VC60"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /GZ /c
# ADD CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /I "$(NDDSHOME)/include" /I "$(NDDSHOME)/include/ndds" /I "..\src\idl" /I "..\src" /D "WIN32" /D "RTI_WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /FD /GZ /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib netapi32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib gdi32.lib winspool.lib comdlg32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 nddscppzd.lib nddsczd.lib nddscorezd.lib WS2_32.lib  kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /out:"../objs/i86Win32VC60/Hello.exe" /pdbtype:sept /libpath:"c:/Program Files/Microsoft Platform SDK for Windows Server 2003 R2/lib" /libpath:"$(NDDSHOME)/lib/i86Win32VC60"

!ELSEIF  "$(CFG)" == "Hello - Win32 Release DLL"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release_DLL"
# PROP BASE Intermediate_Dir "Release_DLL"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "../objs/i86Win32VC60"
# PROP Intermediate_Dir "../objs/i86Win32VC60"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GX /O2 /I "$(NDDSHOME)/include" /I "$(NDDSHOME)/include/ndds" /D "WIN32" /D "RTI_WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /MD /W3 /GX /O2 /I "$(NDDSHOME)/include" /I "$(NDDSHOME)/include/ndds" /I "..\src\idl" /I "..\src" /D "NDDS_DLL_VARIABLE" /D "WIN32" /D "RTI_WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /FD /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386 /libpath:"c:/Program Files/Microsoft Platform SDK for Windows Server 2003 R2/lib" /libpath:"$(NDDSHOME)/lib/i86Win32VC60"
# ADD LINK32 nddscpp.lib nddsc.lib nddscore.lib WS2_32.lib  kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386 /out:"../objs/i86Win32VC60/Hello.exe" /libpath:"c:/Program Files/Microsoft Platform SDK for Windows Server 2003 R2/lib" /libpath:"$(NDDSHOME)/lib/i86Win32VC60"

!ELSEIF  "$(CFG)" == "Hello - Win32 Debug DLL"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug_DLL"
# PROP BASE Intermediate_Dir "Debug_DLL"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "../objs/i86Win32VC60"
# PROP Intermediate_Dir "../objs/i86Win32VC60"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /I "$(NDDSHOME)/include" /I "$(NDDSHOME)/include/ndds" /D "NDDS_DLL_VARIABLE" /D "WIN32" /D "RTI_WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /GZ /c
# ADD CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /I "$(NDDSHOME)/include" /I "$(NDDSHOME)/include/ndds" /I "..\src\idl" /I "..\src" /D "NDDS_DLL_VARIABLE" /D "WIN32" /D "RTI_WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /FD /GZ /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept /libpath:"c:/Program Files/Microsoft Platform SDK for Windows Server 2003 R2/lib" /libpath:"$(NDDSHOME)/lib/i86Win32VC60"
# ADD LINK32 nddscppd.lib nddscd.lib nddscored.lib WS2_32.lib  kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /out:"../objs/i86Win32VC60/Hello.exe" /pdbtype:sept /libpath:"c:/Program Files/Microsoft Platform SDK for Windows Server 2003 R2/lib" /libpath:"$(NDDSHOME)/lib/i86Win32VC60"

!ENDIF 

# Begin Target

# Name "Hello - Win32 Release"
# Name "Hello - Win32 Debug"
# Name "Hello - Win32 Release DLL"
# Name "Hello - Win32 Debug DLL"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=..\src\Hello.cxx
# End Source File
# Begin Source File

SOURCE=..\src\HelloPublisher.cxx
# End Source File
# Begin Source File

SOURCE=..\src\HelloSubscriber.cxx
# End Source File
# End Group
# Begin Group "Type Plugin Files"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\src\idl\HelloWorld.cxx
# End Source File
# Begin Source File

SOURCE=..\src\idl\HelloWorld.h
# End Source File
# Begin Source File

SOURCE=..\src\idl\HelloWorldPlugin.cxx
# End Source File
# Begin Source File

SOURCE=..\src\idl\HelloWorldPlugin.h
# End Source File
# Begin Source File

SOURCE=..\src\idl\HelloWorldSupport.cxx
# End Source File
# Begin Source File

SOURCE=..\src\idl\HelloWorldSupport.h
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=..\src\Hello.h
# End Source File
# End Group
# Begin Source File

SOURCE=..\src\HelloWorld.idl

!IF  "$(CFG)" == "Hello - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build - Regeneration type support plugin from $(InputPath)
InputPath=..\src\HelloWorld.idl

BuildCmds= \
	mkdir ..\src\idl \
	$(NDDSHOME)/scripts/rtiddsgen -replace -language C++ -d ../src/idl  ../src/$(InputPath) \
	

"../src/idl/HelloWorld.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)

"../src/idl/HelloWorld.cxx" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)

"../src/idl/HelloWorldPlugin.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)

"../src/idl/HelloWorldPlugin.cxx" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)

"../src/idl/HelloWorldSupport.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)

"../src/idl/HelloWorldSupport.cxx" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)
# End Custom Build

!ELSEIF  "$(CFG)" == "Hello - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build - Regeneration type support plugin from $(InputPath)
InputPath=..\src\HelloWorld.idl

BuildCmds= \
	mkdir ..\src\idl \
	$(NDDSHOME)/scripts/rtiddsgen -replace -language C++ -d ../src/idl  ../src/$(InputPath) \
	

"../src/idl/HelloWorld.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)

"../src/idl/HelloWorld.cxx" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)

"../src/idl/HelloWorldPlugin.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)

"../src/idl/HelloWorldPlugin.cxx" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)

"../src/idl/HelloWorldSupport.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)

"../src/idl/HelloWorldSupport.cxx" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)
# End Custom Build

!ELSEIF  "$(CFG)" == "Hello - Win32 Release DLL"

# PROP Ignore_Default_Tool 1
# Begin Custom Build - Regeneration type support plugin from $(InputPath)
InputPath=..\src\HelloWorld.idl

BuildCmds= \
	mkdir ..\src\idl \
	$(NDDSHOME)/scripts/rtiddsgen -replace -language C++ -d ../src/idl  ../src/$(InputPath) \
	

"../src/idl/HelloWorld.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)

"../src/idl/HelloWorld.cxx" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)

"../src/idl/HelloWorldPlugin.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)

"../src/idl/HelloWorldPlugin.cxx" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)

"../src/idl/HelloWorldSupport.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)

"../src/idl/HelloWorldSupport.cxx" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)
# End Custom Build

!ELSEIF  "$(CFG)" == "Hello - Win32 Debug DLL"

# PROP Ignore_Default_Tool 1
# Begin Custom Build - Regeneration type support plugin from $(InputPath)
InputPath=..\src\HelloWorld.idl

BuildCmds= \
	mkdir ..\src\idl \
	$(NDDSHOME)/scripts/rtiddsgen -replace -language C++ -d ../src/idl  ../src/$(InputPath) \
	

"../src/idl/HelloWorld.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)

"../src/idl/HelloWorld.cxx" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)

"../src/idl/HelloWorldPlugin.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)

"../src/idl/HelloWorldPlugin.cxx" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)

"../src/idl/HelloWorldSupport.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)

"../src/idl/HelloWorldSupport.cxx" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)
# End Custom Build

!ENDIF 

# End Source File
# End Target
# End Project
