// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// return true if player has mask

private _player = param [ 0, objNull, [objNull] ];

if( isNull _player || { !(alive _player) } || { !(isPlayer _player) } ) exitWith { false };

( (headgear _player) in XY_ssv_maskItems || { (goggles _player) in XY_ssv_maskItems } );