// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

if( !(XY_medicLevel in [1, 2, 3, 4, 5, 6, 7]) ) exitWith {
    ["Notwhitelisted", false, true] call BIS_fnc_endMission;
    sleep 30;
};

XY_PC = switch( XY_medicLevel ) do {
    case 1: { 160 };
    case 2: { 180 };
    case 3: { 190 };
    case 4: { 210 };
    case 5: { 230 };
    case 6: { 240 };
    case 7: { 270 };
};

[XY_fnc_addItemToTrunk, ["eventItem_8", 15]] call XY_fnc_unscheduled;
[XY_fnc_addItemToTrunk, ["eventItem_9", 15]] call XY_fnc_unscheduled;