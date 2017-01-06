// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _group = param[0, grpNull, [grpNull]];
if( _group isEqualTo grpNull ) exitWith {};

private _groupID = _group getVariable["id", -1];
if( _groupID < 0 ) exitWith {};

[ format["updateGangInactive:%1", _groupID] ] call XYDB_fnc_asyncCall;

[] remoteExec ["XY_fnc_gangDisbanded", _group];