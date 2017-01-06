// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// Retrieve all locked vehicles from database
private _unit = param[0, objNull, [objNull]];
if( _unit isEqualTo objNull ) exitWith {};

private _queryResult = ["selectLockedVehicles", true] call XYDB_fnc_asyncCall;
[_queryResult] remoteExec ["XY_fnc_unlockMenu", _unit];