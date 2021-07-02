@echo off
for /f %%y in (chatlocation.txt) do set location=%%y
for /f %%t in ('cd') do set currentlocation=%%t
MODE 60,20
cd /D %location%
:loop
for /f %%e in (%currentlocation%\exit.txt) do set exitcounter=%%e
if "%exitcounter%"=="exit" (
exit
)
cls
type chat.txt
ping 127.0.0.1 -n 1 -w 500> nul
goto loop
