params ["_unit"];

if !(local _unit) exitWith {};

private _id = _unit getVariable ["grad_grandPrix_race_timerID", -1];
if (_id isEqualTo -1) exitWith {};

private _time = [_id] call grad_grandPrix_fnc_stopTimer;

private _results = missionNamespace getVariable ["grad_grandPrix_race_results", []];
_results pushBackUnique [_unit, _time];
missionNamespace setVariable ["grad_grandPrix_race_results", _results, true];

//Todo: Show time to racer
private _formatedTime = [_time] call grad_grandPrix_fnc_formatTime;