/*
	File: fn_catchFish.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Catches a fish that is near by.
*/
private["_fish", "_type", "_count", "_config"];

params[ ["_fish", objNull, [objNull]] ];

if( !(_fish isKindOf "Fish_Base_F") && !(_fish isKindOf "Turtle_F") ) exitWith {};

if( player distance _fish > 3.5 ) exitWith {};

_count = 1;
_type =  switch(true) do {
	case ((typeOf _fish) == "Salema_F"): { "salema" };
	case ((typeOf _fish) == "Ornate_random_F") : { "ornate" };
	case ((typeOf _fish) == "Mackerel_F") : { "mackerel" };
	case ((typeOf _fish) == "Tuna_F") : { "tuna" };
	case ((typeOf _fish) == "Mullet_F") : { "mullet" };
	case ((typeOf _fish) == "CatShark_F") : { "catshark" };
	case ((typeOf _fish) == "Turtle_F" && !(alive _fish) ) : {_count = floor(2 + random 3); "turtle"};
	default { "" };
};

if( _type isEqualTo "" ) exitWith {};

if( ([] call XY_fnc_getTrunkWeight) >= XY_maxWeight ) exitWith {
    hint parseText format[XY_hintError, "Dein Inventar ist voll"];
};

if( ([_type, _count] call XY_fnc_addItemToTrunk) ) then {
	deleteVehicle _fish;

    _config = [_type] call XY_fnc_itemConfig;    
	hint format[localize "STR_NOTF_Fishing", _config select 2];
};