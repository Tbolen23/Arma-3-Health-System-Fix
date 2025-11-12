@echo off
echo ========================================
echo ACE Damage Modifier - HEMTT Builder
echo ========================================
echo.

REM Check if HEMTT exists
if exist "%~dp0hemtt.exe" (
    echo HEMTT found!
    goto :build
)

echo HEMTT not found. Downloading automatically...
echo.

REM Download HEMTT using PowerShell
echo Downloading HEMTT v1.17.2...
powershell -Command "& {$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri 'https://github.com/BrettMayson/HEMTT/releases/download/v1.17.2/windows-x64.zip' -OutFile 'hemtt_temp.zip'}"

if not exist hemtt_temp.zip (
    echo.
    echo ERROR: Download failed!
    echo Please download manually from:
    echo https://github.com/BrettMayson/HEMTT/releases/download/v1.17.2/windows-x64.zip
    echo.
    pause
    exit /b 1
)

echo Extracting HEMTT...
powershell -Command "& {Expand-Archive -Path 'hemtt_temp.zip' -DestinationPath '.' -Force}"

if exist windows-x64.exe (
    ren windows-x64.exe hemtt.exe
    del hemtt_temp.zip
    echo HEMTT downloaded and installed successfully!
    echo.
) else (
    echo ERROR: Extraction failed!
    del hemtt_temp.zip
    pause
    exit /b 1
)

:build
echo Building with HEMTT...
echo.

REM Run HEMTT release
"%~dp0hemtt.exe" release

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo SUCCESS! Mod built successfully!
    echo ========================================
    echo.
    echo Your mod is ready in: releases\@ACE_Damage_Modifier
    echo.
    echo NEXT STEPS:
    echo 1. Copy releases\@ACE_Damage_Modifier to your Arma 3 folder
    echo 2. Enable in Arma 3 Launcher
    echo 3. DISABLE: ACE Armor Adjuster and Armor System mods
    echo 4. Test in-game!
    echo.
    echo Mod structure:
    echo   @ACE_Damage_Modifier\
    echo     - addons\
    echo       - ace_dmg_ace_damage_mod.pbo
    echo     - mod.cpp
    echo.
) else (
    echo.
    echo ========================================
    echo ERROR! Build failed!
    echo ========================================
    echo.
    echo Check the error messages above.
    echo.
)

pause
