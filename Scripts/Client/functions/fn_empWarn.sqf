// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

disableSerialization;
if( isNull (findDisplay 3494) ) exitWith {};

if( XY_empInUse ) exitWith {
    hint "Das EMP ist in Benutzung oder der Kondensator muss sich aufladen";
};
XY_empInUse = true;

private _index = lbCurSel (2902);
private _vehicle = XY_empLastVehicles select _index;
if(isNull _vehicle) exitWith {};

if( !(_vehicle isKindOf "Air") ) exitWith {
    hint "Es können nur Luftfahrzeuge EMP'd werden!";
};
if( _vehicle getVariable["emp.active", false] ) exitWith {
    hint "Das Fahrzeug wird bereits EMP'd";
};
_vehicle setVariable ["emp.active", true, true];

[1, "<t color='#FF0000' size ='3' align='center'>EMP WARNUNG</t><br/><t color='#00FF00' size ='1' align='center'>SCHNELL LANDEN ODER FLÜCHTEN<t>"] remoteExec [ "XY_fnc_broadcast", crew _vehicle ];

for[ {_i = 0}, {_i < 5}, {_i = _i + 1} ] do {
    [_vehicle, "empwarn"] remoteExec ["say3D", crew _vehicle];
    uisleep 3.35;
};

_vehicle setVariable ["emp.warned", serverTime, true];
_vehicle setVariable ["emp.active", false, true];

uisleep 10;
XY_empInUse = false;