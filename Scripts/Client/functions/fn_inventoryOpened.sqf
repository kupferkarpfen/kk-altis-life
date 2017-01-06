/*
    Author: Bryan "Tonic" Boardwine

    Description:
    For the mean time it blocks the player from opening another persons backpack
*/

private _unit = param[0, objNull, [objNull]];
private _container = param[1, objNull, [objNull]];

if( _unit isEqualTo objNull || _container isEqualTo objNull ) exitWith {};

private _lockedUntil = _container getVariable["box.locked", 0];
if( _lockedUntil > serverTime ) exitWith {
    hint parseText format [XY_hintError, format["Das Zeitschloss der Box öffnet sich erst in %1 Sekunden", _lockedUntil - serverTime]];
    true
};

if( (playerSide isEqualTo west) || XY_IN_PVP ) exitWith {};

if( getNumber(configFile >> "CfgVehicles" >> (typeOf _container) >> "isBackpack") isEqualTo 1 ) exitWith {
    true
};

if( (typeOf _container) isEqualTo "B_supplyCrate_F" ) exitWith {
    private _house = nearestBuilding (getPosATL player);
    if( !( _house in XY_vehicles ) && (_house getVariable ["locked", true]) ) then {
        hint localize "STR_House_ContainerDeny";
        true
    };
};

if( _container isKindOf "Car" || _container isKindOf "Ship" || _container isKindOf "Air" ) exitWith {
    if( !(_container in XY_vehicles) && { (locked _container) == 2 } ) exitWith {
        hint localize "STR_MISC_VehInventory";
        true
    };
};

// Allow alive players who've been knocked out to be looted, just not the dead ones
if( _container isKindOf "Man" && !(alive _container) ) exitWith {
    hint localize "STR_NOTF_NoLootingPerson";
    true
};