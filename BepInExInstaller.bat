@echo off
setlocal enabledelayedexpansion
title BepInEx Installer
color 0e

if "%1"=="--credits" (
    cls
    title BepInEx Installer - Credits
    echo ----------------------------------------------------
    echo  BepInEx Installer forked from the iiMenu installer
    echo  github.com/NotMonk1/gtag-bepinex-installer
    echo ----------------------------------------------------
    echo.
    echo  Credits:
    echo  - NotMonk: Edited the iiMenu installer to create this BepInEx installer
    echo  - iiMenu Devs: Original installer and menu framework
    echo.
    pause
    color 0f
    cls
    title Command Prompt
    exit /b
)

set "steamPath1=C:\Program Files (x86)\Steam\steamapps\common\Gorilla Tag"
set "steamPath2=D:\SteamLibrary\steamapps\common\Gorilla Tag"
set "steamPath3=C:\Program Files\Oculus\Software\Software\another-axiom-gorilla-tag"
set "steamPath4=D:\Steam\steamapps\common\Gorilla Tag"

if exist "%steamPath1%" ( set "gamePath=%steamPath1%" & goto :gotpath )
if exist "%steamPath2%" ( set "gamePath=%steamPath2%" & goto :gotpath )
if exist "%steamPath3%" ( set "gamePath=%steamPath3%" & goto :gotpath )
if exist "%steamPath4%" ( set "gamePath=%steamPath4%" & goto :gotpath )

color 0c
set /p "gamePath=Gorilla Tag not found. Enter path manually: "
set "gamePath=%gamePath:"=%"
if not exist "%gamePath%" (
    echo Invalid path.
    pause
    exit /b
)

:gotpath
cls
title BepInEx Installer -- Downloading BepInEx
color 0e
echo.
echo  BepInEx Installer
echo  github.com/NotMonk1/gtag-bepinex-installer
echo.
echo  Downloading BepInEx...
echo.

curl -L -f -# "https://github.com/BepInEx/BepInEx/releases/download/v5.4.23.4/BepInEx_win_x64_5.4.23.4.zip" -o "BPNX54234.zip"

if errorlevel 1 (
    color 0c
    echo Failed to download BepInEx. Check your internet connection.
    pause
    exit /b
)

echo.
echo  Extracting BepInEx...
powershell -command "$ErrorActionPreference = 'SilentlyContinue'; Expand-Archive -Path 'BPNX54234.zip' -DestinationPath '%gamePath%' -Force 2>$null" >nul 2>&1
del "BPNX54234.zip" >nul 2>&1

if not exist "%gamePath%\BepInEx\config" mkdir "%gamePath%\BepInEx\config"
if not exist "%gamePath%\BepInEx\plugins" mkdir "%gamePath%\BepInEx\plugins"

cls
title BepInEx Installer -- Done!
echo.
echo  BepInEx Installer
echo  github.com/NotMonk1/gtag-bepinex-installer
echo.
echo  Done! BepInEx is installed.
echo.
echo  Put mods in %gamePath%\BepInEx\plugins
echo.
start "" "%gamePath%"
echo  Opened game folder in Explorer.
pause
cls
color 0f
title Command Prompt
echo you may now close this window.
exit /b
