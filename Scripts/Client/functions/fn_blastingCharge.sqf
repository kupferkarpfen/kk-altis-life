/*
    Author: Bryan "Tonic" Boardwine

    Description:
    Blasting charge is used for the federal reserve vault and nothing  more.. Yet.
*/
private _vault = param[0, objNull, [objNull]];
if( isNull _vault ) exitWith {};

if( typeOf _vault != "Land_CargoBox_V1_F" ) exitWith {
    hint localize "STR_ISTR_Blast_VaultOnly"
};
if( _vault getVariable["chargeplaced", false] ) exitWith {
    hint localize "STR_ISTR_Blast_AlreadyPlaced"
};
if( _vault getVariable["safe_open", false] ) exitWith {
    hint localize "STR_ISTR_Blast_AlreadyOpen"
};
if( !([XY_fnc_removeItemFromTrunk, ["blastingcharge", 1]] call XY_fnc_unscheduled) ) exitWith {};

_vault setVariable["chargeplaced", true, true];

[1, localize "STR_ISTR_Blast_Placed"] remoteExec ["XY_fnc_broadcast", [west, 2] ];

[] remoteExec ["XY_fnc_demoChargeTimer", west];
[] remoteExec ["XY_fnc_demoChargeTimer", allPlayers select { _x distance player < 500 && (side _x) isEqualTo civilian }];

hint localize "STR_ISTR_Blast_KeepOff";
[] call XY_fnc_demoChargeTimer;

sleep 0.9;

if( !(fed_bank getVariable["chargeplaced", false]) ) exitWith {
    hint localize "STR_ISTR_Blast_Disarmed";
};

"Bo_GBU12_LGB_MI10" createVehicle [getPosATL fed_bank select 0, getPosATL fed_bank select 1, (getPosATL fed_bank select 2) + 0.5];
fed_bank setVariable["chargeplaced", false, true];
fed_bank setVariable["safe_open", true, true];

hint localize "STR_ISTR_Blast_Opened";