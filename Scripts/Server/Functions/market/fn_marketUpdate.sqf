// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
// Persistent market - update item sell prices from market prices

if( isNil "XY_marketPrices" ) exitWith {};

{
    private _item = _x select 0;
    private _price = _x select 1;
    {
        if( (_x select 0) isEqualTo _item ) exitWith {
            _x set [ 4, round(_price) ];
        };
    } forEach XY_virtItems;
} forEach XY_marketPrices;

publicVariable "XY_virtItems";
