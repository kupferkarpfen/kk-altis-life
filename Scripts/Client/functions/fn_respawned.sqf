/*
    File: fn_respawned.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Sets the player up if he/she used the respawn option.
*/

XY_atmUsable = true;
XY_actionInUse = false;
XY_trackerVehicle = objNull;
XY_trackerTimeout = 0;
XY_hunger = 0;
XY_thirst = 0;

// Forget last received passport
XY_PP_LASTPASS = [];
XY_PP_LASTPASS_EXPIRE = 0;

player playMove "amovpercmstpsnonwnondnon";

player setVariable["revive", nil, true];
player setVariable["name", nil, true];
player setVariable["reviving", nil, true];

player setUnitLoadout (call XY_fnc_getDefaultLoadout);

if( XY_removeWanted ) then {
    XY_removeWanted = false;
    [getPlayerUID player] remoteExec ["XY_fnc_wantedRemove", 2];
};

if( XY_isArrested ) exitWith {
    // Re-Jail the player with the last known jailtime
    [ [ KV_jailTime, 15 ] call XY_fnc_kvsGet ] call XY_fnc_jail;
};

[["wait"] call XY_fnc_spawnMenu] call XY_fnc_doSpawn;