params ["_unit"];

if (!local _unit) exitWith {};

private _id = [] call grad_grandPrix_fnc_startTimer;
_unit setVariable ["grad_grandPrix_race_timerID", _id];