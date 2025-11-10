@echo off
echo ========================================
echo ACE Damage Modifier - Mikero PBO Builder
echo ========================================
echo.

REM Set paths
set "SOURCE_DIR=%~dp0addons\ace_damage_mod"
set "DEST_DIR=%~dp0@ACE_Damage_Modifier\addons"

REM Check for Mikero's MakePbo
where makepbo >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Found Mikero's MakePbo! Using correct tool...
    echo.
    goto :UseMikero
) else (
    echo.
    echo ========================================
    echo WARNING: Mikero's Tools NOT Found!
    echo ========================================
    echo.
    echo Arma 3 Addon Builder does NOT properly
    echo handle $PBOPREFIX$ files!
    echo.
    echo Your PBO will have WRONG prefix header!
    echo This causes "file not found" errors!
    echo.
    echo SOLUTION:
    echo 1. Download Mikero's Tools from:
    echo    https://mikero.bytex.digital/Downloads
    echo 2. Install "DePbo Tools"
    echo 3. Restart computer
    echo 4. Run this script again
    echo.
    echo ========================================
    echo.
    pause
    exit /b 1
)

:UseMikero
REM Create destination directory
if not exist "%DEST_DIR%" mkdir "%DEST_DIR%"

REM Delete old PBO if exists
if exist "%DEST_DIR%\ace_damage_mod.pbo" (
    echo Deleting old PBO...
    del "%DEST_DIR%\ace_damage_mod.pbo"
)

echo Building PBO with Mikero's MakePbo...
echo Source: %SOURCE_DIR%
echo Destination: %DEST_DIR%
echo.

REM Build with MakePbo (proper tool that respects $PBOPREFIX$)
cd /d "%~dp0addons"
makepbo -P ace_damage_mod

REM Check if PBO was created
if exist "ace_damage_mod.pbo" (
    echo.
    echo Moving PBO to destination...
    move "ace_damage_mod.pbo" "%DEST_DIR%\"

    echo.
    echo ========================================
    echo SUCCESS! PBO created with Mikero's Tools!
    echo ========================================
    echo.
    echo Location: %DEST_DIR%\ace_damage_mod.pbo
    echo.
    echo IMPORTANT: Verify the PBO:
    echo 1. Right-click the .pbo file
    echo 2. Select "ExtractPbo" or "View PBO"
    echo 3. Check header shows: z\ace_dmg\addons\ace_damage_mod
    echo.
    echo You can now upload @ACE_Damage_Modifier to Steam Workshop!
    echo.
) else (
    echo.
    echo ========================================
    echo ERROR! Build failed!
    echo ========================================
    echo.
    echo Check for errors above.
    echo.
)

pause
