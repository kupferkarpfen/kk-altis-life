// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _item = param[0, "", [""]];
if( _item isEqualTo "" ) exitWith {};

if( vehicle player != player ) exitWith {};

private _chipType = switch(_item) do {
    case "chip0": { 0 };
    case "chip1": { 1 };
    case "chip2": { 2 };
    case "chip3": { 3 };
    case "chip4": { 4 };
    case "chip5": { 5 };
    default { -1 };
};
if( _chipType < 0 ) exitWith {};

private _config = [_item] call XY_fnc_itemConfig;

if( (_config select 5) && playerSide isEqualTo west ) exitWith {
    hint "Dieses Chip-Tuning ist illegal";
};

private _vehicle = cursorTarget;
if( isNull _vehicle ) exitWith {};

if( (!(_vehicle isKindOf "Car") && !(_vehicle isKindOf "Ship")) || (_vehicle getVariable["chip.disallow", false]) ) exitWith {
    hint "Du kannst hier kein Chip-Tuning einbauen";
};
if( !(_vehicle getVariable["owner", ""] isEqualTo (getPlayerUID player)) ) exitWith {
    hint "Das kannst du nur bei deinen eigenen Fahrzeugen machen";
};

private _action = true;
if( _chipType isEqualTo 0 ) then {
    _action = [
        "Willst du an deinem Fahrzeug das Chip-Tuning entfernen und wieder die Original-Software verwenden?",
        "Chip-Tuning",
        localize "STR_Global_Yes",
        localize "STR_Global_No"
    ] call XY_fnc_showQuestionbox;
};
if( _config select 5 ) then {
    _action = [
        "Willst du an deinem Fahrzeug wirklich ein illegales Chip-Tuning durchführen? Wenn die Polizei dich damit auf öffentlichen Straßen erwischt kann sie darauf bestehen die Modifikation rückgängig zu machen, da die Betriebserlaubnis erloschen ist!",
        "Chip-Tuning",
        localize "STR_Global_Yes",
        localize "STR_Global_No"
    ] call XY_fnc_showQuestionbox;
};

if( !_action ) exitWith {};

if( XY_actionInUse ) exitWith {};
XY_actionInUse = true;

closeDialog 0;

XY_interrupted = false;

// KK: Holster weapon:
if( currentWeapon player != "" ) then {
    XY_currentWeaponToRecall = currentWeapon player;
    player action ["SwitchWeapon", player, player, 100];
    player switchcamera cameraView; // << What is this needed for?
    sleep 1;
};

disableSerialization;

private _duration = 40;

private _cp = 0;
private _startTime = time;
private _timeOut = _startTime + _duration;
private _animTarget = time;
private _interrupted = true;

5 cutRsc ["XY_progressBar","PLAIN"];
private _ui = uiNamespace getVariable "XY_progressBar";
private _progressBar = _ui displayCtrl 38201;
private _progressText = _ui displayCtrl 38202;

private _animCounter = 0;
while { alive player && !XY_isTazed && !XY_interrupted && !(player getVariable["restrained", false]) && [_vehicle] call XY_fnc_isPlayerNearVehicle } do {

    if( _animTarget <= time ) then {
        _animTarget = time + 2;
        [player, "AinvPknlMstpSnonWnonDnon_medic_1"] remoteExec ["XY_fnc_animSync", -2];
    };

    _cp = (time - _startTime) / (_timeOut - _startTime);
    _progressBar progressSetPosition _cP;
    _progressText ctrlSetText format[ "Montiere %1 (%2%3)", _config select 2, round(_cP * 100), "%" ];

    if( _cp >= 1 ) exitWith {
        _interrupted = false;
    };

    uisleep 0.25;
};

XY_actionInUse = false;

5 cutText ["","PLAIN"];
player playActionNow "stop";

if( _interrupted || { !([_item, 1] call XY_fnc_removeItemFromTrunk) } ) exitWith {
    hint localize "STR_NOTF_ActionCancel";
};

_vehicle setVariable["chip.enabled", _chipType > 0, true];
_vehicle setVariable["chip.type", _chipType, true];

uisleep 1;

[_vehicle] remoteExec [ "XYDB_fnc_updateVehicle", XYDB];

hint (["Chip-Tuning wurde entfernt, dein Fahrzeug ist nun wieder im Original-Zustand", "Chip-Tuning wurde eingebaut"] select (_chipType > 0));