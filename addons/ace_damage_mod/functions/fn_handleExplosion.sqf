/*
 * Author: Tbolen23
 * Handles explosion damage with distance-based lethality
 * Same for both AI and players
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Damage <NUMBER>
 * 2: Distance <NUMBER> - Distance from explosion
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_damage", "_distance"];

// Only process significant damage
if (_damage < 0.1) exitWith {};

// Don't process if unit is already dead
if (!alive _unit) exitWith {};

// Determine lethal distance based on explosion size
private _lethalDistance = 5;

if (_damage > 0.7) then {
    _lethalDistance = 20;  // Large explosion (artillery, large bombs)
} else {
    if (_damage > 0.4) then {
        _lethalDistance = 10;  // Medium explosion (grenades, small rockets)
    };
};

// Check if within lethal distance
if (_distance <= _lethalDistance) then {
    // Kill unit after short delay to let ACE process
    [{
        params ["_unit"];
        if (alive _unit) then {
            [_unit, true] call ace_medical_fnc_setCardiacArrestState;
            _unit setDamage 1;
        };
    }, [_unit], 0.1] call CBA_fnc_waitAndExecute;
};
