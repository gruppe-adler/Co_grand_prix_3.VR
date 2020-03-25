
params ["_allExplosives", "_station", "_playerGroup", "_time", "_id", "_explosivesClass", "_eventHandlerID"];

private _defusedExplosives = [];

{
	// Current result is saved in variable _x
	[{!(mineActive (_this#0))}, {(_this#1) pushBackUnique (_this#0);}, [_x, _defusedExplosives], _time - time] call CBA_fnc_waitUntilAndExecute;
} forEach _allExplosives;

waitUntil {((count _allExplosives) isEqualTo (count _defusedExplosives)) || (time >= _time)};

private _stationDuration = [_id] call grad_grandPrix_fnc_stopTimer;

sleep 3;

if !((count _defusedExplosives) isEqualTo (count _allExplosives)) then {
	private _amountMinesLeft = (count _allExplosives) - (count _defusedExplosives);
	[_playerGroup, "Tauchen mit Wums", (_amountMinesLeft * 30) + _stationDuration] call grad_grandPrix_fnc_addTime;
} else {
	[_playerGroup, "Tauchen mit Wums", _stationDuration] call grad_grandPrix_fnc_addTime;
};

{
	// Current result is saved in variable _x
	_x hideObjectGlobal false;
} forEach [_station, tauchenMitWumsWall1, tauchenMitWumsWall2, tauchenMitWumsWall3];

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

_station setVariable ["stationIsRunning", false];