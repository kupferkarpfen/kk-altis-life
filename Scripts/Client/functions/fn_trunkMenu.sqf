// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

diag_log format["trunkMenu(%1) - scheduled (true = BAD): %2", _this, canSuspend];

private _mode = param[0, "", [""]];
if( _mode isEqualTo "" ) exitWith {};

disableSerialization;

if( _mode isEqualTo "init" && (!(isNil "XY_TM_dialogOpen") || dialog) ) exitWith {};

if( _mode isEqualTo "init" ) then {
    createDialog "XY_dialog_trunk";
};

private _display = findDisplay 3500;
if( !(_mode isEqualTo "exit") && isNull _display ) exitWith {

    // There is a race condition when the trunk items are received after the dialog has been closed
    // This would render the vehicle trunk unusable, as the trunk unlock is never sent back to the server
    // So make sure to send the received trunk back to the server
    if( _mode isEqualTo "receive" ) then {
        private _vehicle = _this select 1;
        private _trunk = _this select 2;
        diag_log format["remoteExecCall updateTrunk(%1) ['receive' after dialog was closed]", [player, _vehicle , _trunk]];
        [player, _vehicle , _trunk] remoteExecCall ["XYDB_fnc_updateTrunk", 2];
    };

    ["exit"] call XY_fnc_trunkMenu;
};

private _lblHeading = _display displayCtrl 3510;
private _lstTrunkItems = _display displayCtrl 3520;
private _lstPlayerItems = _display displayCtrl 3521;
private _sldTrunkCount = _display displayCtrl 3530;
private _sldPlayerCount = _display displayCtrl 3531;
private _lblTakeInfo = _display displayCtrl 3540;
private _lblStoreInfo = _display displayCtrl 3541;
private _btnTake = _display displayCtrl 3550;
private _btnStore = _display displayCtrl 3551;
private _lblVeil = _display displayCtrl 3560;

if( _mode isEqualTo "init" ) exitWith {

    private _vehicle = param[1, objNull, [objNull]];
    private _isHouse = _vehicle isKindOf "House_F";

    private _vehicleConfig = [typeOf _vehicle, _vehicle getVariable ["side", playerSide]] call XY_fnc_vehicleConfig;
    if( _vehicle isEqualTo objNull || { !(_vehicle isKindOf "Car" || _vehicle isKindOf "Air" || _vehicle isKindOf "Ship" || _isHouse) } || { _vehicleConfig isEqualTo [] && !_isHouse } ) exitWith {
        hint parseText format[XY_hintError, "Kein Kofferraum vorhanden"];
        closeDialog 0;
    };

    // Ensure veil is visible
    _lblVeil ctrlShow true;

    // Proper dialog closing on ESC
    _display displaySetEventHandler ["KeyDown", "if( (_this select 1) isEqualTo 1 ) exitWith { [""exit""] call XY_fnc_trunkMenu; true }"];

    XY_TM_dialogOpen = true;
    XY_TM_vehicle = _vehicle;
    XY_TM_isHouse = _isHouse;
    XY_TM_trunkReceived = false;
    XY_TM_nextTrunkRequest = time;
    XY_TM_playerTrunk = +XY_playerTrunk;
    XY_TM_vehicleTrunk = [];
    XY_TM_vehicleTrunkMax = if( _isHouse ) then {

        private _maxTrunk = 0;
        {
            private _config = [typeOf _x] call XY_fnc_vehicleConfig;
            if( !(_config isEqualTo []) ) then {
                _maxTrunk = _maxTrunk + (_config select 2);
            };
        } forEach (_vehicle getVariable["containers", []]);

        _maxTrunk;

    } else {
        _vehicleConfig select 2;
    };

    "TrunkObserver" spawn { scriptName _this;
        while { XY_TM_dialogOpen } do {
            [XY_fnc_trunkMenu, ["loop"]] call XY_fnc_unscheduled;
            uisleep 0.1;
        };
        XY_TM_dialogOpen = nil;
    };
};

if( _mode isEqualTo "loop" ) exitWith {
    // Just incase bad scheduling took us here...
    if( !XY_TM_dialogOpen ) exitWith {};

    // Check if all conditions are still met
    // not the most elegant way to do it, but it is late and I am lazy
    private _canAccess = XY_TM_vehicle in XY_vehicles;
    _canAccess = _canAccess || (XY_TM_isHouse && !(XY_TM_vehicle getVariable["locked", true]));
    _canAccess = _canAccess || (!XY_TM_isHouse && ((locked XY_TM_vehicle) isEqualTo 0));
    _canAccess = _canAccess && ([XY_TM_vehicle] call XY_fnc_isPlayerNearVehicle);
    if( !_canAccess ) exitWith {
        ["exit"] call XY_fnc_trunkMenu;
    };

    if( XY_TM_nextTrunkRequest <= time && !XY_TM_trunkReceived ) then {
        XY_TM_nextTrunkRequest = time + 4 + (random 4);
        [player, XY_TM_vehicle] remoteExecCall ["XY_fnc_requestTrunk", 2];
    };
};

if( _mode isEqualTo "exit" ) exitWith {
    closeDialog 0;

    if( XY_TM_trunkReceived && !(isNull XY_TM_vehicle) && (alive XY_TM_vehicle) ) then {
        diag_log format["remoteExecCall updateTrunk(%1)", [player, XY_TM_vehicle, XY_TM_vehicleTrunk]];
        [player, XY_TM_vehicle, XY_TM_vehicleTrunk] remoteExecCall ["XYDB_fnc_updateTrunk", 2];
    };
    // There is a race condition when the trunk items are received after the dialog has been closed
    // This would overwrite the players trunk with Nil - which is not good, as you might have guessed
    // So make sure this never happens
    if( !(isNil "XY_TM_playerTrunk") ) then {
        XY_playerTrunk = +XY_TM_playerTrunk;
    };

    XY_TM_dialogOpen = false;
    XY_TM_vehicle = nil;
    XY_TM_isHouse = nil;
    XY_TM_trunkReceived = nil;
    XY_TM_nextTrunkRequest = nil;
    XY_TM_playerTrunk = nil;
    XY_TM_vehicleTrunk = nil;
    XY_TM_vehicleTrunkMax = nil;
};

if( _mode isEqualTo "receive" ) exitWith {

    // Just incase...
    if( XY_TM_trunkReceived ) exitWith {};
    private _vehicle = param[1, objNull, [objNull]];
    if( !(_vehicle isEqualTo XY_TM_vehicle) ) exitWith {};
    XY_TM_vehicleTrunk = param[2, [], [[]]];
    XY_TM_trunkReceived = true;

    // We got a lock for the trunk, display data...
    ["update"] call XY_fnc_trunkMenu;

    // Lift the veil
    _lblVeil ctrlShow false;
};

if( _mode isEqualTo "update" ) exitWith {

    lbClear _lstTrunkItems;
    lbClear _lstPlayerItems;

    {
        private _config = [_x select 0] call XY_fnc_itemConfig;
        if( !(_config isEqualTo []) ) then {
            private _index = _lstTrunkItems lbAdd format["%1x %2", _x select 1, _config select 2 ];
            _lstTrunkItems lbSetData [_index, _x select 0];
        };
    } forEach XY_TM_vehicleTrunk;

    {
        private _config = [_x select 0] call XY_fnc_itemConfig;
        if( !(_config isEqualTo []) ) then {
            private _index = _lstPlayerItems lbAdd format["%1x %2", _x select 1, _config select 2 ];
            _lstPlayerItems lbSetData [_index, _x select 0];
        };
    } forEach XY_TM_playerTrunk;

    _lblHeading ctrlSetStructuredText parseText format["<t size='1' align='center'>%1 (%2 / %3 kg gelagert)</t>", getText(configFile >> "CfgVehicles" >> (typeOf XY_TM_vehicle) >> "displayName"), [XY_TM_vehicleTrunk] call XY_fnc_getTrunkWeight, XY_TM_vehicleTrunkMax];

    ["selection_trunk"] call XY_fnc_trunkMenu;
    ["selection_player"] call XY_fnc_trunkMenu;
};

private _indexTrunk = lbCurSel _lstTrunkItems;
private _itemTrunk = _lstTrunkItems lbData _indexTrunk;

private _indexPlayer = lbCurSel _lstPlayerItems;
private _itemPlayer = _lstPlayerItems lbData _indexPlayer;

if( _mode isEqualTo "selection_trunk" ) exitWith {
    _sldTrunkCount ctrlEnable false;
    _btnTake ctrlEnable false;
    _lblTakeInfo ctrlSetStructuredText parseText "";

    if( _indexTrunk < 0 ) exitWith {};
    private _config = [_itemTrunk] call XY_fnc_itemConfig;
    if( _config isEqualTo [] ) exitWith {};

    private _maxItems = ([_itemTrunk, XY_TM_vehicleTrunk] call XY_fnc_getItemCountFromTrunk) min floor((XY_maxWeight - ([XY_TM_playerTrunk] call XY_fnc_getTrunkWeight)) / (_config select 1));
    if( _maxItems < 1 ) exitWith {
        _lblBuyInfo ctrlSetStructuredText parseText "<t size='0.7' align='center' color='#DD0505'>Inventar voll</t>";
    };

    _sldTrunkCount sliderSetRange [1, 1 max _maxItems];
    _sldTrunkCount sliderSetPosition 1;
    // For some reason slider setPosition is inconsistent with lbSetCurSel, which fires the attached handler, for the slider we have to do it ourself
    ["slider_trunk"] call XY_fnc_trunkMenu;
};

if( _mode isEqualTo "slider_trunk" || _mode isEqualTo "take" ) exitWith {
    if( _indexTrunk < 0 ) exitWith {};
    private _config = [_itemTrunk] call XY_fnc_itemConfig;
    private _amount = round(sliderPosition _sldTrunkCount);

    if( _mode isEqualTo "take" ) exitWith {
        if( !([_itemTrunk, _amount, XY_TM_vehicleTrunk] call XY_fnc_removeItemFromTrunk) ) exitWith {};
        [_itemTrunk, _amount, XY_TM_playerTrunk] call XY_fnc_addItemToTrunk;
        ["update"] call XY_fnc_trunkMenu;
    };

    _lblTakeInfo ctrlSetStructuredText parseText format["<t size='0.7' align='center'><t color='#FF9900'>%1x %2 (%3kg)</t> nehmen</t>", _amount, _config select 2, _amount * (_config select 1)];
    _btnTake ctrlEnable true;
    _sldTrunkCount ctrlEnable true;
};

if( _mode isEqualTo "selection_player" ) exitWith {
    _btnStore ctrlEnable false;
    _sldPlayerCount ctrlEnable false;
    _lblStoreInfo ctrlSetStructuredText parseText "";

    if( _indexPlayer < 0 ) exitWith {};
    private _config = [_itemPlayer] call XY_fnc_itemConfig;
    if( _config isEqualTo [] ) exitWith {};

    if( _itemPlayer isEqualTo "goldbar" && XY_TM_vehicle isKindOf "Air" ) exitWith {};
    if( (_itemPlayer find "uran") >= 0 && XY_TM_vehicle isKindOf "Air" ) exitWith {};
    
    private _maxItems = ([_itemPlayer, XY_TM_playerTrunk] call XY_fnc_getItemCountFromTrunk) min floor((XY_TM_vehicleTrunkMax - ([XY_TM_vehicleTrunk] call XY_fnc_getTrunkWeight)) / (_config select 1));
    if( _maxItems < 1 ) exitWith {
        _lblBuyInfo ctrlSetStructuredText parseText "<t size='0.7' align='center' color='#DD0505'>Fahrzeuginventar voll</t>";
    };

    _sldPlayerCount sliderSetRange [1, 1 max _maxItems];
    _sldPlayerCount sliderSetPosition 1;
    ["slider_player"] call XY_fnc_trunkMenu;
};
if( _mode isEqualTo "slider_player" || _mode isEqualTo "store" ) exitWith {
    if( _indexPlayer < 0 ) exitWith {};
    private _config = [_itemPlayer] call XY_fnc_itemConfig;
    private _amount = round(sliderPosition _sldPlayerCount);

    if( _mode isEqualTo "store" ) exitWith {

        if( !([_itemPlayer, _amount, XY_TM_playerTrunk] call XY_fnc_removeItemFromTrunk) ) exitWith {};
        [_itemPlayer, _amount, XY_TM_vehicleTrunk] call XY_fnc_addItemToTrunk;

        ["update"] call XY_fnc_trunkMenu;
    };

    _lblStoreInfo ctrlSetStructuredText parseText format["<t size='0.7' align='center'><t color='#FF9900'>%1x %2 (%3kg)</t> lagern</t>", _amount, _config select 2, _amount * (_config select 1)];
    _sldPlayerCount ctrlEnable true;
    _btnStore ctrlEnable true;
};