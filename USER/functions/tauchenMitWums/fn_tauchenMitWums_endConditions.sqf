
params ["_allExplosives"];

private _defusedExplosives = [];
private _timeout = time + 300;

{
	// Current result is saved in variable _x
	[{!(mineActive (_this#0))}, {(_this#1) pushBackUnique (_this#0);}, [_x, _defuseExplosives], 300] call CBA_fnc_waitUntilAndExecute;
} forEach _allExplosives;

waitUntil {((count _allExplosives) isEqualTo (count _defusedExplosives)) || (time >= _timeout)};

if !((count _defusedExplosives) isEqualTo (count _allExplosives)) then {
	
};