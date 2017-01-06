// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

if( !hasInterface ) exitWith {};

private _mapInitializers = missionNamespace getVariable ["XY_mapInitializers", []];
if( _mapInitializers isEqualTo [] ) then {
    missionNamespace setVariable ["XY_mapInitializers", _mapInitializers];
};
_mapInitializers pushBack _this;

if( XY_gameRunning ) then {
    // This is a deferred initializer, maybe called from an dynamic event or something
    // Run it immediately
    call XY_fnc_runMapInitializers;
};