/*
	File: fn_spikeStrip.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Creates a spike strip and preps it.
*/
private["_position","_spikeStrip"];

if( vehicle player != player ) exitWith {
    hint "Bitte erst aussteigen, sonst tut sich noch jemand weh...";
};

closeDialog 0;

_spikeStrip = "Land_Razorwire_F" createVehicle [0,0,0];
_spikeStrip attachTo[player,[0,5.5,0]];
_spikeStrip setDir 90;
_spikeStrip setVariable["item", "spikeDeployed",true];

XY_actionDeploySpikestrip = player addAction[localize "STR_ISTR_Spike_Place", {
        if(!isNull XY_spikeStrip) then {
            detach XY_spikeStrip; 
            XY_spikeStrip = ObjNull;
        }; 
        player removeAction XY_actionDeploySpikestrip; 
        XY_actionDeploySpikestrip = nil;
    }, "", 999, false, false, "", '!isNull XY_spikeStrip'];
XY_spikeStrip = _spikeStrip;

waitUntil { isNull XY_spikeStrip };
if( !(isNil "XY_actionDeploySpikestrip") ) then {
    player removeAction XY_actionDeploySpikestrip;
};
if( isNull _spikeStrip ) exitWith {
    XY_spikeStrip = objNull;
};

_spikeStrip setPos [getPos _spikeStrip select 0, getPos _spikeStrip select 1, 0];
_spikeStrip setDamage 1;

XY_actionPickupSpikestrip = player addAction[localize "STR_ISTR_Spike_Pack", XY_fnc_packupSpikes, "", 0, false, false, "", '_spikes = nearestObjects[getPos player,["Land_Razorwire_F"],8] select 0; !isNil "_spikes" && !isNil {(_spikes getVariable "item")}'];