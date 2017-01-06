// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _player = param[ 0, objNull, [objNull] ];
private _group = param[ 1, grpNull, [grpNull] ];

if( isNull _player || _group isEqualTo grpNull ) exitWith {};

private _gangID = _group getVariable [ "id", -1 ];
if( _gangID < 0 ) exitWith {};

[ "log", [ format [ "selectGangBankLog:%1", _gangID ], true] call XYDB_fnc_asyncCall ] remoteExec [ "XY_fnc_gangMenu", _player ];