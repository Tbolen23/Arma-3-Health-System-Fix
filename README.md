# ACE Damage Modifier - Mission Scripts

Simple drop-in scripts for Arma 3 missions that modify ACE Medical damage thresholds.

## Quick Overview

- **AI**: 3 chest/limb hits OR 1 head hit = death
- **Players**: 6 chest/leg hits OR 2 head hits = death
- **Healing**: Resets player damage counters
- **Explosions**: Distance-based lethality
- **Zeus Compatible**: Works with dynamic spawns

---

## Installation (30 seconds)

1. **Copy** the `scripts` folder to your mission folder
2. **Add** this line to your `init.sqf`:
   ```sqf
   [] execVM "scripts\init_damage_system.sqf";
   ```
3. **Done!** Load your mission and test

📖 **See [INSTALLATION.md](INSTALLATION.md) for detailed instructions**

---

## Requirements

- CBA_A3
- ACE Medical

**Disable these mods (they conflict):**
- ❌ ACE Armor Adjuster
- ❌ Armor System

---

## File Structure

```
scripts/
  ├── init_damage_system.sqf   ← Main initialization
  ├── damage_handler.sqf        ← Handles bullet damage
  └── explosion_handler.sqf     ← Handles explosion damage
```

---

## What It Does

### Bullet Damage
- Tracks hits to head and chest/limbs separately
- **AI**: Dies after 3 body hits OR 1 head hit
- **Players**: Dies after 6 body hits OR 2 head hits
- Triggers ACE cardiac arrest when threshold reached

### Explosion Damage
- Distance-based instant death
- Large explosions (>0.7 damage): 20m lethal radius
- Medium explosions (>0.4 damage): 10m lethal radius
- Small explosions: 5m lethal radius

### Healing
- When players receive ACE Medical treatment
- Damage counters reset to 0
- Allows medic gameplay to keep players alive

### Dynamic Spawning
- Automatically works with Zeus
- Works with script-spawned units
- Works with respawn

---

## Customization

All thresholds and distances are easily customizable. See [INSTALLATION.md](INSTALLATION.md#customization) for details.

Example changes:
- Make everyone die in 1 hit
- Make players tankier (10 hits)
- Increase/decrease explosion ranges
- Remove the chat notification

---

## Version

2.0.0

## Author

Tbolen23

## License

Free to use and modify
