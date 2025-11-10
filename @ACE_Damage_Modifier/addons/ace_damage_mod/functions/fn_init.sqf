/*
 * Author: Custom
 * Initializes the ACE damage modifier system
 * Applies to all units (players and AI)
 * Executed from postInit in CfgFunctions
 *
 * Public: No
 */

if (!hasInterface) exitWith {};

// Function to initialize a unit with damage tracking
ace_dmg_fnc_initUnit = {
    params ["_unit"];

    // Initialize hit tracking
    _unit setVariable ["ace_dmg_chestHits", 0, true];
    _unit setVariable ["ace_dmg_headHits", 0, true];

    // Add HandleDamage event handler
    _unit addEventHandler ["HandleDamage", {
        _this call ace_dmg_fnc_handleDamage
    }];

    // Add explosion event handler
    _unit addEventHandler ["Explosion", {
        _this call ace_dmg_fnc_handleExplosion
    }];

    // For players: Add ACE medical treatment event to reset counters
    if (isPlayer _unit) then {
        // Listen for ACE medical treatment finished event
        ["ace_medical_treatmentSucceded", {
            params ["_medic", "_patient"];

            // Reset hit counters when player is healed
            _patient setVariable ["ace_dmg_chestHits", 0, true];
            _patient setVariable ["ace_dmg_headHits", 0, true];
        }] call CBA_fnc_addEventHandler;
    };

    // Respawn event to reset hit counters and re-add handlers
    _unit addEventHandler ["Respawn", {
        params ["_newUnit"];
        [_newUnit] call ace_dmg_fnc_initUnit;
    }];
};

// Wait for player to be initialized
[{
    !isNull player
}, {
    // Initialize the player
    [player] call ace_dmg_fnc_initUnit;

    // Initialize all existing AI units
    {
        if (!isPlayer _x && alive _x) then {
            [_x] call ace_dmg_fnc_initUnit;
        };
    } forEach allUnits;

    // Add event handler for newly created units
    ["CAManBase", "init", {
        params ["_unit"];
        [{
            params ["_unit"];
            if (alive _unit && !isNull _unit) then {
                [_unit] call ace_dmg_fnc_initUnit;
            };
        }, [_unit], 0.5] call CBA_fnc_waitAndExecute;
    }, true, [], true] call CBA_fnc_addClassEventHandler;
}] call CBA_fnc_waitUntilAndExecute;
