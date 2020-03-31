params ["_station", "_bool"];

if (_bool) then {

private _id = [player, "FiredMan", {
	_this params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];
	_thisArgs params ["_station"];

	private _shotsFired = _station getVariable ["shotsFired", 0];
	_shotsFired = _shotsFired + 1;
	hint "test";
	_station setVariable ["shotsFired", _shotsFired, true];
}, _this] call CBA_fnc_addBISEventHandler;

player setVariable ["grad_grandPrix_pewPew_firedEH", _id];

} else {
	private _ehID = player getVariable ["grad_grandPrix_pewPew_firedEH", -1];
	player removeEventHandler ["FiredMan", _ehID];
};