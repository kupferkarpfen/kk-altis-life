/*
    File: fn_radar.sqf
    Author: Silly Aussie kid named Jaydon

    Description:
    Looks like weird but radar?
*/
if(playerSide != west) exitWith {};

private ["_speed","_vehicle"];

_vehicle = cursorTarget;
_speed = round speed _vehicle;

if( (currentWeapon player) in [ "hgun_P07_snds_F", "hgun_P07_F" ] ) then {
    switch (true) do {
        case ((_speed > 33 && _speed <= 80)): {
            hint parseText format ["<t color='#ffffff'><t size='2'><t align='center'>" +(localize "STR_Cop_Radar") + "<br/><t color='#33CC33'><t align='center'><t size='1'>" +(localize "STR_Cop_VehSpeed"), _speed];
        };
        case ((_speed > 80)) : {
            hint parseText format ["<t color='#ffffff'><t size='2'><t align='center'>" +(localize "STR_Cop_Radar") + "<br/><t color='#FF0000'><t align='center'><t size='1'>" +(localize "STR_Cop_VehSpeed"), _speed];
        };
    };
};