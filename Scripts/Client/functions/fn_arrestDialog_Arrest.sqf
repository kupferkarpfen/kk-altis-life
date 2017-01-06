if( playerSide != west ) exitWith {};
if( isNil "XY_currentInteraction" ) exitWith {};
private _unit = XY_currentInteraction;

// Get text
private _time = ctrlText 1400;

if( !([_time] call XY_fnc_isNumber) ) exitWith {
    hint "Du musst eine Zahl eingeben";
};

private _time = round (parseNumber _time);
if( _time < 5 || _time > 60 ) exitWith {
    hint "Die Gefängniszeit darf nur zwischen 5 und 60 Minuten betragen";
};
closeDialog 0;

private _action = [
    "Willst du dass der Spieler seine Rebellenlizenz verliert, falls er eine hat? Belohne ihn bitte, wenn das RP gut lief.",
    "Rebellenlizenz entfernen?",
    "ABNEHMEN",
    "BEHALTEN"
] call XY_fnc_showQuestionbox;

if( _action ) then {
    [2] remoteExec ["XY_fnc_removeLicenses", _unit];
};

if( !((attachedTo _unit) isEqualTo objNull) ) then {
  detach _unit;
};

[_time] remoteExec ["XY_fnc_jail", _unit];
[_unit, player] remoteExecCall ["XY_fnc_wantedBounty", 2];