// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _value = param[0, -1, [0]];
private _source = param[1, objNull, [objNull]];
private _isTicket = param[2, false, [false]];

if( _value < 1 || _source isEqualTo objNull ) exitWith {};

hint format [ ["%1 hat dir %2€ gegeben", "%1 hat %2€ gezahlt"] select _isTicket, [_source getVariable["realName", "ERROR"], "Maskierte Person"] select ([_source] call XY_fnc_playerMasked), [_value] call XY_fnc_numberText];

[_value, !_isTicket] call XY_fnc_addMoney;

[getPlayerUID player, 2, format ["Hat von %1 (%2) %3€ erhalten (TICKET/SPENDE/RECHNUNG: %4)", name _source, getPlayerUID _source, [_value] call XY_fnc_numberText, ["NEIN", "JA"] select _isTicket ]] remoteExec ["XYDB_fnc_log", XYDB];