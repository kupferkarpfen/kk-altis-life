// File: fn_playerInteractionMenu.sqf
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _curTarget = param[ 0, ObjNull, [ObjNull] ];

createDialog "XY_dialog_interaction";

disableSerialization;

XY_currentInteraction = _curTarget;

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

private _targetInfo = [XY_currentInteraction] call XY_fnc_playerInfo;
( _display displayCtrl 37401 ) ctrlSetText ( [_targetInfo select 2, _targetInfo select 1] select (_targetInfo select 6) );

{
    _x ctrlEnable false;
    _x ctrlSetText "";
} forEach _buttons;

private _restrained = _curTarget getVariable["restrained", false];
private _incapacitated = (animationState _curTarget) isEqualTo "incapacitated";

if( playerSide isEqualTo west ) exitWith {

    //Set Unrestrain Button
    (_buttons select 0) ctrlSetText localize "STR_pInAct_Unrestrain";
    (_buttons select 0) buttonSetAction "closeDialog 0; [XY_currentInteraction] call XY_fnc_unrestrain;";
    (_buttons select 0) ctrlEnable _restrained;

    //Set Check Licenses Button
    (_buttons select 1) ctrlSetText localize "STR_pInAct_checkLicenses";
    (_buttons select 1) buttonSetAction "closeDialog 0; [player] remoteExec [""XY_fnc_licenseCheck"", XY_currentInteraction];";
    (_buttons select 1) ctrlEnable true;

    //Set Search Button
    (_buttons select 2) ctrlSetText localize "STR_pInAct_SearchPlayer";
    (_buttons select 2) buttonSetAction "closeDialog 0; [XY_currentInteraction] spawn XY_fnc_searchAction;";
    (_buttons select 2) ctrlEnable _restrained;

    //Set Escort Button
    if( _curTarget getVariable["escorting", false] ) then {
        (_buttons select 3) ctrlSetText localize "STR_pInAct_StopEscort";
        (_buttons select 3) buttonSetAction "closeDialog 0; [XY_currentInteraction] call XY_fnc_stopEscorting;";
    } else {
        (_buttons select 3) ctrlSetText localize "STR_pInAct_Escort";
        (_buttons select 3) buttonSetAction "closeDialog 0; [XY_currentInteraction] call XY_fnc_escortAction;";
    };
    (_buttons select 3) ctrlEnable _restrained;

    //Set Ticket Button
    (_buttons select 4) ctrlSetText localize "STR_pInAct_TicketBtn";
    (_buttons select 4) buttonSetAction "closeDialog 0; [XY_currentInteraction] call XY_fnc_ticketAction;";
    (_buttons select 4) ctrlEnable true;

    (_buttons select 5) ctrlSetText localize "STR_pInAct_Arrest";
    (_buttons select 5) buttonSetAction "closeDialog 0; createDialog ""XY_dialog_jailTime"";";
    (_buttons select 5) ctrlEnable (
        _restrained && (
            player distance getMarkerPos "cop_spawn_1" < 40 ||
            player distance getMarkerPos "cop_spawn_2" < 40 ||
            player distance getMarkerPos "cop_spawn_3" < 40 ||
            player distance getMarkerPos "cop_spawn_4" < 40 ||
            player distance getMarkerPos "other_safezone_kavala" < 100 ||
            player distance getMarkerPos "jail_marker" < 100
        )
    );

    (_buttons select 6) ctrlSetText localize "STR_pInAct_PutInCar";
    (_buttons select 6) buttonSetAction "[XY_currentInteraction] call XY_fnc_putInCar;";
    (_buttons select 6) ctrlEnable _restrained;

    (_buttons select 7) ctrlSetText localize "STR_pInAct_Breathalyzer";
    (_buttons select 7) buttonSetAction "closeDialog 0; [player] remoteExec [""XY_fnc_drugTest"", XY_currentInteraction];";
    (_buttons select 7) ctrlEnable true;

    (_buttons select 8) ctrlSetText localize "STR_pInAct_RevokeLicense";
    (_buttons select 8) buttonSetAction "closeDialog 0; [XY_currentInteraction] call XY_fnc_revokeLicense;";
    (_buttons select 8) ctrlEnable true;
	
    if( _curTarget getVariable["blinded", false] ) then {
        (_buttons select 9) ctrlSetText "Augenbinde entfernen";
        (_buttons select 9) buttonSetAction "closeDialog 0; [] remoteExec[""XY_fnc_headBag"", XY_currentInteraction];";
        (_buttons select 9) ctrlEnable true;
    } else {
        (_buttons select 9) ctrlSetText "Augen verbinden";
        (_buttons select 9) buttonSetAction "closeDialog 0; [] remoteExec[""XY_fnc_headBag"", XY_currentInteraction];";
        (_buttons select 9) ctrlEnable _restrained;
    };

};

if( playerSide isEqualTo civilian ) exitWith {

    //Set Escort Button
    if( _curTarget getVariable["escorting", false] ) then {
        (_buttons select 0) ctrlSetText localize "STR_pInAct_StopEscort";
        (_buttons select 0) buttonSetAction "closeDialog 0; [XY_currentInteraction] call XY_fnc_stopEscorting;";
    } else {
        (_buttons select 0) ctrlSetText localize "STR_pInAct_Escort";
        (_buttons select 0) buttonSetAction "closeDialog 0; [XY_currentInteraction] call XY_fnc_escortAction;";
    };
    (_buttons select 0) ctrlEnable _restrained;

    (_buttons select 1) ctrlSetText localize "STR_pInAct_PutInCar";
    (_buttons select 1) buttonSetAction "closeDialog 0; [XY_currentInteraction] call XY_fnc_putInCar;";
    (_buttons select 1) ctrlEnable _restrained;

    if( _curTarget getVariable["blinded", false] ) then {
        (_buttons select 2) ctrlSetText "Augenbinde entfernen";
        (_buttons select 2) buttonSetAction "closeDialog 0; [] remoteExec[""XY_fnc_headBag"", XY_currentInteraction];";
        (_buttons select 2) ctrlEnable true;
    } else {
        (_buttons select 2) ctrlSetText "Augen verbinden";
        (_buttons select 2) buttonSetAction "closeDialog 0; [] remoteExec[""XY_fnc_headBag"", XY_currentInteraction];";
        (_buttons select 2) ctrlEnable _restrained;
    };

    (_buttons select 3) ctrlSetText "Niere entnehmen";
    (_buttons select 3) buttonSetAction "closeDialog 0; [XY_currentInteraction] call XY_fnc_takeOrgans;";
    (_buttons select 3) ctrlEnable _incapacitated;

    /* TODO: Nur selbst gefesselte entfesseln lassen (_buttons select 4) ctrlSetText "Freilassen";
    (_buttons select 4) buttonSetAction "closeDialog 0; [XY_currentInteraction] call XY_fnc_unrestrain;";
    (_buttons select 4) ctrlEnable _restrained;*/
};

if( playerSide isEqualTo independent ) exitWith {

    (_buttons select 0) ctrlSetText "Spende anfragen";
    (_buttons select 0) buttonSetAction "closeDialog 0; [XY_currentInteraction] spawn XY_fnc_ticketAction;";
    (_buttons select 0) ctrlEnable true;

    (_buttons select 1) ctrlSetText "Niere einpflanzen";
    (_buttons select 1) buttonSetAction "closeDialog 0; [XY_currentInteraction] spawn XY_fnc_insertOrgan;";
    (_buttons select 1) ctrlEnable ( _curTarget getVariable["missingOrgan", false] );
};