// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _mode = param[0, "", [""]];
if( _mode isEqualTo "" ) exitWith {};

if( _mode isEqualTo "init" ) then {

    private _parameters = param[1, [], [[]]];
    if( _parameters isEqualTo [] ) exitWith {};

    private _shopName = _parameters param[0, "", [""]];
    private _shopCaption = _parameters param[1, "", [""]];
    private _shopContents = _parameters param[2, [], [[]]];
    private _shopSource = _parameters param[3, objNull, [objNull]];

    if( _shopSource isEqualTo objNull || _shopCaption isEqualTo "" || _shopContents isEqualTo [] ) exitWith {};

    XY_VS_shopName = _shopName;
    XY_VS_shopSource = _shopSource;
    XY_VS_shopCaption = _shopCaption;
    XY_VS_shopContents = _shopContents;
    XY_VS_shopPopulated = false;

    createDialog "XY_dialog_virtualShop";
};

private _display = findDisplay 8100;
if( isNull _display ) exitWith {};

private _lblHeading = _display displayCtrl 8110;
private _lstShopItems = _display displayCtrl 8120;
private _lstPlayerItems = _display displayCtrl 8121;
private _sldShopCount = _display displayCtrl 8130;
private _sldPlayerCount = _display displayCtrl 8131;
private _lblBuyInfo = _display displayCtrl 8140;
private _lblSellInfo = _display displayCtrl 8141;
private _btnBuy = _display displayCtrl 8150;
private _btnSell = _display displayCtrl 8151;

if( _mode isEqualTo "init" ) exitWith {

    // Proper dialog closing on ESC
    _display displaySetEventHandler ["KeyDown", "if( (_this select 1) isEqualTo 1 ) exitWith { [""exit""] call XY_fnc_virtualShopMenu; true }"];

    _lblHeading ctrlSetStructuredText parseText format["<t size='1' align='center'>%1</t>", XY_VS_shopCaption];

    _sldShopCount sliderSetSpeed [1, 5];
    _sldPlayerCount sliderSetSpeed [1, 5];

    ["update"] call XY_fnc_virtualShopMenu;
};

if( _mode isEqualTo "exit" ) exitWith {
    closeDialog 0;
    XY_VS_shopName = nil;
    XY_VS_shopSource = nil;
    XY_VS_shopCaption = nil;
    XY_VS_shopContents = nil;
    XY_VS_shopPopulated = nil;
    [] call XY_fnc_save;
};

if( _mode isEqualTo "update" ) exitWith {

    lbClear _lstShopItems;
    lbClear _lstPlayerItems;

    {
        private _config = [_x] call XY_fnc_itemConfig;
        if( !(_config isEqualTo []) ) then {

            private _buyPrice = _config select 3;
            if( _buyPrice > 0 && call (_config select 6) ) then {
                private _index = _lstShopItems lbAdd format[ "%1", _config select 2 ];
                _lstShopItems lbSetData [_index, _x];
                _lstShopItems lbSetValue [_index, _buyPrice];
            };

            private _count = [_x] call XY_fnc_getItemCountFromTrunk;
            private _sellPrice = _config select 4;
            if( _count > 0 && _sellPrice > 0 ) then {
                private _index = _lstPlayerItems lbAdd format[ "[%1] %2", _count, _config select 2];
                _lstPlayerItems lbSetData [_index, _x];
                _lstPlayerItems lbSetValue [_index, _sellPrice];
            };
        };
    } forEach XY_VS_shopContents;

    ["selection_shop"] call XY_fnc_virtualShopMenu;
    ["selection_player"] call XY_fnc_virtualShopMenu;

    XY_VS_shopPopulated = true;
};

private _indexShop = lbCurSel _lstShopItems;
private _itemShop = _lstShopItems lbData _indexShop;

private _indexPlayer = lbCurSel _lstPlayerItems;
private _itemPlayer = _lstPlayerItems lbData _indexPlayer;

if( _mode isEqualTo "selection_shop" ) exitWith {
    _btnBuy ctrlEnable false;
    _sldShopCount ctrlEnable false;
    _lblBuyInfo ctrlSetStructuredText parseText "";

    if( _indexShop < 0 ) exitWith {};
    private _config = [_itemShop] call XY_fnc_itemConfig;
    if( _config isEqualTo [] ) exitWith {};
    private _maxItems = floor((XY_maxWeight - ([] call XY_fnc_getTrunkWeight)) / (_config select 1));
    if( _maxItems < 1 ) exitWith {
        _lblBuyInfo ctrlSetStructuredText parseText "<t size='0.7' align='center' color='#DD0505'>Inventar voll</t>";
    };

    _sldShopCount sliderSetRange [1, 1 max _maxItems];
    _sldShopCount sliderSetPosition 1;
    // For some reason slider setPosition is inconsistent with lbSetCurSel, which fires the attached handler, for the slider we have to do it ourself
    ["slider_shop"] call XY_fnc_virtualShopMenu;
};
if( _mode isEqualTo "slider_shop" || _mode isEqualTo "buy" ) exitWith {
    if( _indexShop < 0 || _itemShop isEqualTo "" ) exitWith {};
    private _config = [_itemShop] call XY_fnc_itemConfig;
    private _amount = round(sliderPosition _sldShopCount);
    private _price = round(_amount * (_config select 3));
    private _canBuy = _price <= XY_CA + XY_CC;

    if( _canBuy && (_mode isEqualTo "buy") ) exitWith {
        if( [_price] call XY_fnc_pay ) exitWith {
            hint parseText format[ "<t size='1.2' align='center'><t color='#F0C010'>%1x %2</t><br/><t color='#DD0505'>-%3€</t>", _amount, _config select 2, [_price] call XY_fnc_numberText ];
            [ getPlayerUID player, 14, format [ "Kauft %1x %2 (%3€)", _amount, _config select 2, [_price] call XY_fnc_numberText ] ] remoteExec ["XYDB_fnc_log", XYDB];
            [_itemShop, _amount] call XY_fnc_addItemToTrunk;
            ["update"] call XY_fnc_virtualShopMenu;
            _btnBuy ctrlEnable false;
        };
    };

    _lblBuyInfo ctrlSetStructuredText parseText format["<t size='0.7' align='center'><t color='#FF9900'>%1x %2</t> für <t color='#%3'>%4€</t></t>", _amount, _config select 2, ["DD0505", "00B515"] select _canBuy ,[_price] call XY_fnc_numberText];
    _btnBuy ctrlEnable _canBuy;
    _sldShopCount ctrlEnable true;
};

if( _mode isEqualTo "selection_player" ) exitWith {
    _btnSell ctrlEnable false;
    _sldPlayerCount ctrlEnable false;
    _lblSellInfo ctrlSetStructuredText parseText "";

    if( _indexPlayer < 0 ) exitWith {};
    private _maxItems = [_itemPlayer] call XY_fnc_getItemCountFromTrunk;
    _sldPlayerCount sliderSetRange [1, 1 max _maxItems];
    _sldPlayerCount sliderSetPosition 1;
    ["slider_player"] call XY_fnc_virtualShopMenu;
};
if( _mode isEqualTo "slider_player" || _mode isEqualTo "sell" ) exitWith {
    if( _indexPlayer < 0 || _itemPlayer isEqualTo "" ) exitWith {};
    private _config = [_itemPlayer] call XY_fnc_itemConfig;
    private _amount = round(sliderPosition _sldPlayerCount);
    private _price = _amount * (_config select 4);

    if( _mode isEqualTo "sell" ) exitWith {

        if( !([_itemPlayer, _amount] call XY_fnc_removeItemFromTrunk) ) exitWith {};

        XY_CC = XY_CC + _price;
        XY_forceSaveTime = time + 8;
        hint parseText format[ "<t size='1.2' align='center'><t color='#F0C010'>%1x %2</t><br/><t color='#05DD05'>+%3€</t>", _amount, _config select 2, [_price] call XY_fnc_numberText ];

        if( XY_VS_shopName in ["drugs", "blackmarket"] ) then {

            private _sellers = XY_VS_shopSource getVariable["sellers", []];
            private _uid = getPlayerUID player;
            private _found = false;
            {
                if( (_x select 0) isEqualTo _uid ) exitWith {
                    _found = true;
                };
            } forEach _sellers;

            if( !_found ) then {
                _sellers pushBack [_uid, profileName];
                XY_VS_shopSource setVariable["sellers", _sellers, true];
            };
        };
        private _found = false;
        {
            if( (_x select 0) isEqualTo _itemPlayer ) exitWith {
                _x set [1, (_x select 1) + _amount];
                _x set [2, (_x select 2) + _price];
                _found = true;
            };
        } forEach XY_marketVolume;

        if ( !_found ) then {
            XY_marketVolume pushBack [_itemPlayer, _amount, _price];
        };
        XY_marketLastAction = time;

        ["update"] call XY_fnc_virtualShopMenu;
    };

    _lblSellInfo ctrlSetStructuredText parseText format["<t size='0.7' align='center'><t color='#FF9900'>%1x %2</t> für <t color='#00B515'>%3€</t></t>", _amount, _config select 2, [_price] call XY_fnc_numberText];
    _sldPlayerCount ctrlEnable true;
    _btnSell ctrlEnable true;
};
