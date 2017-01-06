// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _uid = param[0, "", [""]];
if( _uid isEqualTo "" ) exitWith {};

{
    if( (_x select 0) isEqualTo _uid ) exitWith {
        _x set [1, []];
    };
} forEach XY_wantedList;

// Remove crimes from database
[format["updateWantedDisable:%1", _uid]] remoteExec ["XYDB_fnc_asyncCall", XYDB];