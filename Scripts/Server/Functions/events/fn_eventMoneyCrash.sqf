// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _crates = 60;
private _spread = 500;

diag_log "<EVENT> eventMoneyCrash";
XY_allowPVPEvents = false;

private _locations = [];
_locations pushBack [18800, 7500, 0];
_locations pushBack [19300, 6600, 0];
_locations pushBack [20600, 6700, 0];
_locations pushBack [21900, 7500, 0];

private _pos = [];

while { _pos isEqualTo [] } do {

    _pos = [ selectRandom _locations, random 800, random 360, 1 ] call SHK_pos;
    // Check if there are players nearby...
    diag_log format["<EVENT> Checking random position: %1", _pos];

    private _valid = true;
    {
        if( _pos distance (getMarkerPos _x) < 500 ) exitWith {
            diag_log format["<EVENT> Position too near to marker: %1", _x];
            _valid = false;
        };
    } forEach allMapMarkers;

    {
        if( _pos distance _x < 500 ) exitWith {
            diag_log format["<EVENT> Position too near to player: %1", _x];
            _valid = false;
        };
    } forEach allPlayers;

    if( !(_valid) ) then {
        _pos = [];
        uisleep 30;
    };
};

diag_log "<EVENT> Found valid position for crate";
// Spawn boxes within x meters around location

for [ {_i = 0}, {_i < _crates}, { _i = _i + 1} ] do {

    private _subPos = [ _pos, 10 + (random _spread), random 360, 1 ] call SHK_pos;
    _subPos = [ _subPos select 0, _subPos select 1, (getTerrainHeightASL _pos) + 0.15 ];
    diag_log format[ "<EVENT> Spawn box @ %1", _subPos ];
    private _box = "Land_Ammobox_rounds_F" createVehicle _subPos;
    _box setVariable["money", round(800 + (random 1000)), true];
    uisleep 1;
};

// Create global marker for crash site
private _marker = createMarker[ "poi_PVPMoneyCrash", _pos ];
_marker setMarkerColor "ColorRed";
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [500, 500];
_marker setMarkerBrush "SolidBorder";

_marker = createMarker [ "poi_PVPMoneyCrashText", _pos ];
_marker setMarkerColor "ColorYellow";
_marker setMarkerType "mil_marker";
_marker setMarkerText "Absturzstelle";

["update"] remoteExec [ "XY_fnc_markerManager", -2 ];

private _chopper = "B_Heli_Transport_03_F" createVehicle _pos;
_chopper setVariable[ "despawn", false, true];
_chopper setDamage 1;

[3, "Geldtransport für Altis Zentralbank abgestürzt", "Geldkisten um Absturzstelle verstreut +++ Schatzsucher sind bereits vor Ort +++ Halten Sie sich von der Absturzstelle fern, die Situation ist gefährlich"] remoteExec ["XY_fnc_broadcast", civilian];