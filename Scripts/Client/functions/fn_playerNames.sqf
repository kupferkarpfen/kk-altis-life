// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _names = param[0, [], [[]]];

if( _names isEqualTo [] ) exitWith {};

{
    private _found = false;
    private _entry = _x;

    {
        if( (_entry select 0) isEqualTo (_x select 0) ) exitWith {
            _x set [1, _entry select 1];
            _found = true;
        };

    } forEach XY_nameCache;
    
    if( !_found ) then {
        XY_nameCache pushBack _entry;
    };
    
} forEach _names;

[ "refresh" ] call XY_fnc_gangMenu;