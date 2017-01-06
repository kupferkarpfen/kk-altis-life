// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _name = param[0, "", [""]];
private _default = param[1, false, [false]];

if( _name isEqualTo "" ) exitWith {};

missionNamespace getVariable [ format["license_%1", _name], _default]