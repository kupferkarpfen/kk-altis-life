// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// based on work by Tonic

disableSerialization;

private _dialog = findDisplay 2001;
private _inv = _dialog displayCtrl 2005;
private _lic = _dialog displayCtrl 2014;
private _near = _dialog displayCtrl 2022;
private _near_i = _dialog displayCtrl 2023;
private _mstatus = _dialog displayCtrl 2015;
private _struct = "";

lbClear _inv;
lbClear _lic;
lbClear _near;
lbClear _near_i;

{
    _near lbAdd format[ "%1", [_x select 2, _x select 1] select (_x select 6)];
    _near lbSetData [ (lbSize _near) - 1, str(_x select 0) ];

    _near_i lbAdd format[ "%1", [_x select 2, _x select 1] select (_x select 6)];
    _near_i lbSetData [ (lbSize _near_i) - 1, str(_x select 0) ];

} forEach (call XY_fnc_reachablePlayers);

_mstatus ctrlSetStructuredText parseText format[ "<img size='1.3' image='icons\bank.paa'/> <t size='0.8px'>%1€</t><br/><img size='1.2' image='icons\money.paa'/> <t size='0.8'>%2€</t>", [XY_CA] call XY_fnc_numberText, [XY_CC] call XY_fnc_numberText ];

ctrlSetText[2009, format[ "Gewicht: %1 / %2", [] call XY_fnc_getTrunkWeight, XY_maxWeight ]];

{
    if( (_x select 1) > 0) then {
        private _config = [_x select 0] call XY_fnc_itemConfig;
        if( !(_config isEqualTo []) ) then {
            private _index = _inv lbAdd format["%1x %2", _x select 1, _config select 2];
            _inv lbSetData [_index, _x select 0];
        };
    };
} forEach XY_playerTrunk;

// TODO: directly compare sides, and not this crappy string shit
private _side = switch(playerSide) do {
    case west:{ "cop" };
    case civilian:{ "civ" };
    case independent: { "med" };
};

private _licensesFound = false;
{
    if( (_x select 1) isEqualTo _side) then {
        if( missionNamespace getVariable [format["license_%1", _x select 0], false] ) then {
            _licensesFound = true;
            _lic lbAdd (_x select 2);
        };
    };
} forEach (XY_licenses + XY_training);

if( !(_licensesFound) ) then {
    _lic lbAdd "Keine Lizenzen";
};