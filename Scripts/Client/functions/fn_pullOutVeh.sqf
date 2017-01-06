/*
	File: fn_pullOutVeh.sqf
	Author: Bryan "Tonic" Boardwine
*/

if( player getVariable ["restrained", false] ) then {
	detach player;
	player setVariable["escorting", false, true];
};

player action ["Eject", vehicle player];
titleText[localize "STR_NOTF_PulledOut", "PLAIN"];
titleFadeOut 4;