/*
 * Author: Custom
 * Handles damage to implement custom damage system
 * AI: 3 hits to chest/limbs = kill, 1 hit to head = kill
 * Players: 6 hits to chest/legs = kill, 2 hits to head = kill
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

// Determine if unit is a player
private _isPlayer = isPlayer _unit;

// Set thresholds based on unit type
private _headThreshold = if (_isPlayer) then {2} else {1};
private _bodyThreshold = if (_isPlayer) then {6} else {3};

// Check for head hit
if (_selection in ["head", "face"] || {_hitPoint in ["hithead", "hitface"]}) then {
    private _currentHeadHits = _unit getVariable ["ace_dmg_headHits", 0];
    _currentHeadHits = _currentHeadHits + 1;
    _unit setVariable ["ace_dmg_headHits", _currentHeadHits, true];

    // Check if we've reached the threshold
    if (_currentHeadHits >= _headThreshold) then {
        // Set cardiac arrest via ACE
        [_unit, true] call ace_medical_fnc_setCardiacArrestState;

        // Return fatal damage
        exitWith {1.0};
    };

    // Apply increased damage but not fatal yet
    exitWith {_damage * 1.5};
};

// Check for chest/torso/limb hit (body and legs for AI, chest and legs for players)
private _isBodyHit = _selection in ["body", "chest", "spine1", "spine2", "spine3", "leg_l", "leg_r", "hand_l", "hand_r"] ||
                     {_hitPoint in ["hitbody", "hitchest", "hitdiaphragm", "hitlegs", "hitleftleg", "hitrightleg", "hitarms", "hitleftarm", "hitrightarm"]};

if (_isBodyHit) then {
    private _currentHits = _unit getVariable ["ace_dmg_chestHits", 0];
    _currentHits = _currentHits + 1;
    _unit setVariable ["ace_dmg_chestHits", _currentHits, true];

    // Check if we've reached the threshold
    if (_currentHits >= _bodyThreshold) then {
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
