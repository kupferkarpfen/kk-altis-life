private _from = param[0, objNull, [objNull]];
private _value = param[1, -1, [-1]];

if( _from isEqualTo objNull || _value < 0 ) exitWith {};

[_value] call XY_fnc_addMoney;

private _fromName = _from getVariable ["realName", "ERROR"];
hint format["%1 hat %2€ an dich überwiesen", _fromName, [_value] call XY_fnc_numberText];
[getPlayerUID player, 1, format ["Hat von %1 (%2) %3€ per Überweisung erhalten", _fromName, getPlayerUID _from, [_value] call XY_fnc_numberText ]] remoteExec ["XYDB_fnc_log", XYDB];