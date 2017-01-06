// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _vehicle = param[ 0, objNull, [objNull] ];
private _impound = param[ 1, false,   [false]   ];
private _unit =    param[ 2, objNull, [objNull] ];
private _lock =    param[ 3, false,   [false]   ];

if( isNull _vehicle || isNull _unit ) exitWith {};

_fncImpound = {

    private _vehicle = _this select 0;
    private _lock = _this select 1;

    private _vid = _vehicle getVariable["id", -1];

    if( _vid >= 0 ) then {
        _vehicle setVariable["trunk", []];
        [_vehicle] call XYDB_fnc_updateVehicle;
        [format[ "updateVehiclePark:%1:%2:%3", [0, 1] select _lock, [], _vid ]] call XYDB_fnc_asyncCall;
    };
    deleteVehicle _vehicle;
};

if( !(isNull _vehicle) ) then {

    private _vid = _vehicle getVariable["id", -1];
    private _owner = _vehicle getVariable["owner", ""];
    if( _vehicle getVariable["unusable", false] ) then {
        _impound = true;
    };

    if( _impound ) then {

        [_vehicle, _lock] call _fncImpound;

    } else {
        private _message = [XY_hintH1];
        if( _vid >= 0 ) then {
            if( _owner isEqualTo (getPlayerUID _unit) ) then {
                [_vehicle, _lock] call _fncImpound;
                _message set [1, "Das Fahrzeug wurde in der Garage geparkt"];
            } else {
                _message set [1, "Das Fahrzeug gehört nicht dir und kann deshalb nicht in der Garage geparkt werden"];
            };
        } else {
            _message set [1, "Mietwagen können nicht in der Garage geparkt werden"];
        };
        [1, format _message] remoteExec ["XY_fnc_broadcast", _unit];
    };
};

[] remoteExec ["XY_fnc_resetImpoundVars", _unit];