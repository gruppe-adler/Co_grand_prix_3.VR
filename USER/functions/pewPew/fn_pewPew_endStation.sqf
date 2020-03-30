params ["_station", "_playerGroup", "_allTargets", "_timer", "_allPlayerHandlerIDs"];

[{
	params ["_station", "_playerGroup", "_allTargets", "_timer"];
	(count _allTargets) isEqualTo (count(_station getVariable "targetsHit"))
},
{
	params ["_station", "_playerGroup", "_allTargets", "_timer"];
	private _time = [_timer] call grad_grandPrix_fnc_stopTimer;
	private _timeScore = _time + ((_station getVariable ["shotsFired", 4]) * 3);
	[_playerGroup, "PewPew", _timeScore] call grad_grandPrix_fnc_addTime;
	{
		// Current result is saved in variable _x
		["FiredMan", _x] call CBA_fnc_removeEventHandler;
	} forEach _allPlayerHandlerIDs;

	PewPew_Sir_Niclas hideObjectGlobal true;
	_station setVariable ["stationIsRunning", false, true];

	[{
		params ["_station", "_playerGroup", "_allTargets", "_time", "_timeScore"];

		[formatText["Ihr habt die Station in %1 Minuten abgeschlossen.%2Dabei habt ihr %3 Schüsse gebraucht.%4Insgesamt kommen also %5 Minuten auf euer Zeitkonto!", [_time, "MM:SS"] call BIS_fnc_secondsToString, lineBreak, _station getVariable ["shotsFired", 4], lineBreak, [_timeScore, "MM:SS"] call BIS_fnc_secondsToString]] remoteExec ["hint", allPlayers inAreaArray [getPos _station, 50, 50]];
	}, [_station, _playerGroup, _allTargets, _time, _timeScore], 5] call CBA_fnc_waitAndExecute;
}, [_station, _playerGroup, _allTargets, _timer, _allPlayerHandlerIDs]] call CBA_fnc_waitUntilAndExecute;