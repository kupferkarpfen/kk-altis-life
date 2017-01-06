// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _building = param[0, objNull, [objNull]];
if( _building isEqualTo objNull ) exitWith { [] };

private _restricted = switch( typeOf _building ) do {
    case "Land_i_House_Big_02_V1_F": {  [0, 1, 2, 3, 4] };
    case "Land_i_House_Big_02_V2_F": { [0, 1, 2, 3, 4] };
    case "Land_i_House_Big_02_V3_F": { [0, 1, 2, 3, 4] };
    case "Land_i_House_Big_01_V1_F": { [2, 3] };
    case "Land_i_House_Big_01_V2_F": { [2, 3] };
    case "Land_i_House_Big_01_V3_F": { [2, 3] };
    case "Land_i_Stone_HouseSmall_V1_F": { [0, 1, 3, 4] };
    case "Land_i_Stone_HouseSmall_V2_F": { [0, 1, 3, 4] };
    case "Land_i_Stone_HouseSmall_V3_F": { [0, 1, 3, 4] };
    default { [] };
};

private _return = [];
{
    if( !(_forEachIndex in _restricted) ) then {
        _return pushBack _x;
    };
} forEach (_building buildingPos -1);

_return;