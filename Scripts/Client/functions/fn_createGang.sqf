/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Pulls up the menu and creates the gang?
*/
disableSerialization;

private _gangName = ctrlText ((findDisplay 2520) displayCtrl 2522);
private _length = count (toArray(_gangName));
private _chrByte = toArray (_gangName);
private _allowed = toArray("ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜabcdefghijklmnopqrstuvwxyzäöü0123456789_ ");
if( _length > 32 ) exitWith {
    hint localize "STR_GNOTF_Over32"
};
private _badChar = false;
{
    if( !(_x in _allowed) ) exitWith {
        _badChar = true;
    };
} forEach _chrByte;

if( _badChar ) exitWith {
    hint localize "STR_GNOTF_IncorrectChar";
};

closeDialog 0;

if( !([XY_gangPrice] call XY_fnc_pay) ) exitWith {
    hint "Du hast nicht genügend Geld für die Gründung einer Gang";
};

hint "Gang wird gegründet...";
[player, _gangName] remoteExec ["XYDB_fnc_insertGang", XYDB];