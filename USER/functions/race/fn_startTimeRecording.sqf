params ["_unit"];

if !((_unit getVariable ["grad_grandPrix_race_timerID", -1]) isEqualTo -1) exitWith {};
systemChat format ["%1", !((_unit getVariable ["grad_grandPrix_race_timerID", -1]) isEqualTo -1)];

private _id = [] call grad_grandPrix_fnc_startTimer;
_unit setVariable ["grad_grandPrix_race_timerID", _id];