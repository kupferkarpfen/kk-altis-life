// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _return = [];

{
    if( playerSide isEqualTo (_x select 0) ) then {
        _return pushBack _x;
    };
} forEach XY_spawnpoints;

{
    if( _x isKindOf "House_F" ) then {
        _return pushBack [ playerSide, format["poi_house_%1", _x], getText(configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName"), { true } ];
    };
} forEach XY_vehicles;

_return;