// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _unit = param[0, objNull, [objNull]];
private _vid = param[1, -1, [0]];
private _price = param[2, -1, [0]];

if( _unit isEqualTo objNull || _vid < 0 || _price < 0 ) exitWith {};

// Lock section for single thread access:
MUTEX_GARAGE call enterCriticalSection;

private _queryResult = [ format["selectVehicleByID:%1", _vid], true ] call XYDB_fnc_asyncCall;

// Check for possible errors
private _error = switch(true) do {
    case( (typeName _queryResult) isEqualTo "STRING" ): {
        true
    };
    case( _queryResult isEqualTo [] ): {
        [1, "Fehler beim Verkaufen: Fahrzeug nicht gefunden"] remoteExec ["XY_fnc_broadcast", _unit];
        true;
    };
    default { false };
};

if( !_error ) then {

    // get first row
    _queryResult = _queryResult select 0;

    // Sell vehicle
    [format[ "updateVehicleSell:%1", _vid ]] call XYDB_fnc_asyncCall;

    // Send cash to client bank account
    [ _price, false, 2] remoteExec [ "XY_fnc_addMoney", _unit ];

    [ getPlayerUID _unit, 10, format ["Verkauft Fahrzeug %1 (%2) für %3€", getText(configFile >> "CfgVehicles" >> (_queryResult select 0) >> "displayName"), _vid, [_price] call XY_fnc_numberText] ] call XYDB_fnc_log;
};

// Unlock single-threaded section
MUTEX_GARAGE call leaveCriticalSection;