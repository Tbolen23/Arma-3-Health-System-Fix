@echo off
echo ========================================
echo ACE Damage Modifier - HEMTT Builder
echo ========================================
echo.

REM Check if HEMTT exists
if not exist "%~dp0hemtt.exe" (
    echo HEMTT not found!
    echo.
    echo Please download HEMTT manually:
    echo https://github.com/BrettMayson/HEMTT/releases/download/v1.17.2/windows-x64.zip
    echo.
    echo Extract it, rename to hemtt.exe, and place in this folder.
    echo.
    pause
    exit /b 1
)

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
    echo IMPORTANT: The folder has @@ (double @) but you need single @
    echo Rename it to @ACE_Damage_Modifier before copying to Arma 3!
    echo.
    echo Next steps:
    echo 1. Copy releases\@ACE_Damage_Modifier to your Arma 3 folder
    echo 2. Enable in launcher
    echo 3. DISABLE: ACE Armor Adjuster and Armor System mods
    echo 4. Test in-game!
    echo.
) else (
    echo.
    echo ========================================
    echo ERROR! Build failed!
    echo ========================================
    echo.
)

pause
