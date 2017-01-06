/*
    File: fn_onPlayerRespawn.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Does something but I won't know till I write it...
*/
private _unit = _this select 0;
private _corpse = _this select 1;

// Set some vars on our new body.
_unit setVariable["restrained", false, true];
_unit setVariable["escorting", false, true];
_unit setVariable["steam64ID", getPlayerUID player, true];
_unit setVariable["realName", profileName, true];
_unit setVariable["missingOrgan", false, true];

_unit setVariable["copLevel", XY_copLevel, true];
_unit setVariable["medicLevel", XY_medicLevel, true];

_unit addRating 99999999;
player playMoveNow "amovppnemstpsraswrfldnon";

removeAllAssignedItems player;
removeAllItems player;
removeAllWeapons player;
removeBackpack player;
removeGoggles player;
removeHeadgear player;
removeUniform player;
removeVest player;

[] call XY_fnc_setupActions;

[_unit, XY_sidechat, playerSide] remoteExec ["XY_fnc_managesc", 2];