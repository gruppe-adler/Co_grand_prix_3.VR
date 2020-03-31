
if !(isServer) exitWith {
	_this remoteExecCall ["grad_grandPrix_fnc_pewPew_hitPart", 2];
};

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