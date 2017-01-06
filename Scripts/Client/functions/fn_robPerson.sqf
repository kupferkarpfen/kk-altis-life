// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _robber = param[ 0, objNull, [objNull] ];
if( isNull _robber ) exitWith {};

private _amount = XY_CC;
XY_CC = 0;
[player] call XY_fnc_dropItems;
call XY_fnc_save;

private _robbedName = [ profileName, "maskiertem Opfer" ] select ([player] call XY_fnc_playerMasked);

if( _amount < 1 ) exitWith {
    [2, format[ "Du konntest von %1 nichts rauben", _robbedName]] remoteExec ["XY_fnc_broadcast", _robber];
};

[_amount, _robber] spawn {
    // Minimal delay to allow save go through
    uisleep 1;
    [_this select 0] remoteExec ["XY_fnc_robReceive", _this select 1];
};
private _robberName = [ _robber getVariable["realName", name _robber], "Maskierter Schurke" ] select ([_robber] call XY_fnc_playerMasked);

[[0, 1], format["%1 hat %2€ von %3 geraubt", _robberName, [_amount] call XY_fnc_numberText, _robbedName]] remoteExec["XY_fnc_broadcast"];

[getPlayerUID player, 7, format ["Wurde von %1 (%2) um %3 erleichtert @ %4", name _robber, getPlayerUID _robber, [_amount] call XY_fnc_numberText, mapGridPosition player ]] remoteExec ["XYDB_fnc_log", XYDB];
[getPlayerUID _robber, 7, format ["Hat %1 (%2) um %3 erleichtert @ %4", profileName, getPlayerUID player, [_amount] call XY_fnc_numberText, mapGridPosition player ]] remoteExec ["XYDB_fnc_log", XYDB];