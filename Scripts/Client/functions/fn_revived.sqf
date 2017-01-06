// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
private _medic = param[ 0, "ERROR", [""]];

player setUnitLoadout (getUnitLoadout XY_corpse);

private _dir = getDir XY_corpse;
private _pos = visiblePositionASL XY_corpse;

["exit"] call XY_fnc_deathScreen;

// Bring me back to life
player setDir _dir;
player setPosASL _pos;

// Set damage so the player requires painkillers from the medic
player setDamage 0.5 + (random 0.3);

player setVariable["revive", nil, true];
player setVariable["name", nil, true];
player setVariable["reviving", nil, true];

call XY_fnc_save;

_medic spawn {
    uisleep 10;
    hint format[ "Du wurdest von %1 reanimiert, bitte gebe dem Sanitäter eine angemessene Spende", _this ];
};