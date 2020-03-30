params ["_pos"];

_pos params ["_posX", "_posY"];
_msgPos = format ["%1%2",(round (_posX/10)),(round (_posY/10))];
_warning = "";
if ((_pos distance2D player) < 200) then {_warning = ", Danger Close!"};

[format ["Feuerauftrag, Ziel: %1%3", _msgPos, _warning]] remoteExecCall ["grad_grandPrix_fnc_mortarMessage", group player];