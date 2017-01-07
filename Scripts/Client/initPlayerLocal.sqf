// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

if( !hasInterface ) exitWith {};

call XY_fnc_loading;

showChat false;
player allowDamage false;
disableUserInput true;
setViewDistance 1000;
setObjectViewDistance [800, 50];
setTerrainGrid 25;

_whitelist = [
    "rscrespawncounter_script",
    "rscdebugconsole_watchsave",
    "rscstanceinfo_script",
    "rscdiary_playerpos",
    "rscrevive_script",
    "rscunitinfo_script",
    "rscslingloadassistant_script",
    "rsctestcontrolstyles_script",
    "igui_displays",
    "rscphaserules_script",
    "rscadvancedhint_script",
    "rscfiringdrilltime_script",
    "rscdiary_script",
    "mpmarkdisplays_displays",
    "loading_classes",
    "rscunitinfo",
    "rscminimap_script",
    "rscstatic_script",
    "rscmissiontext_script",
    "rscdiary",
    "rscmsgbox",
    "rscprocedurevisualization_script",
    "igui_classes",
    "gui_classes",
    "rscavcamera_script",
    "rscfunctionsviewer_script",
    "rscspectator_script",
    "rscfiringdrillcheckpoint_script",
    "rscmsgbox3_script",
    "rscvrmeta_script",
    "loading_displays",
    "rscrecruitstatus_script",
    "rscestablishingshot_script",
    "rsccuratorping_script",
    "rscmsgbox_script",
    "rsctestcontroltypes_script",
    "rsctilesgroup_script",
    "mpmarkdisplays_classes",
    "rscstanceinfo",
    "rsccuratorvisionmodes_script",
    "rscnoise_script",
    "rscnotification_script",
    "rscmissionstatus_script",
    "rscdiary_playerpostime",
    "rsccommmenuitems_script",
    "gui_displays",
    "rschvtphase_script",
    "rscdiary_playeralpha"
];

{
    if( _x find "bis_" == -1 && { _x find "rscdisplay" == -1 } && { !(_x in _whitelist) } )then {
        diag_log format["Remove %1 from uiNamespace", _x];
        uiNamespace setVariable [_x, nil];
    };
} forEach (allVariables uiNamespace);

enableSentences false;
enableRadio false;
0 fadeRadio 0;

call XY_fnc_stripPlayer;

removeAllMissionEventHandlers "draw3D";

player setVariable ["BIS_enableRandomization", false, true];
player setVariable ["BIS_noCoreConversations", true];

// register player login
private _side = switch( playerSide ) do {
    case west: {"COP"};
    case independent: {"MEDIC"};
    case civilian: {"CIV"};
    default {"ERR"};
};
[ getPlayerUID player, 15, format["Anmeldung als %1, Name %2", _side, profileName] ] remoteExec ["XYDB_fnc_log", XYDB];

// init config
call XY_fnc_initConfiguration;

// init some of the map objects
call XY_fnc_runMapInitializers;

// Lockup the freshspawn building
// This is usually not the right place to do this, but somehow arma keeps fucking up the door logic, so we do it for every client on its own
{
    if( (_x find "naturalisation") >= 0 ) exitWith {
        private _house = nearestBuilding (getMarkerPos _x);
        private _doors = getNumber(configFile >> "CfgVehicles" >> (typeOf _house) >> "NumberOfDoors");
        for "_i" from 1 to _doors do {
            _house setVariable[ format["bis_disabled_Door_%1", _i], 1];
        };
    };
} forEach allMapMarkers;

// Wait for name approval
waitUntil { uisleep 2 + (random 2); missionNamespace getVariable["XY_playerNameAllowed", false]; };

XY_isAdmin = (getPlayerUID player) in XY_ADMINLIST;
XY_showAdminMessages = XY_isAdmin;
XY_kvs_token = floor(random 999999);
[XY_kvs_token, player, playerSide, profileName] remoteExec ["XYDB_fnc_requestKVS", 2];

// Wait for key-value-store, house list, etc...
waitUntil { uisleep 5 + (random 5); missionNamespace getVariable["XY_isServerReady", false] && missionNamespace getVariable["XY_kvs_ready", false] && !(isNil "XY_fnc_cleanup") && !(isNil "XY_allHouses") };

if( XY_isAdmin ) then {
    if( XY_copLevel < 1 && playerSide isEqualTo west ) then {
        XY_copLevel = 4;
    };
    if( XY_medicLevel < 1 && playerSide isEqualTo independent ) then {
        XY_medicLevel = 3;
    };
};
if( !(playerSide isEqualTo civilian) && { ([KV_level, 0] call XY_fnc_kvsGet) < 1 } && { !XY_isAdmin } ) exitWith {
    ["NotWhitelisted", false, true] call BIS_fnc_endMission;
    waitUntil { false };
};

// Check if naturalisation is complete...
private _sawIntro = false;
if( (([ KV_birthday, "" ] call XY_fnc_kvsGet) isEqualTo "") ||
    (([ KV_birthlocation, "" ] call XY_fnc_kvsGet) isEqualTo "") ||
    (([ KV_address, "" ] call XY_fnc_kvsGet) isEqualTo "") ||
    (([ KV_town, "" ] call XY_fnc_kvsGet) isEqualTo "") ||
    (([ KV_height, "" ] call XY_fnc_kvsGet) isEqualTo "") ||
    (([ KV_eyecolor, "" ] call XY_fnc_kvsGet) isEqualTo "") ) then {

    XY_startupDone = true;
    waitUntil { isNil "XY_startupDone" };

    _sawIntro = true;
    call XY_fnc_intro;

    // Apply default loadout when intro went through
    player setUnitLoadout (call XY_fnc_getDefaultLoadout);
};

[KV_name, profileName] call XY_fnc_kvsPut;

player addEventHandler["Killed", { _this spawn XY_fnc_onPlayerKilled; } ];
player addEventHandler["HandleDamage", { _this call XY_fnc_handleDamage; } ];
player addEventHandler["Respawn", { _this call XY_fnc_onPlayerRespawn; } ];
player addEventHandler["Fired", { _this call XY_fnc_onFired; } ];
player addEventHandler["Reloaded", { _this call XY_fnc_onReloaded; } ];

player addEventHandler["InventoryOpened", { _this call XY_fnc_inventoryOpened; } ];
player addEventHandler["InventoryClosed", { _this call XY_fnc_inventoryClosed; } ];

player addEventHandler["Put", { XY_forceSaveTime = time + 3; _this call XY_fnc_onPutItem; }];
player addEventHandler["Take", { XY_forceSaveTime = time + 3; _this call XY_fnc_onTakeItem; } ];

switch (playerSide) do {
    case west: { call XY_fnc_initCop; };
    case independent: { call XY_fnc_initMedic; };
    default { call XY_fnc_initCiv; };
};

player setVariable["copLevel", XY_copLevel, true];
player setVariable["medicLevel", XY_medicLevel, true];
player setVariable["restrained", false, true];
player setVariable["escorting", false, true];
player setVariable["missingOrgan", false, true];
player setVariable["steam64ID", getPlayerUID player, true];
player setVariable["realName", profileName, true];
player setVariable["karma", XY_karma, true];
player addRating 999999;

// when intro ran, this is already nil
if( !(missionNamespace getVariable["XY_startupDone", true]) ) then {
    XY_startupDone = true;
};
waitUntil { isNil "XY_startupDone" };

disableUserInput false;
setCurrentChannel 5;

// Check if we have a spawn point or are in jail...
if( _sawIntro ) then {

    // Auto-spawn in Kavala after intro
    if( playerSide isEqualTo civilian ) then {
        [[3649, 13096, 0]] call XY_fnc_doSpawn;
    };
    if( playerSide isEqualTo west ) then {
        [[3544, 13010, 0]] call XY_fnc_doSpawn;
    };
    if( playerSide isEqualTo independent ) then {
        [[3750, 12999, 0]] call XY_fnc_doSpawn;
    };
} else {
    if( XY_isArrested ) then {

        [ [ KV_jailTime, 15 ] call XY_fnc_kvsGet ] spawn XY_fnc_jail;

    } else {

        private _spawnPosition = [];
        private _spawnDamage = 0;
        private _spawnHunger = 0;
        private _spawnThirst = 0;

        if( (profileNamespace getVariable [ "xy_xy.sessionKey", -1 ]) isEqualTo XY_sessionKey && (profileNamespace getVariable [ "xy_xy.side", sideUnknown ]) isEqualTo playerSide ) then {
            // Player already connected this session, check if there's a saved position
            _spawnPosition = profileNamespace getVariable [ "xy_xy.lastPosition", []];
            _spawnDamage = profileNamespace getVariable [ "xy_xy.damage", 0];
            _spawnHunger = profileNamespace getVariable [ "xy_xy.hunger", 0];
            _spawnThirst = profileNamespace getVariable [ "xy_xy.thirst", 0];
        };

        // Only display welcome on first connect in this server period
        if( _spawnPosition isEqualTo [] ) then {
            if( !_sawIntro ) then {
                call XY_fnc_welcome;
            };
        } else {
            // Double-check position for obstacles, if no valid position is found [] is returned
            _spawnPosition = _spawnPosition findEmptyPosition [0, 250, "B_Quadbike_01_F"];
        };

        if( _spawnPosition isEqualTo [] )then {

            _spawnPosition = (["wait"] call XY_fnc_spawnMenu);

        } else {
            [ "<t size='0.6' color='#F0C010'>Du startest an deiner letzten bekannten Position</t>", -1, -1, 4, 1 ] spawn BIS_fnc_dynamicText;

            XY_thirst = _spawnThirst;
            XY_hunger = _spawnHunger;
            player setDamage _spawnDamage;
        };

        [_spawnPosition] call XY_fnc_doSpawn;
    };
};

showChat true;

call XY_fnc_setupActions;

[] spawn XY_fnc_initSurvival;
[] spawn XY_fnc_cleanup;

// init addons
[] spawn XY_fnc_allergy;
[] spawn XY_fnc_autosave;
[] spawn XY_fnc_emptyfuel;
[] spawn XY_fnc_equipCarrier;
[] spawn XY_fnc_disableThermal;
[] spawn XY_fnc_playerMarkers;
["init"] spawn XY_fnc_markerManager;
[] spawn XY_fnc_market;
[] spawn XY_fnc_noside;
[] spawn XY_fnc_paycheck;
[] spawn XY_fnc_speedtrap;
[] spawn XY_fnc_racingSupport;
[] spawn XY_fnc_radiation;
[] spawn XY_fnc_refuelSupport;
[] spawn XY_fnc_safezone;
[] spawn XY_fnc_spikestripEffect;
// [] spawn XY_fnc_snow;
[] spawn XY_fnc_teargas;
[] spawn XY_fnc_textures;

[] spawn XY_fnc_cashCheck;

(findDisplay 46) displayAddEventHandler ["KeyDown", { _this call XY_fnc_keyHandler; } ];

["XY_PlayerTags", "onEachFrame", "XY_fnc_playerTags"] call BIS_fnc_addStackedEventHandler;

[player, XY_sidechat, playerSide] remoteExec ["XY_fnc_managesc", 2];

call XY_fnc_settingsInit;

0 cutText ["", "BLACK IN", 2];

// This is hacky as fuck, I know but I'm lazy
// TODO: Move to own script
"VariousUpdates" spawn { scriptName _this;

    private _nextActivity = time + 180;

    while { true } do {

        uisleep 1;
        if( alive player ) then {
            call XY_fnc_updateHUD;
        };

        if( time >= _nextActivity ) then {
            [KV_playTime, ([KV_playTime, 0] call XY_fnc_kvsGet) + 3] call XY_fnc_kvsPut;
            _nextActivity = time + 180;
        };

        private _pos = [];

        if( (call XY_fnc_isAlive) ) then {

            _pos = getPos player;

            if( (vehicle player) isKindOf "Air" ) then {
                // Over water? Disable position saving
                if( surfaceIsWater _pos ) then {
                    _pos = [];
                } else {
                    // Set position on ground
                    _pos set [2, 0];
                };
            };
        };

        profileNamespace setVariable ["xy_xy.sessionKey", XY_sessionKey];
        profileNamespace setVariable ["xy_xy.lastPosition", _pos];
        profileNamespace setVariable ["xy_xy.damage", damage player];
        profileNamespace setVariable ["xy_xy.hunger", XY_hunger];
        profileNamespace setVariable ["xy_xy.thirst", XY_thirst];
        profileNamespace setVariable ["xy_xy.side", playerSide];
        saveProfileNamespace;
    };
};

[player, playerSide] remoteExec [ "XY_fnc_pollKeychain", 2 ];
[player] remoteExec ["XY_fnc_pollMarketPrices", 2];
[player] remoteExec ["XYDB_fnc_uidToName", XYDB];

// -- Oil Rig --

private _tower = nearestObject [[19604, 21918, 0], "Land_TTowerBig_2_F"];

private _firePos = (getPos _tower);
_firePos set[2, 53];

private _source = "#particlesource" createVehicleLocal _firePos;
_source setParticleClass "BigDestructionFire";
_source setParticleFire [0.15, 5, 0.75];

_source = "#particlesource" createVehicleLocal _firePos;
_source setParticleParams [
    ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 7, 48],
    "",
    "Billboard",
    1,
    30,
    [0, 0, 0],
    [0, 0, 3],
    0,
    1.2,
    1,
    0.025,
    [3, 15, 50],
    [[0, 0, 0, 0.05], [0.05, 0.05, 0.05, 0.6], [0.07, 0.07, 0.07, 0.3], [0.1, 0.1, 0.1, 0]],
    [0.5],
    0,
    0,
    "",
    "",
    _firePos,
    0
];
_source setParticleRandom [6, [2, 2, 1], [0.1, 0.1, 0.1], 0, 0.25, [0.1, 0.1, 0.1, 0.05], 0, 0, 90];
_source setDropInterval 0.085;

XY_gameRunning = true;

if( playerSide != civilian ) then {
    player createDiarySubject ["calllog", "Notrufe"];
};

"AnnounceHelp" spawn { scriptName _this;

    uisleep (60 + random(30));
    hint parseText format[XY_hintMsg, format[XY_hintH1, "Hilfe öffnen mit F1"], "Die Ingame-Hilfe zeigt dir wichtige Informationen, Tastenkürzel, Lizenzpreise, Farmrouten u.v.m. an"];
};