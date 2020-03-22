/*
 * Author: DerZade
 * Add time to given team
 *
 * Arguments:
 * 0: Group <GROUP>
 * 1: Station-Id <STRING>
 * 2: Time in seconds (with decimal for milliseconds) <NUMBER>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [(group player), "pew pew", 50.3] call grad_grandPrix_fnc_addTime;
 *
 * Public: No
 */

params [
	["_group", grpNull, [grpNull]],
	["_station", "", [""]],
	["_time", 0, [0]]
];

if (isNull _group) exitWith { throw "_group must not be null"; };
if ((count _station) isEqualTo 0) exitWith { throw "_station be longer than 0 chars"; };

if !(isServer) exitWith {
	_this remoteExecCall ["grad_grandPrix_fnc_addTime", 2];
};

// this is basically the same as BIS_fnc_getFromPairs, but it allows
// anything as a key instead of just strings
private _getFromPairs = {
	params ["_pairs", "_key", "_default"];

	private _index = _pairs findIf {(_x select 0) isEqualTo _key};

	private _result = _default;

	if (_index > -1) then {
		_result = (_pairs select _index) select 1;
	};

	_result;
};

// this is basically the same as BIS_fnc_setToPairs, but it allows
// anything as a key instead of just strings
private _setToPairs = {
	params ["_pairs", "_key", "_value"];

	private _pair = [_key, _value];

	private _index = _pairs findIf {(_x select 0) isEqualTo _key};

	if (_index > -1) then {
		_pairs set [_index, _pair];
	} else {
		_pairs pushBack _pair;
	};

	_pairs;
};

private _times = missionNamespace getVariable ["grad_grandPix_times", []];
private _groupTimes = [_times, _group, []] call _getFromPairs;

_groupTimes = [_groupTimes, _station, [_time]] call BIS_fnc_addToPairs;

_times = [_times, _group, _groupTimes] call _setToPairs;

grad_grandPix_times = _times;

publicVariable "grad_grandPix_times";