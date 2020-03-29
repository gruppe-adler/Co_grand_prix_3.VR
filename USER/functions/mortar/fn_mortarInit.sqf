params ["_mortar"];

supplyBoxMortar addItemCargoGlobal ["ACE_RangeTable_82mm", 6];
supplyBoxMortar addWeaponCargoGlobal ["Binocular", 6];
supplyBoxMortar addItemCargoGlobal ["ACE_MapTools", 6];

private _dir = [];
if (selectRandom [false,true]) then {
        _dir = [0,30];
}else{
        _dir = [310,360];
};

private _pos = [getPos _mortar, [400,1700], _dir, false] call grad_grandPrix_fnc_findPos;

GRAD_GRADNPRIX_MORTARVEHICLE = createVehicle ["C_Offroad_01_F", _pos, [], 0, "NONE"];
publicVariable "GRAD_GRADNPRIX_MORTARVEHICLE";

while {lineIntersects [getPosASL GRAD_GRADNPRIX_MORTARVEHICLE, getPosASL mortar_1, GRAD_GRADNPRIX_MORTARVEHICLE, mortar_1]} do {
    _pos = [getPos _mortar, [400,1700], _dir, false] call grad_grandPrix_fnc_findPos;
    GRAD_GRADNPRIX_MORTARVEHICLE setPos _pos;
};

grad_grandPrix_EH = [_mortar, "fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
    _unit setAmmo [((weapons _unit)select 0), 1000000];
    [_projectile, (group _gunner)] call grad_grandPrix_fnc_logPos;
}, []] call CBA_fnc_addBISEventHandler;

GRAD_GRADNPRIX_MORTARVEHICLE addMPEventHandler ["MPKilled", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];

    mortar_1 removeEventHandler ["Fired", GRAD_GRANDPRIX_EH];
    deleteVehicle _unit;
    if (local _killer) then {
        ["TaskSucceeded",["","Ziel zerstört!"]] remoteExec ["BIS_fnc_showNotification", group _killer, false];
    };
}];

[900, [GRAD_GRADNPRIX_MORTARVEHICLE], grad_grandPrix_EH, _mortar, player] call grad_grandPrix_fnc_cleanUp;

[_pos] call grad_grandPrix_fnc_fiveLiner;
MORTARSHOT_LASTPOS = [];

