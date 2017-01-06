// by ALIAS
// nul = [obj_pozition,duration] execvm "ALfireworks\alias_rock.sqf";

if (!hasInterface) exitWith {};

private _source = param[0, objNull, [objNull]];
private _rgb = param[1, [1,1,1], [[]]];
private _height = param[2, 250, [0]];

_lanspoint = "land_helipadempty_f" createVehicleLocal [getPosATL _source select 0,getPosATL _source select 1,getPosATL _source select 2];
_lansspark = "land_helipadempty_f" createVehicleLocal [getPosATL _source select 0,getPosATL _source select 1,getPosATL _source select 2];

_firsound = selectRandom ["firework1","firework2","firework3"];
_firflut = selectRandom ["firework4","firework5","firework6","firework7","firework8","firework9","firework10","firework11"];

_h = _height; // altitude	
_lanspoint setPos [getPos _source select 0,getPos _source select 1, _h];
_lansspark setPos [getPos _source select 0,getPos _source select 1, _h-10];

_ro = _rgb select 0;
_ve = _rgb select 1;
_bl = _rgb select 2;

// genereaza rachete cu sunet
_rocket_handler = [_source,_h,_firflut] spawn XY_fnc_fw_rock;
waitUntil {scriptDone _rocket_handler};

// genereaza lumina
[_source,_ro,_ve,_bl,_h] spawn XY_fnc_fw_lumina;

// genereaza scantei
_sparks_handler = [_lansspark,_ro,_ve,_bl,_h] spawn XY_fnc_fw_sparks;
waitUntil { scriptDone _sparks_handler };

sleep 0.1;

[_lanspoint, player] say3D [_firsound, 1500, 1];

sleep 4;
deleteVehicle _lanspoint;
deleteVehicle _lansspark;