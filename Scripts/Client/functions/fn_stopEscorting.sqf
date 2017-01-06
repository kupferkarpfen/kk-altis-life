// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// original by Tonic

private _unit = param[0, objNull, [objNull]];
if( _unit isEqualTo objNull || !(_unit getVariable ["escorting", false]) ) exitWith {};

detach _unit;
_unit setVariable["escorting", false, true];