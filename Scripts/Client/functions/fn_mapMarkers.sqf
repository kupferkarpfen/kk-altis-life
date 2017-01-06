// Unified script for all fractions to display special markers on the map
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// Prevent multiple instances of the same script
if( XY_mapMarkersActive ) exitWith {};
XY_mapMarkersActive = true;

sleep 0.5;

while { visibleMap || visibleGPS } do {

    XY_mapMarkersActive = true;

    private _markers = [];

    // Add danger marker around fed if charge has been placed
    if( fed_bank getVariable["chargeplaced", false] ) then {

            private _marker = createMarkerLocal [ "fed_marker_danger", visiblePosition fed_bank ];
            _marker setMarkerColorLocal "ColorRed";
            _marker setMarkerTextLocal "ACHTUNG: Schießerei";
            _marker setMarkerShapeLocal "ELLIPSE";
            _marker setMarkerSizeLocal [1000, 1000];
            _marker setMarkerBrushLocal "SolidBorder";

            _markers pushBack [ _marker, fed_bank ];

            _marker = createMarkerLocal [ format[ "%1_marker_danger_text", fed_bank ], visiblePosition fed_bank ];
            _marker setMarkerColorLocal "ColorYellow";
            _marker setMarkerTypeLocal "mil_arrow2";
            _marker setMarkerTextLocal "ACHTUNG: Schießerei";

            _markers pushBack [_marker, fed_bank];
    };

    // Add dead bodies for medics:
    if( playerSide == independent ) then {
        {
            if( !(_x getVariable ["revive", true]) && (_x getVariable ["medicRequested", false]) ) then {

                private _marker = createMarkerLocal [ format[ "%1_dead_marker", _x ], visiblePosition _x ];
                _marker setMarkerColorLocal "ColorRed";
                _marker setMarkerTypeLocal "loc_Hospital";
                _marker setMarkerTextLocal format[ "%1", (_x getVariable[ "name", "Unbekannt" ]) ];
                _markers pushBack [_marker, _x];
            };

        } forEach allDeadMen;
    };

    // Add GPS tracked vehicles
    if( XY_trackerTimeout > time && { !(isNull XY_trackerVehicle) } && { (alive XY_trackerVehicle) }  ) then {
        private _marker = createMarkerLocal [ format[ "%1_vehicle_tracker", XY_trackerVehicle ], visiblePosition XY_trackerVehicle ];
        _marker setMarkerColorLocal "ColorRed";
        _marker setMarkerTypeLocal "Mil_dot";
        _marker setMarkerTextLocal "GPS TRACKER";
        _markers pushBack [_marker, XY_trackerVehicle];
    };

    private _counter = 0;
    while { _counter < 50 && (visibleMap || visibleGPS) } do {
        // Update markers while map is visible
        {
            private _marker = _x select 0;
            private _unit = _x select 1;

            if( !isNil "_unit" && { !isNull _unit } ) then {
                _marker setMarkerPosLocal (visiblePosition _unit);
            };
        } forEach _markers;

        sleep 0.2;
        _counter = _counter + 1;
    };

    {
        deleteMarkerLocal (_x select 0);
    } forEach _markers;

};

XY_mapMarkersActive = false;