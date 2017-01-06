// onlineUID
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
//
// can be called to check if a UID is online

private _uid = param[0, "", [""]];

private _return = false;
{
    if( (getPlayerUID _x) isEqualTo _uid ) exitWith {
        _return = true;
    };
} forEach allPlayers;

_return;