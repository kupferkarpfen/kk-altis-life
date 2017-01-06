/*
	File: fn_wantedMenu.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Opens the Wanted menu and connects to the APD.
*/
disableSerialization;

createDialog "XY_dialog_wantedList";

private _display = findDisplay 2400;
private _list = _display displayCtrl 2401;
lbClear _list;
private _units = [];

ctrlSetText[2404, "Verbindungsaufbau..."];

if( XY_copLevel < 3 && !XY_isAdmin ) then {
	ctrlShow[2405, false];
};

[player] remoteExec ["XY_fnc_wantedFetch", 2];