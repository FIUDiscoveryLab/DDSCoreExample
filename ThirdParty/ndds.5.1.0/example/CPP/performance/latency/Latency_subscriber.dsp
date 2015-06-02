# Microsoft Developer Studio Project File - Name="Latency_subscriber" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=Latency_subscriber - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "Latency_subscriber.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "Latency_subscriber.mak" CFG="Latency_subscriber - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "Latency_subscriber - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "Latency_subscriber - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE "Latency_subscriber - Win32 Release DLL" (based on "Win32 (x86) Console Application")
!MESSAGE "Latency_subscriber - Win32 Debug DLL" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "Latency_subscriber - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "objs/i86Win32VC60"
# PROP Intermediate_Dir "objs/i86Win32VC60"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /MT /W3 /GX /O2 /I "$(NDDSHOME)/include" /I "$(NDDSHOME)/include/ndds" /D "NDEBUG" /D "WIN32" /D "RTI_WIN32" /D "_CONSOLE" /D "_MBCS" /D "RTI_SHARED_MEMORY" /YX /FD /c
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib netapi32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib  odbc32.lib odbccp32.lib kernel32.lib gdi32.lib winspool.lib comdlg32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 nddscppz.lib nddscz.lib nddscorez.lib WS2_32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386 /libpath:"$(NDDSHOME)/lib/i86Win32VC60"

!ELSEIF  "$(CFG)" == "Latency_subscriber - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "objs/i86Win32VC60"
# PROP Intermediate_Dir "objs/i86Win32VC60"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /GZ /c
# ADD CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /I "$(NDDSHOME)/include" /I "$(NDDSHOME)/include/ndds" /D "_DEBUG" /D "WIN32" /D "RTI_WIN32" /D "_CONSOLE" /D "_MBCS" /D "RTI_SHARED_MEMORY" /YX /FD /GZ /c
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib netapi32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib  odbc32.lib odbccp32.lib kernel32.lib gdi32.lib winspool.lib comdlg32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 nddscppzd.lib nddsczd.lib nddscorezd.lib WS2_32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept /libpath:"$(NDDSHOME)/lib/i86Win32VC60"

!ELSEIF  "$(CFG)" == "Latency_subscriber - Win32 Release DLL"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release_DLL"
# PROP BASE Intermediate_Dir "Release_DLL"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "objs/i86Win32VC60"
# PROP Intermediate_Dir "objs/i86Win32VC60"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GX /O2 /I "$(NDDSHOME)/include" /I "$(NDDSHOME)/include/ndds" /D "WIN32" /D "RTI_WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /MD /W3 /GX /O2 /I "$(NDDSHOME)/include" /I "$(NDDSHOME)/include/ndds" /D "NDDS_DLL_VARIABLE" /D "NDEBUG" /D "WIN32" /D "RTI_WIN32" /D "_CONSOLE" /D "_MBCS" /D "RTI_SHARED_MEMORY" /YX /FD /c
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386 /libpath:"$(NDDSHOME)/lib/i86Win32VC60"
# ADD LINK32 nddscpp.lib nddsc.lib nddscore.lib WS2_32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386 /libpath:"$(NDDSHOME)/lib/i86Win32VC60"

!ELSEIF  "$(CFG)" == "Latency_subscriber - Win32 Debug DLL"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug_DLL"
# PROP BASE Intermediate_Dir "Debug_DLL"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "objs/i86Win32VC60"
# PROP Intermediate_Dir "objs/i86Win32VC60"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /I "$(NDDSHOME)/include" /I "$(NDDSHOME)/include/ndds" /D "NDDS_DLL_VARIABLE" /D "WIN32" /D "RTI_WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /GZ /c
# ADD CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /I "$(NDDSHOME)/include" /I "$(NDDSHOME)/include/ndds" /D "NDDS_DLL_VARIABLE" /D "_DEBUG" /D "WIN32" /D "RTI_WIN32" /D "_CONSOLE" /D "_MBCS" /D "RTI_SHARED_MEMORY" /YX /FD /GZ /c
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept /libpath:"$(NDDSHOME)/lib/i86Win32VC60"
# ADD LINK32 nddscppd.lib nddscd.lib nddscored.lib WS2_32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept /libpath:"$(NDDSHOME)/lib/i86Win32VC60"

!ENDIF 

# Begin Target

# Name "Latency_subscriber - Win32 Release"
# Name "Latency_subscriber - Win32 Debug"
# Name "Latency_subscriber - Win32 Release DLL"
# Name "Latency_subscriber - Win32 Debug DLL"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\DataProcessor.cxx
# End Source File
# Begin Source File

SOURCE=.\Latency.cxx
# End Source File
# Begin Source File

SOURCE=.\Latency_subscriber.cxx
# End Source File
# Begin Source File

SOURCE=.\LatencyPlugin.cxx
# End Source File
# Begin Source File

SOURCE=.\LatencySupport.cxx
# End Source File
# Begin Source File

SOURCE=.\NddsCommunicator.cxx
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\Communicator.hxx
# End Source File
# Begin Source File

SOURCE=.\DataProcessor.hxx
# End Source File
# Begin Source File

SOURCE=.\Latency.h
# End Source File
# Begin Source File

SOURCE=.\LatencyPlugin.h
# End Source File
# Begin Source File

SOURCE=.\LatencySupport.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# End Group
# End Target
# End Project
