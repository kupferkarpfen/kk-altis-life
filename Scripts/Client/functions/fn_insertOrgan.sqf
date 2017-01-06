// insertOrgan
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _unit = param[0, objNull, [objNull]];
if( isNull _unit ) exitWith {};

if( !(_unit getVariable ["missingOrgan", false]) ) exitWith {};

// check if target is on "operation table"
if( _unit distance (nearestObject [_unit, "Land_Sun_chair_green_F"]) > 3 || !((animationState _unit) isEqualTo "amovppnemstpsnonwnondnon") ) exitWith {
    hint "Dein Patient muss auf einem OP-Tisch (grüne Sonnenliege) liegen, damit du ihm eine neue Niere einbauen kannst";
};

hint "Niere wird eingesetzt...";
_unit setVariable ["missingOrgan", false, true];

// TODO: I know this is lame. Make this nicer and with more RP required!
player playMove "AinvPknlMstpSnonWnonDnon_medic";
sleep 10;

hint "Niere wurde eingesetzt: Die Krankenkasse zahlt dir 250€";
[250, 1] call XY_fnc_addMoney;

[getPlayerUID player, 7, format ["Hat %1 (%2) eine Niere eingesetzt @ %3", name _unit, getPlayerUID _unit, mapGridPosition player ]] remoteExec ["XYDB_fnc_log", XYDB];
[getPlayerUID _unit, 7, format ["Wurde von %1 (%2) eine Niere eingesetzt @ %3", profileName, getPlayerUID player, mapGridPosition player ]] remoteExec ["XYDB_fnc_log", XYDB];