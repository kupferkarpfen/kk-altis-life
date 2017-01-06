// Danger marker for robbed shops/atms
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _shop = param[0, objNull, [objNull]];

if( isNull _shop ) exitWith {};

if( _shop getVariable["markerSet", false] ) exitWith {};
_shop setVariable["markerSet", true];

private _markers = [];

_marker = createMarker [ format["other_%1_marker_danger", _shop], visiblePosition _shop ];
_marker setMarkerColor "ColorRed";
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [200, 200];
_marker setMarkerBrush "SolidBorder";
_markers pushBack _marker;

_marker = createMarker [ format[ "other_%1_marker_danger_text", _shop ], visiblePosition _shop ];
_marker setMarkerColor "ColorYellow";
_marker setMarkerType "mil_arrow2";
_marker setMarkerText "ACHTUNG: Überfall";
_markers pushBack _marker;

["update"] remoteExec [ "XY_fnc_markerManager", -2 ];

// 10 minutes timeout
uisleep 600;

{
    deleteMarker _x;
} forEach _markers;

_shop setVariable["markerSet", false];