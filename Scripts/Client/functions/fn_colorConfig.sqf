// colorConfig
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
//
// return vehicle color configuration
// param 0 = vehicle class
// param 1 (optional)
//       -1 (default) = return all colors
//     <index> = return specific color
// param 2 _side (optional, default = playerSide)

private _class = param[0, "", [""]];
private _index = param[1, -1, [0]];
private _side = param[2, playerSide, [sideUnknown]];

private _config = [];
if( _class isEqualTo "" ) exitWith {};

{
    if( (_x select 0) isEqualTo _class ) exitWith {
        _config = _x select 1;
    };
} forEach ([_side] call XY_fnc_skins);

if( !(_config isEqualTo []) && _index >= 0 ) then {
    _config = _config select _index;
};

_config;