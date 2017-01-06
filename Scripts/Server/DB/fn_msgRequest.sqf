// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _player = param[0, objNull, [objNull]];
if( isNull _player ) exitWith {};

[1, [format["selectMessages:%1", getPlayerUID _player], true] call XYDB_fnc_asyncCall] remoteExec ["XY_fnc_smartphone", _player];
