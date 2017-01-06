// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _gangID = param[0, -1, [0]];
if( _gangID < 0 ) exitWith {};

private _gang = objNull;
{
    if( _gangID isEqualTo (_x getVariable ["id", -1]) ) exitWith {
        _gang = _x;
    };
} forEach allGroups;

_gang;