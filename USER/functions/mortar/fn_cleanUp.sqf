[{
	params ["","_objects", "_handle", "_mortar", "_unit"];

    {
        if (_x isEqualType objNull && {!isNull _x}) then {
            deleteVehicle _x;
			[["TaskCanceled", ["","Mortar Game ended."]]] remoteExecCall ["BIS_fnc_showNotification", group _unit];
        };
    } forEach _objects;
    _mortar removeEventHandler ["Fired", _handle];
}, _this, (_this select 0)] call CBA_fnc_waitAndExecute;