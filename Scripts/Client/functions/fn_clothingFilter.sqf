// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

disableSerialization;

private _control = _this select 0;
private _selection = _this select 1;

XY_clothingFilter = _selection;

if(isNull (findDisplay 3100)) exitWith {};

private _list = (findDisplay 3100) displayCtrl 3101;
lbClear _list;

_clothes = switch (XY_clothingStore) do {
    case "civ": { [ "Seriöse Bekleidung", XY_clothing_civilian select _selection ] };
    case "cop": { [ "Dienstbekleidung" , XY_clothing_cop select _selection ] };
    case "reb": { [ "Unseriöse Bekleidung", XY_clothing_rebel select _selection ] };
    case "med": { [ "Sanitäter-Bedarf", XY_clothing_medic select _selection ] };
    case "kart": { ["Racing-Outfits", XY_clothing_kart select _selection ] };
    case "dive": { ["Tauch-Shop", XY_clothing_dive select _selection ] };
    default { [] };
};

if( _clothes isEqualTo [] ) exitWith {};

ctrlSetText[3103, _clothes select 0];
{
    if( count _x < 4 || { call (_x select 3) } ) then {

        _price = _x select 2;

        _details = [_x select 0] call XY_fnc_fetchCfgDetails;
        if( isNil {_x select 1} ) then {
            _list lbAdd format["%1", getText(configFile >> (_details select 6) >> (_x select 0) >> "DisplayName")];
        } else {
            _list lbAdd format["%1", _x select 1];
        };
        _pic = getText(configFile >> (_details select 6) >> (_x select 0) >> "picture");
        _list lbSetData [ (lbSize _list) - 1, _x select 0 ];
        _list lbSetValue [ (lbSize _list) - 1, _price ];
        _list lbSetPicture [ (lbSize _list) - 1, _pic ];
    };

} forEach (_clothes select 1);