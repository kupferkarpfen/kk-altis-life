// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _amount = parseNumber(ctrlText 2018);

if( (lbCurSel 2022) < 0 ) exitWith {};

private _unit = call compile format["%1", lbData [2022, lbCurSel 2022]];
if( (isNil "_unit") || { isNull _unit } || { _unit isEqualTo player } ) exitWith {
    hint "Irgendwas ist schiefgelaufen";
};
if( !XY_atmUsable ) exitWith {
    hint "Du hast kürzlich erst was ausgeraubt und kannst einige Zeit kein Geld weitergeben";
};
if( _amount < 1 ) exitWith {
    hint "Du musst mindestens 1€ weitergeben.";
};
if( !([_amount, 1] call XY_fnc_pay) ) exitWith {
    hint "Soviel besitzt du nicht";
};

// Delay a few seconds to prevent duping
[_unit, [_amount, player]] spawn {
    uisleep 2.5;
    (_this select 1) remoteExec ["XY_fnc_receiveMoney", _this select 0];
};

hint format["Du hast %1€ an %2 gegeben", [_amount] call XY_fnc_numberText, _unit getVariable["realName", name _unit]];
[getPlayerUID player, 2, format ["Hat %1 (%2) %3€ gegeben", name _unit, getPlayerUID _unit, [_amount] call XY_fnc_numberText ]] remoteExec ["XYDB_fnc_log", XYDB];

[] call XY_fnc_p_updateMenu;