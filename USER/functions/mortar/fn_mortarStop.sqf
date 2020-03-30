if (isNil "GRAD_GRADNPRIX_MORTARVEHICLE") exitWith {};

GRAD_GRANDPRIX_LASTSHOTRESULT params ["_group", "_distance", "_dir"];

[_group, "Mortar", ((floor _distance) * 5)] call grad_grandPrix_fnc_addTime;

deleteVehicle GRAD_GRADNPRIX_MORTARVEHICLE;
[supplyBoxMortar] call grad_grandPrix_fnc_clearCrate;

GRAD_GRADNPRIX_MORTARVEHICLE = nil;
publicVariable "GRAD_GRADNPRIX_MORTARVEHICLE";
GRAD_GRANDPRIX_LASTPOS = [];
GRAD_GRANDPRIX_LASTSHOTRESULT = [];
