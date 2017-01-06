// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

disableSerialization;

private _display = displayNull;
waitUntil { _display = findDisplay 49; !(_display isEqualTo displayNull) };

private _btnContinue = _display displayCtrl 2;
private _btnSave = _display displayCtrl 103;
private _btnManual = _display displayCtrl 122;
private _btnRespawn = _display displayCtrl 1010;
private _btnSettings = _display displayCtrl 101;
private _btnAbort = _display displayCtrl 104;

_btnRespawn ctrlEnable false;
_btnSave ctrlEnable false;

_btnContinue ctrlSetStructuredText parseText "<t color='#EEEEEE'>Weiterspielen</t>";
_btnSave ctrlSetStructuredText parseText "<t color='#999999'>TS: ts.Just4FunGaming24.de</t>";
_btnRespawn ctrlSetStructuredText parseText "<t color='#999999'>HILFE</t>";
_btnSettings ctrlSetStructuredText parseText "<t color='#EEEEEE'>Einstellungen</t>";
_btnRespawn ctrlSetStructuredText parseText format["<t color='#EEEEEE'>UID: %1</t>", getPlayerUID player];

_btnManual ctrlSetEventHandler [ "ButtonClick", "[] spawn { closeDialog 0; (findDisplay 49) closeDisplay 0; closeDialog 0; [""init""] call XY_fnc_helpMenu; }; true" ];

if( player getVariable["restrained", false] || missionNamespace getVariable["XY_isTazed", false] || missionNamespace getVariable["XY_isArrested", false] ) exitWith {
	_btnAbort ctrlEnable false;
};

private _timeOut = diag_tickTime + 10;
while{ diag_tickTime < _timeOut && !(isNull (findDisplay 49)) } do {
    _btnAbort ctrlSetText format["Verlassen möglich in %1", [_timeOut - diag_tickTime, "SS.MS"] call BIS_fnc_secondsToString];
    _btnAbort buttonSetAction "";
    _btnAbort ctrlEnable false;
    _btnAbort ctrlCommit 0;
};

_btnAbort ctrlSetStructuredText parseText "<t color='#EEEEEE'>Beenden</t>";
_btnAbort ctrlSetEventHandler [ "ButtonClick", "call XY_fnc_save; false" ];
_btnAbort ctrlCommit 0;
_btnAbort ctrlEnable true;