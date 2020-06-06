@echo off
for /f %%z in ('cd') do set filelocation=%%z
break>"%filelocation%\chatlocation.txt"
break>"%filelocation%\exit.txt"
break>"%filelocation%\filelocation.txt"
echo %filelocation% 1>>"%filelocation%\filelocation.txt"
mode 50,20
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