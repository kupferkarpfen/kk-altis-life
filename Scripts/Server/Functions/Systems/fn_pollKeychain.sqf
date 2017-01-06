// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private["_uid", "_side", "_vehicle"];

if( !params[
        [ "_unit",    objNull,     [objNull]     ],
        [ "_side",    sideUnknown, [sideUnknown] ]
    ]) exitWith {};

_uid = getPlayerUID _unit;
    
_keys = missionNamespace getVariable [ format["%1_KEYS_%2", _uid, _side], [] ];
_keys = _keys - [objNull];

[_keys] remoteExec ["XY_fnc_receiveKeychain", _unit];