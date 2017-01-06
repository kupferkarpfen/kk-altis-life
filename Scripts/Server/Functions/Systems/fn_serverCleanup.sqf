// Server-side cleanup script to despawn unused stuff
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _fnc_processQueue = {

    private _oldList = _this select 0;
    private _newList = _this select 1;
    private _return = [];
    private _time = time;

    diag_log format["<CLEANUP> Processing deletion queue with %1 entries, previous was %2 entries", count _newList, count _oldList];
    {
        private _item = _x;
        private _found = _time;
        {
            if( (_x select 0) isEqualTo _item) exitWith {
                _found = _x select 1;
            };
        } forEach _oldList;

        // Despawn after 15 minutes
        private _isVehicle = ( _item isKindOf "Car" || _item isKindOf "Air" || _item isKindOf "Ship" );
        if( (_time - _found) > 1800 || (((_time - _found) > 300) && !_isVehicle) )then {
            diag_log format["<CLEANUP> Deleting %1 @ %2 after %3s", _item, mapGridPosition _item, (_time - _found)];
            if( _isVehicle ) then {
                private _vid = _item getVariable["id", -1];
                if( _vid >= 0 ) then {
                    diag_log format ["<CLEANUP> Returning disabled vehicle: %1", _vid];
                    [_item] call XYDB_fnc_updateVehicle;
                    private _trunk = _item getVariable["trunk", []];
                    [format["updateVehiclePark:0:%1:%2", [_trunk] call XY_fnc_removeVolatileItems, _vid]] call XYDB_fnc_asyncCall;
                    _item setVariable["id", -1, true];
                };
            };
            deleteVehicle _item;

        } else {
            _return pushBack [ _item, _found ];
        };

    } forEach _newList;

    _return;
};

private _deletionQueue = [];
while { true } do {

    uisleep 90;

    diag_log "<CLEANUP> Starting cleanup...";

    private _newList = [];

    {
        if( (_x isKindOf "Car" || _x isKindOf "Air" || _x isKindOf "Ship") && _x getVariable["despawn", true] ) then {

            _vid = _x getVariable["id", -1];
            if( _vid >= 0 ) then {
                diag_log format [ "<CLEANUP> Destroyed vehicle: %1 (%2) @ %3, insured: %4", _vid, _x, mapGridPosition _x, _x getVariable [ "insured", false ] ];
                [format[ "updateVehicleDestroyed:%1:%2", [0, 1] select (_x getVariable ["insured", false]), _vid]] call XYDB_fnc_asyncCall;
            };
            _x setVariable["id", -1, true];

            private _killTime = _x getVariable[ "counter", -1 ];
            if( _killTime < 0 )then {
                _killTime = time;
                _x setVariable["counter", _killTime ];
            };
            if( (time - _killTime) > 180 ) then {
                diag_log format["<CLEANUP> Deleting %1 @ %2 after 180s", _x, mapGridPosition _x];
                deleteVehicle _x;
            };
        };
    } forEach allDead;

    {
        private _vehicle = _x;
        private _vehicleClass = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "vehicleClass");

        if( (getNumber (configfile >> "CfgVehicles" >> typeOf _vehicle >> "isUav") isEqualTo 1) && { isEngineOn _vehicle } ) then {
            private _consume = 0.1;
            if( (playersNumber west) > 20 )then {
                _consume = 0.5;
            };
            [ _vehicle, ((fuel _vehicle) - _consume) max 0 ] remoteExec ["setFuel", _vehicle];
        }; 

        // destroy vehicles parked in water
        if( _vehicleClass in ["Car", "Air"] && surfaceIsWater (getPosASL _vehicle) && ((getPosASL _vehicle) select 2) < -1.5 ) then {
            private _counter = _vehicle getVariable["cleanup.destroy", 0];
            if( _counter > 4 ) then {
                _vehicle setDamage 1;
            } else {
                _vehicle setVariable["cleanup.destroy", _counter + 1];
            };
        };

        if( _vehicle getVariable["despawn", true] && { alive _vehicle } && { _vehicleClass in ["Car", "Air", "Ship", "Armored", "Submarine"] } && { ({ _x distance _vehicle < 500 } count playableUnits) < 1 } ) then {
            _newList pushBack _vehicle;
        };

        if( (typeOf _vehicle) in [ "Land_Money_F", "Land_Suitcase_F", "Land_ClutterCutter_small_F" ]) then {
            _newList pushBack _x;
        };

    } forEach vehicles;

    {
        private _weapon = _x;
        if( { (_x distance _weapon < 75) } count playableUnits == 0 ) then {
            _newList pushBack _x;
        };
    } forEach (allMissionObjects "GroundWeaponHolder");

    _deletionQueue = [ _deletionQueue, _newList ] call _fnc_processQueue;

    private _groups = allGroups;
    diag_log format["<CLEANUP> Total groups %1", count _groups];
    {
        if( local _x && { (units _x) isEqualTo [] } ) then {
            diag_log format["<CLEANUP> Removing group %1", _x];
            deleteGroup _x;
        };
    } foreach _groups;
};