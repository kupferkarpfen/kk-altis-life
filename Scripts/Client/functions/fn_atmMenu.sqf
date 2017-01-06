/*
    File: fn_atmMenu.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Opens and manages the bank menu.
*/
private["_display","_text","_units","_type","_refresh"];

if( !XY_atmUsable ) exitWith {
    hint "Du kannst ein paar Minuten lang keinen ATM benutzen, da du ein gesuchter Verbrecher bist";
};

_refresh = false;
if(!dialog) then {
    _refresh = true;
    createDialog "XY_dialog_atm";
};

disableSerialization;

_display = findDisplay 2700;
_text = _display displayCtrl 2701;
_units = _display displayCtrl 2703;

_text ctrlSetStructuredText parseText format["<img size='1.7' image='icons\bank.paa'/> %1€<br/><img size='1.6' image='icons\money.paa'/> %2€", [XY_CA] call XY_fnc_numberText, [XY_CC] call XY_fnc_numberText];

if( _refresh ) then {
    lbClear _units;
    {
        if(alive _x) then {
            _type = switch (side _x) do {
                case west: { "Cop" };
                case civilian: { "Civ" };
                case independent: { "Medic" };
            };
            _units lbAdd format["%1 (%2)", _x getVariable["realName", name _x], _type];
            _units lbSetData [ (lbSize _units) - 1, str(_x) ];
        };
    } forEach playableUnits;

    lbSetCurSel [2703,0];
};