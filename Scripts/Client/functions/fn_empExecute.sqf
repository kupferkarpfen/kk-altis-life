// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

disableSerialization;
if( isNull (findDisplay 3494) ) exitWith {};

private _index = lbCurSel (2902);
private _vehicle = XY_empLastVehicles select _index;
if(isNull _vehicle) exitWith {};

if( !(_vehicle isKindOf "Air") ) exitWith {
    hint "Es können nur Luftfahrzeuge EMP'd werden!";
};
if( serverTime - (_vehicle getVariable["emp.warned", -999]) > 600 ) exitWith {
    hint "Das Fahrzeug muss erst gewarnt werden!";
};
if( XY_empInUse ) exitWith { 
    hint "Das EMP ist in Benutzung oder der Kondensator muss sich aufladen"; 
};
XY_empInUse = true;

hint "EMP wird ausgeführt, der feindliche Helikopter muss innerhalb von 400m bleiben";
(vehicle player) say3D "empsound";

[vehicle player] remoteExec ["XY_fnc_empReceive", _vehicle];

uisleep 90;

XY_empInUse = false;