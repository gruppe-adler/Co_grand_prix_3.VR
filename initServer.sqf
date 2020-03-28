["Initialize"] call BIS_fnc_dynamicGroups;

Grad_grandPrix_race_drivers = [];

["grad_grandPrix_race_driversUp", {
	params ["_unit"];
	if (Grad_grandPrix_race_drivers isEqualTo []) then {
		Grad_grandPrix_race_drivers = [group _unit, 1];
	} else {
		Grad_grandPrix_race_drivers set [1, (Grad_grandPrix_race_drivers select 1) +1];
	};
}] call CBA_fnc_addEventHandler;

["grad_grandPrix_race_driversDown", {
	params ["_unit"];
	if (Grad_grandPrix_race_drivers isEqualTo []) exitWith {};

	Grad_grandPrix_race_drivers  params ["_group", "_count"];

	if (_count <= 1) then {
		[{
			params ["_group"];
			["grad_grandPrix_race_results", [], _group] call CBA_fnc_targetEvent;
		}, [_group], 15] call CBA_fnc_waitAndExecute;

		[_group, "race",(missionNamespace getVariable ["grad_grandPrix_race_results", []]) select 0] call grad_grandPrix_fnc_addTime;
		Grad_grandPrix_race_drivers = [];
	} else {
		Grad_grandPrix_race_drivers set [1, _count -1];
	};
}] call CBA_fnc_addEventHandler;