// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

if( !([15, 1] call XY_fnc_pay) ) exitWith {
    hint "Du benötigst 15€ für eine Behandlung";
};

if( XY_actionInUse ) exitWith {};
XY_actionInUse = true;

hint "Bitte nicht bewegen...";

XY_interrupted = false;

private _pos = getPos player;
private _interrupted = true;

disableSerialization;

5 cutRsc ["XY_progressBar", "PLAIN"];
private _ui = uiNameSpace getVariable "XY_progressBar";
private _progress = _ui displayCtrl 38201;
private _progressText = _ui displayCtrl 38202;
_progressText ctrlSetText "Behandlung läuft...";

while { alive player && player isEqualTo vehicle player && !XY_isTazed && !XY_interrupted && !(player getVariable["restrained", false]) } do {

    _progress progressSetPosition (1 - (damage player));

    if( (damage player) <= 0.05) exitWith {
        _interrupted = false;
    };
    sleep 0.5;

    player setDamage ((damage player) - 0.0085);
};

5 cutText ["", "PLAIN"];

if( !_interrupted ) then  {
    player setDamage 0;
};

XY_actionInUse = false;