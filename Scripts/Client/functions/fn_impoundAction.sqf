// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
private["_vehicle","_type","_time","_price","_vehicleData","_vehownerid","_costfulImpound","_duration","_cpRate","_cp","_progressBar","_titleText","_ui","_interrupted"];

if( !params[
        [ "_vehicle", objNull, [objNull] ]
    ]) exitWith {};

if( player distance _vehicle > 10 ) exitWith {};

if( !(alive _vehicle) ) exitWith { 
    hint "Die Karre ist nich mehr zu retten"; 
};

if( XY_impoundInUse ) exitWith {};
if( !(_vehicle isKindOf "Car" || _vehicle isKindOf "Air" || _vehicle isKindOf "Ship") ) exitWith {};
if( count crew _vehicle > 0 ) exitWith {
    hint "Da sind noch Personen im Fahrzeug. Die müssen erst raus!";
};

_uid = _vehicle getVariable["owner", ""];
_ownerName = _vehicle getVariable["ownerName", ""];
if( _ownerName == "" ) exitWith {
    deleteVehicle _vehicle
};

_costfulImpound = false;

{
    if( side _x == playerSide && alive _x && getPlayerUID _x == _uid) exitWith {
        _costfulImpound = true;
    };
} forEach playableUnits;

if( _costfulImpound && { !([100] call XY_fnc_pay) } ) exitWith {
    hint "Fahrzeuge der eigenen Fraktion abzuschleppen kostet Geld und davon hast du nicht genug";
};

_vehicleName = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
[0, format["%1, dein %2 wird gerade von %3 beschlagnahmt", _ownerName, _vehicleName, profileName] ] remoteExec ["XY_fnc_broadcast"];

XY_actionInUse = true;

disableSerialization;
_cp = 0;
_duration = 20;
_startTime = time;
_timeOut = _startTime + _duration;
_interrupted = true;

5 cutRsc ["XY_progressBar","PLAIN"];
_ui = uiNamespace getVariable "XY_progressBar";
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;

while { alive player && !XY_isTazed && player distance _vehicle < 10 && !(player getVariable["restrained", false]) && (count crew _vehicle) == 0 } do {

    _cp = (time - _startTime) / (_timeOut - _startTime);
    _progressBar progressSetPosition _cp;
    _titleText ctrlSetText format[ "Beschlagnahme Fahrzeug (%1%2)", round(_cp * 100), "%" ];

    if( _cp >= 1 ) exitWith {
        _interrupted = false;
    };

    sleep 0.25;
};
5 cutText ["","PLAIN"];
XY_actionInUse = false;

if( _interrupted ) exitWith {
    hint localize "STR_NOTF_ActionCancel";
};

_price = switch (true) do {
    case(_vehicle isKindOf "Car"):  { 100 };
    case(_vehicle isKindOf "Ship"): { 150 };
    case(_vehicle isKindOf "Air"):  { 250 };
};

XY_impoundInUse = true;
[_vehicle, true, player, false] remoteExec ["XYDB_fnc_vehicleStore", XYDB];
[0, format["%1 hat ein(en) %2 von %3 beschlagnahmt", profileName, _vehicleName, _ownerName]] remoteExec ["XY_fnc_broadcast"];

if( !_costfulImpound ) then {
    hint format["Du hast ein(en) %1 beschlagnahmt: Du erhälst %2€!", _vehicleName, _price];
    [_price] call XY_fnc_addMoney;
};