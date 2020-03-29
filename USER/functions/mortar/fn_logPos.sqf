params ["_projectile"];

[
    {
        params ["_args", "_handle"];
        _args params ["_projectile"];
        if (isNull _projectile) exitWith {
            [_handle] call CBA_fnc_removePerFrameHandler;
            _pos = ((MORTARSHOT_LASTPOS select 0)select 1);
            MORTARSHOT_LASTPOS deleteAt 0;
            [_pos ] call grad_grandPrix_fnc_calcShot;
        };
        _point = -1;
        {
            if ((_x select 0) == _projectile) exitWith {_point = _forEachIndex};
        }forEach MORTARSHOT_LASTPOS;

        if (_point != -1) then {
            MORTARSHOT_LASTPOS set [_point,[_projectile,(getPos _projectile)]];
        }else{
            MORTARSHOT_LASTPOS pushBack [_projectile,(getPos _projectile)];
        };
    },
    0,
    [_projectile]
] call CBA_fnc_addPerFrameHandler;