params ["_pos", "_group"];

if (isNull GRAD_GRADNPRIX_MORTARVEHICLE) exitWith {};

private _distance = GRAD_GRADNPRIX_MORTARVEHICLE distance2D _pos;
private _dir = GRAD_GRADNPRIX_MORTARVEHICLE getRelDir _pos;

GRAD_GRANDPRIX_LASTSHOTRESULT = [_group, _distance, _dir];