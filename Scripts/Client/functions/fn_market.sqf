// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
// Regulary check item sales and submit them to the server

private _fnc_submitAndClearData = {
    // Announce PvP-market sales
    {
        if( (_x select 0) isEqualTo "usbstick_3" ) exitWith {
            [0, format["%1 hat %2x USB-Sticks mit geheimen Daten verkauft und %3€ bekommen", profileName, _x select 1, _x select 2] ] remoteExec ["XY_fnc_broadcast"];
        };
    } forEach XY_marketVolume;

    // Upload sales to server
    [XY_marketVolume, player] remoteExecCall ["XY_fnc_marketVolume", 2];
    // Reset sales
    XY_marketVolume = [];
    XY_marketLastAction = 0;
    // Save cash
    call XY_fnc_save;
};

while { true } do {

    uisleep 5;

    // Check if there are changes to submit and check if the last sell action is older than n seconds
    if( XY_marketLastAction > 0 && { time - XY_marketLastAction > 15 } ) then {
        // Unscheduled to prevent race-conditions
        [_fnc_submitAndClearData, []] call XY_fnc_unscheduled;
    };
};