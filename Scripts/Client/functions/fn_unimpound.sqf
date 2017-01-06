// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// TODO: Migrate to new garage system
disableSerialization;

if(lbCurSel 2802 == -1) exitWith {
    hint localize "STR_Global_NoSelection"
};

private _vehicle = lbData[2802, lbCurSel 2802];
_vehicle = (call compile format["%1", _vehicle]) select 0;

private _vid = lbValue[2802, lbCurSel 2802];

if( isNil "_vehicle" ) exitWith {
    hint "Selection error"
};

// Send request to server, to checkout the vehicle from the database...
[_vid, 0, XY_GM_spawns, player, civilian] remoteExec ["XYDB_fnc_retrieveVehicle", XYDB];
XY_GM_spawns = nil;

hint "Fahrzeug wird ausgeparkt...";