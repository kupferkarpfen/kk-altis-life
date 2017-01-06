// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _unit = param[0, objNull, [objNull]];
private _gangName = param[1, "", [""]];

if( _unit isEqualTo objNull || _gangName isEqualTo "" || (_gangName find ":") >= 0 ) exitWith {};

private _group = group _unit;
private _uid = getPlayerUID _unit;

if( !(([ format["selectGangByName:%1", _gangName], true] call XYDB_fnc_asyncCall) isEqualTo []) ) exitWith {
    ["Es gibt schon eine Gang mit dem Namen, wähle bitte einen anderen Namen"] remoteExec ["XY_fnc_gangCreated", _unit];
};
if( !(([format["selectGangByMember:%2%1%2:%1", _uid, "%"], true] call XYDB_fnc_asyncCall) isEqualTo []) ) exitWith {
    ["Du bist derzeit schon in einer Gang, verlasse diese erstmal"] remoteExec ["XY_fnc_gangCreated", _unit];
};

private _moderators = [];
private _gangMembers = [_uid];

private _queryResult = [format["insertGang:%1:%2:%3:%4:%5", _uid, _gangName, _gangMembers, _moderators, 4], true] call XYDB_fnc_asyncCall;
diag_log format["insertGang result: %1", _queryResult];

_group setVariable["id", _queryResult select 0, true];
_group setVariable["name", _gangName, true];
_group setVariable["bank", 0, true];
_group setVariable["owner", _uid, true];
_group setVariable["maxMembers", 4, true];
_group setVariable["members", [_uid], true];
_group setVariable["moderators", [], true];

[""] remoteExec ["XY_fnc_gangCreated", _unit];