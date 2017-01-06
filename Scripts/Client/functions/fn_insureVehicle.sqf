// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// insureVehicle

private _vehicle = param[0, objNull, [objNull]];

if( isNull _vehicle ) exitWith {};

if( _vehicle getVariable ["id", -1] < 0 ) exitWith {
    hint "Mietfahrzeuge können nicht versichert werden";
};
if( _vehicle getVariable ["insured", false] ) exitWith {
    hint "Das Fahrzeug ist bereits versichert";
};
if( _vehicle getVariable ["owner", ""] != getPlayerUID player ) exitWith {
    hint "Du kannst keine fremden Fahrzeuge versichern";
};
if( (serverTime - (_vehicle getVariable["spawnTime", 0])) > 360 ) exitWith {
    hint "Das Fahrzeug ist zu alt und kann nicht mehr versichert werden";
};

private _value = 0;

_config = [typeOf _vehicle] call XY_fnc_vehicleConfig;
if( !(_config isEqualTo []) ) then {
    _value = _config select 5;
};

if( _value < 1 ) exitWith {
    hint "Das Fahrzeug kann nicht versichert werden";
};

private _action = [
    format ["Willst du dein Fahrzeug für %1€ versichern? Die Versicherung gilt bis zum nächsten Einparken oder Server-Neustart. Falls es zerstört wird steht es dir nach dem nächsten Neustart wieder zur Verfügung.", [_value] call XY_fnc_numberText],
    "Versicherung abschließen",
    localize "STR_Global_Yes",
    localize "STR_Global_No"
] call XY_fnc_showQuestionbox;

if( !_action ) exitWith {};

if( !([_value] call XY_fnc_pay) ) exitWith {
    hint "Du hast leider nicht genug Geld um das Fahrzeug zu versichern";
};

_vehicle setVariable [ "insured", true, true ];

hint format [ "Du hast für %1€ eine Versicherung abgeschlossen", [_value] call XY_fnc_numberText ];

[ getPlayerUID player, 13, format [ "Versichert seinen %1 für %2€", getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName"), [_value] call XY_fnc_numberText ] ] remoteExec ["XYDB_fnc_log", XYDB];