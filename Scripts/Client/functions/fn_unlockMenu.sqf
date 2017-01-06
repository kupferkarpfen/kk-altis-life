// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
private["_vehicles", "_control"];

disableSerialization;
_vehicles = [ _this, 0, [], [[]] ] call BIS_fnc_param;

ctrlShow[2803, false];
ctrlShow[2830, false];
waitUntil { !isNull (findDisplay 2800) };

if( count _vehicles == 0 ) exitWith {
    ctrlSetText[2811, "Keine eingezogenen Fahrzeuge gefunden"];
};

_control = ((findDisplay 2800) displayCtrl 2802);
lbClear _control;

{
    _vehicleInfo = [_x select 1] call XY_fnc_fetchVehInfo;
    _control lbAdd (_vehicleInfo select 3);
    _control lbSetData    [ (lbSize _control) - 1, str( [_x select 1, _x select 2, _x select 3] )];
    _control lbSetPicture [ (lbSize _control) - 1, _vehicleInfo select 2];
    _control lbSetValue   [ (lbSize _control) - 1, _x select 0];
} forEach _vehicles;

ctrlShow[2810, false];
ctrlShow[2811, false];