// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _mode = param[0, "", [""]];
if( _mode isEqualTo "" ) exitWith {};

disableSerialization;

if( _mode isEqualTo "init" ) then {

    private _killer = param[1, objNull, [objNull]];

    createDialog "XY_dialog_deathScreen";
    XY_DS_newLifeAt = time + ([30, 300] select XY_IN_PVP);
    XY_DS_newLifeUnlockAt = time + 1200;
    XY_DS_nextRequestAt = time + 9;
    XY_DS_requested = false;

    if( !(isNull _killer) && { !(_killer isEqualTo player) } && { isPlayer _killer } ) then {
        XY_DS_killerName = _killer getVariable ["realName", "ERROR"];
        private _gangName = (group _killer) getVariable["name", ""];
        if( !(_gangName isEqualTo "") ) then {
            XY_DS_killerName = format["%1 (%2)", XY_DS_killerName, _gangName];
        };
    } else {
        XY_DS_killerName = "";
    };

    // Create spawn camera
    XY_DS_focusObject = "Land_HelipadEmpty_F" createVehicleLocal [0, 0, 0];
    XY_DS_focusObject enableSimulation false;
    XY_DS_focusObject setPos (getPos XY_corpse);
    XY_DS_focusObject allowDamage false;

    showCinemaBorder true;
    [ XY_DS_focusObject, false, [5, 5, 12], 0.5 ] spawn XY_fnc_rotatingCamera;

    XY_DS_EachFrame = addMissionEventHandler ["EachFrame", { ["update"] call XY_fnc_deathScreen; }];
};

if( _mode isEqualTo "exit" ) exitWith {

    removeMissionEventHandler ["EachFrame", XY_DS_EachFrame];

    closeDialog 0;
    XY_DS_EachFrame = nil;
    XY_DS_newLifeAt = nil;
    XY_DS_newLifeUnlockAt = nil;
    XY_DS_nextRequestAt = nil;
    XY_DS_requested = nil;
    XY_DS_killerName = nil;

    deleteVehicle XY_DS_focusObject;
    XY_DS_focusObject = nil;

    if( !(XY_corpse getVariable["inPVP", false]) ) then {
        deleteVehicle XY_corpse;
    };
    XY_corpse = nil;
};

private _display = findDisplay 7300;
if( isNull _display ) exitWith {
    createDialog "XY_dialog_deathScreen";
};

private _lblMedicsOnline = _display displayCtrl 7310;
private _lblMedicsNear = _display displayCtrl 7311;
private _lblTimer = _display displayCtrl 7312;
private _lblKiller = _display displayCtrl 7313;

private _btnRequest = _display displayCtrl 7320;
private _btnRespawn = _display displayCtrl 7321;

if( _mode isEqualTo "update" ) exitWith {

    private _medics = allPlayers select { side (group _x) isEqualTo independent && !(_x isEqualTo player) };
    private _medicAvailable = !(_medics isEqualTo []);
    private _medicNear = !((_medics select { XY_corpse distance2D _x < 666 }) isEqualTo []);

    _lblMedicsOnline ctrlSetText format["Sanitäter online: %1", count _medics];
    _lblMedicsNear ctrlSetText format[ "Sanitäter in der Nähe: %1", ["NEIN", "JA"] select _medicNear ];

    if( !(XY_DS_killerName isEqualTo "") ) then {
        // Seems useless to update this every frame, but is required if user presses ESC while in deathscreen...
        _lblKiller ctrlSetStructuredText parseText format["<t size='1.2' align='center'>Getötet von: %1</t>", XY_DS_killerName];
    };

    private _timeLeft = XY_DS_newLifeAt - time;
    if( _timeLeft < 0 ) then {
        _lblTimer ctrlSetText "";
    } else {
        _lblTimer ctrlSetText format["'Neues Leben' möglich in: %1", [_timeLeft, "MM:SS.MS"] call BIS_fnc_secondsToString];
    };

    _btnRequest ctrlEnable (_medicAvailable && time >= XY_DS_nextRequestAt);
    _btnRespawn ctrlEnable (time >= XY_DS_newLifeAt) && (!XY_DS_requested || !_medicNear) || time >= XY_DS_newLifeUnlockAt;

    XY_DS_focusObject setPos (getPos XY_corpse);
};

if( _mode isEqualTo "request" ) exitWith {
    XY_DS_newLifeUnlockAt = (XY_DS_newLifeUnlockAt max time) + 600;
    XY_DS_nextRequestAt = time + 300;
    XY_DS_requested = true;
    XY_DS_newLifeAt = time + 600;

    [XY_corpse, profileName] remoteExec ["XY_fnc_medicRequest", independent];
    XY_corpse setVariable["medicRequested", true, true];

    ["update"] call XY_fnc_deathScreen;
};

if( _mode isEqualTo "respawn" ) exitWith {
    [] spawn XY_fnc_respawned;
    ["exit"] call XY_fnc_deathScreen;
};