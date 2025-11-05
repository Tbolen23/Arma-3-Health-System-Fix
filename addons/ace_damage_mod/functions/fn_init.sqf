/*
 * Author: Custom
 * Initializes the ACE damage modifier system
 * Executed from postInit in CfgFunctions
 *
 * Public: No
 */

if (!hasInterface) exitWith {};

// Wait for player to be initialized
[{
    !isNull player
}, {
    // Initialize hit tracking for the player
    player setVariable ["ace_dmg_chestHits", 0, true];
    player setVariable ["ace_dmg_headHits", 0, true];

    // Add HandleDamage event handler
    player addEventHandler ["HandleDamage", {
        _this call ace_dmg_fnc_handleDamage
    }];

    // Add explosion event handler
    player addEventHandler ["Explosion", {
        _this call ace_dmg_fnc_handleExplosion
    }];

    // Respawn event to reset hit counters
    player addEventHandler ["Respawn", {
        params ["_unit"];
        _unit setVariable ["ace_dmg_chestHits", 0, true];
        _unit setVariable ["ace_dmg_headHits", 0, true];

        // Re-add event handlers
        _unit addEventHandler ["HandleDamage", {
            _this call ace_dmg_fnc_handleDamage
        }];

        _unit addEventHandler ["Explosion", {
            _this call ace_dmg_fnc_handleExplosion
        }];
    }];

    systemChat "ACE Damage Modifier: Initialized (3 chest hits, 1 head hit = death)";
}] call CBA_fnc_waitUntilAndExecute;
