// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _hideoutName = param[3, "", [""]];
if( _hideoutName isEqualTo "" ) exitWith {};

private _hideout = missionNamespace getVariable [ _hideoutName, "" ];
if( _hideout isEqualTo objNull ) exitWith {};

private _group = _hideout getVariable ["ownedBy", grpNull];
private _duration = 50;

if( count ((group player) getVariable ["name", ""]) < 1 ) exitWith {
    hint localize "STR_GNOTF_CreateGang";
};
if( _group isEqualTo (group player) ) exitWith {
    hint localize "STR_GNOTF_Controlled"
};
if( _hideout getVariable ["inCapture", false] ) exitWith {
    hint localize "STR_GNOTF_Captured";
};
if( !(_group isEqualTo grpNull) ) then {
    private _action = [
        format[localize "STR_GNOTF_AlreadyControlled", _group getVariable ["name", "ERROR"]],
        localize "STR_GNOTF_CurrentCapture",
        localize "STR_Global_Yes",
        localize "STR_Global_No"
    ] call XY_fnc_showQuestionbox;

    if( !_action ) exitWith {
        hint localize "STR_GNOTF_CaptureCancel";
    };
    _duration = 90; // 90 Sekunden wenn das Versteck bereits in Besitz ist
};

XY_interrupted = false;
XY_actionInUse = true;

_hideout setVariable["inCapture", true, true];

// KK: Holster weapon:
if( currentWeapon player != "" ) then {
    XY_currentWeaponToRecall = currentWeapon player;
    player action ["SwitchWeapon", player, player, 100];
    player switchcamera cameraView; // << What is this needed for?
    sleep 1;
};

disableSerialization;

private _cp = 0;
private _startTime = time;
private _timeOut = _startTime + _duration;
private _animTarget = time;
private _interrupted = true;

5 cutRsc ["XY_progressBar", "PLAIN"];
private _ui = uiNamespace getVariable "XY_progressBar";
private _progressBar = _ui displayCtrl 38201;
private _titleText = _ui displayCtrl 38202;

while { alive player && !XY_isTazed && !XY_interrupted && !(player getVariable["restrained", false]) } do {

    if( _animTarget <= time ) then {
        _animTarget = time + 2;
        [player, "AinvPknlMstpSnonWnonDnon_medic_1"] remoteExec ["XY_fnc_animSync", -2];
    };

    _cp = (time - _startTime) / (_timeOut - _startTime);
    _progressBar progressSetPosition _cp;
    _titleText ctrlSetText format[ "%1 (%2%3)", localize "STR_GNOTF_Capturing", round(_cp * 100), "%" ];
    if( _cp >= 1 ) exitWith {
        _interrupted = false;
    };
    sleep 0.35;
};

5 cutText ["","PLAIN"];
player playActionNow "stop";

XY_actionInUse = false;
_hideout setVariable["inCapture", false, true];

if( _interrupted ) exitWith {
    hint localize "STR_GNOTF_CaptureCancel";
};
_hideout setVariable["ownedBy", (group player), true];
hint "Gangversteck erobert!";

[ [0, 1], format[ localize "STR_GNOTF_CaptureSuccess", profileName, (group player) getVariable "name" ] ] remoteExec ["XY_fnc_broadcast"];