// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
disableSerialization;

private _shopContents = param[0, [], [[]]];
if( _shopContents isEqualTo [] ) exitWith {};

if( !(createDialog "XY_dialog_weaponShop") ) exitwith {};

private _display = objNull;
waitUntil { _display = findDisplay 38400; !(_display isEqualTo objNull) };

private _list = _display displayCtrl 38403;
lbClear _list;

{
    if( (_x select 0) in _shopContents ) then {
        {
            if( call (_x select 3) )then {
                private _config = [_x select 0] call XY_fnc_fetchCfgDetails;
                _list lbAdd format["%1", [_x select 1, _config select 1] select ((_x select 1) isEqualTo "")];
                _list lbSetData [(lbSize _list) - 1, _config select 0 ];
                _list lbSetPicture [(lbSize _list) - 1, _config select 2 ];
                _list lbSetValue [(lbSize _list) - 1, round((_x select 2) * XY_ssv_WD * XY_ssv_GD) ];
            };
        } forEach (_x select 1);
    };
} forEach XY_objectShops;