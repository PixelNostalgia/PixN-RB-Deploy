@echo off
pushd %1
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

SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

rem Check if retrobat.exe exists in the current directory
if not exist "%~dp0retrobat.exe" (
    color E
    echo.
    echo #########################################################
    echo #                                                       #
    echo #   PLEASE RUN THIS SCRIPT FROM YOUR RETROBAT FOLDER!    #
    echo #                                                       #
    echo #########################################################
    echo.
    echo Press any key to exit...
    pause > nul 2>&1
    exit /b
)

echo                             ___
echo                           ,"---".
echo                           :     ;
echo                            `-.-'
echo                             ^| ^|
echo                             ^| ^|
echo                             ^| ^|
echo                          _.-\_/-._
echo                       _ / ^|     ^| \ _
echo                      / /   `---'   \ \
echo                     /  `-----------'  \
echo                    /,-""-.       ,-""-.\
echo                   ( i-..-i       i-..-i )
echo                   ^|`^|    ^|-------^|    ^|'^|
echo                   \ `-..-'  ,=.  `-..-'/
echo                    `--------^|=^|-------'
echo                             ^| ^|
echo                             \ \
echo                              ) )
echo                             / /
echo                            ( (
echo ..............................................................
echo ...Welcome to the Team Pixel Nostalgia Configuration Wizard...
echo ..............................................................
ping -n 2 127.0.0.1 > nul

:START
REM Downloading the package...
echo.
echo Downloading Team Pixel Nostalgia Configuration...
echo.
ping -n 2 127.0.0.1 > nul
curl https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/7z.exe --output 7z.exe
curl https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/7z.dll --output 7z.dll
curl https://raw.githubusercontent.com/PixelNostalgia/PixN-RB-Update-Service/main/wget.exe --output wget.exe
echo.

for %%A in ("PixN-RB-v7.5.0.0-Deploy.7z") do (
    echo %%~zA
    if [%%~zA]==[23617446169] (
        echo Package already exists...
		goto FILE-EXISTS
    ) else (
        echo Starting package download...
		del /Q PixN-RB-v7.5.0.0-Deploy.7z >nul 2>&1
		del /Q PixN-RB-v7.5.0.0-Deploy.7z.1 >nul 2>&1
		del /Q PixN-RB-v7.5.0.0-Deploy.7z.2 >nul 2>&1
		del /Q PixN-RB-v7.5.0.0-Deploy.7z.3 >nul 2>&1
		del /Q PixN-RB-v7.5.0.0-Deploy.7z.4 >nul 2>&1
		del /Q PixN-RB-v7.5.0.0-Deploy.7z.5 >nul 2>&1
		del /Q PixN-RB-v7.5.0.0-Deploy.7z.6 >nul 2>&1
		del /Q PixN-RB-v7.5.0.0-Deploy.7z.7 >nul 2>&1
		del /Q PixN-RB-v7.5.0.0-Deploy.7z.8 >nul 2>&1
		del /Q PixN-RB-v7.5.0.0-Deploy.7z.9 >nul 2>&1
    )
)
wget --progress=bar:binary --no-check-certificate --no-cache --no-cookies http://rgsretro1986.ds78102.seedhost.eu/update/RetroBat/PixN-RB-v7.5.0.0-Deploy.7z
if %ERRORLEVEL% neq 0 (
    echo.
	echo Download Failed! - Trying again in 10 seconds...
	echo Use CTRL-C now if you wish to cancel the script...
	ping -n 10 127.0.0.1 > nul
	cls
    goto START
) else (
    echo.
	echo Download Completed Successfully...
)
ping -n 2 127.0.0.1 > nul
:FILE-EXISTS
ping -n 1 127.0.0.1 > nul
echo.
echo Extracting files...
7z x PixN-RB-v7.5.0.0-Deploy.7z -aoa -o.\
echo.

ping -n 2 127.0.0.1 > nul
del /Q 7z.exe >nul 2>&1
del /Q 7z.dll >nul 2>&1
del /Q wget.exe >nul 2>&1
del /Q .wget-hsts >nul 2>&1

ping -n 2 127.0.0.1 > nul
echo.

REM Calling the PixN Update Service...
echo Running the PixN Update Service...
cd emulators\pixn\
START /WAIT cmd /c "PixN-RB-Update-Service.cmd"

cls
echo .............................................................
echo .........................All done!...........................
echo .............................................................
echo ......Enjoy and join us on Discord for help and support......
echo .............................................................
echo .............................................................
echo .............................................................
echo .......Would you like to keep the ~25GB package file?........
echo .............................................................
echo .......Press 'Y' to keep the file or 'N' to delete it........
echo .............................................................
echo .............................................................
echo ............You have 60 seconds to make a choice.............
echo ...............otherwise the file will be kept...............
echo .............................................................
echo .....(You can manually delete the file later if desired).....
echo .............................................................
echo.
choice /T 60 /C YN /D Y
if %errorlevel%==1 goto yes
if %errorlevel%==2 goto no

:yes
echo.
echo You selected YES, the package will be kept for future use...
echo.
goto END

:no
echo.
echo You selected NO, deleting file...
echo.
del /Q ..\..\PixN-RB-v7.5.0.0-Deploy.7z >nul 2>&1
ping -n 3 127.0.0.1 > nul

:END
echo Press any key to exit...
pause > nul 2>&1

popd

exit