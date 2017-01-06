// fn_ticketPrompt.sqf
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _source   = param[ 0, objNull, [objNull] ];
private _value    = param[ 1, -1, [0] ];

if( _source isEqualTo objNull || _value < 0 ) exitWith {};

private _type = switch (side _source) do {
    case(west): { "ein Strafticket" };
    case(independent): { "einen Spendevordruck" };
    default { "" };
};

if( _type isEqualTo "" ) exitWith {};

private _action = [
    format ["Du hast %1 über %2€ von %3 erhalten. Bezahlen?", _type, [_value] call XY_fnc_numberText, name _source],
    "Zahlungsanfrage",
    "Bezahlen",
    "Ablehnen",
    300,
    false,
    true
] call XY_fnc_showQuestionbox;

if( !_action ) exitWith {
    hint "Du hast die Zahlung abgelehnt";
    [1, format["Die Zahlung wurde von %1 abgelehnt!", profileName]] remoteExec ["XY_fnc_broadcast", _source];
};

if( !([_value] call XY_fnc_pay) ) exitWith {
    hint "Du hast nicht genug Geld um das zu zahlen";
    [1, format["%1 möchte bezahlen, hat jedoch nicht genug Geld", profileName]] remoteExec ["XY_fnc_broadcast", _source];
};

[_value, player, true] remoteExec ["XY_fnc_receiveMoney", _source];

[getPlayerUID player, 1, format ["Hat %1 (%2) %3€ als Strafe/Ticket/Rechnung gezahlt", name _source, getPlayerUID _source, [_value] call XY_fnc_numberText ]] remoteExec ["XYDB_fnc_log", XYDB];

if( (side _source) isEqualTo west ) then {
    [getPlayerUID player] remoteExec ["XY_fnc_wantedRemove", 2];
};