// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// Server-side script to spawn pvp events

XY_allowPVPEvents = true;

_events = [
    XY_fnc_eventMoneyCrash,
    XY_fnc_eventLostConvoy,
    XY_fnc_eventOffroader,
    XY_fnc_eventDrone,
    XY_fnc_eventWeaponDrop
];

// Wait a few minutes before doing anything
uisleep 900;

while { true } do {

    if( XY_allowEvents && XY_allowPVPEvents && XY_RTC_REMAININGMINUTES > 30 ) then {

        // Increased weapon drop chance when its getting late and no event happened yet
        if( XY_RTC_REMAININGMINUTES < 100 && (random 100) < 30 && (count allPlayers) > 30 ) exitWith {
            diag_log "<EVENT> Starting weapon drop as nothing happened yet";
            call XY_fnc_eventWeaponDrop;
        };

        if( (playersNumber civilian) < 50 ) then {
            diag_log "<EVENT> Too few players";
        } else {
            diag_log "<EVENT> Rolling the dice...";
            // chance to spawn random event...
            if( (random 100) < 7 ) then {
                XY_allowPVPEvents = false;
                diag_log "<EVENT> Running event...";
                call ( selectRandom _events );
            };
        };
    };
    uisleep 600;
};