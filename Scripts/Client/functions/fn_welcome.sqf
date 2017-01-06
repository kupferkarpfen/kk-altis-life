// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

disableSerialization;

createDialog "RscDisplayWelcome";

private _display = findDisplay 999999;
(_display displayCtrl 1100) ctrlSetStructuredText (parseText XY_ssv_welcome);

waitUntil{ isNull _display };