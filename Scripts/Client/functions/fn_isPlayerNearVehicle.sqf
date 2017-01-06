// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// isPlayerNearVehicle
// Checks if vehicle is in players range

private _vehicle = param[0, objNull, [objNull]];
if( _vehicle isEqualTo objNull || !(alive _vehicle) ) exitWith { false };

if( _vehicle isKindOf "House_F" ) exitWith {
    player distance2D _vehicle < 8
};

private _maxSize = _vehicle getVariable["bbmax", -1];

if( _maxSize < 0 ) then {
    // Get the bounding box
    private _bb = boundingBoxReal _vehicle;
    private _p1 = _bb select 0;
    private _p2 = _bb select 1;

    // Get shortest dimension
    private _size1 = (abs ((_p2 select 0) - (_p1 select 0)));
    private _size2 = (abs ((_p2 select 1) - (_p1 select 1)));
    _maxSize = _size1 max _size2;
    _minSize = _size1 min _size2;

    _maxSize = _minSize + (_maxSize / 5);
    _vehicle setVariable["bbmax", _maxSize];
};
// Check if player is within distance
(player distance2D _vehicle) < _maxSize;