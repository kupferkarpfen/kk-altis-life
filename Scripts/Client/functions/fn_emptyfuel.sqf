// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _position = getPos player;
private _baseConsumption = 0.001;

while{ true } do {

    uisleep 3;

    private _vehicle = (vehicle player);
    if( !(_vehicle isEqualTo player) && { local _vehicle } && { isEngineOn _vehicle }) then {

        if( _vehicle getVariable ["safezone.godmode", false] ) then {
            if( !XY_IN_SAFEZONE ) then {
                _vehicle allowDamage true;
                _vehicle setVariable ["safezone.godmode", nil, true];
                _vehicle setVariable ["lockpick.timeout", nil, true];
            } else {
                // Dis-allow damage as this may be a locality-change that requires a new allowDamage false
                _vehicle allowDamage false;
            };
        };

        private _distance = round(player distance _position);

        // 1m distance = 0.00004 fuel consumed = 25km total Range
        private _consumption = 0.05 min ((_baseConsumption + (_distance * 0.00004)) * XY_ssv_FCF);

        // For helicopters and jets we reduce the consumption:
        if( _vehicle isKindOf "Air" ) then {
            _consumption = _consumption * XY_ssv_FCAF;
        };
        if( _vehicle isKindOf "Ship" ) then {
            _consumption = _consumption * XY_ssv_FCSF;
        };
        // For planes we further reduce consumption
        if( getNumber(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "maxSpeed") > 400 ) then {
            _consumption = _consumption * 0.25;
        };
        // Event vehicle(s) with reduced fuel consumption...
        if( (typeOf _vehicle) in ["O_Truck_03_fuel_F"] ) then {
            _consumption = _consumption * 0.5;
        };
        // Chip tuning Eco
        if( (_vehicle getVariable["chip.enabled", false]) && { (_vehicle getVariable["chip.type", 0]) isEqualTo 1 } ) then {
            _consumption = _consumption * 0.5;
        };
        if( playerSide in [ independent ] ) then {
            _consumption = _consumption * 0.5;
        };
        if( playerSide isEqualTo west ) then {
            _consumption = _consumption * 0.9;
        };

        _vehicle setFuel( (fuel _vehicle) - _consumption );
    };
    _position = getPos player;
};