// log client fps to database
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _player = param[0, objNull, [objNull]];
private _fps = param[1, -1, [0]];

if( _player isEqualTo objNull || _fps < 0 ) exitWith {};

[ format[ "insertFpsLog:%1:%2:%3", _fps, getPlayerUID _player, mapGridPosition _player ] ] call XYDB_fnc_asyncCall;