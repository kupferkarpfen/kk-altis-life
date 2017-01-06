/*
file: fn_takeOrgans.sqf
author: [midgetgrimm] - A Grimm Life | Altis Life • Index page

taken from the same idea of robbing script by tonic
*/
// TODO: REWRITE THIS, SO IT TAKES SOME AMOUNT UNTIL THE KIDNEY CAN BE LOOTED

private _unit = cursorTarget;

if( XY_actionInUse || XY_isTazed || player getVariable["restrained", false] || (animationState player) isEqualTo "incapacitated" || !(isPlayer _unit) || _unit getVariable ["missingOrgan", false] || animationState _unit != "incapacitated" || player == _unit ) exitWith {};

if( (["kidney"] call XY_fnc_getItemCountFromTrunk) > 1 ) exitWith {
    hint "Du kannst nicht mehr als 2 Nieren tragen"
};
if( (["scalpel"] call XY_fnc_getItemCountFromTrunk) < 1 ) exitWith {
    hint "Wie willst du ohne Skalpell eine Niere entfernen?"
};
// Remove scalpel from inventory
if( !(["scalpel", 1] call XY_fnc_removeItemFromTrunk) ) exitWith {};

[getPlayerUID player, 7, format ["Hat %1 (%2) eine Niere geklaut @ %3", _unit getVariable["realName", "ERROR"], getPlayerUID _unit, mapGridPosition _unit]] remoteExec ["XYDB_fnc_log", XYDB];
[getPlayerUID _unit, 7, format ["Wurde von %1 (%2) eine Niere geklaut @ %3", profileName, getPlayerUID player, mapGridPosition player ]] remoteExec ["XYDB_fnc_log", XYDB];

XY_actionInUse = true;

// Add kidney to inventory
["kidney", 1] call XY_fnc_addItemToTrunk;

player playMove "AinvPknlMstpSnonWnonDnon_medic";
sleep 3;

_unit setVariable["missingOrgan", true, true];
XY_actionInUse = false;

private _playerMasked = [player] call XY_fnc_playerMasked;
private _otherMasked = [_unit] call XY_fnc_playerMasked;

[0, format["%1 hat %2 eine Niere geklaut", if( _playerMasked ) then { "Maskierter Schurke" } else { profileName }, if( _otherMasked ) then { "Maskiertem Opfer" } else { _unit getVariable["realName", "ERROR"] }]] remoteExec ["XY_fnc_broadcast"];

if( !_playerMasked || (random 100) < 33 ) then {
    [getPlayerUID player, "135"] remoteExec ["XY_fnc_wantedAdd", 2];
};