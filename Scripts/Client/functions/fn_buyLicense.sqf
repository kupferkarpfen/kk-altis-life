// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _licenseName = param[0, "", [""]];
if( _licenseName isEqualTo "" ) exitWith {};

private _license = objNull;
{
    if( (_x select 0) isEqualTo _licenseName ) exitWith {
        _license = _x;
    };
} forEach (XY_licenses + XY_training + XY_spawnLicenses);

if( _license isEqualTo objNull ) exitWith {
    diag_log format["<ERROR> buyLicense called, but license %1 was not found", _licenseName];
};

private _price = _license select 3;

if( !([_price, 1] call XY_fnc_pay) ) exitWith {
    hint format[ "Du hast keine %1€ Bargeld dabei, um dir '%2' zu kaufen", [_price] call XY_fnc_numberText, _license select 2];
};

hint format[ "Du hast dir '%1' für %2€ gekauft", _license select 2, [_price] call XY_fnc_numberText ];
missionNamespace setVariable[ format["license_%1", _licenseName], true];