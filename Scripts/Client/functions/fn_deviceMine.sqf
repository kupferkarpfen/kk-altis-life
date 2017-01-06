// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _vehicle = param[ 0, objNull, [objNull] ];
if( isNull _vehicle ) exitWith {};

closeDialog 0;

// Find out what zone we're near and get its configuration
private _zone = "";
private _item = "";
{
    {
        if(player distance (getMarkerPos _x) < 40) exitWith {
            _zone = _x;
        };
    } forEach (_x select 0);

    if( _zone != "" ) exitWith {
        _item = (_x select 1);
    };
} forEach XY_resourceZones;

if( _zone isEqualTo "" || _item isEqualTo "" ) exitWith {
    hint parseText format[XY_hintError, "Es sind keine Ressourcen in der Nähe"];
};
if( _vehicle getVariable ["busy", false] ) exitWith {
    hint parseText format[XY_hintError, "Der Gerät ist bereits beschäftigt oder in Benutzung"];
};

[player, _vehicle, _item] remoteExecCall ["XY_fnc_deviceMineServer", 2];

_vehicle spawn { scriptName "DeviceMine";

    private _vehicle = _this;

    private _timeout = time + 10;
    waitUntil { _vehicle getVariable ["busy", false] || time > _timeout };
    if( time > _timeout ) exitWith {
        hint parseText format[XY_hintError, "Der Gerät ist fehlerhaft"];
    };
    hint parseText format[XY_hintMsg, format[XY_hintH1, "Der Gerät sammelt"], "Du kannst der Gerät während er sammelt nicht verwenden"];

    private _nextSound = time;

    while { !(isNull _vehicle) && { (alive _vehicle) } && { (_vehicle getVariable["busy", false]) } } do {
        if( _nextSound <= time ) then {
            [_vehicle, "device"] remoteExecCall ["say3D", playableUnits select { isPlayer _x && { (_x distance player) < 333 } }];
            _nextSound = time + 6.6;
        };
    };
};