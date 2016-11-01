@echo off
setlocal EnableDelayedExpansion

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
SET /P AREYOUSURE=Would you like to continue using TTRH? (Y/[N])?
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
echo 2. Press your hotkey: Ctrl+Alt+1
echo 3. Press the enter key.
echo.
echo Do the same with the another hotkey to enter your backups:
echo 1. Click on the first text box again.
echo 2. Press your hotkey: Ctrl+Alt+2 or 3,4,5....
echo 3. Press the enter key.
echo.
echo Current CRNs: %params%
echo.
echo Hotkeys are ready. Try pressing Ctrl+Alt+1-10 on a text document to test your hotkey.
echo.
echo Press any key to stop the hotkeys and edit the CRNs.
echo.
pause
echo Turning off hotkeys...
taskkill /IM truman-registration-helper.exe /F > nul
exit /b

:drawui
cls
color 05
echo Tanner's Truman Registration Helper
echo ===================================
color 07
echo.
exit /b
