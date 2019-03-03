#include "script_component.hpp"

// Exit on Headless
if (!hasInterface) exitWith {};

[QGVAR(initialized), {
    private _persistenceClientVersion = "oda_persistence_client" callExtension "version";
    if (_persistenceClientVersion != REQUIRED_PERSISTENCECLIENT_VERSION) exitWith {
        ERROR_2("Failed to initialize - Wrong Persistence Client extension version (active: %1 - required: %2)!",_persistenceClientVersion,REQUIRED_PERSISTENCECLIENT_VERSION);
        [format ["Your connection has been terminated - Wrong Persistence Client extension version (active: %1 - required: %2)!", _persistenceClientVersion, REQUIRED_PERSISTENCECLIENT_VERSION]] call FUNC(endMissionError);
    };

    // Terminate to lobby EH
    [QGVAR(terminatePlayer), {
        params ["_player"];
        _player setVariable [QGVAR(lastSavedTime), -1, true];
        ERROR("Connection terminated - Unknown error with Persistence!");
        ["Your connection has been terminated - Unknown error with Persistence!"] call FUNC(endMissionError);
    }] call CBA_fnc_addEventHandler;

    // Load player after Respawn EH
    [QGVAR(reinitializePlayer), {
        params ["_player", "_registeredDeath"];
        TRACE_1("Reinitialization",_this);

        if (_registeredDeath == "done") then {
            _player setVariable [QGVAR(lastSavedTime), -1, true];
            [_player, "respawned"] call FUNC(playerLoadClient);
        } else {
            ERROR("Connection terminated - Death failed to register!");
            [localize LSTRING(RespawnReinitialization)] call FUNC(endMissionError);
        };
    }] call CBA_fnc_addEventHandler;

    // Load player
    [player, "loaded"] call FUNC(playerLoadClient);
}] call CBA_fnc_addEventHandler;
