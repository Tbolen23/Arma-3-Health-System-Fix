/*
 * Author: Tbolen23
 * Initializes the ACE Damage Modifier system
 * Sets up damage tracking for all units (AI and players)
 *
 * Arguments: None
 * Return Value: None
 * Public: No
 */

// Function to initialize a unit with damage tracking
ace_dmg_fnc_initUnit = {
    params ["_unit"];

    // Skip if already initialized
    if (_unit getVariable ["ace_dmg_initialized", false]) exitWith {};

    // Initialize damage counters
    _unit setVariable ["ace_dmg_chestHits", 0, true];
    _unit setVariable ["ace_dmg_headHits", 0, true];
    _unit setVariable ["ace_dmg_initialized", true, true];

    // Add damage handler
    _unit addEventHandler ["HandleDamage", {
        _this call ace_dmg_fnc_handleDamage
    }];

    // Add explosion handler
    _unit addEventHandler ["Explosion", {
        _this call ace_dmg_fnc_handleExplosion
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
    [_x] call ace_dmg_fnc_initUnit;
} forEach allUnits;

// Handle units that spawn during mission (Zeus, scripts, etc)
["CAManBase", "init", {
    params ["_unit"];

    [{
        params ["_unit"];
        if (alive _unit && !isNull _unit) then {
            [_unit] call ace_dmg_fnc_initUnit;
        };
    }, [_unit], 0.5] call CBA_fnc_waitAndExecute;
}, true, [], true] call CBA_fnc_addClassEventHandler;
