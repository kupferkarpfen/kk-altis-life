// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// TODO: This is a leftover from the migration process, replace ASAP with KVS based solution

private _vehicle = param[ 0, objNull, [objNull]];
if( isNull _vehicle ) exitWith {};

private _vid = _vehicle getVariable["id", -1];
if( _vid < 0 ) exitWith {};

private _chip = 0;
if( _vehicle getVariable["chip.enabled", false] ) then {
    _chip = _vehicle getVariable["chip.type", 0];
};

[ format["updateVehicleData:%1:%2", _chip, _vid] ] call XYDB_fnc_asyncCall;