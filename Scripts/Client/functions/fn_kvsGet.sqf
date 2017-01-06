// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// kvsGet = key-value get
// Retrieves data from a the client key-value array

private _key = param[0, "", [""]];
private _default = _this select 1;

[ XY_kvs_data, _key, _default ] call XY_fnc_kvaGet;