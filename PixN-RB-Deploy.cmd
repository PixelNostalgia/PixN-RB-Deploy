@echo off
setlocal

rem Text color code for Light Green is A
set "colorCode=A"
color %colorCode%

:VBSDynamicBuild
SET TempVBSFile=%temp%\~tmpSendKeysTemp.vbs
IF EXIST "%TempVBSFile%" DEL /F /Q "%TempVBSFile%"
ECHO Set WshShell = WScript.CreateObject("WScript.Shell") >>"%TempVBSFile%"
ECHO Wscript.Sleep 900                                    >>"%TempVBSFile%"
ECHO WshShell.SendKeys "{F11}"                            >>"%TempVBSFile%
ECHO Wscript.Sleep 900                                    >>"%TempVBSFile%"

CSCRIPT //nologo "%TempVBSFile%"

echo .
echo Welcome to the Team Pixel Nostalgia Configuration Wizard...
ping -n 2 127.0.0.1 > nul
echo .
REM Downloading the package...
echo Downloading Team Pixel Nostalgia Configuration...
echo .
ping -n 2 127.0.0.1 > nul
curl https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/7z.exe --output 7z.exe
curl https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/7z.dll --output 7z.dll
curl https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/wget.exe --output wget.exe
echo .
del /Q d4tGtzgF*.* >nul 2>&1
del /Q PixN-RB-Deploy.7z >nul 2>&1
wget https://pixeldrain.com/api/filesystem/d4tGtzgF
ren d4tGtzgF PixN-RB-Deploy.7z
ping -n 2 127.0.0.1 > nul
echo Extracting files...
7z x PixN-RB-Deploy.7z -aoa -o.\
echo .

ping -n 2 127.0.0.1 > nul
del /Q PixN-RB-Deploy.7z >nul 2>&1
del /Q d4tGtzgF*.* >nul 2>&1
del /Q 7z.exe >nul 2>&1
del /Q 7z.dll >nul 2>&1
del /Q wget.exe >nul 2>&1
del /Q .wget-hsts >nul 2>&1

ping -n 2 127.0.0.1 > nul
echo .

REM Downloading the themes...
echo Downloading the Carbon-PixN theme...
echo .
cd .\emulationstation\.emulationstation\themes
rmdir /S /Q "Carbon-PixN" >nul 2>&1
..\..\..\emulators\pixn\PortableGit\cmd\git clone https://github.com/RGS-MBU/Carbon-PixN.git
echo .

echo Downloading the Hypermax-Plus-PixN theme...
echo .
rmdir /S /Q "Hypermax-Plus-PixN" >nul 2>&1
..\..\..\emulators\pixn\PortableGit\cmd\git clone https://github.com/RGS-MBU/Hypermax-Plus-PixN.git
echo .

REM Calling the PixN Update Service...
echo Running the PixN Update Service...
cd ..\..\..\emulators\pixn\
START /WAIT cmd /c "PixN-RB-Update-Service.cmd"
echo .

echo ALL DONE!!!
pause
exit
