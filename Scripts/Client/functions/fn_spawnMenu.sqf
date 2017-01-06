// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// usage:
// _mode = "init"     - initialize spawn selection
//         "update"   - update selected spawn
//         "confirm"  - OK Button clicked
//         "populate" - Populate spawn menu
//         "wait"     - Displays the spawn menu and waits for final selection

private _mode = param[0, "", [""]];
if( _mode isEqualTo "" ) exitWith {};

if( canSuspend ) then {
    diag_log format["spawnMenu(%1) - scheduled (true = BAD): %2", _this, canSuspend];
};

disableSerialization;

if( _mode isEqualTo "wait" ) exitWith {
    XY_selectedSpawn = nil;
    ["init"] call XY_fnc_spawnMenu;
    cutText["", "BLACK IN", 3];
    waitUntil { !(isNil "XY_selectedSpawn") };
    private _selectedSpawn = XY_selectedSpawn;
    XY_selectedSpawn = nil;

    _selectedSpawn
};

if( _mode isEqualTo "init" ) then {
    createDialog "XY_dialog_spawnSelection";
};

private _display = findDisplay 38500;
if( isNull _display ) exitWith {
    createDialog "XY_dialog_spawnSelection";
    ["populate"] call XY_fnc_spawnMenu;
};

private _ctrlList = _display displayCtrl 38501;
private _btnSpawn = _display displayCtrl 38502;

private _spawnPoints = call XY_fnc_getSpawnPoints;

if( _mode isEqualTo "populate" ) exitWith {
    // Fill spawnpoints
    {
        if( (call (_x select 3)) ) then {
            private _index = _ctrlList lbAdd (_x select 2);
            _ctrlList lbSetValue [ _index, _forEachIndex ];
        };
    } forEach _spawnPoints;
};

if( _mode isEqualTo "init" ) exitWith {

    ["populate"] call XY_fnc_spawnMenu;

    // Create spawn camera
    XY_spawnCameraFocusObject = "Land_HelipadEmpty_F" createVehicleLocal [0, 0, 0];
    XY_spawnCameraFocusObject enableSimulation false;
    XY_spawnCameraFocusObject allowDamage false;

    [XY_spawnCameraFocusObject, false, [22, 22, 30]] spawn XY_fnc_rotatingCamera;

    // Do an empty call on each frame to detect an disappeared display
    XY_SM_EachFrame = addMissionEventHandler ["EachFrame", { ["dummy"] call XY_fnc_spawnMenu; }];

    // Focus camera on spawn
    _ctrlList lbSetCurSel 0;
};

private _index = lbCurSel _ctrlList;
if( _index < 0 ) exitWith {};

private _spawn = _spawnPoints select (_ctrlList lbValue _index);

if( _mode isEqualTo "update" ) exitWith {

    _btnSpawn ctrlEnable (call (_spawn select 3));

    XY_spawnCameraFocusObject setPos (getMarkerPos (_spawn select 1));
};

if( _mode isEqualTo "confirm" ) exitWith {

    removeMissionEventHandler ["EachFrame", XY_SM_EachFrame];

    closeDialog 0;
    XY_SM_EachFrame = nil;

    deleteVehicle XY_spawnCameraFocusObject;
    XY_spawnCameraFocusObject = nil;

    private _spawnPos = (getMarkerPos (_spawn select 1));

    // Randomize spawnpoint a few meters
    _spawnPos set [0, (_spawnPos select 0) + (random 2) - 1];
    _spawnPos set [1, (_spawnPos select 1) + (random 2) - 1];

    // Select free space...
    private _freeSpawn = _spawnPos findEmptyPosition [0, 250, "B_Heli_Transport_01_F"];
    if( !(_freeSpawn isEqualTo []) ) then {
        _spawnPos = _freeSpawn;
    };

    _spawnPos set [2, 0.5];

    XY_selectedSpawn = _spawnPos;
};