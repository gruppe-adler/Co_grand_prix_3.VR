
params ["_explosivesClass"];

private _allSpawnPositions = [spawnPositionCharge1, spawnPositionCharge2, spawnPositionCharge3, spawnPositionCharge4, spawnPositionCharge5];
private _allExplosives = [];

{
	
	private _explosive = createMine [_explosivesClass, getPos _x, [], 0];
	_allExplosives pushBackUnique _explosive;
	_explosive attachTo [_x, [0,0,0]];
	
} forEach _allSpawnPositions;

// {
	
// 	[_x, 300] call ace_explosives_fnc_startTimer;
	
// } forEach _allExplosives;

[_allExplosives] call grad_grandPrix_fnc_endConditions;