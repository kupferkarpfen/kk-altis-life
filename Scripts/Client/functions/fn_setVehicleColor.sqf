// sets the vehicle color
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _vehicle = param[0, objNull, [objNull]];
private _colorIndex = param[1, -1, [0]];
private _side = param[2, playerSide, [sideUnknown]];

if( isNull _vehicle ) exitWith {};

private _config = [typeOf _vehicle, _colorIndex, _side] call XY_fnc_colorConfig;

if( _config isEqualTo [] ) exitWith {};

{
    _vehicle setObjectTextureGlobal[_forEachIndex, _x];
} forEach (_config select 1);