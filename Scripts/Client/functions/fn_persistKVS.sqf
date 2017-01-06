// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _saveAll = param[0, false, [false]];

private _array = [];
{
    private _entry = _x;
    {
        if( _saveAll || { (_entry select 0) isEqualTo _x } ) exitWith {
            _array pushBack _entry;
        };
    } forEach XY_kvs_modifiedKeys;
} forEach XY_kvs_data;

if( _array isEqualTo [] ) exitWith {};

XY_kvs_modifiedKeys = [];
[player, playerSide, _array] remoteExec [ "XYDB_fnc_updateKVS", XYDB ];