// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// shows a progressbar
// parameters:
// _duration = how long does it take to complete [s]
//             or animation to play ("repair"), which defines the duration
// _text = progress text (default: "Fortschritt")
// _object = bind progress to an object that has to stay within 10m of the player, (default: none)

disableSerialization;

private _duration = param[0, -1, [0, ""]];
private _text = param[1, "Fortschritt...", [""]];
private _object = param[2, objNull, [objNull]];

private _animation = {};
private _putbackWeapon = false;
private _interruptable = false;

if( (typeName _duration) isEqualTo "STRING" ) then {

    // Select animation source...
    _duration = switch (_duration) do {

        case "repair": {
            _putbackWeapon = true;
            _interruptable = true;
            _animation = {
                player playMoveNow "Acts_carFixingWheel";
            };
            22;
        };
        case "repackMagazines": {
            _putbackWeapon = false;
            _interruptable = true;
            _animation = {
                player switchMove "AinvPknlMstpSrasWrflDnon_G01";
            };
            16.6;
        };
        default {
            diag_log format["ERROR: undefined animation: %1", _duration];
            -1;
        };
    };
};

if( _duration < 0 ) exitWith {};

XY_actionInUse = true;

if( _object isEqualTo objNull ) then {
    _object = player;
};
if( _putbackWeapon && currentWeapon player != "" ) then {
    XY_currentWeaponToRecall = currentWeapon player;
    player action ["SwitchWeapon", player, player, 100];
    uisleep 2.9;
};

private _cp = 0;
private _startTime = time;
private _timeOut = _startTime + _duration;
private _interrupted = false;

5 cutRsc ["XY_progressBar", "PLAIN"];
private _ui = uiNamespace getVariable "XY_progressBar";
private _progressBar = _ui displayCtrl 38201;
private _progressText = _ui displayCtrl 38202;

private _animatorHandle = _animation spawn { scriptName "ProgressAnimator";
    call _this;
};

private _interrupted = true;
while { alive player && !XY_isTazed && (!_interruptable || !XY_interrupted) && (vehicle player) isEqualTo player && !(player getVariable["restrained", false]) && animationState player != "incapacitated" && player distance _object <= 10 } do {

    _cp = (time - _startTime) / _duration;
    _progressBar progressSetPosition _cp;
    _progressText ctrlSetStructuredText parseText format["<t size='1.1' align='center'>%1 (%2%3)</t>", _text, round(_cp * 100), "%"];

    if( time >= _timeOut ) exitWith {
        _interrupted = false;
    };
    uisleep 0.1;
};

if( !(scriptDone _animatorHandle) ) then {
    // incase the player aborted...
    terminate _animatorHandle;
};

5 cutText ["", "PLAIN"];
XY_actionInUse = false;

if( _interrupted ) exitWith {
    XY_interrupted = false;
    player playMoveNow "AmovPercMstpSnonWnonDnon";
    hint "Abgebrochen";
    false
};

true