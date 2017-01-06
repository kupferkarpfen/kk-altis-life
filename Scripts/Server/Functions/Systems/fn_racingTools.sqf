// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _player = param[0, objNull, [objNull]];
private _command = param[1, "", [""]];

diag_log format["racingTools(%1)", _this];

if( _command isEqualTo "" ) exitWith {};

MUTEX_RACING call enterCriticalSection;

if( isNil "XY_leaderbord" ) then {
    XY_raceRound = 0;
    XY_leaderbord = [[]];
};

switch (_command) do {
    case "RESTART": {
        XY_leaderbord set[XY_raceRound, []];
        [0, "successfully reset current round"] remoteExec ["XY_fnc_broadcast", _player];
    };
    case "WIPE": {
        XY_leaderbord = [[]];
        XY_raceRound = 0;
        [0, "wiped leaderboard"] remoteExec ["XY_fnc_broadcast", _player];
    };
    case "ROUND": {
        private _round = param[2, -1, [-1]];
        if( _round > 0 ) then {

            XY_raceRound = _round;
            if( count XY_leaderbord < _round + 1 ) then {
                for "_i" from ((count XY_leaderbord) - 1) to _round do {
                    diag_log format["Adding round %1", _i];
                    XY_leaderbord set[_i, []];
                };

            };
            [0, format["set round counter to: %1", _round]] remoteExec ["XY_fnc_broadcast", _player];

        } else {
            [0, format["invalid round parameter: %1", _this]] remoteExec ["XY_fnc_broadcast", _player];
        };
    };
    case "PUBLISH": {

        private _sortedTopList = [XY_leaderbord select XY_raceRound, [], { _x select 1 }, "ASCEND"] call BIS_fnc_sortBy;
        private _message = format["<t color='#FF0000' size ='1.2' align='center'>BESTENLISTE</t><br/><t color='#FF0000' size ='1' align='center'>RUNDE %1</t><br/>", XY_raceRound + 1];
        private _messageUnformatted = format[ "BESTENLISTE RUNDE %1: ", XY_raceRound + 1 ];       

        for "_i" from 0 to ((count _sortedTopList) -1) do {
            if( _i > 9 ) exitWith {};
            _message = format["%1%2. %3 %4<br/>", _message, _i + 1, (_sortedTopList select _i) select 2, [(_sortedTopList select _i) select 1, "MM:SS.MS"] call BIS_fnc_secondsToString];
            _messageUnformatted = format["%1%2. %3 %4 ", _messageUnformatted, _i + 1, (_sortedTopList select _i) select 2, [(_sortedTopList select _i) select 1, "MM:SS.MS"] call BIS_fnc_secondsToString];
        };
        [1, _message] remoteExec ["XY_fnc_broadcast"];
        [0, _messageUnformatted] remoteExec ["XY_fnc_broadcast"];
    };
    case "PRINT": {

        private _sortedTopList = [XY_leaderbord select XY_raceRound, [], { _x select 1 }, "ASCEND"] call BIS_fnc_sortBy;
        private _message = "";
        for "_i" from 0 to ((count _sortedTopList) -1) do {
            if( _i > 9 ) exitWith {};
            _message = format["%1%2. %3 %4 ", _message, _i + 1, (_sortedTopList select _i) select 2, [(_sortedTopList select _i) select 1, "MM:SS.MS"] call BIS_fnc_secondsToString];
        };
        [0, _message] remoteExec ["XY_fnc_broadcast", _player];
    };
};
MUTEX_RACING call leaveCriticalSection;