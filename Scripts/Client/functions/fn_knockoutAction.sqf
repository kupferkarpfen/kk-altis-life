// Author: Bryan "Tonic" Boardwine
// Rewritten by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _target = param[ 0, objNull, [objNull]];

if( XY_IN_SAFEZONE && playerSide isEqualTo civilian ) exitWith {
    hint parseText format[XY_hintError, "Du befindest dich in einer Safezone"];
};

if( isNull _target || { !(isPlayer _target) } || { !(_target isKindOf "Man") } || { !(alive _target) } || { player distance _target > 4 } || { (animationState _target) isEqualTo "incapacitated" } || { (animationState player) isEqualTo "incapacitated" } || { XY_isTazed } || { (player getVariable["surrender", false]) } || { (currentWeapon player != primaryWeapon player && currentWeapon player != handgunWeapon player) } || { (currentWeapon player) isEqualTo "" } ) exitWith {};

if( !((side _target) isEqualTo civilian) && { (side _target) countSide playableUnits < 4 } ) exitWith {
    hint "Es sind zu wenig Spieler in der Fraktion, bitte lasse sie in Ruhe ihre Arbeit machen";
};

[getPlayerUID player, 8, format ["Hat %1 (%2) niedergeschlagen @ %3", _target getVariable["realName", "ERROR"], getPlayerUID _target, mapGridPosition player ]] remoteExec ["XYDB_fnc_log", XYDB];
[getPlayerUID _target, 8, format ["Wurde von %1 (%2) niedergeschlagen @ %3", profileName, getPlayerUID player, mapGridPosition player ]] remoteExec ["XYDB_fnc_log", XYDB];

[player, "AwopPercMstpSgthWrflDnon_End2"] remoteExec ["XY_fnc_animSync", -2];
[player, "knockout"] remoteExecCall ["say3D", playableUnits select { isPlayer _x && { (_x distance player) < 100 } }];

[player] remoteExec ["XY_fnc_knockedOut", _target];