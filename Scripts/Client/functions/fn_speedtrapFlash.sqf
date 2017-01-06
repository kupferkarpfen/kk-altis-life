// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// No interface, no flashlight...
if( !hasInterface ) exitWith {};

private _speedtrap = param[0, objNull, [objNull]];
if( isNull _speedtrap ) exitWith {};

if( player distance _speedtrap > 2000 ) exitWith {};

private _pos = getPos _speedtrap;
_pos set[2, (_pos select 2) + 0.5];

private _light = "#lightpoint" createVehicleLocal _pos;
_light setLightColor [230, 255, 192];
_light setLightBrightness 150;
_light setLightAmbient [230, 255, 192];
_light setLightAttenuation [0.181, 0, 1000, 130];
_light setLightIntensity 50;
_light setLightFlareSize 1;
_light setLightFlareMaxDistance 150;
_light setLightUseFlare true;
_light setLightDayLight true;

uisleep 0.333;

deleteVehicle _light;