/*
	File: fn_pardon.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Pardons the selected player.
*/
private["_list", "_data", "_name", "_action", "_uid"];
disableSerialization;

_list = (findDisplay 2400) displayCtrl 2402;
_data = lbData[2401,(lbCurSel 2401)];
_data = call compile format["%1", _data];
if(isNil "_data") exitWith {};
if(typeName _data != "ARRAY") exitWith {};
if(count _data == 0) exitWith {};

closeDialog 0;

_uid = _data select 0;
_name = "ERROR";

{
    if( _uid isEqualTo (getPlayerUID _x) ) exitWith {
        _name = _x getVariable["realName", "ERROR"];
    };
} forEach allPlayers;
    
_action = [
    format["Willst du den Fahndungseintrag von %1 wirklich löschen?", _name],
    "Fahndungseintrag löschen",
    localize "STR_Global_Yes",
    localize "STR_Global_No"
] call XY_fnc_showQuestionbox;

if( !_action ) exitWith {};

[_uid] remoteExec ["XY_fnc_wantedRemove", 2];

_message = format["Die Fahndung nach %1 wurde von %2 aufgehoben", _name, profileName];
[1, _message ] remoteExec ["XY_fnc_broadcast", [west] ];
[0, _message ] remoteExec ["XY_fnc_broadcast"];