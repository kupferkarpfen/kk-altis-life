// useAlcohol
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// Alkoholgehalt im Blut steigern. Effekte werden in "init_survival" aktiviert

private["_alcohol","_val"];
_alcohol = [_this,0,"",[""]] call BIS_fnc_param;
if(_alcohol == "") exitWith {};

closeDialog 0;

_val = 0;
switch (_alcohol) do {
    case "bottledbeer": {_val = 0.1 + random 0.3};
    case "bottledwhiskey": { _val = 0.2 + random 0.3 };
    case "brandy": { _val = 0.3 + random 0.6 };
    case "moonshine": { _val = 0.3 + random 0.8 };
};

XY_promille = XY_promille + _val;
hintSilent parseText format["Du hast jetzt<br/><t size='1.4' color='#FF0000'>%1 Promille</t>", [ round (XY_promille * 10) / 10 ] call XY_fnc_numberText];