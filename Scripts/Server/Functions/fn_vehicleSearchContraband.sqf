// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

diag_log format["vehicleSearchContraband(%1)", _this];
if( canSuspend ) exitWith {
    diag_log "CALLED VEGUCKE SEARCH CONTRABAND SUSPENDABLE, EXITING";
};

private _player = param[0, objNull, [objNull]];
private _vehicle = param[1, objNull, [objNull]];
if( isNull _player || isNull _vehicle ) exitWith {};

if( !(_vehicle isKindOf "Air" || _vehicle isKindOf "Ship" || _vehicle isKindOf "Car") ) exitWith {};

private _trunkOwner = _vehicle getVariable ["trunk.owner", ""];
if( _vehicle getVariable ["busy", false] || !(_trunkOwner isEqualTo "") && ([_trunkOwner] call XY_fnc_onlineUID) ) exitWith {
    [1, format[XY_hintError, "Laderraum nicht verfügbar"]] remoteExec ["XY_fnc_broadcast", _player];
};

private _vid = _vehicle getVariable["id", -1];
if( _vid >= 0 && { !(_vehicle getVariable["trunk.loaded", false]) } ) then {
    [_player, _vehicle] spawn { scriptName "SearchVehicleLoadTrunk";
        [_this select 1] call XYDB_fnc_loadTrunk;
        [_this select 0, _this select 1] remoteExecCall ["XY_fnc_vehicleSearchContraband", 2];
    };
};
private _trunk = _vehicle getVariable["trunk", []];

private _vehicleInfo = _vehicle getVariable ["trunk", []];

private _value = 0;
{
    private _item = _x select 0;
    private _count = _x select 1;

    private _config = [_item] call XY_fnc_itemConfig;
    if( (_config select 5) && (_config select 4) > 0) then {
        _value = _value + (((_config select 4) * 0.5) * _count);
    };
} forEach _trunk;

if( _value < 1 ) exitWith {
    [1, format[XY_hintError, "Keine illegale Ladung"]] remoteExec ["XY_fnc_broadcast", _player];
};
_vehicle setVariable["trunk", []];
if( _vid >= 0 && { !(_vehicle getVariable["trunk.loaded", false]) } ) then {
    [_vehicle] call XYDB_fnc_loadTrunk;
};

[0, format["Ein Fahrzeug wurde durchsucht und es wurden illegale Waren im Wert von %1€ gefunden", [_value] call XY_fnc_numberText]] remoteExec ["XY_fnc_broadcast"];
[getPlayerUID _player, 2, format ["Erhält %1€ für beschlagnahmte Items aus %2 @ %3", [_value] call XY_fnc_numberText, _vehicle, mapGridPosition player]] remoteExec ["XYDB_fnc_log", XYDB];

[_value, true] remoteExecCall ["XY_fnc_addMoney", _player];