// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

diag_log "Saving game...";
// Important: Save clones of array, not the original !

// Update KVS from local variables...
[KV_cash, round XY_CC] call XY_fnc_kvsPut;
[KV_bank, round XY_CA] call XY_fnc_kvsPut;

if( playerSide isEqualTo civilian ) then {
    [KV_arrested, XY_isArrested] call XY_fnc_kvsPut;
};

if( playerSide in [west, civilian] ) then {
    [KV_karma, XY_karma] call XY_fnc_kvsPut;
};

[KV_gear, if( call XY_fnc_isAlive ) then { getUnitLoadout player } else { call XY_fnc_getDefaultLoadout }] call XY_fnc_kvsPut;

[KV_trunk, +XY_playerTrunk] call XY_fnc_kvsPut;

private _licenses = [];
{
    private _name = _x select 0;
    if( [_name] call XY_fnc_hasLicense ) then {
        _licenses pushBack _name;
    };
} forEach (XY_licenses + XY_training + XY_spawnLicenses);

[ KV_licenses, _licenses ] call XY_fnc_kvsPut;

[] call XY_fnc_persistKVS;