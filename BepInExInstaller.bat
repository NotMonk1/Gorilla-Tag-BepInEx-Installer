@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul


cls
title BepInEx Installer // [#---------] Getting directory
color 0e

if "%1"=="--credits" (
    cls
    title BepInEx Installer - Credits
    echo ----------------------------------------------------
    echo  BepInEx Installer forked from the Poison installer
    echo  github.com/NotMonk1/Gorilla-Tag-BepInEx-Installer/
    echo ----------------------------------------------------
    echo.
    echo  Credits:
    echo  - NotMonk: Edited the Poison installer to create this BepInEx installer
    echo  - Poison Software: Made the OG installer
    echo.
    pause
    color 0f
    cls
    title Command Prompt
    exit /b
)

:: Thanks to tdcvoid for telling me the new path for Oculus
set "steamPath1=C:/Program Files (x86)/Steam/steamapps/common/Gorilla Tag"
set "steamPath2=C:/Program Files/Meta Horizon/Software/Software/another-axiom-gorilla-tag"


if exist "%steamPath1%" (
    set "gamePath=%steamPath1%"
) else if exist "%steamPath2%" (
    set "gamePath=%steamPath2%"
) else (
    color 0c
    echo Gorilla Tag directory not found.
    pause
    exit /b
)


if not defined gamePath (
    for %%D in (E F G H I J K L M N O P Q R S T U V W X Y Z) do (
        if exist "%%D:/SteamLibrary/steamapps/common/Gorilla Tag" (
            set "gamePath=%%D:/SteamLibrary/steamapps/common/Gorilla Tag"
            goto afterDriveSearch
        )
        if exist "%%D:/Steam/steamapps/common/Gorilla Tag" (
            set "gamePath=%%D:/Steam/steamapps/common/Gorilla Tag"
            goto afterDriveSearch
        )
    )
    color 0c
    echo Gorilla Tag directory not found on any drive.
    pause
    exit /b
)

:afterDriveSearch


color 0e
cls
title BepInEx Installer // [###-------] Downloading BepInEx
curl -L "https://github.com/BepInEx/BepInEx/releases/download/v5.4.23.4/BepInEx_win_x64_5.4.23.4.zip" -o BPNX54234.zip
if errorlevel 1 (
    color 0c
    echo Failed to download BepInEx. Check your internet connection.
    echo Error code: %errorlevel%
    pause
    exit /b
)


cls
title BepInEx Installer // [####------] Extracting BepInEx
powershell -command "Expand-Archive -Path 'BPNX54234.zip' -DestinationPath '%gamePath%' -Force"
if errorlevel 1 (
    color 0c
    echo Failed to extract BepInEx.
    echo Error code: %errorlevel%
    pause
    exit /b
)


cls
title BepInEx Installer // [#####-----] Creating directories
mkdir "%gamePath%/BepInEx/config" 2>nul
mkdir "%gamePath%/BepInEx/plugins" 2>nul

cls
title BepInEx Installer // [##########] Finished
echo Congratulations, you now have BepInEx installed!


del "BPNX54234.zip" 2>nul

if not exist "%gamePath%\BepInEx\config" mkdir "%gamePath%\BepInEx\config"
if not exist "%gamePath%\BepInEx\plugins" mkdir "%gamePath%\BepInEx\plugins"

cls
title BepInEx Installer -- Done!
echo.
echo  BepInEx Installer
echo  github.com/NotMonk1/Gorilla-Tag-BepInEx-Installer/
echo.
echo  Done! BepInEx is installed.
echo.
echo  Put mods in %gamePath%/BepInEx/plugins
echo.
start "" "%gamePath%"
echo Opened game folder in Explorer.
echo you may now close this window.
pause
cls
color 0f
title Command Prompt
exit /b
