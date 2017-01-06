// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _player  = param[0, objNull, [objNull]];
private _house = param[1, objNull, [objNull]];
private _price = param[2, -1, [0]];

diag_log format[ "insertHouse(%1)", _this ];

if( _player isEqualTo objNull || _house isEqualTo objNull || _price < 0 ) exitWith {};

private _ownerUID = getPlayerUID _player;
private _ownerName = _player getVariable["realName", "ERROR"];
private _housePos = getPosATL _house;

private _queryResult = [format["selectHouseByPos:%1", _housePos], true] call XYDB_fnc_asyncCall;
diag_log format["Result: %1", _queryResult];

// Works for a resultset and a string (=error) response...
if( count _queryResult > 0 ) exitWith {
    diag_log format["[ERROR] Client %1 tried buying a house that is already occupied @ %2, result %3", _ownerUID, _housePos, _queryResult];
    [1, "Das Haus ist bereits belegt"] remoteExec ["XY_fnc_broadcast", _player];
    // Refund the money:
    [_price, false, 1] remoteExec ["XY_fnc_addMoney", _player];
};

_queryResult = [format["insertHouse:%1:%2:%3:%4:%5", _ownerUID, _housePos, [], [], 1], true] call XYDB_fnc_asyncCall;
if( _queryResult isEqualTo [] || (typeName _queryResult) isEqualTo "STRING" ) exitWith {
    diag_log format["<ERROR> NO INSERT ID RETURNED FOR HOUSE INSERT (%1)", _this];
    ["ServerError", false, true] remoteExec ["BIS_fnc_endMission", _player];
};
private _houseID = _queryResult select 0;
diag_log format["House DB ID: %1", _houseID];

_house setVariable["id", _houseID, true];
_house setVariable["containers", [], true];
_house setVariable["slots", [], true];
_house setVariable["trunk", []];

[getPlayerUID _player, 9, format ["Kauft Haus @ %1 für $%2", mapGridPosition _house, [_price] call XY_fnc_numberText]] call XYDB_fnc_log;

XY_listHouses pushBack [_house, _ownerUID, _ownerName];

// Send new house to all clients
[[[_house, _ownerUID, _ownerName]]] remoteExecCall ["XY_fnc_receiveHouses", -2];

[1, "Das Haus gehört nun dir"] remoteExec ["XY_fnc_broadcast", _player];