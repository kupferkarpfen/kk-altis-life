// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _speedy = param[ 0, false, [false] ];

if( player getVariable ["restrained", false] || player getVariable ["escorting", false] || XY_isArrested || XY_isTazed || !XY_atmUsable ) exitWith {
    hint "Für dich ist leider kein Taxi verfügbar";
};

private _index = lbCurSel 48402;
if( _index < 0 ) exitWith {};

private _loc = lbData[48402, _index];
if( count _loc == 0) exitWith {};

private _sp = getMarkerPos _loc;
if( count _sp == 0) exitWith {};

private _price = lbValue[48402, (lbCurSel 48402)];
if(_price < 0) exitWith {};

private _distance = player distance _sp;
private _duration = round( _distance / 1000 * ( if( _speedy ) then { 2 } else { 6 } ) );

closeDialog 0;

if( !([_price] call XY_fnc_pay) ) exitWith {
    hint "Du hast nicht genug Geld!";
};

cutText["Transfer...", "BLACK FADED", 5];

// Play random music...
private _music = [];
private _cfg = configFile >> "CfgMusic";
for "_i" from 0 to count _cfg - 1 do {
    private _class = _cfg select _i;
    if( isClass _class ) then {
        private _track = configName _class;
        if( ((toLower _track) find "radio") < 0 ) then {
            _music pushBack _track;
        };
    };
};

playMusic selectRandom _music;

sleep 5;
0 cutFadeOut 9999999;
player setPos getMarkerPos "respawn_civilian";

private _target = time + _duration;

while { time <= _target } do {
    sleep 5;
};

player setPos _sp;
cutText ["Ziel erreicht", "BLACK IN", 5];

private _volume = musicVolume;
5 fadeMusic 0;
sleep 5;

playMusic "";
0 fadeMusic _volume;