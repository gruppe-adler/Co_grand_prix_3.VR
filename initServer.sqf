["Initialize"] call BIS_fnc_dynamicGroups;

Grad_grandPrix_race_drivers = [];
Grad_grandPrix_plank_jumpers = [];

private _objects = nearestTerrainObjects [bigGate_1, ["BUILDING"], 20];
grad_grandPrix_intro_outerGate = _objects select 0;

_objects = nearestTerrainObjects [bigGate_2, ["HOUSE"], 20];
grad_grandPrix_intro_innerGate = _objects select 0;

_objects = nearestTerrainObjects [bigGate_3, ["HOUSE"], 20];
grad_grandPrix_intro_yardGate1 = _objects select 0;

_objects = nearestTerrainObjects [bigGate_4, ["HOUSE"], 20];
grad_grandPrix_intro_yardGate2 = _objects select 0;

_objects = nearestTerrainObjects [mainHall, ["BUILDING"], 20];
grad_grandPrix_intro_mainHall = _objects select 1;

["grad_grandPrix_race_driversUp", {
	params ["_unit"];
	if (Grad_grandPrix_race_drivers isEqualTo []) then {
		Grad_grandPrix_race_drivers = [group _unit, 1];
	} else {
		Grad_grandPrix_race_drivers params ["_group", "_count", "_units"];
		private _index = _units pushBackUnique _unit;

		if !(_index isEqualTo -1) then {
			Grad_grandPrix_race_drivers = [_group, _count +1, _units];
		};
	};
}] call CBA_fnc_addEventHandler;

["grad_grandPrix_race_driversDown", {
	params ["_unit"];
	if (Grad_grandPrix_race_drivers isEqualTo []) exitWith {};

	Grad_grandPrix_race_drivers  params ["_group", "_count", "_units"];

	if (_count <= 1) then {

		[{
			params ["_group"];
			["grad_grandPrix_race_result", [], _group] call CBA_fnc_targetEvent;

			[{
				params ["_group"];
				private _best = missionNamespace getVariable ["grad_grandPrix_race_results", []] select 0;
				missionNamespace setVariable ["grad_grandPrix_race_results", [], true];

				_best params ["_unit", "_time"];
				private _strafe = [_time] call grad_grandPrix_fnc_formatTime;

				private _message = format ["%1 Strafzeit hinzugefügt", _strafe];
				[_message, false] remoteExecCall ["grad_grandPrix_fnc_mortarMessage", group _unit];

				[_group, "race", _time] call grad_grandPrix_fnc_addTime;
			}, [_group], 15] call CBA_fnc_waitAndExecute;
		}, [_group], 15] call CBA_fnc_waitAndExecute;

		Grad_grandPrix_race_drivers = [];
	} else {
		private _index = _units pushBackUnique _unit;

		if !(_index isEqualTo -1) then {
			_units deleteAt _index;
			Grad_grandPrix_race_drivers = [_group, _count -1, _units];
		};
	};
}] call CBA_fnc_addEventHandler;

["grad_grandPrix_plank_jumpersUp", {
	params ["_unit"];
	
	if (Grad_grandPrix_plank_jumpers isEqualTo []) then {
		Grad_grandPrix_plank_jumpers = [group _unit, 1, [_unit]];
	} else {
		Grad_grandPrix_plank_jumpers params ["_group", "_count", "_units"];
		private _index = _units pushBackUnique _unit;

		if !(_index isEqualTo -1) then {
			Grad_grandPrix_plank_jumpers = [_group, _count +1, _units];
		};
	};
}] call CBA_fnc_addEventHandler;

["grad_grandPrix_plank_jumpersDown", {
	params ["_unit"];
	if (Grad_grandPrix_plank_jumpers isEqualTo []) exitWith {};

	Grad_grandPrix_plank_jumpers params ["_group", "_count", "_units"];

	if (_count <= 1) then {
		[{
			params ["_group"];
			["grad_grandPrix_plank_result", [], _group] call CBA_fnc_targetEvent;

			[{
				params ["_group"];
				private _best = missionNamespace getVariable ["grad_grandPrix_plank_results", []] select 0;
				missionNamespace setVariable ["grad_grandPrix_plank_results", [], true];

				_best params ["_unit", "_pullHeight", "_distance"];

				private _time = (floor(_pullHeight*0.1)) + (floor(_distance));
				private _strafe = [_time] call grad_grandPrix_fnc_formatTime;

				private _message = format ["%1 Strafzeit hinzugefügt", _strafe];
				[_message, false] remoteExecCall ["grad_grandPrix_fnc_mortarMessage", group _unit];

				[_group, "plank", _time] call grad_grandPrix_fnc_addTime;
			}, [_group], 15] call CBA_fnc_waitAndExecute;
		}, [_group], 15] call CBA_fnc_waitAndExecute;

		Grad_grandPrix_plank_jumpers = [];
	} else {
		private _index = _units pushBackUnique _unit;

		if !(_index isEqualTo -1) then {
			_units deleteAt _index;
			Grad_grandPrix_plank_jumpers = [_group, _count -1, _units];
		};
	};
}] call CBA_fnc_addEventHandler;

["grad_grandPrix_intro_outerGate_open", {
	if (grad_grandPrix_intro_outerGate animationSourcePhase "Zeroanimation" > 0) exitWith {};

	grad_grandPrix_intro_outerGate animateSource ["Zeroanimation", 5];
}] call CBA_fnc_addEventHandler;

["grad_grandPrix_intro_outerGate_close", {
	if (grad_grandPrix_intro_outerGate animationSourcePhase "Zeroanimation" < 5) exitWith {};

	grad_grandPrix_intro_outerGate animateSource ["Zeroanimation", 0];
}] call CBA_fnc_addEventHandler;

["grad_grandPrix_intro_innerGate_open", {
	if (grad_grandPrix_intro_innerGate animationSourcePhase "Zeroanimation" > 0) exitWith {};

	grad_grandPrix_intro_innerGate animateSource ["Zeroanimation", 12];
}] call CBA_fnc_addEventHandler;

["grad_grandPrix_intro_innerGate_close", {
	if (grad_grandPrix_intro_innerGate animationSourcePhase "Zeroanimation" < 12) exitWith {};

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

["grad_grandPrix_startGroupTimer", {
	params ["_group"];

	private _id = missionNamespace getVariable [format["groupTimer%1", _group], -1];
	if !(_id isEqualTo -1) exitWith {};

	_id = [] call grad_grandPrix_fnc_startTimer;
	missionNamespace setVariable [format["groupTimer%1", _group], _id];
}] call CBA_fnc_addEventHandler;

["grad_grandPrix_stopGroupTimer", {
	params ["_group"];

	private _id = missionNamespace getVariable [format["groupTimer%1", _group], -1];
	if (_id isEqualTo -1) exitWith {};
	missionNamespace setVariable [format["groupTimer%1", _group], -1];

	private _time = [_id] call grad_grandPrix_fnc_stopTimer;
	private _formatedTime = [_time] call grad_grandPrix_fnc_formatTime;

}] call CBA_fnc_addEventHandler;