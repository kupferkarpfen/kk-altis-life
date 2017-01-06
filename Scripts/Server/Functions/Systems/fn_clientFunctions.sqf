// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

{
    private _fnc = format ["XY_fnc_%1", _x];
    diag_log format["Publish %1", _fnc];
    call compileFinal format ["%1 = compile PreprocessFileLineNumbers '\server\client\fn_%2.sqf'", _fnc, _x];
    publicVariable _fnc;

} forEach [
    "cashCheck",
    "cleanup",
    "createSpawnSigns",
    "killedPlayer",
    "fw_init",
    "fw_lumina",
    "fw_rock",
    "fw_sparks"
];