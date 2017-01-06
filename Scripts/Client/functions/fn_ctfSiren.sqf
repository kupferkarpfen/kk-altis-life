// CTF start module
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _flagpole = param[0, objNull, [objNull]];
private _city =     param[3, "",[""]];

if( isNull _flagpole || _city isEqualTo "" ) exitWith {};

if( west countSide playableUnits < 10 ) exitWith {
    hint "Es müssen mindestens 10 Polizisten online sein";
};
if( playerSide != west ) exitWith {};

if( XY_actionInUse ) exitWith {};
XY_actionInUse = true;

// Send CTF request to server...
[player, _flagpole, "start", _city] remoteExec ["XY_fnc_ctf", 2];

uisleep 2;
XY_actionInUse = false;