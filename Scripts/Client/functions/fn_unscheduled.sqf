// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// Shameless copied from CBA's directCall

// Executed _code unscheduled, passes _arguments

private _code = param[0, {}, [{}]];
private _argumens = _this select 1;

private ["_return"];

isNil { _return = _argumens call _code; };

if( !(isNil "_return") ) exitWith { _return };