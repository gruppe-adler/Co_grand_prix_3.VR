params ["_mortar"];

supplyBoxMortar addItemCargoGlobal ["ACE_RangeTable_82mm", 6];
supplyBoxMortar addWeaponCargoGlobal ["Binocular", 6];
supplyBoxMortar addItemCargoGlobal ["ACE_MapTools", 6];
supplyBoxMortar addBackpackCargoGlobal ["rhsgref_wdl_alicepack", 6];
supplyBoxMortar addItemCargoGlobal ["ACE_1Rnd_82mm_Mo_HE", 300];

/*
private _dir = [];
if (selectRandom [false,true]) then {
        _dir = [0,30];
}else{
        _dir = [310,360];
};

private _pos = [getPos _mortar, [400,1500], _dir, false] call grad_grandPrix_fnc_findPos;
*/
private _pos = [5978.79,6448.1,2.28882e-005];
GRAD_GRADNPRIX_MORTARVEHICLE = createVehicle ["C_Offroad_01_F", _pos, [], 0, "NONE"];
publicVariable "GRAD_GRADNPRIX_MORTARVEHICLE";

/*
while {lineIntersects [getPosASL GRAD_GRADNPRIX_MORTARVEHICLE, getPosASL mortar_1, GRAD_GRADNPRIX_MORTARVEHICLE, mortar_1]} do {
    _pos = [getPos _mortar, [400,1700], _dir, false] call grad_grandPrix_fnc_findPos;
    GRAD_GRADNPRIX_MORTARVEHICLE setPos _pos;
};
*/
[_mortar, true] remoteExecCall ["grad_grandPrix_fnc_addFireEH", group player];

GRAD_GRADNPRIX_MORTARVEHICLE addMPEventHandler ["MPKilled", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];

    mortar_1 removeEventHandler ["Fired", GRAD_GRANDPRIX_EH];
    [mortar_1, false] remoteExecCall ["grad_grandPrix_fnc_addFireEH", group player];

    if (local _killer) then {
        [] call grad_grandPrix_fnc_mortarStop;
    };
}];

[_pos] call grad_grandPrix_fnc_fiveLiner;

GRAD_GRANDPRIX_LASTPOS = [];
GRAD_GRANDPRIX_LASTSHOTRESULT = [];
