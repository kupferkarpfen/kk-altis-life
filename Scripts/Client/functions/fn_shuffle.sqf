// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// shuffle an array
// NOTE: the original array gets emptied during this process
// pass a copy if you don't like this :)

private _array = param[0, [], [[]]];

private _return = [];
private _count = count _array;
while { _count > 0 } do {
    private _random = floor (random _count);
    _count = _count - 1;

    _return pushBack (_array select _random);
    _array set[ _random, -1];
    _array = _array - [-1];
};

_return;