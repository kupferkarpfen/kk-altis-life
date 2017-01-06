// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

diag_log format["deviceMineServer(%1)", _this];
if( canSuspend ) exitWith {
    diag_log "CALLED DEVICE MINE SERVER SUSPENDABLE, EXITING";
};

private _player = param[0, objNull, [objNull]];
private _vehicle = param[1, objNull, [objNull]];
private _item = param[2, "", [""]];

if( isNull _player || isNull _vehicle || _item isEqualTo "" ) exitWith {};

private _itemConfig = [_item] call XY_fnc_itemConfig;
private _vehicleConfig = [typeOf _vehicle, _vehicle getVariable ["side", civilian]] call XY_fnc_vehicleConfig;
if( _itemConfig isEqualTo [] || _vehicleConfig isEqualTo [] ) exitWith {};

if( (_vehicle getVariable ["busy", false]) ) exitWith {};
_vehicle setVariable ["busy", true, true];

[_player, _vehicle, _itemConfig, _vehicleConfig] spawn { scriptName "DeviceMineServer";

    private _player = _this select 0;
    private _vehicle = _this select 1;
    private _itemConfig = _this select 2;
    private _vehicleConfig = _this select 3;

    private _vid = _vehicle getVariable["id", -1];
    diag_log format["[PROCESS VID %1] TRUNK: %2", _vid, _vehicle getVariable["trunk", []]];

    private _item = _itemConfig select 0;
    private _itemWeight = _itemConfig select 1;
    private _maxWeight = _vehicleConfig select 2;

    if( _vid >= 0 && { !(_vehicle getVariable["trunk.loaded", false]) } ) then {
        [_vehicle] call XYDB_fnc_loadTrunk;
    };
    private _trunk = _vehicle getVariable["trunk", []];
    diag_log format["[PROCESS VID %1] TRUNK AFTER: %2", _vid, _trunk];

    // We want the device to fill up in x Minutes
    private _weightPerSecond = _maxWeight / 900;
    private _weightGathered = 0;
    private _trunkWeight = [XY_fnc_getTrunkWeight, [_trunk]] call XY_fnc_unscheduled;

    private _nextEvent = time + 10 + (random 5);

    private _reason = (while { true } do {

        uisleep 1;
        if( isEngineOn _vehicle ) exitWith { "Abgebrochen" };
        if( fuel _vehicle <= 0.05 ) exitWith { "Kein Benzin mehr" };
        if( (_trunkWeight + _itemWeight) > _maxWeight ) exitWith { "Der Gerät ist voll" };

        _weightGathered = _weightGathered + _weightPerSecond;

        if( time >= _nextEvent ) then {
            // Mining event!
            _nextEvent = time + 10 + (random 5);

            // Reduce fuel...
            private _fuel = 0 max ((fuel _vehicle) - 0.0085);
            [_vehicle, _fuel] remoteExec ["setFuel", _vehicle];

            private _maxItemCount = floor((_maxWeight - _trunkWeight) / _itemWeight);
            if( _maxItemCount < 1 ) exitWith {};

            private _itemCount = floor(_weightGathered / _itemWeight) min _maxItemCount;
            _weightGathered = _weightGathered - (_itemCount * _itemWeight);

            [XY_fnc_addItemToTrunk, [_item, _itemCount, _trunk]] call XY_fnc_unscheduled;
            _trunkWeight = [XY_fnc_getTrunkWeight, [_trunk]] call XY_fnc_unscheduled;

            diag_log format["[PROCESS VID %1] TRUNK: %2", _vid, _trunk];
            [0, format[ "Der Gerät hat %1x %2 gesammelt (%3 gesamt)", _itemCount, _itemConfig select 2, [XY_fnc_getItemCountFromTrunk, [_item, _trunk]] call XY_fnc_unscheduled]] remoteExec ["XY_fnc_broadcast", _player];
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