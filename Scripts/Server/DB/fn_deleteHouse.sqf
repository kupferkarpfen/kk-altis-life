// Author: Bryan "Tonic" Boardwine
// Rewritten by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _house = param[0, objNull, [objNull]];
private _player = param[1, objNull, [objNull]];
private _price = param[2, -1, [0]];

if( isNull _house || isNull _player || _price < 0 ) exitWith {
    diag_log format["[ERROR] Invalid call to deleteHouse: %1", _this];
};

private _houseID = _house getVariable["id", -1];
if( _houseID < 0 ) exitWith {
    [1, "Irgendetwas stimmt mit dem Haus nicht..."] remoteExec ["XY_fnc_broadcast", _player];
};
if( _house getVariable["house_sold", false] ) exitWith {
    [1, "Das Haus ist bereits verkauft"] remoteExec ["XY_fnc_broadcast", _player];
};
_house setVariable["house_sold", true, true];

[format["updateHouseSold:%1", _houseID]] call XYDB_fnc_asyncCall;
[ getPlayerUID _player, 9, format ["Verkauft Haus @ %1 für %2", mapGridPosition _house, [_price] call XY_fnc_numberText ]] call XYDB_fnc_log;

{
    deleteVehicle _x
} forEach (_house getVariable["containers", []]);

_house setVariable["house_sold", true, true];
_house setVariable["id", nil, true];
_house setVariable["house_owner", nil, true];
_house setVariable["locked", false, true];
_house setVariable["trunk", nil, true];
_house setVariable["containers", nil, true];

for "_i" from 1 to (getNumber(configFile >> "CfgVehicles" >> (typeOf _house) >> "numberOfDoors")) do {
    _house setVariable[format["bis_disabled_Door_%1", _i], 0, true];
};

[ _house, _price ] remoteExecCall ["XY_fnc_houseSold", _player];