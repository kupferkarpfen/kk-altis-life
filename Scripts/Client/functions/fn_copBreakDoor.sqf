// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private["_house","_door","_title","_titleText","_progressBar","_cpRate","_cP","_uid"];

_house = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
if(isNull _house OR !(_house isKindOf "House_F")) exitWith {};
if(isNil {(_house getVariable "house_owner")}) exitWith {hint localize "STR_House_Raid_NoOwner"};

_uid = (_house getVariable "house_owner") select 0;
if(!([_uid] call XY_fnc_isUIDActive)) exitWith {hint localize "STR_House_Raid_OwnerOff"};

_door = [_house] call XY_fnc_nearestDoor;
if(_door == 0) exitWith {hint localize "STR_Cop_NotaDoor"};
if((_house getVariable[format["bis_disabled_Door_%1",_door],0]) == 0) exitWith {hint localize "STR_House_Raid_DoorUnlocked"};

if( XY_actionInUse ) exitWith {};
XY_actionInUse = true;

[[0, 1], format[localize "STR_House_Raid_NOTF", (_house getVariable "house_owner") select 1]] remoteExec ["XY_fnc_broadcast", [civilian, 2]];

_duration = 180;

disableSerialization;

_cp = 0;
_startTime = time;
_timeOut = _startTime + _duration;
_animTarget = time;
_interrupted = true;

5 cutRsc ["XY_progressBar", "PLAIN"];
_ui = uiNameSpace getVariable "XY_progressBar";
_progress = _ui displayCtrl 38201;
_progressText = _ui displayCtrl 38202;

while { alive player && player == vehicle player && !XY_isTazed && !XY_interrupted && !(player getVariable["restrained", false]) } do {
    if( _animTarget <= time ) then {
        _animTarget = time + 5.5;
        player playAction "medicStartUp";
    };

    _cp = (time - _startTime) / (_timeOut - _startTime);
    _progress progressSetPosition _cp;
    _progressText ctrlSetText format["%1 (%2%3)", localize "STR_House_Raid_Progress", round (_cp * 100), "%"];

    if(_cp >= 1) exitWith {
        _interrupted = false;
    };
    sleep 0.25;
};

5 cutText ["", "PLAIN"];
player playActionNow "stop";
XY_actionInUse = false;

if( _interrupted ) exitWith {
    XY_interrupted = false;
    hint localize "STR_NOTF_ActionCancel";
};

_house animate [format["door_%1_rot", _door], 1];
_house setVariable[format["bis_disabled_Door_%1", _door], 0, true]; //Unlock the door.