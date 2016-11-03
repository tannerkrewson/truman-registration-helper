@echo off
SETLOCAL EnableDelayedExpansion
rem For colored text:
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do     rem"') do (
  set "DEL=%%a"
)
rem Kill any old AutoHotkey process
taskkill /IM truman-registration-helper.exe /F > nul

call :drawui
call :colorEcho 0B "Welcome to Tanner's Truman Registration Helper."
echo.
echo.
echo TTRH can help you get an advantage when registering by typing your classes for you.
echo TTRH can hold up to 9 different sets of 10 CRNs.
echo.
echo TTRH is used by pressing Ctrl+Alt+1-9 in the registration box.
echo The numbers 1 through 9 can each store a different set of class CRNs.
echo This is helpful in the case you do not get your first choices.
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
call :colorEcho 0B "Enter your CRNs, seperated by a comma. (no space, just a comma)"
echo.
echo.
echo If you want more than one group of CRNs, put a space after the first group, and enter more CRNs just like before. You can have up to 10 CRNs per group, and up to 9 groups.
echo.
call :colorEcho 0f "Single Group Example"
echo : 8151,6244,7149,3458,1236,8388
call :colorEcho 0f "Multi Group Example"
echo : 3453,2774 8234,3458,5678,2345 2323,2348,2345
echo.
call :colorEcho 70 "Enter all your CRNs in the above format here"
echo.
set /p params=""
start bin\truman-registration-helper.exe %params%
call :drawui
echo Instructions:
echo 1. When registration opens, click on the first text box.
echo 2. Press your hotkey: Ctrl+Alt+1 or Ctrl+Alt+2 etc.
echo.
echo If you want to try out the hotkeys before registration, go to this website:
echo www.tannerkrewson.com/truman-registration-helper/
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
