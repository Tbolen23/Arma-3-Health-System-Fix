# Quick Start Guide

## Step 1: Build the Mod

**Just double-click `build_hemtt.bat`** - That's it!

The script will:
- ✅ Automatically download HEMTT if needed (first time only)
- ✅ Build your mod
- ✅ Show you where the mod is ready

You should see:
- "Downloading HEMTT..." (first time only)
- "Config loaded for ACE Damage Modifier"
- "Built 1 PBOs"
- "SUCCESS! Mod built successfully!"

## Step 2: Install to Arma 3

1. Open `releases\` folder
2. Copy `@ACE_Damage_Modifier` folder to:
   ```
   C:\Program Files (x86)\Steam\steamapps\common\Arma 3\
   ```

## Step 3: Configure Launcher

1. Open Arma 3 Launcher
2. MODS tab
3. **DISABLE these mods** (they conflict!):
   - ❌ ACE Armor Adjuster
   - ❌ Armor System
4. **ENABLE these mods**:
   - ✅ CBA_A3
   - ✅ ace
   - ✅ ACE Damage Modifier (your new mod!)
5. Click PLAY

## Step 4: Test

1. Editor → Place enemy AI
2. Shoot AI 3 times in chest → Should die
3. Shoot AI 1 time in head → Should die instantly

**If it works**: Success! ✅

**If you see "File not found" errors**:
- You copied the wrong folder or old build
- Delete from Arma 3 folder and copy fresh build

**If AI dies in 1 shot**:
- ACE Armor Adjuster or Armor System is still enabled
- Disable them completely

## What This Mod Does

- **AI**: 3 chest/limb hits OR 1 head hit = death
- **Players**: 6 chest/leg hits OR 2 head hits = death
- **Healing**: Resets player damage counters
- **Explosions**: Distance-based lethality (same for all)

## Need Help?

Check the full README.md for detailed troubleshooting.

The PBO **MUST** have this prefix: `z\ace_dmg\addons\ace_damage_mod`

You can verify by opening the PBO with Notepad and checking the "prefix" line near the top.
