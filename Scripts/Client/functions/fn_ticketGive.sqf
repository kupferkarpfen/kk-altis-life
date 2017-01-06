// File: fn_ticketGive.sqf
// Author: Bryan "Tonic" Boardwine
// Rewritten by Kupferkarpfen
// License: CC BY-NC-SA 4.0

if( isNil "XY_ticketUnit" || { isNull XY_ticketUnit } ) exitWith {};

private _val = ctrlText 2652;

if( !([_val] call XY_fnc_isNumber) ) exitWith {
    hint "Das ist keine Zahl";
};
_val = parseNumber _val;

if( playerSide isEqualTo civilian ) exitWith {};
if( playerSide isEqualTo west && { _val > 9999999 } ) exitWith {
    hint "Die Obergrenze für Tickets ist überschritten";
};
if( playerSide isEqualTo independent && { _val > 5000 } ) exitWith {
    hint "Die Obergrenze für Spenden ist 5.000";
};
closeDialog 0;

if( playerSide isEqualTo west ) then {
    [0, format[ "%1 hat %2 ein Ticket über %3€ ausgestellt", profileName, XY_ticketUnit getVariable["realName", name XY_ticketUnit], [_val] call XY_fnc_numberText ]] remoteExec ["XY_fnc_broadcast"];
};
[player, _val] remoteExec ["XY_fnc_ticketPrompt", XY_ticketUnit];
