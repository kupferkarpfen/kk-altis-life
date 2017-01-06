// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _group = param[0, grpNull, [grpNull]];

if( isNull _group ) exitWith { diag_log "<ERROR> updateGang NULL GRP 1" };

// Wait for variables to sync...
uisleep 1;

private _members = _group getVariable ["members", []];
private _moderators = _group getVariable ["moderators", []];
private _maxMembers = _group getVariable ["maxMembers", 4];
private _owner = _group getVariable ["owner", ""];
private _groupID = _group getVariable["id", -1];

if( _groupID isEqualTo -1 ) exitWith {
    diag_log format["<ERROR> updateGang, gang id empty, %1", _group];
};
if( _owner isEqualTo "" ) exitWith {
    diag_log format["<ERROR> updateGang, gang owner empty, %1, %2", _group, _groupID];
};
if( _members isEqualTo [] ) exitWith {
    diag_log format["<ERROR> updateGang, gang members empty, %1, %2", _group, _groupID];
};

if( !(_owner in _members) ) then {
    _members pushBack _owner;
    _group setVariable[ "members", _members, true ];
};

[format["updateGang:%1:%2:%3:%4:%5", _members, _moderators, _maxMembers, _owner, _groupID]] call XYDB_fnc_asyncCall;