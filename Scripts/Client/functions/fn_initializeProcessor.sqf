// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _sellLicense = param[3, true, [false]];

[ _this select 0, false, [_this select 1, _this select 2], {

    private _source = param[0, objNull, [objNull]];
    private _param = param[1, [], [[]]];
    private _processorName = _param param[0, "", [""]];
    private _condition = _param param[1, { true }, [{}]];

    if( _source isEqualTo objNull || _processorName isEqualTo "" ) exitWith {};

    _source setVariable["processor", _processorName];

    _source addAction["Verarbeiten", {


        private _source = param[0, objNull, [objNull]];
        private _param = param[3, [], [[]]];

        private _paramName = _param param[0, "", [""]];
        private _paramCondition = _param param[1, { true }, [{}]];

        if( !(call _paramCondition) ) exitWith {
            hint parseText format[XY_hintError, "Das darfst du nicht"];
        };
        [_source, _paramName] call XY_fnc_processAction;

    }, [_processorName, _condition], 0, false, true, "", format[XY_actionDefaultCondition, "west, independent"], 3];

} ] call XY_fnc_defaultInitializer;

if( _sellLicense ) then {
    [_this select 0, _this select 1] call XY_fnc_initializeLicenseSeller;
};