// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// Adds item to players trunk
// Can optionally pass an alternative trunk

// _item = item to add
// _count = amount to add
// _trunk = alternative trunk, default = player trunk

private _item = param[0, "", [""]];
private _count = param[1, -1, [0]];
private _trunk = param[2, XY_playerTrunk, [[]]];

if( _item isEqualTo "" || _count < 1 ) exitWith { false };

// Do not add non-existing item
if( ([_item] call XY_fnc_itemConfig) isEqualTo [] ) exitWith {};

private _dataset = [_item, _trunk] call XY_fnc_getItemFromTrunk;
if( (_dataset select 0) < 0 ) then {
    // Not existing yet, add it
    _trunk pushBack [_item, _count];
} else {
    private _trunkEnty = _dataset select 1;
    _trunkEnty set[1, (_trunkEnty select 1) + _count];
};

true;