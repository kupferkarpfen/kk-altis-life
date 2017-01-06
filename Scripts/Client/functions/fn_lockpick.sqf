// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _curTarget = cursorObject;

if( XY_actionInUse ) exitWith {};
if( XY_IN_SAFEZONE && playerSide isEqualTo civilian ) exitWith {
    hint parseText format[XY_hintError, "Du befindest dich in einer Safezone"];
};
if( isNull _curTarget ) exitWith {};

private _distance = ((boundingBox _curTarget select 1) select 0) + 3;
if( player distance _curTarget > _distance ) exitWith {};

private _isVehicle = _curTarget isKindOf "Car" || _curTarget isKindOf "Ship" || _curTarget isKindOf "Air";
if( _isVehicle && _curTarget in XY_vehicles ) exitWith { hint "Du hast diesen Fahrzeugschlüssen bereits in deinem Schlüsselbund" };

// More error checks
if( !_isVehicle && !(isPlayer _curTarget) ) exitWith {};
if( !_isVehicle && !(_curTarget getVariable["restrained", false]) ) exitWith {};

private _title = format[ "Breche %1 auf...", if( !_isVehicle ) then { "Handschellen" } else { getText(configFile >> "CfgVehicles" >> (typeOf _curTarget) >> "displayName") } ];

closeDialog 0;

XY_actionInUse = true;
XY_interrupted = false;

if( currentWeapon player != "" ) then {
    XY_currentWeaponToRecall = currentWeapon player;
    player action ["SwitchWeapon", player, player, 100];
    sleep 3;
};

if( _isVehicle && !((_curTarget getVariable["ownerName", ""]) isEqualTo "") ) then {
    [getPlayerUID player, 21, format ["(Versucht) Auto von %1 (%2) aufzubrechen @ %3", _curTarget getVariable[ "ownerName", "ERROR" ], _curTarget getVariable[ "owner", "ERROR" ], mapGridPosition player ]] remoteExec ["XYDB_fnc_log", XYDB];
    [_curTarget getVariable[ "owner", "ERROR" ], 21, format ["Auto wurde von %1 (%2) (versucht) aufzubrechen @ %3", profileName, getPlayerUID player, mapGridPosition player ]] remoteExec ["XYDB_fnc_log", XYDB];
};

disableSerialization;

private _duration = 8 + round(random 14);

private _cp = 0;
private _startTime = time;
private _timeOut = _startTime + _duration;
private _animTarget = time;
private _interrupted = true;

private _alarmed = false;

5 cutRsc ["XY_progressBar","PLAIN"];
private _ui = uiNamespace getVariable "XY_progressBar";
private _progressBar = _ui displayCtrl 38201;
private _progressText = _ui displayCtrl 38202;

private _animCounter = 0;
while { alive player && !XY_isTazed && !XY_interrupted && !(player getVariable["restrained", false]) && player distance _curTarget <= _distance } do {

    if( _animTarget <= time ) then {
        _animTarget = time + 2;
        [player, "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon"] remoteExec ["XY_fnc_animSync", -2];
    };

    _cp = (time - _startTime) / (_timeOut - _startTime);
    _progressBar progressSetPosition _cP;
    _progressText ctrlSetText format[ "%1 (%2%3)", _title, round(_cP * 100), "%" ];

    if( _cp >= 1 ) exitWith {
        _interrupted = false;
    };

    if( playerSide isEqualTo civilian && { _isVehicle } && { !_alarmed } && { _cp > (0.3 + (random 0.6)) } ) then {
        _alarmed = true;
        [_curTarget, "caralarm"] remoteExecCall ["say3D", playableUnits select { isPlayer _x && { (_x distance player) < 150 } }];
    };

    uisleep 0.333;
};

XY_actionInUse = false;

5 cutText ["","PLAIN"];
player playActionNow "stop";

if( _interrupted ) exitWith {
    hint localize "STR_NOTF_ActionCancel";
};

if( playerSide isEqualTo civilian && { !(["lockpick", 1] call XY_fnc_removeItemFromTrunk) } ) exitWith {};

if( !_isVehicle ) then {
    _curTarget setVariable["restrained", false, true];
    _curTarget setVariable["escorting", false, true];
} else {
    private _dice = random(100);
    private _max = 30;

    if( _curTarget getVariable["lockpick.hardened", false] ) then {
        _max = 7;
    };
    if( serverTime < (_curTarget getVariable["lockpick.timeout", 0]) ) then {
        _max = -1;
    };

    // Protection against stealing vehicles of factions that have less than 4 active players ... don't announce, just let em waste their lockpicks
    private _side = _curTarget getVariable["side", civilian];
    if( !(_side isEqualTo civilian) && { _side countSide playableUnits < 4 } ) then {
        _max = -1;
    };

    if( !(playerSide isEqualTo civilian) || _dice <= _max) then {
        hint "Du hast nun einen Schlüssel zu diesem Fahrzeug";
        if( playerSide isEqualTo civilian ) then {
            [ getPlayerUID player, "124" ] remoteExec ["XY_fnc_wantedAdd", 2];
        };
        XY_vehicles pushBack _curTarget;

    } else {
        hint "Der Dietrich ist abgebrochen";
    };

    if( (side player) isEqualTo civilian ) then {
        // a little snitch reported you to the police
        if( _dice > 20 && _dice < 40 ) then {
            [ [0, 1], format["%1 wurde beim Aufbrechen eines Autos gesehen: Koordinaten %2", profileName, mapGridPosition player]] remoteExec ["XY_fnc_broadcast", [west, 2]];
        };
    };
};