# ACE Damage Modifier - Build Instructions

## Quick Build (Recommended)

### Option 1: Use the Build Script (Easiest)

1. **Double-click** `build_pbo.bat`
2. Wait for "SUCCESS!" message
3. Your PBO is ready in `@ACE_Damage_Modifier\addons\`

### Option 2: Manual Command Line

Open Command Prompt in this folder and run:

```cmd
cd "C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Tools\AddonBuilder"

AddonBuilder.exe "PATH_TO_THIS_FOLDER\addons\ace_damage_mod" "PATH_TO_THIS_FOLDER\@ACE_Damage_Modifier\addons" -clear -packonly
```

Replace `PATH_TO_THIS_FOLDER` with the actual path.

### Option 3: Using HEMTT (Advanced - Most Reliable)

**Download HEMTT:**
1. Go to: https://github.com/BrettMayson/HEMTT/releases
2. Download latest `hemtt.exe`
3. Place in this folder
4. Double-click `build_hemtt.bat`

## After Building

Your `@ACE_Damage_Modifier` folder is now ready to upload to Steam Workshop!

**Location:** `@ACE_Damage_Modifier\`

**Contains:**
- `addons\ace_damage_mod.pbo` ← The packed addon
- `mod.cpp`
- `meta.cpp`
- `README.txt`
- Other documentation files

## Uploading to Steam

1. Open **Arma 3 Launcher**
2. Go to **MODS** → **PUBLISH**
3. Select your existing mod or create new
4. Point to the `@ACE_Damage_Modifier` folder
5. Upload!

## Troubleshooting

**"AddonBuilder.exe not found":**
- Install Arma 3 Tools from Steam
- Update the path in `build_pbo.bat` if installed elsewhere

**"Build failed":**
- Make sure source files exist in `addons\ace_damage_mod\functions\`
- Check that you have all 3 .sqf files

**"Still getting errors in-game":**
- Extract the PBO with 7-Zip and verify .sqf files are inside
- Check RPT file for specific error messages

## Updating the Mod

1. Make changes to files in `addons\ace_damage_mod\`
2. Run `build_pbo.bat` again
3. Re-upload to Steam Workshop
4. Update version number in `config.cpp` if needed
