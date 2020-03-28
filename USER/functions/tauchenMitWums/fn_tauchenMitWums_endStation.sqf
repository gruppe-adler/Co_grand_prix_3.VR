params ["_allExplosives", "_station", "_playerGroup", "_time", "_id", "_explosivesClass", "_eventHandlerID"];

diag_log format ["All Explosives: %1, Station: %2, PlayerGroup: %3, Time: %4, ID: %5, ExplosivesClass: %6", _allExplosives, _station, _playerGroup, _time, _id, _explosivesClass, _eventHandlerID];

grad_grandPrix_tauchen_defusedExplosives = [];

{
	// Current result is saved in variable _x
	[{!(mineActive (_this select 0))}, 
		{grad_grandPrix_tauchen_defusedExplosives pushBackUnique (_this select 0);}, 
	[_x], _time - time] call CBA_fnc_waitUntilAndExecute;
} forEach _allExplosives;

[{
	params ["_allExplosives", "", "", "_time", "", "", ""];

	(((count _allExplosives) isEqualTo (count grad_grandPrix_tauchen_defusedExplosives)) || {time >= _time})
},{
	params ["_allExplosives", "_station", "_playerGroup", "_time", "_id", "_explosivesClass", "_eventHandlerID"];

	private _stationDuration = [_id] call grad_grandPrix_fnc_stopTimer;

	[{
		params ["_allExplosives", "_station", "_playerGroup", "_time", "_id", "_explosivesClass", "_eventHandlerID"];

		if !((count grad_grandPrix_tauchen_defusedExplosives) isEqualTo (count _allExplosives)) then {
			private _amountMinesLeft = (count _allExplosives) - (count grad_grandPrix_tauchen_defusedExplosives);
			[_playerGroup, "Tauchen mit Wums", (_amountMinesLeft * 30) + _stationDuration] call grad_grandPrix_fnc_addTime;
		} else {
			[_playerGroup, "Tauchen mit Wums", _stationDuration] call grad_grandPrix_fnc_addTime;
		};

		{
			// Current result is saved in variable _x
			_x hideObjectGlobal false;
		} forEach [tauchenMitWumsWall1, tauchenMitWumsWall2, tauchenMitWumsWall3];

		{
			// Current result is saved in variable _x
			private _position = getPosASL tauchenMitWumsTeleportPosition;
			_x setPosASL _position;
		} forEach (units _playerGroup);

		{
			// Current result is saved in variable _x
			deleteVehicle _x;
		} forEach _allExplosives;

		["ace_explosives_defuse", _eventHandlerID] call CBA_fnc_removeEventHandler;

		_station setVariable ["stationIsRunning", false, true];
	}, _this, 3] call CBA_fnc_waitAndExecute;
}, [_allExplosives, _station, _playerGroup, _time, _id, _explosivesClass, _eventHandlerID]] call CBA_fnc_waitAndExecute;