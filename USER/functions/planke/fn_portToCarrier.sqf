params ["_unit"];

_unit setPos ((getPosATL plankeTP_oben) vectorAdd [0,-1,0]);

_unit addBackpack "B_Parachute";
_unit linkItem "ACE_Altimeter";

[{
	params ["_unit"];

	_unit playMove "Stand";
}, [_unit]] call CBA_fnc_execNextFrame;