// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
//
// call with item class to retrieve stats (armor, weight, capacity)
// armor is unreliable since Nexus update :(

private _item = param[ 0, "", [""] ];
if( _item isEqualTo "" ) exitWith { [] };

// Borrowed from BIS_fnc_arsenal, hope this is ok guys... >>
if( isNil "XY_clothingMinMax" ) then {
    private _statsEquipment = [ ("isClass _x && getNumber (_x >> 'scope') == 2 && getNumber (_x >> 'itemInfo' >> 'type') in [605, 701, 801]") configClasses (configfile >> "CfgWeapons"), ["armor","maximumLoad","mass"], [true, false, false] ] call BIS_fnc_configExtremes;
    private _statsBackpacks = [ ("isClass _x && getNumber (_x >> 'scope') == 2 && getNumber (_x >> 'isBackpack') == 1") configClasses (configfile >> "CfgVehicles"), ["armor","maximumLoad","mass"], [true, false, false] ] call BIS_fnc_configExtremes;

    private _statsEquipmentMin = _statsEquipment select 0;
    private _statsEquipmentMax = _statsEquipment select 1;

    private _statsBackpacksMin = _statsBackpacks select 0;
    private _statsBackpacksMax = _statsBackpacks select 1;

    for "_i" from 1 to 2 do { //--- Ignore backpack armor, has no effect
        _statsEquipmentMin set [ _i, (_statsEquipmentMin select _i) min (_statsBackpacksMin select _i) ];
        _statsEquipmentMax set [ _i, (_statsEquipmentMax select _i) max (_statsBackpacksMax select _i) ];
    };

    XY_clothingMinMax = [_statsEquipmentMin, _statsEquipmentMax];
};

_cfg = switch(true) do {
    case( isClass (configFile >> "CfgVehicles" >> _item) ): { "CfgVehicles" };
    case( isClass (configFile >> "CfgWeapons" >> _item) ): { "CfgWeapons" };
    default { "" };
};
if( _cfg isEqualTo [] ) exitWith { _cfg };

private _statsMin = XY_clothingMinMax select 0;
private _statsMax = XY_clothingMinMax select 1;

private _stats = [ [configfile >> _cfg >> _item], ["armor", "maximumLoad", "mass"], [true, false, false], _statsMin ] call bis_fnc_configExtremes;
_stats = _stats select 0;

private _statArmor = linearConversion [_statsMin select 0, _statsMax select 0, _stats select 0, 0, 1];
private _statMaximumLoad = linearConversion [_statsMin select 1,_statsMax select 1,_stats select 1, 0, 1];
private _statMass = linearConversion [_statsMin select 2,_statsMax select 2,_stats select 2, 0, 1];

if( getNumber (configfile >> _cfg >> _item >> "isBackpack") == 1 ) then {
    _statArmor = 0;
};
// <<

[_statArmor, _statMaximumLoad, _statMass]