// File: fn_sidechat.sqf
XY_sidechat = !XY_sidechat;
[player, XY_sidechat, playerSide] remoteExec ["XY_fnc_managesc", 2];
[] call XY_fnc_settingsMenu;