// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// mildly "inspired" by the original from Tonic

private _time = param[0, -1, [0]];

if( _time < 1 || _time > 60 ) then {
    _time = 15;
};

player setVariable["restrained", false, true];
player setVariable["escorting", false, true];

XY_canPayBail = false;
XY_bailAmount = ( (1 max round( _time / 15)) * 1000 );

player setPos (getMarkerPos "jail_marker");

[0] call XY_fnc_removeLicenses;

// Remove all illegal stuff...
{
    if( _x select 5 ) then {
        private _count = [_x select 0] call XY_fnc_getItemCountFromTrunk;
        if( _count > 0 ) then {
            [XY_fnc_removeItemFromTrunk, [_x select 0, _count]] call XY_fnc_unscheduled;
        };
    };
} forEach XY_virtItems;

removeAllWeapons player;
{
    player removeMagazine _x
} forEach (magazines player);

XY_isArrested = true;
[KV_jailTime, _time] call XY_fnc_kvsPut;

call XY_fnc_save;

private _bailTime = _time / 2 * 60;
private _timeOut = time + _time * 60;
private _escaped = false;
private _nextSave = time + 300;

// make sure the jailed person can buy some food
if( XY_CC < 500 ) then {
    XY_CC = 500;
};

while { true } do {
    private _countdown = floor( _timeOut - time );

    if( !XY_canPayBail && _countdown < _bailTime ) then {
        XY_canPayBail = true;
    };

    hintSilent parseText format[XY_hintH1, format[XY_hintMsg, [ _countdown, "MM:SS" ] call BIS_fnc_secondsToString, format["%1<br/><br/>Kautionspreis: %2€", [ "Kautionszahlung nach halber Haftzeit möglich", "Kaution kann gezahlt werden" ] select XY_canPayBail, [XY_bailAmount] call XY_fnc_numberText ]]];

    if( !(call XY_fnc_isAlive) || XY_bailPaid ) exitWith {};
    if( player distance (getMarkerPos "jail_marker") > 60 ) exitWith {
        _escaped = true;
    };
    if( _countdown < 1 ) exitWith {
        hintSilent "";
    };
    if( _nextSave <= time ) then {
        _nextSave = time + 300;
        [ KV_jailTime, ceil(_countdown / 60) ] call XY_fnc_kvsPut;
    };
    uisleep 1;
};

switch (true) do {
    case ( XY_bailPaid ): {
        hint parseText format[XY_hintH1, "Du hast die Kaution gezahlt und bist nun frei"];
        [getPlayerUID player] remoteExec ["XY_fnc_wantedRemove", 2];
    };
    case ( _escaped ): {
        hint parseText format[XY_hintH1, "Du bist aus dem Knast entkommen: Du behälst deine Straftaten und dein Ausbruch wurde hinzugefügt"];
        [0, format["%1 ist aus dem Knast ausgebrochen!", profileName]] remoteExec ["XY_fnc_broadcast"];
        [getPlayerUID player, "147"] remoteExec ["XY_fnc_wantedAdd", 2];
    };
    case ( (call XY_fnc_isAlive) && !_escaped && !XY_bailPaid ): {
        hint parseText format[XY_hintH1, "Du hast deine Strafe abgesessen und bist nun frei"];
        [getPlayerUID player] remoteExec ["XY_fnc_wantedRemove", 2];
    };
};

XY_canPayBail = false;
XY_bailAmount = 0;
XY_bailPaid = false;

if( !_escaped ) then {
    player setPos (getMarkerPos "jail_release");
};

if( !(call XY_fnc_isAlive) ) exitWith {};

XY_isArrested = false;
[ KV_jailTime, 0 ] call XY_fnc_kvsPut;

[] call XY_fnc_save;