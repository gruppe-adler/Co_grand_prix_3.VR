private _results = missionNamespace getVariable ["grad_grandPrix_race_results", []];
missionNamespace setVariable ["grad_grandPrix_race_results", [], true];

//Todo show results
private _formatedTime = [_time] call grad_grandPrix_fnc_formatTime;
