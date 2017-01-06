// CTF capture module
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _flagpole = param[ 0, ObjNull, [ObjNull] ];
private _city = param[ 3, "", [""] ];

if( isNull _flagpole || _city == "" ) exitWith {};

if( !(_flagPole getVariable[ "ctfActive", false ]) ) exitWith {
    hint "Die Polizei muss erst die Bevölkerung alarmieren, bevor die Stadt erobert werden kann";
};

if( (currentWeapon player) in ["", "binocular", "rangefinder"] ) exitWith {
    hint "Haha, ohne Waffe eroberst du garnichts";
};

if( XY_actionInUse ) exitWith {};
XY_actionInUse = true;

[[0, 1], format["ALARM! Flagge in %1 wird erobert!", _city]] remoteExec ["XY_fnc_broadcast", [west, 2]];

disableSerialization;

private _duration = 180;
private _cp = 0;
private _startTime = time;
private _timeOut = _startTime + _duration;
private _interrupted = true;

5 cutRsc ["XY_progressBar", "PLAIN"];
private _ui = uiNamespace getVariable "XY_progressBar";
private _progressBar = _ui displayCtrl 38201;
private _progressText = _ui displayCtrl 38202;

while { alive player && !XY_isTazed && !(player getVariable["restrained", false]) && player distance _flagpole <= 15 && _flagPole getVariable[ "ctfActive", false ] } do {

    _cp = (time - _startTime) / (_timeOut - _startTime);
    _progressBar progressSetPosition _cp;
    _progressText ctrlSetText format["Erobere Stadt... (%1%2)", round(_cp * 100), "%"];

    if( time >= _timeOut ) exitWith {
        _interrupted = false;
    };
    sleep 0.25;
};

5 cutText ["","PLAIN"];
XY_actionInUse = false;

if(_interrupted) exitWith {
    hint localize "STR_NOTF_ActionCancel";
};

[player, _flagpole, "capture", _city] remoteExec ["XY_fnc_ctf", 2];

sleep 2;
XY_actionInUse = false;