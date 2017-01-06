// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _gangData = param[0, [], [[]]];

if( _gangData isEqualTo [] ) exitWith {};

private _gangID = _gangData param[0, -1, [0]];
private _gangOwner = _gangData param[1, "", [""]];
private _gangName = _gangData param[2, "", [""]];
private _gangMaxMembers = _gangData param[3, -1, [0]];
private _gangBank = _gangData param[4, -1, [0]];
private _gangMembers = _gangData param[5, [], [[]]];
private _gangModerators = _gangData param[6, [], [[]]];

if( _gangID < 0 || _gangOwner isEqualTo "" || _gangName isEqualTo "" || _gangMaxMembers < 0 || _gangBank < 0 || _gangMembers isEqualTo [] ) exitWith {
    diag_log format["Incorrect parameters for initGang: %1", _gangData];
};

// Some randomly delayed checks to whether the group has been created yet
sleep (random 3);
private _group = [_gangID] call XY_fnc_searchMyGang;
if( isNull _group ) then {
    sleep (random 3);
    _group = [_gangID] call XY_fnc_searchMyGang;
};
if( isNull _group ) then {
    sleep (random 3);
    _group = [_gangID] call XY_fnc_searchMyGang;
};

if( isNull _group ) then {

    // Create the group!
    _group = createGroup civilian;
    [player] joinSilent _group;

    _group setVariable["gang.id", _gangID, true];
    _group setVariable["gang.owner", _gangOwner, true];
    _group setVariable["gang.name", _gangName, true];
    _group setVariable["gang.maxMembers", _gangMaxMembers, true];
    _group setVariable["gang.bank", _gangBank, true];
    _group setVariable["gang.members", _gangMembers, true];
    _group setVariable["gang.moderators", _gangModerators, true];

} else {

    // Join existing group
    [player] joinSilent _group;
};