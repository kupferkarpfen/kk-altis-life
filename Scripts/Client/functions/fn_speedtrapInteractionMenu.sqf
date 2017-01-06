// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _curTarget = param[ 0, objNull, [objNull] ];
if( isNull _curTarget || { !(typeOf _curTarget isKindOf "Land_Runway_PAPI") } ) exitWith {};
if( playerSide != west ) exitWith {};

XY_currentInteraction = _curTarget;

disableSerialization;

createDialog "XY_dialog_interaction";

private _display = findDisplay 37400;

private _buttons = [];
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

( _display displayCtrl 37401 ) ctrlSetText "Radarfalle einstellen";

{
    _x ctrlEnable false;
    _x ctrlSetText "";
} forEach _buttons;

(_buttons select 0) ctrlSetText ([ "Aktivieren", "Deaktivieren" ] select (_curTarget getVariable["enabled", false]) );
(_buttons select 0) buttonSetAction "closeDialog 0; XY_currentInteraction setVariable[""enabled"", !(XY_currentInteraction getVariable[""enabled"", false]), true ]";
(_buttons select 0) ctrlEnable true;

(_buttons select 1) ctrlSetText format["Aktuelles Limit: %1 km/h", _curTarget getVariable["speedlimit", 50]];

(_buttons select 2) ctrlSetText "Limit 130 (Außerorts)";
(_buttons select 2) buttonSetAction "closeDialog 0; XY_currentInteraction setVariable[""speedlimit"", 130, true ];";
(_buttons select 2) ctrlEnable true;

(_buttons select 3) ctrlSetText "Limit 50 (Innerorts)";
(_buttons select 3) buttonSetAction "closeDialog 0; XY_currentInteraction setVariable[""speedlimit"", 50, true ];";
(_buttons select 3) ctrlEnable true;

(_buttons select 4) ctrlSetText "Limit 30 (Baustelle)";
(_buttons select 4) buttonSetAction "closeDialog 0; XY_currentInteraction setVariable[""speedlimit"", 30, true ];";
(_buttons select 4) ctrlEnable true;

(_buttons select 5) ctrlSetText "Limit 30 (Kavala Markt)";
(_buttons select 5) buttonSetAction "closeDialog 0; XY_currentInteraction setVariable[""speedlimit"", 30, true ];";
(_buttons select 5) ctrlEnable true;