@echo off
echo ========================================
echo ACE Damage Modifier - HEMTT Builder
echo ========================================
echo.

REM Check if HEMTT exists
if not exist "%~dp0hemtt.exe" (
    echo ERROR: hemtt.exe not found in this folder!
    echo.
    echo Please download HEMTT from:
    echo https://github.com/BrettMayson/HEMTT/releases
    echo.
    echo Download hemtt.exe and place it in this folder.
    pause
    exit /b 1
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
    echo.
) else (
    echo.
    echo ========================================
    echo ERROR! Build failed!
    echo ========================================
    echo.
)

pause
