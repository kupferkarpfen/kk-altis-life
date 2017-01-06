// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private["_unit", "_side", "_vehicle", "_uid", "_keys"];

if( !params[
        [ "_unit",    objNull,     [objNull]     ],
        [ "_side",    sideUnknown, [sideUnknown] ],
        [ "_vehicle", objNull,     [objNull]     ]
    ]) exitWith {};

// vehicle alive?
if( isNull _vehicle ) exitWith {};

_uid = getPlayerUID _unit;

_keys = missionNamespace getVariable [ format["%1_KEYS_%2", _uid, _side], [] ];
_keys pushBack _vehicle;

missionNamespace setVariable[ format[ "%1_KEYS_%2", _uid, _side], _keys ];