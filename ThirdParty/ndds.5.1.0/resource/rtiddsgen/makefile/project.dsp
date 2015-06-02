# Microsoft Developer Studio Project File - Name="%%IDLFileBaseName%%_%%ProjectName%%" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=%%IDLFileBaseName%%_%%ProjectName%% - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "%%IDLFileBaseName%%_%%ProjectName%%.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "%%IDLFileBaseName%%_%%ProjectName%%.mak" CFG="%%IDLFileBaseName%%_%%ProjectName%% - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "%%IDLFileBaseName%%_%%ProjectName%% - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "%%IDLFileBaseName%%_%%ProjectName%% - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE "%%IDLFileBaseName%%_%%ProjectName%% - Win32 Release DLL" (based on "Win32 (x86) Console Application")
!MESSAGE "%%IDLFileBaseName%%_%%ProjectName%% - Win32 Debug DLL" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "%%IDLFileBaseName%%_%%ProjectName%% - Win32 Release"

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
# ADD CPP /nologo /MT /W3 /GX /O2 /I "$(NDDSHOME)/include" /I "$(NDDSHOME)/include/ndds" /D "WIN32" /D "RTI_WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /FD /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib netapi32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib kernel32.lib gdi32.lib winspool.lib comdlg32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 %%RTI_RELEASE_LIB%% nddscz.lib nddscorez.lib WS2_32.lib  kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib /nologo /subsystem:console /machine:I386 /libpath:"c:/Program Files/Microsoft Platform SDK for Windows Server 2003 R2/lib" /libpath:"$(NDDSHOME)/lib/i86Win32VC60"

!ELSEIF  "$(CFG)" == "%%IDLFileBaseName%%_%%ProjectName%% - Win32 Debug"

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
# ADD CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /I "$(NDDSHOME)/include" /I "$(NDDSHOME)/include/ndds" /D "WIN32" /D "RTI_WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /FD /GZ /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib netapi32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib kernel32.lib gdi32.lib winspool.lib comdlg32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 %%RTI_DEBUG_LIB%% nddsczd.lib nddscorezd.lib WS2_32.lib  kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept /libpath:"c:/Program Files/Microsoft Platform SDK for Windows Server 2003 R2/lib" /libpath:"$(NDDSHOME)/lib/i86Win32VC60"

!ELSEIF  "$(CFG)" == "%%IDLFileBaseName%%_%%ProjectName%% - Win32 Release DLL"

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
# ADD CPP /nologo /MD /W3 /GX /O2 /I "$(NDDSHOME)/include" /I "$(NDDSHOME)/include/ndds" /D "NDDS_DLL_VARIABLE" /D "WIN32" /D "RTI_WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /FD /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib /nologo /subsystem:console /machine:I386 /libpath:"c:/Program Files/Microsoft Platform SDK for Windows Server 2003 R2/lib" /libpath:"$(NDDSHOME)/lib/i86Win32VC60"
# ADD LINK32 %%RTI_RELEASE_DLL%% nddsc.lib nddscore.lib WS2_32.lib  kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib /nologo /subsystem:console /machine:I386 /libpath:"c:/Program Files/Microsoft Platform SDK for Windows Server 2003 R2/lib" /libpath:"$(NDDSHOME)/lib/i86Win32VC60"

!ELSEIF  "$(CFG)" == "%%IDLFileBaseName%%_%%ProjectName%% - Win32 Debug DLL"

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
# ADD CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /I "$(NDDSHOME)/include" /I "$(NDDSHOME)/include/ndds" /D "NDDS_DLL_VARIABLE" /D "WIN32" /D "RTI_WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /FD /GZ /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept /libpath:"c:/Program Files/Microsoft Platform SDK for Windows Server 2003 R2/lib" /libpath:"$(NDDSHOME)/lib/i86Win32VC60"
# ADD LINK32 %%RTI_DEBUG_DLL%% nddscd.lib nddscored.lib WS2_32.lib  kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept /libpath:"c:/Program Files/Microsoft Platform SDK for Windows Server 2003 R2/lib" /libpath:"$(NDDSHOME)/lib/i86Win32VC60"

!ENDIF 

# Begin Target

# Name "%%IDLFileBaseName%%_%%ProjectName%% - Win32 Release"
# Name "%%IDLFileBaseName%%_%%ProjectName%% - Win32 Debug"
# Name "%%IDLFileBaseName%%_%%ProjectName%% - Win32 Release DLL"
# Name "%%IDLFileBaseName%%_%%ProjectName%% - Win32 Debug DLL"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\%%IDLFileBaseName%%%%fileExtension%%
# End Source File
# Begin Source File

SOURCE=.\%%IDLFileBaseName%%Plugin%%fileExtension%%
# End Source File
# Begin Source File

SOURCE=.\%%IDLFileBaseName%%Support%%fileExtension%%
# End Source File
# Begin Source File

SOURCE=.\%%IDLFileBaseName%%_%%ProjectName%%%%fileExtension%%
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\%%IDLFileBaseName%%.h
# End Source File
# Begin Source File

SOURCE=.\%%IDLFileBaseName%%Plugin.h
# End Source File
# Begin Source File

SOURCE=.\%%IDLFileBaseName%%Support.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# End Group
# End Target
# End Project
