// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _unit = _this select 0;
private _part = _this select 1;
private _damage = _this select 2;
private _source = _this select 3;
private _projectile = _this select 4;
private _hpi = _this select 5;

if( (side _source) isEqualTo west && { _projectile in ["B_9x21_Ball", "B_556x45_dual"] } && { (currentWeapon _source) in ["hgun_P07_snds_F", "hgun_P07_F", "arifle_SDAR_F"] } ) exitWith {

    private _distance = [35, 100] select ( _projectile isEqualTo "B_556x45_dual" );

    if( _unit distance _source < _distance && { !XY_isTazed } && { !(_unit getVariable["restrained", false]) } ) then {
        private _isVehicle = (vehicle player) != player;
        private _isQuad = _isVehicle && { typeOf (vehicle player) in [ "B_Quadbike_01_F", "C_Kart_01_Blu_F", "C_Kart_01_Fuel_F", "C_Kart_01_Red_F", "C_Kart_01_Vrana_F" ] };
        if( _isQuad ) then {
            player action ["Eject", vehicle player];
        };
        if( !_isVehicle || _isQuad ) then {
            [_unit, _source] spawn XY_fnc_tazed;
        };
    };
    damage player;
};

if( XY_IN_SAFEZONE || XY_immunity > time ) exitWith {
    (damage player);
};

// dampening of vehicle crash damage
if( isNull _source && _projectile isEqualTo "" && _part isEqualTo "" && !((vehicle player) isEqualTo player) && speed (vehicle player) > 30 ) exitWith {
    private _delta = _damage - (damage player);
    (damage player) + (_delta * 0.5);
};

if( isNull _source ) exitWith {
    _damage;
};

// Prevent roadkills
if( isPlayer _source && { _projectile isEqualTo "" } && { (vehicle _source) isKindOf "Car" } ) exitWith {
    damage player;
    // Prevent secondary damage
    XY_immunity = time + 3;
};

// Nerf cyrus on short distances
if( _projectile isEqualTo "B_93x64_Ball" && player distance _source < 1000 ) exitWith {
    if( _hpi >= 0 ) exitWith {
        (damage player);
    };
    private _delta = _damage - (damage player);
    private _factor = ((player distance _source) / 1000);
    private _newDamage = _delta * _factor;

    (damage player) + _newDamage;
};

_damage;