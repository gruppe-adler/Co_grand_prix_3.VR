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

// this is a cba hash with the group as key and a pairs array as value
// the pairs look like this -> [_stationId, [_time1, _time2]]
// e.g. ["gottes_finger", [430]]
private _times = missionNamespace getVariable ["grad_grandPrix_times", ([] call CBA_fnc_hashCreate)];

private _groupTimes = [];
if ([_times, _group] call CBA_fnc_hashHasKey) then {
	_groupTimes = [_times, _group] call CBA_fnc_hashGet;
};

_groupTimes = [_groupTimes, _station, [_time]] call BIS_fnc_addToPairs;

_times = [_times, _group, _groupTimes] call CBA_fnc_hashSet;

grad_grandPrix_times = _times;

publicVariable "grad_grandPrix_times";