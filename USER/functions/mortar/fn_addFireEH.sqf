params ["_mortar"];

grad_grandPrix_EH = [_mortar, "fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

    [_projectile, (group _gunner)] call grad_grandPrix_fnc_logPos;
}, []] call CBA_fnc_addBISEventHandler;