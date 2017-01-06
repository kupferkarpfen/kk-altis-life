// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _player = param[0, objNull, [objNull]];
private _side = param[1, sideUnknown, [sideUnknown]];
private _type = param[2, "", [""]];

if( _player isEqualTo objNull || _type isEqualTo "" ) exitWith {};

private _uid = getPlayerUID _player;

private _sideName = switch(_side) do {
    case west:{"cop"};
    case civilian: {"civ"};
    case independent: {"med"};
    default {"ERROR"};
};

private _queryResult = [ format["selectVehicles:%1:%2:%3", _uid, _sideName, _type], true ] call XYDB_fnc_asyncCall;
if( (typeName _queryResult) isEqualTo "STRING" ) then {
    diag_log format["SERVER DB ERROR: %1", _queryResult];
    _queryResult = [];
};

["init", _queryResult] remoteExec ["XY_fnc_garageMenu", _player];