// Market volume endpoint
// by Kupferkarpfen
// License: CC BY-NC-SA 4.0
// Receives sales from clients an calculates new prices for the resources

private _volume = param[0, [], [[]]];
private _unit = param[1, objNull, [objNull]];

if( _volume isEqualTo [] || _unit isEqualTo objNull ) exitWith {
    diag_log format[ "<MARKET> Received invalid volume %1", _this ];
};

diag_log format["<MARKET> Received volume from %1 (%2):  %3", name _unit, getPlayerUID _unit, _volume];

MUTEX_MARKET call enterCriticalSection;

{
    private _type = _x select 0;
    private _amount = _x select 1;
    private _price = _x select 2;

    [ getPlayerUID _unit, 14, format [ "Verkauft %1x %2 (%3€)", _amount, ([_type] call XY_fnc_itemConfig) select 2, [_price] call XY_fnc_numberText ] ] remoteExec ["XYDB_fnc_log", XYDB];

    // Normalize amount
    _amount = _amount * (([_type] call XY_fnc_sourceConfig) select 1);
    //

    // Store volume internally for logging purposes ---
    {
        if( (_x select 0) isEqualTo _type ) exitWith {
            _x set [1, (_x select 1) + _amount];
        };
    } forEach XY_marketVolumeLogger;

    // Store volume for processing by market change script ---
    {
        if( (_x select 0) isEqualTo _type ) exitWith {
            _x set [1, (_x select 1) + _amount];
            // Save current volume in database...
            [format["insertVolumelog:%1:%2", _type, _x select 1]] remoteExec ["XYDB_fnc_asyncCall", XYDB];
        };
    } forEach XY_marketVolume;

} forEach _volume;

MUTEX_MARKET call leaveCriticalSection;