/*	
	File: fn_safeOpen.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Opens the safe inventory menu.
*/
if( dialog ) exitWith {};

XY_safeObj = [ _this, 0, objNull, [objNull]] call BIS_fnc_param;

if( isNull XY_safeObj ) exitWith {};
if( playerSide != civilian ) exitWith {};

if( (XY_safeObj getVariable["safe", -1]) < 1 ) exitWith {
    hint localize "STR_Civ_VaultEmpty";
};

/*
if( {side _x == west} count playableUnits < 10 ) exitWith {
    hint localize "STR_Civ_NotEnoughCops"
};
*/


if( !(createDialog "XY_dialog_federalSafe") ) exitWith {
    localize "STR_MISC_DialogError"
};


disableSerialization;
ctrlSetText[3501, localize "STR_Civ_SafeInv"];

if( XY_safeObj getVariable["inUse", false] ) exitWith {
    hint localize "STR_Civ_VaultInUse"
};
XY_safeObj setVariable["inUse", true, true];

[XY_safeObj] call XY_fnc_safeInventory;
[XY_safeObj] spawn {
	waitUntil { isNull (findDisplay 3500) };
    sleep 1;
	(_this select 0) setVariable["inUse", false, true];
};