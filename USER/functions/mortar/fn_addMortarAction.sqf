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
		private _distance = missionNamespace getVariable ["GRAD_GRANDPRIX_LASTSHOTRESULT", [600]] select 0;
		private _strafe = [(Grad_grandPrix_mortar_shoots *5) + _distance] call grad_grandPrix_fnc_formatTime;
        private _message = format ["Stage stopped!<br /> Shots fired: %1<br /> Range to Target: %2 <br /> %3 Strafzeit hinzugefügt", Grad_grandPrix_mortar_shoots, _distance, _strafe];
		[_message, false] remoteExecCall ["grad_grandPrix_fnc_mortarMessage", group _player];
		[] call grad_grandPrix_fnc_mortarStop;
	},
	{!isNil "GRAD_GRADNPRIX_MORTARVEHICLE"},
	{}
] call ace_interact_menu_fnc_createAction;

[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;