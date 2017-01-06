// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
//
// return item configuration
// _name must be the short name (e.g. "apple")

private _name = param[0, "",  [""]];
if( _name isEqualTo "" ) exitWith { [] };

private _config = [];
{
    if( (_x select 0) isEqualTo _name ) exitWith {
        _config = _x;
    };
} forEach XY_virtItems;

_config;