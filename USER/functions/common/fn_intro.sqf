params ["_effect", "_music"];

[_effect, 0, false] call BIS_fnc_setPPeffectTemplate;
playMusic [_music, 0];
0 fadeMusic 1;

STHud_UIMode = 0;
diwako_dui_main_toggled_off = true;

cutText ["", "BLACK OUT", 0];
cutText ["","BLACK FADED", 999];

ace_player switchMove "amovpercmstpslowwrfldnon";
[{
    private _filmgrain = ppEffectCreate ["FilmGrain", 2000];
    _filmgrain ppEffectEnable true;
    _filmgrain ppEffectAdjust [0.3, 0.3, 0.12, 0.12, 0.12, true];
    _filmgrain ppEffectCommit 0;

    private _camera = "camera" camCreate (getPosASL camPos_01);
    _camera camSetPos (getPos camPos_01);
    _camera camCommand "inertia on";
    _camera camSetTarget camTarget_01;
    _camera cameraEffect ["internal", "back"];
    _camera camSetFov 1;
    _camera camCommit 0;
    _camera camSetPos (getPos camPos_01);
    _camera camSetTarget camTarget_01;

    showCinemaBorder true;

    cutText ["", "BLACK IN", 1];
    [{
        params ["_camera"];
        _camera camSetFov 0.05;
        _camera camCommit 30;

        [{
            params ["_camera"];
            cutText ["", "BLACK OUT", 0.2];

            0.1 fadeMusic 0;

            [{
                params ["_camera", "_filmgrain"];


                GRAD_USER_introOver = true;
                publicVariable "GRAD_USER_introOver";

                _filmgrain ppEffectEnable false;
                ppEffectDestroy _filmgrain;
                _camera cameraEffect ["terminate", "back"];
                camDestroy _camera;

                ["Default", 0, false] call BIS_fnc_setPPeffectTemplate;

                [{
                    cutText ["", "BLACK IN", 1];
                    [ace_player, "amovpercmstpslowwrfldnon", 1] call ace_common_fnc_doAnimation;

                    [{

                        2 fadeMusic 0;
                        STHud_UIMode = 1;
                        diwako_dui_main_toggled_off = false;
                        ["grad_grandPrix_intro_mainHall_open", []] call CBA_fnc_serverEvent;

                        [{
                            playMusic "";
                            0 fadeMusic 1;
                        }, [], 4] call CBA_fnc_waitAndExecute;
                    }, [], 2] call CBA_fnc_waitAndExecute;
                }, [], 2] call CBA_fnc_waitAndExecute;
            }, _this, 0.3] call CBA_fnc_waitAndExecute;
        }, _this, 21.5] call CBA_fnc_waitAndExecute;
    }, [_camera, _filmgrain], 0.1] call CBA_fnc_waitAndExecute;
}, [], 3] call CBA_fnc_waitAndExecute;
