params ["_station"];

private _action = [
	"Start_Tauchen_mit_Wums",
	"Start",
	"",
	{["SatchelCharge_F", _target, (group _player)] call grad_grandPrix_fnc_tauchenMitWums_startStation;},
	{!(_target getVariable ["stationIsRunning", false])}
] call ace_interact_menu_fnc_createAction;

[_station, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;