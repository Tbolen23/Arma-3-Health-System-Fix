# ACE Damage Modifier - MOD Installation

Pre-built mod version ready to use. No building required!

## Download Pre-Built Mod

The mod is already built for you in the `releases/@ACE_Damage_Modifier` folder!

---

## Installation (2 Steps)

### Step 1: Copy Mod to Arma 3

1. Go to `releases/@ACE_Damage_Modifier` folder in this repository
2. Copy the entire `@ACE_Damage_Modifier` folder
3. Paste it into your Arma 3 directory:
   ```
   C:\Program Files (x86)\Steam\steamapps\common\Arma 3\
   ```

### Step 2: Enable in Launcher

1. Open Arma 3 Launcher
2. Go to MODS tab
3. Find "ACE Damage Modifier" and enable it
4. **DISABLE these conflicting mods**:
   - ❌ ACE Armor Adjuster
   - ❌ Armor System
5. Make sure these are **enabled**:
   - ✅ CBA_A3
   - ✅ ace (ACE3)
6. Click PLAY

---

## Testing

1. Editor → Place AI enemy
2. Preview mission
3. Shoot AI:
   - 3 chest hits → Dies
   - 1 head hit → Dies instantly
4. Works! ✅

---

## What This Mod Does

- **AI**: 3 chest/limb hits OR 1 head hit = death
- **Players**: 6 chest/leg hits OR 2 head hits = death
- **Healing**: ACE Medical treatment resets player damage counters
- **Explosions**:
  - Large: 20m instant kill radius
  - Medium: 10m instant kill radius
  - Small: 5m instant kill radius
- **Zeus Compatible**: Works automatically
- **Multiplayer**: Works perfectly
- **No Notifications**: Silent operation

---

## Verified Build Info

```
PBO Prefix: z\ace_dmg\addons\ace_damage_mod ✓
Size: 11.27 KB
Dependencies: CBA_A3, ACE Medical ✓
Version: 2.0.2
```

This PBO was built with HEMTT 1.17.2 and verified to have the correct prefix.

---

## Troubleshooting

### "File not found" errors
- You copied the wrong folder
- Make sure you copied `@ACE_Damage_Modifier` (with the @ symbol)
- Delete it from Arma 3 folder and recopy from `releases/`

### Units dying in 1 shot
- ACE Armor Adjuster or Armor System is still enabled
- Disable them in launcher

### Mod doesn't appear in launcher
- Folder must be named `@ACE_Damage_Modifier` (with @)
- Must be in Arma 3 root directory
- Click refresh in launcher

### Version conflict with ACE
- You have multiple ACE mods enabled
- Keep only the main "ace" mod (Workshop ID: 463939057)
- Disable old ACE versions

---

## vs Mission Scripts

**Use the MOD if:**
- You want it in ALL missions automatically
- You play on servers that allow it
- You want "install once, use everywhere"

**Use the MISSION SCRIPTS if:**
- You only want it in specific missions
- You want to customize per-mission
- Server doesn't allow mods
- See [INSTALLATION.md](INSTALLATION.md)

---

## Files Included

The mod folder contains:
```
@ACE_Damage_Modifier/
  ├── addons/
  │   └── ace_dmg_ace_damage_mod.pbo  ← The actual mod
  ├── mod.cpp                         ← Mod metadata
  └── README.md                       ← Info
```

---

## Updating

When a new version is released:
1. Delete old `@ACE_Damage_Modifier` from Arma 3 folder
2. Copy new `@ACE_Damage_Modifier` from `releases/`
3. Done!

---

## Building from Source (Optional)

If you want to build it yourself instead of using the pre-built version:

See the source code in `addons/ace_damage_mod/` folder.

**Not recommended** - just use the pre-built version from `releases/`!

---

## Version

2.0.2

## Author

Tbolen23
