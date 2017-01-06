// Author: Bryan "Tonic" Boardwine
// Rewritten by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _source = param[0, objNull, [objNull]];
if( isNull _source ) exitWith {};

XY_actionInUse = true;
"DialogKiller" spawn { scriptName _this;
    while { XY_actionInUse } do {
        closeDialog 0;
    };
};

private _message = format["%1 hat dich niedergeschlagen", [_source getVariable["realName", "ERROR"], "Maskierte Person"] select ([_source] call XY_fnc_playerMasked)];

systemChat _message;
titleText[ _message, "PLAIN"];

player playMoveNow "incapacitated";
XY_interrupted = true;

private _dummyObject = "Land_ClutterCutter_small_F" createVehicle (getPosATL player);
_dummyObject setPosATL (getPosATL player);
player attachTo [_dummyObject, [0, 0, 0]];

// Allow robbing me :(
player setVariable["allowRob", true, true];

uisleep 20;
player playMoveNow "amovppnemstpsraswrfldnon";
detach player;

deleteVehicle _dummyObject;

player setVariable["allowRob", false, true];

XY_actionInUse = false;