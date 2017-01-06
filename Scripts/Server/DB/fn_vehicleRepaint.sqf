// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _vehicle = param[0, objNull, [objNull]];
private _color = param[1, -1, [0]];
if( isNull _vehicle || _color < 0 ) exitWith {};

if( !(alive _vehicle) ) exitWith {};

private _vid = _vehicle getVariable["id", -1];
if(_vid < 0) exitWith {};

[format["updateVehicleColor:%1:%2", _color, _vid]] call XYDB_fnc_asyncCall;