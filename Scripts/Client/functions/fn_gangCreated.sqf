// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _message = param[0, "", [""]];

if( !(_message isEqualTo "") ) exitWith {

    hint parseText _message;
    [XY_gangPrice] call XY_fnc_addMoney;
};

hint "Die Gang wurde erstellt";