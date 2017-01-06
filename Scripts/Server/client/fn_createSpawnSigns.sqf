// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

uisleep 30;

if( !(playerSide isEqualTo civilian) ) exitWith {};

diag_log "XY_fnc_createSpawnSigns";

XY_SS_POSITIONS = [];

// AirService North
XY_SS_POSITIONS pushBack ["spawn5", [
    [9293.69, 21316.5, 0],
    [9382.37, 21866.1, 0],
    [7964.91, 21305.9, 0],
    [9017.82, 21303, 0],
    [9330.49, 21147.3, 0],
    [9266.86, 22169.9, 0],
    [9942.3, 20766.7, 0]
]];

// Kavala North
XY_SS_POSITIONS pushBack ["spawn6", [
    [5693.97, 15317, 0],
    [5302.18, 15319.5, 0],
    [4579.5, 15383.6, 0],
    [5326.6, 14888.2, 0],
    [5934.16, 14894.8, 0],
    [5923.17, 15292.3, 0]
]];

// Pyrgos East
XY_SS_POSITIONS pushBack ["spawn7", [
    [18189.8, 12850.6, 0],
    [18312.5, 13122.3, 1.22],
    [18140.7, 12244.7, 0],
    [18545.2, 12297.3, 0],
    [18794, 12759.2, 0],
    [18208.2, 13825.1, 0]
]];

// Paros
XY_SS_POSITIONS pushBack ["spawn8", [
    [20827.4, 17460.7, 0],
    [20782.8, 17356.4, 0],
    [20097.3, 16994.8, 0],
    [21227.7, 17523.2, 0],
    [21368.8, 17757, 0],
    [20405.5, 16874.7, 0]
]];

while { true } do {

    {
        if( !([_x select 0] call XY_fnc_hasLicense) ) then {

            private _licenseName = _x select 0;
            private _positions = _x select 1;

            private _position = selectRandom _positions;

            private _sign = "Land_InfoStand_V2_F" createVehicleLocal [0, 0, 0];
            _sign setPos _position;
            _sign setDir (random 360);
            _sign allowDamage false;
            _sign enableSimulation false;

            private _license = [];
            {
                if( (_x select 0) isEqualTo _licenseName ) exitWith {
                    _license = _x;
                };
            } forEach XY_spawnLicenses;

            if( _license isEqualTo [] ) exitWith {};

            _sign addAction[ format["%1 (%2€)", _license select 2, [_license select 3] call XY_fnc_numberText], { [_this select 3] call XY_fnc_buyLicense; if( ([_this select 3] call XY_fnc_hasLicense) ) then { deleteVehicle (_this select 0); }; }, _licenseName, 0, false, true, "", format["!license_%1 && playerSide isEqualTo civilian && (vehicle player) isEqualTo player", _licenseName], 3];
            [_x, _sign] spawn { scriptName "RemoveSign";
                uisleep 5400;

                if( (getPlayerUID player) isEqualTo "76561197970371465" ) then {
                  systemChat format["Deleted sign %1", (_this select 0) select 0];
                  deleteMarkerLocal format["position_%1", (_this select 0) select 0];
                };
                if( !(isNull (_this select 1)) ) then {
                    XY_SS_POSITIONS pushBack (_this select 0);
                    deleteVehicle (_this select 1);
                };
            };

            if( (getPlayerUID player) isEqualTo "76561197970371465" ) then {
                private _marker = createMarkerLocal[format["position_%1", _licenseName], _position];
                _marker setMarkerColorLocal "ColorYellow";
                _marker setMarkerTypeLocal "mil_marker";
                _marker setMarkerTextLocal format["POS %1", _licenseName];
                systemChat format["Spawned Sign %1", _licenseName];
            };

            XY_SS_POSITIONS deleteAt _forEachIndex;
        };
    } forEach XY_SS_POSITIONS;

    uisleep 600;
};
