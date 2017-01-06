// Written by Kupferkarpfens
// License: CC BY-NC-SA 4.0

// Returns the trunk of a vehicle / house

diag_log format["requestTrunk(%1)", _this];
if( canSuspend ) exitWith {
    diag_log "CALLED REQUEST TRUNK SUSPENDABLE, EXITING";
};

private _player = param[0, objNull, [objNull]];
private _vehicle = param[1, objNull, [objNull]];

if( isNull _player || isNull _vehicle ) exitWith {};
if( _vehicle getVariable ["busy", false] ) exitWith {};
if( _vehicle isKindOf "House_F" && !(_vehicle getVariable["house.loaded", false]) ) exitWith {};

private _uid = getPlayerUID _player;
// Check if trunk is locked
private _trunkOwner = _vehicle getVariable ["trunk.owner", ""];
if( !(_trunkOwner isEqualTo "") && ([_trunkOwner] call XY_fnc_onlineUID) ) exitWith {};
_vehicle setVariable ["trunk.owner", _uid];

private _vid = _vehicle getVariable["id", -1];
if( _vid >= 0 && { !(_vehicle getVariable["trunk.loaded", false]) } ) exitWith {
    [_vehicle, _player] spawn {
        private _vehicle = _this select 0;
        [_vehicle] call XYDB_fnc_loadTrunk;

        private _trunk = _vehicle getVariable["trunk", []];
        // Send trunk to player
        ["receive", _vehicle, _trunk] remoteExecCall ["XY_fnc_trunkMenu", _this select 1];
    };
};
private _trunk = _vehicle getVariable["trunk", []];

diag_log format["Send trunk to player (%1) = %2", _this, _trunk];
// Send trunk to player
["receive", _vehicle, _trunk] remoteExecCall ["XY_fnc_trunkMenu", _player];