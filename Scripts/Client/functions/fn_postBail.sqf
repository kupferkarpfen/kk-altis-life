// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

if( XY_bailPaid || !XY_canPayBail || XY_bailAmount <= 0 ) exitWith {};

// Pay the bail:
if( !([XY_bailAmount] call XY_fnc_pay) ) exitWith {
    hint "Du hast nicht genug Geld um das zu zahlen";
};

[ 0, format["%1 hat die Kaution gezahlt und ist wieder auf freiem Fuß", profileName] ] remoteExec ["XY_fnc_broadcast"];
XY_bailPaid = true;