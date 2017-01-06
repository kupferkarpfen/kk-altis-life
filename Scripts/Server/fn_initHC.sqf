// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

if( hasInterface || isServer ) exitWith {};
diag_log "INIT HC";

HC1 setVariable["hc.ready", false, true];

execVM "\server\shk_pos\shk_pos_init.sqf";
// init config
call XY_fnc_initConfiguration;

call XY_fnc_initDB;

diag_log "Init activity monitor...";
[] spawn XY_fnc_activityMonitor;

HC1 setVariable["hc.ready", true, true];
"Heartbeat" spawn { scriptName _this;
    while { true } do {
        HC1 setVariable ["hc.heartbeat", serverTime, true];
        uisleep 10;
    };
};