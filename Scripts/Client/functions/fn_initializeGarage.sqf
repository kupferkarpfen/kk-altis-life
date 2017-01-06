// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

[ _this select 0, false, _this select 1, {

    private _source = param[0, objNull, [objNull]];
    private _parameters = param[1, [], [[]]];

    private _type = _parameters param[0, "", [""]];
    private _side = _parameters param[1, sideUnknown, [sideUnknown]];

    if( !(_side isEqualTo sideUnknown) && { !(_side isEqualTo (side(group player))) } ) exitWith {};

    if( _source isEqualTo objNull || _parameters isEqualTo [] || _type isEqualTo "" ) exitWith {};

    private _title = switch(_type) do {
        case "Air": { "Helikopter-Garage" };
        case "Ship": { "Boot-Garage" };
        case "Jet": { "Flugzeug-Hangar" };
        default { "Fahrzeug-Garage" };
    };

    _source addAction[_title, { (_this select 3) call XY_fnc_vehicleGarage }, _parameters, 0, false, true, "", format[XY_actionDefaultCondition, ""], 3];

    if( !(_source getVariable ["impound.placed", false]) )then {
        _source setVariable["impound.placed", true];
        _source addAction["Fahrzeug einparken", { (_this select 3) call XY_fnc_storeVehicle }, _parameters, -10, false, true, "", format["%1 && !XY_garageStore", format[XY_actionDefaultCondition, ""]], 3];
    };

} ] call XY_fnc_defaultInitializer;