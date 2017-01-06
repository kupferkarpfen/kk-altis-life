// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// No interface, no flashlights...
if( !hasInterface ) exitWith {};

private _vehicle = param[0, objNull, [objNull]];
if( isNull _vehicle ) exitWith {};

// Sleep a second to allow syncing, if remoteexec was faster than the variable...
uisleep 1;

if( !(_vehicle getVariable ["lights", false]) ) exitWith {};

private _side = _vehicle getVariable[ "side", sideUnknown ];
if( _side isEqualTo sideUnknown ) exitWith {};

private _colorLeft = switch( _side ) do {
    case west: {
        [20, 0.1, 0.1]
    };
    case independent: {
        [0.1, 0.1, 20]
    };
    default { [] };
};
private _colorRight = switch( _side ) do {
    case independent;
    case west: {
        [0.1, 0.1, 20]
    };
    default { [] };
};
if( _colorLeft isEqualTo [] || _colorRight isEqualTo [] ) exitWith {};

private _attachLeft = switch (typeOf _vehicle) do {
    case "B_Quadbike_01_F":           { [-0.30,  1.0,  -0.68] };
    case "C_Offroad_01_F":            { [-0.37,  0.00,  0.56] };
    case "C_Offroad_02_unarmed_F":    { [-0.56,  2,    -0.6 ] };
    case "C_SUV_01_F":                { [-0.37,  2.20, -0.60] };
    case "B_MRAP_01_F";
    case "B_MRAP_01_hmg_F":           { [-1.00, -2.80,  0.55] };
    case "C_Hatchback_01_F";
    case "C_Hatchback_01_sport_F":    { [-0.60,  2.00, -0.95] };
    case "I_MRAP_03_F":               { [-0.37,  0.00,  0.56] }; // << TODO: This cant be true!
    case "B_Heli_Light_01_F":         { [-0.37,  0.00,  0.56] };
    case "I_Heli_light_03_unarmed_F": { [-0.37,  0.00,  0.56] };
    case "O_MRAP_02_F":               { [-0.37,  0.00,  0.56] };
    case "B_Truck_01_transport_F":    { [-1.00, -2.80,  0.55] };
    case "C_Van_01_box_F":            { [-1.00, -0.30,  1.40] };
	case "I_Truck_02_ammo_F":         { [-1.00,  3.1,   0.57] };
	case "I_Truck_02_covered_F":      { [-1.00,  3.1,   0.57] };
	case "I_Truck_02_transport_F":    { [-1.00,  3.1,   0.57] };
    case "B_T_LSV_01_unarmed_F":      { [-0.72,  2.00, -0.99] };
    default { [] };
};
if( _attachLeft isEqualTo []) exitWith {};

private _attachRight = switch (typeOf _vehicle) do {
    case "B_Quadbike_01_F":           { [0.30,  1.0,  -0.68] };
    case "C_Offroad_01_F":            { [0.37,  0.00,  0.56] };
    case "C_Offroad_02_unarmed_F":    { [0.5,   2,    -0.61] };
    case "C_SUV_01_F":                { [0.37,  2.20, -0.60] };
    case "B_MRAP_01_F";
    case "B_MRAP_01_hmg_F":           { [1.00, -2.80,  0.55] };
    case "C_Hatchback_01_F";
    case "C_Hatchback_01_sport_F":    { [0.60,  2.00, -0.95] };
    case "I_MRAP_03_F":               { [0.37,  0.00,  0.56] }; // << TODO: This cant be true!
    case "B_Heli_Light_01_F":         { [0.37,  0.00,  0.56] };
    case "I_Heli_light_03_unarmed_F": { [0.37,  0.00,  0.56] };
    case "O_MRAP_02_F":               { [0.37,  0.00,  0.56] };
    case "B_Truck_01_transport_F":    { [1.00, -2.80,  0.55] };
    case "C_Van_01_box_F":            { [1.00, -0.30,  1.40] };
    case "I_Truck_02_ammo_F":         { [1.00,  3.1,   0.57] };
    case "I_Truck_02_covered_F":      { [1.00,  3.1,   0.57] };
    case "I_Truck_02_transport_F":    { [1.00,  3.1,   0.57] };
    case "B_T_LSV_01_unarmed_F":      { [0.72,  2.00, -0.99] };
	
    default { [] };
};
if( _attachRight isEqualTo []) exitWith {};

private _left = "#lightpoint" createVehicleLocal (getPos _vehicle);
_left lightAttachObject [_vehicle, _attachLeft];
_left setLightColor _colorLeft;
_left setLightBrightness 0.2;
_left setLightAmbient _colorLeft;
_left setLightAttenuation [0.181, 0, 1000, 130];
_left setLightIntensity 10;
_left setLightFlareSize 0.4;
_left setLightFlareMaxDistance 150;
_left setLightUseFlare true;
_left setLightDayLight true;

private _right = "#lightpoint" createVehicleLocal (getPos _vehicle);
_right lightAttachObject [_vehicle, _attachRight];
_right setLightColor _colorRight;
_right setLightBrightness 0.2;
_right setLightAmbient _colorRight;
_right setLightAttenuation [0.181, 0, 1000, 130];
_right setLightIntensity 10;
_right setLightFlareSize 0.4;
_right setLightFlareMaxDistance 150;
_right setLightUseFlare true;
_right setLightDayLight true;

while { alive _vehicle && _vehicle getVariable["lights", false] } do {

    if( player distance _vehicle < 500 ) then {

        _brightness = [2, 20] select (sunOrMoon isEqualTo 1);

        _right setLightBrightness 0;
        uisleep 0.05;
        _left setLightBrightness _brightness;
        uisleep 0.3;

        _left setLightBrightness 0;
        uisleep 0.05;
        _right setLightBrightness _brightness;
        uisleep 0.3;

    } else {
        uisleep 5;
    };
};

deleteVehicle _left;
deleteVehicle _right;