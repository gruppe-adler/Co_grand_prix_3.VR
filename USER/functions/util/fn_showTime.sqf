if !(isServer) exitWith {
	[] remoteExecCall ["grad_grandPrix_fnc_addTime", 2];
};

private _groups = [];

{
	if (isPlayer _x && {isNull (getAssignedCuratorLogic _x)}) then {
		_groups pushBackUnique (group _x);
	};
}forEach (playableUnits + switchableUnits);

private _groupsArray = [];

{
	private _stationTimes = missionNamespace getVariable [format ["grad_grandPrix_times_%1", _x], []];
	_groupsArray pushBackUnique _stationTimes;
}forEach _groups;

private _newArray = [];

while {(count _groupsArray) > 0} do {
	private _array = _groupsArray select 0;
	private _arrayTime = _array select 0;
	private _index = 0;

	{
		private _time = _x select 0;

		if (_time > _arrayTime) then {
			_arrayTime = _time;
			_array = _x;
			_index = _forEachIndex;
		};
	}forEach _groupsArray;

	_newArray pushBackUnique _array;
	_groupsArray deleteAt _index;
};