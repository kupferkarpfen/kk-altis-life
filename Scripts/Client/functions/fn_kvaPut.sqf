// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// kvaPut = key-value (array) put
// Puts data into an key-value-like array

// returns [] if key didn't exist yet
// returns [ INDEX, OLD VALUE] if key existed

// key-value store does not support removing entries, this has to be done in the database during server restarts with a simple DELETE WHERE key = "..."

private _kvArray = param[0, [], [[]]];
private _key = param[1, "", [""]];
private _value = _this select 2;

private _modified = false;

private _return = [];
{
    if( (_x select 0) isEqualTo _key ) exitWith {
        _return = [ _forEachIndex, _x select 1 ];
        if( !((_x select 1) isEqualTo _value) )then {
            _modified = true;
            _x set[1, _value];
        };
    };
} forEach _kvArray;

if( _return isEqualTo [] ) then {
    _modified = true;
    _kvArray pushBack [_key, _value];
};

if( _modified && { !(_key in XY_kvs_modifiedKeys) } ) then {
    XY_kvs_modifiedKeys pushBack _key;
};

_return;