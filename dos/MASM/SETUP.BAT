ECHO OFF
CLS
WHAT E
IF ERRORLEVEL 15 GOTO ChkDOS
ECHO  
ECHO You have insufficient environment space to run this batch file.
ECHO See Chapter 12 of the CodeView and Utilities manual for information
ECHO on SETENV and other methods of changing the environment size.
GOTO Quit
:ChkDOS
WHAT D
IF ERRORLEVEL 31 GOTO ChkHard
IF NOT ERRORLEVEL 30 GOTO ChkHard
ECHO Because of an incompatibility between DOS 3.0 and the batch file 
ECHO enhancer on this disk, you will not be able to run the setup 
ECHO batch file. Instead, follow the setup instructions in Chapter 1 
ECHO of the Programmer's Guide. 
GOTO Quit
:ChkHard
ECHO  
WHAT C "Are you installing the assembler on a hard disk? (Y/n) " YN~
IF %WHAT%==N GOTO Floppy
SET HARD=H
ECHO  
ECHO  
WHAT C "Type the drive letter: "
SET TDRIVE=%WHAT%
GOTO CheckEnv
:Floppy
SET TDRIVE=B
SET HARD=F
:CheckEnv
WHAT E
ECHO  
ECHO  
ECHO You have %WHAT% bytes of unused environment space.
IF ERRORLEVEL 100 GOTO EnvOK
ECHO  
ECHO This is not enough to run the setup batch file.
ECHO You may also need more to use some assembly features.
ECHO  
GOTO NewEnv
:EnvOK
ECHO  
ECHO This is probably enough to use all assembly features.
WHAT C "Do you want to change the size of the environment? (y/N) " YN~
ECHO  
ECHO  
IF %WHAT%==Y GOTO NewEnv
WHAT Y
SET CDRIVE=%WHAT%
WHAT YE
SET CDIR=%WHAT%
:SetUp
ECHO  
IF %HARD%.==H. GOTO HSetup
CLS
CLS
ECHO A recommended setup for floppy disk systems is shown below:
ECHO  
ECHO Disk	Location	Contents
ECHO  
ECHO  1	A:\		Source files
ECHO  
ECHO  2	B:\		MASM, LINK, and additional utilities such
ECHO 			as MAKE, LIB, and CREF
ECHO 	B:\		Text editor
ECHO  
ECHO  3	B:\		CodeView debugger and help
ECHO 	B:\INCLUDE	Macro and other include files
ECHO 	B:\LIB		Library and standard object files
ECHO  
ECHO Environment variables:	PATH=B:\;A:\;
ECHO 			LIB=B:\LIB
ECHO 			INCLUDE=B:\INCLUDE
ECHO  
ECHO Swap disks 2 and 3 in drive B when developing or debugging.
ECHO Swap source file disks in drive A. Since actual setups vary,
ECHO floppy setup is not automatic. You must copy the files yourself.
ECHO  
WHAT CE "Press any key to continue . . . "
RUNME S
:NewEnv
WHAT S "What size environment do you want? "
SET ENV=%WHAT%
ECHO  
WHAT D
IF NOT ERRORLEVEL 32 GOTO SetEnv
ECHO You should add the following line to your CONFIG.SYS file:
ECHO  
ECHO 	SHELL %COMSPEC% /E:%ENV% /P
ECHO  
IF %HARD%==F GOTO Clean
ECHO You can write this line to a file called \INSERT.SYS now
ECHO and insert it in your CONFIG.SYS later. 
ECHO  
WHAT C "Do you want to create this file? (Y/n) " YN~
ECHO  
ECHO  
WHAT YE
%TDRIVE%:
ECHO SHELL %COMSPEC% /E:%ENV% /P >> \INSERT.SYS
%WHAT%:
GOTO Clean
:SetEnv
IF %HARD%==F GOTO FSetenv
ECHO You can change the environment size with the following command:"
ECHO  
ECHO 	SETENV %COMSPEC% %ENV%
ECHO  
WHAT C "Do you want to do this now? (Y/n) " YN~
ECHO  
ECHO  
IF %WHAT%==N GOTO Clean
SETENV %COMSPEC% %ENV%
GOTO Clean
:FSetenv
ECHO Insert your DOS disk in drive A and disk 1 (Assembler) in drive B
ECHO When ready, enter the following command:
ECHO  
ECHO 	SETENV %COMSPEC% %ENV%
ECHO  
ECHO  
GOTO Clean
:HSetup
CLS
ECHO Warning:
ECHO  
ECHO   Before installing the assembler files, you should make backup
ECHO   copies of the new distribution disks. Because of system variations,
ECHO   this is not included as part of setup.
ECHO  
ECHO   If you have files with the same file names as files copied during
ECHO   installation, the old versions will be overwritten. For example,
ECHO   a previous version of MASM.EXE would be lost.
ECHO  
ECHO   If you have not backed up the distribution disks or if you do
ECHO   not have copies of old versions, you should make backup copies now.
ECHO  
WHAT C "Do you wish to continue? (Y/n) " YN~
IF %WHAT%==N RUNME S
SET EDIR=\BIN
SET IDIR=\INCLUDE
SET LDIR=\LIB
SET ADIR=\ASM
SET SDIR=\
:Locate
CLS
ECHO The locations for assembler files are shown below:
ECHO  
ECHO   Directory	Files
ECHO   ---------	-----
ECHO  
ECHO   %EDIR%		Executable files (MASM, LINK, ETC.)
ECHO   %IDIR%	Include files (usually macro files)
ECHO   %LDIR%		Library files
ECHO   %ADIR%		Sample programs, source files, and setup batch files
ECHO   %SDIR%		MOUSE.SYS (updated device driver for debugging with mouse)
ECHO  
WHAT C "Are these locations acceptable? (Y/n) " ~YN
CLS 
IF NOT %WHAT%==N GOTO Copy1
ECHO  
ECHO Enter complete directory path for executable files.
WHAT S "Make sure the path starts with a backslash: "
ECHO  
SET EDIR=%WHAT%
ECHO  
ECHO Enter complete directory path for include files.
WHAT S "Make sure the path starts with a backslash: "
ECHO  
SET IDIR=%WHAT%
ECHO  
ECHO Enter complete directory path for library files.
WHAT S "Make sure the path starts with a backslash: "
ECHO  
SET LDIR=%WHAT%
ECHO  
ECHO Enter complete directory path for sample source files.
WHAT S "Make sure the path starts with a backslash: "
ECHO  
SET ADIR=%WHAT%
ECHO Enter complete directory path for MOUSE.SYS.
WHAT S "Make sure the path starts with a backslash: "
ECHO  
SET SDIR=%WHAT%
GOTO Locate
:Copy1
WHAT KE %TDRIVE%
IF ERRORLEVEL 74 GOTO MakeDir
ECHO  
ECHO You have about %WHAT%000 bytes of disk space available. This is
ECHO not enough. You must delete files to make space, then try again.
ECHO  
WHAT CE "Press any key to continue . . . "
RUNME H
:MakeDir
ECHO OFF
WHAT F %TDRIVE%:%EDIR%
IF %WHAT%==0 MD %TDRIVE%:%EDIR%
WHAT F %TDRIVE%:%ADIR%
IF %WHAT%==0 MD %TDRIVE%:%ADIR%
WHAT FE %TDRIVE%:%ADIR%\MIXED
IF %WHAT%==0 MD %TDRIVE%:%ADIR%\MIXED
WHAT F %TDRIVE%:%IDIR%
IF %WHAT%==0 MD %TDRIVE%:%IDIR%
WHAT F %TDRIVE%:%LDIR%
IF %WHAT%==0 MD %TDRIVE%:%LDIR%
WHAT F %TDRIVE%:%SDIR%
IF %SDIR%.==\. GOTO Root
IF %WHAT%==0 MD %TDRIVE%:%SDIR%
:Root
COPY WHAT.EXE %TDRIVE%:%ADIR% > NUL
%TDRIVE%:
CD %ADIR%
CLS
ECHO A batch file called ASETUP.BAT will be created in your
ECHO root directory. This file defines the assembler environment
ECHO variables. You can modify the file or insert its contents
ECHO into your AUTOEXEC.BAT file. ASETUP.BAT will contain the
ECHO following lines:
ECHO  
ECHO   PATH=%TDRIVE%:%EDIR%;
ECHO   SET INCLUDE=%TDRIVE%:%IDIR%
ECHO   SET LIB=%TDRIVE%:%LDIR%;
ECHO  
WHAT C "Do you want to create this file now? (Y/n) " ~YN
CLS
IF %WHAT%==N GOTO ChkA
ECHO PATH=%TDRIVE%:%EDIR%; >> \ASETUP.BAT
ECHO SET INCLUDE=%TDRIVE%:%IDIR% >> \ASETUP.BAT
ECHO SET LIB=%TDRIVE%:%LDIR% >> \ASETUP.BAT
:ChkA
IF EXIST A:\README.DOC GOTO DiskOK
:Idiot
CLS
WHAT CE "Insert disk 1 (Assembler) in drive A and press any key when ready. "
IF NOT EXIST A:\README.DOC GOTO Idiot
SET DISK=1
:DiskOK
ECHO  
ECHO About to copy source, documentation, and batch files to 
ECHO directory %TDRIVE%:%ADIR%. Duplicate files will be overwritten.
ECHO  
WHAT C "Do you want to copy these files now? (Y/n) " ~YN
ECHO  
ECHO  
IF %WHAT%==N A:RUNME %1
CD %ADIR%
COPY A:*.BAT
COPY A:*.DOC
COPY A:*.LST
COPY A:*.ASM
SETUP2 S %1
:Clean
ECHO Make sure the change to your environment has been made on
ECHO your DOS disk. Then boot and restart setup.
SET CDRIVE=
SET CDIR=
SET HARD=
SET DISK=
SET TDRIVE=
SET ENV=
:Quit
SET WHAT=

