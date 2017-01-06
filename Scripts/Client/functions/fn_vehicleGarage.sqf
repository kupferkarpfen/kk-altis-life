// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _type = param[0, "", [""]];
private _side = param[1, sideUnknown, [sideUnknown]];
private _spawnPositions = param[2, [], [[]]];
private _condition = param[3, { true }, [{}]];

if( _type isEqualTo "" || _spawnPositions isEqualTo [] ) exitWith {};

if( !(_side isEqualTo playerSide) || !(call _condition) ) exitWith {
    hint "Das darfst du nicht";
};

XY_actionInUse = true;

XY_GM_spawns = [];
{
    if( (typeName _x)  isEqualTo "STRING" ) then {
        // Marker as spawnpoint: convert...
        XY_GM_spawns pushBack [ getMarkerPos _x, markerDir _x ];
    } else {
        XY_GM_spawns pushBack _x;
    };
} forEach _spawnPositions;

// setup preview environment
[ "init" ] call XY_fnc_showVehiclePreview;

_type spawn { scriptName "WaitForVeil";
    uisleep 1;
    [player, playerSide, _this] remoteExec ["XYDB_fnc_getVehicles", XYDB];
};