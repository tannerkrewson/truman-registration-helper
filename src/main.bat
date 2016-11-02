@echo off
SETLOCAL EnableDelayedExpansion
rem For colored text:
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do     rem"') do (
  set "DEL=%%a"
)

call :drawui
echo Welcome to Tanner's Truman Registration Helper.
echo TTRH can help you get an advantage when registering by typing your classes for you.
echo TTRH can hold up to 10 different sets of 6 CRNs.
echo.
pause
call :drawui
echo TTRH is used by pressing Ctrl+Alt+1-10 in the registration box.
echo The numbers 1 through 10 can each store a different set of class CRNs.
echo This is helpful in the case you do not get your first choices.
echo.
pause
call :drawui
echo Format: CRN1,CRN2,CRN3,CRN4,CRN5,CRN6 CRN7,CRN8,CRN9,CRN10,CRN11,CRN12
echo                                      ^^single space to seperate groups
echo.
echo Example:
echo If your main choice classes are 8151,6244,7149,7925,4001,8506...
echo ...and your backup choices are 8042,7280,6668,6867,4356,5692...
echo.
echo You should enter the following into this program, all in one line:
echo 8151,6244,7149,7925,4001,8506 8042,7280,6668,6867,4356,5692
echo                              ^^single space to seperate groups
echo.
echo *In this example, the first block of six classes will be assigned to Ctrl+Alt+1
echo  and the second block of six will be mapped to Ctrl+Alt+2 and so on.
echo.
pause
call :drawui
echo Tips:
echo *You can have up to 10 groups of CRNs.
echo *Each group can have 1 to 6 classes.
echo.
pause
:restart
call :drawui
call :entercrn

echo.
SET /P AREYOUSURE="Would you like to continue using TTRH? (y/n) "
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END
goto restart

:entercrn
echo Example: 8151,6244,7149,7925,4001,8506 8042,7280,6668,6867,4356,5692
echo.
set /p params="Enter all your CRNs in the above format: "
start bin\truman-registration-helper.exe %params%
call :drawui
echo Instructions:
echo 1. When registration opens, click on the first text box.
echo 2. Press your hotkey: Ctrl+Alt+1 or Ctrl+Alt+2 etc.
echo 3. Press the enter key.
echo.
call :colorEcho 70 "Current Hotkeys and CRNs"
echo.

set t=%params%
set /a count=1
:loop
for /f "tokens=1*" %%a in ("%t%") do (
   set msg=Ctrl+Alt+%count% =^> %%a
   echo !msg!
   set t=%%b
   set /a count+=1
   )
if defined t goto :loop

echo.
call :colorEcho 0a "=============="
echo.
call :colorEcho 0a "HOTKEYS ACTIVE"
echo.
call :colorEcho 0a "=============="
echo.
echo.
call :colorEcho 0F "== Press any key to stop the hotkeys and edit the CRNs =="
pause >nul
call :drawui
call :colorEcho 0c "================"
echo.
call :colorEcho 0c "HOTKEYS DISABLED"
echo.
call :colorEcho 0c "================"
echo.
taskkill /IM truman-registration-helper.exe /F > nul
exit /b

:drawui
cls
echo Connecting to the registration server...
echo.
echo If you are stuck on this screen, try reopening TTRH.
for /f "tokens=1 delims=" %%i in ('ping -n 1 shale.truman.edu') do set output=%%i
for /f "tokens=9" %%i in ("%output%") do set output=%%i
set output=%output:~0,-2%
cls
call :colorEcho 0f "=========================================="
echo.
call :colorEcho 0f "Tanner's"
call :colorEcho 05 " Truman"
call :colorEcho 0f " Registration Helper"
echo.
call :colorEcho 07 "Connection to Registration Server= "
if %output% LEQ 1 (
  call :colorEcho 0A " PERFECT"
) ELSE (
  if %output% LEQ 10 (
    call :colorEcho 02 " GREAT"
  ) ELSE (
    if %output% LEQ 30 (
      call :colorEcho 02 " GOOD"
    ) ELSE (
      if %output% LEQ 100 (
        call :colorEcho 0E " DECENT"
      ) ELSE (
        call :colorEcho 0C " SLOW"
      )
    )
  )
)
call :colorEcho 0f " %output%ms"
echo.
call :colorEcho 0f "=========================================="
echo.
echo.
exit /b

:colorEcho
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1i
