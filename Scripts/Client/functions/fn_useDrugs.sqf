// useDrugs
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// Drogen im Blut steigern. Effekte werden in "init_survival" aktiviert

private["_drug","_val"];
_drug = [_this,0,"",[""]] call BIS_fnc_param;
if(_drug == "") exitWith {};

closeDialog 0;

_val = 0;
switch (_drug) do {
    case "marijuana": { _val = 0.1 + random 0.3 };
    case "frogslsd":  { _val = 0.3 + random 2.0 }; // -> horror trip possible :)
    case "cocainep":  { _val = 0.5 + random 0.5 };
    case "heroinp":   { _val = 1.0 + random 1.0 };
    case "methp":     { _val = 1.0 + random 1.0 };
};

if( _drug == "marijuana" ) then {
    // Min. 15 minutes between sounds!
    if( XY_lastDrugSound == 0 || time - XY_lastDrugSound > 1800 ) then {
        XY_lastDrugSound = time;
        // Play ganja sound
        [player, "weed"] remoteExecCall ["say3D", playableUnits select { isPlayer _x && { (_x distance player) < 250 } }];
    } else {
        hintSilent "Hinweis: Die Musik wird nur alle 30 Minuten abgespielt";
    };
} else {
    // Set flag for dangerous drugs
    XY_hardDrugged = true;
};
if( XY_drugged <= 0 ) then {
    hintSilent parseText "<t size='1.2' color='#FF0000'>Die Droge beginnt gleich zu wirken...</t>";
};
XY_drugged = XY_drugged + _val;