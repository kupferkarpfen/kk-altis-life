// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
private _vehicle = param[0, objNull, [objNull]];
if( _vehicle isEqualTo objNull ) exitWith {};

if( !(alive _vehicle) ) exitWith {
    hint "Die Karre ist bereits kaputt";
};

if( !(_vehicle isKindOf "Car" || _vehicle isKindOf "Air" || _vehicle isKindOf "Ship") ) exitWith {};

if( !((crew _vehicle) isEqualTo []) ) exitWith {
    hint "Da sind noch Personen im Fahrzeug. Die müssen erst raus!";
};

private _vid = _vehicle getVariable["id", -1];
if( _vid < 0 ) then {
    _vid = "MIETWAGEN";
};
private _uid = _vehicle getVariable["owner", ""];
private _ownerName = _vehicle getVariable["ownerName", ""];
if( _ownerName isEqualTo "" ) exitWith {
    deleteVehicle _vehicle
};

private _vehicleName = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");

private _action = [
    format["Willst du das Fahrzeug '%1' von '%2' wirklich sprengen? ACHTUNG: Das darfst du nur wenn der Besitzer des Fahrzeug oder seine Gang bewaffneten Widerstand geleistet haben, oder längere Zeit vor der Polizei geflüchtet sind.", _vehicleName, _ownerName],
    "Sprengen?",
    "SPRENGEN!",
    "ABBRUCH"
] call XY_fnc_showQuestionbox;

if( !_action ) exitWith {};

if( player distance _vehicle > 15 ) exitWith {
    hint "Du bist zu weit entfernt";
};

_vehicle setVariable [ "insured", false, true ];

hint "Das Fahrzeug wird zerstört, bitte mindestens 50m Abstand halten!";
uisleep 10;

_message = "<t color='#FF0000' size='%1' align='center'>%2</t>";

for[ {_i = 10}, {_i > 3}, {_i = _i - 1} ] do {
    hintSilent parseText format[_message, 1.2, _i];
    uisleep 1;
};

hintSilent parseText format[_message, 1.4, 3];
uisleep 1;
hintSilent parseText format[_message, 1.6, 2];
uisleep 1;
hintSilent parseText format[_message, 1.8, 1];
uisleep 1;
hintSilent parseText format[_message, 2.1, "BOOM"];

[0, format["%1 hat ein(en) %2 von %3 gesprengt", profileName, _vehicleName, _ownerName ]] remoteExec ["XY_fnc_broadcast"];

[getPlayerUID player, 21, format ["Sprengt Fahrzeug %1 (%2) von %3 (%4) @ %5", _vehicleName, _vid, _ownerName, _uid, mapGridPosition player ]] remoteExec ["XYDB_fnc_log", XYDB];
[_uid, 21, format ["Fahrzeug %1 (%2) wurde von %3 (%4) gesprengt @ %5", _vehicleName, _vid, profileName, getPlayerUID player, mapGridPosition player ]] remoteExec ["XYDB_fnc_log", XYDB];

[getPos _vehicle] remoteExec ["XY_fnc_bomb", 2];
uisleep 1;
if( alive _vehicle ) then {
    _vehicle setDamage 1;
};