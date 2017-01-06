// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _unit = param[0, objNull, [objNull]];
if( isNull _unit ) exitWith {};

if( !(XY_playerTrunk isEqualTo []) ) then {

    private _pos = getPos _unit;
    _pos set[0, (_pos select 0) + (((random 1) + 1) * (selectRandom [1, -1]))];
    _pos set[1, (_pos select 1) + (((random 1) + 1) * (selectRandom [1, -1]))];
    _pos set[2, 0.25];

    private _obj = "Land_Suitcase_F" createVehicle [0, 0, 0];
    _obj setPos _pos;
    _obj setDir (random 360);
    _obj setVariable["side", playerSide, true];
    _obj setVariable["items", XY_playerTrunk, true];
    XY_playerTrunk = [];
};

if( XY_CC > 0 ) then {

    private _pos = getPos _unit;
    _pos set[0, (_pos select 0) + (((random 1) + 1) * (selectRandom [1, -1]))];
    _pos set[1, (_pos select 1) + (((random 1) + 1) * (selectRandom [1, -1]))];
    _pos set[2, 0.25];

    private _obj = "Land_Money_F" createVehicle [0, 0, 0];
    _obj setPos _pos;
    _obj setDir (random 360);
    _obj setVariable["side", playerSide, true];
    _obj setVariable["money", XY_CC, true];

    XY_CC = 0;
};