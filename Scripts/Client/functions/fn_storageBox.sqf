/*
    Author: Bryan "Tonic" Boardwine

    Description:
    Tries to place a storage box in the nearest house.
*/
private _boxType = param[0, "", [""]];

closeDialog 0;

if( XY_actionInUse ) exitWith {};

private _house = nearestBuilding (getPosATL player);
if(!(_house in XY_vehicles)) exitWith {hint localize "STR_ISTR_Box_NotinHouse"};
private _containers = _house getVariable["containers",[]];
private _houseCfg = [(typeOf _house)] call XY_fnc_houseConfig;
if(count _houseCfg == 0) exitWith {}; //What the fuck happened?
if(count _containers >= (_houseCfg select 1)) exitWith {hint localize "STR_ISTR_Box_HouseFull"};

private _slots = _house getVariable ["slots",[]];
private _positions = [_house] call XY_fnc_getBuildingPositions;
private _pos = [0,0,0];
{
    _slots = _house getVariable ["slots",[]];
    if(!(_forEachIndex in _slots)) exitWith {
        _slots pushBack _forEachIndex;
        _house setVariable["slots",_slots,true];
        _pos = _x;
    };
} forEach _positions;

if(_pos isEqualTo [0,0,0]) exitWith {
    hint localize "STR_ISTR_Box_HouseFull_2"
};

if( !([_boxType, 1] call XY_fnc_removeItemFromTrunk) ) exitWith {};
XY_actionInUse = true;

hint "Kiste wird platziert...";

[_pos, _house] spawn { scriptName "WaitForBoxSpawn";
    uisleep 5;
    hintSilent "";

    XY_actionInUse = false;
    private _container = "B_supplyCrate_F" createVehicle [0, 0, 0];

    //Empty out the crate
    clearWeaponCargoGlobal _container;
    clearMagazineCargoGlobal _container;
    clearItemCargoGlobal _container;
    clearBackpackCargoGlobal _container;

    private _house = (_this select 1);
    private _containers = _house getVariable["containers",[]];
    _containers pushBack _container;
    _house setVariable["containers", _containers, true];
    [_house] remoteExec ["XYDB_fnc_updateHouseContainers", 2];

    _container setPosATL (_this select 0);
};