// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private["_ret", "_list"];

if( !params[
    [ "_unit", objNull, [objNull] ]
    ]) exitWith {};

// Return all online entries on wanted list
_list = [];
{
    if( [_x select 0] call XY_fnc_onlineUID ) then {
        _list pushBack _x;
    };
} forEach XY_wantedList;

[_list] remoteExec ["XY_fnc_wantedList", _unit];