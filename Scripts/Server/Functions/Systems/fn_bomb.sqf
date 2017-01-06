private["_pos", "_bomb"];

diag_log format["XY_fnc_bomb(%1)", _this];

if( !params[ ["_pos", [], [[]]] ] ) exitWith {};

_bomb = "Bo_Mk82" createVehicle [0, 0, 9999];
_bomb setPos _pos;
_bomb setVelocity [100, 0, 0];