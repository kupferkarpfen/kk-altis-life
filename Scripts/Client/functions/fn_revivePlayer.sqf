// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
private _target = param[0, objNull, [objNull]];
if( isNull _target ) exitWith {};

private _revivable = _target getVariable["revive", false];
if( _revivable || player distance _target > 5 ) exitWith {};

if( _target getVariable ["reviving", objNull] == player) exitWith {
    hint localize "STR_Medic_AlreadyReviving";
};

XY_interrupted = false;
XY_actionInUse = true;
_target setVariable["reviving", player, true];

disableSerialization;
private _duration = 30;

private _cp = 0;
private _startTime = time;
private _timeOut = _startTime + _duration;
private _animTarget = time;
private _interrupted = true;

5 cutRsc ["XY_progressBar", "PLAIN"];
private _ui = uiNamespace getVariable "XY_progressBar";
private _progressBar = _ui displayCtrl 38201;
private _titleText = _ui displayCtrl 38202;

private _animCounter = 0;
while { alive player && !XY_isTazed && !XY_interrupted && !(player getVariable["restrained", false]) && !(_target getVariable["revive", false]) && (_target getVariable["reviving", objNull]) isEqualTo player } do {
    if( _animTarget <= time ) then {
        _animTarget = time + 2;
        [player, "AinvPknlMstpSnonWnonDnon_medic_1"] remoteExec ["XY_fnc_animSync", -2];
    };

    _cp = (time - _startTime) / (_timeOut - _startTime);
    _progressBar progressSetPosition _cp;
    _titleText ctrlSetText format[ "%1 (%2%3)", localize "STR_Medic_Progress", round(_cp * 100), "%" ];

    if( _cp >= 1 ) exitWith {
        _interrupted = false;
    };
    uisleep 0.25;
};

5 cutText ["", "PLAIN"];

XY_interrupted = false;
XY_actionInUse = false;

private _targetName = _target getVariable ["realName", "ERROR"];
private _targetUID = _target getVariable ["steam64ID", "ERROR"];

[getPlayerUID player, 22, format ["Wiederbelebung von %1 (%2) @ %3", _targetName, _targetUID, mapGridPosition player ]] remoteExec ["XYDB_fnc_log", XYDB];
[_targetUID, 22, format ["Wiederbelebt von %1 (%2) @ %3", profileName, getPlayerUID player, mapGridPosition player ]] remoteExec ["XYDB_fnc_log", XYDB];

_target setVariable["reviving", nil, true];

if( _interrupted ) exitWith {
    if( _target getVariable["revive", false] ) then {
        hint localize "STR_Medic_RevivedRespawned"
    } else {
        hint localize "STR_NOTF_ActionCancel";
    };
};

if( !(playerSide isEqualTo independent) ) then {
    player removeItem "MediKit";
};

_target setVariable["revive", true, true];

if( playerSide isEqualTo independent ) then {
    XY_CA = XY_CA + 250;
    hint "Du hast 250€ für deine Hilfe erhalten";
};

[profileName] remoteExec ["XY_fnc_revived", _target];