// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// Server-side "realtime" clock, useful for various occassions

XY_RTC_HOUR = 0;
XY_RTC_MINUTE = 0;
XY_RTC_SECOND = 0;
// Day of week (1 = Sunday, 2 = Monday, ..., 7 = Saturday).
XY_RTC_DAYOFWEEK = 0;
XY_RTC_LASTUPDATE = 0;
// Remaining minutes until restart
XY_RTC_REMAININGMINUTES = 4 * 60;

XY_fnc_updateRTC = {
    private _result = (["selectRTC", true] call XYDB_fnc_asyncCall) select 0;
    XY_RTC_HOUR = _result select 0;
    XY_RTC_MINUTE = _result select 1;
    XY_RTC_SECOND = _result select 2;
    XY_RTC_DAYOFWEEK = _result select 3;
    XY_RTC_LASTUPDATE = time;
    diag_log format["<RTC> AFTER UPDATE %1:%2:%3 - Day of week: %4", XY_RTC_HOUR, XY_RTC_MINUTE, XY_RTC_SECOND, XY_RTC_DAYOFWEEK];
};
call XY_fnc_updateRTC;

"XY_RTC" spawn { scriptName _this;

    private _announces = [ 120, 60, 30, 15, 5 ];

    // TODO: This doesn't work when there isn't a 0am shutdown, but I'm lazy and so it's Future-Kupferkarpfens problem
    private _nextShutdown = 0;
    {
        if( XY_RTC_HOUR < _x ) exitWith {
            _nextShutdown = _x;
        };
    } forEach [ 6, 12, 16, 20 ];
    diag_log format["<RTC> Next shutdown: %1", _nextShutdown];

    private _nextCorrection = time + 600;

    while {true} do {

        private _time = time;
        private _diff = _time - XY_RTC_LASTUPDATE;
        XY_RTC_LASTUPDATE = _time;

        // if we have a monster lag we theoretically could skip a few minutes, so just to be sure, allow it...
        XY_RTC_SECOND = XY_RTC_SECOND + _diff;
        while { XY_RTC_SECOND >= 60 } do {
            XY_RTC_SECOND = XY_RTC_SECOND - 60;
            XY_RTC_MINUTE = XY_RTC_MINUTE + 1;
        };
        while { XY_RTC_MINUTE >= 60 } do {
            XY_RTC_MINUTE = XY_RTC_MINUTE - 60;
            XY_RTC_HOUR = XY_RTC_HOUR + 1;
        };
        if( XY_RTC_HOUR >= 24 ) then {
            XY_RTC_HOUR = XY_RTC_HOUR - 24;
            XY_RTC_DAYOFWEEK = XY_RTC_DAYOFWEEK + 1;
        };
        if( XY_RTC_DAYOFWEEK > 7 ) then {
            XY_RTC_DAYOFWEEK = 0;
        };

        if( _nextCorrection <= time ) then {
            _nextCorrection = time + 600;
            diag_log format["<RTC> BEFORE UPDATE %1:%2:%3 - Day of week: %4", XY_RTC_HOUR, XY_RTC_MINUTE, XY_RTC_SECOND, XY_RTC_DAYOFWEEK];
            call XY_fnc_updateRTC;
        };

        // check if we can announce a shutdown...
        private _remainingHours = _nextShutdown - XY_RTC_HOUR;
        if( _remainingHours < 0 ) then {
            _remainingHours = _remainingHours + 24;
        };
        private _remainingMinutes = (_remainingHours * 60) - XY_RTC_MINUTE;
        XY_RTC_REMAININGMINUTES = _remainingMinutes;
        
        if( isNil "XY_RTC_SHUTDOWNTIME" ) then {
            // broadcast server shutdown time
            XY_RTC_SHUTDOWNTIME = time + (_remainingMinutes * 60);
            publicVariable "XY_RTC_SHUTDOWNTIME";
        };

        if( _remainingMinutes in _announces ) then {
            diag_log format["<RTC> Announce time until shutdown: %1 %2", _remainingHours, _remainingMinutes];
            _announces = _announces - [_remainingMinutes];
            [_remainingMinutes] remoteExec[ "XY_fnc_announceRestart", -2 ];
        };
        
        uisleep 15;
    };
};