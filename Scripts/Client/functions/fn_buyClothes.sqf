/*
	File: fn_buyClothes.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Buys the current set of clothes and closes out of the shop interface.
*/
private["_price","_itemInfo","_item"];
if((lbCurSel 3101) == -1) exitWith {titleText[localize "STR_Shop_NoClothes","PLAIN"];};

_price = 0;
{
	if(_x != -1) then {
		_price = _price + _x;
	};
} forEach XY_clothingPurchase;

_item = lbData[3101, lbCurSel 3101];


_itemInfo = [_item] call XY_fnc_fetchCfgDetails;
if( _itemInfo isEqualTo [] ) exitWith {};


if( !([_price] call XY_fnc_pay) ) exitWith {
    hint "Du hast nicht genug Geld um diese Kleidung zu kaufen";
};

XY_clothesPurchased = true;
[ getPlayerUID player, 14, format [ "Kauft %1 (%2€)", _itemInfo select 1 , [_price] call XY_fnc_numberText ] ] remoteExec ["XYDB_fnc_log", XYDB];
closeDialog 0;

XY_forceSaveTime = time + 8;