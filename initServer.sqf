["Initialize"] call BIS_fnc_dynamicGroups;

Grad_grandPrix_race_drivers = [];
Grad_grandPrix_plank_jumpers = [];

private _objects = nearestTerrainObjects [bigGate_1, ["BUILDING"], 20];
grad_grandPrix_intro_outerGate = _objects select 0;

_objects = nearestTerrainObjects [bigGate_2, ["HOUSE"], 20];
grad_grandPrix_intro_innerGate = _objects select 0;

_objects = nearestTerrainObjects [bigGate_3, ["HOUSE"], 20];
grad_grandPrix_intro_yardGate1 = _objects select 0;

_objects = nearestTerrainObjects [bigGate_3, ["HOUSE"], 20];
grad_grandPrix_intro_yardGate2 = _objects select 0;

_objects = nearestTerrainObjects [mainHall, ["BUILDING"], 20];
grad_grandPrix_intro_mainHall = _objects select 1;

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

	Grad_grandPrix_plank_jumpers params ["_group", "_count"];

	systemChat format ["Jump counter: %1", _count];

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

["grad_grandPrix_intro_outerGate_open", {
	if (grad_grandPrix_intro_outerGate animationSourcePhase "Zeroanimation" > 0) exitWith {};

	grad_grandPrix_intro_outerGate animateSource ["Zeroanimation", 5];
}] call CBA_fnc_addEventHandler;

["grad_grandPrix_intro_innerGate_open", {
	if (grad_grandPrix_intro_innerGate animationSourcePhase "Zeroanimation" > 0) exitWith {};

	grad_grandPrix_intro_innerGate animateSource ["Zeroanimation", 12];
}] call CBA_fnc_addEventHandler;

["grad_grandPrix_intro_yardGate1_open", {
	if (grad_grandPrix_intro_yardGate1 animationSourcePhase "Zeroanimation" < 0) exitWith {};

	grad_grandPrix_intro_yardGate1 animateSource ["Zeroanimation", -2];
}] call CBA_fnc_addEventHandler;

["grad_grandPrix_intro_yardGate2_open", {
	if (grad_grandPrix_intro_yardGate2 animationSourcePhase "Zeroanimation" < 0) exitWith {};

	grad_grandPrix_intro_yardGate2 animateSource ["Zeroanimation", -2];
}] call CBA_fnc_addEventHandler;

["grad_grandPrix_intro_mainHall_open", {
	if (grad_grandPrix_intro_mainHall animationSourcePhase "Zeroanimation" > 0) exitWith {};

	grad_grandPrix_intro_mainHall animateSource ["OneAnimation", -2];
	grad_grandPrix_intro_mainHall animateSource ["Zeroanimation", 1];
	grad_grandPrix_intro_mainHall animateSource ["TwoAnimation", 2];
}] call CBA_fnc_addEventHandler;