// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// Function to rotate camera around an object
// Automatically terminates when object gets deleted

// parameters:
// _object = object to rotate around
// _light = create artificial (local) light? (default = true)
// _offset = relative position to object in [x,y,z] (default = [30, 30, 15])
// _fov = FOV ( default: 0.6 )
// _speed = rotation speed in degrees per second ( default: 12 )

private _object = param[0, objNull, [objNull]];
private _light = param[1, true, [false]];
private _offset = param[2, [30, 30, 15], [[]]];
private _fov = param[3, 0.6, [0]];
private _speed = param[4, 12, [0]];

if( _object isEqualTo objNull ) exitWith {};

private _objectPos = getPos _object;

private _cameraLight = "#lightpoint" createVehicleLocal [ _objectPos select 0, _objectPos select 1, 200 ];
if( _light ) then {
    _cameraLight setLightBrightness 125;
    _cameraLight setLightAmbient [1, 0.9, 0.7];
    _cameraLight setLightColor [1, 0.9, 0.7];
};

private _camera = "CAMERA" camCreate _objectPos;
_camera cameraEffect ["internal", "BACK"];
_camera camSetFov _fov;

showCinemaBorder true;

private _rotation = 0;
private _lastTime = time;

while { !(isNull _object) } do {

    private _timePassed = time - _lastTime;
    private _mod = _speed * _timePassed;
    _lastTime = time;

    _rotation = _rotation + _mod;
    if( _rotation > 360 ) then {
        _rotation = 0;
    };

    _camera camSetTarget _object;
    _camera camSetRelPos [ (_offset select 0) * (sin _rotation), (_offset select 1) * (cos _rotation), _offset select 2];

    // If object did a significant move we do an instant commit to prevent lagging
    _camera camCommit ( if( _objectPos distance _object > 100 ) then { 0 } else { 0.1 } );
    _objectPos = getPos _object;

    uisleep 0.05;
};

_camera cameraEffect ["TERMINATE", "BACK"];
camDestroy _camera;

deleteVehicle _cameraLight;