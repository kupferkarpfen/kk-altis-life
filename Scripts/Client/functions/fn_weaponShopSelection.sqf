// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _list = param[ 0, controlNull, [controlNull] ];
private _index = param[1, -1, [0] ];

if( _list isEqualTo controlNull || _index < 0 ) exitWith {
    closeDialog 0;
};

private _display = findDisplay 38400;
private _price = _list lbValue _index;

(_display displayCtrl 38404) ctrlSetStructuredText parseText format ["<t size='0.8'>Preis: <t color='%1'>%2€</t></t>", ["#8CFF9B", "#FF0000"] select (_price > XY_CC + XY_CA), [_price] call XY_fnc_numberText];