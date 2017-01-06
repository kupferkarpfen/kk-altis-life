// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

disableSerialization;

private _list = (findDisplay 2400) displayCtrl 2402;
private _data = lbData[2401, lbCurSel 2401];
_data = call compile format["%1", _data];

if(isNil "_data") exitWith {
    _list lbAdd "Fehler beim Abrufen der Verbrechen";
};
if( typeName _data != "ARRAY" ) exitWith {
    _list lbAdd "Fehler beim Abrufen der Verbrechen";
};
if( _data isEqualTo [] ) exitWith {
    _list lbAdd "Keine Vebrechen gelistet";
};

lbClear _list;

private _total = 0;
{
    _list lbAdd format["%1 (%2€)", _x select 0, [_x select 1] call XY_fnc_numberText ];
    _total = _total + (_x select 1);
} forEach (_data select 1);

ctrlSetText[2403, format["Aktuelles Kopfgeld: %1€", [_total] call XY_fnc_numberText] ];