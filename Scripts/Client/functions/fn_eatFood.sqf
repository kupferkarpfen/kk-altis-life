// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _food = param[0, "", [""]];
if( _food isEqualTo "" ) exitWith {};

if( !([_food, 1] call XY_fnc_removeItemFromTrunk) ) exitWith {};

private _value = switch (_food) do {
    case "rusk":     {  5 };
    case "apple":    { 15 };
    case "grape":    { 15 };
    case "peach":    { 15 };
    case "cookie":   { 15 };
    case "donuts":   { 15 };
    case "rabbit":   { 25 };
    case "tbacon":   { 30 };
    case "applepie": { 50 };
    case "doner":    { 66 };
    case "salema";
    case "ornate";
    case "mackerel";
    case "tuna";
    case "mullet";
    case "catshark": { 60 };
    default          { 10 };
};

private _hunger = XY_hunger - (_value / 100);
if( _hunger < -0.25 ) then {
    player setFatigue 1;
    hint "Du hast dich überfressen";
};
XY_hunger = 0 max _hunger;