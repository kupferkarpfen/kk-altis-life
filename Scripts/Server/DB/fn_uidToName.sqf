// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _player = param[0, objNull, [objNull]];
private _uids = param[1, [], [[]]];

MUTEX_UIDRESOLVER call enterCriticalSection;

if( isNil "XY_uidCache" ) then {
    XY_uidCache = [];
};

private _results = [];

if( _uids isEqualTo [] ) then {

    _results = XY_uidCache;

} else {
    {
        private _uid = _x;
        private _name = "";
        // cache lookup
        {
            if( (_x select 0) isEqualTo _uid ) exitWith {
                _name = _x select 1;
            };
        } forEach XY_uidCache;

        // query database
        if( _name isEqualTo "" )then {
            private _result = [ format [ "selectNameFromUID:%1", _uid ], true] call XYDB_fnc_asyncCall;
            if( _result isEqualTo [] || { (_result select 0) isEqualTo [] } ) then {
                diag_log format["Failed to resolve UID %1", _uid];
                _name = "ERROR";
            } else {
                _name = (_result select 0) select 0;
                XY_uidCache pushBack [ _uid, _name ];
            };
        };

        _results pushBack [ _uid, _name ];

    } forEach _uids;
};

MUTEX_UIDRESOLVER call leaveCriticalSection;

[ _results ] remoteExec [ "XY_fnc_playerNames", _player ];