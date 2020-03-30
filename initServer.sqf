["Initialize"] call BIS_fnc_dynamicGroups;

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

	grad_grandPrix_intro_mainHall animateSource ["OneAnimation", 0];
	grad_grandPrix_intro_mainHall animateSource ["Zeroanimation", 1];
	grad_grandPrix_intro_mainHall animateSource ["TwoAnimation", 2];
}] call CBA_fnc_addEventHandler;