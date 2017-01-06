// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// based on work by Tonic

private _building = param[0, objNull, [objNull]];

if( isNull _building ) exitWith {};

if( XY_IN_SAFEZONE && playerSide isEqualTo civilian ) exitWith {
    hint parseText format[XY_hintError, "Du befindest dich in einer Safezone"];
};

if( !(_building isKindOf "House_F") ) exitWith {
    hint "Du schaust nicht auf eine Tür";
};

closeDialog 0;

private _isBank = XY_FED_DOME isEqualTo _building || XY_FED_RSB isEqualTo _building;
private _isJail = XY_JAIL isEqualTo _building;
private _maxDistance = [2, 8] select (_isBank || _isJail);

if( !_isBank && !_isJail ) then {
    _building setVariable["preventCleanup", true, true];
};

private _doors = getNumber(configFile >> "CfgVehicles" >> (typeOf _building) >> "NumberOfDoors");

private _door = 0;
private _doorPosition = [];
for "_i" from 1 to _doors do {
    _doorPosition = _building modelToWorld (_building selectionPosition format["Door_%1_trigger", _i]);
    if( player distance _doorPosition < _maxDistance ) exitWith {
        _door = _i;
    };
};
if( _door <= 0 ) exitWith {
    hint "Du bist nicht in der Nähe einer Tür";
};
if( (_building getVariable[format["bis_disabled_Door_%1", _door], 0]) isEqualTo 0 ) exitWith {
    hint "Die Tür ist bereits offen";
};

if( _isBank && { west countSide playableUnits < 10 } ) exitWith {
    hint "Es müssen mindestens 10 Polizisten online sein";
};
if( _isJail && { west countSide playableUnits < 6 } ) exitWith {
    hint "Es müssen mindestens 6 Polizisten online sein";
};

if( _isJail ) then {
    [[0, 1], "ACHTUNG: Das Staatsgefängnis wird aufgebrochen!"] remoteExec ["XY_fnc_broadcast"];
};
if( _isBank ) then {
    [[0, 1], "ACHTUNG: Die Staatsbank wird aufgebrochen!"] remoteExec ["XY_fnc_broadcast"];
};

private _ownerID = "UNKNOWN";
private _ownerName = "ERROR";

if( !_isBank && !_isJail ) then {
    private _owner = _building getVariable["house_owner", []];
    if ( !(_owner isEqualTo []) ) then {
        _ownerID = _owner select 0;
        _ownerName = _owner select 1;
    };
    [0, format["%1 bricht in ein Haus ein", profileName]] remoteExec ["XY_fnc_broadcast", [civilian]];
    [1, format["%1 bricht in dein Haus ein", profileName]] remoteExec ["XY_fnc_broadcast", allPlayers select { (getPlayerUID _x) isEqualTo _ownerID }];

    [_ownerID, 12, format ["Hauseinbruch begonnen durch %1 (%2) @ %3", profileName, getPlayerUID player, mapGridPosition player ]] remoteExec ["XYDB_fnc_log", XYDB];
    [getPlayerUID player, 12, format ["Beginnt Hauseinbruch bei %1 (%2) ein @ %3", _ownerName, _ownerID, mapGridPosition player ]] remoteExec ["XYDB_fnc_log", XYDB];
};

XY_interrupted = false;
XY_actionInUse = true;

if( currentWeapon player != "" ) then {
    XY_currentWeaponToRecall = currentWeapon player;
    player action ["SwitchWeapon", player, player, 100];
    player switchcamera cameraView; // << What is this needed for?
    sleep 1;
};

disableSerialization;

private _duration = [480, 180] select _isBank;

private _cp = 0;
private _startTime = time;
private _timeOut = _startTime + _duration;
private _animTarget = time;
private _interrupted = true;

5 cutRsc ["XY_progressBar", "PLAIN"];
private _ui = uiNameSpace getVariable "XY_progressBar";
private _progress = _ui displayCtrl 38201;
private _progressText = _ui displayCtrl 38202;

while { alive player && player isEqualTo (vehicle player) && !XY_isTazed && (animationState player) != "incapacitated" && !XY_interrupted && !(player getVariable["restrained", false]) && player distance _doorPosition < (_maxDistance * 2) } do {
    if( _animTarget <= time ) then {
        _animTarget = time + 2;
        [player, "AinvPknlMstpSnonWnonDnon_medic_1"] remoteExec ["XY_fnc_animSync", -2];
    };

    _cp = (time - _startTime) / (_timeOut - _startTime);
    _progress progressSetPosition _cp;
    _progressText ctrlSetText format["Breche Tür auf... (%1%2)", round (_cp * 100), "%"];

    if(_cp >= 1) exitWith {
        _interrupted = false;
    };
    sleep 0.25;
};

5 cutText ["", "PLAIN"];
player playActionNow "stop";
XY_actionInUse = false;

if( !_interrupted && { !([XY_fnc_removeItemFromTrunk, ["boltcutter", 1]] call XY_fnc_unscheduled) } ) then {
    _interrupted = true;
};

_building setVariable["preventCleanup", false, true];

if( _interrupted ) exitWith {
    XY_interrupted = false;
    hint localize "STR_NOTF_ActionCancel";
};

[getPlayerUID player, if(_isBank || _isJail) then { "145" } else { "123" } ] remoteExec ["XY_fnc_wantedAdd", 2];

if( !_isBank && !_isJail ) then {
    [_ownerID, 12, format ["Hauseinbruch durch %1 (%2) @ %3", profileName, getPlayerUID player, mapGridPosition player ]] remoteExec ["XYDB_fnc_log", XYDB];
    [getPlayerUID player, 12, format ["Bricht in Haus von %1 (%2) ein @ %3", _ownerName, _ownerID, mapGridPosition player ]] remoteExec ["XYDB_fnc_log", XYDB];
};

_building setVariable[format["bis_disabled_Door_%1", _door], 0, true]; //Unlock the door.
if( _isBank ) then {
    fed_bank setVariable[ format["door.open.%1", _door], true, true ];
};

if( (_building getVariable["locked", true]) ) then {
    _building setVariable["locked", false, true];
};