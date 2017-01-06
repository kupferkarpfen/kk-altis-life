// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _house = param[0, objNull, [objNull]];
if( _house isEqualTo objNull || !(_house isKindOf "House_F") ) exitWith {};

closeDialog 0;

private _uid = getPlayerUID player;

if( !((_house getVariable["house_owner", []]) isEqualTo []) ) exitWith {
    hint "Das Haus ist schon verkauft...";
};
if( _house getVariable ["house_sold", false] ) exitWith {
    hint "Dieses Haus wird grad renoviert. Komm doch später wieder.";
};
if( !license_civ_home ) exitWith {
    hint "Dir fehlt die Hausbesitzurkunde";
};

// Check for a nosale marker nearby
private _noSale = false;
{
    if( (_x find "nosale") >= 0 && ((getMarkerPos _x) distance2D _house) < 12 ) exitWith {
        _noSale = true;
    };
} forEach allMapMarkers;

if( _noSale ) exitWith {
    hint "Dieses Haus steht aktuell nicht zum Verkauf";
};

private _houseCfg = [typeOf _house] call XY_fnc_houseConfig;
if( _houseCfg isEqualTo [] ) exitWith {};

private _count = 0;

private _isGarage = ((typeOf _house) in ["Land_i_Garage_V1_F", "Land_i_Garage_V2_F"]);

{
    if( _x isKindOf "House_F" && { ((_x getVariable["house_owner", [""]]) select 0) isEqualTo (getPlayerUID player) } ) then {
        if( ((typeOf _x) in ["Land_i_Garage_V1_F", "Land_i_Garage_V2_F"]) isEqualTo _isGarage ) then {
            _count = _count + 1;
        };
    };
} forEach XY_vehicles;

private _price = (_houseCfg select 0) * ( 1 + (_count * 0.3));

private _action = [
    format[ "Willst du %1 für %2€ kaufen?%3", [ "das Haus", "die Garage" ] select _isGarage, [_price] call XY_fnc_numberText, if( _isGarage ) then { "" } else { format[" Es unterstützt %1 Lagerbox(en).", _houseCfg select 1] }],
        "Haus kaufen?",
        "KAUFEN",
        "ABBRECHEN"
] call XY_fnc_showQuestionbox;

if( !_action ) exitWith {};

if( !([_price] call XY_fnc_pay) ) exitWith {
    hint "Das kannst du dir nicht leisten";
};

// Warning: the housing system ist not designed to support the HC yet !
[player, _house, _price] remoteExec ["XYDB_fnc_insertHouse", 2];