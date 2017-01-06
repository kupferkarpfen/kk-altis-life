/*
    File: fn_giveItem.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Gives the selected item & amount to the selected player and
    removes the item & amount of it from the players virtual
    inventory.
*/

if( (lbCurSel 2023) == -1 ) exitWith {
    hint "Du hast niemanden ausgewählt!";
};
if( (lbCurSel 2005) == -1 ) exitWith {
    hint "Wähle einen Gegenstand aus.";
};

private _unit = lbData [2023, lbCurSel 2023];
_unit = call compile format["%1", _unit];
if( isNil "_unit" || { isNull _unit } || { _unit isEqualTo player } ) exitWith {};

private _item = lbData [2005, (lbCurSel 2005)];
if( isNil "_item" || { _item isEqualTo "" } ) exitWith {};

private _val = ctrlText 2010;
if( !([_val] call XY_fnc_isNumber) ) exitWith {
    hint "Gib eine Zahl ein";
};
_val = parseNumber(_val);
if( _val <= 0 ) exitWith {
    hint "Gib eine Menge > 0 an";
};

private _config = [_item] call XY_fnc_itemConfig;

if( _config select 5 && { ([ west, getPos player, 50 ] call XY_fnc_nearUnits) } ) exitWith {
    hint "Dieser Gegenstand ist illegal, du kannst ihn nicht weitergeben solange die Polizei in der Nähe ist";
};

if( !([_item, _val] call XY_fnc_removeItemFromTrunk) ) exitWith {
    hint "Du hast davon nicht genug!";
};

XY_forceSaveTime = time;
// Delay give a few seconds to prevent duping
[_unit, _item, _val, player] spawn {
    sleep 2.5;
    _this remoteExec ["XY_fnc_receiveItem", _this select 0];
};

[getPlayerUID player, 2, format ["Hat %1 (%2) %3 %4 gegeben", name _unit, getPlayerUID _unit, _val, _config select 2 ]] remoteExec ["XYDB_fnc_log", XYDB];
hint format["Du hast %1 %2 %3 gegeben.", [ _unit getVariable["realName", name _unit], "der maskierten Person" ] select ([_unit] call XY_fnc_playerMasked), _val, _config select 2];

[] call XY_fnc_p_updateMenu;