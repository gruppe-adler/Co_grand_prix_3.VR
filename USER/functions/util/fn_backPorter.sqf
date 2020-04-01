params ["_obj", "_portTarget"];

_obj setVariable ["grandPrix_portTarget", _portTarget];

private _action = [
	format ["teleport_1_%1", _obj], 
	"Teleport", 
	"", 
	{
		cutText ["", "BLACK", 0.1];

		[{
			params ["_unit", "_target"];

			private _portTarget = _target getVariable "grandPrix_portTarget";

			playSound "jumpTPSound";
			_unit setPos ((getPosATL _portTarget) vectorAdd [(random 6) -4, (random 6) -4, 1]);
			
			cutText ["", "BLACK IN", 3];
		},[_player, _target], 0.3] call CBA_fnc_waitAndExecute;
	},
	{true},
	{}
] call ace_interact_menu_fnc_createAction;

[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;


