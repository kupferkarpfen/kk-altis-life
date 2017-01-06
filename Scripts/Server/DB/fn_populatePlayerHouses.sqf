// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// original by Tonic
// @TODO The db storage format needs to be revised to better match the one from getUnitLoadout

private _uid = param[ 0, "", [""]];
if( _uid isEqualTo "" ) exitWith { [] };

{
    diag_log format["LINE: %1", _x];

    private _house = nearestBuilding (_x select 1);
    if( !(_house getVariable["house.loaded", false] ) ) then {
        _house setVariable["house.loaded", true];

        [_house, false] remoteExecCall ["allowDamage", 0, true];

        _house setVariable["id", _x select 0];
        _house setVariable["trunk", _x select 2];
        _house setVariable["trunk.loaded", true];

        private _containers = _house getVariable ["containers", []];
        // Cleanup if there are already containers
        {
            if( !(isNull _x) ) then {
                deleteVehicle _x;
            };
        } forEach _containers;
        _containers = [];

        private _houseSlots = [];

        {
            diag_log format["fill container %1: %2", _forEachIndex, _x];
            if( _x isEqualTo [] ) exitWith {};

            private _className = _x select 0;
            private _weapons = (_x select 1) select 0;
            private _magazines = (_x select 1) select 1;
            private _items = (_x select 1) select 2;
            private _backpacks = (_x select 1) select 3;

            private _positions = [_house] call XY_fnc_getBuildingPositions;
            private _containerPosition = [];

            {
                if( !(_forEachIndex in _houseSlots) ) exitWith {
                    _houseSlots pushBack _forEachIndex;
                    _containerPosition = _x;
                };
            } forEach _positions;

            if(_containerPosition isEqualTo []) exitWith {};

            private _box = _className createVehicle [random 500, random 500, random 500];
            [_box, false] remoteExecCall ["allowDamage", 0, true];

            clearWeaponCargoGlobal _box;
            clearItemCargoGlobal _box;
            clearMagazineCargoGlobal _box;
            clearBackpackCargoGlobal _box;

            //Add weapons to the crate.
            {
                _weaponCount = (_weapons select 1) select _forEachIndex;
                _box addWeaponCargoGlobal [_x, _weaponCount];
            } forEach (_weapons select 0);

            //Add magazines
            {
                _magazineCount = (_magazines select 1) select _forEachIndex;
                _box addMagazineCargoGlobal [_x, _magazineCount];
            } forEach (_magazines select 0);

            //Add items
            {
                _itemCount = (_items select 1) select _forEachIndex;
                _box addItemCargoGlobal [_x, _itemCount];
            } forEach (_items select 0);

            //Add backpacks
            {
                _backpackCount = (_backpacks select 1) select _forEachIndex;
                _box addBackpackCargoGlobal [_x, _backpackCount];
            } forEach (_backpacks select 0);

            _box setPosATL _containerPosition;
            _containers pushBack _box;

        } forEach (_x select 3);

        _house setVariable["slots", _houseSlots, true];
        _house setVariable["containers", _containers, true];
    };

} forEach ([format["selectHousesForUID:%1", _uid], true] call XYDB_fnc_asyncCall);