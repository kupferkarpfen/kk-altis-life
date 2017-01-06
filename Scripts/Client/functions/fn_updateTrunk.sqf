// updateTrunk
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
//
// can be called to set trunk contents and update its weight

private _vehicle = param[0, objNull, [objNull] ];
private _trunkContents = param[1, [], [[]] ];
if( isNull _vehicle ) exitWith {};

_vehicle setVariable["trunk", [_trunkContents, [_trunkContents] call XY_fnc_calculateWeight ], true];