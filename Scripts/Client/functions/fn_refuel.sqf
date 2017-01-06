// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _isAir = (_this select 3) == "air";
private _objectTypes = [[ "Car", "Ship" ], [ "Air" ]] select _isAir;
private _maxDistance = [10, 30] select _isAir;

if( (vehicle player) != player ) exitWith {
    hint "Bitte aus dem Fahrzeug aussteigen"
};

private _vehicles = nearestObjects [ _this select 0, _objectTypes, _maxDistance ];

// Try to find the nearest vehicle used by player, if none, take nearest
private _vehicle = objNull;

if( !(_vehicles isEqualTo []) ) then {
    _vehicle = _vehicles select 0;
    {
        if( _x getVariable[ "lastUsedByMe", 0 ] > _vehicle getVariable [ "lastUsedByMe", 0 ] ) then {
            _vehicle = _x;
        };
    } forEach _vehicles;
};

if( isNull _vehicle ) exitWith {
    hint "Kein Fahrzeug in der Nähe gefunden";
};

if( isEngineOn _vehicle ) exitWith {
    hint "Motor aus, wegen Explosionsgefahr und so";
};

if( XY_actionInUse ) exitWith {};
XY_actionInUse = true;

disableSerialization;

5 cutRsc ["XY_progressBar", "PLAIN"];

private _ui = uiNameSpace getVariable "XY_progressBar";

private _progress = _ui displayCtrl 38201;
private _progressText = _ui displayCtrl 38202;

private _oilConfig = (XY_marketPrices select { (_x select 0) isEqualTo "oilp" }) select 0;

private _capacity = getNumber(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "fuelCapacity");
private _tick = ((1 / _capacity) max 0.01);
private _ticks = 0;
private _costs = 0;
private _fuel = fuel _vehicle;
private _startFuel = _fuel;
private _oilPrice = (_oilConfig select 1) / XY_ssv_FPD;

if( _isAir ) then {
    _oilPrice = _oilPrice * XY_ssv_FPAF;
};

while { _fuel < 1 && alive player && player isEqualTo (vehicle player) && !XY_isTazed && !(player getVariable["restrained", false]) && player distance _vehicle <= _maxDistance && !(isEngineOn _vehicle) } do {

    _progress progressSetPosition _fuel;
    _progressText ctrlSetText format[ "%1: %2 / %3l, Preis: %4€", getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName"), [_fuel * _capacity] call XY_fnc_numberText, [_capacity] call XY_fnc_numberText, [_costs] call XY_fnc_numberText];

    _fuel = (1 min (_fuel + _tick));
    // yeah i know 'multiplication and division first, then addition and subtraction', but I like braces
    _costs = ((_fuel * _capacity) - (_startFuel * _capacity)) * _oilPrice;
    _ticks = _ticks + 1;

    uisleep 0.25;
};

5 cutText ["", "PLAIN"];
XY_actionInUse = false;

[ _vehicle, _fuel ] remoteExec ["setFuel", _vehicle];

private _repairCosts = 0;
private _repairMessage = "";
if( _isAir ) then {

    {
        if( _x > 0 ) then {
            _repairCosts = _repairCosts + 25;
        };
    } forEach ((getAllHitPointsDamage _vehicle) select 2);

    _repairMessage = format[ "Reparaturkosten: %1€<br/>", [_repairCosts] call XY_fnc_numberText ];
    _vehicle setDamage 0;
};
hintSilent parseText format["<t align='center' color='#F0C010' size='1.6'>Tankquittung</t><br/><t size='1.2'>Getankt: %1l<br/>Preis: %2€/l<br/>Kosten: %3€<br/>%4<t align='center'>Vielen Dank für Ihren Besuch</t></t>", [_ticks * _tick * _capacity] call XY_fnc_numberText, [_oilPrice, 3] call XY_fnc_numberText, [_costs] call XY_fnc_numberText, _repairMessage ];

// Allow paying less than available...
[XY_CA min (_costs + _repairCosts), 2] call XY_fnc_pay;