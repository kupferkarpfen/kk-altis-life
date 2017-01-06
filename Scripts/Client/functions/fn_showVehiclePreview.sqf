// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// Function to display a vehicle with a nice rotating camera effect

private _mode = param[0, "", [""]];

if( _mode isEqualTo "init" ) exitWith {

    XY_previewCameraVehicle = nil;
    XY_previewCameraVeil = true;
    XY_previewCameraFocusObject = "Land_HelipadEmpty_F" createVehicleLocal [0,0,0];
    XY_previewCameraFocusObject setPosATL XY_vehiclePreviewPos;
    XY_previewCameraFocusObject enableSimulation false;
    XY_previewCameraFocusObject allowDamage false;

    0 cutText["Einen Moment...", "BLACK OUT", 1];
};
if( _mode isEqualTo "exit" ) exitWith {

    0 cutText["", "PLAIN", 1];

    if( !(isNil "XY_previewCameraVehicle") ) then {
        deleteVehicle XY_previewCameraVehicle;
    };

    if( XY_previewCameraVeil ) then {
        0 cutText["", "BLACK IN", 1];
    };
    XY_previewCameraVehicle = nil;
    XY_previewCameraVeil = nil;

    deleteVehicle XY_previewCameraFocusObject;
};

if( _mode isEqualTo "update" ) exitWith {

    private _vehicle = param[1, "", [""]];
    private _color = param[2, -1, [-1]];

    if( _vehicle isEqualTo "" || _color < 0 ) exitWith {};

    if( !(isNil "XY_previewCameraVehicle") ) then {
        // Check if we just have to re-skin...

        if( !(_vehicle isEqualTo (typeOf XY_previewCameraVehicle)) )then {
            deleteVehicle XY_previewCameraVehicle;
            XY_previewCameraVehicle = nil;
        };
    };

    if( isNil "XY_previewCameraVehicle" ) then {
        XY_previewCameraVehicle = _vehicle createVehicleLocal [0, 0, 0];
        XY_previewCameraVehicle enableSimulation false;
        XY_previewCameraVehicle setDir XY_vehiclePreviewDir;
        XY_previewCameraVehicle setPosATL XY_vehiclePreviewPos;
    };
    [XY_previewCameraVehicle, _color] call XY_fnc_setVehicleColor;

    if( XY_previewCameraVeil ) then {
        XY_previewCameraVeil = false;

        [XY_previewCameraFocusObject] spawn XY_fnc_rotatingCamera;
        [] spawn { scriptName "VeilLifter";
            uisleep 0.33;
            0 cutText["", "BLACK IN", 1];
        };
    };
};