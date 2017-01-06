// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// Returns item count in player trunk
// Can optionally pass an alternative trunk

// _item = item to check for

private _item = param[0, "", [""]];
private _trunk = param[1, XY_playerTrunk, [[]]];
if( _item isEqualTo "" || _trunk isEqualTo [] ) exitWith { 0 };

private _entry = [_item, _trunk] call XY_fnc_getItemFromTrunk;

if( (_entry select 0) < 0 ) exitWith { 0 };
(_entry select 1) select 1;