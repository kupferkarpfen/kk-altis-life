/*
	Does it matter? Needs to be replaced.
	Built for Feint's Push functionality
*/
private["_target","_caller","_posCaller","_dir"];
_target = cursorTarget;
_caller = player;
_posCaller = getPos _caller;
_dir = getDir _caller;

if(isNull _target) exitWith {};
if(_caller distance _target > 5) exitWith {};

[_caller, _target, _posCaller, _dir] remoteExec ["XY_fnc_pushFunction", _target];