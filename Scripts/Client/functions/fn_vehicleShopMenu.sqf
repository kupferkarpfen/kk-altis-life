// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _mode = param[0, "", [""]];

disableSerialization;

if( _mode isEqualTo "init" ) then {

    XY_VS_type = (_this select 1) param [0, "", [""]];
    XY_VS_spawnsMarkers = (_this select 1) param [1, [], [[]]];

    if( dialog || XY_VS_type isEqualTo "" || XY_VS_spawnsMarkers isEqualTo [] ) exitWith {
        ["exit"] call XY_fnc_vehicleShopMenu;
    };

    XY_VS_spawns = [];
    {
        if( (typeName _x)  isEqualTo "STRING" ) then {
            // Marker as spawnpoint: convert to [pos, dir]...
            XY_VS_spawns pushBack [ getMarkerPos _x, markerDir _x ];
        } else {
            XY_VS_spawns pushBack _x;
        };
    } forEach XY_VS_spawnsMarkers;

    XY_VS_caption = XY_VS_type;
    private _condition = { true };

    {
        if( (_x select 0) isEqualTo XY_VS_type ) exitWith {
            XY_VS_caption = _x select 1;
            _condition = _x select 2;
        };
    } forEach XY_vehicleShopConfig;

    if( !(call _condition) ) exitWith {
        hint parseText format[XY_hintError, "Du darfst hier nicht einkaufen"];
        ["exit"] call XY_fnc_vehicleShopMenu;
    };

    createDialog "XY_dialog_vehicleShop";
};

if( _mode isEqualTo "exit" ) exitWith {

    closeDialog 0;
    ["exit"] call XY_fnc_showVehiclePreview;

    XY_VS_type = nil;
    XY_VS_spawnsMarkers = nil;
    XY_VS_spawns = nil;
    XY_VS_caption = nil;

    XY_actionInUse = false;
};

private _display = findDisplay 9300;
if( isNull _display ) exitWith {};

private _lbCaption = _display displayCtrl 9301;
private _lbInfo = _display displayCtrl 9302;

private _lstVehicles = _display displayCtrl 9310;
private _lstSkins = _display displayCtrl 9311;

private _btnRent = _display displayCtrl 9320;
private _btnBuy = _display displayCtrl 9321;

if( _mode isEqualTo "init" ) exitWith {

    _btnRent ctrlEnable false;
    _btnBuy ctrlEnable false;

    _lbCaption ctrlSetStructuredText parseText format["<t size='1.15' align='center'>%1</t>", XY_VS_caption];

    // Proper dialog closing on ESC
    _display displaySetEventHandler ["KeyDown", "if( (_this select 1) isEqualTo 1 ) exitWith { [""exit""] call XY_fnc_vehicleShopMenu; true }"];

    private _vehicleList = [];
    {
        if( XY_VS_type in (_x select 8) && { call (_x select 9) } ) then {
            private _vehicleInfo = [_x select 1] call XY_fnc_fetchVehInfo;
            private _index = _lstVehicles lbAdd format["%1", _vehicleInfo select 3];
            _lstVehicles lbSetPicture [_index, _vehicleInfo select 2];
            _lstVehicles lbSetData [_index, _x select 1];
        };
    } forEach XY_vehicleList;

    _lstVehicles lbSetCurSel 0;
};

private _indexVehicle = lbCurSel _lstVehicles;
if( _indexVehicle < 0 ) exitWith {};

private _className = _lstVehicles lbData _indexVehicle;

private _vehicleConfig = [_className] call XY_fnc_vehicleConfig;
if( _vehicleConfig isEqualTo [] ) exitWith {};

if( _mode isEqualTo "selectVehicle" ) exitWith {

    // load available skins...
    lbClear _lstSkins;
    {
        if( (count _x < 3) || { (call (_x select 2)) } ) then {
            private _index = _lstSkins lbAdd (_x select 0);
            _lstSkins lbSetValue [_index, _forEachIndex];
        };
    } forEach ([_className] call XY_fnc_colorConfig);

    if( (lbSize _lstSkins) == 0 ) then {
        private _index = _lstSkins lbAdd "Standard";
        _lstSkins lbSetValue [_index, 0];
    };

    _lstSkins lbSetCurSel 0;
};

private _indexSkin = lbCurSel _lstSkins;
if( _indexSkin < 0 ) exitWith {};

private _skinCode = _lstSkins lbValue _indexSkin;

private _buyPrice = _vehicleConfig select 3;
private _rentPrice = _vehicleConfig select 4;
private _isRentable = _rentPrice >= 1 && (XY_CC + XY_CA) >= _rentPrice;
private _isBuyable = _buyPrice >= 1 && (XY_CC + XY_CA) >= _buyPrice;

if( _mode isEqualTo "selectSkin" ) exitWith {

    // Update displayed vehicle...
    ["update", _className, _skinCode] call XY_fnc_showVehiclePreview;

    private _vehicleInfo = [_className] call XY_fnc_fetchVehInfo;

    _lbInfo ctrlSetStructuredText parseText format[
        "Kaufpreis: <t color='#%1'>%2€</t><br/>" +
        "Mietpreis: <t color='#%3'>%4€</t><br/>" +
        "<br/>" +
        "Höchstgeschwindigkeit: %5 km/h<br/>" +
        "Sitzplätze: %6<br/>" +
        "Tankkapazität: %7l<br/>" +
        "Kofferraumgröße: %8<br/>",
        ["FF0000", "8CFF9B"] select _isBuyable,
        [_buyPrice] call XY_fnc_numberText,
        ["FF0000", "8CFF9B"] select _isRentable,
        [_rentPrice] call XY_fnc_numberText,
        _vehicleInfo select 8,
        (_vehicleInfo select 10) + 1,
        [_vehicleInfo select 12] call XY_fnc_numberText,
        [_vehicleConfig select 2] call XY_fnc_numberText
    ];

    _btnRent ctrlEnable _isRentable;
    _btnBuy ctrlEnable _isBuyable;
};

if( _mode isEqualTo "rent" || _mode isEqualTo "buy" ) exitWith {
    private _isBought = _mode isEqualTo "buy";
    private _price = [_rentPrice, _buyPrice] select _isBought;
    if( !_isBought && !_isRentable || _isBought && !_isBuyable ) exitWith {};

    private _vehicle = [_className, XY_VS_spawns, _price, _skinCode, -1, playerSide, 0, _isBought] call XY_fnc_spawnVehicle;
    [ "exit" ] call XY_fnc_vehicleShopMenu;

    if( !isNil("_vehicle") ) then {
        [ getPlayerUID player, 10, format ["Kauft Fahrzeug %1 für %2€ / Leihwagen: %3", getText(configFile >> "CfgVehicles" >> (_className) >> "displayName"), [_price] call XY_fnc_numberText, [ "JA", "NEIN" ] select _isBought ] ] remoteExec ["XYDB_fnc_log", XYDB];

        // Add database entry for vehicle
        if( _isBought ) then {
            [ player, playerSide, _vehicle, _skinCode] remoteExec ["XYDB_fnc_vehicleCreate", XYDB];
        };
    };
};