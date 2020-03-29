params ["_obj"];

private _action = [
	"mortar_game", 
	"Mörser Feuerauftrag anfordern", 
	"a3\ui_f\data\IGUI\Cfg\Actions\talk_ca.paa", 
	{[_target] call grad_grandPrix_fnc_mortarInit},{true},
	{}
] call ace_interact_menu_fnc_createAction;

[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;