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
	_stationTimes pushBack _x;
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

private _structured = ["<t align='center' color='#D18D1F' size='2'>End Results:</t>"]; 
_structured pushBack "<t align='right' font='EtelkaMonospacePro'>-------------------------</t>"; 

{
	_x params ["_overAllTime", "", "_group"];

	_structured pushBack format ["<t align='left' font='EtelkaMonospacePro'>%1</t><t align='right' font='EtelkaMonospacePro'>%2</t>", name _group, _overAllTime];  
}forEach _newArray;

[parseText (_structured joinString "<br />"), false] remoteExecCall ["grad_grandPrix_fnc_mortarMessage", -2];