// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// vehicleConfig
// parameter
// _class : class of the vehicle
// _side : owner side of the vehicle (optional, default = playerSide)

private _class = param[0, "", [""]];
private _side = param[1, playerSide, [sideUnknown]];

if( _class isEqualTo "" || _side isEqualTo sideUnknown ) exitWith { [] };

private _config = [];
{
    if( ((_x select 0) isEqualTo _side || (_x select 0) isEqualTo sideUnknown) && { (_x select 1) isEqualTo _class } ) exitWith {
        _config = _x;
    };
} forEach XY_vehicleList;

_config;