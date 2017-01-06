// Written by Kupferkarpfens
// License: CC BY-NC-SA 4.0

private _container = param[1, objNull, [objNull]];
if( isNull _container ) exitWith {};

if( (typeOf _container) isEqualTo "B_supplyCrate_F" ) exitWith {
    private _house = nearestBuilding player;
    if( !(_house isKindOf "House_F") || player distance2D _house > 20 ) exitWith {};
    _house spawn {
        uisleep 10 + (random 10);
        [_this] remoteExecCall ["XYDB_fnc_updateHouseContainers", 2];
    };
};