/*
 * ACE Damage Modifier - Damage Handler
 * Author: Tbolen23
 *
 * Handles damage for custom hit counting system
 * AI: 3 chest/limb hits OR 1 head hit = death
 * Players: 6 chest/leg hits OR 2 head hits = death
 *
 * This is called automatically by the HandleDamage event handler
 * DO NOT call this directly!
 */

params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitPartIndex", "_instigator", "_hitPoint"];

// Only process significant damage
if (_damage < 0.05) exitWith {_damage};

// Don't process if unit is already dead
if (!alive _unit) exitWith {_damage};

// Determine if unit is a player
private _isPlayer = isPlayer _unit;

// Set thresholds based on unit type
private _headThreshold = [1, 2] select _isPlayer;
private _bodyThreshold = [3, 6] select _isPlayer;

// Check for head hit
if (_selection in ["head", "face"] || {_hitPoint in ["hithead", "hitface"]}) exitWith {
    private _currentHeadHits = _unit getVariable ["ace_dmg_headHits", 0];
    _currentHeadHits = _currentHeadHits + 1;
    _unit setVariable ["ace_dmg_headHits", _currentHeadHits, true];

    // Check if we've reached the threshold
    if (_currentHeadHits >= _headThreshold) then {
        // Set cardiac arrest via ACE
        [_unit, true] call ace_medical_fnc_setCardiacArrestState;
        // Return fatal damage
        1.0
    } else {
        // Apply increased damage but not fatal yet
        _damage * 1.5
    };
};

// Check for chest/torso/limb hit
private _isBodyHit = _selection in ["body", "chest", "spine1", "spine2", "spine3", "leg_l", "leg_r", "hand_l", "hand_r"] ||
                     {_hitPoint in ["hitbody", "hitchest", "hitdiaphragm", "hitlegs", "hitleftleg", "hitrightleg", "hitarms", "hitleftarm", "hitrightarm"]};

if (_isBodyHit) exitWith {
    private _currentHits = _unit getVariable ["ace_dmg_chestHits", 0];
    _currentHits = _currentHits + 1;
    _unit setVariable ["ace_dmg_chestHits", _currentHits, true];

    // Check if we've reached the threshold
    if (_currentHits >= _bodyThreshold) then {
        // Set cardiac arrest via ACE
        [_unit, true] call ace_medical_fnc_setCardiacArrestState;
        // Return fatal damage
        1.0
    } else {
        // Apply increased damage but not fatal yet
        _damage * 1.5
    };
};

// Return original damage for other body parts
_damage
