// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _vehicle = param[0, objNull, [objNull]];
private _color = lbValue[2302, lbCurSel 2302];

if( _color < 0 ) exitWith {
    hint "Keine Farbe ausgewählt";
};

closeDialog 0;

if( _vehicle getVariable["id", -1] < 0 ) exitWith {
    hint "Mietfahrzeuge können nicht umlackiert werden";
};
if( XY_actionInUse ) exitWith {
    hint "Du bist grad anderweitig beschäftigt";
};
XY_actionInUse = true;

disableSerialization;

private _duration = 60;

private _cp = 0;
private _startTime = time;
private _timeOut = _startTime + _duration;
private _animTarget = time;
private _interrupted = true;

5 cutRsc ["XY_progressBar", "PLAIN"];
private _ui = uiNameSpace getVariable "XY_progressBar";
private _progress = _ui displayCtrl 38201;
private _progressText = _ui displayCtrl 38202;

while { alive player && player isEqualTo (vehicle player) && !XY_isTazed && !(player getVariable["restrained", false]) && player distance _vehicle <= 10 } do {
    if( _animTarget <= time ) then {
        _animTarget = time + 9;
        [player, "spraycan"] remoteExecCall ["say3D", playableUnits select { isPlayer _x && { (_x distance player) < 100 } }];
    };

    _cp = (time - _startTime) / (_timeOut - _startTime);
    _progress progressSetPosition _cp;
    _progressText ctrlSetText format["%1 (%2%3)", format[ "Lackiere %1", getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName") ], round (_cp * 100), "%"];

    if(_cp >= 1) exitWith {
        _interrupted = false;
    };
    sleep 0.25;
};

5 cutText ["", "PLAIN"];
XY_actionInUse = false;

if( _interrupted ) exitWith {
    hint localize "STR_NOTF_ActionCancel";
};

[_vehicle, _color] remoteExec ["XYDB_fnc_vehicleRepaint", XYDB];
[_vehicle, _color, civilian] call XY_fnc_setVehicleColor;

hint "Fahrzeug wurde umlackiert";