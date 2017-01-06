// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
// Persistent market - get resource base price

private _item = param[0, "", [""]];
if( _item isEqualTo "" ) exitWith {};

private _normPrice = -1;
{
    if( (_x select 0) isEqualTo _item ) exitWith {
        _normPrice = _x select 1;
    };
} forEach XY_marketConfiguration;

if( _normPrice < 0 ) then {
    diag_log format ["<MARKET> ERROR: No price config found for %1", _item];
    _normPrice = 5;
};

_normPrice * (([_item] call XY_fnc_sourceConfig) select 1) * XY_ssv_PB;