ECHO OFF
CLS
WHAT E
IF ERRORLEVEL 10 GOTO ChkDOS
ECHO  
ECHO You have insufficient environment space to run this batch file.
ECHO See Chapter 12 of the CodeView and Utilities manual for information 
ECHO on SETENV and other methods of changing the environment size.
GOTO Quit
:ChkDOS
WHAT D
IF ERRORLEVEL 31 GOTO ChkMem
IF NOT ERRORLEVEL 30 GOTO ChkMem
WHAT V
ECHO Starting with the following command line:
ECHO  
IF NOT ERRORLEVEL 3 GOTO BW
ECHO CV /I /W /S /M "/C<M_AUTO.CV" SHOW SHOW.ASM
CV /I /W /S /M "/C<M_AUTO.CV" SHOW SHOW.ASM
CLS
GOTO Quit
:BW
ECHO CV /I /B /W /S /M "/C<M_AUTO.CV" SHOW SHOW.ASM
CV /I /B /W /S /M "/C<M_AUTO.CV" SHOW SHOW.ASM
CLS
GOTO Quit
:ChkMem
WHAT ME
IF ERRORLEVEL 31 GOTO MemOK
ECHO The sample session requires approximately 310K of free
ECHO memory. You have only %WHAT%K. If you have resident programs,
ECHO you may want to remove them and try again.
ECHO  
GOTO EXIT
:MemOK
CLS
ECHO Machine Menu
ECHO 
ECHO Which type of computer are you using?
ECHO  
ECHO   1. IBM (R) Personal Computer
ECHO   2. Compatible Computer
ECHO   3. Not IBM Compatible
ECHO  
WHAT C "Select: " ICN123
CLS
IF %WHAT%==I GOTO Monitor
IF %WHAT%==C GOTO Choose
IF %WHAT%==1 GOTO Monitor
IF %WHAT%==2 GOTO Choose
:NoWay
ECHO If your computer is not IBM compatible, you will not be able
ECHO to run the sample session. However, you can still use the 
ECHO CodeView (R) debugger in sequential mode, as described in the 
ECHO CodeView and Utilities manual.
ECHO  
GOTO Exit
:Choose
ECHO A few IBM-compatible computers require the /D CodeView
ECHO option. The following are known to require this option:
ECHO  
ECHO      Tandy 1000            AT&T 6300 Plus 
ECHO  
ECHO If your computer is not one of these, try the session first
ECHO without /D. If you have trouble, try again with /D. If you
ECHO still have trouble, your computer isn't compatible. 
ECHO  
ECHO If you use the /D option, the CONTROL-C and CONTROL-BREAK
ECHO keys cannot be used to break out of the sample session.
ECHO  
WHAT C "Do you want to try the /D option? (y/N) " ~YN
SET OPT=/I
IF %WHAT%==Y SET OPT=/D
:Monitor
WHAT V 
SET ADAPT=
IF %WHAT%==0 SET ADAPT=/B
IF %WHAT%==2 SET ADAPT=/B
IF %WHAT%==5 SET ADAPT=/B
IF %WHAT%==7 SET ADAPT=/B
IF %WHAT%==15 SET ADAPT=/B
CLS
ECHO Welcome to the Microsoft CodeView(R) debugger. 
ECHO  
ECHO      Copyright (C) Microsoft Corporation 1987
ECHO                 All rights reserved
ECHO  
ECHO The CodeView debugger is a powerful tool for serious debugging.
ECHO This tutorial introduces you to CodeView commands using SHOW--
ECHO a program that displays text files on the screen. The tutorial 
ECHO is broken into three lessons taking 5 to 10 minutes each. 
ECHO  
ECHO You control the pace. The lessons periodically pause and ask
ECHO you to press a key. Although keystrokes may be discussed on the 
ECHO screen, you do not need to type them. Just press any key.  
ECHO  
ECHO You can quit in the middle of a lesson by first pressing CONTROL-C 
ECHO or CONTROL-BREAK, then pressing a key. The word `break' will 
ECHO appear, followed by the CodeView prompt (the greater-than symbol). 
ECHO At the prompt, enter `Q' for Quit. The tutorial will end.
ECHO  
WHAT CE "Press any key to continue . . . "
CLS
ECHO The following command line will be used to start the debugger:
ECHO  
ECHO 	CV /W /S /M "/C<M_AUTO.CV" SHOW SHOW.ASM
ECHO  
ECHO The elements of the command line are explained below:
ECHO  
ECHO   - CV is the program name of the debugger.
ECHO   - /W specifies window mode.
ECHO   - /S specifies screen swapping as the screen-exchange mode.
ECHO   - /M turns off the mouse if you have one.
ECHO   - "/C<M_AUTO.CV" specifies that on start-up, commands will be 
ECHO     redirected from M_AUTO.CV to the debugger.
ECHO   - SHOW is the executable file (.EXE extension assumed).
ECHO   - SHOW.ASM is the file to be processed by SHOW.
ECHO  
ECHO Your command line may also include the /B, /I, or /D options,
ECHO depending on selections made earlier. 
ECHO  
WHAT CE "Press any key to continue . . . "
CLS
ECHO The debugger will now start. Loading and initial processing
ECHO may take a moment . . .
WHAT V
SET VID=%WHAT%
ECHO  
SET TPATH=
SET TPATH2=
IF %EDIR%.==. GOTO Continue
SET TPATH=%PATH%
SET TPATH2=1
SET PATH=%TDRIVE%:%EDIR%
GOTO Continue
:Continue
ECHO CV %ADAPT% %OPT% /W /S /M "/C<M_AUTO.CV" SHOW SHOW.ASM
CV %ADAPT% %OPT% /W /S /M "/C<M_AUTO.CV" SHOW SHOW.ASM > nul
CLS
IF ERRORLEVEL 1 WHAT CE "Debugger not found. Modify your path. "
IF %TPATH2%.==1. SET PATH=%TPATH%
SET TPATH=
SET TPATH2=
WHAT V %VID%
IF NOT %1.==. RUNME D
:Exit
IF NOT %1.==. WHAT CE "Press any key to Continue "
IF NOT %1.==. RUNME D
:Quit
SET WHAT=
SET ADAPT=
SET OPT=
SET VID=
ECHO OFF

