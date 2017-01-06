private _container = param[1, objNull, [objNull]];
private _item = param[2, "", [""]];

[format[ "<TAKE> %1 (%2) TAKE %3 FROM %4", profileName, getPlayerUID player, _item, _container]] remoteExec ["XY_fnc_log", 2];