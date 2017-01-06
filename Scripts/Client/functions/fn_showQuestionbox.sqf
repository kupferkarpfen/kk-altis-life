// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
//
// Shows a BIS_fnc_guiMessage with a default action if dead or timed out

private _message = param[0, "", [""]];
private _title = param[1, "", [""]];
private _yesCaption = param[2, "", [""]];
private _noCaption = param[3, "", [""]];
private _timeout = param[4, 30, [0]];
private _defaultResponse = param[5, false, [false]];
private _allowRestrainedAndTazed = param[6, false, [false]];

if( _message isEqualTo "" ) exitWith {_defaultResponse };

XY_SQ_response = _defaultResponse;
XY_SQ_open = true;

_this spawn { scriptName "ShowMessageBox";
    XY_SQ_response = [
        _this select 0,
        _this select 1,
        _this select 2,
        _this select 3
        ] call BIS_fnc_guiMessage;
    XY_SQ_open = false;
};

private _maxTime = time + _timeout;
waitUntil { !XY_SQ_open || time >= _maxTime || !([] call XY_fnc_isAlive) || (!_allowRestrainedAndTazed && XY_isTazed) || (!_allowRestrainedAndTazed && (player getVariable["restrained", false])) || (!_allowRestrainedAndTazed && ((animationState player) isEqualTo "incapacitated")) };

private _useDefault = XY_SQ_open;

// Timeout, dead or something?
if( _useDefault ) then {
    // Force close dialog
    closeDialog 0;
    uiNamespace setVariable ["BIS_fnc_guiMessage_status", false];
};

// Wait until dialog has been closed and spawn'ed scope ended...
waitUntil { !XY_SQ_open };

private _response = [ XY_SQ_response, _defaultResponse ] select _useDefault;

// Free memory
XY_SQ_open = nil;
XY_SQ_response = nil;

_response;