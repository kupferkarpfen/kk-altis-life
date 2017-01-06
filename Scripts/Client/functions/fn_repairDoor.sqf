// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// based on work by Tonic

private _building = param[0, objNull, [objNull]];

if( isNull _building || { !(_building isKindOf "House_F") } ) exitWith {};
private _isBank = XY_FED_DOME isEqualTo _building || XY_FED_RSB isEqualTo _building;

private _doors = getNumber(configFile >> "CfgVehicles" >> (typeOf _building) >> "NumberOfDoors");

private _door = 0;
private _doorPosition = [];
for "_i" from 1 to _doors do {
    _doorPosition = _building modelToWorld (_building selectionPosition format["Door_%1_trigger", _i]);
    if( player distance _doorPosition < 5 ) exitWith {
        _door = _i;
    };
};
if( _door <= 0 ) exitWith {
    hint "Du bist nicht in der Nähe einer Tür";
};
if( (_building getVariable[format["bis_disabled_Door_%1", _door], 0]) == 1 ) exitWith {
    hint "Die Tür ist bereits versperrt";
};
XY_actionInUse = true;

closeDialog 0;

disableSerialization;

private _duration = [30, 60] select _isBank;

private _cp = 0;
private _startTime = time;
private _timeOut = _startTime + _duration;
private _animTarget = time;
private _interrupted = true;

5 cutRsc ["XY_progressBar", "PLAIN"];
private _ui = uiNameSpace getVariable "XY_progressBar";
private _progress = _ui displayCtrl 38201;
private _progressText = _ui displayCtrl 38202;

while { alive player && player isEqualTo vehicle player && !XY_interrupted && !(player getVariable["restrained", false]) && player distance _doorPosition <= 10 } do {
    if( _animTarget <= time ) then {
        _animTarget = time + 5.5;
        player playAction "medicStartUp";
    };

    _cp = (time - _startTime) / (_timeOut - _startTime);
    _progress progressSetPosition _cp;
    _progressText ctrlSetText format["Repariere Tür (%1%2)", round (_cp * 100), "%"];

    if(_cp >= 1) exitWith {
        _interrupted = false;
    };
    sleep 0.25;
};

5 cutText ["", "PLAIN"];
player playActionNow "stop";
XY_actionInUse = false;

if( _interrupted ) exitWith {
    XY_interrupted = false;
    hint "Abgebrochen";
};

_building animate [format["door_%1_rot", _door], 0];
_building setVariable[format["bis_disabled_Door_%1", _door], 1, true];
if( _isBank ) then {
    fed_bank setVariable[ format["door.open.%1", _door], false, true ];
};