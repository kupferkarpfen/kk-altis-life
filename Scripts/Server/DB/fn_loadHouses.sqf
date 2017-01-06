// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _i = 1;
private _interval = 10;

private _houses = [];

while { true } do {

    private _entries = [format["selectHouses:%1:%2", _i, _interval], true] call XYDB_fnc_asyncCall;
    if( _entries isEqualTo [] ) exitWith {};

    _i = _i + _interval;
    {
        private _houseID = _x select 0;
        private _housePos = _x select 1;
        private _ownerName = _x select 2;
        private _ownerUID = _x select 3;

        // Resolve position to building...
        private _house = nearestBuilding _housePos;

        _houses pushBack [_house, _ownerUID, _ownerName];

    } forEach _entries;
};

XY_listHouses = _houses;