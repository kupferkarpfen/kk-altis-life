/*
    File: fn_safeTake.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Gateway to fn_vehTakeItem.sqf but for safe(s).
*/
disableSerialization;

if( (lbCurSel 3502) == -1 ) exitWith {
    hint localize "STR_Civ_SelectItem";
};
private _ctrl = lbData[3502, lbCurSel 3502];
private _num = ctrlText 3505;
private _safeInfo = XY_safeObj getVariable["safe", 0];

//Error checks
if( !([_num] call XY_fnc_isNumber) ) exitWith {
    hint "Das it keine gültige Zahl";
};

_num = parseNumber(_num);
if( _num < 1 || _ctrl != "goldbar" || _num > _safeInfo ) exitWith {};

private _config = [_ctrl] call XY_fnc_itemConfig;

if( ([] call XY_fnc_getTrunkWeight) + ((_config select 1) * _num) > XY_maxWeight ) exitWith {
    hint parseText format[XY_hintError, "Dein Inventar ist voll"];
};

//Take it
[_ctrl, _num] call XY_fnc_addItemToTrunk;

XY_safeObj setVariable["safe",_safeInfo - _num,true];
[XY_safeObj] call XY_fnc_safeInventory;