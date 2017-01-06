// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// original by Tonic

private _vehicle = param[0, objNull, [objNull]];
if( _vehicle isEqualTo objNull || speed _vehicle >= 5 || _vehicle distance player > 10 ) exitWith {};

if( playerSide isEqualTo civilian && ((currentWeapon player != primaryWeapon player && currentWeapon player != handgunWeapon player) || currentWeapon player isEqualTo "") ) exitWith {
    hint "Ohne Waffe kriegst du niemanden aus einem Fahrzeug!";
};
if( playerSide != west && locked _vehicle != 0 ) exitWith {
    hint "Das Fahrzeug ist abgeschlossen";
};

[] remoteExec ["XY_fnc_pulloutVeh", crew _vehicle];

{
    [getPlayerUID player, 5, format ["Zieht %1 (%2) aus dem Fahrzeug @ %3", name _x, getPlayerUID _x, mapGridPosition player ]] remoteExec ["XYDB_fnc_log", XYDB];
    [getPlayerUID _x, 5, format ["Wurde von %1 (%2) aus dem Fahrzeug gezogen @ %3", profileName, getPlayerUID player, mapGridPosition player ]] remoteExec ["XYDB_fnc_log", XYDB];
} forEach (crew _vehicle);
