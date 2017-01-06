// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

if( !(XY_copLevel in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) ) exitWith {
    ["NotWhitelisted", false, true] call BIS_fnc_endMission;
    sleep 30;
};

XY_PC = switch( XY_copLevel ) do {
    case 1:  {  35 };
    case 2:  { 100 };
    case 3:  { 150 };
    case 4:  { 200 };
    case 5:  { 250 };
    case 6:  { 300 };
    case 7:  { 350 };
    case 8:  { 400 };
    case 9:  { 450 };
    case 10: { 500 };
    default  {  10 };
};

[XY_fnc_addItemToTrunk, ["eventItem_5", 15]] call XY_fnc_unscheduled;
[XY_fnc_addItemToTrunk, ["eventItem_6", 15]] call XY_fnc_unscheduled;