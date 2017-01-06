// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// Removes item from players trunk
// Can optionally pass an alternative trunk

// _item = item to remove for
// _count = amount to remove
// _trunk = alternative trunk, default = player trunk

// Returns true if removed, otherwise false (not enough items were available)

private _item = param[0, "", [""]];
private _count = param[1, -1, [0]];
private _trunk = param[2, XY_playerTrunk, [[]]];

if( _item isEqualTo "" || _count < 1 || _trunk isEqualTo [] ) exitWith { false };

private _return = false;

private _dataset = [_item, _trunk] call XY_fnc_getItemFromTrunk;
private _index = _dataset select 0;
private _entry = _dataset select 1;

if( _index >= 0 ) then {
    // Entry exists, check amount
    private _oldCount = _entry select 1;
    if( _oldCount >= _count ) then {
        _return = true;
        if( floor(_oldCount - _count) < 1 ) exitWith {
            // Everything removed, clear entry from trunk...
            _trunk deleteAt _index;
        };
        // Reduce item count...
        _entry set [1, _oldCount - _count];
    };
};

XY_forceSaveTime = time;

_return;