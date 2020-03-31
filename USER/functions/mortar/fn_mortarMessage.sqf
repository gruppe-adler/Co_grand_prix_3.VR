params ["_message", ["_bool", true]];

if (_bool) then {
	systemChat _message;
} else {
	hintSilent _message;
};
