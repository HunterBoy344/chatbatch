@echo off
set /p "driveletter=Enter File Stream drive letter: "
set /p "chatname=Enter chat folder path in quotations: "
for /f %%t in ('cd') do set currentlocation=%%t
MODE 60,20
cd /D %driveletter%:\%chatname%
:loop
for /f %%e in (%currentlocation%\exit.txt) do set exitcounter=%%e
if "%exitcounter%"=="exit" (
exit
)
cls
type chat.txt
ping 127.0.0.1 -n 1 -w 500> nul
goto loop
