// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _owner = param[0, -1, [0]];
private _name = param[1, "", [""]];
private _uid = param[2, "", [""]];

// Check if this is the HC or a player with invalid UID
if( count(_uid) != 17  ) exitWith {
    if( (_uid find "HC") != 0 ) then {
        diag_log format["<ERROR> Suspicious player id: %1", _uid];
        ["NotWhitelisted", false, true] remoteExec ["BIS_fnc_endMission", _owner];
    };
    // Stop further processing of a non-player connection
};

// Validate playername:
if( !( [_owner, _name, _uid] call XY_fnc_validatePlayerName ) ) exitWith {
    diag_log format["<OnConnect> Invalid playername (%1), disconnecting", _name];
    ["InvalidName", false, true] remoteExec ["BIS_fnc_endMission", _owner];
};
// Send houselist to client
[XY_listHouses] remoteExecCall ["XY_fnc_receiveHouses", _owner];

XY_playerNameAllowed = true;
_owner publicVariableClient "XY_playerNameAllowed";

[] remoteExec ["XY_fnc_createSpawnSigns", _owner];