// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// kvsPut = key-value store put
// Puts data into the client key-value array

private _key = param[0, "", [""]];
private _value = _this select 1;

[ XY_kvs_data, _key, _value ] call XY_fnc_kvaPut;