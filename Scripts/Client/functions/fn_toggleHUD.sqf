// File: fn_sidechat.sqf
XY_hudON = !XY_hudON;
[] call XY_fnc_settingsMenu;

if( XY_hudON )then {
    2 cutRsc ["XY_HUD", "PLAIN", 0, false];
} else {
    2 cutText ["", "PLAIN"];
};