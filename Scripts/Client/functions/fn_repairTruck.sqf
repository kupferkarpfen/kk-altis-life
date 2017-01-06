// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _vehicle = cursorTarget;

if( isNull _vehicle ) exitWith {};
if( !(_vehicle isKindOf "Car" || _vehicle isKindOf "Ship" || _vehicle isKindOf "Air") ) exitWith {};
if( !("ToolKit" in items player) ) exitWith {};

if( XY_actionInUse ) exitWith {};
XY_interrupted = false;

if( !(["repair", format[ "Repariere %1", getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName") ], _vehicle] call XY_fnc_showProgress) ) exitWith {};

if( !("ToolKit" in items player) ) exitWith {
    hint "Abgebrochen";
};
if( playerSide isEqualTo civilian ) then {
    player removeItem "ToolKit";
};

_vehicle setDamage 0;

hint "Fahrzeug repariert";