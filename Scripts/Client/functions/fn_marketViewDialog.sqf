// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

disableSerialization;

private _mode = param[0, "", [""]];
if( _mode isEqualTo "" ) exitWith {};

if( _mode isEqualTo "init" ) then {
    createDialog "XY_dialog_marketView";
};

private _display = findDisplay 39500;
if( isNull _display ) exitWith {};

private _lstProducts = _display displayCtrl 1500;
private _lblMarketData = _display displayCtrl 1501;

if( _mode isEqualTo "init" ) exitWith {
    lbClear _lstProducts;

    private _products = XY_marketPrices apply { [([_x select 0] call XY_fnc_itemConfig) select 2, _x select 0] };
    _products sort true;
    {
        private _newIndex = _lstProducts lbAdd format["%1%2", _x select 0, ["", " (*)"] select ((_x select 1) isEqualTo XY_resourceOfTheDay)];
        _lstProducts lbSetData [_newIndex, _x select 1];
    } forEach _products;

    _lstProducts lbSetCurSel 0;
};

private _index = lbCurSel _lstProducts;

// If selected index is -1, set it to 0 (triggers refresh)
if( _index < 0 ) exitWith {};

if( _mode isEqualTo "refresh" ) exitWith {

    private _itemName = _lstProducts lbText _index;
    private _shortName = _lstProducts lbData _index;
    private _illegal = ([_shortName] call XY_fnc_itemConfig) select 5;
    private _sourceWeight = ([_shortName] call XY_fnc_sourceConfig) select 1;

    private _priceData = (XY_marketPrices select { (_x select 0) isEqualTo _shortName }) select 0;

    private _absLongPrice = abs (_priceData select 2);
    private _absShortPrice = abs (_priceData select 3);

    _lblMarketData ctrlSetStructuredText composeText [
        parseText format["<t size='1' align='center'>%1</t>", _itemName],
        lineBreak,
        lineBreak,
        parseText "<t size='0.8' align='center'>Aktueller Preis</t>",
        lineBreak,
        parseText format["<t size='1' align='center'>%1€</t>", [_priceData select 1] call XY_fnc_numberText],
        lineBreak,
        parseText format["<t size='1' align='center'>%1€/LE</t>", [(_priceData select 1) / _sourceWeight] call XY_fnc_numberText],        
        lineBreak,
        parseText "<t size='0.5' align='center'>LE = Ladeeinheit</t>",
        lineBreak,
        lineBreak,
        parseText "<t size='0.8' align='center'>Letzte Preisänderung</t>",
        lineBreak,
        parseText format["<t size='1' align='center' color='#%1'>%2€</t>", ["AA0000", "00AA00"] select ((_priceData select 3) >= 0), [_absShortPrice] call XY_fnc_numberText],
        lineBreak,
        lineBreak,
        parseText "<t size='0.8' align='center'>Langfristige Preisänderung</t>",
        lineBreak,
        parseText format["<t size='1' align='center' color='#%1'>%2€</t>", ["AA0000", "00AA00"] select ((_priceData select 2) >= 0), [_absLongPrice] call XY_fnc_numberText],
        lineBreak,
        lineBreak,
        parseText format["<t size='1' align='center' color='#FF0000'>%1</t>", ["", "Illegale Ware"] select _illegal],
        lineBreak,
        lineBreak,
        parseText format["<t size='1' align='center' color='#9999F7'>%1</t>", ["", "(*) Hohe Nachfrage"] select (_shortName isEqualTo XY_resourceOfTheDay)]
        ];
};