// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _position = param[0, [], [[]]];
if( _position isEqualTo [] ) exitWith {};

// Spawn a few cm higher to prevent bugging into stuff
_position set [2, (_position select 2) + 0.55];

player allowDamage false;
player setPos _position;

if( XY_hudON ) then {
    disableSerialization;
    2 cutRsc ["XY_HUD", "PLAIN", 4, false];
};

"EnableDamage" spawn { scriptName _this;
    uisleep 5;
    player allowDamage true;
};

cutText ["", "BLACK IN"];