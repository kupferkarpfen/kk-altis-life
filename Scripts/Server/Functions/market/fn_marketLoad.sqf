// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
// Persistent market - load script

{
    private _type = _x select 0;
    diag_log format["Loading market price and volume for %1...", _type];
    private _queryResult = [ format["selectPricelog:%1", _type], true ] call XYDB_fnc_asyncCall;

    if( !(_queryResult isEqualTo []) ) then {

        private _price = (_queryResult select 0) select 0;
        diag_log format["Price: %1", _price];
        _x set [1, _price];
        _x set [2, 0];
    };

    // Load stored volume...
    _queryResult = [ format["selectVolumelog:%1", _type], true ] call XYDB_fnc_asyncCall;
    if( !(_queryResult isEqualTo []) ) then {

        private _volume = (_queryResult select 0) select 0;
        diag_log format[ "Volume: %1", _volume ];

        {
            if( (_x select 0) isEqualTo _type ) exitWith {
                _x set [1, _volume];
            };
        } forEach XY_marketVolume;
    };

} forEach XY_marketPrices;

publicVariable "XY_marketPrices";
