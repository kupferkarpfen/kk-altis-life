// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

disableSerialization;

if( lbCurSel 2802 == -1 ) exitWith {
    hint localize "STR_Global_NoSelection"
};

private _vehicle = lbData[2802,(lbCurSel 2802)];
_vehicle = (call compile format["%1",_vehicle]) select 0;
if(isNil "_vehicle") exitWith {hint localize "STR_Garage_Selection_Error"};

private _vid = lbValue[2802, lbCurSel 2802];

closeDialog 0;

private _config = [ _vehicle ] call XY_fnc_vehicleConfig;
if( _config isEqualTo [] ) exitWith {};

private _price = _config select 7;
if( _price < 1 ) exitWith {
    hint "Das Fahrzeug kann nicht verkauft werden";
};

private _action = [
    format ["Willst du dein(en) %1 für %2€ verkaufen?", getText(configFile >> "CfgVehicles" >> (_vehicle) >> "displayName"), [_price] call XY_fnc_numberText],
    "Fahrzeug verkaufen",
    localize "STR_Global_Yes",
    localize "STR_Global_No"
] call XY_fnc_showQuestionbox;

if( !_action ) exitWith {};

if (XY_actionInUse)  exitWith {
    hint "Du kannst grad nichts verkaufen";
};
XY_actionInUse = true;

[player, _vid, _price] remoteExec ["XYDB_fnc_sellVehicle", XYDB];

hint "Verkaufe Fahrzeug...";

[] spawn {
    sleep 3;
    XY_actionInUse = false;
};