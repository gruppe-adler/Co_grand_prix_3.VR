params ["_mortar", "_bool"];

if (_bool) then {
	grad_grandPrix_EH = [_mortar, "fired", {
		params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

		Grad_grandPrix_mortar_shoots = Grad_grandPrix_mortar_shoots +1;
		publicVariable "Grad_grandPrix_mortar_shoots";

		[_projectile, (group _gunner)] call grad_grandPrix_fnc_logPos;
	}, []] call CBA_fnc_addBISEventHandler;
} else {
	mortar_1 removeEventHandler ["Fired", GRAD_GRANDPRIX_EH];
};