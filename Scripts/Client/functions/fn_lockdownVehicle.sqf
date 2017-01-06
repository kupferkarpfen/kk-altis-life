// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _vehicle = param[0, objNull, [objNull]];

if( _vehicle isEqualTo objNull ) exitWith {};

if( !(alive _vehicle) ) exitWith {
    hint "Die Karre ist nich mehr zu retten";
};

if( XY_impoundInUse ) exitWith {};
if( _vehicle distance player > 10 ) exitWith {};
if( !(_vehicle isKindOf "Car" || _vehicle isKindOf "Air" || _vehicle isKindOf "Ship") ) exitWith {};
if( count crew _vehicle > 0 ) exitWith {
    hint "Da sind noch Personen im Fahrzeug. Die müssen erst raus";
};
if( _vehicle distance cursorTarget > 10 ) exitWith {};

if( _vehicle distance (getMarkerPos "XXX_MARKER") > 60 ) exitWith {
    hint "Du kannst das Fahrzeug nur in der Nähe einer Verwahrstelle einziehen";
};

private _ownerName = _vehicle getVariable["ownerName", ""];
if( _ownerName == "" ) exitWith {
    deleteVehicle _vehicle
};
if( _vehicle getVariable["side", sideUnknown ] != civilian ) exitWith {
    hint "Es können nur Zivilfahrzeuge eingezogen werden";
};

private _dbInfo = _vehicle getVariable["id", -1];
if( _dbInfo < 0 ) exitWith {
    hint "Mietwagen können nicht eingezogen werden";
};

private _vehicleName = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
[0, format["%1, dein %2 wird von %3 gebührenpflichtig beschlagnahmt", _ownerName, _vehicleName, profileName] ] remoteExec ["XY_fnc_broadcast"];

XY_actionInUse = true;

disableSerialization;
private _cp = 0;
private _duration = 45;
private _startTime = time;
private _timeOut = _startTime + _duration;
private _interrupted = true;

5 cutRsc ["XY_progressBar", "PLAIN"];
private _ui = uiNamespace getVariable "XY_progressBar";
private _progressBar = _ui displayCtrl 38201;
private _titleText = _ui displayCtrl 38202;

while { alive player && !XY_isTazed && player distance _vehicle < 15 && !(player getVariable["restrained", false]) && (count crew _vehicle) == 0 } do {

    _cp = (time - _startTime) / (_timeOut - _startTime);
    _progressBar progressSetPosition _cp;
    _titleText ctrlSetText format[ "%1 einziehen... (%2%3)", _vehicleName, round(_cp * 100), "%" ];

    if( _cp >= 1 ) exitWith {
        _interrupted = false;
    };

    sleep 0.25;
};
5 cutText ["", "PLAIN"];
XY_actionInUse = false;

if( _interrupted ) exitWith {
    hint localize "STR_NOTF_ActionCancel";
};

XY_impoundInUse = true;

private _reward = [50000, 5000] select ( typeOf (_vehicle) in ["C_Hatchback_01_F", "C_Hatchback_01_sport_F", "C_Offroad_01_F", "B_G_Offroad_01_F", "C_SUV_01_F", "C_Van_01_box_F", "C_Van_01_transport_F", "C_Van_01_fuel_F", "B_Quadbike_01_F"] );

hint format[ "Du hast ein(en) %1 kostenpflichtig beschlagnahmt: Du erhälst %2€", _vehicleName, [_reward] call XY_fnc_numberText ];

[_reward] call XY_fnc_addMoney;

[_vehicle, true, player, true] remoteExec ["XYDB_fnc_vehicleStore", XYDB];
waitUntil {sleep 1; !XY_impoundInUse};





