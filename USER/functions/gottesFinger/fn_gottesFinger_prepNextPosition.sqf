/*
 * Author: DerZade
 * Prep next target. Pops a target from the positions list and spawns arrow at it's position.
 *
 * Arguments:
 * 0: Station object <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [_station] call grad_grandPrix_fnc_gottesFinger_prepNextPosition;
 *
 * Public: No
 */

#include "script_component.hpp"
#include "macros.hpp"

params [["_station", objNull, [objNull]]];

if (isNull _station) exitWith { throw "_station must not be null"; };

if !(isServer) exitWith {
	_this remoteExecCall [QFUNC_CUSTOM(start), 2];
};

// delete old target
private _oldTarget = _station getVariable [QGVAR(target), objNull];
if !(isNull _oldTarget) then {
	deleteVehicle _oldTarget;
};

private _positions = _station getVariable [QGVAR(positions), []];

if ((count _positions) isEqualTo 0) exitWith {
	[_station] call FUNC_CUSTOM(end);
};

private _nextPos = [_positions] call BIS_fnc_arrayShift;
_nextPos set [2, 0];

private _target = createVehicle [GRAD_GRANDPRIX_GOTTESFINGER_VEHICLE, _nextPos, [], 0, "CAN_COLLIDE"];

// update variables
_station setVariable [QGVAR(positions), _positions, true];
_station setVariable [QGVAR(currentPosition), _nextPos, true];
_station setVariable [QGVAR(target), _target, true];
