// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _mode = param[0, "", [""]];
private _vehicles = param[ 1, [], [[]] ];

disableSerialization;

if( _mode isEqualTo "init" ) then {
    if( _vehicles isEqualTo [] ) exitWith {
        XY_actionInUse = false;
        ["exit"] call XY_fnc_showVehiclePreview;
        hint parseText format[XY_hintH1, "Keine Fahrzeuge vorhanden"];
    };

    createDialog "XY_dialog_garage";
};

private _display = findDisplay 2800;
if( isNull _display ) exitWith {};

private _ctrlList = _display displayCtrl 2801;
private _ctrlInsure = _display displayCtrl 2802;
private _ctrlInfo = _display displayCtrl 2803;

private _btnUnimpound = _display displayCtrl 2810;
private _btnSell = _display displayCtrl 2811;

if( _mode isEqualTo "init" ) exitWith {
    XY_GM_vehicles = _vehicles;

    // Proper dialog closing on ESC
    _display displaySetEventHandler ["KeyDown", "if( (_this select 1) isEqualTo 1 ) exitWith { [""exit""] call XY_fnc_garageMenu; true }"];

    {
        private _info = [_x select 1] call XY_fnc_fetchVehInfo;
        private _config = [ _x select 1 ] call XY_fnc_vehicleConfig;

        if( !(_info isEqualTo []) && !(_config isEqualTo []) ) then {
            private _index = _ctrlList lbAdd format["%1%2", _info select 3, if( (_x select 4) isEqualTo 1 ) then { " [X]" } else { [" *", ""] select ((_x select 5) isEqualTo []) } ];
            _ctrlList lbSetPicture [ _index, _info select 2];
            _ctrlList lbSetValue   [ _index, _x select 0];
        };
    } forEach _vehicles;

    _ctrlList lbSetCurSel 0;
};

if( _mode isEqualTo "exit" ) exitWith {
    closeDialog 0;
    ["exit"] call XY_fnc_showVehiclePreview;
    XY_GM_vehicles = nil;
    XY_GM_spawns = nil;
    XY_actionInUse = false;
};

private _index = lbCurSel _ctrlList;
if( _index < 0 ) exitWith {};

private _vid = _ctrlList lbValue _index;

private _vehicle = objNull;
{
    if( (_x select 0) isEqualTo _vid ) exitWith {
        _vehicle = _x;
    };
} forEach XY_GM_vehicles;

// shouldn't happen :)
if( _vehicle isEqualTo objNull ) exitWith {};

private _className = _vehicle select 1;

private _vehicleConfig = [ _className ] call XY_fnc_vehicleConfig;
if( _vehicleConfig isEqualTo [] ) exitWith {};

private _insurance = cbChecked _ctrlInsure;
private _disallowedVehicle = true;
private _unimpoundPrice = _vehicleConfig select 6;
private _sellPrice = (_vehicleConfig select 3) * XY_ssv_SF;
private _insurancePrice = _vehicleConfig select 5;

// This is not the nicest way to do it, but it should work and shouldn't be exploitable
if( _insurance && _insurancePrice > 0 ) then {
    _unimpoundPrice = _unimpoundPrice + _insurancePrice;
    missionNamespace setVariable["XY_GM_insureNextVehicle", true];
} else {
    missionNamespace setVariable["XY_GM_insureNextVehicle", false];
};

if( _mode isEqualTo "update" ) exitWith {

    // Update displayed vehicle...
    ["update", _className, _vehicle select 3] call XY_fnc_showVehiclePreview;

    // Update insurability (is this a word?)
    _ctrlInsure ctrlEnable (_insurancePrice > 0);

    /*private _chipTuning = (switch(_vehicle select 6) do {
        case 1: { "Eco" };
        case 2: { "Sport" };
        case 3: { "Race" };
        case 4: { "Insane" };
        case 5: { "Ludicrous" };
        default { "Nein" };
    });*/

    private _inventory = "";
    {
        private _itemName = _x select 0;
        private _itemCount = _x select 1;
        {
            if( (_x select 0) isEqualTo _itemName ) exitWith {
                _inventory = format["%1%2x %3<br/>", _inventory, _itemCount, _x select 2];
            };
        } forEach XY_virtItems;
    } forEach (_vehicle select 5);

    // get vehicle skins
    private _colorConfig = [_className, _vehicle select 3] call XY_fnc_colorConfig;
    private _colorName = "Standard";
    if( !(_colorConfig isEqualTo []) ) then {
        _colorName = _colorConfig select 0;
    };

    private _locked = _vehicle select 4;
    private _vehicleInfo = [_className] call XY_fnc_fetchVehInfo;

    _ctrlInfo ctrlSetStructuredText parseText format[
        "Ausparkgebühr: <t color='#%1'>%2€</t><br/>" +
        "Verkaufserlös: <t color='#8CFF9B'>%3€</t><br/>" +
        "<br/>" +
        "Lackierung: %4<br/>" +
        "Höchstgeschwindigkeit: %5 km/h<br/>" +
        "Sitzplätze: %6<br/>" +
        "Tankkapazität: %7l<br/>" +
        "Kofferraumgröße: %8<br/>" +
        "<br/>" +
        // "Chip-Tuning: %9<br/>" +
        "Ladung: %10<br/>" +
        "%11",
        ["FF0000", "8CFF9B"] select (XY_CA >= _unimpoundPrice),
        [_unimpoundPrice] call XY_fnc_numberText,
        [ _sellPrice ] call XY_fnc_numberText,
        _colorName,
        _vehicleInfo select 8,
        (_vehicleInfo select 10) + 1,
        [_vehicleInfo select 12] call XY_fnc_numberText,
        [_vehicleConfig select 2] call XY_fnc_numberText,
        "", // _chipTuning,
        if( _inventory isEqualTo "" ) then { "KEINE" } else { format["<br/>%1", _inventory] },
        if( _locked isEqualTo 1 ) then { "<br/><t color='#FF0000'>Fahrzeug beschlagnahmt</t>" } else { "" }
    ];
    _btnUnimpound ctrlEnable (_locked != 1 && XY_CA >= _unimpoundPrice);
    _btnSell ctrlEnable (_locked != 1 && _sellPrice > 0);
};

if( _mode isEqualTo "unimpound" ) exitWith {

    if( _unimpoundPrice < 0 ) exitWith {};

    if( XY_CA < _unimpoundPrice ) exitWith {};

    // Send request to server, to checkout the vehicle from the database...
    [_vid, _unimpoundPrice, XY_GM_spawns, player, playerSide] remoteExec ["XYDB_fnc_retrieveVehicle", XYDB];

    ["exit"] call XY_fnc_garageMenu;

    hint parseText format[XY_hintH1, "Das Fahrzeug wird ausgeparkt..."];
};

if( _mode isEqualTo "sell" ) exitWith {

    if( _sellPrice < 1 ) exitWith {};

    [ "exit" ] call XY_fnc_garageMenu;

    private _action = [
        format ["Willst du dein(en) %1 für %2€ verkaufen?", getText(configFile >> "CfgVehicles" >> (_className) >> "displayName"), [_sellPrice] call XY_fnc_numberText],
        "Fahrzeug verkaufen",
        localize "STR_Global_Yes",
        localize "STR_Global_No"
    ] call XY_fnc_showQuestionbox;

    if( !_action ) exitWith {};

    if( XY_actionInUse ) exitWith {
        hint parseText format[XY_hintH1, "Du kannst grad nichts verkaufen"];
    };
    XY_actionInUse = true;

    [player, _vid, _sellPrice] remoteExec ["XYDB_fnc_sellVehicle", XYDB];

    hint parseText format[XY_hintH1, "Verkaufe Fahrzeug..."];

    "UnlockActionInUse" spawn { scriptName _this;
        uisleep 4;
        XY_actionInUse = false;
    };
};