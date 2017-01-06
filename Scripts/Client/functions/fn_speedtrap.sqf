// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

if( playerSide != civilian ) exitWith {};

private _vehicle = objNull;
private _speedtrap = objNull;
private _speedtrapPos = [];

while { true } do {

    waitUntil { uisleep 5; _vehicle = vehicle player; _vehicle != player && { player isEqualTo (driver _vehicle) } };

    private _name = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayname");

    private _nextRefresh = time;
    private _warned = objNull;

    while { (vehicle player) isEqualTo _vehicle && player isEqualTo (driver _vehicle) } do {

        // update speedtraps?
        if( time >= _nextRefresh ) then {
            // 300kmh = 250m in 3 seconds
            _nextRefresh = time + 3;
            private _speedtraps = nearestObjects[player, ["Land_Runway_PAPI"], 300];
            _speedtrap = if( _speedtraps isEqualTo []) then { objNull } else { _speedtraps select 0 };
            _speedtrapPos = getPosASL _speedtrap;
            _speedtrapPos set[2, (_speedtrapPos select 2) + 0.5];
        };

        if( isNull _speedtrap ) then {
            uisleep 3;
        } else {

            if( _vehicle getVariable["radarwarner", false] && { _warned != _speedtrap }) then {
                _warned = _speedtrap;
                [_vehicle, "radarwarn"] remoteExec ["say3D", crew _vehicle];
                titleText["BLITZERWARNUNG", "PLAIN"];
            };

            if( _vehicle distance _speedtrap < 15 && { _speedtrap getVariable["enabled", false] } && { !(lineIntersects [eyePos player, _speedtrapPos, _vehicle, _speedtrap]) } ) then {

                private _speed = abs (speed _vehicle);
                private _limit = _speedtrap getVariable["speedlimit", 50];

                if( _speed > (_limit * 1.10) && abs(((getDir _speedtrap) mod 360) - ((getDir _vehicle) mod 360)) < 90 ) then {
                    if( sunOrMoon > 0.95 ) then {
                        titleCut [" ", "WHITE IN", 1];
                    };
                    [_speedtrap] remoteExec [ "XY_fnc_speedtrapFlash", -2 ];

                    private _wantedStatus = switch( true ) do {
                        case( _speed < _limit + 15 ): { "104" };
                        case( _speed < _limit + 30 ): { "105" };
                        case( _speed < _limit + 45 ): { "106" };
                        case( _speed < _limit + 60 ): { "107" };
                        case( _speed < _limit + 75 ): { "108" };
                        case( _speed < _limit + 90 ): { "109" };
                        case( _speed < _limit + 111 ): { "110" };
                        default { "111" };
                    };

                    [getPlayerUID player, _wantedStatus, -1, _name] remoteExec ["XY_fnc_wantedAdd", 2];
                    hint parseText format ["Du wurdest gerade geblitzt! (Limit: %1 km/h, Geschwindigkeit: %2 km/h)", round _limit, round _speed];
                    [0, format["%1 wurde geblitzt! Fahrzeug: %3, Geschwindigkeit: %2 km/h!", profileName, round _speed, _name]] remoteExec ["XY_fnc_broadcast"];

                    // sleep a moment to prevent double-triggering
                    uisleep 6;
                };
            };
        };
    };
};