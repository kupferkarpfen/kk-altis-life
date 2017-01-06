// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _curTarget = cursorObject;

if( XY_actionInUse || player getVariable["restrained", false] ) exitWith {};
if( isNull _curTarget ) exitWith {};

if( player distance _curTarget > 8 || !((typeOf _curTarget) isEqualTo "Land_fs_feed_F") )exitWith {
    hint "Bitte schaue eine Zapfsäule an, um den Kanister aufzufüllen";
};

closeDialog 0;

XY_actionInUse = true;
XY_interrupted = false;

if( !([5] call XY_fnc_pay) ) exitWith {
    hint "Du hast keine 5€ zum Befüllen";
};

// KK: Holster weapon:
if( currentWeapon player != "" ) then {
    XY_currentWeaponToRecall = currentWeapon player;
    player action ["SwitchWeapon", player, player, 100];
    player switchcamera cameraView; // << What is this needed for?
    uisleep 4;
};

disableSerialization;

private _duration = 5;

private _cp = 0;
private _startTime = time;
private _timeOut = _startTime + _duration;
private _animTarget = time;
private _interrupted = true;

private _alarmed = false;

5 cutRsc ["XY_progressBar","PLAIN"];
private _ui = uiNamespace getVariable "XY_progressBar";
private _progressBar = _ui displayCtrl 38201;
private _progressText = _ui displayCtrl 38202;

private _animCounter = 0;
while { alive player && !XY_isTazed && !XY_interrupted && !(player getVariable["restrained", false]) } do {

    if( _animTarget <= time ) then {
        _animTarget = time + 2;
        [player, "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon"] remoteExec ["XY_fnc_animSync", -2];
    };

    _cp = (time - _startTime) / (_timeOut - _startTime);
    _progressBar progressSetPosition _cP;
    _progressText ctrlSetText format[ "Befülle Kanister (%1%2)", round(_cP * 100), "%" ];

    if( _cp >= 1 ) exitWith {
        _interrupted = false;
    };

    uisleep 0.333;
};

XY_actionInUse = false;

5 cutText ["","PLAIN"];
player playActionNow "stop";

if( !(["fuelE", 1] call XY_fnc_removeItemFromTrunk) ) then {
    _interrupted = true;
};

if( _interrupted ) exitWith {
    hint localize "STR_NOTF_ActionCancel";
};

hint "Kanister für 5€ aufgefüllt";

[XY_fnc_addItemToTrunk, ["fuelF", 1]] call XY_fnc_unscheduled;