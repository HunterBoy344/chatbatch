@echo off
for /f %%z in ('cd') do set filelocation=%%z
break>"%filelocation%\chatlocation.txt"
break>"%filelocation%\exit.txt"
break>"%filelocation%\filelocation.txt"
echo %filelocation% 1>>"%filelocation%\filelocation.txt"
mode 50,20
set /p "driveboolean=Are you using Google Drive (y/n) "
if "%driveboolean%"=="y" (goto setup_googledrive)
if "%driveboolean%"=="n" (goto setup_networkdrive)
:setup_googledrive
echo Please note that in this mode, the software cannot
echo create a chat folder. You will have to make your
echo chat folder manually in the My Drive directory.
echo You will also have to create a text file in that
echo directory called chat.txt
set /p "folderpath=Enter Google Drive drive letter: "
set /p "chatname=Enter chat folder path in quotations: "
if exist %folderpath%:\%chatname% (
cd /D %folderpath%:\%chatname%
goto prep_googledrive
) else (
echo The chat does not exist.
echo Please create the folder in My Drive and try again.
goto setup_googledrive
)
:setup_networkdrive
set /p "folderpath=Enter Chat Drive Letter: "
set /p "chatname=Enter Chat Name: "
if exist %folderpath%:\%chatname% (
cd /D %folderpath%:\%chatname%
goto prep
) else (
echo creating new chat...
cd /D %folderpath%:\
mkdir %chatname%
cd %chatname%
break>"chat.txt"
goto prep
)
:prep
set /p "screenname=Enter Username: "
setlocal enabledelayedexpansion
(
echo !screenname! has entered the chat 1>>"chat.txt"
)
echo Welcome^^! Use /exit to leave the chat and /clear to clear history.
cd /D %filelocation%
setlocal enabledelayedexpansion
(
echo !folderpath!:\!chatname! 1>>"chatlocation.txt"
)
start cmd /C "%filelocation%\looping-realtime.bat"
cd /D %folderpath%:\%chatname%
goto chat
:chat
setlocal enabledelayedexpansion
(
set /p "message=Enter Message: "
echo !screenname!: !message! 1>>"chat.txt"
)
if "%message%"=="/exit" (
echo %screenname% has left the chat 1>>"chat.txt"
echo exit 1>>"%filelocation%\exit.txt"
exit
)
if "%message%"=="/clear" (
break>"chat.txt"
)
cls
goto chat
:prep_googledrive
set /p "screenname=Enter Username: "
setlocal enabledelayedexpansion
(
echo !screenname! has entered the chat 1>>"chat.txt"
)
echo Welcome^^! Use /exit to leave the chat and /clear to clear history.
echo Since you're using Drive, you need to put in the
echo drive letter and path into the chat monitor program.
cd /D %filelocation%
start cmd /C "%filelocation%\looping-realtime-drive.bat"
cd /D %folderpath%:\%chatname%
goto chat