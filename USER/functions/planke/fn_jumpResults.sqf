params ["_unit"];

private _distance = _unit distance2D jumpPoint;
systemChat str(_distance);