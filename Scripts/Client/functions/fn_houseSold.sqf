// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _house = param[0, objNull, [objNull]];
private _price = param[1, -1, [0]];

if( _house isEqualTo objNull || _price < 0 ) exitWith {
    [format["<CERROR> %1 (%2) invalid call XY_fnc_houseSold: %3", profileName, getPlayerUID player, _this]] remoteExec ["XY_fnc_log", 2];
};

deleteMarkerLocal format["poi_house_%1", _house];

[_price] call XY_fnc_addMoney;

private _index = XY_vehicles find _house;
if( _index > -1 ) then {
    XY_vehicles set[_index, -1];
    XY_vehicles = XY_vehicles - [-1];
};

hint "Das Haus wurde verkauft!";