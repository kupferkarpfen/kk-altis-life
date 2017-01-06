// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _player  = param[ 0, objNull,     [objNull] ];
private _side    = param[ 1, sideUnknown, [west]    ];
private _vehicle = param[ 2, objNull,     [objNull] ];
private _color   = param[ 3, -1,          [0]       ];

//Error checks
if( _player isEqualTo objNull || _side isEqualTo sideUnknown || _vehicle isEqualTo objNull || _color < 0 ) exitWith {};

// Vehicle already destroyed
if( !(alive _vehicle) ) exitWith {};

private _uid = getPlayerUID _player;

private _class = typeOf _vehicle;

private _type = switch(true) do {
    case (_vehicle isKindOf "Car"): { "Car" };
    case (_vehicle isKindOf "Air"): { ["Air", "Jet"] select ((toLower _class) find "plane" >= 0 ) };
    case (_vehicle isKindOf "Ship"): { "Ship" };
};

private _side = switch(_side) do {
    case west: { "cop" };
    case civilian: { "civ" };
    case independent: { "med" };
    default { "Error" };
};

private _queryResult = [ format[ "insertVehicle:%1:%2:%3:%4:%5:%6", _side, _class, _type, _uid, [], _color ], true ] call XYDB_fnc_asyncCall;
if( _queryResult isEqualTo [] || (typeName _queryResult) isEqualTo "STRING" ) exitWith {
    diag_log format["<ERROR> NO INSERT ID RETURNED FOR VEHICLE INSERT (%1)", _this];
    ["ServerError", false, true] remoteExec ["BIS_fnc_endMission", _player];
};
private _vid = _queryResult select 0;
diag_log format["Vehicle DB ID: %1", _vid];

// Wait until spawnVehicle is executed on client-side...
waitUntil { uisleep 2; _vehicle getVariable ["id", -10] > -10 };

_vehicle setVariable ["trunk", []];
_vehicle setVariable ["id", _vid, true];