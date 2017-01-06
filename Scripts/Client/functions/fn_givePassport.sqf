// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _target = param[0, objNull, [objNull]];
if( isNull _target ) exitWith {};

private _name = profileName;
private _address = [KV_address, ""] call XY_fnc_kvsGet;
private _town = [KV_town, ""] call XY_fnc_kvsGet;
private _birthday = [KV_birthday, ""] call XY_fnc_kvsGet;
private _birthlocation = [KV_birthlocation, ""] call XY_fnc_kvsGet;
private _height = [KV_height, ""] call XY_fnc_kvsGet;
private _eyecolor = [KV_eyecolor, ""] call XY_fnc_kvsGet;

[playerSide, _name, _address, _town, _birthday, _birthlocation, _height, _eyecolor] remoteExecCall ["XY_fnc_showPassport", _target];
