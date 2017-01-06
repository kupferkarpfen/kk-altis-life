// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
// Persistent wanted list - load script

private _i = 0;
private _interval = 20;

while { true } do {

    private _entries = [ format["selectWantedEntries:%1:%2", _i, _interval], true] call XYDB_fnc_asyncCall;
    if( _entries isEqualTo [] ) exitWith {};

    _i = _i + _interval;

    {
        private _uid = _x select 0;

        private _array = [];
        {
            if( (_x select 0) isEqualTo _uid ) exitWith {
                _array = _x select 1;
            };
        } forEach XY_wantedList;

        if( _array isEqualTo [] ) then {
            // First entry:
            XY_wantedList pushBack [ _x select 0, _array ];
        };

        _array pushBack [ _x select 1, _x select 2 ];

    } forEach _entries;
};