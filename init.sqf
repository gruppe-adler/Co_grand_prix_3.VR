if (isNil "MISSION_ROOT") then {
    if(isDedicated) then {
        MISSION_ROOT = "mpmissions\__CUR_MP." + worldName + "\";
    } else {
        MISSION_ROOT = str missionConfigFile select [0, count str missionConfigFile - 15];
    };
};

enableSentences false;
enableRadio false;
enableSaving [false, false];

2 enableChannel false;  // command
4 enableChannel false;  // vehicle
5 enableChannel false;  // direct

// SCRIPTS =====================================================================
[] execVM "USER\userInit.sqf";
