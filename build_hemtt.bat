@echo off
echo ========================================
echo ACE Damage Modifier - HEMTT Builder
echo ========================================
echo.

REM Check if HEMTT exists
if not exist "%~dp0hemtt.exe" (
    echo HEMTT not found. Downloading latest version...
    echo.

    REM Try to download using PowerShell
    powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $releases = Invoke-RestMethod -Uri 'https://api.github.com/repos/BrettMayson/HEMTT/releases/latest'; $asset = $releases.assets | Where-Object { $_.name -like '*windows-x64.exe' }; Invoke-WebRequest -Uri $asset.browser_download_url -OutFile 'hemtt.exe'}"

    if %ERRORLEVEL% NEQ 0 (
        echo.
        echo ========================================
        echo ERROR: Could not download HEMTT!
        echo ========================================
        echo.
        echo Please manually download HEMTT from:
        echo https://github.com/BrettMayson/HEMTT/releases
        echo.
        echo Download the Windows x64 .exe file and rename it to hemtt.exe
        echo Place it in this folder: %~dp0
        echo.
        pause
        exit /b 1
    )

    echo HEMTT downloaded successfully!
    echo.
)

echo Building with HEMTT...
echo.

REM Run HEMTT build
"%~dp0hemtt.exe" build --release

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo SUCCESS! Mod built successfully!
    echo ========================================
    echo.
    echo Your mod is ready in the releases folder!
    echo Output: releases\@ACE_Damage_Modifier
    echo.
    echo Next steps:
    echo 1. Test the mod in Arma 3
    echo 2. Upload to Steam Workshop (see HEMTT_STEAM_GUIDE.txt)
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
