params ["_effect", "_music"];
*
[_effect, 0, false] call BIS_fnc_setPPeffectTemplate;
0 fadeMusic 0;
playMusic [_music, 20];
[{3 fadeMusic 1;},[]] call CBA_fnc_execNextFrame;

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
        _camera camSetPos (getPos camPos_02);
        _camera camCommit 10;

        [{
            params ["_camera"];

            _camera camSetTarget camTarget_02;
            _camera camCommit 1;

            [{
                params ["_camera"];

                _camera camCommand "inertia off";
                _camera camSetPos (getPos camPos_03);
                _camera camCommit 10;

                [{
                    params ["_camera"];

                    _camera camSetPos (getPos camPos_04);
                    _camera camCommit 10;

                    [{
                        params ["_camera"];

                        _camera camCommand "inertia on";
                        _camera camSetTarget camTarget_03;
                        _camera camCommit 1;
                        [{
                            params ["_camera"];
                            cutText ["", "BLACK OUT", 1];

                            0 fadeMusic 0;

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
                                    cutText ["", "BLACK IN", 2];
                                    [ace_player, "amovpercmstpslowwrfldnon", 1] call ace_common_fnc_doAnimation;

                                    [{

                                        10 fadeMusic 0;
                                            STHud_UIMode = 1;
                                            diwako_dui_main_toggled_off = false;

                                            [{
                                                playMusic "";
                                                0 fadeMusic 1;
                                            }, [], 11] call CBA_fnc_waitAndExecute;
                                        }, [], 4] call CBA_fnc_waitAndExecute;
                                }, [], 2] call CBA_fnc_waitAndExecute;
                            }, _this, 1] call CBA_fnc_waitAndExecute;
                        }, _this, 9] call CBA_fnc_waitAndExecute;
                    }, _this, 5] call CBA_fnc_waitAndExecute;
                }, _this, 9] call CBA_fnc_waitAndExecute;
            }, _this, 6] call CBA_fnc_waitAndExecute;
        }, _this, 3] call CBA_fnc_waitAndExecute;
    }, [_camera, _filmgrain], 1] call CBA_fnc_waitAndExecute;
}, [], 3] call CBA_fnc_waitAndExecute;
