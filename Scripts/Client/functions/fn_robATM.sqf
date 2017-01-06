// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _shop = param[0, objNull, [objNull]];

if( !(alive player) ) exitWith {};

if( side player != civilian ) exitWith {
    hint "Du bist kein Zivilist"
};
if( player distance _shop > 3 ) exitWith {
    hint "Du bist zu weit weg"
};
if( vehicle player != player ) exitWith {
    hint "Steig aus deinem Fahrzeug aus"
};
if( west countSide playableUnits < 6 ) exitWith {
    hint "Es müssen mindestens 6 Polizisten online sein";
};

// Check if last rob is not long enough ago:
if( _shop getVariable["locked", false] ) exitWith {
    hint "Der Automat wurde bereits aufgebrochen";
};

if( (["boltcutter"] call XY_fnc_getItemCountFromTrunk < 1) ) exitWith {
    hint "Du brauchst einen Bolzenschneider";
};

// Three randomly delayed checks to prevent two players robbing simultaneously:
uisleep random 0.5;
if( !(_shop getVariable["rip", false]) ) then {
    uisleep random 0.5;
    if( !(_shop getVariable["rip", false]) ) then {
        uisleep random 0.5;
    };
};
if( _shop getVariable["rip", false] ) exitWith {
    hint "Dieser ATM wird bereits aufgeknackt!";
};

if( XY_actionInUse ) exitWith {};
XY_actionInUse = true;
XY_interrupted = false;

// KK: Holster weapon:
if( currentWeapon player != "" ) then {
    XY_currentWeaponToRecall = currentWeapon player;
    player action ["SwitchWeapon", player, player, 100];
    sleep 3;
};

// Launch cooldown server-side to prevent deadlocking when client disconnects
[_shop] remoteExec ["XY_fnc_robCooldown", 2];
[_shop] remoteExec ["XY_fnc_dangerMarker", 2];

// Lock the shop:
_shop setVariable["rip", true, true];

private _informed = false;

disableSerialization;
// Dauer: 240 - 360 Sekunden
private _duration = 240 + floor(random 120);
private _cp = 0;
private _startTime = time;
private _timeOut = _startTime + _duration;
private _animTarget = time;
private _interrupted = true;

5 cutRsc ["XY_progressBar", "PLAIN"];
private _ui = uiNamespace getVariable "XY_progressBar";
private _progressBar = _ui displayCtrl 38201;
private _progressText = _ui displayCtrl 38202;

while { alive player && !XY_isTazed && !(player getVariable["restrained", false]) && !XY_interrupted && player distance _shop <= 10 } do {

    if( _animTarget <= time ) then {
        _animTarget = time + 5.5;
        player playAction "medicStartUp";
    };

    _cp = (time - _startTime) / (_timeOut - _startTime);

    _progressBar progressSetPosition _cp;
    _progressText ctrlSetText format["ATM wird aufgebrochen (%1%2)", round(_cp * 100), "%"];

    if(_cp >= 1) exitWith {
        _interrupted = false;
    };

    _chance = random(100);
    // Zufallschance dass die Polizei informiert wird:
    if( _cp > 0.1 && _chance < 2 && !_informed ) then {
        _informed = true;
        hint "Du hast versehentlich den Alarm ausgelöst: Die Polizei wurde informiert!";
        [ [0, 1], format["ALARM! Geldautomat %1 wird überfallen!", _shop]] remoteExec ["XY_fnc_broadcast", [west, 2]];
    };
    sleep 0.25;
};
5 cutText ["","PLAIN"];

if( !_interrupted ) then {
    // Bolzenschneider entfernen
    if( !(["boltcutter", 1] call XY_fnc_removeItemFromTrunk) ) then {
        _interrupted = true;
    };
};

_shop setVariable["rip", false, true];
XY_actionInUse = false;

if( _interrupted ) exitWith {
    hint localize "STR_NOTF_ActionCancel";
};

_shop setVariable["locked", true, true];

// Beute: 1000 - 1800
private _cash = 1000 + floor(random 800);
hint format["Du hast %1€ gestohlen!", [_cash] call XY_fnc_numberText];

[_cash, true] call XY_fnc_addMoney;

XY_atmUsable = false;
[] spawn {
    scriptName "ATMCooldown";
    sleep 300;
    XY_atmUsable = true;
};

// News verteilen
[1, format["110 - ATM %1 wurde von %2 ausgeraubt! Beute: %3€", _shop, [profileName, "maskierter Person"] select ([player] call XY_fnc_playerMasked), [_cash] call XY_fnc_numberText]] remoteExec ["XY_fnc_broadcast", [west, 2]];
[0, format["NEWS: ATM %1 wurde ausgeraubt: Der Täter erbeutete %2€", _shop, [_cash] call XY_fnc_numberText]] remoteExec ["XY_fnc_broadcast", civilian];

// Wanted-Liste
if( !([player] call XY_fnc_playerMasked) || ((random 100) < 50) ) then {
    [getPlayerUID player, "121"] remoteExec ["XY_fnc_wantedAdd", 2];
};