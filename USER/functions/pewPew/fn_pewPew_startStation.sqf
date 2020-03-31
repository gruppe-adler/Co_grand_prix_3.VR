params ["_station", "_playerGroup"];

if !(isServer) exitWith {
	_this remoteExecCall ["grad_grandPrix_fnc_pewPew_startStation", 2];
};

_station setVariable ["stationIsRunning", true, true];
_station setVariable ["shotsFired", 0, true];
_station setVariable ["targetsHit", []];

private _allTargets = [PewPewTarget1, PewPewTarget2, PewPewTarget3, PewPewTarget4];
private _allPlayerHandlerIDs = [];
[PewPew_Sir_Niclas] call grad_grandPrix_fnc_clearCrate;
[PewPew_Sir_Niclas] call grad_grandPrix_fnc_pewPew_fillCrate;
//private _playersToNotify = allPlayers inAreaArray [_station, 50, 50];



{
	_x setVariable ["station", _station];
	_x setVariable ["playerGroup", _playerGroup];
	private _id = _x addMPEventHandler ["MPHit", {
		params ["_unit", "_causedBy", "_damage", "_instigator"];

		if (!isServer) exitWith {};
		private _playerGroup = _unit getVariable "playerGroup";
		private _station = _unit getVariable "station";
		private _allTargets = [PewPewTarget1, PewPewTarget2, PewPewTarget3, PewPewTarget4];
		
		if (_instigator in (units _playerGroup)) then {
			deleteVehicle _causedBy;
			private _targetsHit = _station getVariable ["targetsHit", []];
			_targetsHit pushBackUnique _unit;
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
			_unit removeMPEventHandler ["MPHit", _unit getVariable ["pewPewID", 0]];
		};
	}];
	_x setVariable ["pewPewID", _id];
} forEach _allTargets;

{
	// Current result is saved in variable _x
	_x setVariable ["station", _station];
	private _id = _x addEventHandler ["FiredMan", {
		params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];

		private _station = _unit getVariable "station";
		private _shotsFired = _station getVariable ["shotsFired", 0];
		_shotsFired = _shotsFired + 1;
		hint "test";
		_station setVariable ["shotsFired", _shotsFired, true];
	}];

} forEach (units _playerGroup);

[formatText["Die Zeit läuft.%1Ab jetzt wird jeder Schuss gezählt!", lineBreak]] remoteExec ["hint", allPlayers inAreaArray [getPos _station, 50, 50]];

private _time = [] call grad_grandPrix_fnc_startTimer;

[_station, _playerGroup, _allTargets, _time, _allPlayerHandlerIDs] call grad_grandPrix_fnc_pewPew_endStation;