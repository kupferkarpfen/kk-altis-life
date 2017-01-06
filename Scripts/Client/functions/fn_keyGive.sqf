/*
    File: fn_keyGive.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Gives a copy of the key for the selected vehicle to the selected player.
    Player must be within range.
*/

disableSerialization;

private _dialog = findDisplay 2700;
private _list = _dialog displayCtrl 2701;
private _plist = _dialog displayCtrl 2702;

private _sel = lbCurSel _list;
private _vehicleID = _list lbData _sel;
private _vehicle = XY_vehicles select parseNumber(_vehicleID);

_sel = lbCurSel _plist;
private _unit = _plist lbData _sel;
_unit = call compile format["%1", _unit];
if( isNil "_unit" || { isNull _unit } ) exitWith {};

hint format["Du hast %1 die Schlüssel zu deinem %2 gegeben", [_unit getVariable["realName", name _unit], "der maskierten Person"] select ([_unit] call XY_fnc_playerMasked), getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName")];

[_vehicle, player] remoteExec ["XY_fnc_receiveKey", _unit];