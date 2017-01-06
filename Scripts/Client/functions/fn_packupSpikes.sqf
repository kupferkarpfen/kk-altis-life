/*
	File: fn_packupSpikes.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Packs up a deployed spike strip.
*/
private _spikes = nearestObjects[getPos player, ["Land_Razorwire_F"], 8] select 0;
if( isNil "_spikes" ) exitWith {};

if( !([XY_fnc_addItemToTrunk, ["spikeStrip", 1]] call XY_fnc_unscheduled) ) exitWith {};

titleText["Du hast das Nagelband eingepackt", "PLAIN"];
player removeAction XY_actionPickupSpikestrip;
XY_actionPickupSpikestrip = nil;
deleteVehicle _spikes;