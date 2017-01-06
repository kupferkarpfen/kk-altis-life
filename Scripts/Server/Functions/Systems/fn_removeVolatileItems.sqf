// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// Removes items from a trunk array that shouldn't get persisted: e.g. goldbars from the fed or uran stuff

diag_log format["removeVolatileItems(%1)", _this];

private _trunk = param[0, [], []];
if( _trunk isEqualTo [] ) exitWith { [] };

// Return trunk with removed volatile stuff
_trunk select {

    private _item = _x select 0;
    private _count = _x select 1;
    private _volatile = (_item isEqualTo "goldbar") || { (_item find "uran") > -1 } || { (_item find "eventItem") > -1 } || { _count < 1 };
    !(_volatile)
};