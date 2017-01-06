// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private["_vehicle", "_state"];

_vehicle = [ _this, 0, objNull, [objNull]  ] call BIS_fnc_param;
_state =   [ _this, 1, 3,       [0]        ] call BIS_fnc_param;

if(isNull _vehicle) exitWith {};

_vehicle lock _state;