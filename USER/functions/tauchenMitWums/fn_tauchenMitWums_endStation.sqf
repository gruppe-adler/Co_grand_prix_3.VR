params ["_allExplosives", "_station", "_playerGroup", "_time", "_id", "_explosivesClass", "_eventHandlerID"];

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
	private _amountMinesLeft = (count _allExplosives) - (count grad_grandPrix_tauchen_defusedExplosives);

	if !((count grad_grandPrix_tauchen_defusedExplosives) isEqualTo (count _allExplosives)) then {
		[_playerGroup, "Tauchen mit Wums", (_amountMinesLeft * 30) + _stationDuration] call grad_grandPrix_fnc_addTime;
	} else {
		[_playerGroup, "Tauchen mit Wums", _stationDuration] call grad_grandPrix_fnc_addTime;
	};
	
	[{
		_this params ["_allExplosives", "_station", "_playerGroup", "_time", "_id", "_explosivesClass", "_eventHandlerID", "_amountMinesLeft", "_stationDuration"];

		{
			// Current result is saved in variable _x
			_x hideObjectGlobal false;
		} forEach [tauchenMitWumsWall1, tauchenMitWumsWall2, tauchenMitWumsWall3];

		{
			// Current result is saved in variable _x
			private _position = (getPosASL tauchenMitWumsTeleportPosition) vectorAdd [0, 0, 1];
			_x setPosASL _position;
		} forEach (units _playerGroup);

		["ace_explosives_defuse", _eventHandlerID] call CBA_fnc_removeEventHandler;

		if (_amountMinesLeft > 0) then {
			[formatText["Ihr habt nur %1 von %2 Sprengladungen entschärft!%3Daher kommen insgesamt %4 Minuten auf euer Zeitkonto!", count grad_grandPrix_tauchen_defusedExplosives, count _allExplosives, lineBreak, [(_amountMinesLeft * 30) + _stationDuration, "MM:SS"] call BIS_fnc_secondsToString]] remoteExec ["hint", units _playerGroup];
		} else {
			[formatText["Ihr habt die Station erfolgreich abgeschlossen!%1Es kommen %2 Minuten auf euer Zeitkonto.", lineBreak, [_stationDuration, "MM:SS"] call BIS_fnc_secondsToString]] remoteExec ["hint", units _playerGroup];
		};

		{
			// Current result is saved in variable _x
			deleteVehicle _x;
		} forEach _allExplosives;

		_station setVariable ["stationIsRunning", false, true];
	}, [_allExplosives, _station, _playerGroup, _time, _id, _explosivesClass, _eventHandlerID, _amountMinesLeft, _stationDuration], 3] call CBA_fnc_waitAndExecute;
}, [_allExplosives, _station, _playerGroup, _time, _id, _explosivesClass, _eventHandlerID]] call CBA_fnc_waitUntilAndExecute;