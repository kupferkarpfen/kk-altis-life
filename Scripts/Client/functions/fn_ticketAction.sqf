// Author: Bryan "Tonic" Boardwine
// Rewritten by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _unit = param[0, objNull, [objNull]];
if( _unit isEqualTo objNull || !(isPlayer _unit) ) exitWith {};

if( playerSide isEqualTo civilian ) exitWith {};

disableSerialization;
if( !(createDialog "XY_dialog_giveTicket") ) exitWith {};

ctrlSetText[2651, format["%1 %2", (switch ( playerSide ) do {
    case (west): { "Strafticket ausstellen für" };
    case (independent): { "Spendenanfrage an" };
    default { "ERROR" };
}), [_unit getVariable["realName", "ERROR"], "Maskierte Person"] select ([_unit] call XY_fnc_playerMasked) ]];

XY_ticketUnit = _unit;