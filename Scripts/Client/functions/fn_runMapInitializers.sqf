// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

{
    private _source = _x param[0, objNull, [objNull]];
    private _simulation = _x param[1, false, [false]];
    private _code = _x param[3, {}, [{}]];

    _source allowDamage false;
    _source enableSimulation _simulation;

    [_source, _x select 2] call _code;

} forEach (missionNamespace getVariable ["XY_mapInitializers", []]);
XY_mapInitializers = [];