params ["_allExplosives", "_station", "_playerGroup", "_time", "_id", "_explosivesClass", "_eventHandlerID"];

grad_grandPrix_tauchen_defusedExplosives = [];

// {
// 	// Current result is saved in variable _x
// 	[{!(mineActive (_this select 0))}, 
// 		{grad_grandPrix_tauchen_defusedExplosives pushBackUnique (_this select 0);}, 
// 	[_x], _time - serverTime] call CBA_fnc_waitUntilAndExecute;
// } forEach _allExplosives;

[{
	params ["_allExplosives", "_station", "", "_time", "", "", ""];

	(((_station getVariable ["defusedExplosives", 0]) isEqualTo 5) || {serverTime >= _time})
},{
	params ["_allExplosives", "_station", "_playerGroup", "_time", "_id", "_explosivesClass", "_eventHandlerID"];

	private _stationDuration = [_id] call grad_grandPrix_fnc_stopTimer;
	private _defusedExplosives = _station getVariable ["defusedExplosives", 0];
	private _amountMinesLeft = 5 - _defusedExplosives;

	if !(_defusedExplosives isEqualTo 5) then {
		[_playerGroup, "Tauchen mit Wums", (_amountMinesLeft * 30) + _stationDuration] call grad_grandPrix_fnc_addTime;
	} else {
		[_playerGroup, "Tauchen mit Wums", _stationDuration] call grad_grandPrix_fnc_addTime;
	};
	
	[{
		_this params ["_allExplosives", "_station", "_playerGroup", "_time", "_id", "_explosivesClass", "_eventHandlerID", "_amountMinesLeft", "_stationDuration", "_defusedExplosives"];

		{
			// Current result is saved in variable _x
			_x hideObjectGlobal false;
		} forEach [tauchenMitWumsWall1, tauchenMitWumsWall2, tauchenMitWumsWall3];

		{
			// Current result is saved in variable _x
			[_x, false] remoteExec ["allowDamage", _x];
			private _position = getPosATL tauchenMitWumsTeleportPosition;
			_x setPosATL _position;
			[_x] call GRAD_Loadout_fnc_doLoadoutForUnit;
			[_x, "AmovPercMstpSnonWnonDnon_AwopPercMstpSoptWbinDnon_end"] remoteExec ["switchMove", _x];
		} forEach (units _playerGroup);

		["ace_explosives_defuse", _eventHandlerID] call CBA_fnc_removeEventHandler;

		private _unitsToMessage = (units _playerGroup) + [TauchenMitWums_Instructor];
		if (_amountMinesLeft > 0) then {
			[formatText["Ihr habt nur %1 von %2 Sprengladungen entschärft!%3Daher kommen insgesamt %4 Minuten auf euer Zeitkonto!", _defusedExplosives, 5, lineBreak, [(_amountMinesLeft * 30) + _stationDuration, "MM:SS"] call BIS_fnc_secondsToString]] remoteExec ["hint", _unitsToMessage];
		} else {
			[formatText["Ihr habt die Station erfolgreich abgeschlossen!%1Es kommen %2 Minuten auf euer Zeitkonto.", lineBreak, [_stationDuration, "MM:SS"] call BIS_fnc_secondsToString]] remoteExec ["hint", _unitsToMessage];
		};

		{
			// Current result is saved in variable _x
			deleteVehicle _x;
		} forEach _allExplosives;

		[TauchenMitWums_Sir_Niclas] call grad_grandPrix_fnc_tauchenMitWums_fillCrate;
		_station setVariable ["stationIsRunning", false, true];
	}, [_allExplosives, _station, _playerGroup, _time, _id, _explosivesClass, _eventHandlerID, _amountMinesLeft, _stationDuration, _defusedExplosives], 3] call CBA_fnc_waitAndExecute;
}, [_allExplosives, _station, _playerGroup, _time, _id, _explosivesClass, _eventHandlerID]] call CBA_fnc_waitUntilAndExecute;