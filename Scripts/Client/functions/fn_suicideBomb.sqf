// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

if( (vest player) != "V_HarnessOGL_brn") exitWith {};

if( XY_IN_SAFEZONE ) exitWith {
    hint "Deine Bombe hat eine Fehlfunktion und du bekommst einen starken Stromschlag. Gute Nacht!";
    player unassignItem "V_HarnessOGL_brn";
    player removeItem "V_HarnessOGL_brn";
    sleep 3;
    player setDamage 1;
    [0, format["%1 wollte einen Selbstmordanschlag begehen, aber hat dabei NUR sein eigenes Leben verloren da er einen Stromschlag bekommen hat!", profileName]] remoteExec ["XY_fnc_broadcast"];
};

private _action = [
    "Willst du den Knaller wirklich zünden? ACHTUNG: Du darst dies nur in einem RP und nicht in einer Safezone tun!",
    "Zünden?",
    "ZÜNDEN!",
    "ABBRUCH"
] call XY_fnc_showQuestionbox;

if( !_action ) exitWith {
    hint "Abgebrochen";
};

[0, format["%1 hat ein Selbstmordattentat begangen!", profileName]] remoteExec ["XY_fnc_broadcast"];
player unassignItem "V_HarnessOGL_brn";
player removeItem "V_HarnessOGL_brn";
[getPos player] remoteExec ["XY_fnc_bomb", 2];

uisleep 1;
if( alive player ) then {
    player setDamage 1;
};