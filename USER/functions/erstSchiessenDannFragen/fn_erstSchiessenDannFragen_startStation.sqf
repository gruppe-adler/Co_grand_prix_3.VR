params ["_station", "_playerGroup"];

if !(isServer) exitWith {
	_this remoteExecCall ["grad_grandPrix_fnc_erstSchiessenDannFragen_startStation", 2];
};

_station setVariable ["stationIsRunning", true, true];

private _targetsNorth = [NorthTarget1, NorthTarget2, NorthTarget3, NorthTarget4, NorthTarget5, NorthTarget6, NorthTarget7, NorthTarget8, NorthTarget9, NorthHostage1, NorthHostage2];
private _targetsEast = [EastTarget1, EastTarget2, EastTarget3, EastTarget4, EastTarget5, EastTarget6, EastTarget7, EastTarget8, EastTarget9, EastHostage1, EastHostage2];
private _targetsSouth = [SouthTarget1, SouthTarget2, SouthTarget3, SouthTarget4, SouthTarget5, SouthTarget6, SouthTarget7, SouthTarget8, SouthTarget9, SouthHostage1, SouthHostage2];
private _targetsWest = [WestTarget1, WestTarget2, WestTarget3, WestTarget4, WestTarget5, WestTarget6, WestTarget7, WestTarget8, WestTarget9, WestHostage1, WestHostage2];
private _allTargets = _targetsNorth + _targetsEast + _targetsSouth + _targetsWest;
private _portPositions = [ReaktionsschiessenPort1, ReaktionsschiessenPort2, ReaktionsschiessenPort3, ReaktionsschiessenPort4, ReaktionsschiessenPort5, ReaktionsschiessenPort6];

_station setVariable ["targetsNorth", _targetsNorth];
_station setVariable ["targetsEast", _targetsEast];
_station setVariable ["targetsSouth", _targetsSouth];
_station setVariable ["targetsWest", _targetsWest];
_station setVariable ["targetsHit", []];
_station setVariable ["hostagesHit", []];
// _station setVariable ["targetsRemaining", _allTargets];

{
	// Current result is saved in variable _x
	_x animate ["terc", 1];
	_x allowDamage true;
	_x setVariable ["noPop", true, true];
} forEach _allTargets;

[{
	params ["_portPositions", "_playerGroup"];
	{
		// Current result is saved in variable _x
		private _pos = selectRandom _portPositions;
		_portPositions deleteAt (_portPositions find _pos);
		_x setPosASL (getPosASL _pos);
	} forEach (units _playerGroup);
}, [_portPositions, _playerGroup], 0.5] call CBA_fnc_waitAndExecute;

[{
	params ["_station", "_playerGroup"];
	{
		// Current result is saved in variable _x
		["drillStart"] remoteExec ["playSound", _x];
	} forEach (units _playerGroup);
	[{
		params ["_args", "_handle"];
		_args params ["_station", "_playerGroup"];

		if ((count(_station getVariable "targetsNorth") + count(_station getVariable "targetsEast") + count(_station getVariable "targetsSouth") + count(_station getVariable "targetsWest")) <= 0) exitWith {
			[_handle] call CBA_fnc_removePerFrameHandler;
		};

		private _uptime = (random 2) +2;
		{
				private _targets = _station getVariable [_x, []];
				private _target = selectRandom _targets;
				_targets deleteAt (_targets find _target);
				_station setVariable [_x, _targets];

			[[[_uptime, _station, _target], {
				params ["_uptime", "_station", "_target"];
				private _id = [_target, "hit", {
					_thisArgs params ["_target", "_station"];

					_target removeEventHandler ["hit", _thisID];

					if (typeOf _target in ["TargetP_Civ_F", "TargetP_Civ2_F"]) then {
						private _targetsHit = _station getVariable ["hostagesHit", []];
						_targetsHit pushBackUnique _target;
						_station setVariable ["hostagesHit", _targetsHit, true];	
					} else {
						private _targetsHit = _station getVariable ["targetsHit", []];
						_targetsHit pushBackUnique _target;
						_station setVariable ["targetsHit", _targetsHit, true];	 
					};

				}, [_target, _station]] call CBA_fnc_addBISEventHandler;

				[{
					params ["_target", "_id"];

					_target removeEventHandler ["hit", _id];
					_target animate ["terc", 1];
				},[_target, _id], _uptime] call CBA_fnc_waitAndExecute;
			}]] remoteExecCall ["BIS_fnc_call"];
			_target animate ["terc", 0];
		}forEach ["targetsNorth", "targetsEast", "targetsSouth", "targetsWest"];

	}, 4, [_station, _playerGroup]] call CBA_fnc_addPerFrameHandler;
}, [_station, _playerGroup], 22] call CBA_fnc_waitAndExecute;

[
	{
		params ["_station", "_playerGroup", "_allTargets"];

		(count(_station getVariable ["targetsNorth", []]) + count(_station getVariable ["targetsEast", []]) + count(_station getVariable ["targetsSouth", []]) + count(_station getVariable ["targetsWest", []])) <= 0
	},
	{
		[{
			params ["_station", "_playerGroup", "_allTargets"];

			[_station, _playerGroup, _allTargets] call grad_grandPrix_fnc_erstSchiessenDannFragen_endStation;
		}, _this, 7] call CBA_fnc_waitAndExecute;
	},
	[_station, _playerGroup, _allTargets]
] call CBA_fnc_waitUntilAndExecute;