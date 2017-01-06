// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// Server-side script for house burn event
private _location = param[0, [], [[]]];
diag_log format["<HOUSE BURN> @ ", _location];

private _house = nearestObject[_location, "House"];

diag_log format["<HOUSE BURN> FOUND ", _house];

// Disable wind for the event
setWind[0.1, 0.075, true];

private _positions = _house buildingPos -1;

private _fires = [];
private _smokes = [];
{
    private _source = "#particlesource" createVehicle _x;
    _source setParticleClass "BigDestructionFire";
	_source setParticleFire [0.15, 5, 0.75];
    _source setPos _x;
    _fires pushBack _source;

    _source = "#particlesource" createVehicle _x;
    _source setParticleClass "BigDestructionSmoke";
    _source setPos _x;
    _smokes pushBack _source;

} forEach _positions;

// Fire is burning, keep it burning for a few minutes...
uisleep 300;

// Destroy building...
_house setDamage 1;

// Replace fire by ground fire...
uisleep 5;
{
    deleteVehicle _x;
} forEach _fires;
_fires = [];

private _randomizePosition = {
    private _position = param[0, [], [[]]];
    [ (_position select 0) + ((random 6) - 3), (_position select 1) + ((random 6) - 3), 0 ];
};

while { (count _fires) < 4 } do {
    private _source = "#particlesource" createVehicle [0,0,0];
    _source setParticleClass "BigDestructionFire";
	_source setParticleFire [0.15, 5, 0.75];
    _source setPos ([getPos _house] call _randomizePosition);
    _fires pushBack _source;
};
// Replace smoke with smoke fitting to fire locations...
private _newSmoke = [];
{
    private _source = "#particlesource" createVehicle [0,0,0];
    _source setParticleClass "BigDestructionSmoke";
    _source setPos (getPos _x);
    _newSmoke pushBack _source;
} forEach _fires;

uisleep 2;
// Remove "old" smoke

{
    deleteVehicle _x;
    uisleep 3;
} forEach _smokes;

_smokes = _newSmoke;

uisleep 150;

// Remove fires, then smokes...
{
    deleteVehicle _x;
    uisleep 15 + (random 30);
} forEach (_fires + _smokes);