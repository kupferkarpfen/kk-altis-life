// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

if( playerSide != west ) exitWith {};

if( (_this select 0) getVariable["used", false] ) exitWith {
    hint "Das Notfall-Equipment wurde bereits benutzt";
};

if( XY_copLevel < 7 ) exitWith {
    hint "Mit deinem Rang darfst du das leider nicht";
};

private _action = [
	"ACHTUNG: Unbedingt beide Heli-Plätze freiräumen! Willst du das Notfall-Equipment der Polizei ausparken? Dies funktioniert nur einmal pro Server-Periode und darf nur für Banküberfälle oder Städeangriffe verwendet werden.",
    "Notfall-Equipment", 
    "AUSPARKEN", 
    "ABBRECHEN"
] call XY_fnc_showQuestionbox;

if( !_action ) exitWith {};

if( (_this select 0) getVariable["used", false] ) exitWith {};
(_this select 0) setVariable["used", true, true];

// Spawn
private _vehicle = createVehicle["B_Truck_01_box_F", getMarkerPos "cop_air_8", [], 0, "NONE"];
_vehicle setVariable ["BIS_enableRandomization", false, true];
_vehicle allowDamage false;
_vehicle lock 2;
_vehicle setDir 290;
_vehicle setVectorUp (surfaceNormal getMarkerPos "cop_air_8");
_vehicle setFuel 0;
_vehicle setVariable[ "unusable", true, true ];
_vehicle setVariable[ "owner", getPlayerUID player, true ];

clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;

_vehicle call XY_ssv_emergencyEquip;