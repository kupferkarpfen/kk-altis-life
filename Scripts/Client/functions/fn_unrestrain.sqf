// Author: Bryan "Tonic" Boardwine
// Rewritten by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _unit = param[0, objNull, [objNull]];

if( _unit isEqualTo objNull || !(_unit getVariable["restrained", false]) ) exitWith {};

_unit setVariable["restrained", false, true];
_unit setVariable["escorting", false, true];
detach _unit;

[player, "cuff"] remoteExecCall ["say3D", playableUnits select { isPlayer _x && { (_x distance player) < 100 } }];
[ 0, format[localize "STR_NOTF_Unrestrain", _unit getVariable["realName", name _unit], profileName] ] remoteExec ["XY_fnc_broadcast", [west, 2]];