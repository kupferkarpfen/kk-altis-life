// Written by Kupferkarpfens
// License: CC BY-NC-SA 4.0

// Saves the trunk of a vehicle / house

diag_log format["updateTrunk(%1)", _this];

private _player = param[0, objNull, [objNull]];
private _vehicle = param[1, objNull, [objNull]];
private _trunk = param[2, [], [[]]];

if( isNull _player || isNull _vehicle ) exitWith {};

// Check if this player was the one that opened the trunk...
private _uid = getPlayerUID _player;
if( !((_vehicle getVariable ["trunk.owner", ""]) isEqualTo _uid) ) exitWith {
    [1, format[XY_hintError, "Deine Änderungen konnten nicht gespeichert werden"]] remoteExec ["XY_fnc_broadcast", _player];
};

// Flag vehicle as unliftable if it contains goldbars...
private _containsGold = false;
{
    if( (_x select 0) isEqualTo "goldbar" && (_x select 1) > 0 ) exitWith {
        _containsGold = true;
    };
} forEach _trunk;
_vehicle setVariable["rope.allow", !_containsGold, true];

// Store trunk inside vehicle, non-public
_vehicle setVariable["trunk", _trunk];

// Unlock trunk
_vehicle setVariable ["trunk.owner", ""];

// Do not persist if its a rented car
private _id = _vehicle getVariable["id", -1];
if( _id < 0 ) exitWith {};

diag_log format["updateTrunk, id %1, type %2, trunk %3", _id, typeOf _vehicle, _trunk];
[format["%1:%2:%3", ["updateVehicleTrunk", "updateHouseTrunk"] select (_vehicle isKindOf "House_F"), [_trunk] call XY_fnc_removeVolatileItems, _id]] remoteExec ["XYDB_fnc_asyncCall", XYDB];