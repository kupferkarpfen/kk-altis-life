// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _shop = param[0, objNull, [objNull]];
private _robber = param[1, objNull, [objNull]];

if( isNull _shop || isNull _robber ) exitWith {};

if( playersNumber west < 4 ) exitWith {
    hint "Es müssen mindestens 4 Polizisten online sein!"
};
if( playerSide != civilian ) exitWith {
    hint "Du bist kein Zivilist!"
};
if (vehicle player != _robber) exitWith {
    hint "Raus aus dem Fahrzeug!"
};
if (currentWeapon player == "rangefinder" ) exitWith {
    hint "Echt jetzt? Wenn du ein Foto willst, dann fahr durch nen Blitzer. Verschwinde!"
};

if (currentWeapon player == "binocular") exitWith {
    hint "Ja ne is klar. Jetzt willst du mir die Netzhaut verbrennen oder? Verschwinde!"
};

if (currentWeapon player == "" ) exitWith {
    hint "Hau ab du Lappen. Leg dir mal ne Waffe zu."
};

if(_robber distance _shop > 3) exitWith {
    hint "Geh näher ran!"
};

// Check if last rob is not long enough ago:
if( _shop getVariable["locked", false] ) exitWith {
    hint "Die Kasse ist leer!";
};

// Three randomly delayed checks to prevent two players robbing simultaneously:
sleep random 0.2;
if( !(_shop getVariable["rip", false]) ) then {
    sleep random 0.2;
    if( !(_shop getVariable["rip", false]) ) then {
        sleep random 0.2;
    };
};
if( _shop getVariable["rip", false] ) exitWith {
    hint "Hier läuft bereits ein Raub!";
};

if( XY_actionInUse ) exitWith {};
XY_actionInUse = true;

// Launch cooldown server-side to prevent deadlocking when client disconnects
[_shop] remoteExec ["XY_fnc_robCooldown", 2];
[_shop] remoteExec ["XY_fnc_dangerMarker", 2];

// Lock the shop:
_shop setVariable["rip", true, true];

private _shopName = _shop getVariable["location", "ERROR"];

hint "Bleib in der Nähe!";

private _informed = false;

disableSerialization;
private _duration = 150 + floor(random 50);
private _cp = 0;
private _startTime = time;
private _timeOut = _startTime + _duration;
private _interrupted = true;

5 cutRsc ["XY_progressBar", "PLAIN"];
private _ui = uiNamespace getVariable "XY_progressBar";
private _progressBar = _ui displayCtrl 38201;
private _progressText = _ui displayCtrl 38202;

while { alive player && !XY_isTazed && !(player getVariable["restrained", false]) && (animationState player) != "incapacitated" && !(currentWeapon player == "binocular") && !(currentWeapon player == "rangefinder" ) && !(currentWeapon player == "" ) && _robber distance _shop <= 10 } do {

    _cp = (time - _startTime) / (_timeOut - _startTime);

	_progressBar progressSetPosition _cp;
	_progressText ctrlSetText format["Tankstellenraub läuft (%1%2)", round(_cp * 100), "%"];

    if(_cp >= 1) exitWith {
        _interrupted = false;
    };

    // Zufallschance wann die Polizei informiert wird:
    if( _cp > 0.05 && (random(100)) < 15 && !_informed ) then {
        _informed = true;
        hint "Der Kassierer hat heimlich die Polizei informiert!";
        [ [0, 1], format["ALARM! Tankstelle %1 wird überfallen!", _shopName ]] remoteExec ["XY_fnc_broadcast", [west, 2] ];
    };
    sleep 0.25;
};

5 cutText ["", "PLAIN"];
XY_actionInUse = false;
_shop setVariable["rip", false, true];

if( _interrupted ) exitWith {
    hint localize "STR_NOTF_ActionCancel";
};
_shop setVariable["locked", true, true];

private _cash = 150 + floor(random 200);

hint format["Du hast %1€ geklaut und die Polizei ist auf dem Weg, nichts wie weg hier!", [_cash] call XY_fnc_numberText];
[_cash, true] call XY_fnc_addMoney;

// ATM deaktivieren
XY_atmUsable = false;
[] spawn {
    scriptName "ATM cooldown";
    sleep 300;
    XY_atmUsable = true;
};

// News verteilen
[[0, 1], format["110 - Tankstelle %1 wurde von %2 ausgeraubt! Beute: %3€", _shopName, [profileName, "maskierter Person"] select ([player] call XY_fnc_playerMasked), [_cash] call XY_fnc_numberText]] remoteExec ["XY_fnc_broadcast", [west, 2]];
[0, format["NEWS: Tankstelle %1 wurde ausgeraubt: Der Täter erbeutete %2€!", _shopName, [_cash] call XY_fnc_numberText]] remoteExec ["XY_fnc_broadcast", civilian];

// Wanted-Liste
if( !([player] call XY_fnc_playerMasked) || ((random 100) < 50) ) then {
    [getPlayerUID player, "120"] remoteExec ["XY_fnc_wantedAdd", 2];
};