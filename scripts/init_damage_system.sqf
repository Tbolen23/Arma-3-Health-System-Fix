/*
 * ACE Damage Modifier - Initialization Script
 * Author: Tbolen23
 *
 * This script sets up the damage tracking system for all units in the mission
 * Call this from your mission's init.sqf or place it in the mission folder
 *
 * Features:
 * - AI: 3 chest/limb hits OR 1 head hit = death
 * - Players: 6 chest/leg hits OR 2 head hits = death
 * - Healing resets player damage counters
 * - Distance-based explosion lethality
 * - Works with Zeus/dynamically spawned units
 */

// Function to initialize a single unit
ACE_DMG_fnc_initUnit = {
    params ["_unit"];

    // Skip if already initialized
    if (_unit getVariable ["ace_dmg_initialized", false]) exitWith {};

    // Initialize damage counters
    _unit setVariable ["ace_dmg_chestHits", 0, true];
    _unit setVariable ["ace_dmg_headHits", 0, true];
    _unit setVariable ["ace_dmg_initialized", true, true];

    // Add damage handler
    _unit addEventHandler ["HandleDamage", {
        _this call compile preprocessFileLineNumbers "scripts\damage_handler.sqf"
    }];

    // Add explosion handler
    _unit addEventHandler ["Explosion", {
        _this call compile preprocessFileLineNumbers "scripts\explosion_handler.sqf"
    }];

    // For players: Add ACE medical treatment event to reset counters
    if (isPlayer _unit) then {
        ["ace_medical_treatmentSucceded", {
            params ["_medic", "_patient"];
            _patient setVariable ["ace_dmg_chestHits", 0, true];
            _patient setVariable ["ace_dmg_headHits", 0, true];
        }] call CBA_fnc_addEventHandler;
    };
};

// Initialize all existing units
{
    [_x] call ACE_DMG_fnc_initUnit;
} forEach allUnits;

// Handle units that spawn during mission (Zeus, scripts, etc)
["CAManBase", "init", {
    params ["_unit"];

    [{
        params ["_unit"];
        if (alive _unit && !isNull _unit) then {
            [_unit] call ACE_DMG_fnc_initUnit;
        };
    }, [_unit], 0.5] call CBA_fnc_waitAndExecute;
}, true, [], true] call CBA_fnc_addClassEventHandler;

// Confirmation message (optional - can be removed)
if (hasInterface) then {
    systemChat "ACE Damage Modifier loaded - AI: 3/1 hits, Players: 6/2 hits";
};
