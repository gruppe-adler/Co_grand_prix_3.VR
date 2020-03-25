params ["_unit"];

[_unit, "GetInMan" {
	params ["_unit"];

	_unit removeEventHandler ["GetInMan", _thisID];
	_unit setVariable ["Grad_grandPrix_plank_pullhight", (getPosASL _unit) select 0];
}] call CBA_fnc_addBISEventHandler;

[_unit, "GetOutMan" {
	params ["_unit"];

	_unit removeEventHandler ["GetOutMan", _thisID];
	
	[_unit] call grad_grandPrix_fnc_jumpResults;
}] call CBA_fnc_addBISEventHandler;