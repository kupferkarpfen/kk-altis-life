// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _vehicle = cursorTarget;

if( vehicle player != player ) exitWith {
    hint localize "STR_ISTR_RefuelInVehicle"
};
if( isNull _vehicle ) exitWith {
    hint localize "STR_ISTR_Jerry_NotLooking"
};
if( !(_vehicle isKindOF "Car") && !(_vehicle isKindOf "Air") && !(_vehicle isKindOf "Ship") ) exitWith {};

if( !([_vehicle] call XY_fnc_isPlayerNearVehicle) ) exitWith {
    hint localize "STR_ISTR_Jerry_NotNear"
};

closeDialog 0;

XY_interrupted = false;
XY_actionInUse = true;

if( currentWeapon player != "" ) then {
    XY_currentWeaponToRecall = currentWeapon player;
    player action ["SwitchWeapon", player, player, 100];
    player switchcamera cameraView; // << What is this needed for?
    sleep 5;
};

disableSerialization;

private _duration = 20;

private _cp = 0;
private _startTime = time;
private _timeOut = _startTime + _duration;
private _animTarget = time;
private _interrupted = true;

5 cutRsc ["XY_progressBar", "PLAIN"];
private _ui = uiNameSpace getVariable "XY_progressBar";
private _progress = _ui displayCtrl 38201;
private _progressText = _ui displayCtrl 38202;

while { alive player && player isEqualTo (vehicle player) && !XY_isTazed && !XY_interrupted && !(player getVariable["restrained", false]) && ([_vehicle] call XY_fnc_isPlayerNearVehicle) } do {
    if( _animTarget <= time ) then {
        _animTarget = time + 5.5;
        player playAction "medicStartUp";
    };

    _cp = (time - _startTime) / (_timeOut - _startTime);
    _progress progressSetPosition _cp;
    _progressText ctrlSetText format["Befülle %1 (%2%3)", getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName"), round (_cp * 100), "%"];

    if(_cp >= 1) exitWith {
        _interrupted = false;
    };
    sleep 0.25;
};

5 cutText ["", "PLAIN"];
player playActionNow "stop";
XY_actionInUse = false;

if( !(["fuelF", 1] call XY_fnc_removeItemFromTrunk) ) then {
    _interrupted = true;
};

if( _interrupted ) exitWith {
    XY_interrupted = false;
    hint localize "STR_NOTF_ActionCancel";
};

private _amount = switch (true) do {
    case (_vehicle isKindOf "Air"): { 0.125 };
    case (_vehicle isKindOf "Ship"): { 0.8 };
    default { 0.25 };
};
[ _vehicle, 1 min ((fuel _vehicle) + _amount) ] remoteExec ["setFuel", _vehicle];

hint "Fahrzeug betankt!";

[XY_fnc_addItemToTrunk, ["fuelE", 1]] call XY_fnc_unscheduled;