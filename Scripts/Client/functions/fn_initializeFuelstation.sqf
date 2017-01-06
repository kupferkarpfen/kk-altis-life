// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _robbable = param[2, true, [false]];

[_this select 0, ["Tankstellenladen", ["items_civ"]]] call XY_fnc_initializeWeaponShop;
[_this select 0, ["bistro", { true }]] call XY_fnc_initializeVirtualShop;

[ _this select 0, false, [_this select 1, _robbable], {

    private _source = param[0, objNull, [objNull]];
    private _stationName = (_this select 1) param[0, "", [""]];
    private _robbable = (_this select 1) param[1, true, [false]];

    if( _source isEqualTo objNull || _stationName isEqualTo "" ) exitWith {};

    if( _robbable ) then {
        _source addAction["Tankstelle ausrauben", XY_fnc_robShops, "", 0, false, true, "", format[XY_actionDefaultCondition, "west, independent"], 3];
    };

    _source setVariable["location", _stationName];
} ] call XY_fnc_defaultInitializer;