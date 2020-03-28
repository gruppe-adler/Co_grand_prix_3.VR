params ["_station", "_playerGroup", "_allTargets"];

{
	// Current result is saved in variable _x
	["drillStop"] remoteExec ["playSound", _x];
} forEach (units _playerGroup);

[{
	_this params ["_station", "_playerGroup", "_allTargets"];
	{
		// Current result is saved in variable _x
		_x setPosASL ((getPosASL ReaktionsschiessenStationPort) vectorAdd [(random 4) - 2, (random 4) - 2, 0]);
	} forEach (units _playerGroup);
	
	private _penalty = ((count _allTargets - count(_station getVariable ["targetsHit", []])) * 5) + (count(_station getVariable ["hostagesHit", []]) * 15);
	[_playerGroup, "erst schiessen, dann fragen", _penalty] call grad_grandPrix_fnc_addTime;
	{
		// Current result is saved in variable _x
		[formatText["Ihr habt %1 von %2 Zielen, sowie %3 Zivilisten getroffen!%4Das ergibt %5 Strafsekunden!", count(_station getVariable ["targetsHit", []]), count _allTargets, count(_station getVariable ["hostagesHit", []]), lineBreak, _penalty]] remoteExec ["hint", _x];
	} forEach (units _playerGroup);

	{
		// Current result is saved in variable _x
		_x animate ["terc", 0];
		_x allowDamage false;
	} forEach _allTargets;
	
	_station setVariable ["stationIsRunning", false, true];
}, [_station, _playerGroup, _allTargets], 2] call CBA_fnc_waitAndExecute;