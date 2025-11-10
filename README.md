# ACE Damage Modifier

Balanced damage system for ACE Medical with separate AI/Player thresholds and distance-based explosion lethality.

## Features

- **AI Damage**: 3 chest/limb hits or 1 head hit = death
- **Player Damage**: 6 chest/leg hits or 2 head hits = death
- **Healing Resets**: ACE Medical treatment resets player damage counters for medic gameplay
- **Explosion Damage**: Distance-based lethality (same for AI and players)
  - Large explosions (>0.7 damage): 20m lethal radius
  - Medium explosions (>0.4 damage): 10m lethal radius
  - Small explosions: 5m lethal radius
- **Zeus Compatible**: Works with dynamically spawned units
- **No Notifications**: Silent operation, no in-game spam

## Requirements

- CBA_A3
- ACE Medical
- ACE Medical Damage

## Installation

1. Download the latest release
2. Extract `@ACE_Damage_Modifier` to your Arma 3 folder
3. Enable in Arma 3 Launcher
4. Make sure CBA and ACE are loaded before this mod

## Known Conflicts

**Disable these mods:**
- ACE Armor Adjuster (conflicts with HandleDamage)
- Armor System (conflicts with damage tracking)

## Building from Source

Requires HEMTT: https://github.com/BrettMayson/HEMTT

```bash
# Windows
build_hemtt.bat

# Linux/Mac
./build_hemtt.sh
```

Output: `releases/@ACE_Damage_Modifier/`

## Version

2.0.2

## Author

Tbolen23

## License

Feel free to modify and redistribute.
