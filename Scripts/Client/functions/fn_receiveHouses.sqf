// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// If it gets called on HC...
if( !hasInterface ) exitWith {};

private _houses = param[0, [], [[]]];

private _uid = getPlayerUID player;

// Houselist received before our variables initialized?
if( isNil "XY_vehicles" ) exitWith {
    _this spawn { scriptName "WaitForInitVariables";
        waitUntil { !(isNil "XY_vehicles") };
        [XY_fnc_receiveHouses, _this] call XY_fnc_unscheduled;
    };
};

if( isNil "XY_allHouses" ) then {
    XY_allHouses = [];
};

{
    private _house = _x select 0;
    if( !(_house getVariable["initialized", false]) )then {
        _house setVariable["initialized", true];

        _house setVariable["house_owner", [_x select 1, _x select 2]];

        // Initialize all untouched doors to locked state
        private _doors = getNumber(configFile >> "CfgVehicles" >> (typeOf _house) >> "numberOfDoors");
        for "_i" from 1 to _doors do {
            if( _house getVariable[ format["bis_disabled_Door_%1", _i], -1] < 0 ) then {
                _house setVariable[format["bis_disabled_Door_%1", _i], 1];
            };
        };

        // Is this my house???
        if( playerSide isEqualTo civilian && { _uid isEqualTo (_x select 1) } && { !(_house in XY_vehicles) } ) then {
            XY_vehicles pushBack _house;

            private _marker = createMarkerLocal[format["poi_house_%1", _house], getPos _house];
            _marker setMarkerTextLocal getText(configFile >> "CfgVehicles" >> (typeOf _house) >> "displayName");
            _marker setMarkerColorLocal "ColorBlue";
            _marker setMarkerTypeLocal "loc_Lighthouse";
        };
    };
    XY_allHouses pushBack _house;

} forEach _houses;