/*
 * Author: DerZade
 * Initialize station
 *
 * Arguments:
 * 0: Station object <OBJECT>
 * 1: Posititons <ARRAY>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [this, [[0,0], [100,100]]] call grad_grandPrix_fnc_gottesFinger_initStation;
 *
 * Public: No
 */

#include "script_component.hpp"

params [["_station", objNull, [objNull]], ["_positions", [], [[]]]];

if (isNull _station) exitWith { throw "_station must not be null"; };
if ((count _positions) isEqualTo 0) exitWith { throw "_positions must at least contain one element"; };

// validate array to contain only arrays with 2 or 3 numbers
for "_i" FROM 0 TO ((count _positions) - 1) do {
	private _elem = _positions param [_i, [], [[]], [2,3]];

	for "_j" from 0 to (count _elem) do {
		_elem param [_j, 0, [0]];
	}
};

// store available positions
_station setVariable [QGVAR(availablePositions), _positions];

private _action1 = [
	QGVAR(start),
	"Start",
	"",
	{[_target, (group _player)] call FUNC_CUSTOM(start);},
	{!(_target getVariable [QGVAR(running), false])}
] call ace_interact_menu_fnc_createAction;

private _action2 = [
	QGVAR(guess),
	"Position raten",
	"",
	{[_target, _player] call FUNC_CUSTOM(openDisplay);},
	{_target getVariable [QGVAR(running), false]}
] call ace_interact_menu_fnc_createAction;

private _action3 = [
	QGVAR(cancel),
	"Abbrechen",
	"",
	{
		[_target, _player] spawn {
			params ["_target", "_player"];

			private _result = [
				"Bist du dir sicher, dass du abbrechen willst?", 
				"Abbrechen",
				true,
				true,
				(findDisplay 46)
			] call BIS_fnc_guiMessage;

			if (!_result) exitWith {};

			[_target, _player] call FUNC_CUSTOM(cancel);
		}
		
	},
	{(_target getVariable [QGVAR(running), false]) && [] call grad_adminMessages_fnc_isAdminOrZeus}
] call ace_interact_menu_fnc_createAction;

[_station, 0, ["ACE_MainActions"], _action1] call ace_interact_menu_fnc_addActionToObject;
[_station, 0, ["ACE_MainActions"], _action2] call ace_interact_menu_fnc_addActionToObject;
[_station, 0, ["ACE_MainActions"], _action3] call ace_interact_menu_fnc_addActionToObject;
