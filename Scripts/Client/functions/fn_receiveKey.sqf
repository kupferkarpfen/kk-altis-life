// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
private _vehicle = param[0, objNull, [objNull]];
private _source  = param[1, objNull, [objNull]];

if( isNull _vehicle || isNull _source ) exitWith {};

private _users = _vehicle getVariable["users", []];
if( !(profileName in _users) ) then {
    _users pushBack profileName;
    _vehicle setVariable[ "users", _users, true ];
};

if( !(_vehicle in XY_vehicles) ) then {
    XY_vehicles pushBack _vehicle;
    [player, playerSide, _vehicle] remoteExec ["XY_fnc_addToKeychain", 2];
};

hint format["%1 hat dir einen Schlüssel für %2 gegeben", [_source getVariable["realName", "ERROR"], "Maskierte Person"] select ([_source] call XY_fnc_playerMasked), getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName")];