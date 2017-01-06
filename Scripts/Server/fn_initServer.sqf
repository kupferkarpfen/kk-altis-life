// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

if( !isServer ) exitWith {};

diag_log "INIT SERVER";

XY_isServerReady = false;
publicVariable "XY_isServerReady";

// Generate random server session key to enable position saving in client profileNamespace
XY_sessionKey = floor (random 99999);
publicVariable "XY_sessionKey";

east setFriend [west, 0];
east setFriend [civilian, 0];
east setFriend [independent, 0];

west setFriend [east, 0];
west setFriend [civilian, 1];
west setFriend [independent, 1];

independent setFriend [east, 0];
independent setFriend [civilian, 1];
independent setFriend [west, 1];

civilian setFriend [east, 0];
civilian setFriend [independent, 1];
civilian setFriend [west, 1];

call XY_fnc_initDB;
// --

// init config
call XY_fnc_initConfiguration;
call compile preprocessfile "\server\shk_pos\shk_pos_init.sqf";

//Run procedures for SQL cleanup on mission start.
["CALL resetLifeVehicles", false, true] call XYDB_fnc_asyncCall;
["CALL deleteDeadVehicles", false, true] call XYDB_fnc_asyncCall;
["CALL deleteOldHouses", false, true] call XYDB_fnc_asyncCall;
["CALL deleteOldGangs", false, true] call XYDB_fnc_asyncCall;
["CALL createStatistics", false, true] call XYDB_fnc_asyncCall;
["CALL deleteOldWantedEntries", false, true] call XYDB_fnc_asyncCall;

XYDB = 2;
publicVariable "XYDB";

["update"] call XY_fnc_ssv;

fed_bank setVariable["safe", XY_ssv_fed, true];

["loop"] call XY_fnc_ssv;

life_radio_west = radioChannelCreate [[0, 0.95, 1, 0.8], "Side Channel", "%UNIT_NAME", []];
life_radio_civ = radioChannelCreate [[0, 0.95, 1, 0.8], "Side Channel", "%UNIT_NAME", []];
life_radio_indep = radioChannelCreate [[0, 0.95, 1, 0.8], "Side Channel", "%UNIT_NAME", []];
life_radio_east = radioChannelCreate [[0, 0.95, 1, 0.8], "Side Channel", "%UNIT_NAME", []];

//General cleanup for clients disconnecting
addMissionEventHandler ["HandleDisconnect", {_this call XY_fnc_clientDisconnect; false; }];
onPlayerConnected { diag_log format["onPlayerConnected(%1) %2 (%3)", _id, _name, _uid]; [_owner, _name, _uid] call XY_fnc_onConnect; };

//Lockup the dome
fed_bank setVariable["door.open.1", false, true];
fed_bank setVariable["door.open.2", false, true];
fed_bank setVariable["door.open.3", false, true];

private _dome = nearestObject [[20894, 19228, 0], "Land_Dome_Big_F"];
_dome setVariable["bis_disabled_Door_1", 1, true];
_dome setVariable["bis_disabled_Door_2", 1, true];
_dome setVariable["bis_disabled_Door_3", 1, true];
_dome allowDamage false;
XY_FED_DOME = _dome;
publicVariable "XY_FED_DOME";

private _rsb = nearestObject [[20888, 19240, 0], "Land_Research_house_V1_F"];
_rsb setVariable["bis_disabled_Door_1", 1, true];
_rsb allowDamage false;
XY_FED_RSB = _rsb;
publicVariable "XY_FED_RSB";

//Lockup the jail
private _jail = nearestObject [[11611, 11937, 0], "Land_Dome_Small_F"];
_jail setVariable["bis_disabled_Door_1", 1, true];
_jail setVariable["bis_disabled_Door_2", 1, true];
_jail allowDamage false;
XY_JAIL = _jail;
publicVariable "XY_JAIL";

XY_HIDEOUT_1 = (nearestObjects[getMarkerPos "poi_gang_area_1", ["Land_u_Barracks_V2_F", "Land_i_Barracks_V2_F"], 25]) select 0;
if( isNil "XY_HIDEOUT_1" ) exitWith { diag_log "<ERROR> SERVER LOAD ERROR: CANNOT FIND GANGHIDEOUT 1!"; };
publicVariable "XY_HIDEOUT_1";

XY_HIDEOUT_2 = (nearestObjects[getMarkerPos "poi_gang_area_2", ["Land_u_Barracks_V2_F", "Land_i_Barracks_V2_F"], 25]) select 0;
if( isNil "XY_HIDEOUT_2" ) exitWith { diag_log "<ERROR> SERVER LOAD ERROR: CANNOT FIND GANGHIDEOUT 2!"; };
publicVariable "XY_HIDEOUT_2";

XY_HIDEOUT_3 = (nearestObjects[getMarkerPos "poi_gang_area_3", ["Land_u_Barracks_V2_F", "Land_i_Barracks_V2_F"], 25]) select 0;
if( isNil "XY_HIDEOUT_3" ) exitWith { diag_log "<ERROR> SERVER LOAD ERROR: CANNOT FIND GANGHIDEOUT 3!"; };
publicVariable "XY_HIDEOUT_3";

XY_wantedList = [];
XY_ctfActive = false;
XY_allowEvents = true;

{
    _x setVariable ["BIS_noCoreConversations", true, true];
} forEach allUnits;

diag_log "Init RTC...";
call XY_fnc_realtimeClock;

diag_log "Load houses...";
call XYDB_fnc_loadHouses;

diag_log "Load wanted list...";
call XY_fnc_wantedLoad;

diag_log "Init market...";
call XY_fnc_marketConfiguration;
diag_log "Load prices...";
call XY_fnc_marketLoad;
diag_log "Update prices...";
call XY_fnc_marketUpdate;

diag_log "Market initialized, adding dynamics...";
[] spawn XY_fnc_marketChange;
diag_log "Init time accelerator...";
[] spawn XY_fnc_timeAccelerator;
diag_log "Init weather...";
[] spawn XY_fnc_randomWeather;
diag_log "Init federal update...";
[] spawn XY_fnc_federalUpdate;
diag_log "Init pvp events...";
[] spawn XY_fnc_pvpEvents;
diag_log "Init cleanup...";
[] spawn XY_fnc_serverCleanup;
diag_log "Init client functions...";
[] spawn XY_fnc_clientFunctions;
diag_log "Init refueling...";
[] call XY_fnc_fuelstations;
diag_log "Init activity monitor...";
[] spawn XY_fnc_activityMonitor;
diag_log "Init bounty announce...";
[] spawn XY_fnc_wantedAnnounce;

"HCDetect" spawn { scriptName _this;
    while { true } do {
        private _target = 2;
        if( !(isNil "HC1") && { !(isNull HC1) } && { HC1 getVariable ["hc.ready", false] } && { (serverTime - (HC1 getVariable ["hc.heartbeat", 0])) < 20 } ) then {
            _target = (owner HC1);
        };
        if( _target != XYDB ) then {
            diag_log format["<HC> Updating XYDB = %1", _target];
            XYDB = _target;
            publicVariable "XYDB";
        };
        uisleep 1;
    };
};

"FPSDiagnose" spawn { scriptName _this;

    private _samples = 5;

    private _allOccurences = [];

    // Diagnose...
    while { true } do {

        private _avg = 0;
        private _min = 100;
        private _max = 0;

        for "_i" from 1 to _samples do {
            _fps = diag_fps;
            _avg = _avg + _fps;
            _min = _fps min _min;
            _max = _fps max _max;

            uisleep 1;
        };
        _min = round(_min);
        _avg = round(_avg / _samples);
        _max = round(_max);

        diag_log format["<PERFORMANCE> ACTIVE SQF: %1, FPS (MIN/AVG/MAX): %2/%3/%4, PLAYERS: %5, VEHICLES: %6", count diag_activeSQFScripts, _min, _avg, _max, count allPlayers, count vehicles];
        {
            diag_log format["<PERFORMANCE> %1", _x];
        } forEach diag_activeSQFScripts;

        diag_log format["<MARKER> MARKERS"];
        {
            if( (_x find "_USER_DEFINED") > -1 ) then {
                diag_log format["<MARKER> %1 = %2", _x, markerText _x];
            };
        } forEach allMapMarkers;

        uisleep 600;
    };
};

XY_ticketSign = "Land_InfoStand_V2_F" createVehicle [0, 0, 0];
XY_ticketSign setPosATL [3681.34, 12281.1, 0];
XY_ticketSign setDir 275;
XY_ticketSign setVectorUp [0, 0, 1];
XY_ticketSign enableSimulation false;
publicVariable "XY_ticketSign";

// Create global marker for ticket position
private _markerRedeem = createMarker ["poi_ticketRedeem", [3681.34, 12281.1, 0]];
_markerRedeem setMarkerColor "ColorRed";
_markerRedeem setMarkerType "hd_dot";
_markerRedeem setMarkerText "Tickets einlösen";

{
    waitUntil { !(isNil "XY_ticketSign") };
    XY_ticketSign addAction[ "Tickets einlösen", {

        private _count = ([XY_fnc_getItemCountFromTrunk, ["ticket1"]] call XY_fnc_unscheduled);
        if( _count > 0 ) exitWith {
            if( ([XY_fnc_removeItemFromTrunk, ["ticket1", _count]] call XY_fnc_unscheduled) ) then {
                ["ttb", (["ttb", 0] call XY_fnc_kvsGet) + _count] call XY_fnc_kvsPut;
                hint parseText format[XY_hintH1, format["Du hast %1 blaue%2 Ticket%3 eingelöst", _count, ["s", ""] select (_count > 1), ["", "s"] select (_count > 1)]];
                call XY_fnc_save;
            };
        };

        _count = ([XY_fnc_getItemCountFromTrunk, ["ticket2"]] call XY_fnc_unscheduled);
        if( _count > 0 ) exitWith {
            if( ([XY_fnc_removeItemFromTrunk, ["ticket2", _count]] call XY_fnc_unscheduled) ) then {
                ["ttr", (["ttr", 0] call XY_fnc_kvsGet) + _count] call XY_fnc_kvsPut;
                hint parseText format[XY_hintH1, format["Du hast %1 rote%2 Ticket%3 eingelöst", _count, ["s", ""] select (_count > 1), ["", "s"] select (_count > 1)]];
                call XY_fnc_save;
            };
        };

        _count = ([XY_fnc_getItemCountFromTrunk, ["ticket3"]] call XY_fnc_unscheduled);
        if( _count > 0 ) exitWith {
            if( ([XY_fnc_removeItemFromTrunk, ["ticket3", _count]] call XY_fnc_unscheduled) ) then {
                ["ttg", (["ttg", 0] call XY_fnc_kvsGet) + _count] call XY_fnc_kvsPut;
                hint parseText format[XY_hintH1, format["Du hast %1 goldene%2 Ticket%3 eingelöst", _count, ["s", ""] select (_count > 1), ["", "s"] select (_count > 1)]];
                call XY_fnc_save;
            };
        };

        hint parseText format[XY_hintError, "Du hast keine Tickets"];

    }, "", 0, false, true, "", "", 3];
} remoteExec ["bis_fnc_call", -2, true];

diag_log "server ready and running...";
XY_isServerReady = true;
publicVariable "XY_isServerReady";