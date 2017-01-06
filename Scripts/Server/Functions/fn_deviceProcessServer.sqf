// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

diag_log format["deviceProcessServer(%1)", _this];
if( canSuspend ) exitWith {
    diag_log "CALLED DEVICE PROCESS SERVER SUSPENDABLE, EXITING";
};

private _player = param[0, objNull, [objNull]];
private _vehicle = param[1, objNull, [objNull]];
private _processorName = param[2, "", [""]];

if( isNull _player || isNull _vehicle || _processorName isEqualTo "" ) exitWith {};

private _processor = [];
{
    if( (_x select 0) isEqualTo _processorName ) exitWith {
        _processor = _x;
    };
} forEach XY_resourceProcessors;

private _vehicleConfig = [typeOf _vehicle, _vehicle getVariable ["side", civilian]] call XY_fnc_vehicleConfig;
if( _processor isEqualTo [] || _vehicleConfig isEqualTo [] ) exitWith {};

if( (_vehicle getVariable ["busy", false]) ) exitWith {};
_vehicle setVariable ["busy", true, true];

[_player, _vehicle, _processor, _vehicleConfig] spawn { scriptName "DeviceProcessServer";

    private _player = _this select 0;
    private _vehicle = _this select 1;
    private _processor = _this select 2;
    private _vehicleConfig = _this select 3;

    private _vid = _vehicle getVariable["id", -1];

    diag_log format["[PROCESS VID %1] TRUNK: %2", _vid, _vehicle getVariable["trunk", []]];

    private _sourceItems = _processor select 1;
    private _targetItem = _processor select 2;
    private _targetItemConfig = [_targetItem] call XY_fnc_itemConfig;

    private _sourceItemsWeight = 0;
    {
        _sourceItemsWeight = _sourceItemsWeight + (([_x] call XY_fnc_itemConfig) select 1);
    } forEach _sourceItems;

    private _maxWeight = _vehicleConfig select 2;

    if( _vid >= 0 && { !(_vehicle getVariable["trunk.loaded", false]) } ) then {
        [_vehicle] call XYDB_fnc_loadTrunk;
    };
    private _trunk = _vehicle getVariable["trunk", []];
    diag_log format["[PROCESS VID %1] TRUNK AFTER: %2", _vid, _trunk];

    // We want the device to fill up in x Minutes
    private _weightPerSecond = _maxWeight / 900;
    private _weightProcessed = 0;
    private _trunkWeight = [XY_fnc_getTrunkWeight, [_trunk]] call XY_fnc_unscheduled;

    private _nextEvent = time + 10 + (random 5);

    private _reason = (while { true } do { scopeName "Loop";

        uisleep 1;
        if( isEngineOn _vehicle ) exitWith { "Abgebrochen" };
        if( fuel _vehicle <= 0.05 ) exitWith { "Kein Benzin mehr" };

        _weightProcessed = _weightProcessed + _weightPerSecond;

        if( time >= _nextEvent ) then {
            // Mining event!
            _nextEvent = time + 10 + (random 5);

            // Validate resources...
            private _minResources = 999;
            {
                _minResources = _minResources min ([XY_fnc_getItemCountFromTrunk, [_x, _trunk]] call XY_fnc_unscheduled);
            } forEach _sourceItems;

            if( _minResources < 1 ) exitWith {
                "Der Gerät hat keine Resourcen mehr" breakOut "Loop";
            };

            private _itemCount = floor(_weightProcessed / _sourceItemsWeight) min _minResources;
            _weightProcessed = _weightProcessed - _itemCount * _sourceItemsWeight;

            // Remove resources...
            {
                [XY_fnc_removeItemFromTrunk, [_x, _itemCount, _trunk]] call XY_fnc_unscheduled;
            } forEach _sourceItems;

            // Reduce fuel...
            private _fuel = 0 max ((fuel _vehicle) - 0.0085);
            [_vehicle, _fuel] remoteExec ["setFuel", _vehicle];

            [XY_fnc_addItemToTrunk, [_targetItem, _itemCount, _trunk]] call XY_fnc_unscheduled;
            _trunkWeight = [XY_fnc_getTrunkWeight, [_trunk]] call XY_fnc_unscheduled;

            diag_log format["[PROCESS VID %1] TRUNK: %2", _vid, _trunk];
            [0, format[ "Der Gerät hat %1x %2 verarbeitet (%3 gesamt)", _itemCount, _targetItemConfig select 2, [XY_fnc_getItemCountFromTrunk, [_targetItem, _trunk]] call XY_fnc_unscheduled]] remoteExec ["XY_fnc_broadcast", _player];
        };
    });

    if( !(isNil "_reason" ) ) then {
        [1, format[XY_hintError, _reason]] remoteExec ["XY_fnc_broadcast", _player];
    };
    _vehicle setVariable ["busy", false, true];

    if( _vid < 0 ) exitWith {};

    diag_log format["[PROCESS VID %1] SAVE TO DB: %2", _vid, _trunk];
    [format["updateVehicleTrunk:%1:%2", [_trunk] call XY_fnc_removeVolatileItems, _vid]] remoteExec ["XYDB_fnc_asyncCall", XYDB];
};