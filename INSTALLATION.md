# ACE Damage Modifier - Mission Scripts Installation

Simple damage modifier for Arma 3 missions using ACE Medical.

## Features

- **AI**: 3 chest/limb hits OR 1 head hit = death
- **Players**: 6 chest/leg hits OR 2 head hits = death
- **Healing**: ACE Medical treatment resets player damage counters
- **Explosions**: Distance-based lethality (same for all units)
  - Large: 20m lethal radius
  - Medium: 10m lethal radius
  - Small: 5m lethal radius
- **Zeus Compatible**: Works with dynamically spawned units
- **No Notifications**: Silent operation

---

## Requirements

- CBA_A3
- ACE Medical

**Important**: Disable these mods (they conflict):
- ❌ ACE Armor Adjuster
- ❌ Armor System

---

## Installation (3 Steps)

### Step 1: Copy Scripts to Your Mission

1. Find your mission folder:
   ```
   Documents\Arma 3\missions\YourMission.MapName\
   ```

2. Copy the **entire `scripts` folder** from this repository into your mission folder

Your mission folder should now look like:
```
YourMission.MapName\
  ├── mission.sqm
  ├── scripts\              ← New folder
  │   ├── init_damage_system.sqf
  │   ├── damage_handler.sqf
  │   └── explosion_handler.sqf
  └── (your other mission files)
```

---

### Step 2: Add to init.sqf

**Option A - If you DON'T have an init.sqf:**
1. Copy the provided `init.sqf` into your mission folder

**Option B - If you ALREADY have an init.sqf:**
1. Open your existing `init.sqf`
2. Add this line at the TOP:
   ```sqf
   [] execVM "scripts\init_damage_system.sqf";
   ```

---

### Step 3: Test

1. Load your mission in the editor
2. Place some AI units
3. Preview the mission
4. You should see: "ACE Damage Modifier loaded - AI: 3/1 hits, Players: 6/2 hits"
5. Test:
   - Shoot AI 3 times in chest → Dies
   - Shoot AI 1 time in head → Dies instantly

**Done!** ✅

---

## Troubleshooting

### "File not found" errors

**Problem**: Scripts can't be found

**Fix**:
- Make sure the `scripts` folder is in your mission root
- Check capitalization: `scripts\init_damage_system.sqf` (lowercase 's')
- Verify all 3 .sqf files are present

---

### Units dying in 1 shot

**Problem**: ACE Armor Adjuster or Armor System is still enabled

**Fix**:
- Open Arma 3 Launcher
- MODS tab
- Disable: ACE Armor Adjuster and Armor System

---

### No message appears / system not working

**Problem**: CBA or ACE not loaded

**Fix**:
- Enable CBA_A3 in launcher
- Enable ACE in launcher
- Make sure they load BEFORE your mission starts

---

### Works for existing units but not Zeus spawns

**Problem**: This shouldn't happen - Zeus is supported by default

**Fix**:
- Make sure you're running the latest version of the script
- Check RPT log for errors: `%localappdata%\Arma 3\`

---

## Customization

### Change Damage Thresholds

Edit `scripts\damage_handler.sqf`:

```sqf
// Line 35-36: Change these numbers
private _headThreshold = [1, 2] select _isPlayer;  // [AI, Player]
private _bodyThreshold = [3, 6] select _isPlayer;  // [AI, Player]
```

Examples:
- `[1, 1]` = 1 hit kills everyone
- `[5, 10]` = 5 hits AI, 10 hits players
- `[3, 3]` = Same for everyone

### Change Explosion Distances

Edit `scripts\explosion_handler.sqf`:

```sqf
// Line 24-30: Change these distances
if (_damage > 0.7) then {
    _lethalDistance = 20;  // Large explosion
} else {
    if (_damage > 0.4) then {
        _lethalDistance = 10;  // Medium explosion
    };
};
```

### Remove Chat Notification

Edit `scripts\init_damage_system.sqf`:

```sqf
// Line 51-54: Delete or comment out these lines
if (hasInterface) then {
    systemChat "ACE Damage Modifier loaded - AI: 3/1 hits, Players: 6/2 hits";
};
```

---

## How It Works

1. **init_damage_system.sqf**: Runs once when mission starts
   - Sets up event handlers on all units
   - Monitors for new spawns (Zeus, scripts)

2. **damage_handler.sqf**: Runs every time a unit takes damage
   - Tracks hit counts per body part
   - Triggers cardiac arrest when threshold reached

3. **explosion_handler.sqf**: Runs when a unit is near explosion
   - Calculates distance from explosion
   - Instant kill if within lethal radius

---

## Multiplayer Notes

- ✅ Works in multiplayer
- ✅ Works with JIP (Join In Progress)
- ✅ Damage counters synchronized across clients
- ✅ Works with respawn (counters auto-reset)

---

## Removing the System

1. Delete the `scripts` folder from your mission
2. Remove the line from `init.sqf`:
   ```sqf
   [] execVM "scripts\init_damage_system.sqf";
   ```

---

## Support

If something isn't working:

1. Check the RPT file: `%localappdata%\Arma 3\`
2. Search for errors mentioning "ace_dmg" or "damage_handler"
3. Verify CBA and ACE are loaded
4. Disable conflicting mods

---

## Version

2.0.0 - Mission Scripts

## Author

Tbolen23
