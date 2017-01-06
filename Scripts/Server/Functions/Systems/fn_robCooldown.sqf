// Cooldown for robbable shops
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _shop = param[0, objNull, [objNull]];
if(isNull _shop) exitWith {};

uisleep 5400;

// Reset shop locks:
diag_log format [ "Unlocking shop: %1", _shop ];
_shop setVariable["locked", false, true];
_shop setVariable["rip", false, true];