// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _name = param[0, "", [""]];
private _group = param[1, grpNull, [grpNull]];
private _perm = param[2, false, [false]];

if( _name isEqualTo "" || isNull _group ) exitWith {};

if( _perm && (group player) getVariable ["id", -1] >= 0 ) exitWith {
    hint "Du hast eine Einladung erhalten, bist aber schon in einer Gang"
};

if( player getVariable ["restrained", false] ) exitWith {};

_gangName = _group getVariable ["name", ""];
if( _gangName isEqualTo "" ) exitWith {};

private _action = [
    [format["Du wurdest von %1 temporär in die Gang %2 eingeladen, willst du dies annehmen? Falls du bereits in einer Gang bist verlässt du diese dadurch nicht, sobald du neu verbindest bist du wieder in deiner alten Gang.", _name, _gangName], format["Du wurdest von %1 in die Gang %2 eingeladen, willst du die Einladung annehmen?", _name, _gangName]] select _perm,
    "Gang-Einladung",
    localize "STR_Global_Yes",
    localize "STR_Global_No"
] call XY_fnc_showQuestionbox;

player setVariable["invited", false, true];

if( !_action ) exitWith {
    hint format ["Du hast die Einladung in die Gang %1 abgelehnt", _gangName];
};

[player] join _group;

if ( _perm ) then {
    private _members = _group getVariable ["members", []];
    private _uid = getPlayerUID player;
    if( !(_uid in _members) ) then {
        _members pushBack _uid;
        _group setVariable["members", _members, true];
        [_group] remoteExec ["XYDB_fnc_updateGang", XYDB];
    };
    hint format ["Du gehörst nun zur Gang %1", _gangName];
} else {
    hint format ["Du gehörst nun temporär zur Gang %1, bis du die Verbindung trennst", _gangName];
};