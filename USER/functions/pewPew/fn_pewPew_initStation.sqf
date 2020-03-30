params ["_station"];

private _action = [
    "Start_Erst_Schiessen_Dann_Fragen",
    "Start",
    "",
    {[_target, (group _player)] call grad_grandPrix_fnc_pewPew_startStation;},
    {!(_target getVariable ["stationIsRunning", false])}
] call ace_interact_menu_fnc_createAction;

[_station, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;