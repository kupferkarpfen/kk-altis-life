// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// Server-side script for infection event
if( (playersNumber civilian) < 30 ) exitWith {
    diag_log "<INFECTION> Cancelling event with less than 30 civs";
};

// Array of arrays
// [ <PLAYER UID>, <INFECTION LEVEL> ]
// Infection Level = -1, 0 to N
// -1 = Immunized by medicine
// 0 = Freshly infected
// N = Minutes since infection
private _lstInfected = [];

private _doInfect = {

    private _target = param[ 0, objNull, [objNull] ];
    private _list = param[ 1, [], [[]] ];

    diag_log format["<INFECTION> Infecting %1 (%2) -> %3", _target, getPlayerUID _target, _target getVariable["realName", "ERROR"]];
    _list pushBack [getPlayerUID _target, 0];
    _target setVariable["infection.infected", true, true];
};

private _tryInfect = {

    private _target = param[ 0, objNull, [objNull] ];
    private _source = param[ 1, objNull, [objNull] ];
    private _list = param[ 2, [], [[]] ];

    if( _source isEqualTo _target ) exitWith {};
    if( (side _target) isEqualTo independent ) exitWith {};
    if( !(alive _target) ) exitWith {};
    if( _target getVariable[ "infection.infected", false ] ) exitWith {};
    if( isObjectHidden _target ) exitWith {};
    if( (random 100) < 20 ) exitWith {};

    [ _target, _list] call _doInfect;
};

// infect random people...
diag_log "<INFECTION> INITIAL INFECTION...";
while { count _lstInfected < 3 && (playersNumber civilian) >= 30 } do {
    private _player = selectRandom playableUnits;
    if( (side _player) isEqualTo civilian && { !(_player getVariable["infection.infected", false]) } ) then {
        [ _player, _lstInfected ] call _doInfect;
    };
    uisleep 5;
};
if( (count _lstInfected) < 3 ) exitWith {
    diag_log "<INFECTION> CANCELLING EVENT...";
};

// infection type:
//
private _infectionType = floor(random 4);
// 0 = Virus
// 1 = Bacteria
// 2 = Fungus
// 3 = Parasite

// Allow cancellation from admin console
XY_infectedEvent = true;
while { XY_infectedEvent } do {
    uisleep 45;
    {
        private _player = _x;
        private _uid = getPlayerUID _player;

        {
            if( _uid isEqualTo (_x select 0) && { (_x select 1) >= 0 } ) exitWith {

                // Increase infection level
                _x set [1, (_x select 1) + 1];

                // Make sure he has his proper infection level (e.g. if reconnected)
                if( !(_player getVariable["infection.infected", false]) )then {
                    _player setVariable["infection.infected", true, true];
                };
                if( !(_player getVariable["infection.type", -1] isEqualTo _infectionType) )then {
                    _player setVariable["infection.type", _infectionType, true];
                };

                _player setVariable["infection.strength", _x select 1, true];

                // Infect nearby players (only crew if in vehicle)...
                {
                    [_x, _player, _lstInfected] call _tryInfect;
                } forEach ( if( (vehicle _player) isEqualTo _player ) then { _player nearEntities ["Man", 5] } else { crew (vehicle _player) } );
            };
        } forEach _lstInfected;

    } forEach playableUnits;
    diag_log format["<INFECTION> COUNT: %1", count _lstInfected];
};