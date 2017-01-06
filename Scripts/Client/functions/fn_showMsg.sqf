/*
    file: fn_showMsg.sqf
    Author: Silex
*/
// TODO: Some cleanup by Kupferkarpfen, but this shitty smartphone stuff really needs to be re-written nice and clean

private _index = param[0, -1, [0]];
if( _index < 0 ) exitWith {};

disableSerialization;
waitUntil { !isNull findDisplay 88888 };

private _display = findDisplay 88888;
private _cMessageList = _display displayCtrl 88882;
private _cMessageShow = _display displayCtrl 88887;
private _cMessageHeader = _display displayCtrl 88890;

private _data = call compile (_cMessageList lnbData[_index, 0]);

private _online = [ _data select 1 ] call XY_fnc_onlineUID;
private _status = ["[OFFLINE]", "[ONLINE]"] select _online;
ctrlEnable[887892, _online];

_cMessageHeader ctrlSetText format["%1 %2 schrieb:", _data select 0, _status];
_cMessageShow ctrlSetText format["%1", _data select 2];