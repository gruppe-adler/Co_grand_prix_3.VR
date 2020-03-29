params ["_mortar"];

if !(isNull GRAD_GRADNPRIX_MORTARVEHICLE) exitWith {[(getPos GRAD_GRADNPRIX_MORTARVEHICLE)] call grad_grandPrix_fnc_fiveLiner;};

private _pos = [getPos _mortar, [100,3000], [310,40], false] call grad_grandPrix_fnc_findPos;

GRAD_GRADNPRIX_MORTARVEHICLE = createVehicle ["C_Offroad_01_F", _pos, [], 0, "CAN_COLLIDE"];

grad_grandPrix_EH = [_mortar, "fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
    _unit setAmmo [((weapons _unit)select 0), 1000000];
    [_projectile, (group _gunner)] call grad_grandPrix_fnc_logPos;
}, []] call CBA_fnc_addBISEventHandler;

[GRAD_GRADNPRIX_MORTARVEHICLE, "MPKilled", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
    (_unit getVariable "grad_grandPrix_MORTAR") removeEventHandler ["Fired", grad_grandPrix_EH];
    deleteVehicle _unit;
    if (local _killer) then {
        ["TaskSucceeded",["","Ziel zerstört!"]] remoteExec ["BIS_fnc_showNotification",_killer,false];
    };
}, []] call CBA_fnc_addBISEventHandler;

[900, [GRAD_GRADNPRIX_MORTARVEHICLE], grad_grandPrix_EH, _mortar, player] call grad_grandPrix_fnc_cleanUp;

[_pos] call grad_grandPrix_fnc_fiveLiner;
MORTARSHOT_LASTPOS = [];

