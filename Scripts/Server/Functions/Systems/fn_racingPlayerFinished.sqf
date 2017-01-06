// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _player = param[0, objNull, [objNull]];
private _time = param[1, -1, [-1]];

diag_log format["racingPlayerFinished(%1)", _this];

if( isNull _player || _time < 0 ) exitWith {};

private _uid = getPlayerUID _player;
private _name = _player getVariable["realName", name _player];

MUTEX_RACING call enterCriticalSection;

if( isNil "XY_leaderbord" ) then {
    XY_raceRound = 0;
    XY_leaderbord = [[]];
};

private _found = false;
private _round = XY_leaderbord select XY_raceRound;
{
    if( (_x select 0) isEqualTo _uid ) exitWith {
        _found = true;
        _x set[2, _name];
        if( _time < (_x select 1) ) then {
            _x set [1, _time];
            [0, format["%1 hat eine neue Bestzeit: %2", _name, [ _time, "MM:SS.MS" ] call BIS_fnc_secondsToString]] remoteExec ["XY_fnc_broadcast"];
        };
    };
} forEach _round;

if( !_found ) then {
    _round pushBack[ _uid, _time, _name];
};

MUTEX_RACING call leaveCriticalSection;