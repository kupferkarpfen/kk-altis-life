// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

if( !(alive player) || dialog ) exitWith {};
if( !(createDialog "XY_dialog_EMP") ) exitWith {};

disableSerialization;
waitUntil { !isNull (findDisplay 3494) };

[] spawn XY_fnc_empScan;