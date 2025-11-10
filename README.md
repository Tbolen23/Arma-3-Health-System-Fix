# ACE Damage Modifier for Arma 3

A custom Arma 3 mod that modifies ACE Medical damage behavior to create a more lethal and realistic combat environment.

## Features

### 🤖 AI Damage System
- **1 hit to the head = instant death**
- **3 hits to chest/limbs = death**
- Applies to all non-player units
- Tracks cumulative damage silently

### 👤 Player Damage System
- **2 hits to the head = death** (more forgiving than AI)
- **6 hits to chest/legs = death** (allows for extended firefights)
- Tracks cumulative damage silently
- **Healing resets counters** - Medic gameplay is viable and encouraged
- No in-game notifications (clean gameplay)

### 💥 Explosion Damage (Same for All)
Distance-based lethality that varies by explosion size:
- **Small explosions** (grenades): ~5m lethal range
- **Medium explosions** (RPG, small rockets): ~10m lethal range
- **Large explosions** (bombs, large rockets): ~20m lethal range
- Scaling damage beyond lethal range
- Applies equally to players and AI

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
- Hit counters are stored per-unit and reset on respawn
- **For players: Healing via ACE Medical resets hit counters**
- Different thresholds for players vs AI

### ACE Medical Integration
- Uses `ace_medical_fnc_setCardiacArrestState` for lethal hits
- Compatible with ACE medical settings
- Works with ACE's advanced medical system
- **Healing events reset player damage counters** for viable medic gameplay
- Silent operation - no in-game notifications for clean immersive gameplay
- Applies to all units in the mission (players and AI)

## Configuration

The mod currently uses hardcoded values. To customize:

Edit `addons/ace_damage_mod/functions/fn_handleDamage.sqf`:
- AI thresholds: 1 head hit, 3 chest/limb hits
- Player thresholds: 2 head hits, 6 chest/leg hits
- Modify damage multipliers

Edit `addons/ace_damage_mod/functions/fn_handleExplosion.sqf`:
- Adjust lethal distances for each explosion size
- Modify explosion size thresholds

Edit `addons/ace_damage_mod/functions/fn_init.sqf`:
- Modify healing reset behavior
- Change which units are affected

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

### 2.0.0 (Current)
- Separate damage thresholds for AI vs Players
- AI: 1 head hit, 3 chest/limb hits
- Players: 2 head hits, 6 chest/leg hits
- Healing resets player damage counters
- Applies to all units (players and AI)
- Distance-based explosion lethality (same for all)
- ACE Medical integration
- Silent operation (no notifications)

### 1.0.0 (Initial Release)
- Head shot kills (1 hit)
- Chest damage tracking (3 hits)
- Distance-based explosion lethality
- ACE Medical integration
- Silent operation (no notifications)
