// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _value = param[0, -1, [0]];
if( _value < 0 ) exitWith {};

[0, format[ "%1 erhält für die Festnahme eines Kriminellen %2€ Kopfgeld", profileName, [_value] call XY_fnc_numberText]] remoteExec ["XY_fnc_broadcast"];

[getPlayerUID player, 2, format ["Hat %1€ Kopfgeld erhalten", [_value] call XY_fnc_numberText]] remoteExec ["XYDB_fnc_log", XYDB];

hint format[ "Für die Festnahme eines gesuchten Kriminellen erhälst du %1€", [_value] call XY_fnc_numberText ];

[_value] call XY_fnc_addMoney;