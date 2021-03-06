/*
 * Author: Jonpas
 * Handles save and corpse removal on disconnect.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: ID <NUMBER> (unused)
 * 2: UID <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [unit, 11, "51792927127296126"] call oda_persistence_fnc_handleDisconnect
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit", "", "_uid"];
TRACE_1("Handle Disconnect",_this);

// Exit if null unit or saving never started
private _lastSavedTime = _unit getVariable [QGVAR(lastSavedTime), -1];
if (isNull _unit || {_lastSavedTime == -1}) exitWith {
    ERROR_1("Player not saved on disconnect - UID (%1) or LastSavedTime (%2) undefined!",getPlayerUID _player,_lastSavedTime);
};

[_unit, _uid, "save"] call FUNC(playerSingletonSave);

deleteVehicle _unit;
