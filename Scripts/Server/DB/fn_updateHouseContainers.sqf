// Written by Kupferkarpfens
// License: CC BY-NC-SA 4.0

diag_log format["updateHouseContainers(%1)", _this];

private _house = param[0, objNull, [objNull]];
if( isNull _house ) exitWith {};

private _houseID = _house getVariable["id", -1];
diag_log format["updateHouseContainers house id = %1", _houseID];
if( _houseID < 0 ) exitWith {};

private _containers = _house getVariable ["containers", []];

private _arr = [];
{
    private _className = typeOf _x;
    private _weapons = getWeaponCargo _x;
    private _magazines = getMagazineCargo _x;
    private _items = getItemCargo _x;
    private _backpacks = getBackpackCargo _x;

    _arr pushBack [_className, [_weapons, _magazines, _items, _backpacks]];
} forEach _containers;

[format["updateHouseContainers:%1:%2", _arr, _houseID]] remoteExec ["XYDB_fnc_asyncCall", XYDB];