rem @echo off

@RD /S /Q build
mkdir build
mkdir build\bin

echo f | xcopy /s /f /y src\main.bat build\RUN.bat

cd Ahk2Exe
Ahk2exe.exe /in ..\src\hotkeys.ahk /out ..\build\bin\truman-registration-helper.exe
