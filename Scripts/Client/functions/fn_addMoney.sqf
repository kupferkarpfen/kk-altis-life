// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
//
// [ amount, type, announce ]
//
// - _amount: amount to add
// - _cash: false = atm (default) or true = cash
// - _announce: 0 = don't announce (default), 1 = announce in systemChat, 2 = announce with hint

private _amount = param[0, -1, [0]];
private _cash = param[1, false, [false]];
private _announce = param[2, 0, [0]];

if( _amount <= 0 ) exitWith {};

private _message = "";
if( _cash ) then {
    XY_CC = XY_CC + _amount;
    _message = format["Du hast %1€ Bargeld erhalten", [_amount] call XY_fnc_numberText];
} else {
    XY_CA = XY_CA + _amount;
    _message = format["Du hast %1€ auf dein Bankkonto erhalten", [_amount] call XY_fnc_numberText];
};
call XY_fnc_save;

if( _announce != 0 ) then {
    systemChat _message;
};
if( _announce isEqualTo 2 ) then {
    hint parseText format["<t align='center' size='1' color='#DDDDDD'>%1</t>", _message];
};