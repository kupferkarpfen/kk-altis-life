// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// Retrieves item from players trunk

// _item = item to return
// _trunk = alternative trunk, default = player trunk

// Returns array of type [<INDEX>, <TRUNK_ENTRY>]
// <INDEX> = Index of original trunk entry, -1 if not found
// <TRUNK_ENTRY> = Original (modifiable) trunk entry in format [<ITEM NAME>, <COUNT>]

private _item = param[0, "", [""]];
private _trunk = param[1, XY_playerTrunk, [[]]];

private _return = [-1, []];

{
    if( (_x select 0) isEqualTo _item ) exitWith {
        _return = [_forEachIndex, _x];
    };
} forEach _trunk;

_return;