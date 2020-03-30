[
    {
        params ["_args", "_handle"];
        _args params ["_projectile", "_group"];;

        if (isNull _projectile) exitWith {
            [_handle] call CBA_fnc_removePerFrameHandler;
            _pos = ((GRAD_GRANDPRIX_LASTPOS select 0)select 1);
            GRAD_GRANDPRIX_LASTPOS deleteAt 0;
            [_pos, _group ] call grad_grandPrix_fnc_calcShot;
        };

        private _point = -1;
        {
            if ((_x select 0) == _projectile) exitWith {_point = _forEachIndex};
        }forEach GRAD_GRANDPRIX_LASTPOS;

        if (_point != -1) then {
            GRAD_GRANDPRIX_LASTPOS set [_point,[_projectile,(getPos _projectile)]];
        }else{
            GRAD_GRANDPRIX_LASTPOS pushBack [_projectile,(getPos _projectile)];
        };
    },
    0,
    _this
] call CBA_fnc_addPerFrameHandler;