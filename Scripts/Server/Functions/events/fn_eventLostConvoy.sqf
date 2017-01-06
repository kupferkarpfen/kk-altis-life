// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

diag_log "<EVENT> eventLostConvoy";
XY_allowPVPEvents = false;

private _vehicles = 4;
private _vehicleClass = "I_Truck_02_covered_F";

private _pos = [ [21036, 7348, 0], random 300, random 360, 0 ] call SHK_pos;
diag_log format["<EVENT> Checking random position: %1", _pos];

while { true } do {

    private _valid = true;
    {
        if( _pos distance _x < 1000 ) exitWith {
            diag_log format["<EVENT> Position too near to player: %1", _x];
            _valid = false;
        };
    } forEach allPlayers;

    if( _valid ) exitWith {};
    uisleep 30;
};

diag_log "<EVENT> Found valid position for event";

private _vehicleCount = 0;
// Spawn vehicles around location
while { _vehicleCount < _vehicles } do {

    private _subPos = [ _pos, random 80, random 360, 0, [0], _vehicleClass ] call SHK_pos;

    diag_log format[ "<EVENT> Spawn vehicle @ %1", _subPos ];
    private _vehicle = _vehicleClass createVehicle _subPos;

    _vehicle setVariable[ "trunk", [["goldbar", round( 10 + (random 20) )]]];
    _vehicle setVariable[ "lockpick.hardened", true, true];
    _vehicle setVariable[ "lockpick.timeout", serverTime + 720, true];
    _vehicle setVariable[ "rope.allow", false, true];
    _vehicle setVariable[ "side", civilian, true];
    _vehicle setHitPointDamage [ "HitEngine", 0.5 + random 0.5 ];
    _vehicle setHitPointDamage [ "HitLFWheel", [1, random 1] select ((random 100) > 50) ];
    _vehicle setHitPointDamage [ "HitLF2Wheel", [1, random 1] select ((random 100) > 50) ];
    _vehicle setHitPointDamage [ "HitRFWheel", [1, random 1] select ((random 100) > 50) ];
    _vehicle setHitPointDamage [ "HitRF2Wheel", [1, random 1] select ((random 100) > 50) ];
    _vehicle setDamage (0.5 + (random 0.3));
    _vehicle setDir (random 360);
    _vehicle setFuel (random 0.1);
    _vehicle lock 2;

	// Wait to test if vehicle survived the spawn...
	uisleep 15;

	if( !(alive _vehicle) ) then {
		deleteVehicle _vehicle;
	} else {
		_vehicle setVariable[ "despawn", false, true];
		_vehicleCount = _vehicleCount + 1;
	};
};

// Create global marker for crash site
private _marker = createMarker[ "poi_PVPLostConvoy", _pos ];
_marker setMarkerColor "ColorRed";
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [150, 150];
_marker setMarkerBrush "SolidBorder";

_marker = createMarker [ "poi_PVPLostConvoyText", _pos ];
_marker setMarkerColor "ColorYellow";
_marker setMarkerType "mil_marker";
_marker setMarkerText "Verlassener Konvoi";

["update"] remoteExec [ "XY_fnc_markerManager", -2 ];

[3, "Gold-Konvoi von Rebellen überfallen", "Die Mannschaften sind tot oder geflüchtet +++ Die Rebellen konnten vermutlich nicht alle Goldbarren abtransportieren +++ Die Region gilt als extrem gefährlich"] remoteExec ["XY_fnc_broadcast", civilian];