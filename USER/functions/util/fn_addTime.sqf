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

diag_log format ["Grad_grandPrix_%1: %2", _station, _time];

// this is a cba hash with the group as key and a pairs array as value
// the pairs look like this -> [_stationId, [_time1, _time2]]
// e.g. ["gottes_finger", [430]]
private _stationTimes = missionNamespace getVariable [format ["grad_grandPrix_times_%1", _group], []];

if (_stationTimes isEqualTo []) then {
	_stationTimes = [_time, [[_station, _time]]];
} else {
	_stationTimes params ["_overAllTime", "_stations"];

	_overAllTime = _overAllTime + _time;
	_stations pushBackUnique [_station, _time];

	_stationTimes = [_overAllTime, _stations];
};

missionNamespace setVariable [format ["grad_grandPrix_times_%1", _group], _stationTimes];

