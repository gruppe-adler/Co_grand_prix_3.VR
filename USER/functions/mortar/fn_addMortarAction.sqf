params ["_obj"];

private _action = [
	"start_mortar", 
	"Start Mortar Stage", 
	"a3\ui_f\data\IGUI\Cfg\Actions\talk_ca.paa", 
	{[mortar_1] call grad_grandPrix_fnc_mortarInit;},
	{isNil "GRAD_GRADNPRIX_MORTARVEHICLE"},
	{}
] call ace_interact_menu_fnc_createAction;

[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

private _action = [
	"stop_mortar", 
	"Stop Mortar Stage", 
	"", 
	{[] call grad_grandPrix_fnc_mortarStop;},
	{!isNil "GRAD_GRADNPRIX_MORTARVEHICLE"},
	{}
] call ace_interact_menu_fnc_createAction;

[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;