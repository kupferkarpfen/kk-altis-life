// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _vehicle = param[0, objNull, [objNull]];
if( _vehicle isEqualTo objNull ) exitWith {};

closeDialog 0; // Close the interaction menu

//Find out what processor we're near and get its configuration
private _processorName = "";
{
    _processorName = _x getVariable["processor", ""];
    if( !(_processorName isEqualTo "") ) exitWith {};
} forEach (player nearObjects 35);

if( _processorName isEqualTo "" ) exitWith {
    hint parseText format[XY_hintError, "Es ist kein Verarbeiter in der Nähe"];
};
if( _vehicle getVariable ["busy", false] ) exitWith {
    hint parseText format[XY_hintError, "Der Gerät ist bereits beschäftigt oder in Benutzung"];
};

[player, _vehicle, _processorName] remoteExecCall ["XY_fnc_deviceProcessServer", 2];

_vehicle spawn { scriptName "DeviceProcess";

    private _vehicle = _this;

    private _timeout = time + 10;
    waitUntil { _vehicle getVariable ["busy", false] || time > _timeout };
    if( time > _timeout ) exitWith {
        hint parseText format[XY_hintError, "Der Gerät ist fehlerhaft"];
    };
    hint parseText format[XY_hintMsg, format[XY_hintH1, "Der Gerät verarbeitet"], "Du kannst der Gerät während er verarbeitet nicht verwenden"];

    private _nextSound = time;

    while { !(isNull _vehicle) && { (alive _vehicle) } && { (_vehicle getVariable["busy", false]) } } do {
        if( _nextSound <= time ) then {
            [_vehicle, "deviceprocess"] remoteExecCall ["say3D", playableUnits select { isPlayer _x && { (_x distance player) < 333 } }];
            _nextSound = time + 6.6;
        };
    };
};