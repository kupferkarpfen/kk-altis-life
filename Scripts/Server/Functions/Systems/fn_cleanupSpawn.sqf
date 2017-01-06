// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _vehicle = param[0, objNull, [objNull]];

diag_log format["cleanupSpawn(%1)", _this];

if( _vehicle isEqualTo objNull ) exitWith {};

private _position = getPos _vehicle;
private _points = 0;
private _rewarded = false;

while { true } do {
    uisleep 20;

    if( !((crew _vehicle) isEqualTo []) && !_rewarded ) then {
        _points = _points - 2;
        _rewarded = true;
    };
    if( _points > 10 ) exitWith {
        private _vid = _vehicle getVariable["id", -1];
        if( _vid >= 0 ) then {
            [format["updateVehiclePark:0:%1:%2", [], _vid]] call XYDB_fnc_asyncCall;
        };
        deleteVehicle _vehicle;
    };
    if( isNull _vehicle ) exitWith {};
    if( _vehicle distance _position > 9 ) exitWith {};

    _points = _points + 1;
};