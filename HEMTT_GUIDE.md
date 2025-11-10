# HEMTT Build and Steam Workshop Guide

## What is HEMTT?

HEMTT (Huge Engine for Massive Touchy Truckloads) is a modern build tool for Arma 3 mods used by professional mod developers like LambsDanger. Unlike Arma 3's Addon Builder, HEMTT **correctly handles** the `$PBOPREFIX$` file, which is critical for proper mod loading.

## Why Use HEMTT?

- ✅ **Respects $PBOPREFIX$**: Correctly sets PBO prefix header (z\ace_dmg\addons\ace_damage_mod)
- ✅ **Professional**: Used by major mods like LambsDanger, ACE3, CBA
- ✅ **Cross-platform**: Works on Windows, Linux, Mac
- ✅ **CI/CD Ready**: Can be automated with GitHub Actions
- ✅ **No Installation Required**: Single executable file

## Quick Start

### Option 1: Automated Build (Recommended)

1. **Run the build script**:
   ```batch
   build_hemtt.bat
   ```

2. **First time only**: Script will automatically download HEMTT for you

3. **Wait for build**: HEMTT will build your mod and place it in `releases/@ACE_Damage_Modifier`

### Option 2: Manual HEMTT Download

1. Download HEMTT from: https://github.com/BrettMayson/HEMTT/releases
2. Download the `hemtt-windows-x64.exe` file
3. Rename it to `hemtt.exe`
4. Place it in your mod's root folder
5. Run `build_hemtt.bat`

## Testing Your Build

1. **Copy the mod folder**:
   - Copy `releases\@ACE_Damage_Modifier` to your Arma 3 root directory
   - Should be in: `C:\Program Files (x86)\Steam\steamapps\common\Arma 3\`

2. **Launch Arma 3 with the mod**:
   - Open Arma 3 Launcher
   - Go to "MODS" tab
   - Enable "@ACE Damage Modifier"
   - Click "PLAY"

3. **Check for errors**:
   - If you see "file not found" errors → Build tool problem (HEMTT should fix this!)
   - If you see "unexpected modDIR" errors → PBO prefix problem (HEMTT should fix this!)
   - No errors? Success! 🎉

4. **Test in-game**:
   - Start a mission with ACE Medical enabled
   - Test AI: 3 chest/limb hits or 1 head hit should kill
   - Test Player: 6 chest/leg hits or 2 head hits should kill
   - Test healing: Medic treatment should reset damage counters
   - Test Zeus: Spawned units should have damage tracking

## Uploading to Steam Workshop

### Prerequisites

1. **Arma 3 Tools** (from Steam):
   - Open Steam Library
   - Search for "Arma 3 Tools"
   - Install it (free if you own Arma 3)

2. **Publisher Account**:
   - You need to accept Steam Workshop legal agreement
   - First time publishing requires this one-time setup

### Upload Steps

1. **Open Publisher**:
   - Launch "Arma 3 Tools" from Steam
   - Click "Publisher" button

2. **Create New Item** (first time only):
   - Click "New" button
   - Select "Mod" as item type
   - This creates your Workshop ID

3. **Fill Out Details**:
   - **Title**: ACE Damage Modifier
   - **Description**: See `STEAM_DESCRIPTION.txt` for pre-written description
   - **Visibility**: Public (or Friends Only for testing)
   - **Tags**: Add relevant tags (ACE, Medical, Damage, etc.)

4. **Select Your Mod**:
   - **Source Directory**: Browse to `releases\@ACE_Damage_Modifier`
   - **Important**: Select the `@ACE_Damage_Modifier` folder, not the parent folder!

5. **Add Preview Image** (optional but recommended):
   - Create a 512x512 or 1024x1024 image
   - Show what your mod does (e.g., "Realistic Damage System")

6. **Publish**:
   - Click "Publish" button
   - Wait for upload to complete (can take a few minutes)
   - Copy the Workshop URL when done!

### Updating Your Mod

When you make code changes and want to update:

1. **Rebuild with HEMTT**:
   ```batch
   build_hemtt.bat
   ```

2. **Open Publisher**:
   - Launch Arma 3 Tools → Publisher
   - Your mod should appear in the list

3. **Update**:
   - Click your mod in the list
   - Make any description changes if needed
   - Click "Publish" to upload the new version
   - **Important**: Make sure Source Directory still points to `releases\@ACE_Damage_Modifier`

4. **Add Change Notes**:
   - Publisher will ask for change notes
   - Example: "Fixed player damage thresholds" or "Added Zeus compatibility"

## Configuration Files

### `.hemtt/project.toml`
This is the main HEMTT configuration:

```toml
name = "ACE Damage Modifier"
prefix = "ace_dmg"           # Short prefix for your mod
mainprefix = "z"             # Creates z\ namespace
author = "Tbolen23"
version = "2.0.1"

[hemtt.release]
sign = false                 # No code signing required

[hemtt.build]
# Build configuration
```

**Key Points**:
- `prefix = "ace_dmg"` + `mainprefix = "z"` creates the full prefix: `z\ace_dmg`
- Combined with addon name creates: `z\ace_dmg\addons\ace_damage_mod`
- This matches what's in your `$PBOPREFIX$` file!

### `addons/ace_damage_mod/$PBOPREFIX$`
Contains the full path HEMTT will use:
```
z\ace_dmg\addons\ace_damage_mod
```

**Must match**: The combination of mainprefix + prefix + "addons" + folder name

## Troubleshooting

### Build Fails

**"hemtt.exe not found"**:
- Run `build_hemtt.bat` to auto-download
- Or manually download from GitHub releases

**"Failed to parse project.toml"**:
- Check `.hemtt/project.toml` for syntax errors
- Make sure `name`, `prefix`, `mainprefix` are on separate lines

**"No addons found"**:
- Make sure `addons/ace_damage_mod/` folder exists
- Check that `config.cpp` is present

### Game Errors After Build

**"File not found" errors**:
- Check if PBO was actually built in `releases/`
- Verify you copied the entire `@ACE_Damage_Modifier` folder
- Enable mods in Arma 3 Launcher

**"Unexpected modDIR"**:
- This should NOT happen with HEMTT!
- If it does, verify `.hemtt/project.toml` settings
- Check `$PBOPREFIX$` file content

**Functions don't work**:
- Check RPT file: `C:\Users\YourName\AppData\Local\Arma 3\`
- Look for specific error messages
- Verify ACE Medical is loaded before your mod

### Steam Workshop Issues

**"Failed to publish"**:
- Make sure you accepted Workshop legal agreement
- Check internet connection
- Try closing and reopening Publisher

**"Mod doesn't appear in Workshop"**:
- Wait a few minutes for Steam to process
- Check your Steam Workshop profile page
- Visibility might be set to "Hidden" or "Friends Only"

**"Subscribers can't use mod"**:
- Make sure visibility is set to "Public"
- Verify mod actually uploaded (check file size in Workshop)
- Ask subscribers to verify they enabled it in launcher

## Comparison: HEMTT vs Other Tools

| Tool | Respects $PBOPREFIX$ | Cross-Platform | Auto-Download | Used By |
|------|---------------------|----------------|---------------|---------|
| **HEMTT** | ✅ Yes | ✅ Yes | ✅ Yes | LambsDanger, ACE3, CBA |
| Mikero's Tools | ✅ Yes | ❌ Windows Only | ❌ No | Many mods |
| Arma 3 Addon Builder | ❌ **NO** | ❌ Windows Only | ✅ With game | ⚠️ Not recommended |

**Winner**: HEMTT - Modern, professional, and handles everything correctly.

## Advanced: GitHub Actions (Optional)

Want to automatically build your mod on GitHub? LambsDanger uses this:

1. Create `.github/workflows/build.yml`:
```yaml
name: Build

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: arma-actions/hemtt@v1
      - run: hemtt build --release
```

2. Commit and push
3. GitHub will automatically build your mod on every commit!

## Support

If you encounter issues:

1. **Check HEMTT docs**: https://hemtt.dev
2. **Check Arma 3 logs**: `%localappdata%\Arma 3\` (look for .rpt files)
3. **Verify mod structure**: Make sure all files are present
4. **Test locally first**: Always test before uploading to Workshop

## Summary

✅ **Use HEMTT** for building your mod (not Addon Builder!)
✅ **Run `build_hemtt.bat`** to build automatically
✅ **Test locally** in `releases/@ACE_Damage_Modifier`
✅ **Upload to Steam Workshop** via Arma 3 Tools → Publisher
✅ **Update by rebuilding** and republishing

That's it! You're now ready to build and share your mod professionally. 🎉
