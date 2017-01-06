// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _vid = param[0, -1, [0]];
private _price = param[1, -1, [0]];
private _spawnPositions = param[2, [], [[]]];
private _unit = param[3, objNull, [objNull]];
private _side = param[4, sideUnknown, [sideUnknown]];

if( _vid < 0 || _price < 0 || _spawnPositions isEqualTo [] || _unit isEqualTo objNull || _side isEqualTo sideUnknown ) exitWith {};

// Validate spawnpoints
private _spawn = [];
{
    private _objects = nearestObjects[(_x select 0), ["Car", "Ship", "Air"], 8];
    if( _objects isEqualTo [] ) exitWith {
        _spawn = _x
    };
} forEach _spawnPositions;

// Lock section for single thread access:
MUTEX_GARAGE call enterCriticalSection;

private _queryResult = [ format["selectVehicleByID:%1", _vid], true ] call XYDB_fnc_asyncCall;

// Check for possible errors
private _error = switch(true) do {
    case( (typeName _queryResult) isEqualTo "STRING" ): {
        [1, "Fehler beim Ausparken: Datenbankfehler"] remoteExec ["XY_fnc_broadcast", _unit];
        true;
    };
    case( _queryResult isEqualTo [] ): {
        [1, "Fehler beim Ausparken: Fahrzeug nicht gefunden"] remoteExec ["XY_fnc_broadcast", _unit];
        true;
    };
    case( _spawn isEqualTo [] ): {
        [1, "Fehler beim Ausparken: Spawnpunkt blockiert"] remoteExec ["XY_fnc_broadcast", _unit];
        true
    };
    default { false };
};

if( !_error ) then {

    // Update database and set vehicle active
    [format[ "updateVehicleUnpark:%1", _vid ]] call XYDB_fnc_asyncCall;

    _queryResult = _queryResult select 0;

    // Spawn vehicle on client
    [ _queryResult select 0, _spawnPositions, _price, _queryResult select 1, _vid, _side, _queryResult select 2 ] remoteExec ["XY_fnc_spawnVehicle", _unit];
};

// Unlock single-threaded section
MUTEX_GARAGE call leaveCriticalSection;