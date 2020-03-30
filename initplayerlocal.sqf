if (didJIP) then {
    [player] remoteExec ["grad_common_fnc_addJipToZeus",2,false];
};

["InitializePlayer", [player,true]] call BIS_fnc_dynamicGroups;
grad_template_ratingEH = player addEventHandler ["HandleRating",{0}];

["CBA_loadingScreenDone", {
    [{time > ((_this select 0) + 10)},{
        params ["", "_didJip"];
        if (!(_didJip) || {_didJip && !(isNil "GRAD_USER_introOver")}) then {    
            //if (isNull (getAssignedCuratorLogic ace_player)) then {
                ["Mediterranean", "Queen"] call GRAD_grandPrix_fnc_intro;
            //};
        };
    }, [time, didJIP]] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_addEventHandler;