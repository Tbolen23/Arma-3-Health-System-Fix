# ACE Damage Modifier for Arma 3

A custom Arma 3 mod that modifies ACE Medical damage behavior to create a more lethal and realistic combat environment.

## Features

### 🎯 Head Shots
- **1 hit to the head = instant death**
- Applies to any head or face hit
- Triggers immediate cardiac arrest via ACE Medical

### 🫀 Chest Shots
- **3 hits to the chest/torso = death**
- Tracks cumulative chest damage silently
- Triggers cardiac arrest after 3rd hit
- No in-game notifications (clean gameplay)

### 💥 Explosion Damage
Distance-based lethality that varies by explosion size:
- **Small explosions** (grenades): ~5m lethal range
- **Medium explosions** (RPG, small rockets): ~10m lethal range
- **Large explosions** (bombs, large rockets): ~20m lethal range
- Scaling damage beyond lethal range

## Requirements

- **Arma 3**
- **ACE Medical** (ace_medical)
- **ACE Medical Damage** (ace_medical_damage)
- **CBA_A3** (Community Base Addons)

## Installation

### Method 1: Steam Workshop (Recommended - Coming Soon)
1. Subscribe to the mod on Steam Workshop
2. Arma 3 will automatically download and install it
3. Enable the mod in Arma 3 Launcher
4. Make sure ACE and CBA are loaded before this mod

### Method 2: Manual Installation
1. Download the `@ACE_Damage_Modifier` folder from releases
2. Copy it to your Arma 3 directory
3. Add `-mod=@ACE_Damage_Modifier` to your launch parameters
4. Make sure ACE and CBA are loaded before this mod

### Method 3: Development/Testing
1. Copy the `addons` folder to your Arma 3 installation
2. Use PBO Manager or similar tool to pack the addon:
   - Pack `addons/ace_damage_mod` into `ace_damage_mod.pbo`
3. Place the PBO in your Arma 3 `addons` folder or create a mod folder

### Uploading to Steam Workshop
See `@ACE_Damage_Modifier/WORKSHOP_GUIDE.txt` for detailed instructions on uploading this mod to Steam Workshop.

## How It Works

### Damage Tracking
The mod uses event handlers to track damage to specific body parts:
- `HandleDamage` event tracks bullet/projectile hits
- `Explosion` event handles blast damage
- Hit counters are stored per-player and reset on respawn

### ACE Medical Integration
- Uses `ace_medical_fnc_setCardiacArrestState` for lethal hits
- Compatible with ACE medical settings
- Works with ACE's advanced medical system
- Silent operation - no in-game notifications for clean immersive gameplay

## Configuration

The mod currently uses hardcoded values. To customize:

Edit `addons/ace_damage_mod/functions/fn_handleDamage.sqf`:
- Change chest hit threshold (default: 3)
- Modify damage multipliers

Edit `addons/ace_damage_mod/functions/fn_handleExplosion.sqf`:
- Adjust lethal distances for each explosion size
- Modify explosion size thresholds

## Building the PBO

To create a proper PBO file:

1. **Using Addon Builder (Arma 3 Tools)**:
   - Source: `addons/ace_damage_mod`
   - Destination: Your mod folder
   - Build

2. **Using PBO Manager**:
   - Right-click `addons/ace_damage_mod` folder
   - Select "Pack into PBO"

3. **Using command line** (makepbo/cpbo):
   ```bash
   makepbo -P addons/ace_damage_mod
   ```

## Troubleshooting

**Mod not loading:**
- Ensure ACE Medical and CBA are loaded first
- Check RPT file for errors
- Verify mod is in launch parameters

**Damage not being tracked:**
- Make sure ACE Medical is enabled
- Check that you're using ACE medical settings (not vanilla medical)
- Verify CBA is installed

**Explosions not working as expected:**
- Explosion damage varies by ammo type
- Distance is calculated from explosion center
- Some custom weapons may behave differently

## Compatibility

- ✅ Works with ACE Medical (required)
- ✅ Works with ACE Advanced Medical
- ✅ Compatible with most weapon mods
- ✅ Compatible with most mission types
- ⚠️ May conflict with other damage modification mods

## Development

### File Structure
```
addons/ace_damage_mod/
├── $PBOPREFIX$              # PBO prefix file
├── config.cpp               # Main configuration
└── functions/
    ├── fn_init.sqf          # Initialization
    ├── fn_handleDamage.sqf  # Damage handler
    └── fn_handleExplosion.sqf # Explosion handler
```

### Contributing
Feel free to submit issues or pull requests for improvements.

## Credits

- ACE Team for ACE Medical
- CBA Team for Community Base Addons

## License

This mod is provided as-is for the Arma 3 community.

## Steam Workshop Upload

This mod is ready for Steam Workshop! See the complete upload guide:
- `@ACE_Damage_Modifier/WORKSHOP_GUIDE.txt` - Step-by-step upload instructions
- `@ACE_Damage_Modifier/` - Properly structured mod folder
- `@ACE_Damage_Modifier/meta.cpp` - Steam Workshop metadata

## Version History

### 1.0.0 (Initial Release)
- Head shot kills (1 hit)
- Chest damage tracking (3 hits)
- Distance-based explosion lethality
- ACE Medical integration
- Silent operation (no notifications)
