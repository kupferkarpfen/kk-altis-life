// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

[ _this select 0, false, _this select 1, {

    private _source = param[0, objNull, [objNull]];
    private _licenseName = param[1, "", [""]];

    if( _source isEqualTo objNull || _licenseName isEqualTo "" ) exitWith {};

    private _license = objNull;
    {
        if( (_x select 0) isEqualTo _licenseName ) exitWith {
            _license = _x;
        };
    } forEach (XY_licenses + XY_training + XY_spawnLicenses);

    if( _license isEqualTo objNull ) exitWith {};

    private _licenseSide = switch( _license select 1 ) do {
        case( "cop" ): { "west" };
        case( "med" ): { "independent" };
        default { "civilian" };
    };

    _source addAction[ format["%1 (%2€)", _license select 2, [_license select 3] call XY_fnc_numberText], { [_this select 3] call XY_fnc_buyLicense; }, _licenseName, 0, false, true, "", format["!%1 && playerSide isEqualTo %2 && (vehicle player) isEqualTo player", format["license_%1", _licenseName], _licenseSide], 3];

} ] call XY_fnc_defaultInitializer;