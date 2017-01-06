// Seize objects
// by Kupferkarpfen
// License: CC BY-NC-SA 4.0

if( playerSide != west ) exitWith {};

private _counter = 0;
{
	_counter = _counter + 1;
	deleteVehicle _x;
} forEach (nearestObjects[player, ["WeaponHolder", "WeaponHolderSimulated", "GroundWeaponHolder"], 3]);

hint format["%1 Objekt%2 beschlagnahmt", _counter, ["", "e"] select (_counter == 1)];