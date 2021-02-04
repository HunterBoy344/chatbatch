@echo off
set /p "driveletter=Enter drive letter: "
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
timeout 1 >nul
goto loop