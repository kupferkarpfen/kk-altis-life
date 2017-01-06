// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _cash = param [ 0, -1, [0] ];

if( _cash < 1 ) exitWith {
    titleText[ localize "STR_Civ_RobFail", "PLAIN"];
};

[_cash, true] call XY_fnc_addMoney;

titleText[ format[localize "STR_Civ_Robbed", [_cash] call XY_fnc_numberText], "PLAIN" ];