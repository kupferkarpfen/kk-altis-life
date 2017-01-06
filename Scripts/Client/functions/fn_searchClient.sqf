// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _cop = param[ 0, objNull, [objNull] ];

if( isNull _cop ) exitWith {};

private _inv = [];
{
    if( _x select 5 ) then {
        private _count = [_x select 0] call XY_fnc_getItemCountFromTrunk;
        if(_count > 0) then {
            _inv pushBack [_x select 0, _count];
            [_x select 0, _count] call XY_fnc_removeItemFromTrunk;
        };
    };
} forEach XY_virtItems;

if( !(_inv isEqualTo []) ) then {
    [getPlayerUID player, "136"] remoteExec ["XY_fnc_wantedAdd", 2];
};

private _robber = false;
if( !XY_atmUsable ) then {
	XY_CC = 0;
    call XY_fnc_save;
    _robber = true;
};

[ player, _inv, _robber ] remoteExec ["XY_fnc_copSearch", _cop];