// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _curTarget = param[0, objNull, [objNull] ];

if( isNull _curTarget ) exitWith {};

private _isBank = XY_FED_DOME isEqualTo _curTarget || XY_FED_RSB isEqualTo _curTarget;
if( !_isBank && player distance _curTarget > 10 ) exitWith {};

disableSerialization;
createDialog "XY_dialog_interaction";

XY_currentInteraction = _curTarget;

_display = findDisplay 37400;

_buttons = [];
_buttons pushBack (_display displayCtrl 37450);
_buttons pushBack (_display displayCtrl 37451);
_buttons pushBack (_display displayCtrl 37452);
_buttons pushBack (_display displayCtrl 37453);
_buttons pushBack (_display displayCtrl 37454);
_buttons pushBack (_display displayCtrl 37455);
_buttons pushBack (_display displayCtrl 37456);
_buttons pushBack (_display displayCtrl 37457);
_buttons pushBack (_display displayCtrl 37458);
_buttons pushBack (_display displayCtrl 37459);

( _display displayCtrl 37401 ) ctrlSetText toUpper(getText(configFile >> "CfgVehicles" >> (typeOf _curTarget) >> "displayName"));

{
    _x ctrlEnable false;
    _x ctrlSetText "";
} forEach _buttons;

if( _curTarget isKindOf "House_F" && playerSide isEqualTo west ) exitWith {

    if( _isBank ) exitWith {

        (_buttons select 0) ctrlSetText localize "STR_pInAct_Repair";
        (_buttons select 0) buttonSetAction "[XY_currentInteraction] spawn XY_fnc_repairDoor; closeDialog 0;";
        (_buttons select 0) ctrlEnable true;

        (_buttons select 1) ctrlSetText localize "STR_pInAct_CloseOpen";
        (_buttons select 1) buttonSetAction "[XY_currentInteraction] call XY_fnc_doorAnimate; closeDialog 0;";
        (_buttons select 1) ctrlEnable true;
    };

    if( !(_curTarget getVariable["house_owner", ""] isEqualTo "") ) exitWith {

        (_buttons select 0) ctrlSetText localize "STR_House_Raid_Owner";
        (_buttons select 0) buttonSetAction "[XY_currentInteraction] call XY_fnc_copHouseOwner;";
        (_buttons select 0) ctrlEnable true;

        (_buttons select 1) ctrlSetText localize "STR_pInAct_BreakDown";
        (_buttons select 1) buttonSetAction "[XY_currentInteraction] spawn XY_fnc_copBreakDoor; closeDialog 0;";
        (_buttons select 1) ctrlEnable true;

        (_buttons select 2) ctrlSetText localize "STR_pInAct_SearchHouse";
        (_buttons select 2) buttonSetAction "[XY_currentInteraction] spawn XY_fnc_raidHouse; closeDialog 0;";
        (_buttons select 2) ctrlEnable true;

        (_buttons select 3) ctrlSetText localize "STR_pInAct_LockHouse";
        (_buttons select 3) buttonSetAction "[XY_currentInteraction] spawn XY_fnc_lockupHouse; closeDialog 0;";
        (_buttons select 3) ctrlEnable true;

    };
    closeDialog 0;
};

// Check if house is buyable
if( ([typeOf _curTarget] call XY_fnc_houseConfig) isEqualTo [] ) exitWith {
    closeDialog 0;
};

if( !(_curTarget in XY_vehicles) || (_curTarget getVariable["house_owner", []]) isEqualTo [] ) exitWith {
    if( _curTarget in XY_vehicles ) then {
        // no owner but in our owner list...wtf?
        XY_vehicles = XY_vehicles - [_curTarget];
    };
    (_buttons select 0) ctrlSetText localize "STR_pInAct_BuyHouse";
    (_buttons select 0) buttonSetAction "[XY_currentInteraction] spawn XY_fnc_buyHouse;";
    (_buttons select 0) ctrlEnable (_curTarget getVariable["house_owner", []] isEqualTo []);
};

if( (typeOf _curTarget) in ["Land_i_Garage_V1_F", "Land_i_Garage_V2_F"] ) exitWith {

    (_buttons select 0) ctrlSetText localize "STR_pInAct_SellGarage";
    (_buttons select 0) buttonSetAction "[XY_currentInteraction] spawn XY_fnc_sellHouse; closeDialog 0;";
    (_buttons select 0) ctrlEnable (((_curTarget getVariable ["house_owner", [""]]) select 0) isEqualTo (getPlayerUID player));

    (_buttons select 1) ctrlSetText localize "STR_pInAct_AccessGarage";
    (_buttons select 1) buttonSetAction "closeDialog 0; [XY_fnc_vehicleGarage, [""Car"", playerSide, [[XY_currentInteraction modelToWorld [-10, 0, 0], (getDir XY_currentInteraction) - 90]]]] call XY_fnc_unscheduled;";
    (_buttons select 1) ctrlEnable true;

    (_buttons select 2) ctrlSetText localize "STR_pInAct_StoreVeh";
    (_buttons select 2) buttonSetAction "closeDialog 0; [objNull, playerSide] spawn XY_fnc_storeVehicle; ";
    (_buttons select 2) ctrlEnable true;
};

(_buttons select 0) ctrlSetText "VERKAUFEN";
(_buttons select 0) buttonSetAction "[XY_currentInteraction] spawn XY_fnc_sellHouse; closeDialog 0;";
(_buttons select 0) ctrlEnable (((_curTarget getVariable ["house_owner", [""]]) select 0) isEqualTo (getPlayerUID player));

(_buttons select 1) ctrlSetText ([localize "STR_pInAct_UnlockStorage", localize "STR_pInAct_LockStorage"] select (_curTarget getVariable ["locked", false]));
(_buttons select 1) buttonSetAction "[XY_currentInteraction] call XY_fnc_lockHouse; closeDialog 0;";
(_buttons select 1) ctrlEnable true;

(_buttons select 2) ctrlSetText ([localize "STR_pInAct_LightsOff", localize "STR_pInAct_LightsOn"] select (isNull (_curTarget getVariable ["lightSource", objNull])));
(_buttons select 2) buttonSetAction "[XY_currentInteraction] call XY_fnc_lightHouseAction; closeDialog 0;";
(_buttons select 2) ctrlEnable true;