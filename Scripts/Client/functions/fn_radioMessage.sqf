// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _headline = ctrlText 1400;
private _ticker = ctrlText 1401;

if( count _headline <= 0 ) exitWith {
    hint "Die Headline ist zu kurz";
};
if( count _ticker <= 0 ) exitWith {
    hint "Der Ticker-Text ist zu kurz";
};
if( count _headline > 50 ) exitWith {
    hint "Die Headline ist zu lang (Max. 50 Zeichen)";
};
if( count _ticker > 150 ) exitWith {
    hint "Der Ticker-Text ist zu lang (Max. 150 Zeichen)";
};
if( !([1000] call XY_fnc_pay) ) exitWith {
    hint "Du hast nicht genug Geld um eine Nachricht zu verschicken";
};

closeDialog 0;
hint "Die Nachricht wird gleich abgeschickt...";

if( !(isNil "radio_bullshit") ) then {
    radio_bullshit setVariable ["next", serverTime + 1800, true];
};

[ getPlayerUID player, 17, format ["NACHRICHT: %1 - %2", _headline, _ticker] ] remoteExec ["XYDB_fnc_log", XYDB];

[_headline, _ticker] spawn {
    sleep 5;
    [3, _this select 0, _this select 1] remoteExec ["XY_fnc_broadcast", civilian];
    sleep 20;
	[0, format["%1 - %2 - Gesendet von Spieler: %3", _this select 0, _this select 1, profileName]] remoteExec ["XY_fnc_broadcast"];
};