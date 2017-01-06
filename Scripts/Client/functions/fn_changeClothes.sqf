/*
	File: fn_changeClothes.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Used in the clothing store to show a 'preview' of the piece of clothing.
*/
disableSerialization;
private["_control","_selection","_data","_price","_total","_totalPrice"];
_control = (_this select 0) select 0;
_selection = (_this select 0) select 1;
_price = (findDisplay 3100) displayCtrl 3102;
_total = (findDisplay 3100) displayCtrl 3106;
if(_selection == -1) exitWith {hint localize "STR_Shop_NoSelection";};
if(isNull _control) exitWith {hint localize "STR_Shop_NoDisplay"};
if(XY_cMenuLock) exitWith {};

XY_cMenuLock = true;

XY_clothingPurchase set[XY_clothingFilter,(_control lbValue _selection)];

_data = _control lbData _selection;

[_data, true, nil, nil, nil, nil, nil, true] call XY_fnc_handleItem;

XY_cMenuLock = false;

_stats = [_data] call XY_fnc_getClothingStats;
// ((findDisplay 3100) displayCtrl 3200) progressSetPosition ( _stats select 0 ); armor is unreliable since nexus update
((findDisplay 3100) displayCtrl 3300) progressSetPosition ( _stats select 1 );
((findDisplay 3100) displayCtrl 3400) progressSetPosition ( _stats select 2 );

_price ctrlSetStructuredText parseText format ["Preis: <t color='#8CFF9B'>%1€</t>", [_control lbValue _selection] call XY_fnc_numberText];

_totalPrice = 0;
{
	if( _x != -1 ) then {
		_totalPrice = _totalPrice + _x;
	};
} forEach XY_clothingPurchase;

_total ctrlSetStructuredText parseText format ["Gesamtpreis: <t color='#%1'>%2€</t>", ["8CFF9B", "FF3A3A"] select (_totalPrice > (XY_CC + XY_CA)), [_totalPrice] call XY_fnc_numberText];