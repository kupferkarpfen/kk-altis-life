// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _next = time + 300;
while { true } do {
    uisleep 30;

    if( time >= _next ) then {
        _next = time + 300;

        if( (XYDB isEqualTo 2 && isServer) || (XYDB != 2 && !isServer) ) then {
            diag_log "Updating activity...";
            _uids = [];
            {
                _uid = getPlayerUID _x;
                if( (count _uid) == 17 ) then {
                    _uids pushBack _uid;
                } else {
                    diag_log format[ "<SERROR> Invalid UID for updateActivity >>%1<<", _uid ];
                };
            } forEach allPlayers;

            {
                diag_log format["updateActivity(%1)", _x];
                [ format["CALL updateActivity('%1')", _x], false, true] call XYDB_fnc_asyncCall;
                uisleep 1.5;
            } forEach _uids;
        };
    };
};