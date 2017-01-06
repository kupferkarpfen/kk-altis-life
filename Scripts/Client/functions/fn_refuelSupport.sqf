// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

{
    if( (_x find "fuel_") isEqualTo 0 ) then {

        {
            _x setFuelCargo 0;
            _x addAction[ "Tanken", XY_fnc_refuel, "", 10, false, true, "", "(vehicle player) isEqualTo player", 3 ];
        } forEach nearestObjects[ getMarkerPos _x, ["Land_fs_feed_F", "Land_FuelStation_Feed_F"], 50 ];

    };
} forEach allMapMarkers;