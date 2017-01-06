// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

closeDialog 0;

private _unit = cursorTarget;

if( XY_actionInUse ) exitWith {};
if( isNull _unit ) exitWith {};

if( !(_unit isKindOf "Car") ) exitWith {
    hint "Du kannst hier keinen Radarwarner einbauen";
};
if( !(_unit getVariable["radarwarner", true]) ) exitWith {
    hint "Das Fahrzeug hat einen Radarwarner";
};
if (vehicle player != player) exitWith {};

XY_actionInUse = true;
XY_interrupted = false;

// KK: Holster weapon:
if( currentWeapon player != "" ) then {
    XY_currentWeaponToRecall = currentWeapon player;
    player action ["SwitchWeapon", player, player, 100];
    player switchcamera cameraView; // << What is this needed for?
    sleep 1;
};

disableSerialization;

_duration = 10;

_cp = 0;
_startTime = time;
_timeOut = _startTime + _duration;
_animTarget = time;
_interrupted = true;

5 cutRsc ["XY_progressBar","PLAIN"];
_ui = uiNamespace getVariable "XY_progressBar";
_progressBar = _ui displayCtrl 38201;
_progressText = _ui displayCtrl 38202;

_animCounter = 0;
while { alive player && !XY_isTazed && !XY_interrupted && !(player getVariable["restrained", false]) && player distance _unit <= 10 } do {

    if( _animTarget <= time ) then {
        _animTarget = time + 2;
        [player, "AinvPknlMstpSnonWnonDnon_medic_1"] remoteExec ["XY_fnc_animSync", -2];
    };

    _cp = (time - _startTime) / (_timeOut - _startTime);
    _progressBar progressSetPosition _cP;
    _progressText ctrlSetText format[ "%1 (%2%3)", "Montiere Radarwarner...", round(_cP * 100), "%" ];

    if( _cp >= 1 ) exitWith {
        _interrupted = false;
    };

    uisleep 0.25;
};

XY_actionInUse = false;

5 cutText ["","PLAIN"];
player playActionNow "stop";

if (!(["radarwarner", 1] call XY_fnc_removeItemFromTrunk)) then {
    _interrupted = true;
};

if( _interrupted ) exitWith {
    hint localize "STR_NOTF_ActionCancel";
};

_unit setVariable["radarwarner", true, true];
hint "Radarwarner wurde eingebaut";