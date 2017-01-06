// placeItem
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _class = param [ 0, "", [""] ];
private _counter = param [ 1, 0, [0] ];

if( _class isEqualTo "" || _counter > 3 ) exitWith {};

XY_actionInUse = true;

private _vehicle = _class createVehicle [0, 0, 0];
_vehicle attachTo[ player, [0, 2.5, 1] ];
_vehicle setDir 180;

private _actionDeploy = player addAction["<t color='#00FF00'>Aufstellen</t>", { (_this select 3) setVariable["deployed", 1, true]; }, _vehicle, 6, false, true];
private _actionCancel = player addAction["<t color='#FF0000'>Abbrechen</t>", { (_this select 3) setVariable["deployed", 2, true]; }, _vehicle, 0, false, true];

waitUntil { _vehicle getVariable["deployed", 0] != 0 || !(alive player) };

XY_actionInUse = false;

detach _vehicle;

player removeAction _actionDeploy;
player removeAction _actionCancel;

if( _vehicle getVariable["deployed", 0] != 1 ) exitWith {
    deleteVehicle _vehicle;
};

private _pos = getPosATL _vehicle;
_vehicle setVelocity [0, 0, 0];
_vehicle setPosATL [_pos select 0, _pos select 1, 0.05];
_vehicle setVectorUp [0, 0, 1];
_vehicle allowDamage false;

if( _class isEqualTo "Land_Runway_PAPI" ) exitWith {

    // Check if other speedtraps are near
    if( (count (nearestObjects[player, ["Land_Runway_PAPI"], 300])) > 1 ) exitWith {
        hint "Es befindet sich im Umkreis von 300m schon ein Blitzer";
        deleteVehicle _vehicle;
    };

    private _supportVehicle = "Land_Stone_pillar_F" createVehicle [0, 0, 0];
    _supportVehicle setPosATL [_pos select 0, _pos select 1, -1];
    _supportVehicle setVectorUp [0, 0, 1];
    _supportVehicle setDir (getDir _vehicle);
    _supportVehicle allowDamage false;
    _supportVehicle enableSimulation false;
    _supportVehicle setVariable["deployed", 1, true];

    _vehicle setPosATL [_pos select 0, _pos select 1, 1.38];
    _vehicle enableSimulation false;
    player reveal _vehicle;
};

if( _class isEqualTo "SignAd_Sponsor_F" ) then {
    if( playerSide isEqualTo west ) then {
        _vehicle setObjectTextureGlobal [0, "images\police_checkpoint.paa"];
    };
};

// allow multiple pylons to be placed...
if( _class isEqualTo "RoadCone_L_F" ) then {
    [_class, _counter + 1] call XY_fnc_placeItem;
};