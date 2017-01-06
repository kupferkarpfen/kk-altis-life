// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

[ _this select 0, false, _this select 1, {

    private _source = param[0, objNull, [objNull]];
    private _parameters = param[1, [], [[]]];

    if( _source isEqualTo objNull || _parameters isEqualTo [] ) exitWith {};

    private _shopName = _parameters param[0, "", [""]];
    private _condition = _parameters param[1, { true }, [{}]];

    if( _shopName isEqualTo "" ) exitWith {};

    _source addAction[_shopName,
    {
        private _arguments = _this select 3;
        if( !(call (_arguments select 0)) ) exitWith {
            hint "Das darfst du nicht";
        };
        [XY_fnc_weaponShopMenu, [_arguments select 1]] call XY_fnc_unscheduled;
    }, [_condition, _shopContents], 0, false, true, "", format[XY_actionDefaultCondition, ""], 3];

} ] call XY_fnc_defaultInitializer;