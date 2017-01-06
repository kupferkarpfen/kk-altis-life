/*
    File: fn_weaponShopBuySell.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Master handling of the weapon shop for buying / selling an item.
*/
disableSerialization;

private["_price","_item","_itemInfo","_bad"];

if( (lbCurSel 38403) == -1 ) exitWith {
    hint localize "STR_Shop_Weapon_NoSelect"
};

_price = lbValue[38403, lbCurSel 38403];
if( isNil "_price" ) exitWith {};

_item = lbData[38403, lbCurSel 38403];

if(XY_actionInUse) exitWith {};
XY_actionInUse = true;

_itemInfo = [_item] call XY_fnc_fetchCfgDetails;
if( _itemInfo isEqualTo [] ) exitWith {};

_bad = "";

if( (_itemInfo select 6) != "CfgVehicles" ) then {
    if((_itemInfo select 4) in [4096, 131072]) then {
        if( !(player canAdd _item) ) exitWith {
            _bad = (localize "STR_NOTF_NoRoom")
        };
    };
};

if( !(_bad isEqualTo "") ) exitWith {
    hint _bad
};

if( !([_price] call XY_fnc_pay) ) exitWith {
    hint localize "STR_NOTF_NotEnoughMoney";
};
hint parseText format[ localize "STR_Shop_Weapon_BoughtItem", _itemInfo select 1, [_price] call XY_fnc_numberText ];

[_item, true] spawn XY_fnc_handleItem;
[ getPlayerUID player, 14, format [ "Kauft %1 (%2€)", _itemInfo select 1 , [_price] call XY_fnc_numberText ] ] remoteExec ["XYDB_fnc_log", XYDB];
XY_forceSaveTime = time + 4;