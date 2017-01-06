// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _unit = param[0, objNull, [objNull]];
if( _unit isEqualTo objNull ) exitWith {};

if( XY_actionInUse ) exitWith {};
XY_actionInUse = true;

hint "Durchsuche Person...";

uisleep 2;
if( player distance _unit > 4 || !(alive player) || !(alive _unit) ) exitWith {
    hint "Diese Person kann nicht durchsucht werden"
};
[player] remoteExec ["XY_fnc_searchClient", _unit];