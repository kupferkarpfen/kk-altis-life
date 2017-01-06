// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _curTarget = param[0, objNull, [objNull]];

if( _curTarget isEqualTo objNull || !(_curTarget isKindOf "Car" || _curTarget isKindOf "Ship" || _curTarget isKindOf "Air") ) exitWith {};

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

private _button = 0;

(_buttons select _button) ctrlSetText "Reparieren";
(_buttons select _button) buttonSetAction "closeDialog 0; [XY_currentInteraction] spawn XY_fnc_repairTruck;";
(_buttons select _button) ctrlEnable ("ToolKit" in (items player));

_button = _button + 1;

(_buttons select _button) ctrlSetText "Schieben";
(_buttons select _button) buttonSetAction "closeDialog 0; [] spawn XY_fnc_pushObject;";
(_buttons select _button) ctrlEnable (_curTarget isKindOf "Ship" && { local _curTarget } && { (crew _curTarget) isEqualTo [] });

_button = _button + 1;

(_buttons select _button) ctrlSetText "Einsteigen";
(_buttons select _button) buttonSetAction "closeDialog 0; player moveInDriver XY_currentInteraction;";
(_buttons select _button) ctrlEnable ( !(([configfile >> "CfgVehicles" >> typeOf (_curTarget), "DLC", ""]  call BIS_fnc_returnConfigEntry) isEqualTo "") && { (crew _curTarget) isEqualTo [] } && { canMove _curTarget } && { locked _curTarget == 0 });

_button = _button + 1;

(_buttons select _button) ctrlSetText "Fahrzeug aufrichten";
(_buttons select _button) buttonSetAction "closeDialog 0; XY_currentInteraction allowDamage false; XY_currentInteraction setPos [getPos XY_currentInteraction select 0, getPos XY_currentInteraction select 1, (getPos XY_currentInteraction select 2) + 0.2]; XY_currentInteraction setVectorUp (surfaceNormal (getPos XY_currentInteraction)); [XY_currentInteraction] spawn { uisleep 1; _this allowDamage true; };";
(_buttons select _button) ctrlEnable ( vectorMagnitude ((vectorUp XY_currentInteraction) vectorDiff (surfaceNormal (getPos XY_currentInteraction))) > 0.1 );

_button = _button + 1;

if( playerSide isEqualTo west ) exitWith {

    (_buttons select _button) ctrlSetText "Halterabfrage";
    (_buttons select _button) buttonSetAction "closeDialog 0; [XY_currentInteraction] spawn XY_fnc_searchVehAction;";
    (_buttons select _button) ctrlEnable true;

    _button = _button + 1;

    (_buttons select _button) ctrlSetText "Fahrzeug durchsuchen";
    (_buttons select _button) buttonSetAction "closeDialog 0; [player, XY_currentInteraction] remoteExecCall [""XY_fnc_vehicleSearchContraband"", 2];";
    (_buttons select _button) ctrlEnable true;

    _button = _button + 1;

    (_buttons select _button) ctrlSetText "Insassen herausziehen";
    (_buttons select _button) buttonSetAction "closeDialog 0; [XY_currentInteraction] spawn XY_fnc_pulloutAction;";
    (_buttons select _button) ctrlEnable ( !((crew _curTarget) isEqualTo []) && speed _curTarget < 4 );

    _button = _button + 1;

    (_buttons select _button) ctrlSetText "Beschlagnahmen";
    (_buttons select _button) buttonSetAction "closeDialog 0; [XY_currentInteraction] spawn XY_fnc_impoundAction;";
    (_buttons select _button) ctrlEnable true;

    _button = _button + 1;

    (_buttons select _button) ctrlSetText "Zerstören";
    (_buttons select _button) buttonSetAction "closeDialog 0; [XY_currentInteraction] spawn XY_fnc_destroyAction;";
    (_buttons select _button) ctrlEnable (XY_copLevel >= 9);
};

if( playerSide isEqualTo civilian ) exitWith {

    (_buttons select _button) ctrlSetText "Insassen herausziehen";
    (_buttons select _button) buttonSetAction "closeDialog 0; [XY_currentInteraction] spawn XY_fnc_pulloutAction;";
    (_buttons select _button) ctrlEnable ( !((crew _curTarget) isEqualTo []) && speed _curTarget < 4 );

    _button = _button + 1;

    (_buttons select _button) ctrlSetText "Automatisch farmen";
    (_buttons select _button) buttonSetAction "closeDialog 0; [XY_currentInteraction] call XY_fnc_deviceMine;";
    (_buttons select _button) ctrlEnable ( (typeOf _curTarget) in ["O_Truck_03_device_F", "B_Truck_01_covered_F"] && { !(_curTarget getVariable ["busy", false]) } );

    _button = _button + 1;

    (_buttons select _button) ctrlSetText "Automatisch verarbeiten";
    (_buttons select _button) buttonSetAction "closeDialog 0; [XY_currentInteraction] call XY_fnc_deviceProcess;";
    (_buttons select _button) ctrlEnable ( (typeOf _curTarget) in ["O_Truck_03_device_F", "B_Truck_01_covered_F"] && { !(_curTarget getVariable ["busy", false]) } );

    _button = _button + 1;

    (_buttons select _button) ctrlSetText "Versichern";
    (_buttons select _button) buttonSetAction "closeDialog 0; [XY_currentInteraction] spawn XY_fnc_insureVehicle;";
    (_buttons select _button) ctrlEnable !(_curTarget getVariable ["insured", false]);
};