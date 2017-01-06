// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// original by Tonic

private _unit = param[0, objNull, [objNull]];
if( _unit isEqualTo objNull || !(isPlayer _unit) ) exitWith {};

_unit attachTo [player, [0.1, 1.1, 0]];
_unit setVariable["escorting", true, true];
player reveal _unit;