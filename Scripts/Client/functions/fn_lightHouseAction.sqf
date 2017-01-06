/*
	Author: Bryan "Tonic" Boardwine

	Description:
	Lights up the house.
*/
private["_house"];

_house = [ _this, 0, objNull, [objNull] ] call BIS_fnc_param;

if(isNull _house) exitWith {};
if(!(_house isKindOf "House_F")) exitWith {};

[_house, isNull (_house getVariable ["lightSource", objNull]) ] remoteExec ["XY_fnc_lightHouse", -2];