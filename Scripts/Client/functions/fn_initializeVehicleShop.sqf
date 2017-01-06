// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

[ _this select 0, false, _this select 1, {

    private _source = param[0, objNull, [objNull]];
    private _parameters = param[1, [], [[]]];

    if( _source isEqualTo objNull || _parameters isEqualTo [] ) exitWith {};

    private _title = "";
    {
        if( (_x select 0) isEqualTo (_parameters select 0) ) exitWith {
            _title = _x select 1;
        };
    } forEach XY_vehicleShopConfig;

    if( _title isEqualTo "" ) then {
        diag_log format["<ERROR> Failed to find title for vehicle shop: %1", _this];
        _title = "Fahrzeugshop";
    };

    _source addAction[_title, {
        XY_actionInUse = true;
        ["init"] call XY_fnc_showVehiclePreview;
        uisleep 1;
        [XY_fnc_vehicleShopMenu, ["init", _this select 3]] call XY_fnc_unscheduled;
    }, _parameters, 0, false, true, "", format[XY_actionDefaultCondition, ""], 3];

} ] call XY_fnc_defaultInitializer;