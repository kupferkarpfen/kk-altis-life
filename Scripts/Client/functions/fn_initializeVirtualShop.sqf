// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

[ _this select 0, false, _this select 1, {

    private _source = param[0, objNull, [objNull]];
    private _parameters = param[1, [], [[]]];

    if( _source isEqualTo objNull || _parameters isEqualTo [] ) exitWith {};

    private _shopType = _parameters param[0, "", [""]];
    private _condition = _parameters param[1, { true }, [{}]];

    if( _shopType isEqualTo "" ) exitWith {};

    private _shopData = [];
    {
        if( (_x select 0) isEqualTo _shopType ) exitWith {
            _shopData = _x;
        };
    } forEach XY_virtShops;

    if( _shopData isEqualTo [] ) exitWith {};

    // Add reference to shop source
    _shopData pushBack _source;

    _source addAction[_shopData select 1, {
        private _arguments = _this select 3;
        if( !(call (_arguments select 0)) ) exitWith {
            hint "Das darfst du nicht";
        };
        [XY_fnc_virtualShopMenu, ["init", _arguments select 1]] call XY_fnc_unscheduled;
    }, [_condition, _shopData], 0, false, true, "", format[XY_actionDefaultCondition, ""], 3];

} ] call XY_fnc_defaultInitializer;