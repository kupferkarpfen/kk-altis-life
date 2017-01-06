// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

if( !hasInterface || !(missionNamespace getVariable["XY_gameRunning", false]) ) exitWith {};

private _caller = param[0, objNull, [objNull]];
private _callerName = param[1, "Unbekannter Spieler", [""]];

if( isNull _caller ) exitWith {};

playSound "notification";
hint parseText format["<t color='#FF0000' size='2'>Hilferuf von %1</t>", _callerName];
systemChat format["Hilferuf von %1", _callerName];
titleText[ format["Hilferuf von %1", _callerName], "PLAIN"];