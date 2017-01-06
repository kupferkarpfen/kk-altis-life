// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
//
// calculate weight of a [[itemname, itemcount], ...] array
//
// Parameters:
// _trunk = trunk-style array (optional, default = playertrunk)

private _trunk = param[ 0, XY_playerTrunk, [[]] ];

private _weight = 0;
{
    _weight = _weight + ((([_x select 0] call XY_fnc_itemConfig) select 1) * (_x select 1));
} forEach _trunk;

_weight;