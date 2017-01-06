// announce restarts
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

if( !(missionNamespace getVariable["XY_gameRunning", false]) ) exitWith {};

private _remaining = param[0, -1, [0]];
if( _remaining < 2 || _remaining > 180 ) exitWith {};

[ format ["<t size='0.8' color='#F0C010'>Server-Neustart in ca %1 Minuten</t>", _remaining], -1, -1, 4, 1 ] spawn BIS_fnc_dynamicText;