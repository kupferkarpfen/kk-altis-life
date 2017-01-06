// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// original by Tonic

private _unit = param[0, objNull, [objNull]];
if( _unit isEqualTo objNull || !(isPlayer _unit) ) exitWith {};

private _nearestVehicles = nearestObjects[getPosATL player, ["Car", "Ship", "Air"], 10];
if( _nearestVehicles isEqualTo [] ) exitWith {
    hint "Kein Fahrzeug in der Nähe";
};

detach _unit;
_unit setVariable["escorting", false, true];

[_nearestVehicles select 0] remoteExec ["XY_fnc_moveIn", _unit];