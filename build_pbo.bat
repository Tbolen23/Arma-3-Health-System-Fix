@echo off
echo ========================================
echo ACE Damage Modifier - PBO Builder
echo ========================================
echo.

REM Set paths
set "SOURCE_DIR=%~dp0addons\ace_damage_mod"
set "DEST_DIR=%~dp0@ACE_Damage_Modifier\addons"
set "ADDON_BUILDER=C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Tools\AddonBuilder\AddonBuilder.exe"

REM Check if Arma 3 Tools is installed
if not exist "%ADDON_BUILDER%" (
    echo ERROR: Arma 3 Tools not found!
    echo Please install Arma 3 Tools from Steam.
    pause
    exit /b 1
)

REM Create destination directory if it doesn't exist
if not exist "%DEST_DIR%" mkdir "%DEST_DIR%"

REM Delete old PBO if exists
if exist "%DEST_DIR%\ace_damage_mod.pbo" (
    echo Deleting old PBO...
    del "%DEST_DIR%\ace_damage_mod.pbo"
)

echo.
echo Building PBO...
echo Source: %SOURCE_DIR%
echo Destination: %DEST_DIR%
echo.

REM Build the PBO with -clear and -packonly flags
"%ADDON_BUILDER%" "%SOURCE_DIR%" "%DEST_DIR%" -clear -packonly

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo SUCCESS! PBO created successfully!
    echo ========================================
    echo.
    echo Location: %DEST_DIR%\ace_damage_mod.pbo
    echo.
    echo You can now upload @ACE_Damage_Modifier folder to Steam Workshop!
    echo.
) else (
    echo.
    echo ========================================
    echo ERROR! Build failed!
    echo ========================================
    echo.
)

pause
