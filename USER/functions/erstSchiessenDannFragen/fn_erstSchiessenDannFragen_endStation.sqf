params ["_station", "_playerGroup", "_allTargets"];

["drillStop"] remoteExec ["playSound", (units _playerGroup)];

[{
	_this params ["_station", "_playerGroup", "_allTargets"];
	{
		// Current result is saved in variable _x
		_x setPosASL ((getPosASL ReaktionsschiessenStationPort) vectorAdd [(random 4) - 2, (random 4) - 2, 0]);
	} forEach (units _playerGroup);
	
	private _targetsHit = count(_station getVariable ["targetsHit", []]);
	private _hostagesHit = count(_station getVariable ["hostagesHit", []]);
	private _penalty = ((count _allTargets - _targetsHit * 5) + (_hostagesHit * 15));

	[_playerGroup, "erst schiessen, dann fragen", _penalty] call grad_grandPrix_fnc_addTime;

	[formatText["Ihr habt %1 von %2 Zielen, sowie %3 Zivilisten getroffen!%4Damit kommen %5 Minuten auf euer Zeitkonto!", _targetsHit, count _allTargets, _hostagesHit, lineBreak, [_penalty, "MM:SS"] call BIS_fnc_secondsToString]] remoteExec ["hint", units _playerGroup];

	{
		// Current result is saved in variable _x
		_x animate ["terc", 0];
		_x allowDamage false;
	} forEach _allTargets;
	
	_station setVariable ["stationIsRunning", false, true];
}, [_station, _playerGroup, _allTargets], 2] call CBA_fnc_waitAndExecute;