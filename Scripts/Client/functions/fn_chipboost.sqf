// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _vehicle = param[0, objNull, [objNull]];

private _canBoost = true;
private _hitPointDamage = (getAllHitPointsDamage _vehicle);
{
    if( (_x find "wheel") >= 0 ) then {
        if( ((_hitPointDamage select 2) select _forEachIndex) > 0.2 ) then {
            _canBoost = false;
        };
    };
} forEach (_hitPointDamage select 0);

if( !_canBoost ) exitWith {};

private _type = _vehicle getVariable["chip.type", 0];
if( _type <  1 ) exitWith {};

if( time < XY_nextBoost ) exitWith {};
XY_nextBoost = time + 0.025;

private _acceleration = switch (_type) do {
    case 1: { 0.0225 }; // Eco
    case 2: { 0.05 }; // Sport
    case 3: { 0.10 }; // Race
    case 4: { 0.20 }; // Insane
    case 5: { 0.30 }; // Ludicrous
    default { 0 };
};

private _max = getNumber(configFile >> 'CfgVehicles' >> (typeOf _vehicle) >> 'maxSpeed') * (switch (_type) do {
    case 2: { 1.12 }; // Sport
    case 3: { 1.18 }; // Race
    case 4: { 1.30 }; // Insane
    case 5: { 1.80 }; // Ludicrous
    default { 1 };
});

private _speed = speed _vehicle;

// only allow forward acceleration, and only up to max
if( _speed < 9 || _speed > _max ) exitWith {};

// If vehicle is in the air (or terrain too rough), disable
if( ((getPosATL _vehicle) select 2) > 0.15 ) exitWith {};

// ESP -> only accelerate if vehicle is straight up
private _vectorUp = vectorUp _vehicle;
private _surfaceNormal = surfaceNormal (getPos _vehicle);
private _diff = _vectorUp vectorDiff  _surfaceNormal;
if( abs(_diff select 0) > 0.05 || abs(_diff select 1) > 0.05 || abs(_diff select 2) > 0.05 ) exitWith {};

// Check if its too steep for accelerated climb
private _vectorDir = vectorDir _vehicle;
private _relX = _vectorDir select 0;
private _relY = _vectorDir select 1;
private _relZ = _vectorDir select 2;

if( _relZ > 0.3 ) exitWith {};

// reduce acceleration by terrain steepness...
if( _relZ > 0 ) then {
    _acceleration = _acceleration * (1 - ((_vectorDir select 2) * 3));
};

private _velocity = velocity _vehicle;
//hintSilent parseText format[ "%1<br/>%2<br/>%3<br/>%4<br/>%5<br/>%6<br/>%7", _velocity select 0, _velocity select 1, _relX, _relY, _relZ, _acceleration, _max ];

_velocity set[0, (_velocity select 0) + (_relX * _acceleration) ];
_velocity set[1, (_velocity select 1) + (_relY * _acceleration) ];
_vehicle setVelocity _velocity;