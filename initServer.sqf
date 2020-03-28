["Initialize"] call BIS_fnc_dynamicGroups;

Grad_grandPrix_plank_jumpers = [];

["grad_grandPrix_plank_jumpersUp", {
	params ["_unit"];
	if (Grad_grandPrix_plank_jumpers isEqualTo []) then {
		Grad_grandPrix_plank_jumpers = [group _unit, 1];
	} else {
		Grad_grandPrix_plank_jumpers set [1, (Grad_grandPrix_plank_jumpers select 1) +1];
	};
}] call CBA_fnc_addEventHandler;

["grad_grandPrix_plank_jumpersDown", {
	params ["_unit"];
	if (Grad_grandPrix_plank_jumpers isEqualTo []) exitWith {};

	Grad_grandPrix_plank_jumpers  params ["_group", "_count"];

	if (_count <= 1) then {
		[{
			params ["_group"];
			["grad_grandPrix_plank_result", [], _group] call CBA_fnc_targetEvent;
		}, [_group], 15] call CBA_fnc_waitAndExecute;

		[_group, "plank", (missionNamespace getVariable ["grad_grandPrix_plank_results", []]) select 0] call grad_grandPrix_fnc_addTime;
		Grad_grandPrix_plank_jumpers = [];
	} else {
		Grad_grandPrix_plank_jumpers set [1, _count -1];
	};
}] call CBA_fnc_addEventHandler;