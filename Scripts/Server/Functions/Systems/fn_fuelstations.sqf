// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

diag_log "<FUEL> Marking fuel feeds";
{
    diag_log format[ "<FUEL> Marking fuel feed %1", _x ];
    private _marker = createMarker[ format["fuel_%1", _x], _x];
    _marker setMarkerShape "ICON";
    _marker setMarkerType "loc_Fuelstation";
    _marker setMarkerColor "ColorOrange";   

} forEach [
    [14173, 16542, 0],
    [16872, 15477, 0],
    [15781, 17453, 0],
    [15297, 17566, 0],
    [17417, 13937, 0],
    [16751, 12513, 0],
    [12028, 15830, 0],
    [11832, 14156, 0],
    [14221, 18303, 0],
    [9026, 15729, 0],
    [20785, 16666, 0],
    [19961, 11455, 0],
    [9206, 12112, 0],
    [8482, 18261, 0],
    [6798, 15562, 0],
    [6199, 15081, 0],
    [23379, 19799, 0],
    [5023, 14430, 0],
    [21230, 7117, 0],
    [5769, 20086, 0],
    [4001, 12592, 0],
    [3758, 13486, 0],
    [25701, 21373, 0]
];
/*

// Use this to generate fuel station list:
{   
    private _fuelStation = _x;
    private _shouldMark = true;
    {
        if( (getMarkerPos _x) distance _fuelStation < 50 && { (_x find "fuel_") isEqualTo 0 } ) exitWith {
            _shouldMark = false;
        };
    } forEach allMapMarkers;
    
    if( _shouldMark ) then {
        private _pos = getPos _fuelStation;
        diag_log format["[%1, %2, 0],", round(_pos select 0), round(_pos select 1)];
        createMarker[ format["fuel_%1", _x], _x];
    };		
} forEach nearestObjects [ [15000, 15000, 0], ["Land_fs_feed_F", "Land_FuelStation_Feed_F"], 30000];
*/