/*
	Author: MrKraken
	filename: fn_surrender.sqf
	Description: places player into a surrendered state!
*/

if( player getVariable["restrained", false] ) exitWith {};
if( player getVariable["escorting", false] ) exitWith {};

player setVariable ["surrender", true, true];

while { player getVariable ["surrender", false] }  do { 
	player playMove "amovpercmstpsnonwnondnon_amovpercmstpssurwnondnon";
	if( !(call XY_fnc_isAlive) || !((vehicle player) isEqualTo player) ) exitWith {};
};
player setVariable ["surrender", false, true];

player playMoveNow "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon";