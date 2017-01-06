/*
	File: fn_keyDrop.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Drops the key.
*/
private["_dialog","_list","_sel","_vehicle","_impounded","_users","_index","_index2","_i"];
disableSerialization;

_dialog = findDisplay 2700;
_list = _dialog displayCtrl 2701;
_sel = lbCurSel _list;

if( _sel == -1 ) exitWith {
    hint "Keine Daten ausgewählt";
};

_index = (parseNumber(_list lbData _sel));
_vehicle = XY_vehicles select _index;

if(_vehicle isKindOf "House_F") exitWith {
    hint "Du kannst dein Hausschlüssel nicht wegwerfen."
};
XY_vehicles = XY_vehicles - [_vehicle];

_users = _vehicle getVariable["users", []];
_index = [profileName, _users] call XY_fnc_index;
if( _index >= 0 ) then {
    _users set[_index, -1];
    _users = _users - [-1];
    _vehicle setVariable["users", _users, true];
};

[] spawn XY_fnc_keyMenu;