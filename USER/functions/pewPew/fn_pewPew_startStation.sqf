params ["_station", "_playerGroup"];

if !(isServer) exitWith {
	_this remoteExecCall ["grad_grandPrix_fnc_pewPew_startStation", 2];
};

_station setVariable ["stationIsRunning", true, true];
_station setVariable ["shotsFired", 0];
_station setVariable ["targetsHit", []];

private _allTargets = [PewPewTarget1, PewPewTarget2, PewPewTarget3, PewPewTarget4];
private _allPlayerHandlerIDs = [];
PewPew_Sir_Niclas hideObjectGlobal false;
//private _playersToNotify = allPlayers inAreaArray [_station, 50, 50];



{
	_x setVariable ["station", _station];
	_x setVariable ["playerGroup", _playerGroup];
	private _id = _x addEventHandler ["HitPart", {
		(_this select 0) params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];
		private _playerGroup = _target getVariable "playerGroup";
		private _station = _target getVariable "station";
		private _allTargets = [PewPewTarget1, PewPewTarget2, PewPewTarget3, PewPewTarget4];
		
		if ((_shooter in (units _playerGroup)) && _isDirect) then {
			deleteVehicle _projectile;
			private _targetsHit = _station getVariable ["targetsHit", []];
			_targetsHit pushBackUnique _target;
			_station setVariable ["targetsHit", _targetsHit];
			private _units = allPlayers inAreaArray [getPos _station, 50, 50];

			if ((count(_station getVariable "targetsHit")) isEqualTo (count _allTargets)) then {
				[formatText["Schuss %1 war ein Treffer!%2Ihr habt alle Ziele getroffen!", _station getVariable "shotsFired", lineBreak]] remoteExec ["hint", _units];
			} else {
				if ((count(_station getVariable "targetsHit") isEqualTo (count _allTargets - 1))) then {
					[formatText["Schuss %1 war ein Treffer!%2Es ist nur noch ein Ziel übrig!", _station getVariable "shotsFired", lineBreak]] remoteExec ["hint", _units];
				} else {
					[formatText["Schuss %1 war ein Treffer!%2%3 Ziele to go!", _station getVariable "shotsFired", lineBreak, count _allTargets - count(_station getVariable "targetsHit")]] remoteExec ["hint", _units];
				};
			};
			_target removeEventHandler ["HitPart", _target getVariable ["pewPewID", 0]];
		};
	}];
	_x setVariable ["pewPewID", _id];
} forEach _allTargets;

{
	// Current result is saved in variable _x
	private _id = [_x, "FiredMan", {
		_this params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];
		_thisArgs params ["_station"];

		private _shotsFired = _station getVariable ["shotsFired", 0];
		_shotsFired = _shotsFired + 1;
		_station setVariable ["shotsFired", _shotsFired];
	}, [_station]] call CBA_fnc_addBISEventHandler;
	_allPlayerHandlerIDs pushBackUnique _id;
} forEach (units _playerGroup);

[formatText["Die Zeit läuft.%1Ab jetzt wird jeder Schuss gezählt!", lineBreak]] remoteExec ["hint", allPlayers inAreaArray [getPos _station, 50, 50]];

private _time = [] call grad_grandPrix_fnc_startTimer;

[_station, _playerGroup, _allTargets, _time, _allPlayerHandlerIDs] call grad_grandPrix_fnc_pewPew_endStation;