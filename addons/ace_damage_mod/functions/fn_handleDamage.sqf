/*
 * Author: Custom
 * Handles damage to implement custom damage system
 * - 3 hits to chest = kill
 * - 1 hit to head = kill
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Selection <STRING>
 * 2: Damage <NUMBER>
 * 3: Source <OBJECT>
 * 4: Projectile <STRING>
 * 5: HitPartIndex <NUMBER>
 * 6: Instigator <OBJECT>
 * 7: HitPoint <STRING>
 *
 * Return Value:
 * Damage to apply <NUMBER>
 *
 * Public: No
 */

params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitPartIndex", "_instigator", "_hitPoint"];

// Only process significant damage
if (_damage < 0.05) exitWith {_damage};

// Don't process if unit is already dead
if (!alive _unit) exitWith {_damage};

// Check for head hit
if (_selection in ["head", "face"] || {_hitPoint in ["hithead", "hitface"]}) then {
    // Instant kill on head hit
    systemChat "ACE Damage Mod: Head hit detected - Fatal!";
    _unit setVariable ["ace_dmg_headHits", 1, true];

    // Set cardiac arrest via ACE
    [_unit, true] call ace_medical_fnc_setCardiacArrestState;

    // Return fatal damage
    exitWith {1.0};
};

// Check for chest/torso hit
if (_selection in ["body", "chest", "spine1", "spine2", "spine3"] || {_hitPoint in ["hitbody", "hitchest", "hitdiaphragm"]}) then {
    private _currentHits = _unit getVariable ["ace_dmg_chestHits", 0];
    _currentHits = _currentHits + 1;
    _unit setVariable ["ace_dmg_chestHits", _currentHits, true];

    systemChat format ["ACE Damage Mod: Chest hit %1/3", _currentHits];

    // Check if we've reached 3 hits
    if (_currentHits >= 3) then {
        systemChat "ACE Damage Mod: 3 chest hits detected - Fatal!";

        // Set cardiac arrest via ACE
        [_unit, true] call ace_medical_fnc_setCardiacArrestState;

        // Return fatal damage
        exitWith {1.0};
    };

    // Apply increased damage but not fatal yet
    exitWith {_damage * 1.5};
};

// Return original damage for other body parts
_damage
