// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private["_unit","_duration","_ui","_progress","_progressText","_cp","_startTime","_timeOut","_interrupted","_animTarget"];

closeDialog 0;

_unit = cursorTarget;

if( XY_actionInUse ) exitWith {};
if( isNull _unit ) exitWith {};
if (vehicle player != player) exitWith {};

if( !(_unit isKindOf "Car") && !(_unit isKindOf "Air") ) exitWith {
    hint "Du kannst hier keinen Tracker anbringen!";
};

XY_actionInUse = true;
XY_interrupted = false;

// KK: Holster weapon:
if( currentWeapon player != "" ) then {
    XY_currentWeaponToRecall = currentWeapon player;
    player action ["SwitchWeapon", player, player, 100];
    player switchcamera cameraView; // << What is this needed for?
    sleep 3;
};

disableSerialization;

_duration = 8;

_cp = 0;
_startTime = time;
_timeOut = _startTime + _duration;
_animTarget = time;
_interrupted = true;

5 cutRsc ["XY_progressBar", "PLAIN"];
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
    _progressText ctrlSetText format[ "%1 (%2%3)", "Montiere Tracker...", round(_cP * 100), "%" ];

    if( _cp >= 1 ) exitWith {
        _interrupted = false;
    };

    uisleep 0.25;
};

XY_actionInUse = false;

5 cutText ["", "PLAIN"];
player playActionNow "stop";

if (!(["tracker", 1] call XY_fnc_removeItemFromTrunk)) then {
    _interrupted = true;
};

if( _interrupted ) exitWith {
    hint localize "STR_NOTF_ActionCancel";
};

[getPlayerUID player, 21, format ["Auto von %1 (%2) verwanzt @ %3", _unit getVariable[ "ownerName", "ERROR" ], _unit getVariable[ "owner", "ERROR" ], mapGridPosition player ]] remoteExec ["XYDB_fnc_log", XYDB];
[_unit getVariable[ "owner", "ERROR" ], 21, format ["Auto wurde von %1 (%2) verwanzt @ %3", profileName, getPlayerUID player, mapGridPosition player ]] remoteExec ["XYDB_fnc_log", XYDB];

XY_trackerVehicle = _unit;
XY_trackerTimeout = time + (45 * 60);
hint "Tracker wurde montiert, die Batterie hält 45 Minuten";