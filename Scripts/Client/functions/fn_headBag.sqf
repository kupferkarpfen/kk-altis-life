// File: fn_headBag.sqf
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

if( XY_headbag ) exitWith {
    XY_headbag = false;
};
player setVariable["blinded", true, true];
XY_headbag = true;

0 cutRsc ["XY_HEADBAG", "PLAIN"];

while { XY_headbag && { player getVariable ["restrained", false] } && { alive player } } do {
    sleep 1;
};

XY_headbag = false;
0 cutRsc ["XY_HEADBAG", "BLACK IN", 2];
player setVariable ["blinded", false, true];