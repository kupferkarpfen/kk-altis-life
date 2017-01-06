/*
    File: fn_bankTransfer.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Figure it out again.
*/
private _val = parseNumber(ctrlText 2702);
private _unit = call compile format["%1", lbData[2703, lbCurSel 2703]];

if(isNull _unit) exitWith {};

if( (lbCurSel 2703) < 0 ) exitWith {
    hint localize "STR_ATM_NoneSelected"
};
if( isNil "_unit" ) exitWith {
    hint localize "STR_ATM_DoesntExist"
};

if(_val <= 0) exitwith {};

if(_val > XY_CA) exitWith {
    hint localize "STR_ATM_NotEnough"
};

_tax = round(_val * 0.1);
if((_val + _tax) > XY_CA) exitWith {
    hint format[localize "STR_ATM_SentMoneyFail", _val, _tax]
};

XY_CA = XY_CA - (_val + _tax);
call XY_fnc_save;

[player, _val] remoteExec ["XY_fnc_clientWireTransfer", _unit];

hint format[localize "STR_ATM_SentMoneySuccess", [_val] call XY_fnc_numberText, _unit getVariable["realName", name _unit], [_tax] call XY_fnc_numberText];

[getPlayerUID player, 1, format ["Hat %1 (%2) %3€ überwiesen", name _unit, getPlayerUID _unit, [_val] call XY_fnc_numberText ]] remoteExec ["XYDB_fnc_log", XYDB];

closeDialog 0;