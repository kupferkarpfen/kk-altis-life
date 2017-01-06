// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _vehicle = vehicle player;
if( !(_vehicle isKindOf "Ship") ) exitWith {
    hint "Du musst dies auf einem Boot benutzen";
};
if( speed _vehicle > 4 ) exitWith {
    hint "Das Boot muss ruhig stehen um das Netz auszuwerfen";
};

if( _vehicle getVariable["fishnet.inuse", 0] > time ) exitWith {
    hint "Auf dem Boot hantiert schon jemand mit einem Fischernetz";
};

if( !((nearestObjects [player, ["Land_InfoStand_V2_F"], 500]) isEqualTo []) ) exitWith {
        hint "Du musst weiter auf's Meer hinaus fahren";
};

if( XY_actionInUse ) exitWith {};
XY_actionInUse = true;

closeDialog 0;

hint "Das Netz wurde ausgeworfen: Versuch' zu fahren (max. 20km/h) um deine Ausbeute zu erhöhen";

disableSerialization;
private _duration = 60;

_vehicle setVariable["fishnet.inuse", time + _duration, true];

private _cp = 0;
private _startTime = time;
private _timeOut = _startTime + _duration;
private _interrupted = true;

5 cutRsc ["XY_progressBar", "PLAIN"];
private _ui = uiNamespace getVariable "XY_progressBar";
private _progressBar = _ui displayCtrl 38201;
private _titleText = _ui displayCtrl 38202;

private _points = 80;
private _nextPoint = time;

while { alive player && (vehicle player) == _vehicle && speed _vehicle < 28 } do {

    _cp = (time - _startTime) / (_timeOut - _startTime);
    _progressBar progressSetPosition _cp;
    _titleText ctrlSetText format[ "Fischen... (%1%2)", round(_cp * 100), "%" ];

    if( time >= _nextPoint ) then {
        if( speed _vehicle < 21 ) then {
            _points = _points + (speed _vehicle);
        };
        _nextPoint = time + 2;
    };

    if( _cp >= 1 ) exitWith {
        _interrupted = false;
    };
    uisleep 0.25;
};

5 cutText ["", "PLAIN"];

XY_actionInUse = false;
_vehicle setVariable["fishnet.inuse", 0, true];

if( _interrupted || (random 100) < 8 ) exitWith {
    ["fishnet", 1] call XY_fnc_removeItemFromTrunk;
    hint "Das Netz ist abgerissen";
};

private _fish = [ "salema", "ornate", "mackerel", "tuna", "mullet", "catshark" ];
private _net = [];
while { _points > 0 } do {
    _net pushBack (_fish select (floor (random (count _fish))));
    _points = _points - 65;
};

private _message = "<t size='1' align='center'>Du hast das Netz eingeholt und folgendes gefangen:</t><br/>";
{
    if( (([] call XY_fnc_getTrunkWeight) >= XY_maxWeight) ) exitWith {
        _message = format["%1<br/><t color='#FF0000' size='0.75' align='center'>Inventar voll</t><br/>", _message];
    };
    [XY_fnc_addItemToTrunk, [_x, 1]] call XY_fnc_unscheduled;
    _message = format["%1<br/><t size='0.75' align='center'>%2</t>", _message, ([_x] call XY_fnc_itemConfig) select 2];
} forEach _net;

hint parseText _message;