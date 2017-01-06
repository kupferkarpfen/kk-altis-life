// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

diag_log format["<KVStore> receiveKVS (%1)", _this];

private _token = param[0, -1, [0]];
private _keyValueStore = param[1, [], [[]]];

// There exists a very rare race-condition when the client quickly re-connects after he was kicked during client set-up (e.g. high ping)
// He then received the KVS data that was requested during the previous session while the basic client setup hasn't been done already
// The token should mitigate this and should make it very very unlikely to happen
if( !(_token isEqualTo XY_kvs_token) || !(isNil "XY_kvs_data") ) exitWith {
    diag_log format["Cancelling receiveKVS() as the tokens didn't match or KVS was already initialized: %1", XY_kvs_token];
    // We exit to prevent damage to the player's savegame
    ["ServerError", false, true] call BIS_fnc_endMission;
};

XY_kvs_data = _keyValueStore;

private _profileName = [KV_name, ""] call XY_fnc_kvsGet;
if( !XY_isAdmin && { !(_profileName isEqualTo "") } && { !(_profileName isEqualTo profileName) } ) exitWith {
    0 cutText["", "BLACK FADED"];
    [ format["<t size='0.8' color='#F0C010'>Dein Profilname muss '%1' sein</t>", _profileName], -1, -1, 1, 1] spawn BIS_fnc_dynamicText;
    systemChat format["Erwarteter Profilname: %1", _profileName];
    uisleep 15;
    ["WrongName", false, true] call BIS_fnc_endMission;
    waitUntil { false };
};

// Update local variables from KVS...
XY_CC = [KV_cash, 0] call XY_fnc_kvsGet;
XY_CA = [KV_bank, 0] call XY_fnc_kvsGet;

XY_isArrested = [ KV_arrested , false ] call XY_fnc_kvsGet;

XY_karma = [KV_karma, XY_ssv_karmaBase] call XY_fnc_kvsGet;

private _level = [KV_level, 0] call XY_fnc_kvsGet;
switch( playerSide ) do {
    case (west): {
        XY_copLevel = _level;
    };
    case (independent): {
        XY_medicLevel = _level;
    };
};

private _gear = [KV_gear, []] call XY_fnc_kvsGet;

XY_playerTrunk = +([KV_trunk, []] call XY_fnc_kvsGet);

private _licenses = [KV_licenses, []] call XY_fnc_kvsGet;

if( !(_gear isEqualTo []) ) then {
    player setUnitLoadout [_gear, false];
};

{
    missionNamespace setVariable [ format["license_%1", _x], true ];
} forEach _licenses;

if( ["cop_air_small"] call XY_fnc_hasLicense && ["cop_air"] call XY_fnc_hasLicense ) then {
    license_cop_air_small = false;
};

XY_kvs_ready = true;