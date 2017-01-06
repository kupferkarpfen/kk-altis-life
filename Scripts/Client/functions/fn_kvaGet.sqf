// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// kvaGet = key-value (array) get
// Retrieves data from a key-value-like array

private _kvArray = param[0, [], [[]]];
private _key = param[1, "", [""]];
private _default = _this select 2;

if( _kvArray isEqualTo [] || _key isEqualTo "" ) exitWith { _default };

private _return = _default;
{
    if( (_x select 0) isEqualTo _key ) exitWith {
        _return = _x select 1;
    };
} forEach _kvArray;

_return;