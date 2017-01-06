// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

XY_soundTarget = switch( true ) do {
    case(XY_soundTarget > 0.5): { 0.5 };
    case(XY_soundTarget > 0.2): { 0.2 };
    case(XY_soundTarget > 0.05): { 0.05 };
    default { 1 };
};

titleText [ format["Lautstärke %1%2", [round(XY_soundTarget * 100)] call XY_fnc_numberText, "%"] , "PLAIN"];
2.5 fadeSound XY_soundTarget;