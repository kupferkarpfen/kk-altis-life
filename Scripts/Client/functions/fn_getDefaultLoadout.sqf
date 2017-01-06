// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _result = [];
{
    if( playerSide isEqualTo (_x select 0) ) exitWith {
        _result = _x select 1;
    };
} forEach XY_defaultLoadouts;

_result;