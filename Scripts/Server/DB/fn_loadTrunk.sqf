// Written by Kupferkarpfens
// License: CC BY-NC-SA 4.0

diag_log format["loadTrunk(%1)", _this];

private _vehicle = param[0, objNull, [objNull]];

if( _vehicle getVariable["trunk.loaded", false] ) exitWith {};

private _vid = _vehicle getVariable["id", -1];

private _queryResult = ([format["selectVehicleTrunkByID:%1", _vid], true] call XYDB_fnc_asyncCall) select 0;
diag_log format["GOT trunk for player (%1) = %2", _this, _queryResult];
_vehicle setVariable["trunk.loaded", true];
_vehicle setVariable["trunk", _queryResult select 0];