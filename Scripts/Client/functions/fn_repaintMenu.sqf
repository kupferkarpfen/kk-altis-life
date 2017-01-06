// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _vehicle = param[0, objNull, [objNull]];
if( _vehicle isEqualTo objNull ) exitWith {};

if( _vehicle getVariable["id", -1] < 0 ) exitWith {
    hint "Mietfahrzeuge können nicht umlackiert werden";
};
if( XY_actionInUse ) exitWith {
    hint "Du bist grad anderweitig beschäftigt";
};
if( (_vehicle getVariable["side", sideUnknown]) != civilian ) exitWith {
    hint "Es können nur Zivilisten-Fahrzeuge lackiert werden";
};

if( !(createDialog "XY_dialog_repaintVehicle") ) exitWith {};

disableSerialization;

private _ctrl = (findDisplay 2300) displayCtrl 2302;
lbClear _ctrl;

{
    if( (count _x < 3) || { (call (_x select 2)) } ) then {
        private _index = _ctrl lbAdd format["%1", _x select 0];
        _ctrl lbSetValue [_index, _forEachIndex];
    };
} forEach ([typeOf _vehicle, -1, civilian] call XY_fnc_colorConfig);