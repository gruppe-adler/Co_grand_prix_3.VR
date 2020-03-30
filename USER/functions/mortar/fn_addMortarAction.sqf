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
	{
		[format ["Stage stopped! Shots fired: %1, Range to Target: %2", Grad_grandPrix_mortar_shoots, GRAD_GRANDPRIX_LASTSHOTRESULT select 0]] remoteExecCall ["grad_grandPrix_fnc_mortarMessage", group _player];
		[] call grad_grandPrix_fnc_mortarStop;
	},
	{!isNil "GRAD_GRADNPRIX_MORTARVEHICLE"},
	{}
] call ace_interact_menu_fnc_createAction;

[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;