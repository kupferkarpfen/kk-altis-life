// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

scopeName "requestKVS";

private _token = param[0, -1, [0]];
private _player = param[1, objNull, [objNull]];
private _side = param[2, sideUnknown, [sideUnknown]];
private _name = param[3, "", [""]];

if( _token < 0 || _token > 999999 || _player isEqualTo objNull || _side isEqualTo sideUnknown || _name isEqualTo "" ) exitWith {};

private _queryResult = [format["selectNameFromBlacklist:%1", _name], true] call XYDB_fnc_asyncCall;
if( !(_queryResult isEqualTo []) ) exitWith {
    ["NameBlacklisted", false, true] remoteExec ["BIS_fnc_endMission", _player];
};

private _uid = getPlayerUID _player;

if( _uid isEqualTo "" ) exitWith {};

private _sideID = XY_playerSides find _side;
if( _sideID < 0 ) exitWith {
    diag_log format["requestKVS ERROR: Unknown side %1 in %2 = %3", _side, XY_playerSides, _sideID]
};

// Check if name exists...
_queryResult = [format["selectUIDByName:%2%1%2", _name, "%"], true] call XYDB_fnc_asyncCall;
if( !(_queryResult isEqualTo []) && { !(((_queryResult select 0) select 0) isEqualTo _uid) || !(((_queryResult select 0) select 1) isEqualTo _sideID) } ) then {

    // Is an admin and the name is his name on another side?
    if( _uid in XY_ADMINLIST && (((_queryResult select 0) select 0) isEqualTo _uid) ) exitWith {};

    ["NameTaken", false, true] remoteExec ["BIS_fnc_endMission", _player];
    breakOut "requestKVS";
};
[format["insertPlayerAlias:%1:%2", _uid, _name]] call XYDB_fnc_asyncCall;

// Load key-value store...
_queryResult = [ format [ "selectKVStore:%1:%2", _uid, _sideID ], true ] call XYDB_fnc_asyncCall;

if( (typeName _queryResult) isEqualTo "STRING" ) exitWith {
    diag_log format["<requestKVS> SQL query error (%1), disconnecting", _queryResult];
    ["ServerError", false, true] remoteExec ["BIS_fnc_endMission", _player];
};

// Fill kv store from query...
private _keyValueStore = [];
{
    private _key = _x select 0;
    private _value = _x select 1;
    private _type = _x select 2;

    if( _type isEqualTo "SCALAR" ) then {
        _value = parseNumber _value;
    };
    if( _type isEqualTo "BOOL" ) then {
        _value = _value isEqualTo "true";
    };
    if( _type isEqualTo "ARRAY" ) then {
        _value = call compile _value;
    };
    if( _type isEqualTo "CODE" ) then {
        diag_log format["ERROR: SUSPECTED CODE INJECT: %1", _value];
        _value = "";
    };

    if( _key isEqualTo "blacklisted" && { _value } ) then {
        diag_log format["<requestKVS> Server message: Player %1 is blacklisted", _this];
        ["Blacklisted", false, true] remoteExec ["BIS_fnc_endMission", _player];
        breakOut "requestKVS";
    };

    diag_log format["KEY %1 = %2 (%3)", _key, _value, _type];
    _keyValueStore pushBack[ _key, _value ];

} forEach _queryResult;

// newbie?
// is empty or only contains whitelist level
if( (count _keyValueStore) <= 1 ) then {

    if( isNil "XY_ssv_startMoney" ) exitWith {
        diag_log "<requestKVS> Server error: XY_ssv_startMoney is undefined";
        ["ServerError", false, true] remoteExec ["BIS_fnc_endMission", _player];
        breakOut "requestKVS";
    };

    // add start money
    [_keyValueStore, KV_bank, XY_ssv_startMoney] call XY_fnc_kvaPut;
};

if( _side isEqualTo civilian ) then {

    // Load house contents from DB
    [_uid] call XYDB_fnc_populatePlayerHouses;

    // Check gang membership...
    _queryResult = [format["selectGangByMember:%2%1%2:%1", _uid, "%"], true] call XYDB_fnc_asyncCall;
    if( !(_queryResult isEqualTo []) ) then {
        // get first row...
        _queryResult = _queryResult select 0;
        // append player
        _queryResult pushBack _player;
        [{
            private _gangID = param[0, -1, [0]];
            private _gangOwner = param[1, "", [""]];
            private _gangName = param[2, "", [""]];
            private _gangMaxMembers = param[3, -1, [0]];
            private _gangBank = param[4, -1, [0]];
            private _gangMembers = param[5, [], [[]]];
            private _gangModerators = param[6, [], [[]]];
            private _player = param[7, objNull, [objNull]];

            diag_log format["Search gang: %1", _this];

            if( _gangID < 0 || _gangOwner isEqualTo "" || _gangName isEqualTo "" || _gangMaxMembers < 0 || _gangBank < 0 || _player isEqualTo objNull ) exitWith {};

            // Check if group exists...
            private _groupExists = false;
            {
                diag_log format["Check gang: %1 - %2", _x getVariable["id", -1], _x getVariable["name", "ERROR"]];
                if( (_x getVariable["id", -1]) isEqualTo _gangID ) exitWith {
                    diag_log "HIT!";
                    _groupExists = true;
                    [_player] joinSilent _x;
                };
            } forEach allGroups;

            if( !(_groupExists) ) then {
                // Make the players group the gang group
                private _group = createGroup civilian;
                _group setVariable["id", _gangID, true];
                _group setVariable["owner", _gangOwner, true];
                _group setVariable["name", _gangName, true];
                _group setVariable["maxMembers", _gangMaxMembers, true];
                _group setVariable["bank", _gangBank, true];
                _group setVariable["members", _gangMembers, true];
                _group setVariable["moderators", _gangModerators, true];
                [_player] joinSilent _group;
            };

        }, _queryResult] call XY_fnc_unscheduled;
    };
};

// Send kv store to client
[_token, _keyValueStore] remoteExecCall [ "XY_fnc_receiveKVS", _player];