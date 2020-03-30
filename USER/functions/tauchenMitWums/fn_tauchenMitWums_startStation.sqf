params ["_explosivesClass", "_station", "_playerGroup"];

if !(isServer) exitWith {
	_this remoteExecCall ["grad_grandPrix_fnc_tauchenMitWums_startStation", 2];
};

_station setVariable ["stationIsRunning", true, true];
_station setVariable ["defusedExplosives", 0, true];

private _allSpawnPositions = [spawnPositionCharge1, spawnPositionCharge2, spawnPositionCharge3, spawnPositionCharge4, spawnPositionCharge5];
private _allExplosives = [];

{
	
	private _explosive = createMine [_explosivesClass, getPos _x, [], 0];
	_allExplosives pushBackUnique _explosive;
	_explosive attachTo [_x, [0,0,0]];
	
} forEach _allSpawnPositions;

[{
	[{
		params ["", "_station"];

		playSound3D["a3\missions_f_beta\data\sounds\firing_drills\timer.wss", _station, false, getPosASL _station, 5, 1, 25];
		[{
			params ["", "_station"];

			playSound3D["a3\missions_f_beta\data\sounds\firing_drills\timer.wss", _station, false, getPosASL _station, 5, 1, 25];
			[{
				params ["", "_station"];

				playSound3D["a3\missions_f_beta\data\sounds\firing_drills\timer.wss", _station, false, getPosASL _station, 5, 1, 25];
				[{
					params ["", "_station"];

					playSound3D ["a3\missions_f_beta\data\sounds\firing_drills\course_active.wss", _station, false, getPosASL _station, 5, 1, 25];

					{
						// Current result is saved in variable _x
						_x hideObjectGlobal true;
					} forEach [tauchenMitWumsWall1, tauchenMitWumsWall2, tauchenMitWumsWall3];

					[{
						params ["", "", "_playerGroup"];

						private _unitsPlayerGroup = units _playerGroup;
						count(_unitsPlayerGroup select {eyePos _x select 2 < 0}) > 0
					},{
						params ["_explosivesClass", "_station", "_playerGroup", "_allExplosives"];

						private _time = [300] call BIS_fnc_countdown;
						private _id = [] call grad_grandPrix_fnc_startTimer;

						{
							// Current result is saved in variable _x
							[[_time, _station],
								{
									params ["_time", "_station"];
									while {(time < _time) && (_station getVariable ["stationIsRunning", false])} do {
										hintSilent ([_time - time, "MM:SS"] call BIS_fnc_secondsToString);
										sleep 1;
									};
								}
							] remoteExec ["spawn", _x];
						} forEach (units _playerGroup);

						private _eventHandlerID = ["ace_explosives_defuse", {
							params ["_explosive", "_unit"];
							_thisArgs params ["_playerGroup", "_station"];
							_unit = getPos _unit;
							{
								// Current result is saved in variable _x
								_station setVariable ["defusedExplosives",((_station getVariable "defusedExplosives") + 1), true];
								[format["%1 von 5 Sprengladungen entschärft", _station getVariable "defusedExplosives"]] remoteExec ["hint", _x];
							} forEach (units _playerGroup);
							[{
								deleteVehicle (nearestObject[_this, "GroundWeaponHolder"]);
							}, _unit, 2] call CBA_fnc_waitAndExecute;
						}, [_playerGroup, _station]] call CBA_fnc_addEventHandlerArgs;

						[_allExplosives, _station, _playerGroup, _time, _id, _explosivesClass, _eventHandlerID] call grad_grandPrix_fnc_tauchenMitWums_endStation;
					}, _this] call CBA_fnc_waitUntilAndExecute;
				}, _this, 1] call CBA_fnc_waitAndExecute;
			}, _this, 1] call CBA_fnc_waitAndExecute;
		}, _this, 1] call CBA_fnc_waitAndExecute;
	}, _this, 1] call CBA_fnc_waitAndExecute;
},[_explosivesClass, _station, _playerGroup, _allExplosives], 2] call CBA_fnc_waitAndExecute;
