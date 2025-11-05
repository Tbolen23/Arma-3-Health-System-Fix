/*
 * Author: Custom
 * Handles explosion damage with distance-based lethality
 * Smaller explosions need closer range, larger ones kill from further away
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Damage <NUMBER>
 * 2: Distance <NUMBER> - Distance from explosion center
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_damage", "_distance"];

// Don't process if unit is already dead
if (!alive _unit) exitWith {};

// Explosion damage thresholds based on distance
// Small explosions (grenades): ~5m lethal range
// Medium explosions (RPG, small rockets): ~10m lethal range
// Large explosions (bombs, large rockets): ~20m lethal range

private _lethalDistance = 0;

// Determine explosion size based on damage dealt
// Higher base damage = larger explosion
if (_damage > 0.7) then {
    // Large explosion
    _lethalDistance = 20;
    systemChat format ["ACE Damage Mod: Large explosion at %1m", round _distance];
} else {
    if (_damage > 0.4) then {
        // Medium explosion
        _lethalDistance = 10;
        systemChat format ["ACE Damage Mod: Medium explosion at %1m", round _distance];
    } else {
        // Small explosion
        _lethalDistance = 5;
        systemChat format ["ACE Damage Mod: Small explosion at %1m", round _distance];
    };
};

// Check if within lethal distance
if (_distance <= _lethalDistance) then {
    systemChat "ACE Damage Mod: Lethal explosion range - Fatal!";

    // Set cardiac arrest via ACE medical
    [{
        params ["_unit"];
        [_unit, true] call ace_medical_fnc_setCardiacArrestState;

        // Also apply massive damage to ensure death
        _unit setDamage 1;
    }, [_unit], 0.1] call CBA_fnc_waitAndExecute;
} else {
    // Apply scaling damage based on distance beyond lethal range
    private _damageMultiplier = 1 - ((_distance - _lethalDistance) / _lethalDistance);
    _damageMultiplier = _damageMultiplier max 0;

    if (_damageMultiplier > 0) then {
        [{
            params ["_unit", "_mult"];
            private _currentDamage = damage _unit;
            _unit setDamage (_currentDamage + (0.5 * _mult));
        }, [_unit, _damageMultiplier], 0.1] call CBA_fnc_waitAndExecute;
    };
};
