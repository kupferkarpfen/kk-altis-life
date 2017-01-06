// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _vehicle = param[0, objNull, [objNull]];
private _timeout = param[1, -1, [-1]];

diag_log format["registerVehicleForDeletion(%1)", _this];

if( _vehicle isEqualTo objNull || _timeout < 0 ) exitWith {};

uisleep _timeout;

if( !(isNull _vehicle) ) then {
    {
        diag_log format["registerVehicleForDeletion(%1) KILL %2", _this, _x];
        if( !(isPlayer _x) ) then {
            deleteVehicle _x;
        };
    } forEach (crew _vehicle);
    diag_log format["registerVehicleForDeletion(%1) KILL %2", _this, _vehicle];
    deleteVehicle _vehicle;
};